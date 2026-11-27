FLASH GAMES HUB
Plan général du projet
Version de travail — 26/11/2026

============================================================
SUIVI DU PROJET
============================================================

[fait] Lecture du plan existant et vérification du contenu du dossier.
[fait] Vérification de l'installation devkitPro : devkitARM et libctru sont présents dans C:\devkitPro.
[fait] Vérification des bibliothèques : libctru et citro2d sont présentes.
[fait] Vérification des outils : compilateur arm-none-eabi-gcc 16.1.0,
       3dsxtool, bannertool et makerom sont présents.
[fait] Repérage des points à corriger : DEVKITPRO/DEVKITARM pointent vers
       /opt/devkitpro, chemin absent sur cette machine Windows.
[fait] Vérification de make : le programme présent sous devkitPro/MSYS2
       échoue au démarrage avec une erreur de permission Windows.
[fait] Confirmation qu'aucun code source ni fichier de projet du Hub
       n'est encore présent dans le dossier ; seul ce plan a été trouvé.
[fait] Création du squelette C++ 3DS avec Makefile et source/main.cpp.
[fait] Étape 1.2 : interface double écran et quatre pages (Store,
       Bibliothèque, Mises à jour, Stockage) créées.
[fait] Navigation par croix directionnelle, L/R, A et écran tactile.
[fait] La fiche Store sélectionnée affiche nom, description, genre,
       compatibilité et disponibilité depuis le catalogue.
[fait] Vérification syntaxique du code avec le compilateur devkitARM installé.
[fait] Reconstruire le fichier .3dsx depuis MSYS2 après ajout de C2D_Prepare ;
       le lancement dans Azahar reste à vérifier en fin de projet.
[fait] Vérification du dépôt FlashGamesHub-Data fourni : dépôt public avec
       les données sur la branche principale `main`.
[fait] Préparation locale des formats catalog.json/hub.json et des dossiers
       covers/, screenshots/ et releases/ dans le dépôt de données.
[fait] Publication de la correction du README dans FlashGamesHub-Data
       (branche main, commit acc83ae).
[fait] Le catalogue initial garde les quatre World's Hardest Game
       indisponibles jusqu'à la validation de leurs fichiers et compatibilités.
[fait] La page Store affiche ces quatre jeux comme éléments à intégrer,
       sans présenter leurs fichiers comme téléchargeables.
[fait] Ajout d'un lecteur JSON version 1 avec contrôle de format et doublons,
       lecture du catalogue embarqué dans ROMFS et navigation dans ses jeux.
[fait] Séparation du clone GitHub des données et du ROMFS intégré, pour
       éviter d'embarquer les métadonnées `.git` dans l'application.
[fait] Ajout du téléchargement du catalogue par HTTPS, avec validation des
       certificats, limite de taille, validation JSON et cache SD temporaire.
[fait] Le build prépare le bundle de certificats racinaires depuis Windows.
[fait] Le chargement réseau tourne à part de l'interface ; le Hub garde son
       catalogue local quand le réseau n'est pas disponible.
[fait] Première mesure du stockage SD : capacité totale et espace libre.
[fait] Afficher la taille cumulée des jeux enregistrés et du cache local
       catalog.json/hub.json sur la page Stockage.
[fait] Makefile complété avec la structure de compilation devkitPro,
       génération CIA non prévue à cette étape et inclusion des données ROMFS.
[fait] Ajout de build.ps1 pour configurer les chemins Windows devkitPro
       au moment de la compilation, et README du projet.
[fait] Correction des chemins d'en-têtes du Makefile récursif : le dossier
       include/ est maintenant résolu depuis la racine du projet.
[fait] Vérification de syntaxe C++ directe avec devkitARM après correction ;
       corrections de mkdir et du retour du thread réseau.
[fait] Initialiser l'état graphique Citro2D avec C2D_Prepare avant de dessiner ;
       le rendu des formes et du texte était absent sur la capture Azahar.
