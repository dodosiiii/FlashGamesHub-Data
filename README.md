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

## Compilation

devkitPro, devkitARM, libctru et citro2d doivent etre installes dans
`C:\devkitPro`. Ouvrir le shell MSYS2 de devkitPro puis lancer :

```sh
export DEVKITPRO=/c/devkitPro
export DEVKITARM=/c/devkitPro/devkitARM
cd "$(cygpath -u 'C:\Users\dodo\Desktop\projet')"
make
```

Le fichier produit sera `FlashGamesHub.3dsx`. `make clean` supprime les anciens
artefacts avant une reconstruction propre.

Le script copie le catalogue et le manifeste depuis le depot `data/` et prepare
les certificats racinaires de Windows pour verifier les connexions HTTPS. La
page Mises à jour compare la version du Hub avec le manifeste publié.
La bibliothèque lit `sdmc:/3ds/FlashGamesHub/installed.json` pour comparer les
versions des jeux installés au catalogue. Depuis la page Mises à jour, le Hub
peut télécharger une mise à jour disponible, vérifier sa taille et son SHA-256,
puis remplacer le fichier du jeu en conservant l'ancienne version en cas d'échec.
Les données de sauvegarde restent dans un dossier séparé. L'installation
initiale et le lancement direct des jeux restent à intégrer.
Dans le Store, `X` ouvre la recherche, `Y` change le genre, `B` modifie le favori
du jeu sélectionné et `Select` affiche uniquement les favoris.
Dans la bibliothèque, `X` met à jour le jeu sélectionné, `Y` change son favori
et `B` ouvre la confirmation de désinstallation. `A` signale que le lancement
direct d'un fichier `.3dsx` doit encore être relié au chargeur Homebrew.

Les tests sur emulateur et sur console seront effectues apres la fin du Hub.
