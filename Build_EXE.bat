@echo off
setlocal

set SCRIPT=DMPRepackGUI.py
set ICON=setup.ico
set EXENAME=AG Repack GUI

echo.
echo  =========================================
echo   AG Repack GUI  --  Build EXE
echo  =========================================
echo.

:: Check Python is available
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found in PATH.
    echo         Install Python 3.8+ and make sure it is on your PATH.
    pause
    exit /b 1
)

:: Check PyInstaller is available (auto-py-to-exe installs it)
python -m PyInstaller --version >nul 2>&1
if errorlevel 1 (
    echo [INFO] PyInstaller not found -- installing...
    pip install pyinstaller
    if errorlevel 1 (
        echo [ERROR] Could not install PyInstaller.
        pause
        exit /b 1
    )
)

:: Remove previous build artefacts so we always get a clean output
if exist "build"          rmdir /s /q "build"
if exist "dist"           rmdir /s /q "dist"
if exist "%EXENAME%.spec" del /q "%EXENAME%.spec"

echo [BUILD] Compiling %SCRIPT% ...
echo.

python -m PyInstaller ^
    --onefile ^
    --windowed ^
    --icon="%ICON%" ^
    --name="%EXENAME%" ^
    --distpath="." ^
    "%SCRIPT%"

if errorlevel 1 (
    echo.
    echo [ERROR] Build failed. Check the output above for details.
    pause
    exit /b 1
)

:: Clean up build folder and spec file; keep only the exe
if exist "build"          rmdir /s /q "build"
if exist "%EXENAME%.spec" del /q "%EXENAME%.spec"

echo.
echo  =========================================
echo   Done!  "%EXENAME%.exe" is in this folder.
echo  =========================================
echo.
pause
endlocal
