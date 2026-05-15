@echo off
title DiskSpan GUI Compressor
setlocal EnableDelayedExpansion EnableExtensions

cd /D "%~dp0"
if "%~3" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~3") do ( set "GameDir=%%~fa" && set "BackupDir=%%~fa (Backup)") ) else ( endlocal && exit /B )


:LangChoice
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
echo. 2 = Japanese
echo.

set /p langchoice=
if "%langchoice%"=="" goto LangChoice
if "%langchoice%"=="0" goto EndLang
if "%langchoice%"=="1" goto English
if "%langchoice%"=="2" goto Japanese


:English
xcopy /S /I /Y /E "!GameDir!\AT\Content\DLC\05\Sound\Voice\ja" "!BackupDir!\AT\Content\DLC\05\Sound\Voice\ja"
xcopy /S /I /Y /E "!GameDir!\AT\Content\DLC\06\Sound\Voice\ja" "!BackupDir!\AT\Content\DLC\06\Sound\Voice\ja"
xcopy /S /I /Y /E "!GameDir!\AT\Content\DLC\08\Sound\Voice\ja" "!BackupDir!\AT\Content\DLC\08\Sound\Voice\ja"
xcopy /S /I /Y /E "!GameDir!\AT\Content\DLC\09\Sound\Voice\ja" "!BackupDir!\AT\Content\DLC\09\Sound\Voice\ja"
xcopy /S /I /Y /E "!GameDir!\AT\Content\DLC\10\Sound\Voice\ja" "!BackupDir!\AT\Content\DLC\10\Sound\Voice\ja"
xcopy /S /I /Y /E "!GameDir!\AT\Content\Sound\Voice\ja" "!BackupDir!\AT\Content\Sound\Voice\ja"
rd /S /Q "!GameDir!\AT\Content\DLC\05\Sound\Voice\ja"
rd /S /Q "!GameDir!\AT\Content\DLC\06\Sound\Voice\ja"
rd /S /Q "!GameDir!\AT\Content\DLC\08\Sound\Voice\ja"
rd /S /Q "!GameDir!\AT\Content\Sound\Voice\ja"
goto EndLang


:Japanese
xcopy /S /I /Y /E "!GameDir!\AT\Content\DLC\05\Sound\Voice\en" "!BackupDir!\AT\Content\DLC\05\Sound\Voice\en"
xcopy /S /I /Y /E "!GameDir!\AT\Content\DLC\06\Sound\Voice\en" "!BackupDir!\AT\Content\DLC\06\Sound\Voice\en"
xcopy /S /I /Y /E "!GameDir!\AT\Content\DLC\08\Sound\Voice\en" "!BackupDir!\AT\Content\DLC\08\Sound\Voice\en"
xcopy /S /I /Y /E "!GameDir!\AT\Content\DLC\09\Sound\Voice\en" "!BackupDir!\AT\Content\DLC\09\Sound\Voice\en"
xcopy /S /I /Y /E "!GameDir!\AT\Content\DLC\10\Sound\Voice\en" "!BackupDir!\AT\Content\DLC\10\Sound\Voice\en"
xcopy /S /I /Y /E "!GameDir!\AT\Content\Sound\Voice\en" "!BackupDir!\AT\Content\Sound\Voice\en"
rd /S /Q "!GameDir!\AT\Content\DLC\05\Sound\Voice\en"
rd /S /Q "!GameDir!\AT\Content\DLC\06\Sound\Voice\en"
rd /S /Q "!GameDir!\AT\Content\DLC\08\Sound\Voice\en"
rd /S /Q "!GameDir!\AT\Content\Sound\Voice\en"
goto EndLang


:EndLang
endlocal
exit /b