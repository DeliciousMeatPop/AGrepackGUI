#Requires -Version 5.1
<#
.SYNOPSIS
    ISXPM Patch Builder automation script for AG-ISXPM-Made-Easy.
.DESCRIPTION
    Enter the old and new release name strings (e.g. "Game Name v12345 -ARMGDDN")
    and the script does the rest: parses the version info, fills in the template,
    writes settings.ini, launches isxpm.exe, and zips the output for upload.
.PARAMETER Profile
    Game profile name from game_config.ini (e.g. "Stalker2"). Skips the menu.
.PARAMETER OldRelease
    Full old release name string. Skips the prompt.
.PARAMETER NewRelease
    Full new release name string. Skips the prompt.
.PARAMETER SkipBuild
    Write settings.ini only; do not launch isxpm.exe.
.PARAMETER SkipZip
    Launch isxpm.exe but skip the final zip step.
.EXAMPLE
    .\make_patch.ps1
    .\make_patch.ps1 -Profile Stalker2
    .\make_patch.ps1 -OldRelease "Game v12345 -TAG" -NewRelease "Game v67890 -TAG"
#>
param(
    [string]$Profile    = "",
    [string]$OldRelease = "",
    [string]$NewRelease = "",
    [switch]$SkipBuild,
    [switch]$SkipZip
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ── Paths ──────────────────────────────────────────────────────────────────────
$Root        = $PSScriptRoot
$TemplateIni = Join-Path $Root "settings_template.ini"
$SettingsIni = Join-Path $Root "settings.ini"
$ConfigIni   = Join-Path $Root "game_config.ini"
$IsxpmExe    = Join-Path $Root "isxpm.exe"
$GamesOldDir = Join-Path $Root "Games\old"
$GamesNewDir = Join-Path $Root "Games\new"
$ResourceDir = Join-Path $Root "resources"
$OutputDir   = Join-Path $Root "ISXPMPatch"
$UploadDir   = Join-Path $Root "Output\Upload"

# ── Helpers ────────────────────────────────────────────────────────────────────
function Write-Step([string]$msg) {
    Write-Host ""
    Write-Host ">>> $msg" -ForegroundColor Cyan
}

function Ask([string]$prompt, [string]$default = "") {
    $hint = if ($default) { " [$default]" } else { "" }
    $val  = Read-Host "$prompt$hint"
    if ([string]::IsNullOrWhiteSpace($val)) { return $default }
    return $val.Trim()
}

function Pick([string]$title, [string[]]$items) {
    Write-Host ""
    Write-Host $title -ForegroundColor Yellow
    for ($i = 0; $i -lt $items.Count; $i++) {
        Write-Host "  [$($i+1)] $($items[$i])"
    }
    do {
        $raw = Read-Host "Select (1-$($items.Count))"
        $idx = ([int]$raw) - 1
    } while ($idx -lt 0 -or $idx -ge $items.Count)
    return $items[$idx]
}

function Read-IniFile([string]$path) {
    $data    = [ordered]@{}
    $section = "_"
    foreach ($line in (Get-Content $path -Encoding UTF8)) {
        $line = $line.Trim()
        if ($line -match '^\[(.+)\]$') {
            $section = $Matches[1]
            if (-not $data.Contains($section)) { $data[$section] = [ordered]@{} }
        } elseif ($line -notmatch '^[;#]' -and $line -match '^(.+?)\s*=\s*(.*)$') {
            if (-not $data.Contains($section)) { $data[$section] = [ordered]@{} }
            $data[$section][$Matches[1].Trim()] = $Matches[2].Trim()
        }
    }
    return $data
}

function Parse-ReleaseName([string]$release) {
    # Expected format: "Game Name vBUILD_NUMBER -TAG"
    # Splits on the first " v" that precedes a run of digits
    if ($release -cmatch '^(.+?)\s+v([\d.]+)(\s+.+)?$') {
        return @{
            GameName = $Matches[1].Trim()
            Build    = $Matches[2].Trim()
            Tag      = if ($Matches[3]) { $Matches[3].Trim() } else { "" }
        }
    }
    Write-Error "Could not parse release name: '$release'`nExpected format: 'Game Name vBUILD_NUMBER -TAG'"
    exit 1
}

function Resolve-AssetPath([string]$value) {
    if ([string]::IsNullOrEmpty($value)) { return "" }
    if ([System.IO.Path]::IsPathRooted($value)) { return $value }
    return Join-Path $ResourceDir $value
}

# ── Load game_config.ini ───────────────────────────────────────────────────────
Write-Step "Loading game_config.ini"

if (-not (Test-Path $ConfigIni)) {
    Write-Error "game_config.ini not found at: $ConfigIni"
    exit 1
}

$ini          = Read-IniFile $ConfigIni
$gameProfiles = @($ini.Keys | Where-Object { $_ -notin @('DEFAULT', '_') })

if ($gameProfiles.Count -eq 0) {
    Write-Error "No game profiles found in game_config.ini. Add a [ProfileName] section."
    exit 1
}

# Select profile
if (-not $Profile) {
    $Profile = if ($gameProfiles.Count -eq 1) {
        Write-Host "Using profile: $($gameProfiles[0])" -ForegroundColor Green
        $gameProfiles[0]
    } else {
        Pick "Select game profile:" $gameProfiles
    }
}

if (-not $ini.Contains($Profile)) {
    Write-Error "Profile '$Profile' not found in game_config.ini."
    exit 1
}

# Merge DEFAULT values with game-specific overrides
$cfg = [ordered]@{}
if ($ini.Contains('DEFAULT')) { foreach ($k in $ini['DEFAULT'].Keys) { $cfg[$k] = $ini['DEFAULT'][$k] } }
foreach ($k in $ini[$Profile].Keys) { $cfg[$k] = $ini[$Profile][$k] }

# ── Release name inputs ────────────────────────────────────────────────────────
Write-Step "Release names"
Write-Host "  Format: Game Name vBUILD_NUMBER -TAG" -ForegroundColor DarkGray
Write-Host "  Example: S.T.A.L.K.E.R. 2 - Heart of Chornobyl v21222340 -ARMGDDN" -ForegroundColor DarkGray

if (-not $OldRelease) { $OldRelease = Ask "Old release name" }
if (-not $NewRelease) { $NewRelease = Ask "New release name" }

$old = Parse-ReleaseName $OldRelease
$new = Parse-ReleaseName $NewRelease

if ($old.GameName -ne $new.GameName) {
    Write-Warning "Game names differ between releases:`n  Old: $($old.GameName)`n  New: $($new.GameName)"
    $ok = Ask "Continue anyway? [y/N]" "N"
    if ($ok -notmatch '^[Yy]') { Write-Host "Aborted."; exit 0 }
}

$gameName = $old.GameName
$oldBuild = $old.Build
$newBuild = $new.Build

Write-Host ""
Write-Host "  Game     : $gameName" -ForegroundColor White
Write-Host "  Old build: $oldBuild" -ForegroundColor White
Write-Host "  New build: $newBuild" -ForegroundColor White

# ── Detect game folders ────────────────────────────────────────────────────────
Write-Step "Detecting game folders"

function Find-GameFolder([string]$base, [string]$preferred) {
    $exact = Join-Path $base $preferred
    if (Test-Path $exact -PathType Container) { return $exact }
    $subs = @(Get-ChildItem $base -Directory -ErrorAction SilentlyContinue |
              Where-Object { $_.Name -notmatch '^\.' -and $_.Name -ne '.gitkeep' })
    if ($subs.Count -eq 1) { return $subs[0].FullName }
    if ($subs.Count -gt 1) {
        $chosen = Pick "Multiple folders in '$base' — select game:" ($subs | ForEach-Object { $_.Name })
        return Join-Path $base $chosen
    }
    return $null
}

$oldGamePath = Find-GameFolder $GamesOldDir $gameName
$newGamePath = Find-GameFolder $GamesNewDir $gameName

if (-not $oldGamePath) {
    Write-Error "No game folder found in Games\old\`nInstall the old version there first."
    exit 1
}
if (-not $newGamePath) {
    Write-Error "No game folder found in Games\new\`nInstall the new version there first."
    exit 1
}

Write-Host "  Old path : $oldGamePath" -ForegroundColor Green
Write-Host "  New path : $newGamePath" -ForegroundColor Green

# ── Build all substitution values ──────────────────────────────────────────────
Write-Step "Building settings"

$patchEngine = if ($cfg.Contains('PATCH_ENGINE')) { $cfg['PATCH_ENGINE'] } else { "1" }
$patchExt    = @("xdelta","diff","hdiff")[[int]$patchEngine]
$genCores    = if ($cfg.Contains('GENERATING_CORES')) { $cfg['GENERATING_CORES'] } else { "23" }
$appCores    = if ($cfg.Contains('APPLYING_CORES'))   { $cfg['APPLYING_CORES']   } else { "3"  }
$copyright   = if ($cfg.Contains('COPYRIGHT'))        { $cfg['COPYRIGHT']        } else { "" }
$contact     = if ($cfg.Contains('CONTACT'))          { $cfg['CONTACT']          } else { "" }
$iconFile    = if ($cfg.Contains('ICON_FILE'))        { $cfg['ICON_FILE']        } else { "icon.ico" }
$musicRaw    = if ($cfg.Contains('MUSIC_FILE'))       { $cfg['MUSIC_FILE']       } else { "" }
$skinRaw     = if ($cfg.Contains('SKIN'))             { $cfg['SKIN']             } else { "" }
$curBtnRaw   = if ($cfg.Contains('CURSOR_BTN'))       { $cfg['CURSOR_BTN']       } else { "" }
$curFrmRaw   = if ($cfg.Contains('CURSOR_FRM'))       { $cfg['CURSOR_FRM']       } else { "" }

$patchFilename  = "$gameName v$oldBuild-${newBuild}_Update_Patch"
$uninstallKey   = "${gameName}_is1"

$iconPath = Join-Path $oldGamePath $iconFile
if (-not (Test-Path $iconPath -ErrorAction SilentlyContinue)) { $iconPath = "" }

$skinPath = if ($skinRaw) { Resolve-AssetPath $skinRaw } else { "Skin disabled" }
if ($skinPath -ne "Skin disabled" -and -not (Test-Path $skinPath -ErrorAction SilentlyContinue)) { $skinPath = "Skin disabled" }

$curBtn = if ($curBtnRaw) { Resolve-AssetPath $curBtnRaw } else { "Cursor disabled" }
if ($curBtn -ne "Cursor disabled" -and -not (Test-Path $curBtn -ErrorAction SilentlyContinue)) { $curBtn = "Cursor disabled" }

$curFrm = if ($curFrmRaw) { Resolve-AssetPath $curFrmRaw } else { "Cursor disabled" }
if ($curFrm -ne "Cursor disabled" -and -not (Test-Path $curFrm -ErrorAction SilentlyContinue)) { $curFrm = "Cursor disabled" }

$musicFile = if ($musicRaw -and (Test-Path $musicRaw -ErrorAction SilentlyContinue)) { $musicRaw } else { "Music disabled" }

# ── Summary ────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "  Patch file  : $patchFilename.exe" -ForegroundColor White
Write-Host "  Engine      : $(@('XDelta','JDiff','HDiff')[[int]$patchEngine]) ($patchExt)" -ForegroundColor White
Write-Host "  Cores       : gen=$genCores  apply=$appCores" -ForegroundColor White
Write-Host "  Output dir  : $OutputDir" -ForegroundColor White
Write-Host "  Skin        : $skinPath" -ForegroundColor White
Write-Host "  Music       : $musicFile" -ForegroundColor White
Write-Host ""

$ok = Ask "Proceed? [Y/n]" "Y"
if ($ok -notmatch '^[Yy]') { Write-Host "Aborted." -ForegroundColor Yellow; exit 0 }

# ── Read template, substitute, write settings.ini ─────────────────────────────
Write-Step "Writing settings.ini"

if (-not (Test-Path $TemplateIni)) {
    Write-Error "settings_template.ini not found at: $TemplateIni"
    exit 1
}

$tpl = Get-Content $TemplateIni -Raw -Encoding UTF8

$silentBuild = if ($SkipBuild) { "0" } else { "1" }

$subs = [ordered]@{
    '%OLD_GAME_PATH%'    = $oldGamePath
    '%NEW_GAME_PATH%'    = $newGamePath
    '%GAME_NAME%'        = $gameName
    '%OLD_BUILD%'        = $oldBuild
    '%NEW_BUILD%'        = $newBuild
    '%OLD_RELEASE_NAME%' = $OldRelease
    '%PATCH_FILENAME%'   = $patchFilename
    '%UNINSTALL_KEY%'    = $uninstallKey
    '%ICON_PATH%'        = $iconPath
    '%OUTPUT_DIR%'       = $OutputDir
    '%PATCH_ENGINE%'     = $patchEngine
    '%PATCH_EXT%'        = $patchExt
    '%GENERATING_CORES%' = $genCores
    '%APPLYING_CORES%'   = $appCores
    '%COPYRIGHT%'        = $copyright
    '%CONTACT%'          = $contact
    '%SKIN_PATH%'        = $skinPath
    '%CURSOR_BTN%'       = $curBtn
    '%CURSOR_FRM%'       = $curFrm
    '%MUSIC_FILE%'       = $musicFile
    '%SILENT_BUILD%'     = $silentBuild
}

foreach ($kv in $subs.GetEnumerator()) {
    $tpl = $tpl.Replace($kv.Key, $kv.Value)
}

# Write UTF-16 LE with BOM — the encoding isxpm.exe expects
$enc   = [System.Text.Encoding]::Unicode
$bytes = $enc.GetPreamble() + $enc.GetBytes($tpl)
[System.IO.File]::WriteAllBytes($SettingsIni, $bytes)

Write-Host "Written: $SettingsIni" -ForegroundColor Green

# ── Launch isxpm.exe ───────────────────────────────────────────────────────────
if ($SkipBuild) {
    Write-Host ""
    Write-Host "SkipBuild set — open isxpm.exe manually and click Build when ready." -ForegroundColor Yellow
    exit 0
}

if ($IsLinux -or $IsMacOS) {
    Write-Host ""
    Write-Host "Non-Windows host: settings.ini written successfully." -ForegroundColor Yellow
    Write-Host "Copy the repo to your Windows machine and run isxpm.exe to build the patch." -ForegroundColor Yellow
    exit 0
}

if (-not (Test-Path $IsxpmExe)) {
    Write-Error "isxpm.exe not found at: $IsxpmExe"
    exit 1
}

Write-Step "Launching isxpm.exe"
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
Write-Host "Starting isxpm.exe — build the patch, then close the window." -ForegroundColor Yellow

$proc = Start-Process -FilePath $IsxpmExe -WorkingDirectory $Root -PassThru
$proc.WaitForExit()

Write-Host "isxpm.exe exited (code $($proc.ExitCode))." -ForegroundColor Green

# ── Package output ─────────────────────────────────────────────────────────────
if ($SkipZip) { exit 0 }

Write-Step "Packaging output"
New-Item -ItemType Directory -Force -Path $UploadDir | Out-Null

$builtExe = Get-ChildItem $OutputDir -Filter "*.exe" -ErrorAction SilentlyContinue |
            Sort-Object LastWriteTime -Descending |
            Select-Object -First 1

if (-not $builtExe) {
    Write-Warning "No .exe found in $OutputDir — did the build complete?"
    Write-Host "Run with -SkipBuild or re-run make_patch.ps1 to retry packaging." -ForegroundColor Yellow
} else {
    Write-Host "Found: $($builtExe.Name)" -ForegroundColor Green

    $zipPath = Join-Path $UploadDir "$patchFilename.zip"
    Compress-Archive -Path $builtExe.FullName -DestinationPath $zipPath -Force

    $sizeMB = [Math]::Round((Get-Item $zipPath).Length / 1MB, 2)
    Write-Host "Created: $zipPath ($sizeMB MB)" -ForegroundColor Green
    Start-Process explorer.exe $UploadDir
}

Write-Host ""
Write-Host "All done!" -ForegroundColor Green
