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


:English
mkdir "!BackupDir!\datas\movie\cp03\jp"
mkdir "!BackupDir!\datas\movie\cp06\jp"
mkdir "!BackupDir!\datas\movie\cp09\jp"
mkdir "!BackupDir!\datas\movie\cp90\jp"
mkdir "!BackupDir!\datas\movie\dlc_ex\jp"
mkdir "!BackupDir!\datas\movie\ep1\jp"
mkdir "!BackupDir!\datas\movie\ep2\jp"
mkdir "!BackupDir!\datas\movie\ep3\jp"
mkdir "!BackupDir!\datas\movie\ep4\jp"
mkdir "!BackupDir!\datas\movie\ful\jp"
mkdir "!BackupDir!\datas\movie\movie_team\jp"
mkdir "!BackupDir!\datas\movie\multi\jp"

move /Y "!GameDir!\datas\movie\cp03\jp\cp03_03lvs_05_pc.bk2" "!BackupDir!\datas\movie\cp03\jp\"
move /Y "!GameDir!\datas\movie\cp03\jp\cp03_03lvs_30_pc.bk2" "!BackupDir!\datas\movie\cp03\jp\"
move /Y "!GameDir!\datas\movie\cp06\jp\cp06_01one_11_pc.bk2" "!BackupDir!\datas\movie\cp06\jp\"
move /Y "!GameDir!\datas\movie\cp09\jp\cp09_04cmp_10_pc.bk2" "!BackupDir!\datas\movie\cp09\jp\"
move /Y "!GameDir!\datas\movie\cp90\jp\cp90_00kid_10_pc.bk2" "!BackupDir!\datas\movie\cp90\jp\"
move /Y "!GameDir!\datas\movie\cp90\jp\cp90_00kid_30_pc.bk2" "!BackupDir!\datas\movie\cp90\jp\"
move /Y "!GameDir!\datas\movie\cp90\jp\cp90_00lun_20_pc.bk2" "!BackupDir!\datas\movie\cp90\jp\"
move /Y "!GameDir!\datas\movie\cp90\jp\cp90_00nfl_10_pc.bk2" "!BackupDir!\datas\movie\cp90\jp\"
move /Y "!GameDir!\datas\movie\cp90\jp\cp90_00nfl_20_pc.bk2" "!BackupDir!\datas\movie\cp90\jp\"
move /Y "!GameDir!\datas\movie\cp90\jp\cp90_01kid_10_pc.bk2" "!BackupDir!\datas\movie\cp90\jp\"
move /Y "!GameDir!\datas\movie\cp90\jp\cp90_01kid_20_pc.bk2" "!BackupDir!\datas\movie\cp90\jp\"
move /Y "!GameDir!\datas\movie\cp90\jp\cp90_01kid_30_pc.bk2" "!BackupDir!\datas\movie\cp90\jp\"
move /Y "!GameDir!\datas\movie\cp90\jp\cp90_01kid_40.bk2" "!BackupDir!\datas\movie\cp90\jp\"
move /Y "!GameDir!\datas\movie\dlc_ex\jp\cp11_01siv_15_6shin_01_pc.bk2" "!BackupDir!\datas\movie\dlc_ex\jp\"
move /Y "!GameDir!\datas\movie\dlc_ex\jp\cp11_01siv_15_6shin_02_pc.bk2" "!BackupDir!\datas\movie\dlc_ex\jp\"
move /Y "!GameDir!\datas\movie\dlc_ex\jp\cp13_02rvs_10_pc.bk2" "!BackupDir!\datas\movie\dlc_ex\jp\"
move /Y "!GameDir!\datas\movie\dlc_ex\jp\cp90_01kid_50_6shin.bk2" "!BackupDir!\datas\movie\dlc_ex\jp\"
move /Y "!GameDir!\datas\movie\ep1\jp\sc_ep1_plot01_99_a_copy_pc.bk2" "!BackupDir!\datas\movie\ep1\jp\"
move /Y "!GameDir!\datas\movie\ep1\jp\sc_ep1_plot01_99_copy_pc.bk2" "!BackupDir!\datas\movie\ep1\jp\"
move /Y "!GameDir!\datas\movie\ep2\jp\epi01_alt_005_pc.bk2" "!BackupDir!\datas\movie\ep2\jp\"
move /Y "!GameDir!\datas\movie\ep2\jp\epi01_prg_010_pc.bk2" "!BackupDir!\datas\movie\ep2\jp\"
move /Y "!GameDir!\datas\movie\ep2\jp\epi03_cmp_010_pc.bk2" "!BackupDir!\datas\movie\ep2\jp\"
move /Y "!GameDir!\datas\movie\ep2\jp\epi03_stf_010_pc.bk2" "!BackupDir!\datas\movie\ep2\jp\"
move /Y "!GameDir!\datas\movie\ep2\jp\epi04_ifb_010_pc.bk2" "!BackupDir!\datas\movie\ep2\jp\"
move /Y "!GameDir!\datas\movie\ep2\jp\epi04_ifz_010_pc.bk2" "!BackupDir!\datas\movie\ep2\jp\"
move /Y "!GameDir!\datas\movie\ep3\jp\epp00_opn_040_pc.bk2" "!BackupDir!\datas\movie\ep3\jp\"
move /Y "!GameDir!\datas\movie\ep3\jp\epp03_cnp_030_pc.bk2" "!BackupDir!\datas\movie\ep3\jp\"
move /Y "!GameDir!\datas\movie\ep3\jp\epp05_end_050_pc.bk2" "!BackupDir!\datas\movie\ep3\jp\"
move /Y "!GameDir!\datas\movie\ep4\jp\epa01_flw_010.bk2" "!BackupDir!\datas\movie\ep4\jp\"
move /Y "!GameDir!\datas\movie\ep4\jp\epa01_mkg_043.bk2" "!BackupDir!\datas\movie\ep4\jp\"
move /Y "!GameDir!\datas\movie\ep4\jp\epa02_flw_010.bk2" "!BackupDir!\datas\movie\ep4\jp\"
move /Y "!GameDir!\datas\movie\ep4\jp\epa03_ins_010.bk2" "!BackupDir!\datas\movie\ep4\jp\"
move /Y "!GameDir!\datas\movie\ep4\jp\epa04_flw_030.bk2" "!BackupDir!\datas\movie\ep4\jp\"
move /Y "!GameDir!\datas\movie\ep4\jp\epa04_thr_050.bk2" "!BackupDir!\datas\movie\ep4\jp\"
move /Y "!GameDir!\datas\movie\ful\jp\gt01_01ins_10.bk2" "!BackupDir!\datas\movie\ful\jp\"
move /Y "!GameDir!\datas\movie\movie_team\jp\*.bk2" "!BackupDir!\datas\movie\movie_team\jp\"
move /Y "!GameDir!\datas\movie\multi\jp\mp01_01opn_10.bk2" "!BackupDir!\datas\movie\multi\jp\"
move /Y "!GameDir!\datas\movie\multi\jp\mp01_06ham_10.bk2" "!BackupDir!\datas\movie\multi\jp\"

