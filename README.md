# Flash Games Hub

Application homebrew C++ pour Nintendo 3DS et New 3DS.

## Projet

- `source/` : code de l'application.
- `include/` : en-tetes des modules du Hub.
- `data/` : clone local du dépôt public de données.
- `romfs/` : catalogue, manifeste et certificats copiés dans le `.3dsx` lors de la compilation.
- `source/catalog_network.cpp` : téléchargement HTTPS du catalogue et du manifeste, avec cache hors ligne.
- `Flash_Games_Hub_Plan.md` : plan et suivi avec les marqueurs `[fait]`.

Le catalogue en ligne est heberge dans le depot public
[FlashGamesHub-Data](https://github.com/dodosiiii/FlashGamesHub-Data).
Le depot contient le catalogue initial, le manifeste du Hub et la structure
des dossiers d'images et de publications. Le depot local est dans `data/`.
Le Hub lit directement les fichiers de la branche `main` : les paquets de test
sont dans [`github-upload/whg-v1.0.0-test`](https://github.com/dodosiiii/FlashGamesHub-Data/tree/main/github-upload/whg-v1.0.0-test),
et le CIA du Hub v0.1.2-dev est dans
[`github-upload/flash-games-hub-v0.1.2-dev`](https://github.com/dodosiiii/FlashGamesHub-Data/tree/main/github-upload/flash-games-hub-v0.1.2-dev).
Le catalogue et le manifeste doivent être publiés à la racine sous
`catalog.json` et `hub.json`. Aucun GitHub Release n'est requis.

## Compilation

devkitPro, devkitARM, libctru et citro2d doivent etre installes dans
`C:\devkitPro`. Ouvrir le shell MSYS2 de devkitPro puis lancer :

```sh
export DEVKITPRO=/c/devkitPro
export DEVKITARM=/c/devkitPro/devkitARM
cd "$(cygpath -u 'C:\Users\dodo\Desktop\projet')"
make
```

`make` produit `FlashGamesHub.3dsx` et `FlashGamesHub.cia`. Le CIA installe
l'application depuis le menu HOME avec son icône et sa bannière. `make clean`
supprime les anciens artefacts avant une reconstruction propre.

L'interface et les descriptions du catalogue sont disponibles en anglais et
en français; l'anglais est sélectionné par défaut.

Pour une installation CIA, copie `FlashGamesHub.cia` sur la carte SD et
installe-le avec un gestionnaire CIA compatible. Pour Homebrew Launcher,
copie `FlashGamesHub.3dsx` dans `/3ds/FlashGamesHub/` ; le catalogue et les
certificats sont déjà inclus dans le fichier.

Le script copie le catalogue et le manifeste depuis le depot `data/` et prepare
les certificats racinaires de Windows pour verifier les connexions HTTPS. La
page Mises à jour compare la version du Hub avec le manifeste publié.
La bibliothèque lit `sdmc:/3ds/FlashGamesHub/installed.json` pour comparer les
versions des jeux installés au catalogue. Depuis la page Mises à jour, le Hub
peut télécharger une mise à jour disponible, vérifier sa taille et son SHA-256,
puis remplacer le fichier du jeu en conservant l'ancienne version en cas d'échec.
Les données de sauvegarde restent dans un dossier séparé. Les paquets `.3dsx`
du catalogue peuvent être téléchargés, vérifiés par taille et SHA-256, puis
ajoutés à la bibliothèque. La bibliothèque lance ces fichiers via le service
`hb:ldr` de Rosalina. Les jeux `.cia` sont installés sur la carte SD et peuvent
être lancés ou désinstallés depuis la bibliothèque. L'installation des CIA
demande un environnement 3DS qui autorise le gestionnaire de titres.
Dans le Store, toucher un jeu ou appuyer sur `A` ouvre sa fiche. La fiche
présente la description, l'état des captures fournies et le bouton de
téléchargement ou d'installation. `B` revient à la liste; `Y` change le format
quand le jeu propose `.3dsx` et `.cia`. Dans la liste, `X` ouvre la recherche,
`Y` change le genre et `Select` affiche uniquement les favoris.
Dans la bibliothèque, `A` lance le jeu sélectionné si le service Rosalina est
disponible, `X` met à jour le jeu, `Y` change son favori et `B` ouvre la
confirmation de désinstallation.

Les tests sur emulateur et sur console seront effectues apres la fin du Hub.
