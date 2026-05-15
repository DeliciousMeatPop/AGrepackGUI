@echo off
title DiskSpan GUI Compressor
setlocal EnableDelayedExpansion EnableExtensions

cd /D "%~dp0"
if "%~3" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~3") do ( set "GameDir=%%~fa" && set "BackupDir=%%~fa (Backup)") ) else ( endlocal && exit /B )


:HaloCELangChoice
cls
echo.
echo.----------------------------------------------------------------------
echo. Which language you did want to use for Halo CE?
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
echo. 6 = JAPANESE
echo. 7 = KOREAN
echo. 8 = CHINESE (SIMPLIFIED)
echo.

set "LangCount=8"
set "Lang.Name[1]="
set "Lang.Name[2]=_french"
set "Lang.Name[3]=_german"
set "Lang.Name[4]=_italian"
set "Lang.Name[5]=_spanish"
set "Lang.Name[6]=_japan"
set "Lang.Name[7]=_korean"
set "Lang.Name[8]=_chinese"

set "SelLang=unknown"
set /P "LangChoice="
if "!LangChoice!" EQU "" goto HaloCELangChoice
if "!LangChoice!" EQU "0" goto Halo2LangChoice
if "!LangChoice!" EQU "1" set "SelLang=!Lang.Name[1]!"
if "!LangChoice!" EQU "2" set "SelLang=!Lang.Name[2]!"
if "!LangChoice!" EQU "3" set "SelLang=!Lang.Name[3]!"
if "!LangChoice!" EQU "4" set "SelLang=!Lang.Name[4]!"
if "!LangChoice!" EQU "5" set "SelLang=!Lang.Name[5]!"
if "!LangChoice!" EQU "6" set "SelLang=!Lang.Name[6]!"
if "!LangChoice!" EQU "7" set "SelLang=!Lang.Name[7]!"
if "!LangChoice!" EQU "8" set "SelLang=!Lang.Name[8]!"
if /I "!SelLang!" EQU "unknown" goto HaloCELangChoice

mkdir "!BackupDir!\halo1\sound\pc"
for /L %%i in (1, 1, !LangCount!) do if /I "!SelLang!" NEQ "!Lang.Name[%%i]!" (
	move /Y "!GameDir!\halo1\sound\pc\sounds_dialogs!Lang.Name[%%i]!.fsb" "!BackupDir!\halo1\sound\pc\"
)


:Halo2LangChoice
cls
echo.
echo.----------------------------------------------------------------------
echo. Which language you did want to use for Halo 2?
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
echo. 6 = JAPANESE
echo. 7 = KOREAN
echo. 8 = CHINESE (TRADITIONAL)
echo.

set "LangCount=8"
set "Lang.Name[1]=en"
set "Lang.Name[2]=fr"
set "Lang.Name[3]=de"
set "Lang.Name[4]=it"
set "Lang.Name[5]=sp"
set "Lang.Name[6]=jpn"
set "Lang.Name[7]=kor"
set "Lang.Name[8]=cht"

set "SelLang="
set /P "LangChoice="
if "!LangChoice!" EQU "" goto Halo2LangChoice
if "!LangChoice!" EQU "0" goto Halo3LangChoice
if "!LangChoice!" EQU "1" set "SelLang=!Lang.Name[1]!"
if "!LangChoice!" EQU "2" set "SelLang=!Lang.Name[2]!"
if "!LangChoice!" EQU "3" set "SelLang=!Lang.Name[3]!"
if "!LangChoice!" EQU "4" set "SelLang=!Lang.Name[4]!"
if "!LangChoice!" EQU "5" set "SelLang=!Lang.Name[5]!"
if "!LangChoice!" EQU "6" set "SelLang=!Lang.Name[6]!"
if "!LangChoice!" EQU "7" set "SelLang=!Lang.Name[7]!"
if "!LangChoice!" EQU "8" set "SelLang=!Lang.Name[8]!"
if /I "!SelLang!" EQU "" goto Halo2LangChoice

mkdir "!BackupDir!\halo2\h2_maps_win64_dx11"
for /L %%i in (1, 1, !LangCount!) do if /I "!SelLang!" NEQ "!Lang.Name[%%i]!" (
	move /Y "!GameDir!\halo2\h2_maps_win64_dx11\sounds_!Lang.Name[%%i]!.dat" "!BackupDir!\halo2\h2_maps_win64_dx11\"
)


:Halo3LangChoice
cls
echo.
echo.----------------------------------------------------------------------
echo. Which language you did want to use for Halo 3?
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
echo. 6 = SPANISH (MEXICO)
echo. 7 = PORTUGUESE (BRAZIL)
echo. 8 = JAPANESE
echo. 9 = KOREAN
echo. 10 = CHINESE (TRADITIONAL)
echo.

