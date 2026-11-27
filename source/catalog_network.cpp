#include "catalog_network.hpp"
#include "embedded_romfs.hpp"
#include "installed_games.hpp"

#include <3ds.h>
#include <3ds/services/am.h>
#include <curl/curl.h>
#include <mbedtls/sha256.h>

#include <atomic>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <malloc.h>
#include <sys/stat.h>

namespace {

constexpr const char* kCatalogUrl =
    "https://raw.githubusercontent.com/dodosiiii/FlashGamesHub-Data/main/catalog.json";
constexpr const char* kHubManifestUrl =
    "https://raw.githubusercontent.com/dodosiiii/FlashGamesHub-Data/main/hub.json";
constexpr const char* kScreenshotBaseUrl =
    "https://raw.githubusercontent.com/dodosiiii/FlashGamesHub-Data/main/";
constexpr const char* kCaBundlePath = "romfs:/ca-bundle.pem";
constexpr const char* kCaBundleFallbackPath = "sdmc:/3ds/FlashGamesHub/ca-bundle.pem";
constexpr const char* kCacheDirectory = "sdmc:/3ds/FlashGamesHub";
constexpr const char* kCachePath = "sdmc:/3ds/FlashGamesHub/catalog.json";
constexpr const char* kCacheTempPath = "sdmc:/3ds/FlashGamesHub/catalog.json.tmp";
constexpr const char* kHubCachePath = "sdmc:/3ds/FlashGamesHub/hub.json";
constexpr const char* kHubCacheTempPath = "sdmc:/3ds/FlashGamesHub/hub.json.tmp";
constexpr const char* kGamesDirectory = "sdmc:/3ds/FlashGamesHub/games";
constexpr const char* kScreenshotsDirectory = "sdmc:/3ds/FlashGamesHub/screenshots";
constexpr const char* kSavesDirectory = "sdmc:/3ds/FlashGamesHub/saves";
constexpr std::size_t kMaxCatalogBytes = 256 * 1024;
constexpr u32 kMaxHubCiaBytes = 32 * 1024 * 1024;
constexpr u64 kHubTitleId = 0x000400000F64B000ULL;
constexpr u32 kSocBufferSize = 0x100000;
constexpr long kPackageTimeoutMs = 1800000L;
constexpr long kPackageLowSpeedLimit = 1024L;
constexpr long kPackageLowSpeedTime = 120L;
constexpr long kPackageBufferSize = 64L * 1024L;

LightLock gStateLock;
bool gLockInitialized = false;
bool gHasPendingCatalog = false;
bool gHasPendingHubManifest = false;
GameCatalog gPendingCatalog{};
HubManifest gPendingHubManifest{};
GameCatalog gWorkerCatalog{};
HubManifest gWorkerHubManifest{};
CatalogUpdateState gState = CatalogUpdateState::Idle;
Thread gDownloadThread = nullptr;
Thread gGamePackageThread = nullptr;
Thread gScreenshotThread = nullptr;
GamePackageState gGamePackageState = GamePackageState::Idle;
CatalogGame gGamePackageRequest{};
char gGamePackageFormat[12] = "3dsx";
GamePackageResult gPendingGamePackageResult{};
bool gHasPendingGamePackageResult = false;
u64 gGamePackageDownloadedBytes = 0;
u64 gGamePackageTotalBytes = 0;
struct ScreenshotRequest { char url[256]; char localPath[256]; char tempPath[264]; };
ScreenshotRequest gScreenshotRequest{};
ScreenshotCacheResult gScreenshotResult{};
ScreenshotCacheState gScreenshotState = ScreenshotCacheState::Idle;
bool gHasScreenshotResult = false;
bool gCatalogJobFinished = false;
u32* gSocBuffer = nullptr;
bool gSocReady = false;
bool gCurlReady = false;
std::atomic<bool> gCancel{false};
std::atomic<bool> gScreenshotCancel{false};
char gResponseBuffer[kMaxCatalogBytes + 1]{};
std::size_t gResponseSize = 0;

void setState(CatalogUpdateState state) {
    LightLock_Lock(&gStateLock);
    gState = state;
    LightLock_Unlock(&gStateLock);
}

const char* resolveCaBundlePath() {
    struct stat info{};
    if (stat(kCaBundlePath, &info) == 0 && info.st_size > 0) return kCaBundlePath;
    if (stat(kCaBundleFallbackPath, &info) == 0 &&
        static_cast<std::size_t>(info.st_size) == kEmbeddedCaBundlePemLength) {
        return kCaBundleFallbackPath;
    }
    mkdir("sdmc:/3ds", 0777);
    mkdir(kCacheDirectory, 0777);
    FILE* file = std::fopen(kCaBundleFallbackPath, "wb");
    if (file) {
        std::fwrite(kEmbeddedCaBundlePem, 1, kEmbeddedCaBundlePemLength, file);
        std::fclose(file);
        return kCaBundleFallbackPath;
    }
    return kCaBundlePath;
}

// Lit un fichier entier en memoire (termine par un octet nul). A liberer avec free().
char* readWholeFile(const char* path, std::size_t* outLength) {
    FILE* file = std::fopen(path, "rb");
    if (!file) return nullptr;
    if (std::fseek(file, 0, SEEK_END) != 0) {
        std::fclose(file);
        return nullptr;
    }
    const long length = std::ftell(file);
    if (length <= 0 || static_cast<unsigned long>(length) > kMaxCatalogBytes || std::fseek(file, 0, SEEK_SET) != 0) {
        std::fclose(file);
        return nullptr;
    }
    char* buffer = static_cast<char*>(std::malloc(static_cast<std::size_t>(length) + 1));
    if (!buffer) {
        std::fclose(file);
        return nullptr;
    }
    const std::size_t read = std::fread(buffer, 1, static_cast<std::size_t>(length), file);
    std::fclose(file);
    if (read != static_cast<std::size_t>(length)) {
        std::free(buffer);
        return nullptr;
    }
    buffer[read] = '\0';
    *outLength = read;
    return buffer;
}

bool readCatalogFile(const char* path, GameCatalog* output) {
    std::size_t length = 0;
    char* buffer = readWholeFile(path, &length);
    if (!buffer) return false;
    const bool valid = parseCatalogJson(buffer, length, output);
    std::free(buffer);
    return valid;
}

bool readHubManifestFile(const char* path, HubManifest* output) {
    std::size_t length = 0;
    char* buffer = readWholeFile(path, &length);
    if (!buffer) return false;
    const bool valid = parseHubManifestJson(buffer, length, output);
    std::free(buffer);
    return valid;
}

// Ecrit dans un fichier temporaire puis le renomme. Sur la carte SD de la 3DS,
// rename() echoue si la destination existe deja : on la supprime d'abord, sinon le
// cache ne serait jamais mis a jour apres la premiere ecriture.
bool saveFileReplacing(const char* tempPath, const char* finalPath, const char* contents, std::size_t length) {
    mkdir("sdmc:/3ds", 0777);
    mkdir(kCacheDirectory, 0777);
    FILE* file = std::fopen(tempPath, "wb");
    if (!file) return false;
    const std::size_t written = std::fwrite(contents, 1, length, file);
    const bool closeOk = std::fclose(file) == 0;
    if (written != length || !closeOk) {
        std::remove(tempPath);
        return false;
    }
    std::remove(finalPath);
    if (std::rename(tempPath, finalPath) != 0) {
        std::remove(tempPath);
        return false;
    }
    return true;
}

std::size_t receiveResponse(char* data, std::size_t itemSize, std::size_t itemCount, void*) {
    if (itemSize != 0 && itemCount > static_cast<std::size_t>(-1) / itemSize) return 0;
    const std::size_t bytes = itemSize * itemCount;
    if (bytes > kMaxCatalogBytes - gResponseSize) return 0;
    std::memcpy(gResponseBuffer + gResponseSize, data, bytes);
    gResponseSize += bytes;
    return bytes;
}

// Appelee regulierement par curl : renvoyer une valeur non nulle interrompt le transfert.
int progressCallback(void*, curl_off_t, curl_off_t, curl_off_t, curl_off_t) {
    return gCancel.load() ? 1 : 0;
}

int screenshotProgressCallback(void*, curl_off_t, curl_off_t, curl_off_t, curl_off_t) {
    return (gCancel.load() || gScreenshotCancel.load()) ? 1 : 0;
}

int gamePackageProgressCallback(void*, curl_off_t totalDownload, curl_off_t downloaded, curl_off_t, curl_off_t) {
    if (gCancel.load()) return 1;
    if (gLockInitialized) {
        LightLock_Lock(&gStateLock);
        gGamePackageTotalBytes = totalDownload > 0 ? static_cast<u64>(totalDownload) : gGamePackageTotalBytes;
        gGamePackageDownloadedBytes = downloaded > 0 ? static_cast<u64>(downloaded) : 0;
        LightLock_Unlock(&gStateLock);
    }
    return 0;
}

CURLcode performHttps(CURL* curl) {
    CURLcode res = curl_easy_perform(curl);
    if (res == CURLE_PEER_FAILED_VERIFICATION || res == CURLE_SSL_CACERT_BADFILE ||
        res == CURLE_SSL_CONNECT_ERROR) {
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);
        gResponseSize = 0;
        gResponseBuffer[0] = '\0';
        res = curl_easy_perform(curl);
    }
    return res;
}

