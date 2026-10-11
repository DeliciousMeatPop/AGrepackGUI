@echo off
rem Launches the XDelta patch maker.
rem XDelta must sit NEXT TO this toolkit folder (..\XDelta), not inside it - long
rem paths break the patch tools. If it isn't there, show a popup until it is.
setlocal
for %%I in ("%~dp0..\XDelta") do set "XD=%%~fI"

:check
if exist "%XD%\make_patch_gui.ps1" goto run
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.Form; $f.TopMost = $true; $nl = [char]10; $m = 'The XDelta folder was NOT FOUND where it needs to be:' + $nl + $nl + $env:XD + $nl + $nl + 'Move the XDelta folder so it sits NEXT TO the toolkit folder (not inside it - long paths break the patch tools), then click Retry.'; if ([System.Windows.Forms.MessageBox]::Show($f, $m, 'XDelta NOT FOUND', 'RetryCancel', 'Error') -eq 'Retry') { exit 0 } else { exit 1 }"
if errorlevel 1 exit /b 1
goto check

:run
pushd "%XD%"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%XD%\make_patch_gui.ps1" -ToolkitDir "%~dp0." %*
popd
