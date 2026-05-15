@echo off
color 0E
title DiskSpan GUI - Mode Selector
setlocal EnableDelayedExpansion EnableExtensions
:Start
cls
echo.
echo.-------------------------------------------------------------------------
echo Choose a DiskSpan GUI Run Mode:
echo.-------------------------------------------------------------------------
echo.
echo [ ] Run DEVELOPER mode (Auto)
echo.
echo [0] Run DEVELOPER mode (64 bits forced)
echo [1] Run DEVELOPER mode (32 bits forced)
echo.
echo [2] Run STANDARD mode (64 bits forced)
echo [3] Run STANDARD mode (32 bits forced)
echo.
echo [4] Run STANDARD mode (Auto)
echo [5] Run UNPACKER mode
echo [6] Run HELP mode
set INPUT=
echo.
echo.-------------------------------------------------------------------------
echo.
set /P "INPUT=Type: %=%"
cls
if "%INPUT%" EQU "" start "" "DiskSpan_GUI.exe" /config && exit /B
if /I %INPUT% EQU 0 start "" "DiskSpan_GUI.exe" /config /win64 && exit /B 
if /I %INPUT% EQU 1 start "" "DiskSpan_GUI.exe" /config /win32 && exit /B 
if /I %INPUT% EQU 2 start "" "DiskSpan_GUI.exe" /win32 && exit /B 
if /I %INPUT% EQU 3 start "" "DiskSpan_GUI.exe" /win64 && exit /B
if /I %INPUT% EQU 4 start "" "DiskSpan_GUI.exe" && exit /B
if /I %INPUT% EQU 5 start "" "DiskSpan_GUI.exe" /tools && exit /B
if /I %INPUT% EQU 6 start "" "DiskSpan_GUI.exe" /help && exit /B
goto Start