[fait] Ajouter les titres connus du plan au catalogue de travail et afficher
       leur statut de disponibilité dans le Store.
[fait] Ajouter les fiches détaillées et le regroupement visuel des séries.
[à faire] Ajouter les affiches et captures vérifiées pendant la passe finale
       du Hub, comme convenu.
[à faire] Vérifier la connexion réseau HTTPS en fin de développement, selon
       la demande de reporter les tests.
[fait] Télécharger hub.json en HTTPS, le valider et le garder dans le cache SD.
[fait] Lire hub.json embarqué si aucun cache n'existe et afficher la version
       publiée ou l'absence de publication sur la page Mises à jour.
[fait] Comparer la version du Hub à la version publiée et signaler une mise à jour.
[fait] Afficher les notes de version et la version minimale requise dans la page.
[fait] Étape 1.7 : détection et installation des mises à jour des jeux installés.
[fait] Définir le format schema 1 de installed.json et lire les jeux installés
       depuis la carte SD.
[fait] Comparer les versions installées au catalogue et compter les mises à jour.
[fait] Afficher la bibliothèque et signaler les jeux qui ont une mise à jour.
[fait] Ajouter un module pour créer/mettre à jour installed.json après une
       installation et retirer une entrée après une désinstallation.
[fait] Charger la bibliothèque depuis ce module au démarrage ; reconstruire
       l'application avec MSYS2 sans avertissement.
[fait] Depuis la page Mises à jour, télécharger le premier jeu installé ayant
       une version catalogue plus récente, vérifier taille et SHA-256, puis
       remplacer son fichier via un temporaire en gardant l'ancienne version
       en cas d'échec ; les sauvegardes restent séparées.
[fait] Rendre le remplacement de installed.json récupérable si la sauvegarde
       du manifeste ou son renommage échoue.
[à faire] Relier l'enregistrement de installed.json à l'installation initiale
       des jeux et intégrer une méthode de lancement compatible 3DS.
[fait] Étape 1.8 : catalogue du Store, fiches disponibles et séries regroupées.
[fait] Recherche avec le clavier 3DS, filtre de genre et filtre des favoris.
[fait] Sauvegarde des favoris sur la carte SD, avec signalement si l'écriture échoue.
[fait] Ajouter les titres prioritaires et les autres suggestions du plan au
       catalogue de travail sans les annoncer disponibles.
[fait] Catalogue de travail porte a 61 fiches, dont les quatre World's
       Hardest Game et les titres prioritaires et suggestions du plan.
[fait] Regrouper les séries depuis leur identifiant et leur nom explicites
       dans les fiches de catalogue, avec détection historique par nom en repli.
[fait] La fiche détaillée du Store présente la description, le genre, le
       développeur, la compatibilité, la version et la taille quand connus.
[reporté à la passe finale] Affiches et captures vérifiées pour les jeux.
[reporté à la passe finale] Compléter les genres et descriptions après
       vérification des titres; les fiches de travail ne valent pas validation.
[en cours] Étape 1.9 : bibliothèque des jeux installés.
[fait] Afficher le nom, la version, la taille et l'état de mise à jour.
[fait] Ajouter les favoris dans la bibliothèque et la mise à jour du jeu
       sélectionné.
[fait] Désinstaller un jeu avec confirmation et mise à jour de installed.json;
       ses sauvegardes séparées sont conservées.
[à faire] Ajouter le lancement direct des jeux .3dsx avec le chargeur Homebrew
       pris en charge par l'environnement de lancement.
[fait] Repérer à la racine les paquets de test whg-hub-3ds.3dsx (47 192 056
       octets) et whg-hub-3ds.cia (47 756 224 octets); le .3dsx porte la
       signature 3DSX. SHA-256 .3dsx :
       1f6697dbf90a17c0e2282eb7b46ea8e47d57b150342ee3a9f854646cd714b72a
       SHA-256 .cia :
       a390785c6b493a0dfc79f45e0b685e660640d58ebd371b0302bf855dabb267a0.
