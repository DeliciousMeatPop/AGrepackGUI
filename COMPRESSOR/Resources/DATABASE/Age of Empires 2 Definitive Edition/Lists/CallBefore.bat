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
echo. 7 = SPANISH (MEXICO)
echo. 8 = KOREAN
echo. 9 = CHINESE (SIMPLIFIED)
echo.

set /P "LangChoice="
if "!LangChoice!" EQU "" goto LangChoice
if "!LangChoice!" EQU "0" goto EndLang
if "!LangChoice!" EQU "1" goto English
if "!LangChoice!" EQU "2" goto French
if "!LangChoice!" EQU "3" goto German
if "!LangChoice!" EQU "4" goto Italian
if "!LangChoice!" EQU "5" goto PortugueseBrazil
if "!LangChoice!" EQU "6" goto SpanishSpain
if "!LangChoice!" EQU "7" goto SpanishMexico
if "!LangChoice!" EQU "8" goto Korean
if "!LangChoice!" EQU "9" goto ChineseS


:English
mkdir "!BackupDir!\wwise"
mkdir "!BackupDir!\resources"
move /Y "!GameDir!\wwise\br" "!BackupDir!\wwise\br"
move /Y "!GameDir!\wwise\de" "!BackupDir!\wwise\de"
move /Y "!GameDir!\wwise\es" "!BackupDir!\wwise\es"
move /Y "!GameDir!\wwise\fr" "!BackupDir!\wwise\fr"
move /Y "!GameDir!\wwise\it" "!BackupDir!\wwise\it"
move /Y "!GameDir!\wwise\ko" "!BackupDir!\wwise\ko"
move /Y "!GameDir!\wwise\mx" "!BackupDir!\wwise\mx"
move /Y "!GameDir!\wwise\zh" "!BackupDir!\wwise\zh"
move /Y "!GameDir!\resources\br" "!BackupDir!\resources\br"
move /Y "!GameDir!\resources\de" "!BackupDir!\resources\de"
move /Y "!GameDir!\resources\es" "!BackupDir!\resources\es"
move /Y "!GameDir!\resources\fr" "!BackupDir!\resources\fr"
move /Y "!GameDir!\resources\it" "!BackupDir!\resources\it"
move /Y "!GameDir!\resources\ko" "!BackupDir!\resources\ko"
move /Y "!GameDir!\resources\mx" "!BackupDir!\resources\mx"
move /Y "!GameDir!\resources\zh" "!BackupDir!\resources\zh"
goto EndLang


:French
mkdir "!BackupDir!\wwise"
mkdir "!BackupDir!\resources"
move /Y "!GameDir!\wwise\br" "!BackupDir!\wwise\br"
move /Y "!GameDir!\wwise\de" "!BackupDir!\wwise\de"
move /Y "!GameDir!\wwise\en" "!BackupDir!\wwise\en"
move /Y "!GameDir!\wwise\es" "!BackupDir!\wwise\es"
move /Y "!GameDir!\wwise\it" "!BackupDir!\wwise\it"
move /Y "!GameDir!\wwise\ko" "!BackupDir!\wwise\ko"
move /Y "!GameDir!\wwise\mx" "!BackupDir!\wwise\mx"
move /Y "!GameDir!\wwise\zh" "!BackupDir!\wwise\zh"
move /Y "!GameDir!\resources\br" "!BackupDir!\resources\br"
move /Y "!GameDir!\resources\de" "!BackupDir!\resources\de"
move /Y "!GameDir!\resources\en" "!BackupDir!\resources\en"
move /Y "!GameDir!\resources\es" "!BackupDir!\resources\es"
move /Y "!GameDir!\resources\it" "!BackupDir!\resources\it"
move /Y "!GameDir!\resources\ko" "!BackupDir!\resources\ko"
move /Y "!GameDir!\resources\mx" "!BackupDir!\resources\mx"
move /Y "!GameDir!\resources\zh" "!BackupDir!\resources\zh"
goto EndLang


:German
mkdir "!BackupDir!\wwise"
mkdir "!BackupDir!\resources"
move /Y "!GameDir!\wwise\br" "!BackupDir!\wwise\br"
move /Y "!GameDir!\wwise\en" "!BackupDir!\wwise\en"
move /Y "!GameDir!\wwise\es" "!BackupDir!\wwise\es"
move /Y "!GameDir!\wwise\fr" "!BackupDir!\wwise\fr"
move /Y "!GameDir!\wwise\it" "!BackupDir!\wwise\it"
move /Y "!GameDir!\wwise\ko" "!BackupDir!\wwise\ko"
move /Y "!GameDir!\wwise\mx" "!BackupDir!\wwise\mx"
move /Y "!GameDir!\wwise\zh" "!BackupDir!\wwise\zh"
move /Y "!GameDir!\resources\br" "!BackupDir!\resources\br"
move /Y "!GameDir!\resources\en" "!BackupDir!\resources\en"
move /Y "!GameDir!\resources\es" "!BackupDir!\resources\es"
move /Y "!GameDir!\resources\fr" "!BackupDir!\resources\fr"
move /Y "!GameDir!\resources\it" "!BackupDir!\resources\it"
move /Y "!GameDir!\resources\ko" "!BackupDir!\resources\ko"
move /Y "!GameDir!\resources\mx" "!BackupDir!\resources\mx"
move /Y "!GameDir!\resources\zh" "!BackupDir!\resources\zh"
goto EndLang


