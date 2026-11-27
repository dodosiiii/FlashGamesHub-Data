#pragma once

#include <cstdint>

namespace cheeseria {

enum class Screen : std::uint8_t {
    Menu,
    Station,
    Pause,
    Result,
    Progress
};

enum class Station : std::uint8_t {
    TakeOrder,
    Cook,
    Build,
    Fry,
    Service
};

enum class Bread : std::uint8_t {
    NotSelected,
    White,
    Wholegrain
};

enum class Cheese : std::uint8_t {
    NotSelected,
    Cheddar,
    Mozzarella
};

enum class CookLevel : std::uint8_t {
    NotSelected,
    Light,
    Medium,
    Well
};

enum class Fries : std::uint8_t {
    NotSelected,
    Regular,
    SweetPotato
};

enum class Validation : std::uint8_t {
    Incomplete,
    Correct,
    Incorrect,
    NotReady
};

struct Ticket {
    Bread bread;
    Cheese cheese;
    CookLevel cook;
    Fries fries;
};

constexpr bool matchesBuild(const Ticket& ticket, Bread bread, Cheese cheese) {
    return bread != Bread::NotSelected && cheese != Cheese::NotSelected &&
           bread == ticket.bread && cheese == ticket.cheese;
}

constexpr bool matchesCook(const Ticket& ticket, CookLevel cook) {
    return cook != CookLevel::NotSelected && cook == ticket.cook;
}

constexpr bool matchesFries(const Ticket& ticket, Fries fries) {
    return fries != Fries::NotSelected && fries == ticket.fries;
}

static_assert(matchesBuild({Bread::Wholegrain, Cheese::Cheddar,
                            CookLevel::Medium, Fries::Regular},
                           Bread::Wholegrain, Cheese::Cheddar));
static_assert(!matchesBuild({Bread::Wholegrain, Cheese::Cheddar,
                             CookLevel::Medium, Fries::Regular},
                            Bread::White, Cheese::Cheddar));
static_assert(matchesCook({Bread::White, Cheese::Mozzarella,
                           CookLevel::Medium, Fries::Regular},
                          CookLevel::Medium));
static_assert(matchesFries({Bread::White, Cheese::Mozzarella,
                            CookLevel::Medium, Fries::Regular},
                           Fries::Regular));

class Game {
public:
    Screen screen() const;
    Station station() const;
    const Ticket& ticket() const;
    Bread selectedBread() const;
    Cheese selectedCheese() const;
    CookLevel selectedCook() const;
    Fries selectedFries() const;
    Validation result() const;
    unsigned score() const;
    unsigned ordersCompleted() const;
    unsigned totalScore() const;

    bool startOrder();
    bool acceptOrder();
    bool chooseCook(CookLevel cook);
    bool finishCook();
    bool chooseBread(Bread bread);
    bool chooseCheese(Cheese cheese);
    bool finishBuild();
    bool chooseFries(Fries fries);
    bool finishFry();
    Validation serveOrder();
    bool pause();
    bool resume();
    bool cancelOrder();
    bool acknowledgeResult();
    bool continueFromProgress();

private:
    Screen screen_ = Screen::Menu;
    Screen screenBeforePause_ = Screen::Menu;
    Station station_ = Station::TakeOrder;
    Ticket ticket_{Bread::Wholegrain, Cheese::Cheddar,
                   CookLevel::Medium, Fries::Regular};
    Bread selectedBread_ = Bread::NotSelected;
    Cheese selectedCheese_ = Cheese::NotSelected;
    CookLevel selectedCook_ = CookLevel::NotSelected;
    Fries selectedFries_ = Fries::NotSelected;
    Validation result_ = Validation::NotReady;
    unsigned score_ = 0;
    unsigned ordersCompleted_ = 0;
    unsigned totalScore_ = 0;
    bool orderAccepted_ = false;
    bool cookCorrect_ = false;
    bool buildCorrect_ = false;
    bool friesCorrect_ = false;
};

} // namespace cheeseria
