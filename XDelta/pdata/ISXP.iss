;Inno Setup XDELTA Patch Application 2.6.4.4
;Unicode version of Inno Setup 5.6.1 is required
;Maded by Kindly
                        
#pragma option -v+
#pragma verboselevel 9
#define Debug

[Setup]
AppName={#PWP_AppName}
AppVerName={#PWP_VerInfoVersion} 
DefaultDirName={tmp}
AppCopyright={#PWP_Copyright}
VersionInfoCompany={#PWP_VerInfoComp}
VersionInfoDescription={#PWP_Description}
VersionInfoVersion={#PWP_VerInfoVersion}
OutputBaseFilename={#PWP_OutputFileName}
OutputDir={#PWP_OutputDir}
WizardImageFile=Empty.bmp
WizardSmallImageFile=Empty.bmp
SetupIconFile={#PWP_SetupIconFile}
PrivilegesRequired={#PWP_PrivilegeLevel}
SolidCompression=yes
Compression={#PWP_InternalCompression}
DiskSpanning={#PWP_ExternalLauncher}
#ifdef PWP_UseX64
ArchitecturesInstallIn64BitMode=x64 ia64
#endif
                                         
[Messages]
SetupAppTitle={#PWP_AppTitle}

[LangOptions]
;Compatibled fonts
;Arial
;Courier New
;Lucida Console
;MS Sans Serif
;Tahoma
;Times New Roman
;Verdana
DialogFontName=Tahoma                                          
DialogFontSize=8               
                                                                
[Files]
; always put checker file before all other files
Source: {#PWP_CheckerLocation}\Checker.ini; DestDir: {tmp}; Flags: dontcopy; 

Source: InnoCallback.dll; DestDir: {tmp}; Flags: dontcopy;
Source: isproc.dll; DestDir: {tmp}; Flags: dontcopy;

#ifdef PWP_SilentFormMode
  Source: wintb.dll; Flags: dontcopy;
  #ifdef PWP_LanguageSupport 
  Source: {#PWP_PatchLanguage}; DestDir: {tmp}; Flags: dontcopy;
  #endif
#endif

#ifndef PWP_SilentMode
  Source: wintb.dll; Flags: dontcopy;

  #ifdef PWP_LanguageSupport 
  #ifndef PWP_LanguageSelector
  Source: {#PWP_PatchLanguage}; DestDir: {tmp}; Flags: dontcopy;
  #endif
  #endif

  #ifdef PWP_LanguageSelector
  Source: ..\lang\*.ini; DestDir: lang; Flags: ignoreversion dontcopy;
  #endif

  #ifdef PWP_BackgroundBMP
  Source: {#PWP_BackBMP}; DestDir: {tmp}; Flags: dontcopy;
  #endif

  #ifdef  PWP_SkinSupport
  Source: ISSkinU.dll; DestDir: {tmp}; Flags: dontcopy;
  Source: {#PWP_SkinLocation}; DestDir: {tmp}; Flags: dontcopy;
  #endif
  #ifdef  PWP_SkinSupportVCL
  Source: VclStylesinno.dll; DestDir: {tmp}; Flags: dontcopy;
  Source: {#PWP_SkinLocation}; DestDir: {tmp}; Flags: dontcopy;
  #endif

  #ifdef  PWP_CursorSupport
  Source: {#PWP_CurBtnLocation}; DestDir: {tmp}; Flags: dontcopy;
  Source: {#PWP_CurFrmLocation}; DestDir: {tmp}; Flags: dontcopy;
  #endif

  #ifdef  PWP_InfoSupport
    #ifndef PWP_MultiInfo
    Source: {#PWP_InfoFile}; DestDir: {tmp}; Flags: dontcopy;
    #endif
    #ifdef PWP_MultiInfo                        
      Source: ..\info\{#PWP_AppName}\*; DestDir: info; Flags: ignoreversion dontcopy;
    #endif
  #endif

  #ifdef PWP_MusicSupport 
  Source: bass.dll; DestDir: {tmp}; Flags: dontcopy;
  Source: {#PWP_MusicFile}; DestDir: {tmp}; Flags: dontcopy;
  #endif
  #ifdef PWP_ModMusicSupport 
  Source: bass.dll; DestDir: {tmp}; Flags: dontcopy;
  Source: {#PWP_MusicFile}; DestDir: {tmp}; Flags: dontcopy;
  #endif
#endif

#ifdef PWP_BatchCodeSupport
  #ifndef PWP_ExternalFilesSupport 
  Source: ..\PCODE\OnStartupCode.bat; DestDir: {tmp}; Flags: dontcopy;
  Source: ..\PCODE\OnBeforeCode.bat; DestDir: {tmp}; Flags: dontcopy;
  Source: ..\PCODE\OnAfterCode.bat; DestDir: {tmp}; Flags: dontcopy;
  Source: ..\PCODE\OnFinishCode.bat; DestDir: {tmp}; Flags: dontcopy;
  #endif
  #ifdef PWP_ExternalTemp
  Source: ..\PCODE\OnStartupCode.bat; DestDir: {tmp}; Flags: dontcopy;
  Source: ..\PCODE\OnBeforeCode.bat; DestDir: {tmp}; Flags: dontcopy;
  Source: ..\PCODE\OnAfterCode.bat; DestDir: {tmp}; Flags: dontcopy;
  Source: ..\PCODE\OnFinishCode.bat; DestDir: {tmp}; Flags: dontcopy;
  #endif
#endif   

#ifdef PWP_VerificationMethodCRC
Source: crc32c.dll; DestDir: {tmp}; Flags: dontcopy;
#endif

#ifdef PWP_XDELTAEngine
Source: xdelta-x86.exe; DestDir: {tmp}; Flags: dontcopy;
Source: xdelta-x64.exe; DestDir: {tmp}; Flags: dontcopy;
#endif

#ifdef PWP_JojoDiffEngine
Source: jptch-x86.exe; DestDir: {tmp}; Flags: dontcopy;
Source: jptch-x64.exe; DestDir: {tmp}; Flags: dontcopy;
#endif

#ifdef PWP_HDiffEngine
Source: hpatchz-x86.exe; DestDir: {tmp}; Flags: dontcopy;
Source: hpatchz-x64.exe; DestDir: {tmp}; Flags: dontcopy;
#endif

#ifdef PWP_FreeArcSupport
Source: unarc.dll; DestDir: {tmp}; Flags: dontcopy; 
#endif

#ifdef PWP_InsidePatch
Source: {#PWP_OutputPatchData}\*; DestDir: {#PWP_PatchDataDirName}; Flags: ignoreversion recursesubdirs createallsubdirs dontcopy;
#endif
#ifndef PWP_InsidePatch
Source: {#PWP_OutputPatchData}\*; DestDir: {#PWP_PatchDataDirName}; Flags: ignoreversion recursesubdirs createallsubdirs external;
#endif

#ifndef PWP_FreeArcSupport
  #ifdef PWP_ExternalFilesSupport 
  Source: {#PWP_ExternalLocation}\*; DestDir: {#PWP_ExternalDirName}; Flags: ignoreversion recursesubdirs createallsubdirs {#PWP_ExternalMethod};
  #endif
#endif

#ifdef PWP_FreeArcSupport
  #ifdef PWP_ExternalFilesSupport 
  Source: {#PWP_ExternalLocation}\*; DestDir: {#PWP_ExternalDirName}; Flags: ignoreversion recursesubdirs createallsubdirs {#PWP_ExternalMethod};
  #endif
#endif

[Code]
#ifdef PWP_DownloadFileSupport
  #include "dwinshs.iss"
#endif

#ifdef PWP_SilentFormMode
const
  TBPF_NOPROGRESS = 0;
  TBPF_INDETERMINATE = 1;
  TBPF_NORMAL = 2;
  TBPF_ERROR = 4;
  TBPF_PAUSED = 8;

type
  TProc = procedure(HandleW, msg, idEvent, TimeSys: LongInt);
  TTimerProc=procedure(h:longword; msg:longword; idevent:longword; dwTime:longword);

function FindWindow(ClassName, WindowName: String): HWND; 
external 'FindWindowW@user32.dll stdcall';

function ShowWindow(hWnd: HWND; uType: Integer): BOOL;
external 'ShowWindow@user32.dll stdcall';

function FlashWindow(hWnd: HWND; bInvert: Bool): Bool;
external 'FlashWindow@user32.dll stdcall';

procedure WintbStart(); 
external 'WintbStart@files:wintb.dll cdecl';

procedure WintbStop(); 
external 'WintbStop@files:wintb.dll cdecl';

procedure SetTaskBarProgressValue(Value: Longint); 
external 'SetTaskBarProgressValue@files:wintb.dll cdecl';

procedure SetTaskBarProgressState(Value: Longint); 
external 'SetTaskBarProgressState@files:wintb.dll cdecl';

function WrapTimerProc(callback:TTimerProc; paramcount:integer):longword;
external 'wrapcallback@files:innocallback.dll stdcall';

function SetTimer(hWnd: longword; nIDEvent, uElapse: longword; lpTimerFunc: longword): longword;
external 'SetTimer@user32.dll stdcall';
                    
function KillTimer(hWnd: LongWord; nIDEvent: LongWord): LongWord;
external 'KillTimer@user32.dll stdcall';

function GetTickCount: Dword; 
external 'GetTickCount@kernel32.dll stdcall';

function SetForegroundWindow(HW: HWND): Bool;
external 'SetForegroundWindow@user32.dll stdcall';
#endif

#ifndef PWP_SilentMode
const
  GCL_HCURSOR   = (-12);
  OCR_NORMAL    = 32512;
// ----------------------------------------------------------- //
#ifdef  PWP_TransparentSupport
  TransparentPercent = {#PWP_TransparentLevel};
  TransparentColor = clBtnFace; 
  WS_EX_LAYERED = $80000;
  LWA_ALPHA = 2;
  GWL_EXSTYLE = (-20);
#endif
// ----------------------------------------------------------- //
#ifdef PWP_AnimationSupport
  AW_SLIDE_IN_LEFT = $00040001;
  AW_SLIDE_IN_RIGHT = $00040002;
  AW_SLIDE_IN_TOP = $00040004;
  AW_SLIDE_IN_BOTTOM = $00040008;
  AW_DIAG_SLIDE_IN_TOPLEFT = $00040005;
  AW_DIAG_SLIDE_IN_TOPRIGHT = $00040006;
  AW_DIAG_SLIDE_IN_BOTTOMLEFT = $00040009;
  AW_DIAG_SLIDE_IN_BOTTOMRIGHT = $0004000a;
  AW_HOR_POSITIVE = $00000001;
  AW_VER_POSITIVE = $00000004;
  AW_EXPLODE = $00040010;

  AW_SLIDE_OUT_LEFT = $00050002;
  AW_SLIDE_OUT_RIGHT = $00050001;
  AW_SLIDE_OUT_TOP = $00050008;
  AW_SLIDE_OUT_BOTTOM = $00050004;
  AW_DIAG_SLIDE_OUT_TOPLEFT = $0005000a;
  AW_DIAG_SLIDE_OUT_TOPRIGHT = $00050009;
  AW_DIAG_SLIDE_OUT_BOTTOMLEFT = $00050006;
  AW_DIAG_SLIDE_OUT_BOTTOMRIGHT = $00050005;
  AW_HOR_NEGATIVE = $00000002;
  AW_VER_NEGATIVE = $00000008;
  AW_IMPLODE = $00050010;

  AW_BLEND = $00080000; 

  AW_ACTIVATE = $00020000;
  AW_HIDE = $00010000;
#endif

type
  TProc=procedure(HandleW, msg, idEvent, TimeSys: longword);
  TTimerProc=procedure(h:longword; msg:longword; idevent:longword; dwTime:longword);

// ----------------------------------------------------------- //
#ifdef  PWP_TransparentSupport
function SetLayeredWindowAttributes(hwnd: hWnd; crKey: TColor; bAlpha: byte; dwFlags: DWORD): Boolean; 
external 'SetLayeredWindowAttributes@user32.dll stdcall';

function GetWindowLong(Wnd: HWnd; Index: Integer): Longint; 
external 'GetWindowLongW@user32.dll stdcall';

function SetWindowLong(Wnd: HWnd; Index: Integer; NewLong: Longint): Longint; 
external 'SetWindowLongW@user32.dll stdcall';
#endif
// ----------------------------------------------------------- //

function FindWindow(ClassName, WindowName: String): HWnd; 
external 'FindWindowW@user32.dll stdcall';

function ShowWindow(hWnd: HWND; uType: Integer): BOOL;
external 'ShowWindow@user32.dll stdcall';

function FlashWindow(hWnd: HWND; bInvert: Bool): Bool;
external 'FlashWindow@user32.dll stdcall';
//
procedure WintbStart(); 
external 'WintbStart@files:wintb.dll cdecl';

procedure WintbStop(); 
external 'WintbStop@files:wintb.dll cdecl';

procedure SetTaskBarProgressValue(Value: Longint); 
external 'SetTaskBarProgressValue@files:wintb.dll cdecl';

procedure SetTaskBarProgressState(Value: Longint); 
external 'SetTaskBarProgressState@files:wintb.dll cdecl';

function SetForegroundWindow(HW: HWND): Bool;
external 'SetForegroundWindow@user32.dll stdcall';

// ----------------------------------------------------------- //
#ifdef  PWP_SkinSupport
procedure LoadSkin(lpszPath: String; lpszIniFileName: String);
external 'LoadSkin@files:isskinu.dll stdcall';

procedure UnloadSkin();
external 'UnloadSkin@files:isskinu.dll stdcall';
#endif
// ----------------------------------------------------------- //
#ifdef  PWP_SkinSupportVCL
procedure LoadVCLStyle(VClStyleFile: String); 
external 'LoadVCLStyleW@files:VclStylesInno.dll stdcall';

procedure UnLoadVCLStyles; 
external 'UnLoadVCLStyles@files:VclStylesInno.dll stdcall';
#endif
// ----------------------------------------------------------- //
function WrapTimerProc(callback:TTimerProc; paramcount:integer):longword;
external 'wrapcallback@files:innocallback.dll stdcall';

function WrapTProc(tcallback:TProc; paramcount:integer):longword;
external 'wrapcallback@files:innocallback.dll stdcall';

function SetTimer(hWnd: longword; nIDEvent, uElapse: longword; lpTimerFunc: longword): longword;
external 'SetTimer@user32.dll stdcall';
                    
function KillTimer(hWnd: LongWord; nIDEvent: LongWord): LongWord;
external 'KillTimer@user32.dll stdcall';

function GetTickCount: Dword; 
external 'GetTickCount@kernel32.dll stdcall';
// ----------------------------------------------------------- //
#ifdef  PWP_CursorSupport
function LoadCursorFromFile(FileName: String): Longint;
external 'LoadCursorFromFileW@user32 stdcall';

function SetClassLong(hWnd: HWND; Index, NewLong: Longint): Longint;
external 'SetClassLongW@user32 stdcall';

function SetSystemCursor(Cursor, CurType: Longint): Longint;
external 'SetSystemCursor@user32 stdcall';
#endif
// ----------------------------------------------------------- //
#ifdef PWP_MusicSupport
function BASS_Init(device: longint; freq, flags: DWORD; win: hwnd; CLSID: Longint): Boolean;
external 'BASS_Init@files:BASS.dll stdcall';

function BASS_Start(): Boolean;
external 'BASS_Start@files:BASS.dll stdcall';

function BASS_StreamCreateFile(mem: BOOL; f: PAnsiChar; offset, length: Int64; flags: DWORD): HWND;
external 'BASS_StreamCreateFile@files:BASS.dll stdcall';

function BASS_ChannelPlay(handle: DWORD; restart: BOOL): Boolean;
external 'BASS_ChannelPlay@files:BASS.dll stdcall';

function BASS_ChannelPause(handle: DWORD): BOOLEAN;
external 'BASS_ChannelPause@files:BASS.dll stdcall';

function  BASS_Stop(): Boolean;
external 'BASS_Stop@files:BASS.dll stdcall';

function  BASS_Free(): Boolean;
external 'BASS_Free@files:BASS.dll stdcall';

function BASS_ChannelSetAttribute(handle, attrib: DWORD; value: single): BOOL;
external 'BASS_ChannelSetAttribute@BASS.dll stdcall'; 

function BASS_ChannelGetAttribute(handle, attrib: DWORD; var value: single): BOOL;
external 'BASS_ChannelGetAttribute@BASS.dll stdcall'; 
#endif
#ifdef PWP_ModMusicSupport
function BASS_Init(device: longint; freq, flags: DWORD; win: hwnd; CLSID: Longint): Boolean;
external 'BASS_Init@files:BASS.dll stdcall';

function BASS_Start(): Boolean;
external 'BASS_Start@files:BASS.dll stdcall';

function BASS_ChannelPlay(handle: DWORD; restart: BOOL): Boolean;
external 'BASS_ChannelPlay@files:BASS.dll stdcall';

function BASS_ChannelPause(handle: DWORD): BOOLEAN;
external 'BASS_ChannelPause@files:BASS.dll stdcall';

function BASS_Stop(): Boolean;
external 'BASS_Stop@files:BASS.dll stdcall';

function BASS_Free(): Boolean;
external 'BASS_Free@files:BASS.dll stdcall';

function BASS_MusicLoad(mem: BOOL; f: PAnsiChar; offset: Int64; length, flags, freq: DWORD): HWND;
external 'BASS_MusicLoad@files:BASS.dll stdcall';

function BASS_MusicFree(handle: HWND): BOOL;
external 'BASS_MusicFree@files:BASS.dll stdcall';

function BASS_ChannelSetAttribute(handle, attrib: DWORD; value: single): BOOL;
external 'BASS_ChannelSetAttribute@BASS.dll stdcall'; 

function BASS_ChannelGetAttribute(handle, attrib: DWORD; var value: single): BOOL;
external 'BASS_ChannelGetAttribute@BASS.dll stdcall'; 
#endif
// ----------------------------------------------------------- //

#endif    

//...MAIN FUNCTIONS...//
const
  BAK_DIR = '\{#PWP_BackupDir}';

  //GENERIC_READ        = $80000000;
  GENERIC_WRITE       = $40000000;
  GENERIC_EXECUTE     = $20000000;
  GENERIC_ALL         = $10000000;
  FILE_SHARE_READ     = 1;
  FILE_SHARE_WRITE    = 2;
  FILE_SHARE_DELETE   = 4;
  CREATE_NEW          = 1;
  CREATE_ALWAYS       = 2;
  OPEN_EXISTING       = 3;
  OPEN_ALWAYS         = 4;
  TRUNCATE_EXISTING   = 5;

  INVALID_HANDLE_VALUE = (-1);

  SW_RESTORE          = 9;
  ///////////////////////
  PROGRESS_CONTINUE = 0;
  PROGRESS_CANCEL = 1;
  CALLBACK_CHUNK_FINISHED = $0;
{
#ifdef PWP_VerificationMethodCRC
  PAGE_READONLY = $0002;
  FILE_MAP_READ = $0004;
  HEAP_ZERO_MEMORY = $0008;
  FILE_FLAG_SEQUENTIAL_SCAN = $08000000;
#endif
}
#ifdef PWP_FreeArcSupport
  CP_ACP = 0; CP_UTF8 = 65001;
  oneMb = 1048576;

type
  TFreeArcCallback = function (what: PAnsiChar; int1, int2: Cardinal; str: PAnsiChar): Cardinal;
#endif

type
  PLARGE_INTEGER = record
  QuadPart: Int64;
end; 

type 
  TMyMsg = record hWnd: HWND; msg, wParam: Word; lParam: LongWord; Time: TFileTime; pt: TPoint; end;

type 
  EnumCopyCallback=function(TotalFileSizeLo, TotalFileSizeHi, TotalBytesTransferredLo, TotalBytesTransferredHi, StreamSizeLo, StreamSizeHi, StreamBytesTransferredLo, StreamBytesTransferredHi: Longint; dwStreamNumber, dwCallbackReason: DWORD; hSourceFile, hDestinationFile: THandle; lpData: Longint): DWORD;

type
{ typedef struct _PROCESS_INFORMATION ... PROCESS_INFORMATION, *LPPROCESS_INFORMATION; }

TProcessInfo = record
  hProcess:DWORD;
  hThread:DWORD;
  dwProcessId:DWORD;
  dwThreadId:DWORD;
end;

  { typedef struct _STARTUPINFOA ... STARTUPINFOA, *LPSTARTUPINFOA; }
TStartupInfo = record
  cb:DWORD;
  lpReserved:DWORD; // not PChar; - need NULL pointer
  lpDesktop:DWORD;  // not PChar; - need NULL pointer
  lpTitle:DWORD;  // not PChar; - need NULL pointer
  dwX:DWORD;
  dwY:DWORD;
  dwXSize:DWORD;
  dwYSize:DWORD;
  dwXCountChars:DWORD;
  dwYCountChars:DWORD;
  dwFillAttribute:DWORD;
  dwFlags:DWORD;
  wShowWindow:WORD;
  cbReserved2:WORD;
  lpReserved2:DWORD;
  hStdInput:DWORD;
  hStdOutput:DWORD;
  hStdError:DWORD;
end;

function WrapMyCopyCallback(copycallback:EnumCopyCallback; paramcount:integer):longword;
external 'wrapcallback@files:innocallback.dll stdcall';
// ----------------------------------------------------------- //
function CopyFileEx(lpExistingFileName, lpNewFileName: String; lpProgressRoutine, lpData: Longword; var pbCancel: BOOL; dwCopyFlags: DWORD): BOOL; 
external 'CopyFileExW@kernel32.dll stdcall';

function PathIsDirectory(pszPath: String): BOOL; 
external 'PathIsDirectoryW@shlwapi.dll stdcall';
// ----------------------------------------------------------- //
function GetFileAttributes(lpFileName: String): DWORD;
external 'GetFileAttributesW@kernel32.dll stdcall';
                                                 
function SetFileAttributes(lpFileName: String; dwFileAttributes: DWORD): BOOL;
external 'SetFileAttributesW@kernel32.dll stdcall';

function MoveFileEx(lpExistingFileName, lpNewFileName: String; dwFlags: DWORD): BOOL;
external 'MoveFileExW@kernel32.dll stdcall';
// ----------------------------------------------------------- //
function CreateFile(lpFileName: String; dwDesiredAccess: DWORD; dwShareMode: DWORD; lpSecurityAttributes: DWORD; dwCreationDisposition: DWORD; dwFlagsAndAttributes: DWORD; hTemplateFile: THandle): THandle;
external 'CreateFileW@kernel32.dll stdcall';

function CloseHandle(hObject: THandle): BOOL;
external 'CloseHandle@kernel32.dll stdcall';
// ----------------------------------------------------------- //
function CreateProcess(lpApplicationName: String; lpCommandLine: string; lpProcAttrib,lpThreadAttrib: DWORD; bInheritHandles: BOOL; dwCreationFlags: DWORD; lpEnvironment:DWORD; lpCurrentDirectory: String; var lpStartupInfo:TStartupInfo; var lpProcessInfo:TProcessInfo): Integer;
external 'CreateProcessW@kernel32.dll stdcall';

function GetExitCodeProcess(hProcess:THandle; var lpExitCode:DWORD):Integer;
external 'GetExitCodeProcess@kernel32.dll stdcall';

function WaitForSingleObject(hHandle: THandle; dwMilliseconds: DWORD): DWORD; 
external 'WaitForSingleObject@kernel32.dll stdcall';

function WaitForInputIdle(hProcess: THandle; dwMilliseconds: DWORD): DWORD; 
external 'WaitForInputIdle@user32.dll stdcall';
// ----------------------------------------------------------- //
function PeekMessage(var lpMsg: TMyMsg; hWnd: HWND; wMsgFilterMin, wMsgFilterMax, wRemoveMsg: UINT): BOOL; 
external 'PeekMessageW@user32.dll stdcall';

function TranslateMessage(const lpMsg: TMyMsg): BOOL; 
external 'TranslateMessage@user32.dll stdcall';

function DispatchMessage(const lpMsg: TMyMsg): Longint; 
external 'DispatchMessageW@user32.dll stdcall';
// ----------------------------------------------------------- //
#ifdef PWP_AnimationSupport
function AnimateWindow(hWnd: HWND; dwTime: DWORD; dwFlags: DWORD): Bool;
external 'AnimateWindow@user32 stdcall';
#endif
// ----------------------------------------------------------- //
#ifdef PWP_TimeStampSupport
function GetFileTime(hFile: THANDLE; out lpCreationTime,lpLastAccessTime,lpLastWriteTime: TFileTime): BOOL;
external 'GetFileTime@kernel32.dll stdcall';

function SetFileTime(hFile: THANDLE; lpCreationTime,lpLastAccessTime,lpLastWriteTime: TFileTime): BOOL;
external 'SetFileTime@kernel32.dll stdcall';
#endif
// ----------------------------------------------------------- //
#ifdef PWP_VerificationMethodCRC
function GetCRC32OfFile(FilePath: String): Cardinal;                    
external 'GetCRC32OfFile@files:crc32c.dll stdcall'; 
{
function RtlComputeCrc32(dwInitial: Cardinal; const pData: Longint; iLen: Integer): Cardinal; 
external 'RtlComputeCrc32@ntdll.dll stdcall';

function ReadFile(hFile: THandle; lpBuffer: Longint; nNumberOfBytesToRead: DWORD; var lpNumberOfBytesRead: DWORD; lpOverlapped: Longint): BOOL; 
external 'ReadFile@kernel32.dll stdcall';

function GetProcessHeap: THandle; 
external 'GetProcessHeap@kernel32.dll stdcall';

function HeapAlloc(hHeap: THandle; dwFlags, dwBytes: DWORD): Longint; 
external 'HeapAlloc@kernel32.dll stdcall';

function HeapSize(hHeap: THandle; dwFlags: DWORD; lpMem: Longint): DWORD; 
external 'HeapSize@kernel32.dll stdcall';

function HeapFree(hHeap: THandle; dwFlags: DWORD; lpMem: Longint): BOOL; 
external 'HeapFree@kernel32.dll stdcall';
}
#endif
// ----------------------------------------------------------- //
#ifdef PWP_FreeArcSupport
function MultiByteToWideChar(CodePage: UINT; dwFlags: DWORD; lpMultiByteStr: AnsiString; cbMultiByte: integer; lpWideCharStr: AnsiString; cchWideChar: integer): longint; 
external 'MultiByteToWideChar@kernel32.dll stdcall';

function WideCharToMultiByte(CodePage: UINT; dwFlags: DWORD; lpWideCharStr: AnsiString; cchWideChar: integer; lpMultiByteStr: AnsiString; cbMultiByte: integer; lpDefaultChar: integer; lpUsedDefaultChar: integer): longint; 
external 'WideCharToMultiByte@kernel32.dll stdcall';
// ----------------------------------------------------------- //
Function OemToChar(lpszSrc, lpszDst: PAnsiChar): longint; 
external 'OemToCharA@user32.dll stdcall';
// ----------------------------------------------------------- //
function WrapFreeArcCallback(callback: TFreeArcCallback; paramcount: integer):longword; 
external 'wrapcallback@files:innocallback.dll stdcall';

function FreeArcExtract(callback: longword; cmd1,cmd2,cmd3,cmd4,cmd5,cmd6,cmd7,cmd8,cmd9,cmd10: PAnsiChar): integer; 
external 'FreeArcExtract@files:unarc.dll cdecl';
#endif
{
function GetFileSizeEx(hFile: THANDLE; out lpFileSize: PLARGE_INTEGER): BOOL;
external 'GetFileSizeEx@kernel32.dll stdcall';
}
function IsProcessRunning(exename: ansistring): Integer; 
external 'IsProcessRunning@files:isproc.dll stdcall';

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

procedure GetSystemInfo(var lpSystemInfo: TSystemInfo); 
external 'GetSystemInfo@kernel32.dll stdcall';

// ----------------------------------------------------------- //
type
  FILETIME = record
    dwLowDateTime, dwHighDateTime: DWORD;
  end;

  WIN32_FILE_ATTRIBUTE_DATA = record
    dwFileAttributes: DWORD;
    ftCreationTime, ftLastAccessTime, ftLastWriteTime: FILETIME;
    nFileSizeHigh, nFileSizeLow: DWORD;
  end;

function GetFileAttributesEx(lpFileName: String; fInfoLevelId: DWORD; var lpFileInformation: WIN32_FILE_ATTRIBUTE_DATA): BOOL; 
external 'GetFileAttributesExW@kernel32.dll stdcall';
// ----------------------------------------------------------- //

var
#ifdef PWP_BatchCodeSupport
  ResultCode: Integer;
#endif
  m,z,pCount,oCount,iCount,v,t,j: Cardinal;

  #ifdef PWP_AttributesSupport
  az: Cardinal;
  #endif

  tp,tc,dz: Cardinal;
  tf: String;

  pProcessInfo: Array of TProcessInfo;
#ifdef PWP_MultiVersionMode
  tk,tj,mvCount,tj10,tj5,tj3,tj1: Integer;
  fVer: String;
  gm: ShortInt;
#endif

#ifdef PWP_DownloadFileSupport
  CancelClicked: Boolean;
  Downloaded: Integer;
  Response: AnsiString;
  Size: {#BIG_INT};
#endif

#ifdef PWP_FreeArcSupport
  CancelCode: Integer;
  lastMb,baseMb: Cardinal;
  totalUncompressedSize,origsize: Cardinal;
  Archive,ArcPath: String;
#endif

#ifdef PWP_JunkedFilesProcessing
  jCount: Cardinal;
#endif

#ifdef PWP_JunkedDirsProcessing
  jdCount: Cardinal;
#endif

#ifdef PWP_ForcePatchingSupport
  d: Cardinal;
#endif

#ifdef PWP_TimeStampSupport
  hFile: THandle;
  CreationTime,LastAccessTime,LastWriteTime: TFileTime;
  tz: Cardinal;
#endif
//=============================//
  PatchingError,bkp: ShortInt;

  bCancel: BOOL;  
  cores,corcnt,i: Integer;
  copycallback: LongWord;
  srcFile,destFile,ResultStr: String;
  basePath,t_basePath,b_basePath,ini,PatchEngine,EngineParam: string;

  BACKUP_DIR: String;

  key_cur: {#PWP_VER_METHOD};
  init_key_chk: shortint;

  #ifdef PWP_SimplyLogSupport
  s_basePath: string;
  #endif
//=============================//
  #ifndef PWP_InsidePatch
  upstr: String;
  #endif

  #ifndef PWP_ExternalTemp
    #ifdef PWP_ExternalFilesSupport 
      #ifdef PWP_BatchCodeSupport
        ctstr: String;
      #endif
    #endif
  #endif

#ifndef PWP_SilentMode
  sLang: String;
  #ifdef PWP_LanguageSelector
  lCombo: TComboBox;
  #endif

  #ifdef PWP_MultiInfo
  iName: String;
  #endif
#endif

#ifdef PWP_SilentFormMode
  sLang: String;
#endif

#ifdef PWP_SilentFormMode
  Form: TSetupForm;
  Lang,Lang2: String;
  #ifdef PWP_GetSpaseOnDisk
  Lang3,Lang4: String;
  #endif
  mStr,iStr: TLabel;
  ProgressBar: TNewProgressBar;
  ExitButton: TButton;
  X: Integer;
  HW: HWND;
  fpfunc,fTimerID: LongWord;
#endif
//////
#ifndef PWP_SilentMode
  ExitButton,StartButton,BrowseButton,InfoButton: TButton;

  #ifdef PWP_MusicButtonSupport 
  MusicButton,MusicButton1,MusicButton2: TButton;
  #endif

  #ifdef PWP_DownloadFileSupport
  CancelButton: TButton;
  #endif

  Form: TSetupForm;
  cb_bak,cb_log,cb_vh: TCheckBox;
  oDir: TEdit;
  pLog,xInfo: TMemo;

  #ifdef PWP_InfoRtfSupport
  pInfo: TRichEditViewer;
  #endif
  #ifndef PWP_InfoRtfSupport
  pInfo: TMemo;
  #endif

  cStr,pStr,bStr,lStr,iStr,dStr,mStr,vStr,SiteLabel: TLabel;
  ProgressBar: TNewProgressBar;
  UserSelectDir,Lang,Lang2,Lang3,Lang4: String;
  Panel: TPanel;

  #ifdef PWP_InfoSupport
  str_z: AnsiString;
  #endif

  #ifdef PWP_LinkSupport
  MouseLabel: TLabel;
  #endif

  #ifdef PWP_BackgroundBMP
  BMPBackground:TBitmapImage;
  #endif

  HW: HWND;

  #ifdef PWP_CursorSupport
  OldCursor,NewCursor,NewCursorForm: Longint;
  #endif

  #ifdef PWP_MusicSupport
  Song: String;
  hMus: DWORD;
  #endif
  #ifdef PWP_ModMusicSupport
  Song: String;
  hMus: HWND;
  #endif

  fpfunc,fTimerID: LongWord;
  tfunc,tTimerID:longword;
  Elapsed,Start,Stop:int64;

  #ifdef PWP_ScrollerSupport
  pfunc,sTimerID: LongWord;
  rStr: TLabel;
  X,RL: Integer;
  BitmapImage: TBitmapImage;
  #endif

function FormatTime(time: int64): string;
 var
  Ms : Int64;
  H, M, S : Integer;
begin
  Ms := time;
  H := Ms div (60 * 60 * 1000);
  Ms := Ms mod (60 * 60 * 1000); 
  M := Ms div (60 * 1000);
  Ms := Ms mod (60 * 1000); 
  S := Ms div 1000;
  Ms := Ms mod 1000; 
  Result := Format('%.2dh:%.2dm:%.2ds:%.3dms',[H,M,S,Ms]);
end;  

procedure tTimer(h: Longword; msg: Longword; idevent: Longword; dwTime: Longword);
begin
  Stop:=GetTickCount;
  Elapsed:=Stop-Start;
  Lang := GetIniString('ISPATCH', 'PATCHING_PROCESS', 'Patching process, please wait...', sLang);
  xInfo.Text := Lang + #13#10 + FormatTime(Elapsed);
  xInfo.Update;
end;

#ifdef  PWP_ScrollerSupport
procedure OnTimer(HandleW, msg, idEvent, TimeSys: LongWord);
begin
  X := X - 1;
  rStr.Left := X + Form.Width;  
  if X <= -Form.Width-rStr.Width then
  X := 0;
end;

procedure StringTimer;
begin
  pfunc:= WrapTimerProc(@OnTimer, 4);
  sTimerID:= SetTimer(0, 0, 28, pfunc);
end;
#endif

#endif

function GetCPUCores(): Integer;
var
  SysInfo: TSystemInfo;
begin
  GetSystemInfo(SysInfo);  	
  Result := SysInfo.dwNumberOfProcessors;
end;

procedure AppProcessMessage;
var
  Msg: TMyMsg;
begin
  while PeekMessage(Msg, 0, 0, 0, 1) do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end;

#ifdef PWP_SilentFormMode
procedure Finish(HandleW, msg, idEvent, TimeSys: LongWord);
begin
  FlashWindow(HW, True); 
  FlashWindow(HW, False); 

  if Form.Active then
  begin
    SetForegroundWindow(HW);  
    FlashWindow(HW, False);

    Lang := GetIniString('ISPATCH', 'FORM_CLOSED', 'The patch window is closed automatically after ', sLang);
    Lang2 := GetIniString('ISPATCH', 'FORM_CLOSED2', ' seconds.', sLang);
    iStr.Caption := Lang + IntToStr(X) + Lang2;
    iStr.Refresh;

    if X <= 0 then
    begin
      PostMessage(ExitButton.Handle, 513, 0, 0);
      PostMessage(ExitButton.Handle, 514, 0, 0);
    end;

    dec(X);
  end; 
end;

procedure FlashTimer;
begin
  X := {#PWP_SecondsCount};

  if X = 0 then
  begin
    PostMessage(ExitButton.Handle, 513, 0, 0);
    PostMessage(ExitButton.Handle, 514, 0, 0);
  end;

  HW := FindWindow('TApplication','{#PWP_AppTitle}');
  fpfunc:= WrapTimerProc(@Finish, 4);
  fTimerID:= SetTimer(0, 0, 1000, fpfunc);
end;
#endif
#ifndef PWP_SilentMode
procedure Finish(HandleW, msg, idEvent, TimeSys: LongWord);
begin
  FlashWindow(HW, True); 
  FlashWindow(HW, False); 

  if Form.Active then
  begin
    KillTimer(0, fTimerID);
    SetForegroundWindow(HW);  
    FlashWindow(HW, False);
  end;  
end;

procedure FlashTimer;
begin
  HW := FindWindow('TApplication','{#PWP_AppTitle}');
  fpfunc:= WrapTimerProc(@Finish, 4);
  fTimerID:= SetTimer(0, 0, 1000, fpfunc);
end;
#endif

#ifndef PWP_SilentMode
#ifdef PWP_LinkSupport
procedure SiteLabelOnClick(Sender: TObject); var ErrorCode: Integer;
begin
  ShellExec('open', '{#PWP_Contact}', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode)
end;

procedure SiteLabelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 // SiteLabel.Font.Color:=$FC552D
 // SiteLabel.Font.Style := SiteLabel.Font.Style + [fsItalic];
end;

procedure SiteLabelMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // SiteLabel.Font.Color:=$723F34
  SiteLabel.Font.Style := SiteLabel.Font.Style - [fsUnderline];
end;

procedure SiteLabelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  // SiteLabel.Font.Color:=$723F34
  SiteLabel.Font.Style := SiteLabel.Font.Style + [fsUnderline];
end;

procedure SiteLabelMouseMove2(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  //SiteLabel.Font.Color:=$723F34
  SiteLabel.Font.Style := SiteLabel.Font.Style - [fsUnderline];
end;
#endif
#endif

#ifdef PWP_DownloadFileSupport
function FormatFileSize(sz: Int64): String;
var
  mb,size: extended;
  s : string;
begin
  if sz < $400 then
  begin
    Result := Format('%d B',[sz]);
    Exit;
  end;
  if sz < $100000 then
  begin
    size := Extended(sz);
    mb:=size/(1 shl 10);
    s := FloatToStr(mb);
    s := Copy(s,Pos('.',s)+1,Length(s)-Pos('.',s)+1);
    Insert('.',s,3)
    Result := Format('%d,%.2d Kb',[Trunc(mb),Round(StrToFloat(s))]);
    Exit;
  end;
  if (sz >= $100000) and (sz < $40000000) then
  begin
    size := Extended(sz);
    mb:=size/(1 shl 20);
    s := FloatToStr(mb);
    s := Copy(s,Pos('.',s)+1,Length(s)-Pos('.',s)+1);
    Insert('.',s,3)
    Result := Format('%d,%.2d Mb',[Trunc(mb),Round(StrToFloat(s))]);
    Exit;
  end;
  if sz >= $40000000 then
  begin
    size := Extended(sz);
    mb:=size/(1 shl 30);
    s := FloatToStr(mb);
    s := Copy(s,Pos('.',s)+1,Length(s)-Pos('.',s)+1);
    Insert('.',s,3)
    Result := Format('%d,%.2d Gb',[Trunc(mb),Round(StrToFloat(s))]);
  end;
end;

function OnRead(URL, Agent: AnsiString; Method: TReadMethod; Index, TotalSize, ReadSize,
  CurrentSize: {#BIG_INT}; var ReadStr: AnsiString): Boolean;
begin
  if Index = 0 then 
  begin 
    #ifdef PWP_SilentFormMode
    ProgressBar.Max := TotalSize;
    #endif

    #ifndef PWP_SilentMode
    ProgressBar.Max := TotalSize;

    Lang := GetIniString('ISPATCH', 'DOWNLOAD_START', 'Downloading data: ', sLang);
    pLog.Lines.Add(Lang + '"' + '{#PWP_DownloadFileName}' + '"');

    Lang := GetIniString('ISPATCH', 'DOWNLOAD_START2', 'To the location: ', sLang);
    #ifndef PWP_DownloadCustomPath
    pLog.Lines.Add(Lang + '"' + ResultStr + '"');                                
    #endif
    #ifdef PWP_DownloadCustomPath
    pLog.Lines.Add(Lang + '"' + ExpandConstant('{#PWP_DownloadPath}\') + '"');
    #endif

    Lang := GetIniString('ISPATCH', 'DOWNLOAD_START3', 'Total size: ', sLang);
    pLog.Lines.Add(Lang + FormatFileSize(TotalSize));
    #endif
  end;
  #ifdef PWP_SilentFormMode
  ProgressBar.Position := ReadSize; // Update the download progress indicator
  #endif
  #ifndef PWP_SilentMode
  ProgressBar.Position := ReadSize; // Update the download progress indicator
  #endif
  Result := True; // Continue to download
  Result := not CancelClicked; // Determine whether download was cancelled
end;
#endif
{
#ifdef PWP_VerificationMethodCRC
function GetCRC32OfFile(FileName: string): Cardinal;
var
  hFile, hHeap: THandle;
  lpBuffer: Longint;
  dwBufferSize, dwRead: DWORD;
begin
  Result := 0;
  hFile := CreateFile(FileName, $80000000, FILE_SHARE_READ, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL or FILE_FLAG_SEQUENTIAL_SCAN, 0);
  if hFile = INVALID_HANDLE_VALUE then Exit;
  try
    hHeap := GetProcessHeap;
    if hHeap = 0 then Exit;
    lpBuffer := HeapAlloc(hHeap, HEAP_ZERO_MEMORY, 32*1024);
    if lpBuffer = 0 then Exit;
    dwBufferSize := HeapSize(hHeap, 0, lpBuffer);
    if dwBufferSize = 0 then Exit;
    while ReadFile(hFile, lpBuffer, dwBufferSize, dwRead, 0) and BOOL(dwRead > 0) do
    begin
      AppProcessMessage;  
      Result := RtlComputeCrc32(Result, lpBuffer, dwRead);
    end;
  finally
    if hHeap <> 0 then
      HeapFree(hHeap, 0, lpBuffer);
    CloseHandle(hFile);
  end;
end;
#endif
}

function CreateAppProcess(appName, commandLine: String; var pProcessInfo:TProcessInfo):Boolean;
var 
  xStartInfo:TStartupInfo;
  bExecuted:Integer;
begin
  xStartInfo.dwFlags := $00000001;                    
  xStartInfo.wShowWindow:=SW_HIDE;
  xStartInfo.cb := sizeof(xStartInfo);
  bExecuted := CreateProcess('' , appName + ' ' + commandLine, 0, 0, True, 0, 0, '', xStartInfo, pProcessInfo);
  if bExecuted = 0 then
  Result := false else
  Result := true;
end;
{
function GetAppExitCodeProcess(ProcInfo:TProcessInfo):DWORD;
var 
  dwExitCode:DWORD;
begin
  if GetExitCodeProcess(ProcInfo.hProcess, dwExitCode) = 0 then
  RaiseException('Function GetExitCodeProcess returned FALSE. This indicates a bug in the script! Please report this error to the author!')
  else
  Result := dwExitCode;
end;
}
function CloseProcessHandles(ProcInfo:TProcessInfo):Bool;
begin
  Result := False;
  WaitForInputIdle(ProcInfo.hProcess, DWORD($FFFFFFFF));
  WaitforSingleObject(ProcInfo.hProcess, DWORD($FFFFFFFF));
  if CloseHandle(ProcInfo.hThread) and CloseHandle(ProcInfo.hProcess) then
  Result := True;
  //else
  //RaiseException('Failed to close process handles! Please report this error to the author!');
end;

function ExtendPath(exPath: String): String;
begin
  if Length(exPath) > 259 then
  if Pos('\\?\',exPath) = 0 then
  exPath := '\\?\' + exPath;
  Result := exPath;
end;

function Size64(LowPart: Longint; HighPart: DWORD): Extended;
begin
  Result := (HighPart + integer(LowPart < 0))*4.294967296E9 + LowPart;
end;

/////////////////////////////////////////////
function FileSizeEx(Filename: String): Int64;
var
  lpFileInformation: WIN32_FILE_ATTRIBUTE_DATA;
begin
  Result:=0;
  if FileExists(ExpandConstant(Filename)) then
  begin
    if GetFileAttributesEx(ExpandConstant(Filename), $0, lpFileInformation) then
    Result := lpFileInformation.nFileSizeLow or (lpFileInformation.nFileSizeHigh shl 32);
  end;
end;

{
function FileSizeEx(FileName: String): Int64;
var
  hFile: THandle;  
  lpFileSize: PLARGE_INTEGER;
begin
  Result := 0;
    hFile := CreateFile(FileName,$80000000,FILE_SHARE_READ,0,OPEN_EXISTING,0,0);
    if (INVALID_HANDLE_VALUE = hFile) then
    begin
      CloseHandle(hFile);
      Exit;
    end;
    if GetFileSizeEx(hFile, lpFileSize) then
    Result := lpFileSize.QuadPart;
  CloseHandle(hFile); 
end;
}

procedure WriteUnicode(sFile,uText: String);
var
  Stream: TFileStream;
begin
  SaveStringToFile(sFile, Chr($FF)+Chr($FE),False); 
  Stream := TFileStream.Create(sFile, fmOpenWrite);
  try      
    Stream.Seek(2, soFromBeginning);
    Stream.WriteBuffer(uText,Length(uText)*2);
  finally
    Stream.Free;
  end;
end;

#ifdef PWP_GetSpaseOnDisk
function GetSpaceForPatch(): Boolean;
var
  Path: String;
  FreeMB, TotalMB: Cardinal;
begin
  Result := False;
  Path := ExtractFileDrive(ResultStr);
  if not GetSpaceOnDisk(Path, True, FreeMB, TotalMB) then
  begin
    #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'GET_SPACE_FAILED', 'Failed to get free space on ', sLang);
      xInfo.Text := Lang;
      xInfo.Update;
      MsgBox(Lang + Path, mbInformation, MB_OK);
    #endif
    #ifdef PWP_SilentFormMode
      Lang := GetIniString('ISPATCH', 'GET_SPACE_FAILED', 'Failed to get free space on ', sLang);
      mStr.Caption := Lang;
      mStr.Refresh;
      Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
      iStr.Caption := Lang;
      iStr.Refresh;
    #endif
    Exit;
  end else 
  if (Round(FreeMB/1024*100)/100 < {#PWP_RequiredSpace}) then
  if FreeMB > 1024 then  
  begin   
    #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'REQUIRED_SPACE', 'Reguired space for successful updating is ', sLang);
      Lang2 := GetIniString('ISPATCH', 'SPACE_GB', 'GB!', sLang);
      Lang3 := GetIniString('ISPATCH', 'SPACE_ONLY', 'There are only ', sLang);
      Lang4 := GetIniString('ISPATCH', 'SPACE_GB_FREE', 'GB free on volume ', sLang);
      xInfo.Text := Lang + '{#PWP_RequiredSpace}' + Lang2 + ' ' + Lang3 + IntToStr(round(FreeMB/1024*100)/100) + Lang4 + Path;
      xInfo.Update;
      MsgBox(Lang + '{#PWP_RequiredSpace}' + Lang2 + #13#13 + Lang3 + IntToStr(round(FreeMB/1024*100)/100) + Lang4 + Path, mbError, MB_OK);
    #endif
    #ifdef PWP_SilentFormMode
      Lang := GetIniString('ISPATCH', 'REQUIRED_SPACE', 'Reguired space for successful updating is ', sLang);
      Lang2 := GetIniString('ISPATCH', 'SPACE_GB', 'GB!', sLang);
      Lang3 := GetIniString('ISPATCH', 'SPACE_FREE_ONLY', 'Free only ', sLang);
      Lang4 := GetIniString('ISPATCH', 'SPACE_GB', 'GB!', sLang);
      mStr.Caption := Lang + '{#PWP_RequiredSpace}' + Lang2 + ' ' + Lang3 + IntToStr(round(FreeMB/1024*100)/100) + Lang4;
      mStr.Refresh;
      Lang := GetIniString('ISPATCH', 'SPACE_FREE_ONLY', 'Free only ', sLang);
      Lang2 := GetIniString('ISPATCH', 'SPACE_GB', 'GB!', sLang);
      iStr.Caption := Lang + IntToStr(round(FreeMB/1024*100)/100) + Lang2;
      iStr.Refresh;
    #endif
  end else
  begin
    #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'REQUIRED_SPACE', 'Reguired space for successful updating is ', sLang);
      Lang2 := GetIniString('ISPATCH', 'SPACE_MB', 'MB!', sLang);
      Lang3 := GetIniString('ISPATCH', 'SPACE_ONLY', 'There are only ', sLang);
      Lang4 := GetIniString('ISPATCH', 'SPACE_MB_FREE', 'MB free on volume ', sLang);
      xInfo.Text := Lang + '{#PWP_RequiredSpace}' + Lang2 + ' ' + Lang3 + IntToStr(FreeMB) + Lang4 + Path;
      xInfo.Update;
      MsgBox(Lang + '{#PWP_RequiredSpace}' + Lang2 + #13#13 + Lang3 + IntToStr(FreeMB) + Lang4 + Path, mbError, MB_OK);
    #endif
    #ifdef PWP_SilentFormMode
      Lang := GetIniString('ISPATCH', 'REQUIRED_SPACE', 'Reguired space for successful updating is ', sLang);
      Lang2 := GetIniString('ISPATCH', 'SPACE_GB', 'GB!', sLang);
      Lang3 := GetIniString('ISPATCH', 'SPACE_FREE_ONLY', 'Free only ', sLang);
      Lang4 := GetIniString('ISPATCH', 'SPACE_MB', 'MB!', sLang);
      mStr.Caption := Lang + '{#PWP_RequiredSpace}' + Lang2 + ' ' + Lang3 + IntToStr(FreeMB) + Lang4;
      mStr.Refresh;
      Lang := GetIniString('ISPATCH', 'SPACE_FREE_ONLY', 'Free only ', sLang);
      Lang2 := GetIniString('ISPATCH', 'SPACE_MB', 'MB!', sLang);
      iStr.Caption := Lang + IntToStr(FreeMB) + Lang2;
      iStr.Refresh;
    #endif
  end else
  Result := True;                                                                         
end;
#endif

#ifdef PWP_FreeArcSupport
function OemToAnsiStr(strSource: AnsiString): AnsiString;
var
  nRet: longint;
begin
  SetLength(Result, Length(strSource));
  nRet := OemToChar(strSource,Result);
end;

function AnsiToUtf8(strSource: string): string;
var
  nRet: integer;
  WideCharBuf: ansistring;
  MultiByteBuf: ansistring;
begin
  strSource:= strSource + chr(0);
  SetLength(WideCharBuf, Length(strSource) * 2);
  SetLength(MultiByteBuf, Length(strSource) * 2);

  nRet:= MultiByteToWideChar(CP_ACP, 0, strSource, -1, WideCharBuf, Length(WideCharBuf));
  nRet:= WideCharToMultiByte(CP_UTF8, 0, WideCharBuf, -1, MultiByteBuf, Length(MultiByteBuf), 0, 0);

  Result:= MultiByteBuf;
end;

// The callback function for getting info about FreeArc archive
function FreeArcInfoCallback (what: PAnsiChar; Mb, sizeArc: Cardinal; str: PAnsiChar): Cardinal;
begin
  if string(what)='origsize'    then origsize := Mb else
  if string(what)='compsize'    then                else
  if string(what)='total_files' then                else
  Result:= CancelCode;
end;

// Returns decompressed size of files in archive
function ArchiveOrigSize(arcname: string): Cardinal;
var
  callback: longword;
begin
  callback:= WrapFreeArcCallback(@FreeArcInfoCallback,4);  
  CancelCode:= 0;
  AppProcessMessage;
  try
    Result:= FreeArcExtract (callback, 'l', '--', AnsiToUtf8(arcname), '', '', '', '', '', '', '');
    if CancelCode < 0 then Result:=CancelCode;
    if Result >= 0 then Result:=origsize;
  except
    Result:= -63;  //    ArcFail
  end;
end;

// The main callback function for unpacking FreeArc Archive
function FreeArcCallback (what: PAnsiChar; Mb, sizeArc: Cardinal; str: PAnsiChar): Cardinal;
begin
  AppProcessMessage;
  if string(what)='filename' then 
  begin
    #ifndef PWP_SilentMode
      #ifndef PWP_SimplyLogSupport
        Lang := GetIniString('ISPATCH', 'EXTRACTING_EXTERNAL_FILE', '--> Extracting file to: ', sLang);
        pLog.Lines.Add(Lang + OemToAnsiStr('"' + ArcPath + '\' + str + '"'));
      #endif
      #ifdef PWP_SimplyLogSupport
        Lang := GetIniString('ISPATCH', 'S_EXTRACTING', '--> Extracting file: ', sLang);
        pLog.Lines.Add(Lang + OemToAnsiStr('"' + str + '"'));
      #endif
    #endif
  end else 
  begin  
    if (string(what)='write') and (totalUncompressedSize > 0) and (Mb > lastMb) then 
    begin
      lastMb := Mb;
      Mb := baseMb+Mb;
      // Update progress bar
      #ifdef PWP_SilentFormMode
      ProgressBar.Position:= Mb;
      SetTaskBarProgressValue(Mb * 100 / totalUncompressedSize);
      #endif
      #ifndef PWP_SilentMode
      ProgressBar.Position:= Mb;
      SetTaskBarProgressValue(Mb * 100 / totalUncompressedSize);
      #endif
    end;
  end;
  Result:= CancelCode;
end;

// Extracts all found Archive
function UnPack(Archive: String): Integer;
var
  totalCompressedSize: Cardinal;
  callback: longword;
begin
  #ifdef PWP_SilentFormMode
  ProgressBar.Position:= 0;
  SetTaskBarProgressValue(0);
  #endif
  #ifndef PWP_SilentMode
  ProgressBar.Position:= 0;
  SetTaskBarProgressValue(0);
  #endif

  totalUncompressedSize := 0;
  totalCompressedSize := FileSizeEx(Archive);
  totalUncompressedSize := ArchiveOrigSize(Archive);

  #ifdef PWP_SilentFormMode
  ProgressBar.Max:= totalUncompressedSize;
  #endif
  #ifndef PWP_SilentMode
  ProgressBar.Max:= totalUncompressedSize;
  #endif
  // Other initializations
  callback:= WrapFreeArcCallback(@FreeArcCallback,4);   

  baseMb := 0;

  begin
    lastMb := 0;
    CancelCode := 0;

    AppProcessMessage;

    try
      Result := FreeArcExtract (callback, 'x', '-o+', '-dp' + AnsiToUtf8(ArcPath), '--', AnsiToUtf8(Archive), '', '', '', '', '');
      if CancelCode < 0 then Result := CancelCode;
    except
      Result:= -63;  //    ArcFail
    end;

    baseMb := baseMb + lastMb;
    // Error occured
    if Result <> 0 then
    begin
      #ifdef PWP_SilentFormMode
      Lang := GetIniString('ISPATCH', 'EXTRACTING_ERROR2', 'Error ocurred while extracting archive!', sLang);
      mStr.Caption := Lang;
      mStr.Refresh;
      Lang := GetIniString('ISPATCH', 'EXTRACTING_ERROR3', 'Maybe archive is corrupt or not enough free space!', sLang);
      iStr.Caption := Lang;
      iStr.Refresh;
      #endif
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'EXTRACTING_ERROR', '[!]  Decompression failed! Maybe archive is corrupt or not enough free space!', sLang);
      pLog.Lines.Add(Lang);
      #endif
      Exit;
    end;
  end;
  // Hide labels and button
end;
#endif

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function CopyProgressRoutine(TotalFileSizeLo, TotalFileSizeHi, TotalBytesTransferredLo, TotalBytesTransferredHi, StreamSizeLo, StreamSizeHi, StreamBytesTransferredLo, StreamBytesTransferredHi: Longint; dwStreamNumber, dwCallbackReason: DWORD; hSourceFile, hDestinationFile: THandle; lpData: Longint): DWORD;
begin
  if bCancel then Result := PROGRESS_CANCEL else Result := PROGRESS_CONTINUE;
  case dwCallbackReason of
      CALLBACK_CHUNK_FINISHED: begin
      #ifdef PWP_SilentFormMode
      AppProcessMessage;
      ProgressBar.Position := Round(100*Size64(TotalBytesTransferredLo, TotalBytesTransferredHi)/Size64(TotalFileSizeLo, TotalFileSizeHi));
      SetTaskBarProgressValue(Round(100*Size64(TotalBytesTransferredLo, TotalBytesTransferredHi)/Size64(TotalFileSizeLo, TotalFileSizeHi))); 
      #endif
      #ifndef PWP_SilentMode
      AppProcessMessage;
      ProgressBar.Position := Round(100*Size64(TotalBytesTransferredLo, TotalBytesTransferredHi)/Size64(TotalFileSizeLo, TotalFileSizeHi));
      SetTaskBarProgressValue(Round(100*Size64(TotalBytesTransferredLo, TotalBytesTransferredHi)/Size64(TotalFileSizeLo, TotalFileSizeHi))); 
      #endif
    end;
  end;
end;
///////////////////////////////////////////////
//procedure CancelButtonOnClick(Sender: TObject);
//begin
//    bCancel := True;
//end;
////////////////////////////////////////////////////////////////////////////////////////////////////////
function FindFiles(const pFrom, pTo: String; const Recurse: Boolean; const szRootDir: String): Cardinal;
var
  FR: TFindRec;
  szFileName,BPath: String;
begin
  bCancel := False;
  if FindFirst(ExtendPath(pFrom), FR) then
  try
      repeat 
      AppProcessMessage;  
          if (FR.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0) then
          begin
            pFrom := pFrom;
            while Pos('\\?\',pFrom) > 0 do
            Delete(pFrom,Pos('\\?\',pFrom),4);

            if not DirExists(ExtendPath(Format('%s\%s', [pTo, ExtractRelativePath(szRootDir, ExtractFilePath(pFrom))]))) then 
            ForceDirectories(ExtendPath(Format('%s\%s', [pTo, ExtractRelativePath(szRootDir, ExtractFilePath(pFrom))])));
   
            szFileName := ExtendPath(Format('%s\%s', [ExtractFileDir(pFrom), FR.Name]));

            BPath := szFileName;
            while Pos('\\?\',BPath) > 0 do
            Delete(BPath,Pos('\\?\',BPath),4);

            #ifdef PWP_SilentFormMode
              ProgressBar.Min := 0;
              ProgressBar.Max := 100;
            #endif
            #ifndef PWP_SilentMode
              ProgressBar.Min := 0;
              ProgressBar.Max := 100;
            #endif

            copycallback := WrapMyCopyCallback(@CopyProgressRoutine,13); //Our proc has 13 arguments

            #ifndef PWP_SilentMode
              #ifndef PWP_SimplyLogSupport
                Lang := GetIniString('ISPATCH', 'COPYING_EXTERNAL_FILE', '--> Copying file to: ', sLang); 
                pLog.Lines.Add(Lang + '"' + pTo +'\' +ExtractRelativePath(szRootDir, BPath)+'"');
              #endif
              #ifdef PWP_SimplyLogSupport
                Lang := GetIniString('ISPATCH', 'S_COPYING_EXTERNAL', '--> Copying external file: ', sLang); 
                pLog.Lines.Add(Lang + '"' + ExtractRelativePath(szRootDir, BPath) + '"');
              #endif
            #endif

            if FileExists(ExtendPath(ResultStr + '\' + ExtractRelativePath(szRootDir, BPath))) then
            SetFileAttributes(ExtendPath(ResultStr + '\' + ExtractRelativePath(szRootDir, BPath)),$80); 

            if not CopyFileEx(ExtendPath(Format('%s\%s', [ExtractFileDir(pFrom), FR.Name])), ExtendPath(Format('%s\%s%s', [pTo, ExtractRelativePath(szRootDir, ExtractFilePath(pFrom)), FR.Name])), copycallback, 0, bCancel, 0) then
            begin
              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'COPYING_EXTERNAL_FILE_FAILED', '[!]  Some error ocurred while copying file: ', sLang); 
              pLog.Lines.Add(Lang + '"'+BPath+'"');
              #endif
              inc(z); 
              bCancel := True;
              #ifdef PWP_SilentFormMode
              SetTaskBarProgressState(4);
              SetTaskBarProgressValue(100); 
              #endif
              #ifndef PWP_SilentMode
              SetTaskBarProgressState(4);
              SetTaskBarProgressValue(100); 
              #endif
              Exit; 
            end;

            Result := DLLGetLastError;
        
            if bCancel then Exit;
          end;
      until not FindNext(FR);
  finally
    FindClose(FR);
  end;
  //
  if not Recurse then Exit;
  if FindFirst(ExtendPath(Format('%s\*', [ExtractFileDir(pFrom)])), FR) then
  try
    repeat
    AppProcessMessage;
      if (FR.Attributes and FILE_ATTRIBUTE_DIRECTORY <> 0) and (FR.Name <> '.') and (FR.Name <> '..') then
      FindFiles(ExtendPath(Format('%s\%s\%s', [ExtractFileDir(pFrom), FR.Name, ExtractFileName(pFrom)])), pTo, Recurse, szRootDir);
    until not FindNext(FR);
  finally
    FindClose(FR);
  end;
end;

///////////////////////////////////////////////////////////////////////////
function xcopy(const pFrom, pTo: String; const Recurse: Boolean): Cardinal;
// pFrom - source path. wildcard allowed
// pTo - destination path
// Recurse - recursion flag
begin
  if PathIsDirectory(pFrom) then
  begin
    if not DirExists(pFrom) then Exit;
    pFrom := Format('%s\*', [pFrom]);
  end else if not DirExists(ExtractFileDir(pFrom)) then Exit;
  Result := FindFiles(pFrom, pTo, Recurse, ExtractFilePath(pFrom));
end;

{
function IsProcessRunning(FileName: String): Boolean;
var
  objSWbemLocator, objSWbemServices: Variant;
begin
  try
    objSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  except
    ShowExceptionMessage;
    Exit;
  end;
  objSWbemServices := objSWbemLocator.ConnectServer();
  objSWbemServices.Security_.ImpersonationLevel := 3;
  Result := (objSWbemServices.ExecQuery('SELECT * FROM Win32_Process WHERE Name="' + FileName + '"').Count > 0);
end;
}

#ifndef PWP_MultiVersionMode
procedure RollBack;
begin
  // - VERIFIED -
  if IniKeyExists('TOTALVER','VER',ExpandConstant('{tmp}') + '\Checker.ini') then
  begin
    t := 0;

    #ifndef PWP_SilentMode
    pLog.Lines.Add('');
    Lang := GetIniString('ISPATCH', 'PATCH_UNSUCCESS', 'Errors ocurred during patching!', sLang); 
    pLog.Lines.Add(Lang); 
    pLog.Lines.Add('');
    Lang := GetIniString('ISPATCH', 'ROLLBACK_STARTED', 'Rollback started!', sLang);
    pLog.Lines.Add(Lang); 
    #endif

    #ifdef PWP_SilentFormMode
    ProgressBar.Min := 0;
    ProgressBar.Max := pCount;
    ProgressBar.Position := pCount;
    #endif
    #ifndef PWP_SilentMode
    ProgressBar.Min := 0;
    ProgressBar.Max := pCount;
    ProgressBar.Position := pCount;
    #endif

    repeat
    AppProcessMessage;

    ini := GetIniString('VERIFIED', IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');

    if FileExists(ExtendPath(ResultStr + BACKUP_DIR + ini)) then
    begin
      ForceDirectories(ExtendPath(ExtractFilePath(ResultStr + ini))); 

      SetFileAttributes(ExtendPath(ResultStr + ini),$80);     
          
      if not FileCopy(ExtendPath(ResultStr + BACKUP_DIR + ini),ExtendPath(ResultStr + ini), False) then
      begin
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'FAILED_TO_ROLLBACK', 'Error: Failed to rollback from: ', sLang);
        Lang2 := GetIniString('ISPATCH', 'FAILED_TO_ROLLBACK2', ' file to: ', sLang);
        pLog.Lines.Add(Lang +'"'+ ResultStr + BACKUP_DIR + ini +'"'+ Lang2 +'"'+ ResultStr + ini +'"');   
        #endif
      end else
      begin
        #ifndef PWP_SilentMode
          #ifndef PWP_SimplyLogSupport
            Lang := GetIniString('ISPATCH', 'ROLLBACK_SUCCESS', 'Rollback: ', sLang);
            Lang2 := GetIniString('ISPATCH', 'ROLLBACK_SUCCESS2', ' to: ', sLang);
            Lang3 := GetIniString('ISPATCH', 'ROLLBACK_SUCCESS3', ' success.', sLang);
            pLog.Lines.Add(Lang +'"'+ ResultStr + BACKUP_DIR + ini +'"'+ Lang2 +'"'+ ResultStr + ini +'"'+ Lang3);  
          #endif
          #ifdef PWP_SimplyLogSupport
            Lang := GetIniString('ISPATCH', 'S_ROLLBACK', '--> Rollback file: ', sLang);
            s_basePath := ini;
            Delete(s_basePath,1,1);
            pLog.Lines.Add(Lang +'"'+ s_basePath +'"');  
          #endif
        #endif
      end;
    end;
                   
    inc(t);

    #ifdef PWP_SilentFormMode
    ProgressBar.Position := pCount - t;
    SetTaskBarProgressValue(100 - (t * 100 / pCount));
    #endif
    #ifndef PWP_SilentMode
    ProgressBar.Position := pCount - t;
    SetTaskBarProgressValue(100 - (t * 100 / pCount));
    #endif

    until t >= pCount;

  end;

  // - INCLUDED -
  if IniKeyExists('TOTALINC','INC',ExpandConstant('{tmp}') + '\Checker.ini') then
  begin
    t := 0;

    #ifdef PWP_SilentFormMode
    ProgressBar.Min := 0;
    ProgressBar.Max := iCount;
    ProgressBar.Position := iCount;
    #endif
    #ifndef PWP_SilentMode
    ProgressBar.Min := 0;
    ProgressBar.Max := iCount;
    ProgressBar.Position := iCount;
    #endif

    repeat
    AppProcessMessage;

    ini := GetIniString('INCLUDED', IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');

    if FileExists(ExtendPath(ResultStr + ini)) then
    begin 
      SetFileAttributes(ExtendPath(ResultStr + ini),$80);   

      if not DeleteFile(ExtendPath(ResultStr + ini)) then
      begin
         #ifndef PWP_SilentMode
         Lang := GetIniString('ISPATCH', 'FAILED_TO_DELETE_INCLUDED', 'Error: Failed to delete included: ', sLang);
         pLog.Lines.Add(Lang +'"'+ ResultStr + ini +'"');  
         #endif
      end else
      begin
        if FileExists(ExtendPath(ResultStr + BACKUP_DIR + ini)) then
        begin
          ForceDirectories(ExtendPath(ExtractFilePath(ResultStr + ini))); 
          MoveFileEx(ExtendPath(ResultStr + BACKUP_DIR + ini),ExtendPath(ResultStr + ini), $1 or $2);
        end;

        #ifndef PWP_SilentMode
           #ifndef PWP_SimplyLogSupport
              Lang := GetIniString('ISPATCH', 'INCLUDED_DELETED_SUCCESS', 'Included: ', sLang);
              Lang2 := GetIniString('ISPATCH', 'INCLUDED_DELETED_SUCCESS2', ' deleted success.', sLang);
              pLog.Lines.Add(Lang +'"'+ ResultStr + ini +'"'+ Lang2);  
           #endif
           #ifdef PWP_SimplyLogSupport
              Lang := GetIniString('ISPATCH', 'S_DELETING', '--> Deleting file: ', sLang);
              s_basePath := ini;
              Delete(s_basePath,1,1);
              pLog.Lines.Add(Lang +'"'+ s_basePath +'"');  
           #endif
        #endif
        if DirExists(ExtendPath(ExtractFileDir(ResultStr + ini))) then
        begin
          if RemoveDir(ExtendPath(ExtractFileDir(ResultStr + ini))) then
          begin
            #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'INCLUDED_DIR_DELETED', 'Included dir: ', sLang);
              Lang2 := GetIniString('ISPATCH', 'INCLUDED_DIR_DELETED2', ' is empty and was deleted success.', sLang);
              pLog.Lines.Add(Lang +'"'+ ExtractFileDir(ResultStr + ini) +'"'+ Lang2); 
            #endif
          end;
        end;
      end;
    end;

    inc(t);

    #ifdef PWP_SilentFormMode
    ProgressBar.Position := iCount - t;
    SetTaskBarProgressValue(100 - (t * 100 / iCount));
    #endif
    #ifndef PWP_SilentMode
    ProgressBar.Position := iCount - t;
    SetTaskBarProgressValue(100 - (t * 100 / iCount));
    #endif

    until t >= iCount;

  end;

  #ifdef PWP_JunkedFilesProcessing
  ////// Junked restoring
  if IniKeyExists('TOTALOLD','OLD',ExpandConstant('{tmp}') + '\Checker.ini') then
  begin
    t := 0;

    #ifdef PWP_SilentFormMode
    ProgressBar.Min := 0;
    ProgressBar.Max := jCount;
    ProgressBar.Position := jCount;
    #endif
    #ifndef PWP_SilentMode
    ProgressBar.Min := 0;
    ProgressBar.Max := jCount;
    ProgressBar.Position := jCount;
    #endif

    repeat
    AppProcessMessage;

    ini := GetIniString('JUNKED', IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');

    if FileExists(ExtendPath(ResultStr + BACKUP_DIR + ini)) then
    begin
      ForceDirectories(ExtendPath(ExtractFilePath(ResultStr + ini))); 

      SetFileAttributes(ExtendPath(ResultStr + ini),$80);

      if not FileCopy(ExtendPath(ResultStr + BACKUP_DIR + ini), ExtendPath(ResultStr + ini), False) then
      begin
         #ifndef PWP_SilentMode
         Lang := GetIniString('ISPATCH', 'FAILED_TO_RESTORE', 'Error: Failed to restore junked file from: ', sLang);
         Lang2 := GetIniString('ISPATCH', 'FAILED_TO_RESTORE2', ' to: ', sLang);
         pLog.Lines.Add(Lang +'"'+ ResultStr + BACKUP_DIR + ini +'"'+ Lang2 +'"'+ ResultStr + ini +'"');   
         #endif
      end else
      begin
        #ifndef PWP_SilentMode
          #ifndef PWP_SimplyLogSupport
            Lang := GetIniString('ISPATCH', 'JUNKED_RESTORED', 'Junked file: ', sLang);
            Lang2 := GetIniString('ISPATCH', 'JUNKED_RESTORED2', ' is restored successfull.', sLang);
            pLog.Lines.Add(Lang +'"'+ ResultStr + ini +'"'+ Lang2);  
          #endif
          #ifdef PWP_SimplyLogSupport
            Lang := GetIniString('ISPATCH', 'S_JUNKED_RESTORED', '--> Restored junked file: ', sLang);
            s_basePath := ini;
            Delete(s_basePath,1,1);
            pLog.Lines.Add(Lang +'"'+ s_basePath +'"');  
          #endif
        #endif
      end;
    end;

    inc(t);

    #ifdef PWP_SilentFormMode
    ProgressBar.Position := jCount - t;
    SetTaskBarProgressValue(100 - (t * 100 / jCount));
    #endif
    #ifndef PWP_SilentMode
    ProgressBar.Position := jCount - t;
    SetTaskBarProgressValue(100 - (t * 100 / jCount));
    #endif

    until t >= jCount;

    #ifdef PWP_JunkedDirsProcessing
    if IniKeyExists('TOTALOLD','OLD_DIRS',ExpandConstant('{tmp}') + '\Checker.ini') then
    begin
      t := 0;
      repeat
      AppProcessMessage;
      ini := GetIniString('JUNKED_DIRS', IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');
      if DirExists(ExtendPath(ResultStr + BACKUP_DIR + ini)) then
        ForceDirectories(ExtendPath(ResultStr + ini));
      inc(t);
      until t >= jdCount;
    end;
    #endif

  end;
  #endif

  #ifdef PWP_SilentFormMode
  SetTaskBarProgressValue(0);
  #endif
  #ifndef PWP_SilentMode
  SetTaskBarProgressValue(0);
  #endif

  #ifndef PWP_SilentMode
  Lang := GetIniString('ISPATCH', 'ROLLBACK_ERROR', 'Error while patching was ocurred and Patch apply the rollback.', sLang);
  Lang2 := GetIniString('ISPATCH', 'ROLLBACK_ERROR2', 'Rollback of modified files is complete. Included files was deleted.', sLang); 
  Lang3 := GetIniString('ISPATCH', 'ROLLBACK_ERROR3', 'Remove backup dir: ', sLang);
  Lang4 := GetIniString('ISPATCH', 'ROLLBACK_ERROR4', 'totally with all included files and subdirs?', sLang);
  if MsgBox(Lang + #13#13 + Lang2 + #13#13 + Lang3 +'"'+ ResultStr + BACKUP_DIR +'"'+ #13#13 + Lang4, mbError, mb_yesno) = idyes then
  #endif
  begin
    if DelTree(ExtendPath(ResultStr + BACKUP_DIR), True, True, True) then
    begin
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'BACKUP_DIR_DELETED', 'Backup dir: ', sLang);
      Lang2 := GetIniString('ISPATCH', 'BACKUP_DIR_DELETED2', ' was deleted.', sLang);
      pLog.Lines.Add(Lang +'"'+ResultStr +BACKUP_DIR +'"'+ Lang2); 
      #endif
    end else
    begin
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'BACKUP_DIR_DELETED_NOT_FULLY', 'Backup dir: ', sLang);
      Lang2 := GetIniString('ISPATCH', 'BACKUP_DIR_DELETED_NOT_FULLY2', ' was cleared but some used files or folders unable to delete. Check this dir for details.', sLang);
      pLog.Lines.Add(Lang +'"'+ ResultStr +BACKUP_DIR +'"'+ Lang2); 
      #endif
    end
  end;

  #ifndef PWP_SilentMode
  Lang := GetIniString('ISPATCH', 'ROLLBACK_FINISHED', 'Rollback finished!', sLang);
  pLog.Lines.Add(Lang); 
  pLog.Lines.Add('');
  Lang := GetIniString('ISPATCH', 'PATCHING_FINIFHED_WITH_ERRORS', 'Patching finished with errors!', sLang);
  pLog.Lines.Add(Lang);
  Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang); 
  xInfo.Text := Lang;
  xInfo.Update;
  #endif

  #ifndef PWP_SilentMode
  if cb_log.checked then
  begin
    //SaveStringsToFile(ExtendPath(ResultStr + '\{#PWP_PatchLogName}.txt'), [pLog.Text],False);
    pLog.Lines.Add(''); 
    Lang := GetIniString('ISPATCH', 'PATCHING_LOG', 'Patching log saved to: ', sLang + ' ' + GetDateTimeString('dd/mm/yyyy hh:nn:ss', '.', '-'));
    pLog.Lines.Add(Lang);
    pLog.Lines.Add('--> ' + '"'+ ResultStr + '\{#PWP_PatchLogName} '+GetDateTimeString('dd/mm/yyyy hh:nn:ss', '.', '-')+'.txt'+'"');
    WriteUnicode(ExtendPath(ResultStr + '\{#PWP_PatchLogName} '+GetDateTimeString('dd/mm/yyyy hh:nn:ss', '.', '-')+'.txt'),pLog.Text);
  end;
  #endif

end;
#endif

#ifdef PWP_MultiVersionMode
procedure RollBack;
begin
     // - VERIFIED -
  if IniKeyExists('TOTALVER' + fVer,'VER',ExpandConstant('{tmp}') + '\Checker.ini') then
  begin
    t := 0;

    #ifndef PWP_SilentMode
    pLog.Lines.Add('');
    Lang := GetIniString('ISPATCH', 'PATCH_UNSUCCESS', 'Errors ocurred during patching!', sLang); 
    pLog.Lines.Add(Lang); 
    pLog.Lines.Add('');
    Lang := GetIniString('ISPATCH', 'ROLLBACK_STARTED', 'Rollback started!', sLang);
    pLog.Lines.Add(Lang); 
    #endif

    #ifdef PWP_SilentFormMode
    ProgressBar.Min := 0;
    ProgressBar.Max := pCount;
    ProgressBar.Position := pCount;
    #endif
    #ifndef PWP_SilentMode
    ProgressBar.Min := 0;
    ProgressBar.Max := pCount;
    ProgressBar.Position := pCount;
    #endif

    repeat
    AppProcessMessage;

    ini := GetIniString('VERIFIED' + fVer, IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');

    if FileExists(ExtendPath(ResultStr + BACKUP_DIR + ini)) then
    begin
      ForceDirectories(ExtendPath(ExtractFilePath(ResultStr + ini))); 

      SetFileAttributes(ExtendPath(ResultStr + ini),$80);     
          
      if not FileCopy(ExtendPath(ResultStr + BACKUP_DIR + ini),ExtendPath(ResultStr + ini), False) then
      begin
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'FAILED_TO_ROLLBACK', 'Error: Failed to rollback from: ', sLang);
        Lang2 := GetIniString('ISPATCH', 'FAILED_TO_ROLLBACK2', ' file to: ', sLang);
        pLog.Lines.Add(Lang +'"'+ ResultStr + BACKUP_DIR + ini +'"'+ Lang2 +'"'+ ResultStr + ini +'"');   
        #endif
      end else
      begin
        #ifndef PWP_SilentMode
          #ifndef PWP_SimplyLogSupport
            Lang := GetIniString('ISPATCH', 'ROLLBACK_SUCCESS', 'Rollback: ', sLang);
            Lang2 := GetIniString('ISPATCH', 'ROLLBACK_SUCCESS2', ' to: ', sLang);
            Lang3 := GetIniString('ISPATCH', 'ROLLBACK_SUCCESS3', ' success.', sLang);
            pLog.Lines.Add(Lang +'"'+ ResultStr + BACKUP_DIR + ini +'"'+ Lang2 +'"'+ ResultStr + ini +'"'+ Lang3);  
          #endif
          #ifdef PWP_SimplyLogSupport
            Lang := GetIniString('ISPATCH', 'S_ROLLBACK', '--> Rollback file: ', sLang);
            s_basePath := ini;
            Delete(s_basePath,1,1);
            pLog.Lines.Add(Lang +'"'+ s_basePath +'"');  
          #endif
        #endif
      end;
      end;
                   
    inc(t);

    #ifdef PWP_SilentFormMode
    ProgressBar.Position := pCount - t;
    SetTaskBarProgressValue(100 - (t * 100 / pCount));
    #endif
    #ifndef PWP_SilentMode
    ProgressBar.Position := pCount - t;
    SetTaskBarProgressValue(100 - (t * 100 / pCount));
    #endif

    until t >= pCount;

  end;

  // - INCLUDED -
  if IniKeyExists('TOTALINC' + fVer,'INC',ExpandConstant('{tmp}') + '\Checker.ini') then
  begin
    t := 0;

    #ifdef PWP_SilentFormMode
    ProgressBar.Min := 0;
    ProgressBar.Max := iCount;
    ProgressBar.Position := iCount;
    #endif
    #ifndef PWP_SilentMode
    ProgressBar.Min := 0;
    ProgressBar.Max := iCount;
    ProgressBar.Position := iCount;
    #endif

    repeat
    AppProcessMessage;

    ini := GetIniString('INCLUDED' + fVer, IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');

    if FileExists(ExtendPath(ResultStr + ini)) then
    begin 

      SetFileAttributes(ExtendPath(ResultStr + ini),$80);   

      if not DeleteFile(ExtendPath(ResultStr + ini)) then
      begin
         #ifndef PWP_SilentMode
         Lang := GetIniString('ISPATCH', 'FAILED_TO_DELETE_INCLUDED', 'Error: Failed to delete included: ', sLang);
         pLog.Lines.Add(Lang +'"'+ ResultStr + ini +'"');  
         #endif
      end else
      begin
        if FileExists(ExtendPath(ResultStr + BACKUP_DIR + ini)) then
        begin
          ForceDirectories(ExtendPath(ExtractFilePath(ResultStr + ini))); 
          MoveFileEx(ExtendPath(ResultStr + BACKUP_DIR + ini),ExtendPath(ResultStr + ini), $1 or $2);
        end;

        #ifndef PWP_SilentMode
          #ifndef PWP_SimplyLogSupport
            Lang := GetIniString('ISPATCH', 'INCLUDED_DELETED_SUCCESS', 'Included: ', sLang);
            Lang2 := GetIniString('ISPATCH', 'INCLUDED_DELETED_SUCCESS2', ' deleted success.', sLang);
            pLog.Lines.Add(Lang +'"'+ ResultStr + ini +'"'+ Lang2);  
          #endif
          #ifdef PWP_SimplyLogSupport
            Lang := GetIniString('ISPATCH', 'S_DELETING', '--> Deleting file: ', sLang);
            s_basePath := ini;
            Delete(s_basePath,1,1);
            pLog.Lines.Add(Lang +'"'+ s_basePath +'"');   
          #endif
        #endif
        if DirExists(ExtendPath(ExtractFileDir(ResultStr + ini))) then
        begin
          if RemoveDir(ExtendPath(ExtractFileDir(ResultStr + ini))) then
          begin
            #ifndef PWP_SilentMode
            Lang := GetIniString('ISPATCH', 'INCLUDED_DIR_DELETED', 'Included dir: ', sLang);
            Lang2 := GetIniString('ISPATCH', 'INCLUDED_DIR_DELETED2', ' is empty and was deleted success.', sLang);
            pLog.Lines.Add(Lang +'"'+ ExtractFileDir(ResultStr + ini) +'"'+ Lang2); 
            #endif
          end;
        end;
      end;
    end;

    inc(t);

    #ifdef PWP_SilentFormMode
    ProgressBar.Position := iCount - t;
    SetTaskBarProgressValue(100 - (t * 100 / iCount));
    #endif
    #ifndef PWP_SilentMode
    ProgressBar.Position := iCount - t;
    SetTaskBarProgressValue(100 - (t * 100 / iCount));
    #endif

    until t >= iCount;
  end;

  #ifdef PWP_JunkedFilesProcessing
  ////// Junked restoring
  if IniKeyExists('TOTALOLD' + fVer,'OLD',ExpandConstant('{tmp}') + '\Checker.ini') then
  begin
    t := 0;

    #ifdef PWP_SilentFormMode
    ProgressBar.Min := 0;
    ProgressBar.Max := jCount;
    ProgressBar.Position := jCount;
    #endif
    #ifndef PWP_SilentMode
    ProgressBar.Min := 0;
    ProgressBar.Max := jCount;
    ProgressBar.Position := jCount;
    #endif

    repeat
    AppProcessMessage;

    ini := GetIniString('JUNKED' + fVer, IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');

    if FileExists(ExtendPath(ResultStr + BACKUP_DIR + ini)) then
    begin
      ForceDirectories(ExtendPath(ExtractFilePath(ResultStr + ini))); 

      SetFileAttributes(ExtendPath(ResultStr + ini),$80);

      if not FileCopy(ExtendPath(ResultStr + BACKUP_DIR + ini), ExtendPath(ResultStr + ini), False) then
      begin
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'FAILED_TO_RESTORE', 'Error: Failed to restore junked file from: ', sLang);
        Lang2 := GetIniString('ISPATCH', 'FAILED_TO_RESTORE2', ' to: ', sLang);
        pLog.Lines.Add(Lang +'"'+ ResultStr + BACKUP_DIR + ini +'"'+ Lang2 +'"'+ ResultStr + ini +'"');   
        #endif
      end else
      begin
        #ifndef PWP_SilentMode
          #ifndef PWP_SimplyLogSupport
            Lang := GetIniString('ISPATCH', 'JUNKED_RESTORED', 'Junked file: ', sLang);
            Lang2 := GetIniString('ISPATCH', 'JUNKED_RESTORED2', ' is restored successfull.', sLang);
            pLog.Lines.Add(Lang +'"'+ ResultStr + ini +'"'+ Lang2);  
          #endif
          #ifdef PWP_SimplyLogSupport
            Lang := GetIniString('ISPATCH', 'S_JUNKED_RESTORED', '--> Restored junked file: ', sLang);
            s_basePath := ini;
            Delete(s_basePath,1,1);
            pLog.Lines.Add(Lang +'"'+ s_basePath +'"');  
          #endif
        #endif
      end;
    end;

    inc(t);

    #ifdef PWP_SilentFormMode
    ProgressBar.Position := jCount - t;
    SetTaskBarProgressValue(100 - (t * 100 / jCount));
    #endif
    #ifndef PWP_SilentMode
    ProgressBar.Position := jCount - t;
    SetTaskBarProgressValue(100 - (t * 100 / jCount));
    #endif

    until t >= jCount;

    #ifdef PWP_JunkedDirsProcessing
    if IniKeyExists('TOTALOLD' + fVer,'OLD_DIRS',ExpandConstant('{tmp}') + '\Checker.ini') then
    begin
      t := 0;
      repeat
      AppProcessMessage;
      ini := GetIniString('JUNKED_DIRS', IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');
      if DirExists(ExtendPath(ResultStr + BACKUP_DIR + ini)) then
        ForceDirectories(ExtendPath(ResultStr + ini));
      inc(t);
      until t >= jdCount;
    end;
    #endif

  end;
  #endif

  #ifdef PWP_SilentFormMode
  SetTaskBarProgressValue(0);
  #endif
  #ifndef PWP_SilentMode
  SetTaskBarProgressValue(0);
  #endif

  #ifndef PWP_SilentMode
  Lang := GetIniString('ISPATCH', 'ROLLBACK_ERROR', 'Error while patching was ocurred and Patch apply the rollback.', sLang);
  Lang2 := GetIniString('ISPATCH', 'ROLLBACK_ERROR2', 'Rollback of modified files is complete. Included files was deleted.', sLang); 
  Lang3 := GetIniString('ISPATCH', 'ROLLBACK_ERROR3', 'Remove backup dir: ', sLang);
  Lang4 := GetIniString('ISPATCH', 'ROLLBACK_ERROR4', 'totally with all included files and subdirs?', sLang);
  if MsgBox(Lang + #13#13 + Lang2 + #13#13 + Lang3 +'"'+ ResultStr + BACKUP_DIR +'"'+ #13#13 + Lang4, mbError, mb_yesno) = idyes then
  #endif
  begin
    if DelTree(ExtendPath(ResultStr + BACKUP_DIR), True, True, True) then
    begin
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'BACKUP_DIR_DELETED', 'Backup dir: ', sLang);
      Lang2 := GetIniString('ISPATCH', 'BACKUP_DIR_DELETED2', ' was deleted.', sLang);
      pLog.Lines.Add(Lang +'"'+ResultStr +BACKUP_DIR +'"'+ Lang2); 
      #endif
    end else
    begin
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'BACKUP_DIR_DELETED_NOT_FULLY', 'Backup dir: ', sLang);
      Lang2 := GetIniString('ISPATCH', 'BACKUP_DIR_DELETED_NOT_FULLY2', ' was cleared but some used files or folders unable to delete. Check this dir for details.', sLang);
      pLog.Lines.Add(Lang +'"'+ ResultStr +BACKUP_DIR +'"'+ Lang2); 
      #endif
    end
  end;

  #ifndef PWP_SilentMode
  Lang := GetIniString('ISPATCH', 'ROLLBACK_FINISHED', 'Rollback finished!', sLang);
  pLog.Lines.Add(Lang); 
  pLog.Lines.Add('');
  Lang := GetIniString('ISPATCH', 'PATCHING_FINIFHED_WITH_ERRORS', 'Patching finished with errors!', sLang);
  pLog.Lines.Add(Lang);
  Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang); 
  xInfo.Text := Lang;
  xInfo.Update;
  #endif

  #ifndef PWP_SilentMode
  if cb_log.checked then
  begin
    //SaveStringsToFile(ExtendPath(ResultStr + '\{#PWP_PatchLogName}.txt'), [pLog.Text],False);
    pLog.Lines.Add(''); 
    Lang := GetIniString('ISPATCH', 'PATCHING_LOG', 'Patching log saved to: ', sLang + ' ' + GetDateTimeString('dd/mm/yyyy hh:nn:ss', '.', '-'));
    pLog.Lines.Add(Lang);
    pLog.Lines.Add('--> ' + '"'+ ResultStr + '\{#PWP_PatchLogName} '+GetDateTimeString('dd/mm/yyyy hh:nn:ss', '.', '-')+'.txt'+'"');
    WriteUnicode(ExtendPath(ResultStr + '\{#PWP_PatchLogName} '+GetDateTimeString('dd/mm/yyyy hh:nn:ss', '.', '-')+'.txt'),pLog.Text);
  end;
  #endif

end;
#endif

procedure InsertCodeOnStartup;
{#PWP_InsertCodeVarStartup}
begin
{#PWP_InsertCodeStartup}
#ifdef PWP_BatchCodeSupport
#ifdef PWP_ExternalTemp
   Exec(ExpandConstant('{tmp}') + '\OnStartupCode.bat','', ExpandConstant('{tmp}'), {#PWP_SW_STATE_STARTUP}, ewWaitUntilTerminated, ResultCode);
#endif
#ifndef PWP_ExternalFilesSupport 
   Exec(ExpandConstant('{tmp}\OnStartupCode.bat'),'', ExpandConstant('{tmp}'), {#PWP_SW_STATE_STARTUP}, ewWaitUntilTerminated, ResultCode);
#endif
#ifndef PWP_ExternalTemp
#ifdef PWP_ExternalFilesSupport 
   ctstr := ExpandConstant('{src}'); 

   if ctstr = ExtractFileDir(ctstr) then
   ctstr := RemoveBackslash(ctstr);

   Exec(ctstr + '\{#PWP_ExternalDirName}' + '\OnStartupCode.bat','', ctstr + '\{#PWP_ExternalDirName}', {#PWP_SW_STATE_STARTUP}, ewWaitUntilTerminated, ResultCode);
#endif
#endif
#endif
end;

procedure InsertCodeBeforeUpdate;
{#PWP_InsertCodeVarBefore}
begin
{#PWP_InsertCodeBefore}
#ifdef PWP_BatchCodeSupport

#ifdef PWP_ExternalTemp
   #ifndef PWP_ExecuteBatchBefore
   Exec(ExpandConstant('{tmp}') + '\OnBeforeCode.bat','', ExpandConstant('{tmp}'), {#PWP_SW_STATE_BEFORE}, ewWaitUntilTerminated, ResultCode);
   #endif

   #ifdef PWP_ExecuteBatchBefore
   FileCopy(ExpandConstant('{tmp}') + '\OnBeforeCode.bat', ExtendPath(ResultStr + '\OnBeforeCode.bat'), False);
   Exec(ExtendPath(ResultStr + '\OnBeforeCode.bat'),'', ExtendPath(ResultStr), {#PWP_SW_STATE_BEFORE}, ewWaitUntilTerminated, ResultCode);
   DeleteFile(ExtendPath(ResultStr + '\OnBeforeCode.bat')); 
   #endif
#endif

#ifndef PWP_ExternalFilesSupport 
   #ifndef PWP_ExecuteBatchBefore
   Exec(ExpandConstant('{tmp}\OnBeforeCode.bat'),'', ExpandConstant('{tmp}'), {#PWP_SW_STATE_BEFORE}, ewWaitUntilTerminated, ResultCode);
   #endif

   #ifdef PWP_ExecuteBatchBefore
   FileCopy(ExpandConstant('{tmp}') + '\OnBeforeCode.bat', ExtendPath(ResultStr + '\OnBeforeCode.bat'), False);
   Exec(ExtendPath(ResultStr + '\OnBeforeCode.bat'),'', ExtendPath(ResultStr), {#PWP_SW_STATE_BEFORE}, ewWaitUntilTerminated, ResultCode);
   DeleteFile(ExtendPath(ResultStr + '\OnBeforeCode.bat')); 
   #endif
#endif

#ifndef PWP_ExternalTemp
#ifdef PWP_ExternalFilesSupport 
   ctstr := ExpandConstant('{src}'); 
   if ctstr = ExtractFileDir(ctstr) then
   ctstr := RemoveBackslash(ctstr);

   #ifndef PWP_ExecuteBatchBefore
   Exec(ctstr + '\{#PWP_ExternalDirName}' + '\OnBeforeCode.bat','', ctstr + '\{#PWP_ExternalDirName}', {#PWP_SW_STATE_BEFORE}, ewWaitUntilTerminated, ResultCode);
   #endif

   #ifdef PWP_ExecuteBatchBefore
   FileCopy(ctstr + '\{#PWP_ExternalDirName}' + '\OnBeforeCode.bat', ExtendPath(ResultStr + '\OnBeforeCode.bat'), False);
   Exec(ExtendPath(ResultStr + '\OnBeforeCode.bat'),'', ExtendPath(ResultStr), {#PWP_SW_STATE_BEFORE}, ewWaitUntilTerminated, ResultCode);
   DeleteFile(ExtendPath(ResultStr + '\OnBeforeCode.bat')); 
   #endif

#endif
#endif
#endif
end;

procedure InsertCodeAfterUpdate;
{#PWP_InsertCodeVarAfter}
begin
{#PWP_InsertCodeAfter}
#ifdef PWP_BatchCodeSupport

#ifdef PWP_ExternalTemp
   #ifndef PWP_ExecuteBatchAfter
   Exec(ExpandConstant('{tmp}') + '\OnAfterCode.bat','', ExpandConstant('{tmp}'), {#PWP_SW_STATE_AFTER}, ewWaitUntilTerminated, ResultCode);
   #endif

   #ifdef PWP_ExecuteBatchAfter
   FileCopy(ExpandConstant('{tmp}') + '\OnAfterCode.bat', ExtendPath(ResultStr + '\OnAfterCode.bat'), False);
   Exec(ExtendPath(ResultStr + '\OnAfterCode.bat'),'', ExtendPath(ResultStr), {#PWP_SW_STATE_AFTER}, ewWaitUntilTerminated, ResultCode);
   DeleteFile(ExtendPath(ResultStr + '\OnAfterCode.bat')); 
   #endif
#endif

#ifndef PWP_ExternalFilesSupport 
   #ifndef PWP_ExecuteBatchAfter
   Exec(ExpandConstant('{tmp}\OnAfterCode.bat'),'', ExpandConstant('{tmp}'), {#PWP_SW_STATE_AFTER}, ewWaitUntilTerminated, ResultCode);
   #endif

   #ifdef PWP_ExecuteBatchAfter
   FileCopy(ExpandConstant('{tmp}') + '\OnAfterCode.bat', ExtendPath(ResultStr + '\OnAfterCode.bat'), False);
   Exec(ExtendPath(ResultStr + '\OnAfterCode.bat'),'', ExtendPath(ResultStr), {#PWP_SW_STATE_AFTER}, ewWaitUntilTerminated, ResultCode);
   DeleteFile(ExtendPath(ResultStr + '\OnAfterCode.bat')); 
   #endif
#endif

#ifndef PWP_ExternalTemp
#ifdef PWP_ExternalFilesSupport 
   ctstr := ExpandConstant('{src}'); 
   if ctstr = ExtractFileDir(ctstr) then
   ctstr := RemoveBackslash(ctstr); 

   #ifndef PWP_ExecuteBatchAfter
   Exec(ctstr + '\{#PWP_ExternalDirName}' + '\OnAfterCode.bat','', ctstr + '\{#PWP_ExternalDirName}', {#PWP_SW_STATE_AFTER}, ewWaitUntilTerminated, ResultCode);
   #endif

   #ifdef PWP_ExecuteBatchAfter
   FileCopy(ctstr + '\{#PWP_ExternalDirName}' + '\OnAfterCode.bat', ExtendPath(ResultStr + '\OnAfterCode.bat'), False);
   Exec(ExtendPath(ResultStr + '\OnAfterCode.bat'),'', ExtendPath(ResultStr), {#PWP_SW_STATE_AFTER}, ewWaitUntilTerminated, ResultCode);
   DeleteFile(ExtendPath(ResultStr + '\OnAfterCode.bat')); 
   #endif

#endif
#endif
#endif
end;

procedure InsertCodeOnFinish;
{#PWP_InsertCodeVarFinish}
begin
{#PWP_InsertCodeFinish}
#ifdef PWP_BatchCodeSupport
#ifdef PWP_ExternalTemp
   Exec(ExpandConstant('{tmp}') + '\OnFinishCode.bat','', ExpandConstant('{tmp}'), {#PWP_SW_STATE_FINISH}, ewWaitUntilTerminated, ResultCode);
#endif
#ifndef PWP_ExternalFilesSupport 
   Exec(ExpandConstant('{tmp}\OnFinishCode.bat'),'', ExpandConstant('{tmp}'), {#PWP_SW_STATE_FINISH}, ewWaitUntilTerminated, ResultCode);
#endif
#ifndef PWP_ExternalTemp
#ifdef PWP_ExternalFilesSupport 
   ctstr := ExpandConstant('{src}'); 
   if ctstr = ExtractFileDir(ctstr) then
   ctstr := RemoveBackslash(ctstr);

   Exec(ctstr + '\{#PWP_ExternalDirName}' + '\OnFinishCode.bat','',ctstr + '\{#PWP_ExternalDirName}', {#PWP_SW_STATE_FINISH}, ewWaitUntilTerminated, ResultCode);
#endif
#endif
#endif
end;

#ifdef PWP_MultiVersionMode
function SetDetectingMessage():Integer;
begin
  Result:=0;
  if gm = 10 then
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION', 'Founded installed version: ', sLang); 
    Lang2 := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);      
    xInfo.Text := Lang + GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') + '. ' + Lang2;
    xInfo.Update;
    #endif
    Result:=10;
    Exit;
  end;
  if gm = 5 then
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'ALLREADY_UPDATED', 'Application in this location is allready updated!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
    Result:=5;
    Exit;
  end;
  if gm = 1 then
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
    Result:=1;
    Exit;
  end;
end;

function SetCheckDetectingMessage():Integer;
var
  dk,dt,dk3: Integer;
begin
  Result:=0;
  if gm = 10 then
  begin
    dk := StrToInt( GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini')), 'TOTAL_KEYS', '', ExpandConstant('{tmp}') + '\Checker.ini') );
    for dt:=1 to dk do
    begin
      if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH'+IntToStr(dt-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(dt-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
      begin  
        gm := 3;
        inc(dk3);
        if dk3=dk then 
        begin
          Result:=3;
          #ifndef PWP_SilentMode
          Lang := GetIniString('ISPATCH', 'INCORRECT_HASH', 'Checksum hash is a not from original file!', sLang);
          Lang2 := GetIniString('ISPATCH', 'INCORRECT_HASH2', 'Please check your program version!', sLang);
          xInfo.Text := Lang + ' ' + Lang2;
          xInfo.Update;
          MsgBox(Lang + #13#13 + Lang2, mbCriticalError, mb_OK);
          #endif
          Exit;
        end;
      end;
    end;

    Result:=10;
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION', 'Founded installed version: ', sLang);  
    Lang2 := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);      
    xInfo.Text := Lang + GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') + '. ' + Lang2;
    xInfo.Update;
    #endif
    fVer := GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini');
  end;
  if gm = 5 then
  begin
    Result:=5;
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'ALLREADY_UPDATED', 'Application is allready updated!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    MsgBox(Lang, mbInformation, mb_OK);
    #endif
  end;
  if gm = 1 then
  begin
    Result:=1;
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'ORIGINAL_NOT_FOUND', 'Original installation not found! Please select a valid path!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    MsgBox(Lang, mbError, mb_OK);
    #endif
  end;
end;
#endif

#ifdef PWP_MultiVersionMode
#ifdef PWP_SilentFormMode
function SetSilentFormDetectingMessage():Integer;
begin
  Result:=0;
  if gm = 10 then
  begin
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION', 'Founded installed version: ', sLang);  
    Lang2 := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);      
    mStr.Caption := Lang + GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') + '. ' + Lang2;
    mStr.Update;
    Result:=10;
    Exit;
  end;
  if gm = 5 then
  begin
    Lang := GetIniString('ISPATCH', 'ALLREADY_UPDATED', 'Application in this location is allready updated!', sLang);
    mStr.Caption := Lang;
    mStr.Update;
    Result:=5;
    Exit;
  end;
  if gm = 1 then
  begin
    Lang := GetIniString('ISPATCH', 'NOTHING_TO_PATCH3', 'Nothing to patch!', sLang);
    mStr.Caption := Lang;
    mStr.Refresh;
    Result:=1;
    Exit;
  end;
end;
#endif
#endif

procedure GetInstallPathFromRegistry;
#ifdef PWP_MultiVersionMode
label
_start;
#endif
begin
  if RegQueryStringValue({#PWP_RegRoot}, '{#PWP_RegKey}', '{#PWP_RegValue}', ResultStr) then
  if 1 = {#PWP_RegTrimResult} then
  ResultStr := ExtendPath(ExtractFileDir(ResultStr));

  if ResultStr <> '' then
  ResultStr := ExtendPath(RemoveQuotes(ResultStr) + '{#PWP_ExtraPath}');

  #ifndef PWP_SilentMode
  #ifndef PWP_MultiVersionMode
  if ResultStr = '' then
  begin
    #ifdef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
    #endif
    #ifndef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    #endif
    xInfo.Text := Lang;
    xInfo.Update;
  end;

  ExtractTemporaryFile('Checker.ini'); 

  if not FileExists(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini'))) then
  begin 
    #ifdef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
    #endif
    #ifndef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    #endif
    xInfo.Text := Lang;
    xInfo.Update;
    Exit;
  end else
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
    key_cur := {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini')));
  end;

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH_NEW','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
  begin
    Lang := GetIniString('ISPATCH', 'ALLREADY_UPDATED', 'Application in this location is allready updated!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> key_cur then
  begin 
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
  begin   
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION2', 'Founded installed version! Ready to Patch!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else
  begin 
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end;
  #endif
  #endif

  #ifdef PWP_MultiVersionMode
  ////////////////////////////////////
  ExtractTemporaryFile('Checker.ini'); 

  mvCount := StrToInt( GetIniString('USED_VERSIONS', 'TOTAL', '', ExpandConstant('{tmp}') + '\Checker.ini') );

  for i := 1 to mvCount do
  begin
    tk := StrToInt( GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini')), 'TOTAL_KEYS', '', ExpandConstant('{tmp}') + '\Checker.ini') );
    gm := 0;
    tj:=0;
    tj10:=0;
    tj5:=0;
    tj3:=0;
    tj1:=0;
    repeat
      _start:
      inc(tj);

      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
      xInfo.Text := Lang;
      xInfo.Update;
      #endif
      AppProcessMessage; 
      if FileExists(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
      begin 
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin
          gm := 10;
          inc(tj10);
          if tj10=tk then Exit;
        goto _start;
        end else
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH_NEW'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin  
          gm := 5;
          if i < mvCount then Break;
          inc(tj5);
          if tj5=tk then Exit;
          goto _start;
        end else
        gm:=1; 
      end else
      gm:=1;
    until tj>=tk;
  end;

  if ResultStr = '' then
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
  end;

  #endif
end;

procedure GetInstallPathFromIni;
#ifdef PWP_MultiVersionMode
label
_start;
#endif
begin
  ResultStr := GetIniString('{#PWP_IniSection}', '{#PWP_IniValue}', ExtendPath(ResultStr), ExpandConstant(ExtendPath('{#PWP_IniPath}')));  
  if 1 = {#PWP_IniTrimResult} then
  ResultStr := ExtendPath(ExtractFileDir(ResultStr)); 

  if ResultStr <> '' then 
  ResultStr := ExtendPath(RemoveQuotes(ResultStr) + '{#PWP_ExtraPath}');

  #ifndef PWP_SilentMode
  #ifndef PWP_MultiVersionMode
  if ResultStr = '' then
  begin
    #ifdef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
    #endif
    #ifndef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    #endif
    xInfo.Text := Lang;
    xInfo.Update;
  end;

  ExtractTemporaryFile('Checker.ini'); 

  if not FileExists(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini'))) then
  begin 
    #ifdef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
    #endif
    #ifndef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    #endif
    xInfo.Text := Lang;
    xInfo.Update;
    Exit;
  end else
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
    key_cur := {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini')));
  end;

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH_NEW','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
  begin
    Lang := GetIniString('ISPATCH', 'ALLREADY_UPDATED', 'Application in this location is allready updated!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> key_cur then
  begin  
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
  begin   
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION2', 'Founded installed version! Ready to Patch!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else
  begin   
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end;
  #endif
  #endif

  #ifdef PWP_MultiVersionMode

  ///////////////////////////////////
  ExtractTemporaryFile('Checker.ini'); 

  mvCount := StrToInt( GetIniString('USED_VERSIONS', 'TOTAL', '', ExpandConstant('{tmp}') + '\Checker.ini') );

  for i := 1 to mvCount do
  begin
    tk := StrToInt( GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini')), 'TOTAL_KEYS', '', ExpandConstant('{tmp}') + '\Checker.ini') );
    gm := 0;
    tj:=0;
    tj10:=0;
    tj5:=0;
    tj3:=0;
    tj1:=0;
    repeat
      _start:
      inc(tj);

      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
      xInfo.Text := Lang;
      xInfo.Update;
      #endif
      AppProcessMessage; 
      if FileExists(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
      begin 
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin
          gm := 10;
          inc(tj10);
          if tj10=tk then Exit;
        goto _start;
        end else
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH_NEW'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin  
          gm := 5;
          if i < mvCount then Break;
          inc(tj5);
          if tj5=tk then Exit;
          goto _start;
        end else
        gm:=1; 
      end else
      gm:=1;
    until tj>=tk;
  end;

  if ResultStr = '' then
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
  end;

  #endif
end;

procedure GetInstallPathFromXml;
#ifdef PWP_MultiVersionMode
label
_start;
#endif
var
  xml,currNode: Variant;
begin
  if not FileExists(ExtendPath(ExpandConstant('{#PWP_XmlPath}'))) then
  ResultStr := ''
  else
  begin
    try
      xml := CreateOleObject('MSXML2.DOMDocument');
      xml.async := false;
      xml.preserveWhiteSpace := true;
      xml.load(ExtendPath(ExpandConstant('{#PWP_XmlPath}')));
      currNode:= xml.selectSingleNode('{#PWP_XmlNode}')

      ResultStr := currNode.text;  
    except
    end;

    if 1 = {#PWP_XmlTrimResult} then
    begin
      ResultStr := ExtendPath(ExtractFileDir(ResultStr)); 
    end;
  end;

  if ResultStr <> '' then 
  ResultStr := ExtendPath(RemoveQuotes(ResultStr) + '{#PWP_ExtraPath}');

  #ifndef PWP_SilentMode
  #ifndef PWP_MultiVersionMode
  if ResultStr = '' then
  begin
    #ifdef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
    #endif
    #ifndef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    #endif
    xInfo.Text := Lang;
    xInfo.Update;
  end;

  ExtractTemporaryFile('Checker.ini'); 

  if not FileExists(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini'))) then
  begin 
    #ifdef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
    #endif
    #ifndef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    #endif
    xInfo.Text := Lang;
    xInfo.Update;
    Exit;
  end else
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
    key_cur := {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini')));
  end;

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH_NEW','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
  begin
    Lang := GetIniString('ISPATCH', 'ALLREADY_UPDATED', 'Application in this location is allready updated!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> key_cur then
  begin  
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
  begin   
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION2', 'Founded installed version! Ready to Patch!', sLang);
    xInfo.Text := Lang;
  end else
  begin   
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end;
  #endif
  #endif

  #ifdef PWP_MultiVersionMode

  ExtractTemporaryFile('Checker.ini'); 

  mvCount := StrToInt( GetIniString('USED_VERSIONS', 'TOTAL', '', ExpandConstant('{tmp}') + '\Checker.ini') );

  for i := 1 to mvCount do
  begin
    tk := StrToInt( GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini')), 'TOTAL_KEYS', '', ExpandConstant('{tmp}') + '\Checker.ini') );
    gm := 0;

    tj:=0;
    tj10:=0;
    tj5:=0;
    tj3:=0;
    tj1:=0;
    repeat
      _start:
      inc(tj);

      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
      xInfo.Text := Lang;
      xInfo.Update;
      #endif
      AppProcessMessage; 
      if FileExists(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
      begin 
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin
          gm := 10;
          inc(tj10);
          if tj10=tk then Exit;
        goto _start;
        end else
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH_NEW'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin  
          gm := 5;
          if i < mvCount then Break;
          inc(tj5);
          if tj5=tk then Exit;
          goto _start;
        end else
        gm:=1; 
      end else
      gm:=1;
    until tj>=tk;
  end;

  if ResultStr = '' then
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
  end;

#endif
end;

procedure GetManualInstallPath;
#ifdef PWP_MultiVersionMode
label
_start;
#endif
begin
  ResultStr := ExtendPath(ExpandConstant('{#PWP_ManualPath}'));

  if ResultStr <> '' then
  ResultStr := ExtendPath(RemoveQuotes(ResultStr) + '{#PWP_ExtraPath}');

  #ifndef PWP_SilentMode
  #ifndef PWP_MultiVersionMode
  if ResultStr = '' then
  begin
    #ifdef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
    #endif
    #ifndef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    #endif
    xInfo.Text := Lang;
    xInfo.Update;
  end;

  ExtractTemporaryFile('Checker.ini'); 

  if not FileExists(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini'))) then
  begin 
    #ifdef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
    #endif
    #ifndef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    #endif
    xInfo.Text := Lang;
    xInfo.Update;
    Exit;
  end else
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
    key_cur := {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini')));
  end;
  
  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH_NEW','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
  begin
    Lang := GetIniString('ISPATCH', 'ALLREADY_UPDATED', 'Application in this location is allready updated!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> key_cur then
  begin  
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
  begin   
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION2', 'Founded installed version! Ready to Patch!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else
  begin   
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end;
  #endif
  #endif

  #ifdef PWP_MultiVersionMode

  ExtractTemporaryFile('Checker.ini'); 

  //////////////////////////
  mvCount := StrToInt( GetIniString('USED_VERSIONS', 'TOTAL', '', ExpandConstant('{tmp}') + '\Checker.ini') );

  for i := 1 to mvCount do
  begin
    tk := StrToInt( GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini')), 'TOTAL_KEYS', '', ExpandConstant('{tmp}') + '\Checker.ini') );
    gm := 0;
    tj:=0;
    tj10:=0;
    tj5:=0;
    tj3:=0;
    tj1:=0;
    repeat
      _start:
      inc(tj);

      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
      xInfo.Text := Lang;
      xInfo.Update;
      #endif
      AppProcessMessage; 
      if FileExists(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
      begin 
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin
          gm := 10;
          inc(tj10);
          if tj10=tk then Exit;
        goto _start;
        end else
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH_NEW'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin  
          gm := 5;
          if i < mvCount then Break;
          inc(tj5);
          if tj5=tk then Exit;
          goto _start;
        end else
        gm:=1; 
      end else
      gm:=1;
    until tj>=tk;
  end;

  if ResultStr = '' then
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
  end;

  #endif
end;

procedure GetInstallPathFromParameter;
#ifdef PWP_MultiVersionMode
label
_start;
#endif
begin
  ResultStr := ExtendPath(ExpandConstant('{param:{#PWP_ParameterName}}'));

  if ResultStr <> '' then 
  ResultStr := ExtendPath(RemoveQuotes(ResultStr) + '{#PWP_ExtraPath}');

  #ifndef PWP_SilentMode
  #ifndef PWP_MultiVersionMode
  if ResultStr = '' then
  begin
    #ifdef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
    #endif
    #ifndef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    #endif
    xInfo.Text := Lang;
    xInfo.Update;
  end;

  ExtractTemporaryFile('Checker.ini'); 

  if not FileExists(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini'))) then
  begin 
    #ifdef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
    #endif
    #ifndef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    #endif
    xInfo.Text := Lang;
    xInfo.Update;
    Exit;
  end else
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
    key_cur := {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini')));
  end;
  
  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH_NEW','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
  begin
    Lang := GetIniString('ISPATCH', 'ALLREADY_UPDATED', 'Application in this location is allready updated!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> key_cur then
  begin  
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
  begin   
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION2', 'Founded installed version! Ready to Patch!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else
  begin   
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end;
  #endif
  #endif

  #ifdef PWP_MultiVersionMode

  ExtractTemporaryFile('Checker.ini'); 

  //////////////////////////
  mvCount := StrToInt( GetIniString('USED_VERSIONS', 'TOTAL', '', ExpandConstant('{tmp}') + '\Checker.ini') );

  for i := 1 to mvCount do
  begin
    tk := StrToInt( GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini')), 'TOTAL_KEYS', '', ExpandConstant('{tmp}') + '\Checker.ini') );
    gm := 0;
    tj:=0;
    tj10:=0;
    tj5:=0;
    tj3:=0;
    tj1:=0;
    repeat
      _start:
      inc(tj);

      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
      xInfo.Text := Lang;
      xInfo.Update;
      #endif
      AppProcessMessage; 
      if FileExists(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
      begin 
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin
          gm := 10;
          inc(tj10);
          if tj10=tk then Exit;
        goto _start;
        end else
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH_NEW'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin  
          gm := 5;
          if i < mvCount then Break;
          inc(tj5);
          if tj5=tk then Exit;
          goto _start;
        end else
        gm:=1; 
      end else
      gm:=1;
    until tj>=tk;
  end;

  if ResultStr = '' then
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
  end;

  #endif
end;

#ifndef PWP_SilentMode

#ifdef PWP_AppDetecting
function FindAppByWindowName():Boolean;
var
  h: Longint;
begin
  Result:=True;
  h:=FindWindowByWindowName('{#PWP_DetectWindowName}');
  if h<>0 then
  begin
    Lang := GetIniString('ISPATCH', 'FIND_BY_WINDOW_NAME', 'Running application detected!', sLang);
    Lang2 := GetIniString('ISPATCH', 'FIND_BY_WINDOW_NAME2', 'Please close ', sLang);
    Lang3 := GetIniString('ISPATCH', 'FIND_BY_WINDOW_NAME3', ' then run Patch again!', sLang);
    MsgBox(Lang + #13#13 + Lang2 +'{#PWP_AppName}' + Lang3, mbError, MB_OK);
    Result:=False;
  end;
end;

function FindAppByClassName():Boolean;
var
  h: Longint;
begin
  Result:=True;
  h:=FindWindowByClassName('{#PWP_DetectWindowClass}');
  if h<>0 then
  begin
    Lang := GetIniString('ISPATCH', 'FIND_BY_CLASS_NAME', 'Running application detected!', sLang);
    Lang2 := GetIniString('ISPATCH', 'FIND_BY_CLASS_NAME2', 'Please close ', sLang);
    Lang3 := GetIniString('ISPATCH', 'FIND_BY_CLASS_NAME3', ' then run Patch again!', sLang);
    MsgBox(Lang + #13#13 + Lang2 +'{#PWP_AppName}' + Lang3, mbError, MB_OK);
    Result:=False;
  end;
end;   

function FindAppByMutex():Boolean;
begin
  Result:=True;
  if CheckForMutexes('{#PWP_DetectMutex}') then
  begin
    Lang := GetIniString('ISPATCH', 'FIND_BY_MUTEX', 'Running application detected!', sLang);
    Lang2 := GetIniString('ISPATCH', 'FIND_BY_MUTEX2', 'Please close ', sLang);
    Lang3 := GetIniString('ISPATCH', 'FIND_BY_MUTEX3', ' then run Patch again!', sLang);
    MsgBox(Lang + #13#13 + Lang2 +'{#PWP_AppName}' + Lang3, mbError, MB_OK);
    Result:=False;
  end;
end;

function FindAppByProc():Boolean;
begin
  Result:=True;
  if IsProcessRunning('{#PWP_DetectProcess}') > 0 then
  begin
    Lang := GetIniString('ISPATCH', 'FIND_BY_PROC', 'Running application detected!', sLang);
    Lang2 := GetIniString('ISPATCH', 'FIND_BY_PROC2', 'Please close ', sLang);
    Lang3 := GetIniString('ISPATCH', 'FIND_BY_PROC3', ' then run Patch again!', sLang);
    MsgBox(Lang + #13#13 + Lang2 +'{#PWP_AppName}' + Lang3, mbError, MB_OK);
    Result:=False;
  end;
end;
#endif

#endif
//////
#ifndef PWP_SilentMode
procedure CheckApp;
#ifdef PWP_MultiVersionMode
label
_start;
#endif
begin
  #ifndef PWP_MultiVersionMode
  ResultStr := oDir.Text;
  if ResultStr = '' then
  begin
    #ifdef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
    #endif
    #ifndef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    #endif
    xInfo.Text := Lang;
    xInfo.Update;
  end;

  ExtractTemporaryFile('Checker.ini'); 

  if not FileExists(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini'))) then
  begin 
    #ifdef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
    #endif
    #ifndef PWP_DisableKeyfileCheck
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    #endif
    xInfo.Text := Lang;
    xInfo.Update;
    Exit;
  end else
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
    key_cur := {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini')));
  end;

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH_NEW','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
  begin
    Lang := GetIniString('ISPATCH', 'ALLREADY_UPDATED', 'Application in this location is allready updated!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> key_cur then
  begin  
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else

  if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
  begin   
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION2', 'Founded installed version! Ready to Patch!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end else
  begin   
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end
  #endif

  #ifdef PWP_MultiVersionMode
  ResultStr := oDir.Text;
  if ResultStr = '' then
  begin
    Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
  end;

  ExtractTemporaryFile('Checker.ini'); 

  mvCount := StrToInt( GetIniString('USED_VERSIONS', 'TOTAL', '', ExpandConstant('{tmp}') + '\Checker.ini') );

  for i := 1 to mvCount do
  begin
    tk := StrToInt( GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini')), 'TOTAL_KEYS', '', ExpandConstant('{tmp}') + '\Checker.ini') );
    gm := 0;

    tj:=0;
    tj10:=0;
    tj5:=0;
    tj3:=0;
    tj1:=0;
    repeat
      _start:
      inc(tj);

      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
      xInfo.Text := Lang;
      xInfo.Update;
      #endif
      AppProcessMessage; 
      if FileExists(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
      begin 
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin
          gm := 10;
          inc(tj10);
          if tj10=tk then Exit;
        goto _start;
        end else
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH_NEW'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin  
          gm := 5;
          if i < mvCount then Break;
          inc(tj5);
          if tj5=tk then Exit;
          goto _start;
        end else
        gm:=1; 
      end else
      gm:=1;
    until tj>=tk;
  end;
  #endif
end;

procedure CheckValidAppPath(Sender: TObject);
begin
  if init_key_chk = 0 then Exit else init_key_chk := 1;
  CheckApp; 
#ifdef PWP_MultiVersionMode
  SetDetectingMessage;
#endif
end;            

procedure BrowseOutput(Sender: TObject); 
begin
  UserSelectDir:= ExpandConstant('{pf}');
  Lang := GetIniString('ISPATCH', 'BROWSE_DIALOG', 'Please select path to the destination dir location:', sLang);
  if BrowseForFolder(Lang, UserSelectDir, False) then
  begin
    ResultStr:= UserSelectDir;
    oDir.Text := ResultStr;
    CheckApp;
  #ifdef PWP_MultiVersionMode
    SetDetectingMessage;
  #endif
  end;
end;
#endif

function CheckIni(): Boolean;
#ifdef PWP_MultiVersionMode
label
_start;
#endif
begin
  Result := True;
  DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
  ExtractTemporaryFile('Checker.ini'); 

#ifndef PWP_MultiVersionMode

  if IniKeyExists('KEY','FILE',ExpandConstant('{tmp}') + '\Checker.ini') then
  begin
    if not FileExists(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini'))) then
    begin
      Result:=False;
      DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'ORIGINAL_NOT_FOUND', 'Original installation not found! Please select a valid path!', sLang);
      xInfo.Text := Lang;
      xInfo.Update;
      MsgBox(Lang, mbError, mb_OK);
      #endif
      Exit;
    end else
    begin
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
      xInfo.Text := Lang;
      xInfo.Update;
      #endif
      key_cur := {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini')));
    end;

    if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH_NEW','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
    begin
      Result:=False;
      DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini'); 
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'ALLREADY_UPDATED', 'Application in this location is allready updated!', sLang);
      xInfo.Text := Lang;
      xInfo.Update;
      MsgBox(Lang, mbInformation, mb_OK);
      #endif
    end else
    if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> key_cur then
    begin
      Result:=False;
      DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini'); 
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'INCORRECT_HASH', 'Checksum hash is a not from original file!', sLang);
      Lang2 := GetIniString('ISPATCH', 'INCORRECT_HASH2', 'Please check your program version!', sLang);
      xInfo.Text := Lang + ' ' + Lang2;
      xInfo.Update;
      MsgBox(Lang + #13#13 + Lang2, mbCriticalError, mb_OK);
      #endif
    end;
    //if IniKeyFileValueExists
  end else
  begin
  #ifdef PWP_DisableKeyfileCheck
    //risky and dangerous for patch applying if no keyfile check
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    #endif
  #endif
  ////// unnecessary check (standard "not found" message if keyfile in Checker.ini not exists when )
  #ifndef PWP_DisableKeyfileCheck
    Result:=False;
    DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'ORIGINAL_NOT_FOUND', 'Original installation not found! Please select a valid path!', sLang);
    xInfo.Text := Lang;
    xInfo.Update;
    MsgBox(Lang, mbError, mb_OK);
    #endif
    Exit;
  #endif
  end;

#endif

#ifdef PWP_MultiVersionMode
  mvCount := StrToInt( GetIniString('USED_VERSIONS', 'TOTAL', '', ExpandConstant('{tmp}') + '\Checker.ini') );
  for i := 1 to mvCount do
  begin
    tk := StrToInt( GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini')), 'TOTAL_KEYS', '', ExpandConstant('{tmp}') + '\Checker.ini') );
    gm := 0;
    tj:=0;
    tj10:=0;
    tj5:=0;
    tj3:=0;
    tj1:=0;
    repeat
      _start:
      inc(tj);

      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
      xInfo.Text := Lang;
      xInfo.Update;
      #endif
      AppProcessMessage; 
      if FileExists(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
      begin 
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini'),'HASH'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini'),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin
          gm := 10;
          inc(tj10);
          if tj10=tk then Exit;
        goto _start;
        end else
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH_NEW'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin  
          gm := 5;
          if i < mvCount then Break;
          inc(tj5);
          if tj5=tk then Exit;
          goto _start;
        end else
        gm:=1; 
      end else
      gm:=1;
    until tj>=tk;
  end;
#endif
end;

#ifndef PWP_SilentMode
#ifdef PWP_AppDetecting
function CheckRunningApplication(): Boolean;
begin
  if {#PWP_DetectRunnedApp} = 0 then
  Result := True
  else
  if {#PWP_DetectRunnedApp} = 1 then
  Result := FindAppByWindowName
  else
  if {#PWP_DetectRunnedApp} = 2 then
  Result := FindAppByClassName
  else
  if {#PWP_DetectRunnedApp} = 3 then 
  Result := FindAppByMutex
  else
  if {#PWP_DetectRunnedApp} = 4 then
  Result := FindAppByProc
  else
  if {#PWP_DetectRunnedApp} = 5 then
  if FindAppByWindowName and FindAppByClassName and FindAppByMutex and FindAppByProc then
  Result := True
  else
  Result := False;
end;
#endif
#endif

#ifdef PWP_ForcedPath
procedure ForcedInstallPath;
var
  f: Integer;
begin
  ExtractTemporaryFile('Checker.ini'); 
#ifndef PWP_MultiVersionMode
  for f := 0 to 4 do 
  begin
    if f = 0 then
       GetManualInstallPath; 
    if f = 1 then
       GetInstallPathFromRegistry;
    if f = 2 then
       GetInstallPathFromIni;
    if f = 3 then
       GetInstallPathFromParameter;
    if f = 4 then
       GetInstallPathFromXml; 

    if ResultStr = '' then
    begin
       #ifndef PWP_SilentMode
         #ifdef PWP_DisableKeyfileCheck
         Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
         #endif
         #ifndef PWP_DisableKeyfileCheck
         Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
         #endif
       xInfo.Text := Lang;
       xInfo.Update;
       #endif
    end else
    if not FileExists(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini'))) then
    begin 
       #ifndef PWP_SilentMode
         #ifdef PWP_DisableKeyfileCheck
         Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION_READY', 'Ready to Patch!', sLang);
         #endif
         #ifndef PWP_DisableKeyfileCheck
         Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
         #endif
       xInfo.Text := Lang;
       xInfo.Update;
       #endif
       Exit;
    end else
    begin
       #ifndef PWP_SilentMode
       Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
       xInfo.Text := Lang;
       xInfo.Update;
       #endif
       //repeated from methods
       //key_cur := {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini')));
    end;

    if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH_NEW','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
    begin
       #ifndef PWP_SilentMode
       Lang := GetIniString('ISPATCH', 'ALLREADY_UPDATED', 'Application in this location is allready updated!', sLang);
       xInfo.Text := Lang;
       xInfo.Update;
       #endif
    end else
    if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> key_cur then
    begin  
       #ifndef PWP_SilentMode
       Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
       xInfo.Text := Lang;
       xInfo.Update;
       #endif
    end else
    if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
    begin   
       #ifndef PWP_SilentMode
       Lang := GetIniString('ISPATCH', 'FOUNDED_VERSION2', 'Founded installed version! Ready to Patch!', sLang);
       xInfo.Text := Lang;
       xInfo.Update;
       #endif
       DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
       Exit;
    end else
    begin   
       #ifndef PWP_SilentMode
       Lang := GetIniString('ISPATCH', 'INSTALL_PATH_NOT_FOUND', 'Install path for required version was not found! Please select it!', sLang);
       xInfo.Text := Lang;
       xInfo.Update;
       #endif
    end;
  end;
#endif

#ifdef PWP_MultiVersionMode
  for f := 0 to 4 do 
  begin
    if f = 0 then
    begin
      GetManualInstallPath; 
      if SetDetectingMessage = 10 then 
      begin
        DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
        Exit;
      end;
      if SetDetectingMessage = 5 then 
      begin
        DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
        Exit;
      end;
    end;

    if f = 1 then
    begin
      GetInstallPathFromRegistry;
      if SetDetectingMessage = 10 then 
      begin
        DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
        Exit;
      end;
      if SetDetectingMessage = 5 then 
      begin
        DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
        Exit;
      end;
    end;

    if f = 2 then
    begin
      GetInstallPathFromIni;
      if SetDetectingMessage = 10 then 
      begin
        DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
        Exit;
      end;
      if SetDetectingMessage = 5 then 
      begin
        DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
        Exit;
      end;
    end;

    if f = 3 then
    begin
      GetInstallPathFromParameter;
      if SetDetectingMessage = 10 then 
      begin
        DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
        Exit;
      end;
      if SetDetectingMessage = 5 then 
      begin
        DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
        Exit;
      end;
    end;

    if f = 4 then
    begin
      GetInstallPathFromXml;
      if SetDetectingMessage = 10 then 
      begin
        DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
        Exit;
      end;
      if SetDetectingMessage = 5 then 
      begin
        DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
        Exit;
      end;
    end;
  end;
  SetDetectingMessage;
#endif
  DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
end;
#endif

#ifdef PWP_SilentFormMode
#ifdef PWP_MultiVersionMode
procedure SilentFormDetecting;
#ifdef PWP_MultiVersionMode
label
_start;
#endif
begin
  mvCount := StrToInt( GetIniString('USED_VERSIONS', 'TOTAL', '', ExpandConstant('{tmp}') + '\Checker.ini') );
  for i := 1 to mvCount do
  begin
    tk := StrToInt( GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini')), 'TOTAL_KEYS', '', ExpandConstant('{tmp}') + '\Checker.ini') );
    gm := 0;
    tj:=0;
    tj10:=0;
    tj5:=0;
    tj3:=0;
    tj1:=0;
    repeat
      _start:
      inc(tj);

      Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
      mStr.Caption := Lang;
      mStr.Update;
      AppProcessMessage; 
      if FileExists(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
      begin 
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini'),'HASH'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini'),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin
          gm := 10;
          inc(tj10);
          if tj10=tk then Exit;
        goto _start;
        end else
        if {#PWP_CRC32_PARAM1}GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'HASH_NEW'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY' + ( GetIniString('USED_VERSIONS', IntToStr(i-1), '', ExpandConstant('{tmp}') + '\Checker.ini') ),'FILE'+IntToStr(tj-1),'',ExpandConstant('{tmp}') + '\Checker.ini'))) then
        begin  
          gm := 5;
          if i < mvCount then Break;
          inc(tj5);
          if tj5=tk then Exit;
          goto _start;
        end else
        gm:=1; 
      end else
      gm:=1;
    until tj>=tk;
  end;
end;
#endif
#endif  

function GetApplyingCores: Integer;
begin
    cores := GetCPUCores;
  if {#PWP_ApplyingCores} = 1 then
    Result := 1 else
  if {#PWP_ApplyingCores} = 25 then
    Result := cores / 2 / 2 else
  if {#PWP_ApplyingCores} = 50 then
    Result := cores / 2 else
  if {#PWP_ApplyingCores} = 75 then
    Result := cores / 2 + cores / 4 else
  if {#PWP_ApplyingCores} = 100 then
    Result := cores;
  if Result < 1 then Result := 1;
end;
                                                      
procedure ApplyPatchData;
//#ifdef PWP_SilentFormMode ???
//#ifdef PWP_MultiVersionMode
//#endif
//#endif
begin 
  #ifndef PWP_SilentMode
  ResultStr := oDir.Text; 
  #endif

  ExtractTemporaryFile('Checker.ini'); 

  #ifdef PWP_SilentFormMode
    #ifndef PWP_MultiVersionMode
    if ResultStr = '' then
    begin
      Lang := GetIniString('ISPATCH', 'NOTHING_TO_PATCH3', 'Nothing to patch!', sLang);
      mStr.Caption := Lang;
      mStr.Refresh;
      DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini'); 
      Exit;
    end else
    if not FileExists(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini'))) then
    begin 
      Lang := GetIniString('ISPATCH', 'NOTHING_TO_PATCH3', 'Nothing to patch!', sLang);
      mStr.Caption := Lang;
      mStr.Refresh;
      DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini'); 
      Exit;
    end else
    begin
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'VERSION_DETECTING', 'Detecting version... Please wait...', sLang);
      mStr.Caption := Lang;
      mStr.Refresh;
      #endif
      key_cur := {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('KEY','FILE','',ExpandConstant('{tmp}') + '\Checker.ini')));
    end;

    if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH_NEW','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} = key_cur then
    begin
      Lang := GetIniString('ISPATCH', 'ALLREADY_UPDATED', 'Application in this location is allready updated!', sLang);
      mStr.Caption := Lang;
      mStr.Refresh;
      DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini'); 
      Exit;
    end else
    if {#PWP_CRC32_PARAM1}GetIniString('KEY','HASH','',ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> key_cur then
    begin  
      Lang := GetIniString('ISPATCH', 'NOTHING_TO_PATCH3', 'Nothing to patch!', sLang);
      mStr.Caption := Lang;
      mStr.Refresh;
      DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini'); 
      Exit;
    end;
    DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
    #endif
     //////
    #ifdef PWP_MultiVersionMode
      SilentFormDetecting;

      if SetSilentFormDetectingMessage <> 10 then                        
      Exit;  
      //DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
    #endif
  #endif

  // remove \ at the end of path
  ResultStr := RemoveBackslash(ResultStr);

  if not DirExists(ExtendPath(ResultStr)) then // if exist detected or selected path
  begin
    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'INCORRECR_PATH_ENTERED', 'Incorrect path entered! Please select installation dir!', sLang);
    MsgBox(Lang, mbError, mb_OK);
    DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
    Exit;
    #endif
  end;

  // additional checks
  #ifndef PWP_MultiVersionMode
  if CheckIni = False then                       
  Exit;  
  #endif
  #ifdef PWP_MultiVersionMode
  CheckIni; 
  if SetCheckDetectingMessage <> 10 then                        
  Exit;  
  #endif

  #ifdef PWP_GetSpaseOnDisk
  if GetSpaceForPatch = False then 
  Exit;
  #endif

  PatchingError := 0; 
  z := 0;

  #ifndef PWP_SilentMode
  #ifdef PWP_AppDetecting
    #ifdef PWP_CheckAppBeforePatching
    if CheckRunningApplication = False then 
    Exit;
    #endif
  #endif
  #endif  

  #ifndef PWP_SilentMode
    pInfo.SendToBack;
    pLog.BringToFront;  
    InfoButton.Enabled := True;
  #endif  

  #ifndef PWP_SilentMode
    pLog.Text := '';
    pLog.Refresh;
  #endif 

  #ifdef PWP_MultiVersionMode
    #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'VERSION_TO_PATCH', 'Preparing to patching founded version: ', sLang);
      pLog.Lines.Add(Lang + fVer);
      pLog.Lines.Add('');
    #endif 
  #endif 

  /////////////////////////         
  InsertCodeBeforeUpdate;
  /////////////////////////

  #ifndef PWP_SilentMode
    #ifdef PWP_InsidePatch
      #ifdef PWP_ForcePatchingSupport
        Lang := GetIniString('ISPATCH', 'FORCE_PATCHING', 'Patching is runned in the force mode!', sLang);
        pLog.Lines.Add(Lang);
        Lang := GetIniString('ISPATCH', 'FORCE_PATCHING2', 'All nonexistent for patching files will be skipped...', sLang);
        pLog.Lines.Add(Lang);
        pLog.Lines.Add('');
      #endif
    #endif 

    #ifndef PWP_InsidePatch
      #ifdef PWP_ForcePatchingSupport
        Lang := GetIniString('ISPATCH', 'FORCE_PATCHING', 'Patching is runned in the force mode!', sLang);
        pLog.Lines.Add(Lang);
        Lang := GetIniString('ISPATCH', 'FORCE_PATCHING2', 'All nonexistent for patching files will be skipped...', sLang);
        pLog.Lines.Add(Lang);
        pLog.Lines.Add('');
      #endif
    #endif 
  #endif 

  #ifdef PWP_VerificationList

      #ifndef PWP_MultiVersionMode
            m := 0; 
            pCount := StrToInt(GetIniString('TOTAL_VER_LIST', 'COUNT', '0', ExpandConstant('{tmp}') + '\Checker.ini'));

            #ifdef PWP_SilentFormMode
            Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting files verification process...', sLang);
            mStr.Caption := Lang;
            mStr.Refresh;
            iStr.Caption := '';
            iStr.Refresh;

            ProgressBar.Position := 0;
            ProgressBar.Min := 0;
            ProgressBar.Max := pCount;
            #endif
            //////
            #ifndef PWP_SilentMode 
            Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting files verification process...', sLang);
            xInfo.Text := Lang;
            xInfo.Update;

            Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting files verification process...', sLang);
            pLog.Lines.Add(Lang);

            ProgressBar.Position := 0;
            ProgressBar.Min := 0;
            ProgressBar.Max := pCount;
            #endif

            repeat
              AppProcessMessage; 
               #ifndef PWP_SilentMode 
               if FileExists(ExtendPath(ResultStr + GetIniString('OLD_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
               begin
                  if {#PWP_CRC32_PARAM1}GetIniString('VER_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('OLD_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
                  begin
                    #ifndef PWP_SimplyLogSupport
                      Lang := GetIniString('ISPATCH', 'INVALID_HASH', '[!]  Invalid checksum hash for updated file: ', sLang); 
                      pLog.Lines.Add(Lang +'"'+ResultStr + GetIniString('OLD_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')+'"');
                    #endif
                    #ifdef PWP_SimplyLogSupport
                      Lang := GetIniString('ISPATCH', 'S_INVALID_FILE', '[!]  Invalid file: ', sLang); 
                      s_basePath := GetIniString('OLD_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
                      Delete(s_basePath,1,1);
                      pLog.Lines.Add(Lang +'"'+ s_basePath +'"'); 
                    #endif
                    Inc(z);  
                  end else
                  begin
                    #ifndef PWP_SimplyLogSupport
                      Lang := GetIniString('ISPATCH', 'VALID_HASH', 'Valid checksum hash for updated file: ', sLang); 
                      pLog.Lines.Add(Lang +'"'+ResultStr + GetIniString('OLD_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')+'"');
                    #endif
                    #ifdef PWP_SimplyLogSupport
                      Lang := GetIniString('ISPATCH', 'S_VALID_FILE', 'OK! Valid file: ', sLang); 
                      s_basePath := GetIniString('OLD_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
                      Delete(s_basePath,1,1);
                      pLog.Lines.Add(Lang +'"'+ s_basePath +'"'); 
                    #endif
                  end;

                  #ifdef PWP_ForcePatchingSupport
                  end else
                  begin
                    #ifndef PWP_SilentMode
                    Lang := GetIniString('ISPATCH', 'FILE_SKIPPED', '[!]  This file not exists and skipped: ', sLang); 
                    pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('OLD_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
                    #endif
                  end;
                  #endif

                  #ifndef PWP_ForcePatchingSupport
                  end else
                  begin
                    #ifndef PWP_SilentMode
                    Lang := GetIniString('ISPATCH', 'FILE_NOT_EXISTS', '[!]  Required to process file not exists: ', sLang); 
                    pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('OLD_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
                    #endif
                    Inc(z);
                  end;
                  #endif
              #endif
              //////
              #ifdef PWP_SilentMode
              if FileExists(ExtendPath(ResultStr + GetIniString('OLD_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
              begin
                if {#PWP_CRC32_PARAM1}GetIniString('VER_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('OLD_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
                Inc(z);

              #ifdef PWP_ForcePatchingSupport
              end;
              #endif
              #ifndef PWP_ForcePatchingSupport
              end else
                Inc(z);
              #endif

              #endif

              inc(m);

              #ifdef PWP_SilentFormMode
              ProgressBar.Position := m;
              SetTaskBarProgressValue(m * 100 / pCount);
              #endif
              //////
              #ifndef PWP_SilentMode
              ProgressBar.Position := m;
              SetTaskBarProgressValue(m * 100 / pCount);
              #endif

            until m >= pCount;

            if (z > 0) then // if Error Code was happened, show additional warning
            begin                      
              PatchingError := 1;

              #ifdef PWP_SilentFormMode
              SetTaskBarProgressState(4);
              SetTaskBarProgressValue(100);
              Lang := GetIniString('ISPATCH', 'VERIFICATION_UNSUCCESS', '[!]  Some files not exists or have incorrect checksum!', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif
              //////
              #ifndef PWP_SilentMode
              KillTimer(0, tTimerID);
              SetTaskBarProgressState(4);
              SetTaskBarProgressValue(100);

              Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
              xInfo.Text := Lang + #13#10 + FormatTime(Elapsed);
              xInfo.Update;

              Lang := GetIniString('ISPATCH', 'VERIFICATION_UNSUCCESS', '[!]  Some files not exists or have incorrect checksum!', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('');

              Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
              pLog.Lines.Add(Lang);
              Lang := GetIniString('ISPATCH', 'FINISHED_WITH_ERRORS', 'Patch finished with errors! Check the log for details!', sLang); 
              MsgBox(Lang, mbError, mb_OK);
              #endif   
              Exit;
            end else
            begin       
              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'VERIFICATION_FINISH', 'All files verification checksums is correct!', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('');
              #endif  
            end;
      #endif
      /////////////////////////////
      #ifdef PWP_MultiVersionMode
            m := 0; 
            pCount := StrToInt(GetIniString('TOTAL_VER_LIST' + fVer, 'COUNT', '0', ExpandConstant('{tmp}') + '\Checker.ini'));

            #ifdef PWP_SilentFormMode
            Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting files verification process...', sLang);
            mStr.Caption := Lang;
            mStr.Refresh;
            iStr.Caption := '';
            iStr.Refresh;

            ProgressBar.Position := 0;
            ProgressBar.Min := 0;
            ProgressBar.Max := pCount;
            #endif
            //////
            #ifndef PWP_SilentMode 
            Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting files verification process...', sLang);
            xInfo.Text := Lang;
            xInfo.Update;

            Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting files verification process...', sLang);
            pLog.Lines.Add(Lang);

            ProgressBar.Position := 0;
            ProgressBar.Min := 0;
            ProgressBar.Max := pCount;
            #endif

            repeat
              AppProcessMessage; 
              #ifndef PWP_SilentMode
              if FileExists(ExtendPath(ResultStr + GetIniString('OLD_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
              begin
                if {#PWP_CRC32_PARAM1}GetIniString('VER_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('OLD_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
                begin
                  #ifndef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'INVALID_HASH', '[!]  Invalid checksum hash for updated file: ', sLang); 
                    pLog.Lines.Add(Lang +'"'+ResultStr + GetIniString('OLD_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')+'"');
                  #endif
                  #ifdef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'S_INVALID_FILE', '[!]  Invalid file: ', sLang); 
                    s_basePath := GetIniString('OLD_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
                    Delete(s_basePath,1,1);
                    pLog.Lines.Add(Lang +'"'+ s_basePath +'"'); 
                  #endif
                  Inc(z);  
                end else
                begin
                  #ifndef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'VALID_HASH', 'Valid checksum hash for updated file: ', sLang); 
                    pLog.Lines.Add(Lang +'"'+ResultStr + GetIniString('OLD_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')+'"');
                  #endif
                  #ifdef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'S_VALID_FILE', 'OK! Valid file: ', sLang); 
                    s_basePath := GetIniString('OLD_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
                    Delete(s_basePath,1,1);
                    pLog.Lines.Add(Lang +'"'+ s_basePath +'"'); 
                  #endif
                end;
              #ifdef PWP_ForcePatchingSupport
              end else
              begin
                #ifndef PWP_SilentMode
                Lang := GetIniString('ISPATCH', 'FILE_SKIPPED', '[!]  This file not exists and skipped: ', sLang); 
                pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('OLD_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
                #endif
              end;
              #endif
              #ifndef PWP_ForcePatchingSupport
              end else
              begin
                #ifndef PWP_SilentMode
                Lang := GetIniString('ISPATCH', 'FILE_NOT_EXISTS', '[!]  Required to process file not exists: ', sLang); 
                pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('OLD_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
                #endif
                Inc(z);
              end;
              #endif

              #endif
              //////
              #ifdef PWP_SilentMode
              if FileExists(ExtendPath(ResultStr + GetIniString('OLD_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
              begin
                if {#PWP_CRC32_PARAM1}GetIniString('VER_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('OLD_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
                Inc(z);  

              #ifdef PWP_ForcePatchingSupport
              end;
              #endif
              #ifndef PWP_ForcePatchingSupport
              end else
              Inc(z);
              #endif

              #endif

              inc(m);

              #ifdef PWP_SilentFormMode
              ProgressBar.Position := m;
              SetTaskBarProgressValue(m * 100 / pCount);
              #endif
              
              #ifndef PWP_SilentMode
              ProgressBar.Position := m;
              SetTaskBarProgressValue(m * 100 / pCount);
              #endif

            until m >= pCount;

            if (z > 0) then // if Error Code was happened, show additional warning
            begin                      
              PatchingError := 1;

              #ifdef PWP_SilentFormMode
              SetTaskBarProgressState(4);
              SetTaskBarProgressValue(100);
              Lang := GetIniString('ISPATCH', 'VERIFICATION_UNSUCCESS', '[!]  Some files not exists or have incorrect checksum!', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif
              //////
              #ifndef PWP_SilentMode
              KillTimer(0, tTimerID);
              SetTaskBarProgressState(4);
              SetTaskBarProgressValue(100);

              Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
              xInfo.Text := Lang + #13#10 + FormatTime(Elapsed);
              xInfo.Update;
              Lang := GetIniString('ISPATCH', 'VERIFICATION_UNSUCCESS', '[!]  Some files not exists or have incorrect checksum!', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('');
              Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
              pLog.Lines.Add(Lang);
              Lang := GetIniString('ISPATCH', 'FINISHED_WITH_ERRORS', 'Patch finished with errors! Check the log for details!', sLang); 
              MsgBox(Lang, mbError, mb_OK);
              #endif   
              Exit;
            end else
            begin       
              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'VERIFICATION_FINISH', 'All files verification checksums is correct!', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('');
              #endif  
            end;
      #endif
  #endif
   //////
  #ifdef PWP_PatchedVerificationList

      #ifndef PWP_MultiVersionMode
            m := 0; 
            pCount := StrToInt(GetIniString('TOTALVER', 'VER', '0', ExpandConstant('{tmp}') + '\Checker.ini'));

            #ifdef PWP_SilentFormMode
            Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting files verification process...', sLang);
            mStr.Caption := Lang;
            mStr.Refresh;
            iStr.Caption := '';
            iStr.Refresh;

            ProgressBar.Position := 0;
            ProgressBar.Min := 0;
            ProgressBar.Max := pCount;
            #endif
            //////
            #ifndef PWP_SilentMode 
            Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting files verification process...', sLang);
            xInfo.Text := Lang;
            xInfo.Update;

            Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting files verification process...', sLang);
            pLog.Lines.Add(Lang);

            ProgressBar.Position := 0;
            ProgressBar.Min := 0;
            ProgressBar.Max := pCount;
            #endif

            repeat
            AppProcessMessage; 
              #ifndef PWP_SilentMode 
              if FileExists(ExtendPath(ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
              begin
                if {#PWP_CRC32_PARAM1}GetIniString('UPD_VER_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
                begin
                  #ifndef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'INVALID_HASH', '[!]  Invalid checksum hash for updated file: ', sLang); 
                    pLog.Lines.Add(Lang +'"'+ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')+'"');
                  #endif
                  #ifdef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'S_INVALID_FILE', '[!]  Invalid file: ', sLang); 
                    s_basePath := GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
                    Delete(s_basePath,1,1);
                    pLog.Lines.Add(Lang +'"'+ s_basePath +'"'); 
                  #endif
                  Inc(z);  
                end else
                begin
                  #ifndef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'VALID_HASH', 'Valid checksum hash for updated file: ', sLang); 
                    pLog.Lines.Add(Lang +'"'+ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')+'"');
                  #endif
                  #ifdef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'S_VALID_FILE', 'OK! Valid file: ', sLang); 
                    s_basePath := GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
                    Delete(s_basePath,1,1);
                    pLog.Lines.Add(Lang +'"'+ s_basePath +'"'); 
                  #endif
                end;

              #ifdef PWP_ForcePatchingSupport
              end else
              begin
                #ifndef PWP_SilentMode
                Lang := GetIniString('ISPATCH', 'FILE_SKIPPED', '[!]  This file not exists and skipped: ', sLang); 
                pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
                #endif
              end;
              #endif
              #ifndef PWP_ForcePatchingSupport
              end else
              begin
                #ifndef PWP_SilentMode
                Lang := GetIniString('ISPATCH', 'FILE_NOT_EXISTS', '[!]  Required to process file not exists: ', sLang); 
                pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
                #endif
                Inc(z);
              end;
              #endif

              #endif
              //////
              #ifdef PWP_SilentMode                              
              if FileExists(ExtendPath(ResultStr + GetIniString('VERIFIED'{VERIFIED}, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
              begin
                if {#PWP_CRC32_PARAM1}GetIniString('UPD_VER_LIST', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
                Inc(z);  
              #ifdef PWP_ForcePatchingSupport
              end;
              #endif
              #ifndef PWP_ForcePatchingSupport
              end else
              Inc(z);
              #endif

              #endif

              inc(m);

              #ifdef PWP_SilentFormMode
              ProgressBar.Position := m;
              SetTaskBarProgressValue(m * 100 / pCount);
              #endif
              //////
              #ifndef PWP_SilentMode
              ProgressBar.Position := m;
              SetTaskBarProgressValue(m * 100 / pCount);
              #endif

            until m >= pCount;

            if (z > 0) then // if Error Code was happened, show additional warning
            begin                      
              PatchingError := 1;

              #ifdef PWP_SilentFormMode
              SetTaskBarProgressState(4);
              SetTaskBarProgressValue(100);
              Lang := GetIniString('ISPATCH', 'VERIFICATION_UNSUCCESS', '[!]  Some files not exists or have incorrect checksum!', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif
              //////
              #ifndef PWP_SilentMode
              KillTimer(0, tTimerID);
              SetTaskBarProgressState(4);
              SetTaskBarProgressValue(100);

              Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
              xInfo.Text := Lang + #13#10 + FormatTime(Elapsed);
              xInfo.Update;

              Lang := GetIniString('ISPATCH', 'VERIFICATION_UNSUCCESS', '[!]  Some files not exists or have incorrect checksum!', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('');

              Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
              pLog.Lines.Add(Lang);
              Lang := GetIniString('ISPATCH', 'FINISHED_WITH_ERRORS', 'Patch finished with errors! Check the log for details!', sLang); 
              MsgBox(Lang, mbError, mb_OK);
              #endif   
              Exit;
            end else
            begin       
              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'VERIFICATION_FINISH', 'All files verification checksums is correct!', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('');
              #endif  
            end;
      #endif
      /////////////////////////////
      #ifdef PWP_MultiVersionMode
            m := 0; 
            pCount := StrToInt(GetIniString('TOTALVER' + fVer, 'VER', '0', ExpandConstant('{tmp}') + '\Checker.ini'));

            #ifdef PWP_SilentFormMode
            Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting files verification process...', sLang);
            mStr.Caption := Lang;
            mStr.Refresh;
            iStr.Caption := '';
            iStr.Refresh;

            ProgressBar.Position := 0;
            ProgressBar.Min := 0;
            ProgressBar.Max := pCount;
            #endif
            //////
            #ifndef PWP_SilentMode 
            Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting files verification process...', sLang);
            xInfo.Text := Lang;
            xInfo.Update;

            Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting files verification process...', sLang);
            pLog.Lines.Add(Lang);

            ProgressBar.Position := 0;
            ProgressBar.Min := 0;
            ProgressBar.Max := pCount;
            #endif

            repeat
            AppProcessMessage; 
              #ifndef PWP_SilentMode 
              if FileExists(ExtendPath(ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
              begin
                if {#PWP_CRC32_PARAM1}GetIniString('UPD_VER_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
                begin
                  #ifndef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'INVALID_HASH', '[!]  Invalid checksum hash for updated file: ', sLang); 
                    pLog.Lines.Add(Lang +'"'+ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')+'"');
                  #endif
                  #ifdef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'S_INVALID_FILE', '[!]  Invalid file: ', sLang); 
                    s_basePath := GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
                    Delete(s_basePath,1,1);
                    pLog.Lines.Add(Lang +'"'+ s_basePath +'"'); 
                  #endif
                  Inc(z);  
                end else
                begin
                  #ifndef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'VALID_HASH', 'Valid checksum hash for updated file: ', sLang); 
                    pLog.Lines.Add(Lang +'"'+ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')+'"');
                  #endif
                  #ifdef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'S_VALID_FILE', 'OK! Valid file: ', sLang); 
                    s_basePath := GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
                    Delete(s_basePath,1,1);
                    pLog.Lines.Add(Lang +'"'+ s_basePath +'"'); 
                  #endif
                end;
              #ifdef PWP_ForcePatchingSupport
              end else
              begin
                #ifndef PWP_SilentMode
                Lang := GetIniString('ISPATCH', 'FILE_SKIPPED', '[!]  This file not exists and skipped: ', sLang); 
                pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
                #endif
              end;
              #endif
              #ifndef PWP_ForcePatchingSupport
              end else
              begin
                #ifndef PWP_SilentMode
                Lang := GetIniString('ISPATCH', 'FILE_NOT_EXISTS', '[!]  Required to process file not exists: ', sLang); 
                pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
                #endif
                Inc(z);
              end;
              #endif

              #endif
              //////
              #ifdef PWP_SilentMode
              if FileExists(ExtendPath(ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
              begin
                if {#PWP_CRC32_PARAM1}GetIniString('UPD_VER_LIST' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
                Inc(z);  

              #ifdef PWP_ForcePatchingSupport
              end;
              #endif
              #ifndef PWP_ForcePatchingSupport
              end else
              Inc(z);
              #endif

              #endif

              inc(m);

              #ifdef PWP_SilentFormMode
              ProgressBar.Position := m;
              SetTaskBarProgressValue(m * 100 / pCount);
              #endif
              //// dfs
              #ifndef PWP_SilentMode
              ProgressBar.Position := m;
              SetTaskBarProgressValue(m * 100 / pCount);
              #endif

            until m >= pCount;

            if (z > 0) then // if Error Code was happened, show additional warning
            begin                      
              PatchingError := 1;

              #ifdef PWP_SilentFormMode
              SetTaskBarProgressState(4);
              SetTaskBarProgressValue(100);
              Lang := GetIniString('ISPATCH', 'VERIFICATION_UNSUCCESS', '[!]  Some files not exists or have incorrect checksum!', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif
              //////
              #ifndef PWP_SilentMode
              KillTimer(0, tTimerID);
              SetTaskBarProgressState(4);
              SetTaskBarProgressValue(100);

              Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
              xInfo.Text := Lang + #13#10 + FormatTime(Elapsed);
              xInfo.Update;
              Lang := GetIniString('ISPATCH', 'VERIFICATION_UNSUCCESS', '[!]  Some files not exists or have incorrect checksum!', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('');
              Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
              pLog.Lines.Add(Lang);
              Lang := GetIniString('ISPATCH', 'FINISHED_WITH_ERRORS', 'Patch finished with errors! Check the log for details!', sLang); 
              MsgBox(Lang, mbError, mb_OK);
              #endif   
              Exit;
            end else
            begin       
              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'VERIFICATION_FINISH', 'All files verification checksums is correct!', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('');
              #endif  
            end;
      #endif
   #endif
   ///////////////////////////////
   #ifdef PWP_DownloadFileSupport

      #ifdef PWP_SilentFormMode
        ProgressBar.Position := 0;
        ExitButton.Enabled := False;   
      #endif

      #ifndef PWP_SilentMode
        ProgressBar.Position := 0;
        ExitButton.Enabled := False;   
        StartButton.Enabled := False;                              
        BrowseButton.Enabled := False;   
        CancelButton.Enabled := True;
      #endif 

      #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'DOWNLOAD_REQUIRED', 'This Patch is require to download some data from the server!', sLang);
        pLog.Lines.Add(Lang);
      #endif 

      CancelClicked := False;  
          
      #ifndef PWP_DownloadCustomPath
      Downloaded := DwinsHs_ReadRemoteURL('{#PWP_DownloadUrl}', '{#PWP_AppName} {#PWP_VerInfoVersion} Patch', {#PWP_DownloadMethod}, Response, Size, ExtendPath(ResultStr + '\{#PWP_DownloadFileName}'), @OnRead);  
      #endif 

      #ifdef PWP_DownloadCustomPath
      if not DirExists(ExtendPath(ExpandConstant('{#PWP_DownloadPath}'))) then
      ForceDirectories(ExtendPath(ExpandConstant('{#PWP_DownloadPath}')));

      Downloaded := DwinsHs_ReadRemoteURL('{#PWP_DownloadUrl}', '{#PWP_AppName} {#PWP_VerInfoVersion} Patch', {#PWP_DownloadMethod}, Response, Size, ExtendPath(ExpandConstant('{#PWP_DownloadPath}\') + '{#PWP_DownloadFileName}'), @OnRead);  
      #endif 

      #ifdef PWP_DownloadMirrorSupport
      if (Downloaded <> 0) then
      if (Downloaded = 9) then
      begin
      end else
      begin
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'DOWNLOAD_MIRROR', 'Failed to download data from the main server! Try to download from the mirror...', sLang);
        pLog.Lines.Add(Lang);
        #endif 

        #ifndef PWP_DownloadCustomPath
        Downloaded := DwinsHs_ReadRemoteURL('{#PWP_DownloadMirror}', '{#PWP_AppName} {#PWP_VerInfoVersion} Patch', {#PWP_DownloadMethod}, Response, Size, ExtendPath(ResultStr + '\{#PWP_DownloadFileName}'), @OnRead);  
        #endif 

        #ifdef PWP_DownloadCustomPath
        if not DirExists(ExtendPath(ExpandConstant('{#PWP_DownloadPath}'))) then
        ForceDirectories(ExtendPath(ExpandConstant('{#PWP_DownloadPath}')));

        Downloaded := DwinsHs_ReadRemoteURL('{#PWP_DownloadMirror}', '{#PWP_AppName} {#PWP_VerInfoVersion} Patch', {#PWP_DownloadMethod}, Response, Size, ExtendPath(ExpandConstant('{#PWP_DownloadPath}\') + '{#PWP_DownloadFileName}'), @OnRead);  
        #endif 
      end;
      #endif 

      if (Downloaded = 0) then
      begin
        #ifdef PWP_SilentFormMode
        ExitButton.Enabled := True;  
        #endif

        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'READ_OK', 'The download completes successfully!', sLang);
        pLog.Lines.Add(Lang);
        pLog.Lines.Add('');

        CancelButton.Enabled := False;

        #endif
      end else
      if (Downloaded = 1) then
      begin
        #ifdef PWP_SilentFormMode
        ExitButton.Enabled := True; 
        ProgressBar.Position := 0; 
        #endif
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'CONNECT_ERROR_NETWORK', '[!]  Error: There is no Internet connection, or if all possible Internet connections are not currently active.', sLang);
        pLog.Lines.Add(Lang);

        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED', '[!]  Unable to continue patching process without required data!', sLang);
        pLog.Lines.Add(Lang);
        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED2', 'Please provide access to the server connection and try to apply Patch again!', sLang);
        pLog.Lines.Add(Lang);

        ProgressBar.Position := 0;
        ExitButton.Enabled := True;  
        //InfoButton.Enabled := True;                          
        StartButton.Enabled := True;   
        BrowseButton.Enabled := True; 
        CancelButton.Enabled := False;
        #endif
        Exit;
      end else
      if (Downloaded = 2) then
      begin
        #ifdef PWP_SilentFormMode
        ExitButton.Enabled := True; 
        ProgressBar.Position := 0; 
        #endif
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'CONNECT_ERROR_OFFLINE', '[!]  Error: The computer is in offline mode.', sLang);
        pLog.Lines.Add(Lang);

        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED', '[!]  Unable to continue patching process without required data!', sLang);
        pLog.Lines.Add(Lang);
        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED2', 'Please provide access to the server connection and try to apply Patch again!', sLang);
        pLog.Lines.Add(Lang);

        ProgressBar.Position := 0;
        ExitButton.Enabled := True;      
        //InfoButton.Enabled := True;                      
        StartButton.Enabled := True;   
        BrowseButton.Enabled := True; 
        CancelButton.Enabled := False;
        #endif
        Exit;
      end else
      if (Downloaded = 3) then
      begin
        #ifdef PWP_SilentFormMode
        ExitButton.Enabled := True; 
        ProgressBar.Position := 0; 
        #endif
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'CONNECT_ERROR_INITIALIZE', '[!]  Error: Failed to initialize the installation package for accessing Internet.', sLang);
        pLog.Lines.Add(Lang);

        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED', '[!]  Unable to continue patching process without required data!', sLang);
        pLog.Lines.Add(Lang);
        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED2', 'Please provide access to the server connection and try to apply Patch again!', sLang);
        pLog.Lines.Add(Lang);

        ProgressBar.Position := 0;
        ExitButton.Enabled := True;      
        //InfoButton.Enabled := True;                      
        StartButton.Enabled := True;   
        BrowseButton.Enabled := True; 
        CancelButton.Enabled := False;
        #endif
        Exit;
      end else
      if (Downloaded = 4) then
      begin
        #ifdef PWP_SilentFormMode
        ExitButton.Enabled := True; 
        ProgressBar.Position := 0; 
        #endif
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'CONNECT_ERROR_OPENSESSION', '[!]  Error: Failed to open the FTP or HTTP session.', sLang);
        pLog.Lines.Add(Lang);

        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED', '[!]  Unable to continue patching process without required data!', sLang);
        pLog.Lines.Add(Lang);
        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED2', 'Please provide access to the server connection and try to apply Patch again!', sLang);
        pLog.Lines.Add(Lang);

        ProgressBar.Position := 0;
        ExitButton.Enabled := True;     
        //InfoButton.Enabled := True;                       
        StartButton.Enabled := True;   
        BrowseButton.Enabled := True; 
        CancelButton.Enabled := False;
        #endif
        Exit;
      end else
      if (Downloaded = 5) then
      begin
        #ifdef PWP_SilentFormMode
        ExitButton.Enabled := True; 
        ProgressBar.Position := 0; 
        #endif
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'CONNECT_ERROR_CREATEREQUEST', '[!]  Error: Failed to create an HTTP request handle.', sLang);
        pLog.Lines.Add(Lang);

        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED', '[!]  Unable to continue patching process without required data!', sLang);
        pLog.Lines.Add(Lang);
        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED2', 'Please provide access to the server connection and try to apply Patch again!', sLang);
        pLog.Lines.Add(Lang);

        ProgressBar.Position := 0;
        ExitButton.Enabled := True;      
        //InfoButton.Enabled := True;                      
        StartButton.Enabled := True;   
        BrowseButton.Enabled := True; 
        CancelButton.Enabled := False;
        #endif
        Exit;
      end else
      if (Downloaded = 6) then
      begin
        #ifdef PWP_SilentFormMode
        ExitButton.Enabled := True; 
        ProgressBar.Position := 0; 
        #endif
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'CONNECT_ERROR_SENDREQUEST', '[!]  Error: Failed to send request to the HTTP server.', sLang);
        pLog.Lines.Add(Lang);

        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED', '[!]  Unable to continue patching process without required data!', sLang);
        pLog.Lines.Add(Lang);
        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED2', 'Please provide access to the server connection and try to apply Patch again!', sLang);
        pLog.Lines.Add(Lang);

        ProgressBar.Position := 0;
        ExitButton.Enabled := True;  
        //InfoButton.Enabled := True;                          
        StartButton.Enabled := True;   
        BrowseButton.Enabled := True; 
        CancelButton.Enabled := False;
        #endif
        Exit;
      end else
      if (Downloaded = 7) then
      begin
      #ifdef PWP_SilentFormMode
      ExitButton.Enabled := True; 
      ProgressBar.Position := 0; 
      #endif
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'READ_ERROR_DELETEFILE', '[!]  Error: The local file exists, and failed to delete it.', sLang);
      pLog.Lines.Add(Lang);

      Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED', '[!]  Unable to continue patching process without required data!', sLang);
      pLog.Lines.Add(Lang);
      Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED2', 'Please provide access to the server connection and try to apply Patch again!', sLang);
      pLog.Lines.Add(Lang);

      ProgressBar.Position := 0;
      ExitButton.Enabled := True;       
      //InfoButton.Enabled := True;                     
      StartButton.Enabled := True;   
      BrowseButton.Enabled := True; 
      CancelButton.Enabled := False;
      #endif
      Exit;
      end else
      if (Downloaded = 8) then
      begin
        #ifdef PWP_SilentFormMode
        ExitButton.Enabled := True; 
        ProgressBar.Position := 0; 
        #endif
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'READ_ERROR_SAVEFILE', '[!]  Error: Failed to save data to the local file.', sLang);
        pLog.Lines.Add(Lang);

        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED', '[!]  Unable to continue patching process without required data!', sLang);
        pLog.Lines.Add(Lang);
        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED2', 'Please provide access to the server connection and try to apply Patch again!', sLang);
        pLog.Lines.Add(Lang);

        ProgressBar.Position := 0;
        ExitButton.Enabled := True;       
        //InfoButton.Enabled := True;                     
        StartButton.Enabled := True;   
        BrowseButton.Enabled := True; 
        CancelButton.Enabled := False;
        #endif
        Exit;
      end else
      if (Downloaded = 9) then
      begin
        #ifdef PWP_SilentFormMode
        ExitButton.Enabled := True; 
        ProgressBar.Position := 0; 
        #endif
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'READ_ERROR_CANCELED', '[!]  Error: The download operation is terminated by user.', sLang);
        pLog.Lines.Add(Lang);

        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED', '[!]  Unable to continue patching process without required data!', sLang);
        pLog.Lines.Add(Lang);
        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED2', 'Please provide access to the server connection and try to apply Patch again!', sLang);
        pLog.Lines.Add(Lang);

        ProgressBar.Position := 0;
        ExitButton.Enabled := True;   
        //InfoButton.Enabled := True;                         
        StartButton.Enabled := True;   
        BrowseButton.Enabled := True; 
        CancelButton.Enabled := False;
        #endif
        Exit;
      end else
      if (Downloaded = 10) then
      begin
        #ifdef PWP_SilentFormMode
        ExitButton.Enabled := True; 
        ProgressBar.Position := 0; 
        #endif
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'READ_ERROR_READDATA', '[!]  Error: Failed to read data from the remote URL.', sLang);
        pLog.Lines.Add(Lang);

        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED', '[!]  Unable to continue patching process without required data!', sLang);
        pLog.Lines.Add(Lang);
        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED2', 'Please provide access to the server connection and try to apply Patch again!', sLang);
        pLog.Lines.Add(Lang);

        ProgressBar.Position := 0;
        ExitButton.Enabled := True;       
        //InfoButton.Enabled := True;                     
        StartButton.Enabled := True;   
        BrowseButton.Enabled := True; 
        CancelButton.Enabled := False;
        #endif
        Exit;
      end else
      if (Downloaded >= 400) then
      begin
        #ifdef PWP_SilentFormMode
        ExitButton.Enabled := True; 
        ProgressBar.Position := 0; 
        #endif
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'UNKNOWN_ERROR', '[!]  Unknown error: The HTTP status code is: ', sLang);
        pLog.Lines.Add(Lang + IntToStr(Downloaded));

        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED', '[!]  Unable to continue patching process without required data!', sLang);
        pLog.Lines.Add(Lang);
        Lang := GetIniString('ISPATCH', 'DOWNLOAD_FAILED2', 'Please provide access to the server connection and try to apply Patch again!', sLang);
        pLog.Lines.Add(Lang);

        ProgressBar.Position := 0;
        ExitButton.Enabled := True;       
        //InfoButton.Enabled := True;                     
        StartButton.Enabled := True;   
        BrowseButton.Enabled := True; 
        CancelButton.Enabled := False;
        #endif
        Exit;
      end;

   #endif 

    #ifndef PWP_SilentMode
      ProgressBar.Position := 0;
      ExitButton.Enabled := False;   
      StartButton.Enabled := False;                             
      BrowseButton.Enabled := False;   
    #endif 

    #ifdef PWP_SilentFormMode
      #ifdef PWP_InsidePatch
        Lang := GetIniString('ISPATCH', 'EXTRACT_TEMP_PATCH_DATA', 'Extracting patch-data to the temporary dir...', sLang);
        mStr.Caption := Lang;
        mStr.Refresh;
      #endif 
      #ifndef PWP_InsidePatch
        Lang := GetIniString('ISPATCH', 'DIRECT_PATCH_DATA', 'Direct access to the patch-data...', sLang);
        mStr.Caption := Lang;
        mStr.Refresh;
      #endif 
    #endif
    //////
    #ifndef PWP_SilentMode
      #ifdef PWP_InsidePatch
        Lang := GetIniString('ISPATCH', 'EXTRACT_TEMP_PATCH_DATA', 'Extracting patch-data to the temporary dir...', sLang);
        pLog.Lines.Add(Lang);

        #ifndef PWP_SimplyLogSupport
        #ifndef PWP_SilentMode
        pLog.Lines.Add('');
        #endif
        #endif

        xInfo.Text := Lang;
        xInfo.Update;
      #endif 
      #ifndef PWP_InsidePatch
        Lang := GetIniString('ISPATCH', 'DIRECT_PATCH_DATA', 'Direct access to the patch-data...', sLang);
        pLog.Lines.Add(Lang);

        #ifndef PWP_SimplyLogSupport
        #ifndef PWP_SilentMode
        pLog.Lines.Add('');
        #endif
        #endif

      #endif 
    #endif 

    #ifdef PWP_InsidePatch
      #ifndef PWP_MultiVersionMode
        tc := StrToInt(GetIniString('TOTAL_TMP_PATCH_DATA', 'TMP_PD', '0', ExpandConstant('{tmp}') + '\Checker.ini')); 

        #ifdef PWP_SilentFormMode
        ProgressBar.Position := 0;
        ProgressBar.Min := 0;
        ProgressBar.Max := tc;
        #endif
        ////
        #ifndef PWP_SilentMode 
        ProgressBar.Position := 0;
        ProgressBar.Min := 0;
        ProgressBar.Max := tc;
        #endif

        for tp:=0 to tc-1 do
        begin
          AppProcessMessage;
          tf := GetIniString('TMP_PATCH_DATA', IntToStr(tp),'0', ExpandConstant('{tmp}') + '\Checker.ini');

          #ifndef PWP_SilentMode
            #ifndef PWP_SimplyLogSupport
            Lang := GetIniString('ISPATCH', 'S_EXTRACTING', '--> Extracting file: ', sLang);
            pLog.Lines.Add(Lang + '"'+tf+'"');
            #endif
          #endif

          ExtractTemporaryFiles(tf); 

          #ifdef PWP_SilentFormMode
          ProgressBar.Position := tp+1;
          SetTaskBarProgressValue((tp+1) * 100 / tc);
          #endif
          #ifndef PWP_SilentMode
          ProgressBar.Position := tp+1;
          SetTaskBarProgressValue((tp+1) * 100 / tc);
          #endif
        end;
      #endif
      //////
      #ifdef PWP_MultiVersionMode
        tc := StrToInt(GetIniString('TOTAL_TMP_PATCH_DATA' + fVer, 'TMP_PD', '0', ExpandConstant('{tmp}') + '\Checker.ini')); 

        #ifdef PWP_SilentFormMode
        ProgressBar.Position := 0;
        ProgressBar.Min := 0;
        ProgressBar.Max := tc;
        #endif
        ////
        #ifndef PWP_SilentMode 
        ProgressBar.Position := 0;
        ProgressBar.Min := 0;
        ProgressBar.Max := tc;
        #endif

        for tp:=0 to tc-1 do
        begin
          AppProcessMessage;
          tf := GetIniString('TMP_PATCH_DATA' + fVer, IntToStr(tp),'0', ExpandConstant('{tmp}') + '\Checker.ini');

          #ifndef PWP_SilentMode
            #ifndef PWP_SimplyLogSupport
            Lang := GetIniString('ISPATCH', 'S_EXTRACTING', '--> Extracting file: ', sLang);
            pLog.Lines.Add(Lang + '"'+tf+'"');
            #endif
          #endif

          ExtractTemporaryFiles(tf); 

          #ifdef PWP_SilentFormMode
          ProgressBar.Position := tp+1;
          SetTaskBarProgressValue((tp+1) * 100 / tc);
          #endif
          #ifndef PWP_SilentMode
          ProgressBar.Position := tp+1;
          SetTaskBarProgressValue((tp+1) * 100 / tc);
          #endif
        end;
      #endif
    #endif

    #ifdef PWP_InsidePatch
      #ifndef PWP_SilentMode
        pLog.Lines.Add('');
      #endif
    #endif
    /////////////////////////         
    //InsertCodeBeforeUpdate;
    /////////////////////////
    if PatchingError = 1 then
    begin
      #ifndef PWP_SilentMode
      ExitButton.Enabled := True;                          
      StartButton.Enabled := True;   
      BrowseButton.Enabled := True; 
      #endif
      Exit;
    end;
    ///////////////////////////////  

    //fp

    #ifdef PWP_SilentFormMode
        Lang := GetIniString('ISPATCH', 'PATCHING', 'Patching: ', sLang);
        mStr.Caption := Lang + '{#PWP_AppName}';
        mStr.Refresh;
        Lang := GetIniString('ISPATCH', 'PATCHING_PROCESS', 'Patching process, please wait...', sLang);
        iStr.Caption := Lang;
        iStr.Refresh;
    #endif
    ///
    #ifndef PWP_SilentMode 
        oDir.ReadOnly := True;
        oDir.Refresh;
        Lang := GetIniString('ISPATCH', 'PATCHING_PROCESS', 'Patching process, please wait...', sLang);

        Elapsed := 0;
        Start:=GetTickCount;

        tfunc:= WrapTimerProc(@tTimer, 4);
        tTimerID:= SetTimer(0, 0, 100, tfunc);
        //tfunc:= WrapTimerProc(@tTimer, 4);
        //tTimerID:= SetTimer(0, 0, 1000, tfunc);

        xInfo.Text := Lang + #13#10 + FormatTime(Elapsed);
        xInfo.Update;
    #endif

    #ifndef PWP_MultiVersionMode
        pCount := StrToInt(GetIniString('TOTALVER', 'VER', '', ExpandConstant('{tmp}') + '\Checker.ini')); // get the included files count
    #endif
    #ifdef PWP_MultiVersionMode
        pCount := StrToInt(GetIniString('TOTALVER' + fVer, 'VER', '', ExpandConstant('{tmp}') + '\Checker.ini')); // get the included files count
    #endif

    begin
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'START_PATCHING', '[Starting patching session]', sLang);
      pLog.Lines.Add(Lang);
      #endif
      m := 0;

      #ifdef PWP_ForcePatchingSupport
      d := 0;
      #endif

      #ifdef PWP_SilentFormMode
      ProgressBar.Position := 0;
      ProgressBar.Min := 0;
      ProgressBar.Max := pCount;
      SetTaskBarProgressValue(0);
      #endif
      //////
      #ifndef PWP_SilentMode 
      ProgressBar.Position := 0;
      ProgressBar.Min := 0;
      ProgressBar.Max := pCount;
      SetTaskBarProgressValue(0);
      #endif

      #ifdef PWP_XDELTAEngine
      begin
        #ifdef PWP_CustomXParam
        EngineParam := '{#PWP_XAParam} ';
        #endif
        #ifndef PWP_CustomXParam
        EngineParam := '-d -f -s ';
        #endif

        if not IsWin64 then
        begin
          ExtractTemporaryFile('xdelta-x86.exe');
          PatchEngine := 'xdelta-x86.exe';
        end else
        begin
          ExtractTemporaryFile('xdelta-x64.exe');
          PatchEngine := 'xdelta-x64.exe';
        end;
      end;
      #endif
      
      #ifdef PWP_JojoDiffEngine
          #ifdef PWP_CustomJParam
          EngineParam := '{#PWP_JAParam} ';
          #endif
          #ifndef PWP_CustomJParam
          EngineParam := '';
          #endif

          if not IsWin64 then
          begin
            ExtractTemporaryFile('jptch-x86.exe');
            PatchEngine := 'jptch-x86.exe';
          end else
          begin
            ExtractTemporaryFile('jptch-x64.exe');
            PatchEngine := 'jptch-x64.exe';
          end;
      #endif
      
      #ifdef PWP_HDiffEngine
          #ifdef PWP_CustomHParam
          EngineParam := '{#PWP_HAParam} ';
          #endif
          #ifndef PWP_CustomHParam
          EngineParam := '-s -f ';
          #endif

          if not IsWin64 then
          begin
            ExtractTemporaryFile('hpatchz-x86.exe');
            PatchEngine := 'hpatchz-x86.exe';
          end else
          begin
            ExtractTemporaryFile('hpatchz-x64.exe');
            PatchEngine := 'hpatchz-x64.exe';
          end;
      #endif

    #ifdef PWP_MultiVersionMode
       #ifdef PWP_BackupWithMultiVersion
       BACKUP_DIR := BAK_DIR+' '+fVer;
       #endif
       #ifndef PWP_BackupWithMultiVersion
       BACKUP_DIR := BAK_DIR;
       #endif
    #endif
    #ifndef PWP_MultiVersionMode
       BACKUP_DIR := BAK_DIR;
    #endif

    bkp := 0;
    if DirExists(ExtendPath(ResultStr + BACKUP_DIR)) then
    begin
      while DirExists(ExtendPath(ResultStr + BACKUP_DIR)) do
      begin
        inc(bkp);
        if not DirExists(ExtendPath(ResultStr + BACKUP_DIR + '-' + IntToStr(bkp))) then
        begin
          BACKUP_DIR := BACKUP_DIR + '-' + IntToStr(bkp);
          Break;
        end;
      end;
    end;

    corcnt := GetApplyingCores;
    SetLength(pProcessInfo, pCount);

    repeat 
      AppProcessMessage;

      #ifdef PWP_InsidePatch
        #ifndef PWP_MultiVersionMode
          basePath := ExpandConstant('{tmp}') + '\{#PWP_PatchDataDirName}';
        #endif
        #ifdef PWP_MultiVersionMode
          basePath := ExpandConstant('{tmp}') + '\{#PWP_PatchDataDirName}\' + fVer;
        #endif
      #endif

      #ifndef PWP_InsidePatch
        upstr := ExpandConstant('{src}'); 
        if upstr = ExtractFileDir(upstr) then
        upstr := RemoveBackslash(upstr);

        #ifndef PWP_MultiVersionMode
          basePath := upstr + '\{#PWP_PatchDataDirName}';
        #endif
        #ifdef PWP_MultiVersionMode
          basePath := upstr + '\{#PWP_PatchDataDirName}\' + fVer;
        #endif
      #endif

      #ifndef PWP_MultiVersionMode
        srcFile := GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
      #endif
      #ifdef PWP_MultiVersionMode
        srcFile := GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
      #endif

      destFile := srcFile;    

      srcFile := basePath + srcFile + '.{#PWP_PatchDataExtensionName}';
      t_basePath := ResultStr + destFile;
      
      if FileExists(ExtendPath(t_basePath)) then
      begin
        b_basePath := t_basePath; 
        Delete(b_basePath,1,Length(ResultStr));    
        ForceDirectories(ExtendPath(ExtractFilePath(ResultStr + BACKUP_DIR + b_basePath))); 
        MoveFileEx(ExtendPath(t_basePath),ExtendPath(ResultStr + BACKUP_DIR + b_basePath), $1 or $2);

        if FileExists(ExtendPath(srcFile)) and FileExists(ExtendPath(ResultStr + BACKUP_DIR + b_basePath)) then // check if patch-data and same original file is exists
        begin  
          #ifndef PWP_SilentMode
             #ifndef PWP_SimplyLogSupport
                Lang := GetIniString('ISPATCH', 'TARGET_FILE', 'Target file: ', sLang);
                pLog.Lines.Add(Lang +'"'+ t_basePath +'"');
                Lang := GetIniString('ISPATCH', 'PATCH_DATA_FILE', 'Patch-data file: ', sLang);
                pLog.Lines.Add(Lang +'"'+srcFile+'"');
             #endif
             #ifdef PWP_SimplyLogSupport
                Lang := GetIniString('ISPATCH', 'S_PATCHING', '--> Patching file: ', sLang);
                s_basePath := b_basePath;
                Delete(s_basePath,1,1);
                pLog.Lines.Add(Lang +'"'+ s_basePath +'"');
             #endif
          #endif

          CreateAppProcess(ExpandConstant('{tmp}\') + PatchEngine, EngineParam + '"'+ExtendPath(ResultStr + BACKUP_DIR + b_basePath)+'" "'+ExtendPath(srcFile)+'" "'+ExtendPath(t_basePath)+'"', pProcessInfo[m]);
          
          while IsProcessRunning(PatchEngine) > (corcnt-1) do
          begin 
            AppProcessMessage; 
            Sleep(50);
          end; 

          #ifndef PWP_SilentMode   
          begin   
            #ifndef PWP_SimplyLogSupport
              Lang := GetIniString('ISPATCH', 'OUTPUT_PATCHED', 'Output patched: ', sLang);                   
              pLog.Lines.Add(Lang +'"'+t_basePath+'"');
            #endif
          end;
          #endif

          #ifdef PWP_ForcePatchingSupport
          inc(d); 
          #endif

        end else

        #ifndef PWP_ForcePatchingSupport
        begin
          #ifndef PWP_SilentMode
          Lang := GetIniString('ISPATCH', 'UNKNOWN_PATCHING_ERROR', 'Some error was ocurred while appling patch-data to: ', sLang); 
          pLog.Lines.Add(Lang +'"'+t_basePath+'"');
          #endif
          inc(z);   
        end;
        #endif

        #ifdef PWP_ForcePatchingSupport
        end;
        inc(m); 

        #ifdef PWP_SilentFormMode
        ProgressBar.Position := m;
        SetTaskBarProgressValue(m * 100 / pCount);
        #endif
        ////
        #ifndef PWP_SilentMode
        ProgressBar.Position := m;
        SetTaskBarProgressValue(m * 100 / pCount);
        #endif

        #endif

    #ifndef PWP_ForcePatchingSupport
      end else
      begin // if files between patch-data and original dirs is missmatch, get the critical error and exit from the procedure
        #ifdef PWP_SilentFormMode
        ProgressBar.Position := pCount;

        SetTaskBarProgressState(4);
        SetTaskBarProgressValue(100);

        Lang := GetIniString('ISPATCH', 'ROLLBACK_ERROR', 'Error while patching was ocurred and Patch apply the rollback.', sLang);
        mStr.Caption := Lang;
        mStr.Refresh;
        Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
        iStr.Caption := Lang;
        iStr.Refresh;
        #endif
        ////
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'NOT_EXISTS_OR_MISSMATCH', 'Error: Files for patching in the selected dir are not exists or missmatch.', sLang); 
        pLog.Lines.Add(Lang);

        Lang := GetIniString('ISPATCH', 'CORRECT_PROBLEM', 'Please correct the problem and apply Patch again.', sLang);  
        pLog.Lines.Add(Lang);   

        ProgressBar.Position := pCount;

        KillTimer(0, tTimerID);

        SetTaskBarProgressState(4);
        SetTaskBarProgressValue(100);

        StartButton.Enabled := false;
        BrowseButton.Enabled := false; 
        //InfoButton.Enabled := True; 
        ExitButton.Enabled := True; 
        oDir.ReadOnly := True;

        Lang := GetIniString('ISPATCH', 'NOTHING_TO_PATCH', 'Error! In installation dir not exists required files for patching!', sLang); 
        Lang2 := GetIniString('ISPATCH', 'NOTHING_TO_PATCH2', 'Please check the original files or it filenames in selected dir!', sLang); 
        MsgBox(Lang + #13 + Lang2, mbCriticalError, mb_OK);
        #endif

        RollBack;
        DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini'); 

        PatchingError := 1;
        Exit;
      end;

      inc(m); 

      #ifdef PWP_SilentFormMode
      ProgressBar.Position := m;
      SetTaskBarProgressValue(m * 100 / pCount);
      #endif
      #ifndef PWP_SilentMode
      ProgressBar.Position := m;
      SetTaskBarProgressValue(m * 100 / pCount);
      #endif
    #endif

    until m >= pCount   

    #ifndef PWP_SilentMode
    Lang := GetIniString('ISPATCH', 'PATCHING_END', '[Ending patching session]', sLang); 
    pLog.Lines.Add(Lang); 
    #endif    

    // fp new here
    //#ifdef PWP_FastPatchingMode
      #ifndef PWP_SilentMode
        pLog.Lines.Add(''); 
        Lang := GetIniString('ISPATCH', 'PREPARING_TO_OPERATIONS', 'Preparing to the next operations, waiting for unloading patching engine...', sLang); 
        pLog.Lines.Add(Lang);
        pLog.Lines.Add('');  
      #endif

        while IsProcessRunning(PatchEngine) > 0 do
        begin 
          AppProcessMessage; 
          Sleep(50);
        end;                              

        for i:=0 to pCount-1 do
          CloseProcessHandles(pProcessInfo[i]);
    //#endif

    #ifndef PWP_ForcePatchingSupport
      #ifndef PWP_MultiVersionMode   
        #ifndef PWP_SilentMode
        //pLog.Lines.Add('::> Verifing patch-data...');
        Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting verification process...', sLang); 
        pLog.Lines.Add('::> ' + Lang);
        #endif
        oCount := StrToInt(GetIniString('TOTALVER', 'VER', '0', ExpandConstant('{tmp}') + '\Checker.ini'));
        for i:=0 to oCount-1 do
        begin   
          AppProcessMessage; 
          if not FileExists(ResultStr + GetIniString('VERIFIED', IntToStr(i), '', ExpandConstant('{tmp}') + '\Checker.ini')) then
          begin
            #ifndef PWP_SilentMode
            Lang := GetIniString('ISPATCH', 'VERIFICATION_UNSUCCESS', '[!]  Some files do not exist or have incorrect hash!', sLang); 
            pLog.Lines.Add(Lang + ' > '+ExtendPath(GetIniString('VERIFIED', IntToStr(i), '', ExpandConstant('{tmp}') + '\Checker.ini')));
            #endif
            inc(z);
          end;
        end;
      #endif
      #ifdef PWP_MultiVersionMode
        #ifndef PWP_SilentMode
        //pLog.Lines.Add('::> Verifing patch-data...');
        Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting verification process...', sLang); 
        pLog.Lines.Add('::> ' + Lang);
        #endif
        oCount := StrToInt(GetIniString('TOTALVER' + fVer, 'VER', '0', ExpandConstant('{tmp}') + '\Checker.ini'));
        for i:=0 to oCount-1 do
        begin    
          AppProcessMessage; 
          if not FileExists(ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(i), '', ExpandConstant('{tmp}') + '\Checker.ini')) then
          begin
            #ifndef PWP_SilentMode
            Lang := GetIniString('ISPATCH', 'VERIFICATION_UNSUCCESS', '[!]  Some files do not exist or have incorrect hash!', sLang); 
            pLog.Lines.Add(Lang + ' > '+ExtendPath(GetIniString('VERIFIED' + fVer, IntToStr(i), '', ExpandConstant('{tmp}') + '\Checker.ini'))); 
            #endif
            inc(z);
          end;
        end;
      #endif
      (*
      *)
    #endif

    if (z > 0) or (v > 0) or (j > 0) then // if Error Code was happened, show additional warning
    begin                      
      PatchingError := 1;

      #ifdef PWP_SilentFormMode
      SetTaskBarProgressState(4);
      SetTaskBarProgressValue(100);
      Lang := GetIniString('ISPATCH', 'ROLLBACK_ERROR', 'Error while patching was ocurred and Patch apply the rollback.', sLang);
      mStr.Caption := Lang;
      mStr.Refresh;
      Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
      iStr.Caption := Lang;
      iStr.Refresh;
      #endif

      #ifndef PWP_SilentMode
      KillTimer(0, tTimerID);
      SetTaskBarProgressState(4);
      SetTaskBarProgressValue(100);
      #endif

      RollBack;
      DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');

      #ifdef PWP_SilentFormMode
      Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
      Lang2 := GetIniString('ISPATCH', 'ROLLBACK_END', 'Error ocurred. Rollback applied. All patched files restored.', sLang);
      mStr.Caption := Lang + ' ' + Lang2;
      mStr.Refresh;
      #endif
      
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'FINISHED_WITH_ERRORS', 'Patch finished with errors! Check the log for details!', sLang); 
      MsgBox(Lang, mbError, mb_OK);
      #endif   
      Exit;
    end;

    #ifndef PWP_SilentMode
    pLog.Lines.Delete(pLog.Lines.Count-1);
    Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting verification process... OK!', sLang); 
    pLog.Lines.Add('::> ' + Lang + ' OK!');
    #endif

    t := 0; 
    v := 0; 

    #ifndef PWP_MultiVersionMode                                       
    // if are available included files start the copying session
    if IniKeyExists('INCLUDED','0',ExpandConstant('{tmp}') + '\Checker.ini') then
    begin
      #ifndef PWP_SilentMode
      pLog.Lines.Add(''); 
      Lang := GetIniString('ISPATCH', 'COPYING_START', '[Copying session start]', sLang); 
      pLog.Lines.Add(Lang);  
      #endif
      iCount := StrToInt(GetIniString('TOTALINC', 'INC', '', ExpandConstant('{tmp}') + '\Checker.ini')); // get the included files count

      // set the new parameters for progress bar

      #ifdef PWP_SilentFormMode
      ProgressBar.Position := 0;
      SetTaskBarProgressValue(0);

      ProgressBar.Min := 0;
      ProgressBar.Max := iCount; 
      #endif
      #ifndef PWP_SilentMode
      ProgressBar.Position := 0;
      SetTaskBarProgressValue(0);

      ProgressBar.Min := 0;
      ProgressBar.Max := iCount;  
      #endif
      // creating new session for copying
      repeat
        AppProcessMessage;
        
        ini := GetIniString('INCLUDED', IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');
           
        #ifdef PWP_InsidePatch
        if FileExists(ExpandConstant('{tmp}') + '\{#PWP_PatchDataDirName}' + ini) then
        #endif
        #ifndef PWP_InsidePatch
        upstr := ExpandConstant('{src}'); 
        if upstr = ExtractFileDir(upstr) then
        upstr := RemoveBackslash(upstr);

        if FileExists(upstr + '\{#PWP_PatchDataDirName}' + ini) then
        #endif

        begin
           ForceDirectories(ExtendPath(ExtractFilePath(ResultStr + ini))); 

           if FileExists(ExtendPath(ResultStr + ini)) then
           begin
             ForceDirectories(ExtendPath(ExtractFilePath(ResultStr + BACKUP_DIR + ini))); 
             MoveFileEx(ExtendPath(ResultStr + ini),ExtendPath(ResultStr + BACKUP_DIR + ini), $1 or $2);
           end;

           // needed if included file exist and have r-s-h attributes (it moved/backup)
           // SetFileAttributes(ExtendPath(ResultStr + ini),$80);

           #ifdef PWP_InsidePatch
           if not FileCopy(ExpandConstant('{tmp}') + '\{#PWP_PatchDataDirName}' + ini, ExtendPath(ResultStr + ini), False) then
           #endif
           #ifndef PWP_InsidePatch
           upstr := ExpandConstant('{src}'); 
           if upstr = ExtractFileDir(upstr) then
           upstr := RemoveBackslash(upstr);

           if not FileCopy(upstr + '\{#PWP_PatchDataDirName}' + ini, ExtendPath(ResultStr + ini), False) then
           #endif
           begin
              inc(v);

              #ifdef PWP_SilentFormMode

              #ifdef PWP_InsidePatch
              #endif
              #ifndef PWP_InsidePatch
              upstr := ExpandConstant('{src}'); 
              if upstr = ExtractFileDir(upstr) then
              upstr := RemoveBackslash(upstr);
              #endif

              #endif
              ///
              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'COPY_FAILED', 'Error: Failed to copy included file: ', sLang); 
              Lang2 := GetIniString('ISPATCH', 'COPY_FAILED2', ' to: ', sLang); 

              #ifdef PWP_InsidePatch
              pLog.Lines.Add(Lang +'"'+ ExpandConstant('{tmp}') + '\{#PWP_PatchDataDirName}' + ini +'"'+ Lang2 +'"'+ ResultStr + ini+'"'); 
              #endif
              #ifndef PWP_InsidePatch
              upstr := ExpandConstant('{src}'); 
              if upstr = ExtractFileDir(upstr) then
              upstr := RemoveBackslash(upstr);
              pLog.Lines.Add(Lang +'"'+ upstr + '\{#PWP_PatchDataDirName}' + ini +'"'+ Lang2 +'"'+ ResultStr + ini+'"'); 
              #endif

              Lang := GetIniString('ISPATCH', 'COPY_IN_USE', 'Maybe ', sLang);   
              Lang2 := GetIniString('ISPATCH', 'COPY_IN_USE2', ' in use!', sLang);  
              pLog.Lines.Add(Lang +'"'+ ResultStr + ini +'"'+ Lang2);
              #endif

           end else
           begin    
              #ifdef PWP_SilentFormMode

              #ifdef PWP_InsidePatch

              #endif
              #ifndef PWP_InsidePatch
              upstr := ExpandConstant('{src}'); 
              if upstr = ExtractFileDir(upstr) then
              upstr := RemoveBackslash(upstr);
              #endif
               
              #endif
              ///
              #ifndef PWP_SilentMode
                #ifndef PWP_SimplyLogSupport
                  Lang := GetIniString('ISPATCH', 'INCLUDED_COPYIED', 'Included file: ', sLang); 
                  Lang2 := GetIniString('ISPATCH', 'INCLUDED_COPYIED2', ' is copied to: ', sLang);

                  #ifdef PWP_InsidePatch
                  pLog.Lines.Add(Lang +'"'+ ExpandConstant('{tmp}') + '\{#PWP_PatchDataDirName}' + ini +'"'+ Lang2 +'"'+ ResultStr + ini+'"'); 
                  #endif
                #endif
                #ifdef PWP_SimplyLogSupport
                  Lang := GetIniString('ISPATCH', 'S_COPYING', '--> Copying file: ', sLang); 

                  #ifdef PWP_InsidePatch
                  s_basePath := ini;
                  Delete(s_basePath,1,1);
                  pLog.Lines.Add(Lang +'"'+ s_basePath +'"');
                  #endif
                #endif

                #ifndef PWP_InsidePatch
                upstr := ExpandConstant('{src}'); 
                if upstr = ExtractFileDir(upstr) then
                upstr := RemoveBackslash(upstr);
                #ifndef PWP_SimplyLogSupport
                  pLog.Lines.Add(Lang +'"'+ upstr + '\{#PWP_PatchDataDirName}' + ini +'"'+ Lang2 +'"'+ ResultStr + ini+'"'); 
                #endif
                #ifdef PWP_SimplyLogSupport
                  s_basePath := ini;
                  Delete(s_basePath,1,1);
                  pLog.Lines.Add(Lang +'"'+ s_basePath +'"');
                #endif

                #endif
              #endif
           end;
        end;

      inc(t);

      #ifdef PWP_SilentFormMode
      ProgressBar.Position := t;
      SetTaskBarProgressValue(t * 100 / iCount);
      #endif
      #ifndef PWP_SilentMode
      ProgressBar.Position := t;
      SetTaskBarProgressValue(t * 100 / iCount);
      #endif
      until t >= iCount;
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'COPYING_END', '[Copying session end]', sLang); 
      pLog.Lines.Add(Lang);
      #endif
    end;
    #endif
    //////
    #ifdef PWP_MultiVersionMode
    // if are available included files start the copying session
    if IniKeyExists('INCLUDED' + fVer,'0',ExpandConstant('{tmp}') + '\Checker.ini') then
    begin
      #ifndef PWP_SilentMode
      pLog.Lines.Add(''); 
      Lang := GetIniString('ISPATCH', 'COPYING_START', '[Copying session start]', sLang); 
      pLog.Lines.Add(Lang);  
      #endif
      iCount := StrToInt(GetIniString('TOTALINC' + fVer, 'INC', '', ExpandConstant('{tmp}') + '\Checker.ini')); // get the included files count

      // set the new parameters for progress bar
      #ifdef PWP_SilentFormMode
      ProgressBar.Position := 0;
      SetTaskBarProgressValue(0);

      ProgressBar.Min := 0;
      ProgressBar.Max := iCount; 
      #endif
      #ifndef PWP_SilentMode
      ProgressBar.Position := 0;
      SetTaskBarProgressValue(0);

      ProgressBar.Min := 0;
      ProgressBar.Max := iCount;  
      #endif
      // create the new session for copying
      repeat
        AppProcessMessage;
        // get the file
        ini := GetIniString('INCLUDED' + fVer, IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');
           
        #ifdef PWP_InsidePatch
        if FileExists(ExpandConstant('{tmp}') + '\{#PWP_PatchDataDirName}\' + fVer + ini) then
        #endif
        #ifndef PWP_InsidePatch
        upstr := ExpandConstant('{src}'); 
        if upstr = ExtractFileDir(upstr) then
        upstr := RemoveBackslash(upstr); 

        if FileExists(upstr + '\{#PWP_PatchDataDirName}\' + fVer + ini) then
        #endif

        begin
          ForceDirectories(ExtendPath(ExtractFilePath(ResultStr + ini))); 

           if FileExists(ExtendPath(ResultStr + ini)) then
           begin
             ForceDirectories(ExtendPath(ExtractFilePath(ResultStr + BACKUP_DIR + ini))); 
             MoveFileEx(ExtendPath(ResultStr + ini),ExtendPath(ResultStr + BACKUP_DIR + ini), $1 or $2);
           end;

          // needed if included file exist and have r-s-h attributes (it moved/backup)
          // SetFileAttributes(ExtendPath(ResultStr + ini),$80);

          #ifdef PWP_InsidePatch
          if not FileCopy(ExpandConstant('{tmp}') + '\{#PWP_PatchDataDirName}\' + fVer + ini, ExtendPath(ResultStr + ini), False) then
          #endif
          #ifndef PWP_InsidePatch
          upstr := ExpandConstant('{src}'); 
          if upstr = ExtractFileDir(upstr) then
          upstr := RemoveBackslash(upstr);

          if not FileCopy(upstr + '\{#PWP_PatchDataDirName}\' + fVer + ini, ExtendPath(ResultStr + ini), False) then
          #endif
          begin
            inc(v);

            #ifdef PWP_SilentFormMode
              #ifdef PWP_InsidePatch
              #endif
              #ifndef PWP_InsidePatch
              upstr := ExpandConstant('{src}'); 
              if upstr = ExtractFileDir(upstr) then
              upstr := RemoveBackslash(upstr);
              #endif
            #endif
            ///
            #ifndef PWP_SilentMode
            Lang := GetIniString('ISPATCH', 'COPY_FAILED', 'Error: Failed to copy included file: ', sLang); 
            Lang2 := GetIniString('ISPATCH', 'COPY_FAILED2', ' to: ', sLang); 

            #ifdef PWP_InsidePatch
            pLog.Lines.Add(Lang +'"'+ ExpandConstant('{tmp}') + '\{#PWP_PatchDataDirName}\' + fVer + ini +'"'+ Lang2 +'"'+ ResultStr + ini+'"'); 
            #endif
            #ifndef PWP_InsidePatch
            upstr := ExpandConstant('{src}'); 
            if upstr = ExtractFileDir(upstr) then
            upstr := RemoveBackslash(upstr);

            pLog.Lines.Add(Lang +'"'+ upstr + '\{#PWP_PatchDataDirName}\' + fVer + ini +'"'+ Lang2 +'"'+ ResultStr + ini+'"'); 
            #endif

            Lang := GetIniString('ISPATCH', 'COPY_IN_USE', 'Maybe ', sLang);   
            Lang2 := GetIniString('ISPATCH', 'COPY_IN_USE2', ' in use!', sLang);  
            pLog.Lines.Add(Lang +'"'+ ResultStr + ini +'"'+ Lang2);
            #endif

           end else
           begin    
              #ifdef PWP_SilentFormMode
                #ifdef PWP_InsidePatch
                #endif

                #ifndef PWP_InsidePatch
                upstr := ExpandConstant('{src}'); 
                if upstr = ExtractFileDir(upstr) then
                upstr := RemoveBackslash(upstr);
                #endif 
              #endif
                 ///
              #ifndef PWP_SilentMode
                #ifndef PWP_SimplyLogSupport
                  Lang := GetIniString('ISPATCH', 'INCLUDED_COPYIED', 'Included file: ', sLang); 
                  Lang2 := GetIniString('ISPATCH', 'INCLUDED_COPYIED2', ' is copied to: ', sLang);

                  #ifdef PWP_InsidePatch
                    pLog.Lines.Add(Lang +'"'+ ExpandConstant('{tmp}') + '\{#PWP_PatchDataDirName}\' + fVer + ini +'"'+ Lang2 +'"'+ ResultStr + ini+'"'); 
                  #endif
                #endif
                #ifdef PWP_SimplyLogSupport
                  Lang := GetIniString('ISPATCH', 'S_COPYING', '--> Copying file: ', sLang); 

                  #ifdef PWP_InsidePatch
                    s_basePath := ini;
                    Delete(s_basePath,1,1);
                    pLog.Lines.Add(Lang +'"'+ s_basePath +'"');
                  #endif
                #endif

                #ifndef PWP_InsidePatch
                  upstr := ExpandConstant('{src}'); 
                  if upstr = ExtractFileDir(upstr) then
                  upstr := RemoveBackslash(upstr);
  
                  #ifndef PWP_SimplyLogSupport
                    pLog.Lines.Add(Lang +'"'+ upstr + '\{#PWP_PatchDataDirName}\' + fVer + ini +'"'+ Lang2 +'"'+ ResultStr + ini+'"'); 
                  #endif
                  #ifdef PWP_SimplyLogSupport
                    s_basePath := ini;
                    Delete(s_basePath,1,1);
                    pLog.Lines.Add(Lang +'"'+ s_basePath +'"');
                  #endif
                #endif

              #endif
           end;
        end;

      inc(t);

      #ifdef PWP_SilentFormMode
      ProgressBar.Position := t;
      SetTaskBarProgressValue(t * 100 / iCount);
      #endif
      #ifndef PWP_SilentMode
      ProgressBar.Position := t;
      SetTaskBarProgressValue(t * 100 / iCount);
      #endif
      until t >= iCount;
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'COPYING_END', '[Copying session end]', sLang); 
      pLog.Lines.Add(Lang);
      #endif
    end;
    #endif

    // fp old here

    #ifndef PWP_SilentMode
      pLog.Lines.Add(''); 
    #endif
    
    #ifdef PWP_AttributesSupport
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'SET_ATTRIBUTES', 'Set files attributes...', sLang); 
      pLog.Lines.Add(Lang); 
      #endif
    #endif

    #ifndef PWP_MultiVersionMode
      if IniKeyExists('TOTAL_HIDDEN', 'TH', ExpandConstant('{tmp}') + '\Checker.ini') then
      begin
        tc := StrToInt(GetIniString('TOTAL_HIDDEN', 'TH', '0', ExpandConstant('{tmp}') + '\Checker.ini')); 
        for tp:=0 to tc-1 do
        begin
          AppProcessMessage;
          if not SetFileAttributes(ExtendPath(ResultStr + GetIniString('HIDDEN_FILES', IntToStr(tp),'0', ExpandConstant('{tmp}') + '\Checker.ini')),StrToInt64(GetIniString('HIDDEN_ATTRS', IntToStr(tp),'0', ExpandConstant('{tmp}') + '\Checker.ini'))) then
          begin
            #ifndef PWP_SilentMode
            Lang := GetIniString('ISPATCH', 'SET_ATTRIBUTES_FAILED', '[!]  Failed to set original attributes to file: ', sLang); 
            pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('HIDDEN_FILES', IntToStr(tp), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
            #endif
            inc(z);
          end;
        end;
      end;
    #endif

    #ifdef PWP_MultiVersionMode
      if IniKeyExists('TOTAL_HIDDEN' + fVer, 'TH', ExpandConstant('{tmp}') + '\Checker.ini') then
      begin
        tc := StrToInt(GetIniString('TOTAL_HIDDEN' + fVer, 'TH', '0', ExpandConstant('{tmp}') + '\Checker.ini')); 
        for tp:=0 to tc-1 do
        begin
          AppProcessMessage;
          if not SetFileAttributes(ExtendPath(ResultStr + GetIniString('HIDDEN_FILES' + fVer, IntToStr(tp),'0', ExpandConstant('{tmp}') + '\Checker.ini')),StrToInt64(GetIniString('HIDDEN_ATTRS' + fVer, IntToStr(tp),'0', ExpandConstant('{tmp}') + '\Checker.ini'))) then
          begin
            #ifndef PWP_SilentMode
            Lang := GetIniString('ISPATCH', 'SET_ATTRIBUTES_FAILED', '[!]  Failed to set original attributes to file: ', sLang); 
            pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('HIDDEN_FILES' + fVer, IntToStr(tp), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
            #endif
            inc(z);
          end;
        end;
      end;
    #endif

    #ifndef PWP_SilentMode
    if cb_vh.checked then
    begin
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'VERIFICATION_START', 'Starting files verification process...', sLang); 
      pLog.Lines.Add(Lang); 
      #endif
    end;
    #endif

    #ifndef PWP_MultiVersionMode
       m := 0;

       repeat
       AppProcessMessage;

       if FileExists(ExtendPath(ResultStr + BACKUP_DIR + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) and FileExists(ExtendPath(ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then // check if patch-data and same original file is exists
       begin 
          #ifdef PWP_TimeStampSupport
          //Get Time
          hFile := CreateFile(ExtendPath(ResultStr + BACKUP_DIR + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')),$80000000,FILE_SHARE_READ,0,OPEN_EXISTING,0,0);

          if (INVALID_HANDLE_VALUE = hFile) then
          begin
            #ifndef PWP_SilentMode
            KillTimer(0, tTimerID);
            Lang := GetIniString('ISPATCH', 'HANDLE_ERROR', '[!]  Critical error ocurred while access to: ', sLang); 
            pLog.Lines.Add(Lang + '"' + ResultStr + BACKUP_DIR + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
            #endif
            Inc(z);
            CloseHandle(hFile);
            Exit;
          end else
          begin
            if not GetFileTime(hFile,CreationTime,LastAccessTime,LastWriteTime) then
            begin
              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'GET_TIME_FAILED', '[!]  Failed to get time attributes from file: ', sLang); 
              pLog.Lines.Add(Lang + '"' + ResultStr + BACKUP_DIR + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
              #endif
              Inc(tz);
              CloseHandle(hFile);
            end;
            CloseHandle(hFile);
          end;                                                                                                                         
          //Set Time
          hFile := CreateFile(ExtendPath(ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')),$80000000 or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE,0,OPEN_EXISTING,0,0);
         
          if (INVALID_HANDLE_VALUE = hFile) then
          begin	  
            #ifndef PWP_SilentMode
            KillTimer(0, tTimerID);
            Lang := GetIniString('ISPATCH', 'HANDLE_ERROR', '[!]  Critical error ocurred while access to: ', sLang); 
            pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
            #endif
            Inc(z);
            CloseHandle(hFile);
            Exit;
          end else
          begin
            if not SetFileTime(hFile,CreationTime,LastAccessTime,LastWriteTime) then
            begin
              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'SET_TIME_FAILED', '[!]  Failed to set time attributes to file: ', sLang); 
              pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
              Inc(tz);
              CloseHandle(hFile);
              #endif
            end;
          CloseHandle(hFile);
          end;                
          //////////////////
          #endif
          ////////////////// 
             
          #ifdef PWP_AttributesSupport 
          if not SetFileAttributes(ExtendPath(ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')), GetFileAttributes(ExtendPath(ResultStr + BACKUP_DIR + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')))) then
          begin
             #ifndef PWP_SilentMode
             Lang := GetIniString('ISPATCH', 'SET_ATTRIBUTES_FAILED', '[!]  Failed to set original attributes to file: ', sLang); 
             pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
             Inc(az);
             #endif
          end;
          #endif
          //////////checking//////////
          #ifndef PWP_SilentMode 
          if cb_vh.checked then
          begin
            if {#PWP_CRC32_PARAM1}GetIniString('MODIFIED_HASH', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
            begin
              #ifndef PWP_SimplyLogSupport
                  Lang := GetIniString('ISPATCH', 'INVALID_HASH', '[!]  Invalid checksum hash for updated file: ', sLang); 
                  pLog.Lines.Add(Lang +'"'+ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')+'"');
              #endif
              #ifdef PWP_SimplyLogSupport
                  Lang := GetIniString('ISPATCH', 'S_INVALID_FILE', '[!]  Invalid file: ', sLang); 
                  s_basePath := GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
                  Delete(s_basePath,1,1);
                  pLog.Lines.Add(Lang +'"'+ s_basePath +'"');
              #endif
              Inc(z);  
            end else
            begin
              #ifndef PWP_SimplyLogSupport
                  Lang := GetIniString('ISPATCH', 'VALID_HASH', 'Valid checksum hash for updated file: ', sLang); 
                  pLog.Lines.Add(Lang +'"'+ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')+'"');
              #endif
              #ifdef PWP_SimplyLogSupport
                  Lang := GetIniString('ISPATCH', 'S_VALID_FILE', 'OK! Valid file: ', sLang); 
                  s_basePath := GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
                  Delete(s_basePath,1,1);
                  pLog.Lines.Add(Lang +'"'+ s_basePath +'"');
              #endif
            end;
          end;
          #endif
          //////
          #ifdef PWP_SilentMode
          if {#PWP_VerifySilentModeTrue} = 1 then
          begin
            if {#PWP_CRC32_PARAM1}GetIniString('MODIFIED_HASH', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
            Inc(z);  
          end;
          #endif
      ////////////checking////////////
      #ifdef PWP_ForcePatchingSupport
      end else
      begin
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'FILE_SKIPPED', '[!]  This file not exists and skipped: ', sLang); 
        pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
        #endif
      end;
      #endif
      #ifndef PWP_ForcePatchingSupport
      end else
      begin
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'FILE_NOT_EXISTS', '[!]  Required to process file not exists: ', sLang); 
        pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
        #endif
        Inc(z);
      end;
      #endif

      inc(m);  

      until m >= pCount;

      dz := 0;

      #ifndef PWP_SilentMode
      if cb_vh.checked then
      begin
        if (z > 0) then
        begin
          pLog.Lines.Add(''); 
          Lang := GetIniString('ISPATCH', 'VERIFICATION_UNSUCCESS', '[!]  Some files not exists or have incorrect checksum!', sLang); 
          pLog.Lines.Add(Lang); 
        end else
        begin
          Lang := GetIniString('ISPATCH', 'VERIFICATION_FINISH', 'All files verification checksums is correct!', sLang); 
          pLog.Lines.Add(Lang); 
        end;
      end;
      #endif

      #ifdef PWP_TimeStampSupport
      #ifndef PWP_SilentMode
      if (tz > 0) then
      begin
        dz := 0;
        pLog.Lines.Add(''); 
        Lang := GetIniString('ISPATCH', 'SET_ATTRIBUTES_UNSUCCESS', '[!]  Some files attributes was not set!', sLang); 
        pLog.Lines.Add(Lang); 
      end else
        dz := 1;
      #endif
      #endif

      #ifdef PWP_AttributesSupport
      #ifndef PWP_SilentMode
      if (az > 0) then
      begin
        dz := 0;
        pLog.Lines.Add(''); 
        Lang := GetIniString('ISPATCH', 'SET_ATTRIBUTES_UNSUCCESS', '[!]  Some files attributes was not set!', sLang); 
        pLog.Lines.Add(Lang); 
      end else
        dz := 1;
      #endif
      #endif

      #ifndef PWP_SilentMode
      if (dz = 1) then
      begin
        pLog.Lines.Add(''); 
        Lang := GetIniString('ISPATCH', 'SET_ATTRIBUTES_SUCCESS', 'Files attributes was set successfully!', sLang); 
        pLog.Lines.Add(Lang); 
      end;
      #endif

    #endif
    //////
    #ifdef PWP_MultiVersionMode
      m := 0;

      repeat
      AppProcessMessage;

      if FileExists(ExtendPath(ResultStr + BACKUP_DIR + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) and FileExists(ExtendPath(ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then // check if patch-data and same original file is exists
      begin 
        #ifdef PWP_TimeStampSupport
        //Get Time
        hFile := CreateFile(ExtendPath(ResultStr + BACKUP_DIR + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')),$80000000,FILE_SHARE_READ,0,OPEN_EXISTING,0,0);

        if (INVALID_HANDLE_VALUE = hFile) then
        begin
          #ifndef PWP_SilentMode
          KillTimer(0, tTimerID);
          Lang := GetIniString('ISPATCH', 'HANDLE_ERROR', '[!]  Critical error ocurred while access to: ', sLang); 
          pLog.Lines.Add(Lang + '"' + ResultStr + BACKUP_DIR + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
          #endif
          Inc(z);
          CloseHandle(hFile);
          Exit;
        end else
        begin
          if not GetFileTime(hFile,CreationTime,LastAccessTime,LastWriteTime) then
          begin
            #ifndef PWP_SilentMode
            Lang := GetIniString('ISPATCH', 'GET_TIME_FAILED', '[!]  Failed to get time attributes from file: ', sLang); 
            pLog.Lines.Add(Lang + '"' + ResultStr + BACKUP_DIR + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
            #endif
            Inc(tz);
            CloseHandle(hFile);
          end;
          CloseHandle(hFile);
        end;
        //Set Time
        hFile := CreateFile(ExtendPath(ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')),$80000000 or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE,0,OPEN_EXISTING,0,0);
       
        if (INVALID_HANDLE_VALUE = hFile) then
        begin	  
          #ifndef PWP_SilentMode
          KillTimer(0, tTimerID);
          Lang := GetIniString('ISPATCH', 'HANDLE_ERROR', '[!]  Critical error ocurred while access to: ', sLang); 
          pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
          #endif
          Inc(z);
          CloseHandle(hFile);
          Exit;
        end else
        begin
          if not SetFileTime(hFile,CreationTime,LastAccessTime,LastWriteTime) then
          begin
            #ifndef PWP_SilentMode
            Lang := GetIniString('ISPATCH', 'SET_TIME_FAILED', '[!]  Failed to set time attributes to file: ', sLang); 
            pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
            Inc(tz);
            CloseHandle(hFile);
            #endif
          end;
        CloseHandle(hFile);
        end;                
        //////
        #endif
        //////  
        #ifdef PWP_AttributesSupport   
        if not SetFileAttributes(ExtendPath(ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')), GetFileAttributes(ExtendPath(ResultStr + BACKUP_DIR + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')))) then
        begin
          #ifndef PWP_SilentMode
          Lang := GetIniString('ISPATCH', 'SET_ATTRIBUTES_FAILED', '[!]  Failed to set original attributes to file: ', sLang); 
          pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
          Inc(az);
          #endif
        end;
        #endif
        ///////checking////////
        #ifndef PWP_SilentMode
        if cb_vh.checked then
        begin
          if {#PWP_CRC32_PARAM1}GetIniString('MODIFIED_HASH' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
          begin
            #ifndef PWP_SimplyLogSupport
                Lang := GetIniString('ISPATCH', 'INVALID_HASH', '[!]  Invalid checksum hash for updated file: ', sLang); 
                pLog.Lines.Add(Lang +'"'+ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')+'"');
            #endif
            #ifdef PWP_SimplyLogSupport
                Lang := GetIniString('ISPATCH', 'S_INVALID_FILE', '[!]  Invalid file: ', sLang); 
                s_basePath := GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
                Delete(s_basePath,1,1);
                pLog.Lines.Add(Lang +'"'+ s_basePath +'"');
            #endif
            Inc(z);  
          end else
          begin
            #ifndef PWP_SimplyLogSupport
                Lang := GetIniString('ISPATCH', 'VALID_HASH', 'Valid checksum hash for updated file: ', sLang); 
                pLog.Lines.Add(Lang +'"'+ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini')+'"');
            #endif
            #ifdef PWP_SimplyLogSupport
                Lang := GetIniString('ISPATCH', 'S_VALID_FILE', 'OK! Valid file: ', sLang); 
                s_basePath := GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini');
                Delete(s_basePath,1,1);
                pLog.Lines.Add(Lang +'"'+ s_basePath +'"');
            #endif
          end;
        end;
        #endif
        //////
        #ifdef PWP_SilentMode
        if {#PWP_VerifySilentModeTrue} = 1 then
        begin
          if {#PWP_CRC32_PARAM1}GetIniString('MODIFIED_HASH' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'){#PWP_CRC32_PARAM2} <> {#PWP_VerificationMethod}(ExtendPath(ResultStr + GetIniString('VERIFIED' + fVer, IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini'))) then
          Inc(z);  
        end;
        #endif
      ////////////checking////////////
      #ifdef PWP_ForcePatchingSupport
      end else
      begin
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'FILE_SKIPPED', '[!]  This file not exists and skipped: ', sLang); 
        pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"');
        #endif
        end;
      #endif
      #ifndef PWP_ForcePatchingSupport
      end else
      begin
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'FILE_NOT_EXISTS', '[!]  Required to process file not exists: ', sLang); 
        pLog.Lines.Add(Lang + '"' + ResultStr + GetIniString('VERIFIED', IntToStr(m), '', ExpandConstant('{tmp}') + '\Checker.ini') + '"'); 
        #endif
        Inc(z);
      end;
      #endif

      inc(m);  

      until m >= pCount;

      #ifndef PWP_SilentMode
      if cb_vh.checked then
      begin
        if (z > 0) then
        begin
          pLog.Lines.Add(''); 
          Lang := GetIniString('ISPATCH', 'VERIFICATION_UNSUCCESS', '[!]  Some files not exists or have incorrect checksum!', sLang); 
          pLog.Lines.Add(Lang); 
        end else
        begin
          Lang := GetIniString('ISPATCH', 'VERIFICATION_FINISH', 'All files verification checksums is correct!', sLang); 
          pLog.Lines.Add(Lang); 
        end;
      end;
      #endif

      #ifdef PWP_TimeStampSupport
      #ifndef PWP_SilentMode
      if (tz > 0) then
      begin
        pLog.Lines.Add(''); 
        Lang := GetIniString('ISPATCH', 'SET_ATTRIBUTES_UNSUCCESS', '[!]  Some files attributes was not set!', sLang); 
        pLog.Lines.Add(Lang); 
      end else
        dz := 1;
      #endif
      #endif

      #ifdef PWP_AttributesSupport
      #ifndef PWP_SilentMode
      if (az > 0) then
      begin
        pLog.Lines.Add(''); 
        Lang := GetIniString('ISPATCH', 'SET_ATTRIBUTES_UNSUCCESS', '[!]  Some files attributes was not set!', sLang); 
        pLog.Lines.Add(Lang); 
      end else
        dz := 1;
      #endif
      #endif

      #ifndef PWP_SilentMode
      if (dz = 1) then
      begin
        pLog.Lines.Add(''); 
        Lang := GetIniString('ISPATCH', 'SET_ATTRIBUTES_SUCCESS', 'Files attributes was set successfully!', sLang); 
        pLog.Lines.Add(Lang); 
      end;
      #endif

    #endif

    if (z > 0) or (v > 0) or (j > 0) then // if Error Code was happened, show additional warning
    begin                      
      PatchingError := 1;

      #ifdef PWP_SilentFormMode
      SetTaskBarProgressState(4);
      SetTaskBarProgressValue(100);
      Lang := GetIniString('ISPATCH', 'ROLLBACK_ERROR', 'Error while patching was ocurred and Patch apply the rollback.', sLang);
      mStr.Caption := Lang;
      mStr.Refresh;
      Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
      iStr.Caption := Lang;
      iStr.Refresh;
      #endif

      #ifndef PWP_SilentMode
      KillTimer(0, tTimerID);
      SetTaskBarProgressState(4);
      SetTaskBarProgressValue(100);
      #endif

      RollBack;
      DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');

      #ifdef PWP_SilentFormMode
      Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
      Lang2 := GetIniString('ISPATCH', 'ROLLBACK_END', 'Error ocurred. Rollback applied. All patched files restored.', sLang);
      mStr.Caption := Lang + ' ' + Lang2;
      mStr.Refresh;
      #endif
      ////
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'FINISHED_WITH_ERRORS', 'Patch finished with errors! Check the log for details!', sLang); 
      MsgBox(Lang, mbError, mb_OK);
      #endif   
      Exit;
    end;

    #ifndef PWP_SilentMode
       #ifdef PWP_ForcePatchingSupport
       if cb_vh.checked then
       pLog.Lines.Add('');

       Lang := GetIniString('ISPATCH', 'TOTAL_PATCHED_FILES', 'Total processed files: ', sLang); 
       pLog.Lines.Add(Lang + IntToStr(d));
       #endif
       #ifndef PWP_ForcePatchingSupport
       if cb_vh.checked then
       pLog.Lines.Add('');

       Lang := GetIniString('ISPATCH', 'TOTAL_PATCHED_FILES', 'Total processed files: ', sLang); 
       pLog.Lines.Add(Lang + IntToStr(m));

       #endif
    #endif

    //////////////////////////////////////
    if (z > 0) or (v > 0) or (j > 0) then // if Error Code was happened, show additional warning
    begin                      
      PatchingError := 1;

      #ifdef PWP_SilentFormMode
      SetTaskBarProgressState(4);
      SetTaskBarProgressValue(100);
      Lang := GetIniString('ISPATCH', 'ROLLBACK_ERROR', 'Error while patching was ocurred and Patch apply the rollback.', sLang);
      mStr.Caption := Lang;
      mStr.Refresh;
      Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
      iStr.Caption := Lang;
      iStr.Refresh;
      #endif

      #ifndef PWP_SilentMode
      KillTimer(0, tTimerID);
      SetTaskBarProgressState(4);
      SetTaskBarProgressValue(100);
      #endif

      RollBack;
      DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');

      #ifdef PWP_SilentFormMode
      Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
      Lang2 := GetIniString('ISPATCH', 'ROLLBACK_END', 'Error ocurred. Rollback applied. All patched files restored.', sLang);
      mStr.Caption := Lang + ' ' + Lang2;
      mStr.Refresh;
      #endif
      ////
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'FINISHED_WITH_ERRORS', 'Patch finished with errors! Check the log for details!', sLang); 
      MsgBox(Lang, mbError, mb_OK);
      #endif   
      Exit;
    end;
   ////////////////////////////
  #ifndef PWP_MultiVersionMode
    #ifdef PWP_JunkedFilesProcessing
    t := 0; 

    #ifndef PWP_JunkedDeletingError
    j := 0; 
    #endif

    if IniKeyExists('JUNKED','0',ExpandConstant('{tmp}') + '\Checker.ini') then
    begin
      #ifndef PWP_SilentMode
      pLog.Lines.Add(''); 
      Lang := GetIniString('ISPATCH', 'DELETING_JUNKED', '[Junked files deleting session start]', sLang); 
      pLog.Lines.Add(Lang);  
      #endif

      jCount := StrToInt(GetIniString('TOTALOLD', 'OLD', '', ExpandConstant('{tmp}') + '\Checker.ini')); // get the included files count

      #ifndef PWP_SilentMode
      ProgressBar.Position := 0;
      SetTaskBarProgressValue(0);
      ProgressBar.Min := 0;
      ProgressBar.Max := jCount; 
      #endif

      repeat
        AppProcessMessage;
        
        ini := GetIniString('JUNKED', IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');

        if FileExists(ExtendPath(ResultStr + ini)) then
        begin
          ForceDirectories(ExtendPath(ResultStr + BACKUP_DIR + ExtractFileDir(ini)));
          if MoveFileEx(ExtendPath(ResultStr + ini),ExtendPath(ResultStr + BACKUP_DIR + ini), $1 or $2) then
          begin
            #ifndef PWP_SilentMode
              #ifndef PWP_SimplyLogSupport
                  Lang := GetIniString('ISPATCH', 'JUNKED_REMOVED', 'Removed junked file: ', sLang);   
                  pLog.Lines.Add(Lang +'"'+ ResultStr + ini +'"');
              #endif 
              #ifdef PWP_SimplyLogSupport
                  Lang := GetIniString('ISPATCH', 'JUNKED_REMOVED', 'Removed junked file: ', sLang);   
                  s_basePath := ini;
                  Delete(s_basePath,1,1);
                  pLog.Lines.Add(Lang +'"'+ s_basePath +'"');
              #endif
            #endif
          end else
          begin
            #ifndef PWP_SilentMode
            Lang := GetIniString('ISPATCH', 'JUNKED_REM_FAILED', 'Failed to remove junked file: ', sLang);   
            pLog.Lines.Add(Lang +'"'+ ResultStr + ini +'"');
            #endif
            #ifndef PWP_JunkedDeletingError
            inc(j);
            #endif
          end;
        end;

      inc(t);

      #ifndef PWP_SilentMode
      ProgressBar.Position := t;
      SetTaskBarProgressValue(t * 100 / jCount);
      #endif

      until t >= jCount;


      //upd1
      #ifdef PWP_JunkedDirsProcessing
        t := 0; 

        if IniKeyExists('JUNKED_DIRS','0',ExpandConstant('{tmp}') + '\Checker.ini') then
        begin
          jCount := StrToInt(GetIniString('TOTALOLD', 'OLD_DIRS', '', ExpandConstant('{tmp}') + '\Checker.ini')); // get the included files count
          repeat
            AppProcessMessage;
            
            ini := GetIniString('JUNKED_DIRS', IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');

            if DirExists(ExtendPath(ResultStr + ini)) then
            begin
              ForceDirectories(ExtendPath(ResultStr + BACKUP_DIR + ini));
              RemoveDir(ExtendPath(ResultStr + ini));
            end;

          inc(t);

          until t >= jCount;
        end;
      #endif

      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'COMPLETING_JUNKED', '[Junked files deleting session end]', sLang); 
      pLog.Lines.Add(Lang);
      #endif
    end;
    //here end of
    #endif

  #endif
  ///////////////////////////////////
  #ifdef PWP_MultiVersionMode
    #ifdef PWP_JunkedFilesProcessing
    t := 0; 

    #ifndef PWP_JunkedDeletingError
    j := 0; 
    #endif

    if IniKeyExists('JUNKED' + fVer,'0',ExpandConstant('{tmp}') + '\Checker.ini') then
    begin
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'DELETING_JUNKED', '[Junked files deleting session start]', sLang); 
      pLog.Lines.Add(Lang);  
      #endif

      jCount := StrToInt(GetIniString('TOTALOLD' + fVer, 'OLD', '', ExpandConstant('{tmp}') + '\Checker.ini')); // get the included files count

      #ifndef PWP_SilentMode
      ProgressBar.Position := 0;
      SetTaskBarProgressValue(0);
      ProgressBar.Min := 0;
      ProgressBar.Max := jCount; 
      #endif
        
      repeat
        AppProcessMessage;

        ini := GetIniString('JUNKED' + fVer, IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');

        if FileExists(ExtendPath(ResultStr + ini)) then
        begin
           ForceDirectories(ExtendPath(ResultStr + BACKUP_DIR + ExtractFileDir(ini)));
           if MoveFileEx(ExtendPath(ResultStr + ini),ExtendPath(ResultStr + BACKUP_DIR + ini), $1 or $2) then
           begin
              #ifndef PWP_SilentMode
                  #ifndef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'JUNKED_REMOVED', 'Removed junked file: ', sLang);   
                    pLog.Lines.Add(Lang +'"'+ ResultStr + ini +'"');
                  #endif
                  #ifdef PWP_SimplyLogSupport
                    Lang := GetIniString('ISPATCH', 'JUNKED_REMOVED', 'Removed junked file: ', sLang);   
                    s_basePath := ini;
                    Delete(s_basePath,1,1);
                    pLog.Lines.Add(Lang +'"'+ s_basePath +'"');
                  #endif
              #endif
           end else
           begin
              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'JUNKED_REM_FAILED', 'Failed to remove junked file: ', sLang);   
              pLog.Lines.Add(Lang +'"'+ ResultStr + ini +'"');
              #endif
              #ifndef PWP_JunkedDeletingError
              inc(j);
              #endif
           end;
        end;

      inc(t);

      #ifndef PWP_SilentMode
      ProgressBar.Position := t;
      SetTaskBarProgressValue(t * 100 / jCount);
      #endif

      until t >= jCount;

      //upd1
      #ifdef PWP_JunkedDirsProcessing
        t := 0; 

        if IniKeyExists('JUNKED_DIRS' + fVer,'0',ExpandConstant('{tmp}') + '\Checker.ini') then
        begin
          jdCount := StrToInt(GetIniString('TOTALOLD' + fVer, 'OLD_DIRS', '', ExpandConstant('{tmp}') + '\Checker.ini')); // get the included files count
          repeat
            AppProcessMessage;
            
            ini := GetIniString('JUNKED_DIRS' + fVer, IntToStr(t), '', ExpandConstant('{tmp}') + '\Checker.ini');

            if DirExists(ExtendPath(ResultStr + ini)) then
            begin
              ForceDirectories(ExtendPath(ResultStr + BACKUP_DIR + ini));
              RemoveDir(ExtendPath(ResultStr + ini));
            end;

          inc(t);

          until t >= jdCount;
        end;
      #endif

      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'COMPLETING_JUNKED', '[Junked files deleting session end]', sLang); 
      pLog.Lines.Add(Lang);
      #endif
    end;
    #endif
  #endif
      //////////////////////////////////////
      if (z > 0) or (v > 0) or (j > 0) then // if Error Code was happened, show additional warning
      begin                      
        PatchingError := 1;

        #ifdef PWP_SilentFormMode
        SetTaskBarProgressState(4);
        SetTaskBarProgressValue(100);
        Lang := GetIniString('ISPATCH', 'ROLLBACK_ERROR', 'Error while patching was ocurred and Patch apply the rollback.', sLang);
        mStr.Caption := Lang;
        mStr.Refresh;
        Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
        iStr.Caption := Lang;
        iStr.Refresh;
        #endif

        #ifndef PWP_SilentMode
        KillTimer(0, tTimerID);
        SetTaskBarProgressState(4);
        SetTaskBarProgressValue(100);
        #endif

        RollBack;
        DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');

        #ifdef PWP_SilentFormMode
        Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
        Lang2 := GetIniString('ISPATCH', 'ROLLBACK_END', 'Error ocurred. Rollback applied. All patched files restored.', sLang);
        mStr.Caption := Lang + ' ' + Lang2;
        mStr.Refresh;
        #endif
        ////
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'FINISHED_WITH_ERRORS', 'Patch finished with errors! Check the log for details!', sLang); 
        MsgBox(Lang, mbError, mb_OK);
        #endif   
        Exit;
      end;

    #ifdef PWP_ExternalFilesSupport  
      #ifndef PWP_FreeArcSupport
         #ifndef PWP_ExternalTemp
            #ifdef PWP_CopyInstallPath
              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'COPYING_EXTERNAL', 'Copying external files...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'COPYING_PROCESS', 'Copying process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif

              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'COPYING_EXTERNAL', 'Copying external files...', sLang);
              pLog.Lines.Add(Lang); 
              #endif

              xcopy(ExtendPath(ExpandConstant('{src}\{#PWP_ExternalDirName}')), ExtendPath(ResultStr), True); //tut

              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'EXTERNAL_COPYIED', 'Additional external files was copyied to: ', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('--> ' + '"'+ ResultStr+'"'); 
              #endif
            #endif
            #ifdef PWP_CopyCustomPath
              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'COPYING_EXTERNAL', 'Copying external files...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'COPYING_PROCESS', 'Copying process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif

              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'COPYING_EXTERNAL', 'Copying external files...', sLang);
              pLog.Lines.Add(Lang); 
              #endif

              xcopy(ExtendPath(ExpandConstant('{src}\{#PWP_ExternalDirName}')), ExtendPath(ExpandConstant('{#PWP_CopyDirName}')), True); //tut

              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'EXTERNAL_COPYIED', 'Additional external files was copyied to: ', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('--> ' + '"'+ ExpandConstant('{#PWP_CopyDirName}')+'"'); 
              #endif
            #endif
         #endif
      #endif
    ////ARC////
      #ifdef PWP_FreeArcSupport
         #ifndef PWP_ExternalTemp
            #ifdef PWP_CopyInstallPath
              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'EXTRACTING_PROCESS', 'Extracting external files...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'EXTRACTING_START', 'Extracting process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif

              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'EXTRACTING_PROCESS', 'Extracting external files...', sLang);
              pLog.Lines.Add(Lang); 
              #endif

              Archive := ExtendPath(ExpandConstant('{src}\{#PWP_ExternalDirName}\{#PWP_ExternalDirName}.arc'));
              ArcPath := ExtendPath(ResultStr);

              if UnPack(Archive) <> 0 then
              begin
                #ifdef PWP_SilentFormMode
                SetTaskBarProgressState(4);
                SetTaskBarProgressValue(100);
                #endif

                #ifndef PWP_SilentMode
                KillTimer(0, tTimerID);
                SetTaskBarProgressState(4);
                SetTaskBarProgressValue(100);
                #endif

                #ifdef PWP_SilentFormMode
                Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
                Lang2 := GetIniString('ISPATCH', 'ROLLBACK_END', 'Error ocurred. Rollback applied. All patched files restored.', sLang);
                mStr.Caption := Lang + ' ' + Lang2;
                mStr.Refresh;
                #endif

                PatchingError := 1;
                RollBack;
                DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
                inc(z);

                #ifndef PWP_SilentMode
                Lang := GetIniString('ISPATCH', 'EXTRACTING_WITH_ERRORS', 'Arhive extracting finished with errors! Check the log for details!', sLang);
                pLog.Lines.Add(Lang); 
                #endif
                Exit;
              end;

              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'EXTERNAL_EXTRACTED', 'Additional external files was extracted to: ', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('--> ' + '"'+ ResultStr+'"'); 
              #endif
            #endif
            #ifdef PWP_CopyCustomPath
              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'EXTRACTING_PROCESS', 'Extracting external files...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'EXTRACTING_START', 'Extracting process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif

              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'EXTRACTING_PROCESS', 'Extracting external files...', sLang);
              pLog.Lines.Add(Lang); 
              #endif

              Archive := ExtendPath(ExpandConstant('{src}\{#PWP_ExternalDirName}\{#PWP_ExternalDirName}.arc'));
              ArcPath := ExtendPath(ExpandConstant('{#PWP_CopyDirName}'));

              if UnPack(Archive) <> 0 then
              begin
                #ifdef PWP_SilentFormMode
                SetTaskBarProgressState(4);
                SetTaskBarProgressValue(100);
                #endif

                #ifndef PWP_SilentMode
                KillTimer(0, tTimerID);
                SetTaskBarProgressState(4);
                SetTaskBarProgressValue(100);
                #endif

                #ifdef PWP_SilentFormMode
                Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
                Lang2 := GetIniString('ISPATCH', 'ROLLBACK_END', 'Error ocurred. Rollback applied. All patched files restored.', sLang);
                mStr.Caption := Lang + ' ' + Lang2;
                mStr.Refresh;
                #endif

                PatchingError := 1;
                RollBack;
                DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
                inc(z);

                #ifndef PWP_SilentMode
                Lang := GetIniString('ISPATCH', 'EXTRACTING_WITH_ERRORS', 'Arhive extracting finished with errors! Check the log for details!', sLang);
                pLog.Lines.Add(Lang); 
                #endif
                Exit;
              end;

              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'EXTERNAL_EXTRACTED', 'Additional external files was extracted to: ', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('--> ' + '"'+ ExpandConstant('{#PWP_CopyDirName}')+'"'); 
              #endif
            #endif
         #endif
      #endif
      /// 2 ///
      #ifndef PWP_FreeArcSupport
         #ifdef PWP_ExternalTemp

            #ifndef PWP_CopyInstallPath
            #ifndef PWP_CopyCustomPath
              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP', 'Extracting temporary required data...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP2', 'Extracting process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif
              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP', 'Extracting temporary data...', sLang);
              pLog.Lines.Add(Lang); 
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP2', 'Extracting process, please wait...', sLang);
              pLog.Lines.Add(Lang); 
              #endif
                tc := StrToInt(GetIniString('TOTAL_TMP_COPY_DATA', 'TMP_CD', '0', ExpandConstant('{tmp}') + '\Checker.ini')); 

                #ifdef PWP_SilentFormMode
                ProgressBar.Position := 0;
                ProgressBar.Min := 0;
                ProgressBar.Max := tc;
                #endif
                ////
                #ifndef PWP_SilentMode 
                ProgressBar.Position := 0;
                ProgressBar.Min := 0;
                ProgressBar.Max := tc;
                #endif

                for tp:=0 to tc-1 do
                begin
                  AppProcessMessage;
                  tf := GetIniString('TMP_COPY_DATA', IntToStr(tp),'0', ExpandConstant('{tmp}') + '\Checker.ini');

                  #ifndef PWP_SilentMode
                  #ifndef PWP_SimplyLogSupport
                  Lang := GetIniString('ISPATCH', 'S_EXTRACTING', '--> Extracting file: ', sLang);
                  pLog.Lines.Add(Lang + '"'+tf+'"');
                  #endif
                  #endif

                  ExtractTemporaryFiles(tf); 

                  #ifdef PWP_SilentFormMode
                  ProgressBar.Position := tp+1;
                  SetTaskBarProgressValue((tp+1) * 100 / tc);
                  #endif
                  #ifndef PWP_SilentMode
                  ProgressBar.Position := tp+1;
                  SetTaskBarProgressValue((tp+1) * 100 / tc);
                  #endif
                end;
            #endif
            #endif

            #ifdef PWP_CopyInstallPath

              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP', 'Extracting temporary required data...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP2', 'Extracting process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif
              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP', 'Extracting temporary data...', sLang);
              pLog.Lines.Add(Lang); 
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP2', 'Extracting process, please wait...', sLang);
              pLog.Lines.Add(Lang); 
              #endif
              //!!!!
              tc := StrToInt(GetIniString('TOTAL_TMP_COPY_DATA', 'TMP_CD', '0', ExpandConstant('{tmp}') + '\Checker.ini')); 

              #ifdef PWP_SilentFormMode
              ProgressBar.Position := 0;
              ProgressBar.Min := 0;
              ProgressBar.Max := tc;
              #endif
              ////
              #ifndef PWP_SilentMode 
              ProgressBar.Position := 0;
              ProgressBar.Min := 0;
              ProgressBar.Max := tc;
              #endif

              for tp:=0 to tc-1 do
              begin
                AppProcessMessage;
                tf := GetIniString('TMP_COPY_DATA', IntToStr(tp),'0', ExpandConstant('{tmp}') + '\Checker.ini');

                #ifndef PWP_SilentMode
                #ifndef PWP_SimplyLogSupport
                Lang := GetIniString('ISPATCH', 'S_EXTRACTING', '--> Extracting file: ', sLang);
                pLog.Lines.Add(Lang + '"'+tf+'"');
                #endif
                #endif

                ExtractTemporaryFiles(tf); 

                #ifdef PWP_SilentFormMode
                ProgressBar.Position := tp+1;
                SetTaskBarProgressValue((tp+1) * 100 / tc);
                #endif
                #ifndef PWP_SilentMode
                ProgressBar.Position := tp+1;
                SetTaskBarProgressValue((tp+1) * 100 / tc);
                #endif
              end;

              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'COPYING_EXTERNAL', 'Copying external files...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'COPYING_PROCESS', 'Copying process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif

              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'COPYING_EXTERNAL', 'Copying external files...', sLang);
              pLog.Lines.Add(Lang); 
              #endif

              xcopy(ExtendPath(ExpandConstant('{tmp}\{#PWP_ExternalDirName}')), ExtendPath(ResultStr), True); 

              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'EXTERNAL_COPYIED', 'Additional external files was copyied to: ', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('--> ' +'"'+ ResultStr+'"'); 
              #endif
            #endif
            #ifdef PWP_CopyCustomPath

              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP', 'Extracting temporary required data...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP2', 'Extracting process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif
              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP', 'Extracting temporary data...', sLang);
              pLog.Lines.Add(Lang); 
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP2', 'Extracting process, please wait...', sLang);
              pLog.Lines.Add(Lang); 
              #endif
              //!!!!
              tc := StrToInt(GetIniString('TOTAL_TMP_COPY_DATA', 'TMP_CD', '0', ExpandConstant('{tmp}') + '\Checker.ini')); 

              #ifdef PWP_SilentFormMode
              ProgressBar.Position := 0;
              ProgressBar.Min := 0;
              ProgressBar.Max := tc;
              #endif
              ////
              #ifndef PWP_SilentMode 
              ProgressBar.Position := 0;
              ProgressBar.Min := 0;
              ProgressBar.Max := tc;
              #endif

              for tp:=0 to tc-1 do
              begin
                AppProcessMessage;
                tf := GetIniString('TMP_COPY_DATA', IntToStr(tp),'0', ExpandConstant('{tmp}') + '\Checker.ini');

                #ifndef PWP_SilentMode
                #ifndef PWP_SimplyLogSupport
                Lang := GetIniString('ISPATCH', 'S_EXTRACTING', '--> Extracting file: ', sLang);
                pLog.Lines.Add(Lang + '"'+tf+'"');
                #endif
                #endif

                ExtractTemporaryFiles(tf); 

                #ifdef PWP_SilentFormMode
                ProgressBar.Position := tp+1;
                SetTaskBarProgressValue((tp+1) * 100 / tc);
                #endif
                #ifndef PWP_SilentMode
                ProgressBar.Position := tp+1;
                SetTaskBarProgressValue((tp+1) * 100 / tc);
                #endif
              end;

              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'COPYING_EXTERNAL', 'Copying external files...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'COPYING_PROCESS', 'Copying process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif

              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'COPYING_EXTERNAL', 'Copying external files...', sLang);
              pLog.Lines.Add(Lang); 
              #endif

              xcopy(ExtendPath(ExpandConstant('{tmp}\{#PWP_ExternalDirName}')), ExtendPath(ExpandConstant('{#PWP_CopyDirName}')), True); //tut

              #ifndef PWP_SilentMode 
              Lang := GetIniString('ISPATCH', 'EXTERNAL_COPYIED', 'Additional external files was copyied to: ', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('--> ' + '"'+ ExpandConstant('{#PWP_CopyDirName}')+'"'); 
              #endif
            #endif
         #endif
      #endif
   ////ARC////
      #ifdef PWP_FreeArcSupport
         #ifdef PWP_ExternalTemp

            #ifndef PWP_CopyInstallPath
            #ifndef PWP_CopyCustomPath
              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP', 'Extracting temporary required data...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP2', 'Extracting process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif
              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP', 'Extracting temporary data...', sLang);
              pLog.Lines.Add(Lang); 
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP2', 'Extracting process, please wait...', sLang);
              pLog.Lines.Add(Lang); 
              #endif
              //!!!!
              tc := StrToInt(GetIniString('TOTAL_TMP_COPY_DATA', 'TMP_CD', '0', ExpandConstant('{tmp}') + '\Checker.ini')); 

              #ifdef PWP_SilentFormMode
              ProgressBar.Position := 0;
              ProgressBar.Min := 0;
              ProgressBar.Max := tc;
              #endif
              ////
              #ifndef PWP_SilentMode 
              ProgressBar.Position := 0;
              ProgressBar.Min := 0;
              ProgressBar.Max := tc;
              #endif

              for tp:=0 to tc-1 do
              begin
                AppProcessMessage;
                tf := GetIniString('TMP_COPY_DATA', IntToStr(tp),'0', ExpandConstant('{tmp}') + '\Checker.ini');

                #ifndef PWP_SilentMode
                #ifndef PWP_SimplyLogSupport
                Lang := GetIniString('ISPATCH', 'S_EXTRACTING', '--> Extracting file: ', sLang);
                pLog.Lines.Add(Lang + '"'+tf+'"');
                #endif
                #endif

                ExtractTemporaryFiles(tf); 

                #ifdef PWP_SilentFormMode
                ProgressBar.Position := tp+1;
                SetTaskBarProgressValue((tp+1) * 100 / tc);
                #endif
                #ifndef PWP_SilentMode
                ProgressBar.Position := tp+1;
                SetTaskBarProgressValue((tp+1) * 100 / tc);
                #endif
              end;
            #endif
            #endif

            #ifdef PWP_CopyInstallPath

              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP', 'Extracting temporary required data...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP2', 'Extracting process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif
              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP', 'Extracting temporary data...', sLang);
              pLog.Lines.Add(Lang); 
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP2', 'Extracting process, please wait...', sLang);
              pLog.Lines.Add(Lang); 
              #endif
              //!!!!
              tc := StrToInt(GetIniString('TOTAL_TMP_COPY_DATA', 'TMP_CD', '0', ExpandConstant('{tmp}') + '\Checker.ini')); 

              #ifdef PWP_SilentFormMode
              ProgressBar.Position := 0;
              ProgressBar.Min := 0;
              ProgressBar.Max := tc;
              #endif
              ////
              #ifndef PWP_SilentMode 
              ProgressBar.Position := 0;
              ProgressBar.Min := 0;
              ProgressBar.Max := tc;
              #endif

              for tp:=0 to tc-1 do
              begin
                AppProcessMessage;
                tf := GetIniString('TMP_COPY_DATA', IntToStr(tp),'0', ExpandConstant('{tmp}') + '\Checker.ini');

                #ifndef PWP_SilentMode
                #ifndef PWP_SimplyLogSupport
                Lang := GetIniString('ISPATCH', 'S_EXTRACTING', '--> Extracting file: ', sLang);
                pLog.Lines.Add(Lang + '"'+tf+'"');
                #endif
                #endif

                ExtractTemporaryFiles(tf); 

                #ifdef PWP_SilentFormMode
                ProgressBar.Position := tp+1;
                SetTaskBarProgressValue((tp+1) * 100 / tc);
                #endif
                #ifndef PWP_SilentMode
                ProgressBar.Position := tp+1;
                SetTaskBarProgressValue((tp+1) * 100 / tc);
                #endif
              end;

              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'EXTRACTING_PROCESS', 'Extracting external files...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'EXTRACTING_START', 'Extracting process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif

              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'EXTRACTING_PROCESS', 'Extracting external files...', sLang);
              pLog.Lines.Add(Lang);
              #endif

              Archive := ExtendPath(ExpandConstant('{tmp}\{#PWP_ExternalDirName}\{#PWP_ExternalDirName}.arc'));
              ArcPath := ExtendPath(ResultStr);

              if UnPack(Archive) <> 0 then
              begin
                #ifdef PWP_SilentFormMode
                SetTaskBarProgressState(4);
                SetTaskBarProgressValue(100);
                #endif

                #ifndef PWP_SilentMode
                KillTimer(0, tTimerID);
                SetTaskBarProgressState(4);
                SetTaskBarProgressValue(100);
                #endif

                #ifdef PWP_SilentFormMode
                Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
                Lang2 := GetIniString('ISPATCH', 'ROLLBACK_END', 'Error ocurred. Rollback applied. All patched files restored.', sLang);
                mStr.Caption := Lang + ' ' + Lang2;
                mStr.Refresh;
                #endif

                PatchingError := 1;
                RollBack;
                DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');
                inc(z);

                #ifndef PWP_SilentMode
                Lang := GetIniString('ISPATCH', 'EXTRACTING_WITH_ERRORS', 'Arhive extracting finished with errors! Check the log for details!', sLang);
                pLog.Lines.Add(Lang); 
                #endif
                Exit;
              end;

              #ifndef PWP_SilentMode
              Lang := GetIniString('ISPATCH', 'EXTERNAL_EXTRACTED', 'Additional external files was extracted to: ', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('--> ' +'"'+ ResultStr+'"'); 
              #endif
            #endif
            #ifdef PWP_CopyCustomPath

              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP', 'Extracting temporary required data...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP2', 'Extracting process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif
              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP', 'Extracting temporary data...', sLang);
              pLog.Lines.Add(Lang); 
              Lang := GetIniString('ISPATCH', 'EXTRACT_TO_TEMP2', 'Extracting process, please wait...', sLang);
              pLog.Lines.Add(Lang); 
              #endif
              //!!!!
              tc := StrToInt(GetIniString('TOTAL_TMP_COPY_DATA', 'TMP_CD', '0', ExpandConstant('{tmp}') + '\Checker.ini')); 

              #ifdef PWP_SilentFormMode
              ProgressBar.Position := 0;
              ProgressBar.Min := 0;
              ProgressBar.Max := tc;
              #endif
              ////
              #ifndef PWP_SilentMode 
              ProgressBar.Position := 0;
              ProgressBar.Min := 0;
              ProgressBar.Max := tc;
              #endif

              for tp:=0 to tc-1 do
              begin
                AppProcessMessage;
                tf := GetIniString('TMP_COPY_DATA', IntToStr(tp),'0', ExpandConstant('{tmp}') + '\Checker.ini');

                #ifndef PWP_SilentMode
                #ifndef PWP_SimplyLogSupport
                Lang := GetIniString('ISPATCH', 'S_EXTRACTING', '--> Extracting file: ', sLang);
                pLog.Lines.Add(Lang + '"'+tf+'"');
                #endif
                #endif

                ExtractTemporaryFiles(tf); 

                #ifdef PWP_SilentFormMode
                ProgressBar.Position := tp+1;
                SetTaskBarProgressValue((tp+1) * 100 / tc);
                #endif
                #ifndef PWP_SilentMode
                ProgressBar.Position := tp+1;
                SetTaskBarProgressValue((tp+1) * 100 / tc);
                #endif
              end;

              #ifdef PWP_SilentFormMode
              Lang := GetIniString('ISPATCH', 'EXTRACTING_PROCESS', 'Extracting external files...', sLang);
              mStr.Caption := Lang;
              mStr.Refresh;
              Lang := GetIniString('ISPATCH', 'EXTRACTING_START', 'Extracting process, please wait...', sLang);
              iStr.Caption := Lang;
              iStr.Refresh;
              #endif

              #ifndef PWP_SilentMode
              pLog.Lines.Add(''); 
              Lang := GetIniString('ISPATCH', 'EXTRACTING_PROCESS', 'Extracting external files...', sLang);
              pLog.Lines.Add(Lang);
              #endif

              Archive := ExtendPath(ExpandConstant('{tmp}\{#PWP_ExternalDirName}\{#PWP_ExternalDirName}.arc'));
              ArcPath := ExtendPath(ExpandConstant('{#PWP_CopyDirName}'));

              if UnPack(Archive) <> 0 then
              begin
                #ifdef PWP_SilentFormMode
                SetTaskBarProgressState(4);
                SetTaskBarProgressValue(100);
                #endif

                #ifndef PWP_SilentMode
                KillTimer(0, tTimerID);
                SetTaskBarProgressState(4);
                SetTaskBarProgressValue(100);
                #endif

                #ifdef PWP_SilentFormMode
                Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
                Lang2 := GetIniString('ISPATCH', 'ROLLBACK_END', 'Error ocurred. Rollback applied. All patched files restored.', sLang);
                mStr.Caption := Lang + ' ' + Lang2;
                mStr.Refresh;
                #endif

                PatchingError := 1;
                RollBack;
                DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini'); 
                inc(z);
                #ifndef PWP_SilentMode
                Lang := GetIniString('ISPATCH', 'EXTRACTING_WITH_ERRORS', 'Arhive extracting finished with errors! Check the log for details!', sLang);
                pLog.Lines.Add(Lang); 
                #endif
                Exit;
              end;

              #ifndef PWP_SilentMode 
              Lang := GetIniString('ISPATCH', 'EXTERNAL_EXTRACTED', 'Additional external files was extracted to: ', sLang);
              pLog.Lines.Add(Lang);
              pLog.Lines.Add('--> ' + '"'+ ExpandConstant('{#PWP_CopyDirName}')+'"'); 
              #endif
            #endif
         #endif
      #endif
    #endif

    end;
    //////////////////////////////////////
    if (z > 0) or (v > 0) or (j > 0) then // if Error Code was happened, show additional warning
    begin                      
      PatchingError := 1;

      #ifdef PWP_SilentFormMode
      SetTaskBarProgressState(4);
      SetTaskBarProgressValue(100);
      Lang := GetIniString('ISPATCH', 'ROLLBACK_ERROR', 'Error while patching was ocurred and Patch apply the rollback.', sLang);
      mStr.Caption := Lang;
      mStr.Refresh;
      Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
      iStr.Caption := Lang;
      iStr.Refresh;
      #endif

      #ifndef PWP_SilentMode
      KillTimer(0, tTimerID);
      SetTaskBarProgressState(4);
      SetTaskBarProgressValue(100);
      #endif

      RollBack;
      DeleteFile(ExpandConstant('{tmp}') + '\Checker.ini');

      #ifdef PWP_SilentFormMode
      Lang := GetIniString('ISPATCH', 'PATCHING_ERROR', 'Patch was not applied!', sLang);
      Lang2 := GetIniString('ISPATCH', 'ROLLBACK_END', 'Error ocurred. Rollback applied. All patched files restored.', sLang);
      mStr.Caption := Lang + ' ' + Lang2;
      mStr.Refresh;
      #endif
      ////
      #ifndef PWP_SilentMode
      Lang := GetIniString('ISPATCH', 'FINISHED_WITH_ERRORS', 'Patch finished with errors! Check the log for details!', sLang); 
      MsgBox(Lang, mbError, mb_OK);
      #endif   
      Exit;
    end;

    ////////////////////////////////
    InsertCodeAfterUpdate;
    ////////////////////////////////

    ////////////////////////////////
    #ifndef PWP_SilentMode
    StartButton.Enabled := false;
    BrowseButton.Enabled := false; 
    //InfoButton.Enabled := True; 
    oDir.ReadOnly := True; 
     
    KillTimer(0, tTimerID);

    Lang := GetIniString('ISPATCH', 'PATCH_APPLIED', 'Patch was applied!', sLang); 
    xInfo.Text := Lang + #13#10 + FormatTime(Elapsed);
    xInfo.Update;
    #endif

    PatchingError := 0;
    #ifndef PWP_SilentMode
    if not cb_bak.checked then
    #endif
    begin 
      if DelTree(ExtendPath(ResultStr + BACKUP_DIR), True, True, True) then
      begin
        #ifndef PWP_SilentMode
        pLog.Lines.Add(''); 
        Lang := GetIniString('ISPATCH', 'TEMP_ROLLBACK_DELETED', 'Temporary files for rollback was deleted in: ', sLang);
        pLog.Lines.Add(Lang); 
        pLog.Lines.Add('--> ' + '"'+ ResultStr + BACKUP_DIR +'"'); 
        #endif
      end else
      begin
        #ifndef PWP_SilentMode
        Lang := GetIniString('ISPATCH', 'TEMP_ROLLBACK_DELETED_IN_USE', 'Temporary rollback dir: ', sLang);
        Lang2 := GetIniString('ISPATCH', 'TEMP_ROLLBACK_DELETED_IN_USE2', ' was cleared but some used files or folders unable to delete. Check this dir for details.', sLang);
        pLog.Lines.Add(Lang +'"'+ ResultStr + BACKUP_DIR +'"'+ Lang2); 
        #endif
      end;
    end;
    ////////////////////////////////
    #ifdef PWP_SilentFormMode   
    Lang := GetIniString('ISPATCH', 'OPERATION_SUCCESS', 'The operation completed successfully!', sLang);
    mStr.Caption := Lang;
    mStr.Refresh;
    #endif

    #ifndef PWP_SilentMode
    if cb_bak.checked then
    begin
      pLog.Lines.Add(''); 
      Lang := GetIniString('ISPATCH', 'STORED_BACKUP', 'Backup files stored in:  ', sLang);
      pLog.Lines.Add(Lang);
      pLog.Lines.Add('--> ' + '"'+ ResultStr + BACKUP_DIR+'"');
    end;
    #endif

    #ifndef PWP_SilentMode
    if cb_log.checked then
    begin
      //SaveStringsToFile(ExtendPath(ResultStr + '\{#PWP_PatchLogName}.txt'), [pLog.Text],False);
      pLog.Lines.Add(''); 
      Lang := GetIniString('ISPATCH', 'PATCHING_LOG', 'Patching log saved to: ', sLang);
      pLog.Lines.Add(Lang);
      pLog.Lines.Add('--> ' + '"'+ ResultStr + '\{#PWP_PatchLogName} '+GetDateTimeString('dd/mm/yyyy hh:nn:ss', '.', '-')+'.txt'+'"'); 
    end;
    #endif

    #ifndef PWP_SilentMode
    pLog.Lines.Add(''); 
    Lang := GetIniString('ISPATCH', 'OPERATION_SUCCESS', 'The operation completed successfully!', sLang);
    pLog.Lines.Add(Lang);
    SetTaskBarProgressValue(0);
    SetTaskBarProgressState(0); 
    ExitButton.Enabled := True;
    FlashTimer;
    #endif

    #ifndef PWP_SilentMode
    if cb_log.checked then 
    WriteUnicode(ExtendPath(ResultStr + '\{#PWP_PatchLogName} '+GetDateTimeString('dd/mm/yyyy hh:nn:ss', '.', '-')+'.txt'),pLog.Text);
    #endif
end;

#ifdef PWP_BatchCodeSupport
  #ifndef PWP_ExternalFilesSupport 
procedure OnPatchActivate;
begin
  ExtractTemporaryFile('OnStartupCode.bat');
  ExtractTemporaryFile('OnBeforeCode.bat');
  ExtractTemporaryFile('OnAfterCode.bat');
  ExtractTemporaryFile('OnFinishCode.bat');
end;
  #endif
  #ifdef PWP_ExternalTemp
procedure OnPatchActivate;
begin
  ExtractTemporaryFile('OnStartupCode.bat');
  ExtractTemporaryFile('OnBeforeCode.bat');
  ExtractTemporaryFile('OnAfterCode.bat');
  ExtractTemporaryFile('OnFinishCode.bat');
end;
  #endif
#endif

#ifdef PWP_SilentFormMode
procedure PatchStart (Sender: TObject);
begin
  ExitButton.Enabled := False;   
  Form.Refresh;
  ApplyPatchData;

  SetTaskBarProgressValue(0);
  SetTaskBarProgressState(0);
    
  ExitButton.Enabled := True;
  FlashTimer;
end;  

function ShowUpdaterForm(): Boolean;
begin
  Result := True;
  Form := CreateCustomForm();
try
  Form.ClientWidth := ScaleX(438);                                                                                                                                                                                                                                                  
  Form.ClientHeight := ScaleY(82);
  Form.Caption := '{#PWP_AppTitle}';
  Form.Center;
  Form.BorderIcons := [biMinimize];
  Form.OnActivate := @PatchStart;

  iStr := TLabel.Create(Form);
  iStr.Width:= ScaleX(38);                   
  iStr.Top := ScaleY(54);
  iStr.Left := ScaleX(7);
  iStr.Transparent := True;
  iStr.Parent := Form;
  iStr.ClientWidth := Form.ClientWidth;

  mStr := TLabel.Create(Form);               
  mStr.Top := ScaleY(5);
  mStr.Left := ScaleX(7);
  mStr.Transparent := True;
  mStr.Parent := Form;
  Lang := GetIniString('ISPATCH', 'PATCHING_PREPARING', 'Preparing to patching...', sLang);
  mStr.Caption := Lang;

  ProgressBar := TNewProgressBar.Create(Form); 
  ProgressBar.Parent := Form;
  ProgressBar.Width:= ScaleX(424);
  ProgressBar.Top := ScaleY(24);
  ProgressBar.Left := ScaleX(7);
  ProgressBar.Height := ScaleY(18);

  ExitButton := TButton.Create(Form);                                      
  ExitButton.Width := ScaleX(84);
  ExitButton.Height := ScaleY(22);
  ExitButton.Left := ScaleX(347);
  ExitButton.Top := ScaleY(50);
  Lang := GetIniString('ISPATCH', 'CLOSE_BUTTON', 'Close', sLang);
  ExitButton.Caption := Lang;
  ExitButton.Parent := Form;
  ExitButton.ModalResult := mrOk; 

  WintbStart();
  SetTaskBarProgressValue(0);
  SetTaskBarProgressState(0); 
                      
  Form.ActiveControl := ExitButton;

  if Form.ShowModal() = mrOk then
  Result := True;                                   
  finally           
    Form.Free();
  end; 
end;
#endif

#ifndef PWP_SilentMode
// Actions on a click Start button
procedure PatchStart (Sender: TObject);
begin
  Form.Refresh;
  ApplyPatchData;
  ExitButton.Enabled := True;
end;  
        
// show info
procedure ShowInfo (Sender: TObject);
begin
  Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
  if InfoButton.Caption = Lang then
  begin
    Lang := GetIniString('ISPATCH', 'LOG_BTN_STATE', 'Log', sLang);
    InfoButton.Caption := Lang;
    pLog.SendToBack;
    pInfo.BringToFront;

  #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif

    #ifndef PWP_InfoRtfSupport
      #ifdef PWP_InfoSupport
        #ifdef PWP_InfoNfoSupport
          pInfo.Font.Name:='Terminal';
          pInfo.Font.Size:=10;
          pInfo.Text := str_z;
        #endif
      #endif
        #ifndef  PWP_InfoSupport
          pInfo.Text := '';
        #endif
    #endif

    #ifdef PWP_InfoRtfSupport
      pInfo.RTFText := str_z;
    #endif
  #endif

  #ifndef PWP_MultiInfo
    #ifndef PWP_InfoRtfSupport
      #ifdef PWP_InfoSupport
        #ifdef PWP_InfoNfoSupport
          pInfo.Font.Name:='Terminal';
          pInfo.Font.Size:=10;
          pInfo.Text := str_z;
        #endif
        #ifndef PWP_InfoRtfSupport
        #ifndef PWP_InfoNfoSupport
          pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
        #endif
        #endif
      #endif
        #ifndef  PWP_InfoSupport
          pInfo.Text := '';
        #endif
    #endif

    #ifdef PWP_InfoRtfSupport
      pInfo.RTFText := str_z;
    #endif
  #endif
  end else
  begin
    Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
    InfoButton.Caption := Lang;
    pLog.BringToFront;
    pInfo.SendToBack;
  end;
end; 

#ifdef PWP_MusicButtonSupport
#ifndef PWP_VolumeButtons
procedure MusicPause (Sender: TObject);
begin
  if not BASS_ChannelPause(hMus) then  
  begin
    Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
    MusicButton.Caption := Lang + ' |>';
    BASS_ChannelPlay(hMus , False);
  end else
  begin
    Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PAUSE', 'Music ||', sLang);
    MusicButton.Caption := Lang + ' ||';
  end;
end; 
#endif

#ifdef PWP_VolumeButtons
procedure MusicPause (Sender: TObject);
begin
  if not BASS_ChannelPause(hMus) then  
  begin
    Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
    MusicButton.Font.Style:=StartButton.Font.Style;
    MusicButton.Caption := Lang;
    BASS_ChannelPlay(hMus, False);
  end else
  begin
    MusicButton.Font.Style:=[fsStrikeOut];
    Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PAUSE', 'Music', sLang);
    MusicButton.Caption := Lang;
  end;
end; 

procedure VolumeUp (Sender: TObject);
var
  flt: single;
begin
  BASS_ChannelGetAttribute(hMus, 2, flt);
  BASS_ChannelSetAttribute(hMus, 2, flt + 0.1);
end; 

procedure VolumeDown (Sender: TObject);
var
  flt: single;
begin
  BASS_ChannelGetAttribute(hMus, 2, flt);
  BASS_ChannelSetAttribute(hMus, 2, flt - 0.1);
end;
#endif

#endif

#ifdef PWP_DownloadFileSupport
procedure CancelDownload(Sender: TObject); 
begin
  CancelClicked := True;
end;
#endif

#ifdef PWP_ModMusicSupport
procedure PlayBassmodMusic;
begin
  if BASS_Init(-1, 44100, 0, 0, 0) then
  begin
    BASS_Start();
    ExtractTemporaryFile(ExtractFileName('{#PWP_MusicFile}'));
    Song := ExpandConstant(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_MusicFile}'));
    hMus := BASS_MusicLoad(FALSE, PAnsiChar(Song), 0, 0, 4 or $200 or $800, 0);
    if hMus <> 0 then
    begin
      BASS_ChannelSetAttribute(hMus, 2, {#PWP_DefaultVolume});
      BASS_ChannelPlay(hMus, True);
    end;
  end;
end;
#endif

#ifdef PWP_MusicSupport
procedure PlayMusic;
begin
  if BASS_Init(-1, 44100, 0, 0, 0) then
  begin
    BASS_Start();
    ExtractTemporaryFile(ExtractFileName('{#PWP_MusicFile}'));
    Song := ExpandConstant(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_MusicFile}'));
    hMus := BASS_StreamCreateFile(False, PAnsiChar(Song), 0, 0, 4);
    if hMus <> 0 then
    begin
      BASS_ChannelSetAttribute(hMus, 2, {#PWP_DefaultVolume});
      BASS_ChannelPlay(hMus, True);
    end;
  end;
end;
#endif

procedure CheckAppPath(Sender: TObject);
begin
  {#PWP_ResultString}
  oDir.Text := ResultStr; 
end;

procedure TransparentAndAnimation(Sender: TObject);
begin
#ifdef PWP_TransparentSupport
  SetWindowLong(Form.Handle, GWL_EXSTYLE, GetWindowLong(Form.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
  SetLayeredWindowAttributes(Form.Handle, TransparentColor, (255 * TransparentPercent) / 100, LWA_ALPHA);
#endif
#ifdef PWP_AnimationSupport
  #ifdef PWP_OnShowAnimation
    AnimateWindow(Form.Handle,{#PWP_InPlayTime},{#PWP_OnShowAnimationEffect} or AW_ACTIVATE);
    Form.ActiveControl := oDir; 
    Form.ActiveControl := xInfo;
    Form.ActiveControl := pInfo; 
    Form.ActiveControl := ExitButton; 
    oDir.Refresh; 
    xInfo.Refresh;
    pInfo.Refresh; 
    ExitButton.Refresh;
  #endif
#endif
end;

#ifdef PWP_AnimationSupport
#ifdef PWP_OnCloseAnimation
procedure AnimationOnClose(Sender: TObject; var Action: TCloseAction);
begin
  AnimateWindow(Form.Handle,{#PWP_OutPlayTime},{#PWP_OnCloseAnimationEffect} or AW_HIDE);
  Action := caFree;
end;
#endif
#endif

#ifdef PWP_StandardTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(438);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(468);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(3);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes

   cStr := TLabel.Create(Form);
#ifdef PWP_ScrollerSupport
   cStr.Top := ScaleY(17);
#endif
#ifndef PWP_ScrollerSupport
   cStr.Top := ScaleY(12);
#endif
   cStr.Left := ScaleX(0);
   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);

#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(38);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(56);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
   
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38);                   
   iStr.Top := ScaleY(74);
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(111);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(114);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes

#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(90);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(424);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(178);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;

#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(424);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(178);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(7);
   StartButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(347);
   BrowseButton.Top := ScaleY(110);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(256);
   InfoButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(7);
   MusicButton.Top := ScaleY(381);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(7);
   MusicButton.Top := ScaleY(381);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(174);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(256);
   CancelButton.Top := ScaleY(381);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(347);
   ExitButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(424);
   ProgressBar.Top := ScaleY(440);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(95);
   cb_bak.Top:=ScaleY(378);               
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(95);
   cb_log.Top:=ScaleY(396);           
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(95);
   cb_vh.Top:=ScaleY(414);           
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(377);
   bStr.Left := ScaleX(112);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(395);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(112);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(413);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(112);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(424);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(138);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(244);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(111);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                  
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_WideTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(554);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(468);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(3);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);
#ifdef PWP_ScrollerSupport
   cStr.Top := ScaleY(17);
#endif
#ifndef PWP_ScrollerSupport
   cStr.Top := ScaleY(12);
#endif
   cStr.Left := ScaleX(0);
   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);

#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(38);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(56);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38);                   
   iStr.Top := ScaleY(74);
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(111);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(114);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;
#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(90);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(540);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(178);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(540);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(178);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(7);
   StartButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(463);
   BrowseButton.Top := ScaleY(110);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(371);
   InfoButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(98);
   MusicButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(98);
   MusicButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(175);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(189);
   CancelButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(463);
   ExitButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(540);
   ProgressBar.Top := ScaleY(440);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(7);
   cb_bak.Top:=ScaleY(385);              
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(189);
   cb_log.Top:=ScaleY(385);            
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(371);
   cb_vh.Top:=ScaleY(385);        
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(385);
   bStr.Left := ScaleX(24);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(385);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(206);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(385);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(388);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(540);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(138);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(360);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(111);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                  
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_RightSideTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(618);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(381);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(3);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);
#ifdef PWP_ScrollerSupport
   cStr.Top := ScaleY(17);
#endif
#ifndef PWP_ScrollerSupport
   cStr.Top := ScaleY(12);
#endif
   cStr.Left := ScaleX(0);
   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);

#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(38);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(56);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38);                   
   iStr.Top := ScaleY(74);
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(111);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(114);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes

#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(90);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(424);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(178);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(424);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(178);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(437);
   StartButton.Top := ScaleY(177);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(527);
   BrowseButton.Top := ScaleY(110);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(437);
   InfoButton.Top := ScaleY(352);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(527);
   MusicButton.Top := ScaleY(177);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(527);
   MusicButton.Top := ScaleY(177);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(174);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(437);
   CancelButton.Top := ScaleY(325);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(527);
   ExitButton.Top := ScaleY(352);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(172);
   ProgressBar.Top := ScaleY(205);
   ProgressBar.Left := ScaleX(438);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(438);
   cb_bak.Top:=ScaleY(239);               
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(438);
   cb_log.Top:=ScaleY(267);         
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(438);
   cb_vh.Top:=ScaleY(295);           
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(238);
   bStr.Left := ScaleX(455);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(266);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(455);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(294);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(455);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(604);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(138);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(424);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(111);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                  
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_LeftSideTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(617);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(381);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(3);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);
#ifdef PWP_ScrollerSupport
   cStr.Top := ScaleY(17);
#endif
#ifndef PWP_ScrollerSupport
   cStr.Top := ScaleY(12);
#endif
   cStr.Left := ScaleX(0);
   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);

#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(38);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(56);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38);                   
   iStr.Top := ScaleY(74);
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(111);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(114);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(90);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(424);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(186);
   pInfo.Top := ScaleY(178);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(424);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(186);
   pLog.Top := ScaleY(178);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(7);
   StartButton.Top := ScaleY(177);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(527);
   BrowseButton.Top := ScaleY(110);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(7);
   InfoButton.Top := ScaleY(352);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(97);
   MusicButton.Top := ScaleY(177);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(97);
   MusicButton.Top := ScaleY(177);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(174);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(7);
   CancelButton.Top := ScaleY(325);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(97);
   ExitButton.Top := ScaleY(352);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(172);
   ProgressBar.Top := ScaleY(205);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(7);
   cb_bak.Top:=ScaleY(239);             
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(7);
   cb_log.Top:=ScaleY(267);       
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(7);
   cb_vh.Top:=ScaleY(295);           
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(238);
   bStr.Left := ScaleX(24);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(266);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(24);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(294);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(24);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(603);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(138);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(424);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(111);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                    
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_TopSideTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(438);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(468);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(450);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);

   cStr.Top := ScaleY(358);
   cStr.Left := ScaleX(0);

   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);

#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(380);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(398);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38);                   
   iStr.Top := ScaleY(416);
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(92);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(95);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(433);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(424);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(159);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(424);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(159);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(6);
   StartButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(348);
   BrowseButton.Top := ScaleY(91);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(257);
   InfoButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(6);
   MusicButton.Top := ScaleY(7);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(6);
   MusicButton.Top := ScaleY(7);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(175);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(257);
   CancelButton.Top := ScaleY(7);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(348);
   ExitButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(424);
   ProgressBar.Top := ScaleY(66);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(94);
   cb_bak.Top:=ScaleY(9);            
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(94);
   cb_log.Top:=ScaleY(26);        
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(94);
   cb_vh.Top:=ScaleY(43);            
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(8);
   bStr.Left := ScaleX(111);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(25);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(111);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(42);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(111);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(424);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(119);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(244);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(92);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                  
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_TopSideWideTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(553);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(468);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(450);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);

   cStr.Top := ScaleY(358);
   cStr.Left := ScaleX(0);

   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);

#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(380);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(398);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38);                   
   iStr.Top := ScaleY(416);
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(92);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(95);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(433);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(539);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(159);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(539);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(159);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(6);
   StartButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(463);
   BrowseButton.Top := ScaleY(91);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(371);
   InfoButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(98);
   MusicButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(98);
   MusicButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(175);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(189);
   CancelButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(463);
   ExitButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(539);
   ProgressBar.Top := ScaleY(66);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(7);
   cb_bak.Top:=ScaleY(13);          
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(189);
   cb_log.Top:=ScaleY(13);        
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(371);
   cb_vh.Top:=ScaleY(13);          
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(12);
   bStr.Left := ScaleX(24);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(12);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(206);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(12);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(388);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(539);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(119);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(360);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(92);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                   
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_ModernTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(438);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(468);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(3);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);
#ifdef PWP_ScrollerSupport
   cStr.Top := ScaleY(17);
#endif
#ifndef PWP_ScrollerSupport
   cStr.Top := ScaleY(12);
#endif
   cStr.Left := ScaleX(0);
   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);

#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(39);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(57);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38); 
   iStr.Top := ScaleY(75);                     
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(171);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(174);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(92);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(424);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(238);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(424);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(238);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(6);
   StartButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(347);
   BrowseButton.Top := ScaleY(170);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(256);
   InfoButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(6);
   MusicButton.Top := ScaleY(112);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(6);
   MusicButton.Top := ScaleY(112);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(175);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(256);
   CancelButton.Top := ScaleY(112);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(347);
   ExitButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(424);
   ProgressBar.Top := ScaleY(442);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(95);
   cb_bak.Top:=ScaleY(114);               
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(95);
   cb_log.Top:=ScaleY(131);            
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(95);
   cb_vh.Top:=ScaleY(148);           
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(113);
   bStr.Left := ScaleX(112);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(130);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(112);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(147);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(112);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(424);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(198);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(244);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(171);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                 
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_ModernWideTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(553);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(468);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(3);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);
#ifdef PWP_ScrollerSupport
   cStr.Top := ScaleY(17);
#endif
#ifndef PWP_ScrollerSupport
   cStr.Top := ScaleY(12);
#endif
   cStr.Left := ScaleX(0);
   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);
#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(40);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(58);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif
   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38); 
   iStr.Top := ScaleY(76);                     
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(171);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(174);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(94);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(539);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(238);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(539);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(238);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(6);
   StartButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(463);
   BrowseButton.Top := ScaleY(170);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(371);
   InfoButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(98);
   MusicButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(98);
   MusicButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(175);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(189);
   CancelButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(463);
   ExitButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(539);
   ProgressBar.Top := ScaleY(442);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(7);
   cb_bak.Top:=ScaleY(120);               
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(189);
   cb_log.Top:=ScaleY(120);           
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(371);
   cb_vh.Top:=ScaleY(120);             
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(119);
   bStr.Left := ScaleX(24);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(119);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(206);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(119);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(388);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(539);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(198);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(358);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(171);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                    
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_RevStandardTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(438);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(468);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(3);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);
#ifdef PWP_ScrollerSupport
   cStr.Top := ScaleY(17);
#endif
#ifndef PWP_ScrollerSupport
   cStr.Top := ScaleY(12);
#endif
   cStr.Left := ScaleX(0);
   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);
#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(38);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(56);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38);                   
   iStr.Top := ScaleY(74);
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(111);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(114);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(90);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(424);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(178);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(424);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(178);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(347);
   StartButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(347);
   BrowseButton.Top := ScaleY(110);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(256);
   InfoButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(7);
   MusicButton.Top := ScaleY(381);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(7);
   MusicButton.Top := ScaleY(381);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(174);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(256);
   CancelButton.Top := ScaleY(381);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(7);
   ExitButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(424);
   ProgressBar.Top := ScaleY(440);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(95);
   cb_bak.Top:=ScaleY(378);               
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(95);
   cb_log.Top:=ScaleY(396);           
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(95);
   cb_vh.Top:=ScaleY(414);           
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(377);
   bStr.Left := ScaleX(112);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(395);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(112);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(413);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(112);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(424);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(138);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(244);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(111);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
   begin
      Result := True;
   end;                                    
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_RevWideTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(554);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(468);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(3);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);
#ifdef PWP_ScrollerSupport
   cStr.Top := ScaleY(17);
#endif
#ifndef PWP_ScrollerSupport
   cStr.Top := ScaleY(12);
#endif
   cStr.Left := ScaleX(0);
   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);
#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(38);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(56);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38);                   
   iStr.Top := ScaleY(74);
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(111);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(114);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(90);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(540);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(178);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(540);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(178);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(463);
   StartButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(463);
   BrowseButton.Top := ScaleY(110);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(371);
   InfoButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(98);
   MusicButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(98);
   MusicButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(175);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(189);
   CancelButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(7);
   ExitButton.Top := ScaleY(410);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(540);
   ProgressBar.Top := ScaleY(440);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(7);
   cb_bak.Top:=ScaleY(385);              
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(189);
   cb_log.Top:=ScaleY(385);            
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(371);
   cb_vh.Top:=ScaleY(385);        
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(385);
   bStr.Left := ScaleX(24);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(385);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(206);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(385);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(388);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(540);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(138);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(360);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(111);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                  
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_RevRightSideTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(618);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(381);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(3);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);
#ifdef PWP_ScrollerSupport
   cStr.Top := ScaleY(17);
#endif
#ifndef PWP_ScrollerSupport
   cStr.Top := ScaleY(12);
#endif
   cStr.Left := ScaleX(0);
   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);

#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(38);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(56);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38);                   
   iStr.Top := ScaleY(74);
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(111);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(114);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(90);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(424);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(178);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(424);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(178);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(527);
   StartButton.Top := ScaleY(352);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(527);
   BrowseButton.Top := ScaleY(110);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(437);
   InfoButton.Top := ScaleY(352);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(527);
   MusicButton.Top := ScaleY(177);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(527);
   MusicButton.Top := ScaleY(177);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(174);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(437);
   CancelButton.Top := ScaleY(325);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(437);
   ExitButton.Top := ScaleY(177);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(172);
   ProgressBar.Top := ScaleY(205);
   ProgressBar.Left := ScaleX(438);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(438);
   cb_bak.Top:=ScaleY(239);               
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(438);
   cb_log.Top:=ScaleY(267);         
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(438);
   cb_vh.Top:=ScaleY(295);           
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(238);
   bStr.Left := ScaleX(455);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(266);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(455);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(294);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(455);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(604);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(138);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(424);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(111);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                    
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_RevLeftSideTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(617);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(381);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(3);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);
#ifdef PWP_ScrollerSupport
   cStr.Top := ScaleY(17);
#endif
#ifndef PWP_ScrollerSupport
   cStr.Top := ScaleY(12);
#endif
   cStr.Left := ScaleX(0);
   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif
   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);

#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(38);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(56);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38);                   
   iStr.Top := ScaleY(74);
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(111);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(114);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(90);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(424);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(186);
   pInfo.Top := ScaleY(178);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(424);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(186);
   pLog.Top := ScaleY(178);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(97);
   StartButton.Top := ScaleY(352);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(527);
   BrowseButton.Top := ScaleY(110);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(7);
   InfoButton.Top := ScaleY(352);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(97);
   MusicButton.Top := ScaleY(177);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(97);
   MusicButton.Top := ScaleY(177);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(174);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(7);
   CancelButton.Top := ScaleY(325);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(7);
   ExitButton.Top := ScaleY(177);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(172);
   ProgressBar.Top := ScaleY(205);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(7);
   cb_bak.Top:=ScaleY(239);             
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(7);
   cb_log.Top:=ScaleY(267);       
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(7);
   cb_vh.Top:=ScaleY(295);           
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(238);
   bStr.Left := ScaleX(24);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(266);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(24);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(294);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(24);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(603);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(138);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(424);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(111);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                   
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_RevTopSideTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(438);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(468);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(450);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);

   cStr.Top := ScaleY(358);
   cStr.Left := ScaleX(0);

   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);

#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(380);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(398);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38);                   
   iStr.Top := ScaleY(416);
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(92);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(95);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(433);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(424);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(159);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(424);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(159);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(348);
   StartButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(348);
   BrowseButton.Top := ScaleY(91);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(257);
   InfoButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(6);
   MusicButton.Top := ScaleY(7);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(6);
   MusicButton.Top := ScaleY(7);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(175);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(257);
   CancelButton.Top := ScaleY(7);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(6);
   ExitButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(424);
   ProgressBar.Top := ScaleY(66);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(94);
   cb_bak.Top:=ScaleY(9);            
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(94);
   cb_log.Top:=ScaleY(26);        
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(94);
   cb_vh.Top:=ScaleY(43);            
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(8);
   bStr.Left := ScaleX(111);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(25);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(111);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(42);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(111);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(424);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(119);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(244);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(92);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                   
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_RevTopSideWideTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(553);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(468);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(450);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);

   cStr.Top := ScaleY(358);
   cStr.Left := ScaleX(0);

   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);

#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(380);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(398);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38);                   
   iStr.Top := ScaleY(416);
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(92);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(95);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(433);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(539);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(159);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(539);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(159);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(463);
   StartButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(463);
   BrowseButton.Top := ScaleY(91);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(371);
   InfoButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(98);
   MusicButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(98);
   MusicButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(175);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(189);
   CancelButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(6);
   ExitButton.Top := ScaleY(36);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(539);
   ProgressBar.Top := ScaleY(66);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(7);
   cb_bak.Top:=ScaleY(13);          
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(189);
   cb_log.Top:=ScaleY(13);        
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(371);
   cb_vh.Top:=ScaleY(13);          
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(12);
   bStr.Left := ScaleX(24);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(12);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(206);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(12);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(388);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(539);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(119);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(360);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(92);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                   
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_RevModernTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(438);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(468);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(3);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);
#ifdef PWP_ScrollerSupport
   cStr.Top := ScaleY(17);
#endif
#ifndef PWP_ScrollerSupport
   cStr.Top := ScaleY(12);
#endif
   cStr.Left := ScaleX(0);
   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);
#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(39);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(57);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38); 
   iStr.Top := ScaleY(75);                     
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(171);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(174);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(92);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(424);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(238);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(424);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(238);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(347);
   StartButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(347);
   BrowseButton.Top := ScaleY(170);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(256);
   InfoButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(6);
   MusicButton.Top := ScaleY(112);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(6);
   MusicButton.Top := ScaleY(112);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(175);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(256);
   CancelButton.Top := ScaleY(112);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(6);
   ExitButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(424);
   ProgressBar.Top := ScaleY(442);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(95);
   cb_bak.Top:=ScaleY(114);               
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(95);
   cb_log.Top:=ScaleY(131);            
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(95);
   cb_vh.Top:=ScaleY(148);           
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(113);
   bStr.Left := ScaleX(112);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(130);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(112);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(147);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(112);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(424);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(198);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(244);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(171);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                    
   finally           
      Form.Free();
   end; 
end;
#endif

#ifdef PWP_RevModernWideTemplate
function ShowUpdaterForm(): Boolean;
begin
   Result := True;
   Form := CreateCustomForm();
try
   Form.ClientWidth := ScaleX(553);                                                                                                                                                                                                                                                  
   Form.ClientHeight := ScaleY(468);
   Form.Caption := '{#PWP_AppTitle}';
   Form.Center;
#ifdef PWP_TextColorSupport
   Form.Font.Color := {#PWP_Color};
#endif

   Form.OnShow := @TransparentAndAnimation;
   Form.OnActivate := @CheckAppPath;

#ifdef PWP_AnimationSupport
   #ifdef PWP_OnCloseAnimation
   Form.OnClose := @AnimationOnClose;
   #endif
#endif

#ifdef PWP_BackgroundBMP
   BMPBackground := TBitmapImage.Create(Form);
   BMPBackground.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_BackBMP}')); 
   BMPBackground.Left:= ScaleX(0);
   BMPBackground.Top:= ScaleY(0);
   BMPBackground.Height:= Form.ClientHeight;
   BMPBackground.Width:= Form.ClientWidth;
   BMPBackground.AutoSize := False;
   BMPBackground.Parent := Form;
   BMPBackground.Stretch := True;
#endif

#ifdef PWP_ScrollerSupport
   rStr := TLabel.Create(Form);               
   rStr.Top := ScaleY(3);
   rStr.Left := Form.Width;
   rStr.Width := Form.Width;
   rStr.Parent := Form;
   rStr.Font.Style:= [fsBold];
   rStr.Transparent := True;
   rStr.Caption := '    {#PWP_TextScroller}  ';
   #ifdef PWP_TextColorSupport
   rStr.Font.Color := {#PWP_Color};
   #endif
   StringTimer;
#endif

#ifndef PWP_DisablePatchNotes
   cStr := TLabel.Create(Form);
#ifdef PWP_ScrollerSupport
   cStr.Top := ScaleY(17);
#endif
#ifndef PWP_ScrollerSupport
   cStr.Top := ScaleY(12);
#endif
   cStr.Left := ScaleX(0);
   cStr.Font.Style:={#PWP_RLabelBold}cStr.Font.Style{#PWP_RLabelUnderline};
   cStr.Font.Size:= Form.Font.Size + {#PWP_RLabelSize};
   cStr.Font.Name:= Form.Font.Name;
   #ifdef PWP_TextColorSupport
   cStr.Font.Color := {#PWP_Color};
   #endif
   
   cStr.Caption := '{#PWP_AppName}' + ' ' + '{#PWP_AppNote}';

   cStr.ClientWidth := Form.ClientWidth;
   cStr.Alignment := taCenter;
   cStr.Transparent := True;
   cStr.Parent := Form;

   Lang := GetIniString('ISPATCH', 'DESCRIPTION', 'Description:', sLang);
   Lang2 := GetIniString('ISPATCH', 'COPYRIGHT', 'Copyright:', sLang);
   Lang3 := GetIniString('ISPATCH', 'CONTACT', 'Contact:', sLang);
#endif

   Lang4 := GetIniString('ISPATCH', 'INSTALLATION', 'Installation:', sLang);
#ifndef PWP_DisablePatchNotes
   dStr := TLabel.Create(Form);               
   dStr.Top := ScaleY(40);
   dStr.Left := ScaleX(0);
   dStr.Font.Style:={#PWP_BoldNotes}dStr.Font.Style;
   dStr.Caption := Lang +' {#PWP_Description}';
   dStr.Transparent := True;
   dStr.Parent := Form;
   dStr.ClientWidth := Form.ClientWidth;
   dStr.Alignment := taCenter;

   pStr := TLabel.Create(Form);               
   pStr.Top := ScaleY(58);
   pStr.Left := ScaleX(0);
   pStr.Font.Style:={#PWP_BoldNotes}pStr.Font.Style;
   pStr.Caption := Lang2 +' {#PWP_Copyright}';
   pStr.Transparent := True;
   pStr.Parent := Form;
   pStr.ClientWidth := Form.ClientWidth;
   pStr.Alignment := taCenter;
#endif

   iStr := TLabel.Create(Form);
   iStr.Width:= ScaleX(38); 
   iStr.Top := ScaleY(76);                     
   iStr.Left := ScaleX(0);
   iStr.Font.Style:={#PWP_BoldNotes}iStr.Font.Style;
   iStr.Caption := Lang3;
   iStr.Transparent := True;
   iStr.Parent := Form;
   iStr.ClientWidth := Form.ClientWidth;
   iStr.Alignment := taCenter;

   Panel:=TPanel.Create(Form)
   Panel.Left:=ScaleX(7);
   Panel.Top:=ScaleY(171);                                     
   Panel.Width:=ScaleX(90);
   Panel.Height:=ScaleY(21);
   Panel.BevelInner:=bvNone;
   Panel.BevelOuter:=bvNone
   Panel.Parent:=Form;
   Panel.Visible:=False;

   mStr := TLabel.Create(Form);               
   mStr.Top := ScaleY(174);
   mStr.Left := ScaleX(7);
   mStr.Caption := Lang4;
   mStr.Transparent := True;
   mStr.Parent := Form;
   mStr.ClientWidth := Panel.ClientWidth;
   mStr.Alignment := taCenter;

#ifndef PWP_DisablePatchNotes
#ifdef PWP_LinkSupport
   MouseLabel:=TLabel.Create(Form);
   MouseLabel.Width:=Form.Width;
   MouseLabel.Height:=Form.Height;
   MouseLabel.Autosize:=False;
   MouseLabel.Transparent:=True;
   MouseLabel.OnMouseMove:=@SiteLabelMouseMove2;
   MouseLabel.Parent:=Form;
#endif

   SiteLabel:=TLabel.Create(Form);
   SiteLabel.Caption:='{#PWP_Contact}';
   SiteLabel.Font.Style:={#PWP_BoldNotes}SiteLabel.Font.Style;

#ifdef PWP_LinkSupport
   SiteLabel.Cursor:=crHand; 
   SiteLabel.OnClick:=@SiteLabelOnClick;
   SiteLabel.OnMouseDown:=@SiteLabelMouseDown;
   SiteLabel.OnMouseUp:=@SiteLabelMouseUp;
   SiteLabel.OnMouseMove:=@SiteLabelMouseMove;
#endif
   SiteLabel.Transparent:=True
   SiteLabel.Parent:=Form;
   SiteLabel.Top:=ScaleY(94);
   SiteLabel.Left := (Form.ClientWidth - SiteLabel.Width) / 2;
#endif

#ifdef PWP_InfoRtfSupport
   pInfo := TRichEditViewer.Create(Form);
#endif
#ifndef PWP_InfoRtfSupport
   pInfo := TMemo.Create(Form);
#endif
   pInfo.Parent := Form;
   pInfo.Width := ScaleX(539);          
   pInfo.Height := ScaleY(195);
   pInfo.Left := ScaleX(7);
   pInfo.Top := ScaleY(238);
   pInfo.ReadOnly:=True;
   pInfo.ScrollBars:={#PWP_WordWrap};
   pInfo.WordWrap:=True;
#ifdef PWP_InfoSupport
   #ifdef PWP_MultiInfo
      #ifdef PWP_TXT_Info
      if FileExists(ExpandConstant('{tmp}\info\') + iName + '.txt') then
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + iName + '.txt')
      else
      pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\info\') + 'English.txt');
      #endif
      #ifdef PWP_RTF_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.rtf', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.rtf', str_z);
      #endif
      #ifdef PWP_NFO_Info
      if not LoadStringFromFile(ExpandConstant('{tmp}\info\') + iName + '.nfo', str_z) then
      LoadStringFromFile(ExpandConstant('{tmp}\info\') + 'English.nfo', str_z); 
      #endif
   #endif

   #ifndef PWP_MultiInfo
     ExtractTemporaryFile(ExtractFileName('{#PWP_InfoFile}'));
     #ifndef PWP_InfoRtfSupport
     #ifndef PWP_InfoNfoSupport
     pInfo.Lines.LoadFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'));
     #endif
     #endif
   #endif
#endif

#ifdef PWP_InfoRtfSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.RTFText := str_z;
#endif

#ifndef PWP_InfoSupport
   pInfo.Text := '';
#endif
   pInfo.Alignment := taLeftJustify;
#ifdef PWP_InfoNfoSupport
   pInfo.Font.Name:='Terminal';
   pInfo.Font.Size:=10;

   #ifdef PWP_InfoSupport
   #ifndef PWP_MultiInfo
   LoadStringFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_InfoFile}'), str_z);
   #endif
   pInfo.Text := str_z;
   #endif
#endif
   pInfo.Parent := Form;
   pInfo.BringToFront;

   pLog := TMemo.Create(Form);
   pLog.Parent := Form;
   pLog.Width := ScaleX(539);          
   pLog.Height := ScaleY(195);
   pLog.Left := ScaleX(7);
   pLog.Top := ScaleY(238);
   pLog.ReadOnly:=True;
   pLog.ScrollBars:=ssBoth;
   pLog.Text := '';
   pLog.Alignment := taLeftJustify;
   pLog.Parent := Form;
   pLog.SendToBack;

   StartButton := TButton.Create(Form);                    
   StartButton.Width := ScaleX(84);
   StartButton.Height := ScaleY(22);
   StartButton.Left := ScaleX(463);
   StartButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'START_BUTTON', 'Start', sLang);
   StartButton.Caption := Lang;
   StartButton.OnClick := @PatchStart;
   StartButton.Parent := Form;  

   BrowseButton := TButton.Create(Form);                    
   BrowseButton.Width := ScaleX(84);
   BrowseButton.Height := ScaleY(22);
   BrowseButton.Left := ScaleX(463);
   BrowseButton.Top := ScaleY(170);
   Lang := GetIniString('ISPATCH', 'BROWSE_BUTTON', 'Browse', sLang);
   BrowseButton.Caption := Lang;
   BrowseButton.OnClick := @BrowseOutput;
   BrowseButton.Parent := Form; 

   InfoButton := TButton.Create(Form);                                         
   InfoButton.Width := ScaleX(84);
   InfoButton.Height := ScaleY(22);
   InfoButton.Left := ScaleX(371);
   InfoButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'INFO_BUTTON', 'Info', sLang);
   InfoButton.Caption := Lang;
   InfoButton.OnClick := @ShowInfo; 
   InfoButton.Enabled := False;  
   InfoButton.Parent := Form;

#ifdef PWP_MusicButtonSupport
   #ifndef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(84);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(98);
   MusicButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang + ' |>';
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;
   #endif

   #ifdef PWP_VolumeButtons
   MusicButton := TButton.Create(Form);                                         
   MusicButton.Width := ScaleX(56);
   MusicButton.Height := ScaleY(22);
   MusicButton.Left := ScaleX(98);
   MusicButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'MUSIC_BUTTON_PLAY', 'Music', sLang);
   MusicButton.Caption := Lang;
   MusicButton.OnClick := @MusicPause; 
   MusicButton.Parent := Form;

   MusicButton2 := TButton.Create(Form);                                         
   MusicButton2.Width := ScaleX(14);
   MusicButton2.Height := ScaleY(22);
   MusicButton2.Left := MusicButton.Left + MusicButton.Width;
   MusicButton2.Top := MusicButton.Top;
   MusicButton2.Caption := '-';
   MusicButton2.OnClick := @VolumeDown; 
   MusicButton2.Parent := Form;

   MusicButton1 := TButton.Create(Form);                                         
   MusicButton1.Width := ScaleX(14);
   MusicButton1.Height := ScaleY(22);
   MusicButton1.Left := MusicButton.Left + MusicButton.Width + MusicButton1.Width;
   MusicButton1.Top := MusicButton.Top;
   MusicButton1.Caption := '+';
   MusicButton1.OnClick := @VolumeUp; 
   MusicButton1.Parent := Form;
   #endif
#endif

#ifdef PWP_DownloadFileSupport
   CancelButton := TButton.Create(Form);                                         
   CancelButton.Width := ScaleX(175);
   CancelButton.Height := ScaleY(22);
   CancelButton.Left := ScaleX(189);
   CancelButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'CANCEL_DOWNLOAD_BUTTON', 'Cancel Download', sLang);
   CancelButton.Caption := Lang;
   CancelButton.OnClick := @CancelDownload; 
   CancelButton.Enabled := False; 
   CancelButton.Parent := Form;
#endif

   ExitButton := TButton.Create(Form);                                         
   ExitButton.Width := ScaleX(84);
   ExitButton.Height := ScaleY(22);
   ExitButton.Left := ScaleX(6);
   ExitButton.Top := ScaleY(141);
   Lang := GetIniString('ISPATCH', 'EXIT_BUTTON', 'Exit', sLang);
   ExitButton.Caption := Lang;
   ExitButton.Parent := Form;
   ExitButton.ModalResult := mrOk; 

   ProgressBar := TNewProgressBar.Create(Form); 
   ProgressBar.Parent := Form;
   ProgressBar.Width:= ScaleX(539);
   ProgressBar.Top := ScaleY(442);
   ProgressBar.Left := ScaleX(7);
   ProgressBar.Height := ScaleY(18);
  
   WintbStart();
   SetTaskBarProgressValue(0);
   SetTaskBarProgressState(0); 

   cb_bak:=TCheckBox.Create(Form);
   cb_bak.Width:=ScaleX(13);
   cb_bak.Height:=ScaleY(13);
   cb_bak.Left:=ScaleX(7);
   cb_bak.Top:=ScaleY(120);               
   cb_bak.checked:= {#PWP_DefaultBackup};
   cb_bak.Parent:=Form;

   cb_log:=TCheckBox.Create(Form);
   cb_log.Width:=ScaleX(13);
   cb_log.Height:=ScaleY(13);
   cb_log.Left:=ScaleX(189);
   cb_log.Top:=ScaleY(120);           
   cb_log.checked:= {#PWP_DefaultLog};
   cb_log.Parent:=Form;

   cb_vh:=TCheckBox.Create(Form);
   cb_vh.Width:=ScaleX(13);
   cb_vh.Height:=ScaleY(13);
   cb_vh.Left:=ScaleX(371);
   cb_vh.Top:=ScaleY(120);             
   cb_vh.checked:= {#PWP_DefaultVerify};
   cb_vh.Parent:=Form;

   bStr := TLabel.Create(Form);
   bStr.Width:= ScaleX(168);
   bStr.Height:= ScaleX(18);
   bStr.Top := ScaleY(119);
   bStr.Left := ScaleX(24);
   Lang := GetIniString('ISPATCH', 'BACKUP_BUTTON', 'Save Backup', sLang);
   bStr.Caption := Lang;
   bStr.Transparent := True;
   bStr.Parent := Form;

   lStr := TLabel.Create(Form);
   lStr.Width:= ScaleX(168);
   lStr.Top := ScaleY(119);
   lStr.Height:= ScaleX(18);
   lStr.Left := ScaleX(206);
   Lang := GetIniString('ISPATCH', 'LOG_BUTTON', 'Save Log', sLang);
   lStr.Caption := Lang;
   lStr.Transparent := True;
   lStr.Parent := Form;

   vStr := TLabel.Create(Form);
   vStr.Width:= ScaleX(168);
   vStr.Top := ScaleY(119);
   vStr.Height:= ScaleX(18);
   vStr.Left := ScaleX(388);
   Lang := GetIniString('ISPATCH', 'VERIFY_BUTTON', 'Verify Hash', sLang);
   vStr.Caption := Lang;
   vStr.Transparent := True;
   vStr.Parent := Form;

   xInfo := TMemo.Create(Form);
   xInfo.Width := ScaleX(539);
   xInfo.Height := ScaleY(34);
   xInfo.Left := ScaleX(7);
   xInfo.Top := ScaleY(198);
   xInfo.Parent := Form;
   xInfo.ReadOnly := True; 
   xInfo.Alignment :=taCenter;
   xInfo.Font.Style := [fsBold];
   xInfo.WordWrap:=False;
   xInfo.WantReturns:=False;

   oDir := TEdit.Create(Form);
   oDir.Width := ScaleX(358);
   oDir.Height := ScaleY(18);
   oDir.Left := ScaleX(97);
   oDir.Top := ScaleY(171);
   oDir.OnChange := @CheckValidAppPath;

   //{#PWP_ResultString}
   //oDir.Text := ResultStr; 
   oDir.Parent := Form;

#ifdef PWP_TextColorSupport
#ifdef PWP_MemoBlackColorSupport
#ifndef PWP_InfoRtfSupport
   pInfo.Font.Color := clBlack;
#endif
   pLog.Font.Color := clBlack;
   xInfo.Font.Color := clBlack;
   oDir.Font.Color := clBlack;
#endif
#endif

#ifdef PWP_CursorSupport
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurBtnLocation}'));
   ExtractTemporaryFile(ExtractFileName('{#PWP_CurFrmLocation}'));

   NewCursor     := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurBtnLocation}'));
   NewCursorForm := LoadCursorFromFile(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_CurFrmLocation}'));

   OldCursor:= SetClassLong(StartButton.Handle, GCL_HCURSOR, NewCursor);   
   OldCursor:= SetClassLong(cb_bak.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_log.Handle, GCL_HCURSOR, NewCursor); 
   OldCursor:= SetClassLong(cb_vh.Handle, GCL_HCURSOR, NewCursor); 

   OldCursor:= SetClassLong(pLog.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(pInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(xInfo.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(Form.Handle, GCL_HCURSOR, NewCursorForm); 
   OldCursor:= SetClassLong(oDir.Handle, GCL_HCURSOR, NewCursorForm);  
   OldCursor:= SetClassLong(ProgressBar.Handle, GCL_HCURSOR, NewCursorForm);   
#endif
                               
   Form.ActiveControl := ExitButton;
   init_key_chk := 1;
#ifdef PWP_ModMusicSupport
   PlayBassmodMusic;
#endif
#ifdef PWP_MusicSupport
   PlayMusic;
#endif
   if Form.ShowModal() = mrOk then
      Result := True;                                    
   finally           
      Form.Free();
   end; 
end;
#endif

//silent end
#endif

#ifndef PWP_SilentMode
#ifdef PWP_LanguageSelector
procedure SearchLangFiles(const fromDir, fileMask: String);
var
  FSR: TFindRec;
  FindResult: Boolean;
  APath: String;
begin
  APath := AddBackslash(fromDir);
  FindResult := FindFirst(APath + fileMask, FSR);
  try
    while FindResult do
    begin
      if (FSR.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0) then
      begin
        Delete(FSR.Name,Length(FSR.Name)-3,4); 
        lCombo.Items.Add(FSR.Name);
      end;
      FindResult := FindNext(FSR);
    end;
  finally
    FindClose(FSR);
  end;                                                                 
end;

function LangSelector(): Boolean;
var
  lExitButton: TButton;
  lForm: TSetupForm;
begin
  Result := True;
  lForm := CreateCustomForm();
  try
    lForm.ClientWidth := ScaleX(207);                                                                                                                                                                                                                                                  
    lForm.ClientHeight := ScaleY(68);
    lForm.Caption := 'Patch Language';
    lForm.BorderIcons := [biMinimize];
    lForm.Center;

    lCombo := TComboBox.Create(lForm);
    lCombo.Parent := lForm;
    lCombo.Style := csDropDownList;
    lCombo.Width := ScaleX(192);          
    lCombo.Height := ScaleY(22);
    lCombo.Left := ScaleX(7);
    lCombo.Top := ScaleY(9);

    lExitButton := TButton.Create(lForm);    
    lExitButton.Parent := lForm;                                     
    lExitButton.Width := ScaleX(70);
    lExitButton.Height := ScaleY(22);
    lExitButton.Left := ScaleX(130);
    lExitButton.Top := ScaleY(38);
    lExitButton.Caption := 'OK';
    lExitButton.ModalResult := mrOk; 
    lForm.ActiveControl := lExitButton;                   

    ExtractTemporaryFiles('lang\*.ini');

    SearchLangFiles(ExpandConstant('{tmp}\lang'),'*.ini');

    lCombo.ItemIndex := lCombo.Items.IndexOf('{#PWP_DefPatchLang}');
    if lCombo.ItemIndex < 0 then
    lCombo.ItemIndex := 0;

    if lForm.ShowModal() = mrOk then
    Result := True;  
      
    sLang := ExpandConstant('{tmp}\lang\') + lCombo.Items.Strings[lCombo.ItemIndex] + '.ini';

    #ifdef PWP_MultiInfo
    ExtractTemporaryFiles('info\*');
    //iName := Copy(lCombo.Items.Strings[lCombo.ItemIndex],1,Length(lCombo.Items.Strings[lCombo.ItemIndex])-4);
    iName := Copy(lCombo.Items.Strings[lCombo.ItemIndex],1,Length(lCombo.Items.Strings[lCombo.ItemIndex])); // multiinfo fix

    #endif            
  finally           
    lForm.Free();
  end; 
end;
#endif
#endif

function InitializeSetup(): Boolean;
begin
  #ifndef PWP_SilentMode
    #ifdef PWP_SkinSupport
      ExtractTemporaryFile(ExtractFileName('{#PWP_SkinLocation}'));
      LoadSkin(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_SkinLocation}'), '{#PWP_SkinSchemaName}');
    #endif
    #ifdef PWP_SkinSupportVCL
      ExtractTemporaryFile(ExtractFileName('{#PWP_SkinLocation}'));
      LoadVCLStyle(ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_SkinLocation}'));
    #endif
  #endif

  #ifndef PWP_SilentMode
    #ifdef PWP_LanguageSelector
      LangSelector;
    #endif
  #endif

  #ifdef PWP_BatchCodeSupport
    #ifndef PWP_ExternalFilesSupport 
      OnPatchActivate;
    #endif
    #ifdef PWP_ExternalTemp
      OnPatchActivate;
    #endif
  #endif

  #ifdef PWP_SilentMode
    {#PWP_ResultString} 
    PatchingError := 2; 
    InsertCodeOnStartup;

    #ifndef PWP_SilentFormMode
      ApplyPatchData;
    #endif

    #ifdef PWP_SilentFormMode
      #ifdef PWP_LanguageSupport
        #ifndef PWP_LanguageSelector
          ExtractTemporaryFile(ExtractFileName('{#PWP_PatchLanguage}'));
          sLang := ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_PatchLanguage}');
        #endif
      #endif
      ShowUpdaterForm;
      WintbStop;
      KillTimer(0, fTimerID);
    #endif

    InsertCodeOnFinish;
    Result := False;
  #endif

  #ifndef PWP_SilentMode

  #ifdef PWP_LanguageSupport 
    #ifndef PWP_LanguageSelector
      ExtractTemporaryFile(ExtractFileName('{#PWP_PatchLanguage}'));
      sLang := ExpandConstant('{tmp}\') + ExtractFileName('{#PWP_PatchLanguage}');
    #endif
  #endif

  #ifdef PWP_AppDetecting
    #ifndef PWP_CheckAppBeforePatching
      Result := CheckRunningApplication;
    #endif
  #endif
  
  #ifdef PWP_BackgroundBMP
    ExtractTemporaryFile(ExtractFileName('{#PWP_BackBMP}'));
  #endif

    PatchingError := 2;
    InsertCodeOnStartup;

    init_key_chk := 0;
    ShowUpdaterForm;

    #ifdef PWP_ScrollerSupport
      KillTimer(0, sTimerID);
    #endif

    #ifndef PWP_SilentMode
      WintbStop;
      KillTimer(0, fTimerID);
    #endif

    #ifdef PWP_CursorSupport
      SetSystemCursor(OldCursor, OCR_NORMAL);
    #endif

    #ifdef PWP_ModMusicSupport
      BASS_MusicFree(hMus);
      BASS_Stop();
      BASS_Free(); 
    #endif
    #ifdef PWP_MusicSupport
      BASS_Stop();
      BASS_Free(); 
    #endif

    InsertCodeOnFinish;

    #ifdef PWP_SkinSupport  
      HW := FindWindow('TApplication','{#PWP_AppTitle}');
      ShowWindow(HW, 0); 
      UnloadSkin();
    #endif
    #ifdef PWP_SkinSupportVCL  
      UnLoadVCLStyles;
    #endif

    Result := False; 
  #endif
end;

#ifdef Debug
  #expr SaveToFile(AddBackslash(SourcePath) + "Preprocessed.iss");
#endif