@echo off
title DiskSpan GUI Compressor
setlocal EnableDelayedExpansion EnableExtensions

cd /D "%~dp0"
if "%~3" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~3") do ( set "GameDir=%%~fa" && set "BackupDir=%%~fa (Backup)") ) else ( endlocal && exit /B )


:LangChoice
cls
echo.
echo.----------------------------------------------------------------------
echo. Which language you did want to use?
echo.
echo. Backup files will be made here:
echo. !BackupDir!\
echo.----------------------------------------------------------------------
echo. 0 = Keep everything
echo.
echo. 1 = ENGLISH
echo. 2 = FRENCH
echo. 3 = GERMAN
echo. 4 = JAPANESE
echo. 5 = PORTUGUESE (BRAZIL)
echo. 6 = SPANISH (SPAIN)
echo. 7 = SPANISH (MEXICO)
echo. 8 = RUSSIAN
echo. 9 = POLISH
echo. 10 = CHINESE (SIMPLIFIED)
echo.

set "SetLang="
set /P "LangChoice="
if "!LangChoice!" EQU "" goto LangChoice
if "!LangChoice!" EQU "0" goto EndLang
if "!LangChoice!" EQU "1" set "SetLang=en"
if "!LangChoice!" EQU "2" set "SetLang=fr"
if "!LangChoice!" EQU "3" set "SetLang=de"
if "!LangChoice!" EQU "4" set "SetLang=jp"
if "!LangChoice!" EQU "5" set "SetLang=br"
if "!LangChoice!" EQU "6" set "SetLang=es"
if "!LangChoice!" EQU "7" set "SetLang=el"
if "!LangChoice!" EQU "8" set "SetLang=ru"
if "!LangChoice!" EQU "9" set "SetLang=pl"
if "!LangChoice!" EQU "10" set "SetLang=cn"
if /I "!SetLang!" EQU "" goto LangChoice

set "LangCount=10"
set "Lang.Name[1]=en"
set "Lang.Name[2]=fr"
set "Lang.Name[3]=de"
set "Lang.Name[4]=jp"
set "Lang.Name[5]=br"
set "Lang.Name[6]=es"
set "Lang.Name[7]=el"
set "Lang.Name[8]=ru"
set "Lang.Name[9]=pl"
set "Lang.Name[10]=cn"

mkdir "!BackupDir!\ph\work\data_platform\pc\assets"
mkdir "!BackupDir!\ph\work\data_lang"

for /L %%i in (1, 1, !LangCount!) do if /I "!SetLang!" NEQ "!Lang.Name[%%i]!" (
	move /Y "!GameDir!\ph\work\data_lang\speech_!Lang.Name[%%i]!" "!BackupDir!\ph\work\data_lang\speech_!Lang.Name[%%i]!"
	move /Y "!GameDir!\ph\work\data_platform\pc\assets\lang_speech_!Lang.Name[%%i]!_pc.rpack" "!BackupDir!\ph\work\data_platform\pc\assets\"
)


:EndLang
cls
exit /B