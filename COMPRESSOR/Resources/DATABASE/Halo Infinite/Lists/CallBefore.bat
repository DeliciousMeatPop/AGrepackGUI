@echo off
title DiskSpan GUI Compressor
setlocal EnableDelayedExpansion EnableExtensions

cd /D "%~dp0"
if "%~3" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~3") do ( set "GameDir=%%~fa" && set "BackupDir=%%~fa (Backup)") ) else ( endlocal && exit /B )


:HiresFiles
cls
echo.
echo.----------------------------------------------------------------------
echo. Do you want to use HiRes files? [Y/N]
echo.
echo. Backup files will be made here:
echo. !BackupDir!\
echo.----------------------------------------------------------------------
choice /C NY /N
if errorlevel 2 (
	goto LangChoice
) else (
	mkdir "!BackupDir!\deploy\pc\compositions\narrative\mp\mp_02"
	mkdir "!BackupDir!\deploy\pc\globals"
	mkdir "!BackupDir!\deploy\pc\levels\multi\academy_weapon_drills"
	mkdir "!BackupDir!\deploy\pc\levels\multi\btb_drydock"
	mkdir "!BackupDir!\deploy\pc\levels\multi\btb_fragmentation"
	mkdir "!BackupDir!\deploy\pc\levels\multi\btb_highpower"
	mkdir "!BackupDir!\deploy\pc\levels\multi\catalyst"
	mkdir "!BackupDir!\deploy\pc\levels\multi\ctf_aquarius"
	mkdir "!BackupDir!\deploy\pc\levels\multi\ctf_bazaar"
	mkdir "!BackupDir!\deploy\pc\levels\multi\ctf_breaker"
	mkdir "!BackupDir!\deploy\pc\levels\multi\sgh_blueprint"
	mkdir "!BackupDir!\deploy\pc\levels\multi\sgh_streets"
	mkdir "!BackupDir!\deploy\pc\levels\multi\va_behemoth"
	mkdir "!BackupDir!\deploy\pc\levels\multi\va_launchsite"
	mkdir "!BackupDir!\deploy\pc\levels\ui\mainmenu"
	mkdir "!BackupDir!\videos"
	mkdir "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_banished_ship"
	mkdir "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_boss_hq_interior"
	mkdir "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_cortana_palace"
	mkdir "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_forerunner_austin"
	mkdir "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_forerunner_dallas"
	mkdir "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_spire_02"
	mkdir "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_underbelly"
	mkdir "!BackupDir!\deploy\pc\levels\campaign\ring01\island01"

	move /Y "!GameDir!\deploy\pc\compositions\narrative\mp\mp_02\*.module_hd1" "!BackupDir!\deploy\pc\compositions\narrative\mp\mp_02\"
	move /Y "!GameDir!\deploy\pc\globals\forge\*.module_hd1" "!BackupDir!\deploy\pc\globals\forge\"
	move /Y "!GameDir!\deploy\pc\globals\*.module_hd1" "!BackupDir!\deploy\pc\globals\"
	move /Y "!GameDir!\deploy\pc\levels\multi\academy_weapon_drills\*.module_hd1" "!BackupDir!\deploy\pc\levels\multi\academy_weapon_drills\"
	move /Y "!GameDir!\deploy\pc\levels\multi\btb_drydock\*.module_hd1" "!BackupDir!\deploy\pc\levels\multi\btb_drydock\"
	move /Y "!GameDir!\deploy\pc\levels\multi\btb_fragmentation\*.module_hd1" "!BackupDir!\deploy\pc\levels\multi\btb_fragmentation\"
	move /Y "!GameDir!\deploy\pc\levels\multi\btb_highpower\*.module_hd1" "!BackupDir!\deploy\pc\levels\multi\btb_highpower\"
	move /Y "!GameDir!\deploy\pc\levels\multi\catalyst\*.module_hd1" "!BackupDir!\deploy\pc\levels\multi\catalyst\"
	move /Y "!GameDir!\deploy\pc\levels\multi\ctf_aquarius\*.module_hd1" "!BackupDir!\deploy\pc\levels\multi\ctf_aquarius\"
	move /Y "!GameDir!\deploy\pc\levels\multi\ctf_bazaar\*.module_hd1" "!BackupDir!\deploy\pc\levels\multi\ctf_bazaar\"
	move /Y "!GameDir!\deploy\pc\levels\multi\ctf_breaker\*.module_hd1" "!BackupDir!\deploy\pc\levels\multi\ctf_breaker\"
	move /Y "!GameDir!\deploy\pc\levels\multi\sgh_blueprint\*.module_hd1" "!BackupDir!\deploy\pc\levels\multi\sgh_blueprint\"
	move /Y "!GameDir!\deploy\pc\levels\multi\sgh_streets\*.module_hd1" "!BackupDir!\deploy\pc\levels\multi\sgh_streets\"
	move /Y "!GameDir!\deploy\pc\levels\multi\va_behemoth\*.module_hd1" "!BackupDir!\deploy\pc\levels\multi\va_behemoth\"
	move /Y "!GameDir!\deploy\pc\levels\multi\va_launchsite\*.module_hd1" "!BackupDir!\deploy\pc\levels\multi\va_launchsite\"
	move /Y "!GameDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_banished_ship\*.module_hd1" "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_banished_ship\"
	move /Y "!GameDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_boss_hq_interior\*.module_hd1" "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_boss_hq_interior\"
	move /Y "!GameDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_cortana_palace\*.module_hd1" "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_cortana_palace\"
	move /Y "!GameDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_forerunner_austin\*.module_hd1" "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_forerunner_austin\"
	move /Y "!GameDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_forerunner_dallas\*.module_hd1" "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_forerunner_dallas\"
	move /Y "!GameDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_spire_02\*.module_hd1" "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_spire_02\"
	move /Y "!GameDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_underbelly\*.module_hd1" "!BackupDir!\deploy\pc\levels\campaign\ring01\dungeons\dungeon_underbelly\"
	move /Y "!GameDir!\deploy\pc\levels\campaign\ring01\island01\*.module_hd1" "!BackupDir!\deploy\pc\levels\campaign\ring01\island01\"
	move /Y "!GameDir!\deploy\pc\levels\ui\mainmenu\*.module_hd1" "!BackupDir!\deploy\pc\levels\ui\mainmenu\"
	move /Y "!GameDir!\videos\*-2160.mp4" "!BackupDir!\videos\"
	TIMEOUT 1
)


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
echo. 6 = SPANISH (MEXICO)
echo. 7 = PORTUGUESE (BRAZIL)
echo. 8 = JAPANESE
echo. 9 = KOREAN
echo. 10 = CHINESE (TAIWAN)
echo. 11 = CHINESE (SIMPLIFIED)
echo.

set "LangCount=11"
set "Lang.Name[1]=English(US)"
set "Lang.Name[2]=French(France)"
set "Lang.Name[3]=German"
set "Lang.Name[4]=Italian"
set "Lang.Name[5]=Spanish(Spain)"
set "Lang.Name[6]=Spanish(Mexico)"
set "Lang.Name[7]=Portuguese(Brazil)"
set "Lang.Name[8]=Japanese"
set "Lang.Name[9]=Korean"
set "Lang.Name[10]=Chinese(Taiwan)"
set "Lang.Name[11]=Chinese(PRC)"

set "SetLang=unknown"
set /P "LangChoice="
if "!LangChoice!" EQU "" goto LangChoice
if "!LangChoice!" EQU "0" goto EndLang
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
if /I "!SetLang!" EQU "unknown" goto LangChoice

mkdir "!BackupDir!\Sound\win"
for /L %%i in (1, 1, !LangCount!) do if /I "!SetLang!" NEQ "!Lang.Name[%%i]!" (
	move /Y "!GameDir!\Sound\win\!Lang.Name[%%i]!" "!BackupDir!\Sound\win\!Lang.Name[%%i]!"
)
goto EndLang


:EndLang
exit /B