[à faire] Tester un téléchargement réseau réel après publication des paquets
       sur une URL HTTPS; ne pas déclarer le jeu disponible avant cette étape.
[fait] Préparer github-upload/whg-v1.0.0-test avec les deux paquets et les
       instructions de publication manuelle comme assets d'une GitHub Release.
[fait] Ajouter au catalogue local la fiche de test du World's Hardest Game 1,
       en développement, avec l'URL prévue, la taille et le SHA-256 du .3dsx.
[fait] Autoriser depuis le Store le téléchargement initial d'un paquet .3dsx
       de test, puis valider son empreinte et l'ajouter à la bibliothèque.
[à faire] Publier la release et data/catalog.json, puis vérifier le
       téléchargement HTTPS depuis une console ou un émulateur.
[à faire] Ajouter le téléchargement et l'installation des CIA dans l'étape
       d'installation; le CIA de test est préparé comme asset séparé.
[à faire] Vérifier la détection réseau de catalog.json et hub.json en fin de
       développement, selon la demande de reporter les tests.
[à faire] Mesurer la taille des jeux et du cache dans la page Stockage.
[fait] Le script de compilation définit les chemins Windows DEVKITPRO et DEVKITARM.
[fait] Corriger l'appel récursif de make et les variables devkitPro ; lancer
       directement le Makefile dans MSYS2.
[fait] Produire FlashGamesHub.3dsx depuis les sources avec MSYS2.
[fait] Reconstruire proprement le projet : compilation et édition de liens
       réussies sans avertissement.
[fait] Recompiler depuis MSYS2 après l'ajout de la mesure du cache.
[à faire] Effectuer les tests sur console/emulateur uniquement apres la fin
       du Hub, comme demandé.
[à faire] Développer les modules du Hub selon les étapes ci-dessous.

============================================================
OBJECTIF DU PROJET
============================================================

Créer un Homebrew Nintendo 3DS / New 3DS en C et C++.

Le Hub sera le pilier du projet :
- un Store avec les jeux, leurs affiches et descriptions ;
- un catalogue distant hébergé sur GitHub ;
- une bibliothèque des jeux installés ;
- la détection des mises à jour du Hub et des jeux ;
- le téléchargement, l'installation et la désinstallation ;
- une page de stockage.

Les jeux seront téléchargés séparément. Le CIA du Hub ne contiendra pas toute la collection.

Technologies envisagées :
- C / C++
- devkitPro / devkitARM
- libctru
- citro2d pour l'interface 2D
- JSON pour le catalogue
- GitHub pour héberger le catalogue et les versions publiées

============================================================
GRANDE ÉTAPE 1 — DÉVELOPPEMENT DU HUB
============================================================

Le Hub est le pilier du projet. Il doit être construit et testé avant
l'intégration de nouveaux jeux.

1.1 — Préparation du projet
- Préparer l'environnement devkitPro.
- Créer le projet C/C++ compilable pour la 3DS.
- Organiser les dossiers source, include, assets et data.
- Séparer les fonctionnalités dans différents fichiers/modules.

1.2 — Interface principale
Créer les pages principales :
- STORE : catalogue de tous les jeux.
- BIBLIOTHÈQUE : jeux installés.
- MISES À JOUR : mises à jour disponibles.
- STOCKAGE : espace libre et espace utilisé par le Hub.

L'interface doit être adaptée aux deux écrans de la 3DS et aux commandes
de la console.

1.3 — Dépôt GitHub des données
Créer un dépôt séparé, par exemple :
FlashGamesHub-Data/

Organisation proposée :
- catalog.json : catalogue complet des jeux.
- hub.json : informations de version du Hub.
- covers/ : affiches des jeux.
- screenshots/ : captures de gameplay.
- releases/ : informations et fichiers publiés.

