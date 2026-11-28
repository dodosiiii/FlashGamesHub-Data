// progress_save.cpp — Papa's Cheeseria 3DS
// Sérialisation/désérialisation de la progression (format versionné avec checksum)

#include "progress_save.hpp"

#include <cstdint>
#include <cstring>
#include <numeric>

namespace cheeseria {

// Format : [magic 4B][version 1B][pad 3B][orders 4B][score 4B][checksum 4B]
// Total : 20 octets = kProgressSaveSize

static constexpr std::uint8_t kMagic[4]   = {'C', 'H', 'Z', '1'};
static constexpr std::uint8_t kVersion     = 0x01;
static constexpr std::uint32_t kMaxOrders  = 9999;
static constexpr std::uint32_t kMaxScore   = kMaxOrders * 100;

// Checksum XOR simple sur les 16 premiers octets
static std::uint32_t computeChecksum(const std::uint8_t* data, std::size_t len) {
    std::uint32_t acc = 0x12345678U;
    for (std::size_t i = 0; i < len; ++i) {
        acc = (acc << 7U) | (acc >> 25U);
        acc ^= static_cast<std::uint32_t>(data[i]);
    }
    return acc;
}

bool encodeProgress(const SavedProgress& progress,
                    std::array<std::uint8_t, kProgressSaveSize>& output) {
    // Validation
    if (progress.ordersCompleted > kMaxOrders) return false;
    if (progress.totalScore > kMaxScore) return false;
    if (progress.ordersCompleted > 0 && progress.totalScore > progress.ordersCompleted * 100) return false;

    output = {};
    // Magic + version
    std::memcpy(output.data(), kMagic, 4);
    output[4] = kVersion;
    // octets 5-7 : padding = 0
    // orders (little-endian)
    output[8]  = static_cast<std::uint8_t>(progress.ordersCompleted);
    output[9]  = static_cast<std::uint8_t>(progress.ordersCompleted >> 8);
    output[10] = static_cast<std::uint8_t>(progress.ordersCompleted >> 16);
    output[11] = static_cast<std::uint8_t>(progress.ordersCompleted >> 24);
    // score (little-endian)
    output[12] = static_cast<std::uint8_t>(progress.totalScore);
    output[13] = static_cast<std::uint8_t>(progress.totalScore >> 8);
    output[14] = static_cast<std::uint8_t>(progress.totalScore >> 16);
    output[15] = static_cast<std::uint8_t>(progress.totalScore >> 24);
    // checksum
    std::uint32_t chk = computeChecksum(output.data(), 16);
    output[16] = static_cast<std::uint8_t>(chk);
    output[17] = static_cast<std::uint8_t>(chk >> 8);
    output[18] = static_cast<std::uint8_t>(chk >> 16);
    output[19] = static_cast<std::uint8_t>(chk >> 24);
    return true;
}

bool decodeProgress(const std::uint8_t* data, std::size_t size,
                    SavedProgress& progress) {
    if (!data || size < kProgressSaveSize) return false;

    // Vérification magic
    if (std::memcmp(data, kMagic, 4) != 0) return false;
    // Vérification version
    if (data[4] != kVersion) return false;

    // Vérification checksum
    std::uint32_t storedChk =
        static_cast<std::uint32_t>(data[16]) |
        (static_cast<std::uint32_t>(data[17]) << 8) |
        (static_cast<std::uint32_t>(data[18]) << 16) |
        (static_cast<std::uint32_t>(data[19]) << 24);
    std::uint32_t computedChk = computeChecksum(data, 16);
    if (storedChk != computedChk) return false;

    // Lecture des données
    progress.ordersCompleted =
        static_cast<std::uint32_t>(data[8]) |
        (static_cast<std::uint32_t>(data[9]) << 8) |
        (static_cast<std::uint32_t>(data[10]) << 16) |
        (static_cast<std::uint32_t>(data[11]) << 24);
    progress.totalScore =
        static_cast<std::uint32_t>(data[12]) |
        (static_cast<std::uint32_t>(data[13]) << 8) |
        (static_cast<std::uint32_t>(data[14]) << 16) |
        (static_cast<std::uint32_t>(data[15]) << 24);

    // Validation des valeurs
    if (progress.ordersCompleted > kMaxOrders) return false;
    if (progress.totalScore > kMaxScore) return false;

    return true;
}

} // namespace cheeseria
