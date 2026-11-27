#include "catalog_network.hpp"
#include "installed_games.hpp"

#include <3ds.h>
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
constexpr const char* kCaBundlePath = "romfs:/ca-bundle.pem";
constexpr const char* kCacheDirectory = "sdmc:/3ds/FlashGamesHub";
constexpr const char* kCachePath = "sdmc:/3ds/FlashGamesHub/catalog.json";
constexpr const char* kCacheTempPath = "sdmc:/3ds/FlashGamesHub/catalog.json.tmp";
constexpr const char* kHubCachePath = "sdmc:/3ds/FlashGamesHub/hub.json";
constexpr const char* kHubCacheTempPath = "sdmc:/3ds/FlashGamesHub/hub.json.tmp";
constexpr const char* kGamesDirectory = "sdmc:/3ds/FlashGamesHub/games";
constexpr const char* kSavesDirectory = "sdmc:/3ds/FlashGamesHub/saves";
constexpr std::size_t kMaxCatalogBytes = 256 * 1024;
constexpr u32 kSocBufferSize = 0x100000;

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
GamePackageState gGamePackageState = GamePackageState::Idle;
CatalogGame gGamePackageRequest{};
GamePackageResult gPendingGamePackageResult{};
bool gHasPendingGamePackageResult = false;
bool gCatalogJobFinished = false;
u32* gSocBuffer = nullptr;
bool gSocReady = false;
bool gCurlReady = false;
std::atomic<bool> gCancel{false};
char gResponseBuffer[kMaxCatalogBytes + 1]{};
std::size_t gResponseSize = 0;

