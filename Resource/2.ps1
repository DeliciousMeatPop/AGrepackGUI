$directory = Get-Content "$env:TEMP\directory.tmp" | ForEach-Object { $_.Trim() } 
$save = Get-Content "$env:TEMP\save.tmp" | ForEach-Object { $_.Trim() } 


$settingsFilePath = Join-Path $directory "settings.ini"


if (Test-Path $settingsFilePath) {
    
    $settingsContent = Get-Content $settingsFilePath -Encoding UTF8
    $gameName = Read-Host "What Is The Game's Name?"
    $settingsContent[1] = "Name=$gameName"
    $gameName | Out-File "$env:TEMP\name.tmp"
    Clear-Host
    
    $appID = Read-Host "Enter The Game's APP ID (or leave blank if nonsteam)"
    $settingsContent[2] = "APPID=$appID"
    $appID | Out-File "$env:TEMP\appid.tmp"
    Clear-Host
    
    $buildVersion = Read-Host "Enter The Game's Build ID or Version Number"
    $settingsContent[3] = "Buildversion=$buildVersion"
    $buildVersion | Out-File "$env:TEMP\build.tmp"
    Clear-Host
    
    $size = Read-Host "Enter The Game's Size"
    $settingsContent[4] = "Size=$size"
    Clear-Host
    
    $repackerName = Get-Content "$save\repacker.txt" | ForEach-Object { $_.Trim() } 
    $settingsContent[5] = "REPACKER=$repackerName"
    Clear-Host
    
    $Compact = Read-Host "Compact Mode - 1 or 0?"
    $settingsContent[10] = "CompactMode=$Compact"
    Clear-Host
    
    $admin = Read-Host "Run As Admin - 1 or 0?"
    $settingsContent[11] = "RunAppAsAdmin=$admin"    
    $admin | Out-File "$env:TEMP\ofme.tmp"
    Clear-Host
    
    $settingsContent[13] = "ShortcutName=$gameName" 
    Clear-Host
    
    $exepath = Read-Host "What Is The Relative Path To EXE?"
    $settingsContent[14] = "Exe=$exepath"   
    Clear-Host
    
    $args = Read-Host "What, If Any, Arguments Are Needed?"
    $settingsContent[15] = "Exeparam=$args"  
    Clear-Host
    
    $infob4 = Read-Host "Info Before - 1 or 0?"
    $settingsContent[23] = "Enable=$infob4"  
    Clear-Host
    
    $enablebat = Read-Host "Enable Bat - 1 or 0?"
    $settingsContent[42] = "Enable=$enablebat"  
    Clear-Host
    
    if ($enablebat -eq "1") {
        $batname = Read-Host "Enter The Name Of The Bat File"
        $settingsContent[43] = "BatchFile=$batname"  
    }
    Clear-Host
    
    $settingsContent | Set-Content $settingsFilePath -Encoding UTF8
    Write-Host "Settings.ini For PC Game Updated Successfully."
    Clear-Host
} else {
    Write-Host "Settings.ini Not Found."
    Write-Host "Start Repack.bat Over."
    Write-Host "Press Enter to Continue..."
    $null = Read-Host
}
