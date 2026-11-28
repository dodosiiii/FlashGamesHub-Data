// main_3ds.cpp — Papa's Cheeseria 3DS
// Rendu Citro2D + gestion stylet/boutons
// Toutes les stations : TakeOrder, Cook, Build, Fry, Service
// Écrans : Menu, Station (5 sous-écrans), Pause, Result, Progress

#include "game.hpp"
#include "audio_3ds.hpp"
#include "progress_save.hpp"
#include "sprites.hpp"
#include "gallery.hpp"
#include "scene.hpp"

#include <3ds.h>
#include <citro2d.h>
#include <sys/stat.h>

#include <array>
#include <cstdio>
#include <cstring>

// ─── Constantes d'écran ──────────────────────────────────────────────────────
static constexpr int W_TOP  = 400;
static constexpr int H_SCR  = 240;
static constexpr int W_BOT  = 320;

// ─── Palettes couleurs ───────────────────────────────────────────────────────
static const u32 COL_BG_TOP    = C2D_Color32(0x1A, 0x1A, 0x2E, 0xFF);
static const u32 COL_BG_BOT    = C2D_Color32(0x16, 0x21, 0x3E, 0xFF);
static const u32 COL_WHITE     = C2D_Color32(0xFF, 0xFF, 0xFF, 0xFF);
static const u32 COL_YELLOW    = C2D_Color32(0xFF, 0xD7, 0x00, 0xFF);
static const u32 COL_GREEN     = C2D_Color32(0x00, 0xC8, 0x50, 0xFF);
static const u32 COL_RED       = C2D_Color32(0xFF, 0x38, 0x38, 0xFF);
static const u32 COL_ORANGE    = C2D_Color32(0xFF, 0x87, 0x00, 0xFF);
static const u32 COL_GREY      = C2D_Color32(0x88, 0x88, 0x88, 0xFF);
static const u32 COL_DARKBLUE  = C2D_Color32(0x0F, 0x3D, 0x66, 0xFF);
static const u32 COL_LTBLUE    = C2D_Color32(0x44, 0xAA, 0xFF, 0xFF);

// ─── Textures ────────────────────────────────────────────────────────────────
static C2D_SpriteSheet g_sheetIngr;
static C2D_SpriteSheet g_sheetUI;
static bool g_ingrLoaded = false;
static bool g_uiLoaded   = false;
static bool g_romfsOk    = false;
static bool g_openGallery = false;
static C2D_TextBuf g_textBuf = nullptr; // un seul buffer, vidé à chaque frame

// Sprites d'ingrédients (index dans l'atlas ingredients.t3x)
// Ordre défini par le .t3s : bread_white=0, bread_wheat=1, cheddar=2, mozzarella=3,
//   bread_sourdough=4, bread_rye=5, cheese_american=6, cheese_swiss=7, cheese_pepperjack=8,
//   top_bacon=9, top_ham=10, top_tomato=11, top_lettuce=12, top_chicken=13,
//   sauce_ranch=14, sauce_bbq=15, fries_regular=16, fries_curly=17, fries_sweet=18
enum IngrIdx : int {
    IDX_BREAD_WHITE=0, IDX_BREAD_WHEAT, IDX_CHEDDAR, IDX_MOZZARELLA,
    IDX_BREAD_SOURDOUGH, IDX_BREAD_RYE, IDX_CHEESE_AMERICAN, IDX_CHEESE_SWISS,
    IDX_CHEESE_PEPPERJACK, IDX_TOP_BACON, IDX_TOP_HAM, IDX_TOP_TOMATO,
    IDX_TOP_LETTUCE, IDX_TOP_CHICKEN, IDX_SAUCE_RANCH, IDX_SAUCE_BBQ,
    IDX_FRIES_REGULAR, IDX_FRIES_CURLY, IDX_FRIES_SWEET
};

// ─── Sauvegarde ─────────────────────────────────────────────────────────────
static const char* kSavePath = "sdmc:/3ds/CheeseShop3DS/progress.dat";

static void ensureSaveDir() {
    // mkdir() POSIX de newlib — ignore si les dossiers existent déjà
    mkdir("/3ds", 0777);
    mkdir("/3ds/CheeseShop3DS", 0777);
}

