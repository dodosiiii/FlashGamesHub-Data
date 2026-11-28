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
- Two audio files are signed 16-bit mono PCM WAV: the button sound
  (11,025 Hz) and order-screen music (22,050 Hz).
- The atlas is loaded only while the assembly station is active. The WAV files
  are copied into RomFS; the button sound plays when an order is served. The
  background music is packaged but not yet played.
- See [`asset-inventory.csv`](asset-inventory.csv) for paths, formats, and
  measured sizes. The local source extraction contains 8,258 files totaling
  92,512,472 bytes; that full extraction is not needed to build the project.

## Phase 4 — Shared game engine

- Implemented menu, station, pause, result, and session-progress states.
- Touch input and A/B/START buttons operate the route; the game model owns
  station selection, validation, transitions, and scoring.
- The current prototype uses static ingredient art; no animation playback is
  implemented. The serve sound uses NDSP and reports unavailable audio in the
  menu if the DSP or WAV asset cannot be initialized.

## Phase 5 — Stations

- A complete simplified route is playable, with validation at the cooking,
  assembly, and fries stations and a result screen after service.
- The mechanics are intentionally limited to the four ticket choices above;
  they do not claim feature parity with the original game.
- `tests/game_test.cpp` covers the route, station choices, incomplete input,
  cancellation, pause/resume, and scoring.

## Phase 6 — Progression and save

- Completed order count and cumulative score are saved to
  `sdmc:/3ds/CheeseShop3DS/progress.dat` after each served order.
- The save uses a versioned fixed-size format with a checksum; missing data
  starts a fresh session, while unreadable/corrupt data is reported on the menu
  and the game starts with fresh progress.
- In-progress station state is not saved; this prototype has no days or
  unlocks to persist yet.

## Remaining work

- **Phase 7:** test in an emulator and on Old/New 3DS hardware; measure memory,
  performance, and package size. No emulator or console test is recorded yet.
- **Phase 8:** create and validate a CIA, banner assets, RSF, and a unique
  homebrew Title ID. Only the `.3dsx` and SMDH are currently built.
- **Phase 9:** add a Hub catalogue entry only after a validated package,
  download URL, and SHA-256 are available.

The current devkitPro build measures 807,380 bytes for the `.3dsx`; the ELF
reports 167,908 bytes text, 7,560 bytes data, and 28,640 bytes BSS. These are
static build figures, not runtime memory or frame-rate measurements.

## Build and verification

- `.\build.ps1 3ds` builds `build/cheeseria.3dsx`, its SMDH, texture atlas, and
  RomFS WAV files with devkitPro.
- `.\build.ps1 host` and `.\build.ps1 test` require a native C++17 compiler.
- The 3DS build and test-source syntax check pass. Runtime host tests and
  emulator/device tests remain unverified because no native compiler or
  compatible emulator/device is available in the current environment.
