@echo off
for /r "%CD%" %%a in (Script*.iss) do set script=%%~dpnxa
start "" "Resources\IS_Files\Compil32Ex.exe" /CC "%script%"