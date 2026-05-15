$dir = Get-Content "$env:TEMP\dir.tmp" | ForEach-Object { $_.Trim() }
$presetContent = Get-Content "$env:TEMP\preset.tmp" -Raw
$preset = $presetContent.Trim()


function Get-CRC32-7Zip {
    param([string]$filePath)
    $7zPath = Join-Path $PSScriptRoot "7z.exe"
    try {
        if (Test-Path -Path $filePath -PathType Leaf) {
            $output = & $7zPath h -scrcCRC32 "$filePath"
            if ($output -and $output.Count -gt 2) {
                $crcLine = $output | Where-Object { $_ -match "CRC32\s+for\s+data:\s+[0-9A-F]+" }
                if ($crcLine -and ($crcLine -match "CRC32\s+for\s+data:\s+([0-9A-F]+)")) {
                    return $matches[1].ToLower()
                } else {
                    throw "CRC32 hash not found in 7z output."
                }
            } else {
                throw "7z output was not in the expected format."
            }
        } else {
            return "00000000"
        }
    } catch {
        throw "Failed to compute CRC32 for file '$filePath': $_"
    }
}

$rootPath = "$dir"

function Format-Output {
    param([string]$size, [string]$crc, [string]$path)
    $prePipeContent = "$size"
    $totalLengthBeforePipe = 15
    $paddingLength = $totalLengthBeforePipe - $prePipeContent.Length
    $paddedSize = $prePipeContent.PadLeft($prePipeContent.Length + $paddingLength, " ")
    return "$paddedSize|$crc|$path"
}

$directories = Get-ChildItem -Path $rootPath -Recurse -Directory | ForEach-Object {
    $relativePath = $_.FullName.Replace($rootPath, "{app}").Replace('\\', '\')
    Format-Output "0" "00000000" $relativePath
}

$files = Get-ChildItem -Path $rootPath -Recurse -File | ForEach-Object {
    try {
        $relativePath = $_.FullName.Replace($rootPath, "{app}").Replace('\\', '\')
        $size = $_.Length
        $crc = Get-CRC32-7Zip $_.FullName
        Format-Output $size $crc $relativePath
    } catch {
        Write-Warning "Failed to process file: $($_.FullName) - Error: $_"
    }
}

$finalOutput = ";; This line is required do read first section in UFT-8 BOM ini file" + "`r`n" + "[Record1]" + "`r`n" + ($directories + $files -join "`r`n")
$uninstallListPath = "UninstallList.ini"
$finalOutput | Out-File $uninstallListPath -Encoding UTF8BOM

$destinationPath = Join-Path $PSScriptRoot "Resource\DLL\$preset"
Copy-Item $uninstallListPath -Destination $destinationPath

if (Test-Path $destinationPath) {
    Write-Host "UninstallList.ini has been successfully copied to $destinationPath"
} else {
    Write-Warning "Failed to copy UninstallList.ini to $destinationPath"
}