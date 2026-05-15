@echo off
title DiskSpan GUI Compressor
setlocal EnableDelayedExpansion EnableExtensions

cd /D "%~dp0"
if "%~3" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~3") do ( set "GameDir=%%~fa" && set "BackupDir=%%~fa (Backup)") ) else ( endlocal && exit /B )
if "%~7" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~7") do set "MainDir=%%~fa" ) else ( endlocal && exit /B )
for %%F in (robocopy.exe) do if "%%~$path:F" EQU "" ( endlocal && exit /B )
set "DatabaseDir=!MainDir!\Resources\DATABASE"
set "BaseDir=!MainDir!\Resources\Win64"

start "" "!DatabaseDir!\God of War\Lists\Rebuild_example_for_installers (Setup INI).txt"


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
echo. 4 = ITALIAN
echo. 5 = PORTUGUESE
echo. 6 = PORTUGUESE (BRAZIL)
echo. 7 = SPANISH (SPAIN)
echo. 8 = SPANISH (MEXICO)
echo. 9 = POLISH
echo. 10 = RUSSIAN
echo. 11 = JAPANESE
echo. 12 = GREEK
echo.

set /P "LangChoice="
if "!LangChoice!" EQU "" goto LangChoice
if "!LangChoice!" EQU "0" goto EndLang
if "!LangChoice!" EQU "1" goto English
if "!LangChoice!" EQU "2" goto French
if "!LangChoice!" EQU "3" goto German
if "!LangChoice!" EQU "4" goto Italian
if "!LangChoice!" EQU "5" goto Portuguese
if "!LangChoice!" EQU "6" goto PortugueseBrazil
if "!LangChoice!" EQU "7" goto SpanishSpain
if "!LangChoice!" EQU "8" goto SpanishMexico
if "!LangChoice!" EQU "9" goto Polish
if "!LangChoice!" EQU "10" goto Russian
if "!LangChoice!" EQU "11" goto Japanese
if "!LangChoice!" EQU "12" goto Greek


:English
mkdir "!BackupDir!\exec\sound\pc_le"
mkdir "!BackupDir!\exec\wad\pc_le\soundbanks"
move /Y "!GameDir!\exec\sound\pc_le\french(france)" "!BackupDir!\exec\sound\pc_le\french(france)"
move /Y "!GameDir!\exec\sound\pc_le\german" "!BackupDir!\exec\sound\pc_le\german"
move /Y "!GameDir!\exec\sound\pc_le\greek" "!BackupDir!\exec\sound\pc_le\greek"
move /Y "!GameDir!\exec\sound\pc_le\italian" "!BackupDir!\exec\sound\pc_le\italian"
move /Y "!GameDir!\exec\sound\pc_le\japanese" "!BackupDir!\exec\sound\pc_le\japanese"
move /Y "!GameDir!\exec\sound\pc_le\polish" "!BackupDir!\exec\sound\pc_le\polish"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(brazil)" "!BackupDir!\exec\sound\pc_le\portuguese(brazil)"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(portugal)" "!BackupDir!\exec\sound\pc_le\portuguese(portugal)"
move /Y "!GameDir!\exec\sound\pc_le\russian" "!BackupDir!\exec\sound\pc_le\russian"
move /Y "!GameDir!\exec\sound\pc_le\spanish(mexico)" "!BackupDir!\exec\sound\pc_le\spanish(mexico)"
move /Y "!GameDir!\exec\sound\pc_le\spanish(spain)" "!BackupDir!\exec\sound\pc_le\spanish(spain)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\french(france)" "!BackupDir!\exec\wad\pc_le\soundbanks\french(france)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\german" "!BackupDir!\exec\wad\pc_le\soundbanks\german"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\greek" "!BackupDir!\exec\wad\pc_le\soundbanks\greek"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\italian" "!BackupDir!\exec\wad\pc_le\soundbanks\italian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\japanese" "!BackupDir!\exec\wad\pc_le\soundbanks\japanese"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\polish" "!BackupDir!\exec\wad\pc_le\soundbanks\polish"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\russian" "!BackupDir!\exec\wad\pc_le\soundbanks\russian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(mexico)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(mexico)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(spain)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(spain)"
goto EndLang


