$ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$COMPRESSOR = Join-Path -Path $ScriptDirectory -ChildPath "COMPRESSOR"
$DATA_FILE_PATH = Join-Path -Path $COMPRESSOR -ChildPath "Conversion_Output\CONVERSION"
$SETUP_PATH = Join-Path -Path $COMPRESSOR -ChildPath "Setup_Files"
$save = Get-Content "$env:TEMP\save.tmp" | ForEach-Object { $_.Trim() } 

Write-Host "The Next Step Is To Merge The DLL And EXE"
Write-Host "Make Sure Everything Is In Order Before Continuing"
Pause

$autorunFile = Join-Path -Path $DATA_FILE_PATH -ChildPath "Autorun.inf"
if (Test-Path $autorunFile -PathType Leaf) {
    Remove-Item -Path $autorunFile -Force
    Write-Host "Autorun.inf File Deleted."
} else {
    Write-Host "No Autorun.inf Found To Be Deleted, Continuing To Next Step"
}

$optionalTriggerFile = Join-Path -Path $PSScriptRoot -ChildPath "vroptional.txt"

if (Test-Path $optionalTriggerFile) {
    Write-Host "VR Optional Trigger File Found. Copying Files To $save ..."
    Copy-Item -Path "$DATA_FILE_PATH\AGRepackInstaller.dll" -Destination $save -Force
    Copy-Item -Path "$DATA_FILE_PATH\Data.bin" -Destination $save -Force
}
Move-Item -Path "$DATA_FILE_PATH\AGRepackInstaller.dll" -Destination $ScriptDirectory -Force

$ScriptContent = Get-Content -Path "$ScriptDirectory\Script.iss" -Encoding UTF8BOM
$ScriptContent[8] = '#define InternalDLL        /* Putting Setup.dll next to the script will compress the DLL file into the Setup.exe file  */'
$ScriptContent | Set-Content -Path "$ScriptDirectory\Script.iss" -Encoding UTF8BOM
Start-Process -FilePath "$ScriptDirectory\Compile_Script.bat" -Wait

$ScriptContent = Get-Content -Path "$ScriptDirectory\Script.iss" -Encoding UTF8BOM
$ScriptContent[8] = ';#define InternalDLL        /* Putting Setup.dll next to the script will compress the DLL file into the Setup.exe file  */'
$ScriptContent | Set-Content -Path "$ScriptDirectory\Script.iss" -Encoding UTF8BOM

Move-Item -Path "$ScriptDirectory\AGRepackInstaller.dll" -Destination "$ScriptDirectory\Setup" -Force 

Move-Item -Path "$SETUP_PATH\AGRepackInstaller.exe" -Destination $DATA_FILE_PATH -Force

Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "All Done, DLL File Merged Into the Setup Installer"
Write-Host ""
Write-Host ""
Write-Host ""
