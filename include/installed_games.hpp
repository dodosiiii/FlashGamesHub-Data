#pragma once

#include "catalog.hpp"

bool loadInstalledGamesFromSd(InstalledGameList* output);
bool registerInstalledGame(InstalledGameList* games, const char* id, const char* version, u32 sizeBytes,
                           const char* format = "3dsx", u64 titleId = 0);
bool unregisterInstalledGame(InstalledGameList* games, const char* id);
