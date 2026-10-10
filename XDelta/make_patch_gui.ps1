#Requires -Version 5.1
# GUI patch builder for AG-ISXPM-Made-Easy.
# Launch via "Patch Builder.bat" or right-click -> Run with PowerShell.

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

try {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
} catch {
    [System.Windows.Forms.MessageBox]::Show(
        "Failed to load Windows Forms:`n$_`n`nTry running as Administrator.",
        "Startup Error", "OK", "Error")
    exit 1
}

[System.Windows.Forms.Application]::EnableVisualStyles()

# ── Paths ──────────────────────────────────────────────────────────────────────
$Root        = $PSScriptRoot
$TemplateIni = Join-Path $Root "settings_template.ini"
$SettingsIni = Join-Path $Root "settings.ini"
$ConfigIni   = Join-Path $Root "game_config.ini"
$SetupIni    = Join-Path $Root "setup.ini"
$IsxpmExe    = Join-Path $Root "isxpm.exe"
$GamesOldDir = Join-Path $Root "Games\old"
$GamesNewDir = Join-Path $Root "Games\new"
$ResourceDir = Join-Path $Root "resources"
$OutputDir   = Join-Path $Root "ISXPMPatch"
$UploadDir   = Join-Path $Root "Output\Upload"

# ── Theme ──────────────────────────────────────────────────────────────────────
$cBg      = [System.Drawing.Color]::FromArgb(22,  22,  22)
$cPanel   = [System.Drawing.Color]::FromArgb(36,  36,  36)
$cInput   = [System.Drawing.Color]::FromArgb(48,  48,  48)
$cLog     = [System.Drawing.Color]::FromArgb(12,  12,  12)
$cAccent  = [System.Drawing.Color]::FromArgb(0,   191, 255)
$cText    = [System.Drawing.Color]::FromArgb(220, 220, 220)
$cMuted   = [System.Drawing.Color]::FromArgb(110, 110, 110)
$cSuccess = [System.Drawing.Color]::FromArgb(50,  210, 100)
$cWarn    = [System.Drawing.Color]::FromArgb(255, 165,   0)
$cError   = [System.Drawing.Color]::FromArgb(255,  75,  75)
$cDanger  = [System.Drawing.Color]::FromArgb(160,  40,  40)

$fNormal = New-Object System.Drawing.Font("Segoe UI",  9)
$fBold   = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$fMono   = New-Object System.Drawing.Font("Consolas",  8.5)
$fSmall  = New-Object System.Drawing.Font("Segoe UI",  8, [System.Drawing.FontStyle]::Italic)

# ── Core helpers ───────────────────────────────────────────────────────────────
function Read-IniFile([string]$path) {
    $data = [ordered]@{}; $section = "_"
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
    if ($release -cmatch '^(.+?)\s+v([\d.]+)(\s+.+)?$') {
        return @{ GameName = $Matches[1].Trim(); Build = $Matches[2].Trim()
                  Tag = if ($Matches[3]) { $Matches[3].Trim() } else { "" } }
    }
    return $null
}

function Resolve-AssetPath([string]$value) {
    if ([string]::IsNullOrEmpty($value)) { return "" }
    if ([System.IO.Path]::IsPathRooted($value)) { return $value }
    return Join-Path $ResourceDir $value
}

function Find-GameFolder([string]$base, [string]$preferred) {
    $exact = Join-Path $base $preferred
    if (Test-Path $exact -PathType Container) { return $exact }
    $subs = @(Get-ChildItem $base -Directory -ErrorAction SilentlyContinue |
              Where-Object { $_.Name -notmatch '^\.' -and $_.Name -ne '.gitkeep' })
    if ($subs.Count -eq 1) { return $subs[0].FullName }
    return $null
}

# ── Setup config (setup.ini) ───────────────────────────────────────────────────
function Get-SetupConfig {
    $cfg = @{ SevenZipPath = ""; MusicFile = ""; SkipBuildPopup = $false }
    if (Test-Path $SetupIni) {
        try {
            $ini = Read-IniFile $SetupIni
            if ($ini.Contains('SETUP')) {
                $s = $ini['SETUP']
                if ($s.Contains('SEVENZIP_PATH'))   { $cfg.SevenZipPath   = $s['SEVENZIP_PATH'] }
                if ($s.Contains('MUSIC_FILE'))       { $cfg.MusicFile      = $s['MUSIC_FILE'] }
                if ($s.Contains('SKIP_BUILD_POPUP')) { $cfg.SkipBuildPopup = ($s['SKIP_BUILD_POPUP'] -eq '1') }
            }
        } catch { }
    }
    return $cfg
}

function Save-SetupConfig([string]$sevenZipPath, [string]$musicFile, [bool]$skipBuildPopup) {
    $lines = @(
        '[SETUP]',
        "SEVENZIP_PATH=$sevenZipPath",
        "MUSIC_FILE=$musicFile",
        "SKIP_BUILD_POPUP=$(if ($skipBuildPopup) { '1' } else { '0' })"
    )
    [System.IO.File]::WriteAllLines($SetupIni, $lines, [System.Text.Encoding]::UTF8)
}

function Set-SkipBuildPopup([bool]$value) {
    $c = Get-SetupConfig
    Save-SetupConfig -sevenZipPath $c.SevenZipPath -musicFile $c.MusicFile -skipBuildPopup $value
}

# ── Dirty-dir helpers ──────────────────────────────────────────────────────────
$script:WorkDirs = @(
    (Join-Path $Root "checker"),
    $GamesOldDir,
    $GamesNewDir,
    $OutputDir,
    (Join-Path $Root "xdata")
)

function Get-DirtyDirs {
    $dirty = @()
    foreach ($d in $script:WorkDirs) {
        if (Test-Path $d) {
            $files = @(Get-ChildItem $d -Recurse -File -ErrorAction SilentlyContinue |
                       Where-Object { $_.Name -notin @('.gitkeep', '.gitignore') })
            if ($files.Count -gt 0) { $dirty += $d }
        }
    }
    return $dirty
}

