param(
    [ValidateSet('3ds', 'host', 'test', 'clean')]
    [string] $Target = '3ds'
)

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$DevkitProPath = 'C:\devkitPro'
$DevkitArmPath = Join-Path $DevkitProPath 'devkitARM'
$BashPath = Join-Path $DevkitProPath 'msys2\usr\bin\bash.exe'
$CygpathPath = Join-Path $DevkitProPath 'msys2\usr\bin\cygpath.exe'

if ($Target -eq 'host' -or $Target -eq 'test') {
    $HostCompiler = Get-Command 'g++', 'clang++', 'c++' -ErrorAction SilentlyContinue |
        Select-Object -First 1
    if (-not $HostCompiler) {
        throw 'Un compilateur C++ hote (g++, clang++ ou c++) est requis pour host/test.'
    }

    Push-Location $ProjectRoot
    try {
        New-Item -ItemType Directory -Force -Path 'build' | Out-Null
        $CompilerArguments = @(
            '-std=c++17', '-Wall', '-Wextra', '-Werror', '-pedantic', '-Iinclude'
        )
        if ($Target -eq 'host') {
            $CompilerArguments += @(
                'source/game.cpp', 'source/main_host.cpp', '-o', 'build/cheeseria-host.exe'
            )
        } else {
            $CompilerArguments += @(
                'source/game.cpp', 'tests/game_test.cpp', '-o', 'build/game-tests.exe'
            )
        }

        & $HostCompiler.Source @CompilerArguments
        if ($LASTEXITCODE -ne 0) {
            throw "La compilation C++ hote a echoue (code $LASTEXITCODE)."
        }
        if ($Target -eq 'host') {
            & (Join-Path $ProjectRoot 'build\cheeseria-host.exe')
        } else {
            & (Join-Path $ProjectRoot 'build\game-tests.exe')
        }
        if ($LASTEXITCODE -ne 0) {
            throw "L'execution du prototype/de tests a echoue (code $LASTEXITCODE)."
        }
    } finally {
        Pop-Location
    }
    exit 0
}

if (-not (Test-Path -LiteralPath $DevkitArmPath)) {
    throw "devkitARM introuvable : $DevkitArmPath"
}
if (-not (Test-Path -LiteralPath $BashPath) -or
    -not (Test-Path -LiteralPath $CygpathPath)) {
    throw 'Les outils Bash et cygpath de devkitPro sont requis.'
}

$env:DEVKITPRO = $DevkitProPath
$env:DEVKITARM = $DevkitArmPath
$UnixProjectRoot = (& $CygpathPath -u $ProjectRoot).Trim()
$UnixDevkitProPath = (& $CygpathPath -u $DevkitProPath).Trim()
$UnixDevkitArmPath = (& $CygpathPath -u $DevkitArmPath).Trim()
$MakeTarget = 'clean'
if ($Target -eq '3ds') {
    $MakeTarget = 'all'
}
$BuildCommand = 'cd "$1" && export DEVKITPRO="$2" DEVKITARM="$3" && make "$4"'
& $BashPath -lc $BuildCommand build $UnixProjectRoot $UnixDevkitProPath `
    $UnixDevkitArmPath $MakeTarget
if ($LASTEXITCODE -ne 0) {
    throw "La cible $Target a echoue (code $LASTEXITCODE)."
}