bool fetch(CURL* curl, const char* url) {
    gResponseSize = 0;
    gResponseBuffer[0] = '\0';
    curl_easy_setopt(curl, CURLOPT_URL, url);
    const CURLcode result = performHttps(curl);
    long responseCode = 0;
    curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &responseCode);
    gResponseBuffer[gResponseSize] = '\0';
    return result == CURLE_OK && responseCode == 200 && gResponseSize > 0;
}

void downloadWorker(void*) {
    bool validCatalog = false;
    bool validHubManifest = false;
    CURL* curl = curl_easy_init();
    if (curl) {
        curl_easy_setopt(curl, CURLOPT_CAINFO, resolveCaBundlePath());
        curl_easy_setopt(curl, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4);
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 1L);
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 2L);
        curl_easy_setopt(curl, CURLOPT_PROTOCOLS_STR, "https");
        curl_easy_setopt(curl, CURLOPT_REDIR_PROTOCOLS_STR, "https");
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
        curl_easy_setopt(curl, CURLOPT_MAXREDIRS, 3L);
        curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT_MS, 6000L);
        curl_easy_setopt(curl, CURLOPT_TIMEOUT_MS, 15000L);
        curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
        curl_easy_setopt(curl, CURLOPT_USERAGENT, "FlashGamesHub/0.1");
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, receiveResponse);
        curl_easy_setopt(curl, CURLOPT_FAILONERROR, 1L);
        curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0L);
        curl_easy_setopt(curl, CURLOPT_XFERINFOFUNCTION, progressCallback);

        // Le catalogue et le manifeste du Hub sont independants : l'echec de l'un
        // ne doit pas empecher de recuperer l'autre.
        if (fetch(curl, kCatalogUrl) && parseCatalogJson(gResponseBuffer, gResponseSize, &gWorkerCatalog)) {
            validCatalog = true;
            saveFileReplacing(kCacheTempPath, kCachePath, gResponseBuffer, gResponseSize);
        }
        if (!gCancel.load() && fetch(curl, kHubManifestUrl) &&
            parseHubManifestJson(gResponseBuffer, gResponseSize, &gWorkerHubManifest)) {
            validHubManifest = true;
            saveFileReplacing(kHubCacheTempPath, kHubCachePath, gResponseBuffer, gResponseSize);
        }
        curl_easy_cleanup(curl);
    }

    LightLock_Lock(&gStateLock);
    if (validCatalog) {
        gPendingCatalog = gWorkerCatalog;
        gHasPendingCatalog = true;
    }
    if (validHubManifest) {
        gPendingHubManifest = gWorkerHubManifest;
        gHasPendingHubManifest = true;
    }
    gState = validCatalog ? CatalogUpdateState::Updated : CatalogUpdateState::Unavailable;
    gCatalogJobFinished = true;
    LightLock_Unlock(&gStateLock);
}

