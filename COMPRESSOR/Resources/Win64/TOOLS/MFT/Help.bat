@echo off
color 1E
title MFT by BLACKFIRE69
:Help
cls
echo.-------------------------------------------------------------------------
echo. Select a function to help or press "Enter" to exit?
echo.-------------------------------------------------------------------------
echo. 1 = List
echo. 2 = Calc
echo. 3 = Dir
echo. 4 = Hash
echo. 5 = ISO
echo. 6 = INI
echo. 7 = Watch
echo. 8 = File
echo. 9 = RenameList
echo. 0 = Safe
echo.
set /P "INPUT=Choice: %=%"
if "%INPUT%" EQU "" goto End
if /I %INPUT% EQU 1 goto List
if /I %INPUT% EQU 2 goto Calc
if /I %INPUT% EQU 3 goto Dir
if /I %INPUT% EQU 4 goto Hash
if /I %INPUT% EQU 5 goto ISO
if /I %INPUT% EQU 6 goto INI
if /I %INPUT% EQU 7 goto Watch
if /I %INPUT% EQU 8 goto File
if /I %INPUT% EQU 9 goto RenameList
if /I %INPUT% EQU 0 goto Safe
goto Help

:List
cls
color 0F
MFT.exe List /?
echo.
pause
exit

:Calc
cls
color 0F
MFT.exe Calc /?
echo.
pause
exit

:Dir
cls
color 0F
MFT.exe Dir /?
echo.
pause
exit

:Hash
cls
color 0F
MFT.exe Hash /?
echo.
pause
exit

:ISO
cls
color 0F
MFT.exe ISO /?
echo.
pause
exit

:INI
cls
color 0F
MFT.exe INI /?
echo.
pause
exit

:Watch
color 0F
MFT.exe Watch /?
echo.
pause
exit

:File
cls
color 0F
MFT.exe File /?
echo.
pause
exit

:RenameList
cls
color 0F
MFT.exe RenameList /?
echo.
pause
exit

:Safe
cls
color 0F
MFT.exe Safe /?
echo.
pause
exit

:End
cls
color 0F
MFT.exe /?
echo.Press any key to exit
pause > nul
exit

