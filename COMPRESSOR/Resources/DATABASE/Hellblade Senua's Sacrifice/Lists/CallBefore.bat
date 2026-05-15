@echo off
title DiskSpan GUI Compressor
setlocal EnableDelayedExpansion EnableExtensions

cd /D "%~dp0"
if "%~3" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~3") do ( set "GameDir=%%~fa" && set "BackupDir=%%~fa (Backup)") ) else ( endlocal && exit /B )

if not exist "!GameDir!\HellbladeGame\Content\Movies\HB_DocumentaryRoughCut.bik" goto EndLang


:BenchmarkFile
cls
echo.
echo.----------------------------------------------------------------------
echo. Do you want to keep the game documentary video file? [Y/N]
echo. The game works fine without this file.
echo.
echo. Backup files will be made here:
echo. !BackupDir!\
echo.----------------------------------------------------------------------
choice /C NY /N
if errorlevel 2 (
	goto EndLang
) else (
	mkdir "!BackupDir!\HellbladeGame\Content\Movies"
	move /Y "!GameDir!\HellbladeGame\Content\Movies\HB_DocumentaryRoughCut.bik" "!BackupDir!\HellbladeGame\Content\Movies\"
	TIMEOUT 1
)


:EndLang
endlocal
exit /B