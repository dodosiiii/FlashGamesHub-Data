#pragma once

#include <3ds.h>

#include <cstddef>

enum class GameStatus : u8 {
    Available,
    Unavailable,
    ComingSoon,
    Development,
    Discontinued,
};

struct CatalogGame {
    char id[64];
    char name[96];
    char description[256];
    char descriptionEn[256];
    char genre[48];
    char developer[64];
    char cover[128];
    char screenshots[3][128];
    u8 screenshotCount;
    char version[24];
    char downloadFormat[12];
    char downloadUrl[256];
    char sha256[65];
    char ciaUrl[256];
    char ciaSha256[65];
    u64 ciaTitleId;
    char compatibility3ds[16];
    char compatibilityNew3ds[16];
    char seriesId[64];
    char seriesName[80];
    u32 sizeBytes;
    u32 ciaSizeBytes;
    u16 episode;
    GameStatus status;
};

struct GameCatalog {
    static constexpr std::size_t kMaxGames = 96;
    std::size_t count;
    u32 catalogVersion;
    CatalogGame games[kMaxGames];
};

struct HubManifest {
    bool published;
    char latestVersion[32];
    char minimumSupportedVersion[32];
    char ciaUrl[256];
    char sha256[65];
    char releaseNotes[256];
};

struct InstalledGame {
    char id[64];
    char version[24];
    char format[12];
    u32 sizeBytes;
    u64 titleId;
};

struct InstalledGameList {
    static constexpr std::size_t kMaxGames = 64;
    std::size_t count;
    InstalledGame games[kMaxGames];
};

bool parseCatalogJson(const char* json, std::size_t length, GameCatalog* output);
bool parseHubManifestJson(const char* json, std::size_t length, HubManifest* output);
bool parseInstalledGamesJson(const char* json, std::size_t length, InstalledGameList* output);
int compareVersions(const char* left, const char* right);
const char* gameStatusLabel(GameStatus status);
