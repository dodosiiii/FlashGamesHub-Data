#include "game.hpp"

namespace cheeseria {

Screen Game::screen() const {
    return screen_;
}

Station Game::station() const {
    return station_;
}

const Ticket& Game::ticket() const {
    return ticket_;
}

Bread Game::selectedBread() const {
    return selectedBread_;
}

Cheese Game::selectedCheese() const {
    return selectedCheese_;
}

CookLevel Game::selectedCook() const {
    return selectedCook_;
}

Fries Game::selectedFries() const {
    return selectedFries_;
}

Validation Game::result() const {
    return result_;
}

unsigned Game::score() const {
    return score_;
}

unsigned Game::ordersCompleted() const {
    return ordersCompleted_;
}

unsigned Game::totalScore() const {
    return totalScore_;
}

bool Game::startOrder() {
    if (screen_ != Screen::Menu) {
        return false;
    }

    station_ = Station::TakeOrder;
    selectedBread_ = Bread::NotSelected;
    selectedCheese_ = Cheese::NotSelected;
    selectedCook_ = CookLevel::NotSelected;
    selectedFries_ = Fries::NotSelected;
    result_ = Validation::NotReady;
    score_ = 0;
    orderAccepted_ = false;
    cookCorrect_ = false;
    buildCorrect_ = false;
    friesCorrect_ = false;
    screen_ = Screen::Station;
    return true;
}

bool Game::acceptOrder() {
    if (screen_ != Screen::Station || station_ != Station::TakeOrder) {
        return false;
    }

    orderAccepted_ = true;
    station_ = Station::Cook;
    return true;
}

bool Game::chooseCook(CookLevel cook) {
    if (screen_ != Screen::Station || station_ != Station::Cook ||
        (cook != CookLevel::Light && cook != CookLevel::Medium &&
         cook != CookLevel::Well)) {
        return false;
    }

    selectedCook_ = cook;
    return true;
}

bool Game::finishCook() {
    if (screen_ != Screen::Station || station_ != Station::Cook ||
        selectedCook_ == CookLevel::NotSelected) {
        return false;
    }

    cookCorrect_ = matchesCook(ticket_, selectedCook_);
    station_ = Station::Build;
    return true;
}

bool Game::chooseBread(Bread bread) {
    if (screen_ != Screen::Station || station_ != Station::Build ||
        (bread != Bread::White && bread != Bread::Wholegrain)) {
        return false;
    }

    selectedBread_ = bread;
    return true;
}

bool Game::chooseCheese(Cheese cheese) {
    if (screen_ != Screen::Station || station_ != Station::Build ||
        (cheese != Cheese::Cheddar && cheese != Cheese::Mozzarella)) {
        return false;
    }

    selectedCheese_ = cheese;
    return true;
}

bool Game::finishBuild() {
    if (screen_ != Screen::Station || station_ != Station::Build ||
        selectedBread_ == Bread::NotSelected ||
        selectedCheese_ == Cheese::NotSelected) {
        return false;
    }

    buildCorrect_ = matchesBuild(ticket_, selectedBread_, selectedCheese_);
    station_ = Station::Fry;
    return true;
}

bool Game::chooseFries(Fries fries) {
    if (screen_ != Screen::Station || station_ != Station::Fry ||
        (fries != Fries::Regular && fries != Fries::SweetPotato)) {
        return false;
    }

    selectedFries_ = fries;
    return true;
}

bool Game::finishFry() {
    if (screen_ != Screen::Station || station_ != Station::Fry ||
        selectedFries_ == Fries::NotSelected) {
        return false;
    }

    friesCorrect_ = matchesFries(ticket_, selectedFries_);
    station_ = Station::Service;
    return true;
}

Validation Game::serveOrder() {
    if (screen_ != Screen::Station || station_ != Station::Service) {
        return Validation::NotReady;
    }

    score_ = (orderAccepted_ ? 25U : 0U) +
             (cookCorrect_ ? 25U : 0U) +
             (buildCorrect_ ? 25U : 0U) +
             (friesCorrect_ ? 25U : 0U);
    result_ = score_ == 100 ? Validation::Correct : Validation::Incorrect;
    ++ordersCompleted_;
    totalScore_ += score_;
    screen_ = Screen::Result;
    return result_;
}

bool Game::pause() {
    if (screen_ != Screen::Station) {
        return false;
    }

    screenBeforePause_ = screen_;
    screen_ = Screen::Pause;
    return true;
}

bool Game::resume() {
    if (screen_ != Screen::Pause) {
        return false;
    }

    screen_ = screenBeforePause_;
    return true;
}

bool Game::cancelOrder() {
    if (screen_ != Screen::Station && screen_ != Screen::Pause) {
        return false;
    }

    screen_ = Screen::Menu;
    screenBeforePause_ = Screen::Menu;
    return true;
}

bool Game::acknowledgeResult() {
    if (screen_ != Screen::Result) {
        return false;
    }

    screen_ = Screen::Progress;
    return true;
}

bool Game::continueFromProgress() {
    if (screen_ != Screen::Progress) {
        return false;
    }

    screen_ = Screen::Menu;
    return true;
}

} // namespace cheeseria