:French
mkdir "!BackupDir!\exec\sound\pc_le"
mkdir "!BackupDir!\exec\wad\pc_le\soundbanks"
move /Y "!GameDir!\exec\sound\pc_le\english(us)" "!BackupDir!\exec\sound\pc_le\english(us)"
move /Y "!GameDir!\exec\sound\pc_le\german" "!BackupDir!\exec\sound\pc_le\german"
move /Y "!GameDir!\exec\sound\pc_le\greek" "!BackupDir!\exec\sound\pc_le\greek"
move /Y "!GameDir!\exec\sound\pc_le\italian" "!BackupDir!\exec\sound\pc_le\italian"
move /Y "!GameDir!\exec\sound\pc_le\japanese" "!BackupDir!\exec\sound\pc_le\japanese"
move /Y "!GameDir!\exec\sound\pc_le\polish" "!BackupDir!\exec\sound\pc_le\polish"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(brazil)" "!BackupDir!\exec\sound\pc_le\portuguese(brazil)"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(portugal)" "!BackupDir!\exec\sound\pc_le\portuguese(portugal)"
move /Y "!GameDir!\exec\sound\pc_le\russian" "!BackupDir!\exec\sound\pc_le\russian"
move /Y "!GameDir!\exec\sound\pc_le\spanish(mexico)" "!BackupDir!\exec\sound\pc_le\spanish(mexico)"
move /Y "!GameDir!\exec\sound\pc_le\spanish(spain)" "!BackupDir!\exec\sound\pc_le\spanish(spain)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\english(us)" "!BackupDir!\exec\wad\pc_le\soundbanks\english(us)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\german" "!BackupDir!\exec\wad\pc_le\soundbanks\german"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\greek" "!BackupDir!\exec\wad\pc_le\soundbanks\greek"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\italian" "!BackupDir!\exec\wad\pc_le\soundbanks\italian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\japanese" "!BackupDir!\exec\wad\pc_le\soundbanks\japanese"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\polish" "!BackupDir!\exec\wad\pc_le\soundbanks\polish"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\russian" "!BackupDir!\exec\wad\pc_le\soundbanks\russian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(mexico)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(mexico)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(spain)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(spain)"
goto EndLang


:German
mkdir "!BackupDir!\exec\sound\pc_le"
mkdir "!BackupDir!\exec\wad\pc_le\soundbanks"
move /Y "!GameDir!\exec\sound\pc_le\english(us)" "!BackupDir!\exec\sound\pc_le\english(us)"
move /Y "!GameDir!\exec\sound\pc_le\french(france)" "!BackupDir!\exec\sound\pc_le\french(france)"
move /Y "!GameDir!\exec\sound\pc_le\greek" "!BackupDir!\exec\sound\pc_le\greek"
move /Y "!GameDir!\exec\sound\pc_le\italian" "!BackupDir!\exec\sound\pc_le\italian"
move /Y "!GameDir!\exec\sound\pc_le\japanese" "!BackupDir!\exec\sound\pc_le\japanese"
move /Y "!GameDir!\exec\sound\pc_le\polish" "!BackupDir!\exec\sound\pc_le\polish"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(brazil)" "!BackupDir!\exec\sound\pc_le\portuguese(brazil)"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(portugal)" "!BackupDir!\exec\sound\pc_le\portuguese(portugal)"
move /Y "!GameDir!\exec\sound\pc_le\russian" "!BackupDir!\exec\sound\pc_le\russian"
move /Y "!GameDir!\exec\sound\pc_le\spanish(mexico)" "!BackupDir!\exec\sound\pc_le\spanish(mexico)"
move /Y "!GameDir!\exec\sound\pc_le\spanish(spain)" "!BackupDir!\exec\sound\pc_le\spanish(spain)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\english(us)" "!BackupDir!\exec\wad\pc_le\soundbanks\english(us)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\french(france)" "!BackupDir!\exec\wad\pc_le\soundbanks\french(france)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\greek" "!BackupDir!\exec\wad\pc_le\soundbanks\greek"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\italian" "!BackupDir!\exec\wad\pc_le\soundbanks\italian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\japanese" "!BackupDir!\exec\wad\pc_le\soundbanks\japanese"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\polish" "!BackupDir!\exec\wad\pc_le\soundbanks\polish"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\russian" "!BackupDir!\exec\wad\pc_le\soundbanks\russian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(mexico)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(mexico)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(spain)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(spain)"
goto EndLang


