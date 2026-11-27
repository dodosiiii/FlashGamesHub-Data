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
Les données de sauvegarde restent dans un dossier séparé. Les paquets `.3dsx`
du catalogue peuvent être téléchargés, vérifiés par taille et SHA-256, puis
ajoutés à la bibliothèque. La bibliothèque lance ces fichiers via le service
`hb:ldr` de Rosalina. L'installation des `.cia` reste à intégrer.
Dans le Store, `A` télécharge un paquet indiqué dans la fiche (ou ajoute un
favori si aucun paquet n'est indiqué), `X` ouvre la recherche, `Y` change le
genre, `Select` affiche uniquement les favoris et `B` réinitialise les filtres.
Dans la bibliothèque, `A` lance le jeu sélectionné si le service Rosalina est
disponible, `X` met à jour le jeu, `Y` change son favori et `B` ouvre la
confirmation de désinstallation.

Les tests sur emulateur et sur console seront effectues apres la fin du Hub.
