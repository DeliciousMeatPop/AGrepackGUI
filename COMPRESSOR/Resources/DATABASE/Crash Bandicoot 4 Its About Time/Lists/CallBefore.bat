@echo off
title DiskSpan GUI Compressor
setlocal EnableDelayedExpansion EnableExtensions

cd /D "%~dp0"
if "%~3" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~3") do ( set "GameDir=%%~fa" && set "BackupDir=%%~fa (Backup)") ) else ( endlocal && exit /B )
if "%~7" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~7") do set "MainDir=%%~fa" ) else ( endlocal && exit /B )
set "DatabaseDir=!MainDir!\Resources\DATABASE"
set "BaseDir=!MainDir!\Resources\Win64"


:Start
set removelangmov=false
set removefiles=false
if exist "!MainDir!\ffmpeg.exe" (
	echo.----------------------------------------------------------------------
	echo. ATTENTION
	echo. Removing languages from movie files should only be answered with YES
	echo. if your movie files match with the original files.
	echo.----------------------------------------------------------------------
	echo.
	echo.----------------------------------------------------------------------
	echo. Would you like to remove languages from Movie files? [Y/N]
	echo.
	echo. Backup files will be made here:
	echo. !BackupDir!\
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
	echo. Copy ffmpeg.exe to "!MainDir!" and restart.
	echo.----------------------------------------------------------------------
	pause
	goto Start
)

echo.----------------------------------------------------------------------
echo. Would you like to remove unused files? [Y/N]
echo.
echo. Backup files will be made here:
echo. !BackupDir!\
echo.----------------------------------------------------------------------
choice /C NY /N
if errorlevel 2 set removefiles=true

set /A "count=12"
set "list.file[1]=C_GameEnd.mp4"
set "list.file[2]=C_GameStart.mp4"
set "list.file[3]=C_JungleOutro.mp4"
set "list.file[4]=C_MarshDingoIntro.mp4"
set "list.file[5]=C_NTropyBossIntro.mp4"
set "list.file[6]=C_NTropyBossOutro.mp4"
set "list.file[7]=C_PirateTawnaOutro.mp4"
set "list.file[8]=C_SpaceIntro.mp4"
set "list.file[9]=C_BonusEnd.mp4"
set "list.file[10]=C_BonusEnd1.mp4"
set "list.file[11]=C_BonusEnd2.mp4"
set "list.file[12]=C_CortexBossOutro.mp4"


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
echo. 2 = Arabic
echo. 3 = German
echo. 4 = Spanish Latam
echo. 5 = Japanese
echo. 6 = Spanish
echo. 7 = French
echo. 8 = Italian
echo. 9 = Portuguese Brazil
echo.

set /p langchoice=
if "%langchoice%"=="" goto LangChoice
if "%langchoice%"=="0" goto EndLang
if "%langchoice%"=="1" goto English
if "%langchoice%"=="2" goto Arabic
if "%langchoice%"=="3" goto German
if "%langchoice%"=="4" goto SpanishLatam
if "%langchoice%"=="5" goto Japanese
if "%langchoice%"=="6" goto Spanish
if "%langchoice%"=="7" goto French
if "%langchoice%"=="8" goto Italian
if "%langchoice%"=="9" goto PortugueseBrazil


:English
if "!removelangmov!"=="true" (
mkdir "!BackupDir!\Lava\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Lava\Content\Movies" "!BackupDir!\Lava\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Lava\Content\Movies\%%~a" -map 0:0 -map 0:1 -acodec copy -vcodec copy "!GameDir!\Lava\Content\Movies\%%~nxa"
	goto EndLang
)

:Arabic
if "!removelangmov!"=="true" (
mkdir "!BackupDir!\Lava\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Lava\Content\Movies" "!BackupDir!\Lava\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Lava\Content\Movies\%%~a" -map 0:0 -map 0:2 -acodec copy -vcodec copy "!GameDir!\Lava\Content\Movies\%%~nxa"
	goto EndLang
)