static void saveProgress(const cheeseria::Game& game) {
    std::array<std::uint8_t, cheeseria::kProgressSaveSize> buf{};
    cheeseria::SavedProgress sp{game.ordersCompleted(), game.totalScore()};
    if (!cheeseria::encodeProgress(sp, buf)) return;
    ensureSaveDir();
    FILE* f = fopen(kSavePath, "wb");
    if (!f) return;
    fwrite(buf.data(), 1, buf.size(), f);
    fclose(f);
}

static bool loadProgress(cheeseria::Game& game) {
    FILE* f = fopen(kSavePath, "rb");
    if (!f) return false;
    std::array<std::uint8_t, cheeseria::kProgressSaveSize> buf{};
    bool ok = (fread(buf.data(), 1, buf.size(), f) == buf.size());
    fclose(f);
    if (!ok) return false;
    cheeseria::SavedProgress sp{};
    if (!cheeseria::decodeProgress(buf.data(), buf.size(), sp)) return false;
    return game.restoreProgress(sp.ordersCompleted, sp.totalScore);
}

// ─── Utilitaires dessin ──────────────────────────────────────────────────────

static void drawText(float x, float y, float sz, u32 col, const char* txt) {
    if (!g_textBuf) return;
    C2D_Text t;
    C2D_TextParse(&t, g_textBuf, txt);
    C2D_TextOptimize(&t);
    C2D_DrawText(&t, C2D_WithColor, x, y, 0.5f, sz, sz, col);
}

static void drawRect(float x, float y, float w, float h, u32 col) {
    C2D_DrawRectSolid(x, y, 0.0f, w, h, col);
}

// Fond d'écran : couleur de secours + sprites réels de l'écran courant (layout/screens.tsv)
static const char* g_screenKey = "menu";
static int         g_layoutOps = 0;
static void drawBg(bool top, u32 col) {
    C2D_DrawRectSolid(0, 0, 0.0f, top ? W_TOP : W_BOT, H_SCR, col);
    cheeseria::scene::drawLayer(g_screenKey, top);
}

static const char* screenKey(const cheeseria::Game& g) {
    using cheeseria::Screen; using cheeseria::Station;
    switch (g.screen()) {
        case Screen::Menu:     return "menu";
        case Screen::Pause:    return "pause";
        case Screen::Progress: return "progress";
        case Screen::Result:   return g.result() == cheeseria::Validation::Correct ? "result_ok" : "result_bad";
        case Screen::Station:
            switch (g.station()) {
                case Station::TakeOrder: return "order";
                case Station::Cook:      return "cook";
                case Station::Build:     return "build";
                case Station::Fry:       return "fry";
                case Station::Service:   return "service";
            }
    }
    return "menu";
}

static void drawButton(float x, float y, float w, float h, u32 bgCol, u32 txtCol, float txtSz, const char* label) {
    drawRect(x, y, w, h, bgCol);
    // Centre le texte dans le bouton (approximation)
    float tx = x + 4.0f;
    float ty = y + (h - txtSz * 16.0f) * 0.5f;
    drawText(tx, ty, txtSz, txtCol, label);
}

// Dessine un sprite depuis l'atlas
static void drawSprite(C2D_SpriteSheet sheet, int idx, float x, float y, float scaleX, float scaleY) {
    if (!sheet || idx < 0 || static_cast<std::size_t>(idx) >= C2D_SpriteSheetCount(sheet)) return;
    C2D_Sprite spr;
    C2D_SpriteFromSheet(&spr, sheet, static_cast<std::size_t>(idx));
    C2D_SpriteSetCenter(&spr, 0.0f, 0.0f);
    C2D_SpriteSetPos(&spr, x, y);
    C2D_SpriteSetScale(&spr, scaleX, scaleY);
    C2D_DrawSprite(&spr);
}

// ─── Vérification du toucher ─────────────────────────────────────────────────

static bool touchInRect(touchPosition tp, float x, float y, float w, float h) {
    return tp.px >= x && tp.px <= x + w && tp.py >= y && tp.py <= y + h;
}

// ─── Rendu Menu ──────────────────────────────────────────────────────────────