function Clear-WorkDirs([bool]$keepGames) {
    foreach ($d in $script:WorkDirs) {
        if ($keepGames -and ($d -eq $GamesOldDir -or $d -eq $GamesNewDir)) { continue }
        if (-not (Test-Path $d)) { continue }
        Get-ChildItem $d -Recurse -File -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -notin @('.gitkeep', '.gitignore') } |
            Remove-Item -Force -ErrorAction SilentlyContinue
        Get-ChildItem $d -Directory -Recurse -ErrorAction SilentlyContinue |
            Sort-Object { $_.FullName.Length } -Descending |
            ForEach-Object {
                if (@(Get-ChildItem $_.FullName -ErrorAction SilentlyContinue).Count -eq 0) {
                    Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
                }
            }
    }
}

# ── Setup wizard form ──────────────────────────────────────────────────────────
function Show-SetupWizard([bool]$isRedo) {
    $existing = Get-SetupConfig

    $wiz = New-Object System.Windows.Forms.Form
    $wiz.AutoScaleDimensions = New-Object System.Drawing.SizeF(96, 96)
    $wiz.AutoScaleMode       = [System.Windows.Forms.AutoScaleMode]::Font
    $wiz.Text                = if ($isRedo) { "Redo Setup" } else { "First-Time Setup" }
    $wiz.StartPosition       = "CenterScreen"
    $wiz.BackColor           = $cBg
    $wiz.ForeColor           = $cText
    $wiz.Font                = $fNormal
    $wiz.FormBorderStyle     = "FixedDialog"
    $wiz.MaximizeBox         = $false
    $wiz.MinimizeBox         = $false

    $y = 14

    $lblTitle = New-Object System.Windows.Forms.Label
    $lblTitle.Text      = if ($isRedo) { "Machine-Specific Settings" } else { "Welcome - configure your machine before first use" }
    $lblTitle.Location  = New-Object System.Drawing.Point(14, $y)
    $lblTitle.Size      = New-Object System.Drawing.Size(532, 20)
    $lblTitle.Font      = $fBold
    $lblTitle.ForeColor = $cAccent
    $wiz.Controls.Add($lblTitle)
    $y += 32

    # 7-Zip
    $lbl7z = New-Object System.Windows.Forms.Label
    $lbl7z.Text      = "7-Zip path (7z.exe) - required for packaging:"
    $lbl7z.Location  = New-Object System.Drawing.Point(14, $y)
    $lbl7z.Size      = New-Object System.Drawing.Size(532, 18)
    $lbl7z.ForeColor = $cMuted
    $wiz.Controls.Add($lbl7z)
    $y += 20

    $txt7z = New-Object System.Windows.Forms.TextBox
    $txt7z.Location    = New-Object System.Drawing.Point(14, $y)
    $txt7z.Size        = New-Object System.Drawing.Size(444, 24)
    $txt7z.BackColor   = $cInput
    $txt7z.ForeColor   = $cText
    $txt7z.BorderStyle = "FixedSingle"
    $txt7z.Text        = if ($existing.SevenZipPath) { $existing.SevenZipPath } else { "C:\Program Files\7-Zip\7z.exe" }
    $wiz.Controls.Add($txt7z)

    $btn7z = New-Object System.Windows.Forms.Button
    $btn7z.Text      = "Browse"
    $btn7z.Location  = New-Object System.Drawing.Point(464, $y)
    $btn7z.Size      = New-Object System.Drawing.Size(80, 24)
    $btn7z.BackColor = $cPanel
    $btn7z.ForeColor = $cText
    $btn7z.FlatStyle = "Flat"
    $btn7z.FlatAppearance.BorderColor = $cMuted
    $wiz.Controls.Add($btn7z)
    $y += 32

    $btn7z.Add_Click({
        $dlg = New-Object System.Windows.Forms.OpenFileDialog
        $dlg.Title  = "Locate 7z.exe"
        $dlg.Filter = "7z.exe|7z.exe|Executables|*.exe"
        try {
            if ($txt7z.Text) { $dlg.InitialDirectory = Split-Path $txt7z.Text }
        } catch { }
        if ($dlg.ShowDialog($wiz) -eq "OK") { $txt7z.Text = $dlg.FileName }
    })

    # Music file
    $lblMusic = New-Object System.Windows.Forms.Label
    $lblMusic.Text      = "Background music file (optional - leave blank to disable):"
    $lblMusic.Location  = New-Object System.Drawing.Point(14, $y)
    $lblMusic.Size      = New-Object System.Drawing.Size(532, 18)
    $lblMusic.ForeColor = $cMuted
    $wiz.Controls.Add($lblMusic)
    $y += 20

    $txtMusic = New-Object System.Windows.Forms.TextBox
    $txtMusic.Location    = New-Object System.Drawing.Point(14, $y)
    $txtMusic.Size        = New-Object System.Drawing.Size(444, 24)
    $txtMusic.BackColor   = $cInput
    $txtMusic.ForeColor   = $cText
    $txtMusic.BorderStyle = "FixedSingle"
    $txtMusic.Text        = $existing.MusicFile
    $wiz.Controls.Add($txtMusic)

    $btnMusic = New-Object System.Windows.Forms.Button
    $btnMusic.Text      = "Browse"
    $btnMusic.Location  = New-Object System.Drawing.Point(464, $y)
    $btnMusic.Size      = New-Object System.Drawing.Size(80, 24)
    $btnMusic.BackColor = $cPanel
    $btnMusic.ForeColor = $cText
    $btnMusic.FlatStyle = "Flat"
    $btnMusic.FlatAppearance.BorderColor = $cMuted
    $wiz.Controls.Add($btnMusic)
    $y += 32

    $btnMusic.Add_Click({
        $dlg = New-Object System.Windows.Forms.OpenFileDialog
        $dlg.Title  = "Select music file"
        $dlg.Filter = "Audio files|*.mp3;*.ogg;*.wav;*.flac|All files|*.*"
        if ($dlg.ShowDialog($wiz) -eq "OK") { $txtMusic.Text = $dlg.FileName }
    })

    $y += 8

    $btnSave = New-Object System.Windows.Forms.Button
    $btnSave.Text      = "Save and Continue"
    $btnSave.Location  = New-Object System.Drawing.Point(290, $y)
    $btnSave.Size      = New-Object System.Drawing.Size(158, 30)
    $btnSave.BackColor = $cAccent
    $btnSave.ForeColor = [System.Drawing.Color]::Black
    $btnSave.Font      = $fBold
    $btnSave.FlatStyle = "Flat"
    $btnSave.FlatAppearance.BorderSize = 0
    $wiz.Controls.Add($btnSave)

    $btnSkip = New-Object System.Windows.Forms.Button
    $btnSkip.Text      = if ($isRedo) { "Cancel" } else { "Skip for now" }
    $btnSkip.Location  = New-Object System.Drawing.Point(456, $y)
    $btnSkip.Size      = New-Object System.Drawing.Size(88, 30)
    $btnSkip.BackColor = $cPanel
    $btnSkip.ForeColor = $cMuted
    $btnSkip.FlatStyle = "Flat"
    $btnSkip.FlatAppearance.BorderColor = $cMuted
    $wiz.Controls.Add($btnSkip)

    $wiz.ClientSize   = New-Object System.Drawing.Size(560, ($y + 30 + 14))
    $wiz.AcceptButton = $btnSave
    $wiz.CancelButton = $btnSkip

    $script:wizSaved = $false

    $btnSave.Add_Click({
        $p = $txt7z.Text.Trim()
        if (-not (Test-Path $p -ErrorAction SilentlyContinue)) {
            [System.Windows.Forms.MessageBox]::Show(
                "7-Zip not found at:`n$p`n`nInstall 7-Zip from 7-zip.org or browse to 7z.exe.",
                "7-Zip Not Found", "OK", "Warning")
            return
        }
        Save-SetupConfig -sevenZipPath $p -musicFile $txtMusic.Text.Trim() -skipBuildPopup $false
        $script:wizSaved = $true
        $wiz.Close()
    })

    $btnSkip.Add_Click({ $wiz.Close() })

    [void]$wiz.ShowDialog()
    return $script:wizSaved
}