void setState(CatalogUpdateState state) {
    LightLock_Lock(&gStateLock);
    gState = state;
    LightLock_Unlock(&gStateLock);
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

bool fetch(CURL* curl, const char* url) {
    gResponseSize = 0;
    gResponseBuffer[0] = '\0';
    curl_easy_setopt(curl, CURLOPT_URL, url);
    const CURLcode result = curl_easy_perform(curl);
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
        curl_easy_setopt(curl, CURLOPT_CAINFO, kCaBundlePath);
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
    bool hashFailed;
};

std::size_t receiveGamePackage(char* data, std::size_t itemSize, std::size_t itemCount, void* userData) {
    if (itemSize != 0 && itemCount > static_cast<std::size_t>(-1) / itemSize) return 0;
    const std::size_t bytes = itemSize * itemCount;
    GameFileSink* sink = static_cast<GameFileSink*>(userData);
    if (!sink || !sink->file || bytes > sink->expectedBytes - sink->receivedBytes) return 0;
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

void finishGamePackage(GamePackageState state, const char* id) {
    LightLock_Lock(&gStateLock);
    gGamePackageState = state;
    gPendingGamePackageResult = GamePackageResult{};
    gPendingGamePackageResult.state = state;
    if (id) std::snprintf(gPendingGamePackageResult.gameId, sizeof(gPendingGamePackageResult.gameId), "%s", id);
    gHasPendingGamePackageResult = true;
    LightLock_Unlock(&gStateLock);
}

void gamePackageWorker(void* userData) {
    const CatalogGame game = *static_cast<const CatalogGame*>(userData);
    GamePackageState resultState = GamePackageState::Failed;
    char gameDirectory[160];
    char targetPath[224];
    char temporaryPath[232];
    char backupPath[232];
    std::snprintf(gameDirectory, sizeof(gameDirectory), "%s/%s", kGamesDirectory, game.id);
    std::snprintf(targetPath, sizeof(targetPath), "%s/%s.3dsx", gameDirectory, game.id);
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
    if (!registryValid || !packageStateAllowed || std::strcmp(game.downloadFormat, "3dsx") != 0 ||
        !game.version[0] || !game.sizeBytes || !game.sha256[0] || !game.downloadUrl[0] ||
        (isUpdate && (!installed || compareVersions(game.version, installed->version) <= 0 || !targetExists)) ||
        (!isUpdate && targetExists) || gCancel.load()) {
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
    sink.expectedBytes = game.sizeBytes;
    mbedtls_sha256_init(&sink.hash);
    bool valid = mbedtls_sha256_starts_ret(&sink.hash, 0) == 0;

    CURL* curl = valid ? curl_easy_init() : nullptr;
    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, game.downloadUrl);
        curl_easy_setopt(curl, CURLOPT_CAINFO, kCaBundlePath);
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 1L);
        curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 2L);
        curl_easy_setopt(curl, CURLOPT_PROTOCOLS_STR, "https");
        curl_easy_setopt(curl, CURLOPT_REDIR_PROTOCOLS_STR, "https");
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
        curl_easy_setopt(curl, CURLOPT_MAXREDIRS, 3L);
        curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT_MS, 8000L);
        curl_easy_setopt(curl, CURLOPT_TIMEOUT_MS, 120000L);
        curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
        curl_easy_setopt(curl, CURLOPT_USERAGENT, "FlashGamesHub/0.1");
        curl_easy_setopt(curl, CURLOPT_FAILONERROR, 1L);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, receiveGamePackage);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &sink);
        curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0L);
        curl_easy_setopt(curl, CURLOPT_XFERINFOFUNCTION, progressCallback);
        curl_easy_setopt(curl, CURLOPT_MAXFILESIZE_LARGE, static_cast<curl_off_t>(game.sizeBytes));
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
    if (valid) valid = mbedtls_sha256_finish_ret(&sink.hash, digest) == 0 && digestMatches(digest, game.sha256);
    mbedtls_sha256_free(&sink.hash);
    if (std::fclose(output) != 0) valid = false;
    if (!valid) {
        std::remove(temporaryPath);
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
    if (!registerInstalledGame(&installedGames, game.id, game.version, game.sizeBytes)) {
        std::remove(targetPath);
        if (isUpdate) std::rename(backupPath, targetPath);
        finishGamePackage(resultState, game.id);
        return;
    }
    if (isUpdate) std::remove(backupPath);
    resultState = GamePackageState::Installed;
    finishGamePackage(resultState, game.id);
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

bool startGamePackageDownload(const CatalogGame* game) {
    if (!game || !gLockInitialized || !gSocReady || !gCurlReady || !game->id[0] ||
        (game->status != GameStatus::Available && game->status != GameStatus::Development) ||
        std::strcmp(game->downloadFormat, "3dsx") != 0) return false;
    LightLock_Lock(&gStateLock);
    const bool canStart = gCatalogJobFinished && gGamePackageState == GamePackageState::Idle && !gGamePackageThread;
    if (canStart) {
        gGamePackageRequest = *game;
        gGamePackageState = GamePackageState::Downloading;
        gHasPendingGamePackageResult = false;
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

GamePackageState getGamePackageState() {
    if (!gLockInitialized) return GamePackageState::Idle;
    LightLock_Lock(&gStateLock);
    const GamePackageState state = gGamePackageState;
    LightLock_Unlock(&gStateLock);
    return state;
}

bool takeGamePackageResult(GamePackageResult* output) {
    if (!output || !gLockInitialized) return false;
    LightLock_Lock(&gStateLock);
    const bool available = gHasPendingGamePackageResult;
    if (available) {
        *output = gPendingGamePackageResult;
        gHasPendingGamePackageResult = false;
        gGamePackageState = GamePackageState::Idle;
    }
    LightLock_Unlock(&gStateLock);
    if (available && gGamePackageThread) {
        threadJoin(gGamePackageThread, U64_MAX);
        threadFree(gGamePackageThread);
        gGamePackageThread = nullptr;
    }
    return available;
}

CatalogUpdateState getCatalogUpdateState() {
    if (!gLockInitialized) return CatalogUpdateState::Idle;
    LightLock_Lock(&gStateLock);
    const CatalogUpdateState state = gState;
    LightLock_Unlock(&gStateLock);
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