static void renderMenuTop(const cheeseria::Game& game) {
    drawBg(true, COL_BG_TOP);
    // Logo / titre
    drawText(60, 20, 1.0f, COL_YELLOW, "Papa's Cheeseria 3DS");
    drawText(80, 55, 0.6f, COL_WHITE,  "Port homebrew non officiel");
    // Stats
    char buf[64];
    snprintf(buf, sizeof(buf), "Commandes terminees : %u", game.ordersCompleted());
    drawText(60, 100, 0.55f, COL_LTBLUE, buf);
    snprintf(buf, sizeof(buf), "Score total         : %u", game.totalScore());
    drawText(60, 120, 0.55f, COL_LTBLUE, buf);
    drawText(80, 180, 0.5f, COL_GREY,
             "Ecran du bas : Jouer | Dpad : nav.");
    snprintf(buf, sizeof(buf), "romfs:%s planches:%d layout:%d ingr:%s ui:%s",
             g_romfsOk ? "OK" : "KO", cheeseria::sprites::sheetCount(), g_layoutOps,
             g_ingrLoaded ? "OK" : "KO", g_uiLoaded ? "OK" : "KO");
    drawText(10, 215, 0.4f, COL_GREY, buf);
}

static void renderMenuBot(const cheeseria::Game&) {
    drawBg(false, COL_BG_BOT);
    drawButton(60, 80, 200, 50, COL_ORANGE, COL_WHITE, 0.7f, "  Nouvelle commande");
    drawButton(60, 145, 200, 40, COL_DARKBLUE, COL_WHITE, 0.6f, "  Galerie sprites");
    drawText(60, 200, 0.5f, COL_GREY, "A : jouer  |  Y : galerie");
}

// ─── Rendu Prise de commande ─────────────────────────────────────────────────

static void renderOrderTop(const cheeseria::Game& game) {
    drawBg(true, C2D_Color32(0x1C, 0x35, 0x5E, 0xFF));
    drawText(10, 5, 0.65f, COL_YELLOW, "--- TICKET CLIENT ---");

    const cheeseria::Ticket& t = game.ticket();
    // Pain
    const char* breadName = (t.bread == cheeseria::Bread::White) ? "Pain Blanc" : "Pain Complet";
    char line[80];
    snprintf(line, sizeof(line), "Pain   : %s", breadName);
    drawText(20, 40, 0.6f, COL_WHITE, line);
    // Fromage
    const char* cheeseName = (t.cheese == cheeseria::Cheese::Cheddar) ? "Cheddar" : "Mozzarella";
    snprintf(line, sizeof(line), "Fromage: %s", cheeseName);
    drawText(20, 65, 0.6f, COL_WHITE, line);
    // Cuisson
    const char* cookName = "Medium";
    if (t.cook == cheeseria::CookLevel::Light) cookName = "Leger";
    if (t.cook == cheeseria::CookLevel::Well)  cookName = "Bien cuit";
    snprintf(line, sizeof(line), "Cuisson: %s", cookName);
    drawText(20, 90, 0.6f, COL_WHITE, line);
    // Frites
    const char* friesName = (t.fries == cheeseria::Fries::Regular) ? "Normales" : "Patate douce";
    snprintf(line, sizeof(line), "Frites : %s", friesName);
    drawText(20, 115, 0.6f, COL_WHITE, line);

    drawText(20, 170, 0.5f, COL_GREY, "Bas : Accepter la commande");
}

static void renderOrderBot(const cheeseria::Game&) {
    drawBg(false, COL_BG_BOT);
    drawText(10, 10, 0.6f, COL_YELLOW, "Prise de commande");
    drawButton(40, 70, 240, 50, COL_GREEN, COL_WHITE, 0.65f, "   Accepter la commande");
    drawButton(40, 140, 240, 40, COL_RED, COL_WHITE, 0.6f, "    Annuler");
}

// ─── Rendu Cuisson ───────────────────────────────────────────────────────────