# ── Build-ready popup ──────────────────────────────────────────────────────────
# Returns $true to continue, $false to cancel
function Show-BuildPopup {
    $cfg = Get-SetupConfig
    if ($cfg.SkipBuildPopup) { return $true }

    $pop = New-Object System.Windows.Forms.Form
    $pop.AutoScaleDimensions = New-Object System.Drawing.SizeF(96, 96)
    $pop.AutoScaleMode       = [System.Windows.Forms.AutoScaleMode]::Font
    $pop.Text                = "Ready to Build"
    $pop.StartPosition       = "CenterScreen"
    $pop.BackColor           = $cBg
    $pop.ForeColor           = $cText
    $pop.Font                = $fNormal
    $pop.FormBorderStyle     = "FixedDialog"
    $pop.MaximizeBox         = $false
    $pop.MinimizeBox         = $false

    # Header bar
    $pHead = New-Object System.Windows.Forms.Panel
    $pHead.Location  = New-Object System.Drawing.Point(0, 0)
    $pHead.Size      = New-Object System.Drawing.Size(480, 42)
    $pHead.BackColor = $cPanel
    $pop.Controls.Add($pHead)

    $lblTitle = New-Object System.Windows.Forms.Label
    $lblTitle.Text      = "isxpm.exe is about to open"
    $lblTitle.Location  = New-Object System.Drawing.Point(14, 11)
    $lblTitle.Size      = New-Object System.Drawing.Size(452, 20)
    $lblTitle.Font      = $fBold
    $lblTitle.ForeColor = $cAccent
    $pHead.Controls.Add($lblTitle)

    # Step labels
    $y = 56
    $steps = @(
        @{ text = "1.  Check that the settings in isxpm look correct."; color = $cText },
        @{ text = "2.  Click  BUILD PATCH  to start generating the patch."; color = $cText },
        @{ text = "3.  Wait for the build to fully complete."; color = $cText },
        @{ text = "4.  Close isxpm -- this tool will then package the output."; color = $cText }
    )
    foreach ($step in $steps) {
        $sl = New-Object System.Windows.Forms.Label
        $sl.Text      = $step.text
        $sl.Location  = New-Object System.Drawing.Point(20, $y)
        $sl.Size      = New-Object System.Drawing.Size(440, 18)
        $sl.ForeColor = $step.color
        $pop.Controls.Add($sl)
        $y += 22
    }

    $y += 6

    $lblWarn = New-Object System.Windows.Forms.Label
    $lblWarn.Text      = "Do NOT close isxpm early -- the patch files will be incomplete."
    $lblWarn.Location  = New-Object System.Drawing.Point(20, $y)
    $lblWarn.Size      = New-Object System.Drawing.Size(440, 18)
    $lblWarn.ForeColor = $cWarn
    $pop.Controls.Add($lblWarn)
    $y += 30

    $chkSkip = New-Object System.Windows.Forms.CheckBox
    $chkSkip.Text      = "Don't show this again"
    $chkSkip.Location  = New-Object System.Drawing.Point(20, $y)
    $chkSkip.Size      = New-Object System.Drawing.Size(200, 20)
    $chkSkip.ForeColor = $cMuted
    $pop.Controls.Add($chkSkip)
    $y += 36

    $btnOk = New-Object System.Windows.Forms.Button
    $btnOk.Text      = "Open isxpm"
    $btnOk.Location  = New-Object System.Drawing.Point(268, $y)
    $btnOk.Size      = New-Object System.Drawing.Size(100, 32)
    $btnOk.BackColor = $cAccent
    $btnOk.ForeColor = [System.Drawing.Color]::Black
    $btnOk.Font      = $fBold
    $btnOk.FlatStyle = "Flat"
    $btnOk.FlatAppearance.BorderSize = 0
    $pop.Controls.Add($btnOk)

    $btnAbort = New-Object System.Windows.Forms.Button
    $btnAbort.Text      = "Cancel"
    $btnAbort.Location  = New-Object System.Drawing.Point(376, $y)
    $btnAbort.Size      = New-Object System.Drawing.Size(88, 32)
    $btnAbort.BackColor = $cPanel
    $btnAbort.ForeColor = $cMuted
    $btnAbort.FlatStyle = "Flat"
    $btnAbort.FlatAppearance.BorderColor = $cMuted
    $pop.Controls.Add($btnAbort)

    $pop.ClientSize   = New-Object System.Drawing.Size(480, ($y + 32 + 14))
    $pop.AcceptButton = $btnOk
    $pop.CancelButton = $btnAbort

    $script:popResult = $false

    $btnOk.Add_Click({
        if ($chkSkip.Checked) { Set-SkipBuildPopup $true }
        $script:popResult = $true
        $pop.Close()
    })
    $btnAbort.Add_Click({ $pop.Close() })

    [void]$pop.ShowDialog()
    return $script:popResult
}

