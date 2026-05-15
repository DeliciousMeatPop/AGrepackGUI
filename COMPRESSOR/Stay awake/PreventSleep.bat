@Echo Off
ECHO Three files follow
ECHO PreventSleep.bat
ECHO.
ECHO This file compiles KeepDisplayOn.vb and KeepSystemOn.vb to KeepDisplayOn.exe and KeepSystemOn.exe using the system VB.NET compiler.
ECHO.
ECHO Runs a program preventing sleeping or the display turning off while the program runs
ECHO.
ECHO To Use
ECHO      KeepDisplayOn "C:\Program Files\Notepad++\Notepad++.exe"
ECHO      KeepSystemOn "C:\Program Files\Notepad++\Notepad++.exe"
ECHO.
C:\Windows\Microsoft.NET\Framework\v4.0.30319\vbc "%~dp0\KeepDisplayOn.vb" /out:"%~dp0\KeepDisplayOn.exe" /target:winexe
C:\Windows\Microsoft.NET\Framework\v4.0.30319\vbc "%~dp0\KeepSystemOn.vb" /out:"%~dp0\KeepSystemOn.exe" /target:winexe
pause