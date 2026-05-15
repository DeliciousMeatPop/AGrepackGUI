@echo off
echo Applying Patch %progress%
xdelta3.exe -d -vfs "File1.txt" "File1 Patch file.vcdiff" "File2.txt"
echo File successfully patched! Deleting old file...
del File1.txt
@pause