# ── Dirty-dirs dialog ──────────────────────────────────────────────────────────
# Returns "all", "keepgames", or "skip"
function Show-DirtyDialog([string[]]$dirtyList) {
    $msg = "These folders have leftover files from a previous session:" + [Environment]::NewLine + [Environment]::NewLine
    foreach ($d in $dirtyList) {
        $rel = $d.Substring([Math]::Min($d.Length, $Root.Length + 1))
        $msg += "  - $rel" + [Environment]::NewLine
    }
    $msg += [Environment]::NewLine + "Clean up before starting?"

    $dlg = New-Object System.Windows.Forms.Form
    $dlg.AutoScaleDimensions = New-Object System.Drawing.SizeF(96, 96)
    $dlg.AutoScaleMode       = [System.Windows.Forms.AutoScaleMode]::Font
    $dlg.Text                = "Leftover Files Detected"
    $dlg.StartPosition       = "CenterScreen"
    $dlg.BackColor           = $cBg
    $dlg.ForeColor           = $cText
    $dlg.Font                = $fNormal
    $dlg.FormBorderStyle     = "FixedDialog"
    $dlg.MaximizeBox         = $false
    $dlg.MinimizeBox         = $false

    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Text      = $msg
    $lbl.Location  = New-Object System.Drawing.Point(14, 14)
    $lbl.Size      = New-Object System.Drawing.Size(452, 140)
    $dlg.Controls.Add($lbl)

    $btnAll = New-Object System.Windows.Forms.Button
    $btnAll.Text      = "Delete All"
    $btnAll.Location  = New-Object System.Drawing.Point(14, 164)
    $btnAll.Size      = New-Object System.Drawing.Size(116, 32)
    $btnAll.BackColor = $cDanger
    $btnAll.ForeColor = $cText
    $btnAll.FlatStyle = "Flat"
    $btnAll.FlatAppearance.BorderSize = 0
    $dlg.Controls.Add($btnAll)

    $btnKeep = New-Object System.Windows.Forms.Button
    $btnKeep.Text      = "Delete - Keep Games"
    $btnKeep.Location  = New-Object System.Drawing.Point(138, 164)
    $btnKeep.Size      = New-Object System.Drawing.Size(152, 32)
    $btnKeep.BackColor = $cWarn
    $btnKeep.ForeColor = [System.Drawing.Color]::Black
    $btnKeep.FlatStyle = "Flat"
    $btnKeep.FlatAppearance.BorderSize = 0
    $dlg.Controls.Add($btnKeep)

    $btnSkip = New-Object System.Windows.Forms.Button
    $btnSkip.Text      = "Continue Anyway"
    $btnSkip.Location  = New-Object System.Drawing.Point(388, 164)
    $btnSkip.Size      = New-Object System.Drawing.Size(90, 32)
    $btnSkip.BackColor = $cPanel
    $btnSkip.ForeColor = $cMuted
    $btnSkip.FlatStyle = "Flat"
    $btnSkip.FlatAppearance.BorderColor = $cMuted
    $dlg.Controls.Add($btnSkip)

    $dlg.ClientSize   = New-Object System.Drawing.Size(492, 212)
    $dlg.CancelButton = $btnSkip

    $script:dirtyResult = "skip"
    $btnAll.Add_Click({  $script:dirtyResult = "all";       $dlg.Close() })
    $btnKeep.Add_Click({ $script:dirtyResult = "keepgames"; $dlg.Close() })
    $btnSkip.Add_Click({ $script:dirtyResult = "skip";      $dlg.Close() })

    [void]$dlg.ShowDialog()
    return $script:dirtyResult
}

# ── Load game_config.ini ───────────────────────────────────────────────────────
$script:iniData  = $null
$script:profiles = @()

if (Test-Path $ConfigIni) {
    try {
        $script:iniData  = Read-IniFile $ConfigIni
        $script:profiles = @($script:iniData.Keys | Where-Object { $_ -notin @('DEFAULT','_') })
    } catch { }
}

# ── Main form ──────────────────────────────────────────────────────────────────
$form = New-Object System.Windows.Forms.Form
$form.AutoScaleDimensions = New-Object System.Drawing.SizeF(96, 96)
$form.AutoScaleMode       = [System.Windows.Forms.AutoScaleMode]::Font
$form.Text                = "ARMGDDN Patch Builder"
$form.StartPosition       = "CenterScreen"
$form.BackColor           = $cBg
$form.ForeColor           = $cText
$form.Font                = $fNormal
$form.FormBorderStyle     = "FixedSingle"
$form.MaximizeBox         = $false

$script:isBusy        = $false
$script:lastUploadDir = ""

$form.Add_FormClosing({
    param($s, $e)
    if ($script:isBusy) {
        $e.Cancel = $true
        [System.Windows.Forms.MessageBox]::Show(
            "A build is in progress. Wait for it to finish before closing.",
            "Build in Progress", "OK", "Warning")
    }
})

# ── Input panel ────────────────────────────────────────────────────────────────
$needsProfile = $script:profiles.Count -gt 0
$panelH       = if ($needsProfile) { 156 } else { 124 }

$pTop = New-Object System.Windows.Forms.Panel
$pTop.Location  = New-Object System.Drawing.Point(10, 10)
$pTop.Size      = New-Object System.Drawing.Size(720, $panelH)
$pTop.BackColor = $cPanel
$form.Controls.Add($pTop)

