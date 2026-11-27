#include <3ds.h>
#include <citro2d.h>
#include "catalog.hpp"
#include "catalog_network.hpp"
#include "embedded_romfs.hpp"
#include "installed_games.hpp"

#include <cmath>
#include <cstddef>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <sys/stat.h>

namespace {

// ---------------------------------------------------------------------------
// Constantes
// ---------------------------------------------------------------------------

constexpr int kTopWidth = 400;
constexpr int kBottomWidth = 320;
constexpr int kScreenHeight = 240;
constexpr int kPageCount = 5;
constexpr std::size_t kMaxFavorites = 64;
constexpr std::size_t kMaxGenres = 16;
constexpr float kDepth = 0.5f;
constexpr const char* kHubVersion = "0.1.3-dev";
constexpr const char* kDataDirectory = "sdmc:/3ds/FlashGamesHub";
constexpr const char* kFavoritesPath = "sdmc:/3ds/FlashGamesHub/favorites.txt";
constexpr const char* kFavoritesTempPath = "sdmc:/3ds/FlashGamesHub/favorites.txt.tmp";
constexpr const char* kCachedCatalogPath = "sdmc:/3ds/FlashGamesHub/catalog.json";
constexpr const char* kCachedManifestPath = "sdmc:/3ds/FlashGamesHub/hub.json";
constexpr const char* kSettingsPath = "sdmc:/3ds/FlashGamesHub/settings.txt";
constexpr const char* kSettingsTempPath = "sdmc:/3ds/FlashGamesHub/settings.txt.tmp";

enum Page : int {
    kPageStore = 0,
    kPageLibrary,
    kPageUpdates,
    kPageStorage,
    kPageSettings,
};

constexpr const char* kTabLabels[kPageCount] = {"Boutique", "Jeux", "Màj", "Stockage", "Réglages"};

// Palette : un fond sombre neutre, une seule couleur d'accent, des couleurs
// d'etat reservees aux statuts.
constexpr u32 kBg = C2D_Color32(14, 15, 20, 255);
constexpr u32 kSurface = C2D_Color32(24, 26, 34, 255);
constexpr u32 kSurface2 = C2D_Color32(34, 37, 48, 255);
constexpr u32 kBorder = C2D_Color32(46, 50, 64, 255);
constexpr u32 kText = C2D_Color32(235, 237, 243, 255);
constexpr u32 kMuted = C2D_Color32(172, 178, 196, 255);
constexpr u32 kFaint = C2D_Color32(128, 135, 154, 255);
constexpr u32 kAccent = C2D_Color32(255, 128, 66, 255);
constexpr u32 kAccentDim = C2D_Color32(64, 40, 32, 255);
constexpr u32 kOnAccent = C2D_Color32(24, 16, 12, 255);
constexpr u32 kWhite = C2D_Color32(255, 255, 255, 235);
constexpr u32 kOk = C2D_Color32(96, 198, 132, 255);
constexpr u32 kWarn = C2D_Color32(240, 186, 78, 255);
constexpr u32 kInfo = C2D_Color32(116, 156, 240, 255);
constexpr u32 kBad = C2D_Color32(228, 100, 100, 255);

constexpr u32 kTilePalette[6] = {
    C2D_Color32(206, 108, 84, 255), C2D_Color32(86, 142, 206, 255), C2D_Color32(92, 166, 126, 255),
    C2D_Color32(164, 122, 196, 255), C2D_Color32(204, 160, 80, 255), C2D_Color32(80, 160, 170, 255),
};

// Mise en page de l'ecran du bas.
constexpr float kTabBarHeight = 32.0f;
constexpr float kTabWidth = 64.0f;
constexpr float kFooterY = 208.0f;
constexpr float kChipY = 40.0f;
constexpr float kChipHeight = 22.0f;
constexpr float kStoreListTop = 70.0f;
constexpr float kStoreRowHeight = 27.0f;
constexpr std::size_t kStoreRows = 5;
constexpr float kStoreDetailBackX = 16.0f;
constexpr float kStoreDetailFormatX = 76.0f;
constexpr float kStoreDetailDownloadX = 166.0f;
constexpr float kStoreDetailButtonY = 174.0f;
constexpr float kStoreDetailButtonH = 26.0f;
constexpr float kLibraryListTop = 44.0f;
constexpr float kLibraryRowHeight = 27.0f;
constexpr std::size_t kLibraryRows = 6;
constexpr float kFavoriteHitX = 274.0f;
constexpr float kPanelButtonX = 95.0f;
constexpr float kPanelButtonY = 142.0f;
constexpr float kPanelButtonW = 130.0f;
constexpr float kPanelButtonH = 26.0f;
constexpr float kRefreshButtonX = 10.0f;
constexpr float kRefreshButtonY = 164.0f;
constexpr float kRefreshButtonW = 300.0f;
constexpr float kRefreshButtonH = 32.0f;
constexpr float kGameUpdateButtonX = 166.0f;
constexpr float kGameUpdateButtonW = 144.0f;
constexpr float kLangFrX = 22.0f;
constexpr float kLangEnX = 162.0f;
constexpr float kLangY = 76.0f;
constexpr float kLangW = 128.0f;
constexpr float kLangH = 34.0f;
constexpr float kClearCacheX = 10.0f;
constexpr float kClearCacheY = 174.0f;
constexpr float kClearCacheW = 300.0f;
constexpr float kClearCacheH = 26.0f;

// ---------------------------------------------------------------------------
// Etat
// ---------------------------------------------------------------------------

C3D_RenderTarget* gTop = nullptr;
C3D_RenderTarget* gBottom = nullptr;
C2D_TextBuf gTextBuffer = nullptr;
C2D_TextBuf gMeasureBuffer = nullptr;
C2D_SpriteSheet gStoreScreenshotSheet = nullptr;
char gStoreScreenshotSheetPath[256]{};
char gPendingScreenshotCachePath[256]{};
bool gScreenshotLoading = false;
bool gScreenshotFailed = false;

GameCatalog gCatalog{};
GameCatalog gCachedCatalog{};
GameCatalog gDownloadedCatalog{};
HubManifest gHubManifest{};
HubManifest gDownloadedHubManifest{};
InstalledGameList gInstalledGames{};
bool gCatalogLoaded = false;
bool gHubManifestLoaded = false;
bool gInstalledGamesLoaded = false;
bool gRomfsReady = false;
bool gStorageAvailable = false;
u64 gStorageFreeBytes = 0;
u64 gStorageTotalBytes = 0;
u64 gCachedInstalledBytes = 0;
u64 gCachedCatalogDataBytes = 0;
bool gQuit = false;
u64 gRelaunchTitleId = 0;
bool gDownloading = false;
bool gConfirmUninstall = false;
bool gStoreDetailOpen = false;
std::size_t gStoreDetailGameIndex = GameCatalog::kMaxGames;
std::size_t gStoreScreenshotIndex = 0;

int gCurrentPage = kPageStore;
float gTabIndicator = 0.0f;
float gStoreScrollAnim = 0.0f;
float gLibraryScrollAnim = 0.0f;
float gStoreSelAnim = 0.0f;
float gLibrarySelAnim = 0.0f;
float gProgressAnim = 0.0f;
unsigned gFrame = 0;
unsigned gHoldFrames = 0;

char gGenres[kMaxGenres][48]{};
std::size_t gGenreCount = 0;
std::size_t gGenreFilterIndex = 0;
char gSearchQuery[128]{};
bool gFavoritesOnly = false;
bool gStoreCiaFormat = false;
bool gIsNew3DS = false;
bool gConsoleModelKnown = false;
std::size_t gFiltered[GameCatalog::kMaxGames]{};
std::size_t gGroupCount[GameCatalog::kMaxGames]{};  // nombre de jeux regroupes dans chaque ligne
bool gGroupMixed[GameCatalog::kMaxGames]{};         // statuts differents dans le groupe
std::size_t gFilteredCount = 0;
std::size_t gStoreSel = 0;
std::size_t gStoreScroll = 0;
std::size_t gLibrarySel = 0;
std::size_t gLibraryScroll = 0;

char gFavoriteIds[kMaxFavorites][64]{};
std::size_t gFavoriteCount = 0;

char gToast[64]{};
int gToastFrames = 0;

int gLang = 1;  // 0 = francais, 1 = anglais

// Les textes de l'interface sont ecrits en francais dans le code ; L() renvoie la
// version anglaise quand la langue choisie est l'anglais.
struct Translation {
    const char* fr;
    const char* en;
};
constexpr Translation kTranslations[] = {
    {"Disponible", "Available"},
    {"Indisponible", "Unavailable"},
    {"Bientôt", "Coming soon"},
    {"En dev.", "In dev."},
    {"En développement", "In development"},
    {"Terminé", "Finished"},
    {"Arrêté", "Discontinued"},
    {"Inconnu", "Unknown"},
    {"Compatible", "Compatible"},
    {"Non compatible", "Incompatible"},
    {"Non vérifié", "Unverified"},
    {"Retiré des favoris", "Removed from favorites"},
    {"Échec de l'écriture sur la carte SD", "SD card write failed"},
    {"Limite de favoris atteinte", "Favorites limit reached"},
    {"Ajouté aux favoris", "Added to favorites"},
    {"Nom, genre ou description", "Name, genre or description"},
    {"Annuler", "Cancel"},
    {"Cache catalogue  %s", "Catalog cache  %s"},
    {"Capture indisponible", "Screenshot unavailable"},
    {"Téléchargement indisponible", "Download unavailable"},
    {"Format", "Format"},
    {"Genre", "Genre"},
    {"Effacer", "Clear"},
    {"Chercher", "Search"},
    {"Manifeste indisponible", "Manifest unavailable"},
    {"Aucune version publiée", "No published version"},
    {"Nouvelle version disponible", "New version available"},
    {"Hub à jour", "Hub up to date"},
    {"Synchronisation", "Syncing"},
    {"En ligne", "Online"},
    {"Hors ligne", "Offline"},
    {"Catalogue absent", "No catalog"},
    {"Catalogue local", "Local catalog"},
    {"Aucune information", "No information"},
    {"Aucune description.", "No description."},
    {"Favori", "Favorite"},
    {"Chargement du catalogue", "Loading catalog"},
    {"Connexion en cours...", "Connecting..."},
    {"Catalogue indisponible", "Catalog unavailable"},
    {"Vérifiez la connexion Wi-Fi, puis actualisez.", "Check your Wi-Fi connection, then refresh."},
    {"Aucun résultat", "No results"},
    {"Aucun jeu ne correspond à la recherche ou aux filtres.", "No game matches the search or filters."},
    {"Aucun jeu installé", "No installed games"},
    {"Les jeux installés apparaîtront ici.", "Installed games will appear here."},
    {"Mise à jour", "Update"},
    {"À jour", "Up to date"},
    {"VERSION INSTALLÉE", "INSTALLED VERSION"},
    {"VERSION DU CATALOGUE", "CATALOG VERSION"},
    {"Inconnue", "Unknown"},
    {"TAILLE SUR LA CARTE SD", "SIZE ON SD CARD"},
    {"Dernière version  %s", "Latest version  %s"},
    {"Minimum requis  %s", "Minimum required  %s"},
    {"Connectez-vous pour vérifier les versions.", "Connect to check versions."},
    {"JEUX", "GAMES"},
    {"mises à jour", "updates"},
    {"mise à jour", "update"},
    {"disponible", "available"},
    {"Aucune donnée", "No data"},
    {"Carte SD indisponible", "SD card unavailable"},
    {"Insérez une carte SD pour voir l'espace disponible.", "Insert an SD card to see free space."},
    {"CARTE SD", "SD CARD"},
    {"libres", "free"},
    {"%s utilisés (%u %%)", "%s used (%u %%)"},
    {"Jeux installés  %s", "Installed games  %s"},
    {"Genre : %s", "Genre: %s"},
    {"Tous", "All"},
    {"Rechercher", "Search"},
    {"Favoris", "Favorites"},
    {"Réessayer", "Retry"},
    {"Réinitialiser", "Reset"},
    {"Aucun catalogue valide n'est chargé.", "No valid catalog is loaded."},
    {"Modifiez la recherche ou les filtres.", "Change the search or filters."},
    {"Jeu %u sur %u", "Game %u of %u"},
    {"%u jeu(x) installé(s)", "%u installed game(s)"},
    {"Installée %s  ·  Dernière %s", "Installed %s  ·  Latest %s"},
    {"Installée %s", "Installed %s"},
    {"JEUX INSTALLÉS", "INSTALLED GAMES"},
    {"Tout est à jour", "Everything is up to date"},
    {"%u mise(s) à jour disponible(s)", "%u update(s) available"},
    {"Actualisation...", "Refreshing..."},
    {"Actualiser", "Refresh"},
    {"Télécharger la mise à jour", "Download update"},
    {"Télécharger", "Download"},
    {"Installer CIA", "Install CIA"},
    {"Format .3dsx", ".3dsx format"},
    {"Format .cia", ".cia format"},
    {"Installation CIA...", "Installing CIA..."},
    {"Fiche du jeu", "Game details"},
    {"Retour", "Back"},
    {"Épisodes", "Episodes"},
    {"Captures d’écran", "Screenshots"},
    {"Aucune capture publiée", "No screenshots published"},
    {"Chargement de la capture...", "Loading screenshot..."},
    {"Ouvrir la fiche", "Open details"},
    {"Télécharger .3dsx", "Download .3dsx"},
    {"Jeu installé", "Game installed"},
    {"Échec de l'installation", "Installation failed"},
    {"Désinstallation indisponible", "Uninstall unavailable"},
    {"Jeu supprimé, bibliothèque à actualiser", "Game removed; refresh library"},
    {"Boutique", "Store"},
    {"A classer", "Uncategorized"},
    {"Arcade / labyrinthe", "Arcade / maze"},
    {"Total %s", "Total %s"},
    {"Ép. %u", "Ep. %u"},
    {"Titre CIA introuvable", "CIA title not found"},
    {"Lancement CIA impossible", "Cannot launch CIA"},
    {"Compatibilité non vérifiée", "Compatibility is unverified"},
    {"Modèle de console indisponible", "Console model unavailable"},
    {"Clavier de recherche indisponible", "Search keyboard unavailable"},
    {"Téléchargement terminé", "Download complete"},
    {"Téléchargement  %u %%", "Downloading  %u %%"},
    {"Jeu déjà installé", "Game already installed"},
    {"Déjà installé", "Already installed"},
    {"Mettre à jour", "Update"},
    {"Hub mis à jour", "Hub updated"},
    {"Échec de la mise à jour du Hub", "Hub update failed"},
    {"Màj Hub", "Update Hub"},
    {"Màj Jeux", "Update Games"},
    {"Captures", "Screenshots"},
    {"Téléchargement...", "Downloading..."},
    {"Aucune mise à jour", "No update available"},
    {"Mise à jour installée", "Update installed"},
    {"Échec, version précédente conservée", "Failed; previous version kept"},
    {"Cache catalogue", "Catalog cache"},
    {"Vider le cache", "Clear cache"},
    {"Cache vidé", "Cache cleared"},
    {"Échec du vidage du cache", "Failed to clear cache"},
    {"Fichier vérifié", "File verified"},
    {"Espace libre", "Free space"},
    {"Espace utilisé", "Used space"},
    {"Capacité totale", "Total capacity"},
    {"Jeux installés", "Installed games"},
    {"Les mesures s'afficheront ici.", "Measurements will appear here."},
    {"Synchronisation...", "Syncing..."},
    {"Jeux", "Games"},
    {"Màj", "Updates"},
    {"Stockage", "Storage"},
    {"Réglages", "Settings"},
    {"Onglets", "Tabs"},
    {"Quitter", "Quit"},
    {"Divers", "Mixed"},
    {"LANGUE", "LANGUAGE"},
    {"Langue", "Language"},
    {"Langue enregistrée", "Language saved"},
    {"Choisissez la langue de l'interface.", "Choose the interface language."},
    {"Appuyez sur A ou touchez un bouton pour changer.", "Press A or tap a button to change."},
    {"Chargeur Homebrew indisponible", "Homebrew loader unavailable"},
    {"Fichier de jeu introuvable", "Game file not found"},
    {"A pour confirmer la désinstallation", "Press A to confirm uninstall"},
    {"Désinstallation annulée", "Uninstall cancelled"},
    {"Jeu désinstallé", "Game uninstalled"},
    {"Échec de la désinstallation", "Uninstall failed"},
    {"Aucun fichier de jeu trouvé", "Game file not found"},
    {"Lancer", "Launch"},
    {"Retirer", "Remove"},
    {"Désinstaller", "Uninstall"},
    {"Confirmer la désinstallation", "Confirm uninstall"},
};

const char* L(const char* fr) {
    if (gLang == 0 || !fr) return fr;
    for (const Translation& entry : kTranslations) {
        if (std::strcmp(entry.fr, fr) == 0) return entry.en;
    }
    return fr;
}

const char* localizedGenre(const char* genre) {
    return L(genre);
}


// ---------------------------------------------------------------------------
// Texte : dessin, mesure, ellipse et retour a la ligne
// ---------------------------------------------------------------------------

constexpr int kMaxWrapLines = 6;
constexpr std::size_t kWrapLineBytes = 112;
constexpr std::size_t kMaxLineBytes = 100;
constexpr std::size_t kMaxWordBytes = 64;

struct WrappedText {
    char lines[kMaxWrapLines][kWrapLineBytes];
    int count;
};

struct WrapCache {
    u32 key;
    bool valid;
    WrappedText text;
};

WrapCache gDescriptionWrap{};
WrapCache gNotesWrap{};

// Les petites tailles et les positions fractionnaires rendent le texte flou
// (la police est une texture filtree). On impose une taille minimale lisible
// et on aligne chaque texte sur un pixel entier.
// La police systeme fait 30 px de haut a l'echelle 1.0. Si la hauteur finale n'est
// pas un nombre entier de pixels, chaque glyphe est re-echantillonne (filtre
// lineaire) et devient flou : on arrondit donc a un nombre entier de pixels.
float crisp(float scale) {
    int px = static_cast<int>(scale * 30.0f + 0.5f);
    if (px < 12) px = 12;
    return static_cast<float>(px) / 30.0f;
}

float lineHeight(float scale) { return crisp(scale) * 30.0f; }

bool isContinuationByte(char c) { return (static_cast<unsigned char>(c) & 0xC0) == 0x80; }

void drawRect(float x, float y, float width, float height, u32 color) {
    C2D_DrawRectSolid(x, y, kDepth, width, height, color);
}

// Rectangle aux coins legerement arrondis.
void drawCard(float x, float y, float width, float height, u32 color) {
    drawRect(x + 2, y, width - 4, height, color);
    drawRect(x, y + 2, width, height - 4, color);
    drawRect(x + 1, y + 1, width - 2, height - 2, color);
}

void drawCardOutlined(float x, float y, float width, float height, u32 fill, u32 border) {
    drawCard(x, y, width, height, border);
    drawCard(x + 1, y + 1, width - 2, height - 2, fill);
}

void drawPill(float x, float y, float width, float height, u32 color) {
    const float radius = height / 2.0f;
    drawRect(x + radius, y, width - height, height, color);
    C2D_DrawCircleSolid(x + radius, y + radius, kDepth, radius, color);
    C2D_DrawCircleSolid(x + width - radius, y + radius, kDepth, radius, color);
}

void copyBoundedText(char* output, std::size_t capacity, const char* input) {
    if (!output || capacity == 0) return;
    if (!input) input = "";
    std::size_t length = std::strlen(input);
    if (length >= capacity) length = capacity - 1;
    std::memcpy(output, input, length);
    output[length] = '\0';
}

void drawText(const char* value, float x, float y, float scale, u32 color) {
    if (!value || !value[0]) return;
    scale = crisp(scale);
    x = std::floor(x + 0.5f);
    y = std::floor(y + 0.5f);
    C2D_Text text;
    C2D_TextParse(&text, gTextBuffer, value);
    C2D_TextOptimize(&text);
    C2D_DrawText(&text, C2D_WithColor, x, y, kDepth, scale, scale, color);
}

void drawBold(const char* value, float x, float y, float scale, u32 color) {
    if (!value || !value[0]) return;
    scale = crisp(scale);
    x = std::floor(x + 0.5f);
    y = std::floor(y + 0.5f);
    C2D_Text text;
    C2D_TextParse(&text, gTextBuffer, value);
    C2D_TextOptimize(&text);
    C2D_DrawText(&text, C2D_WithColor, x, y, kDepth, scale, scale, color);
}

// Mesurer un texte coute cher (parse + dimensions). fitText et wrapText le font des
// dizaines de fois par image : on memorise les largeurs deja calculees.
struct WidthEntry {
    u32 h1;
    u32 h2;
    float width;
    bool used;
};
constexpr std::size_t kWidthCacheSize = 512;
WidthEntry gWidthCache[kWidthCacheSize]{};

float textWidth(const char* value, float scale) {
    if (!value || !value[0]) return 0.0f;
    scale = crisp(scale);
    u32 h1 = 2166136261u;
    u32 h2 = 5381u;
    for (const char* c = value; *c; ++c) {
        h1 = (h1 ^ static_cast<unsigned char>(*c)) * 16777619u;
        h2 = h2 * 33u + static_cast<unsigned char>(*c);
    }
    const u32 scaleKey = static_cast<u32>(scale * 3000.0f + 0.5f);
    h1 ^= scaleKey * 2654435761u;
    h2 += scaleKey;
    WidthEntry& entry = gWidthCache[h1 % kWidthCacheSize];
    if (entry.used && entry.h1 == h1 && entry.h2 == h2) return entry.width;

    C2D_TextBufClear(gMeasureBuffer);
    C2D_Text text;
    C2D_TextParse(&text, gMeasureBuffer, value);
    float width = 0.0f;
    float height = 0.0f;
    C2D_TextGetDimensions(&text, scale, scale, &width, &height);
    entry.h1 = h1;
    entry.h2 = h2;
    entry.width = width;
    entry.used = true;
    return width;
}

void drawCentered(const char* value, float centerX, float y, float scale, u32 color) {
    drawText(value, centerX - textWidth(value, scale) / 2.0f, y, scale, color);
}

void drawRight(const char* value, float rightX, float y, float scale, u32 color) {
    drawText(value, rightX - textWidth(value, scale), y, scale, color);
}

// Copie src dans out en coupant avec "..." si le texte depasse maxWidth.
void fitText(const char* src, float maxWidth, float scale, char* out, std::size_t capacity) {
    if (!src) src = "";
    const std::size_t sourceLength = std::strlen(src);
    std::size_t keep = sourceLength < capacity ? sourceLength : capacity - 1;
    if (keep < sourceLength) {
        while (keep > 0 && isContinuationByte(src[keep])) --keep;
    }
    std::memcpy(out, src, keep);
    out[keep] = '\0';
    if (textWidth(out, scale) <= maxWidth) return;

    std::size_t length = keep;
    char trial[200];
    while (length > 0) {
        --length;
        while (length > 0 && isContinuationByte(out[length])) --length;
        out[length] = '\0';
        std::snprintf(trial, sizeof(trial), "%s...", out);
        if (textWidth(trial, scale) <= maxWidth) {
            copyBoundedText(out, capacity, trial);
            return;
        }
    }
    out[0] = '\0';
}

void appendEllipsis(char* line, float maxWidth, float scale) {
    std::size_t length = std::strlen(line);
    while (length > kWrapLineBytes - 6) {
        --length;
        while (length > 0 && isContinuationByte(line[length])) --length;
        line[length] = '\0';
    }
    char trial[kWrapLineBytes + 8];
    for (;;) {
        std::snprintf(trial, sizeof(trial), "%s...", line);
        if (length == 0 || textWidth(trial, scale) <= maxWidth) {
            std::memcpy(line, trial, std::strlen(trial) + 1);
            return;
        }
        --length;
        while (length > 0 && isContinuationByte(line[length])) --length;
        line[length] = '\0';
    }
}

bool isSpace(char c) { return c == ' ' || c == '\n' || c == '\r' || c == '\t'; }

// Retour a la ligne reel : on mesure chaque ligne candidate, ce qui garantit que
// le texte ne deborde jamais de son cadre. La derniere ligne est terminee par "..."
// si le texte est trop long.
void wrapText(const char* text, float maxWidth, float scale, int maxLines, WrappedText* out) {
    out->count = 0;
    if (!text || !text[0]) return;
    if (maxLines > kMaxWrapLines) maxLines = kMaxWrapLines;

    char current[kWrapLineBytes];
    char word[kWrapLineBytes];
    char candidate[kWrapLineBytes];
    current[0] = '\0';
    bool truncated = false;
    const char* cursor = text;

    while (*cursor) {
        while (*cursor && isSpace(*cursor)) ++cursor;
        if (!*cursor) break;
        std::size_t wordLength = 0;
        while (cursor[wordLength] && !isSpace(cursor[wordLength])) ++wordLength;
        std::size_t take = wordLength < kMaxWordBytes ? wordLength : kMaxWordBytes;
        if (take < wordLength) {
            while (take > 0 && isContinuationByte(cursor[take])) --take;
        }
        std::memcpy(word, cursor, take);
        word[take] = '\0';
        cursor += wordLength;

        const std::size_t currentLength = std::strlen(current);
        const std::size_t wordBytes = std::strlen(word);
        const bool candidateFitsBuffer = currentLength + (currentLength ? 1 : 0) + wordBytes < sizeof(candidate);
        if (candidateFitsBuffer && currentLength) {
            std::memcpy(candidate, current, currentLength);
            candidate[currentLength] = ' ';
            std::memcpy(candidate + currentLength + 1, word, wordBytes + 1);
        } else if (candidateFitsBuffer) {
            std::memcpy(candidate, word, wordBytes + 1);
        } else {
            candidate[0] = '\0';
        }

        if (candidateFitsBuffer && std::strlen(candidate) < kMaxLineBytes && textWidth(candidate, scale) <= maxWidth) {
            std::snprintf(current, sizeof(current), "%s", candidate);
            continue;
        }
        if (current[0]) {
            if (out->count >= maxLines) {
                truncated = true;
                break;
            }
            std::snprintf(out->lines[out->count++], kWrapLineBytes, "%s", current);
            fitText(word, maxWidth, scale, current, sizeof(current));
        } else {
            fitText(word, maxWidth, scale, current, sizeof(current));
        }
    }

    if (!truncated && current[0]) {
        if (out->count >= maxLines) truncated = true;
        else std::snprintf(out->lines[out->count++], kWrapLineBytes, "%s", current);
    }
    if (truncated && out->count > 0) appendEllipsis(out->lines[out->count - 1], maxWidth, scale);
}

u32 hashText(const char* value, u32 seed) {
    u32 hash = 2166136261u ^ seed;
    while (*value) {
        hash ^= static_cast<unsigned char>(*value++);
        hash *= 16777619u;
    }
    return hash;
}

const WrappedText& cachedWrap(WrapCache& cache, const char* text, float maxWidth, float scale, int maxLines) {
    const u32 seed = static_cast<u32>(maxWidth * 4.0f) * 31u + static_cast<u32>(scale * 1000.0f) +
                     static_cast<u32>(maxLines) * 7919u;
    const u32 key = hashText(text ? text : "", seed);
    if (!cache.valid || cache.key != key) {
        wrapText(text, maxWidth, scale, maxLines, &cache.text);
        cache.key = key;
        cache.valid = true;
    }
    return cache.text;
}

void drawWrapped(const WrappedText& wrapped, float x, float y, float step, float scale, u32 color) {
    for (int i = 0; i < wrapped.count; ++i) drawText(wrapped.lines[i], x, y + static_cast<float>(i) * step, scale, color);
}

// ---------------------------------------------------------------------------
// Formats et libelles
// ---------------------------------------------------------------------------

void formatSize(u64 bytes, char* out, std::size_t capacity) {
    constexpr u64 kKi = 1024;
    constexpr u64 kMi = kKi * 1024;
    constexpr u64 kGi = kMi * 1024;
    if (bytes >= kGi) {
        const u64 tenths = bytes * 10 / kGi;
        std::snprintf(out, capacity, gLang == 0 ? "%u,%u Go" : "%u.%u GB",
                      static_cast<unsigned>(tenths / 10), static_cast<unsigned>(tenths % 10));
    } else if (bytes >= kMi) {
        const u64 tenths = bytes * 10 / kMi;
        std::snprintf(out, capacity, gLang == 0 ? "%u,%u Mo" : "%u.%u MB",
                      static_cast<unsigned>(tenths / 10), static_cast<unsigned>(tenths % 10));
    } else if (bytes >= kKi) {
        std::snprintf(out, capacity, gLang == 0 ? "%u Ko" : "%u KB", static_cast<unsigned>(bytes / kKi));
    } else {
        std::snprintf(out, capacity, gLang == 0 ? "%u o" : "%u B", static_cast<unsigned>(bytes));
    }
}

const char* statusText(GameStatus status) {
    switch (status) {
        case GameStatus::Available: return L("Disponible");
        case GameStatus::Unavailable: return L("Indisponible");
        case GameStatus::ComingSoon: return L("Bientôt");
        case GameStatus::Development: return L("En dev.");
        case GameStatus::Discontinued: return L("Arrêté");
        case GameStatus::Finished: return L("Terminé");
    }
    return L("Inconnu");
}

u32 statusColor(GameStatus status) {
    switch (status) {
        case GameStatus::Available: return kOk;
        case GameStatus::ComingSoon: return kWarn;
        case GameStatus::Development: return kInfo;
        case GameStatus::Unavailable: return kBad;
        case GameStatus::Discontinued: return kFaint;
        case GameStatus::Finished: return kOk;
    }
    return kFaint;
}

const char* compatibilityText(const char* value) {
    if (std::strcmp(value, "supported") == 0) return L("Compatible");
    if (std::strcmp(value, "unsupported") == 0) return L("Non compatible");
    return L("Non vérifié");
}

u32 compatibilityColor(const char* value) {
    if (std::strcmp(value, "supported") == 0) return kOk;
    if (std::strcmp(value, "unsupported") == 0) return kBad;
    return kFaint;
}

u32 tileColor(const char* id) { return kTilePalette[hashText(id, 7) % 6]; }

void tileInitial(const char* name, char* out) {
    out[0] = '\0';
    if (!name || !name[0]) {
        std::snprintf(out, 8, "?");
        return;
    }
    std::size_t length = 1;
    while (length < 4 && isContinuationByte(name[length])) ++length;
    std::memcpy(out, name, length);
    out[length] = '\0';
    if (length == 1 && out[0] >= 'a' && out[0] <= 'z') out[0] = static_cast<char>(out[0] - 'a' + 'A');
}

// ---------------------------------------------------------------------------
// Fichiers
// ---------------------------------------------------------------------------

char* readSmallFile(const char* path, long maxBytes, std::size_t* outLength) {
    FILE* file = std::fopen(path, "rb");
    if (!file) return nullptr;
    if (std::fseek(file, 0, SEEK_END) != 0) {
        std::fclose(file);
        return nullptr;
    }
    const long length = std::ftell(file);
    if (length <= 0 || length > maxBytes || std::fseek(file, 0, SEEK_SET) != 0) {
        std::fclose(file);
        return nullptr;
    }
    char* contents = static_cast<char*>(std::malloc(static_cast<std::size_t>(length) + 1));
    if (!contents) {
        std::fclose(file);
        return nullptr;
    }
    const std::size_t read = std::fread(contents, 1, static_cast<std::size_t>(length), file);
    std::fclose(file);
    if (read != static_cast<std::size_t>(length)) {
        std::free(contents);
        return nullptr;
    }
    contents[read] = '\0';
    *outLength = read;
    return contents;
}

bool loadEmbeddedCatalog(GameCatalog* output) {
    if (!output) return false;
    if (gRomfsReady) {
        std::size_t length = 0;
        char* contents = readSmallFile("romfs:/catalog.json", 128 * 1024, &length);
        if (contents) {
            const bool valid = parseCatalogJson(contents, length, output);
            std::free(contents);
            if (valid) return true;
        }
    }
    return parseCatalogJson(kEmbeddedCatalogJson, kEmbeddedCatalogJsonLength, output);
}

bool loadEmbeddedHubManifest() {
    if (gRomfsReady) {
        std::size_t length = 0;
        char* contents = readSmallFile("romfs:/hub.json", 16 * 1024, &length);
        if (contents) {
            const bool valid = parseHubManifestJson(contents, length, &gHubManifest);
            std::free(contents);
            if (valid) return true;
        }
    }
    return parseHubManifestJson(kEmbeddedHubJson, kEmbeddedHubJsonLength, &gHubManifest);
}

bool loadInstalledGames() {
    return loadInstalledGamesFromSd(&gInstalledGames);
}

void syncInstalledCiaGames() {
    if (!gCatalogLoaded || R_FAILED(amInit())) return;

    u32 titleCount = 0;
    if (R_FAILED(AM_GetTitleCount(MEDIATYPE_SD, &titleCount)) ||
        static_cast<std::size_t>(titleCount) > static_cast<std::size_t>(-1) / sizeof(u64)) {
        amExit();
        return;
    }
    u64* titleIds = titleCount ? static_cast<u64*>(std::malloc(sizeof(u64) * titleCount)) : nullptr;
    if (titleCount && !titleIds) {
        amExit();
        return;
    }
    u32 titlesRead = 0;
    if (titleCount && (R_FAILED(AM_GetTitleList(&titlesRead, MEDIATYPE_SD, titleCount, titleIds)) ||
                       titlesRead != titleCount)) {
        std::free(titleIds);
        amExit();
        return;
    }
    auto titleIsInstalled = [titleIds, titlesRead](u64 titleId) {
        for (u32 i = 0; i < titlesRead; ++i) {
            if (titleIds[i] == titleId) return true;
        }
        return false;
    };

    InstalledGameList installed{};
    const bool registryLoaded = loadInstalledGamesFromSd(&installed);
    struct stat registryInfo{};
    struct stat registryBackupInfo{};
    const bool registryExists =
        stat("sdmc:/3ds/FlashGamesHub/installed.json", &registryInfo) == 0 ||
        stat("sdmc:/3ds/FlashGamesHub/installed.json.bak", &registryBackupInfo) == 0;
    if (registryExists && !registryLoaded) {
        std::free(titleIds);
        amExit();
        return;
    }

    bool registryChanged = false;
    for (std::size_t i = installed.count; i > 0; --i) {
        const InstalledGame& entry = installed.games[i - 1];
        if (std::strcmp(entry.format, "cia") != 0 || !entry.titleId) continue;
        if (!titleIsInstalled(entry.titleId)) {
            if (unregisterInstalledGame(&installed, entry.id)) registryChanged = true;
        }
    }

    for (std::size_t i = 0; i < gCatalog.count; ++i) {
        const CatalogGame& game = gCatalog.games[i];
        if (!game.ciaTitleId || !game.version[0]) continue;
        if (!titleIsInstalled(game.ciaTitleId)) continue;

        bool alreadyRegistered = false;
        for (std::size_t j = 0; j < installed.count; ++j) {
            if (std::strcmp(installed.games[j].id, game.id) == 0) {
                alreadyRegistered = true;
                break;
            }
        }
        if (!alreadyRegistered &&
            registerInstalledGame(&installed, game.id, game.version, game.ciaSizeBytes, "cia", game.ciaTitleId)) {
            registryChanged = true;
        }
    }

    std::free(titleIds);
    amExit();
    gInstalledGames = installed;
    gInstalledGamesLoaded = registryLoaded || registryChanged;
}

bool isValidGameId(const char* id) {
    if (!id || !*id || std::strlen(id) >= sizeof(gFavoriteIds[0])) return false;
    for (const char* c = id; *c; ++c) {
        if (!((*c >= 'a' && *c <= 'z') || (*c >= '0' && *c <= '9') || *c == '-')) return false;
    }
    return true;
}

bool isFavorite(const char* id) {
    for (std::size_t i = 0; i < gFavoriteCount; ++i) {
        if (std::strcmp(gFavoriteIds[i], id) == 0) return true;
    }
    return false;
}

void loadFavorites() {
    FILE* file = std::fopen(kFavoritesPath, "rb");
    if (!file) return;
    char line[80];
    while (gFavoriteCount < kMaxFavorites && std::fgets(line, sizeof(line), file)) {
        std::size_t length = std::strlen(line);
        while (length && (line[length - 1] == '\n' || line[length - 1] == '\r')) line[--length] = '\0';
        if (!isValidGameId(line) || isFavorite(line)) continue;
        copyBoundedText(gFavoriteIds[gFavoriteCount], sizeof(gFavoriteIds[gFavoriteCount]), line);
        ++gFavoriteCount;
    }
    std::fclose(file);
}

// Sur la carte SD de la 3DS, rename() echoue si la destination existe : il faut
// supprimer l'ancien fichier avant, sinon les favoris ne sont enregistres qu'une fois.
bool saveFavorites() {
    mkdir("sdmc:/3ds", 0777);
    mkdir(kDataDirectory, 0777);
    FILE* file = std::fopen(kFavoritesTempPath, "wb");
    if (!file) return false;
    bool ok = true;
    for (std::size_t i = 0; i < gFavoriteCount; ++i) {
        if (std::fprintf(file, "%s\n", gFavoriteIds[i]) < 0) ok = false;
    }
    if (std::fclose(file) != 0) ok = false;
    if (ok) {
        std::remove(kFavoritesPath);
        ok = std::rename(kFavoritesTempPath, kFavoritesPath) == 0;
    }
    if (!ok) std::remove(kFavoritesTempPath);
    return ok;
}

u64 installedGamesBytes();
u64 cachedDataBytes();

void readStorageStats() {
    gCachedInstalledBytes = installedGamesBytes();
    gCachedCatalogDataBytes = cachedDataBytes();
    FS_ArchiveResource resource{};
    if (R_FAILED(FSUSER_GetSdmcArchiveResource(&resource)) || resource.clusterSize == 0) {
        gStorageAvailable = false;
        return;
    }
    gStorageTotalBytes = static_cast<u64>(resource.clusterSize) * resource.totalClusters;
    gStorageFreeBytes = static_cast<u64>(resource.clusterSize) * resource.freeClusters;
    gStorageAvailable = true;
}

void showToast(const char* message) {
    std::snprintf(gToast, sizeof(gToast), "%s", message);
    gToastFrames = 150;
}

// ---------------------------------------------------------------------------
// Catalogue : filtres, selection, favoris
// ---------------------------------------------------------------------------

void loadSettings() {
    FILE* file = std::fopen(kSettingsPath, "rb");
    if (!file) return;
    char line[16]{};
    if (std::fgets(line, sizeof(line), file)) {
        if (line[0] == 'e' && line[1] == 'n') gLang = 1;
        else if (line[0] == 'f' && line[1] == 'r') gLang = 0;
    }
    std::fclose(file);
}

bool saveSettings() {
    mkdir("sdmc:/3ds", 0777);
    mkdir(kDataDirectory, 0777);
    FILE* file = std::fopen(kSettingsTempPath, "wb");
    if (!file) return false;
    bool ok = std::fprintf(file, "%s\n", gLang == 1 ? "en" : "fr") >= 0;
    if (std::fclose(file) != 0) ok = false;
    if (ok) {
        std::remove(kSettingsPath);
        ok = std::rename(kSettingsTempPath, kSettingsPath) == 0;
    }
    if (!ok) std::remove(kSettingsTempPath);
    return ok;
}

void setLanguage(int language) {
    if (gLang == language) return;
    gLang = language;
    showToast(saveSettings() ? L("Langue enregistrée") : L("Échec de l'écriture sur la carte SD"));
}

void rebuildGenres() {
    gGenreCount = 0;
    if (!gCatalogLoaded) return;
    for (std::size_t i = 0; i < gCatalog.count && gGenreCount < kMaxGenres; ++i) {
        const char* genre = gCatalog.games[i].genre;
        if (!genre[0]) continue;
        bool found = false;
        for (std::size_t g = 0; g < gGenreCount; ++g) {
            if (std::strcmp(gGenres[g], genre) == 0) found = true;
        }
        if (!found) {
            std::snprintf(gGenres[gGenreCount], sizeof(gGenres[0]), "%s", genre);
            ++gGenreCount;
        }
    }
}

bool containsText(const char* text, const char* query) {
    if (!query || !query[0]) return true;
    if (!text) return false;
    for (const char* start = text; *start; ++start) {
        const char* a = start;
        const char* b = query;
        while (*a && *b) {
            char left = *a;
            char right = *b;
            if (left >= 'A' && left <= 'Z') left = static_cast<char>(left - 'A' + 'a');
            if (right >= 'A' && right <= 'Z') right = static_cast<char>(right - 'A' + 'a');
            if (left != right) break;
            ++a;
            ++b;
        }
        if (!*b) return true;
    }
    return false;
}

bool matchesFilters(const CatalogGame& game) {
    if (gFavoritesOnly && !isFavorite(game.id)) return false;
    if (gGenreFilterIndex > 0 && std::strcmp(game.genre, gGenres[gGenreFilterIndex - 1]) != 0) return false;
    return containsText(game.name, gSearchQuery) || containsText(game.description, gSearchQuery) ||
           containsText(game.genre, gSearchQuery) || containsText(localizedGenre(game.genre), gSearchQuery) ||
           containsText(game.developer, gSearchQuery);
}

void clampScroll(std::size_t selection, std::size_t count, std::size_t rows, std::size_t* scroll) {
    if (count <= rows) {
        *scroll = 0;
        return;
    }
    if (selection < *scroll) *scroll = selection;
    else if (selection >= *scroll + rows) *scroll = selection + 1 - rows;
    if (*scroll > count - rows) *scroll = count - rows;
}

// "The World's Hardest Game 1", "... 2" : meme serie une fois le numero final retire.
void seriesKey(const CatalogGame& game, char* out, std::size_t capacity) {
    if (game.seriesName[0]) {
        std::snprintf(out, capacity, "%s", game.seriesName);
        return;
    }
    const char* name = game.name;
    std::snprintf(out, capacity, "%s", name ? name : "");
    std::size_t length = std::strlen(out);
    while (length && out[length - 1] == ' ') out[--length] = '\0';
    std::size_t digits = length;
    while (digits > 0 && out[digits - 1] >= '0' && out[digits - 1] <= '9') --digits;
    if (digits < length && digits > 0 && out[digits - 1] == ' ' && length - digits <= 2) {
        length = digits;
        while (length && out[length - 1] == ' ') out[--length] = '\0';
    }
}

bool sameSeries(const CatalogGame& a, const CatalogGame& b) {
    if (a.seriesId[0] && b.seriesId[0]) return std::strcmp(a.seriesId, b.seriesId) == 0;
    if (a.seriesId[0] || b.seriesId[0]) return false;
    char left[64];
    char right[64];
    seriesKey(a, left, sizeof(left));
    seriesKey(b, right, sizeof(right));
    return std::strcmp(left, right) == 0;
}

std::size_t statusSortOrder(GameStatus status) {
    switch (status) {
        case GameStatus::Available:
        case GameStatus::Finished: return 0;
        case GameStatus::Development: return 1;
        case GameStatus::ComingSoon: return 2;
        case GameStatus::Unavailable: return 3;
        case GameStatus::Discontinued: return 4;
    }
    return 5;
}

void sortCatalogIndicesByStatus(std::size_t* indices, std::size_t count) {
    for (std::size_t i = 1; i < count; ++i) {
        const std::size_t current = indices[i];
        const std::size_t currentOrder = statusSortOrder(gCatalog.games[current].status);
        std::size_t position = i;
        while (position > 0 &&
               currentOrder < statusSortOrder(gCatalog.games[indices[position - 1]].status)) {
            indices[position] = indices[position - 1];
            --position;
        }
        indices[position] = current;
    }
}

void closeStoreDetail();

// Recalcule la liste filtree (une fois par changement, pas a chaque image) en
// conservant autant que possible le jeu selectionne.
void rebuildFilter() {
    if (gStoreDetailOpen) closeStoreDetail();
    else gStoreDetailGameIndex = GameCatalog::kMaxGames;
    if (gGenreFilterIndex > gGenreCount) gGenreFilterIndex = 0;
    char previousId[64]{};
    const std::size_t previousSelection = gStoreSel;
    if (gStoreSel < gFilteredCount && gFiltered[gStoreSel] < gCatalog.count) {
        std::snprintf(previousId, sizeof(previousId), "%s", gCatalog.games[gFiltered[gStoreSel]].id);
    }
    gFilteredCount = 0;
    if (gCatalogLoaded) {
        std::size_t orderedIndices[GameCatalog::kMaxGames]{};
        std::size_t orderedCount = 0;
        for (std::size_t i = 0; i < gCatalog.count; ++i) {
            if (matchesFilters(gCatalog.games[i])) orderedIndices[orderedCount++] = i;
        }
        sortCatalogIndicesByStatus(orderedIndices, orderedCount);
        for (std::size_t item = 0; item < orderedCount; ++item) {
            const std::size_t i = orderedIndices[item];
            const CatalogGame& game = gCatalog.games[i];
            bool merged = false;
            for (std::size_t f = 0; f < gFilteredCount; ++f) {
                const CatalogGame& first = gCatalog.games[gFiltered[f]];
                if (sameSeries(first, game)) {
                    ++gGroupCount[f];
                    if (first.status != game.status) gGroupMixed[f] = true;
                    merged = true;
                    break;
                }
            }
            if (!merged) {
                gFiltered[gFilteredCount] = i;
                gGroupCount[gFilteredCount] = 1;
                gGroupMixed[gFilteredCount] = false;
                ++gFilteredCount;
            }
        }
    }
    bool found = false;
    if (previousId[0]) {
        for (std::size_t i = 0; i < gFilteredCount; ++i) {
            if (std::strcmp(gCatalog.games[gFiltered[i]].id, previousId) == 0) {
                gStoreSel = i;
                found = true;
                break;
            }
        }
    }
    if (!found) {
        if (gFilteredCount == 0) gStoreSel = 0;
        else gStoreSel = previousSelection < gFilteredCount ? previousSelection : gFilteredCount - 1;
    }
    clampScroll(gStoreSel, gFilteredCount, kStoreRows, &gStoreScroll);
}

// Indices (dans le catalogue) des jeux de la ligne `position` de la liste.
std::size_t groupMembers(std::size_t position, std::size_t* out, std::size_t capacity) {
    if (position >= gFilteredCount) return 0;
    const CatalogGame& selected = gCatalog.games[gFiltered[position]];
    std::size_t count = 0;
    for (std::size_t i = 0; i < gCatalog.count && count < capacity; ++i) {
        if (!matchesFilters(gCatalog.games[i])) continue;
        if (sameSeries(selected, gCatalog.games[i])) out[count++] = i;
    }
    sortCatalogIndicesByStatus(out, count);
    return count;
}

const CatalogGame* selectedStoreGame() {
    if (gStoreSel >= gFilteredCount) return nullptr;
    return &gCatalog.games[gFiltered[gStoreSel]];
}

const CatalogGame* activeStoreGame() {
    if (gStoreDetailOpen && gStoreDetailGameIndex < gCatalog.count) return &gCatalog.games[gStoreDetailGameIndex];
    return selectedStoreGame();
}

void requestStoreScreenshot();

bool openSelectedStoreDetail() {
    if (!gCatalogLoaded || gStoreSel >= gFilteredCount) return false;
    std::size_t members[6]{};
    const std::size_t count = groupMembers(gStoreSel, members, 6);
    if (count == 0) return false;
    gStoreDetailGameIndex = members[0];
    gStoreDetailOpen = true;
    gStoreScreenshotIndex = 0;
    requestStoreScreenshot();
    return true;
}

void closeStoreDetail() {
    gStoreDetailOpen = false;
    gStoreDetailGameIndex = GameCatalog::kMaxGames;
    gStoreScreenshotIndex = 0;
    gScreenshotLoading = false;
    gScreenshotFailed = false;
    gPendingScreenshotCachePath[0] = '\0';
    gStoreScreenshotSheetPath[0] = '\0';
    if (gStoreScreenshotSheet) {
        C2D_SpriteSheetFree(gStoreScreenshotSheet);
        gStoreScreenshotSheet = nullptr;
    }
}

void requestStoreScreenshot() {
    stopScreenshotCache();
    if (gStoreScreenshotSheet) {
        C2D_SpriteSheetFree(gStoreScreenshotSheet);
        gStoreScreenshotSheet = nullptr;
    }
    gStoreScreenshotSheetPath[0] = '\0';
    gPendingScreenshotCachePath[0] = '\0';
    gScreenshotLoading = false;
    gScreenshotFailed = false;
    const CatalogGame* game = activeStoreGame();
    if (!gStoreDetailOpen || !game) return;
    const char* mediaPath = nullptr;
    if (game->screenshotCount > 0) {
        if (gStoreScreenshotIndex >= game->screenshotCount) gStoreScreenshotIndex = 0;
        mediaPath = game->screenshots[gStoreScreenshotIndex];
    } else if (game->cover[0]) {
        mediaPath = game->cover;
    } else {
        return;
    }

    u32 pathHash = 2166136261u;
    for (const unsigned char* c = reinterpret_cast<const unsigned char*>(mediaPath); *c; ++c)
        pathHash = (pathHash ^ *c) * 16777619u;
    char localPath[256];
    std::snprintf(localPath, sizeof(localPath), "sdmc:/3ds/FlashGamesHub/screenshots/%s-%u-%08lx.t3x",
                  game->id, static_cast<unsigned>(gStoreScreenshotIndex), static_cast<unsigned long>(pathHash));
    struct stat info{};
    if (stat(localPath, &info) == 0 && info.st_size > 0) {
        gStoreScreenshotSheet = C2D_SpriteSheetLoad(localPath);
        if (gStoreScreenshotSheet) {
            std::snprintf(gStoreScreenshotSheetPath, sizeof(gStoreScreenshotSheetPath), "%s", localPath);
            return;
        }
        std::remove(localPath);
    }
    char embeddedPath[256];
    const char* relativePath = mediaPath[0] == '/' ? mediaPath + 1 : mediaPath;
    std::snprintf(embeddedPath, sizeof(embeddedPath), "romfs:/%s", relativePath);
    gStoreScreenshotSheet = C2D_SpriteSheetLoad(embeddedPath);
    if (gStoreScreenshotSheet) {
        std::snprintf(gStoreScreenshotSheetPath, sizeof(gStoreScreenshotSheetPath), "%s", embeddedPath);
        return;
    }
    if (startScreenshotCache(mediaPath, localPath)) {
        std::snprintf(gPendingScreenshotCachePath, sizeof(gPendingScreenshotCachePath), "%s", localPath);
        gScreenshotLoading = true;
    } else {
        gScreenshotFailed = true;
    }
}

bool hasCiaPackage(const CatalogGame* game) {
    return game && game->ciaUrl[0] && game->ciaSizeBytes && std::strlen(game->ciaSha256) == 64;
}

const char* selectedStoreFormat(const CatalogGame* game) {
    if (!game) return "3dsx";
    if (std::strcmp(game->downloadFormat, "cia") == 0) return "cia";
    return gStoreCiaFormat && hasCiaPackage(game) ? "cia" : game->downloadFormat;
}

bool hasPackageFormat(const CatalogGame* game, const char* format) {
    if (!game || !format) return false;
    if (std::strcmp(format, "cia") == 0) {
        if (std::strcmp(game->downloadFormat, "cia") == 0) return game->downloadUrl[0] && game->sizeBytes && game->sha256[0];
        return hasCiaPackage(game);
    }
    return std::strcmp(format, "3dsx") == 0 && game->downloadUrl[0] && game->sizeBytes && game->sha256[0];
}

bool supportsCurrentModel(const CatalogGame& game) {
    if (!gConsoleModelKnown) return false;
    const char* compatibility = gIsNew3DS ? game.compatibilityNew3ds : game.compatibility3ds;
    return std::strcmp(compatibility, "supported") == 0;
}

bool storeGameCanInstall(const CatalogGame* game) {
    return game && (game->status == GameStatus::Available || game->status == GameStatus::Development) &&
           supportsCurrentModel(*game) && hasPackageFormat(game, selectedStoreFormat(game));
}

void toggleFavoriteId(const char* id) {
    if (!id || !id[0]) return;
    for (std::size_t i = 0; i < gFavoriteCount; ++i) {
        if (std::strcmp(gFavoriteIds[i], id) == 0) {
            for (std::size_t move = i + 1; move < gFavoriteCount; ++move) {
                std::memcpy(gFavoriteIds[move - 1], gFavoriteIds[move], sizeof(gFavoriteIds[0]));
            }
            --gFavoriteCount;
            gFavoriteIds[gFavoriteCount][0] = '\0';
            showToast(saveFavorites() ? L("Retiré des favoris") : L("Échec de l'écriture sur la carte SD"));
            if (gFavoritesOnly) rebuildFilter();
            return;
        }
    }
    if (gFavoriteCount >= kMaxFavorites) {
        showToast(L("Limite de favoris atteinte"));
        return;
    }
    copyBoundedText(gFavoriteIds[gFavoriteCount], sizeof(gFavoriteIds[0]), id);
    ++gFavoriteCount;
    showToast(saveFavorites() ? L("Ajouté aux favoris") : L("Échec de l'écriture sur la carte SD"));
}

void toggleFavorite(const CatalogGame& game) { toggleFavoriteId(game.id); }

bool groupIsFavorite(std::size_t position) {
    std::size_t members[16];
    const std::size_t count = groupMembers(position, members, 16);
    for (std::size_t i = 0; i < count; ++i) {
        if (isFavorite(gCatalog.games[members[i]].id)) return true;
    }
    return false;
}

// Un favori sur une ligne regroupee s'applique a tous les jeux du groupe.
void toggleGroupFavorite(std::size_t position) {
    std::size_t members[16];
    const std::size_t count = groupMembers(position, members, 16);
    bool any = false;
    for (std::size_t i = 0; i < count; ++i) {
        if (isFavorite(gCatalog.games[members[i]].id)) any = true;
    }
    for (std::size_t i = 0; i < count; ++i) {
        const CatalogGame& game = gCatalog.games[members[i]];
        if (isFavorite(game.id) == any) toggleFavorite(game);
    }
}

void editStoreSearch() {
    SwkbdState keyboard{};
    swkbdInit(&keyboard, SWKBD_TYPE_NORMAL, 2, 32);
    swkbdSetValidation(&keyboard, SWKBD_ANYTHING, 0, 0);
    swkbdSetHintText(&keyboard, L("Nom, genre ou description"));
    swkbdSetInitialText(&keyboard, gSearchQuery);
    swkbdSetButton(&keyboard, SWKBD_BUTTON_LEFT, L("Effacer"), false);
    swkbdSetButton(&keyboard, SWKBD_BUTTON_RIGHT, L("Chercher"), true);
    char query[sizeof(gSearchQuery)]{};
    copyBoundedText(query, sizeof(query), gSearchQuery);
    const SwkbdButton result = swkbdInputText(&keyboard, query, sizeof(query));
    if (result == SWKBD_BUTTON_NONE) {
        const SwkbdResult keyboardResult = swkbdGetResult(&keyboard);
        if (keyboardResult == SWKBD_INVALID_INPUT || keyboardResult == SWKBD_OUTOFMEM) {
            showToast(L("Clavier de recherche indisponible"));
        }
        return;
    }
    if (result == SWKBD_BUTTON_LEFT) query[0] = '\0';
    if (result == SWKBD_BUTTON_RIGHT || result == SWKBD_BUTTON_LEFT) {
        std::snprintf(gSearchQuery, sizeof(gSearchQuery), "%s", query);
        rebuildFilter();
    }
}

void cycleGenreFilter() {
    gGenreFilterIndex = (gGenreFilterIndex + 1) % (gGenreCount + 1);
    rebuildFilter();
}

void resetFilters() {
    gSearchQuery[0] = '\0';
    gGenreFilterIndex = 0;
    gFavoritesOnly = false;
    rebuildFilter();
}

const CatalogGame* findCatalogGame(const char* id) {
    if (!id || !gCatalogLoaded) return nullptr;
    for (std::size_t i = 0; i < gCatalog.count; ++i) {
        if (std::strcmp(gCatalog.games[i].id, id) == 0) return &gCatalog.games[i];
    }
    return nullptr;
}

bool findGameUpdate(std::size_t installedIndex, const CatalogGame** catalogGame) {
    if (catalogGame) *catalogGame = nullptr;
    if (installedIndex >= gInstalledGames.count) return false;
    const InstalledGame& installed = gInstalledGames.games[installedIndex];
    const CatalogGame* current = findCatalogGame(installed.id);
    if (catalogGame) *catalogGame = current;
    return current && current->status == GameStatus::Available &&
           hasPackageFormat(current, installed.format[0] ? installed.format : "3dsx") &&
           compareVersions(current->version, installed.version) > 0;
}

std::size_t countGameUpdates() {
    std::size_t count = 0;
    if (!gInstalledGamesLoaded) return count;
    for (std::size_t i = 0; i < gInstalledGames.count; ++i) {
        if (findGameUpdate(i, nullptr)) ++count;
    }
    return count;
}

bool firstGameUpdate(std::size_t* installedIndex, const CatalogGame** catalogGame) {
    if (installedIndex) *installedIndex = InstalledGameList::kMaxGames;
    if (catalogGame) *catalogGame = nullptr;
    if (!gInstalledGamesLoaded || !gCatalogLoaded) return false;
    for (std::size_t i = 0; i < gInstalledGames.count; ++i) {
        const CatalogGame* current = nullptr;
        if (findGameUpdate(i, &current)) {
            if (installedIndex) *installedIndex = i;
            if (catalogGame) *catalogGame = current;
            return true;
        }
    }
    return false;
}

void requestFirstGameUpdate() {
    std::size_t index = InstalledGameList::kMaxGames;
    const CatalogGame* update = nullptr;
    if (!firstGameUpdate(&index, &update) || !update) {
        showToast(L("Aucune mise à jour"));
        return;
    }
    if (getGamePackageState() != GamePackageState::Idle) return;
    const char* format = gInstalledGames.games[index].format[0] ? gInstalledGames.games[index].format : "3dsx";
    if (!startGamePackageDownload(update, format)) showToast(L("Téléchargement indisponible"));
}

bool hubUpdateAvailable();

void requestHubUpdate() {
    if (!hubUpdateAvailable()) {
        showToast(L("Aucune mise à jour"));
        return;
    }
    if (getGamePackageState() != GamePackageState::Idle) return;
    if (!startHubUpdateDownload(&gHubManifest)) showToast(L("Téléchargement indisponible"));
}

void requestSelectedGameUpdate() {
    if (!gInstalledGamesLoaded || gLibrarySel >= gInstalledGames.count) return;
    if (getGamePackageState() != GamePackageState::Idle) return;
    const CatalogGame* update = nullptr;
    if (!findGameUpdate(gLibrarySel, &update) || !update) {
        showToast(L("Aucune mise à jour"));
        return;
    }
    const char* format = gInstalledGames.games[gLibrarySel].format[0] ? gInstalledGames.games[gLibrarySel].format : "3dsx";
    if (!startGamePackageDownload(update, format)) showToast(L("Téléchargement indisponible"));
}

const InstalledGame* findInstalledGame(const char* id) {
    if (!id || !id[0] || !gInstalledGamesLoaded) return nullptr;
    for (std::size_t i = 0; i < gInstalledGames.count; ++i) {
        if (std::strcmp(gInstalledGames.games[i].id, id) == 0) return &gInstalledGames.games[i];
    }
    return nullptr;
}

bool storeGameHasUpdate(const CatalogGame* game) {
    if (!game) return false;
    const InstalledGame* installed = findInstalledGame(game->id);
    if (!installed) return false;
    const char* format = installed->format[0] ? installed->format : "3dsx";
    return game->status == GameStatus::Available && hasPackageFormat(game, format) &&
           compareVersions(game->version, installed->version) > 0;
}

bool storeGameAlreadyInstalled(const CatalogGame* game) {
    if (!game) return false;
    const InstalledGame* installed = findInstalledGame(game->id);
    return installed && compareVersions(game->version, installed->version) <= 0;
}

void requestSelectedStoreDownload() {
    const CatalogGame* game = activeStoreGame();
    if (!game) return;
    if (getGamePackageState() != GamePackageState::Idle) return;
    if (!gConsoleModelKnown) {
        showToast(L("Modèle de console indisponible"));
        return;
    }
    if (!supportsCurrentModel(*game)) {
        showToast(L("Compatibilité non vérifiée"));
        return;
    }
    if (storeGameAlreadyInstalled(game)) {
        showToast(L("Jeu déjà installé"));
        return;
    }
    const InstalledGame* installed = findInstalledGame(game->id);
    const char* format = installed && installed->format[0] ? installed->format : selectedStoreFormat(game);
    if (!storeGameCanInstall(game) ||
        (!std::strcmp(format, "3dsx") && std::strcmp(game->downloadFormat, "3dsx") != 0)) {
        showToast(L("Téléchargement indisponible"));
        return;
    }
    if (!startGamePackageDownload(game, format)) showToast(L("Téléchargement indisponible"));
}

void uninstallSelectedGame() {
    if (!gInstalledGamesLoaded || gLibrarySel >= gInstalledGames.count) return;
    const InstalledGame installed = gInstalledGames.games[gLibrarySel];
    const char* format = installed.format[0] ? installed.format : "3dsx";
    if (std::strcmp(format, "cia") == 0) {
        if (!installed.titleId || R_FAILED(amInit())) {
            showToast(L("Désinstallation indisponible"));
            return;
        }
        const Result result = AM_DeleteTitle(MEDIATYPE_SD, installed.titleId);
        amExit();
        if (R_FAILED(result)) {
            showToast(L("Échec de la désinstallation"));
            return;
        }
        if (!unregisterInstalledGame(&gInstalledGames, installed.id)) {
            showToast(L("Jeu supprimé, bibliothèque à actualiser"));
            return;
        }
        if (gInstalledGames.count == 0) {
            gLibrarySel = 0;
            gLibraryScroll = 0;
        } else if (gLibrarySel >= gInstalledGames.count) {
            gLibrarySel = gInstalledGames.count - 1;
        }
        clampScroll(gLibrarySel, gInstalledGames.count, kLibraryRows, &gLibraryScroll);
        showToast(L("Jeu désinstallé"));
        return;
    }
    char path[224];
    char pendingPath[240];
    std::snprintf(path, sizeof(path), "sdmc:/3ds/FlashGamesHub/games/%s/%s.3dsx", installed.id, installed.id);
    std::snprintf(pendingPath, sizeof(pendingPath), "%s.remove", path);
    struct stat fileInfo{};
    const bool fileExists = stat(path, &fileInfo) == 0;
    if (!fileExists) {
        showToast(L("Aucun fichier de jeu trouvé"));
        return;
    }
    std::remove(pendingPath);
    if (std::rename(path, pendingPath) != 0) {
        showToast(L("Échec de la désinstallation"));
        return;
    }
    if (!unregisterInstalledGame(&gInstalledGames, installed.id)) {
        std::rename(pendingPath, path);
        showToast(L("Échec de la désinstallation"));
        return;
    }
    if (std::remove(pendingPath) != 0) {
        registerInstalledGame(&gInstalledGames, installed.id, installed.version, installed.sizeBytes,
                              format, installed.titleId);
        showToast(L("Échec de la désinstallation"));
        return;
    }
    if (gInstalledGames.count == 0) {
        gLibrarySel = 0;
        gLibraryScroll = 0;
    } else if (gLibrarySel >= gInstalledGames.count) {
        gLibrarySel = gInstalledGames.count - 1;
    }
    clampScroll(gLibrarySel, gInstalledGames.count, kLibraryRows, &gLibraryScroll);
    showToast(L("Jeu désinstallé"));
}

bool setHomebrewLoaderTarget(const char* path) {
    // Uses the Rosalina hb:ldr handoff used by devkitPro's Homebrew Menu.
    const char* targetPath = std::strncmp(path, "sdmc:/", 6) == 0 ? path + 5 : path;
    Handle loader = 0;
    if (R_FAILED(svcConnectToPort(&loader, "hb:ldr"))) return false;
    const u32 pathSize = static_cast<u32>(std::strlen(targetPath) + 1);
    u32* command = getThreadCommandBuffer();
    command[0] = IPC_MakeHeader(2, 0, 2);
    command[1] = IPC_Desc_StaticBuffer(pathSize, 0);
    command[2] = static_cast<u32>(reinterpret_cast<uintptr_t>(targetPath));
    Result result = svcSendSyncRequest(loader);
    if (R_SUCCEEDED(result)) result = command[1];
    if (R_SUCCEEDED(result)) {
        alignas(4) u8 argv[0x300]{};
        command = getThreadCommandBuffer();
        command[0] = IPC_MakeHeader(3, 0, 2);
        command[1] = IPC_Desc_StaticBuffer(sizeof(argv), 1);
        command[2] = static_cast<u32>(reinterpret_cast<uintptr_t>(argv));
        result = svcSendSyncRequest(loader);
        if (R_SUCCEEDED(result)) result = command[1];
    }
    svcCloseHandle(loader);
    return R_SUCCEEDED(result);
}

void launchSelectedGame() {
    if (!gInstalledGamesLoaded || gLibrarySel >= gInstalledGames.count) return;
    const InstalledGame& installed = gInstalledGames.games[gLibrarySel];
    const CatalogGame* catalogGame = findCatalogGame(installed.id);
    if (catalogGame && !gConsoleModelKnown) {
        showToast(L("Modèle de console indisponible"));
        return;
    }
    if (catalogGame && !supportsCurrentModel(*catalogGame)) {
        showToast(L("Compatibilité non vérifiée"));
        return;
    }
    if (installed.format[0] && std::strcmp(installed.format, "cia") == 0) {
        if (!installed.titleId || R_FAILED(nsInit())) {
            showToast(L("Titre CIA introuvable"));
            return;
        }
        const Result result = NS_LaunchTitle(installed.titleId, 0, nullptr);
        nsExit();
        if (R_SUCCEEDED(result)) gQuit = true;
        else showToast(L("Lancement CIA impossible"));
        return;
    }
    char path[224];
    std::snprintf(path, sizeof(path), "sdmc:/3ds/FlashGamesHub/games/%s/%s.3dsx", installed.id, installed.id);
    struct stat info{};
    if (stat(path, &info) != 0 || info.st_size <= 0) {
        showToast(L("Fichier de jeu introuvable"));
        return;
    }
    if (getGamePackageState() != GamePackageState::Idle) return;
    if (!setHomebrewLoaderTarget(path)) {
        showToast(L("Chargeur Homebrew indisponible"));
        return;
    }
    gQuit = true;
}

bool hubUpdateAvailable() {
    return gHubManifestLoaded && gHubManifest.published &&
           compareVersions(gHubManifest.latestVersion, kHubVersion) > 0;
}

u64 installedGamesBytes() {
    u64 total = 0;
    if (!gInstalledGamesLoaded) return total;
    for (std::size_t i = 0; i < gInstalledGames.count; ++i) total += gInstalledGames.games[i].sizeBytes;
    return total;
}

u64 cachedDataBytes() {
    const char* paths[] = {kCachedCatalogPath, kCachedManifestPath};
    u64 total = 0;
    for (const char* path : paths) {
        struct stat info{};
        if (stat(path, &info) == 0 && info.st_size > 0) total += static_cast<u64>(info.st_size);
    }
    return total;
}

void clearCatalogCache() {
    const char* paths[] = {kCachedCatalogPath, kCachedManifestPath};
    bool ok = true;
    for (const char* path : paths) {
        if (std::remove(path) != 0) {
            struct stat info{};
            if (stat(path, &info) == 0) ok = false;
        }
    }
    readStorageStats();
    showToast(L(ok ? "Cache vidé" : "Échec du vidage du cache"));
}

void hubStatus(const char** text, u32* color) {
    if (!gHubManifestLoaded) {
        *text = L("Manifeste indisponible");
        *color = kMuted;
    } else if (!gHubManifest.published) {
        *text = L("Aucune version publiée");
        *color = kText;
    } else if (hubUpdateAvailable()) {
        *text = L("Nouvelle version disponible");
        *color = kAccent;
    } else {
        *text = L("Hub à jour");
        *color = kOk;
    }
}

void connectionStatus(const char** text, u32* color) {
    switch (getCatalogUpdateState()) {
        case CatalogUpdateState::Downloading:
            *text = L("Synchronisation");
            *color = kWarn;
            return;
        case CatalogUpdateState::Updated:
            *text = L("En ligne");
            *color = kOk;
            return;
        case CatalogUpdateState::Unavailable:
            *text = gCatalogLoaded ? L("Hors ligne") : L("Catalogue absent");
            *color = gCatalogLoaded ? kFaint : kBad;
            return;
        case CatalogUpdateState::Idle:
            break;
    }
    *text = gCatalogLoaded ? L("Catalogue local") : L("Catalogue absent");
    *color = gCatalogLoaded ? kFaint : kBad;
}

void applyDownloadedCatalog() {
    if (takeDownloadedCatalog(&gDownloadedCatalog)) {
        if (!gCatalogLoaded || gDownloadedCatalog.catalogVersion > gCatalog.catalogVersion) {
            gCatalog = gDownloadedCatalog;
            gCatalogLoaded = true;
            rebuildGenres();
            rebuildFilter();
            gDescriptionWrap.valid = false;
            if (gInstalledGamesLoaded && gLibrarySel >= gInstalledGames.count) gLibrarySel = 0;
            syncInstalledCiaGames();
        }
    }
    if (takeDownloadedHubManifest(&gDownloadedHubManifest)) {
        gHubManifest = gDownloadedHubManifest;
        gHubManifestLoaded = true;
        gNotesWrap.valid = false;
    }
}

void refreshCatalog() {
    if (getCatalogUpdateState() == CatalogUpdateState::Downloading ||
        getGamePackageState() != GamePackageState::Idle) return;
    stopScreenshotCache();
    stopCatalogDownload();
    startCatalogDownload();
}

// ---------------------------------------------------------------------------
// Composants graphiques
// ---------------------------------------------------------------------------

void drawSpinner(float x, float y) {
    const float phase = static_cast<float>(gFrame) * 0.22f;
    for (unsigned i = 0; i < 3; ++i) {
        const float wave = std::sin(phase - static_cast<float>(i) * 0.9f);
        const float offsetY = -wave * 2.2f;
        const u32 color = wave > 0.35f ? kAccent : (wave > -0.25f ? kText : kFaint);
        C2D_DrawCircleSolid(x + static_cast<float>(i) * 9.0f, y + offsetY, kDepth, 2.6f, color);
    }
}

void drawDotLabel(float x, float y, u32 dot, const char* label, float scale, u32 color) {
    C2D_DrawCircleSolid(x + 3.5f, y + lineHeight(scale) / 2.0f, kDepth, 3.2f, dot);
    drawText(label, x + 12.0f, y, scale, color);
}

void drawStatusPill(float x, float y, float width, const char* label, u32 dot) {
    drawPill(x, y, width, 20, kSurface2);
    const float textScale = 0.33f;
    const float contentWidth = 12.0f + textWidth(label, textScale);
    const float start = x + (width - contentWidth) / 2.0f;
    C2D_DrawCircleSolid(start + 3.5f, y + 10.0f, kDepth, 3.2f, dot);
    drawText(label, start + 12.0f, y + (20.0f - lineHeight(textScale)) / 2.0f, textScale, kText);
}

void drawButton(float x, float y, float width, float height, const char* label, bool enabled) {
    drawCard(x, y, width, height, enabled ? kAccent : kSurface2);
    const float scale = 0.42f;
    drawCentered(label, x + width / 2.0f, y + (height - lineHeight(scale)) / 2.0f, scale,
                 enabled ? kOnAccent : kFaint);
}

void drawChip(float x, float y, float width, const char* label, bool active, bool strong) {
    const u32 fill = strong ? kAccent : (active ? kAccentDim : kSurface2);
    const u32 color = strong ? kOnAccent : (active ? kAccent : kMuted);
    drawPill(x, y, width, kChipHeight, fill);
    char fitted[64];
    fitText(label, width - 16.0f, 0.34f, fitted, sizeof(fitted));
    drawCentered(fitted, x + width / 2.0f, y + (kChipHeight - lineHeight(0.34f)) / 2.0f, 0.34f, color);
}

struct Hint {
    const char* key;
    const char* label;
};

float drawHint(float x, float y, const Hint& hint) {
    const float keyWidth = textWidth(hint.key, 0.30f) + 10.0f;
    const char* label = L(hint.label);
    drawCard(x, y, keyWidth, 14, kSurface2);
    drawText(hint.key, x + 5.0f, y + 2.0f, 0.30f, kText);
    drawText(label, x + keyWidth + 5.0f, y + 1.5f, 0.32f, kMuted);
    return x + keyWidth + 5.0f + textWidth(label, 0.32f) + 14.0f;
}

void drawTile(float x, float y, float size, const char* id, const char* name) {
    drawCard(x, y, size, size, tileColor(id));
    char letter[8];
    tileInitial(name, letter);
    const float scale = size > 80.0f ? 1.5f : 0.9f;
    drawCentered(letter, x + size / 2.0f, y + (size - lineHeight(scale)) / 2.0f, scale, kWhite);
}

// ---------------------------------------------------------------------------
// Ecran du haut
// ---------------------------------------------------------------------------

void drawTopHeader() {
    drawRect(0, 0, kTopWidth, 34, kSurface);
    drawRect(0, 34, kTopWidth, 1, kBorder);
    drawCard(16, 8, 18, 18, kAccent);
    drawCentered("F", 25, 9.5f, 0.5f, kOnAccent);
    drawBold("Flash Games Hub", 44, 9, 0.55f, kText);

    const char* label = "";
    u32 color = kFaint;
    connectionStatus(&label, &color);
    const float scale = 0.32f;
    const float width = textWidth(label, scale);
    drawText(label, 384.0f - width, 12.0f, scale, kMuted);
    C2D_DrawCircleSolid(384.0f - width - 9.0f, 17.0f, kDepth, 3.4f, color);
}

void drawTopFooter(const Hint* hints, int count) {
    drawRect(20, 216, 360, 1, kBorder);
    float x = 20.0f;
    for (int i = 0; i < count; ++i) x = drawHint(x, 222, hints[i]);
}

void drawTopMessage(const char* title, const char* message) {
    drawCentered(title, kTopWidth / 2.0f, 98, 0.6f, kText);
    drawCentered(message, kTopWidth / 2.0f, 128, 0.38f, kMuted);
}

void drawGameDetail(const CatalogGame& game) {
    constexpr float tile = 104.0f;
    drawTile(20, 50, tile, game.id, game.name);
    drawStatusPill(20, 162, tile, statusText(game.status), statusColor(game.status));

    constexpr float columnX = 138.0f;
    constexpr float columnWidth = 242.0f;
    char fitted[128];
    fitText(game.name[0] ? game.name : game.id, columnWidth, 0.62f, fitted, sizeof(fitted));
    drawBold(fitted, columnX, 47, 0.62f, kText);

    char meta[160];
    if (game.developer[0] && game.genre[0]) {
        std::snprintf(meta, sizeof(meta), "%s  ·  %s", game.developer, localizedGenre(game.genre));
    } else if (game.developer[0]) std::snprintf(meta, sizeof(meta), "%s", game.developer);
    else if (game.genre[0]) std::snprintf(meta, sizeof(meta), "%s", localizedGenre(game.genre));
    else std::snprintf(meta, sizeof(meta), "%s", L("Aucune information"));
    fitText(meta, columnWidth, 0.36f, fitted, sizeof(fitted));
    drawText(fitted, columnX, 75, 0.36f, kAccent);

    const char* localizedDescription = gLang == 1 ? game.descriptionEn : game.description;
    if (localizedDescription[0]) {
        drawWrapped(cachedWrap(gDescriptionWrap, localizedDescription, columnWidth, 0.37f, 4), columnX, 97, 15.0f, 0.37f, kMuted);
    } else {
        drawText(L("Aucune description."), columnX, 97, 0.37f, kFaint);
    }

    drawDotLabel(columnX, 160, compatibilityColor(game.compatibility3ds), "3DS", 0.33f, kMuted);
    drawText(compatibilityText(game.compatibility3ds), columnX + 40, 160, 0.33f, kText);
    drawDotLabel(columnX, 176, compatibilityColor(game.compatibilityNew3ds), "New 3DS", 0.33f, kMuted);
    drawText(compatibilityText(game.compatibilityNew3ds), columnX + 66, 176, 0.33f, kText);

    char details[128];
    char size[24];
    const char* selectedFormat = selectedStoreFormat(&game);
    const u32 selectedBytes = std::strcmp(selectedFormat, "cia") == 0 ? game.ciaSizeBytes : game.sizeBytes;
    std::snprintf(details, sizeof(details), "%s  ·  .%s", game.version[0] ? game.version : "", selectedFormat);
    if (selectedBytes > 0) {
        formatSize(selectedBytes, size, sizeof(size));
        const std::size_t used = std::strlen(details);
        std::snprintf(details + used, sizeof(details) - used, "  ·  %s", size);
    }
    drawText(details, columnX, 194, 0.33f, kMuted);
    if (isFavorite(game.id)) {
        C2D_DrawCircleSolid(380.0f - textWidth(L("Favori"), 0.33f) - 8.0f, 199.0f, kDepth, 3.4f, kAccent);
        drawRight(L("Favori"), 380, 194, 0.33f, kAccent);
    }
}

void drawGroupDetail(std::size_t position) {
    std::size_t members[6];
    const std::size_t count = groupMembers(position, members, 6);
    if (count == 0) return;
    const CatalogGame& first = gCatalog.games[members[0]];
    const bool mixed = gGroupMixed[position];
    char title[96];
    seriesKey(first, title, sizeof(title));

    drawTile(20, 50, 104.0f, first.id, title);
    drawStatusPill(20, 162, 104.0f, mixed ? L("Divers") : statusText(first.status),
                   mixed ? kInfo : statusColor(first.status));

    constexpr float columnX = 138.0f;
    char fitted[128];
    fitText(title, 242, 0.62f, fitted, sizeof(fitted));
    drawBold(fitted, columnX, 47, 0.62f, kText);

    char meta[160];
    std::snprintf(meta, sizeof(meta), "%s (%u)%s%s", L("Tous"), static_cast<unsigned>(gGroupCount[position]),
                  first.genre[0] ? "  ·  " : "", localizedGenre(first.genre));
    fitText(meta, 242, 0.36f, fitted, sizeof(fitted));
    drawText(fitted, columnX, 75, 0.36f, kAccent);

    for (std::size_t i = 0; i < count; ++i) {
        const CatalogGame& game = gCatalog.games[members[i]];
        const float y = 100.0f + static_cast<float>(i) * 18.0f;
        C2D_DrawCircleSolid(columnX + 3.5f, y + 7.0f, kDepth, 3.2f, statusColor(game.status));
        fitText(game.name[0] ? game.name : game.id, 150, 0.37f, fitted, sizeof(fitted));
        drawText(fitted, columnX + 12.0f, y, 0.37f, kText);
        drawRight(statusText(game.status), 380, y, 0.37f, kMuted);
    }
}

void drawTopStore() {
    if (!gCatalogLoaded || gCatalog.count == 0) {
        if (gDownloading) drawTopMessage(L("Chargement du catalogue"), L("Connexion en cours..."));
        else drawTopMessage(L("Catalogue indisponible"), L("Vérifiez la connexion Wi-Fi, puis actualisez."));
        return;
    }
    const CatalogGame* game = activeStoreGame();
    if (!game) {
        drawTopMessage(L("Aucun résultat"), L("Aucun jeu ne correspond à la recherche ou aux filtres."));
        return;
    }
    if (gStoreDetailOpen) {
        drawCardOutlined(20, 48, 360, 162, kSurface, kBorder);
        char fitted[128];
        fitText(game->name, 330, 0.56f, fitted, sizeof(fitted));
        drawText(fitted, 34, 58, 0.56f, kText);
        drawCard(34, 82, 332, 112, kSurface2);
        if (gStoreScreenshotSheet) {
            const C2D_Image image = C2D_SpriteSheetGetImage(gStoreScreenshotSheet, 0);
            if (image.subtex && image.subtex->width && image.subtex->height) {
                const float scale = std::min(324.0f / image.subtex->width, 104.0f / image.subtex->height);
                C2D_DrawImageAt(image, 200.0f - image.subtex->width * scale * 0.5f,
                                86.0f + (104.0f - image.subtex->height * scale) * 0.5f,
                                kDepth, nullptr, scale, scale);
            }
            if (game->screenshotCount > 1) {
                char countLabel[16];
                std::snprintf(countLabel, sizeof(countLabel), "< %u/%u >", static_cast<unsigned>(gStoreScreenshotIndex + 1),
                              static_cast<unsigned>(game->screenshotCount));
                drawPill(310, 195, 52, 14, kSurface);
                drawCentered(countLabel, 336, 196.5f, 0.27f, kText);
            }
        } else if (game->screenshotCount == 0 && !game->cover[0]) {
            drawCentered(L("Aucune capture publiée"), 200, 128, 0.38f, kMuted);
        } else if (gScreenshotLoading) {
            drawSpinner(191, 122);
            drawCentered(L("Chargement de la capture..."), 200, 136, 0.36f, kMuted);
        } else {
            drawCentered(L("Capture indisponible"), 200, 128, 0.38f, kMuted);
        }
        return;
    }
    if (!gStoreDetailOpen && gGroupCount[gStoreSel] > 1) drawGroupDetail(gStoreSel);
    else drawGameDetail(*game);
}

void drawKeyValue(float x, float y, const char* key, const char* value) {
    drawText(key, x, y, 0.30f, kFaint);
    drawText(value, x, y + 12, 0.42f, kText);
}

void drawTopLibrary() {
    if (!gInstalledGamesLoaded || gInstalledGames.count == 0) {
        drawTopMessage(L("Aucun jeu installé"), L("Les jeux installés apparaîtront ici."));
        return;
    }
    const InstalledGame& installed = gInstalledGames.games[gLibrarySel];
    const CatalogGame* current = nullptr;
    const bool update = findGameUpdate(gLibrarySel, &current);
    const char* displayName = current && current->name[0] ? current->name : installed.id;

    drawTile(20, 50, 104, installed.id, displayName);
    drawStatusPill(20, 162, 104, update ? L("Mise à jour") : L("À jour"), update ? kAccent : kOk);

    constexpr float columnX = 138.0f;
    char fitted[128];
    fitText(displayName, 242, 0.62f, fitted, sizeof(fitted));
    drawBold(fitted, columnX, 47, 0.62f, kText);

    char size[24];
    drawKeyValue(columnX, 86, L("VERSION INSTALLÉE"), installed.version);
    drawKeyValue(columnX, 118, L("VERSION DU CATALOGUE"), current && current->version[0] ? current->version : L("Inconnue"));
    if (installed.sizeBytes > 0) formatSize(installed.sizeBytes, size, sizeof(size));
    else std::snprintf(size, sizeof(size), "-");
    drawKeyValue(columnX, 150, L("TAILLE SUR LA CARTE SD"), size);
    if (isFavorite(installed.id)) {
        C2D_DrawCircleSolid(376, 197, kDepth, 3.5f, kAccent);
        drawRight(L("Favori"), 368, 191, 0.32f, kAccent);
    }
}

void drawTopUpdates() {
    drawCardOutlined(20, 48, 252, 162, kSurface, kBorder);
    drawText("FLASH GAMES HUB", 34, 58, 0.30f, kFaint);
    drawBold(kHubVersion, 34, 70, 0.8f, kText);

    const char* status = "";
    u32 color = kMuted;
    hubStatus(&status, &color);
    drawStatusPill(34, 104, 150, status, color);

    if (gHubManifestLoaded && gHubManifest.published) {
        char line[96];
        std::snprintf(line, sizeof(line), L("Dernière version  %s"), gHubManifest.latestVersion);
        drawText(line, 34, 130, 0.34f, kText);
        std::snprintf(line, sizeof(line), L("Minimum requis  %s"), gHubManifest.minimumSupportedVersion);
        drawText(line, 34, 144, 0.34f, kMuted);
    }
    if (gHubManifestLoaded && gHubManifest.releaseNotes[0]) {
        drawWrapped(cachedWrap(gNotesWrap, gHubManifest.releaseNotes, 224, 0.32f, 3), 34, 164, 13.0f, 0.32f, kMuted);
    } else if (!gHubManifestLoaded) {
        drawText(L("Connectez-vous pour vérifier les versions."), 34, 130, 0.34f, kMuted);
    }

    drawCardOutlined(284, 48, 96, 162, kSurface, kBorder);
    drawCentered(L("JEUX"), 332, 58, 0.30f, kFaint);
    if (gInstalledGamesLoaded) {
        const std::size_t updates = countGameUpdates();
        char number[16];
        std::snprintf(number, sizeof(number), "%u", static_cast<unsigned>(updates));
        drawCentered(number, 332, 88, 1.3f, updates ? kAccent : kText);
        drawCentered(updates > 1 ? L("mises à jour") : L("mise à jour"), 332, 138, 0.33f, kMuted);
        drawCentered(L("disponible"), 332, 152, 0.33f, kMuted);
    } else {
        drawCentered("-", 332, 88, 1.3f, kFaint);
        drawCentered(L("Aucune donnée"), 332, 138, 0.33f, kMuted);
    }
    std::size_t updateIndex = InstalledGameList::kMaxGames;
    const CatalogGame* updateGame = nullptr;
    if (firstGameUpdate(&updateIndex, &updateGame) && updateGame) {
        char updateLine[96];
        std::snprintf(updateLine, sizeof(updateLine), "%.56s  %.11s -> %.11s", updateGame->name,
                      gInstalledGames.games[updateIndex].version, updateGame->version);
        char fitted[96];
        fitText(updateLine, 238, 0.30f, fitted, sizeof(fitted));
        drawText(fitted, 34, 190, 0.30f, kAccent);
    }
}

void drawTopStorage() {
    if (!gStorageAvailable) {
        drawTopMessage(L("Carte SD indisponible"), L("Insérez une carte SD pour voir l'espace disponible."));
        return;
    }
    drawCardOutlined(20, 48, 360, 162, kSurface, kBorder);
    drawText(L("CARTE SD"), 36, 58, 0.30f, kFaint);

    char value[32];
    formatSize(gStorageFreeBytes, value, sizeof(value));
    drawBold(value, 36, 72, 0.95f, kText);
    drawText(L("libres"), 40 + textWidth(value, 0.95f), 90, 0.38f, kMuted);

    const u64 used = gStorageTotalBytes > gStorageFreeBytes ? gStorageTotalBytes - gStorageFreeBytes : 0;
    const unsigned percent = gStorageTotalBytes ? static_cast<unsigned>(used * 100 / gStorageTotalBytes) : 0;
    const float ratio = gStorageTotalBytes ? static_cast<float>(used) / static_cast<float>(gStorageTotalBytes) : 0.0f;
    drawCard(36, 124, 328, 12, kSurface2);
    if (ratio > 0.0f) {
        float fill = 328.0f * ratio;
        if (fill < 6.0f) fill = 6.0f;
        drawCard(36, 124, fill, 12, percent >= 90 ? kBad : (percent >= 75 ? kWarn : kAccent));
    }

    char usedText[32];
    char totalText[32];
    char line[64];
    formatSize(used, usedText, sizeof(usedText));
    formatSize(gStorageTotalBytes, totalText, sizeof(totalText));
    std::snprintf(line, sizeof(line), L("%s utilisés (%u %%)"), usedText, percent);
    drawText(line, 36, 144, 0.34f, kMuted);
    std::snprintf(line, sizeof(line), L("Total %s"), totalText);
    drawRight(line, 364, 144, 0.34f, kMuted);

    formatSize(gCachedInstalledBytes, value, sizeof(value));
    std::snprintf(line, sizeof(line), L("Jeux installés  %s"), value);
    drawText(line, 36, 178, 0.38f, kText);
    formatSize(gCachedCatalogDataBytes, value, sizeof(value));
    std::snprintf(line, sizeof(line), L("Cache catalogue  %s"), value);
    drawText(line, 36, 192, 0.32f, kMuted);
}

void drawTopSettings() {
    drawCardOutlined(20, 48, 360, 162, kSurface, kBorder);
    drawText(L("LANGUE"), 36, 58, 0.30f, kFaint);
    drawBold(gLang == 0 ? "Français" : "English", 36, 72, 0.8f, kText);
    drawText(L("Appuyez sur A ou touchez un bouton pour changer."), 36, 112, 0.34f, kMuted);
    char line[64];
    std::snprintf(line, sizeof(line), "Flash Games Hub  v%s", kHubVersion);
    drawText(line, 36, 184, 0.34f, kFaint);
}

void drawTopScreen() {
    C2D_TargetClear(gTop, kBg);
    C2D_SceneBegin(gTop);
    drawTopHeader();

    static const Hint storeHints[] = {{"A", "Ouvrir la fiche"}, {"X", "Chercher"}, {"Y", "Genre"}, {"SELECT", "Favoris"}};
    static const Hint storeFormatHints[] = {{"A", "Ouvrir la fiche"}, {"X", "Chercher"}, {"Y", "Format"}, {"SELECT", "Favoris"}};
    static const Hint storeDetailHints[] = {{"A", "Télécharger"}, {"B", "Retour"}, {"◀▶", "Captures"}, {"SELECT", "Favori"}};
    static const Hint storeDetailFormatHints[] = {{"A", "Télécharger"}, {"B", "Retour"}, {"Y", "Format"}, {"SELECT", "Favori"}};
    static const Hint storeFavoriteHints[] = {{"A", "Favori"}, {"X", "Chercher"}, {"Y", "Genre"}, {"SELECT", "Favoris"}};
    static const Hint libraryHints[] = {{"A", "Lancer"}, {"X", "Màj"}, {"Y", "Favori"}, {"B", "Désinstaller"}};
    static const Hint updatesHints[] = {{"A", "Actualiser"}, {"L R", "Onglets"}, {"START", "Quitter"}};
    static const Hint updatesHubHints[] = {{"A", "Màj Hub"}, {"X", "Actualiser"}, {"Y", "Màj Jeux"}, {"L R", "Onglets"}};
    static const Hint updatesGameHints[] = {{"A", "Màj Jeux"}, {"X", "Actualiser"}, {"L R", "Onglets"}, {"START", "Quitter"}};
    static const Hint storageHints[] = {{"A", "Vider le cache"}, {"L R", "Onglets"}, {"START", "Quitter"}};
    static const Hint settingsHints[] = {{"A", "Langue"}, {"L R", "Onglets"}, {"START", "Quitter"}};

    switch (gCurrentPage) {
        case kPageStore:
            drawTopStore();
            if (gStoreDetailOpen) {
                const CatalogGame* active = activeStoreGame();
                const bool dual = hasCiaPackage(active) && hasPackageFormat(active, "3dsx");
                drawTopFooter(dual ? storeDetailFormatHints : storeDetailHints, 4);
            } else {
                drawTopFooter(hasCiaPackage(selectedStoreGame()) ? storeFormatHints :
                              (selectedStoreGame() && selectedStoreGame()->downloadUrl[0] ? storeHints : storeFavoriteHints), 4);
            }
            break;
        case kPageLibrary:
            drawTopLibrary();
            drawTopFooter(libraryHints, 4);
            break;
        case kPageUpdates:
            drawTopUpdates();
            if (hubUpdateAvailable()) drawTopFooter(updatesHubHints, 4);
            else if (firstGameUpdate(nullptr, nullptr)) drawTopFooter(updatesGameHints, 4);
            else drawTopFooter(updatesHints, 3);
            break;
        case kPageSettings:
            drawTopSettings();
            drawTopFooter(settingsHints, 3);
            break;
        default:
            drawTopStorage();
            drawTopFooter(storageHints, 3);
            break;
    }
}

// ---------------------------------------------------------------------------
// Ecran du bas
// ---------------------------------------------------------------------------

void drawTabBar() {
    drawRect(0, 0, kBottomWidth, kTabBarHeight, kSurface);
    drawRect(0, kTabBarHeight, kBottomWidth, 1, kBorder);
    drawCard(gTabIndicator + 6.0f, 4.0f, kTabWidth - 12.0f, kTabBarHeight - 8.0f, kSurface2);
    const float scale = 0.36f;
    for (int i = 0; i < kPageCount; ++i) {
        const float x = static_cast<float>(i) * kTabWidth;
        drawCentered(L(kTabLabels[i]), x + kTabWidth / 2.0f, (kTabBarHeight - lineHeight(scale)) / 2.0f - 1.0f, scale,
                     i == gCurrentPage ? kText : kMuted);
    }
    drawRect(gTabIndicator + 14.0f, kTabBarHeight - 3.0f, kTabWidth - 28.0f, 3, kAccent);

    const unsigned pending = static_cast<unsigned>(countGameUpdates()) + (hubUpdateAvailable() ? 1u : 0u);
    if (pending > 0) {
        C2D_DrawCircleSolid(2.0f * kTabWidth + kTabWidth - 10.0f, 9.0f, kDepth, 3.2f, kAccent);
    }
}

void drawBottomFooter(const char* idleText) {
    drawRect(0, kFooterY, kBottomWidth, 1, kBorder);
    const GamePackageState packageState = getGamePackageState();
    const bool packageDownloading = packageState == GamePackageState::Downloading;
    if (gToastFrames > 0) {
        char fitted[64];
        fitText(gToast, 224.0f, 0.33f, fitted, sizeof(fitted));
        const float pillW = textWidth(fitted, 0.33f) + 18.0f;
        drawPill(10, 213, pillW, 20, kAccentDim);
        drawText(fitted, 19, 217, 0.33f, kAccent);
    } else if (gDownloading || packageDownloading || packageState == GamePackageState::Installing) {
        drawSpinner(16, 223);
        if (packageState == GamePackageState::Installing) {
            drawText(L("Installation CIA..."), 34, 217, 0.34f, kMuted);
        } else if (packageDownloading) {
            u64 downloaded = 0;
            u64 total = 0;
            getGamePackageProgress(&downloaded, &total);
            const unsigned percent = total ? static_cast<unsigned>((downloaded * 100) / total) : 0;
            char progress[64];
            if (total > 0) {
                char dlSize[24];
                char totSize[24];
                formatSize(downloaded, dlSize, sizeof(dlSize));
                formatSize(total, totSize, sizeof(totSize));
                std::snprintf(progress, sizeof(progress), "%u %%  ·  %s / %s", percent, dlSize, totSize);
            } else {
                std::snprintf(progress, sizeof(progress), L("Téléchargement  %u %%"), percent);
            }
            drawText(progress, 34, 216, 0.33f, kMuted);
            drawCard(12, 234, 296, 4, kSurface2);
            if (gProgressAnim > 0.005f) {
                float fill = 296.0f * gProgressAnim;
                if (fill < 6.0f) fill = 6.0f;
                drawCard(12, 234, fill, 4, kAccent);
            }
        } else {
            drawText(L("Synchronisation..."), 34, 217, 0.34f, kMuted);
        }
    } else if (idleText) {
        drawText(idleText, 12, 219, 0.34f, kMuted);
    }
    char version[32];
    std::snprintf(version, sizeof(version), "v%s", kHubVersion);
    drawRight(version, 308, 220, 0.30f, kFaint);
}

void drawScrollbar(float top, float height, std::size_t count, std::size_t rows, float scrollAnim) {
    if (count <= rows) return;
    drawCard(309, top, 3, height, kSurface2);
    float thumb = height * static_cast<float>(rows) / static_cast<float>(count);
    if (thumb < 14.0f) thumb = 14.0f;
    const float travel = height - thumb;
    float ratio = scrollAnim / static_cast<float>(count - rows);
    if (ratio < 0.0f) ratio = 0.0f;
    if (ratio > 1.0f) ratio = 1.0f;
    const float offset = travel * ratio;
    drawCard(309, top + offset, 3, thumb, kMuted);
}

void drawPanelMessage(const char* title, const char* message) {
    drawCardOutlined(10, 52, 300, 140, kSurface, kBorder);
    drawCentered(title, 160, 76, 0.5f, kText);
    drawCentered(message, 160, 102, 0.34f, kMuted);
}

void drawFavoriteMarker(float x, float y, bool favorite, u32 rowColor) {
    if (favorite) {
        C2D_DrawCircleSolid(x, y, kDepth, 4.0f, kAccent);
    } else {
        C2D_DrawCircleSolid(x, y, kDepth, 4.0f, kFaint);
        C2D_DrawCircleSolid(x, y, kDepth, 2.6f, rowColor);
    }
}

void drawBottomStoreDetail() {
    const CatalogGame* game = activeStoreGame();
    if (!game) {
        drawBottomFooter(nullptr);
        return;
    }
    drawCardOutlined(10, 42, 300, 164, kSurface, kBorder);
    char fitted[128];
    fitText(game->name, 194, 0.47f, fitted, sizeof(fitted));
    drawText(fitted, 20, 49, 0.47f, kText);
    drawRight(statusText(game->status), 278, 52, 0.30f, statusColor(game->status));
    drawFavoriteMarker(292, 57, isFavorite(game->id), kSurface);

    std::size_t members[6]{};
    const std::size_t count = gStoreSel < gFilteredCount ? groupMembers(gStoreSel, members, 6) : 0;
    float descriptionY = 72.0f;
    if (count > 1) {
        drawText(L("Épisodes"), 20, 68, 0.28f, kFaint);
        const float chipWidth = 44.0f;
        for (std::size_t i = 0; i < count; ++i) {
            const float x = 18.0f + static_cast<float>(i) * 48.0f;
            const CatalogGame& episode = gCatalog.games[members[i]];
            char episodeLabel[16];
            std::snprintf(episodeLabel, sizeof(episodeLabel), L("Ép. %u"),
                          episode.episode ? episode.episode : static_cast<unsigned>(i + 1));
            drawButton(x, 82, chipWidth, 20, episodeLabel, members[i] == gStoreDetailGameIndex);
        }
        descriptionY = 106.0f;
    }

    const char* localizedDescription = gLang == 1 ? game->descriptionEn : game->description;
    const char* description = localizedDescription[0] ? localizedDescription : L("Aucune description.");
    drawWrapped(cachedWrap(gDescriptionWrap, description, 272, 0.33f, count > 1 ? 2 : 3), 20,
                descriptionY, 11.5f, 0.33f, kMuted);

    drawText(L("Captures d’écran"), 20, 130, 0.28f, kFaint);
    drawCard(18, 141, 284, 24, kSurface2);
    if (game->screenshotCount == 0 && !game->cover[0]) {
        drawCentered(L("Aucune capture publiée"), 160, 149, 0.30f, kMuted);
    } else if (gStoreScreenshotSheet) {
        const C2D_Image image = C2D_SpriteSheetGetImage(gStoreScreenshotSheet, 0);
        if (image.subtex && image.subtex->width && image.subtex->height) {
            const float scale = std::min(280.0f / image.subtex->width, 22.0f / image.subtex->height);
            C2D_DrawImageAt(image, 160.0f - image.subtex->width * scale * 0.5f,
                            142.0f + (22.0f - image.subtex->height * scale) * 0.5f,
                            kDepth, nullptr, scale, scale);
        }
        if (game->screenshotCount > 1) {
            drawText("<", 24, 146, 0.38f, kText);
            drawText(">", 288, 146, 0.38f, kText);
            char countLabel[16];
            std::snprintf(countLabel, sizeof(countLabel), "%u/%u", static_cast<unsigned>(gStoreScreenshotIndex + 1),
                          static_cast<unsigned>(game->screenshotCount));
            drawRight(countLabel, 282, 148, 0.25f, kText);
        }
    } else if (gScreenshotLoading) {
        drawSpinner(151, 153);
    } else if (gScreenshotFailed) {
        drawCentered(L("Capture indisponible"), 160, 149, 0.30f, kMuted);
    } else {
        drawCentered(L("Capture indisponible"), 160, 149, 0.30f, kMuted);
    }

    drawButton(kStoreDetailBackX, kStoreDetailButtonY, 54, kStoreDetailButtonH, L("Retour"), true);
    const bool dualFormat = hasCiaPackage(game) && hasPackageFormat(game, "3dsx");
    const float downloadX = dualFormat ? kStoreDetailDownloadX : kStoreDetailFormatX;
    const float downloadWidth = dualFormat ? 136.0f : 226.0f;
    if (dualFormat) {
        drawButton(kStoreDetailFormatX, kStoreDetailButtonY, 84, kStoreDetailButtonH,
                   L(gStoreCiaFormat ? "Format .cia" : "Format .3dsx"), true);
    }
    const char* format = selectedStoreFormat(game);
    const bool alreadyInstalled = storeGameAlreadyInstalled(game);
    const bool hasUpdate = storeGameHasUpdate(game);
    const bool canInstall = storeGameCanInstall(game) && !alreadyInstalled;
    const GamePackageState packageState = getGamePackageState();
    const char* action = packageState == GamePackageState::Downloading ? L("Téléchargement...") :
                         packageState == GamePackageState::Installing ? L("Installation CIA...") :
                         game->status == GameStatus::Development ? L("En développement") :
                         game->status == GameStatus::Finished ? L("Terminé") :
                         alreadyInstalled ? L("Déjà installé") :
                         hasUpdate ? L("Mettre à jour") :
                         (std::strcmp(format, "cia") == 0 ? L("Installer CIA") : L("Télécharger .3dsx"));
    drawButton(downloadX, kStoreDetailButtonY, downloadWidth, kStoreDetailButtonH, action,
               canInstall && packageState == GamePackageState::Idle);
    drawBottomFooter(nullptr);
}

void drawBottomStore() {
    if (gStoreDetailOpen) {
        drawBottomStoreDetail();
        return;
    }
    char label[96];
    std::snprintf(label, sizeof(label), L("Genre : %s"),
                  gGenreFilterIndex == 0 ? L("Tous") : localizedGenre(gGenres[gGenreFilterIndex - 1]));
    drawChip(10, kChipY, 112, label, gGenreFilterIndex > 0, false);
    fitText(gSearchQuery[0] ? gSearchQuery : L("Rechercher"), 118.0f, 0.34f, label, sizeof(label));
    drawChip(128, kChipY, 118, label, gSearchQuery[0] != 0, false);
    drawChip(252, kChipY, 58, L("Favoris"), false, gFavoritesOnly);

    if (!gCatalogLoaded || gCatalog.count == 0) {
        drawPanelMessage(L("Catalogue indisponible"), L("Aucun catalogue valide n'est chargé."));
        if (gDownloading) {
            drawSpinner(150, 156);
        } else {
            drawButton(kPanelButtonX, kPanelButtonY, kPanelButtonW, kPanelButtonH, L("Réessayer"), true);
        }
        drawBottomFooter(nullptr);
        return;
    }
    if (gFilteredCount == 0) {
        drawPanelMessage(L("Aucun résultat"), L("Modifiez la recherche ou les filtres."));
        drawButton(kPanelButtonX, kPanelButtonY, kPanelButtonW, kPanelButtonH, L("Réinitialiser"), true);
        drawBottomFooter(nullptr);
        return;
    }

    for (std::size_t row = 0; row < kStoreRows; ++row) {
        const std::size_t position = gStoreScroll + row;
        if (position >= gFilteredCount) break;
        const CatalogGame& game = gCatalog.games[gFiltered[position]];
        const bool selected = position == gStoreSel;
        const float y = kStoreListTop + static_cast<float>(row) * kStoreRowHeight;
        const u32 rowColor = selected ? kSurface2 : kSurface;
        if (selected) drawCardOutlined(10, y, 294, kStoreRowHeight - 3, rowColor, kBorder);
        else drawCard(10, y, 294, kStoreRowHeight - 3, rowColor);

        char fitted[96];
        const std::size_t members = gGroupCount[position];
        char title[96];
        if (members > 1) seriesKey(game, title, sizeof(title));
        else std::snprintf(title, sizeof(title), "%s", game.name);
        fitText(title, 172, 0.42f, fitted, sizeof(fitted));
        drawText(fitted, 20, y + 2, 0.42f, selected ? kText : kMuted);
        char sub[128];
        if (members > 1) {
            std::snprintf(sub, sizeof(sub), "%s (%u)  ·  %s", L("Tous"), static_cast<unsigned>(members),
                          localizedGenre(game.genre));
        } else {
            std::snprintf(sub, sizeof(sub), "%s", localizedGenre(game.genre));
        }
        fitText(sub, 172, 0.30f, fitted, sizeof(fitted));
        drawText(fitted, 20, y + 13, 0.30f, kFaint);

        const bool mixed = members > 1 && gGroupMixed[position];
        const char* status = mixed ? L("Divers") : statusText(game.status);
        const float statusWidth = textWidth(status, 0.31f);
        drawRight(status, 266, y + 7, 0.31f, kMuted);
        C2D_DrawCircleSolid(266.0f - statusWidth - 8.0f, y + 12.5f, kDepth, 3.0f, mixed ? kInfo : statusColor(game.status));
        drawFavoriteMarker(287, y + 12, groupIsFavorite(position), rowColor);
        drawText("›", 297, y + 4, 0.42f, selected ? kAccent : kFaint);
    }
    if (gFilteredCount > 0) {
        float selRel = gStoreSelAnim - gStoreScrollAnim;
        if (selRel < 0.0f) selRel = 0.0f;
        if (selRel > static_cast<float>(kStoreRows - 1)) selRel = static_cast<float>(kStoreRows - 1);
        drawRect(10, kStoreListTop + selRel * kStoreRowHeight + 4.0f, 3.0f, kStoreRowHeight - 11.0f, kAccent);
    }
    drawScrollbar(kStoreListTop, static_cast<float>(kStoreRows) * kStoreRowHeight - 3.0f, gFilteredCount, kStoreRows, gStoreScrollAnim);

    char count[48];
    std::snprintf(count, sizeof(count), L("Jeu %u sur %u"), static_cast<unsigned>(gStoreSel + 1), static_cast<unsigned>(gFilteredCount));
    drawBottomFooter(count);
}

void drawBottomLibrary() {
    if (!gInstalledGamesLoaded || gInstalledGames.count == 0) {
        drawPanelMessage(L("Aucun jeu installé"), L("Les jeux installés apparaîtront ici."));
        drawBottomFooter(nullptr);
        return;
    }
    for (std::size_t row = 0; row < kLibraryRows; ++row) {
        const std::size_t index = gLibraryScroll + row;
        if (index >= gInstalledGames.count) break;
        const InstalledGame& installed = gInstalledGames.games[index];
        const CatalogGame* current = nullptr;
        const bool update = findGameUpdate(index, &current);
        const bool selected = index == gLibrarySel;
        const float y = kLibraryListTop + static_cast<float>(row) * kLibraryRowHeight;
        const u32 rowColor = selected ? kSurface2 : kSurface;
        if (selected) drawCardOutlined(10, y, 294, kLibraryRowHeight - 3, rowColor, kBorder);
        else drawCard(10, y, 294, kLibraryRowHeight - 3, rowColor);

        char fitted[96];
        fitText(current && current->name[0] ? current->name : installed.id, 166, 0.42f, fitted, sizeof(fitted));
        drawText(fitted, 20, y + 2, 0.42f, selected ? kText : kMuted);

        char details[64];
        char size[24];
        if (installed.sizeBytes > 0) {
            formatSize(installed.sizeBytes, size, sizeof(size));
            std::snprintf(details, sizeof(details), "v%s  ·  %s", installed.version, size);
        } else {
            std::snprintf(details, sizeof(details), "v%s", installed.version);
        }
        fitText(details, 166, 0.30f, fitted, sizeof(fitted));
        drawText(fitted, 20, y + 13, 0.30f, kFaint);

        if (update) {
            drawPill(200, y + 5, 74, 15, kAccentDim);
            drawCentered(L("Mise à jour"), 237, y + 6.5f, 0.28f, kAccent);
        } else {
            drawRight(L("À jour"), 274, y + 7, 0.31f, kFaint);
        }
        drawFavoriteMarker(290, y + 12, isFavorite(installed.id), rowColor);
    }
    if (gInstalledGames.count > 0) {
        float selRel = gLibrarySelAnim - gLibraryScrollAnim;
        if (selRel < 0.0f) selRel = 0.0f;
        if (selRel > static_cast<float>(kLibraryRows - 1)) selRel = static_cast<float>(kLibraryRows - 1);
        drawRect(10, kLibraryListTop + selRel * kLibraryRowHeight + 4.0f, 3.0f, kLibraryRowHeight - 11.0f, kAccent);
    }
    drawScrollbar(kLibraryListTop, static_cast<float>(kLibraryRows) * kLibraryRowHeight - 3.0f, gInstalledGames.count,
                  kLibraryRows, gLibraryScrollAnim);

    char count[48];
    std::snprintf(count, sizeof(count), L("%u jeu(x) installé(s)"), static_cast<unsigned>(gInstalledGames.count));
    drawBottomFooter(count);
}

void drawBottomUpdates() {
    const char* status = "";
    u32 statusTint = kMuted;
    hubStatus(&status, &statusTint);

    drawCardOutlined(10, 42, 300, 64, kSurface, kBorder);
    drawText("FLASH GAMES HUB", 22, 50, 0.28f, kFaint);
    drawText(status, 22, 63, 0.46f, statusTint == kMuted ? kText : statusTint);
    char line[96];
    if (gHubManifestLoaded && gHubManifest.published) {
        std::snprintf(line, sizeof(line), L("Installée %s  ·  Dernière %s"), kHubVersion, gHubManifest.latestVersion);
    } else {
        std::snprintf(line, sizeof(line), L("Installée %s"), kHubVersion);
    }
    char fitted[96];
    fitText(line, hubUpdateAvailable() ? 174.0f : 276.0f, 0.32f, fitted, sizeof(fitted));
    drawText(fitted, 22, 84, 0.32f, kMuted);

    const GamePackageState packageState = getGamePackageState();
    if (hubUpdateAvailable()) {
        drawButton(202, 56, 96, 34, L("Mettre à jour"), packageState == GamePackageState::Idle);
    }

    drawCardOutlined(10, 114, 300, 42, kSurface, kBorder);
    drawText(L("JEUX INSTALLÉS"), 22, 121, 0.28f, kFaint);
    if (!gInstalledGamesLoaded) {
        drawText(L("Aucune donnée"), 22, 134, 0.40f, kMuted);
    } else {
        const std::size_t updates = countGameUpdates();
        if (updates == 0) std::snprintf(line, sizeof(line), "%s", L("Tout est à jour"));
        else std::snprintf(line, sizeof(line), L("%u mise(s) à jour disponible(s)"), static_cast<unsigned>(updates));
        drawText(line, 22, 134, 0.40f, updates ? kAccent : kText);
    }

    std::size_t updateIndex = InstalledGameList::kMaxGames;
    const CatalogGame* updateGame = nullptr;
    if (firstGameUpdate(&updateIndex, &updateGame) && updateGame) {
        char updateLine[112];
        std::snprintf(updateLine, sizeof(updateLine), "%.72s  %.11s -> %.11s", updateGame->name,
                      gInstalledGames.games[updateIndex].version, updateGame->version);
        char fitted[112];
        fitText(updateLine, 276, 0.30f, fitted, sizeof(fitted));
        drawText(fitted, 22, 146, 0.30f, kMuted);
    }

    drawButton(kRefreshButtonX, kRefreshButtonY, 144.0f, kRefreshButtonH,
               gDownloading ? L("Actualisation...") : L("Actualiser"), !gDownloading);
    const bool hasUpdate = firstGameUpdate(nullptr, nullptr);
    const char* updateButtonLabel = packageState == GamePackageState::Downloading || packageState == GamePackageState::Installing ? L("Téléchargement...") :
                                    hasUpdate ? L("Télécharger la mise à jour") : L("Aucune mise à jour");
    drawButton(kGameUpdateButtonX, kRefreshButtonY, kGameUpdateButtonW, kRefreshButtonH,
               updateButtonLabel, hasUpdate && packageState == GamePackageState::Idle);
    drawBottomFooter(nullptr);
}

void drawBottomStorage() {
    drawCardOutlined(10, 42, 300, 164, kSurface, kBorder);
    if (!gStorageAvailable) {
        drawCentered(L("Carte SD indisponible"), 160, 100, 0.5f, kText);
        drawCentered(L("Les mesures s'afficheront ici."), 160, 126, 0.34f, kMuted);
        drawBottomFooter(nullptr);
        return;
    }
    const u64 used = gStorageTotalBytes > gStorageFreeBytes ? gStorageTotalBytes - gStorageFreeBytes : 0;
    const char* labels[5] = {L("Espace libre"), L("Espace utilisé"), L("Capacité totale"), L("Jeux installés"), L("Cache catalogue")};
    u64 values[5] = {gStorageFreeBytes, used, gStorageTotalBytes, gCachedInstalledBytes, gCachedCatalogDataBytes};
    for (int i = 0; i < 5; ++i) {
        const float y = 47.0f + static_cast<float>(i) * 25.0f;
        char value[32];
        formatSize(values[i], value, sizeof(value));
        drawText(labels[i], 24, y + 4, 0.34f, kMuted);
        drawRight(value, 296, y + 3, 0.40f, kText);
        if (i < 4) drawRect(24, y + 22, 272, 1, kBorder);
    }
    drawButton(kClearCacheX, kClearCacheY, kClearCacheW, kClearCacheH, L("Vider le cache"), true);
    drawBottomFooter(nullptr);
}

void drawBottomSettings() {
    drawCardOutlined(10, 42, 300, 156, kSurface, kBorder);
    drawText(L("LANGUE"), 22, 52, 0.30f, kFaint);
    drawButton(kLangFrX, kLangY, kLangW, kLangH, "Français", gLang == 0);
    drawButton(kLangEnX, kLangY, kLangW, kLangH, "English", gLang == 1);
    drawText(L("Choisissez la langue de l'interface."), 22, 124, 0.34f, kMuted);
    drawBottomFooter(nullptr);
}

void drawBottomScreen() {
    C2D_TargetClear(gBottom, kBg);
    C2D_SceneBegin(gBottom);
    drawTabBar();
    switch (gCurrentPage) {
        case kPageStore: drawBottomStore(); break;
        case kPageLibrary: drawBottomLibrary(); break;
        case kPageUpdates: drawBottomUpdates(); break;
        case kPageSettings: drawBottomSettings(); break;
        default: drawBottomStorage(); break;
    }
    if (gConfirmUninstall) {
        drawRect(0, 34, kBottomWidth, 174, C2D_Color32(0, 0, 0, 190));
        drawCardOutlined(10, 72, 300, 112, kSurface, kBorder);
        drawCentered(L("Confirmer la désinstallation"), 160, 88, 0.43f, kText);
        drawCentered(L("A pour confirmer la désinstallation"), 160, 112, 0.34f, kMuted);
        drawButton(20, 142, 126, 28, L("Annuler"), false);
        drawButton(174, 142, 126, 28, L("Désinstaller"), true);
    }
}

// ---------------------------------------------------------------------------
// Entrees
// ---------------------------------------------------------------------------

void changePage(int direction) {
    gCurrentPage = (gCurrentPage + kPageCount + direction) % kPageCount;
    if (gCurrentPage != kPageStore) closeStoreDetail();
    if (gCurrentPage == kPageStorage) readStorageStats();
}

void goToPage(int page) {
    if (page < 0 || page >= kPageCount) return;
    gCurrentPage = page;
    if (gCurrentPage != kPageStore) closeStoreDetail();
    if (gCurrentPage == kPageStorage) readStorageStats();
}

void moveSelection(int direction) {
    if (gCurrentPage == kPageStore && gStoreDetailOpen) {
        if (gStoreSel >= gFilteredCount || gGroupCount[gStoreSel] < 2) return;
        std::size_t members[6]{};
        const std::size_t count = groupMembers(gStoreSel, members, 6);
        if (count == 0) return;
        std::size_t current = 0;
        while (current < count && members[current] != gStoreDetailGameIndex) ++current;
        if (current == count) current = 0;
        current = (current + count + (direction < 0 ? count - 1 : 1)) % count;
        gStoreDetailGameIndex = members[current];
        gStoreScreenshotIndex = 0;
        requestStoreScreenshot();
        return;
    }
    if (gCurrentPage == kPageStore && gFilteredCount > 0) {
        gStoreSel = (gStoreSel + (direction < 0 ? gFilteredCount - 1 : 1)) % gFilteredCount;
        clampScroll(gStoreSel, gFilteredCount, kStoreRows, &gStoreScroll);
    } else if (gCurrentPage == kPageLibrary && gInstalledGamesLoaded && gInstalledGames.count > 0) {
        gLibrarySel = (gLibrarySel + (direction < 0 ? gInstalledGames.count - 1 : 1)) % gInstalledGames.count;
        clampScroll(gLibrarySel, gInstalledGames.count, kLibraryRows, &gLibraryScroll);
    }
}

bool inside(const touchPosition& touch, float x, float y, float width, float height) {
    return touch.px >= x && touch.px < x + width && touch.py >= y && touch.py < y + height;
}

void handleStoreTouch(const touchPosition& touch) {
    if (!gCatalogLoaded || gCatalog.count == 0) {
        if (!gDownloading && inside(touch, kPanelButtonX, kPanelButtonY, kPanelButtonW, kPanelButtonH)) refreshCatalog();
        return;
    }
    if (gStoreDetailOpen) {
        const CatalogGame* game = activeStoreGame();
        if (game && inside(touch, 276, 44, 34, 24)) {
            toggleFavoriteId(game->id);
        } else if (inside(touch, kStoreDetailBackX, kStoreDetailButtonY, 54, kStoreDetailButtonH)) {
            closeStoreDetail();
        } else if (inside(touch, kStoreDetailDownloadX, kStoreDetailButtonY, 136, kStoreDetailButtonH) ||
                   (!(hasCiaPackage(game) && hasPackageFormat(game, "3dsx")) &&
                    inside(touch, kStoreDetailFormatX, kStoreDetailButtonY, 226, kStoreDetailButtonH))) {
            requestSelectedStoreDownload();
        } else if (hasCiaPackage(game) && hasPackageFormat(game, "3dsx") &&
                   inside(touch, kStoreDetailFormatX, kStoreDetailButtonY, 84, kStoreDetailButtonH)) {
            gStoreCiaFormat = !gStoreCiaFormat;
        } else if (gStoreSel < gFilteredCount && gGroupCount[gStoreSel] > 1 &&
                   inside(touch, 18, 82, 284, 20)) {
            std::size_t members[6]{};
            const std::size_t count = groupMembers(gStoreSel, members, 6);
            const std::size_t episode = static_cast<std::size_t>((touch.px - 18) / 48);
            if (episode < count && touch.px < 18.0f + static_cast<float>(count) * 48.0f) {
                gStoreDetailGameIndex = members[episode];
                gStoreScreenshotIndex = 0;
                requestStoreScreenshot();
            }
        } else if (game && game->screenshotCount > 1 && inside(touch, 18, 141, 284, 24)) {
            gStoreScreenshotIndex = (gStoreScreenshotIndex + (touch.px < 160 ? game->screenshotCount - 1 : 1)) % game->screenshotCount;
            requestStoreScreenshot();
        }
        return;
    }
    if (inside(touch, 10, kChipY, 112, kChipHeight)) {
        cycleGenreFilter();
    } else if (inside(touch, 128, kChipY, 118, kChipHeight)) {
        editStoreSearch();
    } else if (inside(touch, 252, kChipY, 58, kChipHeight)) {
        gFavoritesOnly = !gFavoritesOnly;
        rebuildFilter();
    } else if (gFilteredCount == 0) {
        if (inside(touch, kPanelButtonX, kPanelButtonY, kPanelButtonW, kPanelButtonH)) resetFilters();
    } else if (inside(touch, 0, kStoreListTop, kBottomWidth, static_cast<float>(kStoreRows) * kStoreRowHeight)) {
        const std::size_t row = static_cast<std::size_t>((touch.py - kStoreListTop) / kStoreRowHeight);
        const std::size_t position = gStoreScroll + row;
        if (position < gFilteredCount) {
            gStoreSel = position;
            if (touch.px >= kFavoriteHitX) toggleGroupFavorite(position);
            else openSelectedStoreDetail();
        }
    }
}

void handleLibraryTouch(const touchPosition& touch) {
    if (!gInstalledGamesLoaded || gInstalledGames.count == 0) return;
    if (inside(touch, 0, kLibraryListTop, kBottomWidth, static_cast<float>(kLibraryRows) * kLibraryRowHeight)) {
        const std::size_t row = static_cast<std::size_t>((touch.py - kLibraryListTop) / kLibraryRowHeight);
        const std::size_t index = gLibraryScroll + row;
        if (index < gInstalledGames.count) {
            if (touch.px >= kFavoriteHitX) {
                gLibrarySel = index;
                toggleFavoriteId(gInstalledGames.games[index].id);
            } else if (gLibrarySel == index) {
                launchSelectedGame();
            } else {
                gLibrarySel = index;
            }
        }
    }
}

void handleTouch(const touchPosition& touch) {
    if (touch.py < kTabBarHeight) {
        goToPage(static_cast<int>(touch.px / kTabWidth));
        return;
    }
    if (gCurrentPage == kPageStore) handleStoreTouch(touch);
    else if (gCurrentPage == kPageLibrary) handleLibraryTouch(touch);
    else if (gCurrentPage == kPageUpdates) {
        if (hubUpdateAvailable() && inside(touch, 202, 56, 96, 34)) {
            requestHubUpdate();
        } else if (inside(touch, kRefreshButtonX, kRefreshButtonY, 144.0f, kRefreshButtonH)) {
            if (!gDownloading) refreshCatalog();
        } else if (inside(touch, kGameUpdateButtonX, kRefreshButtonY, kGameUpdateButtonW, kRefreshButtonH)) {
            requestFirstGameUpdate();
        }
    } else if (gCurrentPage == kPageStorage) {
        if (inside(touch, kClearCacheX, kClearCacheY, kClearCacheW, kClearCacheH)) clearCatalogCache();
    } else if (gCurrentPage == kPageSettings) {
        if (inside(touch, kLangFrX, kLangY, kLangW, kLangH)) setLanguage(0);
        else if (inside(touch, kLangEnX, kLangY, kLangW, kLangH)) setLanguage(1);
    }
}

void handleInput() {
    hidScanInput();
    const u32 down = hidKeysDown();
    const u32 held = hidKeysHeld();

    if (gConfirmUninstall) {
        if (down & KEY_A) {
            gConfirmUninstall = false;
            uninstallSelectedGame();
        } else if (down & KEY_B) {
            gConfirmUninstall = false;
            showToast(L("Désinstallation annulée"));
        } else if (down & KEY_TOUCH) {
            touchPosition touch{};
            hidTouchRead(&touch);
            if (inside(touch, 174, 142, 126, 28)) {
                gConfirmUninstall = false;
                uninstallSelectedGame();
            } else if (inside(touch, 20, 142, 126, 28)) {
                gConfirmUninstall = false;
                showToast(L("Désinstallation annulée"));
            }
        }
        return;
    }

    if (down & KEY_START) {
        gQuit = true;
        return;
    }
    if (down & KEY_L) changePage(-1);
    if (down & KEY_R) changePage(1);
    if (gCurrentPage == kPageStore && gStoreDetailOpen) {
        const CatalogGame* game = activeStoreGame();
        if (game && game->screenshotCount > 1 && (down & (KEY_LEFT | KEY_RIGHT))) {
            gStoreScreenshotIndex = (gStoreScreenshotIndex + ((down & KEY_LEFT) ? game->screenshotCount - 1 : 1)) %
                                    game->screenshotCount;
            requestStoreScreenshot();
        }
    } else {
        if (down & KEY_LEFT) changePage(-1);
        if (down & KEY_RIGHT) changePage(1);
    }

    // Haut / bas avec repetition quand on maintient la touche.
    int move = 0;
    if (down & KEY_UP) {
        move = -1;
        gHoldFrames = 0;
    } else if (down & KEY_DOWN) {
        move = 1;
        gHoldFrames = 0;
    } else if (held & (KEY_UP | KEY_DOWN)) {
        ++gHoldFrames;
        if (gHoldFrames > 18 && gHoldFrames % 4 == 0) move = (held & KEY_UP) ? -1 : 1;
    } else {
        gHoldFrames = 0;
    }
    if (move != 0) moveSelection(move);

    if (gCurrentPage == kPageStore) {
        if (gStoreDetailOpen) {
            if (down & KEY_A) requestSelectedStoreDownload();
            if (down & KEY_B) closeStoreDetail();
            if (down & KEY_Y) {
                const CatalogGame* game = activeStoreGame();
                if (hasCiaPackage(game) && hasPackageFormat(game, "3dsx")) {
                    gStoreCiaFormat = !gStoreCiaFormat;
                    showToast(L(gStoreCiaFormat ? "Format .cia" : "Format .3dsx"));
                }
            }
            if (down & KEY_SELECT) {
                const CatalogGame* game = activeStoreGame();
                if (game) toggleFavoriteId(game->id);
            }
        } else {
            if (down & KEY_A) {
                const CatalogGame* game = selectedStoreGame();
                if (game) openSelectedStoreDetail();
                else if (!gCatalogLoaded && !gDownloading) refreshCatalog();
            }
            if (down & KEY_X) editStoreSearch();
            if (down & KEY_Y) {
                const CatalogGame* game = selectedStoreGame();
                if (hasCiaPackage(game) && hasPackageFormat(game, "3dsx")) {
                    gStoreCiaFormat = !gStoreCiaFormat;
                    showToast(L(gStoreCiaFormat ? "Format .cia" : "Format .3dsx"));
                } else {
                    cycleGenreFilter();
                }
            }
            if (down & KEY_B) resetFilters();
            if (down & KEY_SELECT) {
                gFavoritesOnly = !gFavoritesOnly;
                rebuildFilter();
            }
        }
    } else if (gCurrentPage == kPageLibrary) {
        if (down & KEY_A) launchSelectedGame();
        if (down & KEY_X) requestSelectedGameUpdate();
        if (down & KEY_Y && gInstalledGamesLoaded && gLibrarySel < gInstalledGames.count) {
            toggleFavoriteId(gInstalledGames.games[gLibrarySel].id);
        }
        if (down & KEY_B && gInstalledGamesLoaded && gLibrarySel < gInstalledGames.count) {
            if (getGamePackageState() != GamePackageState::Idle) showToast(L("Téléchargement..."));
            else gConfirmUninstall = true;
        }
    } else if (gCurrentPage == kPageUpdates) {
        if (down & KEY_A) {
            if (hubUpdateAvailable()) requestHubUpdate();
            else if (firstGameUpdate(nullptr, nullptr)) requestFirstGameUpdate();
            else if (!gDownloading) refreshCatalog();
        }
        if (down & KEY_X) {
            if (!gDownloading) refreshCatalog();
        }
        if (down & KEY_Y) {
            if (firstGameUpdate(nullptr, nullptr)) requestFirstGameUpdate();
        }
    } else if (gCurrentPage == kPageStorage) {
        if (down & KEY_A) clearCatalogCache();
    } else if (gCurrentPage == kPageSettings) {
        if (down & KEY_A) setLanguage(gLang == 0 ? 1 : 0);
    }

    if (down & KEY_TOUCH) {
        touchPosition touch{};
        hidTouchRead(&touch);
        handleTouch(touch);
    }
}

void updateAnimation() {
    ++gFrame;
    if (gToastFrames > 0) --gToastFrames;
    GamePackageResult packageResult{};
    if (takeGamePackageResult(&packageResult)) {
        if (packageResult.isHubUpdate) {
            if (packageResult.state == GamePackageState::Installed) {
                showToast(L("Hub mis à jour"));
                if (!envIsHomebrew() && packageResult.titleId != 0) {
                    gRelaunchTitleId = packageResult.titleId;
                    gQuit = true;
                }
            } else {
                showToast(L("Échec de la mise à jour du Hub"));
            }
        } else if (packageResult.state == GamePackageState::Installed) {
            gInstalledGamesLoaded = loadInstalledGames();
            syncInstalledCiaGames();
            if (gInstalledGamesLoaded && gLibrarySel >= gInstalledGames.count) gLibrarySel = 0;
            showToast(L("Jeu installé"));
        } else {
            showToast(L("Échec de l'installation"));
        }
    }
    ScreenshotCacheResult screenshotResult{};
    if (takeScreenshotCacheResult(&screenshotResult)) {
        const bool currentRequest = gPendingScreenshotCachePath[0] &&
                                    std::strcmp(gPendingScreenshotCachePath, screenshotResult.localPath) == 0;
        if (gStoreDetailOpen && currentRequest && screenshotResult.state == ScreenshotCacheState::Ready) {
            gStoreScreenshotSheet = C2D_SpriteSheetLoad(screenshotResult.localPath);
            if (gStoreScreenshotSheet) {
                std::snprintf(gStoreScreenshotSheetPath, sizeof(gStoreScreenshotSheetPath), "%s", screenshotResult.localPath);
            } else {
                gScreenshotFailed = true;
            }
        } else if (gStoreDetailOpen && currentRequest) {
            gScreenshotFailed = true;
        }
        gScreenshotLoading = false;
        gPendingScreenshotCachePath[0] = '\0';
        if (gStoreDetailOpen && !currentRequest) requestStoreScreenshot();
    }
    gDownloading = getCatalogUpdateState() == CatalogUpdateState::Downloading;
    auto smoothTo = [](float& current, float target, float speed) {
        current += (target - current) * speed;
        if (std::fabs(target - current) < 0.02f) current = target;
    };
    const float target = static_cast<float>(gCurrentPage) * kTabWidth;
    gTabIndicator += (target - gTabIndicator) * 0.35f;
    if (std::fabs(target - gTabIndicator) < 0.5f) gTabIndicator = target;
    smoothTo(gStoreScrollAnim, static_cast<float>(gStoreScroll), 0.30f);
    smoothTo(gLibraryScrollAnim, static_cast<float>(gLibraryScroll), 0.30f);
    smoothTo(gStoreSelAnim, static_cast<float>(gStoreSel), 0.35f);
    smoothTo(gLibrarySelAnim, static_cast<float>(gLibrarySel), 0.35f);
    if (getGamePackageState() == GamePackageState::Downloading) {
        u64 downloaded = 0;
        u64 total = 0;
        getGamePackageProgress(&downloaded, &total);
        const float targetProgress = total > 0 ? static_cast<float>(downloaded) / static_cast<float>(total) : 0.0f;
        gProgressAnim += (targetProgress - gProgressAnim) * 0.25f;
    } else {
        gProgressAnim = 0.0f;
    }
}

// ---------------------------------------------------------------------------
// Initialisation
// ---------------------------------------------------------------------------

bool initializeGraphics() {
    gfxInitDefault();
    if (!C3D_Init(C3D_DEFAULT_CMDBUF_SIZE)) {
        gfxExit();
        return false;
    }
    if (!C2D_Init(C2D_DEFAULT_MAX_OBJECTS)) {
        C3D_Fini();
        gfxExit();
        return false;
    }
    C2D_Prepare();

    gTextBuffer = C2D_TextBufNew(16384);
    gMeasureBuffer = C2D_TextBufNew(1024);
    gTop = C3D_RenderTargetCreate(kScreenHeight, kTopWidth, GPU_RB_RGBA8, GPU_RB_DEPTH24_STENCIL8);
    gBottom = C3D_RenderTargetCreate(kScreenHeight, kBottomWidth, GPU_RB_RGBA8, GPU_RB_DEPTH24_STENCIL8);
    if (!gTextBuffer || !gMeasureBuffer || !gTop || !gBottom) {
        if (gBottom) C3D_RenderTargetDelete(gBottom);
        if (gTop) C3D_RenderTargetDelete(gTop);
        if (gMeasureBuffer) C2D_TextBufDelete(gMeasureBuffer);
        if (gTextBuffer) C2D_TextBufDelete(gTextBuffer);
        C2D_Fini();
        C3D_Fini();
        gfxExit();
        return false;
    }

    constexpr u32 transferFlags = GX_TRANSFER_FLIP_VERT(0) |
                                  GX_TRANSFER_OUT_TILED(0) |
                                  GX_TRANSFER_RAW_COPY(0) |
                                  GX_TRANSFER_IN_FORMAT(GX_TRANSFER_FMT_RGBA8) |
                                  GX_TRANSFER_OUT_FORMAT(GX_TRANSFER_FMT_RGB8);
    C3D_RenderTargetSetOutput(gTop, GFX_TOP, GFX_LEFT, transferFlags);
    C3D_RenderTargetSetOutput(gBottom, GFX_BOTTOM, GFX_LEFT, transferFlags);
    return true;
}

void shutdownGraphics() {
    C3D_RenderTargetDelete(gBottom);
    C3D_RenderTargetDelete(gTop);
    C2D_TextBufDelete(gMeasureBuffer);
    C2D_TextBufDelete(gTextBuffer);
    C2D_Fini();
    C3D_Fini();
    gfxExit();
}

} // namespace