1.4 — Catalogue catalog.json
Le catalogue contiendra tous les jeux, même ceux qui ne sont pas encore
disponibles.

Chaque fiche de jeu contiendra :
- identifiant unique ;
- nom ;
- description ;
- genre ;
- développeur ;
- affiche ;
- captures d'écran ;
- statut de disponibilité ;
- compatibilité 3DS / New 3DS ;
- version ;
- taille du fichier ;
- URL de téléchargement ;
- empreinte SHA-256.

Statuts possibles :
- available : jeu disponible ;
- unavailable : jeu pas encore disponible ;
- coming_soon : jeu prévu ;
- development : jeu en développement ;
- discontinued : projet abandonné.

La disponibilité pourra être différente entre 3DS et New 3DS.

1.5 — Connexion GitHub
Au démarrage :
- vérifier la connexion Internet ;
- récupérer le catalogue depuis GitHub ;
- vérifier que le JSON est valide ;
- actualiser les informations du Store ;
- comparer les versions du Hub et des jeux installés.

Si la connexion échoue, utiliser le dernier catalogue enregistré localement.
Les images déjà téléchargées pourront être conservées dans un cache local.

1.6 — Mise à jour du Hub
Le fichier hub.json indiquera :
- dernière version ;
- version minimale requise ;
- URL du CIA ;
- notes de version ;
- empreinte SHA-256.

Si une version plus récente est publiée, le Hub affichera une notification.
La détection sera développée avant l'installation automatique.
Le Hub ne doit pas tenter de remplacer son propre programme pendant qu'il
est en cours d'exécution.

1.7 — Mise à jour des jeux
Pour chaque jeu :
- comparer la version installée à la version du catalogue ;
- afficher la mise à jour disponible ;
- permettre à l'utilisateur de choisir quand la télécharger ;
- vérifier le fichier téléchargé ;
- préserver les sauvegardes ;
- éviter les installations incomplètes.

1.8 — Store
Le Store affichera :
- affiches ;
- captures d'écran ;
- descriptions ;
- genre et développeur ;
- compatibilité ;
- version et taille ;
- statut du jeu ;
- bouton Télécharger ou indication Indisponible.

Fonctions prévues :
- recherche ;
- catégories ;
- favoris ;
- fiches détaillées ;
- regroupement des jeux par série.

Les épisodes d'une série seront regroupés visuellement, mais leurs versions
et leurs fichiers resteront indépendants.

1.9 — Bibliothèque
Afficher les jeux installés avec :
- nom et affiche ;
- version installée ;
- taille ;
- lancement ;
- mise à jour ;
- désinstallation ;
- favoris.

Un fichier local installed.json enregistrera les jeux installés.

1.10 — Téléchargement et installation
Après le Store :
- téléchargement individuel ;
- barre de progression ;
- vérification SHA-256 ;
- installation dans le bon dossier ;
- enregistrement de la version ;
- gestion des erreurs ;
- protection des sauvegardes lors des mises à jour.

Attention : un fichier .3dsx ou .cia ne peut pas être exécuté comme un
simple module à l'intérieur du Hub. Le système de lancement devra respecter
les méthodes compatibles avec l'environnement Homebrew 3DS.

1.11 — Stockage
Afficher :
- capacité totale de la carte SD ;
- espace libre ;
- espace occupé par les jeux du Hub ;
- espace utilisé par le cache ;
- taille de chaque jeu ;
- option pour vider le cache.

1.12 — Tests et première publication
Tester :
- sur 3DS et New 3DS ;
- sans connexion Internet ;
- avec catalogue incorrect ou incomplet ;
- avec images manquantes ;
- avec jeux indisponibles ;
- avec mises à jour ;
- avec téléchargements interrompus.

Objectif de la grande étape 1 :
Un Hub fonctionnel, publié en CIA, avec Store connecté à GitHub,
catalogue complet, bibliothèque et détection des mises à jour.