$lblHead = New-Object System.Windows.Forms.Label
$lblHead.Text      = "ARMGDDN Patch Builder"
$lblHead.Location  = New-Object System.Drawing.Point(12, 10)
$lblHead.Size      = New-Object System.Drawing.Size(500, 22)
$lblHead.Font      = $fBold
$lblHead.ForeColor = $cAccent
$pTop.Controls.Add($lblHead)

$rowY = 40

$script:cbProfile = $null
if ($needsProfile) {
    $lblProf = New-Object System.Windows.Forms.Label
    $lblProf.Text      = "Settings profile:"
    $lblProf.Location  = New-Object System.Drawing.Point(12, ($rowY + 3))
    $lblProf.Size      = New-Object System.Drawing.Size(112, 18)
    $lblProf.ForeColor = $cMuted
    $pTop.Controls.Add($lblProf)

    $script:cbProfile = New-Object System.Windows.Forms.ComboBox
    $script:cbProfile.Location      = New-Object System.Drawing.Point(128, $rowY)
    $script:cbProfile.Size          = New-Object System.Drawing.Size(220, 24)
    $script:cbProfile.BackColor     = $cInput
    $script:cbProfile.ForeColor     = $cText
    $script:cbProfile.DropDownStyle = "DropDownList"
    $script:cbProfile.FlatStyle     = "Flat"
    foreach ($p in $script:profiles) { [void]$script:cbProfile.Items.Add($p) }
    $script:cbProfile.SelectedIndex = 0
    $pTop.Controls.Add($script:cbProfile)
    $rowY += 32
}

$lblOld = New-Object System.Windows.Forms.Label
$lblOld.Text      = "Old release:"
$lblOld.Location  = New-Object System.Drawing.Point(12, ($rowY + 4))
$lblOld.Size      = New-Object System.Drawing.Size(84, 18)
$lblOld.ForeColor = $cMuted
$pTop.Controls.Add($lblOld)

$txtOld = New-Object System.Windows.Forms.TextBox
$txtOld.Location    = New-Object System.Drawing.Point(100, $rowY)
$txtOld.Size        = New-Object System.Drawing.Size(608, 24)
$txtOld.BackColor   = $cInput
$txtOld.ForeColor   = $cText
$txtOld.BorderStyle = "FixedSingle"
$pTop.Controls.Add($txtOld)
$rowY += 32

$lblNew = New-Object System.Windows.Forms.Label
$lblNew.Text      = "New release:"
$lblNew.Location  = New-Object System.Drawing.Point(12, ($rowY + 4))
$lblNew.Size      = New-Object System.Drawing.Size(84, 18)
$lblNew.ForeColor = $cMuted
$pTop.Controls.Add($lblNew)

$txtNew = New-Object System.Windows.Forms.TextBox
$txtNew.Location    = New-Object System.Drawing.Point(100, $rowY)
$txtNew.Size        = New-Object System.Drawing.Size(608, 24)
$txtNew.BackColor   = $cInput
$txtNew.ForeColor   = $cText
$txtNew.BorderStyle = "FixedSingle"
$pTop.Controls.Add($txtNew)
$rowY += 28

$lblHint = New-Object System.Windows.Forms.Label
$lblHint.Text      = "Format:  Game Name vBUILD_NUMBER -TAG     e.g.  S.T.A.L.K.E.R. 2 - Heart of Chornobyl v21222340 -ARMGDDN"
$lblHint.Location  = New-Object System.Drawing.Point(12, $rowY)
$lblHint.Size      = New-Object System.Drawing.Size(696, 16)
$lblHint.ForeColor = $cMuted
$lblHint.Font      = $fSmall
$pTop.Controls.Add($lblHint)

# ── Log area ───────────────────────────────────────────────────────────────────
$logTop = 10 + $panelH + 8

$rtbLog = New-Object System.Windows.Forms.RichTextBox
$rtbLog.Location    = New-Object System.Drawing.Point(10, $logTop)
$rtbLog.Size        = New-Object System.Drawing.Size(720, 268)
$rtbLog.BackColor   = $cLog
$rtbLog.ForeColor   = $cText
$rtbLog.Font        = $fMono
$rtbLog.ReadOnly    = $true
$rtbLog.BorderStyle = "None"
$rtbLog.ScrollBars  = "Vertical"
$form.Controls.Add($rtbLog)

# ── Progress bar ───────────────────────────────────────────────────────────────
$pbarTop = $logTop + 268 + 6

$pbar = New-Object System.Windows.Forms.ProgressBar
$pbar.Location = New-Object System.Drawing.Point(10, $pbarTop)
$pbar.Size     = New-Object System.Drawing.Size(720, 12)
$pbar.Style    = "Marquee"
$pbar.MarqueeAnimationSpeed = 0
$form.Controls.Add($pbar)

# ── Buttons ────────────────────────────────────────────────────────────────────
$btnTop = $pbarTop + 12 + 10

function New-Btn([string]$text, [int]$x, [int]$w,
                 [System.Drawing.Color]$bg, [System.Drawing.Color]$fg,
                 [bool]$bold = $false, [bool]$noBorder = $false) {
    $b = New-Object System.Windows.Forms.Button
    $b.Text      = $text
    $b.Location  = New-Object System.Drawing.Point($x, $btnTop)
    $b.Size      = New-Object System.Drawing.Size($w, 36)
    $b.BackColor = $bg
    $b.ForeColor = $fg
    $b.Font      = if ($bold) { $fBold } else { $fNormal }
    $b.FlatStyle = "Flat"
    if ($noBorder) {
        $b.FlatAppearance.BorderSize = 0
    } else {
        $b.FlatAppearance.BorderSize  = 1
        $b.FlatAppearance.BorderColor = $cMuted
    }
    return $b
}

