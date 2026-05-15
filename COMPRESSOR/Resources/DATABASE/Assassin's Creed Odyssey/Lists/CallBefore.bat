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
echo. 4 = ITALIAN
echo. 5 = PORTUGUESE (BRAZIL)
echo. 6 = SPANISH (SPAIN)
echo. 7 = JAPANESE
echo. 8 = RUSSIAN
echo.

set "SelLang="
set /P "LangChoice="
if "!LangChoice!" EQU "" goto LangChoice
if "!LangChoice!" EQU "0" goto EndLang
if "!LangChoice!" EQU "1" set "SelLang=eng"
if "!LangChoice!" EQU "2" set "SelLang=fre"
if "!LangChoice!" EQU "3" set "SelLang=ger"
if "!LangChoice!" EQU "4" set "SelLang=ita"
if "!LangChoice!" EQU "5" set "SelLang=bra"
if "!LangChoice!" EQU "6" set "SelLang=spa"
if "!LangChoice!" EQU "7" set "SelLang=jap"
if "!LangChoice!" EQU "8" set "SelLang=rus"
if /I "!SelLang!" EQU "" goto LangChoice

set "LangCount=8"
set "Lang.Name[1]=eng"
set "Lang.Name[2]=fre"
set "Lang.Name[3]=ger"
set "Lang.Name[4]=ita"
set "Lang.Name[5]=bra"
set "Lang.Name[6]=spa"
set "Lang.Name[7]=jap"
set "Lang.Name[8]=rus"

mkdir "!BackupDir!\sounddata\PC"
mkdir "!BackupDir!\dlc_3"
mkdir "!BackupDir!\dlc_12"
mkdir "!BackupDir!\dlc_13"
mkdir "!BackupDir!\dlc_14"
mkdir "!BackupDir!\dlc_15"
mkdir "!BackupDir!\dlc_16"
mkdir "!BackupDir!\dlc_18"
mkdir "!BackupDir!\dlc_19"
mkdir "!BackupDir!\dlc_32"
mkdir "!BackupDir!\dlc_33"
mkdir "!BackupDir!\dlc_34"
mkdir "!BackupDir!\dlc_35"
mkdir "!BackupDir!\dlc_43"
mkdir "!BackupDir!\dlc_58"

for /L %%i in (1, 1, !LangCount!) do if /I "!SelLang!" NEQ "!Lang.Name[%%i]!" (
	move /Y "!GameDir!\sounddata\PC\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\sounddata\PC\"
	move /Y "!GameDir!\dlc_3\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_3\"
	move /Y "!GameDir!\dlc_12\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_12\"
	move /Y "!GameDir!\dlc_13\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_13\"
	move /Y "!GameDir!\dlc_14\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_14\"
	move /Y "!GameDir!\dlc_15\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_15\"
	move /Y "!GameDir!\dlc_16\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_16\"
	move /Y "!GameDir!\dlc_18\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_18\"
	move /Y "!GameDir!\dlc_19\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_19\"
	move /Y "!GameDir!\dlc_32\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_32\"
	move /Y "!GameDir!\dlc_33\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_33\"
	move /Y "!GameDir!\dlc_34\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_34\"
	move /Y "!GameDir!\dlc_35\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_35\"
	move /Y "!GameDir!\dlc_43\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_43\"
	move /Y "!GameDir!\dlc_58\sounds_!Lang.Name[%%i]!*.pck" "!BackupDir!\dlc_58\"
)


:EndLang
cls
exit /B