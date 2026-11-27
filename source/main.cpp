#include <3ds.h>
#include <citro2d.h>
#include "catalog.hpp"
#include "catalog_network.hpp"
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
constexpr const char* kHubVersion = "0.1.0-dev";
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

constexpr const char* kTabLabels[kPageCount] = {"Store", "Jeux", "Màj", "Stockage", "Réglages"};

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

// ---------------------------------------------------------------------------
// Etat
// ---------------------------------------------------------------------------

C3D_RenderTarget* gTop = nullptr;
C3D_RenderTarget* gBottom = nullptr;
C2D_TextBuf gTextBuffer = nullptr;
C2D_TextBuf gMeasureBuffer = nullptr;

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
bool gQuit = false;
bool gDownloading = false;
bool gConfirmUninstall = false;

int gCurrentPage = kPageStore;
float gTabIndicator = 0.0f;
unsigned gFrame = 0;
unsigned gHoldFrames = 0;

char gGenres[kMaxGenres][48]{};
std::size_t gGenreCount = 0;
std::size_t gGenreFilterIndex = 0;
char gSearchQuery[128]{};
bool gFavoritesOnly = false;
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

int gLang = 0;  // 0 = francais, 1 = anglais

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
    {"Téléchargement terminé", "Download complete"},
    {"Jeu déjà installé", "Game already installed"},
    {"Téléchargement...", "Downloading..."},
    {"Aucune mise à jour", "No update available"},
    {"Mise à jour installée", "Update installed"},
    {"Échec, version précédente conservée", "Failed; previous version kept"},
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

// Pas de police grasse sur 3DS : on double le trace avec un leger decalage.
void drawBold(const char* value, float x, float y, float scale, u32 color) {
    if (!value || !value[0]) return;
    scale = crisp(scale);
    x = std::floor(x + 0.5f);
    y = std::floor(y + 0.5f);
    C2D_Text text;
    C2D_TextParse(&text, gTextBuffer, value);
    C2D_TextOptimize(&text);
    C2D_DrawText(&text, C2D_WithColor, x, y, kDepth, scale, scale, color);
    C2D_DrawText(&text, C2D_WithColor, x + 1.0f, y, kDepth, scale, scale, color);
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
        std::snprintf(out, capacity, "%u,%u Go", static_cast<unsigned>(tenths / 10), static_cast<unsigned>(tenths % 10));
    } else if (bytes >= kMi) {
        const u64 tenths = bytes * 10 / kMi;
        std::snprintf(out, capacity, "%u,%u Mo", static_cast<unsigned>(tenths / 10), static_cast<unsigned>(tenths % 10));
    } else if (bytes >= kKi) {
        std::snprintf(out, capacity, "%u Ko", static_cast<unsigned>(bytes / kKi));
    } else {
        std::snprintf(out, capacity, "%u o", static_cast<unsigned>(bytes));
    }
}

