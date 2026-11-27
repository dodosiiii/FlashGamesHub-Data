#include <3ds.h>
#include <curl/curl.h>

#include "catalog.hpp"
#include "embedded_romfs.hpp"

#include <cstdarg>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <malloc.h>
#include <netdb.h>
#include <sys/stat.h>
#include <unistd.h>

namespace {

FILE* gLog = nullptr;
char gDlBuf[256 * 1024];
std::size_t gDlLen = 0;

void logLine(const char* fmt, ...) {
    char buf[512];
    va_list args;
    va_start(args, fmt);
    std::vsnprintf(buf, sizeof(buf), fmt, args);
    va_end(args);
    std::printf("%s\n", buf);
    if (gLog) {
        std::fprintf(gLog, "%s\n", buf);
        std::fflush(gLog);
    }
}

size_t writeCb(char* ptr, size_t size, size_t nmemb, void*) {
    size_t bytes = size * nmemb;
    if (gDlLen + bytes >= sizeof(gDlBuf)) {
        bytes = sizeof(gDlBuf) - 1 - gDlLen;
    }
    if (bytes > 0) {
        std::memcpy(gDlBuf + gDlLen, ptr, bytes);
        gDlLen += bytes;
    }
    return size * nmemb;
}

void testCurlUrl(const char* label, const char* url, const char* caPath, bool verifySsl) {
    gDlLen = 0;
    gDlBuf[0] = '\0';
    CURL* curl = curl_easy_init();
    if (!curl) {
        logLine("[FAIL] %s: curl_easy_init() null", label);
        return;
    }
    char errBuf[CURL_ERROR_SIZE]{};
    curl_easy_setopt(curl, CURLOPT_URL, url);
    curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, errBuf);
    curl_easy_setopt(curl, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4);
    curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
    curl_easy_setopt(curl, CURLOPT_MAXREDIRS, 3L);
    curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT_MS, 8000L);
    curl_easy_setopt(curl, CURLOPT_TIMEOUT_MS, 15000L);
    curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
    curl_easy_setopt(curl, CURLOPT_USERAGENT, "FlashGamesHubDiag/1.0");
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCb);
    if (verifySsl) {
        curl_easy_setopt(curl, CURLOPT_CAINFO, caPath);
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 1L);
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 2L);
    } else {
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);
    }

    const CURLcode rc = curl_easy_perform(curl);
    long httpCode = 0;
    curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &httpCode);
    curl_easy_cleanup(curl);

    logLine("[%s] %s: rc=%d (%s) http=%ld bytes=%zu",
            (rc == CURLE_OK && httpCode == 200) ? "OK" : "FAIL",
            label, static_cast<int>(rc), curl_easy_strerror(rc), httpCode, gDlLen);
    if (errBuf[0]) logLine("  err: %s", errBuf);
}

} // namespace