struct GameFileSink {
    FILE* file;
    mbedtls_sha256_context hash;
    u32 expectedBytes;
    u32 receivedBytes;
    u32 maxBytes;
    bool hashFailed;
};

std::size_t receiveGamePackage(char* data, std::size_t itemSize, std::size_t itemCount, void* userData) {
    if (itemSize != 0 && itemCount > static_cast<std::size_t>(-1) / itemSize) return 0;
    const std::size_t bytes = itemSize * itemCount;
    GameFileSink* sink = static_cast<GameFileSink*>(userData);
    const u32 limit = sink && sink->expectedBytes ? sink->expectedBytes : (sink ? sink->maxBytes : 0);
    if (!sink || !sink->file || bytes > limit - sink->receivedBytes) return 0;
    if (mbedtls_sha256_update_ret(&sink->hash, reinterpret_cast<const unsigned char*>(data), bytes) != 0) {
        sink->hashFailed = true;
        return 0;
    }
    const std::size_t written = std::fwrite(data, 1, bytes, sink->file);
    sink->receivedBytes += static_cast<u32>(written);
    return written;
}

bool digestMatches(const unsigned char digest[32], const char* expected) {
    char actual[65];
    for (std::size_t i = 0; i < 32; ++i) {
        std::snprintf(actual + i * 2, 3, "%02x", digest[i]);
    }
    for (std::size_t i = 0; i < 64; ++i) {
        char expectedChar = expected[i];
        if (expectedChar >= 'A' && expectedChar <= 'F') expectedChar = static_cast<char>(expectedChar - 'A' + 'a');
        if (actual[i] != expectedChar) return false;
    }
    return expected[64] == '\0';
}

bool isInstalledGame(const InstalledGameList& list, const char* id, const InstalledGame** result) {
    for (std::size_t i = 0; i < list.count; ++i) {
        if (std::strcmp(list.games[i].id, id) == 0) {
            if (result) *result = &list.games[i];
            return true;
        }
    }
    return false;
}

void finishGamePackage(GamePackageState state, const char* id, bool isHubUpdate = false, u64 titleId = 0) {
    LightLock_Lock(&gStateLock);
    gGamePackageState = state;
    gPendingGamePackageResult = GamePackageResult{};
    gPendingGamePackageResult.state = state;
    gPendingGamePackageResult.isHubUpdate = isHubUpdate;
    gPendingGamePackageResult.titleId = titleId;
    if (id) std::snprintf(gPendingGamePackageResult.gameId, sizeof(gPendingGamePackageResult.gameId), "%s", id);
    gHasPendingGamePackageResult = true;
    LightLock_Unlock(&gStateLock);
}

void setGamePackageState(GamePackageState state) {
    LightLock_Lock(&gStateLock);
    gGamePackageState = state;
    LightLock_Unlock(&gStateLock);
}

bool installCiaPackage(const char* path, bool overwrite, u64 expectedTitleId, u64* installedTitleId) {
    if (!path || std::strncmp(path, "sdmc:/", 6) != 0 || !installedTitleId || R_FAILED(amInit())) return false;
    const FS_Path archivePath = fsMakePath(PATH_EMPTY, "");
    const FS_Path filePath = fsMakePath(PATH_ASCII, path + 5);
    Handle fileHandle = 0;
    Result result = FSUSER_OpenFileDirectly(&fileHandle, ARCHIVE_SDMC, archivePath, filePath, FS_OPEN_READ, 0);
    AM_TitleInfo ciaInfo{};
    if (R_SUCCEEDED(result)) result = AM_GetCiaFileInfo(MEDIATYPE_SD, &ciaInfo, fileHandle);
    if (fileHandle) FSFILE_Close(fileHandle);
    if (R_FAILED(result) || ciaInfo.titleID == 0 || (expectedTitleId && expectedTitleId != ciaInfo.titleID)) {
        amExit();
        return false;
    }

    Handle installHandle = 0;
    result = overwrite ? AM_StartCiaInstallOverwrite(&installHandle, MEDIATYPE_SD)
                       : AM_StartCiaInstall(MEDIATYPE_SD, &installHandle);
    if (R_FAILED(result) && overwrite) {
        result = AM_StartCiaInstall(MEDIATYPE_SD, &installHandle);
    }
    if (R_FAILED(result)) {
        amExit();
        return false;
    }
    FILE* input = std::fopen(path, "rb");
    alignas(0x1000) unsigned char buffer[0x10000];
    u64 offset = 0;
    bool ok = input != nullptr;
    while (ok) {
        const std::size_t count = std::fread(buffer, 1, sizeof(buffer), input);
        if (count == 0) {
            if (std::ferror(input)) ok = false;
            break;
        }
        u32 written = 0;
        result = FSFILE_Write(installHandle, &written, offset, buffer, static_cast<u32>(count), 0);
        if (R_FAILED(result) || written != count) ok = false;
        else offset += written;
    }
    if (input && std::fclose(input) != 0) ok = false;
    if (ok) {
        result = FSFILE_Flush(installHandle);
        if (R_SUCCEEDED(result)) result = AM_FinishCiaInstall(installHandle);
        if (R_FAILED(result)) AM_CancelCIAInstall(installHandle);
    } else {
        AM_CancelCIAInstall(installHandle);
    }
    AM_TitleInfo installedInfo{};
    u64 verifiedTitleId = ciaInfo.titleID;
    const bool installed = R_SUCCEEDED(result) && ok &&
        R_SUCCEEDED(AM_GetTitleInfo(MEDIATYPE_SD, 1, &verifiedTitleId, &installedInfo)) &&
        installedInfo.titleID == ciaInfo.titleID;
    amExit();
    if (!installed) return false;
    *installedTitleId = ciaInfo.titleID;
    return true;
}

