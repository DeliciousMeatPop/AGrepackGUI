@echo off
set "OldFile=File_Old.txt"
set "NewFile=File_New.txt"
echo.
if exist "%OldFile%.diff" del /S /F /Q "%OldFile%.diff" >nul
call "..\XDelta3\xdelta3.exe" -e -9 -S djw -vfs "%OldFile%" "%NewFile%" "%OldFile%.diff"
echo.
echo.Press any key to exit.
pause >nul