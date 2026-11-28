// scene.cpp — Papa's Cheeseria 3DS : affichage des sprites réels pilotés par layout/screens.tsv
#include "scene.hpp"
#include "layout_parse.hpp"
#include "sprites.hpp"

#include <cstdio>
#include <set>
#include <string>
#include <vector>

namespace cheeseria {
namespace scene {

namespace {
std::vector<LayoutOp> g_ops;
std::string           g_current;
}

int init() {
    g_ops.clear();
    g_current.clear();
    FILE* f = std::fopen("romfs:/layout/screens.tsv", "r");
    if (!f) return 0;
    char line[512];
    while (std::fgets(line, sizeof(line), f)) {
        LayoutOp op;
        if (parseLayoutLine(line, op)) g_ops.push_back(op);
    }
    std::fclose(f);
    return static_cast<int>(g_ops.size());
}

int opCount() { return static_cast<int>(g_ops.size()); }

void setScreen(const char* key) {
    if (!key || g_current == key) return;
    g_current = key;
    // Planches nécessaires à cet écran
    std::set<int> need;
    for (const LayoutOp& op : g_ops) {
        if (op.screen != g_current) continue;
        int sh = -1, idx = -1;
        if (sprites::find(op.sprite.c_str(), sh, idx)) need.insert(sh);
    }
    // Décharge tout le reste (une scène à la fois en RAM)
    for (int s = 0; s < sprites::sheetCount(); ++s)
        if (!need.count(s)) sprites::unload(s);
}

int drawLayer(const char* key, bool top) {
    if (!key) return 0;
    int n = 0;
    for (const LayoutOp& op : g_ops) {
        if (op.top != top || op.screen != key) continue;
        if (sprites::draw(op.sprite.c_str(), op.x, op.y, op.sx, op.sy)) ++n;
    }
    return n;
}

} // namespace scene
} // namespace cheeseria
