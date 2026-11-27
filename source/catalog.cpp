#include "catalog.hpp"

#include <cstdint>
#include <cstdio>
#include <cstring>

namespace {

// Diagnostic : derniere cause d'echec du parseur, ecrite sur la SD par
// parseCatalogJson (sdmc:/3ds/FlashGamesHub/parse_error.txt).
char gParseError[192] = "";
char gCurrentKey[64] = "";
std::size_t gGameIndex = 0;

void noteParseError(const char* what, std::size_t a = 0, std::size_t b = 0) {
    if (gParseError[0]) return;  // garde la premiere cause (la plus proche de l'origine)
    std::snprintf(gParseError, sizeof(gParseError), "%s key=%s game#%u a=%u b=%u", what, gCurrentKey,
                  static_cast<unsigned>(gGameIndex), static_cast<unsigned>(a), static_cast<unsigned>(b));
}

class JsonReader {
public:
    JsonReader(const char* input, std::size_t length) : mInput(input), mLength(length) {
        // Ignore un eventuel BOM UTF-8 ajoute par certains editeurs sous Windows.
        if (length >= 3 && static_cast<unsigned char>(input[0]) == 0xEF &&
            static_cast<unsigned char>(input[1]) == 0xBB && static_cast<unsigned char>(input[2]) == 0xBF) {
            mPosition = 3;
        }
    }

    bool parseCatalog(GameCatalog* output) {
        if (!output || !consume('{')) return false;

        bool sawGames = false;
        bool sawSchemaVersion = false;
        bool sawCatalogVersion = false;
        skipWhitespace();
        if (consume('}')) return false;

        while (mPosition < mLength) {
            char key[64]{};
            if (!parseString(key, sizeof(key)) || !consume(':')) return false;

            if (std::strcmp(key, "schema_version") == 0) {
                u32 version = 0;
                if (!parseUnsigned(version) || version != 1) return false;
                sawSchemaVersion = true;
            } else if (std::strcmp(key, "catalog_version") == 0) {
                if (!parseUnsigned(output->catalogVersion)) return false;
                sawCatalogVersion = true;
            } else if (std::strcmp(key, "games") == 0) {
                if (sawGames || !parseGames(output)) return false;
                sawGames = true;
            } else if (!skipValue(0)) {
                return false;
            }

            skipWhitespace();
            if (consume('}')) break;
            if (!consume(',')) return false;
        }

        skipWhitespace();
        return sawSchemaVersion && sawCatalogVersion && sawGames && mPosition == mLength && validateGames(*output);
    }

    bool parseHubManifest(HubManifest* output) {
        if (!output || !consume('{')) return false;
        bool sawSchemaVersion = false;
        bool sawPublished = false;
        bool sawReleaseNotes = false;
        skipWhitespace();
        if (consume('}')) return false;
        while (mPosition < mLength) {
            char key[64]{};
            if (!parseString(key, sizeof(key)) || !consume(':')) return false;
            if (std::strcmp(key, "schema_version") == 0) {
                u32 version = 0;
                if (!parseUnsigned(version) || version != 1) return false;
                sawSchemaVersion = true;
            } else if (std::strcmp(key, "published") == 0) {
                if (!parseBoolean(output->published)) return false;
                sawPublished = true;
            } else if (std::strcmp(key, "latest_version") == 0) {
                if (!parseStringOrNull(output->latestVersion, sizeof(output->latestVersion))) return false;
            } else if (std::strcmp(key, "minimum_supported_version") == 0) {
                if (!parseStringOrNull(output->minimumSupportedVersion, sizeof(output->minimumSupportedVersion))) return false;
            } else if (std::strcmp(key, "cia_url") == 0) {
                if (!parseStringOrNull(output->ciaUrl, sizeof(output->ciaUrl))) return false;
            } else if (std::strcmp(key, "sha256") == 0) {
                if (!parseStringOrNull(output->sha256, sizeof(output->sha256))) return false;
            } else if (std::strcmp(key, "release_notes") == 0) {
                if (!parseStringOrNull(output->releaseNotes, sizeof(output->releaseNotes), true)) return false;
                sawReleaseNotes = true;
            } else if (!skipValue(0)) return false;
            skipWhitespace();
            if (consume('}')) break;
            if (!consume(',')) return false;
        }
        skipWhitespace();
        if (!sawSchemaVersion || !sawPublished || !sawReleaseNotes || mPosition != mLength) return false;
        if (!output->published) return true;
        if (!isValidVersion(output->latestVersion) || !isValidVersion(output->minimumSupportedVersion) ||
            std::strncmp(output->ciaUrl, "https://", 8) != 0 || std::strlen(output->sha256) != 64) return false;
        for (const char* hash = output->sha256; *hash; ++hash) {
            if (!((*hash >= '0' && *hash <= '9') || (*hash >= 'a' && *hash <= 'f') || (*hash >= 'A' && *hash <= 'F'))) return false;
        }
        return true;
    }

