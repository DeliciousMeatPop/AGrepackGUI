//----------------------------------------------------//
//  DiskSpan GUI Module 1.0.0.0 (Created by Cesar82)  //
//----------------------------------------------------//

[Files]
#define iCount 0
#define ModulePath ExtractFilePath(__PATHFILENAME__)
Source: "{#ModulePath}\English.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy
Source: "{#ModulePath}\French.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "{#ModulePath}\German.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "{#ModulePath}\Italian.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "{#ModulePath}\Spanish.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "{#ModulePath}\Polish.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "{#ModulePath}\Russian.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "{#ModulePath}\PortugueseBrazil.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "{#ModulePath}\Czech.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "{#ModulePath}\UnArc.dll"; DestDir: "COMPRESSORS"; Flags: dontcopy
Source: "{#ModulePath}\ISDone.dll"; DestDir: "COMPRESSORS"; Flags: dontcopy
Source: "{#ModulePath}\SplitLib.dll"; DestDir: "COMPRESSORS"; Flags: dontcopy
#pragma message AddBackslash(SourcePath) + ExtractFileName(SetupSetting("OutputBaseFilename")) + ".dll"
#if defined(DSG_InternalDLL) && FileExists(AddBackslash(SourcePath) + ExtractFileName(SetupSetting("OutputBaseFilename")) + ".dll")
Source: "{#AddBackslash(SourcePath) + ExtractFileName(SetupSetting("OutputBaseFilename")) + ".dll"}"; DestDir: "{tmp}"; Flags: dontcopy
#else
  #undef DSG_InternalDLL
  #define iFile 0
  #define FindHandle
  #define FindResult
  #define public StrFile
  #dim public FileList[10000]
  #define public FilePath AddBackslash(ModulePath) + "COMPRESSORS"
  ;#define public FilePath AddBackslash(ModulePath) + "..\..\DECOMPRESSOR"
  #sub ProcessFoundFile
      #define DestPath (Trim(ExtractFilePath(StrFile)) != "") ? "COMPRESSORS\" + ExtractFileDir(StrFile) : "COMPRESSORS"
      #emit "Source: """ + AddBackSlash(FilePath) + StrFile + """; DestDir: """ + DestPath + """; Flags: dontcopy;"
      #expr FileList[iCount] = StrFile
      #expr iCount++
      ;#pragma message strFile
  #endSub
  #define private ListPath(str StrLine) \
    StrFile = StrLine, ProcessFoundFile
  #define private ProcessPath(str Path, str Crop = "") \
    StartProcessPath(Path, Crop, FindFirst(AddBackSlash(Path) + '*.*', faAnyFile))
  #define private StartProcessPath(str Path, str Crop, int Handle) \
    handle ? ProcessFilterPath(Path, Crop, handle) : void
  #define private ProcessFilterPath(str Path, str Crop, int Handle) \
    FindGetFileName(Handle) == '.' || FindGetFileName(Handle) == '..' ? \
    GoToNextFile(Path, Crop, Handle) : CheckPathIsDir(Path, Crop, Handle, AddBackSlash(Path) + FindGetFilename(Handle))
  #define private GoToNextFile(str Path, str Crop, int Handle) \
    FindNext(Handle) ? ProcessFilterPath(Path, Crop, handle) : void
  #define private CheckPathIsDir(str Path, str Crop, int Handle, str FileName) \
    DirExists(FileName) ?  ProcessPath(FileName, Crop) + GoToNextFile(Path, Crop, Handle) : \
    ListPath(StringChange(FileName, AddBackSlash(Crop), "")), GoToNextFile(Path, Crop, Handle)
  #expr ProcessPath(FilePath, FilePath)
#endif

[CustomMessages]
ExtractFiles=Extracting files...
ExtractDecomp=Extracting decompressors...
CancelButton=Cancel unpacking
UnpackingError=Unpacking error!
ElapsedTime=Elapsed Time: %1
RemainingTime=Remaining Time: %1
Extracting=Extracting %1...
MergingFile=Merging file %1 (%3%) to %2 (%4%)...
IncompatibleClsVersion=Incompatible version of the "CLS-DiskSpan.dll" library.
ChangeDiskLabel=Please insert disk %1 with %2 file.%nBrowse for required file?
ChangeDiskTitle=Setup Needs the Next Disk
SetupAppTitle={#SetupSetting("AppName")}™ - Setup
ErrorTitle=Error

#ifndef DSG_CreateUninstallList
[UninstallDelete]
Type: filesandordirs; Name: "{app}"
#endif

[Code]
#define AW = (Defined UNICODE) ? "W" : "A"

const
  DSG_MB_ICONERROR = $10;
  DSG_MB_ICONQUESTION = $20;
  DSG_MB_TASKMODAL = $00002000;
  DSG_MOVEFILE_REPLACE_EXISTING = $1;
  DSG_MOVEFILE_COPY_ALLOWED = $2;
  DSG_MOVEFILE_WRITE_THROUGH = $8;
  DSG_PM_REMOVE = $0001;
  DSG_GW_OWNER = 4;

type
  TCallback = function(OveralPct, CurrentPct: Integer; CurrentFile, TimeStr1, TimeStr2, TimeStr3: PAnsiChar): LongWord;

#if (VER < 0x06000000) && !defined(IS_ENHANCED)
  TFreeArcCallback = function (What: PAnsiChar; Int1, Int2: Integer; Str: PAnsiChar): Integer;
#endif

  DSG_TMsg = record
    hWnd: HWND;
    message: LongWord;
    wParam: Longint;
    lParam: Longint;
    Time: LongWord;
    pt: TPoint;
  end;

  DSG_TSystemInfo = record
    wProcessorArchitecture: Word;
    wReserved: Word;
    dwPageSize: DWORD;
    lpMinimumApplicationAddress: Integer;
    lpMaximumApplicationAddress: Integer;
    dwActiveProcessorMask: DWORD;
    dwNumberOfProcessors: DWORD;
    dwProcessorType: DWORD;
    dwAllocationGranularity: DWORD;
    wProcessorLevel: Integer;
    wProcessorRevision: Word;
  end;

  TArrayOfExtended = Array of Extended;
  TExtendedMatrix = Array of TArrayOfExtended;
  TArcType = (tpUnd, tsArc, tsZip, tsRar, tmArc, tmZip, tmRar, tpSplit, tpDelta, tpExec, tpHash);

  TArcFiles = Array of record
    Pct: Double;
    AType: TArcType;
    SizeEx: Extended;
    Source, Output, Disk, Password: String;
    Component, Task, Language: String;
    SubDir, Slices, Section: String;
  end;

  THashFileList = Array of record
    FileName: String;
    BasePath: String;
    AppDirFile: Boolean;
    FilesCount: Integer;
    PctOfTotal: Double;
  end;

#if (VER < 0x06000000) && !defined(IS_ENHANCED)
function WrapFreeArcCallback(Callback: TFreeArcCallback; ParamCount: Integer): LongWord; external 'wrapcallback@files:ISDone.dll stdcall delayload';
function WrapCallback(Callback: TCallback; ParamCount: Integer): LongWord; external 'wrapcallback@files:ISDone.dll stdcall delayload';
#endif
function ISArcExtract(CurComponent: Cardinal; PctOfTotal: Double; InName, OutPath, ExtractedPath: AnsiString; DeleteInFile: Boolean; Password, CfgFile, WorkPath: AnsiString; ExtractPCF: Boolean): Boolean; external 'ISArcExtract@files:ISDone.dll stdcall delayload';
function IS7ZipExtract(CurComponent: Cardinal; PctOfTotal: Double; InName, OutPath: AnsiString; DeleteInFile: Boolean; Password: AnsiString): Boolean; external 'IS7zipExtract@files:ISDone.dll stdcall delayload';
function ISRarExtract(CurComponent: Cardinal; PctOfTotal: Double; InName, OutPath: AnsiString; DeleteInFile: Boolean; Password: AnsiString): Boolean; external 'ISRarExtract@files:ISDone.dll stdcall delayload';
function ISxDeltaExtract(CurComponent: Cardinal; PctOfTotal: Double; MinRAM, MaxRAM: Integer; InName, DiffFile, OutFile: AnsiString; DeleteInFile, DeleteDiffFile: Boolean): Boolean; external 'ISxDeltaExtract@files:ISDone.dll stdcall delayload';
function Exec2(FileName, Param: PAnsiChar; Show: Boolean): Boolean; external 'Exec2@files:ISDone.dll stdcall delayload';
function ISExec(CurComponent: Cardinal; PctOfTotal, SpecifiedProcessTime: Double; ExeName, Parameters, TargetDir, OutputStr: AnsiString; Show: Boolean): Boolean; external 'ISExec@files:ISDone.dll stdcall delayload';
function ISDoneInit(RecordFileName: AnsiString; TimeType, Comp1, Comp2, Comp3: Cardinal; WinHandle, NeededMem: Longint; Callback: TCallback): Boolean; external 'ISDoneInit@files:ISDone.dll stdcall delayload';
function ISDoneStop(): Boolean; external 'ISDoneStop@files:ISDone.dll stdcall delayload';
function ChangeLanguage(Language: AnsiString): Boolean; external 'ChangeLanguage@files:ISDone.dll stdcall delayload';
function SuspendProc(): Boolean; external 'SuspendProc@files:ISDone.dll stdcall delayload';
function ResumeProc(): Boolean; external 'ResumeProc@files:ISDone.dll stdcall delayload';

type { SplitLib 1.0.0.4 }
  TSplitState = (ssRead, ssRunning, ssPaused, ssStoped);
  TSplitCallback = function(const State: TSplitState; const SrcFile, DstFile: WideString; SplitPos, MinProg, MaxProg: Integer; SrcPos, SrcSize, DstPos, DstSize: Extended): Boolean;

//function SplitDataFile(const SrcFile, DstFile: WideString; SizeOfParts: WideString; InitProg, MaxProg: Integer; CallBack: TSplitCallback): Boolean; external 'SplitDataFile@files:SplitLib.dll stdcall delayload';
//function JoinDataFiles(const SrcFile, DstFile: WideString; InitProg, MaxProg: Integer; CallBack: TSplitCallback): Boolean; external 'JoinDataFiles@files:SplitLib.dll stdcall delayload';
function MergeDataFile(const SrcFile, DstFile: WideString; SizeOfParts: WideString; CurrPart, InitProg, MaxProg: Integer; FirstPart: Boolean; CallBack: TSplitCallback): Boolean; external 'MergeDataFile@files:SplitLib.dll stdcall delayload';
function SplitState(State: TSplitState): TSplitState; external 'SplitState@files:SplitLib.dll stdcall delayload';
procedure SplitBuffer(Size, Slice: Integer); external 'SplitBuffer@files:SplitLib.dll stdcall delayload';

function FloatToString(const Float: Extended; Offset: Integer): WideString; external 'FloatToString@files:SplitLib.dll stdcall delayload';
function ProgressCalcule(FilePos, FileSize, MaxProg: Extended): Extended; external 'ProgressCalcule@files:SplitLib.dll stdcall delayload';
//function ConvertDisk(const FirstDisk: WideString; DiskNumber: Integer): WideString; external 'ConvertDisk@files:SplitLib.dll stdcall delayload';
//procedure ValueToBytes(const Value: WideString; Default: Extended; var Bytes: Extended); external 'ValueToBytes@files:SplitLib.dll stdcall delayload';

//type
//  TEncodeType = (etUSASCII, etUTF8, etANSI);
//
//function DetectUTF8Encoding(strText: WideString): TEncodeType; external 'DetectUTF8Encoding@{tmp}\SplitLib.dll stdcall delayload';
//function IsUtf8String(strText: WideString): Boolean; external 'IsUtf8String@files:SplitLib.dll stdcall delayload';
function AnsiToUtf8(strSource: WideString): WideString; external 'AnsiToUtf8@files:SplitLib.dll stdcall delayload';
//function Utf8ToAnsi(strSource: WideString): WideString; external 'Utf8ToAnsi@files:SplitLib.dll stdcall delayload';
function StrAsAnsi(StrText: WideString): WideString; external 'StrAsAnsi@files:SplitLib.dll stdcall delayload';
//function StrAsUtf8(StrText: WideString): WideString; external 'StrAsUtf8@files:SplitLib.dll stdcall delayload';

//function AnsiText(Text: String): AnsiString;
//begin
//  if IsUtf8String(Text) then
//    Result := Utf8ToAnsi(Text)
//  else
//    Result := Text;
//end;

//type
//  TWideStringArray = Array of WideString;
//  TExprType = (peString, peHex, peBool, peFloat);
//
//function ParseExpressionEx(Expr: WideString; ExprType: TExprType; CStyle: Boolean; DecimalSep, ArgumentSep: Char): Variant; external 'ParseExpressionEx@files:SplitLib.dll stdcall delayload';
//function ParseExpressionVars(Expr: WideString; ExprType: TExprType; CStyle: Boolean; DecimalSep, ArgumentSep: Char; Vars: TWideStringArray): Variant; external 'ParseExpressionVars@files:SplitLib.dll stdcall delayload';
//function ParseExpressionAsString(Expr: WideString): WideString; external 'ParseExpressionAsString@files:SplitLib.dll stdcall delayload';
//function ParseExpressionExAsString(Expr: WideString; CStyle: Boolean; DecimalSep, ArgumentSep: Char): WideString; external 'ParseExpressionExAsString@files:SplitLib.dll stdcall delayload';
//function ParseExpressionAsHexadecimal(Expr: WideString): WideString; external 'ParseExpressionAsHexadecimal@files:SplitLib.dll stdcall delayload';
//function ParseExpressionExAsHexadecimal(Expr: WideString; CStyle: Boolean; DecimalSep, ArgumentSep: Char): WideString; external 'ParseExpressionExAsHexadecimal@files:SplitLib.dll stdcall delayload';
//function ParseExpressionAsFloat(Expr: WideString): Double; external 'ParseExpressionAsFloat@files:SplitLib.dll stdcall delayload';
//function ParseExpressionExAsFloat(Expr: WideString; CStyle: Boolean; DecimalSep, ArgumentSep: Char): Double; external 'ParseExpressionExAsFloat@files:SplitLib.dll stdcall delayload';
//function ParseExpressionAsBoolean(Expr: WideString): Boolean; external 'ParseExpressionAsBoolean@files:SplitLib.dll stdcall delayload';
function ParseExpressionExAsBoolean(Expr: WideString; CStyle: Boolean; DecSep, ArgSep: Char): Boolean; external 'ParseExpressionExAsBoolean@files:SplitLib.dll stdcall delayload';

//function WordToChar(Value: Word): Char; external 'WordToChar@files:SplitLib.dll stdcall delayload';
//function FloatToText(Value: Extended): WideString; external 'FloatToText@files:SplitLib.dll stdcall delayload';
//function IsWildcardEx(const Pattern: WideString): Boolean; external 'IsWildcardEx@files:SplitLib.dll stdcall delayload';
function WildcardMatchEx(const Text, Pattern: WideString; CaseSensitive: Boolean): Boolean; external 'WildcardMatchEx@files:SplitLib.dll stdcall delayload';
function DSG_CreateBitmapRgn(DC: LongWord; hBmp: HBitmap; TransColor, TolerColor: DWORD; dX, dY: Integer): LongWord; external 'CreateBitmapRgn@files:SplitLib.dll stdcall delayload';

type
  DSG_TFFResultKind = (dsg_ffrkFull, dsg_ffrkRelative, dsg_ffrkOnlyName);

function DSG_pFindFiles(const FindPath, FileMasks, ExcludeMasks: WideString; ResultKind: DSG_TFFResultKind; Recursive, FindDirs: Boolean): Longint; external 'pFindFiles@files:SplitLib.dll stdcall delayload';
//function DSG_FindFilesEx(const FindPath, FileMasks, ExcludeMasks: WideString; ResultKind: DSG_TFFResultKind; Recursive, HiddenFiles, SystemFiles, FindDirs: Boolean): Longint; external 'pFindFilesEx@files:SplitLib.dll stdcall delayload';
function DSG_pFileCount(const FindHandle: Longint): Integer; external 'pFileCount@files:SplitLib.dll stdcall delayload';
function DSG_pPickFile(const FindHandle: Longint; const Index: Integer): WideString; external 'pPickFile@files:SplitLib.dll stdcall delayload';
//function DSG_pPickSize(const FindHandle: Longint; const Index: Integer): WideString; external 'pPickSize@files:SplitLib.dll stdcall delayload';
//function DSG_pPickAttrib(const FindHandle: Longint; const Index: Integer): Integer; external 'pPickAttrib@files:SplitLib.dll stdcall delayload';
//function DSG_pDirCount(const FindHandle: Longint): Integer; external 'pDirCount@files:SplitLib.dll stdcall delayload';
//function DSG_pPickDir(const FindHandle: Longint; const Index: Integer): WideString; external 'pPickDir@files:SplitLib.dll stdcall delayload';
function DSG_pFindFree(const FindHandle: Longint): Boolean; external 'pFindFree@files:SplitLib.dll stdcall delayload';

//function GetCpuName(): WideString; external 'GetCpuName@files:SplitLib.dll stdcall delayload';
//function GetCpuRealClockSpeed(): Integer; external 'GetCpuRealClockSpeed@files:SplitLib.dll stdcall delayload';
//function GetCpuPhysicalCores(): Integer; external 'GetCpuPhysicalCores@files:SplitLib.dll stdcall delayload';
//function GetCpuLogicalCores(): Integer; external 'GetCpuLogicalCores@files:SplitLib.dll stdcall delayload';
//function GetTotalVisibleMemoryEx(): Extended; external 'GetTotalVisibleMemoryEx@files:SplitLib.dll stdcall delayload';
//function GetFreePhysicalMemoryEx(): Extended; external 'GetFreePhysicalMemoryEx@files:SplitLib.dll stdcall delayload';
//function GetTotalVisibleMemory(): Cardinal; external 'GetTotalVisibleMemory@files:SplitLib.dll stdcall delayload';
//function GetFreePhysicalMemory(): Cardinal; external 'GetFreePhysicalMemory@files:SplitLib.dll stdcall delayload';
//function GetOSName(): WideString; external 'GetOSName@files:SplitLib.dll stdcall delayload';
//function GetOSVersionMajor(): Cardinal; external 'GetOSVersionMajor@files:SplitLib.dll stdcall delayload';
//function GetOSVersionMinor(): Cardinal; external 'GetOSVersionMinor@files:SplitLib.dll stdcall delayload';
//function GetOSBuildNumbers(): Cardinal; external 'GetOSBuildNumbers@files:SplitLib.dll stdcall delayload';
//function GetServicePackMajorVersion(): Word; external 'GetServicePackMajorVersion@files:SplitLib.dll stdcall delayload';
//function GetServicePackMinorVersion(): Word; external 'GetServicePackMinorVersion@files:SplitLib.dll stdcall delayload';
//function GetOSArchitecture(): Byte; external 'GetOSArchitecture@files:SplitLib.dll stdcall delayload';

type { CLS DiskSpan }
  TDiskSpanStatus = (cbStoped, cbPaused, cbWorking);
  TDiskSpanProc = procedure(Status: TDiskSpanStatus);
  TRequestDisk = procedure(var lpPath: WideString; lpFileName: WideString);

function DiskSpanInit(hParent: THandle; lpPath: WideString; DiskRequest: TRequestDisk; Callback: TDiskSpanProc): Boolean; external 'ClsInit@{tmp}\CLS-DISKSPAN.dll stdcall delayload'; // optional
//procedure SetDiskRequest(DiskRequest: TRequestDisk); external 'ClsSetDiskRequest@{tmp}\CLS-DISKSPAN.dll stdcall delayload';
procedure SetSourcePath(lpPath: WideString); external 'ClsSetSourcePath@{tmp}\CLS-DISKSPAN.dll stdcall delayload';
function GetSourcePath(): WideString; external 'ClsGetSourcePath@{tmp}\CLS-DISKSPAN.dll stdcall delayload';
procedure SetMessageText(lpText, lpCaption: WideString); external 'ClsSetMessageText@{tmp}\CLS-DISKSPAN.dll stdcall delayload';
procedure SetDiskList(lpDisks: WideString); external 'ClsSetDiskList@{tmp}\CLS-DISKSPAN.dll stdcall delayload';

function DSG_FreeArcExtract(Callback: LongWord; Cmd1, Cmd2, Cmd3, Cmd4, Cmd5, Cmd6, Cmd7, Cmd8, Cmd9, Cmd10: PAnsiChar): Integer; external 'FreeArcExtract@files:UnArc.dll cdecl';
function DSG_OemToCharBuff(lpszSrc: AnsiString; lpszDst: String; cchDstLength: DWORD): BOOL; external 'OemToCharBuff{#AW}@user32.dll stdcall delayload';
function DSG_MessageBox(hWnd: HWND; lpText, lpCaption: String; uType: UINT): Integer; external 'MessageBox{#AW}@user32.dll stdcall delayload';
function DSG_FreeLibrary(hModule: THandle): BOOL; external 'FreeLibrary@kernel32.dll stdcall delayload';
function DSG_GetModuleHandle(lpModuleName: String): THandle; external 'GetModuleHandle{#AW}@kernel32.dll stdcall delayload';
function DSG_MoveFileEx(lpExistingFileName: String; lpNewFileName: String; dwFlags: DWORD): BOOL; external 'MoveFileEx{#AW}@kernel32.dll stdcall delayload';
function DSG_TranslateMessage(const lpMsg: DSG_TMsg): BOOL; external 'TranslateMessage@user32.dll stdcall delayload';
function DSG_DispatchMessage(const lpMsg: DSG_TMsg): Longint; external 'DispatchMessage{#AW}@user32.dll stdcall delayload';
function DSG_PeekMessage(var lpMsg: DSG_TMsg; hWnd: HWND; wMsgFilterMin, wMsgFilterMax, wRemoveMsg: UINT): BOOL; external 'PeekMessage{#AW}@user32.dll stdcall delayload';
function DSG_SetFileAttributes(lpFileName: String; dwFileAttributes: DWORD): BOOL; external 'SetFileAttributes{#AW}@kernel32.dll stdcall delayload';
function DSG_SetFocus(hWnd: HWND): HWND; external 'SetFocus@user32.dll stdcall delayload';
function DSG_GetWindow(hWnd: HWND; uCmd: UINT): HWND; external 'GetWindow@user32.dll stdcall delayload';
function DSG_GetTickCount(): DWORD; external 'GetTickCount@kernel32 stdcall delayload';
procedure DSG_GetSystemInfo(var lpSystemInfo: DSG_TSystemInfo); external 'GetSystemInfo@kernel32.dll stdcall delayload';

function DSG_GetElapseTime(dwTime: DWORD): DWORD;
var
  dwTick: DWORD;
begin
  dwTick := DSG_GetTickCount();
  if dwTick < dwTime then {Fix GetTickCount() 49.7 days time limit}
    Result := $FFFFFFFF - dwTime + dwTick
  else
    Result := dwTick - dwTime;
end;

procedure DSG_ProcessMessages();
var
  Msg: DSG_TMsg;
begin
  while DSG_PeekMessage(Msg, 0, 0, 0, DSG_PM_REMOVE) do
  begin
    DSG_TranslateMessage(Msg);
    DSG_DispatchMessage(Msg);
  end;
end;

function DSG_GetTextWidth(aText: String; aFont: TFont): Integer;
var
  Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  try
    Bmp.Canvas.Font.Assign(aFont);
    Result := Bmp.Canvas.TextWidth(aText);
  finally
    Bmp.Free;
  end;
end;

function OemToAnsiStr(strSource: AnsiString): String;
begin
  SetLength(Result, Length(strSource));
  DSG_OemToCharBuff(strSource, Result, Length(Result));
end;

function GetCPUThreads(): Integer;
var
  SysInfo: DSG_TSystemInfo;
begin
  DSG_GetSystemInfo(SysInfo);
  Result := SysInfo.dwNumberOfProcessors;
end;

function DSG_IfThen(AValue: Boolean; const ATrue, AFalse: Variant): Variant;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function DSG_MaxFloat(A, B: Extended): Extended;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

function DSG_EmptyStr(S: String): Boolean;
begin
  Result := Trim(S) = '';
end;

function DSG_StrToFloatDef(S: String; Def: Extended): Extended;
begin
  if Trim(S) = '' then
    Result := Def
  else
    try
      Result := StrToFloat(S);
    except
      Result := Def;
    end;
end;

function DSG_PowerK(Value: Extended; Offset: Integer): Extended;
var
  I: Integer;
begin
  Result := Value;
  for I := 1 to Offset do
    Result := Result * 1024;
end;

function DSG_GetSizeBytes(const Value: String; Default: Extended): Extended;
var
  I: Integer;
  Pt: Integer;
  TmpStr: String;
  Unity: String;
begin
  I := 1;
  Pt := 0;
  Unity := '';
  TmpStr := Trim(Value);
  StringChangeEx(TmpStr, ',', '.', True);
  while Length(TmpStr) >= I do {remove no numeric caractere}
  begin
    if StrToIntDef(TmpStr[I], 10) = 10 then begin
      if (Pt = 0) and (I > 1) and (TmpStr[I] = '.') then begin
        Inc(Pt);
        Inc(I);
      end else begin
        if (TmpStr[I] <> '.') and (TmpStr[I] <> ' ') and (Length(Unity) < 3) then
          Unity := Unity + TmpStr[I];
        Delete(TmpStr, I, 1)
      end;
    end else
      Inc(I);
  end;
  if TmpStr <> '' then
  begin
    SetLength(Unity, 2);
    case Trim(Uppercase(Unity)) of
      'PB', 'P' : Result := DSG_PowerK(DSG_StrToFloatDef(TmpStr, Default), 5{PB});
      'TB', 'T' : Result := DSG_PowerK(DSG_StrToFloatDef(TmpStr, Default), 4{TB});
      'GB', 'G' : Result := DSG_PowerK(DSG_StrToFloatDef(TmpStr, Default), 3{GB});
      'MB', 'M' : Result := DSG_PowerK(DSG_StrToFloatDef(TmpStr, Default), 2{MB});
      'KB', 'K' : Result := DSG_PowerK(DSG_StrToFloatDef(TmpStr, Default), 1{KB});
      'BY', 'B' : begin
        StringChangeEx(TmpStr, '.', '', True);
        StringChangeEx(TmpStr, ',', '', True);
        Result := DSG_StrToFloatDef(TmpStr, Default);
      end;
      else begin
        if Pos('.', Copy(TmpStr, Pos('.', TmpStr), Length(TmpStr))) > 0 then
        begin
          StringChangeEx(TmpStr, '.', '', True);
          Result := DSG_StrToFloatDef(TmpStr, Default);
        end else
          Result := DSG_PowerK(DSG_StrToFloatDef(TmpStr, Default), 2{MB});
      end;
    end;
  end else
    Result := Default;
end;

function DSG_CloseProcess(const Process: String): Integer;
var
  ProcInt: Integer;
  WQLQuery: String;
  WbemLocator: Variant;
  WbemServices: Variant;
  WbemObject: Variant;
  WbemObjectSet: Variant;
begin
  Result := 0;
  if FileExists(Process) then
  begin
    try
      WQLQuery := 'SELECT ExecutablePath FROM Win32_Process WHERE Name LIKE "%' + ExtractFileName(Process) + '%"';
      WbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      if VarIsNull(WbemLocator) then Exit;
      WbemServices := WbemLocator.ConnectServer('localhost', 'root\CIMV2');
      if VarIsNull(WbemServices) then Exit;
      WbemObjectSet := WbemServices.ExecQuery(WQLQuery);
      if VarIsNull(WbemObjectSet) then Exit;
      if WbemObjectSet.Count > 0 then
      begin
        for ProcInt := 0 to WbemObjectSet.Count - 1 do
        begin
          WbemObject := WbemObjectSet.ItemIndex(ProcInt);
          if not VarIsNull(WbemObject) then
          begin
            if CompareText(WbemObject.ExecutablePath, Process) = 0 then
            begin
              WbemObject.Terminate;
              WbemObject := Unassigned;
              Inc(Result);
            end;
          end;
        end;
      end;
    except
    end;
  end;
end;

function DSG_CloseTempProcessFromDir(const FromDir: String): Integer;
var
  FindRec: TFindRec;
begin
  if FindFirst(AddBackslash(FromDir) + '*', FindRec) then
  begin
    try
      repeat
        if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
        begin
          if FileExists(AddBackslash(FromDir) + FindRec.Name)
          and (LowerCase(ExtractFileExt(FindRec.Name)) = '.exe') then
            Result := DSG_CloseProcess(AddBackslash(FromDir) + FindRec.Name)
          else
            if DirExists(AddBackslash(FromDir) + FindRec.Name) then
              Result := DSG_CloseTempProcessFromDir(AddBackslash(FromDir) + FindRec.Name);
        end;
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
    end;
  end;
end;

function DSG_ParseCheckItemsLine(ItemList: TStringList; ItemLine: String; IsLang: Boolean): String;
var
  I: Integer;
  S1, S2, S3: String;
begin
  S2 := '';
  S3 := '';
  S1 := TrimLeft(ItemLine);
  for I := 1 to Length(S1) do
  begin
    case Copy(S1, I, 1) of
      '&', '+' : begin
        if Copy(S2, Length(S2) - 1, 2) <> '&&' then
          Insert('&&', S2, Length(S2) + 1);
      end;
      '|', ',' : begin
        if Copy(S2, Length(S2) - 1, 2) <> '||' then
          Insert('||', S2, Length(S2) + 1);
      end;
      '!' : begin
        if Copy(S2, Length(S2), 1) <> '!' then
          Insert('!', S2, Length(S2) + 1);
      end;
      '(', ')' : Insert(Copy(S1, I, 1), S2, Length(S2) + 1);
      '0'..'9' : begin
        if not IsLang then
          Insert(Copy(S1, I, 1), S3, Length(S3) + 1);
      end;
      'A'..'Z', 'a'..'z' : begin
        if IsLang then
          Insert(Copy(S1, I, 1), S3, Length(S3) + 1);
      end;
    end;
    if S3 <> '' then
    begin
      case Copy(S1, I, 1) of
        '&', '+', '|', ',', '!', '(', ')' : { supported operator };
        else
          case Copy(S1, I + 1, 1) of
            '', '&', '+', '|', ',', '(', ')', '!' : begin
              if IsLang then
                Insert(IntToStr(Ord(ItemList.IndexOf(UpperCase(S3)) >= 0)), S2, Length(S2) + 1)
              else
                Insert(IntToStr(Ord(ItemList.IndexOf(S3) >= 0)), S2, Length(S2) + 1);
              S3 := '';
            end;
          end;
      end;
    end;
  end;
  Result := S2;
end;

//---------------------------------------------------------------------------------------------------------------------------------
var
  DSG_LangList: TStringList;
  DSG_CompList: TStringList;
  DSG_TaskList: TStringList;
  DSG_StatusLabel: TNewStaticText;
  DSG_FileNameLabel: TNewStaticText;
  DSG_ProgressCallback: TCallback;
  DSG_ActLang: String;
  DSG_OutputPath: String;
  DSG_Unpacking: Boolean;
  DSG_UnpackCanceled: Boolean;
  DSG_FormHandle: THandle;
  HashFileList: THashFileList;
  IsDoneInitialized: Boolean;
  ISDoneCancel: Integer;
  ISDoneError: Boolean;
  SingleUnpack: Boolean;
  DLLFileCount: Integer;
  LastArcFile: String;
  ArcSubDir: String;
  ClsLibInit: Boolean;
  IsTempFiles: Boolean;
  SplitPct: Double;
  Arcs: TArcFiles;

function DSG_GetLangLabel(Message: String): String;
begin
  try
    if DSG_ActLang = '' then
      Result := CustomMessage(Message)
    else
      Result := CustomMessage(DSG_ActLang + '_' + Message);
  except
    try
      Result := CustomMessage('eng_' + Message);
    except
      Result := '';
    end;
  end;
end;

function DSG_ExpandConstantTry(const S: String; nTry: Integer): String;
var
  S1, S2: String;
  S3, S4: String;
  I, X, Y: Integer;
begin
  I := 0;
  S1 := S;
  S3 := '';
  S4 := RemoveBackSlash(DSG_OutputPath);
  repeat
    X := Pos('{', S1);
    if X > 0 then
    begin
      I := I + 1;
      S2 := Copy(S1, X, Length(S1));
      Y := Pos('}', S2 + '}');
      S2 := Copy(S2, 0, Y);
      try
        S2 := ExpandConstant(S2);
      except
        if Trim(S2) = '{app}' then
          S2 := S4;
      end;
      S3 := S3 + Copy(S1, 0, X - 1) + S2;
      S1 := Copy(S1, X + Y, Length(S1));
      if (nTry > 0) and (I >= nTry) then
      begin
        S3 := S3 + S1;
        Break;
      end;
    end else
      S3 := S3 + S1;
  until X = 0;
  Result := S3;
end;

function DSG_MergeFileCallback_Dummy(const State: TSplitState; const SrcFile, DstFile: WideString; SplitPos, MinProg, MaxProg: Integer; SrcPos, SrcSize, DstPos, DstSize: Extended): Boolean;
begin
  Result := ISDoneCancel = 0;
end;

function DSG_ProgressCallback_Dummy(OveralPct, CurrentPct: Integer; CurrentFile, TimeStr1, TimeStr2, TimeStr3: PAnsiChar): LongWord;
begin
  Result := ISDoneCancel;
end;

function ComponentsCheck(CompLine: String): Boolean;
var
  StrLine: String;
begin
  Result := DSG_EmptyStr(CompLine) or (Pos('*', CompLine) > 0);
  if (not Result) and Assigned(DSG_CompList) then
  begin
    try
      StrLine := DSG_ParseCheckItemsLine(DSG_CompList, CompLine, False);
      Result := ParseExpressionExAsBoolean('(' + StrLine + ')==1', True, '.', ';');
    except
      Log('Exception on ParseExpressionExAsBoolean function');
    end;
  end;
end;

function TasksCheck(TaskLine: String): Boolean;
var
  StrLine: String;
begin
  Result := DSG_EmptyStr(TaskLine) or (Pos('*', TaskLine) > 0);
  if (not Result) and Assigned(DSG_TaskList) then
  begin
    try
      StrLine := DSG_ParseCheckItemsLine(DSG_TaskList, TaskLine, False);
      Result := ParseExpressionExAsBoolean('(' + StrLine + ')==1', True, '.', ';');
    except
      Log('Exception on ParseExpressionExAsBoolean function');
    end;
  end;
end;

function LanguagesCheck(LangLine: String): Boolean;
var
  StrLine: String;
begin
  Result := DSG_EmptyStr(LangLine) or (Pos('*', LangLine) > 0);
  if (not Result) and Assigned(DSG_LangList) then
  begin
    try
      StrLine := DSG_ParseCheckItemsLine(DSG_LangList, LangLine, True);
      Result := ParseExpressionExAsBoolean('(' + StrLine + ')==1', True, '.', ';');
    except
      Log('Exception on ParseExpressionExAsBoolean function');
    end;
  end;
end;

function CheckError: Boolean;
begin
  Result := not ISDoneError;
end;

procedure DSG_PauseUnpacker(Pause: Boolean);
begin
  if IsDoneInitialized then
  begin
    if FileExists(ExpandConstant('{tmp}\ISDone.dll')) then
    begin
      case Pause of
        True  : SuspendProc;
        False : ResumeProc;
      end;
    end;
    if FileExists(ExpandConstant('{tmp}\SplitLib.dll'))
    and (SplitState(ssRead) in [ssRunning, ssPaused]) then
    begin
      case Pause of
        True  : SplitState(ssPaused);
        False : SplitState(ssRunning);
      end;
    end;
  end;
end;

function DSG_ExpandArcFile(ArcFile, SrcDir: String): String;
begin
  Result := ArcFile;
  StringChange(Result, '{src}', RemoveBackslashUnlessRoot(SrcDir));
  Result := DSG_ExpandConstantTry(Result, 1);
end;

function DSG_BrowseArcFile(const ArcFile, Disk: String; var SrcDir: String): String;
var
  I: Integer;
  TmpStr: String;
  TmpPath: String;
  StrLabel: String;
  DiskNumber: String;
  FirstPath: String;
begin
  SuspendProc();
  DiskNumber := Trim(Disk);
  if ClsLibInit then
  begin
    if ClsLibInit then
      SetDiskList(DiskNumber);
    if GetSourcePath <> '' then
      SrcDir := GetSourcePath;
  end;
  FirstPath := ExtractFileName(RemoveBackslash(SrcDir));
  if (FirstPath <> '') and (not FileExists(DSG_ExpandArcFile(ArcFile, SrcDir))) then
  begin
    TmpPath := ExtractFilePath(RemoveBackslash(SrcDir)) + FirstPath;
    ArcFile := AddBackslash(TmpPath) + ExtractFileName(ArcFile);
    if not FileExists(DSG_ExpandArcFile(ArcFile, TmpPath)) then
    begin
      TmpStr := '';
      I := Length(FirstPath);
      while (I > 0) and (StrToIntDef(FirstPath[I], 10) < 10) do
      begin
        TmpStr := FirstPath[I] + TmpStr;
        Dec(I);
      end;
      if TmpStr <> '' then
      begin
        I := Length(TmpStr);
        TmpStr := Padz(IntToStr(StrToInt(TmpStr) + 1), I);
        TmpPath := RemoveBackslash(SrcDir);
        TmpPath := Copy(TmpPath, 1, Length(TmpPath) - I) + TmpStr;
        ArcFile := AddBackslash(TmpPath) + ExtractFileName(ArcFile);
        if FileExists(DSG_ExpandArcFile(ArcFile, TmpPath)) then
        begin
          SrcDir := TmpPath;
          FirstPath := ExtractFileName(RemoveBackslash(SrcDir));
        end;
      end;
    end else
      SrcDir := TmpPath;
  end else
    FirstPath := ExtractFileName(RemoveBackslash(SrcDir));

  if not FileExists(DSG_ExpandArcFile(ArcFile, SrcDir)) then
    SrcDir := ExtractFilePath(LastArcFile);

  while (not FileExists(DSG_ExpandArcFile(ArcFile, SrcDir))) and (not ISDoneError) do
  begin
    StrLabel := FmtMessage(DSG_GetLangLabel('ChangeDiskLabel'), [Copy(Trim(DiskNumber), 1, Pos(',', Trim(DiskNumber) + ',') - 1), ExtractFileName(ArcFile)]);
    StringChangeEx(StrLabel, #32#32, #32, True);
    case DSG_MessageBox(DSG_FormHandle, StrLabel, DSG_GetLangLabel('ChangeDiskTitle'), MB_OKCANCEL or DSG_MB_ICONQUESTION or DSG_MB_TASKMODAL) of
      IDCANCEL : begin
        ISDoneCancel := 1;
        ISDoneError := True;
        ResumeProc();
        try
          WizardForm.CancelButton.OnClick(nil);
        except
        end;
      end;
      IDOK : begin
        if FileExists(DSG_ExpandArcFile(ArcFile, SrcDir)) then
        begin
          SrcDir := ExtractFileDir(DSG_ExpandArcFile(ArcFile, SrcDir));
          FirstPath := ExtractFileName(RemoveBackslash(SrcDir));
        end else
          if GetOpenFileName('open', ArcFile, AddBackslash(SrcDir), ExtractFileName(ArcFile) + '|' + ExtractFileName(ArcFile), ExtractFileName(ArcFile)) then
          begin
            SrcDir := ExtractFileDir(ArcFile);
            FirstPath := ExtractFileName(RemoveBackslash(SrcDir));
          end;
      end;
    end;
  end;
  Result := DSG_ExpandArcFile(ArcFile, SrcDir);
  if ClsLibInit then
    SetSourcePath(WideString(SrcDir));

  LastArcFile := Result;
  ResumeProc();
end;

procedure DSG_RenameINIFiles(Optimal: Boolean);
begin
  if FileCopy(ExpandConstant('{tmp}\CLS_' + DSG_IfThen(Optimal, 'Optimal', 'Standard') + '.ini'), ExpandConstant('{tmp}\CLS.ini'), False) then
  begin
    DeleteFile(ExpandConstant('{tmp}\CLS_Standard.ini'));
    DeleteFile(ExpandConstant('{tmp}\CLS_Optimal.ini'));
  end;
  if FileCopy(ExpandConstant('{tmp}\ARC_' + DSG_IfThen(Optimal, 'Optimal', 'Standard') + '_' + DSG_IfThen(IsWin64, 'x64', 'x86') + '.ini'), ExpandConstant('{tmp}\Arc.ini'), False) then
  begin
    DeleteFile(ExpandConstant('{tmp}\ARC_Standard_x64.ini'));
    DeleteFile(ExpandConstant('{tmp}\ARC_Standard_x86.ini'));
    DeleteFile(ExpandConstant('{tmp}\ARC_Optimal_x64.ini'));
    DeleteFile(ExpandConstant('{tmp}\ARC_Optimal_x86.ini'));
  end else
    if FileCopy(ExpandConstant('{tmp}\ARC_' + DSG_IfThen(Optimal, 'Optimal', 'Standard') + '.ini'), ExpandConstant('{tmp}\Arc.ini'), False) then
    begin
      DeleteFile(ExpandConstant('{tmp}\ARC_Standard.ini'));
      DeleteFile(ExpandConstant('{tmp}\ARC_Optimal.ini'));
    end;
end;

function DSG_GetDLLFileName(Default: String): String;
begin
  Result := ChangeFileExt(ExpandConstant('{srcexe}'), '.dll');
  if not FileExists(Result) then
  begin
    try
      if not FileExists(ExpandConstant('{tmp}\{#SetupSetting("OutputBaseFilename")}.dll')) then
        ExtractTemporaryFile('{#SetupSetting("OutputBaseFilename")}.dll');
      Result := ExpandConstant('{tmp}\{#SetupSetting("OutputBaseFilename")}.dll');
    except
    end;
    if not FileExists(Result) then
      Result := Default;
  end;
end;

function FreeArcCallback(What: PAnsiChar; Int1, Int2: Integer; Str: PAnsiChar): Integer;
var
  StrText: String;
begin
  Result := 0;
  if String(What) = 'password?' then
  begin
    StrText := OemToAnsiStr(Str);
    DSG_MessageBox(DSG_FormHandle, 'The password used to extract Setup.dll is incorrect.' + #13#10 + 'Password: ' + StrText, DSG_GetLangLabel('ErrorTitle'), MB_OK or DSG_MB_ICONERROR or DSG_MB_TASKMODAL);
    Result := (-10); {-63} {-127}
  end else
    if (not SingleUnpack) and (String(What) = 'filename') then
    begin
      StrText := OemToAnsiStr(Str);
      DLLFileCount := DLLFileCount + 1;
      Log('Unpacking temporary file: ' + StrText);
      if DSG_ProgressCallback <> nil then
      begin
        if DSG_ProgressCallback((-1), DLLFileCount, PansiChar(StrText), '', '', '') <> 0 then
          Result := (-127);
      end else
      begin
        if DSG_StatusLabel <> nil then
        begin
          DSG_StatusLabel.Caption := DSG_GetLangLabel('ExtractFiles');
          DSG_StatusLabel.Refresh;
        end;
        if DSG_FileNameLabel <> nil then
        begin
          DSG_FileNameLabel.Caption := MinimizePathName(String(Str), DSG_FileNameLabel.Font, DSG_FileNameLabel.Width);
          DSG_FileNameLabel.Refresh;
        end;
      end;
      DSG_ProcessMessages();
    end;
end;

function DSG_UnpackDLLFiles(UnpFile: String): Boolean;
var
  FileName: String;
  Password: String;
  ErrorCode: Integer;
//Unpacked: Boolean;
begin
  Result := False;
  FileName := DSG_GetDLLFileName(ExpandConstant('{src}\Setup.dll'));
  if FileExists(FileName) then
  begin
    DLLFileCount := 0;
    IsTempFiles := False;
    SingleUnpack := Trim(UnpFile) <> '';
    #ifdef DSG_PasswordDLL
    Password := '{#DSG_PasswordDLL}';
    #else
    Password := GetSHA1OfUnicodeString(GetSHA1OfFile(ExpandConstant('{srcexe}')));
    #endif
    try
    #if VER >= 0x06000000
      ErrorCode := DSG_FreeArcExtract(CreateCallback(@FreeArcCallback), 'x', '-o-', '-dp' + AnsiToUtf8(ExpandConstant('{tmp}')), '-p' + AnsiToUtf8(Password), '-w' + AnsiToUtf8(ExpandConstant('{tmp}')), '--', AnsiToUtf8(FileName), AnsiToUtf8(UnpFile), '', '');
    #elif defined(IS_ENHANCED)
      ErrorCode := DSG_FreeArcExtract(CallbackAddr('FreeArcCallback'), 'x', '-o-', '-dp' + AnsiToUtf8(ExpandConstant('{tmp}')), '-p' + AnsiToUtf8(Password), '-w' + AnsiToUtf8(ExpandConstant('{tmp}')), '--', AnsiToUtf8(FileName), AnsiToUtf8(UnpFile), '', '');
    #else
      ErrorCode := DSG_FreeArcExtract(WrapFreeArcCallback(@FreeArcCallback, 4), 'x', '-o-', '-dp' + AnsiToUtf8(ExpandConstant('{tmp}')), '-p' + AnsiToUtf8(Password), '-w' + AnsiToUtf8(ExpandConstant('{tmp}')), '--', AnsiToUtf8(FileName), AnsiToUtf8(UnpFile), '', '');
    #endif
    finally
      Result := ErrorCode = 0;
      UnloadDLL(ExpandConstant('{tmp}\UnArc.dll'));
    end;
  end else
  begin
    Result := {#iCount} > 0;
    #sub ExtractFoundFile
      #pragma message FileList[iFile]
      if (Trim(UnpFile) = '') or (CompareText(Trim(UnpFile), '{#Trim(FileList[iFile])}') = 0) then
      begin
        try
          ExtractTemporaryFile('{#ExtractFileName(FileList[iFile])}');
          #if ExtractFilePath(FileList[iFile]) != ""
          if (not ForceDirectories(ExpandConstant('{tmp}\{#ExtractFilePath(FileList[iFile])}')))
          or (not RenameFile(ExpandConstant('{tmp}\{#ExtractFileName(FileList[iFile])}'), ExpandConstant('{tmp}\{#FileList[iFile]}'))) then
            Result := False;
	  #endif
        except
          Result := False;
        end;
      end;
    #endsub
    #for {iFile = 0; iFile < iCount; iFile++} ExtractFoundFile
    if (not Result) and FileExists(DSG_ExpandArcFile(GetIniString('Record' + IntToStr(1), 'Source', '{src}\Data1.bin.001', ExpandConstant('{tmp}\Records.ini')), ExpandConstant('{src}'))) then
      DSG_MessageBox(DSG_FormHandle, 'The required ' + ChangeFileExt(ExtractFileName(ExpandConstant('{srcexe}')), '.dll') + ' file was not found.' #13#10 + 'Add the ' + ChangeFileExt(ExtractFileName(ExpandConstant('{srcexe}')), '.dll') + ' file next to this executable and try again.', DSG_GetLangLabel('SetupAppTitle'), MB_OK or DSG_MB_ICONERROR or DSG_MB_TASKMODAL);
  end;
end;

function DSG_ConvertDataType(sType: String): TArcType;
begin
  Result := tpUnd;
  case Trim(LowerCase(sType)) of
    LowerCase('FreeArc_Original') : Result := tsArc;
    LowerCase('7-Zip_Original')   : Result := tsZip;
    LowerCase('WinRAR_Original')  : Result := tsRar;
    LowerCase('FreeArc_Split')    : Result := tmArc;
    LowerCase('7-Zip_Split')      : Result := tmZip;
    LowerCase('WinRAR_Split')     : Result := tmRar;
    LowerCase('Split_Part')       : Result := tpSplit;
    LowerCase('Delta3_Patch')     : Result := tpDelta;
    LowerCase('Exec_Command')     : Result := tpExec;
    LowerCase('Checksum_File')    : Result := tpHash;
  end;
end;

#ifdef DSG_CreateUninstallList
type
  TUninstallCallback = function(CurrentFile: String; Progress, Maximum: Integer): Boolean;

function DSG_ForceDeleteFiles(lpFilePath: String; OnlyDir: Boolean): Boolean;
var
  AppPath: String;
  PathName: String;
begin
  PathName := lpFilePath;
  AppPath := DSG_ExpandConstantTry('{app}', 1);
  if DirExists(PathName) or ((not OnlyDir) and FileExists(PathName)) then
  begin
    if (Length(PathName) >= Length(AppPath)) or (Pos(AppPath, PathName) = 0) then
      DSG_SetFileAttributes(PathName, FILE_ATTRIBUTE_NORMAL);

    if DirExists(PathName) then
      RemoveDir(PathName)
    else
      DeleteFile(PathName);
  end;
  repeat
    PathName := ExtractFileDir(PathName);
    if (Length(PathName) >= Length(AppPath)) or (Pos(AppPath, PathName) = 0) then
      DSG_SetFileAttributes(PathName, FILE_ATTRIBUTE_NORMAL);
  until (Length(PathName) < 4) or (not RemoveDir(PathName));
  Result := not FileOrDirExists(lpFilePath);
end;

function DSG_UninstallStep(const UninsFile: String; ProgressBar: TNewProgressBar; Callback: TUninstallCallback): Boolean;
var
  I: Integer;
  dwTicks: DWORD;
  PathName: String;
  Previous: Integer;
  Progress: Integer;
  UninsList: TArrayOfString;
begin
  Result := LoadStringsFromFile(ChangeFileExt(UninsFile, '.msg'), UninsList);
  if Result then
  begin
    if ProgressBar <> nil then
    begin
      ProgressBar.Max := 1000;
      ProgressBar.Position := 0;
    end;
    if Callback <> nil then
    begin
      Result := Callback('', 0, 1000);
      if not Result then
        Exit;
    end;
    dwTicks := DSG_GetTickCount();
    SetArrayLength(UninsList, GetArrayLength(UninsList) + 1);
    UninsList[GetArrayLength(UninsList) - 1] := ChangeFileExt(UninsFile, '.msg');
    for I := 0 to GetArrayLength(UninsList) - 1 do
    begin
      PathName := TrimLeft(DSG_ExpandConstantTry(UninsList[I], 1));
      while Pos('|', PathName) > 0 do
        PathName := TrimLeft(Copy(PathName, Pos('|', PathName) + 1, Length(PathName)));
      DSG_ForceDeleteFiles(PathName, False);
      Progress := Round((I + 1) * 1000 / GetArrayLength(UninsList));
      if (I = 0) or (I = GetArrayLength(UninsList) - 1) or (DSG_GetElapseTime(dwTicks) >= 50) then
      begin
        if Progress <> Previous then
        begin
          if Callback <> nil then
          begin
            Result := Callback(PathName, Progress, 1000);
            if not Result then
              Exit;
          end else
            if ProgressBar <> nil then
              ProgressBar.Position := Progress;

          DSG_ProcessMessages();
          Previous := Progress;
        end;
        dwTicks := DSG_GetTickCount();
      end;
    end;
  end else
    if not FileExists(ChangeFileExt(UninsFile, '.msg')) then
      Result := (not DirExists(DSG_ExpandConstantTry('{app}', 1))) or DelTree(DSG_ExpandConstantTry('{app}', 1), True, True, True);
end;

function DSG_PostUninstallStep(const UninsFile: String): Boolean;
begin
  Result := DSG_ForceDeleteFiles(UninsFile, True);
  RemoveDir(DSG_ExpandConstantTry('{app}', 1));
end;

function DSG_CurUninstallStepChanged(CurUninstallStep: TUninstallStep; ProgressBar: TNewProgressBar; Callback: TUninstallCallback): Boolean;
begin
  if CurUninstallStep = usUninstall then
  begin
    Result := DSG_UninstallStep(ExpandConstant('{uninstallexe}'), ProgressBar, Callback);
  end;
  if CurUninstallStep = usPostUninstall then
  begin
    Result := DSG_PostUninstallStep(ExpandConstant('{uninstallexe}'));
  end;
end;

function DSG_CreateUninstallFilesList(const FileList: String): Boolean;
var
  I, Y: Integer;
  S1, S2: String;
  StrList: TStringList;
  DstList: TStringList;
begin
  DeleteFile(ExpandConstant('{tmp}\Uninstall.dat'));
  StrList := TStringList.Create;
  DstList := TStringList.Create;
  try
    I := 0;
    StrList.LoadFromFile(FileList);
    while I < StrList.Count do
    begin
      S1 := StrList.Strings[I];
      if (Pos('[', S1) > 0) and (Pos(']', Copy(S1, Pos('[', S1) + 1, Length(S1))) > 0) then
      begin
        S2 := Copy(S1, Pos('[', S1), Pos(']', Copy(S1, Pos('[', S1) + 1, Length(S1))) + 1);
        for Y := 0 to GetArrayLength(Arcs) - 1 do
          if CompareText(Arcs[Y].Section, S2) = 0 then
            Break;

        if Y < GetArrayLength(Arcs) then
        begin
          while I + 1 < StrList.Count do
          begin
            S1 := StrList.Strings[I + 1];
            if Pos('[', Trim(S1)) = 1 then
              Break
            else begin
              Inc(I);
              if (Trim(S1) <> '') and (Pos(';', Trim(S1)) <> 1) and (Pos('//', Trim(S1)) <> 1) then
                DstList.Append(S1);
            end;
          end;
        end;
      end;
      Inc(I);
    end;
    if DstList.Count > 0 then
      SaveStringsToUTF8File(ExpandConstant('{tmp}\Uninstall.dat'), [DstList.Text], False);
      //DstList.SaveToFile(ExpandConstant('{tmp}\Uninstall.dat'));
  finally
    DstList.Free;
    StrList.Free;
  end;
  Result := FileExists(ExpandConstant('{tmp}\Uninstall.dat'));
end;
#endif

function DSG_IsWindows11OrHigher(): Boolean;
var
  dwMajor: DWORD;
  dwMinor: DWORD;
  dwBuild: DWORD;
  szBuild: String;
begin
  Result := False;
  if RegQueryDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows NT\CurrentVersion', 'CurrentMajorVersionNumber', dwMajor)
  and RegQueryDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows NT\CurrentVersion', 'CurrentMinorVersionNumber', dwMinor)
  and RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows NT\CurrentVersion', 'CurrentBuildNumber', szBuild) then
  begin
    dwBuild := DWORD(DWORD(StrToIntDef(szBuild, 0)) and $FFFF)
    Result := (dwMajor > 10) or ((dwMajor = 10) and ((dwMinor > 0) or ((dwMinor = 0) and (dwBuild >= 22000))));
  end;
end;

function DSG_IsWindows10OrHigher(): Boolean;
var
  dwMajor: DWORD;
begin
  Result := RegQueryDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows NT\CurrentVersion', 'CurrentMajorVersionNumber', dwMajor) and (dwMajor >= 10);
end;

function DSG_CreateUnpackFileList(): Integer;
var
  I, X, Y, Z: Integer;
  WinTenOrNewer: String;
  FailWinEleven: String;
  LIndex: TArrayOfInteger;
  ASize: TExtendedMatrix;
  ESize: Extended;
  AType: TArcType;
begin
  SetArrayLength(Arcs, 0);
  SetArrayLength(HashFileList, 0);
  if not DSG_IsWindows10OrHigher() then
  begin
    WinTenOrNewer := Trim(GetIniString('InstallerSettings', 'WinTenOrNewer', '', ExpandConstant('{tmp}\Records.ini')));
    if (WinTenOrNewer <> '') and (DSG_MessageBox(DSG_FormHandle, 'The method' + DSG_IfThen(Pos(', ', WinTenOrNewer) > 0, 's', '') + ' used during compression cannot be decompressed on Windows systems prior to Windows 10.' + #13#10 + #13#10 + 'Methods:' + #13#10 + WinTenOrNewer + #13#10 + #13#10 + 'Would you like to try to decompress anyway?', DSG_GetLangLabel('SetupAppTitle'), MB_YESNO or DSG_MB_ICONERROR or DSG_MB_TASKMODAL) <> IDYES) then
    begin
      DSG_UnpackCanceled := True;
      Exit;
    end;
  end;
  if DSG_IsWindows11OrHigher() then
  begin
    FailWinEleven := Trim(GetIniString('InstallerSettings', 'FailWinEleven', '', ExpandConstant('{tmp}\Records.ini')));
    if (FailWinEleven <> '') and (DSG_MessageBox(DSG_FormHandle, 'The method' + DSG_IfThen(Pos(', ', FailWinEleven) > 0, 's', '') + ' used during compression does not support being decompressed in Windows 11.' + #13#10 + #13#10 + 'Methods:' + #13#10 + FailWinEleven + #13#10 + #13#10 + 'Would you like to try to decompress anyway?', DSG_GetLangLabel('SetupAppTitle'), MB_YESNO or DSG_MB_ICONERROR or DSG_MB_TASKMODAL) <> IDYES) then
    begin
      DSG_UnpackCanceled := True;
      Exit;
    end;
  end;
  if FileExists(ExpandConstant('{tmp}\Records.ini')) then
  begin
    X := 1;
    while GetIniString('Record' + IntToStr(X), 'Type', '', ExpandConstant('{tmp}\Records.ini')) <> '' do
    begin
      AType := DSG_ConvertDataType(GetIniString('Record' + IntToStr(X), 'Type', '', ExpandConstant('{tmp}\Records.ini')));
      case AType of
        tsArc, tsZip, tsRar, tmArc, tmZip, tmRar, tpSplit, tpDelta, tpExec, tpHash :
          begin
            I := GetArrayLength(Arcs);
            SetArrayLength(Arcs, I + 1);
            SetArrayLength(ASize, I + 1);

            Arcs[I].AType     := AType;
            Arcs[I].Source    := GetIniString('Record' + IntToStr(X), 'Source',    '', ExpandConstant('{tmp}\Records.ini'));
            Arcs[I].Component := GetIniString('Record' + IntToStr(X), 'Component', '', ExpandConstant('{tmp}\Records.ini'));
            Arcs[I].Task      := GetIniString('Record' + IntToStr(X), 'Task',      '', ExpandConstant('{tmp}\Records.ini'));
            Arcs[I].Language  := GetIniString('Record' + IntToStr(X), 'Language',  '', ExpandConstant('{tmp}\Records.ini'));

            { checks whether the current file meets the selected configuration }
            if (Arcs[I].Source <> '') and ComponentsCheck(Arcs[I].Component) and TasksCheck(Arcs[I].Task) and LanguagesCheck(Arcs[I].Language) then
            begin
              Arcs[I].Source := DSG_IfThen(ExtractFileDrive(DSG_ExpandConstantTry(Arcs[I].Source, 1)) = '', '{src}\', '') + Arcs[I].Source;
              Arcs[I].Output := GetIniString('Record' + IntToStr(X), 'Output', '', ExpandConstant('{tmp}\Records.ini'));
              Arcs[I].Output := DSG_IfThen(Arcs[I].Output = '', '{app}', Arcs[I].Output);
              StringChangeEx(Arcs[I].Source, '\\', '\', True);

              if Arcs[I].AType = tpHash then
              begin
                StringChangeEx(Arcs[I].Source, '\\', '\', True);
                StringChangeEx(Arcs[I].Output, '\\', '\', True);
                if (Pos('{', TrimLeft(Arcs[I].Source)) <> 1) and (ExtractFileDrive(TrimLeft(Arcs[I].Source)) = '') then
                  Arcs[I].Source := '{tmp}\' + TrimLeft(Arcs[I].Source);

                SetArrayLength(HashFileList, GetArrayLength(HashFileList) + 1);
                with HashFileList[GetArrayLength(HashFileList) - 1] do
                begin
                  FileName := DSG_ExpandConstantTry(Arcs[I].Source, 1);
                  BasePath := DSG_ExpandConstantTry(Arcs[I].Output, 1);
                  AppDirFile := Pos(LowerCase(DSG_ExpandConstantTry('{app}\', 1)), LowerCase(FileName)) > 0;
                end;
                SetArrayLength(ASize, I);
                SetArrayLength(Arcs, I);
              end else
              begin
                Arcs[I].Section  := '[' + 'Record' + IntToStr(X) + ']';
                Arcs[I].SizeEx   := DSG_GetSizeBytes(GetIniString('Record' + IntToStr(X), 'Size', '', ExpandConstant('{tmp}\Records.ini')), 0);
                Arcs[I].Disk     := GetIniString('Record' + IntToStr(X), 'Disk', '', ExpandConstant('{tmp}\Records.ini'));
                Arcs[I].Password := GetIniString('Record' + IntToStr(X), 'Password', '', ExpandConstant('{tmp}\Records.ini'));

                if Arcs[I].AType <> tpDelta then
                  Arcs[I].SubDir := DSG_IfThen(Pos('}\', AddBackslash(Arcs[I].Output)) > 0, Copy(Arcs[I].Output, Pos('}\', AddBackslash(Arcs[I].Output)) + 2, Length(Arcs[I].Output)), Arcs[I].Output)
                else
                  Arcs[I].SubDir := DSG_IfThen(Pos('}\', AddBackslash(ExtractFilePath(Arcs[I].Source))) > 0, Copy(ExtractFilePath(Arcs[I].Source), Pos('}\', AddBackslash(ExtractFilePath(Arcs[I].Source))) + 2, Length(ExtractFilePath(Arcs[I].Source))), ExtractFilePath(Arcs[I].Source));

                case Arcs[I].AType of
                  tmArc, tmZip, tmRar : { type merged }
                    begin
                      StringChangeEx(Arcs[I].Source, '{tmp}', '{app}', True);
                      StringChangeEx(Arcs[I].Source, '{src}', '{app}', True);
                    end;
                  tpSplit :             { type split }
                    begin
                      StringChangeEx(Arcs[I].Output, '{tmp}', '{app}', True);
                      StringChangeEx(Arcs[I].Output, '{src}', '{app}', True);
                    end;
                  else
                    if Arcs[I].SizeEx = 0 then
                      Arcs[I].SizeEx := DSG_PowerK(1000, 2{MB});
                end;
                case Arcs[I].AType of
                  tmArc, tmZip, tmRar :
                    begin
                      SetArrayLength(LIndex, 0);
                      for Y := I - 1 downto 0 do                                    { create split slices list to current merged file }
                      begin
                        if ((Arcs[Y].AType = tmArc) or (Arcs[Y].AType = tmZip) or (Arcs[Y].AType = tmRar))
                        and (CompareText(Trim(Arcs[I].Source), Trim(Arcs[Y].Source)) = 0) then
                          Break
                        else
                          if (Arcs[Y].AType = tpSplit) and (CompareText(Trim(Arcs[I].Source), Trim(Arcs[Y].Output)) = 0) then
                          begin
                            SetArrayLength(LIndex, GetArrayLength(LIndex) + 1);
                            LIndex[GetArrayLength(LIndex) - 1] := Y;
                          end;
                      end;
                      for Z := 0 to GetArrayLength(LIndex) - 1 do                   { fill values size of unspecified slices tpSplit }
                      begin
                        Y := LIndex[Z];
                        if (Arcs[I].SizeEx > 0) and (Arcs[Y].SizeEx = 0) then
                          Arcs[Y].SizeEx := Arcs[I].SizeEx / GetArrayLength(LIndex) { set merged size div by slices }
                        else
                          if Arcs[Y].SizeEx = 0 then
                            Arcs[Y].SizeEx := DSG_PowerK(100, 2{MB});               { set default 100 MB value }

                        SetArrayLength(ASize[I], GetArrayLength(ASize[I]) + 1);
                        ASize[I][GetArrayLength(ASize[I]) - 1] := Arcs[Y].SizeEx;
                      end;
                      ESize := 0;
                      for Z := 0 to GetArrayLength(LIndex) - 1 do                  { fill values size of unspecified slices tpSplit }
                      begin
                        Y := LIndex[Z];
                        ESize := ESize + Arcs[Y].SizeEx;
                        ASize[Y] := ASize[I];
                      end;
                      if Arcs[I].SizeEx = 0 then
                        Arcs[I].SizeEx := ESize;
                    end;
                end;
              end;
            end else
            begin  { remove items }
              SetArrayLength(ASize, I);
              SetArrayLength(Arcs, I);
            end;
          end;
      end;
      Inc(X);
    end;
    ESize := 0;
    for I := 0 to GetArrayLength(Arcs) - 1 do
    begin
      if Arcs[I].AType = tpSplit then
        ESize := ESize + Arcs[I].SizeEx / 10
      else
        ESize := ESize + Arcs[I].SizeEx;
    end;
    for I := 0 to GetArrayLength(Arcs) - 1 do
    begin
      if Arcs[I].AType = tpSplit then
        Arcs[I].Pct := 10 * Arcs[I].SizeEx / ESize
      else
        Arcs[I].Pct := 100 * Arcs[I].SizeEx / ESize;
    end;
    for I := 0 to GetArrayLength(Arcs) - 1 do
    begin
      if (Pos('{', TrimLeft(Arcs[I].Source)) <> 1) and (ExtractFileDrive(TrimLeft(Arcs[I].Source)) = '') then
        Arcs[I].Source := '{src}\' + TrimLeft(Arcs[I].Source);
      if Arcs[I].AType <> tpExec then
        Arcs[I].Output := ExpandFileName(DSG_ExpandConstantTry(Arcs[I].Output, 1));
      StringChangeEx(Arcs[I].Source, '\\', '\', True);
      StringChangeEx(Arcs[I].Output, '\\', '\', True);
      for Y := 0 to GetArrayLength(ASize[I]) - 1 do
        Arcs[I].Slices := FloatToString(ASize[I][Y], 0) + DSG_IfThen(Y = 0, '', ',' + Arcs[I].Slices); { create line with all size }
    end;
    SetArrayLength(ASize, 0);
    #ifdef DSG_CreateUninstallList
    if (GetArrayLength(Arcs) > 0) and FileExists(ExpandConstant('{tmp}\UninstallList.ini')) then
      DSG_CreateUninstallFilesList(ExpandConstant('{tmp}\UninstallList.ini'));
    #endif
  end;
  Result := GetArrayLength(Arcs);
end;

function DSG_Unpack_Process(OptimalMode: Boolean; SetLanguage: String; StatusLabel, FileNameLabel: TNewStaticText; CancelButton: TNewButton; MainProgressBar, SecondProgressBar: TNewProgressBar; lpProgressCallback: TCallback; lpMergeFileCallback: TSplitCallback; lpDiskSpanCallback: TDiskSpanProc): Boolean;
var
  I, Y: Integer;
  ArcPct: Double;
  LastFile: String;
  SourceDir: String;
  CurrArcFile: String;
  Position: Integer;
  ResultCode: Integer;
  FindHandle: Integer;
  DSG_CancelButton: TNewButton;
  DSG_MainProgressBar: TNewProgressBar;
  DSG_SecondProgressBar: TNewProgressBar;
  DSG_MergeFileCallback: TSplitCallback;
  PatchList: TArrayOfString;
  MainHandle: THandle;
  DiffFile: String;
  InFile: String;
  OutFile: String;
begin
  DSG_Unpacking := True;
  DSG_ActLang := SetLanguage;
  DSG_MainProgressBar := MainProgressBar;
  DSG_SecondProgressBar := SecondProgressBar;
  DSG_StatusLabel := StatusLabel;
  DSG_FileNameLabel := FileNameLabel;
  DSG_CancelButton := CancelButton;
  DSG_ProgressCallback := lpProgressCallback;
  DSG_MergeFileCallback := lpMergeFileCallback;
  if DSG_FileNameLabel <> nil then
  begin
    DSG_FileNameLabel.Caption := '';
    DSG_FileNameLabel.Refresh;
  end;
  if DSG_MainProgressBar <> nil then
  begin
    DSG_MainProgressBar.Max := 1000;
    DSG_MainProgressBar.Position := 0;
  end;
  if DSG_SecondProgressBar <> nil then
  begin
    DSG_SecondProgressBar.Max := 1000;
    DSG_SecondProgressBar.Position := 0;
  end;
  if DSG_StatusLabel <> nil then
  begin
    DSG_StatusLabel.Caption := DSG_GetLangLabel('ExtractFiles');
    DSG_StatusLabel.Refresh;
  end;
  try
    if MainForm = nil then
    begin
      with CreateCustomForm do
      begin
        MainHandle := DSG_GetWindow(Handle, DSG_GW_OWNER);
        Free;
      end;
    end else
      MainHandle := MainForm.Handle;
  except
    with CreateCustomForm do
    begin
      MainHandle := DSG_GetWindow(Handle, DSG_GW_OWNER);
      Free;
    end;
  end;
  try
    if WizardForm <> nil then
    begin
      try
        DSG_FormHandle := WizardForm.Handle;
        DSG_SetFocus(WizardForm.CancelButton.Handle);
      except
      end;
    end else
      DSG_FormHandle := 0;
  except
    DSG_FormHandle := 0;
  end;
  ISDoneCancel := 0;
  DSG_ProcessMessages();
  IsDoneInitialized := False;
  DSG_UnpackCanceled := False;
  ISDoneError := (not DSG_UnpackDLLFiles('')) or ((not FileCopy(ExpandConstant('{src}\Records.ini'), ExpandConstant('{tmp}\Records.ini'), False)) and (not FileExists(ExpandConstant('{tmp}\Records.ini')))) or (DSG_CreateUnpackFileList() = 0);
  if not ISDoneError then
  begin
    DSG_RenameINIFiles(OptimalMode);
    UnloadDLL(ExpandConstant('{tmp}\UnArc.dll'));
    UnloadDLL(ExpandConstant('{tmp}\ISDone.dll'));
    FileCopy(ExpandConstant('{src}\Records.ini'), ExpandConstant('{tmp}\Records.ini'), False);
  end;
  if DSG_ProgressCallback = nil then
    DSG_ProgressCallback := @DSG_ProgressCallback_Dummy;
  if DSG_MergeFileCallback = nil then
    DSG_MergeFileCallback := @DSG_MergeFileCallback_Dummy;
  if (not ISDoneError) and ISDoneInit(ExpandConstant('{tmp}\Records.inf'), $F777, 0,0,0, MainHandle, 0, DSG_ProgressCallback) then
  begin
    { MTX }
    if FileExists(ExpandConstant('{tmp}\MTX\MTX.exe')) then
      SetIniString('MTX', 'TmpPath', ExpandConstant('{app}'), ExpandConstant('{tmp}\MTX\MTX.ini'));
    if FileExists(ExpandConstant('{tmp}\MTX\MTX32.exe')) then
      SetIniString('MTX32', 'TmpPath', ExpandConstant('{app}'), ExpandConstant('{tmp}\MTX\MTX.ini'));
    if FileExists(ExpandConstant('{tmp}\MTX\MTX64.exe')) then
      SetIniString('MTX64', 'TmpPath', ExpandConstant('{app}'), ExpandConstant('{tmp}\MTX\MTX.ini'));
    if FileExists(ExpandConstant('{tmp}\MTX\Win32\MTX.exe')) then
      SetIniString('MTX', 'TmpPath', ExpandConstant('{app}'), ExpandConstant('{tmp}\MTX\Win32\MTX.ini'));
    if FileExists(ExpandConstant('{tmp}\MTX\Win64\MTX.exe')) then
      SetIniString('MTX', 'TmpPath', ExpandConstant('{app}'), ExpandConstant('{tmp}\MTX\Win64\MTX.ini'));
    { AFR }
    if FileExists(ExpandConstant('{tmp}\CLS-AFR.dll')) or FileExists(ExpandConstant('{tmp}\CLS-AFR_019.dll')) then
    begin
      if not IsIniSectionEmpty('Afr', ExpandConstant('{tmp}\CLS.ini')) then
        SetIniString('Afr', 'Threads', IntToStr(GetCPUThreads()), ExpandConstant('{tmp}\CLS.ini'));
      if not IsIniSectionEmpty('Afr_019', ExpandConstant('{tmp}\CLS.ini')) then
        SetIniString('Afr_019', 'Threads', IntToStr(GetCPUThreads()), ExpandConstant('{tmp}\CLS.ini'));
    end;
    { SREP }
    if FileExists(ExpandConstant('{tmp}\CLS-SREP.dll')) and (not IsIniSectionEmpty('Srep', ExpandConstant('{tmp}\CLS.ini'))) then
      SetIniString('Srep', 'TempPath', DSG_ExpandConstantTry('{app}', 1), ExpandConstant('{tmp}\CLS.ini'));
    if FileExists(ExpandConstant('{tmp}\CLS-SREP_NEW.dll')) and (not IsIniSectionEmpty('Srep_NEW', ExpandConstant('{tmp}\CLS.ini'))) then
      SetIniString('Srep_NEW', 'TempPath', DSG_ExpandConstantTry('{app}', 1), ExpandConstant('{tmp}\CLS.ini'));
    if FileExists(ExpandConstant('{tmp}\CLS-SREP_OLD.dll')) and (not IsIniSectionEmpty('Srep_OLD', ExpandConstant('{tmp}\CLS.ini'))) then
      SetIniString('Srep_OLD', 'TempPath', DSG_ExpandConstantTry('{app}', 1), ExpandConstant('{tmp}\CLS.ini'));
    { LOLZ }
    if FileExists(ExpandConstant('{tmp}\CLS-LOLZ.dll')) and (not IsIniSectionEmpty('LOLZ', ExpandConstant('{tmp}\CLS.ini'))) then
      SetIniString('LOLZ', 'ldmfTempPath', DSG_ExpandConstantTry('{app}', 1), ExpandConstant('{tmp}\CLS.ini'));
    { MPZMT }
    if FileExists(ExpandConstant('{tmp}\CLS-MPZMT.dll')) and (not IsIniSectionEmpty('MPZMT', ExpandConstant('{tmp}\CLS.ini'))) then
      SetIniString('MPZMT', 'Temp', DSG_ExpandConstantTry('{app}', 1), ExpandConstant('{tmp}\CLS.ini'));
    { DiskSpan R3 Modified }
    ClsLibInit := False;
    IsDoneInitialized := True;
    SourceDir := ExpandConstant('{src}');
    if FileExists(ExpandConstant('{tmp}\CLS-DISKSPAN.dll')) then
    begin
      try
        ClsLibInit := DiskSpanInit(DSG_FormHandle, SourceDir, nil, lpDiskSpanCallback);
        SetMessageText(DSG_GetLangLabel('ChangeDiskLabel'), DSG_GetLangLabel('ChangeDiskTitle'));
      except
        if DSG_StatusLabel <> nil then
        begin
          DSG_StatusLabel.Caption := '';
          DSG_StatusLabel.Refresh;
        end;
        if DSG_FileNameLabel <> nil then
        begin
          DSG_FileNameLabel.Caption := '';
          DSG_FileNameLabel.Refresh;
        end;
        ISDoneError := True;
        ISDoneStop();
        DSG_MessageBox(DSG_FormHandle, DSG_GetLangLabel('IncompatibleClsVersion'), DSG_GetLangLabel('SetupAppTitle'), MB_OK or DSG_MB_ICONERROR or DSG_MB_TASKMODAL);
        Exit;
      end;
    end;
    repeat
      try
        ExtractTemporaryFile(ActiveLanguage + '.ini');
        ChangeLanguage(ActiveLanguage);
      except
        ExtractTemporaryFile('English.ini');
        ChangeLanguage('English');
      end;
      ArcPct := 0;
      SplitPct := 0;
      LastFile := '';
      if DSG_CancelButton <> nil then
      begin
        DSG_CancelButton.Enabled := True;
      end;
      ForceDirectories(DSG_ExpandConstantTry('{app}\', 1));
      for I := 0 to GetArrayLength(Arcs) - 1 do
      begin
        if DSG_StatusLabel <> nil then
        begin
          DSG_StatusLabel.Caption := DSG_IfThen((Arcs[I].AType = tpSplit) or (Arcs[I].AType = tpDelta), '', DSG_GetLangLabel('ExtractFiles'));
          DSG_StatusLabel.Refresh;
        end;
        ArcSubDir := Arcs[I].SubDir;
        ArcPct := ArcPct + (Arcs[I].Pct * 10);
        case Arcs[I].AType of
          tsArc, tmArc :
            begin
              CurrArcFile := DSG_BrowseArcFile(Arcs[I].Source, Arcs[I].Disk, SourceDir);
              if (not ISDoneError) and (not ISArcExtract(0, Arcs[I].Pct, CurrArcFile, Arcs[I].Output, '', Arcs[I].AType = tmArc, Arcs[I].Password, ExpandConstant('{tmp}\Arc.ini'), Arcs[I].Output, False)) then
                ISDoneError := True;
            end;
          tsZip, tmZip :
            begin
              CurrArcFile := DSG_BrowseArcFile(Arcs[I].Source, Arcs[I].Disk, SourceDir);
              if (not ISDoneError) and (not IS7ZipExtract(0, Arcs[I].Pct, CurrArcFile, Arcs[I].Output, Arcs[I].AType = tmZip, Arcs[I].Password)) then
                ISDoneError := True;
            end;
          tsRar, tmRar :
            begin
              CurrArcFile := DSG_BrowseArcFile(Arcs[I].Source, Arcs[I].Disk, SourceDir);
              if (not ISDoneError) and (not ISRarExtract(0, Arcs[I].Pct, CurrArcFile, Arcs[I].Output, Arcs[I].AType = tmRar, Arcs[I].Password)) then
                ISDoneError := True;
            end;
          tpSplit :
            begin
              Position := 0;
              CurrArcFile := DSG_BrowseArcFile(Arcs[I].Source, Arcs[I].Disk, SourceDir);
              SplitBuffer(Round(DSG_PowerK(256, 1{KB})), Round(Arcs[I].SizeEx / DSG_PowerK(100, 1{KB})));
              if DSG_MainProgressBar <> nil then
                Position := DSG_MainProgressBar.Position;
              if DSG_SecondProgressBar <> nil then
                DSG_SecondProgressBar := 0;
              if (not ISDoneError) and (not MergeDataFile(CurrArcFile, Arcs[I].Output, Arcs[I].Slices, 0, Position, Round(Arcs[I].Pct * 1000), CompareText(LastFile, Arcs[I].Output) <> 0, DSG_MergeFileCallback)) then
                ISDoneError := True
              else
                if DSG_MainProgressBar <> nil then
                  DSG_MainProgressBar.Position := Round(ArcPct);
              SplitPct := SplitPct + (Arcs[I].Pct * 10);
            end;
          tpDelta :
            begin
              if ((Pos('*', ExtractFileName(Arcs[I].Source))) > 0) and (Pos('*', ExtractFileName(Arcs[I].Output)) > 0) then
              begin
                FindHandle := DSG_pFindFiles(ExtractFilePath(DSG_ExpandConstantTry(Arcs[I].Source, 1)), ExtractFileName(Arcs[I].Source), '', dsg_ffrkRelative, True, False);
                try
                  SetArrayLength(PatchList, DSG_pFileCount(FindHandle));
                  for Y := 0 to DSG_pFileCount(FindHandle) - 1 do
                    PatchList[Y] := DSG_pPickFile(FindHandle, Y);
                finally
                  DSG_pFindFree(FindHandle);
                end;
              end else
              begin
                SetArrayLength(PatchList, 1);
                PatchList[0] := ExtractRelativePath(ExtractFilePath(DSG_ExpandConstantTry(Arcs[I].Source, 1)), DSG_ExpandConstantTry(Arcs[I].Source, 1));
              end;
              if GetArrayLength(PatchList) > 0 then
              begin
                for Y := 0 to GetArrayLength(PatchList) - 1 do
                begin
                  DiffFile := ExtractFilePath(DSG_ExpandConstantTry(Arcs[I].Source, 1)) + PatchList[Y];
                  InFile := ExtractFilePath(Arcs[I].Output) + ChangeFileExt(PatchList[Y], '');
                  OutFile := DSG_IfThen(ExtractFileExt(Arcs[I].Output) = '', InFile, ChangeFileExt(InFile, ExtractFileExt(Arcs[I].Output)));
                  if not ForceDirectories(ExtractFilePath(OutFile)) then
                  begin
                    ISDoneError := True;
                    Break;
                  end;
                  if CompareText(InFile, OutFile + '.patched') = 0 then
                  begin
                    if not DSG_MoveFileEx(InFile, InFile + '.tmp', DSG_MOVEFILE_REPLACE_EXISTING or DSG_MOVEFILE_WRITE_THROUGH or DSG_MOVEFILE_COPY_ALLOWED) then
                    begin
                      ISDoneError := True;
                      Break;
                    end else
                      InFile := InFile + '.tmp';
                  end;
                  if not ISxDeltaExtract(0, Arcs[I].Pct / GetArrayLength(PatchList), 0, DSG_IfThen(OptimalMode, 1024, 640), InFile, DiffFile, OutFile + '.patched', True, True) then
                  begin
                    ISDoneError := True;
                    Break;
                  end else
                    DSG_MoveFileEx(OutFile + '.patched', OutFile, DSG_MOVEFILE_REPLACE_EXISTING or DSG_MOVEFILE_WRITE_THROUGH or DSG_MOVEFILE_COPY_ALLOWED);
                end;
              end else
                SplitPct := SplitPct + Arcs[I].Pct;
            end;
          tpExec :
            begin
              ShellExec('open', DSG_ExpandConstantTry(Arcs[I].Source, 1), DSG_ExpandConstantTry(Arcs[I].Output, 1), '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
            end;
        end;
        LastFile := Arcs[I].Output;
        if ISDoneError then
          Break;
      end;
    until True;
    ISDoneStop();
    IsDoneInitialized := False;
    if DSG_StatusLabel <> nil then
    begin
      DSG_StatusLabel.Caption := '';
      DSG_StatusLabel.Refresh;
    end;
    if DSG_FileNameLabel <> nil then
    begin
      DSG_FileNameLabel.Caption := '';
      DSG_FileNameLabel.Refresh;
    end;
    if DSG_CancelButton <> nil then
    begin
      DSG_CancelButton.Enabled := False;
    end;
    if (not ISDoneError) and (DSG_MainProgressBar <> nil) then
    begin
      DSG_MainProgressBar.Max := 1000;
      DSG_MainProgressBar.Position := 1000;
    end;
    if (not ISDoneError) and (DSG_SecondProgressBar <> nil) then
    begin
      DSG_SecondProgressBar.Max := 1000;
      DSG_SecondProgressBar.Position := 1000;
    end;
    while FileExists(ExpandConstant('{tmp}\XDelta3.dll'))
    and BOOLEAN(DSG_FreeLibrary(DSG_GetModuleHandle(ExpandConstant('{tmp}\XDelta3.dll')))) do
    begin
      UnloadDLL(ExpandConstant('{tmp}\XDelta3.dll'));
      DeleteFile(ExpandConstant('{tmp}\XDelta3.dll'));
    end;
    DSG_CloseTempProcessFromDir(ExpandConstant('{tmp}'));
  end;
  Result := not ISDoneError;
  DSG_CancelButton := nil;
  DSG_MainProgressBar := nil;
  DSG_SecondProgressBar := nil;
  DSG_FileNameLabel := nil;
  DSG_StatusLabel := nil;
  DSG_ProgressCallback := nil
  DSG_MergeFileCallback := nil;
  DSG_Unpacking := False;
  DSG_FormHandle := 0;
  DSG_ActLang := '';
end;

[/code]