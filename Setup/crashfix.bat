@echo off
setlocal EnableExtensions DisableDelayedExpansion
title ARMGDDN Steam Overlay Config Toggle

rem The folder holding this file is the repack release folder:
rem Game Name vBUILD -ARMGDDN
set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%.") do set "RELEASE_DIR=%%~fI"

rem The release folder name is used only to find the installed copy in the registry.
rem The PowerShell call only extracts the game title. It does not edit anything.
set "ARM_RELEASE_DIR=%RELEASE_DIR%"
set "GAME_NAME="
for /f "usebackq delims=" %%A in (`powershell.exe -NoProfile -Command "$name = Split-Path -Leaf $env:ARM_RELEASE_DIR; if ($name -match '^(?<game>.+)\s+v\S+\s+-ARMGDDN$') { $matches['game'] }"`) do if not defined GAME_NAME set "GAME_NAME=%%A"

if not defined GAME_NAME (
    echo.
    echo This repack folder does not contain a usable game name.
    echo Expected a folder name like: Game Name vBUILD -ARMGDDN
    echo.
    call :AskForInstallLocation
    if errorlevel 1 (
        pause
        exit /b 1
    )

    goto :HaveInstallLocation
)

echo.
echo Game found: %GAME_NAME%

rem First try spaces, then try the Inno Setup key name with spaces changed to underscores.
set "UNINSTALL_ROOT=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
set "INSTALL_LOCATION="
set "GAME_NAME_WITH_UNDERSCORES=%GAME_NAME: =_%"
call :ReadInstallLocation "%GAME_NAME%_is1"

if not defined INSTALL_LOCATION (
    call :ReadInstallLocation "%GAME_NAME_WITH_UNDERSCORES%_is1"
)

if not defined INSTALL_LOCATION (
    echo.
    echo Could not find either uninstall registry entry:
    echo   %GAME_NAME%_is1
    echo   %GAME_NAME_WITH_UNDERSCORES%_is1
    echo.
    echo The installer may have used a different registry name.
    echo.
    call :AskForInstallLocation
    if errorlevel 1 (
        pause
        exit /b 1
    )
)

:HaveInstallLocation
echo.
echo Installed copy: %INSTALL_LOCATION%

call :FindSteamSettings
if errorlevel 1 (
    echo.
    echo Could not find a steam_settings folder containing configs.overlay.ini or configs.overlay.bak inside:
    echo   %INSTALL_LOCATION%
    pause
    exit /b 1
)

echo steam_settings found: %INSTALLED_SETTINGS%

set "CONFIG_INI=%INSTALLED_SETTINGS%\configs.overlay.ini"
set "CONFIG_BAK=%INSTALLED_SETTINGS%\configs.overlay.bak"

if exist "%CONFIG_INI%" if exist "%CONFIG_BAK%" (
    echo.
    echo Both configs.overlay.ini and configs.overlay.bak exist.
    echo Nothing was changed so neither file gets overwritten.
    pause
    exit /b 1
)

if exist "%CONFIG_INI%" (
    ren "%CONFIG_INI%" "configs.overlay.bak"
    if errorlevel 1 (
        echo.
        echo Could not rename the file. Try right-clicking this batch file and choosing Run as administrator.
        pause
        exit /b 1
    )
    echo.
    echo Removing Steam overlay: configs.overlay.ini was renamed to configs.overlay.bak
	echo This should fix your game crash issue. Please try running the game again.
	echo Run this script again to reverse.
    pause
    exit /b 0
)

if exist "%CONFIG_BAK%" (
    ren "%CONFIG_BAK%" "configs.overlay.ini"
    if errorlevel 1 (
        echo.
        echo Could not rename the file. Try right-clicking this batch file and choosing Run as administrator.
        pause
        exit /b 1
    )
    echo.
    echo Fixing Steam overlay: configs.overlay.bak was renamed to configs.overlay.ini
	echo The overlay will now work again if you press shift and tab at the same time.
	echo If your game crashes run this again to reverse and turn the overlay off.
    pause
    exit /b 0
)

echo.
echo Neither configs.overlay.ini nor configs.overlay.bak was found in:
echo   %INSTALLED_SETTINGS%
pause
exit /b 1

:AskForInstallLocation
set "INSTALL_LOCATION="
set /p "INSTALL_LOCATION=Paste the installed game folder path, then press Enter: "
set "INSTALL_LOCATION=%INSTALL_LOCATION:"=%"

if not defined INSTALL_LOCATION (
    echo.
    echo No folder path was entered. Nothing was changed.
    exit /b 1
)

for %%I in ("%INSTALL_LOCATION%") do set "INSTALL_LOCATION=%%~fI"
if not exist "%INSTALL_LOCATION%\" (
    echo.
    echo That folder does not exist:
    echo   %INSTALL_LOCATION%
    exit /b 1
)

exit /b 0

:FindSteamSettings
set "INSTALLED_SETTINGS="
set "ARM_INSTALL_LOCATION=%INSTALL_LOCATION%"

rem Only accept a real steam_settings folder that contains the overlay config.
rem This prevents a false match elsewhere in the installed game folder.
for /f "usebackq delims=" %%D in (`powershell.exe -NoProfile -Command "$root = $env:ARM_INSTALL_LOCATION; $target = $null; $folders = Get-ChildItem -LiteralPath $root -Directory -Recurse -Force -ErrorAction SilentlyContinue; foreach ($folder in $folders) { if ($folder.Name -ieq 'steam_settings') { $ini = Join-Path $folder.FullName 'configs.overlay.ini'; $bak = Join-Path $folder.FullName 'configs.overlay.bak'; if ((Test-Path -LiteralPath $ini -PathType Leaf) -or (Test-Path -LiteralPath $bak -PathType Leaf)) { $target = $folder.FullName; break } } }; if ($null -ne $target) { $target }"`) do if not defined INSTALLED_SETTINGS set "INSTALLED_SETTINGS=%%D"

if not defined INSTALLED_SETTINGS exit /b 1
if not exist "%INSTALLED_SETTINGS%\configs.overlay.ini" if not exist "%INSTALLED_SETTINGS%\configs.overlay.bak" (
    set "INSTALLED_SETTINGS="
    exit /b 1
)
exit /b 0

:ReadInstallLocation
for /f "tokens=1,2,*" %%A in ('reg.exe query "%UNINSTALL_ROOT%\%~1" /v InstallLocation 2^>nul ^| findstr /r /c:"^[ ]*InstallLocation"') do set "INSTALL_LOCATION=%%C"
exit /b