    bool parseInstalledGames(InstalledGameList* output) {
        if (!output || !consume('{')) return false;
        bool sawSchemaVersion = false;
        bool sawGames = false;
        skipWhitespace();
        if (consume('}')) return false;
        while (mPosition < mLength) {
            char key[64]{};
            if (!parseString(key, sizeof(key)) || !consume(':')) return false;
            if (std::strcmp(key, "schema_version") == 0) {
                u32 version = 0;
                if (!parseUnsigned(version) || (version != 1 && version != 2)) return false;
                sawSchemaVersion = true;
            } else if (std::strcmp(key, "games") == 0) {
                if (sawGames || !parseInstalledList(output)) return false;
                sawGames = true;
            } else if (!skipValue(0)) return false;
            skipWhitespace();
            if (consume('}')) break;
            if (!consume(',')) return false;
        }
        skipWhitespace();
        if (!sawSchemaVersion || !sawGames || mPosition != mLength) return false;
        for (std::size_t i = 0; i < output->count; ++i) {
            for (std::size_t j = i + 1; j < output->count; ++j) {
                if (std::strcmp(output->games[i].id, output->games[j].id) == 0) return false;
            }
        }
        return true;
    }

    std::size_t position() const { return mPosition; }

private:
    const char* mInput;
    std::size_t mLength;
    std::size_t mPosition = 0;

    void skipWhitespace() {
        while (mPosition < mLength) {
            const char c = mInput[mPosition];
            if (c != ' ' && c != '\n' && c != '\r' && c != '\t') break;
            ++mPosition;
        }
    }

    bool consume(char expected) {
        skipWhitespace();
        if (mPosition >= mLength || mInput[mPosition] != expected) return false;
        ++mPosition;
        return true;
    }

    bool appendUtf8(char* output, std::size_t capacity, std::size_t& used, std::uint32_t codepoint) {
        char bytes[4];
        std::size_t count = 0;
        if (codepoint <= 0x7F) {
            bytes[count++] = static_cast<char>(codepoint);
        } else if (codepoint <= 0x7FF) {
            bytes[count++] = static_cast<char>(0xC0 | (codepoint >> 6));
            bytes[count++] = static_cast<char>(0x80 | (codepoint & 0x3F));
        } else if (codepoint <= 0xFFFF) {
            bytes[count++] = static_cast<char>(0xE0 | (codepoint >> 12));
            bytes[count++] = static_cast<char>(0x80 | ((codepoint >> 6) & 0x3F));
            bytes[count++] = static_cast<char>(0x80 | (codepoint & 0x3F));
        } else if (codepoint <= 0x10FFFF) {
            bytes[count++] = static_cast<char>(0xF0 | (codepoint >> 18));
            bytes[count++] = static_cast<char>(0x80 | ((codepoint >> 12) & 0x3F));
            bytes[count++] = static_cast<char>(0x80 | ((codepoint >> 6) & 0x3F));
            bytes[count++] = static_cast<char>(0x80 | (codepoint & 0x3F));
        } else {
            return false;
        }
        if (used + count >= capacity) return false;
        std::memcpy(output + used, bytes, count);
        used += count;
        return true;
    }

    bool parseHex4(std::uint32_t& value) {
        if (mPosition + 4 > mLength) return false;
        value = 0;
        for (int i = 0; i < 4; ++i) {
            const char c = mInput[mPosition++];
            value <<= 4;
            if (c >= '0' && c <= '9') value |= static_cast<std::uint32_t>(c - '0');
            else if (c >= 'a' && c <= 'f') value |= static_cast<std::uint32_t>(c - 'a' + 10);
            else if (c >= 'A' && c <= 'F') value |= static_cast<std::uint32_t>(c - 'A' + 10);
            else return false;
        }
        return true;
    }

