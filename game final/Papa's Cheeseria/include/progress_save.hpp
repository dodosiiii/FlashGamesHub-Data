// progress_save.hpp — sérialisation de la progression (20 octets, magic CHZ1)
#pragma once
#include <array>
#include <cstddef>
#include <cstdint>

namespace cheeseria {

constexpr std::size_t kProgressSaveSize = 20;

struct SavedProgress {
    std::uint32_t ordersCompleted = 0;
    std::uint32_t totalScore = 0;
};

bool encodeProgress(const SavedProgress& progress, std::array<std::uint8_t, kProgressSaveSize>& output);
bool decodeProgress(const std::uint8_t* data, std::size_t size, SavedProgress& progress);

} // namespace cheeseria
