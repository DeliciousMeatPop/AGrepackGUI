$presetContent = Get-Content "$env:TEMP\preset.tmp" -Raw
$preset = $presetContent.Trim()

$dataBinPath = Join-Path $PSScriptRoot "COMPRESSOR\Conversion_Output\CONVERSION\data.bin"

if (Test-Path $dataBinPath) {
    $fileSizeBytes = (Get-Item $dataBinPath).Length
    $formattedSize = "{0:N0}" -f $fileSizeBytes -replace ',', '.'
    $recordsTemplatePath = Join-Path $PSScriptRoot "Resource\DLL\recordstemplate.ini"
    $content = Get-Content $recordsTemplatePath
    $content[5] = "Size=${formattedSize} bytes"
    $content | Set-Content $recordsTemplatePath

    $destinationPath = Join-Path $PSScriptRoot "Resource\DLL\$preset\Records.ini"
    Copy-Item $recordsTemplatePath -Destination $destinationPath
    Write-Host "Recordstemplate.ini Has Been Edited, Copied, And Renamed To Records.ini at $destinationPath"
} else {
    Write-Warning "The File At $dataBinPath Does Not Exist To Move!"
    PUSE
}
