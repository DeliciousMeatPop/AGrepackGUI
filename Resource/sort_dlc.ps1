$folderPath = Get-Content "$env:TEMP\dir.tmp" | ForEach-Object { $_.Trim() }

if (-not (Test-Path $folderPath -PathType Container)) {
    Write-Host "The Specified Folder Does Not Exist: $folderPath"
    exit
}

$dlcFilePath = Get-ChildItem -Path $folderPath -Filter "DLC.txt" -Recurse -File | Select-Object -ExpandProperty FullName

if (-not $dlcFilePath) {
    Write-Host "DLC.txt Not Found In The Specified Folder Or Its Subfolders."
    exit
}

$dlcContent = Get-Content -Path $dlcFilePath
$modifiedContent = foreach ($line in $dlcContent) {
    $line = $line -replace '^(\d+)\s+(.*?)\s+(?:\(.*?\))?\s+(?:last month|\d+\s+\w+\s+ago)', '$1=$2'
    $line = $line -replace '^(\d+)\s+(\w)', '$1=$2'
    $line
}

$sortedContent = $modifiedContent | Sort-Object { [int]($_ -replace '(\d+).*', '$1') }

$sortedContent | Set-Content -Path $dlcFilePath

Write-Host "Sorting and Modification Complete For $dlcFilePath."
Write-Host "Press Enter to Continue..."
$null = Read-Host