void gamePackageWorker(void* userData) {
    const CatalogGame game = *static_cast<const CatalogGame*>(userData);
    char packageFormat[12]{};
    std::snprintf(packageFormat, sizeof(packageFormat), "%s", gGamePackageFormat);
    const bool isCia = std::strcmp(packageFormat, "cia") == 0;
    const bool ciaIsPrimary = isCia && std::strcmp(game.downloadFormat, "cia") == 0;
    const char* packageUrl = isCia ? (ciaIsPrimary ? game.downloadUrl : game.ciaUrl) : game.downloadUrl;
    const char* packageHash = isCia ? (ciaIsPrimary ? game.sha256 : game.ciaSha256) : game.sha256;
    const u32 packageBytes = isCia ? (ciaIsPrimary ? game.sizeBytes : game.ciaSizeBytes) : game.sizeBytes;
    GamePackageState resultState = GamePackageState::Failed;
    char gameDirectory[160];
    char targetPath[320];
    char temporaryPath[328];
    char backupPath[328];
    std::snprintf(gameDirectory, sizeof(gameDirectory), "%s/%s", kGamesDirectory, game.id);
    std::snprintf(targetPath, sizeof(targetPath), "%s/%s.%s", gameDirectory, game.id, isCia ? "cia" : "3dsx");
    std::snprintf(temporaryPath, sizeof(temporaryPath), "%s.tmp", targetPath);
    std::snprintf(backupPath, sizeof(backupPath), "%s.bak", targetPath);

    InstalledGameList installedGames{};
    const InstalledGame* installed = nullptr;
    struct stat targetInfo{};
    const bool registryLoaded = loadInstalledGamesFromSd(&installedGames);
    struct stat registryInfo{};
    const bool registryExists = stat("sdmc:/3ds/FlashGamesHub/installed.json", &registryInfo) == 0;
    const bool registryValid = registryLoaded || !registryExists;
    const bool targetExists = stat(targetPath, &targetInfo) == 0 && targetInfo.st_size > 0;
    const bool isUpdate = isInstalledGame(installedGames, game.id, &installed);
    const bool packageStateAllowed = game.status == GameStatus::Available || game.status == GameStatus::Development;
    const bool formatValid = isCia || std::strcmp(packageFormat, "3dsx") == 0;
    const bool updateValid = !isUpdate || (installed && std::strcmp(installed->format, packageFormat) == 0 &&
        compareVersions(game.version, installed->version) > 0 && (isCia || targetExists));
    if (!registryValid || !packageStateAllowed || !formatValid || !game.version[0] || !packageBytes ||
        !packageHash[0] || !packageUrl[0] || (isUpdate && !updateValid) || (!isUpdate && targetExists && !isCia) || gCancel.load()) {
        finishGamePackage(resultState, game.id);
        return;
    }

    mkdir("sdmc:/3ds", 0777);
    mkdir("sdmc:/3ds/FlashGamesHub", 0777);
    mkdir(kGamesDirectory, 0777);
    mkdir(kSavesDirectory, 0777); // Updates never modify per-game save data.
    mkdir(gameDirectory, 0777);
    std::remove(temporaryPath);

    FILE* output = std::fopen(temporaryPath, "wb");
    if (!output) {
        finishGamePackage(resultState, game.id);
        return;
    }
    GameFileSink sink{};
    sink.file = output;
    sink.expectedBytes = packageBytes;
    sink.maxBytes = packageBytes;
    mbedtls_sha256_init(&sink.hash);
    bool valid = mbedtls_sha256_starts_ret(&sink.hash, 0) == 0;

    CURL* curl = valid ? curl_easy_init() : nullptr;
    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, packageUrl);
        curl_easy_setopt(curl, CURLOPT_CAINFO, resolveCaBundlePath());
        curl_easy_setopt(curl, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4);
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 1L);
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 2L);
        curl_easy_setopt(curl, CURLOPT_PROTOCOLS_STR, "https");
        curl_easy_setopt(curl, CURLOPT_REDIR_PROTOCOLS_STR, "https");
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
        curl_easy_setopt(curl, CURLOPT_MAXREDIRS, 3L);
        curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT_MS, 8000L);
        curl_easy_setopt(curl, CURLOPT_TIMEOUT_MS, kPackageTimeoutMs);
        curl_easy_setopt(curl, CURLOPT_LOW_SPEED_LIMIT, kPackageLowSpeedLimit);
        curl_easy_setopt(curl, CURLOPT_LOW_SPEED_TIME, kPackageLowSpeedTime);
        curl_easy_setopt(curl, CURLOPT_BUFFERSIZE, kPackageBufferSize);
        curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
        curl_easy_setopt(curl, CURLOPT_USERAGENT, "FlashGamesHub/0.1");
        curl_easy_setopt(curl, CURLOPT_FAILONERROR, 1L);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, receiveGamePackage);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &sink);
        curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0L);
        curl_easy_setopt(curl, CURLOPT_XFERINFOFUNCTION, gamePackageProgressCallback);
        curl_easy_setopt(curl, CURLOPT_MAXFILESIZE_LARGE, static_cast<curl_off_t>(packageBytes));
        long responseCode = 0;
        const CURLcode request = curl_easy_perform(curl);
        curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &responseCode);
        valid = request == CURLE_OK && responseCode == 200 && !sink.hashFailed &&
                sink.receivedBytes == sink.expectedBytes && !gCancel.load();
        curl_easy_cleanup(curl);
    } else {
        valid = false;
    }

    unsigned char digest[32]{};
    if (valid) valid = mbedtls_sha256_finish_ret(&sink.hash, digest) == 0 && digestMatches(digest, packageHash);
    mbedtls_sha256_free(&sink.hash);
    if (std::fclose(output) != 0) valid = false;
    if (!valid) {
        std::remove(temporaryPath);
        finishGamePackage(resultState, game.id);
        return;
    }

    if (isCia) {
        setGamePackageState(GamePackageState::Installing);
        u64 titleId = 0;
        const u64 expectedTitleId = isUpdate && installed ? installed->titleId : 0;
        if (!installCiaPackage(temporaryPath, isUpdate, expectedTitleId, &titleId)) {
            std::remove(temporaryPath);
            finishGamePackage(resultState, game.id);
            return;
        }
        if (!registerInstalledGame(&installedGames, game.id, game.version, packageBytes, "cia", titleId)) {
            std::remove(temporaryPath);
            finishGamePackage(resultState, game.id);
            return;
        }
        std::remove(temporaryPath);
        resultState = GamePackageState::Installed;
        finishGamePackage(resultState, game.id);
        return;
    }

    // Keep an installed version recoverable while replacing it. First installs
    // only promote the verified temporary file into the game's directory.
    std::remove(backupPath);
    if (isUpdate && std::rename(targetPath, backupPath) != 0) {
        std::remove(temporaryPath);
        finishGamePackage(resultState, game.id);
        return;
    }
    if (std::rename(temporaryPath, targetPath) != 0) {
        if (isUpdate) std::rename(backupPath, targetPath);
        std::remove(temporaryPath);
        finishGamePackage(resultState, game.id);
        return;
    }
    if (!registerInstalledGame(&installedGames, game.id, game.version, packageBytes, "3dsx", 0)) {
        std::remove(targetPath);
        if (isUpdate) std::rename(backupPath, targetPath);
        finishGamePackage(resultState, game.id);
        return;
    }
    if (isUpdate) std::remove(backupPath);
    resultState = GamePackageState::Installed;
    finishGamePackage(resultState, game.id);
}

