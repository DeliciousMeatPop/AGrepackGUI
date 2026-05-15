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
echo. 5 = SPANISH
echo. 6 = SPANISH (LATAM)
echo. 7 = PORTUGUESE
echo. 8 = PORTUGUESE (BRAZIL)
echo. 9 = RUSSIAN
echo. 10 = POLISH
echo. 11 = ARABIC
echo.

set "SelLang="
set /P "LangChoice="
if "!LangChoice!" EQU "" goto LangChoice
if "!LangChoice!" EQU "0" goto EndLang
if "!LangChoice!" EQU "1" set "SelLang=English"
if "!LangChoice!" EQU "2" set "SelLang=French"
if "!LangChoice!" EQU "3" set "SelLang=German"
if "!LangChoice!" EQU "4" set "SelLang=Italian"
if "!LangChoice!" EQU "5" set "SelLang=Spanish"
if "!LangChoice!" EQU "6" set "SelLang=LATAMSP"
if "!LangChoice!" EQU "7" set "SelLang=Portugese"
if "!LangChoice!" EQU "8" set "SelLang=LATAMPOR"
if "!LangChoice!" EQU "9" set "SelLang=Russian"
if "!LangChoice!" EQU "10" set "SelLang=Polish"
if "!LangChoice!" EQU "11" set "SelLang=Arabic"
if /I "!SelLang!" EQU "" goto LangChoice

set "LangCount=11"
set "Lang.Name[1]=English"
set "Lang.Name[2]=French"
set "Lang.Name[3]=German"
set "Lang.Name[4]=Italian"
set "Lang.Name[5]=Spanish"
set "Lang.Name[6]=LATAMSP"
set "Lang.Name[7]=Portugese"
set "Lang.Name[8]=LATAMPOR"
set "Lang.Name[9]=Russian"
set "Lang.Name[10]=Polish"
set "Lang.Name[11]=Arabic"

mkdir "!BackupDir!\Packed_DX12"

for /L %%i in (1, 1, !LangCount!) do if /I "!SelLang!" NEQ "!Lang.Name[%%i]!" (
	move /Y "!GameDir!\Packed_DX12\*!Lang.Name[%%i]!*" "!BackupDir!\Packed_DX12\"
)


:EndLang
exit /B