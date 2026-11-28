// main_host.cpp — Papa's Cheeseria (prototype terminal, sans libctru)
// Prototype de test rapide de la logique sur PC

#include "game.hpp"
#include "progress_save.hpp"

#include <array>
#include <cinttypes>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <string>

using namespace cheeseria;

static void printMenu(const Game& g) {
    std::printf("\n=== Papa's Cheeseria (Terminal) ===\n");
    std::printf("Commandes: %u | Score: %u\n", g.ordersCompleted(), g.totalScore());
    std::printf("[1] Nouvelle commande  [q] Quitter\n> ");
}

static void printTicket(const Game& g) {
    const Ticket& t = g.ticket();
    const char* breads[] = {"?", "Blanc", "Complet"};
    const char* cheeses[] = {"?", "Cheddar", "Mozzarella"};
    const char* cooks[] = {"?", "Leger", "Medium", "Bien cuit"};
    const char* fries[] = {"?", "Normales", "Patate douce"};
    std::printf("\n--- TICKET ---\n");
    std::printf("Pain   : %s\n", breads[static_cast<int>(t.bread)]);
    std::printf("Fromage: %s\n", cheeses[static_cast<int>(t.cheese)]);
    std::printf("Cuisson: %s\n", cooks[static_cast<int>(t.cook)]);
    std::printf("Frites : %s\n", fries[static_cast<int>(t.fries)]);
}

int main() {
    Game game;

    // Tentative de chargement save
    std::array<std::uint8_t, kProgressSaveSize> saveBytes{};
    FILE* f = std::fopen("cheeseria_save.dat", "rb");
    if (f) {
        if (std::fread(saveBytes.data(), 1, saveBytes.size(), f) == saveBytes.size()) {
            SavedProgress sp{};
            if (decodeProgress(saveBytes.data(), saveBytes.size(), sp)) {
                game.restoreProgress(sp.ordersCompleted, sp.totalScore);
                std::printf("[Sauvegarde chargee: %" PRIu32 " commandes, %" PRIu32 " pts]\n",
                    sp.ordersCompleted, sp.totalScore);
            }
        }
        std::fclose(f);
    }

    std::string line;
    while (true) {
        Screen sc = game.screen();
        Station st = game.station();

        if (sc == Screen::Menu) {
            printMenu(game);
            if (!std::getline(std::cin, line)) break;
            if (line == "q" || line == "Q") break;
            if (line == "1") game.startOrder();
        }
        else if (sc == Screen::Station && st == Station::TakeOrder) {
            printTicket(game);
            std::printf("[A]ccepter  [C]annuler\n> ");
            if (!std::getline(std::cin, line)) break;
            if (line == "a" || line == "A") game.acceptOrder();
            else if (line == "c" || line == "C") game.cancelOrder();
        }
        else if (sc == Screen::Station && st == Station::Cook) {
            std::printf("\nCuisson: [1]Leger [2]Medium [3]Bien cuit -- [v]Valider\n> ");
            if (!std::getline(std::cin, line)) break;
            if (line == "1") game.chooseCook(CookLevel::Light);
            else if (line == "2") game.chooseCook(CookLevel::Medium);
            else if (line == "3") game.chooseCook(CookLevel::Well);
            else if (line == "v" || line == "V") game.finishCook();
        }
        else if (sc == Screen::Station && st == Station::Build) {
            std::printf("\nPain: [1]Blanc [2]Complet | Fromage: [3]Cheddar [4]Mozza -- [v]Valider\n> ");
            if (!std::getline(std::cin, line)) break;
            if (line == "1") game.chooseBread(Bread::White);
            else if (line == "2") game.chooseBread(Bread::Wholegrain);
            else if (line == "3") game.chooseCheese(Cheese::Cheddar);
            else if (line == "4") game.chooseCheese(Cheese::Mozzarella);
            else if (line == "v" || line == "V") game.finishBuild();
        }
        else if (sc == Screen::Station && st == Station::Fry) {
            std::printf("\nFrites: [1]Normales [2]Patate douce -- [v]Valider\n> ");
            if (!std::getline(std::cin, line)) break;
            if (line == "1") game.chooseFries(Fries::Regular);
            else if (line == "2") game.chooseFries(Fries::SweetPotato);
            else if (line == "v" || line == "V") game.finishFry();
        }
        else if (sc == Screen::Station && st == Station::Service) {
            std::printf("\n[S]ervir le client\n> ");
            if (!std::getline(std::cin, line)) break;
            if (line == "s" || line == "S") game.serveOrder();
        }
        else if (sc == Screen::Result) {
            const char* msg = (game.result() == Validation::Correct) ? "PARFAIT!" : "Rate...";
            std::printf("\n%s  +%u pts (total: %u)\n[Entree pour continuer]\n> ", msg, game.score(), game.totalScore());
            std::getline(std::cin, line);
            // Sauvegarde automatique
            SavedProgress sp{game.ordersCompleted(), game.totalScore()};
            if (encodeProgress(sp, saveBytes)) {
                FILE* sf = std::fopen("cheeseria_save.dat", "wb");
                if (sf) { std::fwrite(saveBytes.data(), 1, saveBytes.size(), sf); std::fclose(sf); }
            }
            game.acknowledgeResult();
        }
        else if (sc == Screen::Progress) {
            std::printf("\nCommandes: %u | Total: %u pts\n[Entree pour continuer]\n> ",
                game.ordersCompleted(), game.totalScore());
            std::getline(std::cin, line);
            game.continueFromProgress();
        }
    }

    std::printf("\nAu revoir ! Score final : %u pts (%u commandes)\n",
        game.totalScore(), game.ordersCompleted());
    return 0;
}
