// sprites.cpp — Papa's Cheeseria 3DS
#include "sprites.hpp"

#include <3ds.h>
#include <citro2d.h>
#include <dirent.h>

#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <unordered_map>
#include <vector>

namespace cheeseria {
namespace sprites {

namespace {

struct SheetInfo {
    std::string     name;
    std::string     path;
    C2D_SpriteSheet sheet = nullptr;
};

struct Ref { int sheet = -1; int idx = -1; };

std::vector<SheetInfo>                 g_sheets;
std::vector<std::vector<std::string>>  g_names;   // [planche][index] -> nom
std::unordered_map<std::string, Ref>   g_byName;

bool validSheet(int s) { return s >= 0 && s < static_cast<int>(g_sheets.size()); }

void loadManifest() {
    FILE* f = fopen("romfs:/gfx/manifest.tsv", "r");
    if (!f) return;
    char line[512];
    while (fgets(line, sizeof(line), f)) {
        std::size_t n = std::strlen(line);
        while (n > 0 && (line[n - 1] == '\n' || line[n - 1] == '\r')) line[--n] = '\0';
        if (n == 0 || line[0] == '#') continue;

        char* t1 = std::strchr(line, '\t');
        if (!t1) continue;
        *t1++ = '\0';
        char* t2 = std::strchr(t1, '\t');
        if (!t2) continue;
        *t2++ = '\0';

        int idx = std::atoi(t1);
        if (idx < 0 || *t2 == '\0') continue;

        int sh = -1;
        for (std::size_t i = 0; i < g_sheets.size(); ++i)
            if (g_sheets[i].name == line) { sh = static_cast<int>(i); break; }
        if (sh < 0) continue;

        auto& v = g_names[static_cast<std::size_t>(sh)];
        if (static_cast<std::size_t>(idx) >= v.size()) v.resize(static_cast<std::size_t>(idx) + 1);
        v[static_cast<std::size_t>(idx)] = t2;

        Ref r;
        r.sheet = sh;
        r.idx = idx;
        g_byName.emplace(std::string(t2), r);                          // 1er nom gagne
        g_byName[std::string(line) + "/" + t2] = r;                    // nom qualifié "planche/nom"
    }
    fclose(f);
}

} // namespace

void scan() {
    unloadAll();
    g_sheets.clear();
    g_names.clear();
    g_byName.clear();

    DIR* d = opendir("romfs:/gfx");
    if (!d) return;
    while (dirent* e = readdir(d)) {
        std::string fn = e->d_name;
        if (fn.size() <= 4 || fn.compare(fn.size() - 4, 4, ".t3x") != 0) continue;
        SheetInfo si;
        si.name = fn.substr(0, fn.size() - 4);
        si.path = "romfs:/gfx/" + fn;
        g_sheets.push_back(si);
    }
    closedir(d);

    std::sort(g_sheets.begin(), g_sheets.end(),
              [](const SheetInfo& a, const SheetInfo& b) { return a.name < b.name; });
    g_names.assign(g_sheets.size(), std::vector<std::string>());
    loadManifest();
}

int sheetCount() { return static_cast<int>(g_sheets.size()); }

const char* sheetName(int sheet) { return validSheet(sheet) ? g_sheets[static_cast<std::size_t>(sheet)].name.c_str() : ""; }

bool load(int sheet) {
    if (!validSheet(sheet)) return false;
    SheetInfo& s = g_sheets[static_cast<std::size_t>(sheet)];
    if (s.sheet) return true;
    s.sheet = C2D_SpriteSheetLoad(s.path.c_str());
    return s.sheet != nullptr;
}

void unload(int sheet) {
    if (!validSheet(sheet)) return;
    SheetInfo& s = g_sheets[static_cast<std::size_t>(sheet)];
    if (s.sheet) { C2D_SpriteSheetFree(s.sheet); s.sheet = nullptr; }
}

void unloadAll() {
    for (std::size_t i = 0; i < g_sheets.size(); ++i) unload(static_cast<int>(i));
}

int spriteCount(int sheet) {
    if (!validSheet(sheet)) return 0;
    const SheetInfo& s = g_sheets[static_cast<std::size_t>(sheet)];
    return s.sheet ? static_cast<int>(C2D_SpriteSheetCount(s.sheet)) : 0;
}

const char* spriteName(int sheet, int idx) {
    if (!validSheet(sheet) || idx < 0) return nullptr;
    const auto& v = g_names[static_cast<std::size_t>(sheet)];
    if (static_cast<std::size_t>(idx) >= v.size() || v[static_cast<std::size_t>(idx)].empty()) return nullptr;
    return v[static_cast<std::size_t>(idx)].c_str();
}

bool find(const char* name, int& sheet, int& idx) {
    if (!name) return false;
    auto it = g_byName.find(name);
    if (it == g_byName.end()) return false;
    sheet = it->second.sheet;
    idx = it->second.idx;
    return true;
}

bool size(int sheet, int idx, float& w, float& h) {
    if (!load(sheet)) return false;
    C2D_SpriteSheet sh = g_sheets[static_cast<std::size_t>(sheet)].sheet;
    if (idx < 0 || static_cast<std::size_t>(idx) >= C2D_SpriteSheetCount(sh)) return false;
    C2D_Image img = C2D_SpriteSheetGetImage(sh, static_cast<std::size_t>(idx));
    if (!img.subtex) return false;
    w = static_cast<float>(img.subtex->width);
    h = static_cast<float>(img.subtex->height);
    return true;
}

bool drawIndex(int sheet, int idx, float x, float y, float sx, float sy) {
    if (!load(sheet)) return false;
    C2D_SpriteSheet sh = g_sheets[static_cast<std::size_t>(sheet)].sheet;
    if (idx < 0 || static_cast<std::size_t>(idx) >= C2D_SpriteSheetCount(sh)) return false;
    C2D_Sprite spr;
    C2D_SpriteFromSheet(&spr, sh, static_cast<std::size_t>(idx));
    C2D_SpriteSetCenter(&spr, 0.0f, 0.0f);
    C2D_SpriteSetPos(&spr, x, y);
    C2D_SpriteSetScale(&spr, sx, sy);
    C2D_DrawSprite(&spr);
    return true;
}

bool draw(const char* name, float x, float y, float sx, float sy) {
    int sh = -1, idx = -1;
    if (!find(name, sh, idx)) return false;
    return drawIndex(sh, idx, x, y, sx, sy);
}

} // namespace sprites
} // namespace cheeseria
