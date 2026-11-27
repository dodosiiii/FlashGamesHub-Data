# Publication du Hub v0.1.1-dev

## Avant de pousser

- [ ] Pousser ce dossier avec `FlashGamesHub.cia` et le `hub.json` a la racine.
- [ ] Verifier que le CIA est accessible a l'URL declaree dans `hub.json`.
- [ ] Garder la taille et le SHA-256 du CIA identiques a ceux du manifeste.
- [ ] Ne pas reconstruire le CIA apres calcul du SHA-256. Si le CIA change,
      recalculer son empreinte et mettre a jour `data/hub.json` et `hub.json`.
- [ ] Sur la 3DS avec la version `0.1.0-dev`, ouvrir Mises a jour et actualiser
      les donnees apres que le push est disponible.

Le manifeste annonce `0.1.1-dev` comme version courante et accepte la mise a
jour depuis `0.1.0-dev`.
