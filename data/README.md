# Fichiers du depot FlashGamesHub-Data

Ce depot public contient le catalogue initial du Hub et le manifeste de
publication. Le Hub embarque aussi `catalog.json` pour son affichage hors
ligne.

Depot : https://github.com/dodosiiii/FlashGamesHub-Data

Liens publics utilises par le Hub :

- https://raw.githubusercontent.com/dodosiiii/FlashGamesHub-Data/main/catalog.json
- https://raw.githubusercontent.com/dodosiiii/FlashGamesHub-Data/main/hub.json

Les dossiers `covers/`, `screenshots/` et `releases/` accueillent les medias
et fichiers publies. Une fiche de jeu n'est marquee `available` qu'apres
validation de son fichier et de sa compatibilite.

## Format du catalogue

- `schema_version` : version du format JSON.
- `catalog_version` : numero croissant a chaque publication.
- `updated_at` : date au format `AAAA-MM-JJ`.
- `games` : liste des fiches avec `id`, `name`, `description_fr`,
  `description_en`, `genre`,
  `developer`, `cover`, `screenshots`, `status`, `compatibility`, `version`,
  `size_bytes`, `download_url`, `sha256` et, si besoin, `series`.
- `cia_title_id` identifie le titre installé d'un paquet CIA pour le détecter
  dans la bibliothèque. Il reste optionnel pour les anciennes fiches.
- Les champs encore inconnus restent `null`.
- Les descriptions utilisent `description_en` pour l'anglais et
  `description_fr` pour le français. `description` reste accepte par les
  anciennes versions du Hub.
- `screenshots` est une liste de chemins relatifs au depot, par exemple
  `screenshots/mon-jeu/1.t3x`. Chaque fichier doit etre une feuille sprite
  Citro2D `.t3x` de 512 Kio maximum. La fiche permet de parcourir les captures;
  une liste vide affiche « Aucune capture publiée ».
- `cover` peut référencer une image `.t3x` préparée comme les captures. Les
  originaux JPG restent dans le dossier de publication pour faciliter les
  modifications; le Hub télécharge les `.t3x` référencés par `screenshots`.
- `compatibility` utilise `supported`, `unsupported` ou `unverified` pour
  `3ds` et `new_3ds`.
- `status` utilise `available`, `unavailable`, `coming_soon`, `development`
  ou `discontinued`.
- `file_type` choisit le paquet principal (`3dsx` ou `cia`). Une fiche peut
  aussi proposer un paquet CIA secondaire via `cia_url`, `cia_size_bytes` et
  `cia_sha256`. Chaque paquet doit avoir son URL HTTPS, sa taille et son SHA-256.
- Les CIA sont installés sur la carte SD avec le gestionnaire de titres 3DS;
  les `.3dsx` sont rangés dans le dossier du Hub et démarrés via Rosalina.

`hub.json` reste avec `published: false` tant qu'une version CIA n'est pas
publiee avec son empreinte SHA-256.

Le catalogue de travail reference aussi les titres de la liste de priorites
et les suggestions du plan. Les entrees sans paquet verifie restent
`coming_soon` ou `unavailable`; leurs compatibilites restent `unverified`.
Les illustrations et captures ne sont renseignees qu'apres choix de ressources
adaptees et verification de leur provenance.
