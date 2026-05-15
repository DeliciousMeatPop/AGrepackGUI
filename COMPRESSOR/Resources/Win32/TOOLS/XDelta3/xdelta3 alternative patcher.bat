@echo off
COLOR 02
:start

echo This is a shell orientated patcher.If you don't like the GUI, you may use this  (the GUI and this bat are working in the exactly same way).
echo Input file: the old file
echo Output file: the patched file (create patch) OR the new, patched file after applying the patch (apply patch)
echo Patch: the delta vcdiff patch
echo ------------------------------------------------------------------------------
set /p mode=patch or apply patch?:

if "%mode%" == "patch" (
	GOTO patch
 )
if "%mode%" == "apply" (
        GOTO apply
 )
if "%mode%" == "exit" (
	GOTO end
)
else (
	echo Please type in a valid value (patch/apply/exit)!
	@pause
	cls
	goto start
 )
END

:PATCH
set /p input=Input file:
set /p outout=Output file:
set /p patch=Patch file:

if "%input%" != "" and "%output%" != "" and "%patch%" != "" (
	echo Creating patch...
	xdelta3.exe -9 -S djw -e -vfs "%input%" "%output%" "%patch%"
	echo Patch successfully created!
	@pause
	GOTO end
 )
else (
	echo Please set valid values!
	@pause
	cls
	goto patch
 )

END

:APPLY
set /p input=Input file:
set /p outout=Output file:
set /p patch=Patch file:

if "%input%" != "" and "%output%" != "" and "%patch%" != "" (
	echo Applying patch...
	xdelta3.exe -d -vfs "%input%" "%patch%" "%output%"
	echo File successfully patched!
	@pause
	GOTO end
 )
else (
	echo Please set valid values!
	@pause
	cls
	goto apply
 )

:END
exit
end