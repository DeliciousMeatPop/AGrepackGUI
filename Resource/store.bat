@echo off
setlocal enabledelayedexpansion

for /f "usebackq delims=" %%A in ("%TEMP%\dir.tmp") do (
    set "REPACK_PATH=%%A"
    set "REPACK_PATH=!REPACK_PATH:~0,-1!"  
)

for /f "usebackq delims=" %%B in ("%TEMP%\directory.tmp") do (
    set "WORKING_DIR=%%B"
    set "WORKING_DIR=!WORKING_DIR:~0,-1!"  
)

if "%WORKING_DIR:~-1%"=="\" set "WORKING_DIR=%WORKING_DIR:~0,-1%"


set "COMPRESSOR=%WORKING_DIR%\COMPRESSOR"
set "RESOURCES=%COMPRESSOR%\Resources\Win64"
set "ARC_EXE_PATH=%RESOURCES%\Arc.exe"
set "CONFIG_FILE_PATH=%RESOURCES%\DSG_Arc.ini"
set "DATA_FILE_PATH=%COMPRESSOR%\Conversion_Output"
set "OUTPUT_DIRECTORY=%DATA_FILE_PATH%\TEMP"
set "FINAL_DIR=%DATA_FILE_PATH%\CONVERSION"
set "DATA=%DATA_FILE_PATH%\Data.bin"
set "EXE=%COMPRESSOR%\Setup_Files\AGRepackInstaller.exe"

type nul > "%WORKING_DIR%\choosecompression.txt"

set COMMAND=call "%ARC_EXE_PATH%" create -cfg"%CONFIG_FILE_PATH%" -ep1 -r -s; --dirs -ds -w"%OUTPUT_DIRECTORY%" -m"storing" -x"uninstall.exe" -x"uninstall.dat" -x"uninstall.bin" -x"unins???.exe" -x"unins???.dat" -dp"%REPACK_PATH%" "%DATA%"

%COMMAND%

move /Y "%DATA%" "%FINAL_DIR%\Data.bin" 
rmdir /S /Q "%OUTPUT_DIRECTORY%"
copy /Y "%EXE%" "%FINAL_DIR%\AGRepackInstaller.exe"

ECHO Compression Complete
PAUSE
CLS
