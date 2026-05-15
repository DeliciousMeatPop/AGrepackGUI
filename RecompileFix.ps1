$ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$COMPRESSOR = Join-Path -Path $ScriptDirectory -ChildPath "COMPRESSOR"
$DATA_FILE_PATH = Join-Path -Path $COMPRESSOR -ChildPath "Conversion_Output\CONVERSION"
$SETUP_PATH = Join-Path -Path $COMPRESSOR -ChildPath "Setup_Files"
$SETUP =  Join-Path -Path $ScriptDirectory -ChildPath "Setup"
$destinationDllPath = Join-Path $DATA_FILE_PATH "AGRepackInstaller.dll"

Write-Host "Before you continue, make sure all the slideshow pics are in the backgrounds"
Write-Host "folder, and all the game art, the data.bin, the completed settings.ini"
Write-Host "and the old dll are in the setup folder. Then hit enter"
Pause
Move-Item -Path "$Setup\data.bin" -Destination "$DATA_FILE_PATH" -Force
Move-Item -Path "$Setup\settings.ini" -Destination "$ScriptDirectory" -Force
Move-Item -Path "$Setup\AGRepackInstaller.dll" -Destination "$DATA_FILE_PATH" -Force
Start-Process -FilePath "$ScriptDirectory\Compile_Script.bat" -Wait
Move-Item -Path "$SETUP_PATH\AGRepackInstaller.exe" -Destination "$DATA_FILE_PATH" -Force
Clear-Host
Write-Host ""
Write-Host ""
& "$ScriptDirectory\internaldll.ps1"
Write-Host ""
Write-Host ""
Clear-Host
Write-Host ""
Write-Host ""
& "$ScriptDirectory\zipNname.ps1"
Write-Host ""
Write-Host ""
Clear-Host
Write-Host ""
Write-Host ""
& "$ScriptDirectory\oldrepackshit.ps1"
Write-Host ""
Write-Host ""
Clear-Host
Write-Host ""
Write-Host ""
Write-Host "Repack DONE! Everything Zipped And Moved! Ready To Repack ANOTHER Game!"
Write-Host ""
Write-Host ""
Pause