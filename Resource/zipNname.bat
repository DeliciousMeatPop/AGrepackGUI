@echo off
setlocal enabledelayedexpansion

for /f "usebackq delims=" %%A in ("%TEMP%\name.tmp") do (
    set "GAME_NAME=%%A"
    set "GAME_NAME=!GAME_NAME:~0,-1!"  REM Remove the last character (trailing space or slash)
)

for /f "usebackq delims=" %%B in ("%TEMP%\build.tmp") do (
    set "BUILD_ID=%%B"
    set "BUILD_ID=!BUILD_ID:~0,-1!"  REM Remove the last character (trailing space or slash)
)

for /f "usebackq delims=" %%C in ("%TEMP%\ofme.tmp") do (
    set "OFME=%%B"
    set "OFME=!OFME:~0,-1!"  REM Remove the last character (trailing space or slash)
)

for /f "usebackq delims=" %%Din ("%TEMP%\directory.tmp") do (
    set "WORKING_DIR=%%D
    set "WORKING_DIR=!WORKING_DIR:~0,-1!"  REM Remove the last character (trailing space or slash)
)

echo The game name is: !GAME_NAME!
echo The build id is: !BUILD_ID!
echo OFME 1 or 0 is: !OFME!
echo The working directory is: !WORKING_DIR!

set "COMPRESSOR=%WORKING_DIR%\COMPRESSOR"
set "DATA_FILE_PATH=%COMPRESSOR%\Conversion_Output"
set "GROUP=-ARMGDDN"

if "%OFME%"=="1" (
    set "GROUP=!GROUP! + OFME"
)

set "totalSize=0"
for /f "tokens=3" %%E in ('dir /-C /s /-C "%DATA_FILE_PATH%" ^| findstr /c:"File(s)"') do (
    set "size=%%E"
    set size=!size:,=!
    set /a "totalSize+=size"
)

if %totalSize% gtr 10737418240 (
    set "command=7z a -t7z -mx=0 -sdel -v5000M '%GAME_NAME% v%BUILD_ID% %GROUP%'  *"
) else (
    set "command=7z a -t7z -mx=0 -sdel '%GAME_NAME% v%BUILD_ID% %GROUP%' *"
)

echo Command to be executed:
echo %command%
PAUSE
%command%

endlocal