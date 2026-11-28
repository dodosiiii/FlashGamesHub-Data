# inventory.ps1 — inventaire complet du projet pour le port 3DS
# Usage (depuis la racine du projet) :
#   powershell -ExecutionPolicy Bypass -File inventory.ps1
# Produit : inventory\report.txt, inventory\files.csv et inventory.zip
param([string]$Root = (Get-Location).Path, [string]$Out = "inventory")
$ErrorActionPreference = "SilentlyContinue"
$Root = (Resolve-Path $Root).Path
$OutDir = Join-Path $Root $Out
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

$sb = New-Object System.Text.StringBuilder
function W([string]$s) { [void]$sb.AppendLine($s) }
function Rel([string]$p) { $p.Substring($Root.Length).TrimStart('\','/') }

$skip = '\\(\.git|node_modules|inventory)(\\|$)'
$files = @(Get-ChildItem -LiteralPath $Root -Recurse -File -Force | Where-Object { $_.FullName -notmatch $skip })

function Get-PngSize([string]$path) {
    try {
        $fs = [System.IO.File]::OpenRead($path); $b = New-Object byte[] 24
        $n = $fs.Read($b, 0, 24); $fs.Close()
        if ($n -ge 24 -and $b[1] -eq 0x50 -and $b[2] -eq 0x4E -and $b[3] -eq 0x47) {
            $w = ([int]$b[16] -shl 24) -bor ([int]$b[17] -shl 16) -bor ([int]$b[18] -shl 8) -bor [int]$b[19]
            $h = ([int]$b[20] -shl 24) -bor ([int]$b[21] -shl 16) -bor ([int]$b[22] -shl 8) -bor [int]$b[23]
            return @($w, $h)
        }
    } catch {}
    return $null
}
function Get-WavInfo([string]$path) {
    try {
        $fs = [System.IO.File]::OpenRead($path); $b = New-Object byte[] 44
        $n = $fs.Read($b, 0, 44); $fs.Close()
        if ($n -ge 44 -and $b[0] -eq 0x52 -and $b[8] -eq 0x57) {
            return "ch=$([BitConverter]::ToUInt16($b,22)) rate=$([BitConverter]::ToUInt32($b,24)) bits=$([BitConverter]::ToUInt16($b,34))"
        }
    } catch {}
    return ""
}

# ── CSV de tous les fichiers (taille, dimensions PNG, infos WAV) ──
$rows = foreach ($f in $files) {
    $ext = $f.Extension.ToLower(); $w = ""; $h = ""; $extra = ""
    if ($ext -eq ".png") { $s = Get-PngSize $f.FullName; if ($s) { $w = $s[0]; $h = $s[1] } }
    if ($ext -eq ".wav") { $extra = Get-WavInfo $f.FullName }
    [pscustomobject]@{ path = (Rel $f.FullName); size = $f.Length; ext = $ext; width = $w; height = $h; extra = $extra }
}
$rows | Export-Csv -LiteralPath (Join-Path $OutDir "files.csv") -NoTypeInformation -Encoding UTF8

# ── Résumé ──
$total = ($files | Measure-Object Length -Sum).Sum
W "=== INVENTAIRE ==="
W "Racine : $Root"
W "Fichiers : $($files.Count)   Taille totale : $([math]::Round($total/1MB,1)) Mo"
W ""
W "=== DOSSIERS DE PREMIER NIVEAU ==="
foreach ($d in (Get-ChildItem -LiteralPath $Root -Directory -Force | Where-Object { $_.FullName -notmatch $skip })) {
    $p = $d.FullName + "\"
    $sub = @($files | Where-Object { $_.FullName.StartsWith($p) })
    $mb = [math]::Round((($sub | Measure-Object Length -Sum).Sum) / 1MB, 2)
    W ("{0,-20} {1,7} fichiers {2,9} Mo" -f $d.Name, $sub.Count, $mb)
}
W ""
W "=== EXTENSIONS (global) ==="
$files | Group-Object { $_.Extension.ToLower() } | Sort-Object Count -Descending | ForEach-Object {
    W ("{0,-10} {1,7}" -f $(if ($_.Name) { $_.Name } else { "(aucune)" }), $_.Count)
}
W ""

# ── Dossiers contenant des images/sons : stats + échantillon ──
W "=== DOSSIERS (images / sons) : nombre, tailles PNG min-max, exemples ==="
$byDir = $rows | Where-Object { $_.ext -in ".png", ".wav", ".mp3", ".ogg", ".t3x", ".svg", ".jpg", ".gif" } |
    Group-Object { Split-Path $_.path -Parent } | Sort-Object Count -Descending | Select-Object -First 200
foreach ($g in $byDir) {
    $pngs = @($g.Group | Where-Object { $_.width -ne "" })
    $dim = ""
    if ($pngs.Count -gt 0) {
        $ws = $pngs | ForEach-Object { [int]$_.width }; $hs = $pngs | ForEach-Object { [int]$_.height }
        $dim = "  PNG w:$(($ws | Measure-Object -Minimum).Minimum)-$(($ws | Measure-Object -Maximum).Maximum) h:$(($hs | Measure-Object -Minimum).Minimum)-$(($hs | Measure-Object -Maximum).Maximum)"
    }
    W ("[{0}] {1} fichiers{2}" -f $g.Name, $g.Count, $dim)
    ($g.Group | Select-Object -First 12 | ForEach-Object { "    " + (Split-Path $_.path -Leaf) + $(if ($_.width -ne "") { " ($($_.width)x$($_.height))" } else { "" }) + $(if ($_.extra) { " [$($_.extra)]" } else { "" }) }) | ForEach-Object { W $_ }
}
W ""

# ── Arborescence détaillée (hors images/sons) ──
W "=== AUTRES FICHIERS (code, config, docs, outils, scripts AS3...) ==="
$rows | Where-Object { $_.ext -notin ".png", ".wav", ".mp3", ".ogg", ".jpg", ".gif", ".svg", ".t3x", ".o", ".d" } |
    Select-Object -First 1500 | ForEach-Object { W ("{0}  ({1} o)" -f $_.path, $_.size) }
W ""

# ── Contenu des fichiers texte importants ──
W "=== CONTENU DES FICHIERS CLES ==="
$textRx = '(^|\\)(Makefile|\.gitignore|build\.ps1)$|\.(rsf|t3s|tsv|md|json|py|ps1|txt|cfg|yml|yaml|toml)$'
$maxBytes = 30000
foreach ($f in ($files | Where-Object { (Rel $_.FullName) -match $textRx -and $_.Length -lt 400000 -and $_.FullName -notmatch '\\(build|extracted)\\' } | Sort-Object FullName)) {
    W ("----- {0} ({1} o) -----" -f (Rel $f.FullName), $f.Length)
    $txt = Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8
    if ($txt.Length -gt $maxBytes) { $txt = $txt.Substring(0, $maxBytes) + "`n[... tronqué ...]" }
    W $txt
}
W ""

# ── Lignes de code ──
W "=== SOURCES (lignes) ==="
foreach ($f in ($files | Where-Object { $_.Extension -in ".cpp", ".hpp", ".h", ".c" -and $_.FullName -notmatch '\\(build|extracted)\\' })) {
    W ("{0,6}  {1}" -f (@(Get-Content -LiteralPath $f.FullName)).Count, (Rel $f.FullName))
}

[System.IO.File]::WriteAllText((Join-Path $OutDir "report.txt"), $sb.ToString(), (New-Object System.Text.UTF8Encoding($false)))
$zip = Join-Path $Root "inventory.zip"
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path (Join-Path $OutDir "*") -DestinationPath $zip -Force
Write-Host "OK -> $zip  (envoie ce fichier)"
