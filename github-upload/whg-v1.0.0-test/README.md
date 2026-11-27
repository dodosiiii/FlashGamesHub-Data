# The World's Hardest Game 1 — test release

Ces deux fichiers sont prêts à être ajoutés comme pièces jointes à une GitHub
Release du dépôt `dodosiiii/FlashGamesHub-Data`.

## Publication manuelle

1. Créer une release avec le tag `whg-v1.0.0-test`.
2. Ajouter `whg-hub-3ds.3dsx` et `whg-hub-3ds.cia` depuis ce dossier.
3. Publier ensuite `data/catalog.json` à la racine de la branche `main`.
4. Dans le Hub, ouvrir le Store puis actualiser le catalogue.
5. Sélectionner The World's Hardest Game 1 et appuyer sur `A` pour télécharger
   le `.3dsx` de test.

Le catalogue pointe vers cette pièce jointe :

`https://github.com/dodosiiii/FlashGamesHub-Data/releases/download/whg-v1.0.0-test/whg-hub-3ds.3dsx`

Le Hub vérifie la taille attendue et le SHA-256 avant d'ajouter le `.3dsx` à la
bibliothèque. L'entrée reste marquée `development` et les modèles restent
`unverified` jusqu'aux essais sur console.

Le `.cia` est joint pour les essais manuels. Le Hub ne le télécharge ni ne
l'installe pour le moment; le flux actuel utilise le `.3dsx`.

## Empreintes de référence

| Fichier | Taille | SHA-256 |
| --- | ---: | --- |
| `whg-hub-3ds.3dsx` | 47 192 056 octets | `1f6697dbf90a17c0e2282eb7b46ea8e47d57b150342ee3a9f854646cd714b72a` |
| `whg-hub-3ds.cia` | 47 756 224 octets | `a390785c6b493a0dfc79f45e0b685e660640d58ebd371b0302bf855dabb267a0` |