HubManifest gHubUpdateRequest{};

void hubUpdateWorker(void* userData) {
    const HubManifest manifest = *static_cast<const HubManifest*>(userData);
    constexpr const char* kHubTempPath = "sdmc:/3ds/FlashGamesHub/FlashGamesHub-update.cia.tmp";
    if (!manifest.published || std::strncmp(manifest.ciaUrl, "https://", 8) != 0 ||
        std::strlen(manifest.sha256) != 64 || gCancel.load()) {
        finishGamePackage(GamePackageState::Failed, "hub", true);
        return;
    }

    mkdir("sdmc:/3ds", 0777);
    mkdir(kCacheDirectory, 0777);
    std::remove(kHubTempPath);
    FILE* output = std::fopen(kHubTempPath, "wb");
    if (!output) {
        finishGamePackage(GamePackageState::Failed, "hub", true);
        return;
    }

    GameFileSink sink{};
    sink.file = output;
    sink.expectedBytes = 0;
    sink.maxBytes = kMaxHubCiaBytes;
    mbedtls_sha256_init(&sink.hash);
    bool valid = mbedtls_sha256_starts_ret(&sink.hash, 0) == 0;

    CURL* curl = valid ? curl_easy_init() : nullptr;
    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, manifest.ciaUrl);
        curl_easy_setopt(curl, CURLOPT_CAINFO, resolveCaBundlePath());
        curl_easy_setopt(curl, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4);
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 1L);
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 2L);
        curl_easy_setopt(curl, CURLOPT_PROTOCOLS_STR, "https");
        curl_easy_setopt(curl, CURLOPT_REDIR_PROTOCOLS_STR, "https");
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
        curl_easy_setopt(curl, CURLOPT_MAXREDIRS, 3L);
        curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT_MS, 8000L);
        curl_easy_setopt(curl, CURLOPT_TIMEOUT_MS, kPackageTimeoutMs);
        curl_easy_setopt(curl, CURLOPT_LOW_SPEED_LIMIT, kPackageLowSpeedLimit);
        curl_easy_setopt(curl, CURLOPT_LOW_SPEED_TIME, kPackageLowSpeedTime);
        curl_easy_setopt(curl, CURLOPT_BUFFERSIZE, kPackageBufferSize);
        curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
        curl_easy_setopt(curl, CURLOPT_USERAGENT, "FlashGamesHub/0.1");
        curl_easy_setopt(curl, CURLOPT_FAILONERROR, 1L);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, receiveGamePackage);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &sink);
        curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0L);
        curl_easy_setopt(curl, CURLOPT_XFERINFOFUNCTION, gamePackageProgressCallback);
        curl_easy_setopt(curl, CURLOPT_MAXFILESIZE_LARGE, static_cast<curl_off_t>(kMaxHubCiaBytes));
        long responseCode = 0;
        const CURLcode request = curl_easy_perform(curl);
        curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &responseCode);
        valid = request == CURLE_OK && responseCode == 200 && !sink.hashFailed &&
                sink.receivedBytes > 0 && !gCancel.load();
        curl_easy_cleanup(curl);
    } else {
        valid = false;
    }

    unsigned char digest[32]{};
    if (valid) valid = mbedtls_sha256_finish_ret(&sink.hash, digest) == 0 && digestMatches(digest, manifest.sha256);
    mbedtls_sha256_free(&sink.hash);
    if (std::fclose(output) != 0) valid = false;
    if (!valid) {
        std::remove(kHubTempPath);
        finishGamePackage(GamePackageState::Failed, "hub", true);
        return;
    }

    setGamePackageState(GamePackageState::Installing);
    u64 titleId = 0;
    const bool installed = installCiaPackage(kHubTempPath, true, kHubTitleId, &titleId);
    std::remove(kHubTempPath);
    if (!installed) {
        finishGamePackage(GamePackageState::Failed, "hub", true);
        return;
    }
    finishGamePackage(GamePackageState::Installed, "hub", true, titleId);
}

