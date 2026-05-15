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

set /A "count=188"
set "list.file[1]=DC2_001_012.mp4"
set "list.file[2]=DC2_001_012_Press.mp4"
set "list.file[3]=DC2_013_014.mp4"
set "list.file[4]=DC2_015_016.mp4"
set "list.file[5]=DC2_017.mp4"
set "list.file[6]=DC2_018_022.mp4"
set "list.file[7]=DC2_018_022_Press.mp4"
set "list.file[8]=DC2_023.mp4"
set "list.file[9]=DC2_024_025.mp4"
set "list.file[10]=DC2_027.mp4"
set "list.file[11]=DC2_028_035.mp4"
set "list.file[12]=DC2_035_Choice.mp4"
set "list.file[13]=DC2_035BC_PRE.mp4"
set "list.file[14]=DC2_035GA_PRE.mp4"
set "list.file[15]=DC2_036.mp4"
set "list.file[16]=DC2_036_Choice.mp4"
set "list.file[17]=DC2_036BC_PRE.mp4"
set "list.file[18]=DC2_036BC_PST.mp4"
set "list.file[19]=DC2_036GA_PRE.mp4"
set "list.file[20]=DC2_036GA_PST.mp4"
set "list.file[21]=DC2_037.mp4"
set "list.file[22]=DC2_037_Choice.mp4"
set "list.file[23]=DC2_037BC_PRE.mp4"
set "list.file[24]=DC2_037BC_PST.mp4"
set "list.file[25]=DC2_037GA_PRE.mp4"
set "list.file[26]=DC2_037GA_PST.mp4"
set "list.file[27]=DC2_038_039.mp4"
set "list.file[28]=DC2_038BC_PST.mp4"
set "list.file[29]=DC2_038GA_PST.mp4"
set "list.file[30]=DC2_039_Choice.mp4"
set "list.file[31]=DC2_039BC_PRE.mp4"
set "list.file[32]=DC2_039GA_PRE.mp4"
set "list.file[33]=DC2_040_057.mp4"
set "list.file[34]=DC2_040BC_PST.mp4"
set "list.file[35]=DC2_040GA_PST.mp4"
set "list.file[36]=DC2_058_058B.mp4"
set "list.file[37]=DC2_059_061.mp4"
set "list.file[38]=DC2_062.mp4"
set "list.file[39]=DC2_063_066.mp4"
set "list.file[40]=DC2_067_069.mp4"
set "list.file[41]=DC2_070_071.mp4"
set "list.file[42]=DC2_072.mp4"
set "list.file[43]=DC2_073_083.mp4"
set "list.file[44]=DC2_083_Choice.mp4"
set "list.file[45]=DC2_084BB.mp4"
set "list.file[46]=DC2_084FS.mp4"
set "list.file[47]=DC2_085BB.mp4"
set "list.file[48]=DC2_085FS.mp4"
set "list.file[49]=DC2_086.mp4"
set "list.file[50]=DC2_086_Choice.mp4"
set "list.file[51]=DC2_087BB.mp4"
set "list.file[52]=DC2_087FS.mp4"
set "list.file[53]=DC2_088FS.mp4"
set "list.file[54]=DC2_089_093.mp4"
set "list.file[55]=DC2_093_Choice.mp4"
set "list.file[56]=DC2_094BB.mp4"
set "list.file[57]=DC2_094FS.mp4"
set "list.file[58]=DC2_095BB.mp4"
set "list.file[59]=DC2_095FS.mp4"
set "list.file[60]=DC2_096.mp4"
set "list.file[61]=DC2_096_Choice.mp4"
set "list.file[62]=DC2_097BB.mp4"
set "list.file[63]=DC2_097FS.mp4"
set "list.file[64]=DC2_098BB.mp4"
set "list.file[65]=DC2_098FS.mp4"
set "list.file[66]=DC2_099_103.mp4"
set "list.file[67]=DC2_103_Choice.mp4"
set "list.file[68]=DC2_104CW.mp4"
set "list.file[69]=DC2_104CY.mp4"
set "list.file[70]=DC2_105CW.mp4"
set "list.file[71]=DC2_105CY.mp4"
set "list.file[72]=DC2_106.mp4"
set "list.file[73]=DC2_106_Choice.mp4"
set "list.file[74]=DC2_107CW.mp4"
set "list.file[75]=DC2_107CY.mp4"
set "list.file[76]=DC2_108CW.mp4"
set "list.file[77]=DC2_108CY.mp4"
set "list.file[78]=DC2_109_111.mp4"
set "list.file[79]=DC2_111_Choice.mp4"
set "list.file[80]=DC2_112CW.mp4"
set "list.file[81]=DC2_112CY.mp4"
set "list.file[82]=DC2_113CW.mp4"
set "list.file[83]=DC2_113CY.mp4"
set "list.file[84]=DC2_114_115.mp4"
set "list.file[85]=DC2_115_Choice.mp4"
set "list.file[86]=DC2_116CW.mp4"
set "list.file[87]=DC2_116CY.mp4"
set "list.file[88]=DC2_117CW.mp4"
set "list.file[89]=DC2_117CY.mp4"
set "list.file[90]=DC2_118_122.mp4"
set "list.file[91]=Dc2_123.mp4"
set "list.file[92]=DC2_124_125.mp4"
set "list.file[93]=DC2_126_127.mp4"
set "list.file[94]=DC2_128.mp4"
set "list.file[95]=DC2_129_132.mp4"
set "list.file[96]=DC2_133.mp4"
set "list.file[97]=DC2_134.mp4"
set "list.file[98]=DC2_135_151.mp4"
set "list.file[99]=DC2_151_Choice.mp4"
set "list.file[100]=DC2_152AQ.mp4"
set "list.file[101]=DC2_152BA.mp4"
set "list.file[102]=DC2_153AQ.mp4"
set "list.file[103]=DC2_153BA.mp4"
set "list.file[104]=DC2_154.mp4"
set "list.file[105]=DC2_154_Choice.mp4"
set "list.file[106]=DC2_155AQ.mp4"
set "list.file[107]=DC2_155BA.mp4"
set "list.file[108]=DC2_157_159.mp4"
set "list.file[109]=DC2_159_Choice.mp4"
set "list.file[110]=DC2_160AQ.mp4"
set "list.file[111]=DC2_160BA.mp4"
set "list.file[112]=DC2_161AQ.mp4"
set "list.file[113]=DC2_161BA.mp4"
set "list.file[114]=DC2_162.mp4"
set "list.file[115]=DC2_162_Choice.mp4"
set "list.file[116]=DC2_163AQ.mp4"
set "list.file[117]=DC2_163BA.mp4"
set "list.file[118]=DC2_164AQ.mp4"
set "list.file[119]=DC2_164BA.mp4"
set "list.file[120]=DC2_165_175.mp4"
set "list.file[121]=DC2_175_Choice.mp4"
set "list.file[122]=DC2_176BM.mp4"
set "list.file[123]=DC2_176SU.mp4"
set "list.file[124]=DC2_177BM.mp4"
set "list.file[125]=DC2_177SU.mp4"
set "list.file[126]=DC2_178.mp4"
set "list.file[127]=DC2_178_Choice.mp4"
set "list.file[128]=DC2_179BM.mp4"
set "list.file[129]=DC2_179SU.mp4"
set "list.file[130]=DC2_181_182.mp4"
set "list.file[131]=DC2_182_Choice.mp4"
set "list.file[132]=DC2_183BM.mp4"
set "list.file[133]=DC2_183SU.mp4"
set "list.file[134]=DC2_185_187.mp4"
set "list.file[135]=DC2_188_197.mp4"
set "list.file[136]=DC2_198_203.mp4"
set "list.file[137]=DC2_203_Choice.mp4"
set "list.file[138]=DC2_204BM_205BM.mp4"
set "list.file[139]=DC2_204SU_207SU.mp4"
set "list.file[140]=DC2_206BM_208BM.mp4"
set "list.file[141]=DC2_208SU_211SU.mp4"
set "list.file[142]=DC2_209BM_211BM.mp4"
set "list.file[143]=DC2_212BM_213BM.mp4"
set "list.file[144]=DC2_212SU_214SU.mp4"
set "list.file[145]=DC2_214BM_215BM.mp4"
set "list.file[146]=DC2_215SU_216SU.mp4"
set "list.file[147]=DC2_217SU_219SU.mp4"
set "list.file[148]=DCF2_StudioLogos.mp4"
set "list.file[149]=Ending_AM.mp4"
set "list.file[150]=Ending_AQ.mp4"
set "list.file[151]=Ending_AT.mp4"
set "list.file[152]=Ending_BA.mp4"
set "list.file[153]=Ending_BB.mp4"
set "list.file[154]=Ending_BC.mp4"
set "list.file[155]=Ending_BM.mp4"
set "list.file[156]=Ending_BN.mp4"
set "list.file[157]=Ending_BR.mp4"
set "list.file[158]=Ending_CC.mp4"
set "list.file[159]=Ending_CH.mp4"
set "list.file[160]=Ending_CW.mp4"
set "list.file[161]=Ending_CY.mp4"
set "list.file[162]=Ending_DE.mp4"
set "list.file[163]=Ending_DF.mp4"
set "list.file[164]=Ending_DS.mp4"
set "list.file[165]=Ending_DW.mp4"
set "list.file[166]=Ending_EC.mp4"
set "list.file[167]=Ending_FL.mp4"
set "list.file[168]=Ending_FS.mp4"
set "list.file[169]=Ending_GA.mp4"
set "list.file[170]=Ending_GG.mp4"
set "list.file[171]=Ending_GL.mp4"
set "list.file[172]=Ending_HB.mp4"
set "list.file[173]=Ending_HQ.mp4"
set "list.file[174]=Ending_JK.mp4"
set "list.file[175]=Ending_Ladder.mp4"
set "list.file[176]=Ending_MN.mp4"
set "list.file[177]=Ending_NT.mp4"	
set "list.file[178]=Ending_PI.mp4"
set "list.file[179]=Ending_RA.mp4"
set "list.file[180]=Ending_RH.mp4"
set "list.file[181]=Ending_SC.mp4"
set "list.file[182]=Ending_SF.mp4"
set "list.file[183]=Ending_SG.mp4"
set "list.file[184]=Ending_ST.mp4"
set "list.file[185]=Ending_SU.mp4"
set "list.file[186]=Ending_SZ.mp4"
set "list.file[187]=Ending_WW.mp4"
set "list.file[188]=MultiverseIntro.mp4"

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
	move /Y "!BackupDir!\Movies\Credits_Crawl_Fr.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Crawl_Int.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio.scx" "!GameDir!\Movies\"
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
	move /Y "!BackupDir!\Movies\Credits_Crawl_Fr.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Crawl_Int.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio.scx" "!GameDir!\Movies\"
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
	move /Y "!BackupDir!\Movies\Credits_Crawl_Fr.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Crawl_Int.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio.scx" "!GameDir!\Movies\"
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
	move /Y "!BackupDir!\Movies\Credits_Crawl_Fr.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Crawl_Int.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio.scx" "!GameDir!\Movies\"
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
	move /Y "!BackupDir!\Movies\Credits_Crawl_Fr.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Crawl_Int.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio.scx" "!GameDir!\Movies\"
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
	move /Y "!BackupDir!\Movies\Credits_Crawl_Fr.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Crawl_Int.scx" "!GameDir!\Movies\"
	move /Y "!BackupDir!\Movies\Credits_Studio.scx" "!GameDir!\Movies\"
	ren "!GameDir!\Movies\*.mp4" "*.scx"
	goto EndLang
)
goto EndLang

:EndLang
endlocal
exit /B