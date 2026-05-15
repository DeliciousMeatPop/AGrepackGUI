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
echo. 0 = Do nothing, just compress
echo. 
echo. 1 = English
echo. 2 = French
echo. 3 = German
echo. 4 = Italian
echo. 5 = Spanish
echo. 6 = Polish
echo. 7 = Russian
echo. 8 = Arabic
echo.

set /p langchoice=
if "%langchoice%"=="" goto LangChoice
if "%langchoice%"=="0" goto EndLang
if "%langchoice%"=="1" goto English
if "%langchoice%"=="2" goto French
if "%langchoice%"=="3" goto German
if "%langchoice%"=="4" goto Italian
if "%langchoice%"=="5" goto Spanish
if "%langchoice%"=="6" goto Polish
if "%langchoice%"=="7" goto Russian
if "%langchoice%"=="8" goto Arabic


:English
mkdir "!BackupDir!"
move "!GameDir!\*_ARABIC.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_SPANISH.*" "!BackupDir!\"
goto EndLang


:French
mkdir "!BackupDir!"
move "!GameDir!\*_ARABIC.*" "!BackupDir!\"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_SPANISH.*" "!BackupDir!\"
goto EndLang


:German
mkdir "!BackupDir!"
move "!GameDir!\*_ARABIC.*" "!BackupDir!\"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_SPANISH.*" "!BackupDir!\"
goto EndLang


:Italian
mkdir "!BackupDir!"
move "!GameDir!\*_ARABIC.*" "!BackupDir!\"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_SPANISH.*" "!BackupDir!\"
goto EndLang


:Spanish
mkdir "!BackupDir!"
move "!GameDir!\*_ARABIC.*" "!BackupDir!\"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
goto EndLang


:Polish
mkdir "!BackupDir!"
move "!GameDir!\*_ARABIC.*" "!BackupDir!\"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_SPANISH.*" "!BackupDir!\"
goto EndLang


:Russian
mkdir "!BackupDir!"
move "!GameDir!\*_ARABIC.*" "!BackupDir!\"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_SPANISH.*" "!BackupDir!\"
goto EndLang


:Arabic
mkdir "!BackupDir!"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_SPANISH.*" "!BackupDir!\"
goto EndLang


:EndLang
cls
endlocal
exit /B