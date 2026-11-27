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
    Installed,
    Failed,
};

struct GamePackageResult {
    GamePackageState state;
    char gameId[64];
};

bool loadCachedCatalog(GameCatalog* output);
bool loadCachedHubManifest(HubManifest* output);
bool startCatalogDownload();
bool takeDownloadedCatalog(GameCatalog* output);
bool takeDownloadedHubManifest(HubManifest* output);
bool startGamePackageDownload(const CatalogGame* game);
GamePackageState getGamePackageState();
bool takeGamePackageResult(GamePackageResult* output);
CatalogUpdateState getCatalogUpdateState();
void stopCatalogDownload();
