// audio_3ds.hpp — audio NDSP (nécessite /3ds/dspfirm.cdc sur la SD)
#pragma once

namespace cheeseria {

bool initializeAudio();   // après romfsInit()
void playServeSound();
void shutdownAudio();

} // namespace cheeseria