static void renderCookTop(const cheeseria::Game& game) {
    drawBg(true, C2D_Color32(0x3B, 0x1A, 0x05, 0xFF));
    drawText(10, 5, 0.7f, COL_ORANGE, "STATION : GRILL");
    drawText(10, 35, 0.55f, COL_WHITE, "Choisir le niveau de cuisson :");

    const char* cookName = "?";
    if (game.selectedCook() == cheeseria::CookLevel::Light)  cookName = "Leger";
    if (game.selectedCook() == cheeseria::CookLevel::Medium) cookName = "Medium";
    if (game.selectedCook() == cheeseria::CookLevel::Well)   cookName = "Bien cuit";

    char buf[64];
    snprintf(buf, sizeof(buf), "Selection : %s", cookName);
    drawText(10, 160, 0.6f, COL_YELLOW, buf);
}

static void renderCookBot(const cheeseria::Game& game) {
    drawBg(false, COL_BG_BOT);
    drawText(10, 5, 0.6f, COL_ORANGE, "Cuisson");

    u32 cLight  = (game.selectedCook() == cheeseria::CookLevel::Light)  ? COL_YELLOW : COL_DARKBLUE;
    u32 cMedium = (game.selectedCook() == cheeseria::CookLevel::Medium) ? COL_YELLOW : COL_DARKBLUE;
    u32 cWell   = (game.selectedCook() == cheeseria::CookLevel::Well)   ? COL_YELLOW : COL_DARKBLUE;

    drawButton(10, 40, 90, 50, cLight,  COL_WHITE, 0.52f, " Leger");
    drawButton(115, 40, 90, 50, cMedium, COL_WHITE, 0.52f, "Medium");
    drawButton(220, 40, 90, 50, cWell,  COL_WHITE, 0.52f, "B.Cuit");

    bool canFinish = game.selectedCook() != cheeseria::CookLevel::NotSelected;
    drawButton(60, 120, 200, 50, canFinish ? COL_GREEN : COL_GREY, COL_WHITE, 0.6f, "   Terminer cuisson");
}

// ─── Rendu Assemblage ────────────────────────────────────────────────────────

static void renderBuildTop(const cheeseria::Game& game) {
    drawBg(true, C2D_Color32(0x1A, 0x3B, 0x1A, 0xFF));
    drawText(10, 5, 0.7f, COL_GREEN, "STATION : ASSEMBLAGE");

    if (g_ingrLoaded) {
        // Pain gauche, fromage droite
        int breadIdx = (game.selectedBread() == cheeseria::Bread::White) ? IDX_BREAD_WHITE : IDX_BREAD_WHEAT;
        if (game.selectedBread() != cheeseria::Bread::NotSelected)
            drawSprite(g_sheetIngr, breadIdx, 20, 60, 0.9f, 0.9f);

        int cheeseIdx = (game.selectedCheese() == cheeseria::Cheese::Cheddar) ? IDX_CHEDDAR : IDX_MOZZARELLA;
        if (game.selectedCheese() != cheeseria::Cheese::NotSelected)
            drawSprite(g_sheetIngr, cheeseIdx, 220, 60, 0.9f, 0.9f);
    }

    char buf[80];
    const char* bname = (game.selectedBread() == cheeseria::Bread::White) ? "Blanc" :
                        (game.selectedBread() == cheeseria::Bread::Wholegrain) ? "Complet" : "?";
    const char* cname = (game.selectedCheese() == cheeseria::Cheese::Cheddar) ? "Cheddar" :
                        (game.selectedCheese() == cheeseria::Cheese::Mozzarella) ? "Mozza" : "?";
    snprintf(buf, sizeof(buf), "Pain: %s  |  Fromage: %s", bname, cname);
    drawText(10, 190, 0.5f, COL_WHITE, buf);
}

static void renderBuildBot(const cheeseria::Game& game) {
    drawBg(false, COL_BG_BOT);
    drawText(10, 5, 0.6f, COL_GREEN, "Assemblage");

    u32 cW = (game.selectedBread() == cheeseria::Bread::White)      ? COL_YELLOW : COL_DARKBLUE;
    u32 cG = (game.selectedBread() == cheeseria::Bread::Wholegrain) ? COL_YELLOW : COL_DARKBLUE;
    drawButton(10, 30, 140, 40, cW, COL_WHITE, 0.52f, " Pain Blanc");
    drawButton(165, 30, 145, 40, cG, COL_WHITE, 0.52f, " Pain Complet");

    u32 cC = (game.selectedCheese() == cheeseria::Cheese::Cheddar)     ? COL_YELLOW : COL_DARKBLUE;
    u32 cM = (game.selectedCheese() == cheeseria::Cheese::Mozzarella)  ? COL_YELLOW : COL_DARKBLUE;
    drawButton(10, 85, 140, 40, cC, COL_WHITE, 0.52f, " Cheddar");
    drawButton(165, 85, 145, 40, cM, COL_WHITE, 0.52f, " Mozzarella");

    bool canFinish = game.selectedBread() != cheeseria::Bread::NotSelected &&
                     game.selectedCheese() != cheeseria::Cheese::NotSelected;
    drawButton(60, 150, 200, 50, canFinish ? COL_GREEN : COL_GREY, COL_WHITE, 0.6f, "   Terminer sandwich");
}