$btnDeleteQuit = New-Btn "Delete && Quit"  10  120 $cDanger $cText  $false $true
$btnRedoSetup  = New-Btn "Redo Setup"     138   88 $cPanel  $cMuted $false $false
$btnPreview    = New-Btn "Preview"        314  102 $cPanel  $cText  $false $false
$btnBuild      = New-Btn "Build Patch"    424  110 $cAccent ([System.Drawing.Color]::Black) $true $true
$btnOpen       = New-Btn "Open Upload"    542   94 $cPanel  $cMuted $false $false
$btnQuit       = New-Btn "Quit"           644   76 $cPanel  $cMuted $false $false

$btnOpen.Enabled = $false

foreach ($b in @($btnDeleteQuit, $btnRedoSetup, $btnPreview, $btnBuild, $btnOpen, $btnQuit)) {
    $form.Controls.Add($b)
}

$form.ClientSize = New-Object System.Drawing.Size(740, ($btnTop + 36 + 12))

$tip = New-Object System.Windows.Forms.ToolTip
$tip.SetToolTip($btnPreview,    "Show parsed values and check game folder paths")
$tip.SetToolTip($btnOpen,       "Open the upload folder (available after a successful build)")
$tip.SetToolTip($btnDeleteQuit, "Delete all working files from the last repack, then quit")
$tip.SetToolTip($btnRedoSetup,  "Re-run setup: configure 7-Zip path and music file")

# ── Log helper ─────────────────────────────────────────────────────────────────
function Log([string]$msg, [System.Drawing.Color]$color) {
    if (-not $color) { $color = $cText }
    $rtbLog.SelectionStart  = $rtbLog.TextLength
    $rtbLog.SelectionLength = 0
    $rtbLog.SelectionColor  = $color
    $rtbLog.AppendText("$msg`n")
    $rtbLog.SelectionColor  = $cText
    $rtbLog.ScrollToCaret()
    [System.Windows.Forms.Application]::DoEvents()
}

# ── Button handlers ────────────────────────────────────────────────────────────
$btnQuit.Add_Click({ $form.Close() })

$btnDeleteQuit.Add_Click({
    if ($script:isBusy) {
        [System.Windows.Forms.MessageBox]::Show("A build is in progress.", "Build in Progress", "OK", "Warning")
        return
    }
    $res = [System.Windows.Forms.MessageBox]::Show(
        "Delete all files in:`n  checker\, Games\old\, Games\new\, ISXPMPatch\, xdata\`n`nAre you sure?",
        "Delete Repack Files", "YesNo", "Warning")
    if ($res -eq "Yes") {
        try { Clear-WorkDirs -keepGames $false } catch { }
        $form.Close()
    }
})

$btnRedoSetup.Add_Click({
    [void](Show-SetupWizard -isRedo $true)
})

