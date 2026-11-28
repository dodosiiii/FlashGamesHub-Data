// game_test.cpp — tests hôte (sans framework) : logique + sauvegarde
#include "game.hpp"
#include "progress_save.hpp"
#include "layout_parse.hpp"
#include <cstdio>

using namespace cheeseria;
static int g_fail = 0;
#define CHECK(c) do { if (!(c)) { std::printf("ECHEC l.%d: %s\n", __LINE__, #c); ++g_fail; } } while (0)

static void playPerfect(Game& g) {
    CHECK(g.startOrder());
    Ticket t = g.ticket();
    CHECK(g.acceptOrder());
    CHECK(!g.finishCook());
    g.chooseCook(t.cook);   CHECK(g.finishCook());
    CHECK(!g.finishBuild());
    g.chooseBread(t.bread); g.chooseCheese(t.cheese); CHECK(g.finishBuild());
    g.chooseFries(t.fries); CHECK(g.finishFry());
    CHECK(g.serveOrder() == Validation::Correct);
    CHECK(g.score() == 100);
    CHECK(g.acknowledgeResult()); CHECK(g.continueFromProgress());
}

int main() {
    Game g;
    CHECK(g.screen() == Screen::Menu);
    for (int i = 0; i < 12; ++i) playPerfect(g);   // traverse le cycle des 6 tickets
    CHECK(g.ordersCompleted() == 12 && g.totalScore() == 1200);

    CHECK(g.startOrder()); CHECK(g.acceptOrder());
    g.chooseCook(g.ticket().cook);  g.finishCook();
    g.chooseBread(g.ticket().bread);
    g.chooseCheese(g.ticket().cheese == Cheese::Cheddar ? Cheese::Mozzarella : Cheese::Cheddar);
    g.finishBuild();
    g.chooseFries(g.ticket().fries == Fries::Regular ? Fries::SweetPotato : Fries::Regular);
    g.finishFry();
    CHECK(g.serveOrder() == Validation::Incorrect); CHECK(g.score() == 25);
    g.acknowledgeResult(); g.continueFromProgress();

    CHECK(g.startOrder()); CHECK(g.pause()); CHECK(g.screen() == Screen::Pause);
    CHECK(g.resume()); CHECK(g.screen() == Screen::Station);
    CHECK(g.cancelOrder()); CHECK(g.screen() == Screen::Menu);
    CHECK(!g.acceptOrder());

    std::array<std::uint8_t, kProgressSaveSize> buf{};
    SavedProgress in{7, 650}, out{};
    CHECK(encodeProgress(in, buf));
    CHECK(decodeProgress(buf.data(), buf.size(), out) && out.ordersCompleted == 7 && out.totalScore == 650);
    buf[9] ^= 1; CHECK(!decodeProgress(buf.data(), buf.size(), out));
    CHECK(!encodeProgress(SavedProgress{1, 101}, buf));
    Game r; CHECK(r.restoreProgress(3, 300)); CHECK(!r.restoreProgress(1, 500));

    // Layout : analyse des lignes de screens.tsv
    LayoutOp op;
    CHECK(parseLayoutLine("build\ttop\tspr_buildScreenMC_1\t40\t0\t0.5\t0.25\n", op));
    CHECK(op.screen == "build" && op.top && op.sprite == "spr_buildScreenMC_1");
    CHECK(op.x == 40.0f && op.y == 0.0f && op.sx == 0.5f && op.sy == 0.25f);
    CHECK(parseLayoutLine("menu\tbottom\timg_10030\t0\t0\t2\r\n", op) && !op.top && op.sx == 2.0f && op.sy == 2.0f);
    CHECK(parseLayoutLine("menu\tbottom\timg_1\t5\t6", op) && op.sx == 1.0f && op.sy == 1.0f);
    CHECK(!parseLayoutLine("# commentaire", op));
    CHECK(!parseLayoutLine("", op));
    CHECK(!parseLayoutLine("menu\tmiddle\timg_1\t0\t0", op));   // cible invalide
    CHECK(!parseLayoutLine("menu\ttop\timg_1\tabc\t0", op));    // nombre invalide
    CHECK(!parseLayoutLine("menu\ttop\timg_1", op));              // champs manquants

    std::printf(g_fail ? "\n%d echec(s)\n" : "OK : tous les tests passent\n", g_fail);
    return g_fail ? 1 : 0;
}
