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

set /A "count=195"
set "list.file[1]=BAR_Ending.mp4"
set "list.file[2]=CAS_Ending.mp4"
set "list.file[3]=CET_Ending.mp4"
set "list.file[4]=DVO_Ending.mp4"
set "list.file[5]=ERR_Ending.mp4"
set "list.file[6]=FRO_Ending.mp4"
set "list.file[7]=FUJ_Ending.mp4"
set "list.file[8]=JAC_Ending.mp4"
set "list.file[9]=JAD_Ending.mp4"
set "list.file[10]=JAX_Ending.mp4"
set "list.file[11]=JOH_Ending.mp4"
set "list.file[12]=JOK_Ending.mp4"
set "list.file[13]=KAB_Ending.mp4"
set "list.file[14]=KAN_Ending.mp4"
set "list.file[15]=KIT_Ending.mp4"
set "list.file[16]=KOL_Ending.mp4"
set "list.file[17]=KOT_Ending.mp4"
set "list.file[18]=Krypt_ShangTsung_Intro.mp4"
set "list.file[19]=KUN_Ending.mp4"
set "list.file[20]=Ladder_Ending.mp4"
set "list.file[21]=Ladder_Intro.mp4"
set "list.file[22]=LIU_Ending.mp4"
set "list.file[23]=MK11_001_003.mp4"
set "list.file[24]=MK11_004_015.mp4"
set "list.file[25]=MK11_016_023.mp4"
set "list.file[26]=MK11_024_028.mp4"
set "list.file[27]=MK11_029_043.mp4"
set "list.file[28]=MK11_044_045.mp4"
set "list.file[29]=MK11_046.mp4"
set "list.file[30]=MK11_047_048.mp4"
set "list.file[31]=MK11_049_053.mp4"
set "list.file[32]=mk11_049_053_demo.mp4"
set "list.file[33]=MK11_053_Choice.mp4"
set "list.file[34]=MK11_054KUN.mp4"
set "list.file[35]=MK11_054LIU.mp4"
set "list.file[36]=MK11_056.mp4"
set "list.file[37]=MK11_056_Choice.mp4"
set "list.file[38]=MK11_057KUN.mp4"
set "list.file[39]=MK11_057LIU.mp4"
set "list.file[40]=MK11_058KUN.mp4"
set "list.file[41]=MK11_058LIU.mp4"
set "list.file[42]=MK11_059_062.mp4"
set "list.file[43]=MK11_062_Choice.mp4"
set "list.file[44]=MK11_063KUN.mp4"
set "list.file[45]=MK11_063LIU.mp4"
set "list.file[46]=MK11_064KUN.mp4"
set "list.file[47]=MK11_064LIU.mp4"
set "list.file[48]=MK11_065.mp4"
set "list.file[49]=MK11_065_Choice.mp4"
set "list.file[50]=MK11_066KUN.mp4"
set "list.file[51]=MK11_066LIU.mp4"
set "list.file[52]=MK11_067KUN.mp4"
set "list.file[53]=MK11_067LIU.mp4"
set "list.file[54]=MK11_068_074.mp4"
set "list.file[55]=MK11_074_Choice.mp4"
set "list.file[56]=MK11_075SCO.mp4"
set "list.file[57]=MK11_075SUB.mp4"
set "list.file[58]=MK11_076SCO.mp4"
set "list.file[59]=MK11_076SUB.mp4"
set "list.file[60]=MK11_077.mp4"
set "list.file[61]=MK11_077_Choice.mp4"
set "list.file[62]=MK11_078SCO.mp4"
set "list.file[63]=MK11_078SUB.mp4"
set "list.file[64]=MK11_080.mp4"
set "list.file[65]=MK11_080_Choice.mp4"
set "list.file[66]=MK11_081SCO.mp4"
set "list.file[67]=MK11_081SUB.mp4"
set "list.file[68]=MK11_083.mp4"
set "list.file[69]=MK11_083_Choice.mp4"
set "list.file[70]=MK11_084SCO.mp4"
set "list.file[71]=MK11_084SUB.mp4"
set "list.file[72]=MK11_086_094.mp4"
set "list.file[73]=MK11_095.mp4"
set "list.file[74]=MK11_096_100.mp4"
set "list.file[75]=MK11_101.mp4"
set "list.file[76]=MK11_102_106.mp4"
set "list.file[77]=MK11_107_112.mp4"
set "list.file[78]=MK11_113_117.mp4"
set "list.file[79]=MK11_118.mp4"
set "list.file[80]=MK11_119_127.mp4"
set "list.file[81]=MK11_128.mp4"
set "list.file[82]=MK11_129_130.mp4"
set "list.file[83]=MK11_131.mp4"
set "list.file[84]=MK11_132_136.mp4"
set "list.file[85]=MK11_137_139.mp4"
set "list.file[86]=MK11_140_142.mp4"
set "list.file[87]=MK11_143.mp4"
set "list.file[88]=MK11_144_147.mp4"
set "list.file[89]=MK11_147_Choice.mp4"
set "list.file[90]=MK11_148JAC.mp4"
set "list.file[91]=MK11_148JAX.mp4"
set "list.file[92]=MK11_149JAC.mp4"
set "list.file[93]=MK11_149JAX.mp4"
set "list.file[94]=MK11_150.mp4"
set "list.file[95]=MK11_150_Choice.mp4"
set "list.file[96]=MK11_151JAC.mp4"
set "list.file[97]=MK11_151JAX.mp4"
set "list.file[98]=MK11_153_154.mp4"
set "list.file[99]=MK11_154_Choice.mp4"
set "list.file[100]=MK11_155JAC.mp4"
set "list.file[101]=MK11_155JAX.mp4"
set "list.file[102]=MK11_156JAC.mp4"
set "list.file[103]=MK11_156JAX.mp4"
set "list.file[104]=MK11_157.mp4"
set "list.file[105]=MK11_158_159.mp4"
set "list.file[106]=MK11_159_Choice.mp4"
set "list.file[107]=MK11_160JAC.mp4"
set "list.file[108]=MK11_160JAX.mp4"
set "list.file[109]=MK11_161JAC.mp4"
set "list.file[110]=MK11_161JAX.mp4"
set "list.file[111]=MK11_162_168.mp4"
set "list.file[112]=MK11_169.mp4"
set "list.file[113]=MK11_170_171.mp4"
set "list.file[114]=MK11_172.mp4"
set "list.file[115]=MK11_173.mp4"
set "list.file[116]=MK11_174_187.mp4"
set "list.file[117]=MK11_188.mp4"
set "list.file[118]=MK11_189.mp4"
set "list.file[119]=MK11_190_197.mp4"
set "list.file[120]=MK11_198_216.mp4"
set "list.file[121]=MK11_217.mp4"
set "list.file[122]=MK11_218.mp4"
set "list.file[123]=MK11_219_222.mp4"
set "list.file[124]=MK11_223.mp4"
set "list.file[125]=MK11_224_225.mp4"
set "list.file[126]=MK11_226.mp4"
set "list.file[127]=MK11_227.mp4"
set "list.file[128]=MK11_228_229.mp4"
set "list.file[129]=MK11_230.mp4"
set "list.file[130]=MK11_300_302.mp4"
set "list.file[131]=MK11_303_309.mp4"
set "list.file[132]=MK11_310.mp4"M
set "list.file[133]=MK11_311_313.mp4"
set "list.file[134]=MK11_314.mp4"
set "list.file[135]=MK11_315_317.mp4"
set "list.file[136]=MK11_318.mp4"
set "list.file[137]=MK11_319.mp4"
set "list.file[138]=MK11_320_321.mp4"
set "list.file[139]=MK11_322.mp4"
set "list.file[140]=MK11_323_325.mp4"
set "list.file[141]=MK11_326_327.mp4"
set "list.file[142]=MK11_328.mp4"
set "list.file[143]=MK11_329_330.mp4"
set "list.file[144]=MK11_331_333.mp4"
set "list.file[145]=MK11_334.mp4"
set "list.file[146]=MK11_335_338.mp4"
set "list.file[147]=MK11_339_340.mp4"
set "list.file[148]=MK11_340_CHOICE.mp4"
set "list.file[149]=MK11_341SHA.mp4"
set "list.file[150]=MK11_341SIN.mp4"
set "list.file[151]=MK11_342SHA.mp4"
set "list.file[152]=MK11_342SIN.mp4"
set "list.file[153]=MK11_343_345.mp4"
set "list.file[154]=MK11_346SHA.mp4"
set "list.file[155]=MK11_346SIN.mp4"
set "list.file[156]=MK11_347SHA.mp4"
set "list.file[157]=MK11_347SIN.mp4"
set "list.file[158]=MK11_348.mp4"
set "list.file[159]=MK11_348_CHOICE.mp4"
set "list.file[160]=MK11_349SHA.mp4"
set "list.file[161]=MK11_349SIN.mp4"
set "list.file[162]=MK11_350SHA.mp4"
set "list.file[163]=MK11_350SIN.mp4"
set "list.file[164]=MK11_351_355.mp4"
set "list.file[165]=MK11_356SHA.mp4"
set "list.file[166]=MK11_356SIN.mp4"
set "list.file[167]=MK11_357SHA.mp4"
set "list.file[168]=MK11_357SIN.mp4"
set "list.file[169]=MK11_358.mp4"
set "list.file[170]=MK11_359SHA.mp4"
set "list.file[171]=MK11_359SIN.mp4"
set "list.file[172]=MK11_361_369.mp4"
set "list.file[173]=MK11_370.mp4"
set "list.file[174]=MK11_371_374.mp4"
set "list.file[175]=MK11_375.mp4"
set "list.file[176]=MK11_376.mp4"
set "list.file[177]=MK11_377LIU.mp4"
set "list.file[178]=MK11_377SHT.mp4"
set "list.file[179]=MK11_378LIU_380LIU.mp4"
set "list.file[180]=MK11_378SHT_379SHT.mp4"
set "list.file[181]=nit_ending.mp4"
set "list.file[182]=NOO_Ending.mp4"
set "list.file[183]=RAI_Ending.mp4"
set "list.file[184]=ROB_Ending.mp4"
set "list.file[185]=SCO_Ending.mp4"
set "list.file[186]=SHA_Ending.mp4"
set "list.file[187]=SHE_Ending.mp4"
set "list.file[188]=SHT_Ending.mp4"
set "list.file[189]=SIN_Ending.mp4"
set "list.file[190]=SKA_Ending.mp4"
set "list.file[191]=SON_Ending.mp4"
set "list.file[192]=SPA_Ending.mp4"
set "list.file[193]=SUB_Ending.mp4"
set "list.file[194]=TER_Ending.mp4"
set "list.file[195]=trm_ending.mp4"


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
echo. 2 = German
echo. 3 = French
echo. 4 = Italian
echo. 5 = Spanish Mexico
echo. 6 = Portuguese Brazil
echo.

