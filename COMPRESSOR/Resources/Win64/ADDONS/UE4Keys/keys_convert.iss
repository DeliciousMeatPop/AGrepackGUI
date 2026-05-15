
[Setup]
AppName=My App
AppVersion=1.0
CreateAppDir=no
OutputBaseFilename=keys_convert
OutputDir=.

[code]
function InitializeSetup(): Boolean;
var
  I: Integer;
  S1: String;
  InFile: String;
  OutFile: String;
  InList: TStringList;
  OutList: TStringList;
begin
  InFile := ExpandConstant('{src}\keys_raw.txt');
  if FileExists(InFile) then
  begin
    OutFile := ExpandConstant('{src}\keys.txt');
    InList := TStringList.Create;
    OutList := TStringList.Create;
    try
      InList.LoadFromFile(InFile);
      for I := 0 to InList.Count - 1 do
      begin
        S1 := Trim(InList.Strings[I]);
        S1 := Trim(Copy(S1, 0, Length(S1) - 66)) + '|' + Trim(Copy(S1, Length(S1) - 66, Length(S1)));
        OutList.Append(S1);
      end;
      if (not FileExists(OutFile)) or DeleteFile(OutFile) then
      begin
        if MsgBox('Force save file using ecoding UTF8 (Without BOM)?' + #13#10 + #13#10 +
                  'If you choose no, then UTF8-BOM / ANSI encoding will be used depending on the encoding of the original file.' + #13#10 + #13#10 +
                  'Only use UTF8 (Without BOM) if the game names contain characters formed by 4 bytes like the Chinese language.', mbConfirmation, MB_YESNO or MB_DEFBUTTON2) = IDYES then
          OutList.SaveToFile(OutFile)
        else
          SaveStringsToUTF8File(OutFile, [OutList.Text], False);
      end else
        MsgBox('Unable to save the file.' + #13#10 +
               'Perhaps the file already exists and is in use.' + #13#10 +
               'Delete the destination file and try again.', mbError, MB_OK);
    finally
      InList.Free;
      OutList.Free;
    end;
  end;
  Result := False;
end;


