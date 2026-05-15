@echo off
setlocal enabledelayedexpansion

set "CURRENT_DIR=%~dp0"
set "RESOURCE_DIR=%~dp0Resource"
set "SETUP_DIR=%~dp0Setup"
set "COMPRESSOR=%CURRENT_DIR%COMPRESSOR"
set "SAVE=%RESOURCE_DIR%\Save"
echo %CURRENT_DIR% > "%TEMP%\directory.tmp"
echo %SAVE% >  "%TEMP%\save.tmp"

if not exist "%SETUP_DIR%\Finish.bmp" (
    echo No Finish.bmp found in setup folder
    copy "%SETUP_DIR%\welcome.bmp" "%SETUP_DIR%\Finish.bmp" >nul 2>&1
    echo Welcome.bmp copied to Finish.bmp
    PAUSE
)

if exist "%RESOURCE_DIR%\FIRSTRUN.txt" (
    set /p "REPACKER_NAME=Enter Your Repacker Name: "
    echo !REPACKER_NAME! > "%SAVE%\repacker.txt"
    del "%RESOURCE_DIR%\FIRSTRUN.txt"
)


set /p "DIR=What Is The Games FULL Directory? "
set "DIR=!DIR:"=!"
echo %DIR% >  "%TEMP%\dir.tmp"

CLS
set /p "RENAME_ORIG=Do You Want The Original Files Renamed? (Yes/No) "
if /i "!RENAME_ORIG!"=="Yes" ( 
    call "%RESOURCE_DIR%\rename.ps1"
) else if /i "!RENAME_ORIG!"=="Y" (
    call "%RESOURCE_DIR%\rename.ps1"
)

CLS
set /p "SORT_DLC=Do You Want To format The Raw STEAMDB DLC Info In The DLC.txt? (Yes/No) "
if /i "!SORT_DLC!"=="Yes" ( 
    call "%RESOURCE_DIR%\sort_dlc.ps1"
) else if /i "!SORT_DLC!"=="Y" (
    call "%RESOURCE_DIR%\sort_dlc.ps1"
)

CLS
set /p "SETTINGS_READY=Is The Settings.ini Complete Already (in %SETUP_DIR%)?  (Yes/No) "
if /i "!SETTINGS_READY!"=="Yes" ( 
    echo If you need to change the build id or size do it now.
    pause
    move "%SETUP_DIR%\settings.ini" "%CURRENT_DIR%settings.ini"
    goto READY
) else if /i "!SETTINGS_READY!"=="Y" (
    echo If you need to change the build id or size do it now.
    pause
    move "%SETUP_DIR%\settings.ini" "%CURRENT_DIR%settings.ini"
    goto READY
)

CLS
set /p "GAME_TYPE=What Type Of Game Are You Repacking? (1 for VR, 2 for PC, 3 for VR Optional) "
if "!GAME_TYPE!"=="1" (
    copy /Y "%RESOURCE_DIR%\1.ini" "%CURRENT_DIR%settings.ini" >nul 2>&1
    call "%RESOURCE_DIR%\1.ps1"
) else if "!GAME_TYPE!"=="2" (
    copy /Y "%RESOURCE_DIR%\2.ini" "%CURRENT_DIR%settings.ini" >nul 2>&1
    call "%RESOURCE_DIR%\2.ps1"
) else if "!GAME_TYPE!"=="3" (
    copy /Y "%RESOURCE_DIR%\3.ini" "%CURRENT_DIR%settings.ini" >nul 2>&1
    call "%RESOURCE_DIR%\3.ps1"
)

:READY
CLS
ECHO Hit Any Key When You Are Ready To Compile.
ECHO If You Need To Customize Anything, Now Is The Time!
PAUSE

:NEXT
Echo.
Echo.
ECHO Compiling The Script! Preparing To Compress
Echo.
Echo.
call Compile_Script.bat

PAUSE
:TRYAGAIN
Echo.
Echo.
set /p "COMPRESSION=Enter Compression Preset (12, 8, 4, 0): "
echo %COMPRESSION% > "%TEMP%\preset.tmp"
if "%COMPRESSION%"=="12" (
    call "%RESOURCE_DIR%\12.bat"
) else if "%COMPRESSION%"=="8" (
    call "%RESOURCE_DIR%\8.bat"
) else if "%COMPRESSION%"=="4" (
    call "%RESOURCE_DIR%\4.bat"
) else if "%COMPRESSION%"=="0" (
    call "%RESOURCE_DIR%\store.bat"
) else (
    echo Invalid Compression Preset Selected....
    goto TRYAGAIN
)
CLS
Echo.
Echo.
call records.ps1
Echo.
Echo.

CLS
Echo.
Echo.
call createdll.ps1
Echo.
Echo.

:NOCOMPRESS
CLS
Echo.
Echo.
call internaldll.ps1
Echo.
Echo.

CLS
Echo.
Echo.
call zipNname.ps1
Echo.
Echo.


CLS
Echo.
Echo.
call oldrepackshit.ps1
Echo.
Echo.

CLS
Echo.
Echo.
ECHO Repack DONE! Everything Zipped And Moved! Ready To Repack ANOTHER Game!
Echo.
Echo.
PAUSE
endlocal