set "LangCount=10"
set "Lang.Name[1]=english"
set "Lang.Name[2]=french"
set "Lang.Name[3]=german"
set "Lang.Name[4]=italian"
set "Lang.Name[5]=spanish"
set "Lang.Name[6]=mexican"
set "Lang.Name[7]=portuguese"
set "Lang.Name[8]=japanese"
set "Lang.Name[9]=korean"
set "Lang.Name[10]=chinese-traditional"

set "SelLang="
set /P "LangChoice="
if "!LangChoice!" EQU "" goto Halo3LangChoice
if "!LangChoice!" EQU "0" goto Halo3ODSTLangChoice
if "!LangChoice!" EQU "1" set "SelLang=!Lang.Name[1]!"
if "!LangChoice!" EQU "2" set "SelLang=!Lang.Name[2]!"
if "!LangChoice!" EQU "3" set "SelLang=!Lang.Name[3]!"
if "!LangChoice!" EQU "4" set "SelLang=!Lang.Name[4]!"
if "!LangChoice!" EQU "5" set "SelLang=!Lang.Name[5]!"
if "!LangChoice!" EQU "6" set "SelLang=!Lang.Name[6]!"
if "!LangChoice!" EQU "7" set "SelLang=!Lang.Name[7]!"
if "!LangChoice!" EQU "8" set "SelLang=!Lang.Name[8]!"
if "!LangChoice!" EQU "9" set "SelLang=!Lang.Name[9]!"
if "!LangChoice!" EQU "10" set "SelLang=!Lang.Name[10]!"
if /I "!SelLang!" EQU "" goto Halo3LangChoice

mkdir "!BackupDir!\halo3\fmod\pc"
for /L %%i in (1, 1, !LangCount!) do if /I "!SelLang!" NEQ "!Lang.Name[%%i]!" (
	move /Y "!GameDir!\halo3\fmod\pc\!Lang.Name[%%i]!*" "!BackupDir!\halo3\fmod\pc\"
)


:Halo3ODSTLangChoice
cls
echo.
echo.----------------------------------------------------------------------
echo. Which language you did want to use for Halo 3 ODST?
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
echo. 6 = SPANISH (MEXICO)
echo. 7 = PORTUGUESE (BRAZIL)
echo. 8 = JAPANESE
echo. 9 = KOREAN
echo. 10 = CHINESE (TRADITIONAL)
echo.

set "LangCount=10"
set "Lang.Name[1]=english"
set "Lang.Name[2]=french"
set "Lang.Name[3]=german"
set "Lang.Name[4]=italian"
set "Lang.Name[5]=spanish"
set "Lang.Name[6]=mexican"
set "Lang.Name[7]=portuguese"
set "Lang.Name[8]=japanese"
set "Lang.Name[9]=korean"
set "Lang.Name[10]=chinese-traditional"

set "Lang.Short[1]=en"
set "Lang.Short[2]=fr"
set "Lang.Short[3]=de"
set "Lang.Short[4]=it"
set "Lang.Short[5]=sp"
set "Lang.Short[6]=sp"
set "Lang.Short[7]=por"
set "Lang.Short[8]=jp"
set "Lang.Short[9]=kr"
set "Lang.Short[10]=ch"

set "SelLang="
set /P "LangChoice="
if "!LangChoice!" EQU "" goto Halo3ODSTLangChoice
if "!LangChoice!" EQU "0" goto Halo4LangChoice
if "!LangChoice!" EQU "1" set "SelLang=!Lang.Name[1]!"
if "!LangChoice!" EQU "2" set "SelLang=!Lang.Name[2]!"
if "!LangChoice!" EQU "3" set "SelLang=!Lang.Name[3]!"
if "!LangChoice!" EQU "4" set "SelLang=!Lang.Name[4]!"
if "!LangChoice!" EQU "5" set "SelLang=!Lang.Name[5]!"
if "!LangChoice!" EQU "6" set "SelLang=!Lang.Name[6]!"
if "!LangChoice!" EQU "7" set "SelLang=!Lang.Name[7]!"
if "!LangChoice!" EQU "8" set "SelLang=!Lang.Name[8]!"
if "!LangChoice!" EQU "9" set "SelLang=!Lang.Name[9]!"
if "!LangChoice!" EQU "10" set "SelLang=!Lang.Name[10]!"
if /I "!SelLang!" EQU "" goto Halo3ODSTLangChoice

mkdir "!BackupDir!\halo3odst\fmod\pc"
mkdir "!BackupDir!\halo3odst\bink"
for /L %%i in (1, 1, !LangCount!) do if /I "!SelLang!" NEQ "!Lang.Name[%%i]!" (
	move /Y "!GameDir!\halo3odst\fmod\pc\!Lang.Name[%%i]!*" "!BackupDir!\halo3odst\fmod\pc\"
	move /Y "!GameDir!\halo3odst\bink\!Lang.Short[%%i]!" "!BackupDir!\halo3odst\bink\!Lang.Short[%%i]!"
	if exist "!GameDir!\halo3odst\bink\!Lang.Short[%%i]!_no_esrb" move /Y "!GameDir!\halo3odst\bink\!Lang.Short[%%i]!_no_esrb" "!BackupDir!\halo3odst\bink\!Lang.Short[%%i]!_no_esrb"
)


