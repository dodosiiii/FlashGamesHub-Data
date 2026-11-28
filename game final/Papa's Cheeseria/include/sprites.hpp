// sprites.hpp — registre des planches romfs:/gfx/*.t3x (chargement à la demande)
#pragma once

namespace cheeseria {
namespace sprites {

void        scan();
int         sheetCount();
const char* sheetName(int sheet);
bool        load(int sheet);
void        unload(int sheet);
void        unloadAll();
int         spriteCount(int sheet);
const char* spriteName(int sheet, int idx);
bool        find(const char* name, int& sheet, int& idx);
bool        size(int sheet, int idx, float& w, float& h);
bool        drawIndex(int sheet, int idx, float x, float y, float sx, float sy);
bool        draw(const char* name, float x, float y, float sx, float sy);

} // namespace sprites
} // namespace cheeseria