struct ScreenshotSink { FILE* file; std::size_t received; bool failed; };

std::size_t receiveScreenshot(char* data, std::size_t itemSize, std::size_t itemCount, void* userData) {
    if (itemSize && itemCount > static_cast<std::size_t>(-1) / itemSize) return 0;
    const std::size_t bytes = itemSize * itemCount;
    ScreenshotSink* sink = static_cast<ScreenshotSink*>(userData);
    if (!sink || sink->received > 512 * 1024 || bytes > 512 * 1024 - sink->received) return 0;
    const std::size_t written = std::fwrite(data, 1, bytes, sink->file);
    sink->received += written;
    if (written != bytes) sink->failed = true;
    return written;
}

void screenshotWorker(void*) {
    bool ok = false;
    if (gCurlReady && gScreenshotRequest.url[0]) {
        mkdir("sdmc:/3ds", 0777);
        mkdir("sdmc:/3ds/FlashGamesHub", 0777);
        mkdir(kScreenshotsDirectory, 0777);
        std::remove(gScreenshotRequest.tempPath);
        FILE* output = std::fopen(gScreenshotRequest.tempPath, "wb");
        if (output) {
            ScreenshotSink sink{output, 0, false};
            CURL* curl = curl_easy_init();
            if (curl) {
                curl_easy_setopt(curl, CURLOPT_URL, gScreenshotRequest.url);
                curl_easy_setopt(curl, CURLOPT_CAINFO, resolveCaBundlePath());
        curl_easy_setopt(curl, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4);
                curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 1L);
                curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 2L);
                curl_easy_setopt(curl, CURLOPT_PROTOCOLS_STR, "https");
                curl_easy_setopt(curl, CURLOPT_REDIR_PROTOCOLS_STR, "https");
                curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
                curl_easy_setopt(curl, CURLOPT_MAXREDIRS, 3L);
                curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT_MS, 8000L);
                curl_easy_setopt(curl, CURLOPT_TIMEOUT_MS, 30000L);
                curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
                curl_easy_setopt(curl, CURLOPT_USERAGENT, "FlashGamesHub/0.1");
                curl_easy_setopt(curl, CURLOPT_FAILONERROR, 1L);
                curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, receiveScreenshot);
                curl_easy_setopt(curl, CURLOPT_WRITEDATA, &sink);
                curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0L);
                curl_easy_setopt(curl, CURLOPT_XFERINFOFUNCTION, screenshotProgressCallback);
                curl_easy_setopt(curl, CURLOPT_MAXFILESIZE_LARGE, static_cast<curl_off_t>(512 * 1024));
                long responseCode = 0;
                const CURLcode request = curl_easy_perform(curl);
                curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &responseCode);
                ok = request == CURLE_OK && responseCode == 200 && sink.received > 0 && !sink.failed &&
                     !gScreenshotCancel.load() && !gCancel.load();
                curl_easy_cleanup(curl);
            }
            if (std::fclose(output) != 0) ok = false;
            if (ok && std::rename(gScreenshotRequest.tempPath, gScreenshotRequest.localPath) != 0) ok = false;
            if (!ok) std::remove(gScreenshotRequest.tempPath);
        }
    }
    LightLock_Lock(&gStateLock);
    gScreenshotState = ok ? ScreenshotCacheState::Ready : ScreenshotCacheState::Failed;
    gScreenshotResult.state = gScreenshotState;
    std::snprintf(gScreenshotResult.localPath, sizeof(gScreenshotResult.localPath), "%s", gScreenshotRequest.localPath);
    gHasScreenshotResult = true;
    LightLock_Unlock(&gStateLock);
}

} // namespace

bool loadCachedCatalog(GameCatalog* output) {
    return output && readCatalogFile(kCachePath, output);
}

bool loadCachedHubManifest(HubManifest* output) {
    return output && readHubManifestFile(kHubCachePath, output);
}

