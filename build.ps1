param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $BuildArguments
)

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$DevkitProPath = 'C:\devkitPro'
$DevkitArmPath = Join-Path $DevkitProPath 'devkitARM'
$MakePath = Join-Path $DevkitProPath 'msys2\usr\bin\make.exe'
$DataPath = Join-Path $ProjectRoot 'data'
$RomfsPath = Join-Path $ProjectRoot 'romfs'

if (-not (Test-Path -LiteralPath $DevkitArmPath)) {
    throw "devkitARM introuvable : $DevkitArmPath"
}
if (-not (Test-Path -LiteralPath $MakePath)) {
    throw "make introuvable : $MakePath"
}
if (-not (Test-Path -LiteralPath $DataPath)) {
    throw "Depot de donnees introuvable : $DataPath"
}

New-Item -ItemType Directory -Force -Path $RomfsPath | Out-Null
Copy-Item -LiteralPath (Join-Path $DataPath 'catalog.json') -Destination (Join-Path $RomfsPath 'catalog.json') -Force
Copy-Item -LiteralPath (Join-Path $DataPath 'hub.json') -Destination (Join-Path $RomfsPath 'hub.json') -Force

$RootCertificates = Get-ChildItem -Path 'Cert:\LocalMachine\Root' -ErrorAction Stop
if ($RootCertificates.Count -eq 0) {
    throw 'Aucun certificat racine de confiance trouve sur cette machine.'
}
$PemBundle = [System.Text.StringBuilder]::new()
foreach ($Certificate in $RootCertificates) {
    [void]$PemBundle.AppendLine('-----BEGIN CERTIFICATE-----')
    $Base64Certificate = [Convert]::ToBase64String($Certificate.RawData)
    for ($Offset = 0; $Offset -lt $Base64Certificate.Length; $Offset += 64) {
        $LineLength = [Math]::Min(64, $Base64Certificate.Length - $Offset)
        [void]$PemBundle.AppendLine($Base64Certificate.Substring($Offset, $LineLength))
    }
    [void]$PemBundle.AppendLine('-----END CERTIFICATE-----')
    [void]$PemBundle.AppendLine()
}
$CaBundlePath = Join-Path $RomfsPath 'ca-bundle.pem'
[System.IO.File]::WriteAllText($CaBundlePath, $PemBundle.ToString(), [System.Text.Encoding]::ASCII)

$env:DEVKITPRO = $DevkitProPath
$env:DEVKITARM = $DevkitArmPath
& $MakePath "DEVKITPRO=$DevkitProPath" "DEVKITARM=$DevkitArmPath" -C $ProjectRoot @BuildArguments
exit $LASTEXITCODE