:Italian
mkdir "!BackupDir!\exec\sound\pc_le"
mkdir "!BackupDir!\exec\wad\pc_le\soundbanks"
move /Y "!GameDir!\exec\sound\pc_le\english(us)" "!BackupDir!\exec\sound\pc_le\english(us)"
move /Y "!GameDir!\exec\sound\pc_le\french(france)" "!BackupDir!\exec\sound\pc_le\french(france)"
move /Y "!GameDir!\exec\sound\pc_le\german" "!BackupDir!\exec\sound\pc_le\german"
move /Y "!GameDir!\exec\sound\pc_le\greek" "!BackupDir!\exec\sound\pc_le\greek"
move /Y "!GameDir!\exec\sound\pc_le\japanese" "!BackupDir!\exec\sound\pc_le\japanese"
move /Y "!GameDir!\exec\sound\pc_le\polish" "!BackupDir!\exec\sound\pc_le\polish"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(brazil)" "!BackupDir!\exec\sound\pc_le\portuguese(brazil)"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(portugal)" "!BackupDir!\exec\sound\pc_le\portuguese(portugal)"
move /Y "!GameDir!\exec\sound\pc_le\russian" "!BackupDir!\exec\sound\pc_le\russian"
move /Y "!GameDir!\exec\sound\pc_le\spanish(mexico)" "!BackupDir!\exec\sound\pc_le\spanish(mexico)"
move /Y "!GameDir!\exec\sound\pc_le\spanish(spain)" "!BackupDir!\exec\sound\pc_le\spanish(spain)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\english(us)" "!BackupDir!\exec\wad\pc_le\soundbanks\english(us)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\french(france)" "!BackupDir!\exec\wad\pc_le\soundbanks\french(france)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\german" "!BackupDir!\exec\wad\pc_le\soundbanks\german"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\greek" "!BackupDir!\exec\wad\pc_le\soundbanks\greek"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\japanese" "!BackupDir!\exec\wad\pc_le\soundbanks\japanese"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\polish" "!BackupDir!\exec\wad\pc_le\soundbanks\polish"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\russian" "!BackupDir!\exec\wad\pc_le\soundbanks\russian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(mexico)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(mexico)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(spain)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(spain)"
goto EndLang


:Japanese
mkdir "!BackupDir!\exec\sound\pc_le"
mkdir "!BackupDir!\exec\wad\pc_le\soundbanks"
move /Y "!GameDir!\exec\sound\pc_le\english(us)" "!BackupDir!\exec\sound\pc_le\english(us)"
move /Y "!GameDir!\exec\sound\pc_le\french(france)" "!BackupDir!\exec\sound\pc_le\french(france)"
move /Y "!GameDir!\exec\sound\pc_le\german" "!BackupDir!\exec\sound\pc_le\german"
move /Y "!GameDir!\exec\sound\pc_le\greek" "!BackupDir!\exec\sound\pc_le\greek"
move /Y "!GameDir!\exec\sound\pc_le\italian" "!BackupDir!\exec\sound\pc_le\italian"
move /Y "!GameDir!\exec\sound\pc_le\polish" "!BackupDir!\exec\sound\pc_le\polish"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(brazil)" "!BackupDir!\exec\sound\pc_le\portuguese(brazil)"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(portugal)" "!BackupDir!\exec\sound\pc_le\portuguese(portugal)"
move /Y "!GameDir!\exec\sound\pc_le\russian" "!BackupDir!\exec\sound\pc_le\russian"
move /Y "!GameDir!\exec\sound\pc_le\spanish(mexico)" "!BackupDir!\exec\sound\pc_le\spanish(mexico)"
move /Y "!GameDir!\exec\sound\pc_le\spanish(spain)" "!BackupDir!\exec\sound\pc_le\spanish(spain)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\english(us)" "!BackupDir!\exec\wad\pc_le\soundbanks\english(us)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\french(france)" "!BackupDir!\exec\wad\pc_le\soundbanks\french(france)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\german" "!BackupDir!\exec\wad\pc_le\soundbanks\german"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\greek" "!BackupDir!\exec\wad\pc_le\soundbanks\greek"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\italian" "!BackupDir!\exec\wad\pc_le\soundbanks\italian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\polish" "!BackupDir!\exec\wad\pc_le\soundbanks\polish"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\russian" "!BackupDir!\exec\wad\pc_le\soundbanks\russian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(mexico)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(mexico)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(spain)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(spain)"
goto EndLang