set /p langchoice=
if "%langchoice%"=="" goto LangChoice
if "%langchoice%"=="0" goto EndLang
if "%langchoice%"=="1" goto English
if "%langchoice%"=="2" goto German
if "%langchoice%"=="3" goto French
if "%langchoice%"=="4" goto Italian
if "%langchoice%"=="5" goto PortugueseBrazil
if "%langchoice%"=="6" goto SpanishMexico


:English
mkdir "!BackupDir!\Asset"
move /Y "!GameDir!\Asset\*_FRA.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_GER.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_ITA.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_POR.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_SPA.*" "!BackupDir!\Asset\"
if "!removelangmov!"=="true" (
	mkdir "!BackupDir!\Movies"
	move /Y "!GameDir!\Movies\*.scx" "!BackupDir!\Movies\"
	ren "!BackupDir!\Movies\*.scx" "*.mp4"
	for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -i "!BackupDir!\Movies\%%~a" -map 0:0 -map 0:1 -acodec copy -vcodec copy "!GameDir!\Movies\%%~nxa"
	ren "!BackupDir!\Movies\*.mp4" "*.scx"
	move /Y "!BackupDir!\Movies\ChSelectAllScenes.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\ChSelectAllScenes_DLC.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Crawl.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio_DLC.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\StudioLogos.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_345_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_355_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_358_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_360SHA.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_376_CHOICE.scx" "!GameDir!\Movies\"
	ren "!GameDir!\Movies\*.mp4" "*.scx"
	goto EndLang
)
goto EndLang


