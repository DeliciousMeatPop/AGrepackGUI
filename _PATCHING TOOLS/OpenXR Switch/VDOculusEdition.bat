@echo off Title Automobilista 2 v10845679 -ARMGDDN + OFME

::-------------------------------
set gameexe=AMS2.exe
set exeparams=
set requiredxr=Oculus
::-------------------------------

echo                             ^.______  .______  ._____.___ ._____  .______  .______  .______  
echo                             ^:      \ : __   \ :         ^|:_ ___\ :_ _   \ :_ _   \ :      \
echo                             ^|   .   ^|^|  \____^|^|   \  /  ^|^|   ^|___^|   ^|   ^|^|   ^|^|       ^|
echo                             ^|   :   ^|^|   :  \ ^|   ^|\/   ^|^|   /  ^|^|  .^|   ^|^|  .^|   ^|^|   ^|   ^|
echo                             ^|___^|   ^|^|   ^|___\^|___^| ^|   ^|^|. __  ^|^|. ____/ ^|. ____/ ^|___^|   ^|
echo                                 ^|___^|^|___^|          ^|___^| :/ ^|. ^| :/       :/       DMP^|___^|
echo                            :----------------PC/PCVR-------:---:/--:--------:----------------:
echo                                                               :
echo.
set errorlevel=
set oculusxr=oculus_openxr_64.json
set openxrreg=HKLM\SOFTWARE\Khronos\OpenXR\1
set origxr=
set vr=
if /I "%1" EQU "-2D" (set vr=0) else (set vr=1)
goto xr

:XR
for /F "tokens=2,*" %%A in ('reg.exe query "%openxrreg%" /v "ActiveRuntime"') do set "origxr=%%B"
if /I "%origxr%" NEQ "%requiredxr%" (
    for /F "tokens=2,*" %%A in ('reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Oculus" /v "InstallLocation"') do set "oculusapp=%%B"
    if "%oculusapp%" NEQ "" (
        start "" "%oculusapp%\Support\oculus-dash\dash\bin\OculusDash.exe" 
        timeout /t 10 /nobreak >nul
    )
    elevate xrsetruntime --%requiredxr%
)
start "" /wait "%gameexe%" %exeparams%
goto reset

:RESET
elevate xrsetruntime --%origxr%
goto end

:META
for /F "tokens=2,*" %%A in ('reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Oculus" /v "InstallLocation"') do set "oculusapp=%%B"
if "%oculusapp%" NEQ "" (
    start "" "%oculusapp%\Support\oculus-dash\dash\bin\OculusDash.exe" 
    timeout /t 10 /nobreak >nul
}
"%gameexe%" %exeparams%
goto end

:END
EXIT
