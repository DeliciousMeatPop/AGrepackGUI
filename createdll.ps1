$presetContent = Get-Content "$env:TEMP\preset.tmp" -Raw
$preset = $presetContent.Trim()

$sourcePath = Join-Path $PSScriptRoot "Resource\dll\$preset"
$compressor = "$PSScriptRoot\COMPRESSOR"
$arcExeFullPath = "$compressor\Resources\Win64\Arc.exe" 
$endDllPath = "$compressor\Conversion_Output\CONVERSION" 
$destinationDllPath = Join-Path $endDllPath "AGRepackInstaller.dll"

$COMMAND = "& `"$arcExeFullPath`" a -ep1 -r -ed -s -w`"$PSScriptRoot\temp`" -mx AGRepackInstaller.dll `"$sourcePath\*`""

Invoke-Expression $COMMAND

$createdDllPath = Join-Path $PSScriptRoot "AGRepackInstaller.dll"
if (Test-Path $createdDllPath) {
    Move-Item -Path $createdDllPath -Destination $destinationDllPath
    Write-Host "AGRepackInstaller.dll has been moved to $destinationDllPath"
} else {
    Write-Warning "AGRepackInstaller.dll not found. Cannot move."
    PAUSE
}

Remove-Item (Join-Path $sourcePath "Records.ini") -ErrorAction SilentlyContinue

Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "DLL Was Created And Moved"
Write-Host ""
Write-Host ""
Write-Host ""