:Italian
mkdir "!BackupDir!\wwise"
mkdir "!BackupDir!\resources"
move /Y "!GameDir!\wwise\br" "!BackupDir!\wwise\br"
move /Y "!GameDir!\wwise\de" "!BackupDir!\wwise\de"
move /Y "!GameDir!\wwise\en" "!BackupDir!\wwise\en"
move /Y "!GameDir!\wwise\es" "!BackupDir!\wwise\es"
move /Y "!GameDir!\wwise\fr" "!BackupDir!\wwise\fr"
move /Y "!GameDir!\wwise\ko" "!BackupDir!\wwise\ko"
move /Y "!GameDir!\wwise\mx" "!BackupDir!\wwise\mx"
move /Y "!GameDir!\wwise\zh" "!BackupDir!\wwise\zh"
move /Y "!GameDir!\resources\br" "!BackupDir!\resources\br"
move /Y "!GameDir!\resources\de" "!BackupDir!\resources\de"
move /Y "!GameDir!\resources\en" "!BackupDir!\resources\en"
move /Y "!GameDir!\resources\es" "!BackupDir!\resources\es"
move /Y "!GameDir!\resources\fr" "!BackupDir!\resources\fr"
move /Y "!GameDir!\resources\ko" "!BackupDir!\resources\ko"
move /Y "!GameDir!\resources\mx" "!BackupDir!\resources\mx"
move /Y "!GameDir!\resources\zh" "!BackupDir!\resources\zh"
goto EndLang


:Korean
mkdir "!BackupDir!\wwise"
mkdir "!BackupDir!\resources"
move /Y "!GameDir!\wwise\br" "!BackupDir!\wwise\br"
move /Y "!GameDir!\wwise\de" "!BackupDir!\wwise\de"
move /Y "!GameDir!\wwise\en" "!BackupDir!\wwise\en"
move /Y "!GameDir!\wwise\es" "!BackupDir!\wwise\es"
move /Y "!GameDir!\wwise\fr" "!BackupDir!\wwise\fr"
move /Y "!GameDir!\wwise\it" "!BackupDir!\wwise\it"
move /Y "!GameDir!\wwise\mx" "!BackupDir!\wwise\mx"
move /Y "!GameDir!\wwise\zh" "!BackupDir!\wwise\zh"
move /Y "!GameDir!\resources\br" "!BackupDir!\resources\br"
move /Y "!GameDir!\resources\de" "!BackupDir!\resources\de"
move /Y "!GameDir!\resources\en" "!BackupDir!\resources\en"
move /Y "!GameDir!\resources\es" "!BackupDir!\resources\es"
move /Y "!GameDir!\resources\fr" "!BackupDir!\resources\fr"
move /Y "!GameDir!\resources\it" "!BackupDir!\resources\it"
move /Y "!GameDir!\resources\mx" "!BackupDir!\resources\mx"
move /Y "!GameDir!\resources\zh" "!BackupDir!\resources\zh"
goto EndLang


:PortugueseBrazil
mkdir "!BackupDir!\wwise"
mkdir "!BackupDir!\resources"
move /Y "!GameDir!\wwise\de" "!BackupDir!\wwise\de"
move /Y "!GameDir!\wwise\en" "!BackupDir!\wwise\en"
move /Y "!GameDir!\wwise\es" "!BackupDir!\wwise\es"
move /Y "!GameDir!\wwise\fr" "!BackupDir!\wwise\fr"
move /Y "!GameDir!\wwise\it" "!BackupDir!\wwise\it"
move /Y "!GameDir!\wwise\ko" "!BackupDir!\wwise\ko"
move /Y "!GameDir!\wwise\mx" "!BackupDir!\wwise\mx"
move /Y "!GameDir!\wwise\zh" "!BackupDir!\wwise\zh"
move /Y "!GameDir!\resources\de" "!BackupDir!\resources\de"
move /Y "!GameDir!\resources\en" "!BackupDir!\resources\en"
move /Y "!GameDir!\resources\es" "!BackupDir!\resources\es"
move /Y "!GameDir!\resources\fr" "!BackupDir!\resources\fr"
move /Y "!GameDir!\resources\it" "!BackupDir!\resources\it"
move /Y "!GameDir!\resources\ko" "!BackupDir!\resources\ko"
move /Y "!GameDir!\resources\mx" "!BackupDir!\resources\mx"
move /Y "!GameDir!\resources\zh" "!BackupDir!\resources\zh"
goto EndLang