$btnPreview.Add_Click({
    if ([string]::IsNullOrWhiteSpace($txtOld.Text) -or [string]::IsNullOrWhiteSpace($txtNew.Text)) {
        [System.Windows.Forms.MessageBox]::Show("Enter both release name strings first.", "Missing Input", "OK", "Warning")
        return
    }

    $old = Parse-ReleaseName $txtOld.Text.Trim()
    $new = Parse-ReleaseName $txtNew.Text.Trim()
    $rtbLog.Clear()

    if (-not $old) { Log "Cannot parse old release name. Expected:  Game Name vBUILD -TAG" $cError; return }
    if (-not $new) { Log "Cannot parse new release name. Expected:  Game Name vBUILD -TAG" $cError; return }

    $gameName      = $old.GameName
    $oldBuild      = $old.Build
    $newBuild      = $new.Build
    $patchFilename = "$gameName v$oldBuild-${newBuild}_Update_Patch"
    $uninstallKey  = "${gameName}_is1"

    Log "Parsed values:" $cAccent
    Log "  Game name   : $gameName"
    Log "  Old build   : $oldBuild"
    Log "  New build   : $newBuild"
    Log "  Tag         : $($old.Tag)"
    Log ""
    Log "Output file:"
    Log "  $patchFilename.exe" $cSuccess
    Log ""
    Log "Registry key:"
    Log "  SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$uninstallKey"
    Log ""

    $oldPath   = Join-Path $GamesOldDir $gameName
    $newPath   = Join-Path $GamesNewDir $gameName
    $oldExists = Test-Path $oldPath
    $newExists = Test-Path $newPath
    Log "Game folders:" $cMuted
    Log "  Old: $oldPath" $(if ($oldExists) { $cSuccess } else { $cWarn })
    if (-not $oldExists) { Log "       ^ NOT FOUND - install old version to Games\old\" $cWarn }
    Log "  New: $newPath" $(if ($newExists) { $cSuccess } else { $cWarn })
    if (-not $newExists) { Log "       ^ NOT FOUND - install new version to Games\new\" $cWarn }

    $sc = Get-SetupConfig
    Log ""
    Log "Packaging:" $cMuted
    if ($sc.SevenZipPath -and (Test-Path $sc.SevenZipPath -EA SilentlyContinue)) {
        Log "  7-Zip  : $($sc.SevenZipPath)" $cSuccess
    } else {
        Log "  7-Zip  : NOT configured -- click Redo Setup" $cWarn
    }
    if ($sc.MusicFile -and (Test-Path $sc.MusicFile -EA SilentlyContinue)) {
        Log "  Music  : $($sc.MusicFile)" $cSuccess
    }

    Log ""
    if ($oldExists -and $newExists) {
        Log "Everything looks good. Click Build Patch when ready." $cSuccess
    } else {
        Log "Install the missing game folders before building." $cWarn
    }
})

$btnOpen.Add_Click({
    $dir = if ($script:lastUploadDir -and (Test-Path $script:lastUploadDir -EA SilentlyContinue)) {
               $script:lastUploadDir
           } elseif (Test-Path $UploadDir -EA SilentlyContinue) {
               $UploadDir
           } else { $null }
    if ($dir) { Start-Process explorer.exe $dir }
    else { [System.Windows.Forms.MessageBox]::Show("Upload folder not found.`nRun a build first.", "Not Found", "OK", "Information") }
})

# ── Build button ───────────────────────────────────────────────────────────────
$btnBuild.Add_Click({
    if ([string]::IsNullOrWhiteSpace($txtOld.Text) -or [string]::IsNullOrWhiteSpace($txtNew.Text)) {
        [System.Windows.Forms.MessageBox]::Show("Enter both release name strings before building.", "Missing Input", "OK", "Warning")
        return
    }

    # Check 7-Zip
    $setupCfg = Get-SetupConfig
    $have7z   = $setupCfg.SevenZipPath -and (Test-Path $setupCfg.SevenZipPath -EA SilentlyContinue)
    if (-not $have7z) {
        $r = [System.Windows.Forms.MessageBox]::Show(
            "7-Zip is not configured or not found at the saved path." + [Environment]::NewLine +
            [Environment]::NewLine +
            "Yes = Open setup now    No = Continue without zipping    Cancel = Abort",
            "7-Zip Not Found", "YesNoCancel", "Warning")
        if ($r -eq "Yes")    { [void](Show-SetupWizard -isRedo $true); return }
        if ($r -eq "Cancel") { return }
    }

    if (-not (Show-BuildPopup)) { return }

    $btnBuild.Enabled   = $false
    $btnPreview.Enabled = $false
    $btnOpen.Enabled    = $false
    $rtbLog.Clear()
    $pbar.MarqueeAnimationSpeed = 30
    $script:isBusy = $true

    try {
        # Parse
        Log "Parsing release names..." $cMuted
        $old = Parse-ReleaseName $txtOld.Text.Trim()
        $new = Parse-ReleaseName $txtNew.Text.Trim()
        if (-not $old) { throw "Cannot parse old release name.`nExpected:  Game Name vBUILD_NUMBER -TAG" }
        if (-not $new) { throw "Cannot parse new release name.`nExpected:  Game Name vBUILD_NUMBER -TAG" }

        $gameName = $old.GameName
        $oldBuild = $old.Build
        $newBuild = $new.Build
        Log "  Game:       $gameName" $cAccent
        Log "  Old build:  $oldBuild"
        Log "  New build:  $newBuild"

        # Merge config
        $cfg = [ordered]@{}
        if ($script:iniData -and $script:iniData.Contains('DEFAULT')) {
            foreach ($k in $script:iniData['DEFAULT'].Keys) { $cfg[$k] = $script:iniData['DEFAULT'][$k] }
        }
        if ($script:cbProfile -and $script:cbProfile.SelectedItem) {
            $pk = $script:cbProfile.SelectedItem.ToString()
            if ($script:iniData.Contains($pk)) {
                foreach ($k in $script:iniData[$pk].Keys) { $cfg[$k] = $script:iniData[$pk][$k] }
            }
        }

        # Detect game folders
        Log "`nDetecting game folders..." $cMuted
        $oldGamePath = Find-GameFolder $GamesOldDir $gameName
        $newGamePath = Find-GameFolder $GamesNewDir $gameName
        if (-not $oldGamePath) { throw "No folder found in Games\old\`nInstall the old version there first." }
        if (-not $newGamePath) { throw "No folder found in Games\new\`nInstall the new version there first." }
        Log "  Old: $oldGamePath" $cSuccess
        Log "  New: $newGamePath" $cSuccess

        # Substitution values
        $patchEngine = if ($cfg.Contains('PATCH_ENGINE'))     { $cfg['PATCH_ENGINE']     } else { "1" }
        $patchExt    = @("xdelta","diff","hdiff")[[int]$patchEngine]
        $genCores    = if ($cfg.Contains('GENERATING_CORES')) { $cfg['GENERATING_CORES'] } else { "23" }
        $appCores    = if ($cfg.Contains('APPLYING_CORES'))   { $cfg['APPLYING_CORES']   } else { "3" }
        $copyright   = if ($cfg.Contains('COPYRIGHT'))        { $cfg['COPYRIGHT']        } else { "" }
        $contact     = if ($cfg.Contains('CONTACT'))          { $cfg['CONTACT']          } else { "" }
        $iconFile    = if ($cfg.Contains('ICON_FILE'))        { $cfg['ICON_FILE']        } else { "icon.ico" }
        $skinRaw     = if ($cfg.Contains('SKIN'))             { $cfg['SKIN']             } else { "" }
        $curBtnRaw   = if ($cfg.Contains('CURSOR_BTN'))       { $cfg['CURSOR_BTN']       } else { "" }
        $curFrmRaw   = if ($cfg.Contains('CURSOR_FRM'))       { $cfg['CURSOR_FRM']       } else { "" }

        # Music: setup.ini wins over game_config.ini
        $sc2     = Get-SetupConfig
        $musicRaw = if ($sc2.MusicFile) { $sc2.MusicFile }
                    elseif ($cfg.Contains('MUSIC_FILE')) { $cfg['MUSIC_FILE'] }
                    else { "" }

        $patchFilename = "$gameName v$oldBuild-${newBuild}_Update_Patch"
        $uninstallKey  = "${gameName}_is1"

        $iconPath = Join-Path $oldGamePath $iconFile
        if (-not (Test-Path $iconPath -EA SilentlyContinue)) { $iconPath = "" }

        function Resolve-Or([string]$raw, [string]$fallback) {
            if (-not $raw) { return $fallback }
            $p2 = Resolve-AssetPath $raw
            if (Test-Path $p2 -EA SilentlyContinue) { return $p2 }
            return $fallback
        }
        $skinPath  = Resolve-Or $skinRaw   "Skin disabled"
        $curBtn    = Resolve-Or $curBtnRaw "Cursor disabled"
        $curFrm    = Resolve-Or $curFrmRaw "Cursor disabled"
        $musicFile = if ($musicRaw -and (Test-Path $musicRaw -EA SilentlyContinue)) { $musicRaw } else { "Music disabled" }

        Log "`nSettings:" $cMuted
        Log "  Output : $patchFilename.exe"
        Log "  Engine : $(@('XDelta','JDiff','HDiff')[[int]$patchEngine]) ($patchExt)"
        Log "  Cores  : gen=$genCores  apply=$appCores"
        if ($iconPath)                       { Log "  Icon   : $iconPath" }
        if ($skinPath  -ne "Skin disabled")  { Log "  Skin   : $skinPath" }
        if ($musicFile -ne "Music disabled") { Log "  Music  : $musicFile" }

        # Write settings.ini
        Log "`nWriting settings.ini..." $cMuted
        if (-not (Test-Path $TemplateIni)) { throw "settings_template.ini not found at:`n$TemplateIni" }

        $tpl = Get-Content $TemplateIni -Raw -Encoding UTF8
        $subs = [ordered]@{
            '%OLD_GAME_PATH%'    = $oldGamePath
            '%NEW_GAME_PATH%'    = $newGamePath
            '%GAME_NAME%'        = $gameName
            '%OLD_BUILD%'        = $oldBuild
            '%NEW_BUILD%'        = $newBuild
            '%OLD_RELEASE_NAME%' = $txtOld.Text.Trim()
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
            '%SILENT_BUILD%'     = "0"
        }
        foreach ($kv in $subs.GetEnumerator()) { $tpl = $tpl.Replace($kv.Key, $kv.Value) }

        $enc   = [System.Text.Encoding]::Unicode
        $bytes = $enc.GetPreamble() + $enc.GetBytes($tpl)
        [System.IO.File]::WriteAllBytes($SettingsIni, $bytes)
        Log "  Done." $cSuccess

        # Launch isxpm.exe
        if (-not (Test-Path $IsxpmExe)) { throw "isxpm.exe not found at:`n$IsxpmExe" }
        New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

        Log "`nOpening isxpm.exe -- click BUILD PATCH, wait for it to finish, then close." $cWarn
        $proc = Start-Process -FilePath $IsxpmExe -WorkingDirectory $Root -PassThru

        while (-not $proc.HasExited) {
            Start-Sleep -Milliseconds 400
            [System.Windows.Forms.Application]::DoEvents()
        }
        Log "  isxpm.exe done (exit $($proc.ExitCode))." $cSuccess

        # Package output
        Log "`nPackaging output..." $cMuted
        $allFiles = @(Get-ChildItem $OutputDir -File -ErrorAction SilentlyContinue |
                      Where-Object { $_.Name -notlike '.git*' })

        if ($allFiles.Count -eq 0) {
            Log "  No output files in $OutputDir -- did the build complete?" $cWarn
        } else {
            $totalBytes = ($allFiles | Measure-Object -Property Length -Sum).Sum
            $totalGB    = $totalBytes / 1GB
            Log "  $($allFiles.Count) file(s), total $([Math]::Round($totalGB, 2)) GB" $cSuccess

            $subFolder = Join-Path $UploadDir $patchFilename
            New-Item -ItemType Directory -Force -Path $subFolder | Out-Null
            $zipBase = Join-Path $subFolder "$patchFilename.zip"

            $sc3 = Get-SetupConfig
            if ($sc3.SevenZipPath -and (Test-Path $sc3.SevenZipPath -EA SilentlyContinue)) {
                $fileArgs = ($allFiles | ForEach-Object { "`"$($_.FullName)`"" }) -join " "
                $splitArg = if ($totalGB -gt 10) { "-v5000m " } else { "" }
                if ($totalGB -gt 10) {
                    Log "  Total >10 GB -- splitting into 5000 MB parts." $cWarn
                }
                $argStr = "a -mx=0 $splitArg`"$zipBase`" $fileArgs"
                Log "  Running 7-Zip..." $cMuted

                $psi7z = New-Object System.Diagnostics.ProcessStartInfo
                $psi7z.FileName               = $sc3.SevenZipPath
                $psi7z.Arguments              = $argStr
                $psi7z.UseShellExecute        = $false
                $psi7z.WindowStyle            = [System.Diagnostics.ProcessWindowStyle]::Hidden
                $p7z = [System.Diagnostics.Process]::Start($psi7z)

                while (-not $p7z.HasExited) {
                    Start-Sleep -Milliseconds 500
                    [System.Windows.Forms.Application]::DoEvents()
                }

                if ($p7z.ExitCode -ne 0) {
                    Log "  7-Zip exited with code $($p7z.ExitCode) -- check $subFolder manually." $cWarn
                } else {
                    $zipFiles   = @(Get-ChildItem $subFolder -File -EA SilentlyContinue)
                    $zipSizeGB  = ($zipFiles | Measure-Object -Property Length -Sum).Sum / 1GB
                    Log "  $($zipFiles.Count) zip file(s) in: $subFolder" $cSuccess
                    Log "  Zip total: $([Math]::Round($zipSizeGB, 2)) GB" $cSuccess
                }
            } else {
                Log "  7-Zip not available -- copying files to upload folder instead." $cWarn
                foreach ($f in $allFiles) {
                    Copy-Item $f.FullName (Join-Path $subFolder $f.Name) -Force
                    Log "  Copied: $($f.Name)"
                }
            }

            $script:lastUploadDir = $subFolder
            $btnOpen.BackColor = $cAccent
            $btnOpen.ForeColor = [System.Drawing.Color]::Black
            $btnOpen.FlatAppearance.BorderSize  = 0
            $btnOpen.FlatAppearance.BorderColor = $cAccent
            $btnOpen.Enabled = $true
        }

        Log "`nAll done!" $cSuccess

    } catch {
        Log "`nERROR: $_" $cError
        [System.Windows.Forms.MessageBox]::Show($_.ToString(), "Build Failed", "OK", "Error")
    } finally {
        $pbar.MarqueeAnimationSpeed = 0
        $btnBuild.Enabled   = $true
        $btnPreview.Enabled = $true
        $script:isBusy      = $false
    }
})

# ── Startup checks (run before form shown) ────────────────────────────────────
$dirtyDirs = @(Get-DirtyDirs)
if ($dirtyDirs.Count -gt 0) {
    $dirtyResult = Show-DirtyDialog $dirtyDirs
    if ($dirtyResult -eq "all")       { try { Clear-WorkDirs -keepGames $false } catch { } }
    elseif ($dirtyResult -eq "keepgames") { try { Clear-WorkDirs -keepGames $true  } catch { } }
}

$initSetup = Get-SetupConfig
if (-not $initSetup.SevenZipPath) {
    [void](Show-SetupWizard -isRedo $false)
}

[void]$form.ShowDialog()
