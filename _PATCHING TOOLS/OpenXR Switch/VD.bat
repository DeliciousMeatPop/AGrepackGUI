@echo off && Title  Automobilista 2 v10845679 -ARMGDDN + OFME

::-------------------------------
set gameexe=AMS2.exe
set exeparams=
set requiredxr=steamvr
::-------------------------------

echo                             ^.______  .______  ._____ ___ ._____  .______  .______  .____  ___
echo                             ^:   _   \: __   \ :     V   ^|:     \ : _._  \ : _._  \ :    \ ^|  ^|  
echo                             ^|  ^|_^|  ^|^|  \____^|^|   \  /  ^|^|    __^|^|^|   ^:  ^|^|^|   ^:  ^|^|  ^|\ \^|  ^|
echo                             ^|   ^:   ^|^|   :  \ ^|   ^|\/   ^|^|   /  ^|^|^:_._^|  ^|^|^:_._^|  ^|^|  ^| \ \  ^|
echo                             ^|___^|   ^|^|   ^|___\^|___^| ^|   ^|^|      ^|^| .____/ ^| .____/ ^|__^|  \   ^|
echo                                 ^|___^|^|___^|          ^|___^|: _____^|:/       :/          DMP \__^|
echo                            :----------------PC/PCVR------:/------:--------:-----------------:
echo. 
set errorlevel=
set oculusxr=oculus_openxr_64.json
set steamxr=steamxr_win64.json
set steamexe=HKCU\SOFTWARE\Valve\Steam
set openxrreg=HKLM\SOFTWARE\Khronos\OpenXR\1
set origxr=
set vr=
for /F "tokens=2,*" %%A in ('reg.exe query "%steamexe%" /v "SteamExe"') do set "steamexe=%%B"
if /I "%1" EQU "-2D" (set vr=0) else (set vr=1)
goto xr

:XR
for /F "tokens=2,*" %%A in ('reg.exe query "%openxrreg%" /v "ActiveRuntime"') do set "origxr=%%B"
echo %origxr% | findstr /I %oculusxr% >nul
if "%errorlevel%" EQU "0" set origxr=oculus
set errorlevel=
echo %origxr% | findstr /I %steamxr% >nul
if "%errorlevel%" EQU "0" set origxr=steamvr
if "%origxr%" NEQ "%requiredxr%" elevate xrsetruntime --%requiredxr%
start "" "%steamexe%" -silent
start "" /wait "%gameexe%" %exeparams%
goto reset

:RESET
elevate xrsetruntime --%origxr%
goto end

:END
EXIT