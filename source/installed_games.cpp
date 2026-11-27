#include "installed_games.hpp"

#include <cerrno>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <sys/stat.h>

namespace {

constexpr const char* kDirectory = "sdmc:/3ds/FlashGamesHub";
constexpr const char* kInstalledPath = "sdmc:/3ds/FlashGamesHub/installed.json";
constexpr const char* kTemporaryPath = "sdmc:/3ds/FlashGamesHub/installed.json.tmp";
constexpr const char* kBackupPath = "sdmc:/3ds/FlashGamesHub/installed.json.bak";
constexpr std::size_t kMaxFileBytes = 32 * 1024;
char gJsonBuffer[kMaxFileBytes];

bool validId(const char* id) {
    if (!id || !*id || std::strlen(id) >= 64) return false;
    for (const char* c = id; *c; ++c) {
        if (!((*c >= 'a' && *c <= 'z') || (*c >= '0' && *c <= '9') || *c == '-')) return false;
    }
    return true;
}

bool validVersion(const char* version) {
    if (!version || !*version || std::strlen(version) >= 24) return false;
    int dots = 0;
    bool hasDigit = false;
    for (const char* c = version; *c; ++c) {
        if (*c >= '0' && *c <= '9') hasDigit = true;
        else if (*c == '.' && hasDigit) {
            ++dots;
            hasDigit = false;
        } else if ((*c == '-' || *c == '+') && dots == 2 && hasDigit) {
            for (++c; *c; ++c) {
                if (!((*c >= 'a' && *c <= 'z') || (*c >= 'A' && *c <= 'Z') ||
                      (*c >= '0' && *c <= '9') || *c == '.' || *c == '-')) return false;
            }
            return true;
        } else {
            return false;
        }
    }
    return dots == 2 && hasDigit;
}

bool writeList(const InstalledGameList& games) {
    std::size_t used = 0;
    int written = std::snprintf(gJsonBuffer, sizeof(gJsonBuffer), "{\"schema_version\":2,\"games\":[");
    if (written < 0 || static_cast<std::size_t>(written) >= sizeof(gJsonBuffer)) return false;
    used = static_cast<std::size_t>(written);
    for (std::size_t i = 0; i < games.count; ++i) {
        const InstalledGame& game = games.games[i];
        if (!validId(game.id) || !validVersion(game.version)) return false;
        const char* format = game.format[0] ? game.format : "3dsx";
        if (std::strcmp(format, "3dsx") != 0 && std::strcmp(format, "cia") != 0) return false;
        written = std::snprintf(gJsonBuffer + used, sizeof(gJsonBuffer) - used,
                                "%s{\"id\":\"%s\",\"version\":\"%s\",\"size_bytes\":%u,\"file_type\":\"%s\",\"title_id\":%llu}",
                                i ? "," : "", game.id, game.version, static_cast<unsigned>(game.sizeBytes), format,
                                static_cast<unsigned long long>(game.titleId));
        if (written < 0 || static_cast<std::size_t>(written) >= sizeof(gJsonBuffer) - used) return false;
        used += static_cast<std::size_t>(written);
    }
    constexpr char suffix[] = "]}\n";
    if (sizeof(suffix) > sizeof(gJsonBuffer) - used) return false;
    std::memcpy(gJsonBuffer + used, suffix, sizeof(suffix));
    used += sizeof(suffix) - 1;

    mkdir("sdmc:/3ds", 0777);
    mkdir(kDirectory, 0777);
    FILE* file = std::fopen(kTemporaryPath, "wb");
    if (!file) return false;
    const std::size_t outputSize = std::fwrite(gJsonBuffer, 1, used, file);
    bool ok = outputSize == used;
    if (std::fclose(file) != 0) ok = false;
    if (ok) {
        struct stat previousInfo{};
        errno = 0;
        const bool hadPrevious = stat(kInstalledPath, &previousInfo) == 0;
        if (!hadPrevious && errno != ENOENT) ok = false;
        if (ok && hadPrevious && std::remove(kBackupPath) != 0) {
            struct stat backupInfo{};
            if (stat(kBackupPath, &backupInfo) == 0) ok = false;
        }
        if (ok && hadPrevious && std::rename(kInstalledPath, kBackupPath) != 0) ok = false;
        if (ok && std::rename(kTemporaryPath, kInstalledPath) != 0) {
            ok = false;
            if (hadPrevious) std::rename(kBackupPath, kInstalledPath);
        } else if (ok) {
            std::remove(kBackupPath);
        }
    }
    if (!ok) std::remove(kTemporaryPath);
    return ok;
}

enum class ReadListResult { Missing, Invalid, Failed, Valid };

ReadListResult readList(const char* path, InstalledGameList* output) {
    errno = 0;
    FILE* file = std::fopen(path, "rb");
    if (!file) return errno == ENOENT ? ReadListResult::Missing : ReadListResult::Failed;
    if (std::fseek(file, 0, SEEK_END) != 0) {
        std::fclose(file);
        return ReadListResult::Failed;
    }
    const long length = std::ftell(file);
    if (length < 0) {
        std::fclose(file);
        return ReadListResult::Failed;
    }
    if (length == 0 || static_cast<unsigned long>(length) > kMaxFileBytes) {
        std::fclose(file);
        return ReadListResult::Invalid;
    }
    if (std::fseek(file, 0, SEEK_SET) != 0) {
        std::fclose(file);
        return ReadListResult::Failed;
    }
    char* json = static_cast<char*>(std::malloc(static_cast<std::size_t>(length) + 1));
    if (!json) {
        std::fclose(file);
        return ReadListResult::Failed;
    }
    const std::size_t read = std::fread(json, 1, static_cast<std::size_t>(length), file);
    const bool closeOk = std::fclose(file) == 0;
    json[read] = '\0';
    InstalledGameList parsed{};
    const bool valid = read == static_cast<std::size_t>(length) && closeOk &&
                       parseInstalledGamesJson(json, read, &parsed);
    std::free(json);
    if (!closeOk || read != static_cast<std::size_t>(length)) return ReadListResult::Failed;
    if (!valid) return ReadListResult::Invalid;
    *output = parsed;
    return ReadListResult::Valid;
}

} // namespace

