$folderPath = Get-Content "$env:TEMP\dir.tmp" | ForEach-Object { $_.Trim() }

if (-not (Test-Path $folderPath -PathType Container)) {
    Write-Host "The Specified Folder Does Not Exist: $folderPath"
    exit
}

$files = Get-ChildItem -Path $folderPath -Recurse -File | Where-Object { $_.Name -match '_o(?=\.[^.]+$)|\s*\(Original\)' }

if ($files.Count -eq 0) {
    Write-Host "No Files Ending With '_o' Or '(Original)' Found In The Specified Folder Or Its Subfolders."
    exit
}

foreach ($file in $files) {
    $newFileName = $file.Name -replace '_o(?=\.[^.]+$)|\s*\(Original\)', '' -replace "(\s)*(\.[^.]+$)", ".AG"
    $newFilePath = Join-Path -Path $file.DirectoryName -ChildPath $newFileName

    Rename-Item -Path $file.FullName -NewName $newFileName

    Write-Host "File Renamed: $($file.FullName) -> $($newFilePath)."
}

Write-Host "Press Enter to Continue..."
$null = Read-Host