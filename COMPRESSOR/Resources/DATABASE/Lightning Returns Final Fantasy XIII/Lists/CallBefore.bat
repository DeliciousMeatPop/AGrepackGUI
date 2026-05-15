@echo off
title DiskSpan GUI Compressor
setlocal EnableDelayedExpansion EnableExtensions

cd /D "%~dp0"
if "%~3" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~3") do ( set "GameDir=%%~fa" && set "BackupDir=%%~fa (Backup)") ) else ( endlocal && exit /B )

:LangChoice
cls
echo.
echo.----------------------------------------------------------------------
echo. Which video language you did want to use?
echo.
echo. Backup files will be made here:
echo. !BackupDir!\
echo.----------------------------------------------------------------------
echo. 0 = Keep everything
echo. 
echo. 1 = ENGLISH
echo. 2 = JAPANESE
echo.

set /P "LangChoice="
if "!LangChoice!" EQU "" goto LangChoice
if "!LangChoice!" EQU "0" goto EndLang
if "!LangChoice!" EQU "1" goto English
if "!LangChoice!" EQU "2" goto Japanese

::*v = japanese
::*a = english


:English
mkdir "!BackupDir!\Lightning Returns Final Fantasy XIII\weiss_data\movie\"
mkdir "!BackupDir!\Lightning Returns Final Fantasy XIII\weiss_data\sys\"
mkdir "!BackupDir!\Lightning Returns Final Fantasy XIII\weiss_data\zone\"

move /Y "!GameDir!\weiss_data\movie\*v.win32.bin" "!BackupDir!\Lightning Returns Final Fantasy XIII\weiss_data\movie\"
move /Y "!GameDir!\weiss_data\sys\*v.win32.bin" "!BackupDir!\Lightning Returns Final Fantasy XIII\weiss_data\sys\"
move /Y "!GameDir!\weiss_data\zone\*v_img*.win32.bin" "!BackupDir!\Lightning Returns Final Fantasy XIII\weiss_data\zone\"
goto EndLang


:Japanese
mkdir "!BackupDir!\FINAL FANTASY XIII-2\alba_data\movie\"
mkdir "!BackupDir!\FINAL FANTASY XIII-2\alba_data\sys\"
mkdir "!BackupDir!\FINAL FANTASY XIII-2\alba_data\udp\"
mkdir "!BackupDir!\FINAL FANTASY XIII-2\alba_data\zone\"

move /Y "!GameDir!\weiss_data\movie\*a.win32.bin" "!BackupDir!\Lightning Returns Final Fantasy XIII\weiss_data\movie\"
move /Y "!GameDir!\weiss_data\sys\*a.win32.bin" "!BackupDir!\Lightning Returns Final Fantasy XIII\weiss_data\sys\"
move /Y "!GameDir!\weiss_data\zone\*a_img*.win32.bin" "!BackupDir!\Lightning Returns Final Fantasy XIII\weiss_data\zone\"
goto EndLang


:EndLang
endlocal
exit /b