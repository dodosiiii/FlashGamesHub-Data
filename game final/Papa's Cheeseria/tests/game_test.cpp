#include "game.hpp"

#include <cassert>

namespace {

void completeOrder(cheeseria::Game& game, cheeseria::CookLevel cook,
                   cheeseria::Bread bread, cheeseria::Cheese cheese,
                   cheeseria::Fries fries) {
    assert(game.startOrder());
    assert(game.acceptOrder());
    assert(game.chooseCook(cook));
    assert(game.finishCook());
    assert(game.chooseBread(bread));
    assert(game.chooseCheese(cheese));
    assert(game.finishBuild());
    assert(game.chooseFries(fries));
    assert(game.finishFry());
}

} // namespace

int main() {
    cheeseria::Game game;

    assert(game.screen() == cheeseria::Screen::Menu);
    assert(!game.acceptOrder());
    assert(game.startOrder());
    assert(game.station() == cheeseria::Station::TakeOrder);
    assert(!game.chooseCook(cheeseria::CookLevel::Medium));
    assert(game.pause());
    assert(game.screen() == cheeseria::Screen::Pause);
    assert(!game.chooseCook(cheeseria::CookLevel::Medium));
    assert(game.resume());
    assert(game.acceptOrder());
    assert(!game.finishCook());
    assert(game.chooseCook(cheeseria::CookLevel::Medium));
    assert(game.finishCook());
    assert(game.station() == cheeseria::Station::Build);
    assert(!game.finishBuild());
    assert(game.chooseBread(cheeseria::Bread::Wholegrain));
    assert(game.chooseCheese(cheeseria::Cheese::Cheddar));
    assert(game.finishBuild());
    assert(!game.finishFry());
    assert(game.chooseFries(cheeseria::Fries::Regular));
    assert(game.finishFry());
    assert(game.serveOrder() == cheeseria::Validation::Correct);
    assert(game.score() == 100);
    assert(game.ordersCompleted() == 1);
    assert(game.totalScore() == 100);
    assert(game.acknowledgeResult());
    assert(game.screen() == cheeseria::Screen::Progress);
    assert(game.continueFromProgress());

    completeOrder(game, cheeseria::CookLevel::Well, cheeseria::Bread::White,
                  cheeseria::Cheese::Mozzarella, cheeseria::Fries::SweetPotato);
    assert(game.serveOrder() == cheeseria::Validation::Incorrect);
    assert(game.score() == 25);
    assert(game.ordersCompleted() == 2);
    assert(game.totalScore() == 125);
    assert(game.acknowledgeResult());
    assert(game.continueFromProgress());

    assert(game.startOrder());
    assert(game.cancelOrder());
    assert(game.screen() == cheeseria::Screen::Menu);
    assert(!game.continueFromProgress());
}