move /Y "!GameDir!\datas\movie\cp03\us\*.bk2" "!GameDir!\datas\movie\cp03\jp\"
move /Y "!GameDir!\datas\movie\cp06\us\*.bk2" "!GameDir!\datas\movie\cp06\jp\"
move /Y "!GameDir!\datas\movie\cp09\us\*.bk2" "!GameDir!\datas\movie\cp09\jp\"
move /Y "!GameDir!\datas\movie\cp90\us\*.bk2" "!GameDir!\datas\movie\cp90\jp\"
move /Y "!GameDir!\datas\movie\dlc_ex\us\*.bk2" "!GameDir!\datas\movie\dlc_ex\jp\"
move /Y "!GameDir!\datas\movie\ep1\us\*.bk2" "!GameDir!\datas\movie\ep1\jp\"
move /Y "!GameDir!\datas\movie\ep2\us\*.bk2" "!GameDir!\datas\movie\ep2\jp\"
move /Y "!GameDir!\datas\movie\ep3\us\*.bk2" "!GameDir!\datas\movie\ep3\jp\"
move /Y "!GameDir!\datas\movie\ep4\us\*.bk2" "!GameDir!\datas\movie\ep4\jp\"
move /Y "!GameDir!\datas\movie\ful\us\*.bk2" "!GameDir!\datas\movie\ful\jp\"
move /Y "!GameDir!\datas\movie\movie_team\us\*.bk2" "!GameDir!\datas\movie\movie_team\jp\"
move /Y "!GameDir!\datas\movie\multi\us\*.bk2" "!GameDir!\datas\movie\multi\jp\"
goto EndLang


:Japanese
mkdir "!BackupDir!\datas\movie\cp03\us"
mkdir "!BackupDir!\datas\movie\cp06\us"
mkdir "!BackupDir!\datas\movie\cp09\us"
mkdir "!BackupDir!\datas\movie\cp90\us"
mkdir "!BackupDir!\datas\movie\dlc_ex\us"
mkdir "!BackupDir!\datas\movie\ep1\us"
mkdir "!BackupDir!\datas\movie\ep2\us"
mkdir "!BackupDir!\datas\movie\ep3\us"
mkdir "!BackupDir!\datas\movie\ep4\us"
mkdir "!BackupDir!\datas\movie\ful\us"
mkdir "!BackupDir!\datas\movie\movie_team\us"
mkdir "!BackupDir!\datas\movie\multi\us"

move /Y "!GameDir!\datas\movie\cp03\us\*.bk2" "!BackupDir!\datas\movie\cp03\us\"
move /Y "!GameDir!\datas\movie\cp06\us\*.bk2" "!BackupDir!\datas\movie\cp06\us\"
move /Y "!GameDir!\datas\movie\cp09\us\*.bk2" "!BackupDir!\datas\movie\cp09\us\"
move /Y "!GameDir!\datas\movie\cp90\us\*.bk2" "!BackupDir!\datas\movie\cp90\us\"
move /Y "!GameDir!\datas\movie\dlc_ex\us\*.bk2" "!BackupDir!\datas\movie\dlc_ex\us\"
move /Y "!GameDir!\datas\movie\ep1\us\*.bk2" "!BackupDir!\datas\movie\ep1\us\"
move /Y "!GameDir!\datas\movie\ep2\us\*.bk2" "!BackupDir!\datas\movie\ep2\us\"
move /Y "!GameDir!\datas\movie\ep3\us\*.bk2" "!BackupDir!\datas\movie\ep3\us\"
move /Y "!GameDir!\datas\movie\ep4\us\*.bk2" "!BackupDir!\datas\movie\ep4\us\"
move /Y "!GameDir!\datas\movie\ful\us\*.bk2" "!BackupDir!\datas\movie\ful\us\"
move /Y "!GameDir!\datas\movie\movie_team\us\*.bk2" "!BackupDir!\datas\movie\movie_team\us\"
move /Y "!GameDir!\datas\movie\multi\us\*.bk2" "!BackupDir!\datas\movie\multi\us\"
goto EndLang


:EndLang
endlocal
exit /b