// ─── Rendu Frites ────────────────────────────────────────────────────────────

static void renderFryTop(const cheeseria::Game& game) {
    drawBg(true, C2D_Color32(0x3B, 0x30, 0x05, 0xFF));
    drawText(10, 5, 0.7f, COL_YELLOW, "STATION : FRITES");

    if (g_ingrLoaded && game.selectedFries() != cheeseria::Fries::NotSelected) {
        int friesIdx = (game.selectedFries() == cheeseria::Fries::Regular) ? IDX_FRIES_REGULAR : IDX_FRIES_SWEET;
        drawSprite(g_sheetIngr, friesIdx, 160, 60, 1.0f, 1.0f);
    }

    const char* friesName = "?";
    if (game.selectedFries() == cheeseria::Fries::Regular)      friesName = "Normales";
    if (game.selectedFries() == cheeseria::Fries::SweetPotato)  friesName = "Patate douce";
    char buf[64];
    snprintf(buf, sizeof(buf), "Selection : %s", friesName);
    drawText(10, 190, 0.55f, COL_WHITE, buf);
}

static void renderFryBot(const cheeseria::Game& game) {
    drawBg(false, COL_BG_BOT);
    drawText(10, 5, 0.6f, COL_YELLOW, "Frites");

    u32 cR = (game.selectedFries() == cheeseria::Fries::Regular)     ? COL_YELLOW : COL_DARKBLUE;
    u32 cS = (game.selectedFries() == cheeseria::Fries::SweetPotato) ? COL_YELLOW : COL_DARKBLUE;
    drawButton(10, 60, 140, 50, cR, COL_WHITE, 0.55f, " Normales");
    drawButton(165, 60, 145, 50, cS, COL_WHITE, 0.55f, " Patate douce");

    bool canFinish = game.selectedFries() != cheeseria::Fries::NotSelected;
    drawButton(60, 150, 200, 50, canFinish ? COL_GREEN : COL_GREY, COL_WHITE, 0.6f, "   Envoyer les frites");
}

// ─── Rendu Service ───────────────────────────────────────────────────────────

static void renderServiceTop(const cheeseria::Game&) {
    drawBg(true, C2D_Color32(0x1A, 0x26, 0x3B, 0xFF));
    drawText(30, 50, 0.75f, COL_WHITE, "Le plateau est pret !");
    drawText(50, 100, 0.6f, COL_LTBLUE, "Servez le client maintenant.");
}

static void renderServiceBot(const cheeseria::Game&) {
    drawBg(false, COL_BG_BOT);
    drawText(10, 10, 0.6f, COL_WHITE, "Service");
    drawButton(60, 80, 200, 60, COL_ORANGE, COL_WHITE, 0.65f, "   Servir le client");
}

// ─── Rendu Résultat ──────────────────────────────────────────────────────────

static void renderResultTop(const cheeseria::Game& game) {
    u32 bgCol = (game.result() == cheeseria::Validation::Correct) ?
        C2D_Color32(0x05, 0x3B, 0x0A, 0xFF) : C2D_Color32(0x3B, 0x05, 0x05, 0xFF);
    drawBg(true, bgCol);

    if (game.result() == cheeseria::Validation::Correct) {
        drawText(70, 40, 0.9f, COL_GREEN, "PARFAIT !");
        drawText(80, 90, 0.6f, COL_WHITE, "Le client est ravi !");
    } else {
        drawText(70, 40, 0.9f, COL_RED, "RATÉ !");
        drawText(60, 90, 0.6f, COL_WHITE, "Verifiez votre commande...");
    }
    char buf[64];
    snprintf(buf, sizeof(buf), "Score : +%u pts", game.score());
    drawText(100, 140, 0.7f, COL_YELLOW, buf);
}