:French
mkdir "!BackupDir!\Asset"
move /Y "!GameDir!\Asset\*_ENG.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_GER.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_ITA.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_POR.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_SPA.*" "!BackupDir!\Asset\"
if "!removelangmov!"=="true" (
	mkdir "!BackupDir!\Movies"
	move /Y "!GameDir!\Movies\*.scx" "!BackupDir!\Movies\"
	ren "!BackupDir!\Movies\*.scx" "*.mp4"
	for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -i "!BackupDir!\Movies\%%~a" -map 0:0 -map 0:2 -acodec copy -vcodec copy "!GameDir!\Movies\%%~nxa"
	ren "!BackupDir!\Movies\*.mp4" "*.scx"
	move /Y "!BackupDir!\Movies\ChSelectAllScenes.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\ChSelectAllScenes_DLC.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Crawl.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio_DLC.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\StudioLogos.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_345_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_355_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_358_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_360SHA.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_376_CHOICE.scx" "!GameDir!\Movies\"
	ren "!GameDir!\Movies\*.mp4" "*.scx"
	goto EndLang
)
goto EndLang


:German
mkdir "!BackupDir!\Asset"
move /Y "!GameDir!\Asset\*_ENG.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_FRA.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_ITA.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_POR.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_SPA.*" "!BackupDir!\Asset\"
if "!removelangmov!"=="true" (
	mkdir "!BackupDir!\Movies"
	move /Y "!GameDir!\Movies\*.scx" "!BackupDir!\Movies\"
	ren "!BackupDir!\Movies\*.scx" "*.mp4"
	for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -i "!BackupDir!\Movies\%%~a" -map 0:0 -map 0:3 -acodec copy -vcodec copy "!GameDir!\Movies\%%~nxa"
	ren "!BackupDir!\Movies\*.mp4" "*.scx"
	move /Y "!BackupDir!\Movies\ChSelectAllScenes.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\ChSelectAllScenes_DLC.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Crawl.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio_DLC.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\StudioLogos.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_345_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_355_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_358_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_360SHA.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_376_CHOICE.scx" "!GameDir!\Movies\"
	ren "!GameDir!\Movies\*.mp4" "*.scx"
	goto EndLang
)
goto EndLang