bool startCatalogDownload() {
    if (gDownloadThread) return false;
    LightLock_Init(&gStateLock);
    gLockInitialized = true;
    gHasPendingCatalog = false;
    gHasPendingHubManifest = false;
    gCatalogJobFinished = false;
    gCancel.store(false);
    setState(CatalogUpdateState::Downloading);

    gSocBuffer = static_cast<u32*>(memalign(0x1000, kSocBufferSize));
    if (!gSocBuffer || R_FAILED(socInit(gSocBuffer, kSocBufferSize))) {
        std::free(gSocBuffer);
        gSocBuffer = nullptr;
        setState(CatalogUpdateState::Unavailable);
        return false;
    }
    gSocReady = true;
    if (curl_global_init(CURL_GLOBAL_DEFAULT) != CURLE_OK) {
        socExit();
        gSocReady = false;
        std::free(gSocBuffer);
        gSocBuffer = nullptr;
        setState(CatalogUpdateState::Unavailable);
        return false;
    }
    gCurlReady = true;

    // Priorite juste en dessous du thread principal : le telechargement ne doit
    // jamais faire ramer l'affichage.
    s32 priority = 0x30;
    svcGetThreadPriority(&priority, CUR_THREAD_HANDLE);
    priority += 1;
    if (priority > 0x3F) priority = 0x3F;
    gDownloadThread = threadCreate(downloadWorker, nullptr, 0x20000, priority, -2, false);
    if (!gDownloadThread) {
        curl_global_cleanup();
        gCurlReady = false;
        socExit();
        gSocReady = false;
        std::free(gSocBuffer);
        gSocBuffer = nullptr;
        setState(CatalogUpdateState::Unavailable);
        return false;
    }
    return true;
}

bool takeDownloadedCatalog(GameCatalog* output) {
    if (!output || !gLockInitialized) return false;
    LightLock_Lock(&gStateLock);
    const bool available = gHasPendingCatalog;
    if (available) {
        *output = gPendingCatalog;
        gHasPendingCatalog = false;
    }
    LightLock_Unlock(&gStateLock);
    return available;
}

bool takeDownloadedHubManifest(HubManifest* output) {
    if (!output || !gLockInitialized) return false;
    LightLock_Lock(&gStateLock);
    const bool available = gHasPendingHubManifest;
    if (available) {
        *output = gPendingHubManifest;
        gHasPendingHubManifest = false;
    }
    LightLock_Unlock(&gStateLock);
    return available;
}

bool startGamePackageDownload(const CatalogGame* game, const char* format) {
    if (game && !format) format = game->downloadFormat;
    if (!game || !gLockInitialized || !gSocReady || !gCurlReady || !game->id[0] ||
        (game->status != GameStatus::Available && game->status != GameStatus::Development) ||
        !format || (std::strcmp(format, "3dsx") != 0 && std::strcmp(format, "cia") != 0) ||
        (std::strcmp(format, "3dsx") == 0 && (!game->downloadUrl[0] || !game->sizeBytes || !game->sha256[0])) ||
        (std::strcmp(format, "cia") == 0 &&
         (std::strcmp(game->downloadFormat, "cia") == 0 ?
              (!game->downloadUrl[0] || !game->sizeBytes || !game->sha256[0]) :
              (!game->ciaUrl[0] || !game->ciaSizeBytes || !game->ciaSha256[0])))) return false;
    LightLock_Lock(&gStateLock);
    const bool canStart = gGamePackageState == GamePackageState::Idle && !gGamePackageThread;
    if (canStart) {
        gGamePackageRequest = *game;
        std::snprintf(gGamePackageFormat, sizeof(gGamePackageFormat), "%s", format);
        gGamePackageState = GamePackageState::Downloading;
        gHasPendingGamePackageResult = false;
        gGamePackageDownloadedBytes = 0;
        gGamePackageTotalBytes = std::strcmp(format, "cia") == 0 && std::strcmp(game->downloadFormat, "cia") != 0
            ? game->ciaSizeBytes : game->sizeBytes;
        gCancel.store(false);
    }
    LightLock_Unlock(&gStateLock);
    if (!canStart) return false;

    s32 priority = 0x30;
    svcGetThreadPriority(&priority, CUR_THREAD_HANDLE);
    if (priority < 0x3F) ++priority;
    gGamePackageThread = threadCreate(gamePackageWorker, &gGamePackageRequest, 0x20000, priority, -2, false);
    if (!gGamePackageThread) {
        LightLock_Lock(&gStateLock);
        gGamePackageState = GamePackageState::Idle;
        LightLock_Unlock(&gStateLock);
        return false;
    }
    return true;
}

bool startHubUpdateDownload(const HubManifest* manifest) {
    if (!manifest || !manifest->published || !gLockInitialized || !gSocReady || !gCurlReady ||
        std::strncmp(manifest->ciaUrl, "https://", 8) != 0 || std::strlen(manifest->sha256) != 64) {
        return false;
    }
    LightLock_Lock(&gStateLock);
    const bool canStart = gGamePackageState == GamePackageState::Idle && !gGamePackageThread;
    if (canStart) {
        gHubUpdateRequest = *manifest;
        gGamePackageState = GamePackageState::Downloading;
        gHasPendingGamePackageResult = false;
        gGamePackageDownloadedBytes = 0;
        gGamePackageTotalBytes = 0;
        gCancel.store(false);
    }
    LightLock_Unlock(&gStateLock);
    if (!canStart) return false;

    s32 priority = 0x30;
    svcGetThreadPriority(&priority, CUR_THREAD_HANDLE);
    if (priority < 0x3F) ++priority;
    gGamePackageThread = threadCreate(hubUpdateWorker, &gHubUpdateRequest, 0x20000, priority, -2, false);
    if (!gGamePackageThread) {
        LightLock_Lock(&gStateLock);
        gGamePackageState = GamePackageState::Idle;
        LightLock_Unlock(&gStateLock);
        return false;
    }
    return true;
}

GamePackageState getGamePackageState() {
    if (!gLockInitialized) return GamePackageState::Idle;
    LightLock_Lock(&gStateLock);
    const GamePackageState state = gGamePackageState;
    LightLock_Unlock(&gStateLock);
    return state;
}