:PortugueseBrazil
mkdir "!BackupDir!\exec\sound\pc_le"
mkdir "!BackupDir!\exec\wad\pc_le\soundbanks"
move /Y "!GameDir!\exec\sound\pc_le\english(us)" "!BackupDir!\exec\sound\pc_le\english(us)"
move /Y "!GameDir!\exec\sound\pc_le\french(france)" "!BackupDir!\exec\sound\pc_le\french(france)"
move /Y "!GameDir!\exec\sound\pc_le\german" "!BackupDir!\exec\sound\pc_le\german"
move /Y "!GameDir!\exec\sound\pc_le\greek" "!BackupDir!\exec\sound\pc_le\greek"
move /Y "!GameDir!\exec\sound\pc_le\italian" "!BackupDir!\exec\sound\pc_le\italian"
move /Y "!GameDir!\exec\sound\pc_le\japanese" "!BackupDir!\exec\sound\pc_le\japanese"
move /Y "!GameDir!\exec\sound\pc_le\polish" "!BackupDir!\exec\sound\pc_le\polish"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(portugal)" "!BackupDir!\exec\sound\pc_le\portuguese(portugal)"
move /Y "!GameDir!\exec\sound\pc_le\russian" "!BackupDir!\exec\sound\pc_le\russian"
move /Y "!GameDir!\exec\sound\pc_le\spanish(mexico)" "!BackupDir!\exec\sound\pc_le\spanish(mexico)"
move /Y "!GameDir!\exec\sound\pc_le\spanish(spain)" "!BackupDir!\exec\sound\pc_le\spanish(spain)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\english(us)" "!BackupDir!\exec\wad\pc_le\soundbanks\english(us)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\french(france)" "!BackupDir!\exec\wad\pc_le\soundbanks\french(france)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\german" "!BackupDir!\exec\wad\pc_le\soundbanks\german"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\greek" "!BackupDir!\exec\wad\pc_le\soundbanks\greek"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\italian" "!BackupDir!\exec\wad\pc_le\soundbanks\italian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\japanese" "!BackupDir!\exec\wad\pc_le\soundbanks\japanese"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\polish" "!BackupDir!\exec\wad\pc_le\soundbanks\polish"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\russian" "!BackupDir!\exec\wad\pc_le\soundbanks\russian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(mexico)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(mexico)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(spain)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(spain)"
goto EndLang


:Portuguese
mkdir "!BackupDir!\exec\sound\pc_le"
mkdir "!BackupDir!\exec\wad\pc_le\soundbanks"
move /Y "!GameDir!\exec\sound\pc_le\english(us)" "!BackupDir!\exec\sound\pc_le\english(us)"
move /Y "!GameDir!\exec\sound\pc_le\french(france)" "!BackupDir!\exec\sound\pc_le\french(france)"
move /Y "!GameDir!\exec\sound\pc_le\german" "!BackupDir!\exec\sound\pc_le\german"
move /Y "!GameDir!\exec\sound\pc_le\greek" "!BackupDir!\exec\sound\pc_le\greek"
move /Y "!GameDir!\exec\sound\pc_le\italian" "!BackupDir!\exec\sound\pc_le\italian"
move /Y "!GameDir!\exec\sound\pc_le\japanese" "!BackupDir!\exec\sound\pc_le\japanese"
move /Y "!GameDir!\exec\sound\pc_le\polish" "!BackupDir!\exec\sound\pc_le\polish"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(brazil)" "!BackupDir!\exec\sound\pc_le\portuguese(brazil)"
move /Y "!GameDir!\exec\sound\pc_le\russian" "!BackupDir!\exec\sound\pc_le\russian"
move /Y "!GameDir!\exec\sound\pc_le\spanish(mexico)" "!BackupDir!\exec\sound\pc_le\spanish(mexico)"
move /Y "!GameDir!\exec\sound\pc_le\spanish(spain)" "!BackupDir!\exec\sound\pc_le\spanish(spain)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\english(us)" "!BackupDir!\exec\wad\pc_le\soundbanks\english(us)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\french(france)" "!BackupDir!\exec\wad\pc_le\soundbanks\french(france)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\german" "!BackupDir!\exec\wad\pc_le\soundbanks\german"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\greek" "!BackupDir!\exec\wad\pc_le\soundbanks\greek"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\italian" "!BackupDir!\exec\wad\pc_le\soundbanks\italian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\japanese" "!BackupDir!\exec\wad\pc_le\soundbanks\japanese"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\polish" "!BackupDir!\exec\wad\pc_le\soundbanks\polish"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\russian" "!BackupDir!\exec\wad\pc_le\soundbanks\russian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(mexico)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(mexico)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(spain)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(spain)"
goto EndLang


