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
#include <ctime>
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
    return curl_easy_perform(curl);
}

// Le CDN de GitHub garde les fichiers "raw" en cache quelques minutes : un parametre
// different a chaque requete force la version la plus recente (nouvelles versions de jeux).
bool fetch(CURL* curl, const char* url) {
    char freshUrl[240];
    std::snprintf(freshUrl, sizeof(freshUrl), "%s?t=%lu", url, static_cast<unsigned long>(std::time(nullptr)));
    for (int attempt = 0; attempt < 2 && !gCancel.load(); ++attempt) {
        gResponseSize = 0;
        gResponseBuffer[0] = '\0';
        curl_easy_setopt(curl, CURLOPT_URL, freshUrl);
        const CURLcode result = performHttps(curl);
        long responseCode = 0;
        curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &responseCode);
        gResponseBuffer[gResponseSize] = '\0';
        if (result == CURLE_OK && responseCode == 200 && gResponseSize > 0) return true;
    }
    return false;
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
        curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT_MS, 8000L);
        curl_easy_setopt(curl, CURLOPT_TIMEOUT_MS, 30000L);
        curl_easy_setopt(curl, CURLOPT_ACCEPT_ENCODING, "");  // gzip si disponible : catalogue plus rapide a charger
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

const char* gPackageError = "";

void failPackage(const char* id, const char* reason, bool isHubUpdate = false) {
    gPackageError = reason ? reason : "";
    finishGamePackage(GamePackageState::Failed, id, isHubUpdate);
}

// Verifie l'espace libre sur la carte SD avant de telecharger / installer.
// Si la lecture echoue on ne bloque pas : l'ecriture signalera l'erreur elle-meme.
bool sdHasFreeSpace(u64 neededBytes) {
    FS_ArchiveResource resource{};
    if (R_FAILED(FSUSER_GetSdmcArchiveResource(&resource)) || resource.clusterSize == 0) return true;
    return static_cast<u64>(resource.clusterSize) * resource.freeClusters >= neededBytes;
}

// Installe un .cia present sur la SD. libctru officiel : AM_TitleEntry et
// AM_StartCiaInstall (AM remplace tout seul un titre deja installe, ce qui
// permet les mises a jour sans desinstaller).
bool installCiaPackage(const char* path, u64 expectedTitleId, u64* installedTitleId, const char** reason) {
    *reason = "Installation impossible";
    if (!path || std::strncmp(path, "sdmc:/", 6) != 0 || !installedTitleId) return false;
    if (R_FAILED(amInit())) {
        *reason = "Service AM indisponible";
        return false;
    }
    const FS_Path archivePath = fsMakePath(PATH_EMPTY, "");
    const FS_Path filePath = fsMakePath(PATH_ASCII, path + 5);
    Handle fileHandle = 0;
    Result result = FSUSER_OpenFileDirectly(&fileHandle, ARCHIVE_SDMC, archivePath, filePath, FS_OPEN_READ, 0);
    AM_TitleEntry ciaInfo{};
    if (R_SUCCEEDED(result)) result = AM_GetCiaFileInfo(MEDIATYPE_SD, &ciaInfo, fileHandle);
    if (fileHandle) FSFILE_Close(fileHandle);
    if (R_FAILED(result) || ciaInfo.titleID == 0) {
        amExit();
        *reason = "CIA invalide";
        return false;
    }
    if (expectedTitleId && expectedTitleId != ciaInfo.titleID) {
        amExit();
        *reason = "CIA d'un autre jeu";
        return false;
    }

    Handle installHandle = 0;
    result = AM_StartCiaInstall(MEDIATYPE_SD, &installHandle);
    if (R_FAILED(result)) {
        amExit();
        *reason = "Démarrage de l'installation refusé";
        return false;
    }
    FILE* input = std::fopen(path, "rb");
    unsigned char* buffer = static_cast<unsigned char*>(memalign(0x1000, 0x10000));  // sur le tas : la pile du thread est petite
    u64 offset = 0;
    bool ok = input != nullptr && buffer != nullptr;
    while (ok) {
        const std::size_t count = std::fread(buffer, 1, 0x10000, input);
        if (count == 0) {
            if (std::ferror(input)) ok = false;
            break;
        }
        u32 written = 0;
        result = FSFILE_Write(installHandle, &written, offset, buffer, static_cast<u32>(count), 0);
        if (R_FAILED(result) || written != count) ok = false;
        else offset += written;
    }
    std::free(buffer);
    if (input && std::fclose(input) != 0) ok = false;
    if (ok) {
        result = FSFILE_Flush(installHandle);
        if (R_SUCCEEDED(result)) result = AM_FinishCiaInstall(installHandle);
        if (R_FAILED(result)) AM_CancelCIAInstall(installHandle);
    } else {
        AM_CancelCIAInstall(installHandle);
    }
    AM_TitleEntry installedInfo{};
    u64 verifiedTitleId = ciaInfo.titleID;
    const bool installed = R_SUCCEEDED(result) && ok &&
        R_SUCCEEDED(AM_GetTitleInfo(MEDIATYPE_SD, 1, &verifiedTitleId, &installedInfo)) &&
        installedInfo.titleID == ciaInfo.titleID;
    amExit();
    if (!installed) {
        *reason = ok ? "Le système a refusé le CIA" : "Écriture de l'installation échouée";
        return false;
    }
    *installedTitleId = ciaInfo.titleID;
    return true;
}

