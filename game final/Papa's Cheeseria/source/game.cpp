// game.cpp — Papa's Cheeseria 3DS
// Logique de jeu pure (sans dépendance libctru/citro2d)
// Compatible C++17

#include "game.hpp"

namespace cheeseria {

// ─── Accesseurs ─────────────────────────────────────────────────────────────

Screen Game::screen() const { return screen_; }
Station Game::station() const { return station_; }
const Ticket& Game::ticket() const { return ticket_; }
Bread Game::selectedBread() const { return selectedBread_; }
Cheese Game::selectedCheese() const { return selectedCheese_; }
CookLevel Game::selectedCook() const { return selectedCook_; }
Fries Game::selectedFries() const { return selectedFries_; }
Validation Game::result() const { return result_; }
unsigned Game::score() const { return score_; }
unsigned Game::ordersCompleted() const { return ordersCompleted_; }
unsigned Game::totalScore() const { return totalScore_; }

// ─── Menu → Prise de commande ────────────────────────────────────────────────

bool Game::startOrder() {
    if (screen_ != Screen::Menu) return false;
    screen_ = Screen::Station;
    station_ = Station::TakeOrder;
    orderAccepted_ = false;
    cookCorrect_ = false;
    buildCorrect_ = false;
    friesCorrect_ = false;
    selectedBread_ = Bread::NotSelected;
    selectedCheese_ = Cheese::NotSelected;
    selectedCook_ = CookLevel::NotSelected;
    selectedFries_ = Fries::NotSelected;
    result_ = Validation::NotReady;
    // Ticket dynamique : cycle entre plusieurs commandes selon ordersCompleted_
    static constexpr Ticket kTickets[] = {
        {Bread::Wholegrain, Cheese::Cheddar,      CookLevel::Medium, Fries::Regular},
        {Bread::White,      Cheese::Mozzarella,   CookLevel::Well,   Fries::SweetPotato},
        {Bread::White,      Cheese::Cheddar,      CookLevel::Light,  Fries::Regular},
        {Bread::Wholegrain, Cheese::Mozzarella,   CookLevel::Medium, Fries::SweetPotato},
        {Bread::White,      Cheese::Mozzarella,   CookLevel::Medium, Fries::Regular},
        {Bread::Wholegrain, Cheese::Cheddar,      CookLevel::Well,   Fries::SweetPotato},
    };
    ticket_ = kTickets[ordersCompleted_ % (sizeof(kTickets) / sizeof(kTickets[0]))];
    return true;
}

bool Game::acceptOrder() {
    if (screen_ != Screen::Station || station_ != Station::TakeOrder) return false;
    orderAccepted_ = true;
    station_ = Station::Cook;
    return true;
}

// ─── Cuisson ────────────────────────────────────────────────────────────────

bool Game::chooseCook(CookLevel cook) {
    if (screen_ != Screen::Station || station_ != Station::Cook) return false;
    selectedCook_ = cook;
    return true;
}

bool Game::finishCook() {
    if (screen_ != Screen::Station || station_ != Station::Cook) return false;
    if (selectedCook_ == CookLevel::NotSelected) return false;
    cookCorrect_ = matchesCook(ticket_, selectedCook_);
    station_ = Station::Build;
    return true;
}

// ─── Assemblage ─────────────────────────────────────────────────────────────

bool Game::chooseBread(Bread bread) {
    if (screen_ != Screen::Station || station_ != Station::Build) return false;
    selectedBread_ = bread;
    return true;
}

bool Game::chooseCheese(Cheese cheese) {
    if (screen_ != Screen::Station || station_ != Station::Build) return false;
    selectedCheese_ = cheese;
    return true;
}

bool Game::finishBuild() {
    if (screen_ != Screen::Station || station_ != Station::Build) return false;
    if (selectedBread_ == Bread::NotSelected || selectedCheese_ == Cheese::NotSelected) return false;
    buildCorrect_ = matchesBuild(ticket_, selectedBread_, selectedCheese_);
    station_ = Station::Fry;
    return true;
}

// ─── Frites ─────────────────────────────────────────────────────────────────

bool Game::chooseFries(Fries fries) {
    if (screen_ != Screen::Station || station_ != Station::Fry) return false;
    selectedFries_ = fries;
    return true;
}

bool Game::finishFry() {
    if (screen_ != Screen::Station || station_ != Station::Fry) return false;
    if (selectedFries_ == Fries::NotSelected) return false;
    friesCorrect_ = matchesFries(ticket_, selectedFries_);
    station_ = Station::Service;
    return true;
}

// ─── Service ────────────────────────────────────────────────────────────────

Validation Game::serveOrder() {
    if (screen_ != Screen::Station || station_ != Station::Service) return Validation::NotReady;

    // Calcul du score : 100 pts si tout correct, 25 pts si partiellement correct
    bool allCorrect = cookCorrect_ && buildCorrect_ && friesCorrect_;
    bool anyCorrect = cookCorrect_ || buildCorrect_ || friesCorrect_;

    if (allCorrect) {
        score_ = 100;
        result_ = Validation::Correct;
    } else if (anyCorrect) {
        score_ = 25;
        result_ = Validation::Incorrect;
    } else {
        score_ = 0;
        result_ = Validation::Incorrect;
    }

    totalScore_ += score_;
    ++ordersCompleted_;
    screen_ = Screen::Result;
    return result_;
}

// ─── Résultat / Progression ──────────────────────────────────────────────────

bool Game::acknowledgeResult() {
    if (screen_ != Screen::Result) return false;
    screen_ = Screen::Progress;
    return true;
}

bool Game::continueFromProgress() {
    if (screen_ != Screen::Progress) return false;
    screen_ = Screen::Menu;
    return true;
}

// ─── Pause / Reprise ────────────────────────────────────────────────────────

bool Game::pause() {
    if (screen_ != Screen::Station) return false;
    screenBeforePause_ = screen_;
    screen_ = Screen::Pause;
    return true;
}

bool Game::resume() {
    if (screen_ != Screen::Pause) return false;
    screen_ = screenBeforePause_;
    return true;
}

bool Game::cancelOrder() {
    if (screen_ != Screen::Station && screen_ != Screen::Pause) return false;
    screen_ = Screen::Menu;
    station_ = Station::TakeOrder;
    return true;
}

// ─── Restauration de la sauvegarde ──────────────────────────────────────────

bool Game::restoreProgress(unsigned ordersCompleted, unsigned totalScore) {
    if (screen_ != Screen::Menu) return false;
    // Validation minimale : impossible si les totaux semblent incohérents
    if (ordersCompleted > 0 && totalScore > ordersCompleted * 100) return false;
    ordersCompleted_ = ordersCompleted;
    totalScore_ = totalScore;
    return true;
}

} // namespace cheeseria