static void renderResultBot(const cheeseria::Game&) {
    drawBg(false, COL_BG_BOT);
    drawButton(60, 90, 200, 60, COL_LTBLUE, COL_WHITE, 0.65f, "   Voir la progression");
}

// ─── Rendu Progression ───────────────────────────────────────────────────────

static void renderProgressTop(const cheeseria::Game& game) {
    drawBg(true, COL_BG_TOP);
    drawText(60, 20, 0.75f, COL_YELLOW, "Progression de la journee");
    char buf[64];
    snprintf(buf, sizeof(buf), "Commandes servies : %u", game.ordersCompleted());
    drawText(60, 80, 0.6f, COL_WHITE, buf);
    snprintf(buf, sizeof(buf), "Score cumulatif   : %u pts", game.totalScore());
    drawText(60, 110, 0.6f, COL_WHITE, buf);
}

static void renderProgressBot(const cheeseria::Game&) {
    drawBg(false, COL_BG_BOT);
    drawButton(60, 90, 200, 60, COL_GREEN, COL_WHITE, 0.65f, "   Continuer");
}

// ─── Rendu Pause ─────────────────────────────────────────────────────────────

static void renderPauseTop(const cheeseria::Game&) {
    drawBg(true, C2D_Color32(0x10, 0x10, 0x10, 0xCC));
    drawText(130, 80, 0.8f, COL_WHITE, "PAUSE");
    drawText(100, 130, 0.5f, COL_GREY, "START pour reprendre");
}

static void renderPauseBot(const cheeseria::Game&) {
    drawBg(false, C2D_Color32(0x10, 0x10, 0x10, 0xCC));
    drawButton(60, 60, 200, 50, COL_GREEN, COL_WHITE, 0.65f, "   Reprendre");
    drawButton(60, 130, 200, 50, COL_RED,  COL_WHITE, 0.65f, "   Quitter la commande");
}

// ─── Gestion du toucher par écran/station ────────────────────────────────────

static void handleMenuTouch(cheeseria::Game& game, touchPosition tp) {
    // Bouton "Nouvelle commande" [60,80,200,50]
    if (touchInRect(tp, 60, 80, 200, 50)) {
        game.startOrder();
    }
    // Bouton "Galerie sprites" [60,145,200,40]
    if (touchInRect(tp, 60, 145, 200, 40)) g_openGallery = true;
}

static void handleOrderTouch(cheeseria::Game& game, touchPosition tp) {
    // Accepter [40,70,240,50]
    if (touchInRect(tp, 40, 70, 240, 50)) game.acceptOrder();
    // Annuler [40,140,240,40]
    if (touchInRect(tp, 40, 140, 240, 40)) game.cancelOrder();
}

static void handleCookTouch(cheeseria::Game& game, touchPosition tp) {
    if (touchInRect(tp, 10,  40, 90, 50)) game.chooseCook(cheeseria::CookLevel::Light);
    if (touchInRect(tp, 115, 40, 90, 50)) game.chooseCook(cheeseria::CookLevel::Medium);
    if (touchInRect(tp, 220, 40, 90, 50)) game.chooseCook(cheeseria::CookLevel::Well);
    if (touchInRect(tp, 60, 120, 200, 50)) game.finishCook();
}

static void handleBuildTouch(cheeseria::Game& game, touchPosition tp) {
    if (touchInRect(tp, 10,  30, 140, 40)) game.chooseBread(cheeseria::Bread::White);
    if (touchInRect(tp, 165, 30, 145, 40)) game.chooseBread(cheeseria::Bread::Wholegrain);
    if (touchInRect(tp, 10,  85, 140, 40)) game.chooseCheese(cheeseria::Cheese::Cheddar);
    if (touchInRect(tp, 165, 85, 145, 40)) game.chooseCheese(cheeseria::Cheese::Mozzarella);
    if (touchInRect(tp, 60, 150, 200, 50)) game.finishBuild();
}

