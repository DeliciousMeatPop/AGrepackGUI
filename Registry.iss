[Registry]
Root: HKLM; SubKey: SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: string; ValueName: {app}\{code:ExePath}; ValueData: RUNASADMIN; Flags: uninsdeletevalue uninsdeletekeyifempty




;RegWriteStringValue(HKEY_CURRENT_USER, 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers', ExpandConstant('{sys}\powershell.exe'), 'RUNASADMIN')



/////