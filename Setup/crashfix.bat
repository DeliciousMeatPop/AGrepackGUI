@echo off
setlocal
title Crash Fix

:: %~dp0 = the folder this .bat lives in (the repack folder). Fully relative,
:: so it works no matter where the repack is copied to.
set "GAMEDIR=%~dp0"

echo.
echo ============================================================
echo   Crash Fix
echo ============================================================
echo.
echo   Repack folder:
echo     %GAMEDIR%
echo.
echo   If the game crashes on launch, the usual causes are:
echo.
echo     1. Antivirus quarantined a file.
echo        Add this folder to your AV / Windows Defender
echo        exclusions, then reinstall the repack.
echo.
echo     2. Missing prerequisites (Visual C++, DirectX, .NET).
echo        Install them and try again.
echo.
echo   Add your game-specific fix steps to this file as needed.
echo.
pause
endlocal
