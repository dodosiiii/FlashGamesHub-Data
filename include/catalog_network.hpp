#pragma once

#include "catalog.hpp"

enum class CatalogUpdateState : u8 {
    Idle,
    Downloading,
    Updated,
    Unavailable,
};

enum class GamePackageState : u8 {
    Idle,
    Downloading,
    Installing,
    Installed,
    Failed,
};

struct GamePackageResult {
    GamePackageState state;
    char gameId[64];
    bool isHubUpdate;
    u64 titleId;
};

enum class ScreenshotCacheState : u8 { Idle, Downloading, Ready, Failed };
struct ScreenshotCacheResult {
    ScreenshotCacheState state;
    char localPath[256];
};

bool loadCachedCatalog(GameCatalog* output);
bool loadCachedHubManifest(HubManifest* output);
bool startCatalogDownload();
bool takeDownloadedCatalog(GameCatalog* output);
bool takeDownloadedHubManifest(HubManifest* output);
bool startGamePackageDownload(const CatalogGame* game, const char* format = nullptr);
bool startHubUpdateDownload(const HubManifest* manifest);
GamePackageState getGamePackageState();
void getGamePackageProgress(u64* downloadedBytes, u64* totalBytes);
bool takeGamePackageResult(GamePackageResult* output);
bool startScreenshotCache(const char* sourcePath, const char* localPath);
bool takeScreenshotCacheResult(ScreenshotCacheResult* output);
void stopScreenshotCache();
CatalogUpdateState getCatalogUpdateState();
void stopCatalogDownload();
