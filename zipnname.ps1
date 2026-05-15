$iniFilePath = Join-Path -Path $PSScriptRoot -ChildPath "settings.ini"
$iniContents = Get-Content -Path $iniFilePath
$save = Get-Content "$env:TEMP\save.tmp" | ForEach-Object { $_.Trim() }

# Get the original game name
$originalGameName = ($iniContents[1] -split '=', 2)[1].Trim()
# Sanitize the game name by removing special characters
$gameName = $originalGameName -replace "['\?]", ""  # Removes apostrophes and question marks
$gameName = $gameName -replace "\s+", " "          # Normalize spaces
$gameName = $gameName.Trim()                       # Trim any leading/trailing spaces

$appID = ($iniContents[2] -split '=', 2)[1].Trim()
$buildID = ($iniContents[3] -split '=', 2)[1].Trim()
$admin = [int]($iniContents[11] -split '=', 2)[1].Trim()

$optionalTriggerFile = Join-Path -Path $PSScriptRoot -ChildPath "vroptional.txt"

if (Test-Path $optionalTriggerFile) {
    Write-Host "VR Optional Trigger File Found. Adding VR To $gameName ..."
    $gameName += " VR"
}

$directoryPath = Join-Path -Path $PSScriptRoot -ChildPath "COMPRESSOR\Conversion_Output\CONVERSION"

$files = Get-ChildItem -Path $directoryPath
$totalSize = ($files | Measure-Object -Property Length -Sum).Sum

$group = "-ARMGDDN"

if ($admin -eq 1) {
    $group += " + OFME"
}
$7zPath = Join-Path -Path $PSScriptRoot -ChildPath "7z.exe"
$zipFileName = "$gameName v$buildID $group.7z"

# Check for compression choice file
$compressionChoiceFile = Join-Path -Path $PSScriptRoot -ChildPath "choosecompression.txt"
$compressionLevel = 0 # Default to store/no compression

if (Test-Path $compressionChoiceFile) {
    Write-Host ""
    Write-Host "Compression options available:"
    Write-Host "0 - No compression (fastest, largest file size)"
    Write-Host "1-8 - Increasing levels of compression"
    Write-Host "9 - Ultra compression (LZMA2, slowest, smallest file size)"
    Write-Host "10 - Don't compress and exit script"
    Write-Host ""
    
    $compressionChoice = Read-Host "Enter compression level (0-10)"
    
    # Validate input
    if ($compressionChoice -match '^\d+$' -and [int]$compressionChoice -ge 0 -and [int]$compressionChoice -le 10) {
        $compressionLevel = [int]$compressionChoice
        
        if ($compressionLevel -eq 10) {
            Write-Host "Exiting without compression as requested."
            exit
        }
        
        Write-Host "Using compression level: $compressionLevel"
    } else {
        Write-Host "Invalid input. Using default compression level (0 - No compression)."
    }
}

if ($totalSize -gt 10737418240) {
    $command = "& '$7zPath' a -t7z -mx=$compressionLevel -sdel -v5000M '$zipFileName' '$directoryPath\*'"
} else {
    $command = "& '$7zPath' a -t7z -mx=$compressionLevel -sdel '$zipFileName' '$directoryPath\*'"
}

Invoke-Expression $command

$firstPart = Get-ChildItem -Path $PSScriptRoot -Filter "*.001" | Select-Object -First 1
$finalFolderPath = $null

if ($firstPart) {
    $multiZipFolder = Join-Path -Path $PSScriptRoot -ChildPath "$gameName v$buildID $group"
    New-Item -ItemType Directory -Path $multiZipFolder -Force | Out-Null
    $finalFolderPath = $multiZipFolder

    $currentPart = 1
    do {
        $partName = "{0:D3}" -f $currentPart
        $partFile = Get-ChildItem -Path $PSScriptRoot -Filter "*.$partName"
        if ($partFile) {
            Move-Item -Path $partFile.FullName -Destination $multiZipFolder -Force
            $currentPart++
        } else {
            break
        }
    } while ($true)
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host "Multipart Zip Files Moved To Folder: $multiZipFolder"
} else {
    $folderPath = Join-Path -Path $PSScriptRoot -ChildPath "$gameName v$buildID $group"
    New-Item -ItemType Directory -Path $folderPath -Force | Out-Null
    Move-Item -Path "$PSScriptRoot\$zipFileName" -Destination $folderPath -Force
    $finalFolderPath = $folderPath
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host "Zip File Moved To Folder: $folderPath"
}

if (-not [string]::IsNullOrWhiteSpace($appid)) {
    $appidFilePath = Join-Path -Path $finalFolderPath -ChildPath $appid
    New-Item -Path $appidFilePath -ItemType File | Out-Null
}

if (Test-Path $optionalTriggerFile) {
    Write-Host "VR Optional Trigger File Found. Moving Files To $directoryPath ..."
    Move-Item -Path "$save\AGRepackInstaller.dll" -Destination $directoryPath -Force
    Move-Item -Path "$save\Data.bin" -Destination $directoryPath -Force
    Write-Host "Operation Complete! Removing The Trigger File..."
    Remove-Item -Path $optionalTriggerFile -Force
}
Write-Host ""
Write-Host ""
Write-Host ""