# Phases 2–9 — Prototype status

This is an independent, simplified remake prototype. It is not the original
game and is not affiliated with its publisher. The game rules and rendering
code are separate; selected SWF media was locally extracted for this remake
with the user's authorization.

## Phase 2 — Architecture and first milestone

- C++17 game logic is kept in `source/game.cpp` and `include/game.hpp`, without
  libctru or Citro2D dependencies.
- `source/main_3ds.cpp` renders the main scene on the top screen and touch
  controls on the bottom screen. `source/main_host.cpp` provides a terminal
  prototype using the same game model.
- The first milestone is now a simplified order route through take order,
  cooking, sandwich assembly, fries, service, result, and session progress.
- The fixed prototype ticket requests wholegrain bread, cheddar, medium cook,
  and regular fries.

## Phase 3 — Assets

- Four selected 128x80 ingredient sprites are packed into a Citro2D texture
  atlas. Only the needed still frames are included.
- Two packaged audio files are signed 16-bit mono PCM WAV: the button sound
  (11,025 Hz) and order-screen music (22,050 Hz).
- The atlas is loaded only while the assembly station is active. The WAV files
  are currently packaged but not played by the prototype.
- See [`asset-inventory.csv`](asset-inventory.csv) for paths, formats, and
  measured sizes. The local source extraction contains 8,258 files totaling
  92,512,472 bytes; that full extraction is not needed to build the project.

## Phase 4 — Shared game engine

- Implemented menu, station, pause, result, and session-progress states.
- Touch input and A/B/START buttons operate the route; the game model owns
  station selection, validation, transitions, and scoring.
- Animations and audio playback are not yet implemented. The current prototype
  uses static ingredient art and keeps audio as packaged assets only.

## Phase 5 — Stations

- A complete simplified route is playable, with validation at the cooking,
  assembly, and fries stations and a result screen after service.
- The mechanics are intentionally limited to the four ticket choices above;
  they do not claim feature parity with the original game.
- `tests/game_test.cpp` covers the route, station choices, incomplete input,
  cancellation, pause/resume, and scoring.

## Remaining work

- **Phase 6:** persist scores/progression to SD and handle invalid save data.
- **Phase 7:** test in an emulator and on Old/New 3DS hardware; measure memory,
  performance, and package size. No emulator or console test is recorded yet.
- **Phase 8:** create and validate a CIA, banner assets, RSF, and a unique
  homebrew Title ID. Only the `.3dsx` and SMDH are currently built.
- **Phase 9:** add a Hub catalogue entry only after a validated package,
  download URL, and SHA-256 are available.

## Build and verification

- `.\build.ps1 3ds` builds `build/cheeseria.3dsx`, its SMDH, texture atlas, and
  RomFS WAV files with devkitPro.
- `.\build.ps1 host` and `.\build.ps1 test` require a native C++17 compiler.
- The 3DS build and test-source syntax check pass. Runtime host tests and
  emulator/device tests remain unverified because no native compiler or
  compatible emulator/device is available in the current environment.
