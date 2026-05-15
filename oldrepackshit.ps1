$iniFilePath = Join-Path -Path $PSScriptRoot -ChildPath "settings.ini"

$iniContents = Get-Content -Path $iniFilePath

$gameName = ($iniContents[1] -split '=', 2)[1].Trim() -replace '[^\w\-\s]', '' -replace '\s+', ' '

$newGameName = $gameName -replace '\s+', '' -replace '\W', '' 
$newGameName = $newGameName.ToLower()  

$directoryPath = Join-Path -Path $PSScriptRoot -ChildPath "Setup"

$backgroundDirectory = Join-Path -Path $directoryPath -ChildPath "Background"
if (!(Test-Path -Path $backgroundDirectory)) {
    New-Item -Path $backgroundDirectory -ItemType Directory
}

$filesToMove = "Welcome.bmp", "Finish.bmp", "icon.ico", "splash.png", "logo.png", "banner.bmp", "library_hero.jpg", "logo_2x.png", "library_hero_2x.jpg", "AGRepackInstaller.dll"
foreach ($file in $filesToMove) {
    $sourceFile = Join-Path -Path $directoryPath -ChildPath $file
    $destinationFile = Join-Path -Path $backgroundDirectory -ChildPath $file
    Move-Item -Path $sourceFile -Destination $destinationFile -Force
}

$destinationIniFile = Join-Path -Path $backgroundDirectory -ChildPath "settings.ini"
Move-Item -Path $iniFilePath -Destination $destinationIniFile -Force

$7zPath = Join-Path -Path $PSScriptRoot -ChildPath "7z.exe"

$command = "& '$7zPath' a -t7z -mx=9 -sdel '$newGameName' '$backgroundDirectory\*' -xr!*\* -xr!_OldGameArt -xr!_OldGameArt\*"
Invoke-Expression -Command $command

$oldGameArtDirectory = Join-Path -Path $backgroundDirectory -ChildPath "_OldGameArt"
if (!(Test-Path -Path $oldGameArtDirectory)) {
    New-Item -Path $oldGameArtDirectory -ItemType Directory
}

$7zFile = Join-Path -Path $PSScriptRoot -ChildPath "$newGameName.7z"
$destination7zFile = Join-Path -Path $oldGameArtDirectory -ChildPath (Split-Path $7zFile -Leaf)
Move-Item -Path $7zFile -Destination $destination7zFile -Force
$setupIniFile = Join-Path -Path $directoryPath -ChildPath "settings.ini"
Remove-Item -Path $setupIniFile -Force