:SpanishSpain
mkdir "!BackupDir!\exec\sound\pc_le"
mkdir "!BackupDir!\exec\wad\pc_le\soundbanks"
move /Y "!GameDir!\exec\sound\pc_le\english(us)" "!BackupDir!\exec\sound\pc_le\english(us)"
move /Y "!GameDir!\exec\sound\pc_le\french(france)" "!BackupDir!\exec\sound\pc_le\french(france)"
move /Y "!GameDir!\exec\sound\pc_le\german" "!BackupDir!\exec\sound\pc_le\german"
move /Y "!GameDir!\exec\sound\pc_le\greek" "!BackupDir!\exec\sound\pc_le\greek"
move /Y "!GameDir!\exec\sound\pc_le\italian" "!BackupDir!\exec\sound\pc_le\italian"
move /Y "!GameDir!\exec\sound\pc_le\japanese" "!BackupDir!\exec\sound\pc_le\japanese"
move /Y "!GameDir!\exec\sound\pc_le\polish" "!BackupDir!\exec\sound\pc_le\polish"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(brazil)" "!BackupDir!\exec\sound\pc_le\portuguese(brazil)"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(portugal)" "!BackupDir!\exec\sound\pc_le\portuguese(portugal)"
move /Y "!GameDir!\exec\sound\pc_le\russian" "!BackupDir!\exec\sound\pc_le\russian"
move /Y "!GameDir!\exec\sound\pc_le\spanish(mexico)" "!BackupDir!\exec\sound\pc_le\spanish(mexico)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\english(us)" "!BackupDir!\exec\wad\pc_le\soundbanks\english(us)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\french(france)" "!BackupDir!\exec\wad\pc_le\soundbanks\french(france)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\german" "!BackupDir!\exec\wad\pc_le\soundbanks\german"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\greek" "!BackupDir!\exec\wad\pc_le\soundbanks\greek"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\italian" "!BackupDir!\exec\wad\pc_le\soundbanks\italian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\japanese" "!BackupDir!\exec\wad\pc_le\soundbanks\japanese"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\polish" "!BackupDir!\exec\wad\pc_le\soundbanks\polish"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\russian" "!BackupDir!\exec\wad\pc_le\soundbanks\russian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(mexico)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(mexico)"
goto EndLang


:SpanishMexico
mkdir "!BackupDir!\exec\sound\pc_le"
mkdir "!BackupDir!\exec\wad\pc_le\soundbanks"
move /Y "!GameDir!\exec\sound\pc_le\english(us)" "!BackupDir!\exec\sound\pc_le\english(us)"
move /Y "!GameDir!\exec\sound\pc_le\french(france)" "!BackupDir!\exec\sound\pc_le\french(france)"
move /Y "!GameDir!\exec\sound\pc_le\german" "!BackupDir!\exec\sound\pc_le\german"
move /Y "!GameDir!\exec\sound\pc_le\greek" "!BackupDir!\exec\sound\pc_le\greek"
move /Y "!GameDir!\exec\sound\pc_le\italian" "!BackupDir!\exec\sound\pc_le\italian"
move /Y "!GameDir!\exec\sound\pc_le\japanese" "!BackupDir!\exec\sound\pc_le\japanese"
move /Y "!GameDir!\exec\sound\pc_le\polish" "!BackupDir!\exec\sound\pc_le\polish"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(brazil)" "!BackupDir!\exec\sound\pc_le\portuguese(brazil)"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(portugal)" "!BackupDir!\exec\sound\pc_le\portuguese(portugal)"
move /Y "!GameDir!\exec\sound\pc_le\russian" "!BackupDir!\exec\sound\pc_le\russian"
move /Y "!GameDir!\exec\sound\pc_le\spanish(spain)" "!BackupDir!\exec\sound\pc_le\spanish(spain)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\english(us)" "!BackupDir!\exec\wad\pc_le\soundbanks\english(us)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\french(france)" "!BackupDir!\exec\wad\pc_le\soundbanks\french(france)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\german" "!BackupDir!\exec\wad\pc_le\soundbanks\german"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\greek" "!BackupDir!\exec\wad\pc_le\soundbanks\greek"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\italian" "!BackupDir!\exec\wad\pc_le\soundbanks\italian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\japanese" "!BackupDir!\exec\wad\pc_le\soundbanks\japanese"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\polish" "!BackupDir!\exec\wad\pc_le\soundbanks\polish"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\russian" "!BackupDir!\exec\wad\pc_le\soundbanks\russian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(spain)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(spain)"
goto EndLang