:Halo4LangChoice
cls
echo.
echo.----------------------------------------------------------------------
echo. Which language you did want to use for Halo 4?
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
echo. 6 = SPANISH (MEXICO)
echo. 7 = PORTUGUESE (BRAZIL)
echo. 8 = JAPANESE
echo. 9 = KOREAN
echo. 10 = CHINESE (SIMPLIFIED)
echo. 11 = POLISH
echo. 12 = RUSSIAN
echo.

set "LangCount=12"
set "Lang.Name[1]=english(us)"
set "Lang.Name[2]=french(france)"
set "Lang.Name[3]=german"
set "Lang.Name[4]=italian"
set "Lang.Name[5]=spanish(spain)"
set "Lang.Name[6]=spanish(mexico)"
set "Lang.Name[7]=portuguese(brazil)"
set "Lang.Name[8]=japanese"
set "Lang.Name[9]=korean"
set "Lang.Name[10]=chinese(taiwan)"
set "Lang.Name[11]=polish"
set "Lang.Name[12]=russian"

set "SelLang="
set /P "LangChoice="
if "!LangChoice!" EQU "" goto Halo4LangChoice
if "!LangChoice!" EQU "0" goto HaloReachLangChoice
if "!LangChoice!" EQU "1" set "SelLang=!Lang.Name[1]!"
if "!LangChoice!" EQU "2" set "SelLang=!Lang.Name[2]!"
if "!LangChoice!" EQU "3" set "SelLang=!Lang.Name[3]!"
if "!LangChoice!" EQU "4" set "SelLang=!Lang.Name[4]!"
if "!LangChoice!" EQU "5" set "SelLang=!Lang.Name[5]!"
if "!LangChoice!" EQU "6" set "SelLang=!Lang.Name[6]!"
if "!LangChoice!" EQU "7" set "SelLang=!Lang.Name[7]!"
if "!LangChoice!" EQU "8" set "SelLang=!Lang.Name[8]!"
if "!LangChoice!" EQU "9" set "SelLang=!Lang.Name[9]!"
if "!LangChoice!" EQU "10" set "SelLang=!Lang.Name[10]!"
if "!LangChoice!" EQU "11" set "SelLang=!Lang.Name[11]!"
if "!LangChoice!" EQU "12" set "SelLang=!Lang.Name[12]!"
if /I "!SelLang!" EQU "" goto Halo4LangChoice

mkdir "!BackupDir!\halo4\sound\pc"
for /L %%i in (1, 1, !LangCount!) do if /I "!SelLang!" NEQ "!Lang.Name[%%i]!" (
	move /Y "!GameDir!\halo4\sound\pc\!Lang.Name[%%i]!" "!BackupDir!\halo4\sound\pc\!Lang.Name[%%i]!"
)


:HaloReachLangChoice
cls
echo.
echo.----------------------------------------------------------------------
echo. Which language you did want to use for Halo Reach?
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
echo. 6 = SPANISH (MEXICO)
echo. 7 = PORTUGUESE (BRAZIL)
echo. 8 = JAPANESE
echo. 9 = KOREAN
echo. 10 = CHINESE (TRADITIONAL)
echo.

set "LangCount=10"
set "Lang.Name[1]=english"
set "Lang.Name[2]=french"
set "Lang.Name[3]=german"
set "Lang.Name[4]=italian"
set "Lang.Name[5]=spanish"
set "Lang.Name[6]=mexican"
set "Lang.Name[7]=portuguese"
set "Lang.Name[8]=japanese"
set "Lang.Name[9]=korean"
set "Lang.Name[10]=chinese-traditional"

set "SelLang="
set /P "LangChoice="
if "!LangChoice!" EQU "" goto HaloReachLangChoice
if "!LangChoice!" EQU "0" goto MultiplayerFiles
if "!LangChoice!" EQU "1" set "SelLang=!Lang.Name[1]!"
if "!LangChoice!" EQU "2" set "SelLang=!Lang.Name[2]!"
if "!LangChoice!" EQU "3" set "SelLang=!Lang.Name[3]!"
if "!LangChoice!" EQU "4" set "SelLang=!Lang.Name[4]!"
if "!LangChoice!" EQU "5" set "SelLang=!Lang.Name[5]!"
if "!LangChoice!" EQU "6" set "SelLang=!Lang.Name[6]!"
if "!LangChoice!" EQU "7" set "SelLang=!Lang.Name[7]!"
if "!LangChoice!" EQU "8" set "SelLang=!Lang.Name[8]!"
if "!LangChoice!" EQU "9" set "SelLang=!Lang.Name[9]!"
if "!LangChoice!" EQU "10" set "SelLang=!Lang.Name[10]!"
if /I "!SelLang!" EQU "" goto HaloReachLangChoice