static void handleFryTouch(cheeseria::Game& game, touchPosition tp) {
    if (touchInRect(tp, 10,  60, 140, 50)) game.chooseFries(cheeseria::Fries::Regular);
    if (touchInRect(tp, 165, 60, 145, 50)) game.chooseFries(cheeseria::Fries::SweetPotato);
    if (touchInRect(tp, 60, 150, 200, 50)) game.finishFry();
}

static void handleServiceTouch(cheeseria::Game& game, touchPosition tp, bool& needSave) {
    if (touchInRect(tp, 60, 80, 200, 60)) {
        game.serveOrder();
        cheeseria::playServeSound();
        needSave = true;
    }
}

static void handleResultTouch(cheeseria::Game& game, touchPosition tp) {
    if (touchInRect(tp, 60, 90, 200, 60)) game.acknowledgeResult();
}

static void handleProgressTouch(cheeseria::Game& game, touchPosition tp) {
    if (touchInRect(tp, 60, 90, 200, 60)) game.continueFromProgress();
}

static void handlePauseTouch(cheeseria::Game& game, touchPosition tp) {
    if (touchInRect(tp, 60,  60, 200, 50)) game.resume();
    if (touchInRect(tp, 60, 130, 200, 50)) game.cancelOrder();
}

// ─── Boucle principale ───────────────────────────────────────────────────────

