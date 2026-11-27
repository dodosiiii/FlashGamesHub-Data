# Cheese Shop 3DS

An independent, simplified C++ remake prototype for Nintendo 3DS. This is not
the original game and is not affiliated with its publisher.

The prototype has a playable order route: take order, cook, assemble, prepare
fries, serve, and review the result. The game rules are platform-independent;
the 3DS front end uses libctru and Citro2D.

## Build

From this directory, with devkitPro installed:

```powershell
.\build.ps1 3ds
```

The output is `build/cheeseria.3dsx`. A native C++17 compiler is required for
the host prototype and game tests:

```powershell
.\build.ps1 host
.\build.ps1 test
```

See [`docs/phase-2.md`](docs/phase-2.md) for phase status and
[`docs/asset-inventory.csv`](docs/asset-inventory.csv) for the asset list.