:German
if "!removelangmov!"=="true" (
mkdir "!BackupDir!\Lava\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Lava\Content\Movies" "!BackupDir!\Lava\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Lava\Content\Movies\%%~a" -map 0:0 -map 0:3 -acodec copy -vcodec copy "!GameDir!\Lava\Content\Movies\%%~nxa"
	goto EndLang
)

:SpanishLatam
if "!removelangmov!"=="true" (
mkdir "!BackupDir!\Lava\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Lava\Content\Movies" "!BackupDir!\Lava\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Lava\Content\Movies\%%~a" -map 0:0 -map 0:4 -acodec copy -vcodec copy "!GameDir!\Lava\Content\Movies\%%~nxa"
	goto EndLang
)


:Japanese
if "!removelangmov!"=="true" (
mkdir "!BackupDir!\Lava\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Lava\Content\Movies" "!BackupDir!\Lava\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Lava\Content\Movies\%%~a" -map 0:0 -map 0:5 -acodec copy -vcodec copy "!GameDir!\Lava\Content\Movies\%%~nxa"
goto EndLang


:Spanish
if "!removelangmov!"=="true" (
mkdir "!BackupDir!\Lava\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Lava\Content\Movies" "!BackupDir!\Lava\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Lava\Content\Movies\%%~a" -map 0:0 -map 0:6 -acodec copy -vcodec copy "!GameDir!\Lava\Content\Movies\%%~nxa"
	goto EndLang
)


:French
if "!removelangmov!"=="true" (
mkdir "!BackupDir!\Lava\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Lava\Content\Movies" "!BackupDir!\Lava\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Lava\Content\Movies\%%~a" -map 0:0 -map 0:7 -acodec copy -vcodec copy "!GameDir!\Lava\Content\Movies\%%~nxa"
	goto EndLang
)


:Italian
if "!removelangmov!"=="true" (
mkdir "!BackupDir!\Lava\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Lava\Content\Movies" "!BackupDir!\Lava\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Lava\Content\Movies\%%~a" -map 0:0 -map 0:8 -acodec copy -vcodec copy "!GameDir!\Lava\Content\Movies\%%~nxa"
	goto EndLang
)


:PortugueseBrazil
if "!removelangmov!"=="true" (
mkdir "!BackupDir!\Lava\Content\Movies"
xcopy /S /I /Y /E "!GameDir!\Lava\Content\Movies" "!BackupDir!\Lava\Content\Movies"
for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -y -i "!BackupDir!\Lava\Content\Movies\%%~a" -map 0:0 -map 0:9 -acodec copy -vcodec copy "!GameDir!\Lava\Content\Movies\%%~nxa"
	goto EndLang
)


:EndLang
if "!removefiles!"=="true" (
	mkdir "!BackupDir!\Engine\Extras\Redist\en-us"
	rmdir /S /Q "!GameDir!\Lava\Content\Movies\134"
	rmdir /S /Q "!GameDir!\Lava\Content\Movies\CrossPromo"
	move /Y "!GameDir!\Lava\Content\Movies\Bumper_HSL_Sting.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\BumperATVI_Gamma.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\BumperTFB_Gamma.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\BumperUnreal_Gamma.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\C_GameEnd_TV_Shot006.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\C_GameEnd_TV_Shot007.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\C_GameEnd_TV_Shot008.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\C_Spyro02_MetropolisIntro.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\CinematicPlaceholder.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\CinematicPlaceholder_4K.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\CinematicPlaceholder_720p.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\CinematicPlaceholder_1080p.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\IntroLoadingBar.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\IntroLoadingBar_Gamma.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\IntroLoadingNoBar.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\LastIntroMovie.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\LoadingScreenMovie_SP.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\LoopingLoadingScreenMovie_SP.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\MaskMonitor_Density.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\MaskMonitor_Gravity.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\MaskMonitor_Space.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Lava\Content\Movies\MaskMonitor_Time.mp4" "!BackupDir!\Lava\Content\Movies\"
	move /Y "!GameDir!\Engine\Extras\Redist\en-us\UE4PrereqSetup_x64.exe" "!BackupDir!\Engine\Extras\Redist\en-us\"
)
endlocal
exit /B