============================================================
GRANDE ÉTAPE 2 — DÉVELOPPEMENT ET INTÉGRATION DES JEUX
============================================================

IMPORTANT : THE WORLD'S HARDEST GAME

Les quatre jeux de The World's Hardest Game sont DÉJÀ DÉVELOPPÉS.
Ils ne sont pas à refaire.

Ils serviront de première collection et de base de référence pour :
- intégrer des jeux déjà terminés dans le Hub ;
- préparer leurs fiches dans catalog.json ;
- organiser leurs fichiers ;
- tester la compatibilité ;
- vérifier le téléchargement et la mise à jour ;
- valider la bibliothèque et le lancement.

Le premier jeu de la collection sera donc le premier jeu à intégrer au Hub
pour valider le processus complet. Les quatre épisodes seront présentés
ensemble dans une collection, avec une fiche et une version propres à chaque
jeu.

============================================================
CONVERSION / PORTAGE DES JEUX FLASH
============================================================

Les jeux Flash originaux sont généralement des fichiers .SWF
(Shockwave Flash). « CWF » n'est probablement pas le format recherché.

Un fichier SWF ne peut pas être simplement renommé en .3dsx ou .cia.
Il faudra convertir ou porter le jeu pour qu'il fonctionne sur 3DS.

Pour chaque jeu Flash :
1. Identifier le fichier SWF et les ressources disponibles.
2. Examiner le gameplay, les graphismes, les sons et les commandes.
3. Déterminer si un moteur ou runtime compatible 3DS est réaliste.
4. Si nécessaire, recréer le fonctionnement du jeu en C/C++.
5. Adapter l'écran tactile, les boutons et les deux écrans de la 3DS.
6. Tester les performances et la mémoire.
7. Préparer un exécutable 3DS et les données nécessaires.
8. Ajouter la fiche au catalogue GitHub après validation.

Le portage ne sera pas forcément une conversion automatique :
certains jeux devront être réécrits ou adaptés. Les ressources extraites
du jeu original ne suffisent pas toujours à recréer son fonctionnement.

Les jeux qui sont déjà portés ou développés ne devront pas être refaits :
on les intégrera directement, après vérification de leur format et de leur
compatibilité avec le Hub.

============================================================
ORDRE DE TRAVAIL POUR LES JEUX — POPULARITÉ DES DEMANDES
============================================================

L'ordre des prochains jeux doit suivre les demandes reçues dans les
commentaires Reddit : les jeux ou séries les plus demandés seront étudiés
en premier.

IMPORTANT :
- Cet ordre est une estimation à partir des demandes et répétitions
  mentionnées dans les commentaires disponibles.
- Ce n'est pas un classement officiel ni un comptage exact de tous les
  commentaires Reddit.
- Quand de nouvelles demandes arrivent, le catalogue de travail sera mis
  à jour et l'ordre pourra changer.
- Les quatre jeux The World's Hardest Game sont déjà développés. Ils
  servent de première collection de test et ne sont pas comptés comme
  nouveaux portages à réaliser.

1. JEUX / SÉRIES LES PLUS DEMANDÉS — PRIORITÉ HAUTE

1. Fancy Pants Adventures
2. Bloxorz
3. Riddle School
4. Super Mario Starcatcher
5. Super Mario 63
6. Chaos Faction 2
7. Swords and Sandals 3
8. Swords and Sandals 4
9. Sonny
10. Earn to Die
11. Papa's Games :
    - Papa's Pizzeria
    - Papa's Burgeria
    - Papa's Freezeria
    - Papa's Hot Doggeria
    - autres épisodes demandés
12. Car Eats Car
13. Snail Bob
14. Wheely
15. Fireboy and Watergirl
16. Truck Loader
17. Drag Racer V3
18. Boxhead
19. The Run series, notamment Run 3
20. Ninja Kitchen
21. Moto X3M
22. Plazma Burst 1
23. Plazma Burst 2
24. Raze 1
25. Raze 2
26. Raze 3
27. World of Goo