    // Lit une chaine JSON. Avec truncate = true, une chaine trop longue est
    // coupee proprement (a une frontiere de caractere UTF-8) au lieu de faire
    // echouer tout le fichier. Utile pour les textes d'affichage (nom, description...).
    bool parseString(char* output, std::size_t capacity, bool truncate = false) {
        if (!output || capacity == 0 || !consume('"')) return false;
        std::size_t used = 0;
        std::size_t boundary = 0;
        bool overflow = false;

        // Ajoute un caractere deja encode (escape) en respectant la capacite.
        auto put = [&](const char* bytes, std::size_t count) -> bool {
            if (overflow) return true;
            boundary = used;
            if (used + count >= capacity) {
                if (!truncate) {
                    noteParseError("string overflow (escape)", capacity);
                    return false;
                }
                overflow = true;
                return true;
            }
            std::memcpy(output + used, bytes, count);
            used += count;
            return true;
        };

        while (mPosition < mLength) {
            const unsigned char c = static_cast<unsigned char>(mInput[mPosition++]);
            if (c == '"') {
                output[overflow ? boundary : used] = '\0';
                return true;
            }
            if (c < 0x20) return false;
            if (c != '\\') {
                if (overflow) continue;
                if ((c & 0xC0) != 0x80) boundary = used;
                if (used + 1 >= capacity) {
                    if (!truncate) {
                        noteParseError("string overflow", capacity);
                        return false;
                    }
                    overflow = true;
                    continue;
                }
                output[used++] = static_cast<char>(c);
                continue;
            }
            if (mPosition >= mLength) return false;
            const char escaped = mInput[mPosition++];
            switch (escaped) {
                case '"': case '\\': case '/':
                    if (!put(&escaped, 1)) return false;
                    break;
                case 'b': case 'f': case 'n': case 'r': case 't': {
                    const char value = escaped == 'n' ? '\n' : escaped == 'r' ? '\r' : escaped == 't' ? '\t' : escaped == 'b' ? '\b' : '\f';
                    if (!put(&value, 1)) return false;
                    break;
                }
                case 'u': {
                    std::uint32_t codepoint = 0;
                    if (!parseHex4(codepoint)) return false;
                    if (codepoint >= 0xDC00 && codepoint <= 0xDFFF) return false;
                    if (codepoint >= 0xD800 && codepoint <= 0xDBFF) {
                        if (mPosition + 2 > mLength || mInput[mPosition] != '\\' || mInput[mPosition + 1] != 'u') return false;
                        mPosition += 2;
                        std::uint32_t low = 0;
                        if (!parseHex4(low) || low < 0xDC00 || low > 0xDFFF) return false;
                        codepoint = 0x10000 + ((codepoint - 0xD800) << 10) + (low - 0xDC00);
                    }
                    char encoded[8];
                    std::size_t encodedLength = 0;
                    if (!appendUtf8(encoded, sizeof(encoded), encodedLength, codepoint)) return false;
                    if (!put(encoded, encodedLength)) return false;
                    break;
                }
                default: return false;
            }
        }
        return false;
    }

    bool parseUnsigned(u32& output) {
        skipWhitespace();
        if (mPosition >= mLength || mInput[mPosition] < '0' || mInput[mPosition] > '9') return false;
        if (mInput[mPosition] == '0' && mPosition + 1 < mLength && mInput[mPosition + 1] >= '0' && mInput[mPosition + 1] <= '9') return false;
        std::uint64_t value = 0;
        while (mPosition < mLength && mInput[mPosition] >= '0' && mInput[mPosition] <= '9') {
            value = value * 10 + static_cast<unsigned>(mInput[mPosition++] - '0');
            if (value > 0xFFFFFFFFu) return false;
        }
        if (!isTokenBoundary()) return false;
        output = static_cast<u32>(value);
        return true;
    }

    bool parseUnsigned64(u64& output) {
        skipWhitespace();
        if (mPosition >= mLength || mInput[mPosition] < '0' || mInput[mPosition] > '9') return false;
        if (mInput[mPosition] == '0' && mPosition + 1 < mLength && mInput[mPosition + 1] >= '0' && mInput[mPosition + 1] <= '9') return false;
        u64 value = 0;
        while (mPosition < mLength && mInput[mPosition] >= '0' && mInput[mPosition] <= '9') {
            const u64 digit = static_cast<u64>(mInput[mPosition++] - '0');
            if (value > (UINT64_MAX - digit) / 10) return false;
            value = value * 10 + digit;
        }
        if (!isTokenBoundary()) return false;
        output = value;
        return true;
    }