// Telecharge un paquet en HTTPS, verifie taille + SHA-256 et le laisse dans tempPath.
// Une seule nouvelle tentative, uniquement pour les erreurs reseau passageres.
bool downloadVerifiedPackage(const char* url, const char* tempPath, u32 expectedBytes, u32 maxBytes,
                             const char* expectedSha, const char** reason) {
    *reason = "Téléchargement échoué";
    for (int attempt = 0; attempt < 2; ++attempt) {
        if (gCancel.load()) {
            *reason = "Annulé";
            return false;
        }
        std::remove(tempPath);
        FILE* output = std::fopen(tempPath, "wb");
        if (!output) {
            *reason = "Écriture SD impossible";
            return false;
        }
        GameFileSink sink{};
        sink.file = output;
        sink.expectedBytes = expectedBytes;
        sink.maxBytes = maxBytes;
        mbedtls_sha256_init(&sink.hash);
        const bool hashStarted = mbedtls_sha256_starts_ret(&sink.hash, 0) == 0;

        CURLcode request = CURLE_FAILED_INIT;
        long responseCode = 0;
        CURL* curl = hashStarted ? curl_easy_init() : nullptr;
        if (curl) {
            curl_easy_setopt(curl, CURLOPT_URL, url);
            curl_easy_setopt(curl, CURLOPT_CAINFO, resolveCaBundlePath());
            curl_easy_setopt(curl, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4);
            curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 1L);
            curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 2L);
            curl_easy_setopt(curl, CURLOPT_PROTOCOLS_STR, "https");
            curl_easy_setopt(curl, CURLOPT_REDIR_PROTOCOLS_STR, "https");
            curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
            curl_easy_setopt(curl, CURLOPT_MAXREDIRS, 5L);
            curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT_MS, 10000L);
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
            curl_easy_setopt(curl, CURLOPT_MAXFILESIZE_LARGE, static_cast<curl_off_t>(maxBytes));
            request = curl_easy_perform(curl);
            curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &responseCode);
            curl_easy_cleanup(curl);
        }
        unsigned char digest[32]{};
        const bool hashFinished = hashStarted && mbedtls_sha256_finish_ret(&sink.hash, digest) == 0;
        mbedtls_sha256_free(&sink.hash);
        const bool closed = std::fclose(output) == 0;

        if (gCancel.load()) {
            std::remove(tempPath);
            *reason = "Annulé";
            return false;
        }
        if (request == CURLE_OK && responseCode == 200 && !sink.hashFailed && closed && hashFinished) {
            const bool sizeOk = expectedBytes ? sink.receivedBytes == expectedBytes : sink.receivedBytes > 0;
            if (!sizeOk) {
                std::remove(tempPath);
                *reason = "Taille du fichier inattendue";
                return false;
            }
            if (!digestMatches(digest, expectedSha)) {
                std::remove(tempPath);
                *reason = "Fichier corrompu (SHA-256)";
                return false;
            }
            return true;
        }

        std::remove(tempPath);
        if (responseCode == 404) {
            *reason = "Fichier introuvable sur le serveur";
            return false;
        }
        if (request == CURLE_PEER_FAILED_VERIFICATION || request == CURLE_SSL_CACERT_BADFILE ||
            request == CURLE_SSL_CONNECT_ERROR) {
            *reason = "Erreur de certificat HTTPS";
            return false;
        }
        if (request == CURLE_WRITE_ERROR || request == CURLE_FILESIZE_EXCEEDED || sink.hashFailed || !closed) {
            *reason = sink.receivedBytes >= (expectedBytes ? expectedBytes : maxBytes) ? "Taille du fichier inattendue"
                                                                                       : "Écriture SD impossible";
            return false;
        }
        const bool retryable = request == CURLE_OPERATION_TIMEDOUT || request == CURLE_COULDNT_CONNECT ||
                               request == CURLE_COULDNT_RESOLVE_HOST || request == CURLE_RECV_ERROR ||
                               request == CURLE_SEND_ERROR || request == CURLE_PARTIAL_FILE ||
                               request == CURLE_GOT_NOTHING;
        *reason = request == CURLE_OPERATION_TIMEDOUT ? "Connexion trop lente" : "Connexion impossible";
        if (!retryable) return false;
    }
    return false;
}

