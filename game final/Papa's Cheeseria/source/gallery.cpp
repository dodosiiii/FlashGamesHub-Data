// gallery.cpp — Papa's Cheeseria 3DS
#include "gallery.hpp"
#include "sprites.hpp"

#include <algorithm>
#include <cstdio>

namespace cheeseria {

namespace {

bool g_active = false;
int  g_sheet  = 0;
int  g_idx    = 0;
C2D_TextBuf g_tb = nullptr;

bool hit(touchPosition tp, float x, float y, float w, float h) {
    return tp.px >= x && tp.px <= x + w && tp.py >= y && tp.py <= y + h;
}

void text(float x, float y, float sz, u32 col, const char* s) {
    if (!g_tb) return;
    C2D_Text t;
    C2D_TextParse(&t, g_tb, s);
    C2D_TextOptimize(&t);
    C2D_DrawText(&t, C2D_WithColor, x, y, 0.5f, sz, sz, col);
}

void button(float x, float y, float w, float h, u32 bg, u32 fg, const char* label) {
    C2D_DrawRectSolid(x, y, 0.0f, w, h, bg);
    text(x + 6.0f, y + (h - 14.0f) * 0.5f, 0.5f, fg, label);
}

int wrap(int v, int n) { return n <= 0 ? 0 : ((v % n) + n) % n; }

void selectSheet(int s) {
    int n = sprites::sheetCount();
    if (n <= 0) { g_sheet = 0; g_idx = 0; return; }
    int ns = wrap(s, n);
    if (ns != g_sheet) sprites::unloadAll(); // une seule planche en mémoire à la fois
    g_sheet = ns;
    g_idx = 0;
    sprites::load(g_sheet);
}

void moveIdx(int d) {
    int c = sprites::spriteCount(g_sheet);
    g_idx = wrap(g_idx + d, c);
}

} // namespace

bool galleryActive() { return g_active; }

void galleryOpen() {
    g_active = true;
    g_sheet = -1;           // force le chargement de la planche 0
    selectSheet(0);
}

void galleryFrame(u32 kDown, touchPosition tp, bool touched,
                  C3D_RenderTarget* top, C3D_RenderTarget* bottom, C2D_TextBuf tb) {
    g_tb = tb;

    // ── Entrées ──
    if (kDown & KEY_B) {
        g_active = false;
        sprites::unloadAll();
        return;
    }
    if (kDown & KEY_DRIGHT) moveIdx(+1);
    if (kDown & KEY_DLEFT)  moveIdx(-1);
    if (kDown & KEY_DUP)    moveIdx(+10);
    if (kDown & KEY_DDOWN)  moveIdx(-10);
    if (kDown & KEY_R)      selectSheet(g_sheet + 1);
    if (kDown & KEY_L)      selectSheet(g_sheet - 1);
    if (touched) {
        if (hit(tp, 10, 20, 70, 40))  moveIdx(-10);
        if (hit(tp, 90, 20, 70, 40))  moveIdx(-1);
        if (hit(tp, 165, 20, 70, 40)) moveIdx(+1);
        if (hit(tp, 245, 20, 65, 40)) moveIdx(+10);
        if (hit(tp, 10, 80, 145, 40)) selectSheet(g_sheet - 1);
        if (hit(tp, 165, 80, 145, 40)) selectSheet(g_sheet + 1);
        if (hit(tp, 60, 150, 200, 40)) {
            g_active = false;
            sprites::unloadAll();
            return;
        }
    }

    const u32 colBlack = C2D_Color32(0, 0, 0, 255);
    const u32 colBgTop = C2D_Color32(0x28, 0x28, 0x30, 255);
    const u32 colBgBot = C2D_Color32(0x16, 0x21, 0x3E, 255);
    const u32 colArea  = C2D_Color32(0x55, 0x55, 0x60, 255);
    const u32 colWhite = C2D_Color32(255, 255, 255, 255);
    const u32 colBlue  = C2D_Color32(0x0F, 0x3D, 0x66, 255);
    const u32 colRed   = C2D_Color32(0xFF, 0x38, 0x38, 255);
    const u32 colGrey  = C2D_Color32(0x99, 0x99, 0x99, 255);

    const int nSheets = sprites::sheetCount();
    const int count   = sprites::spriteCount(g_sheet);
    char buf[160];

    C3D_FrameBegin(C3D_FRAME_SYNCDRAW);
    C2D_TextBufClear(tb);

    // ── Écran du haut : le sprite ──
    C2D_TargetClear(top, colBlack);
    C2D_SceneBegin(top);
    C2D_DrawRectSolid(0, 0, 0.0f, 400, 240, colBgTop);

    if (nSheets <= 0) {
        text(20, 100, 0.55f, colWhite, "Aucune planche dans romfs:/gfx/*.t3x");
    } else {
        snprintf(buf, sizeof(buf), "Planche %d/%d : %s", g_sheet + 1, nSheets, sprites::sheetName(g_sheet));
        text(6, 2, 0.45f, colWhite, buf);

        const char* nm = sprites::spriteName(g_sheet, g_idx);
        float w = 0, h = 0;
        bool haveSize = count > 0 && sprites::size(g_sheet, g_idx, w, h);
        snprintf(buf, sizeof(buf), "Sprite %d/%d  %s  %dx%d", count > 0 ? g_idx + 1 : 0, count,
                 nm ? nm : "(sans nom)", static_cast<int>(w), static_cast<int>(h));
        text(6, 18, 0.45f, colGrey, buf);

        C2D_DrawRectSolid(10, 38, 0.0f, 380, 196, colArea);
        if (haveSize && w > 0 && h > 0) {
            float s = std::min(376.0f / w, 192.0f / h);
            if (s > 2.0f) s = 2.0f;
            float x = 10.0f + (380.0f - w * s) * 0.5f;
            float y = 38.0f + (196.0f - h * s) * 0.5f;
            sprites::drawIndex(g_sheet, g_idx, x, y, s, s);
        } else {
            text(20, 120, 0.5f, colWhite, "Planche vide ou memoire insuffisante");
        }
    }

    // ── Écran du bas : commandes ──
    C2D_TargetClear(bottom, colBlack);
    C2D_SceneBegin(bottom);
    C2D_DrawRectSolid(0, 0, 0.0f, 320, 240, colBgBot);
    text(10, 2, 0.5f, colWhite, "Galerie des sprites exportes");
    button(10, 20, 70, 40, colBlue, colWhite, "  -10");
    button(90, 20, 70, 40, colBlue, colWhite, "  -1");
    button(165, 20, 70, 40, colBlue, colWhite, "  +1");
    button(245, 20, 65, 40, colBlue, colWhite, "  +10");
    button(10, 80, 145, 40, colBlue, colWhite, "< Planche");
    button(165, 80, 145, 40, colBlue, colWhite, "Planche >");
    button(60, 150, 200, 40, colRed, colWhite, "      Retour (B)");
    text(10, 205, 0.4f, colGrey, "Dpad G/D : +-1 | Haut/Bas : +-10 | L/R : planche");

    C3D_FrameEnd(0);
}

} // namespace cheeseria