bool loadInstalledGamesFromSd(InstalledGameList* output) {
    if (!output) return false;
    *output = InstalledGameList{};
    const ReadListResult primary = readList(kInstalledPath, output);
    if (primary == ReadListResult::Valid) return true;
    if (primary == ReadListResult::Failed) return false;

    InstalledGameList backup{};
    if (readList(kBackupPath, &backup) != ReadListResult::Valid) return false;
    if (primary == ReadListResult::Invalid && std::remove(kInstalledPath) != 0) {
        return false;
    }
    if (std::rename(kBackupPath, kInstalledPath) != 0) return false;
    *output = backup;
    return true;
}

bool registerInstalledGame(InstalledGameList* games, const char* id, const char* version, u32 sizeBytes,
                           const char* format, u64 titleId) {
    if (!games || !validId(id) || !validVersion(version) || !format ||
        (std::strcmp(format, "3dsx") != 0 && std::strcmp(format, "cia") != 0) ||
        (std::strcmp(format, "cia") == 0 && titleId == 0)) return false;
    InstalledGameList updated = *games;
    std::size_t index = updated.count;
    for (std::size_t i = 0; i < updated.count; ++i) {
        if (std::strcmp(updated.games[i].id, id) == 0) {
            index = i;
            break;
        }
    }
    if (index == updated.count) {
        if (updated.count >= InstalledGameList::kMaxGames) return false;
        ++updated.count;
    }
    InstalledGame& game = updated.games[index];
    std::memset(&game, 0, sizeof(game));
    std::memcpy(game.id, id, std::strlen(id) + 1);
    std::memcpy(game.version, version, std::strlen(version) + 1);
    std::memcpy(game.format, format, std::strlen(format) + 1);
    game.sizeBytes = sizeBytes;
    game.titleId = titleId;
    if (!writeList(updated)) return false;
    *games = updated;
    return true;
}

bool unregisterInstalledGame(InstalledGameList* games, const char* id) {
    if (!games || !validId(id)) return false;
    InstalledGameList updated = *games;
    std::size_t index = 0;
    while (index < updated.count && std::strcmp(updated.games[index].id, id) != 0) ++index;
    if (index == updated.count) return false;
    for (std::size_t i = index + 1; i < updated.count; ++i) updated.games[i - 1] = updated.games[i];
    --updated.count;
    std::memset(&updated.games[updated.count], 0, sizeof(updated.games[0]));
    if (!writeList(updated)) return false;
    *games = updated;
    return true;
}
