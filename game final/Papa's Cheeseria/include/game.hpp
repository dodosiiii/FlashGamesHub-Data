// game.hpp — Papa's Cheeseria 3DS : logique de jeu pure (aucune dépendance libctru)
#pragma once

namespace cheeseria {

enum class Screen  { Menu, Station, Pause, Result, Progress };
enum class Station { TakeOrder, Cook, Build, Fry, Service };

enum class Bread     { NotSelected, White, Wholegrain };
enum class Cheese    { NotSelected, Cheddar, Mozzarella };
enum class CookLevel { NotSelected, Light, Medium, Well };
enum class Fries     { NotSelected, Regular, SweetPotato };
enum class Validation { NotReady, Correct, Incorrect };

struct Ticket {
    Bread     bread  = Bread::NotSelected;
    Cheese    cheese = Cheese::NotSelected;
    CookLevel cook   = CookLevel::NotSelected;
    Fries     fries  = Fries::NotSelected;
};

inline bool matchesCook(const Ticket& t, CookLevel c)         { return t.cook == c; }
inline bool matchesBuild(const Ticket& t, Bread b, Cheese ch) { return t.bread == b && t.cheese == ch; }
inline bool matchesFries(const Ticket& t, Fries f)            { return t.fries == f; }

class Game {
public:
    Screen        screen() const;
    Station       station() const;
    const Ticket& ticket() const;
    Bread         selectedBread() const;
    Cheese        selectedCheese() const;
    CookLevel     selectedCook() const;
    Fries         selectedFries() const;
    Validation    result() const;
    unsigned      score() const;
    unsigned      ordersCompleted() const;
    unsigned      totalScore() const;

    bool       startOrder();
    bool       acceptOrder();
    bool       chooseCook(CookLevel cook);
    bool       finishCook();
    bool       chooseBread(Bread bread);
    bool       chooseCheese(Cheese cheese);
    bool       finishBuild();
    bool       chooseFries(Fries fries);
    bool       finishFry();
    Validation serveOrder();
    bool       acknowledgeResult();
    bool       continueFromProgress();
    bool       pause();
    bool       resume();
    bool       cancelOrder();
    bool       restoreProgress(unsigned ordersCompleted, unsigned totalScore);

private:
    Screen     screen_ = Screen::Menu;
    Screen     screenBeforePause_ = Screen::Menu;
    Station    station_ = Station::TakeOrder;
    Ticket     ticket_{};
    Bread      selectedBread_  = Bread::NotSelected;
    Cheese     selectedCheese_ = Cheese::NotSelected;
    CookLevel  selectedCook_   = CookLevel::NotSelected;
    Fries      selectedFries_  = Fries::NotSelected;
    Validation result_ = Validation::NotReady;
    bool       orderAccepted_ = false;
    bool       cookCorrect_ = false;
    bool       buildCorrect_ = false;
    bool       friesCorrect_ = false;
    unsigned   score_ = 0;
    unsigned   ordersCompleted_ = 0;
    unsigned   totalScore_ = 0;
};

} // namespace cheeseria