    bool isTokenBoundary() const {
        if (mPosition >= mLength) return true;
        const char c = mInput[mPosition];
        return c == ',' || c == '}' || c == ']' || c == ' ' || c == '\n' || c == '\r' || c == '\t';
    }

    bool skipNumber() {
        skipWhitespace();
        const std::size_t start = mPosition;
        if (mPosition < mLength && mInput[mPosition] == '-') ++mPosition;
        if (mPosition >= mLength) return false;
        if (mInput[mPosition] == '0') {
            ++mPosition;
            if (mPosition < mLength && mInput[mPosition] >= '0' && mInput[mPosition] <= '9') return false;
        } else if (mInput[mPosition] >= '1' && mInput[mPosition] <= '9') {
            while (mPosition < mLength && mInput[mPosition] >= '0' && mInput[mPosition] <= '9') ++mPosition;
        } else {
            return false;
        }
        if (mPosition < mLength && mInput[mPosition] == '.') {
            ++mPosition;
            const std::size_t fractionStart = mPosition;
            while (mPosition < mLength && mInput[mPosition] >= '0' && mInput[mPosition] <= '9') ++mPosition;
            if (mPosition == fractionStart) return false;
        }
        if (mPosition < mLength && (mInput[mPosition] == 'e' || mInput[mPosition] == 'E')) {
            ++mPosition;
            if (mPosition < mLength && (mInput[mPosition] == '+' || mInput[mPosition] == '-')) ++mPosition;
            const std::size_t exponentStart = mPosition;
            while (mPosition < mLength && mInput[mPosition] >= '0' && mInput[mPosition] <= '9') ++mPosition;
            if (mPosition == exponentStart) return false;
        }
        return mPosition > start && isTokenBoundary();
    }

    bool consumeLiteral(const char* literal, std::size_t literalLength) {
        skipWhitespace();
        if (mPosition + literalLength > mLength || std::memcmp(mInput + mPosition, literal, literalLength) != 0) return false;
        mPosition += literalLength;
        return isTokenBoundary();
    }

    bool parseBoolean(bool& output) {
        if (consumeLiteral("true", 4)) {
            output = true;
            return true;
        }
        if (consumeLiteral("false", 5)) {
            output = false;
            return true;
        }
        return false;
    }

