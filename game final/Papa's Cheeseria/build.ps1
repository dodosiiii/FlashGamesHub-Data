param(
    [ValidateSet('3ds', 'cia', 'host', 'test', 'assets', 'clean')]
    [string] $Target = '3ds'
)

$ProjectRoot   = Split-Path -Parent $MyInvocation.MyCommand.Path
$DevkitProPath = 'C:\devkitPro'
$DevkitArmPath = Join-Path $DevkitProPath 'devkitARM'
$BashPath      = Join-Path $DevkitProPath 'msys2\usr\bin\bash.exe'
$CygpathPath   = Join-Path $DevkitProPath 'msys2\usr\bin\cygpath.exe'

# ── Cibles hôte (pas besoin de devkitPro) ───────────────────────────────────
if ($Target -eq 'host' -or $Target -eq 'test') {
    $HostCompiler = Get-Command 'g++', 'clang++', 'c++' -ErrorAction SilentlyContinue |
        Select-Object -First 1
    if (-not $HostCompiler) {
        throw 'Un compilateur C++ hote (g++, clang++ ou c++) est requis pour host/test.'
    }

    Push-Location $ProjectRoot
    try {
        New-Item -ItemType Directory -Force -Path 'build' | Out-Null
        $CompilerArguments = @('-std=c++17', '-Wall', '-Wextra', '-Werror', '-pedantic', '-Iinclude')
        if ($Target -eq 'host') {
            $CompilerArguments += @(
                'source/game.cpp', 'source/progress_save.cpp', 'source/main_host.cpp',
                '-o', 'build/cheeseria-host.exe'
            )
        } else {
            $CompilerArguments += @(
                'source/game.cpp', 'source/progress_save.cpp', 'tests/game_test.cpp',
                '-o', 'build/game-tests.exe'
            )
        }

        & $HostCompiler.Source @CompilerArguments
        if ($LASTEXITCODE -ne 0) { throw "Compilation hote echouee (code $LASTEXITCODE)." }

        if ($Target -eq 'host') {
            & (Join-Path $ProjectRoot 'build\cheeseria-host.exe')
        } else {
            $exe = Join-Path $ProjectRoot 'build\game-tests.exe'
            & $exe
            if ($LASTEXITCODE -eq 0) { Write-Host 'Tous les tests sont passes.' -ForegroundColor Green }
        }
        if ($LASTEXITCODE -ne 0) { throw "Execution echouee (code $LASTEXITCODE)." }
    } finally {
        Pop-Location
    }
    exit 0
}

# ── Validation devkitPro ─────────────────────────────────────────────────────
if (-not (Test-Path -LiteralPath $DevkitArmPath)) {
    throw "devkitARM introuvable : $DevkitArmPath"
}
if (-not (Test-Path -LiteralPath $BashPath) -or -not (Test-Path -LiteralPath $CygpathPath)) {
    throw 'Bash et cygpath de devkitPro sont requis.'
}

$env:DEVKITPRO = $DevkitProPath
$env:DEVKITARM = $DevkitArmPath
$UnixProjectRoot    = (& $CygpathPath -u $ProjectRoot).Trim()
$UnixDevkitProPath  = (& $CygpathPath -u $DevkitProPath).Trim()
$UnixDevkitArmPath  = (& $CygpathPath -u $DevkitArmPath).Trim()

# Mappage des cibles PowerShell → Makefile
$MakeTarget = switch ($Target) {
    '3ds'    { 'all' }
    'cia'    { 'cia' }
    'assets' { 'assets' }
    'clean'  { 'clean' }
    default  { 'all' }
}

$BuildCommand = 'cd "$1" && export DEVKITPRO="$2" DEVKITARM="$3" && make "$4"'
& $BashPath -lc $BuildCommand build $UnixProjectRoot $UnixDevkitProPath $UnixDevkitArmPath $MakeTarget

if ($LASTEXITCODE -ne 0) {
    throw "La cible '$Target' (make $MakeTarget) a echoue (code $LASTEXITCODE)."
}

Write-Host ""
Write-Host "=== Build termine : $Target ===" -ForegroundColor Green
if ($Target -eq '3ds') {
    $size = (Get-Item (Join-Path $ProjectRoot 'build\cheeseria.3dsx') -ErrorAction SilentlyContinue)?.Length
    if ($size) { Write-Host "cheeseria.3dsx : $([math]::Round($size/1KB, 1)) KB" }
}
if ($Target -eq 'cia') {
    $size = (Get-Item (Join-Path $ProjectRoot 'build\cheeseria.cia') -ErrorAction SilentlyContinue)?.Length
    if ($size) { Write-Host "cheeseria.cia  : $([math]::Round($size/1MB, 2)) MB" }
}
