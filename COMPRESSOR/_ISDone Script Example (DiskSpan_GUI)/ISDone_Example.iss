#define NeedSize "15.000.000.000"

;#define Tasks
;#define Components
;#define SecondProgressBar
#define CreateUninstallList

#define HashPage NO              /* Supported values YES/NO to start file integrity check automatically */

;#define DSG_InternalDLL         /* Adding Setup.dll/<outputfiename>.dll next to the script will compress the DLL file into the Setup.exe/<outputfiename>.exe file  */
;#define DSG_PasswordDLL "123"   /* Same password used in DiskSpan_GUI to extract decompressors from Setup.dll files */

#define OutputDir "..\Setup_Files"
;#define OutputDir "..\Conversion_Output\DISK"
;#define OutputDir "Output"

[Setup]
AppName=ISDone
AppVerName=ISDone
DefaultDirName={{#VER >= 0x06000000 ? "common" : void}pf}\ISDone
DefaultGroupName=ISDone Example
OutputDir={#defined(OutputDir) ? OutputDir : "."}
OutputBaseFilename=Setup
SetupIconFile=Include\Setup.ico
VersionInfoCopyright=ProFrager
SolidCompression=yes
DisableWelcomePage=no
UsePreviousAppDir=no
DirExistsWarning=no
ShowLanguageDialog=yes
#ifdef NeedSize
ExtraDiskSpaceRequired={#StringChange(NeedSize, ".", "")}
#endif
;#if VER >= 0x06000000
;WizardStyle=modern
;#endif

#ifdef Components
[Types]
Name: full; Description: Full installation; Flags: iscustom

[Components]
Name: comp1; Description: Game 1; Types: full; ExtraDiskSpaceRequired: 100000000
Name: comp2; Description: Game 2; Types: full; ExtraDiskSpaceRequired: 200000000
Name: comp3; Description: Game 3; Types: full; ExtraDiskSpaceRequired: 200000000; Languages: russian;
;Name: text; Description: Язык субтитров; Types: full; Flags: fixed
;Name: text\rus; Description: Русский; Flags: exclusive; ExtraDiskSpaceRequired: 100000000
;Name: text\eng; Description: Английский; Flags: exclusive; ExtraDiskSpaceRequired: 200000000
;Name: voice; Description: Язык озвучки; Types: full; Flags: fixed
;Name: voice\rus; Description: Русский; Flags: exclusive; ExtraDiskSpaceRequired: 500000000
;Name: voice\eng; Description: Английский; Flags: exclusive; ExtraDiskSpaceRequired: 600000000
#endif

[Registry]
Root: HKLM; Subkey: Software\ProFrager; ValueName: path; ValueType: String; ValueData: {app}; Flags: uninsdeletekey; Check: CheckError
Root: HKLM; Subkey: Software\ProFrager; ValueName: name; ValueType: String; ValueData: Data; Flags: uninsdeletekey; Check: CheckError

[Icons]
Name: "{group}\Удалить пример ISDone"; Filename: {app}\unins000.exe; WorkingDir: {app}; Check: CheckError
Name: "{commondesktop}\Удалить пример ISDone"; Filename: {app}\unins000.exe; WorkingDir: {app}; Check: CheckError

[Tasks]
Name: VCCheck; Description: Установить Microsoft Visual C++ 2005 Redist
Name: PhysXCheck; Description: Установить Nvidia PhysX
#ifdef Tasks
Name: task1; Description: Install *.ini files for Game 1;{#ifdef Components} Components: Comp1;{#endif}
Name: task2; Description: Install *.ini files for Game 2;{#ifdef Components} Components: Comp2;{#endif}
//Name: task; Description: Task Group;
//Name: task\task1; Description: Task 1;
//Name: task\task2; Description: Task 2; Flags: unchecked
#endif

[Run]
Filename: "{src}\Redist\vcredist_x86.exe"; Parameters: /q; StatusMsg: Устанавливаем Microsoft Visual C++ 2005 Redist...; Flags: skipifdoesntexist; Tasks: VCCheck; Check: CheckError
Filename: "{src}\Redist\PhysX.exe"; Parameters: /qn; StatusMsg: Устанавливаем Nvidia PhysX...; Flags: skipifdoesntexist; Tasks: PhysXCheck; Check: CheckError

[Files]
Source: "Include\English.ini"; DestDir: "{tmp}"; Flags: dontcopy
Source: "Include\Russian.ini"; DestDir: "{tmp}"; Flags: dontcopy
Source: "Include\UnArcLib.dll"; DestDir: "{tmp}"; Flags: dontcopy
Source: "Include\ISDone.dll"; DestDir: "{tmp}"; Flags: dontcopy
Source: "Include\SplitLib.dll"; DestDir: "{tmp}"; Flags: dontcopy
#ifdef HashPage
Source: "Include\XHashEx.dll"; DestDir: "{tmp}"; Flags: dontcopy
#endif
#define Setup_DLL = FileExists(AddBackslash(SourcePath) + ExtractFileName(SetupSetting("OutputBaseFilename")) + ".dll") ? ExtractFileName(SetupSetting("OutputBaseFilename")) + ".dll" : "Setup.dll"
#pragma message AddBackslash(SourcePath) + Setup_DLL
#if defined(DSG_InternalDLL) && FileExists(AddBackslash(SourcePath) + Setup_DLL)
Source: "{#AddBackslash(SourcePath) + Setup_DLL}"; DestDir: "{tmp}"; Flags: dontcopy
#endif

[CustomMessages]
english.ExtractedFile=The file is extracted:
english.Extracted=Unpacking archives...
english.CancelButton=Cancel unpacking
english.Error=Unpacking error!
english.ElapsedTime=Passed:
english.RemainingTime=Time left:
english.EstimatedTime=Total:
english.AllElapsedTime=Installation time:
#ifdef HashPage
english.HashPageTitle=Integrity Check
english.HashPageDescription=Check the integrity of installed files?
english.HashStatusLabel=Processed %1 of %2 files (%3%)
english.HashResultLabel=Ok: %1     Missing: %2     Bad: %3
english.HashWaitingLabel=The installer is ready to do the files integrity check
english.HashOk=Hash_OK
english.HashNotFound=File not found!
english.HashAbort=Check of files has been interrupted!
english.HashBadParam=Invalid hash algorithm!
english.HashBadHash=File hash does not match!
english.HashGeneralError=General error!
english.HashPause=Pa&use
english.HashResume=R&esume
english.HashVerify=&Verify
english.HashStop=S&top
english.HashCancel=C&ancel
english.HashNext=&Next
english.HashLog=L&og
english.HashInfo=Inf&o
english.HashFileHash=FileHash
english.HashCalcHash=CalcHash
english.HashHashStatus=HashStatus
english.HashNoFile=NoFile
english.HashNotMatched=NotMatched
english.HashMatched=Matched
english.HashNull=Null
#endif
english.Extracting=Extracting %1...
english.Merging=Merging file %1 (%3%) to %2 (%4%)...
english.ChangeDiskLabel=Please insert disk %1 with %2 file.%nBrowse for required file?

russian.ExtractedFile=Извлекается файл:
russian.Extracted=Распаковка архивов...
russian.CancelButton=Отменить распаковку
russian.Error=Ошибка распаковки!
russian.ElapsedTime=Прошло:
russian.RemainingTime=Осталось времени:
russian.EstimatedTime=Всего:
russian.AllElapsedTime=Время установки:
#ifdef HashPage
russian.HashPageTitle=Проверка целостности
russian.HashPageDescription=Проверить целостность установленных файлов?
russian.HashStatusLabel=Выполнено %1 из %2 файлов (%3%)
russian.HashResultLabel=Ок: %1     Отсутствуют: %2     Испорченные: %3
russian.HashWaitingLabel=Установщик готов выполнить проверку целостности файлов
russian.HashOk=Хеш_Ок
russian.HashNotFound=Файл не найден!
russian.HashAbort=Проверка файлов была прервана!
russian.HashBadParam=Недействителен алгоритм хеша!
russian.HashBadHash=Хеш файла не совпадает!
russian.HashGeneralError=Общая ошибка!
russian.HashPause=Приостановить
russian.HashResume=Продолжить
russian.HashVerify=&Проверить
russian.HashStop=&Остановить
russian.HashCancel=О&тмена
russian.HashNext=&Далее
russian.HashLog=&Журнал
russian.HashInfo=&Информация
russian.HashFileHash=ХэшФайл
russian.HashCalcHash=РасчXэш
russian.HashHashStatus=ХэшCтатус
russian.HashNoFile=НетФайл
russian.HashNotMatched=Несовпадение
russian.HashMatched=Соответствует
russian.HashNull=Нулевой
#endif
russian.Extracting=Извлекается %1...
russian.Merging=Слияние файла %1 (%3%) с %2 (%4%)...
russian.ChangeDiskLabel=Пожалуйста, вставьте диск %1 с файлом %2 File.%nНайти нужный файл?

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl";
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl";

#ifndef CreateUninstallList
[UninstallDelete]
Type: filesandordirs; Name: "{app}"
#endif

[Code]
const
  PCFonFLY = True;
  notPCFonFLY = False;

var
  LabelOveralPct: TNewStaticText;
  LabelCurrFileName: TNewStaticText;
  LabelElapsedTime: TNewStaticText;
  LabelRemainingTime: TNewStaticText;
  LabelAllElapsedTime: TNewStaticText;
  ISDoneOveralProgressBar: TNewProgressBar;
#ifdef HashPage
  HashPage: TWizardPage;
  HashInfoMemo: TNewMemo;
  HashLogMemo: TNewMemo;
  HashProgressGauge: TNewProgressBar;
  HashStatusLabel: TNewStaticText;
  HashResultLabel: TNewStaticText;
  HashPercentLabel: TNewStaticText;
  HashNextButton: TNewButton;
  HashBackButton: TNewButton;
  HashCancelButton: TNewButton;
#endif
#ifdef SecondProgressBar
  LabelCurrentPct: TNewStaticText;
  ISDoneCurrentProgressBar: TNewProgressBar;
#endif
  CancelButton: TButton;
  ISDoneCancel: Integer;
  ISDoneError: Boolean;
  SingleUnpak: Boolean;
  UnpackCanceled: Boolean;
  LastArcFile: String;
  ClsLibInit: Boolean;
  SplitPct: Double;

type
  TCallback = function(OveralPct, CurrentPct: Integer; CurrentFile, TimeStr1, TimeStr2, TimeStr3: PAnsiChar): LongWord;

#if (VER < 0x06000000) && !defined(IS_ENHANCED)
type
  TFreeArcCallback = function (What: PAnsiChar; Int1, Int2: Integer; Str: PAnsiChar): Integer;

function WrapFreeArcCallback(Callback: TFreeArcCallback; ParamCount: Integer): LongWord; external 'wrapcallback@{tmp}\ISDone.dll stdcall delayload';
function WrapCallback(Callback: TCallback; ParamCount: Integer): LongWord; external 'wrapcallback@{tmp}\ISDone.dll stdcall delayload';
#endif
function ISArcExtract(CurComponent: Cardinal; PctOfTotal: Double; InName, OutPath, ExtractedPath: AnsiString; DeleteInFile: Boolean; Password, CfgFile, WorkPath: AnsiString; ExtractPCF: Boolean): Boolean; external 'ISArcExtract@{tmp}\ISDone.dll stdcall delayload';
function IS7ZipExtract(CurComponent: Cardinal; PctOfTotal: Double; InName, OutPath: AnsiString; DeleteInFile: Boolean; Password: AnsiString): Boolean; external 'IS7zipExtract@{tmp}\ISDone.dll stdcall delayload';
function ISRarExtract(CurComponent: Cardinal; PctOfTotal: Double; InName, OutPath: AnsiString; DeleteInFile: Boolean; Password: AnsiString): Boolean; external 'ISRarExtract@{tmp}\ISDone.dll stdcall delayload';
function ISPrecompExtract(CurComponent: Cardinal; PctOfTotal: Double; InName, OutFile: AnsiString; DeleteInFile: Boolean): Boolean; external 'ISPrecompExtract@{tmp}\ISDone.dll stdcall delayload';
function ISSRepExtract(CurComponent: Cardinal; PctOfTotal: Double; InName, OutFile: AnsiString; DeleteInFile: Boolean): Boolean; external 'ISSrepExtract@{tmp}\ISDone.dll stdcall delayload';
function ISxDeltaExtract(CurComponent: Cardinal; PctOfTotal: Double; MinRAM, MaxRAM: Integer; InName, DiffFile, OutFile: AnsiString; DeleteInFile, DeleteDiffFile: Boolean): Boolean; external 'ISxDeltaExtract@{tmp}\ISDone.dll stdcall delayload';
function ISPackZIP(CurComponent: Cardinal; PctOfTotal: Double; InName, OutFile: AnsiString; ComprLvl: Integer; DeleteInFile: Boolean): Boolean; external 'ISPackZIP@{tmp}\ISDone.dll stdcall delayload';
function ShowChangeDiskWindow(Text, DefaultPath, SearchFile: AnsiString): Boolean; external 'ShowChangeDiskWindow@{tmp}\ISDone.dll stdcall delayload';

function Exec2(FileName, Param: PAnsiChar; Show: Boolean): Boolean; external 'Exec2@{tmp}\ISDone.dll stdcall delayload';
function ISFindFiles(CurComponent: Cardinal; FileMask: AnsiString; var ColFiles: Integer): Integer; external 'ISFindFiles@{tmp}\ISDone.dll stdcall delayload';
function ISPickFilename(FindHandle: Integer; OutPath: AnsiString; var CurIndex: Integer; DeleteInFile: Boolean): Boolean; external 'ISPickFilename@{tmp}\ISDone.dll stdcall delayload';
function ISGetName(TypeStr: Integer): PAnsiChar; external 'ISGetName@{tmp}\ISDone.dll stdcall delayload';
function ISFindFree(FindHandle: Integer): Boolean; external 'ISFindFree@{tmp}\ISDone.dll stdcall delayload';
function ISExec(CurComponent: Cardinal; PctOfTotal, SpecifiedProcessTime: Double; ExeName, Parameters, TargetDir, OutputStr: AnsiString; Show: Boolean): Boolean; external 'ISExec@{tmp}\ISDone.dll stdcall delayload';

function SrepInit(TmpPath: PAnsiChar; VirtMem, MaxSave: Cardinal): Boolean; external 'SrepInit@{tmp}\ISDone.dll stdcall delayload';
function PrecompInit(TmpPath: PAnsiChar; VirtMem: Cardinal; PrecompVers: Single): Boolean; external 'PrecompInit@{tmp}\ISDone.dll stdcall delayload';
function FileSearchInit(RecursiveSubDir: Boolean): Boolean; external 'FileSearchInit@{tmp}\ISDone.dll stdcall delayload';
function ISDoneInit(RecordFileName: AnsiString; TimeType, Comp1, Comp2, Comp3: Cardinal; WinHandle, NeededMem: Longint; Callback: TCallback): Boolean; external 'ISDoneInit@{tmp}\ISDone.dll stdcall delayload';
function ISDoneStop: Boolean; external 'ISDoneStop@{tmp}\ISDone.dll stdcall delayload';
function ChangeLanguage(Language: AnsiString): Boolean; external 'ChangeLanguage@{tmp}\ISDone.dll stdcall delayload';
function SuspendProc: Boolean; external 'SuspendProc@{tmp}\ISDone.dll stdcall delayload';
function ResumeProc: Boolean; external 'ResumeProc@{tmp}\ISDone.dll stdcall delayload';

type
  TSplitState = (ssRead, ssRunning, ssPaused, ssStoped);
  TSplitCallback = function(const State: TSplitState; const SrcFile, DstFile: WideString; SplitPos, MinProg, MaxProg: Integer; SrcPos, SrcSize, DstPos, DstSize: Extended): Boolean;

function SplitDataFile(const SrcFile, DstFile: WideString; SizeOfParts: WideString; InitProg, MaxProg: Integer; CallBack: TSplitCallback): Boolean; external 'SplitDataFile@{tmp}\SplitLib.dll stdcall delayload';
function JoinDataFiles(const SrcFile, DstFile: WideString; InitProg, MaxProg: Integer; CallBack: TSplitCallback): Boolean; external 'JoinDataFiles@{tmp}\SplitLib.dll stdcall delayload';
function MergeDataFile(const SrcFile, DstFile: WideString; SizeOfParts: WideString; CurrPart, InitProg, MaxProg: Integer; FirstPart: Boolean; CallBack: TSplitCallback): Boolean; external 'MergeDataFile@{tmp}\SplitLib.dll stdcall delayload';
function SplitState(State: TSplitState): TSplitState; external 'SplitState@{tmp}\SplitLib.dll stdcall delayload';
procedure SplitBuffer(Size, Slice: Integer); external 'SplitBuffer@{tmp}\SplitLib.dll stdcall delayload';

function FloatToString(const Float: Extended; Offset: Integer): WideString; external 'FloatToString@{tmp}\SplitLib.dll stdcall delayload';
function ProgressCalcule(FilePos, FileSize, MaxProg: Extended): Extended; external 'ProgressCalcule@{tmp}\SplitLib.dll stdcall delayload';
function ConvertDisk(const FirstDisk: WideString; DiskNumber: Integer): WideString; external 'ConvertDisk@{tmp}\SplitLib.dll stdcall delayload';
procedure ValueToBytes(const Value: WideString; Default: Extended; var Bytes: Extended); external 'ValueToBytes@{tmp}\SplitLib.dll stdcall delayload';


type
  TEncodeType = (etUSASCII, etUTF8, etANSI);

function DetectUTF8Encoding(strText: WideString): TEncodeType; external 'DetectUTF8Encoding@{tmp}\SplitLib.dll stdcall delayload';
function IsUtf8String(strText: WideString): Boolean; external 'IsUtf8String@{tmp}\SplitLib.dll stdcall delayload';
function AnsiToUtf8(strSource: WideString): WideString; external 'AnsiToUtf8@{tmp}\SplitLib.dll stdcall delayload';
function Utf8ToAnsi(strSource: WideString): WideString; external 'Utf8ToAnsi@{tmp}\SplitLib.dll stdcall delayload';
function StrAsAnsi(StrText: WideString): WideString; external 'StrAsAnsi@{tmp}\SplitLib.dll stdcall delayload';
function StrAsUtf8(StrText: WideString): WideString; external 'StrAsUtf8@{tmp}\SplitLib.dll stdcall delayload';

function AnsiText(Text: String): AnsiString;
begin
  if IsUtf8String(Text) then
    Result := Utf8ToAnsi(Text)
  else
    Result := Text;
end;

type
  TWideStringArray = Array of WideString;
  TExprType = (peString, peHex, peBool, peFloat);

function ParseExpressionEx(Expr: WideString; ExprType: TExprType; CStyle: Boolean; DecimalSep, ArgumentSep: Char): Variant; external 'ParseExpressionEx@{tmp}\SplitLib.dll stdcall delayload';
function ParseExpressionVars(Expr: WideString; ExprType: TExprType; CStyle: Boolean; DecimalSep, ArgumentSep: Char; Vars: TWideStringArray): Variant; external 'ParseExpressionVars@{tmp}\SplitLib.dll stdcall delayload';
function ParseExpressionAsString(Expr: WideString): WideString; external 'ParseExpressionAsString@{tmp}\SplitLib.dll stdcall delayload';
function ParseExpressionExAsString(Expr: WideString; CStyle: Boolean; DecimalSep, ArgumentSep: Char): WideString; external 'ParseExpressionExAsString@{tmp}\SplitLib.dll stdcall delayload';
function ParseExpressionAsHexadecimal(Expr: WideString): WideString; external 'ParseExpressionAsHexadecimal@{tmp}\SplitLib.dll stdcall delayload';
function ParseExpressionExAsHexadecimal(Expr: WideString; CStyle: Boolean; DecimalSep, ArgumentSep: Char): WideString; external 'ParseExpressionExAsHexadecimal@{tmp}\SplitLib.dll stdcall delayload';
function ParseExpressionAsFloat(Expr: WideString): Double; external 'ParseExpressionAsFloat@{tmp}\SplitLib.dll stdcall delayload';
function ParseExpressionExAsFloat(Expr: WideString; CStyle: Boolean; DecimalSep, ArgumentSep: Char): Double; external 'ParseExpressionExAsFloat@{tmp}\SplitLib.dll stdcall delayload';
function ParseExpressionAsBoolean(Expr: WideString): Boolean; external 'ParseExpressionAsBoolean@{tmp}\SplitLib.dll stdcall delayload';
function ParseExpressionExAsBoolean(Expr: WideString; CStyle: Boolean; DecSep, ArgSep: Char): Boolean; external 'ParseExpressionExAsBoolean@{tmp}\SplitLib.dll stdcall delayload';

function WordToChar(Value: Word): Char; external 'WordToChar@{tmp}\SplitLib.dll stdcall delayload';
function FloatToText(Value: Extended): WideString; external 'FloatToText@{tmp}\SplitLib.dll stdcall delayload';
function IsWildcardEx(const Pattern: WideString): Boolean; external 'IsWildcardEx@{tmp}\SplitLib.dll stdcall delayload';
function WildcardMatchEx(const Text, Pattern: WideString; CaseSensitive: Boolean): Boolean; external 'WildcardMatchEx@{tmp}\SplitLib.dll stdcall delayload';
function CreateBitmapRgn(DC: LongWord; hBmp: HBitmap; TransColor, TolerColor: DWORD; dX, dY: Integer): LongWord; external 'CreateBitmapRgn@{tmp}\SplitLib.dll stdcall delayload';

type
  TFFResultKind = (ffrkFull, ffrkRelative, ffrkOnlyName);

function pFindFiles(const FindPath, FileMasks, ExcludeMasks: WideString; ResultKind: TFFResultKind; Recursive, FindDirs: Boolean): Longint; external 'pFindFiles@{tmp}\SplitLib.dll stdcall delayload';
function pFindFilesEx(const FindPath, DestPath, FileMasks, ExcludeMasks: WideString; ResultKind: TFFResultKind; Recursive, HiddenFiles, SystemFiles, FindDirs, GetHash: Boolean): Longint; external 'pFindFilesEx@{tmp}\SplitLib.dll stdcall delayload';
function pFileCount(const FindHandle: Longint): Integer; external 'pFileCount@{tmp}\SplitLib.dll stdcall delayload';
function pPickFile(const FindHandle: Longint; const Index: Integer): WideString; external 'pPickFile@{tmp}\SplitLib.dll stdcall delayload';
function pPickFileList(const FindHandle: Longint): WideString; external 'pPickFileList@{tmp}\SplitLib.dll stdcall delayload';
function pPickSize(const FindHandle: Longint; const Index: Integer): WideString; external 'pPickSize@{tmp}\SplitLib.dll stdcall delayload';
function pPickHash(const FindHandle: Longint; const Index: Integer): WideString; external 'pPickHash@{tmp}\SplitLib.dll stdcall delayload';
function pPickAttrib(const FindHandle: Longint; const Index: Integer): Integer; external 'pPickAttrib@{tmp}\SplitLib.dll stdcall delayload';
function pPickFileFormat(const FindHandle: Longint; const Index: Integer): WideString; external 'pPickFileFormat@{tmp}\SplitLib.dll stdcall delayload';
function pPickFileFormatList(const FindHandle: Longint): WideString; external 'pPickFileFormatList@{tmp}\SplitLib.dll stdcall delayload';
function pDirCount(const FindHandle: Longint): Integer; external 'pDirCount@{tmp}\SplitLib.dll stdcall delayload';
function pPickDir(const FindHandle: Longint; const Index: Integer): WideString; external 'pPickDir@{tmp}\SplitLib.dll stdcall delayload';
function pPickDirList(const FindHandle: Longint): WideString; external 'pPickDirList@{tmp}\SplitLib.dll stdcall delayload';
function pPickDirFormat(const FindHandle: Longint; const Index: Integer): WideString; external 'pPickDirFormat@{tmp}\SplitLib.dll stdcall delayload';
function pPickDirFormatList(const FindHandle: Longint): WideString; external 'pPickDirFormatList@{tmp}\SplitLib.dll stdcall delayload';
function pFindFree(const FindHandle: Longint): Boolean; external 'pFindFree@{tmp}\SplitLib.dll stdcall delayload';

function GetCpuName(): WideString; external 'GetCpuName@{tmp}\SplitLib.dll stdcall delayload';
function GetCpuRealClockSpeed(): Integer; external 'GetCpuRealClockSpeed@{tmp}\SplitLib.dll stdcall delayload';
function GetCpuPhysicalCores(): Integer; external 'GetCpuPhysicalCores@{tmp}\SplitLib.dll stdcall delayload';
function GetCpuLogicalCores(): Integer; external 'GetCpuLogicalCores@{tmp}\SplitLib.dll stdcall delayload';
function GetTotalVisibleMemoryEx(): Extended; external 'GetTotalVisibleMemoryEx@{tmp}\SplitLib.dll stdcall delayload';
function GetFreePhysicalMemoryEx(): Extended; external 'GetFreePhysicalMemoryEx@{tmp}\SplitLib.dll stdcall delayload';
function GetTotalVisibleMemory(): Cardinal; external 'GetTotalVisibleMemory@{tmp}\SplitLib.dll stdcall delayload';
function GetFreePhysicalMemory(): Cardinal; external 'GetFreePhysicalMemory@{tmp}\SplitLib.dll stdcall delayload';
function GetOSName(): WideString; external 'GetOSName@{tmp}\SplitLib.dll stdcall delayload';
function GetOSVersionMajor(): Cardinal; external 'GetOSVersionMajor@{tmp}\SplitLib.dll stdcall delayload';
function GetOSVersionMinor(): Cardinal; external 'GetOSVersionMinor@{tmp}\SplitLib.dll stdcall delayload';
function GetOSBuildNumbers(): Cardinal; external 'GetOSBuildNumbers@{tmp}\SplitLib.dll stdcall delayload';
function GetServicePackMajorVersion(): Word; external 'GetServicePackMajorVersion@{tmp}\SplitLib.dll stdcall delayload';
function GetServicePackMinorVersion(): Word; external 'GetServicePackMinorVersion@{tmp}\SplitLib.dll stdcall delayload';
function GetOSArchitecture(): Byte; external 'GetOSArchitecture@{tmp}\SplitLib.dll stdcall delayload';

type
  TDiskSpanStatus = (cbStoped, cbPaused, cbWorking);
  TDiskSpanProc = procedure(Status: TDiskSpanStatus);
  TRequestDisk = procedure(var lpPath: WideString; lpFileName: WideString);

function DiskSpanInit(hParent: THandle; lpPath: WideString; DiskRequest: TRequestDisk; Callback: TDiskSpanProc): Boolean; external 'ClsInit@{tmp}\CLS-DISKSPAN.dll stdcall delayload'; // optional
procedure SetDiskRequest(DiskRequest: TRequestDisk); external 'ClsSetDiskRequest@{tmp}\CLS-DISKSPAN.dll stdcall delayload';
procedure SetSourcePath(lpPath: WideString); external 'ClsSetSourcePath@{tmp}\CLS-DISKSPAN.dll stdcall delayload';
function GetSourcePath(): WideString; external 'ClsGetSourcePath@{tmp}\CLS-DISKSPAN.dll stdcall delayload';
function GetWaitDiskTime(Reset: Boolean): Double; external 'ClsGetWaitDiskTime@{tmp}\CLS-DISKSPAN.dll stdcall delayload';
procedure SetMessageText(lpText, lpCaption: WideString); external 'ClsSetMessageText@{tmp}\CLS-DISKSPAN.dll stdcall delayload';
procedure SetDiskList(lpDisks: WideString); external 'ClsSetDiskList@{tmp}\CLS-DISKSPAN.dll stdcall delayload';

const
  MB_APPLMODAL       = $00000000;
  MB_SYSTEMMODAL     = $00001000;
  MB_TASKMODAL       = $00002000;
#if !defined(IS_ENHANCED)
  MB_ICONERROR       = $10;
  MB_ICONQUESTION    = $20;
  MB_ICONWARNING     = $30;
  MB_ICONINFORMATION = $40;
#endif
  SS_LEFT = 0;
  SS_CENTER = 1;
  SS_RIGHT = 2;
  SS_LEFTNOWORDWRAP = 12;

  GWL_WNDPROC = (-4);
  GWL_HINSTANCE = (-6);
  GWL_HWNDPARENT = (-8);
  GWL_ID = (-12);
  GWL_STYLE = (-16);
  GWL_EXSTYLE = (-20);
  GWL_USERDATA = (-21);

function FreeArcExtract(Callback: LongWord; Cmd1, Cmd2, Cmd3, Cmd4, Cmd5, Cmd6, Cmd7, Cmd8, Cmd9, Cmd10: PAnsiChar): Integer; external 'FreeArcExtract@{tmp}\UnArcLib.dll cdecl delayload';
function GetWindowLong(hWnd: HWND; nIndex: Integer): Longint; external 'GetWindowLongW@user32.dll stdcall delayload';
function SetWindowLong(hWnd: HWND; nIndex: Integer; dwNewLong: Longint): Longint; external 'SetWindowLongW@user32.dll stdcall delayload';
function SetFocus(hWnd: HWND): HWND; external 'SetFocus@user32.dll stdcall delayload';
function MessageBox(hWnd: HWND; lpText, lpCaption: String; uType: UINT): Integer; external 'MessageBoxW@user32.dll stdcall delayload';
//function FreeLibrary(hModule: THandle): BOOL; external 'FreeLibrary@kernel32.dll stdcall delayload';
//function GetModuleHandle(lpModuleName: String): THandle; external 'GetModuleHandleW@kernel32.dll stdcall delayload';

const
  MOVEFILE_REPLACE_EXISTING = $1;
  MOVEFILE_COPY_ALLOWED = $2;
  MOVEFILE_DELAY_UNTIL_REBOOT = $4;
  MOVEFILE_WRITE_THROUGH = $8;
  MOVEFILE_CREATE_HARDLINK = $10;
  MOVEFILE_FAIL_IF_NOT_TRACKABLE = $20;

function MoveFileEx(lpExistingFileName: String; lpNewFileName: String; dwFlags: DWORD): BOOL; external 'MoveFileExW@kernel32.dll stdcall delayload';
function CopyFile(const lpExistingFileName, lpNewFileName: String; bFailIfExists: BOOL): BOOL; external 'CopyFileW@kernel32.dll stdcall delayload';
function DeleteFileEx(lpFileName: String): BOOL; external 'DeleteFileW@kernel32.dll stdcall delayload';

const
  PM_REMOVE = $0001;

#if !defined(IS_ENHANCED)
type
  TMsg = record hWnd: HWND; message: LongWord; wParam: Longint; lParam: Longint; Time: LongWord; pt: TPoint; end;
#endif

function TranslateMessage(const lpMsg: TMsg): BOOL; external 'TranslateMessage@user32.dll stdcall delayload';
function DispatchMessage(const lpMsg: TMsg): Longint; external 'DispatchMessageW@user32.dll stdcall delayload';
function PeekMessage(var lpMsg: TMsg; hWnd: HWND; wMsgFilterMin, wMsgFilterMax, wRemoveMsg: UINT): BOOL; external 'PeekMessageW@user32.dll stdcall delayload';

procedure ProcessMessages;
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, 0, 0, 0, PM_REMOVE) do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end;

type
  TSystemInfo = record
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

procedure GetSystemInfo(var lpSystemInfo: TSystemInfo); external 'GetSystemInfo@kernel32.dll stdcall delayload';

function GetCPUThreads: Integer;
var
  SysInfo: TSystemInfo;
begin
  GetSystemInfo(SysInfo);
  Result := SysInfo.dwNumberOfProcessors;
end;

function IfThen(AValue: Boolean; const ATrue, AFalse: Variant): Variant;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function EmptyStr(S: String): Boolean;
begin
  Result := Trim(S) = '';
end;

function StrToFloatDef(S: String; Def: Extended): Extended;
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

function Min(A, B: Integer): Integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

function Max(A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

const
  POWER_BY = 0;
  POWER_KB = 1;
  POWER_MB = 2;
  POWER_GB = 3;
  POWER_TB = 4;
  POWER_PB = 5;
  KFactor = 1024;

function PowerK(Value: Extended; Offset: Integer): Extended;
var
  I: Integer;
begin
  Result := Value;
  for I := 1 to Offset do
    Result := Result * KFactor;
end;

function GetSizeBytes(const Value: String; Default: Extended): Extended;
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
      'PB', 'P' : Result := PowerK(StrToFloatDef(TmpStr, Default), POWER_PB);
      'TB', 'T' : Result := PowerK(StrToFloatDef(TmpStr, Default), POWER_TB);
      'GB', 'G' : Result := PowerK(StrToFloatDef(TmpStr, Default), POWER_GB);
      'MB', 'M' : Result := PowerK(StrToFloatDef(TmpStr, Default), POWER_MB);
      'KB', 'K' : Result := PowerK(StrToFloatDef(TmpStr, Default), POWER_KB);
      'BY', 'B' : begin
        StringChangeEx(TmpStr, '.', '', True);
        StringChangeEx(TmpStr, ',', '', True);
        Result := StrToFloatDef(TmpStr, Default);
      end;
      else begin
        if Pos('.', Copy(TmpStr, Pos('.', TmpStr), Length(TmpStr))) > 0 then
        begin
          StringChangeEx(TmpStr, '.', '', True);
          Result := StrToFloatDef(TmpStr, Default);
        end else
          Result := PowerK(StrToFloatDef(TmpStr, Default), POWER_MB);
      end;
    end;
  end else
    Result := Default;
end;

function CloseProcess(const Process: String): Integer;
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

function CloseTempProcessFromDir(const FromDir: String): Integer;
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
            Result := CloseProcess(AddBackslash(FromDir) + FindRec.Name)
          else
            if DirExists(AddBackslash(FromDir) + FindRec.Name) then
              Result := CloseTempProcessFromDir(AddBackslash(FromDir) + FindRec.Name);
        end;
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
    end;
  end;
end;

function ParseCheckItemsLine(ItemList: TStringList; ItemLine: String; IsLang: Boolean): String;
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

function ComponentsCheck(CompLine: String): Boolean; //You can call this function in the registry entries.
#ifdef Components
var
  //I: Integer;
  StrLine: String;
  StrList: TStringList;
#endif
begin
  Result := EmptyStr(CompLine) or (Pos('*', CompLine) > 0);
  #ifdef Components
  if not Result then
  begin
    StrList := TStringList.Create;
    try
      ////It doesn't work because if you use the Languages: native parameters and it is not met, the item will not be displayed and the INDEX will be changed.
      //for I := 0 to WizardForm.ComponentsList.Items.Count - 1 do
      //  if WizardForm.ComponentsList.Checked[I] then
      //    StrList.Append(IntToStr(I + 1));

      if {#VER >= 0x06000000 ? "Wizard" : void}IsComponentSelected('comp1') then StrList.Append('1');
      if {#VER >= 0x06000000 ? "Wizard" : void}IsComponentSelected('comp2') then StrList.Append('2');

//    if {#VER >= 0x06000000 ? "Wizard" : void}IsComponentSelected('text\rus') then StrList.Append('1');
//    if {#VER >= 0x06000000 ? "Wizard" : void}IsComponentSelected('text\eng') then StrList.Append('2');
//    if {#VER >= 0x06000000 ? "Wizard" : void}IsComponentSelected('voice\rus') then StrList.Append('3');
//    if {#VER >= 0x06000000 ? "Wizard" : void}IsComponentSelected('voice\eng') then StrList.Append('4');

      StrLine := ParseCheckItemsLine(StrList, CompLine, False);
      Result := ParseExpressionExAsBoolean('(' + StrLine + ')==1', True, '.', ';');
    except
      Log('Exception on ParseExpressionExAsBoolean function');
    finally
      StrList.Free;
    end;
  end;
  #endif
end;

function TasksCheck(TaskLine: String): Boolean; //You can call this function in the registry entries.
#ifdef Tasks
var
  //I: Integer;
  StrLine: String;
  StrList: TStringList;
#endif
begin
  Result := EmptyStr(TaskLine) or (Pos('*', TaskLine) > 0);
  #ifdef Tasks
  if not Result then
  begin
    StrList := TStringList.Create;
    try
      ////It doesn't work because if you use the Languages: or Components: native parameters and it is not met, the item will not be displayed and the INDEX will be changed.
      //for I := 0 to WizardForm.TasksList.Items.Count - 1 do
      //  if WizardForm.TasksList.Checked[I] then
      //    StrList.Append(IntToStr(I + 1));

      if {#VER >= 0x06000000 ? "Wizard" : void}IsTaskSelected('task1') then StrList.Append('1');
      if {#VER >= 0x06000000 ? "Wizard" : void}IsTaskSelected('task2') then StrList.Append('2');

//      if {#VER >= 0x06000000 ? "Wizard" : void}IsTaskSelected('task\task1') then StrList.Append('2');
//      if {#VER >= 0x06000000 ? "Wizard" : void}IsTaskSelected('task\task2') then StrList.Append('3');

      StrLine := ParseCheckItemsLine(StrList, TaskLine, False);
      Result := ParseExpressionExAsBoolean('(' + StrLine + ')==1', True, '.', ';');
    except
      Log('Exception on ParseExpressionExAsBoolean function');
    finally
      StrList.Free;
    end;
  end;
  #endif
end;

function LanguagesCheck(LangLine: String): Boolean; //You can call this function in the registry entries.
var
  StrLine: String;
  StrList: TStringList;
begin
  Result := EmptyStr(LangLine) or (Pos('*', LangLine) > 0);
  if not Result then
  begin
    StrList := TStringList.Create;
    try
      case LowerCase(ActiveLanguage) of
        'dutch'      : StrList.Append('NL');
        'english'    : StrList.Append('EN');
        'french'     : StrList.Append('FR');
        'german'     : StrList.Append('DE');
        'hungarian'  : StrList.Append('HU');
        'italian'    : StrList.Append('IT');
        'japanese'   : StrList.Append('JP');
        'portuguese' : StrList.Append('PTBR');
        'russian'    : StrList.Append('RU');
        'spanish'    : StrList.Append('ES');
      end;
      StrLine := ParseCheckItemsLine(StrList, LangLine, True);
      Result := ParseExpressionExAsBoolean('(' + StrLine + ')==1', True, '.', ';');
    except
      Log('Exception on ParseExpressionExAsBoolean function');
    finally
      StrList.Free;
    end;
  end;
end;

function CheckError: Boolean;
begin
  Result := not ISDoneError;
end;

procedure CancelButtonOnClick(Sender: TObject);
begin
  SuspendProc;
  if MsgBox(SetupMessage(msgExitSetupMessage), mbConfirmation, MB_YESNO) = IDYES then
    ISDoneCancel := 1;
  ResumeProc;
end;

procedure HideControls();
begin
  WizardForm.FileNamelabel.Hide;
  ISDoneOveralProgressBar.Hide;
  LabelOveralPct.Hide;
  LabelCurrFileName.Hide;
  LabelElapsedTime.Hide;
  LabelRemainingTime.Hide;
  CancelButton.Hide;
  #ifdef SecondProgressBar
  ISDoneCurrentProgressBar.Hide;
  LabelCurrentPct.Hide;
  #endif
end;

procedure CreateControls();
var
  PBTop: Integer;
begin
  PBTop := ScaleY(50);
  ISDoneOveralProgressBar := TNewProgressBar.Create(WizardForm);
  with ISDoneOveralProgressBar do begin
    Parent   := WizardForm.InstallingPage;
    Left     := ScaleX(0);
    Top      := PBTop;
    Width    := WizardForm.ProgressGauge.Width - ScaleX(50);
    Height   := WizardForm.ProgressGauge.Height;
    Max      := 1000;
    Position := 0;
    #if VER >= 0x06000000
    Anchors := [akLeft, akTop, akRight];
    #endif
  end;
  LabelOveralPct := TNewStaticText.Create(WizardForm);
  with LabelOveralPct do begin
    Parent    := WizardForm.InstallingPage;
    AutoSize  := False;
    Left      := ISDoneOveralProgressBar.Width + ScaleX(5);
    Top       := ISDoneOveralProgressBar.Top + ScaleY(3);
    Width     := ScaleX(40);
    SetWindowLong(Handle, GWL_STYLE, (GetWindowLong(Handle, GWL_STYLE) and (not SS_LEFT) and (not SS_CENTER) and (not SS_RIGHT) and (not SS_LEFTNOWORDWRAP)) or SS_CENTER);
    #if VER >= 0x06000000
    Anchors := [akTop, akRight];
    #endif
  end;
  LabelCurrFileName := TNewStaticText.Create(WizardForm);
  with LabelCurrFileName do begin
    Parent   := WizardForm.InstallingPage;
    AutoSize := False;
    Width    := ISDoneOveralProgressBar.Width + ScaleX(30);
    Left     := ScaleX(0);
    Top      := ScaleY(30);
    #if VER >= 0x06000000
    Anchors := WizardForm.FileNameLabel.Anchors;
    #endif
  end;
  #ifdef SecondProgressBar
  PBTop := PBTop + ScaleY(25);
  ISDoneCurrentProgressBar := TNewProgressBar.Create(WizardForm);
  with ISDoneCurrentProgressBar do begin
    Parent   := WizardForm.InstallingPage;
    Left     := ScaleX(0);
    Top      := PBTop + ScaleY(8);
    Width    := ISDoneOveralProgressBar.Width;
    Height   := WizardForm.ProgressGauge.Height;
    Max      := 1000;
    Position := 0;
    #if VER >= 0x06000000
    Anchors := [akLeft, akTop, akRight];
    #endif
  end;
  LabelCurrentPct := TNewStaticText.Create(WizardForm);
  with LabelCurrentPct do begin
    Parent    := WizardForm.InstallingPage;
    AutoSize  := False;
    Left      := ISDoneCurrentProgressBar.Width + ScaleX(5);
    Top       := ISDoneCurrentProgressBar.Top + ScaleY(3);
    Width     := ScaleX(40);
    SetWindowLong(Handle, GWL_STYLE, (GetWindowLong(Handle, GWL_STYLE) and (not SS_LEFT) and (not SS_CENTER) and (not SS_RIGHT) and (not SS_LEFTNOWORDWRAP )) or SS_CENTER);
    #if VER >= 0x06000000
    Anchors := [akTop, akRight];
    #endif
  end;
  #endif
  LabelElapsedTime := TNewStaticText.Create(WizardForm);
  with LabelElapsedTime do begin
    Parent   := WizardForm.InstallingPage;
    AutoSize := False;
    Left     := ScaleX(0);
    Top      := PBTop + ScaleY(35);
    Width    := ISDoneOveralProgressBar.Width div 2;
    #if VER >= 0x06000000
    Anchors := [akLeft, akTop];
    #endif
  end;
  LabelRemainingTime := TNewStaticText.Create(WizardForm);
  with LabelRemainingTime do begin
    Parent   := WizardForm.InstallingPage;
    AutoSize := False;
    Left     := ISDoneOveralProgressBar.Width div 2;
    Top      := LabelElapsedTime.Top;
    Width    := LabelElapsedTime.Width + ScaleX(40);
    #if VER >= 0x06000000
    Anchors := [akLeft, akTop, akRight];
    #endif
  end;
  LabelAllElapsedTime := TNewStaticText.Create(WizardForm);
  with LabelAllElapsedTime do begin
    Parent   := WizardForm.FinishedPage;
    AutoSize := False;
    Left     := WizardForm.NoRadio.Left;
    Top      := WizardForm.NoRadio.Top + WizardForm.NoRadio.Height + ScaleY(11);
    Width    := WizardForm.NoRadio.Width;
    #if VER >= 0x06000000
    Anchors := [akLeft, akTop, akRight];
    #endif
  end;
  CancelButton := TButton.Create(WizardForm);
  with CancelButton do begin
    Parent   := WizardForm;
    Width    := ScaleX(135);
    Caption  := ExpandConstant('{cm:CancelButton}');
    Left     := WizardForm.CancelButton.Left + WizardForm.CancelButton.Width - ScaleX(135);
    Top      := WizardForm.CancelButton.Top;
    OnClick  := @CancelButtonOnClick;
    Enabled  := False;
    #if VER >= 0x06000000
    Anchors := [akTop, akRight];
    #endif
  end;
end;

function MergeFileCallback(const State: TSplitState; const SrcFile, DstFile: WideString; SplitPos, MinProg, MaxProg: Integer; SrcPos, SrcSize, DstPos, DstSize: Extended): Boolean;
var
  Progress: Integer;
  SourcePct: Integer;
  DestinPct: Integer;
begin
  if State <> ssRead then
  begin
    SourcePct := Round(ProgressCalcule(SrcPos, SrcSize, 1000));
    DestinPct := Round(ProgressCalcule(DstPos, DstSize, 1000));
    Progress := Round(ProgressCalcule(SrcPos, SrcSize, MaxProg) / 1000);
    LabelCurrFileName.Caption := FmtMessage(CustomMessage('Merging'), [ExtractFileName(SrcFile), ExtractFileName(DstFile),
      IntToStr(SourcePct div 10) + '.' + IntToStr(SourcePct mod 10), IntToStr(DestinPct div 10) + '.' + IntToStr(DestinPct mod 10)]);
    if MinProg + Progress <= 1000 then
      ISDoneOveralProgressBar.Position := MinProg + Progress;
    #ifdef SecondProgressBar
    if DestinPct <= 1000 then
      ISDoneCurrentProgressBar.Position := DestinPct;
    #endif
  end;
  Result := ISDoneCancel = 0;
end;

function ProgressCallback(OveralPct, CurrentPct: Integer; CurrentFile, TimeStr1, TimeStr2, TimeStr3: PAnsiChar): LongWord;
var
  Progress: Integer;
begin
  Progress := Round(SplitPct + OveralPct)
  if Progress <= 1000 then
    ISDoneOveralProgressBar.Position := Progress;
  LabelOveralPct.Caption := IntToStr(Progress div 10) + '.' + Chr(48 + Progress mod 10) + '%';
  #ifdef SecondProgressBar
  if CurrentPct <= 1000 then
    ISDoneCurrentProgressBar.Position := CurrentPct;
  LabelCurrentPct.Caption := IntToStr(CurrentPct div 10) + '.' + Chr(48 + CurrentPct mod 10) + '%';
  #endif
  LabelCurrFileName.Caption := ExpandConstant('{cm:ExtractedFile} ') + MinimizePathName(CurrentFile, LabelCurrFileName.Font, LabelCurrFileName.Width - ScaleX(100));
  LabelElapsedTime.Caption := ExpandConstant('{cm:ElapsedTime} ') + TimeStr2;
  LabelRemainingTime.Caption := ExpandConstant('{cm:RemainingTime} ') + TimeStr1;
  LabelAllElapsedTime.Caption := ExpandConstant('{cm:AllElapsedTime}') + TimeStr3;
  Result := ISDoneCancel;
end;

procedure DiskSpanCallback(Status: TDiskSpanStatus);
begin
  case Status of
    cbStoped  : begin
      ISDoneCancel := 1;
      ResumeProc;
      ISDoneError := True;
      WizardForm.NextButton.OnClick(nil);
    end;
    cbPaused  : SuspendProc;
    cbWorking : ResumeProc;
  end;
end;

function ExpandArcFile(ArcFile, SrcDir: String): String;
begin
  Result := ArcFile;
  StringChange(Result, '{src}', RemoveBackslashUnlessRoot(SrcDir));
  Result := ExpandConstant(Result);
end;

function BrowseArcFile(const ArcFile, Disk: String; var SrcDir: String): String;
var
  I: Integer;
  TmpStr: String;
  TmpPath: String;
  StrLabel: String;
  DiskNumber: String;
  FirstPath: String;
begin
  SuspendProc;
  DiskNumber := Trim(Disk);
  if ClsLibInit then
  begin
    if ClsLibInit then
      SetDiskList(DiskNumber);
    if GetSourcePath <> '' then
      SrcDir := GetSourcePath;
  end;

  FirstPath := ExtractFileName(RemoveBackslash(SrcDir));
  if (FirstPath <> '') and (not FileExists(ExpandArcFile(ArcFile, SrcDir))) then
  begin
    TmpPath := ExtractFilePath(RemoveBackslash(SrcDir)) + FirstPath;
    ArcFile := AddBackslash(TmpPath) + ExtractFileName(ArcFile);
    if not FileExists(ExpandArcFile(ArcFile, TmpPath)) then
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
        if FileExists(ExpandArcFile(ArcFile, TmpPath)) then
        begin
          SrcDir := TmpPath;
          FirstPath := ExtractFileName(RemoveBackslash(SrcDir));
        end;
      end;
    end else
      SrcDir := TmpPath;
  end else
    FirstPath := ExtractFileName(RemoveBackslash(SrcDir));

  if not FileExists(ExpandArcFile(ArcFile, SrcDir)) then
    SrcDir := ExtractFilePath(LastArcFile);

  while (not FileExists(ExpandArcFile(ArcFile, SrcDir))) and (not ISDoneError) do
  begin
    StrLabel := FmtMessage(CustomMessage('ChangeDiskLabel'), [Copy(Trim(DiskNumber), 1, Pos(',', Trim(DiskNumber) + ',') - 1), ExtractFileName(ArcFile)]);
    StringChangeEx(StrLabel, #32#32, #32, True);
    case MessageBox(WizardForm.Handle, StrLabel, SetupMessage(msgChangeDiskTitle), MB_OKCANCEL or MB_ICONQUESTION or MB_TASKMODAL) of
      IDCANCEL : begin
        ISDoneCancel := 1;
        ISDoneError := True;
        ResumeProc;
        WizardForm.CancelButton.OnClick(nil);
      end;
      IDOK : begin
        if FileExists(ExpandArcFile(ArcFile, SrcDir)) then
        begin
          SrcDir := ExtractFileDir(ExpandArcFile(ArcFile, SrcDir));
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
  Result := ExpandArcFile(ArcFile, SrcDir);
  if ClsLibInit then
    SetSourcePath(WideString(SrcDir));

  LastArcFile := Result;
  ResumeProc;
end;

function ExtractTemporaryFileEx(const FileName: String): Boolean;
begin
  Result := FileExists(ExpandConstant('{tmp}\' + ExtractFileName(FileName)));
  if not Result then
  begin
    try
      ExtractTemporaryFile(ExtractFileName(FileName));
    finally
      Result := FileExists(ExpandConstant('{tmp}\' + ExtractFileName(FileName)));
    end;
  end;
end;

procedure RenameINIFiles(Optimal: Boolean);
begin
  if FileCopy(ExpandConstant('{tmp}\CLS_' + IfThen(Optimal, 'Optimal', 'Standard') + '.ini'), ExpandConstant('{tmp}\CLS.ini'), False) then
  begin
    DeleteFile(ExpandConstant('{tmp}\CLS_Standard.ini'));
    DeleteFile(ExpandConstant('{tmp}\CLS_Optimal.ini'));
  end;
  if FileCopy(ExpandConstant('{tmp}\ARC_' + IfThen(Optimal, 'Optimal', 'Standard') + '_' + IfThen(IsWin64, 'x64', 'x86') + '.ini'), ExpandConstant('{tmp}\Arc.ini'), False) then
  begin
    DeleteFile(ExpandConstant('{tmp}\ARC_Standard_x64.ini'));
    DeleteFile(ExpandConstant('{tmp}\ARC_Standard_x86.ini'));
    DeleteFile(ExpandConstant('{tmp}\ARC_Optimal_x64.ini'));
    DeleteFile(ExpandConstant('{tmp}\ARC_Optimal_x86.ini'));
  end else
    if FileCopy(ExpandConstant('{tmp}\ARC_' + IfThen(Optimal, 'Optimal', 'Standard') + '.ini'), ExpandConstant('{tmp}\Arc.ini'), False) then
    begin
      DeleteFile(ExpandConstant('{tmp}\ARC_Standard.ini'));
      DeleteFile(ExpandConstant('{tmp}\ARC_Optimal.ini'));
    end;
end;

function GetDLLFileName(): String;
begin
  Result := ChangeFileExt(ExpandConstant('{srcexe}'), '.dll');
  if not FileExists(Result) then
  begin
    try
      if not FileExists(ExpandConstant('{tmp}\{#Setup_DLL}')) then
        ExtractTemporaryFile('{#Setup_DLL}');
      Result := ExpandConstant('{tmp}\{#Setup_DLL}');
    except
    end;
  end;
end;

function FreeArcCallback(What: PAnsiChar; Int1, Int2: Integer; Str: PAnsiChar): Integer;
begin
  Result := 0;
  if String(What) = 'password?' then
  begin
    MessageBox(WizardForm.Handle, 'The password used to extract Setup.dll is incorrect.' + #13#10 + 'Password: ' + String(Str), SetupMessage(msgErrorTitle), MB_ICONERROR or MB_OK or MB_TASKMODAL);
    Result := -10; {-63} {-127}
  end else
    if (not SingleUnpak) and (String(What) = 'filename') then
    begin
      Log('Unpacking temporary file: ' + String(Str));
      WizardForm.StatusLabel.Caption := SetupMessage(msgStatusExtractFiles);
      LabelCurrFileName.Caption := MinimizePathName(String(Str), WizardForm.FileNameLabel.Font, WizardForm.FileNameLabel.Width);
      LabelCurrFileName.Refresh;
      ProcessMessages;
    end;
end;

function UnpackDLLFiles(UnpFile: String): Boolean;
var
  FileName: String;
  Password: String;
  ErrorCode: Integer;
begin
  Result := False;
  if ExtractTemporaryFileEx('UnArcLib.dll') and ExtractTemporaryFileEx('SplitLib.dll') then
  begin
    FileName := GetDLLFileName();
    if FileExists(FileName) then
    begin
      SingleUnpak := Trim(UnpFile) <> '';
      #ifdef PasswordDLL
      Password := '{#PasswordDLL}';
      #else
      Password := GetSHA1OfUnicodeString(GetSHA1OfFile(ExpandConstant('{srcexe}')));
      #endif
      try
      #if VER >= 0x06000000
        ErrorCode := FreeArcExtract(CreateCallback(@FreeArcCallback), 'x', '-o-', '-dp' + AnsiToUtf8(ExpandConstant('{tmp}')), '-p' + AnsiToUtf8(Password), '-w' + AnsiToUtf8(ExpandConstant('{tmp}')), '--', AnsiToUtf8(FileName), AnsiToUtf8(UnpFile), '', '');
      #elif defined(IS_ENHANCED)
        ErrorCode := FreeArcExtract(CallbackAddr('FreeArcCallback'), 'x', '-o-', '-dp' + AnsiToUtf8(ExpandConstant('{tmp}')), '-p' + AnsiToUtf8(Password), '-w' + AnsiToUtf8(ExpandConstant('{tmp}')), '--', AnsiToUtf8(FileName), AnsiToUtf8(UnpFile), '', '');
      #else
        ExtractTemporaryFileEx('IsDone.dll')
        ErrorCode := FreeArcExtract(WrapFreeArcCallback(@FreeArcCallback, 4), 'x', '-o-', '-dp' + AnsiToUtf8(ExpandConstant('{tmp}')), '-p' + AnsiToUtf8(Password), '-w' + AnsiToUtf8(ExpandConstant('{tmp}')), '--', AnsiToUtf8(FileName), AnsiToUtf8(UnpFile), '', '');
      #endif
      finally
        Result := ErrorCode = 0;
        //UnloadDLL(ExpandConstant('{tmp}\UnArc.dll')); { error }
      end;
    end else
      if FileExists(ExpandArcFile(GetIniString('Record' + IntToStr(1), 'Source', '{src}\Data1.bin.001', ExpandConstant('{tmp}\Records.ini')), ExpandConstant('{src}'))) then
        MessageBox(WizardForm.Handle, 'The required ' + ChangeFileExt(ExtractFileName(ExpandConstant('{srcexe}')), '.dll') + ' file was not found.' #13#10 + 'Add the ' + ChangeFileExt(ExtractFileName(ExpandConstant('{srcexe}')), '.dll') + ' file next to this executable and try again.', SetupMessage(msgSetupAppTitle), MB_ICONERROR or MB_OK or MB_TASKMODAL);
  end;
end;

const
  HASH_AUTO          = 0;
  HASH_CRC32         = 1;
  HASH_MD5           = 2;
  HASH_SHA1          = 3;
  HASH_SHA256        = 4;
  HASH_SHA512        = 5;
  { not supported by auto mode }
  HASH_SHA512_256    = 6;
  HASH_SHA3_256      = 7;
  HASH_SHA3_512      = 8;
  HASH_BLAKE2_128    = 9;
  HASH_BLAKE2_256    = 10;
  HASH_BLAKE3_256    = 11;
  HASH_HAVAL3_128    = 12;
  HASH_HAVAL3_256    = 13;
  HASH_RIPEMD_128    = 14;
  HASH_RIPEMD_256    = 15;
  HASH_TIGER_128     = 16;
  HASH_TIGER_192     = 17;
  HASH_TIGER2_128    = 18;
  HASH_TIGER2_192    = 19;
  HASH_MURMURHASH_32 = 20;
  HASH_XXHASH_32     = 21;

type
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
    Algorithm: Integer;
    PctOfTotal: Double;
  end;

var
  Arcs: TArcFiles;
  HashFileList: THashFileList;

function GetHashAlgorithm(Value: String): Integer;
begin
  Result := HASH_AUTO;
  case LowerCase(Value) of
    'auto'          : Result := HASH_AUTO;
    'crc32'         : Result := HASH_CRC32;
    'md5'           : Result := HASH_MD5;
    'sha1'          : Result := HASH_SHA1;
    'sha256'        : Result := HASH_SHA256;
    'sha512'        : Result := HASH_SHA512;
    { not supported by auto mode }
    'sha512_256'    : Result := HASH_SHA512_256;
    'sha3_256'      : Result := HASH_SHA3_256;
    'sha3_512'      : Result := HASH_SHA3_512;
    'blake2_128'    : Result := HASH_BLAKE2_128;
    'Blake2_256'    : Result := HASH_BLAKE2_256;
    'blake3_256'    : Result := HASH_BLAKE3_256;
    'haval3_128'    : Result := HASH_HAVAL3_128;
    'haval3_256'    : Result := HASH_HAVAL3_256;
    'ripemd_128'    : Result := HASH_RIPEMD_128;
    'ripemd_256'    : Result := HASH_RIPEMD_256;
    'tiger_128'     : Result := HASH_TIGER_128;
    'tiger-192'     : Result := HASH_TIGER_192;
    'tiger2_128'    : Result := HASH_TIGER2_128;
    'tiger2_192'    : Result := HASH_TIGER2_192;
    'murmurhash_32' : Result := HASH_MURMURHASH_32;
    'xxhash_32'     : Result := HASH_XXHASH_32;
    else
      case StrToIntDef(Value, (-1)) of
        0..21 : Result := StrToInt(Value);
      end;
  end;
end;

function ConvertDataType(sType: String): TArcType;
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

#ifdef CreateUninstallList
function CreateUninstallFilesList(const FileList: String): Boolean;
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
    S1 := StrList.Text;
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
    S2 := DstList.Text;
    if DstList.Count > 0 then
      SaveStringsToUTF8File(ExpandConstant('{tmp}\Uninstall.dat'), [DstList.Text], False);
  finally
    DstList.Free;
    StrList.Free;
  end;
  Result := FileExists(ExpandConstant('{tmp}\Uninstall.dat'));
end;
#endif

function IsWindows11OrHigher(): Boolean;
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

function IsWindows10OrHigher(): Boolean;
var
  dwMajor: DWORD;
begin
  Result := RegQueryDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows NT\CurrentVersion', 'CurrentMajorVersionNumber', dwMajor) and (dwMajor >= 10);
end;

function CreateUnpackFileList(): Integer;
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
  WizardForm.ProgressGauge.Max := 1000;
  WizardForm.ProgressGauge.Position := 0;
  if not IsWindows10OrHigher() then
  begin
    WinTenOrNewer := Trim(GetIniString('InstallerSettings', 'WinTenOrNewer', '', ExpandConstant('{tmp}\Records.ini')));
    if (WinTenOrNewer <> '') and (MessageBox(WizardForm.Handle, 'The method' + IfThen(Pos(', ', WinTenOrNewer) > 0, 's', '') + ' used during compression cannot be decompressed on Windows systems prior to Windows 10.' + #13#10 + #13#10 + 'Methods:' + #13#10 + WinTenOrNewer + #13#10 + #13#10 + 'Would you like to try to decompress anyway?', SetupMessage(msgSetupAppTitle), MB_ICONERROR or MB_YESNO or MB_TASKMODAL) <> IDYES) then
    begin
      UnpackCanceled := True;
      Exit;
    end;
  end;
  if IsWindows11OrHigher() then
  begin
    FailWinEleven := Trim(GetIniString('InstallerSettings', 'FailWinEleven', '', ExpandConstant('{tmp}\Records.ini')));
    if (FailWinEleven <> '') and (MessageBox(WizardForm.Handle, 'The method' + IfThen(Pos(', ', FailWinEleven) > 0, 's', '') + ' used during compression does not support being decompressed in Windows 11.' + #13#10 + #13#10 + 'Methods:' + #13#10 + FailWinEleven + #13#10 + #13#10 + 'Would you like to try to decompress anyway?', SetupMessage(msgSetupAppTitle), MB_ICONERROR or MB_YESNO or MB_TASKMODAL) <> IDYES) then
    begin
      UnpackCanceled := True;
      Exit;
    end;
  end;
  if FileExists(ExpandConstant('{tmp}\Records.ini')) and ExtractTemporaryFileEx('SplitLib.dll') then
  begin
    X := 1;
    while GetIniString('Record' + IntToStr(X), 'Type', '', ExpandConstant('{tmp}\Records.ini')) <> '' do
    begin
      AType := ConvertDataType(GetIniString('Record' + IntToStr(X), 'Type', '', ExpandConstant('{tmp}\Records.ini')));
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
              Arcs[I].Source := IfThen(ExtractFileDrive(ExpandConstant(Arcs[I].Source)) = '', '{src}\', '') + Arcs[I].Source;
              Arcs[I].Output := GetIniString('Record' + IntToStr(X), 'Output', '', ExpandConstant('{tmp}\Records.ini'));
              Arcs[I].Output := IfThen(Arcs[I].Output = '', '{app}', Arcs[I].Output);
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
                  FileName := ExpandConstant(Arcs[I].Source);
                  BasePath := ExpandConstant(Arcs[I].Output);
                  AppDirFile := Pos(LowerCase(ExpandConstant('{app}\')), LowerCase(FileName)) > 0;
                  Algorithm := GetHashAlgorithm(Trim(GetIniString('Record' + IntToStr(X), 'Size', 'auto', ExpandConstant('{tmp}\Records.ini'))));
                end;
                SetArrayLength(ASize, I);
                SetArrayLength(Arcs, I);
              end else
              begin
                Arcs[I].Section  := '[' + 'Record' + IntToStr(X) + ']';
                Arcs[I].SizeEx   := GetSizeBytes(GetIniString('Record' + IntToStr(X), 'Size', '', ExpandConstant('{tmp}\Records.ini')), 0);
                Arcs[I].Disk     := GetIniString('Record' + IntToStr(X), 'Disk', '', ExpandConstant('{tmp}\Records.ini'));
                Arcs[I].Password := GetIniString('Record' + IntToStr(X), 'Password', '', ExpandConstant('{tmp}\Records.ini'));

                if Arcs[I].AType <> tpDelta then
                  Arcs[I].SubDir := IfThen(Pos('}\', AddBackslash(Arcs[I].Output)) > 0, Copy(Arcs[I].Output, Pos('}\', AddBackslash(Arcs[I].Output)) + 2, Length(Arcs[I].Output)), Arcs[I].Output)
                else
                  Arcs[I].SubDir := IfThen(Pos('}\', AddBackslash(ExtractFilePath(Arcs[I].Source))) > 0, Copy(ExtractFilePath(Arcs[I].Source), Pos('}\', AddBackslash(ExtractFilePath(Arcs[I].Source))) + 2, Length(ExtractFilePath(Arcs[I].Source))), ExtractFilePath(Arcs[I].Source));

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
                      Arcs[I].SizeEx := PowerK(1000, POWER_MB);
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
                            Arcs[Y].SizeEx := PowerK(100, POWER_MB);                { set default 100 MB value }

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
        Arcs[I].Output := ExpandFileName(ExpandConstant(Arcs[I].Output));
      StringChangeEx(Arcs[I].Source, '\\', '\', True);
      StringChangeEx(Arcs[I].Output, '\\', '\', True);
      for Y := 0 to GetArrayLength(ASize[I]) - 1 do
        Arcs[I].Slices := FloatToString(ASize[I][Y], 0) + IfThen(Y = 0, '', ',' + Arcs[I].Slices); { create line with all size }
    end;
    SetArrayLength(ASize, 0);
    #ifdef CreateUninstallList
    if (GetArrayLength(Arcs) > 0) and FileExists(ExpandConstant('{tmp}\UninstallList.ini')) then
      CreateUninstallFilesList(ExpandConstant('{tmp}\UninstallList.ini'));
    #endif
  end;
  Result := GetArrayLength(Arcs);
end;

procedure Unpack_Process(OptimalMode: Boolean);
var
  I, Y: Integer;
  ArcPct: Double;
  LastFile: String;
  SourceDir: String;
  CurrArcFile: String;
  ResultCode: Integer;
  Threads: Integer;
  PatchList: TArrayOfString;
  DiffFile: String;
  InFile: String;
  OutFile: String;
  FileList: String;
  CurrItem: String;
  hFind: Longint;
begin
  ISDoneCancel := 0;
  UnpackCanceled := False;
  WizardForm.FileNameLabel.Caption := '';
  WizardForm.FileNameLabel.Refresh;
  if ExtractTemporaryFileEx('SplitLib.dll') then
  begin
    hFind := pFindFilesEx(ExpandConstant('{tmp}'), '', '', '', ffrkRelative, True, True, True, False, False);
    try
      FileList := pPickFileList(hFind) + pPickDirList(hFind) + 'IsDone.dll' + #13#10 + 'UnArc.dll' + #13#10 + 'UnArcLib.dll' + #13#10 + 'CLS-DISKSPAN.dll';
    finally
      pFindFree(hFind);
    end;
  end;
  ISDoneError := (not UnpackDLLFiles('')) or ((not FileCopy(ExpandConstant('{src}\Records.ini'), ExpandConstant('{tmp}\Records.ini'), False)) and (not FileExists(ExpandConstant('{tmp}\Records.ini')))) or (CreateUnpackFileList() = 0);
  if not ISDoneError then
  begin
    RenameINIFiles(OptimalMode);
    //UnloadDLL(ExpandConstant('{tmp}\UnArc.dll'));  { error }
    //UnloadDLL(ExpandConstant('{tmp}\ISDone.dll')); { error }
    FileCopy(ExpandConstant('{tmp}\UnArcLib.dll'), ExpandConstant('{tmp}\UnArc.dll'), True);
    FileCopy(ExpandConstant('{src}\Records.ini'), ExpandConstant('{tmp}\Records.ini'), False);
  end;
  if (not ISDoneError) and FileExists(ExpandConstant('{tmp}\UnArc.dll')) and ExtractTemporaryFileEx('ISDone.dll')
  and ISDoneInit(ExpandConstant('{tmp}\Records.inf'), $F777, 0,0,0, MainForm.Handle, 0, @ProgressCallback) then
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
      Threads := GetCPUThreads;
      if not IsIniSectionEmpty('Afr', ExpandConstant('{tmp}\CLS.ini')) then
        SetIniString('Afr', 'Threads', IntToStr(Threads), ExpandConstant('{tmp}\CLS.ini'));
      if not IsIniSectionEmpty('Afr_019', ExpandConstant('{tmp}\CLS.ini')) then
        SetIniString('Afr_019', 'Threads', IntToStr(Threads), ExpandConstant('{tmp}\CLS.ini'));
    end;
    { SREP }
    if FileExists(ExpandConstant('{tmp}\CLS-SREP.dll')) and (not IsIniSectionEmpty('Srep', ExpandConstant('{tmp}\CLS.ini'))) then
      SetIniString('Srep', 'TempPath', ExpandConstant('{app}'), ExpandConstant('{tmp}\CLS.ini'));
    if FileExists(ExpandConstant('{tmp}\CLS-SREP_NEW.dll')) and (not IsIniSectionEmpty('Srep_NEW', ExpandConstant('{tmp}\CLS.ini'))) then
      SetIniString('Srep_NEW', 'TempPath', ExpandConstant('{app}'), ExpandConstant('{tmp}\CLS.ini'));
    if FileExists(ExpandConstant('{tmp}\CLS-SREP_OLD.dll')) and (not IsIniSectionEmpty('Srep_OLD', ExpandConstant('{tmp}\CLS.ini'))) then
      SetIniString('Srep_OLD', 'TempPath', ExpandConstant('{app}'), ExpandConstant('{tmp}\CLS.ini'));
    { LOLZ }
    if FileExists(ExpandConstant('{tmp}\CLS-LOLZ.dll')) and (not IsIniSectionEmpty('LOLZ', ExpandConstant('{tmp}\CLS.ini'))) then
      SetIniString('LOLZ', 'ldmfTempPath', ExpandConstant('{app}'), ExpandConstant('{tmp}\CLS.ini'));
    { MPZMT }
    if FileExists(ExpandConstant('{tmp}\CLS-MPZMT.dll')) and (not IsIniSectionEmpty('MPZMT', ExpandConstant('{tmp}\CLS.ini'))) then
      SetIniString('MPZMT', 'Temp', ExpandConstant('{app}'), ExpandConstant('{tmp}\CLS.ini'));
    { DiskSpan R3 Modified }
    ClsLibInit := False;
    SourceDir := ExpandConstant('{src}');
    if FileExists(ExpandConstant('{tmp}\CLS-DISKSPAN.dll')) then
    begin
      try
        ClsLibInit := DiskSpanInit(WizardForm.Handle, SourceDir, nil, @DiskSpanCallback);
        SetMessageText(CustomMessage('ChangeDiskLabel'), SetupMessage(msgChangeDiskTitle));
      except
        MessageBox(WizardForm.Handle, 'Incompatible version of the "CLS-DiskSpan.dll" library.', SetupMessage(msgSetupAppTitle), MB_ICONERROR or MB_OK or MB_TASKMODAL);
        WizardForm.StatusLabel.Caption := '';
        WizardForm.FileNameLabel.Caption := '';
        ISDoneError := True;
        ISDoneStop;
        Exit;
      end;
    end;
    repeat
      if not FileSearchInit(True) then
        ISDoneError := True;
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
      CancelButton.Enabled := True;
      ForceDirectories(ExpandConstant('{app}\'));
      for I := 0 to GetArrayLength(Arcs) - 1 do
      begin
        ArcPct := ArcPct + (Arcs[I].Pct * 10);
        WizardForm.StatusLabel.Caption := IfThen((Arcs[I].AType = tpSplit) or (Arcs[I].AType = tpDelta), '', SetupMessage(msgStatusExtractFiles));
        case Arcs[I].AType of
          tsArc, tmArc :
            begin
              CurrArcFile := BrowseArcFile(Arcs[I].Source, Arcs[I].Disk, SourceDir);
              if (not ISDoneError) and (not ISArcExtract(0, Arcs[I].Pct, CurrArcFile, Arcs[I].Output, '', Arcs[I].AType = tmArc, Arcs[I].Password, ExpandConstant('{tmp}\Arc.ini'), Arcs[I].Output, False)) then
                ISDoneError := True;
            end;
          tsZip, tmZip :
            begin
              CurrArcFile := BrowseArcFile(Arcs[I].Source, Arcs[I].Disk, SourceDir);
              if (not ISDoneError) and (not IS7ZipExtract(0, Arcs[I].Pct, CurrArcFile, Arcs[I].Output, Arcs[I].AType = tmZip, Arcs[I].Password)) then
                ISDoneError := True;
            end;
          tsRar, tmRar :
            begin
              CurrArcFile := BrowseArcFile(Arcs[I].Source, Arcs[I].Disk, SourceDir);
              if (not ISDoneError) and (not ISRarExtract(0, Arcs[I].Pct, CurrArcFile, Arcs[I].Output, Arcs[I].AType = tmRar, Arcs[I].Password)) then
                ISDoneError := True;
            end;
          tpSplit :
            begin
              CurrArcFile := BrowseArcFile(Arcs[I].Source, Arcs[I].Disk, SourceDir);
              SplitBuffer(Round(PowerK(256, POWER_KB)), Round(Arcs[I].SizeEx / PowerK(100, POWER_KB)));
              if (not ISDoneError) and (not MergeDataFile(CurrArcFile, Arcs[I].Output, Arcs[I].Slices, 0, WizardForm.ProgressGauge.Position, Round(Arcs[I].Pct * 1000), CompareText(LastFile, Arcs[I].Output) <> 0, @MergeFileCallback)) then
                ISDoneError := True;
              WizardForm.ProgressGauge.Position := Round(ArcPct);
              SplitPct := SplitPct + (Arcs[I].Pct * 10);
            end;
          tpDelta :
            begin
              if ((Pos('*', ExtractFileName(Arcs[I].Source))) > 0) and (Pos('*', ExtractFileName(Arcs[I].Output)) > 0) then
              begin
                hFind := pFindFiles(ExtractFilePath(ExpandConstant(Arcs[I].Source)), ExtractFileName(Arcs[I].Source), '', ffrkRelative, True, False);
                try
                  SetArrayLength(PatchList, pFileCount(hFind));
                  for Y := 0 to pFileCount(hFind) - 1 do
                    PatchList[Y] := pPickFile(hFind, Y);
                finally
                  pFindFree(hFind);
                end;
              end else
              begin
                SetArrayLength(PatchList, 1);
                PatchList[0] := ExtractRelativePath(ExtractFilePath(ExpandConstant(Arcs[I].Source)), ExpandConstant(Arcs[I].Source));
              end;
              if GetArrayLength(PatchList) > 0 then
              begin
                for Y := 0 to GetArrayLength(PatchList) - 1 do
                begin
                  DiffFile := ExtractFilePath(ExpandConstant(Arcs[I].Source)) + PatchList[Y];
                  InFile := ExtractFilePath(Arcs[I].Output) + ChangeFileExt(PatchList[Y], '');
                  OutFile := IfThen(ExtractFileExt(Arcs[I].Output) = '', InFile, ChangeFileExt(InFile, ExtractFileExt(Arcs[I].Output)));
                  if not ForceDirectories(ExtractFilePath(OutFile)) then
                  begin
                    ISDoneError := True;
                    Break;
                  end;
                  if CompareText(InFile, OutFile + '.patched') = 0 then
                  begin
                    if not MoveFileEx(InFile, InFile + '.tmp', MOVEFILE_REPLACE_EXISTING or MOVEFILE_WRITE_THROUGH or MOVEFILE_COPY_ALLOWED) then
                    begin
                      ISDoneError := True;
                      Break;
                    end else
                      InFile := InFile + '.tmp';
                  end;
                  if not ISxDeltaExtract(0, Arcs[I].Pct / GetArrayLength(PatchList), 0, IfThen(OptimalMode, 1024, 640), InFile, DiffFile, OutFile + '.patched', True, True) then
                  begin
                    ISDoneError := True;
                    Break;
                  end else
                    MoveFileEx(OutFile + '.patched', OutFile, MOVEFILE_REPLACE_EXISTING or MOVEFILE_WRITE_THROUGH or MOVEFILE_COPY_ALLOWED);
                end;
              end else
                SplitPct := SplitPct + Arcs[I].Pct;
            end;
          tpExec :
            begin
              ShellExec('open', ExpandConstant(Arcs[I].Source), ExpandConstant(Arcs[I].Output), '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
            end;
        end;
        LastFile := Arcs[I].Output;
        if ISDoneError then
          Break;
      end;
    until True;
    ISDoneStop;
    CancelButton.Enabled := False;
    if not ISDoneError then
      WizardForm.ProgressGauge.Position := 1000;
    WizardForm.StatusLabel.Caption := '';
    WizardForm.FileNameLabel.Caption := '';
    StringChangeEx(FileList, #13#10, '|', True);
    hFind := pFindFilesEx(ExpandConstant('{tmp}'), '', '', FileList, ffrkFull, True, True, True, False, False);
    try
      FileList := pPickFileList(hFind);
      for Y := 0 to pFileCount(hFind) - 1 do
      begin
        CurrItem := pPickFile(hFind, Y);
        if LowerCase(ExtractFileExt(CurrItem)) = '.exe' then
        begin
          CloseProcess(CurrItem);
          DeleteFile(CurrItem);
        end;
      end;
      (*
      for Y := 0 to pFileCount(hFind) - 1 do
      begin
        CurrItem := pPickFile(hFind, Y);
        if LowerCase(ExtractFileExt(CurrItem)) = '.dll' then
        begin
          while FreeLibrary(GetModuleHandle(CurrItem)) do {LOOP} ;
          UnloadDLL(CurrItem); { error }
        end;
        DeleteFile(CurrItem);
      end;
      *)
      for Y := 0 to pDirCount(hFind) - 1 do
      begin
        CurrItem := pPickDir(hFind, Y);
        DelTree(CurrItem, True, True, True);
      end;
    finally
      pFindFree(hFind);
    end;
  end;
end;

#ifdef HashPage /* Thanks BLACKFIRE69 for library */
//---------------------------------------------------------------------------------
// XHashEx.dll - Header
// Created by BLACKFIRE69
// Version:  v1.0
// Last Updated:  2023-July-29
//---------------------------------------------------------------------------------
const
  H_CRC32         = 1;
  H_MD5           = 2;
  H_SHA1          = 3;
  H_SHA256        = 4;
  H_SHA512        = 5;
  H_SHA512_256    = 6;
  H_SHA3_256      = 7;
  H_SHA3_512      = 8;
  H_BLAKE2_128    = 9;
  H_BLAKE2_256    = 10;
  H_BLAKE3_256    = 11;
  H_HAVAL3_128    = 12;
  H_HAVAL3_256    = 13;
  H_RIPEMD_128    = 14;
  H_RIPEMD_256    = 15;
  H_TIGER_128     = 16;
  H_TIGER_192     = 17;
  H_TIGER2_128    = 18;
  H_TIGER2_192    = 19;
  H_MURMURHASH_32 = 20;
  H_XXHASH_32     = 21;

  H_HASH_OK                 = 0;
  H_HASHES_IN_PROGRESS      = 1;
  H_FILE_HASHING_DONE       = 2;
  H_PROCESS_DONE            = 3;
  H_PROCESS_ABORTED         = -1;
  H_BAD_FILE_HASH           = -2;
  H_FILE_NOT_FOUND          = -3;
  H_INVALID_HASH_ALGORITHM  = -4;
  H_ERROR_GENERAL           = -5;
  H_INTERNAL_ERROR          = -6;
  H_HASH_GENERATE_ERROR     = -7;
  H_INVALID_HASHHEX         = -8;
  H_INVALID_CHECKSUM_FILE   = -9;
  H_INVALID_DIRECTORY       = -10;
  H_HASH_VERIFY_ERROR       = -11;
  H_CANNOT_CREATE_HASH_FILE = -12;
  H_EMPTY_DIRECTORY         = -13;
  H_INPUT_FILE_NOT_FOUND    = -14;
  H_CANNOT_CREATE_LOG_FILE  = -15;

  H_LOGMSG_ID_EXPECTEDHASH    = 100;
  H_LOGMSG_ID_CALCULATEDHASH  = 200;
  H_LOGMSG_ID_STATUS          = 300;
  H_LOGMSG_ID_FILENOTFOUND    = 400;
  H_LOGMSG_ID_BADHASH         = 500;
  H_LOGMSG_ID_HASHOK          = 600;
  H_LOGMSG_ID_NULL            = 700;

//  XH_FILENAME               = '%s';
//  XH_FILEPOSITION           = '%s / %s';
//  XH_PERCENTAGE             = '%d%%';
//  XH_VERIFYSTATUS           = '%d / %d  Ok:  %d  Bad:  %d  Missing:  %d';
//  XH_GENERATESTATUS         = '%d / %d';

type
  THashStatus = (hsRuning, hsPaused);
  //TSingleFileHashCallback = function(FileName: WideString; FileSize: Extended; FileProgress, StatusCode: Integer): Boolean;
  TMultiHashCallback = function(FileName: WideString; FileSize: Extended; FileProgress, TotalProgress, TotalFiles, FileCounted, StatusCode: Integer): Boolean;

//function CalculateHashesForDir(ChecksumFile, BasePath: WideString; HashAlgo: Integer; Callback: TMultiHashCallback): Integer;
//  external 'CalculateHashesForDir@{tmp}\XHashEx.dll stdcall delayload'; // Return codes: H_PROCESS_DONE, H_HASH_GENERATE_ERROR, H_INVALID_DIRECTORY, H_PROCESS_ABORTED, H_FILE_NOT_FOUND, H_INTERNAL_ERROR, H_CANNOT_CREATE_HASH_FILE, H_EMPTY_DIRECTORY

//function CalculateHashesForDirEx(ChecksumFile, BasePath, IncludeFiles, ExcludeFiles: WideString; HidePathInCallback, UsePreviousHashCache: Boolean; HashAlgo: Integer; Callback: TMultiHashCallback): Integer;
//  external 'CalculateHashesForDirEx@{tmp}\XHashEx.dll stdcall delayload'; // Return codes: H_PROCESS_DONE, H_HASH_GENERATE_ERROR, H_INVALID_DIRECTORY, H_PROCESS_ABORTED, H_FILE_NOT_FOUND, H_INTERNAL_ERROR, H_CANNOT_CREATE_HASH_FILE, H_EMPTY_DIRECTORY
(*
  The "IncludeFiles" parameter must not contain directories. Should only contain file extensions.
  IncludeFiles: '*.*' or '*.bin|*.dat|*.arc|*.dll' or 'images\png\*|game*info.*|20??_cfg.ini'
  ExcludeFiles: '*.bckp' or 'Trainer.exe|uninst???.exe|uninst???.dat' or 'Bin\*.*|Web\Help\*.*|patch.exe' or 'Documents\ReadMe - *.txt|Languages\English???_*.lng'
*)

//function VerifyHashesFromFile(ChecksumFile, BasePath: WideString; HashAlgo, PreviousFileCount: Integer; LogFile: Boolean; Callback: TMultiHashCallback): Integer;
//  external 'VerifyHashesFromFile@{tmp}\XHashEx.dll stdcall delayload'; // Return codes: H_PROCESS_DONE, H_HASH_VERIFY_ERROR, H_INVALID_CHECKSUM_FILE, H_INVALID_HASH_ALGORITHM, H_PROCESS_ABORTED, H_FILE_NOT_FOUND, H_INTERNAL_ERROR, H_CANNOT_CREATE_LOG_FILE

function VerifyHashesFromFileEx(ChecksumFile, BasePath: WideString; HashAlgo, PreviousFileCount: Integer; HidePathInCallback, LogFile: Boolean; Callback: TMultiHashCallback): Integer;
  external 'VerifyHashesFromFileEx@{tmp}\XHashEx.dll stdcall delayload'; // Return codes: H_PROCESS_DONE, H_HASH_VERIFY_ERROR, H_INVALID_CHECKSUM_FILE, H_INVALID_HASH_ALGORITHM, H_PROCESS_ABORTED, H_FILE_NOT_FOUND, H_INTERNAL_ERROR, H_CANNOT_CREATE_LOG_FILE

//function VerifyHashesAutoFromFile(ChecksumFile, BasePath: WideString; PreviousFileCount: Integer; LogFile: Boolean; Callback: TMultiHashCallback): Integer; { For CRC32, MD5, SHA1, SHA256 and SHA512 only. }
//  external 'VerifyHashesAutoFromFile@{tmp}\XHashEx.dll stdcall delayload'; // Return codes: H_PROCESS_DONE, H_HASH_VERIFY_ERROR, H_INVALID_CHECKSUM_FILE, H_INVALID_HASHHEX, H_INVALID_HASH_ALGORITHM, H_PROCESS_ABORTED, H_FILE_NOT_FOUND, H_INTERNAL_ERROR, H_CANNOT_CREATE_LOG_FILE

function VerifyHashesAutoFromFileEx(ChecksumFile, BasePath: WideString; PreviousFileCount: Integer; HidePathInCallback, LogFile: Boolean; Callback: TMultiHashCallback): Integer;
  external 'VerifyHashesAutoFromFileEx@{tmp}\XHashEx.dll stdcall delayload'; // Return codes: H_PROCESS_DONE, H_HASH_VERIFY_ERROR, H_INVALID_CHECKSUM_FILE, H_INVALID_HASHHEX, H_INVALID_HASH_ALGORITHM, H_PROCESS_ABORTED, H_FILE_NOT_FOUND, H_INTERNAL_ERROR, H_CANNOT_CREATE_LOG_FILE

//function CalculateFileHash(const FileName: WideString; const HashAlgo: Integer; Callback: TSingleFileHashCallback): WideString;
//  external 'CalculateFileHash@{tmp}\XHashEx.dll stdcall delayload';

//function VerifyFileHash(FileName, HashHexStr: WideString; HashAlgo: Integer; LogFile: Boolean; Callback: TSingleFileHashCallback): Integer;
//  external 'VerifyFileHash@{tmp}\XHashEx.dll stdcall delayload'; // Return codes: H_HASH_OK, H_BAD_FILE_HASH, H_FILE_NOT_FOUND, H_CANNOT_CREATE_LOG_FILE

function SetHashLogMsg(const MessageText: WideString; const MsgID: Integer): Boolean;
  external 'SetHashLogMsg@{tmp}\XHashEx.dll stdcall delayload';

procedure SetHashLogFile(const FileName: WideString);
  external 'SetHashLogFile@{tmp}\XHashEx.dll stdcall delayload';

procedure StopHashProcess();
  external 'StopHashProcess@{tmp}\XHashEx.dll stdcall delayload';

procedure PauseHashProcess();
  external 'PauseHashProcess@{tmp}\XHashEx.dll stdcall delayload';

procedure ResumeHashProcess();
  external 'ResumeHashProcess@{tmp}\XHashEx.dll stdcall delayload';

procedure HashLogClear();
  external 'HashLogClear@{tmp}\XHashEx.dll stdcall delayload';

function GetHashLogString(ClearLog: Boolean): WideString;
  external 'GetHashLogString@{tmp}\XHashEx.dll stdcall delayload';

//procedure CalculatedHashClear();
//  external 'CalculatedHashClear@{tmp}\XHashEx.dll stdcall delayload';

//function GetCalculatedHashString(ClearHash: Boolean): WideString;
//  external 'GetCalculatedHashString@{tmp}\XHashEx.dll stdcall delayload';

function GetHashStatus(): THashStatus;
  external 'GetHashStatus@{tmp}\XHashEx.dll stdcall delayload';

procedure SetHashMaxProgress(const MaxTotalProgress, MaxFileProgress: Integer);
  external 'SetHashMaxProgress@{tmp}\XHashEx.dll stdcall delayload';

//procedure HashCommentDefault(HideComments: Boolean);
//  external 'HashCommentDefault@{tmp}\XHashEx.dll stdcall delayload';

//procedure HashCommentClear(AddDefaultComment: Boolean);
//  external 'HashCommentClear@{tmp}\XHashEx.dll stdcall delayload';

//procedure HashCommentAdd(CommentStr: WideString; InNewLine: Boolean);
//  external 'HashCommentAdd@{tmp}\XHashEx.dll stdcall delayload';

function GetPreviouslyVerifiedFileCount(ClearCount, ClearBefore: Boolean): Integer;
  external 'GetPreviouslyVerifiedFileCount@{tmp}\XHashEx.dll stdcall delayload';

//function ByteOrTb(const Float: Extended): WideString;
//  external 'ByteOrTb@{tmp}\XHashEx.dll stdcall delayload';

//procedure ProcessMessages();
//  external 'ProcessMessages@{tmp}\XHashEx.dll stdcall delayload';

//function pFindFiles(const FindPath, FileMasks, ExcludeMasks: WideString; ResultKind: TFFResultKind; Recursive, FindDirs: Boolean): Longint;
//  external 'pFindFiles@{tmp}\XHashEx.dll stdcall delayload';

//function pFindFilesEx(const FindPath, FileMasks, ExcludeMasks: WideString; ResultKind: TFFResultKind; Recursive, HiddenFiles, SystemFiles, FindDirs: Boolean): Longint;
//  external 'pFindFilesEx@{tmp}\XHashEx.dll stdcall delayload';

//function pFileCount(const FindHandle: Longint): Integer;
//  external 'pFileCount@{tmp}\XHashEx.dll stdcall delayload';

//function pPickFile(const FindHandle: Longint; const Index: Integer): WideString;
//  external 'pPickFile@{tmp}\XHashEx.dll stdcall delayload';;

//function pPickSize(const FindHandle: Longint; const Index: Integer): WideString;
//  external 'pPickSize@{tmp}\XHashEx.dll stdcall delayload';

//function pPickAttrib(const FindHandle: Longint; const Index: Integer): Integer;
//  external 'pPickAttrib@{tmp}\XHashEx.dll stdcall delayload';

//function pDirCount(const FindHandle: Longint): Integer;
//  external 'pDirCount@{tmp}\XHashEx.dll stdcall delayload';

//function pPickDir(const FindHandle: Longint; const Index: Integer): WideString;
//  external 'pPickDir@{tmp}\XHashEx.dll stdcall delayload';

//function pFindFree(const FindHandle: Longint): Boolean;
//  external 'pFindFree@{tmp}\XHashEx.dll stdcall delayload';

//---------------------------------------------------------------------------------
const
  WM_VSCROLL = $115;
  SB_BOTTOM  = 7;

  HASH_WAITING  = 0;
  HASH_STARTED  = 1;
  HASH_FINISHED = 2;
  HASH_ABORTED  = 4;

var
  HashOk: Integer;
  HashBad: Integer;
  HashMissing: Integer;
  HashListItem: Integer;
  HashTotalFiles: Integer;
  HashPrevProgress: Integer;
  HashPaused: Boolean;
  HashCancel: Boolean;
  HashAborted: Boolean;
  HashStarted: Boolean;
  HashShowLog: Boolean;

function ShellExecute(hWnd: HWND; lpOperation, lpFile, lpParameters, lpDirectory: String; nShowCmd: Integer): THandle;
  external 'ShellExecuteW@shell32.dll stdcall delayload';

procedure MergeHashFile(lpSrcFile, lpDstFile: String);
var
  ResultCode: Integer;
begin
  if FileExists(lpDstFile) then
  begin
    if (not ShellExec('open', ExpandConstant('{cmd}'), '/C COPY /B "' + lpDstFile + '" + "' + lpSrcFile + '" "' + lpDstFile + '"', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)) or (ResultCode <> 0) then
      ShellExecute(0, 'open', AddQuotes(ExpandConstant('{cmd}')), AddQuotes('/C COPY /B "' + lpDstFile + '" + "' + lpSrcFile + '" "' + lpDstFile + '"'), '', SW_HIDE)
  end else
    if (not ShellExec('open', ExpandConstant('{cmd}'), '/C COPY /Y "' + lpSrcFile + '" "' + lpDstFile + '"', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)) or (ResultCode <> 0) then
      ShellExecute(0, 'open', AddQuotes(ExpandConstant('{cmd}')), AddQuotes('/C COPY /Y "' + lpSrcFile + '" "' + lpDstFile + '"'), '', SW_HIDE);
end;

procedure ParseHashFileList();
var
  I, Y: Integer;
  HashFile: String;
  FileList: TStringList;
  PathList: TStringList;
  AlgoList: TStringList;
begin
  if GetArrayLength(HashFileList) > 0 then
  begin
    FileList := TStringList.Create;
    PathList := TStringList.Create;
    AlgoList := TStringList.Create;
    try
      for I := 0 to GetArrayLength(HashFileList) - 1 do
      begin
        if HashFileList[I].AppDirFile then
        begin
          HashFile := HashFileList[I].FileName;
          HashFileList[I].FileName := GenerateUniqueName(ExpandConstant('{tmp}'), '.dat');
          if not FileCopy(HashFile, HashFileList[I].FileName, False) then
            Continue;
        end;
        if FileExists(HashFileList[I].FileName) then
        begin
          for Y := 0 to FileList.Count - 1 do
          begin
            if (CompareText(HashFileList[I].BasePath, PathList.Strings[Y]) = 0)
            and (CompareText(IntToStr(HashFileList[I].Algorithm), AlgoList.Strings[Y]) = 0) then
              Break;
          end;
          if Y = FileList.Count then
          begin
            Y := PathList.Add(HashFileList[I].BasePath);
            FileList.Add(GenerateUniqueName(ExpandConstant('{tmp}'), '.dat'));
            AlgoList.Add(IntToStr(HashFileList[I].Algorithm));
          end;
          MergeHashFile(HashFileList[I].FileName, FileList.Strings[Y]);
        end;
      end;
      SetArrayLength(HashFileList, FileList.Count);
      for I := 0 to FileList.Count - 1 do
      begin
        HashFileList[I].FileName := FileList.Strings[I];
        HashFileList[I].BasePath := PathList.Strings[I];
        HashFileList[I].Algorithm := StrToIntDef(AlgoList.Strings[I], 0);
      end;
    finally
      AlgoList.Free;
      PathList.Free;
      FileList.Free;
    end;
  end;
end;

function VerifyHashCallback(FileName: WideString; FileSize: Extended; FileProgress, TotalProgress, TotalFiles, FileCounted, StatusCode: Integer): Boolean;
begin
  case StatusCode of
    H_HASH_OK:
      begin
        HashInfoMemo.Lines.Add(FileName + ' ... ' + ExpandConstant('{cm:HashOk}'));
        Inc(HashOk);
      end;
    H_BAD_FILE_HASH:
      begin
        HashInfoMemo.Lines.Add(FileName + ' ... ' + ExpandConstant('{cm:HashBadHash}'));
        Inc(HashBad);
      end;
    H_FILE_NOT_FOUND:
      begin
        HashInfoMemo.Lines.Add(FileName + ' ... ' + ExpandConstant('{cm:HashNotFound}'));
        Inc(HashMissing);
      end;
    H_ERROR_GENERAL :
      begin
        HashInfoMemo.Lines.Add(Filename + ' ... ' + ExpandConstant('{cm:HashGeneralError}'));
      end;
    H_INVALID_HASH_ALGORITHM :
      begin
        HashInfoMemo.Lines.Add(ExpandConstant('{cm:HashBadParam}'));
      end;
    H_PROCESS_ABORTED :
      begin

      end;
    H_INTERNAL_ERROR :
      begin

      end;
    H_HASH_GENERATE_ERROR :
      begin

      end;
    H_INVALID_HASHHEX :
      begin

      end;
    H_INVALID_CHECKSUM_FILE :
      begin

      end;
    H_INVALID_DIRECTORY :
      begin

      end;
    H_HASH_VERIFY_ERROR :
      begin

      end;
    H_CANNOT_CREATE_LOG_FILE :
      begin

      end;
  end;
  HashProgressGauge.Position := HashPrevProgress + Round(TotalProgress * HashFileList[HashListItem].PctOfTotal / 1000000);
  HashStatusLabel.Caption := FmtMessage(ExpandConstant('{cm:HashStatusLabel}'), [IntToStr(FileCounted), IntToStr(HashTotalFiles), IntToStr(FileProgress)]);
  HashResultLabel.Caption := FmtMessage(ExpandConstant('{cm:HashResultLabel}'), [IntToStr(HashOk), IntToStr(HashMissing), IntToStr(HashBad)]);
  HashPercentLabel.Caption := IntToStr(HashProgressGauge.Position div 10) + '.' + IntToStr(HashProgressGauge.Position mod 10) + '%';
//  SetTaskBarProgressValueMax(HashProgressGauge.Position, 1000);
//  if HashProgressGauge.Position = 0 then
//    SetTaskBarProgressState(TBPF_INDETERMINATE)
//  else
//    SetTaskBarProgressState(TBPF_NORMAL);
  ProcessMessages();
  Result := HashCancel;
end;

procedure NextBtnClick(Sender: TObject);
begin
  WizardForm.NextButton.OnClick(nil);
end;

procedure LogHashClick(Sender: TObject);
begin
  HashShowLog := not HashShowLog;
  if HashShowLog then
  begin
    HashBackButton.Caption := ExpandConstant('{cm:HashInfo}');
    HashLogMemo.Show;
    HashInfoMemo.Hide;
  end else
  begin
    HashBackButton.Caption := ExpandConstant('{cm:HashLog}');
    HashInfoMemo.Show;
    HashLogMemo.Hide;
  end;
end;

procedure PauseHashClick(Sender: TObject);
begin
  HashPaused := GetHashStatus() = hsRuning;
  if HashPaused then
  begin
    PauseHashProcess();
    HashNextButton.Caption := ExpandConstant('{cm:HashResume}');
  end else
  begin
    ResumeHashProcess();
    HashNextButton.Caption := ExpandConstant('{cm:HashPause}');
  end;
end;

procedure StopHashClick(Sender: TObject);
begin
  if HashPaused then
  begin
    HashPaused := False;
    ResumeHashProcess();
    HashNextButton.Caption := ExpandConstant('{cm:HashVerify}');
  end;
  HashCancel := True;
end;

procedure CancelHashClick(Sender: TObject);
begin
  if (not HashCancel) and (not HashPaused) then
  begin
    PauseHashProcess();
  end;
  if HashCancel or (MessageBox(WizardForm.Handle, SetupMessage(msgExitSetupMessage), SetupMessage(msgExitSetupTitle), MB_ICONINFORMATION or MB_YESNO) = IDYES) then
  begin
    if GetHashStatus() = hsPaused then
      ResumeHashProcess();
    HashNextButton.Caption := ExpandConstant('{cm:HashVerify}');
    StopHashProcess();
    HashPaused := False;
    HashAborted := True;
    WizardForm.NextButton.OnClick(nil);
  end else
    if (not HashCancel) and (not HashPaused) then
      ResumeHashProcess();
end;

procedure VerifyHashClick(Sender: TObject);
var
  I, Y: Integer;
  StrLine: String;
  HashResult: Integer;
  StrList: TStringList;
begin
  HashNextButton.Caption := ExpandConstant('{cm:HashPause}');
  HashBackButton.Caption := ExpandConstant('{cm:HashStop}');
  HashNextButton.OnClick := @PauseHashClick;
  HashBackButton.OnClick := @StopHashClick;
  HashInfoMemo.Clear;
  HashLogMemo.Clear;
  { checking... }
  HashOk := 0;
  HashBad := 0;
  HashMissing := 0;
  HashShowLog := False;
  HashPaused := False;
  HashCancel := False;
  HashAborted := False;
  HashStarted := True;
  HashProgressGauge.Max := 1000;
  HashProgressGauge.Position := 0;
  HashProgressGauge.State := npbsNormal;
  SetHashLogMsg(ExpandConstant('{cm:HashFileHash}'), H_LOGMSG_ID_EXPECTEDHASH);
  SetHashLogMsg(ExpandConstant('{cm:HashCalcHash}'), H_LOGMSG_ID_CALCULATEDHASH);
  SetHashLogMsg(ExpandConstant('{cm:HashHashStatus}'), H_LOGMSG_ID_STATUS);
  SetHashLogMsg(ExpandConstant('{cm:HashNoFile}'), H_LOGMSG_ID_FILENOTFOUND);
  SetHashLogMsg(ExpandConstant('{cm:HashNotMatched}'), H_LOGMSG_ID_BADHASH);
  SetHashLogMsg(ExpandConstant('{cm:HashMatched}'), H_LOGMSG_ID_HASHOK);
  SetHashLogMsg(ExpandConstant('{cm:HashNull}'), H_LOGMSG_ID_NULL);
  SetHashMaxProgress(1000, 100);
  if GetArrayLength(HashFileList) > 0 then
  begin
    HashLogClear();
    HashTotalFiles := 0;
    HashPrevProgress := 0;
    HashPercentLabel.Caption := '0.0 %'
    HashStatusLabel.Caption := FmtMessage(ExpandConstant('{cm:HashStatusLabel}'), ['0', '0', '0']);
    HashResultLabel.Caption := FmtMessage(ExpandConstant('{cm:HashResultLabel}'), [IntToStr(HashOk), IntToStr(HashMissing), IntToStr(HashBad)]);
    HashBackButton.Enabled := True;
    GetPreviouslyVerifiedFileCount(True, True);
    StrList := TStringList.Create;
    try
      for I := 0 to GetArrayLength(HashFileList) - 1 do
      begin
        StrList.Clear;
        StrList.LoadFromFile(HashFileList[I].FileName);
        for Y := StrList.Count - 1 downto 0 do
        begin
          StrLine := Trim(StrList.Strings[Y]);
          if (StrLine = '') or (Pos(';', StrLine) = 1)  or (Pos('#', StrLine) = 1) or (Pos('//', StrLine) = 1) or (Pos('\\', StrLine) = 1) then
            StrList.Delete(Y); { clear empty lines }
        end;
        HashTotalFiles := HashTotalFiles + StrList.Count;
        HashFileList[I].FilesCount := StrList.Count;
      end;
    finally
      StrList.Free;
    end;
    HashStatusLabel.Caption := FmtMessage(ExpandConstant('{cm:HashStatusLabel}'), ['0', IntToStr(HashTotalFiles), '0']);
    for I := 0 to GetArrayLength(HashFileList) - 1 do
    begin
      HashFileList[I].PctOfTotal := Double(HashFileList[I].FilesCount) * 1000000 / Double(HashTotalFiles);
    end;
    for HashListItem := 0 to GetArrayLength(HashFileList) - 1 do
    begin
      HashPrevProgress := HashProgressGauge.Position;
      if HashFileList[HashListItem].Algorithm > 0 then
        HashResult := VerifyHashesFromFileEx(HashFileList[HashListItem].FileName, HashFileList[HashListItem].BasePath, HashFileList[HashListItem].Algorithm, GetPreviouslyVerifiedFileCount(HashListItem = 0, True), True, False, @VerifyHashCallback)
      else
        HashResult := VerifyHashesAutoFromFileEx(HashFileList[HashListItem].FileName, HashFileList[HashListItem].BasePath, GetPreviouslyVerifiedFileCount(HashListItem = 0, True), True, False, @VerifyHashCallback);

      if HashResult = H_PROCESS_ABORTED then
        Break;
    end;
    HashResultLabel.Caption := FmtMessage(ExpandConstant('{cm:HashResultLabel}'), [IntToStr(HashOk), IntToStr(HashMissing), IntToStr(HashBad)]);
    HashLogMemo.Lines.Text := String(GetHashLogString(True));
    SendMessage(HashLogMemo.Handle, WM_VSCROLL, SB_BOTTOM, 0);
  end;
  if HashResult = H_PROCESS_ABORTED then
  begin
    HashNextButton.Caption := ExpandConstant('{cm:HashVerify}');
    HashBackButton.Caption := ExpandConstant('{cm:HashNext}');
    HashNextButton.OnClick := @VerifyHashClick;
    HashBackButton.OnClick := @NextBtnClick;
  end else
  begin
    HashNextButton.Caption := ExpandConstant('{cm:HashNext}');
    HashBackButton.Caption := ExpandConstant('{cm:HashLog}');
    HashNextButton.OnClick := @NextBtnClick;
    HashBackButton.OnClick := @LogHashClick;
    if HashBad > 0 then
      HashProgressGauge.State := npbsError
    else if HashMissing > 0 then
      HashProgressGauge.State := npbsPaused
    else
      HashProgressGauge.State := npbsNormal;
  end;
  ProcessMessages();
  if HashAborted then
    WizardForm.NextButton.OnClick(nil);
end;

procedure HashBackButtonOnClick(Sender: TObject);
begin
  HashNextButton.Caption := ExpandConstant('{cm:HashVerify}');
  WizardForm.NextButton.OnClick(nil);
end;

procedure InitializeWizard();
begin
  HashPage := CreateCustomPage(wpInfoAfter, ExpandConstant('{cm:HashPageTitle}'), ExpandConstant('{cm:HashPageDescription}'));

  HashInfoMemo := TNewMemo.Create(WizardForm);
  with HashInfoMemo do begin
    Parent     := HashPage.Surface;
    Left       := ScaleX(0);
    Top        := ScaleY(5);
    Width      := HashPage.SurfaceWidth - ScaleX(0);
    Height     := HashPage.SurfaceHeight - ScaleX(75);
    ScrollBars := ssBoth;
    #if VER >= 0x06000000
    Anchors := [akLeft, akTop, akRight, akBottom];
    #endif
  end;
  HashLogMemo := TNewMemo.Create(WizardForm);
  with HashLogMemo do begin
    Parent     := HashPage.Surface;
    Left       := ScaleX(0);
    Top        := ScaleY(5);
    Width      := HashPage.SurfaceWidth - ScaleX(0);
    Height     := HashPage.SurfaceHeight - ScaleX(75);
    ScrollBars := ssBoth;
    Visible    := False;
    #if VER >= 0x06000000
    Anchors := [akLeft, akTop, akRight, akBottom];
    #endif
  end;
  HashProgressGauge := TNewProgressBar.Create(WizardForm);
  with HashProgressGauge do begin
    Parent   := HashPage.Surface;
    Left     := ScaleX(0);
    Top      := HashPage.SurfaceHeight - WizardForm.ProgressGauge.Height - ScaleX(20);
    Width    := WizardForm.ProgressGauge.Width - ScaleX(50);
    Height   := WizardForm.ProgressGauge.Height;
    Max      := 1000;
    Position := 0;
    #if VER >= 0x06000000
    Anchors := [akLeft, akRight, akBottom];
    #endif
  end;
  HashStatusLabel := TNewStaticText.Create(WizardForm);
  with HashStatusLabel do begin
    Parent   := HashPage.Surface;
    AutoSize := False;
    Left     := ScaleX(0);
    Top      := HashPage.SurfaceHeight - WizardForm.ProgressGauge.Height - ScaleY(35);
    Width    := HashPage.SurfaceWidth;
    Height   := ScaleY(15);
    Caption  := ExpandConstant('{cm:HashWaitingLabel}');
    #if VER >= 0x06000000
    Anchors := [akLeft, akTop];
    #endif
  end;
  HashResultLabel := TNewStaticText.Create(WizardForm);
  with HashResultLabel do begin
    Parent   := HashPage.Surface;
    AutoSize := False;
    Left     := ScaleX(0);
    Top      := HashPage.SurfaceHeight - ScaleY(18);
    Width    := HashPage.SurfaceWidth;
    Height   := ScaleY(15);
    Caption  := '';
    #if VER >= 0x06000000
    Anchors := [akLeft, akTop];
    #endif
  end;
  HashPercentLabel := TNewStaticText.Create(WizardForm);
  with HashPercentLabel do begin
    Parent   := HashPage.Surface;
    AutoSize := False;
    Left     := HashProgressGauge.Width + ScaleX(5);
    Top      := HashProgressGauge.Top + ScaleY(3);
    Width    := ScaleX(45);
    Height   := ScaleY(15);
    Caption  := '0.0 %';
    SetWindowLong(Handle, GWL_STYLE, (GetWindowLong(Handle, GWL_STYLE) and (not SS_LEFT) and (not SS_CENTER) and (not SS_RIGHT) and (not SS_LEFTNOWORDWRAP )) or SS_CENTER);
    #if VER >= 0x06000000
    Anchors := [akLeft, akTop];
    #endif
  end;
  HashBackButton := TNewButton.Create(WizardForm);
  with HashBackButton do begin
    Parent   := WizardForm;
    Caption  := ExpandConstant('{cm:HashNext}');
    Left     := WizardForm.BackButton.Left;
    Top      := WizardForm.BackButton.Top;
    Width    := WizardForm.BackButton.Width;
    Height   := WizardForm.BackButton.Height;
    OnClick  := @NextBtnClick;
    #if VER >= 0x06000000
    Anchors := WizardForm.BackButton.Anchors;
    #endif
  end;
  HashNextButton := TNewButton.Create(WizardForm);
  with HashNextButton do begin
    Parent   := WizardForm;
    Caption  := ExpandConstant('{cm:HashVerify}');
    Left     := WizardForm.NextButton.Left;
    Top      := WizardForm.NextButton.Top;
    Width    := WizardForm.NextButton.Width;
    Height   := WizardForm.NextButton.Height;
    OnClick  := @VerifyHashClick;
    #if VER >= 0x06000000
    Anchors := WizardForm.NextButton.Anchors;
    #endif
  end;
  HashCancelButton := TNewButton.Create(WizardForm);
  with HashCancelButton do begin
    Parent   := WizardForm;
    Caption  := ExpandConstant('{cm:HashCancel}');
    Left     := WizardForm.CancelButton.Left;
    Top      := WizardForm.CancelButton.Top;
    Width    := WizardForm.CancelButton.Width;
    Height   := WizardForm.CancelButton.Height;
    OnClick  := @CancelHashClick;
    #if VER >= 0x06000000
    Anchors := WizardForm.CancelButton.Anchors;
    #endif
  end;
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := (PageID = HashPage.ID) and (ISDoneError or (GetArrayLength(HashFileList) = 0));
end;
#endif

procedure CurPageChanged(CurPageID: Integer);
begin
  if (CurPageID = wpFinished) and ISDoneError then
  begin
    LabelAllElapsedTime.Hide;
    WizardForm.Caption := ExpandConstant('{cm:Error}');
    WizardForm.FinishedLabel.Font.Color := clRed;
    WizardForm.FinishedLabel.Caption := SetupMessage(msgSetupAborted);
  end;
  #ifdef HashPage
  if (CurPageID = HashPage.ID) then
  begin
    HashNextButton.Show;
    HashBackButton.Show;
    HashCancelButton.Show;
    #if HashPage == YES
    if not HashStarted then
      HashNextButton.OnClick(nil);
    #endif
  end else
  begin
    HashNextButton.Hide;
    HashBackButton.Hide;
    HashCancelButton.Hide;
  end;
  if (CurPageID = wpFinished) then
  begin
    if HashAborted then
      WizardForm.NextButton.OnClick(nil);
  end;
  #endif
end;

function InitializeSetup(): Boolean;
begin
  ExtractTemporaryFile('SplitLib.dll');
  #ifdef HashPage
  ExtractTemporaryFile('XHashEx.dll');
  #endif
  Result := True;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then //Если необходимо, можно поменять на ssPostInstall
  begin
    WizardForm.ProgressGauge.Hide;
    WizardForm.CancelButton.Hide;
    CreateControls();
    WizardForm.StatusLabel.Caption := ExpandConstant('{cm:Extracted}');
    SetFocus(WizardForm.CancelButton.Handle);
    Unpack_Process(True);
    HideControls();
    WizardForm.CancelButton.Visible := True;
    WizardForm.CancelButton.Enabled := False;
  end;
  if CurStep = ssPostInstall then
  begin
    #ifdef CreateUninstallList
    if (not ISDoneError) and FileCopy(ExpandConstant('{tmp}\Uninstall.dat'), ChangeFileExt(ExpandConstant('{uninstallexe}'), '.msg'), False) then
      DeleteFile(ExpandConstant('{tmp}\Uninstall.dat'));
    #endif
    #ifdef HashPage
    ParseHashFileList();
    #endif
    if ISDoneError and ExtractTemporaryFileEx('ISDone.dll') then
      Exec2(ExpandConstant('{uninstallexe}'), '/VERYSILENT', False);
  end;
end;

#ifdef CreateUninstallList
function SetFileAttributes(lpFileName: String; dwFileAttributes: DWORD): BOOL;
  external 'SetFileAttributesW@kernel32.dll stdcall delayload';

procedure ForceDeleteFiles(lpFilePath: String; OnlyDir: Boolean);
var
  PathName: String;
begin
  PathName := lpFilePath;
  if DirExists(PathName) or ((not OnlyDir) and FileExists(PathName)) then
  begin
    if (Length(ExpandConstant('{app}')) >= Length(PathName)) or (Pos(ExpandConstant('{app}'), PathName) = 0) then
      SetFileAttributes(PathName, FILE_ATTRIBUTE_NORMAL);
    if DirExists(PathName) then
      RemoveDir(PathName)
    else
      DeleteFile(PathName);
  end;
  repeat
    PathName := ExtractFileDir(PathName);
    if (Length(ExpandConstant('{app}')) > Length(PathName)) or (Pos(ExpandConstant('{app}'), PathName) = 0) then
      SetFileAttributes(PathName, FILE_ATTRIBUTE_NORMAL);
  until ((Pos(ExpandConstant('{app}'), PathName) > 0) and (Length(ExpandConstant('{app}')) >= Length(PathName))) or (not RemoveDir(PathName));
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  I: Integer;
  PathName: String;
  UninsList: TArrayOfString;
begin
  if CurUninstallStep = usUninstall then
  begin
    if LoadStringsFromFile(ChangeFileExt(ExpandConstant('{uninstallexe}'), '.msg'), UninsList) then
    begin
      UninstallProgressForm.ProgressBar.Max := 1000;
      UninstallProgressForm.ProgressBar.Position := 0;
      SetArrayLength(UninsList, GetArrayLength(UninsList) + 1);
      UninsList[GetArrayLength(UninsList) - 1] := ChangeFileExt(ExpandConstant('{uninstallexe}'), '.msg');
      for I := 0 to GetArrayLength(UninsList) - 1 do
      begin
        PathName := TrimLeft(ExpandConstant(UninsList[I]));
        while Pos('|', PathName) > 0 do
          PathName := TrimLeft(Copy(PathName, Pos('|', PathName) + 1, Length(PathName)));
        ForceDeleteFiles(PathName, False);
        UninstallProgressForm.ProgressBar.Position := Round((I + 1) * 1000 / GetArrayLength(UninsList));
        ProcessMessages();
      end;
    end;
  end;
  if CurUninstallStep = usPostUninstall then
  begin
    ForceDeleteFiles(ExpandConstant('{uninstallexe}'), True);
    RemoveDir(ExpandConstant('{app}'));
  end;
end;
#endif

#if defined(OutputDir)
  #expr CopyFile(AddbackSlash(SourcePath) + "Include\Setup.ico", AddbackSlash(SourcePath) + "..\Setup_Files\" + SetupSetting("OutputBaseFilename") + ".ico")
#endif

