@echo off
setlocal EnableExtensions DisableDelayedExpansion
title Virtual Desktop Launcher - Find Steam APPID.exe

set "VD_STREAMER=C:\Program Files\Virtual Desktop Streamer\VirtualDesktop.Streamer.exe"
set "GAME_EXE=%~dp0Find Steam APPID.exe"
set "GAME_NAME=Find Steam APPID.exe"
set "GAME_ARGS=-vr -bitches"
set "DISPLAY_ARGS=%GAME_ARGS%"
if not defined DISPLAY_ARGS set "DISPLAY_ARGS=no arguments"

if not exist "%VD_STREAMER%" (
    echo ERROR: Virtual Desktop Streamer was not found at:
    echo "%VD_STREAMER%"
    echo.
    echo Open VD.bat in Notepad and correct the VD_STREAMER path.
    echo.
    pause
    exit /b 1
)

if not exist "%GAME_EXE%" (
    echo ERROR: The game executable was not found at:
    echo "%GAME_EXE%"
    echo.
    echo Keep VD.bat in the same folder as Find Steam APPID.exe.
    echo.
    pause
    exit /b 1
)

cls
echo Now launching %GAME_NAME% with %DISPLAY_ARGS%. Please wait
echo.
echo 3
timeout /t 1 /nobreak >nul
echo 2
timeout /t 1 /nobreak >nul
echo 1
timeout /t 1 /nobreak >nul
echo.
pushd "%~dp0"
"%VD_STREAMER%" "%GAME_EXE%" %GAME_ARGS%
set "LAUNCH_EXIT_CODE=%ERRORLEVEL%"
popd
exit /b %LAUNCH_EXIT_CODE%