int main() {
    gfxInitDefault();
    consoleInit(GFX_TOP, nullptr);

    gLog = std::fopen("sdmc:/flashgameshub_diag.txt", "wb");
    logLine("=== FlashGamesHub Diagnostic ===");
    logLine("envIsHomebrew: %d", envIsHomebrew() ? 1 : 0);

    std::time_t now = std::time(nullptr);
    std::tm* tmNow = std::gmtime(&now);
    if (tmNow) {
        logLine("RTC UTC: %04d-%02d-%02d %02d:%02d:%02d",
                tmNow->tm_year + 1900, tmNow->tm_mon + 1, tmNow->tm_mday,
                tmNow->tm_hour, tmNow->tm_min, tmNow->tm_sec);
    }

    const Result romfsRes = romfsInit();
    logLine("romfsInit: 0x%08lX (%s)", static_cast<unsigned long>(romfsRes),
            R_SUCCEEDED(romfsRes) ? "OK" : "FAIL");

    struct stat st{};
    logLine("stat(romfs:/catalog.json): %d size=%ld",
            stat("romfs:/catalog.json", &st), static_cast<long>(st.st_size));
    st = {};
    logLine("stat(romfs:/ca-bundle.pem): %d size=%ld",
            stat("romfs:/ca-bundle.pem", &st), static_cast<long>(st.st_size));
    st = {};
    logLine("stat(sdmc:/3ds/FlashGamesHub/catalog.json): %d size=%ld",
            stat("sdmc:/3ds/FlashGamesHub/catalog.json", &st), static_cast<long>(st.st_size));

    static GameCatalog cat{};
    const bool embOk = parseCatalogJson(kEmbeddedCatalogJson, kEmbeddedCatalogJsonLength, &cat);
    logLine("parseCatalogJson(embedded len=%zu): %s count=%zu ver=%u",
            kEmbeddedCatalogJsonLength, embOk ? "OK" : "FAIL", cat.count, cat.catalogVersion);

    if (R_SUCCEEDED(romfsRes)) {
        FILE* f = std::fopen("romfs:/catalog.json", "rb");
        if (f) {
            std::fseek(f, 0, SEEK_END);
            long sz = std::ftell(f);
            std::fseek(f, 0, SEEK_SET);
            if (sz > 0 && sz < static_cast<long>(sizeof(gDlBuf))) {
                std::size_t rd = std::fread(gDlBuf, 1, static_cast<std::size_t>(sz), f);
                cat = GameCatalog{};
                const bool romOk = parseCatalogJson(gDlBuf, rd, &cat);
                logLine("parseCatalogJson(romfs rd=%zu): %s count=%zu", rd, romOk ? "OK" : "FAIL", cat.count);
            }
            std::fclose(f);
        }
    }

    const Result acRes = acInit();
    u32 wifiStatus = 0;
    u32 acStatus = 0;
    if (R_SUCCEEDED(acRes)) {
        ACU_GetWifiStatus(&wifiStatus);
        ACU_GetStatus(&acStatus);
        acExit();
    }
    logLine("acInit: 0x%08lX wifiStatus=%lu acStatus=%lu",
            static_cast<unsigned long>(acRes),
            static_cast<unsigned long>(wifiStatus),
            static_cast<unsigned long>(acStatus));

    u32* socBuf = static_cast<u32*>(memalign(0x1000, 0x100000));
    const Result socRes = socBuf ? socInit(socBuf, 0x100000) : -1;
    logLine("socInit: buf=%p res=0x%08lX (%s)", socBuf, static_cast<unsigned long>(socRes),
            R_SUCCEEDED(socRes) ? "OK" : "FAIL");

    if (R_SUCCEEDED(socRes)) {
        struct addrinfo hints{};
        hints.ai_family = AF_INET;
        hints.ai_socktype = SOCK_STREAM;
        struct addrinfo* res = nullptr;
        const int gai = getaddrinfo("raw.githubusercontent.com", "443", &hints, &res);
        logLine("DNS raw.githubusercontent.com: %d", gai);
        if (res) freeaddrinfo(res);

        const CURLcode gci = curl_global_init(CURL_GLOBAL_DEFAULT);
        logLine("curl_global_init: %d", static_cast<int>(gci));
        if (gci == CURLE_OK) {
            const char* caPath = "sdmc:/3ds/FlashGamesHub/ca-bundle.pem";
            if (R_SUCCEEDED(romfsRes) && stat("romfs:/ca-bundle.pem", &st) == 0) {
                caPath = "romfs:/ca-bundle.pem";
            } else {
                mkdir("sdmc:/3ds", 0777);
                mkdir("sdmc:/3ds/FlashGamesHub", 0777);
                FILE* cf = std::fopen(caPath, "wb");
                if (cf) {
                    std::fwrite(kEmbeddedCaBundlePem, 1, kEmbeddedCaBundlePemLength, cf);
                    std::fclose(cf);
                }
            }
            logLine("Using CA: %s", caPath);

            testCurlUrl("Catalog SSL=1",
                        "https://raw.githubusercontent.com/dodosiiii/FlashGamesHub-Data/main/catalog.json",
                        caPath, true);
            testCurlUrl("Catalog SSL=0",
                        "https://raw.githubusercontent.com/dodosiiii/FlashGamesHub-Data/main/catalog.json",
                        caPath, false);
            if (gDlLen > 0) {
                gDlBuf[gDlLen] = '\0';
                cat = GameCatalog{};
                const bool netOk = parseCatalogJson(gDlBuf, gDlLen, &cat);
                logLine("parseCatalogJson(GitHub len=%zu): %s count=%zu ver=%u",
                        gDlLen, netOk ? "OK" : "FAIL", cat.count, cat.catalogVersion);
            }
            testCurlUrl("Cover SSL=0",
                        "https://raw.githubusercontent.com/dodosiiii/FlashGamesHub-Data/main/data/covers/worlds-hardest-game-logo.t3x",
                        caPath, false);
            testCurlUrl("Shot1 SSL=0",
                        "https://raw.githubusercontent.com/dodosiiii/FlashGamesHub-Data/main/data/screenshots/worlds-hardest-game/gameplay-1.t3x",
                        caPath, false);
            curl_global_cleanup();
        }
        socExit();
    }
    std::free(socBuf);
    if (R_SUCCEEDED(romfsRes)) romfsExit();

    logLine("=== DONE: saved sdmc:/flashgameshub_diag.txt ===");
    logLine("Press START to exit.");
    if (gLog) {
        std::fclose(gLog);
        gLog = nullptr;
    }

    while (aptMainLoop()) {
        hidScanInput();
        if (hidKeysDown() & KEY_START) break;
        gfxFlushBuffers();
        gfxSwapBuffers();
        gspWaitForVBlank();
    }

    gfxExit();
    return 0;
}