:Italian
mkdir "!BackupDir!\Asset"
move /Y "!GameDir!\Asset\*_ENG.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_FRA.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_GER.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_POR.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_SPA.*" "!BackupDir!\Asset\"
if "!removelangmov!"=="true" (
	mkdir "!BackupDir!\Movies"
	move /Y "!GameDir!\Movies\*.scx" "!BackupDir!\Movies\"
	ren "!BackupDir!\Movies\*.scx" "*.mp4"
	for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -i "!BackupDir!\Movies\%%~a" -map 0:0 -map 0:4 -acodec copy -vcodec copy "!GameDir!\Movies\%%~nxa"
	ren "!BackupDir!\Movies\*.mp4" "*.scx"
	move /Y "!BackupDir!\Movies\ChSelectAllScenes.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\ChSelectAllScenes_DLC.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Crawl.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio_DLC.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\StudioLogos.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_345_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_355_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_358_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_360SHA.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_376_CHOICE.scx" "!GameDir!\Movies\"
	ren "!GameDir!\Movies\*.mp4" "*.scx"
	goto EndLang
)
goto EndLang


:PortugueseBrazil
mkdir "!BackupDir!\Asset"
move /Y "!GameDir!\Asset\*_ENG.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_FRA.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_GER.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_ITA.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_SPA.*" "!BackupDir!\Asset\"
if "!removelangmov!"=="true" (
	mkdir "!BackupDir!\Movies"
	move /Y "!GameDir!\Movies\*.scx" "!BackupDir!\Movies\"
	ren "!BackupDir!\Movies\*.scx" "*.mp4"
	for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -i "!BackupDir!\Movies\%%~a" -map 0:0 -map 0:5 -acodec copy -vcodec copy "!GameDir!\Movies\%%~nxa"
	ren "!BackupDir!\Movies\*.mp4" "*.scx"
	move /Y "!BackupDir!\Movies\ChSelectAllScenes.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\ChSelectAllScenes_DLC.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Crawl.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio_DLC.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\StudioLogos.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_345_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_355_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_358_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_360SHA.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_376_CHOICE.scx" "!GameDir!\Movies\"
	ren "!GameDir!\Movies\*.mp4" "*.scx"
	goto EndLang
)
goto EndLang


:SpanishMexico
mkdir "!BackupDir!\Asset"
move /Y "!GameDir!\Asset\*_ENG.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_FRA.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_GER.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_ITA.*" "!BackupDir!\Asset\"
move /Y "!GameDir!\Asset\*_POR.*" "!BackupDir!\Asset\"
if "!removelangmov!"=="true" (
	mkdir "!BackupDir!\Movies"
	move /Y "!GameDir!\Movies\*.scx" "!BackupDir!\Movies\"
	ren "!BackupDir!\Movies\*.scx" "*.mp4"
	for /L %%i in (1, 1, !count!) do for %%a in ("!list.file[%%i]!") do "!MainDir!\ffmpeg" -i "!BackupDir!\Movies\%%~a" -map 0:0 -map 0:6 -acodec copy -vcodec copy "!GameDir!\Movies\%%~nxa"
	ren "!BackupDir!\Movies\*.mp4" "*.scx"
	move /Y "!BackupDir!\Movies\ChSelectAllScenes.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\ChSelectAllScenes_DLC.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Crawl.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio_DLC.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\StudioLogos.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_345_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_355_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_358_CHOICE.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_360SHA.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\MK11_376_CHOICE.scx" "!GameDir!\Movies\"
	ren "!GameDir!\Movies\*.mp4" "*.scx"
	goto EndLang
)
goto EndLang


:EndLang
endlocal
exit /B