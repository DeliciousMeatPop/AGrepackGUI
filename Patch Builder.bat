@echo off
pushd "%~dp0XDelta"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0XDelta\make_patch_gui.ps1"
popd