mkdir "!BackupDir!\haloreach\fmod\pc"
for /L %%i in (1, 1, !LangCount!) do if /I "!SelLang!" NEQ "!Lang.Name[%%i]!" (
	move /Y "!GameDir!\haloreach\fmod\pc\!Lang.Name[%%i]!*" "!BackupDir!\haloreach\fmod\pc\"
)


:MultiplayerFiles
cls
echo.----------------------------------------------------------------------
echo. Would you like to keep multiplayer files? [Y/N]
echo.
echo. Backup files will be made here:
echo. !BackupDir!\
echo.----------------------------------------------------------------------
choice /C NY /N
if errorlevel 2 (
goto EndLang
) else (
mkdir "!BackupDir!\halo1\maps"
mkdir "!BackupDir!\halo1\prebuild\paks"
mkdir "!BackupDir!\halo2\h2_maps_win64_dx11"
mkdir "!BackupDir!\halo3\maps"
mkdir "!BackupDir!\halo4\maps"
mkdir "!BackupDir!\haloreach\maps"

move /Y "!GameDir!\groundhog" "!BackupDir!\groundhog" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\beavercreek.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\bloodgulch.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\boardingaction.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\carousel.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\chillout.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\damnation.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\dangercanyon.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\deathisland.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\gephyrophobia.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\hangemhigh.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\icefields.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\infinity.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\longest.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\prisoner.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\putput.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\ratrace.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\sidewinder.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\timberland.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\maps\wizard.map" "!BackupDir!\halo1\maps\"
move /Y "!GameDir!\halo1\prebuild\paks\beavercreek*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\bloodgulch*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\boardingaction*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\carousel*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\chillout*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\damnation*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\dangercanyon*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\deathisland*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\gephyrophobia*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\hangemhigh*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\icefields*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\infinity*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\longest*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\prisoner*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\putput*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\ratrace*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\sidewinder*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\timberland*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo1\prebuild\paks\wizard*.*" "!BackupDir!\halo1\prebuild\paks\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\ascension.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\backwash.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\beavercreek.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\burial_mounds.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\coagulation.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\colossus.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\containment.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\cyclotron.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\deltatap.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\derelict.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\dune.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\elongation.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\foundation.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\gemini.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\headlong.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\highplains.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\lockout.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\midship.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\needle.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\street_sweeper.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\triplicate.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\turf.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\warlock.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\waterworks.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo2\h2_maps_win64_dx11\zanzibar.map" "!BackupDir!\halo2\h2_maps_win64_dx11\"
move /Y "!GameDir!\halo3\maps\armory.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\bunkerworld.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\chill.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\chillout.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\construct.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\cyberdyne.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\deadlock.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\descent.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\docks.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\fortress.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\ghosttown.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\guardian.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\isolation.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\lockout.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\midship.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\riverworld.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\s3d_edge.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\s3d_turf.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\s3d_waterfall.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\salvation.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\sandbox.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\shrine.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\sidewinder.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\snowbound.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\spacecamp.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\warehouse.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo3\maps\zanzibar.map" "!BackupDir!\halo3\maps\"
move /Y "!GameDir!\halo4\maps\ca_basin.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_blood_cavern.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_blood_crash.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_canyon.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_creeper.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_deadlycrossing.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_dropoff.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_forge_bonanza.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_forge_erosion.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_forge_ravine.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_gore_valley.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_highrise.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_port.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_rattler.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_redoubt.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_spiderweb.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_tower.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\ca_warhouse.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\dlc01_engine.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\dlc01_factory.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\dlc_dejewel.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\dlc_dejunkyard.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\dlc_forge_island.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\wraparound.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\z05_cliffside.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\z11_valhalla.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\halo4\maps\zd_02_grind.map" "!BackupDir!\halo4\maps\"
move /Y "!GameDir!\haloreach\maps\20_sword_slayer.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\30_settlement.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\35_island.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\45_aftship.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\45_launch_station.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\50_panopticon.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\52_ivory_tower.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\70_boneyard.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\cex_beaver_creek.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\cex_damnation.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\cex_hangemhigh.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\cex_headlong.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\cex_prisoner.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\cex_timberland.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\condemned.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\dlc_invasion.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\dlc_medium.map" "!BackupDir!\haloreach\maps\"
move /Y "!GameDir!\haloreach\maps\dlc_slayer.map" "!BackupDir!\haloreach\maps\"
goto EndLang
)


:EndLang
exit /B