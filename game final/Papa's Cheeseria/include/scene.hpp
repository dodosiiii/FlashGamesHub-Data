// scene.hpp — couche « vrais assets » : dessine les sprites du SWF listés dans romfs:/layout/screens.tsv
#pragma once

namespace cheeseria {
namespace scene {

int  init();                                  // lit romfs:/layout/screens.tsv ; retourne le nombre d'opérations
int  opCount();
void setScreen(const char* key);              // décharge les planches inutiles à cet écran (mémoire 3DS)
int  drawLayer(const char* key, bool top);    // dessine les sprites de l'écran ; retourne le nombre dessinés

} // namespace scene
} // namespace cheeseria
