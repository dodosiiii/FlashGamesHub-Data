#include <3ds.h>
#include <citro2d.h>

#include "game.hpp"

#include <cstdio>

namespace {

constexpr int kTopWidth = 400;
constexpr int kBottomWidth = 320;
constexpr int kScreenHeight = 240;
constexpr float kDepth = 0.5f;

constexpr u32 kBackground = C2D_Color32(25, 34, 43, 255);
constexpr u32 kPanel = C2D_Color32(44, 58, 68, 255);
constexpr u32 kButton = C2D_Color32(75, 96, 105, 255);
constexpr u32 kSelected = C2D_Color32(51, 135, 105, 255);
constexpr u32 kAccent = C2D_Color32(238, 193, 91, 255);
constexpr u32 kText = C2D_Color32(246, 245, 235, 255);
constexpr u32 kMuted = C2D_Color32(183, 197, 197, 255);
constexpr u32 kError = C2D_Color32(240, 126, 112, 255);

enum IngredientSprite : size_t {
    BreadWhiteSprite,
    BreadWheatSprite,
    CheddarSprite,
    MozzarellaSprite
};

cheeseria::Game gGame;
C2D_TextBuf gTextBuffer = nullptr;
C2D_SpriteSheet gIngredientSheet = nullptr;
C2D_Sprite gIngredientSprites[4]{};
C3D_RenderTarget* gTop = nullptr;
C3D_RenderTarget* gBottom = nullptr;
bool gIngredientLoadAttempted = false;
bool gIngredientLoadFailed = false;

void drawText(const char* value, float x, float y, float scale, u32 color) {
    C2D_Text text;
    C2D_TextParse(&text, gTextBuffer, value);
    C2D_TextOptimize(&text);
    C2D_DrawText(&text, C2D_WithColor, x, y, kDepth, scale, scale, color);
}

void drawButton(const char* label, float x, float y, float width, float height,
                bool selected = false) {
    C2D_DrawRectSolid(x, y, 0.4f, width, height, selected ? kSelected : kButton);
    drawText(label, x + 8.0f, y + 7.0f, 0.45f, kText);
}

void drawIngredientButton(const char* label, IngredientSprite ingredient,
                          float x, float y, bool selected) {
    C2D_DrawRectSolid(x, y, 0.4f, 140.0f, 34.0f, selected ? kSelected : kButton);
    if (gIngredientSheet) {
        C2D_Sprite sprite = gIngredientSprites[ingredient];
        C2D_SpriteSetScale(&sprite, 0.29f, 0.29f);
        C2D_SpriteSetPos(&sprite, x + 4.0f, y + 5.0f);
        C2D_DrawSprite(&sprite);
    }
    drawText(label, x + 45.0f, y + 8.0f, 0.42f, kText);
}

const char* breadName(cheeseria::Bread bread) {
    return bread == cheeseria::Bread::Wholegrain ? "WHOLEGRAIN" : "WHITE";
}

const char* cheeseName(cheeseria::Cheese cheese) {
    return cheese == cheeseria::Cheese::Cheddar ? "CHEDDAR" : "MOZZARELLA";
}

void drawTicket() {
    drawText("ORDER #1", 38.0f, 70.0f, 0.55f, kAccent);
    drawText(breadName(gGame.ticket().bread), 38.0f, 103.0f, 0.48f, kText);
    drawText(cheeseName(gGame.ticket().cheese), 38.0f, 132.0f, 0.48f, kText);
    drawText("COOK: MEDIUM", 220.0f, 103.0f, 0.43f, kText);
    drawText("SIDE: REGULAR FRIES", 220.0f, 132.0f, 0.43f, kText);
}

void drawTop() {
    C2D_TargetClear(gTop, kBackground);
    C2D_SceneBegin(gTop);
    drawText("CHEESE SHOP 3DS", 24.0f, 18.0f, 0.75f, kAccent);
    C2D_DrawRectSolid(20.0f, 55.0f, 0.4f, 360.0f, 150.0f, kPanel);

    switch (gGame.screen()) {
        case cheeseria::Screen::Menu:
            drawText("FIRST PLAYABLE ROUTE", 38.0f, 79.0f, 0.58f, kText);
            drawText("Take, cook, build, fry and serve one order.",
                     38.0f, 119.0f, 0.4f, kMuted);
            drawText("Press A or touch the lower screen.", 38.0f, 151.0f, 0.4f, kMuted);
            break;
        case cheeseria::Screen::Station:
            drawTicket();
            switch (gGame.station()) {
                case cheeseria::Station::TakeOrder:
                    drawText("TAKE ORDER", 38.0f, 166.0f, 0.45f, kMuted);
                    break;
                case cheeseria::Station::Cook:
                    drawText("COOKING STATION", 38.0f, 166.0f, 0.45f, kMuted);
                    break;
                case cheeseria::Station::Build:
                    drawText("ASSEMBLY STATION", 38.0f, 166.0f, 0.45f, kMuted);
                    break;
                case cheeseria::Station::Fry:
                    drawText("FRY STATION", 38.0f, 166.0f, 0.45f, kMuted);
                    break;
                case cheeseria::Station::Service:
                    drawText("READY TO SERVE", 38.0f, 166.0f, 0.45f, kMuted);
                    break;
            }
            break;
        case cheeseria::Screen::Pause:
            drawText("PAUSED", 38.0f, 95.0f, 0.8f, kAccent);
            drawText("Press START or A to resume.", 38.0f, 143.0f, 0.45f, kMuted);
            break;
        case cheeseria::Screen::Result:
            drawText(gGame.result() == cheeseria::Validation::Correct
                         ? "PERFECT ORDER"
                         : "ORDER NEEDS WORK",
                     38.0f, 84.0f, 0.65f,
                     gGame.result() == cheeseria::Validation::Correct ? kSelected : kAccent);
            drawText(gGame.score() == 100 ? "SCORE: 100 / 100" : "SCORE: PARTIAL",
                     38.0f, 132.0f, 0.58f, kText);
            break;
        case cheeseria::Screen::Progress:
        {
            char progressText[64];
            drawText("SESSION PROGRESS", 38.0f, 81.0f, 0.58f, kAccent);
            std::snprintf(progressText, sizeof(progressText), "ORDERS: %u",
                          gGame.ordersCompleted());
            drawText(progressText, 38.0f, 119.0f, 0.5f, kText);
            std::snprintf(progressText, sizeof(progressText), "TOTAL SCORE: %u",
                          gGame.totalScore());
            drawText(progressText, 38.0f, 153.0f, 0.45f, kMuted);
            break;
        }
    }
}

void drawStationControls() {
    switch (gGame.station()) {
        case cheeseria::Station::TakeOrder:
            drawText("CUSTOMER TICKET", 18.0f, 35.0f, 0.52f, kText);
            drawButton("ACCEPT ORDER", 18.0f, 156.0f, 284.0f, 48.0f);
            break;
        case cheeseria::Station::Cook:
            drawText("CHOOSE COOK LEVEL", 18.0f, 15.0f, 0.42f, kMuted);
            drawButton("LIGHT", 16.0f, 50.0f, 88.0f, 38.0f,
                       gGame.selectedCook() == cheeseria::CookLevel::Light);
            drawButton("MEDIUM", 116.0f, 50.0f, 88.0f, 38.0f,
                       gGame.selectedCook() == cheeseria::CookLevel::Medium);
            drawButton("WELL", 216.0f, 50.0f, 88.0f, 38.0f,
                       gGame.selectedCook() == cheeseria::CookLevel::Well);
            drawButton("COOK & CONTINUE", 16.0f, 174.0f, 288.0f, 42.0f);
            break;
        case cheeseria::Station::Build:
            drawText("CHOOSE BREAD", 18.0f, 15.0f, 0.42f, kMuted);
            drawIngredientButton("WHITE", BreadWhiteSprite, 16.0f, 40.0f,
                                 gGame.selectedBread() == cheeseria::Bread::White);
            drawIngredientButton("WHOLEGRAIN", BreadWheatSprite, 164.0f, 40.0f,
                                 gGame.selectedBread() == cheeseria::Bread::Wholegrain);
            drawText("CHOOSE CHEESE", 18.0f, 84.0f, 0.42f, kMuted);
            drawIngredientButton("CHEDDAR", CheddarSprite, 16.0f, 109.0f,
                                 gGame.selectedCheese() == cheeseria::Cheese::Cheddar);
            drawIngredientButton("MOZZARELLA", MozzarellaSprite, 164.0f, 109.0f,
                                 gGame.selectedCheese() == cheeseria::Cheese::Mozzarella);
            drawButton("BUILD & CONTINUE", 16.0f, 174.0f, 288.0f, 42.0f);
            if (gIngredientLoadFailed) {
                drawText("ERROR: INGREDIENT ATLAS FAILED", 18.0f, 222.0f, 0.33f, kError);
            }
            break;
        case cheeseria::Station::Fry:
            drawText("CHOOSE SIDE", 18.0f, 35.0f, 0.48f, kMuted);
            drawButton("REGULAR FRIES", 16.0f, 82.0f, 140.0f, 42.0f,
                       gGame.selectedFries() == cheeseria::Fries::Regular);
            drawButton("SWEET POTATO", 164.0f, 82.0f, 140.0f, 42.0f,
                       gGame.selectedFries() == cheeseria::Fries::SweetPotato);
            drawButton("FRY & CONTINUE", 16.0f, 174.0f, 288.0f, 42.0f);
            break;
        case cheeseria::Station::Service:
            drawText("CHECK THE TICKET", 18.0f, 35.0f, 0.52f, kText);
            drawButton("SERVE ORDER", 18.0f, 156.0f, 284.0f, 48.0f);
            break;
    }
    drawText("START: pause  B: cancel", 18.0f, 222.0f, 0.34f, kMuted);
}

void drawBottom() {
    C2D_TargetClear(gBottom, kBackground);
    C2D_SceneBegin(gBottom);

    switch (gGame.screen()) {
        case cheeseria::Screen::Menu:
            drawText("READY FOR A CUSTOMER?", 18.0f, 35.0f, 0.52f, kText);
            drawButton("START ORDER", 18.0f, 156.0f, 284.0f, 48.0f);
            break;
        case cheeseria::Screen::Station:
            drawStationControls();
            break;
        case cheeseria::Screen::Pause:
            drawText("GAME PAUSED", 18.0f, 35.0f, 0.55f, kText);
            drawButton("RESUME", 18.0f, 156.0f, 284.0f, 48.0f);
            break;
        case cheeseria::Screen::Result:
            drawText("ORDER RESULT", 18.0f, 35.0f, 0.55f, kText);
            drawButton("SESSION SUMMARY", 18.0f, 156.0f, 284.0f, 48.0f);
            break;
        case cheeseria::Screen::Progress:
            drawText("SESSION COMPLETE", 18.0f, 35.0f, 0.55f, kText);
            drawButton("NEXT ORDER", 18.0f, 156.0f, 284.0f, 48.0f);
            break;
    }
}

void handleTouch(int x, int y) {
    switch (gGame.screen()) {
        case cheeseria::Screen::Menu:
            if (y >= 150 && y <= 210) gGame.startOrder();
            break;
        case cheeseria::Screen::Station:
            switch (gGame.station()) {
                case cheeseria::Station::TakeOrder:
                    if (y >= 150 && y <= 210) gGame.acceptOrder();
                    break;
                case cheeseria::Station::Cook:
                    if (y >= 50 && y <= 88) {
                        if (x < 106) gGame.chooseCook(cheeseria::CookLevel::Light);
                        else if (x < 214) gGame.chooseCook(cheeseria::CookLevel::Medium);
                        else gGame.chooseCook(cheeseria::CookLevel::Well);
                    } else if (y >= 174 && y <= 216) {
                        gGame.finishCook();
                    }
                    break;
                case cheeseria::Station::Build:
                    if (y >= 40 && y <= 74) {
                        gGame.chooseBread(x < 160 ? cheeseria::Bread::White
                                                  : cheeseria::Bread::Wholegrain);
                    } else if (y >= 109 && y <= 143) {
                        gGame.chooseCheese(x < 160 ? cheeseria::Cheese::Cheddar
                                                   : cheeseria::Cheese::Mozzarella);
                    } else if (y >= 174 && y <= 216) {
                        gGame.finishBuild();
                    }
                    break;
                case cheeseria::Station::Fry:
                    if (y >= 82 && y <= 124) {
                        gGame.chooseFries(x < 160 ? cheeseria::Fries::Regular
                                                  : cheeseria::Fries::SweetPotato);
                    } else if (y >= 174 && y <= 216) {
                        gGame.finishFry();
                    }
                    break;
                case cheeseria::Station::Service:
                    if (y >= 150 && y <= 210) gGame.serveOrder();
                    break;
            }
            break;
        case cheeseria::Screen::Pause:
            if (y >= 150 && y <= 210) gGame.resume();
            break;
        case cheeseria::Screen::Result:
            if (y >= 150 && y <= 210) gGame.acknowledgeResult();
            break;
        case cheeseria::Screen::Progress:
            if (y >= 150 && y <= 210) gGame.continueFromProgress();
            break;
    }
}

void handleA() {
    switch (gGame.screen()) {
        case cheeseria::Screen::Menu:
            gGame.startOrder();
            break;
        case cheeseria::Screen::Station:
            switch (gGame.station()) {
                case cheeseria::Station::TakeOrder: gGame.acceptOrder(); break;
                case cheeseria::Station::Cook: gGame.finishCook(); break;
                case cheeseria::Station::Build: gGame.finishBuild(); break;
                case cheeseria::Station::Fry: gGame.finishFry(); break;
                case cheeseria::Station::Service: gGame.serveOrder(); break;
            }
            break;
        case cheeseria::Screen::Pause:
            gGame.resume();
            break;
        case cheeseria::Screen::Result:
            gGame.acknowledgeResult();
            break;
        case cheeseria::Screen::Progress:
            gGame.continueFromProgress();
            break;
    }
}

void syncIngredientResources() {
    const bool needed = gGame.screen() == cheeseria::Screen::Station &&
                        gGame.station() == cheeseria::Station::Build;
    if (needed && !gIngredientLoadAttempted) {
        gIngredientLoadAttempted = true;
        gIngredientSheet = C2D_SpriteSheetLoad("romfs:/gfx/ingredients.t3x");
        if (!gIngredientSheet || C2D_SpriteSheetCount(gIngredientSheet) < 4) {
            if (gIngredientSheet) C2D_SpriteSheetFree(gIngredientSheet);
            gIngredientSheet = nullptr;
            gIngredientLoadFailed = true;
            return;
        }
        for (size_t i = 0; i < 4; ++i) {
            C2D_SpriteFromSheet(&gIngredientSprites[i], gIngredientSheet, i);
        }
        gIngredientLoadFailed = false;
    } else if (!needed) {
        if (gIngredientSheet) {
            C2D_SpriteSheetFree(gIngredientSheet);
            gIngredientSheet = nullptr;
        }
        gIngredientLoadAttempted = false;
        gIngredientLoadFailed = false;
    }
}

bool initializeGraphics() {
    gfxInitDefault();
    if (!C3D_Init(C3D_DEFAULT_CMDBUF_SIZE)) {
        gfxExit();
        return false;
    }
    if (!C2D_Init(C2D_DEFAULT_MAX_OBJECTS)) {
        C3D_Fini();
        gfxExit();
        return false;
    }
    C2D_Prepare();

    gTextBuffer = C2D_TextBufNew(512);
    gTop = C3D_RenderTargetCreate(kScreenHeight, kTopWidth, GPU_RB_RGBA8,
                                  GPU_RB_DEPTH24_STENCIL8);
    gBottom = C3D_RenderTargetCreate(kScreenHeight, kBottomWidth, GPU_RB_RGBA8,
                                     GPU_RB_DEPTH24_STENCIL8);
    if (!gTextBuffer || !gTop || !gBottom) {
        if (gBottom) C3D_RenderTargetDelete(gBottom);
        if (gTop) C3D_RenderTargetDelete(gTop);
        if (gTextBuffer) C2D_TextBufDelete(gTextBuffer);
        C2D_Fini();
        C3D_Fini();
        gfxExit();
        return false;
    }

    constexpr u32 transferFlags = GX_TRANSFER_FLIP_VERT(0) |
                                  GX_TRANSFER_OUT_TILED(0) |
                                  GX_TRANSFER_RAW_COPY(0) |
                                  GX_TRANSFER_IN_FORMAT(GX_TRANSFER_FMT_RGBA8) |
                                  GX_TRANSFER_OUT_FORMAT(GX_TRANSFER_FMT_RGB8);
    C3D_RenderTargetSetOutput(gTop, GFX_TOP, GFX_LEFT, transferFlags);
    C3D_RenderTargetSetOutput(gBottom, GFX_BOTTOM, GFX_LEFT, transferFlags);
    return true;
}

void shutdownGraphics() {
    if (gIngredientSheet) C2D_SpriteSheetFree(gIngredientSheet);
    C3D_RenderTargetDelete(gBottom);
    C3D_RenderTargetDelete(gTop);
    C2D_TextBufDelete(gTextBuffer);
    C2D_Fini();
    C3D_Fini();
    gfxExit();
}

} // namespace

int main() {
    if (R_FAILED(romfsInit())) {
        return 1;
    }
    if (!initializeGraphics()) {
        romfsExit();
        return 1;
    }

    while (aptMainLoop()) {
        hidScanInput();
        const u32 keys = hidKeysDown();

        if (keys & KEY_A) handleA();
        if ((keys & KEY_B) &&
            (gGame.screen() == cheeseria::Screen::Station ||
             gGame.screen() == cheeseria::Screen::Pause)) {
            gGame.cancelOrder();
        }
        if (keys & KEY_START) {
            if (gGame.screen() == cheeseria::Screen::Station) gGame.pause();
            else if (gGame.screen() == cheeseria::Screen::Pause) gGame.resume();
        }
        if (keys & KEY_TOUCH) {
            touchPosition touch{};
            hidTouchRead(&touch);
            handleTouch(touch.px, touch.py);
        }

        syncIngredientResources();
        C3D_FrameBegin(C3D_FRAME_SYNCDRAW);
        C2D_TextBufClear(gTextBuffer);
        drawTop();
        drawBottom();
        C3D_FrameEnd(0);
    }

    shutdownGraphics();
    romfsExit();
    return 0;
}
