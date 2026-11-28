// audio_3ds.cpp — Papa's Cheeseria 3DS
// Gestion audio NDSP (sons WAV PCM16 en RAM, lecture à la demande)
// Version corrigée : parcours des chunks WAV, fréquence/canaux lus dans le fichier

#include "audio_3ds.hpp"

#include <3ds.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cstdint>

namespace cheeseria {

struct WavData {
    void*         buf      = nullptr;
    std::size_t   size     = 0;
    std::uint32_t rate     = 0;
    std::uint16_t channels = 0;
    ndspWaveBuf   ndspBuf{};
};

static bool g_ndspReady = false;
static WavData g_serveSound;

static std::uint16_t le16(const std::uint8_t* p) {
    return static_cast<std::uint16_t>(p[0] | (p[1] << 8));
}
static std::uint32_t le32(const std::uint8_t* p) {
    return static_cast<std::uint32_t>(p[0]) | (static_cast<std::uint32_t>(p[1]) << 8) |
           (static_cast<std::uint32_t>(p[2]) << 16) | (static_cast<std::uint32_t>(p[3]) << 24);
}

// Charge un WAV PCM 16 bits mono/stéréo (n'importe quelle fréquence) depuis RomFS.
// Gère les chunks supplémentaires (LIST, fact...) avant "data".
static bool loadWav(const char* path, WavData& out) {
    FILE* f = fopen(path, "rb");
    if (!f) return false;

    std::uint8_t riff[12];
    if (fread(riff, 1, 12, f) < 12 || std::memcmp(riff, "RIFF", 4) != 0 ||
        std::memcmp(riff + 8, "WAVE", 4) != 0) {
        fclose(f);
        return false;
    }

    bool haveFmt = false;
    std::uint16_t fmtTag = 0, bits = 0;

    while (true) {
        std::uint8_t ch[8];
        if (fread(ch, 1, 8, f) < 8) break;
        std::uint32_t sz = le32(ch + 4);

        if (std::memcmp(ch, "fmt ", 4) == 0) {
            std::uint8_t fmt[16];
            if (sz < 16 || fread(fmt, 1, 16, f) < 16) break;
            fmtTag       = le16(fmt);
            out.channels = le16(fmt + 2);
            out.rate     = le32(fmt + 4);
            bits         = le16(fmt + 14);
            haveFmt      = true;
            if (sz > 16) fseek(f, static_cast<long>(sz - 16), SEEK_CUR);
        } else if (std::memcmp(ch, "data", 4) == 0) {
            if (!haveFmt || fmtTag != 1 || bits != 16 || out.channels < 1 || out.channels > 2) break;
            if (sz == 0 || sz > 2 * 1024 * 1024) break; // max 2 Mo par son

            out.buf = linearAlloc(sz); // aligné pour le DSP
            if (!out.buf) break;
            if (fread(out.buf, 1, sz, f) != sz) {
                linearFree(out.buf);
                out.buf = nullptr;
                break;
            }
            fclose(f);
            out.size = sz;
            DSP_FlushDataCache(out.buf, sz);
            return true;
        } else {
            fseek(f, static_cast<long>(sz + (sz & 1U)), SEEK_CUR);
        }
    }
    fclose(f);
    return false;
}

static void freeWav(WavData& w) {
    if (w.buf) { linearFree(w.buf); w.buf = nullptr; }
    w.size = 0;
}

bool initializeAudio() {
    // Nécessite romfsInit() déjà appelé et /3ds/dspfirm.cdc sur la SD
    if (ndspInit() != 0) return false;
    g_ndspReady = true;

    ndspSetOutputMode(NDSP_OUTPUT_STEREO);
    ndspChnReset(0);
    ndspChnSetInterp(0, NDSP_INTERP_POLYPHASE);
    float mix[12] = {1.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f};
    ndspChnSetMix(0, mix);

    if (!loadWav("romfs:/audio/buttonclick.wav", g_serveSound)) {
        g_serveSound.buf = nullptr; // non fatal
    }
    return true;
}

void playServeSound() {
    if (!g_ndspReady || !g_serveSound.buf) return;
    if (ndspChnIsPlaying(0)) ndspChnWaveBufClear(0);

    ndspChnSetRate(0, static_cast<float>(g_serveSound.rate));
    ndspChnSetFormat(0, g_serveSound.channels == 2 ? NDSP_FORMAT_STEREO_PCM16
                                                   : NDSP_FORMAT_MONO_PCM16);

    std::memset(&g_serveSound.ndspBuf, 0, sizeof(ndspWaveBuf));
    g_serveSound.ndspBuf.data_vaddr = g_serveSound.buf;
    g_serveSound.ndspBuf.nsamples   = static_cast<std::uint32_t>(g_serveSound.size / (2U * g_serveSound.channels));
    g_serveSound.ndspBuf.looping    = false;
    g_serveSound.ndspBuf.status     = NDSP_WBUF_FREE;

    ndspChnWaveBufAdd(0, &g_serveSound.ndspBuf);
}

void shutdownAudio() {
    freeWav(g_serveSound);
    if (g_ndspReady) {
        ndspExit();
        g_ndspReady = false;
    }
}

} // namespace cheeseria
