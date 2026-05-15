
#define CallBefore

;#define DEBUG

[Setup]
AppName={#defined(CallBefore) ? "CallBefore" : "CallAfter"}
AppVersion=1.0
#if VER > 0x06000000
WizardResizable=no
WizardSizePercent=100
WizardStyle=modern
#endif
CreateAppDir=no
DisableWelcomePage=no
OutputBaseFilename={#defined(CallBefore) ? "CallBefore" : "CallAfter"}
SetupIconFile=icon.ico
OutputDir={#defined(DEBUG) ? "." : ".."}

[Files]
Source: "dsgcall.dll"; Flags: dontcopy;

[code]
type
  TArrayOfWideString = Array of WideString;
  TCopyCallback = function(Progress: Integer): Boolean;

function MemoLinesCount: Integer;
  external 'MemoLinesCount@{tmp}\dsgcall.dll stdcall delayload';

procedure MemoRemoveLastEmptyLines;
  external 'MemoRemoveLastEmptyLines@{tmp}\dsgcall.dll stdcall delayload';

procedure MemoAddDashedLine;
  external 'MemoAddDashedLine@{tmp}\dsgcall.dll stdcall delayload';

procedure MemoAddEmptyLine;
  external 'MemoAddEmptyLine@{tmp}\dsgcall.dll stdcall delayload';

procedure MemoStringInsert(Index: Integer; const S: WideString);
  external 'MemoStringInsert@{tmp}\dsgcall.dll stdcall delayload';

procedure MemoTextAppend(const S: WideString);
  external 'MemoTextAppend@{tmp}\dsgcall.dll stdcall delayload';

procedure MemoLineWordReplace(Index: Integer; const S: WideString);
  external 'MemoLineWordReplace@{tmp}\dsgcall.dll stdcall delayload';

function MemoRequestUserAction(Options, Answers: TArrayOfWideString): WideString;
  external 'MemoRequestUserAction@{tmp}\dsgcall.dll stdcall delayload';

function CopyFileEx(const FromFile, ToFile: WideString; FailIfExist: Boolean; Callback: TCopyCallback): Boolean;
  external 'CopyFileEx@{tmp}\dsgcall.dll stdcall delayload';

function MoveFileEx(const FromFile, ToFile: WideString; ReplaceIfExist: Boolean; Callback: TCopyCallback): Boolean;
  external 'MoveFileEx@{tmp}\dsgcall.dll stdcall delayload';

function GetFileAttributes(lpFileName: String): DWORD;
  external 'GetFileAttributesW@kernel32.dll stdcall delayload';

function SetFileAttributes(lpFileName: String; dwFileAttributes: DWORD): BOOL;
  external 'SetFileAttributesW@kernel32.dll stdcall delayload';

var
  Canceled: Boolean;
  GameName, DataFile, GameDir, OutputDir,
  SetupDir, MediaDir, MainDir, TempDir: String;
  GameIndex, TempIndex, MediaIndex: Integer;

function IfThen(AValue: Boolean; const ATrue, AFalse: Variant): Variant;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

procedure LoadParameters;
var
  Param: String;
  I, Y: Integer;
begin
  for I := 2 to ParamCount do
    if Pos('/', ParamStr(I)) = 0 then
    begin
      Inc(Y);
      case Y of
        1 : GameName := ParamStr(I);
        2 : DataFile := ParamStr(I);
        3 : GameDir := ParamStr(I);
        4 : OutputDir := ParamStr(I);
        5 : SetupDir := ParamStr(I);
        6 : MediaDir := ParamStr(I);
        7 : MainDir := ParamStr(I);
        8 : TempDir := ParamStr(I);
        9 : Param := ParamStr(I);
      end;
    end;
  if Trim(GameDir) = '' then GameDir := ExpandConstant('{src}');
  if Trim(OutputDir) = '' then OutputDir := ExpandConstant('{src}');
  if Trim(SetupDir) = '' then SetupDir := ExpandConstant('{src}');
  if Trim(MediaDir) = '' then MediaDir := ExpandConstant('{src}');
  if Trim(MainDir) = '' then MainDir := ExpandConstant('{src}');
  if Trim(TempDir) = '' then TempDir := ExpandConstant('{src}');
  GameIndex := StrToIntDef(Trim(Copy(Param, 0, Pos(#32, Param + #32) - 1)), 1);
  Param := Trim(Copy(Param, Pos(#32, Param + #32) + 1, Length(Param)));
  TempIndex := StrToIntDef(Trim(Copy(Param, 0, Pos(#32, Param + #32) - 1)), 1);
  Param := Trim(Copy(Param, Pos(#32, Param + #32) + 1, Length(Param)));
  MediaIndex := StrToIntDef(Trim(Copy(Param, 0, Pos(#32, Param + #32) - 1)), 1);
end;

function Callback(Progress: Integer): Boolean;
begin
  MemoLineWordReplace(MemoLinesCount - 2, PadL(IntToStr(Progress / 10) + '%', 4));
  Result := not Canceled;
end;

procedure ProcessUserTasks;
var
  Res: Integer;
  StrText: WideString;
  Options: TArrayOfWideString;
  SrcFile, DstFile: String;
begin
  LoadParameters;
  SrcFile := ExpandConstant('{src}\video_test.mkv');
  if FileExists(SrcFile) then
  begin
    DstFile := 'C:\' + ExtractFileName(SrcFile);;
    MemoTextAppend('Copyng file: ' + ExtractFileName(SrcFile) + ' - ' + PadL('0%', 4) + #13#10);
    if CopyFileEx(SrcFile, DstFile, False, @Callback) then
    begin
      SrcFile := 'C:\' + ExtractFileName(SrcFile);
      DstFile := 'D:\' + ExtractFileName(SrcFile);
      MemoTextAppend('Moving file: ' + ExtractFileName(SrcFile) + ' - ' + PadL('0%', 4) + #13#10);
      if MoveFileEx(SrcFile, DstFile, True, @Callback) then
      begin
        //MsgBox('The file ' + ExtractFileName(FileName) + ' has copyed from {src} to C:\ and moved to D:\ directory.', mbInformation, MB_OK);
      end;
    end;
  end;

  SetArrayLength(Options, 6);
  Options[0] := '[1] English';
  Options[1] := '[2] French';
  Options[2] := '[3] German';
  Options[3] := '[4] Italian';
  Options[4] := '[5] Spanish';
  Options[5] := #13#10 + 'Choice: ';

  MemoTextAppend(#13#10 + 'Choice a option and press enter key...' + #13#10 + #13#10);

  StrText := MemoRequestUserAction(Options, ['1', '2', '3', '4', '5']);

  MemoTextAppend(#13#10 + #13#10 + 'Received text was: ' + StrText + #13#10 + #13#10);

  Res := StrToIntDef(StrText, 0);
  case Res of
    1 : MemoTextAppend('You have chosen the option: English' + #13#10);
    2 : MemoTextAppend('You have chosen the option: French' + #13#10);
    3 : MemoTextAppend('You have chosen the option: German' + #13#10);
    4 : MemoTextAppend('You have chosen the option: Italian' + #13#10);
    5 : MemoTextAppend('You have chosen the option: Spanish' + #13#10);
  end;
  case Res of
    1 : begin
      if (not DirExists(ExpandConstant('{src}\..\Test'))) and ForceDirectories(ExpandConstant('{src}\..\Test')) then
        MemoTextAppend(#13#10 + 'CREATED DIRECTORY: ' + ExpandFileName(ExpandConstant('{src}\Test')));

      if FileCopy(ExpandConstant('{src}\..\File1.txt'), ExpandConstant('{src}\Test\File1.txt'), False) then
        MemoTextAppend(#13#10 + 'COPIED FILE: ' + ExpandFileName(ExpandConstant('{src}\..\File1.txt')))
      else
        MemoTextAppend(#13#10 + 'COPY FILE ERROR: ' + ExpandFileName(ExpandConstant('{src}\..\File1.txt')));

      if FileCopy(ExpandConstant('{src}\..\File2.txt'), ExpandConstant('{src}\Test\File2.txt'), False) then
        MemoTextAppend(#13#10 + 'COPIED FILE: ' + ExpandFileName(ExpandConstant('{src}\..\File2.txt')))
      else
        MemoTextAppend(#13#10 + 'COPY FILE ERROR: ' + ExpandFileName(ExpandConstant('{src}\..\File2.txt')));
    end;
    2 : begin
      if (not DirExists(ExpandConstant('{src}\..\Test'))) and ForceDirectories(ExpandConstant('{src}\..\Test')) then
        MemoTextAppend(#13#10 + 'CREATED DIRECTORY: ' + ExpandFileName(ExpandConstant('{src}\..\Test')));

      if FileCopy(ExpandConstant('{src}\..\File3.txt'), ExpandConstant('{src}\..\Test\File3.txt'), False) then
        MemoTextAppend(#13#10 + 'COPIED FILE: ' + ExpandFileName(ExpandConstant('{src}\..\File3.txt')))
      else
        MemoTextAppend(#13#10 + 'COPY FILE ERROR: ' + ExpandFileName(ExpandConstant('{src}\..\File3.txt')));
    end;
  end;

  MemoRequestUserAction([#13#10 + 'Press any key to continue...'], []);

  StrText := MemoRequestUserAction([#13#10 + #13#10 + 'Digite a value and press Enter key: '], ['']);

  MemoTextAppend(#13#10 + 'Received Text: ' + StrText + #13#10);
  StrText := MemoRequestUserAction([#13#10 + 'Press any key to continue...' + #13#10], []);

  MemoTextAppend(#13#10 + 'Test of progress: ' + PadL('1%', 4) + #13#10);
  Sleep(1000);
  MemoLineWordReplace(MemoLinesCount - 2, PadL('13%', 4));
  //MsgBox('', mbInformation, MB_OK);
  Sleep(1000);
  MemoLineWordReplace(MemoLinesCount - 2, PadL('27%', 4));
  Sleep(1000);
  MemoLineWordReplace(MemoLinesCount - 2, PadL('43%', 4));
  Sleep(1000);
  MemoLineWordReplace(MemoLinesCount - 2, PadL('59%', 4));
  Sleep(1000);
  MemoLineWordReplace(MemoLinesCount - 2, PadL('85%', 4));
  Sleep(1000);
  MemoLineWordReplace(MemoLinesCount - 2, PadL('100%', 4));

  MemoRequestUserAction([#13#10 + 'Press any key to continue...'], []);
  MemoTextAppend(#13#10 + #13#10 + '{#defined(CallBefore) ? "CallBefore" : "CallAfter"} closed...');
end;

//-------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------
#define AW = (Defined UNICODE) ? "W" : "A"

function FindWindow(lpClassName, lpWindowName: String): HWND;
  external 'FindWindow{#AW}@user32.dll stdcall';

function FindWindowEx(hWndParent, hWndChildAfter: HWND; lpszClass, lpszWindow: String): HWND;
  external 'FindWindowEx{#AW}@user32.dll stdcall';

function InitDsgCall(AHandle: THandle; CallBefore: Boolean): Boolean;
  external 'InitDsgCall@{tmp}\dsgcall.dll stdcall delayload';

procedure UninitDsgCall;
  external 'UninitDsgCall@{tmp}\dsgcall.dll stdcall delayload';

function InitializeSetup(): Boolean;
var
  Handle: THandle;
  #if defined(DEBUG)
  ResultCode: Integer;
  ExecTest: String;
  #endif
begin
  Handle := 0;
  #if defined(DEBUG)
  ExecTest := ExpandConstant('{src}\TMemoWindow.exe');
  FileCopy(ExpandConstant('{src}\dsgcall.dll'), ExpandConstant('{tmp}\dsgcall.dll'), False);
  Handle := FindWindowEx(FindWindow('TSetupForm', 'Test of CallBefore/CallAfter file'), 0, 'TNewMemo', '');
  if (Handle = 0) and FileExists(ExecTest) and ShellExec('open', ExecTest, '/DEBUG={#defined(CallBefore) ? "CallBefore" : "CallAfter"}', '', SW_SHOWNORMAL, ewNoWait, ResultCode) then
  begin
    Sleep(1000);
    Handle := FindWindowEx(FindWindow('TSetupForm', 'Test of {#defined(CallBefore) ? "CallBefore" : "CallAfter"} file'), 0, 'TNewMemo', '');
  end;
  #endif
  if Handle = 0 then
    Handle := StrToInt(ExpandConstant('{param:PARENT|0}'));
  if Handle = 0 then
    Handle := StrToInt(ExpandConstant('{param:HANDLE|0}'));
  if not FileExists(ExpandConstant('{tmp}\dsgcall.dll')) then
  begin
    try
      ExtractTemporaryFile('dsgcall.dll');
    except
    end;
  end;
  if InitDsgCall(Handle, {#defined(CallBefore) ? "True" : "False"}) then
  begin
    ProcessUserTasks;
    UninitDsgCall;
  end;
  Result := False;
end;