:SpanishSpain
mkdir "!BackupDir!\wwise"
mkdir "!BackupDir!\resources"
move /Y "!GameDir!\wwise\br" "!BackupDir!\wwise\br"
move /Y "!GameDir!\wwise\de" "!BackupDir!\wwise\de"
move /Y "!GameDir!\wwise\en" "!BackupDir!\wwise\en"
move /Y "!GameDir!\wwise\fr" "!BackupDir!\wwise\fr"
move /Y "!GameDir!\wwise\it" "!BackupDir!\wwise\it"
move /Y "!GameDir!\wwise\ko" "!BackupDir!\wwise\ko"
move /Y "!GameDir!\wwise\mx" "!BackupDir!\wwise\mx"
move /Y "!GameDir!\wwise\zh" "!BackupDir!\wwise\zh"
move /Y "!GameDir!\resources\br" "!BackupDir!\resources\br"
move /Y "!GameDir!\resources\de" "!BackupDir!\resources\de"
move /Y "!GameDir!\resources\en" "!BackupDir!\resources\en"
move /Y "!GameDir!\resources\fr" "!BackupDir!\resources\fr"
move /Y "!GameDir!\resources\it" "!BackupDir!\resources\it"
move /Y "!GameDir!\resources\ko" "!BackupDir!\resources\ko"
move /Y "!GameDir!\resources\mx" "!BackupDir!\resources\mx"
move /Y "!GameDir!\resources\zh" "!BackupDir!\resources\zh"
goto EndLang


:SpanishMexico
mkdir "!BackupDir!\wwise"
mkdir "!BackupDir!\resources"
move /Y "!GameDir!\wwise\br" "!BackupDir!\wwise\br"
move /Y "!GameDir!\wwise\de" "!BackupDir!\wwise\de"
move /Y "!GameDir!\wwise\en" "!BackupDir!\wwise\en"
move /Y "!GameDir!\wwise\es" "!BackupDir!\wwise\es"
move /Y "!GameDir!\wwise\fr" "!BackupDir!\wwise\fr"
move /Y "!GameDir!\wwise\it" "!BackupDir!\wwise\it"
move /Y "!GameDir!\wwise\ko" "!BackupDir!\wwise\ko"
move /Y "!GameDir!\wwise\zh" "!BackupDir!\wwise\zh"
move /Y "!GameDir!\resources\br" "!BackupDir!\resources\br"
move /Y "!GameDir!\resources\de" "!BackupDir!\resources\de"
move /Y "!GameDir!\resources\en" "!BackupDir!\resources\en"
move /Y "!GameDir!\resources\es" "!BackupDir!\resources\es"
move /Y "!GameDir!\resources\fr" "!BackupDir!\resources\fr"
move /Y "!GameDir!\resources\it" "!BackupDir!\resources\it"
move /Y "!GameDir!\resources\ko" "!BackupDir!\resources\ko"
move /Y "!GameDir!\resources\zh" "!BackupDir!\resources\zh"
goto EndLang


:ChineseS
mkdir "!BackupDir!\wwise"
mkdir "!BackupDir!\resources"
move /Y "!GameDir!\wwise\br" "!BackupDir!\wwise\br"
move /Y "!GameDir!\wwise\de" "!BackupDir!\wwise\de"
move /Y "!GameDir!\wwise\en" "!BackupDir!\wwise\en"
move /Y "!GameDir!\wwise\es" "!BackupDir!\wwise\es"
move /Y "!GameDir!\wwise\fr" "!BackupDir!\wwise\fr"
move /Y "!GameDir!\wwise\it" "!BackupDir!\wwise\it"
move /Y "!GameDir!\wwise\ko" "!BackupDir!\wwise\ko"
move /Y "!GameDir!\wwise\mx" "!BackupDir!\wwise\mx"
move /Y "!GameDir!\resources\br" "!BackupDir!\resources\br"
move /Y "!GameDir!\resources\de" "!BackupDir!\resources\de"
move /Y "!GameDir!\resources\en" "!BackupDir!\resources\en"
move /Y "!GameDir!\resources\es" "!BackupDir!\resources\es"
move /Y "!GameDir!\resources\fr" "!BackupDir!\resources\fr"
move /Y "!GameDir!\resources\it" "!BackupDir!\resources\it"
move /Y "!GameDir!\resources\ko" "!BackupDir!\resources\ko"
move /Y "!GameDir!\resources\mx" "!BackupDir!\resources\mx"
goto EndLang


:EndLang
cls
exit /B