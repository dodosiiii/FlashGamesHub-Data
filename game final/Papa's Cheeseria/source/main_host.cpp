#include "game.hpp"

#include <iostream>

namespace {

int readChoice(const char* prompt, int minimum, int maximum) {
    int choice = 0;
    for (;;) {
        std::cout << prompt;
        if (std::cin >> choice && choice >= minimum && choice <= maximum) {
            return choice;
        }
        if (std::cin.eof()) {
            return -1;
        }

        std::cin.clear();
        std::cin.ignore(1024, '\n');
        std::cout << "Choix invalide.\n";
    }
}

void printTicket(const cheeseria::Ticket& ticket) {
    std::cout << "Ticket : pain "
              << (ticket.bread == cheeseria::Bread::Wholegrain ? "complet" : "blanc")
              << ", cheddar, cuisson medium, frites classiques.\n";
}

} // namespace

int main() {
    cheeseria::Game game;

    for (;;) {
        std::cout << "\n=== Atelier fromage ===\n"
                  << "1. Nouvelle commande\n"
                  << "0. Quitter\n";
        const int menuChoice = readChoice("> ", 0, 1);
        if (menuChoice <= 0) {
            return 0;
        }
        if (!game.startOrder()) {
            std::cerr << "Impossible de demarrer une commande.\n";
            return 1;
        }

        printTicket(game.ticket());
        if (readChoice("1. Accepter le ticket > ", 1, 1) < 0 ||
            !game.acceptOrder()) {
            return 0;
        }

        const int cook = readChoice("Cuisson : 1 legere, 2 medium, 3 bien cuite > ", 1, 3);
        if (cook < 0) return 0;
        game.chooseCook(static_cast<cheeseria::CookLevel>(cook));
        if (!game.finishCook()) return 1;

        const int bread = readChoice("Pain : 1 blanc, 2 complet > ", 1, 2);
        if (bread < 0) return 0;
        game.chooseBread(bread == 1 ? cheeseria::Bread::White
                                    : cheeseria::Bread::Wholegrain);
        const int cheese = readChoice("Fromage : 1 cheddar, 2 mozzarella > ", 1, 2);
        if (cheese < 0) return 0;
        game.chooseCheese(cheese == 1 ? cheeseria::Cheese::Cheddar
                                      : cheeseria::Cheese::Mozzarella);
        if (!game.finishBuild()) return 1;

        const int fries = readChoice("Accompagnement : 1 frites, 2 patate douce > ", 1, 2);
        if (fries < 0) return 0;
        game.chooseFries(fries == 1 ? cheeseria::Fries::Regular
                                    : cheeseria::Fries::SweetPotato);
        if (!game.finishFry()) return 1;

        std::cout << "Commande prete. Entrez 1 pour servir.\n";
        if (readChoice("> ", 1, 1) < 0) return 0;
        const cheeseria::Validation result = game.serveOrder();
        std::cout << (result == cheeseria::Validation::Correct
                          ? "Commande parfaite."
                          : "Commande servie avec des erreurs.")
                  << " Score : " << game.score() << "/100.\n";
        game.acknowledgeResult();
        std::cout << "Commandes terminees : " << game.ordersCompleted()
                  << " | Score total : " << game.totalScore() << '\n';
        game.continueFromProgress();
    }
}
