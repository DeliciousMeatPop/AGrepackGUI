$folderPath = Read-Host "Please provide the folder path containing the DLC.txt file"
$folderPath = $folderPath.Trim('"')

if (-not (Test-Path $folderPath -PathType Container)) {
    Write-Host "The specified folder does not exist."
    exit
}

$dlcFilePath = Get-ChildItem -Path $folderPath -Filter "DLC.txt" -Recurse -File | Select-Object -ExpandProperty FullName

if (-not $dlcFilePath) {
    Write-Host "DLC.txt file not found in the specified folder or its subfolders."
    exit
}

$dlcContent = Get-Content -Path $dlcFilePath
$modifiedContent = foreach ($line in $dlcContent) {
    $line = $line -replace '^(\d+)\s+(.*?)\s*(?:\(.*?\))?\s*(?:last month|\d+\s+\w+\s+ago)?$', '$1=$2'
    $line
}

$sortedContent = $modifiedContent | Sort-Object { [int]($_ -replace '(\d+)=.*', '$1') }

$sortedContent | Set-Content -Path $dlcFilePath

Write-Host "Sorting and modification complete for $dlcFilePath."