int main() {
    gConsoleModelKnown = R_SUCCEEDED(APT_CheckNew3DS(&gIsNew3DS));
    gRomfsReady = R_SUCCEEDED(romfsInit());
    loadSettings();
    loadFavorites();
    gInstalledGamesLoaded = loadInstalledGames();
    if (loadCachedHubManifest(&gHubManifest)) {
        gHubManifestLoaded = true;
    } else {
        gHubManifestLoaded = loadEmbeddedHubManifest();
    }
    const bool hasCachedCatalog = loadCachedCatalog(&gCachedCatalog);
    const bool hasEmbeddedCatalog = loadEmbeddedCatalog(&gCatalog);
    if (hasCachedCatalog && (!hasEmbeddedCatalog || gCachedCatalog.catalogVersion >= gCatalog.catalogVersion)) {
        gCatalog = gCachedCatalog;
        gCatalogLoaded = true;
    } else {
        gCatalogLoaded = hasEmbeddedCatalog;
    }
    syncInstalledCiaGames();
    rebuildGenres();
    rebuildFilter();
    readStorageStats();

    if (!initializeGraphics()) {
        if (gRomfsReady) romfsExit();
        return 1;
    }
    startCatalogDownload();

    while (aptMainLoop() && !gQuit) {
        applyDownloadedCatalog();
        handleInput();
        updateAnimation();
        C3D_FrameBegin(C3D_FRAME_SYNCDRAW);
        C2D_TextBufClear(gTextBuffer);
        drawTopScreen();
        drawBottomScreen();
        C3D_FrameEnd(0);
    }

    stopScreenshotCache();
    stopCatalogDownload();
    shutdownGraphics();
    if (gRomfsReady) romfsExit();
    if (gRelaunchTitleId != 0) {
        APT_PrepareToDoApplicationJump(0, gRelaunchTitleId, MEDIATYPE_SD);
        APT_DoApplicationJump(nullptr, 0, nullptr);
    }
    return 0;
}