:Polish
mkdir "!BackupDir!\exec\sound\pc_le"
mkdir "!BackupDir!\exec\wad\pc_le\soundbanks"
move /Y "!GameDir!\exec\sound\pc_le\english(us)" "!BackupDir!\exec\sound\pc_le\english(us)"
move /Y "!GameDir!\exec\sound\pc_le\french(france)" "!BackupDir!\exec\sound\pc_le\french(france)"
move /Y "!GameDir!\exec\sound\pc_le\german" "!BackupDir!\exec\sound\pc_le\german"
move /Y "!GameDir!\exec\sound\pc_le\greek" "!BackupDir!\exec\sound\pc_le\greek"
move /Y "!GameDir!\exec\sound\pc_le\italian" "!BackupDir!\exec\sound\pc_le\italian"
move /Y "!GameDir!\exec\sound\pc_le\japanese" "!BackupDir!\exec\sound\pc_le\japanese"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(brazil)" "!BackupDir!\exec\sound\pc_le\portuguese(brazil)"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(portugal)" "!BackupDir!\exec\sound\pc_le\portuguese(portugal)"
move /Y "!GameDir!\exec\sound\pc_le\russian" "!BackupDir!\exec\sound\pc_le\russian"
move /Y "!GameDir!\exec\sound\pc_le\spanish(mexico)" "!BackupDir!\exec\sound\pc_le\spanish(mexico)"
move /Y "!GameDir!\exec\sound\pc_le\spanish(spain)" "!BackupDir!\exec\sound\pc_le\spanish(spain)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\english(us)" "!BackupDir!\exec\wad\pc_le\soundbanks\english(us)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\french(france)" "!BackupDir!\exec\wad\pc_le\soundbanks\french(france)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\german" "!BackupDir!\exec\wad\pc_le\soundbanks\german"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\greek" "!BackupDir!\exec\wad\pc_le\soundbanks\greek"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\italian" "!BackupDir!\exec\wad\pc_le\soundbanks\italian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\japanese" "!BackupDir!\exec\wad\pc_le\soundbanks\japanese"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\russian" "!BackupDir!\exec\wad\pc_le\soundbanks\russian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(mexico)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(mexico)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(spain)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(spain)"
goto EndLang


:Russian
mkdir "!BackupDir!\exec\sound\pc_le"
mkdir "!BackupDir!\exec\wad\pc_le\soundbanks"
move /Y "!GameDir!\exec\sound\pc_le\english(us)" "!BackupDir!\exec\sound\pc_le\english(us)"
move /Y "!GameDir!\exec\sound\pc_le\french(france)" "!BackupDir!\exec\sound\pc_le\french(france)"
move /Y "!GameDir!\exec\sound\pc_le\german" "!BackupDir!\exec\sound\pc_le\german"
move /Y "!GameDir!\exec\sound\pc_le\greek" "!BackupDir!\exec\sound\pc_le\greek"
move /Y "!GameDir!\exec\sound\pc_le\italian" "!BackupDir!\exec\sound\pc_le\italian"
move /Y "!GameDir!\exec\sound\pc_le\japanese" "!BackupDir!\exec\sound\pc_le\japanese"
move /Y "!GameDir!\exec\sound\pc_le\polish" "!BackupDir!\exec\sound\pc_le\polish"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(brazil)" "!BackupDir!\exec\sound\pc_le\portuguese(brazil)"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(portugal)" "!BackupDir!\exec\sound\pc_le\portuguese(portugal)"
move /Y "!GameDir!\exec\sound\pc_le\spanish(mexico)" "!BackupDir!\exec\sound\pc_le\spanish(mexico)"
move /Y "!GameDir!\exec\sound\pc_le\spanish(spain)" "!BackupDir!\exec\sound\pc_le\spanish(spain)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\english(us)" "!BackupDir!\exec\wad\pc_le\soundbanks\english(us)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\french(france)" "!BackupDir!\exec\wad\pc_le\soundbanks\french(france)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\german" "!BackupDir!\exec\wad\pc_le\soundbanks\german"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\greek" "!BackupDir!\exec\wad\pc_le\soundbanks\greek"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\italian" "!BackupDir!\exec\wad\pc_le\soundbanks\italian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\japanese" "!BackupDir!\exec\wad\pc_le\soundbanks\japanese"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\polish" "!BackupDir!\exec\wad\pc_le\soundbanks\polish"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(mexico)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(mexico)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(spain)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(spain)"
goto EndLang


