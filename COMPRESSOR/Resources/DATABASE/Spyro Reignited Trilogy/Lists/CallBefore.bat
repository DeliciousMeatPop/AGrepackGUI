@echo off
title DiskSpan GUI Compressor
setlocal EnableDelayedExpansion EnableExtensions

cd /D "%~dp0"
if "%~3" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~3") do ( set "GameDir=%%~fa" && set "BackupDir=%%~fa (Backup)") ) else ( endlocal && exit /B )
if "%~7" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~7") do set "MainDir=%%~fa" ) else ( endlocal && exit /B )


:Start
set removelangmov=false
if exist "!MainDir!\ffmpeg.exe" (
	echo.----------------------------------------------------------------------
	echo. ATTENTION
	echo. Removing languages from movie files should only be answered with YES
	echo. if your movie files match with the original files.
	echo.
	echo. Backup files will be made here:
	echo. !BackupDir!\
	echo.----------------------------------------------------------------------
	echo.
	echo.----------------------------------------------------------------------
	echo. Would you like to remove languages from Movie files? [Y/N]
	echo.----------------------------------------------------------------------
	choice /C NY /N
	if errorlevel 2 set removelangmov=true
) else (
	cls
	echo.
	echo.----------------------------------------------------------------------
	echo. ffmpeg.exe not found^^!
	echo.
	echo. Removing languages from video files are not available.
	echo. Download ffmpeg.exe from the following site:
	echo. https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-essentials.7z
	echo.
	echo. Copy ffmpeg.exe next to DiskSpan_GUI.exe and restart.
	echo.----------------------------------------------------------------------
	pause
	goto Start
)

set /A "count=28"
set "list.file[1]=C_Spyro01_GoodEnd.mp4"
set "list.file[2]=C_Spyro01_Intro.mp4"
set "list.file[3]=C_Spyro01_NormalEnd.mp4"
set "list.file[4]=C_Spyro02_BooBear.mp4"
set "list.file[5]=C_Spyro02_BringShorty.mp4"
set "list.file[6]=C_Spyro02_ComeSparx.mp4"
set "list.file[7]=C_Spyro02_DidIt.mp4"
set "list.file[8]=C_Spyro02_FaunDork.mp4"
set "list.file[9]=C_Spyro02_GulpLunchtime.mp4"
set "list.file[10]=C_Spyro02_IntroDragon.mp4"
set "list.file[11]=C_Spyro02_IntroVacation.mp4"
set "list.file[12]=C_Spyro02_LittleFools.mp4"
set "list.file[13]=C_Spyro02_NoDragons.mp4"
set "list.file[14]=C_Spyro02_YouAgain.mp4"
set "list.file[15]=C_Spyro03_ADesperateRescueBeginsIntro03.mp4"
set "list.file[16]=C_Spyro03_AFamiliarFace.mp4"
set "list.file[17]=C_Spyro03_AMonsterToEndAllMonstersIntro.mp4"
set "list.file[18]=C_Spyro03_AnApologyAndLunchOutro.mp4"
set "list.file[19]=C_Spyro03_AnEvilPlotUnfoldsIntro01.mp4"
set "list.file[20]=C_Spyro03_BiancaStrikesBackIntro.mp4"
set "list.file[21]=C_Spyro03_BillyInTheWall.mp4"
set "list.file[22]=C_Spyro03_DejaVu.mp4"
set "list.file[23]=C_Spyro03_HuntersTussleOutro.mp4"
set "list.file[24]=C_Spyro03_OneLessNobleWarrior.mp4"
set "list.file[25]=C_Spyro03_PowerfulVillainEmergesIntro02.mp4"
set "list.file[26]=C_Spyro03_SpikeIsBornOutro.mp4"
set "list.file[27]=C_Spyro03_TheEndOutro.mp4"
set "list.file[28]=C_Spyro03_TheEscapeOutro.mp4"


:LangChoice
cls
if /I "!removelangmov!"=="false" goto EndLang
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
echo. 2 = Arabic
echo. 3 = Danish
echo. 4 = German
echo. 5 = Spanish
echo. 6 = Spanish Mexico
echo. 7 = Finnish
echo. 8 = French
echo. 9 = Italian
echo. 10 = Dutch
echo. 11 = Norwegian
echo. 12 = Polish
echo. 13 = Portuguese Brazil
echo. 14 = Swedish
echo.

set /p langchoice=
if "%langchoice%"=="" goto LangChoice
if "%langchoice%"=="0" goto EndLang
if "%langchoice%"=="1" goto English
if "%langchoice%"=="2" goto Arabic
if "%langchoice%"=="3" goto Danish
if "%langchoice%"=="4" goto German
if "%langchoice%"=="5" goto Spanish
if "%langchoice%"=="6" goto SpanishMexico
if "%langchoice%"=="7" goto Finnish
if "%langchoice%"=="8" goto French
if "%langchoice%"=="9" goto Italian
if "%langchoice%"=="10" goto Dutch
if "%langchoice%"=="11" goto Norwegian
if "%langchoice%"=="12" goto Polish
if "%langchoice%"=="13" goto PortugueseBrazil
if "%langchoice%"=="14" goto Swedish


:English
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:1 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:Arabic
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:2 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:Danish
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:3 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:German
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:4 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:SpanishMexico
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:5 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:Spanish
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:6 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:Finnish
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:7 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:French
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:8 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:Italian
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:9 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:Dutch
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:10 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:Norwegian
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:11 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:Polish
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:12 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:PortugueseBrazil
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:13 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:Swedish
mkdir "!BackupDir!\Falcon\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Falcon\Content\Movies" "!BackupDir!\Falcon\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Falcon\Content\Movies\%%~a" -map 0:0 -map 0:14 -acodec copy -vcodec copy "!GameDir!\Falcon\Content\Movies\%%~nxa"
goto EndLang


:EndLang
endlocal
exit /B