void gamePackageWorker(void* userData) {
    const CatalogGame game = *static_cast<const CatalogGame*>(userData);
    char packageFormat[12]{};
    std::snprintf(packageFormat, sizeof(packageFormat), "%s", gGamePackageFormat);
    const bool isCia = std::strcmp(packageFormat, "cia") == 0;
    const bool is3dsx = std::strcmp(packageFormat, "3dsx") == 0;
    const bool ciaIsPrimary = isCia && std::strcmp(game.downloadFormat, "cia") == 0;
    const char* packageUrl = isCia ? (ciaIsPrimary ? game.downloadUrl : game.ciaUrl) : game.downloadUrl;
    const char* packageHash = isCia ? (ciaIsPrimary ? game.sha256 : game.ciaSha256) : game.sha256;
    const u32 packageBytes = isCia ? (ciaIsPrimary ? game.sizeBytes : game.ciaSizeBytes) : game.sizeBytes;
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
    struct stat registryBackupInfo{};
    const bool registryExists =
        stat("sdmc:/3ds/FlashGamesHub/installed.json", &registryInfo) == 0 ||
        stat("sdmc:/3ds/FlashGamesHub/installed.json.bak", &registryBackupInfo) == 0;
    const bool targetExists = stat(targetPath, &targetInfo) == 0 && targetInfo.st_size > 0;
    const bool isUpdate = isInstalledGame(installedGames, game.id, &installed);

    if (!registryLoaded && registryExists) return failPackage(game.id, "Liste des jeux installés illisible");
    if (game.status != GameStatus::Available && game.status != GameStatus::Development)
        return failPackage(game.id, "Jeu indisponible");
    if (!isCia && !is3dsx) return failPackage(game.id, "Format inconnu");
    // Un .3dsx ne peut venir que d'une entree 3dsx : sinon on telechargerait un CIA sous un nom .3dsx.
    if (is3dsx && std::strcmp(game.downloadFormat, "3dsx") != 0) return failPackage(game.id, "Pas de version .3dsx");
    if (!game.version[0] || !packageBytes || !packageHash[0] || !packageUrl[0])
        return failPackage(game.id, "Informations du jeu incomplètes");
    if (isUpdate && (!installed || std::strcmp(installed->format, packageFormat) != 0))
        return failPackage(game.id, "Format différent de l'installation");
    if (isUpdate && compareVersions(game.version, installed->version) < 0)
        return failPackage(game.id, "Une version plus récente est déjà installée");
    if (gCancel.load()) return failPackage(game.id, "Annulé");

    // Un .3dsx deja present (mise a jour, ou fichier orphelin dont l'entree a disparu)
    // est remplace en gardant une sauvegarde pour pouvoir revenir en arriere.
    const bool replaceExisting = is3dsx && targetExists;
    const u64 needed = static_cast<u64>(packageBytes) * (isCia ? 2 : 1) + 2ULL * 1024 * 1024;
    if (!sdHasFreeSpace(needed)) return failPackage(game.id, "Espace SD insuffisant");

    mkdir("sdmc:/3ds", 0777);
    mkdir("sdmc:/3ds/FlashGamesHub", 0777);
    mkdir(kGamesDirectory, 0777);
    mkdir(kSavesDirectory, 0777);  // les mises a jour ne touchent jamais aux sauvegardes
    mkdir(gameDirectory, 0777);

    const char* reason = "Téléchargement échoué";
    if (!downloadVerifiedPackage(packageUrl, temporaryPath, packageBytes, packageBytes, packageHash, &reason))
        return failPackage(game.id, reason);

    if (isCia) {
        setGamePackageState(GamePackageState::Installing);
        u64 titleId = 0;
        const u64 expectedTitleId = isUpdate && installed ? installed->titleId : 0;
        if (!installCiaPackage(temporaryPath, expectedTitleId, &titleId, &reason)) {
            std::remove(temporaryPath);
            return failPackage(game.id, reason);
        }
        std::remove(temporaryPath);
        if (!registerInstalledGame(&installedGames, game.id, game.version, packageBytes, "cia", titleId))
            return failPackage(game.id, "Installé, liste non mise à jour");
        gPackageError = "";
        finishGamePackage(GamePackageState::Installed, game.id);
        return;
    }

    std::remove(backupPath);
    if (replaceExisting && std::rename(targetPath, backupPath) != 0) {
        std::remove(temporaryPath);
        return failPackage(game.id, "Impossible de remplacer l'ancienne version");
    }
    if (std::rename(temporaryPath, targetPath) != 0) {
        if (replaceExisting) std::rename(backupPath, targetPath);
        std::remove(temporaryPath);
        return failPackage(game.id, "Écriture SD impossible");
    }
    if (!registerInstalledGame(&installedGames, game.id, game.version, packageBytes, "3dsx", 0)) {
        std::remove(targetPath);
        if (replaceExisting) std::rename(backupPath, targetPath);
        return failPackage(game.id, "Liste des jeux non mise à jour");
    }
    if (replaceExisting) std::remove(backupPath);
    gPackageError = "";
    finishGamePackage(GamePackageState::Installed, game.id);
}