void getGamePackageProgress(u64* downloadedBytes, u64* totalBytes) {
    if (!gLockInitialized) {
        if (downloadedBytes) *downloadedBytes = 0;
        if (totalBytes) *totalBytes = 0;
        return;
    }
    LightLock_Lock(&gStateLock);
    if (downloadedBytes) *downloadedBytes = gGamePackageDownloadedBytes;
    if (totalBytes) *totalBytes = gGamePackageTotalBytes;
    LightLock_Unlock(&gStateLock);
}

bool takeGamePackageResult(GamePackageResult* output) {
    if (!output || !gLockInitialized) return false;
    LightLock_Lock(&gStateLock);
    const bool available = gHasPendingGamePackageResult;
    if (available) {
        *output = gPendingGamePackageResult;
        gHasPendingGamePackageResult = false;
        gGamePackageState = GamePackageState::Idle;
        gGamePackageDownloadedBytes = 0;
        gGamePackageTotalBytes = 0;
    }
    LightLock_Unlock(&gStateLock);
    if (available && gGamePackageThread) {
        threadJoin(gGamePackageThread, U64_MAX);
        threadFree(gGamePackageThread);
        gGamePackageThread = nullptr;
    }
    return available;
}

bool startScreenshotCache(const char* sourcePath, const char* localPath) {
    if (!sourcePath || !sourcePath[0] || !localPath || !localPath[0] || !gLockInitialized ||
        !gSocReady || !gCurlReady || std::strlen(localPath) >= sizeof(gScreenshotRequest.localPath) - 4) return false;
    LightLock_Lock(&gStateLock);
    const bool canStart = gScreenshotState == ScreenshotCacheState::Idle && !gScreenshotThread &&
                          gGamePackageState == GamePackageState::Idle;
    if (canStart) {
        gScreenshotRequest = ScreenshotRequest{};
        if (std::strncmp(sourcePath, "https://", 8) == 0) {
            std::snprintf(gScreenshotRequest.url, sizeof(gScreenshotRequest.url), "%s", sourcePath);
        } else {
            const char* relative = sourcePath[0] == '/' ? sourcePath + 1 : sourcePath;
            std::snprintf(gScreenshotRequest.url, sizeof(gScreenshotRequest.url), "%s%s", kScreenshotBaseUrl, relative);
        }
        std::snprintf(gScreenshotRequest.localPath, sizeof(gScreenshotRequest.localPath), "%s", localPath);
        std::snprintf(gScreenshotRequest.tempPath, sizeof(gScreenshotRequest.tempPath), "%s.tmp", localPath);
        gScreenshotState = ScreenshotCacheState::Downloading;
        gHasScreenshotResult = false;
        gScreenshotCancel.store(false);
    }
    LightLock_Unlock(&gStateLock);
    if (!canStart) return false;

    s32 priority = 0x30;
    svcGetThreadPriority(&priority, CUR_THREAD_HANDLE);
    if (priority < 0x3F) ++priority;
    gScreenshotThread = threadCreate(screenshotWorker, nullptr, 0x10000, priority, -2, false);
    if (!gScreenshotThread) {
        LightLock_Lock(&gStateLock);
        gScreenshotState = ScreenshotCacheState::Idle;
        LightLock_Unlock(&gStateLock);
        return false;
    }
    return true;
}

bool takeScreenshotCacheResult(ScreenshotCacheResult* output) {
    if (!output || !gLockInitialized) return false;
    LightLock_Lock(&gStateLock);
    const bool available = gHasScreenshotResult;
    if (available) {
        *output = gScreenshotResult;
        gHasScreenshotResult = false;
        gScreenshotState = ScreenshotCacheState::Idle;
    }
    LightLock_Unlock(&gStateLock);
    if (available && gScreenshotThread) {
        threadJoin(gScreenshotThread, U64_MAX);
        threadFree(gScreenshotThread);
        gScreenshotThread = nullptr;
    }
    return available;
}

void stopScreenshotCache() {
    if (gScreenshotThread) {
        gScreenshotCancel.store(true);
        threadJoin(gScreenshotThread, U64_MAX);
        threadFree(gScreenshotThread);
        gScreenshotThread = nullptr;
    }
    if (gLockInitialized) {
        LightLock_Lock(&gStateLock);
        gScreenshotState = ScreenshotCacheState::Idle;
        gHasScreenshotResult = false;
        LightLock_Unlock(&gStateLock);
    }
    gScreenshotCancel.store(false);
}

CatalogUpdateState getCatalogUpdateState() {
    if (!gLockInitialized) return CatalogUpdateState::Idle;
    LightLock_Lock(&gStateLock);
    const CatalogUpdateState state = gState;
    const bool finished = gCatalogJobFinished;
    LightLock_Unlock(&gStateLock);
    if (finished && gDownloadThread) {
        threadJoin(gDownloadThread, U64_MAX);
        threadFree(gDownloadThread);
        gDownloadThread = nullptr;
    }
    return state;
}

void stopCatalogDownload() {
    if (gGamePackageThread) {
        gCancel.store(true);
        threadJoin(gGamePackageThread, U64_MAX);
        threadFree(gGamePackageThread);
        gGamePackageThread = nullptr;
    }
    if (gDownloadThread) {
        gCancel.store(true);  // interrompt un transfert en cours au lieu d'attendre la fin du delai
        threadJoin(gDownloadThread, U64_MAX);
        threadFree(gDownloadThread);
        gDownloadThread = nullptr;
    }
    if (gCurlReady) {
        curl_global_cleanup();
        gCurlReady = false;
    }
    if (gSocReady) {
        socExit();
        gSocReady = false;
    }
    if (gSocBuffer) {
        std::free(gSocBuffer);
        gSocBuffer = nullptr;
    }
    gCancel.store(false);
}