2. AUTRES DEMANDES À GARDER DANS LE CATALOGUE DE TRAVAIL

Les titres ci-dessous ont aussi été évoqués dans les suggestions recueillies
ou dans les échanges du projet. Ils restent à vérifier et à classer selon
les demandes exactes et leur fréquence :

- Super Smash Flash
- Super Mario Crossover
- Ultimate Flash Sonic
- Duck Life
- Red Ball
- The Impossible Quiz
- Age of War
- Dino Run
- Bad Ice Cream
- Bloons TD
- Raft Wars
- Strike Force Heroes
- Henry Stickmin
- Sonic RPG
- Mario Combat
- Pokémon Tower Defense
- Gravitee Wars
- Submachine
- Zombotron
- Armor Mayhem
- Electricman
- Castle Clasher
- Power Pamplona
- Epic Battle Fantasy 3
- Neopets
- BFDIA 5B
- Pico's School
- The Pirates (Nitrome)
- Zelda and the Lampshade of No Real Significance

Ces titres sont des idées à conserver dans le catalogue de travail ; ils
ne doivent pas être présentés comme des demandes confirmées du Reddit
tant que leurs commentaires d'origine n'ont pas été vérifiés.

3. PREMIÈRE COLLECTION D'INTÉGRATION — DÉJÀ DÉVELOPPÉE

The World's Hardest Game :
- The World's Hardest Game 1 — déjà développé.
- The World's Hardest Game 2 — déjà développé.
- The World's Hardest Game 3 — déjà développé.
- The World's Hardest Game 4 — déjà développé.

Ces quatre jeux seront intégrés au Hub en premier pour tester le processus
complet : fiches, versions, compatibilité, téléchargement, bibliothèque
et lancement. Ils ne sont pas à refaire.

============================================================
MÉTHODE POUR CHAQUE NOUVEAU JEU
============================================================

1. Étudier le jeu original et ses mécaniques.
2. Examiner les fichiers et ressources disponibles.
3. Déterminer la méthode de portage ou de conversion.
4. Développer ou adapter le jeu en C/C++.
5. Adapter les commandes et l'affichage à la 3DS.
6. Tester sur 3DS et New 3DS.
7. Préparer l'exécutable, les données et la version.
8. Créer l'affiche, les captures et la description.
9. Ajouter ou mettre à jour la fiche dans catalog.json.
10. Publier le jeu après validation.

============================================================
RÈGLES IMPORTANTES DU PROJET
============================================================

- Le Hub et les jeux sont distribués séparément.
- Ne pas inclure toute la collection dans le CIA du Hub.
- Ajouter des jeux au catalogue sans republier le Hub.
- Chaque jeu possède un identifiant unique.
- Chaque jeu possède sa propre version.
- La compatibilité 3DS / New 3DS est indiquée séparément.
- Le Hub garde une copie locale du catalogue pour le mode hors ligne.
- Les mises à jour ne doivent pas effacer les sauvegardes.
- Vérifier les fichiers téléchargés avec leur empreinte.
- Un jeu n'est marqué disponible qu'après test.
- Les jeux déjà développés, notamment les quatre World's Hardest Game,
  sont intégrés et testés, pas recommencés.

============================================================
RÉSULTAT FINAL
============================================================

Un Hub Homebrew 3DS en C/C++ avec :
- Store complet et actualisé depuis GitHub ;
- affiches, captures et descriptions ;
- collections de jeux ;
- bibliothèque ;
- téléchargement et installation ;
- mises à jour du Hub et des jeux ;
- stockage et gestion du cache ;
- lancement des jeux selon une méthode compatible 3DS.

Le développement commence par le Hub, puis la collection déjà développée
The World's Hardest Game servira de première intégration et de test complet.
