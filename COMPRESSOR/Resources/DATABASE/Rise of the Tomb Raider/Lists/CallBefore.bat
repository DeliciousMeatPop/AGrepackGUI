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
echo. 6 = Spanish (Mexico)
echo. 7 = Portuguese (Brazil)
echo. 8 = Polish
echo. 9 = Russian
echo. 10 = Japanese
echo. 11 = Korean
echo. 12 = Chinese (Simplified)
echo. 13 = Chinese (Traditional)
echo.

set /p langchoice=
if "%langchoice%"=="" goto LangChoice
if "%langchoice%"=="0" goto EndLang
if "%langchoice%"=="1" goto English
if "%langchoice%"=="2" goto French
if "%langchoice%"=="3" goto German
if "%langchoice%"=="4" goto Italian
if "%langchoice%"=="5" goto Spanish
if "%langchoice%"=="6" goto SpanishMexico
if "%langchoice%"=="7" goto PortugueseBrazil
if "%langchoice%"=="8" goto Polish
if "%langchoice%"=="9" goto Russian
if "%langchoice%"=="10" goto Japanese
if "%langchoice%"=="11" goto Korean
if "%langchoice%"=="12" goto ChineseS
if "%langchoice%"=="13" goto ChineseT


:English
mkdir "!BackupDir!"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_IBERSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_LATAMSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_PORTUGUESE.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_JAPANESE.*" "!BackupDir!\"
move "!GameDir!\*_KOREAN.*" "!BackupDir!\"
move "!GameDir!\*_SIMPLECHINESE.*" "!BackupDir!\"
move "!GameDir!\*_CHINESE.*" "!BackupDir!\"
goto EndLang


:French
mkdir "!BackupDir!"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_IBERSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_LATAMSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_PORTUGUESE.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_JAPANESE.*" "!BackupDir!\"
move "!GameDir!\*_KOREAN.*" "!BackupDir!\"
move "!GameDir!\*_SIMPLECHINESE.*" "!BackupDir!\"
move "!GameDir!\*_CHINESE.*" "!BackupDir!\"
goto EndLang


:German
mkdir "!BackupDir!"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_IBERSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_LATAMSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_PORTUGUESE.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_JAPANESE.*" "!BackupDir!\"
move "!GameDir!\*_KOREAN.*" "!BackupDir!\"
move "!GameDir!\*_SIMPLECHINESE.*" "!BackupDir!\"
move "!GameDir!\*_CHINESE.*" "!BackupDir!\"
goto EndLang


:Italian
mkdir "!BackupDir!"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_IBERSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_LATAMSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_PORTUGUESE.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_JAPANESE.*" "!BackupDir!\"
move "!GameDir!\*_KOREAN.*" "!BackupDir!\"
move "!GameDir!\*_SIMPLECHINESE.*" "!BackupDir!\"
move "!GameDir!\*_CHINESE.*" "!BackupDir!\"
goto EndLang


:Spanish
mkdir "!BackupDir!"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_LATAMSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_PORTUGUESE.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_JAPANESE.*" "!BackupDir!\"
move "!GameDir!\*_KOREAN.*" "!BackupDir!\"
move "!GameDir!\*_SIMPLECHINESE.*" "!BackupDir!\"
move "!GameDir!\*_CHINESE.*" "!BackupDir!\"
goto EndLang


:SpanishMexico
mkdir "!BackupDir!"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_IBERSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_PORTUGUESE.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_JAPANESE.*" "!BackupDir!\"
move "!GameDir!\*_KOREAN.*" "!BackupDir!\"
move "!GameDir!\*_SIMPLECHINESE.*" "!BackupDir!\"
move "!GameDir!\*_CHINESE.*" "!BackupDir!\"
goto EndLang


:PortugueseBrazil
mkdir "!BackupDir!"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_IBERSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_LATAMSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_JAPANESE.*" "!BackupDir!\"
move "!GameDir!\*_KOREAN.*" "!BackupDir!\"
move "!GameDir!\*_SIMPLECHINESE.*" "!BackupDir!\"
move "!GameDir!\*_CHINESE.*" "!BackupDir!\"
goto EndLang


:Polish
mkdir "!BackupDir!"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_IBERSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_LATAMSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_PORTUGUESE.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_JAPANESE.*" "!BackupDir!\"
move "!GameDir!\*_KOREAN.*" "!BackupDir!\"
move "!GameDir!\*_SIMPLECHINESE.*" "!BackupDir!\"
move "!GameDir!\*_CHINESE.*" "!BackupDir!\"
goto EndLang


:Russian
mkdir "!BackupDir!"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_IBERSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_LATAMSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_PORTUGUESE.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_JAPANESE.*" "!BackupDir!\"
move "!GameDir!\*_KOREAN.*" "!BackupDir!\"
move "!GameDir!\*_SIMPLECHINESE.*" "!BackupDir!\"
move "!GameDir!\*_CHINESE.*" "!BackupDir!\"
goto EndLang


:Japanese
mkdir "!BackupDir!"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_IBERSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_LATAMSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_PORTUGUESE.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_KOREAN.*" "!BackupDir!\"
move "!GameDir!\*_SIMPLECHINESE.*" "!BackupDir!\"
move "!GameDir!\*_CHINESE.*" "!BackupDir!\"
goto EndLang


:Korean
mkdir "!BackupDir!"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_IBERSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_LATAMSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_PORTUGUESE.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_JAPANESE.*" "!BackupDir!\"
move "!GameDir!\*_SIMPLECHINESE.*" "!BackupDir!\"
move "!GameDir!\*_CHINESE.*" "!BackupDir!\"
goto EndLang


:ChineseS
mkdir "!BackupDir!"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_IBERSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_LATAMSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_PORTUGUESE.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_JAPANESE.*" "!BackupDir!\"
move "!GameDir!\*_KOREAN.*" "!BackupDir!\"
move "!GameDir!\*_CHINESE.*" "!BackupDir!\"
goto EndLang


:ChineseT
mkdir "!BackupDir!"
move "!GameDir!\*_ENGLISH.*" "!BackupDir!\"
move "!GameDir!\*_FRENCH.*" "!BackupDir!\"
move "!GameDir!\*_GERMAN.*" "!BackupDir!\"
move "!GameDir!\*_ITALIAN.*" "!BackupDir!\"
move "!GameDir!\*_IBERSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_LATAMSPANISH.*" "!BackupDir!\"
move "!GameDir!\*_PORTUGUESE.*" "!BackupDir!\"
move "!GameDir!\*_POLISH.*" "!BackupDir!\"
move "!GameDir!\*_RUSSIAN.*" "!BackupDir!\"
move "!GameDir!\*_JAPANESE.*" "!BackupDir!\"
move "!GameDir!\*_KOREAN.*" "!BackupDir!\"
move "!GameDir!\*_SIMPLECHINESE.*" "!BackupDir!\"
goto EndLang


:EndLang
cls
endlocal
exit /b