:Greek
mkdir "!BackupDir!\exec\sound\pc_le"
mkdir "!BackupDir!\exec\wad\pc_le\soundbanks"
move /Y "!GameDir!\exec\sound\pc_le\english(us)" "!BackupDir!\exec\sound\pc_le\english(us)"
move /Y "!GameDir!\exec\sound\pc_le\french(france)" "!BackupDir!\exec\sound\pc_le\french(france)"
move /Y "!GameDir!\exec\sound\pc_le\german" "!BackupDir!\exec\sound\pc_le\german"
move /Y "!GameDir!\exec\sound\pc_le\italian" "!BackupDir!\exec\sound\pc_le\italian"
move /Y "!GameDir!\exec\sound\pc_le\japanese" "!BackupDir!\exec\sound\pc_le\japanese"
move /Y "!GameDir!\exec\sound\pc_le\polish" "!BackupDir!\exec\sound\pc_le\polish"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(brazil)" "!BackupDir!\exec\sound\pc_le\portuguese(brazil)"
move /Y "!GameDir!\exec\sound\pc_le\portuguese(portugal)" "!BackupDir!\exec\sound\pc_le\portuguese(portugal)"
move /Y "!GameDir!\exec\sound\pc_le\russian" "!BackupDir!\exec\sound\pc_le\russian"
move /Y "!GameDir!\exec\sound\pc_le\spanish(mexico)" "!BackupDir!\exec\sound\pc_le\spanish(mexico)"
move /Y "!GameDir!\exec\sound\pc_le\spanish(spain)" "!BackupDir!\exec\sound\pc_le\spanish(spain)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\english(us)" "!BackupDir!\exec\wad\pc_le\soundbanks\english(us)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\french(france)" "!BackupDir!\exec\wad\pc_le\soundbanks\french(france)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\german" "!BackupDir!\exec\wad\pc_le\soundbanks\german"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\italian" "!BackupDir!\exec\wad\pc_le\soundbanks\italian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\japanese" "!BackupDir!\exec\wad\pc_le\soundbanks\japanese"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\polish" "!BackupDir!\exec\wad\pc_le\soundbanks\polish"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(brazil)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)" "!BackupDir!\exec\wad\pc_le\soundbanks\portuguese(portugal)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\russian" "!BackupDir!\exec\wad\pc_le\soundbanks\russian"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(mexico)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(mexico)"
move /Y "!GameDir!\exec\wad\pc_le\soundbanks\spanish(spain)" "!BackupDir!\exec\wad\pc_le\soundbanks\spanish(spain)"
goto EndLang


:EndLang
cls
echo.
echo.----------------------------------------------------------------------
echo. The following process uses WEMTool by Masquerade
echo. https://fileforums.com/showthread.php?t=104859
echo.
echo. Please note that some AV's may detect WEMTool.exe as a virus,
echo. therefore it is recommended to turn off your AV during this process.
echo. 
echo. Backup files will be made here:
echo. !BackupDir!\
echo.----------------------------------------------------------------------
echo. Do you want to process sound files? [Y/N]
echo.----------------------------------------------------------------------
echo.
choice /C NY /N
if not errorlevel 2 goto End


:WemProc
robocopy "!GameDir!" "!BackupDir!" "*.wem" /S /NDL /NJH /NJS
copy /Y "!BaseDir!\TOOLS\WemTool\WemTool.exe" "!GameDir!\WemTool.exe" >nul

cd /D "!GameDir!"
"!GameDir!\WemTool.exe" -e


:End
endlocal
exit /B