    static bool isValidVersion(const char* version) {
        if (!version || !*version) return false;
        const char* cursor = version;
        for (int part = 0; part < 3; ++part) {
            if (*cursor < '0' || *cursor > '9') return false;
            if (*cursor == '0' && cursor[1] >= '0' && cursor[1] <= '9') return false;
            u32 value = 0;
            while (*cursor >= '0' && *cursor <= '9') {
                if (value > (0x7FFFFFFFu - static_cast<u32>(*cursor - '0')) / 10u) return false;
                value = value * 10 + static_cast<u32>(*cursor++ - '0');
            }
            if (part < 2) {
                if (*cursor != '.') return false;
                ++cursor;
            }
        }
        if (*cursor == '\0') return true;
        if (*cursor != '-' && *cursor != '+') return false;
        ++cursor;
        if (!*cursor) return false;
        for (; *cursor; ++cursor) {
            const char c = *cursor;
            if (!((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
                  (c >= '0' && c <= '9') || c == '.' || c == '-')) return false;
        }
        return true;
    }

    bool parseStringOrNull(char* output, std::size_t capacity, bool truncate = false) {
        skipWhitespace();
        if (mPosition < mLength && mInput[mPosition] == '"') return parseString(output, capacity, truncate);
        if (mPosition + 4 <= mLength && std::memcmp(mInput + mPosition, "null", 4) == 0) {
            mPosition += 4;
            output[0] = '\0';
            return true;
        }
        return false;
    }

    bool parseUnsignedOrNull(u32& output) {
        skipWhitespace();
        if (mPosition + 4 <= mLength && std::memcmp(mInput + mPosition, "null", 4) == 0) {
            mPosition += 4;
            output = 0;
            return isTokenBoundary();
        }
        return parseUnsigned(output);
    }

    bool parseCompatibility(CatalogGame& game) {
        if (!consume('{')) return false;
        bool saw3ds = false;
        bool sawNew3ds = false;
        skipWhitespace();
        if (consume('}')) return false;
        while (mPosition < mLength) {
            char key[24]{};
            char value[16]{};
            if (!parseString(key, sizeof(key)) || !consume(':') || !parseString(value, sizeof(value))) return false;
            if (std::strcmp(value, "supported") != 0 && std::strcmp(value, "unsupported") != 0 &&
                std::strcmp(value, "unverified") != 0) return false;
            if (std::strcmp(key, "3ds") == 0) {
                std::memcpy(game.compatibility3ds, value, std::strlen(value) + 1);
                saw3ds = true;
            } else if (std::strcmp(key, "new_3ds") == 0) {
                std::memcpy(game.compatibilityNew3ds, value, std::strlen(value) + 1);
                sawNew3ds = true;
            }
            skipWhitespace();
            if (consume('}')) return saw3ds && sawNew3ds;
            if (!consume(',')) return false;
        }
        return false;
    }

    bool parseSeries(CatalogGame& game) {
        if (!consume('{')) return false;
        skipWhitespace();
        if (consume('}')) return true;
        while (mPosition < mLength) {
            char key[32]{};
            if (!parseString(key, sizeof(key)) || !consume(':')) return false;
            if (std::strcmp(key, "id") == 0) {
                if (!parseStringOrNull(game.seriesId, sizeof(game.seriesId))) return false;
            } else if (std::strcmp(key, "name") == 0) {
                if (!parseStringOrNull(game.seriesName, sizeof(game.seriesName), true)) return false;
            } else if (std::strcmp(key, "episode") == 0) {
                u32 episode = 0;
                if (!parseUnsigned(episode) || episode > 0xFFFF) return false;
                game.episode = static_cast<u16>(episode);
            } else if (!skipValue(0)) return false;
            skipWhitespace();
            if (consume('}')) return true;
            if (!consume(',')) return false;
        }
        return false;
    }

    bool parseScreenshots(CatalogGame& game) {
        if (!consume('[')) return false;
        skipWhitespace();
        if (consume(']')) return true;
        while (mPosition < mLength) {
            skipWhitespace();  // apres une virgule, il peut rester espaces / retours a la ligne
            if (mPosition >= mLength) return false;
            if (mInput[mPosition] == '"') {
                if (game.screenshotCount < 3) {
                    if (!parseString(game.screenshots[game.screenshotCount], sizeof(game.screenshots[0]))) return false;
                    if (game.screenshots[game.screenshotCount][0]) ++game.screenshotCount;
                } else {
                    char ignored[256]{};
                    if (!parseString(ignored, sizeof(ignored))) return false;
                }
            } else if (mPosition + 4 <= mLength && std::memcmp(mInput + mPosition, "null", 4) == 0) {
                char ignored[4]{};
                if (!parseStringOrNull(ignored, sizeof(ignored))) return false;
            } else {
                return false;
            }
            skipWhitespace();
            if (consume(']')) return true;
            if (!consume(',')) return false;
        }
        return false;
    }

    bool parseGame(CatalogGame& game) {
        if (!consume('{')) return false;
        bool sawStatus = false;
        bool sawCompatibility = false;
        skipWhitespace();
        if (consume('}')) return false;
        while (mPosition < mLength) {
            char key[64]{};
            if (!parseString(key, sizeof(key)) || !consume(':')) return false;
            std::snprintf(gCurrentKey, sizeof(gCurrentKey), "%s", key);
            if (std::strcmp(key, "id") == 0) {
                if (!parseStringOrNull(game.id, sizeof(game.id))) return false;
            } else if (std::strcmp(key, "name") == 0) {
                if (!parseStringOrNull(game.name, sizeof(game.name), true)) return false;
            } else if (std::strcmp(key, "description") == 0) {
                if (!parseStringOrNull(game.description, sizeof(game.description), true)) return false;
            } else if (std::strcmp(key, "genre") == 0) {
                if (!parseStringOrNull(game.genre, sizeof(game.genre), true)) return false;
            } else if (std::strcmp(key, "developer") == 0) {
                if (!parseStringOrNull(game.developer, sizeof(game.developer), true)) return false;
            } else if (std::strcmp(key, "cover") == 0) {
                if (!parseStringOrNull(game.cover, sizeof(game.cover))) return false;
            } else if (std::strcmp(key, "screenshots") == 0) {
                if (!parseScreenshots(game)) return false;
            } else if (std::strcmp(key, "version") == 0) {
                if (!parseStringOrNull(game.version, sizeof(game.version))) return false;
            } else if (std::strcmp(key, "file_type") == 0) {
                if (!parseStringOrNull(game.downloadFormat, sizeof(game.downloadFormat))) return false;
            } else if (std::strcmp(key, "download_url") == 0) {
                if (!parseStringOrNull(game.downloadUrl, sizeof(game.downloadUrl))) return false;
            } else if (std::strcmp(key, "sha256") == 0) {
                if (!parseStringOrNull(game.sha256, sizeof(game.sha256))) return false;
            } else if (std::strcmp(key, "cia_url") == 0) {
                if (!parseStringOrNull(game.ciaUrl, sizeof(game.ciaUrl))) return false;
            } else if (std::strcmp(key, "cia_sha256") == 0) {
                if (!parseStringOrNull(game.ciaSha256, sizeof(game.ciaSha256))) return false;
            } else if (std::strcmp(key, "cia_size_bytes") == 0) {
                if (!parseUnsignedOrNull(game.ciaSizeBytes)) return false;
            } else if (std::strcmp(key, "compatibility") == 0) {
                if (!parseCompatibility(game)) return false;
                sawCompatibility = true;
            } else if (std::strcmp(key, "series") == 0) {
                if (!parseSeries(game)) return false;
            } else if (std::strcmp(key, "size_bytes") == 0) {
                if (!parseUnsignedOrNull(game.sizeBytes)) return false;
            } else if (std::strcmp(key, "status") == 0) {
                char status[24]{};
                if (!parseString(status, sizeof(status))) return false;
                if (std::strcmp(status, "available") == 0) game.status = GameStatus::Available;
                else if (std::strcmp(status, "unavailable") == 0) game.status = GameStatus::Unavailable;
                else if (std::strcmp(status, "coming_soon") == 0) game.status = GameStatus::ComingSoon;
                else if (std::strcmp(status, "development") == 0) game.status = GameStatus::Development;
                else if (std::strcmp(status, "discontinued") == 0) game.status = GameStatus::Discontinued;
                else return false;
                sawStatus = true;
            } else if (!skipValue(0)) return false;

            skipWhitespace();
            if (consume('}')) {
                if (!game.id[0] || !game.name[0] || !sawStatus || !sawCompatibility) return false;
                for (const char* c = game.id; *c; ++c) {
                    if (!((*c >= 'a' && *c <= 'z') || (*c >= '0' && *c <= '9') || *c == '-')) return false;
                }
                if (game.status == GameStatus::Available) {
                    if (!game.version[0] || (std::strcmp(game.downloadFormat, "3dsx") != 0 &&
                        std::strcmp(game.downloadFormat, "cia") != 0) || !game.downloadUrl[0] ||
                        std::strncmp(game.downloadUrl, "https://", 8) != 0 ||
                        game.sizeBytes == 0 || std::strlen(game.sha256) != 64) return false;
                    bool hasSupportedModel = std::strcmp(game.compatibility3ds, "supported") == 0 ||
                                             std::strcmp(game.compatibilityNew3ds, "supported") == 0;
                    if (!hasSupportedModel) return false;
                    for (const char* hash = game.sha256; *hash; ++hash) {
                        if (!((*hash >= '0' && *hash <= '9') || (*hash >= 'a' && *hash <= 'f') || (*hash >= 'A' && *hash <= 'F'))) return false;
                    }
                }
                const bool anyCiaField = game.ciaUrl[0] || game.ciaSha256[0] || game.ciaSizeBytes;
                if (anyCiaField) {
                    if (!game.ciaUrl[0] || std::strncmp(game.ciaUrl, "https://", 8) != 0 ||
                        game.ciaSizeBytes == 0 || std::strlen(game.ciaSha256) != 64) return false;
                    for (const char* hash = game.ciaSha256; *hash; ++hash) {
                        if (!((*hash >= '0' && *hash <= '9') || (*hash >= 'a' && *hash <= 'f') || (*hash >= 'A' && *hash <= 'F'))) return false;
                    }
                }
                return true;
            }
            if (!consume(',')) return false;
        }
        return false;
    }

    bool parseGames(GameCatalog* catalog) {
        if (!consume('[')) return false;
        skipWhitespace();
        if (consume(']')) return true;
        while (mPosition < mLength) {
            gGameIndex = catalog->count;
            CatalogGame game{};
            game.status = GameStatus::Unavailable;
            if (!parseGame(game)) return false;
            if (catalog->count >= GameCatalog::kMaxGames) {
                // Catalogue plus grand que kMaxGames : on garde les premiers jeux
                // au lieu de rejeter tout le fichier.
                noteParseError("catalogue tronque: kMaxGames atteint", GameCatalog::kMaxGames);
            } else {
                catalog->games[catalog->count++] = game;
            }
            skipWhitespace();
            if (consume(']')) return true;
            if (!consume(',')) return false;
        }
        return false;
    }

    bool parseInstalledGame(InstalledGame& game) {
        if (!consume('{')) return false;
        bool sawId = false;
        bool sawVersion = false;
        bool sawSize = false;
        while (mPosition < mLength) {
            char key[64]{};
            if (!parseString(key, sizeof(key)) || !consume(':')) return false;
            if (std::strcmp(key, "id") == 0) {
                if (!parseString(game.id, sizeof(game.id))) return false;
                sawId = true;
            } else if (std::strcmp(key, "version") == 0) {
                if (!parseString(game.version, sizeof(game.version))) return false;
                sawVersion = true;
            } else if (std::strcmp(key, "size_bytes") == 0) {
                if (!parseUnsigned(game.sizeBytes)) return false;
                sawSize = true;
            } else if (std::strcmp(key, "file_type") == 0) {
                if (!parseString(game.format, sizeof(game.format))) return false;
            } else if (std::strcmp(key, "title_id") == 0) {
                if (!parseUnsigned64(game.titleId)) return false;
            } else if (!skipValue(0)) return false;
            skipWhitespace();
            if (consume('}')) {
                if (!sawId || !sawVersion || !sawSize || !game.id[0] || !game.version[0]) return false;
                if (!game.format[0]) std::snprintf(game.format, sizeof(game.format), "3dsx");
                if (std::strcmp(game.format, "3dsx") != 0 && std::strcmp(game.format, "cia") != 0) return false;
                for (const char* c = game.id; *c; ++c) {
                    if (!((*c >= 'a' && *c <= 'z') || (*c >= '0' && *c <= '9') || *c == '-')) return false;
                }
                return true;
            }
            if (!consume(',')) return false;
        }
        return false;
    }

    bool parseInstalledList(InstalledGameList* list) {
        if (!consume('[')) return false;
        skipWhitespace();
        if (consume(']')) return true;
        while (mPosition < mLength) {
            if (list->count >= InstalledGameList::kMaxGames) return false;
            InstalledGame game{};
            if (!parseInstalledGame(game)) return false;
            list->games[list->count++] = game;
            skipWhitespace();
            if (consume(']')) return true;
            if (!consume(',')) return false;
        }
        return false;
    }

    bool skipValue(unsigned depth) {
        if (depth > 16) return false;
        skipWhitespace();
        if (mPosition >= mLength) return false;
        if (mInput[mPosition] == '"') {
            char ignored[512]{};
            return parseString(ignored, sizeof(ignored));
        }
        if (mInput[mPosition] == '{' || mInput[mPosition] == '[') {
            const char closing = mInput[mPosition++] == '{' ? '}' : ']';
            skipWhitespace();
            if (consume(closing)) return true;
            while (mPosition < mLength) {
                if (closing == '}') {
                    char key[128]{};
                    if (!parseString(key, sizeof(key)) || !consume(':')) return false;
                }
                if (!skipValue(depth + 1)) return false;
                skipWhitespace();
                if (consume(closing)) return true;
                if (!consume(',')) return false;
            }
            return false;
        }
        if (mInput[mPosition] == 't') return consumeLiteral("true", 4);
        if (mInput[mPosition] == 'f') return consumeLiteral("false", 5);
        if (mInput[mPosition] == 'n') return consumeLiteral("null", 4);
        return skipNumber();
    }

    bool validateGames(const GameCatalog& catalog) const {
        for (std::size_t i = 0; i < catalog.count; ++i) {
            for (std::size_t j = i + 1; j < catalog.count; ++j) {
                if (std::strcmp(catalog.games[i].id, catalog.games[j].id) == 0) return false;
            }
        }
        return true;
    }
};

} // namespace

bool parseCatalogJson(const char* json, std::size_t length, GameCatalog* output) {
    if (!json || !output || length == 0) return false;
    *output = GameCatalog{};
    gParseError[0] = '\0';
    gCurrentKey[0] = '\0';
    gGameIndex = 0;
    JsonReader reader(json, length);
    const bool ok = reader.parseCatalog(output);
    if (gParseError[0] || !ok) {
        if (!gParseError[0]) noteParseError("syntaxe/regle de validation", reader.position(), length);
        if (FILE* log = std::fopen("sdmc:/3ds/FlashGamesHub/parse_error.txt", "wb")) {
            std::fprintf(log, "%s ok=%d pos=%u len=%u\n", gParseError, ok ? 1 : 0,
                         static_cast<unsigned>(reader.position()), static_cast<unsigned>(length));
            std::fclose(log);
        }
    }
    if (ok) return true;
    *output = GameCatalog{};  // ne jamais laisser un catalogue a moitie rempli
    return false;
}

bool parseHubManifestJson(const char* json, std::size_t length, HubManifest* output) {
    if (!json || !output || length == 0) return false;
    *output = HubManifest{};
    if (JsonReader(json, length).parseHubManifest(output)) return true;
    *output = HubManifest{};
    return false;
}

bool parseInstalledGamesJson(const char* json, std::size_t length, InstalledGameList* output) {
    if (!json || !output || length == 0) return false;
    *output = InstalledGameList{};
    if (JsonReader(json, length).parseInstalledGames(output)) return true;
    *output = InstalledGameList{};
    return false;
}

int compareVersions(const char* left, const char* right) {
    if (!left || !right) return 0;
    const char* cursors[2] = {left, right};
    u32 parts[2][3] = {};
    const char* suffixes[2] = {nullptr, nullptr};
    for (int side = 0; side < 2; ++side) {
        for (int part = 0; part < 3; ++part) {
            if (*cursors[side] < '0' || *cursors[side] > '9') return 0;
            while (*cursors[side] >= '0' && *cursors[side] <= '9') {
                if (parts[side][part] > (0xFFFFFFFFu - static_cast<u32>(*cursors[side] - '0')) / 10u) return 0;
                parts[side][part] = parts[side][part] * 10 + static_cast<u32>(*cursors[side]++ - '0');
            }
            if (part < 2 && *cursors[side]++ != '.') return 0;
        }
        const char* suffix = cursors[side];
        const char* prerelease = std::strchr(suffix, '-');
        const char* build = std::strchr(suffix, '+');
        suffixes[side] = prerelease && (!build || prerelease < build) ? prerelease : nullptr;
        if (!suffixes[side] && *suffix && *suffix != '+') return 0;
    }
    for (int part = 0; part < 3; ++part) {
        if (parts[0][part] < parts[1][part]) return -1;
        if (parts[0][part] > parts[1][part]) return 1;
    }
    const bool leftStable = !suffixes[0] || *suffixes[0] == '\0';
    const bool rightStable = !suffixes[1] || *suffixes[1] == '\0';
    if (leftStable != rightStable) return leftStable ? 1 : -1;
    if (leftStable) return 0;
    const char* leftPrerelease = suffixes[0] + 1;
    const char* rightPrerelease = suffixes[1] + 1;
    const std::size_t leftLength = std::strcspn(leftPrerelease, "+");
    const std::size_t rightLength = std::strcspn(rightPrerelease, "+");
    const std::size_t commonLength = leftLength < rightLength ? leftLength : rightLength;
    const int prefixOrder = std::strncmp(leftPrerelease, rightPrerelease, commonLength);
    if (prefixOrder != 0) return prefixOrder < 0 ? -1 : 1;
    if (leftLength < rightLength) return -1;
    if (leftLength > rightLength) return 1;
    return 0;
}

const char* gameStatusLabel(GameStatus status) {
    switch (status) {
        case GameStatus::Available: return "DISPONIBLE";
        case GameStatus::Unavailable: return "INDISPONIBLE";
        case GameStatus::ComingSoon: return "BIENTOT";
        case GameStatus::Development: return "EN DEV";
        case GameStatus::Discontinued: return "ARRETE";
    }
    return "INCONNU";
}
