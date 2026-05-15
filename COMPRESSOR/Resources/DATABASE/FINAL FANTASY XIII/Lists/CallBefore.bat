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

::*c = japanese (jp movie -> no lang code)
::*_us, *u = english


:English
mkdir "!BackupDir!\FINAL FANTASY XIII\white_data\movie"
mkdir "!BackupDir!\FINAL FANTASY XIII\white_data\sys"
mkdir "!BackupDir!\FINAL FANTASY XIII\white_data\zone"

move /Y "!GameDir!\white_data\movie\z000.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z002.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z003.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z004.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z006.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z008.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z010.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z015.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z016.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z017.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z018.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z019.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z020.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z021.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z022.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z024.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z027.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\movie\z029.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"

move /Y "!GameDir!\white_data\sys\*c.win32.bin" "!BackupDir!\FINAL FANTASY XIII\white_data\sys\"
move /Y "!GameDir!\white_data\sys\*c.win32.sdat" "!BackupDir!\FINAL FANTASY XIII\white_data\sys\"
move /Y "!GameDir!\white_data\zone\*c_img*.win32.bin" "!BackupDir!\FINAL FANTASY XIII\white_data\zone\"
goto EndLang


:Japanese
mkdir "!BackupDir!\FINAL FANTASY XIII\white_data\movie"
mkdir "!BackupDir!\FINAL FANTASY XIII\white_data\sys"
mkdir "!BackupDir!\FINAL FANTASY XIII\white_data\zone"

move /Y "!GameDir!\white_data\movie\*_us.win32.wmp" "!BackupDir!\FINAL FANTASY XIII\white_data\movie\"
move /Y "!GameDir!\white_data\sys\*u.win32.bin" "!BackupDir!\FINAL FANTASY XIII\white_data\sys\"
move /Y "!GameDir!\white_data\sys\*u.win32.sdat" "!BackupDir!\FINAL FANTASY XIII\white_data\sys\"
move /Y "!GameDir!\white_data\zone\*u_img*.win32.bin" "!BackupDir!\FINAL FANTASY XIII\white_data\zone\"
goto EndLang


:EndLang
endlocal
exit /b