int main() {
    // Init 3DS
    gfxInitDefault();
    g_romfsOk = R_SUCCEEDED(romfsInit()); // indispensable pour lire "romfs:/..."
    C3D_Init(C3D_DEFAULT_CMDBUF_SIZE);
    C2D_Init(C2D_DEFAULT_MAX_OBJECTS);
    C2D_Prepare();
    g_textBuf = C2D_TextBufNew(4096);
    // PAS de consoleInit(GFX_BOTTOM) : il entre en conflit avec la cible citro2d du bas

    // Cibles de rendu
    C3D_RenderTarget* topLeft  = C2D_CreateScreenTarget(GFX_TOP, GFX_LEFT);
    C3D_RenderTarget* bottom   = C2D_CreateScreenTarget(GFX_BOTTOM, GFX_LEFT);

    // Audio
    bool audioOk = cheeseria::initializeAudio();
    (void)audioOk;

    // Chargement des textures
    g_sheetIngr = C2D_SpriteSheetLoad("romfs:/gfx/ingredients.t3x");
    g_ingrLoaded = (g_sheetIngr != nullptr);
    g_sheetUI   = C2D_SpriteSheetLoad("romfs:/gfx/ui.t3x");
    g_uiLoaded  = (g_sheetUI != nullptr);
    cheeseria::sprites::scan(); // liste toutes les planches romfs:/gfx/*.t3x (+ manifest.tsv)
    g_layoutOps = cheeseria::scene::init(); // romfs:/layout/screens.tsv (vrais sprites)

    // État du jeu
    cheeseria::Game game;
    bool saveDirty = false;

    // Chargement de la sauvegarde
    loadProgress(game);

    while (aptMainLoop()) {
        hidScanInput();
        u32 kDown = hidKeysDown();
        touchPosition tp;
        hidTouchRead(&tp);

        bool touched = (kDown & KEY_TOUCH) != 0;
        bool btnA    = (kDown & KEY_A) != 0;
        bool btnB    = (kDown & KEY_B) != 0;
        bool btnStart= (kDown & KEY_START) != 0;

        // Quitter avec SELECT
        if (kDown & KEY_SELECT) break;

        // Galerie des sprites : prend le contrôle de l'entrée et du rendu
        if (cheeseria::galleryActive()) {
            cheeseria::galleryFrame(kDown, tp, touched, topLeft, bottom, g_textBuf);
            continue;
        }

        cheeseria::Screen sc = game.screen();
        cheeseria::Station st = game.station();

        // ── Gestion Pause ──
        if (sc == cheeseria::Screen::Station && btnStart) {
            game.pause();
        } else if (sc == cheeseria::Screen::Pause) {
            if (btnStart || btnB) game.resume();
            if (touched) handlePauseTouch(game, tp);
        }
        // ── Menu ──
        else if (sc == cheeseria::Screen::Menu) {
            if (kDown & KEY_Y) g_openGallery = true;
            if (btnA || touched) {
                if (touched) handleMenuTouch(game, tp);
                else game.startOrder();
            }
        }
        // ── Station ──
        else if (sc == cheeseria::Screen::Station) {
            if (st == cheeseria::Station::TakeOrder) {
                if (btnA) game.acceptOrder();
                if (btnB) game.cancelOrder();
                if (touched) handleOrderTouch(game, tp);
            } else if (st == cheeseria::Station::Cook) {
                if (touched) handleCookTouch(game, tp);
            } else if (st == cheeseria::Station::Build) {
                if (touched) handleBuildTouch(game, tp);
            } else if (st == cheeseria::Station::Fry) {
                if (touched) handleFryTouch(game, tp);
            } else if (st == cheeseria::Station::Service) {
                if (btnA || touched) {
                    if (touched) handleServiceTouch(game, tp, saveDirty);
                    else { game.serveOrder(); cheeseria::playServeSound(); saveDirty = true; }
                }
            }
        }
        // ── Résultat ──
        else if (sc == cheeseria::Screen::Result) {
            if (saveDirty) { saveProgress(game); saveDirty = false; }
            if (btnA || touched) {
                if (touched) handleResultTouch(game, tp);
                else game.acknowledgeResult();
            }
        }
        // ── Progression ──
        else if (sc == cheeseria::Screen::Progress) {
            if (btnA || touched) {
                if (touched) handleProgressTouch(game, tp);
                else game.continueFromProgress();
            }
        }

        if (g_openGallery) { g_openGallery = false; cheeseria::galleryOpen(); }

        // ── Rendu ──
        C3D_FrameBegin(C3D_FRAME_SYNCDRAW);
        C2D_TextBufClear(g_textBuf);

        g_screenKey = screenKey(game);
        cheeseria::scene::setScreen(g_screenKey);

        // Écran du haut
        C2D_TargetClear(topLeft, C2D_Color32(0, 0, 0, 255));
        C2D_SceneBegin(topLeft);
        sc = game.screen();
        st = game.station();
        if (sc == cheeseria::Screen::Menu)      renderMenuTop(game);
        else if (sc == cheeseria::Screen::Pause) renderPauseTop(game);
        else if (sc == cheeseria::Screen::Result) renderResultTop(game);
        else if (sc == cheeseria::Screen::Progress) renderProgressTop(game);
        else if (sc == cheeseria::Screen::Station) {
            if (st == cheeseria::Station::TakeOrder) renderOrderTop(game);
            else if (st == cheeseria::Station::Cook)  renderCookTop(game);
            else if (st == cheeseria::Station::Build) renderBuildTop(game);
            else if (st == cheeseria::Station::Fry)   renderFryTop(game);
            else if (st == cheeseria::Station::Service) renderServiceTop(game);
        }

        // Écran du bas
        C2D_TargetClear(bottom, C2D_Color32(0, 0, 0, 255));
        C2D_SceneBegin(bottom);
        if (sc == cheeseria::Screen::Menu)       renderMenuBot(game);
        else if (sc == cheeseria::Screen::Pause)  renderPauseBot(game);
        else if (sc == cheeseria::Screen::Result)  renderResultBot(game);
        else if (sc == cheeseria::Screen::Progress) renderProgressBot(game);
        else if (sc == cheeseria::Screen::Station) {
            if (st == cheeseria::Station::TakeOrder) renderOrderBot(game);
            else if (st == cheeseria::Station::Cook)  renderCookBot(game);
            else if (st == cheeseria::Station::Build) renderBuildBot(game);
            else if (st == cheeseria::Station::Fry)   renderFryBot(game);
            else if (st == cheeseria::Station::Service) renderServiceBot(game);
        }

        C3D_FrameEnd(0);
    }

    // Nettoyage
    cheeseria::shutdownAudio();
    if (g_ingrLoaded) C2D_SpriteSheetFree(g_sheetIngr);
    if (g_uiLoaded)   C2D_SpriteSheetFree(g_sheetUI);
    cheeseria::sprites::unloadAll();
    if (g_textBuf) C2D_TextBufDelete(g_textBuf);
    C2D_Fini();
    C3D_Fini();
    if (g_romfsOk) romfsExit();
    gfxExit();
    return 0;
}
