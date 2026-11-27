#pragma once

#include "catalog.hpp"

bool loadInstalledGamesFromSd(InstalledGameList* output);
bool registerInstalledGame(InstalledGameList* games, const char* id, const char* version, u32 sizeBytes);
bool unregisterInstalledGame(InstalledGameList* games, const char* id);
