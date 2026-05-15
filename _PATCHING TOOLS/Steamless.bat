@echo off
SETLOCAL
 
:: Change Me
set steamless="D:\ARMGDDN Repacks\_PATCHING TOOLS\Steamless\Steamless.CLI.exe"
 
:: Don't change me
%steamless% --keepbind %1
%~d1
CD %~dp1
IF EXIST "%~dp1\%~nx1.unpacked.exe" (
  REN %1 "%~n1.AG"
  REN "%~nx1.unpacked.exe" "%~nx1"
)
PAUSE