HubManifest gHubUpdateRequest{};

void hubUpdateWorker(void* userData) {
    const HubManifest manifest = *static_cast<const HubManifest*>(userData);
    constexpr const char* kHubTempPath = "sdmc:/3ds/FlashGamesHub/FlashGamesHub-update.cia.tmp";
    if (!manifest.published || std::strncmp(manifest.ciaUrl, "https://", 8) != 0 ||
        std::strlen(manifest.sha256) != 64) {
        return failPackage("hub", "Manifeste du Hub invalide", true);
    }
    if (gCancel.load()) return failPackage("hub", "Annulé", true);
    if (!sdHasFreeSpace(48ULL * 1024 * 1024)) return failPackage("hub", "Espace SD insuffisant", true);

    mkdir("sdmc:/3ds", 0777);
    mkdir(kCacheDirectory, 0777);
    const char* reason = "Téléchargement échoué";
    if (!downloadVerifiedPackage(manifest.ciaUrl, kHubTempPath, 0, kMaxHubCiaBytes, manifest.sha256, &reason))
        return failPackage("hub", reason, true);

    setGamePackageState(GamePackageState::Installing);
    u64 titleId = 0;
    const bool installed = installCiaPackage(kHubTempPath, kHubTitleId, &titleId, &reason);
    std::remove(kHubTempPath);
    if (!installed) return failPackage("hub", reason, true);
    gPackageError = "";
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
        (std::strcmp(format, "3dsx") == 0 && (std::strcmp(game->downloadFormat, "3dsx") != 0 || !game->downloadUrl[0] || !game->sizeBytes || !game->sha256[0])) ||
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

const char* getGamePackageError() { return gPackageError; }

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