const char* statusText(GameStatus status) {
    switch (status) {
        case GameStatus::Available: return L("Disponible");
        case GameStatus::Unavailable: return L("Indisponible");
        case GameStatus::ComingSoon: return L("Bientôt");
        case GameStatus::Development: return L("En dev.");
        case GameStatus::Discontinued: return L("Arrêté");
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

bool loadEmbeddedCatalog() {
    std::size_t length = 0;
    char* contents = readSmallFile("romfs:/catalog.json", 128 * 1024, &length);
    if (!contents) return false;
    const bool valid = parseCatalogJson(contents, length, &gCatalog);
    std::free(contents);
    return valid;
}

bool loadEmbeddedHubManifest() {
    std::size_t length = 0;
    char* contents = readSmallFile("romfs:/hub.json", 16 * 1024, &length);
    if (!contents) return false;
    const bool valid = parseHubManifestJson(contents, length, &gHubManifest);
    std::free(contents);
    return valid;
}

bool loadInstalledGames() {
    return loadInstalledGamesFromSd(&gInstalledGames);
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

void readStorageStats() {
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
    if (std::fgets(line, sizeof(line), file) && line[0] == 'e' && line[1] == 'n') gLang = 1;
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
           containsText(game.genre, gSearchQuery) || containsText(game.developer, gSearchQuery);
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

// Recalcule la liste filtree (une fois par changement, pas a chaque image) en
// conservant autant que possible le jeu selectionne.
void rebuildFilter() {
    if (gGenreFilterIndex > gGenreCount) gGenreFilterIndex = 0;
    char previousId[64]{};
    const std::size_t previousSelection = gStoreSel;
    if (gStoreSel < gFilteredCount && gFiltered[gStoreSel] < gCatalog.count) {
        std::snprintf(previousId, sizeof(previousId), "%s", gCatalog.games[gFiltered[gStoreSel]].id);
    }
    gFilteredCount = 0;
    if (gCatalogLoaded) {
        for (std::size_t i = 0; i < gCatalog.count; ++i) {
            const CatalogGame& game = gCatalog.games[i];
            if (!matchesFilters(game)) continue;
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
    return count;
}

const CatalogGame* selectedStoreGame() {
    if (gStoreSel >= gFilteredCount) return nullptr;
    return &gCatalog.games[gFiltered[gStoreSel]];
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
    if (getGamePackageState() == GamePackageState::Downloading) return;
    if (!startGamePackageDownload(update)) showToast(L("Téléchargement indisponible"));
}

void requestSelectedGameUpdate() {
    if (!gInstalledGamesLoaded || gLibrarySel >= gInstalledGames.count) return;
    if (getGamePackageState() == GamePackageState::Downloading) return;
    const CatalogGame* update = nullptr;
    if (!findGameUpdate(gLibrarySel, &update) || !update) {
        showToast(L("Aucune mise à jour"));
        return;
    }
    if (!startGamePackageDownload(update)) showToast(L("Téléchargement indisponible"));
}

void requestSelectedStoreDownload() {
    const CatalogGame* game = selectedStoreGame();
    if (!game || !game->downloadUrl[0] ||
        (game->status != GameStatus::Available && game->status != GameStatus::Development) ||
        std::strcmp(game->downloadFormat, "3dsx") != 0) {
        if (game) toggleGroupFavorite(gStoreSel);
        return;
    }
    if (getGamePackageState() == GamePackageState::Downloading) return;
    for (std::size_t i = 0; i < gInstalledGames.count; ++i) {
        if (std::strcmp(gInstalledGames.games[i].id, game->id) == 0 &&
            compareVersions(game->version, gInstalledGames.games[i].version) <= 0) {
            showToast(L("Jeu déjà installé"));
            return;
        }
    }
    if (!startGamePackageDownload(game)) showToast(L("Téléchargement indisponible"));
}

void uninstallSelectedGame() {
    if (!gInstalledGamesLoaded || gLibrarySel >= gInstalledGames.count) return;
    const InstalledGame installed = gInstalledGames.games[gLibrarySel];
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
        registerInstalledGame(&gInstalledGames, installed.id, installed.version, installed.sizeBytes);
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
    char path[224];
    std::snprintf(path, sizeof(path), "sdmc:/3ds/FlashGamesHub/games/%s/%s.3dsx", installed.id, installed.id);
    struct stat info{};
    if (stat(path, &info) != 0 || info.st_size <= 0) {
        showToast(L("Fichier de jeu introuvable"));
        return;
    }
    if (getGamePackageState() == GamePackageState::Downloading) return;
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
        gCatalog = gDownloadedCatalog;
        gCatalogLoaded = true;
        rebuildGenres();
        rebuildFilter();
        gDescriptionWrap.valid = false;
        if (gInstalledGamesLoaded && gLibrarySel >= gInstalledGames.count) gLibrarySel = 0;
    }
    if (takeDownloadedHubManifest(&gDownloadedHubManifest)) {
        gHubManifest = gDownloadedHubManifest;
        gHubManifestLoaded = true;
        gNotesWrap.valid = false;
    }
}

void refreshCatalog() {
    if (getCatalogUpdateState() == CatalogUpdateState::Downloading) return;
    stopCatalogDownload();
    startCatalogDownload();
}

// ---------------------------------------------------------------------------
// Composants graphiques
// ---------------------------------------------------------------------------

void drawSpinner(float x, float y) {
    const unsigned active = (gFrame / 8) % 3;
    for (unsigned i = 0; i < 3; ++i) {
        C2D_DrawCircleSolid(x + static_cast<float>(i) * 9.0f, y, kDepth, 2.6f, i == active ? kText : kFaint);
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
    if (game.developer[0] && game.genre[0]) std::snprintf(meta, sizeof(meta), "%s  ·  %s", game.developer, game.genre);
    else if (game.developer[0]) std::snprintf(meta, sizeof(meta), "%s", game.developer);
    else if (game.genre[0]) std::snprintf(meta, sizeof(meta), "%s", game.genre);
    else std::snprintf(meta, sizeof(meta), "%s", L("Aucune information"));
    fitText(meta, columnWidth, 0.36f, fitted, sizeof(fitted));
    drawText(fitted, columnX, 75, 0.36f, kAccent);

    if (game.description[0]) {
        drawWrapped(cachedWrap(gDescriptionWrap, game.description, columnWidth, 0.37f, 4), columnX, 97, 15.0f, 0.37f, kMuted);
    } else {
        drawText(L("Aucune description."), columnX, 97, 0.37f, kFaint);
    }

    drawDotLabel(columnX, 160, compatibilityColor(game.compatibility3ds), "3DS", 0.33f, kMuted);
    drawText(compatibilityText(game.compatibility3ds), columnX + 40, 160, 0.33f, kText);
    drawDotLabel(columnX, 176, compatibilityColor(game.compatibilityNew3ds), "New 3DS", 0.33f, kMuted);
    drawText(compatibilityText(game.compatibilityNew3ds), columnX + 66, 176, 0.33f, kText);

    char details[96];
    char size[24];
    details[0] = '\0';
    if (game.version[0]) std::snprintf(details, sizeof(details), "Version %s", game.version);
    if (game.sizeBytes > 0) {
        formatSize(game.sizeBytes, size, sizeof(size));
        const std::size_t used = std::strlen(details);
        std::snprintf(details + used, sizeof(details) - used, "%s%s", used ? "  ·  " : "", size);
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
                  first.genre[0] ? "  ·  " : "", first.genre);
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
    const CatalogGame* game = selectedStoreGame();
    if (!game) {
        drawTopMessage(L("Aucun résultat"), L("Aucun jeu ne correspond à la recherche ou aux filtres."));
        return;
    }
    if (gGroupCount[gStoreSel] > 1) drawGroupDetail(gStoreSel);
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
    std::snprintf(line, sizeof(line), "Total %s", totalText);
    drawRight(line, 364, 144, 0.34f, kMuted);

    formatSize(installedGamesBytes(), value, sizeof(value));
    std::snprintf(line, sizeof(line), L("Jeux installés  %s"), value);
    drawText(line, 36, 178, 0.38f, kText);
    formatSize(cachedDataBytes(), value, sizeof(value));
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

    static const Hint storeHints[] = {{"A", "Télécharger"}, {"X", "Chercher"}, {"Y", "Genre"}, {"SELECT", "Favoris"}};
    static const Hint storeFavoriteHints[] = {{"A", "Favori"}, {"X", "Chercher"}, {"Y", "Genre"}, {"SELECT", "Favoris"}};
    static const Hint libraryHints[] = {{"A", "Lancer"}, {"X", "Màj"}, {"Y", "Favori"}, {"B", "Désinstaller"}};
    static const Hint updatesHints[] = {{"A", "Actualiser"}, {"L R", "Onglets"}, {"START", "Quitter"}};
    static const Hint storageHints[] = {{"L R", "Onglets"}, {"START", "Quitter"}};
    static const Hint settingsHints[] = {{"A", "Langue"}, {"L R", "Onglets"}, {"START", "Quitter"}};

    switch (gCurrentPage) {
        case kPageStore:
            drawTopStore();
            drawTopFooter(selectedStoreGame() && selectedStoreGame()->downloadUrl[0] ? storeHints : storeFavoriteHints, 4);
            break;
        case kPageLibrary:
            drawTopLibrary();
            drawTopFooter(libraryHints, 2);
            break;
        case kPageUpdates:
            drawTopUpdates();
            drawTopFooter(updatesHints, 3);
            break;
        case kPageSettings:
            drawTopSettings();
            drawTopFooter(settingsHints, 3);
            break;
        default:
            drawTopStorage();
            drawTopFooter(storageHints, 2);
            break;
    }
}

// ---------------------------------------------------------------------------
// Ecran du bas
// ---------------------------------------------------------------------------

void drawTabBar() {
    drawRect(0, 0, kBottomWidth, kTabBarHeight, kSurface);
    drawRect(0, kTabBarHeight, kBottomWidth, 1, kBorder);
    const float scale = 0.36f;
    for (int i = 0; i < kPageCount; ++i) {
        const float x = static_cast<float>(i) * kTabWidth;
        drawCentered(L(kTabLabels[i]), x + kTabWidth / 2.0f, (kTabBarHeight - lineHeight(scale)) / 2.0f - 1.0f, scale,
                     i == gCurrentPage ? kText : kMuted);
    }
    drawRect(gTabIndicator + 14.0f, kTabBarHeight - 3.0f, kTabWidth - 28.0f, 3, kAccent);

    const unsigned pending = static_cast<unsigned>(countGameUpdates()) + (hubUpdateAvailable() ? 1u : 0u);
    if (pending > 0) {
        C2D_DrawCircleSolid(2.0f * kTabWidth + kTabWidth - 8.0f, 9.0f, kDepth, 3.2f, kAccent);
    }
}

void drawBottomFooter(const char* idleText) {
    drawRect(0, kFooterY, kBottomWidth, 1, kBorder);
    if (gToastFrames > 0) {
        drawText(gToast, 12, 219, 0.34f, kAccent);
    } else if (gDownloading || getGamePackageState() == GamePackageState::Downloading) {
        drawSpinner(16, 225);
        drawText(L(gDownloading ? "Synchronisation..." : "Téléchargement..."), 34, 219, 0.34f, kMuted);
    } else if (idleText) {
        drawText(idleText, 12, 219, 0.34f, kMuted);
    }
    char version[32];
    std::snprintf(version, sizeof(version), "v%s", kHubVersion);
    drawRight(version, 308, 220, 0.30f, kFaint);
}

void drawScrollbar(float top, float height, std::size_t count, std::size_t rows, std::size_t scroll) {
    if (count <= rows) return;
    drawRect(309, top, 3, height, kSurface2);
    float thumb = height * static_cast<float>(rows) / static_cast<float>(count);
    if (thumb < 14.0f) thumb = 14.0f;
    const float travel = height - thumb;
    const float offset = travel * static_cast<float>(scroll) / static_cast<float>(count - rows);
    drawRect(309, top + offset, 3, thumb, kMuted);
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

void drawBottomStore() {
    char label[96];
    std::snprintf(label, sizeof(label), L("Genre : %s"), gGenreFilterIndex == 0 ? L("Tous") : gGenres[gGenreFilterIndex - 1]);
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
        drawCard(10, y, 294, kStoreRowHeight - 3, rowColor);
        if (selected) drawRect(10, y + 4, 3, kStoreRowHeight - 11, kAccent);

        char fitted[96];
        const std::size_t members = gGroupCount[position];
        char title[96];
        if (members > 1) seriesKey(game, title, sizeof(title));
        else std::snprintf(title, sizeof(title), "%s", game.name);
        fitText(title, 172, 0.42f, fitted, sizeof(fitted));
        drawText(fitted, 20, y + 2, 0.42f, selected ? kText : kMuted);
        char sub[128];
        if (members > 1) std::snprintf(sub, sizeof(sub), "%s (%u)  ·  %s", L("Tous"), static_cast<unsigned>(members), game.genre);
        else std::snprintf(sub, sizeof(sub), "%s", game.genre);
        fitText(sub, 172, 0.30f, fitted, sizeof(fitted));
        drawText(fitted, 20, y + 13, 0.30f, kFaint);

        const bool mixed = members > 1 && gGroupMixed[position];
        const char* status = mixed ? L("Divers") : statusText(game.status);
        const float statusWidth = textWidth(status, 0.31f);
        drawRight(status, 266, y + 7, 0.31f, kMuted);
        C2D_DrawCircleSolid(266.0f - statusWidth - 8.0f, y + 12.5f, kDepth, 3.0f, mixed ? kInfo : statusColor(game.status));
        drawFavoriteMarker(287, y + 12, groupIsFavorite(position), rowColor);
    }
    drawScrollbar(kStoreListTop, static_cast<float>(kStoreRows) * kStoreRowHeight - 3.0f, gFilteredCount, kStoreRows, gStoreScroll);

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
        drawCard(10, y, 294, kLibraryRowHeight - 3, selected ? kSurface2 : kSurface);
        if (selected) drawRect(10, y + 4, 3, kLibraryRowHeight - 11, kAccent);

        char fitted[96];
        fitText(current && current->name[0] ? current->name : installed.id, 170, 0.42f, fitted, sizeof(fitted));
        drawText(fitted, 20, y + 2, 0.42f, selected ? kText : kMuted);

        char details[64];
        char size[24];
        if (installed.sizeBytes > 0) {
            formatSize(installed.sizeBytes, size, sizeof(size));
            std::snprintf(details, sizeof(details), "v%s  ·  %s", installed.version, size);
        } else {
            std::snprintf(details, sizeof(details), "v%s", installed.version);
        }
        fitText(details, 170, 0.30f, fitted, sizeof(fitted));
        drawText(fitted, 20, y + 13, 0.30f, kFaint);

        if (update) {
            drawPill(222, y + 5, 74, 15, kAccentDim);
            drawCentered(L("Mise à jour"), 259, y + 6.5f, 0.28f, kAccent);
        } else {
            drawRight(L("À jour"), 292, y + 7, 0.31f, kFaint);
        }
        if (isFavorite(installed.id)) drawFavoriteMarker(287, y + 12, true, selected ? kSurface2 : kSurface);
    }
    drawScrollbar(kLibraryListTop, static_cast<float>(kLibraryRows) * kLibraryRowHeight - 3.0f, gInstalledGames.count,
                  kLibraryRows, gLibraryScroll);

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
    fitText(line, 276, 0.32f, fitted, sizeof(fitted));
    drawText(fitted, 22, 84, 0.32f, kMuted);

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
    const GamePackageState packageState = getGamePackageState();
    const bool hasUpdate = firstGameUpdate(nullptr, nullptr);
    const char* updateButtonLabel = packageState == GamePackageState::Downloading ? L("Téléchargement...") :
                                    hasUpdate ? L("Télécharger la mise à jour") : L("Aucune mise à jour");
    drawButton(kGameUpdateButtonX, kRefreshButtonY, kGameUpdateButtonW, kRefreshButtonH,
               updateButtonLabel, hasUpdate && packageState != GamePackageState::Downloading);
    drawBottomFooter(nullptr);
}

void drawBottomStorage() {
    drawCardOutlined(10, 42, 300, 156, kSurface, kBorder);
    if (!gStorageAvailable) {
        drawCentered(L("Carte SD indisponible"), 160, 100, 0.5f, kText);
        drawCentered(L("Les mesures s'afficheront ici."), 160, 126, 0.34f, kMuted);
        drawBottomFooter(nullptr);
        return;
    }
    const u64 used = gStorageTotalBytes > gStorageFreeBytes ? gStorageTotalBytes - gStorageFreeBytes : 0;
    const char* labels[4] = {L("Espace libre"), L("Espace utilisé"), L("Capacité totale"), L("Jeux installés")};
    u64 values[4] = {gStorageFreeBytes, used, gStorageTotalBytes, installedGamesBytes()};
    for (int i = 0; i < 4; ++i) {
        const float y = 52.0f + static_cast<float>(i) * 36.0f;
        char value[32];
        formatSize(values[i], value, sizeof(value));
        drawText(labels[i], 24, y + 6, 0.38f, kMuted);
        drawRight(value, 296, y + 5, 0.44f, kText);
        if (i < 3) drawRect(24, y + 29, 272, 1, kBorder);
    }
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
    if (gCurrentPage == kPageStorage) readStorageStats();
}

void goToPage(int page) {
    if (page < 0 || page >= kPageCount) return;
    gCurrentPage = page;
    if (gCurrentPage == kPageStorage) readStorageStats();
}

void moveSelection(int direction) {
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
        }
    }
}

void handleLibraryTouch(const touchPosition& touch) {
    if (!gInstalledGamesLoaded || gInstalledGames.count == 0) return;
    if (inside(touch, 0, kLibraryListTop, kBottomWidth, static_cast<float>(kLibraryRows) * kLibraryRowHeight)) {
        const std::size_t row = static_cast<std::size_t>((touch.py - kLibraryListTop) / kLibraryRowHeight);
        const std::size_t index = gLibraryScroll + row;
        if (index < gInstalledGames.count) gLibrarySel = index;
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
        if (inside(touch, kRefreshButtonX, kRefreshButtonY, 144.0f, kRefreshButtonH)) {
            if (!gDownloading) refreshCatalog();
        } else if (inside(touch, kGameUpdateButtonX, kRefreshButtonY, kGameUpdateButtonW, kRefreshButtonH)) {
            requestFirstGameUpdate();
        }
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
    if (down & (KEY_L | KEY_LEFT)) changePage(-1);
    if (down & (KEY_R | KEY_RIGHT)) changePage(1);

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
        if (down & KEY_A) {
            const CatalogGame* game = selectedStoreGame();
            if (game && game->downloadUrl[0]) requestSelectedStoreDownload();
            else if (game) toggleGroupFavorite(gStoreSel);
            else if (!gCatalogLoaded && !gDownloading) refreshCatalog();
        }
        if (down & KEY_X) editStoreSearch();
        if (down & KEY_Y) cycleGenreFilter();
        if (down & KEY_B) resetFilters();
        if (down & KEY_SELECT) {
            gFavoritesOnly = !gFavoritesOnly;
            rebuildFilter();
        }
    } else if (gCurrentPage == kPageLibrary) {
        if (down & KEY_A) launchSelectedGame();
        if (down & KEY_X) requestSelectedGameUpdate();
        if (down & KEY_Y && gInstalledGamesLoaded && gLibrarySel < gInstalledGames.count) {
            toggleFavoriteId(gInstalledGames.games[gLibrarySel].id);
        }
        if (down & KEY_B && gInstalledGamesLoaded && gLibrarySel < gInstalledGames.count) {
            if (getGamePackageState() == GamePackageState::Downloading) showToast(L("Téléchargement..."));
            else gConfirmUninstall = true;
        }
    } else if (gCurrentPage == kPageUpdates) {
        if (down & KEY_A) {
            if (firstGameUpdate(nullptr, nullptr)) requestFirstGameUpdate();
            else if (!gDownloading) refreshCatalog();
        }
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
        if (packageResult.state == GamePackageState::Installed) {
            gInstalledGamesLoaded = loadInstalledGames();
            if (gInstalledGamesLoaded && gLibrarySel >= gInstalledGames.count) gLibrarySel = 0;
            showToast(L("Téléchargement terminé"));
        } else {
            showToast(L("Échec, version précédente conservée"));
        }
    }
    gDownloading = getCatalogUpdateState() == CatalogUpdateState::Downloading;
    const float target = static_cast<float>(gCurrentPage) * kTabWidth;
    gTabIndicator += (target - gTabIndicator) * 0.35f;
    if (gTabIndicator - target < 0.5f && target - gTabIndicator < 0.5f) gTabIndicator = target;
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
    gRomfsReady = R_SUCCEEDED(romfsInit());
    loadSettings();
    loadFavorites();
    gInstalledGamesLoaded = loadInstalledGames();
    if (loadCachedHubManifest(&gHubManifest)) {
        gHubManifestLoaded = true;
    } else {
        gHubManifestLoaded = gRomfsReady && loadEmbeddedHubManifest();
    }
    if (loadCachedCatalog(&gCachedCatalog)) {
        gCatalog = gCachedCatalog;
        gCatalogLoaded = true;
    } else if (gRomfsReady) {
        gCatalogLoaded = loadEmbeddedCatalog();
    }
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

    stopCatalogDownload();
    shutdownGraphics();
    if (gRomfsReady) romfsExit();
    return 0;
}
