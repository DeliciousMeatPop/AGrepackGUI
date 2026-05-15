// XHashEx.dll - Header
// Created by BLACKFIRE69
// Version:  v1.0
// Last Updated:  2023-July-29

[Code]

const
{ Algorithm }
  H_CRC32                     = 1;
  H_MD5                       = 2;
  H_SHA1                      = 3;
  H_SHA256                    = 4;
  H_SHA512                    = 5;
  H_SHA512_256                = 6;
  H_SHA3_256                  = 7;
  H_SHA3_512                  = 8;
  H_BLAKE2_128                = 9;
  H_BLAKE2_256                = 10;
  H_BLAKE3_256                = 11;
  H_HAVAL3_128                = 12;
  H_HAVAL3_256                = 13;
  H_RIPEMD_128                = 14;
  H_RIPEMD_256                = 15;
  H_TIGER_128                 = 16;
  H_TIGER_192                 = 17;
  H_TIGER2_128                = 18;
  H_TIGER2_192                = 19;
  H_MURMURHASH_32             = 20;
  H_XXHASH_32                 = 21;

{ Error level }
  H_HASH_OK                   = 0;
  H_HASHES_IN_PROGRESS        = 1;
  H_FILE_HASHING_DONE         = 2;
  H_PROCESS_DONE              = 3;
  H_PROCESS_ABORTED           = -1;
  H_BAD_FILE_HASH             = -2;
  H_FILE_NOT_FOUND            = -3;
  H_INVALID_HASH_ALGORITHM    = -4;
  H_ERROR_GENERAL             = -5;
  H_INTERNAL_ERROR            = -6;
  H_HASH_GENERATE_ERROR       = -7;
  H_INVALID_HASHHEX           = -8;
  H_INVALID_CHECKSUM_FILE     = -9;
  H_INVALID_DIRECTORY         = -10;
  H_HASH_VERIFY_ERROR         = -11;
  H_CANNOT_CREATE_HASH_FILE   = -12;
  H_EMPTY_DIRECTORY           = -13;
  H_INPUT_FILE_NOT_FOUND      = -14;
  H_CANNOT_CREATE_LOG_FILE    = -15;

{ Log Mgs ID }
  H_LOGMSG_ID_EXPECTEDHASH    = 100;
  H_LOGMSG_ID_CALCULATEDHASH  = 200;
  H_LOGMSG_ID_STATUS          = 300;
  H_LOGMSG_ID_FILENOTFOUND    = 400;
  H_LOGMSG_ID_BADHASH         = 500;
  H_LOGMSG_ID_HASHOK          = 600;
  H_LOGMSG_ID_NULL            = 700;

{ Format Str }
  XH_FILENAME                 = '%s';
  XH_FILEPOSITION             = '%s / %s';
  XH_PERCENTAGE               = '%d%%';
  XH_VERIFYSTATUS             = '%d / %d  Ok:  %d  Bad:  %d  Missing:  %d';
  XH_GENERATESTATUS           = '%d / %d';

{ Callback / Enum }
type
  THashStatus             = (hsRuning, hsPaused);
  //TFFResultKind          = (ffrkFull, ffrkRelative, ffrkOnlyName);
  TSingleFileHashCallback = function(FileName: WideString; FileSize: Extended; FileProgress, StatusCode: Integer): Boolean;
  TMultiHashCallback      = function(FileName: WideString; FileSize: Extended; FileProgress, TotalProgress, TotalFiles, FileCounted, StatusCode: Integer): Boolean;

{ Variables }
var
  CancelAll: Boolean;
  Ok, Bad, Missing: Integer;


{ 1. Directory }
function CalculateHashesForDir(ChecksumFile, BasePath: WideString; HashAlgo: Integer; Callback: TMultiHashCallback): Integer;
  external 'CalculateHashesForDir@{tmp}\XHashEx.dll stdcall delayload';
// Return codes:
//    H_PROCESS_DONE
//    H_HASH_GENERATE_ERROR
//	  H_INVALID_DIRECTORY
//	  H_PROCESS_ABORTED
//    H_FILE_NOT_FOUND
//    H_INTERNAL_ERROR
//    H_CANNOT_CREATE_HASH_FILE
//    H_EMPTY_DIRECTORY

function CalculateHashesForDirEx(ChecksumFile, BasePath, IncludeFiles, ExcludeFiles: WideString; HidePathInCallback, UsePreviousHashCache: Boolean; HashAlgo: Integer; Callback: TMultiHashCallback): Integer;
  external 'CalculateHashesForDirEx@{tmp}\XHashEx.dll stdcall delayload';

// Return codes:
//    H_PROCESS_DONE
//    H_HASH_GENERATE_ERROR
//	  H_INVALID_DIRECTORY
//	  H_PROCESS_ABORTED
//    H_FILE_NOT_FOUND
//    H_INTERNAL_ERROR
//    H_CANNOT_CREATE_HASH_FILE
//    H_EMPTY_DIRECTORY

(* IncludeFiles:
  = '*.*'
  = '*.bin|*.dat|*.arc|*.dll'
  = 'images\png\*|game*info.*|20??_cfg.ini'

  = '@".\Includes.txt"'              or    '@.\Includes.txt'
  = '@"C:\testing\incl.txt"'         or    '@C:\testing\incl.txt'

  = '@"i1.txt"|@"i2.txt"|@"i3.txt"'  or    '@i1.txt|@i2.txt|@i3.txt'
  = '@C:\testing\i1.txt|@C:\testing\i2.txt|@C:\testing\i3.txt'

  = 'images\png\*|@i2.txt|20??_cfg.ini'
*)

(* ExcludeFiles:
  = '*.bckp'
  = 'Trainer.exe|uninst???.exe|uninst???.dat'
  = 'Bin\*.*|Web\Help\*.*|patch.exe'
  = 'Documents\ReadMe - *.txt|Languages\English???_*.lng'

  = '@".\Excludes.txt"'              or    '@.\Excludes.txt'
  = '@"C:\testing\excl.txt"'         or    '@C:\testing\excl.txt'

  = '@"x1.txt"|@"x2.txt"|@"x3.txt"'  or    '@x1.txt|@x2.txt|@x3.txt'
  = '@C:\testing\x1.txt|@C:\testing\x2.txt|@C:\testing\x3.txt'

  = '@x1.txt|uninst???.exe|uninst???.dat'
*)

function VerifyHashesFromFile(ChecksumFile, BasePath: WideString; HashAlgo, PreviousFileCount: Integer; LogFile: Boolean; Callback: TMultiHashCallback): Integer;
  external 'VerifyHashesFromFile@{tmp}\XHashEx.dll stdcall delayload';
function VerifyHashesFromFileEx(ChecksumFile, BasePath: WideString; HashAlgo, PreviousFileCount: Integer; HidePathInCallback, LogFile: Boolean; Callback: TMultiHashCallback): Integer;
  external 'VerifyHashesFromFileEx@{tmp}\XHashEx.dll stdcall delayload';
// Return codes:
//    H_PROCESS_DONE
//    H_HASH_VERIFY_ERROR
//    H_INVALID_CHECKSUM_FILE
//    H_INVALID_HASH_ALGORITHM
//    H_PROCESS_ABORTED
//    H_FILE_NOT_FOUND
//    H_INTERNAL_ERROR
//    H_CANNOT_CREATE_LOG_FILE

{ Only for CRC32, MD5, SHA1, SHA256 and SHA512. This is used when multiple algorithms (crc32, md5, sha1, sha256, sha512) are used in a single hash file (ex: hash_mixed.md5). }
function VerifyHashesAutoFromFile(ChecksumFile, BasePath: WideString; PreviousFileCount: Integer; LogFile: Boolean; Callback: TMultiHashCallback): Integer;
  external 'VerifyHashesAutoFromFile@{tmp}\XHashEx.dll stdcall delayload';
function VerifyHashesAutoFromFileEx(ChecksumFile, BasePath: WideString; PreviousFileCount: Integer; HidePathInCallback, LogFile: Boolean; Callback: TMultiHashCallback): Integer;
  external 'VerifyHashesAutoFromFileEx@{tmp}\XHashEx.dll stdcall delayload';
// Return codes:
//    H_PROCESS_DONE
//    H_HASH_VERIFY_ERROR
//    H_INVALID_CHECKSUM_FILE
//    H_INVALID_HASHHEX
//    H_INVALID_HASH_ALGORITHM
//    H_PROCESS_ABORTED
//    H_FILE_NOT_FOUND
//    H_INTERNAL_ERROR
//    H_CANNOT_CREATE_LOG_FILE


{ 2. Single file }
function CalculateFileHash(const FileName: WideString; const HashAlgo: Integer; Callback: TSingleFileHashCallback): WideString;
  external 'CalculateFileHash@{tmp}\XHashEx.dll stdcall delayload';
// Return codes (Callback):
//    H_INPUT_FILE_NOT_FOUND

function VerifyFileHash(FileName, HashHexStr: WideString; HashAlgo: Integer; LogFile: Boolean; Callback: TSingleFileHashCallback): Integer;
  external 'VerifyFileHash@{tmp}\XHashEx.dll stdcall delayload';
// Return codes:
//    H_HASH_OK
//    H_BAD_FILE_HASH
//    H_FILE_NOT_FOUND
//    H_CANNOT_CREATE_LOG_FILE


{ Other }
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

{ New }
procedure HashLogClear();
  external 'HashLogClear@{tmp}\XHashEx.dll stdcall delayload';

function GetHashLogString(ClearLog: Boolean): WideString;
  external 'GetHashLogString@{tmp}\XHashEx.dll stdcall delayload';

procedure CalculatedHashClear();
  external 'CalculatedHashClear@{tmp}\XHashEx.dll stdcall delayload';

function GetCalculatedHashString(ClearHash: Boolean): WideString;
  external 'GetCalculatedHashString@{tmp}\XHashEx.dll stdcall delayload';

function GetHashStatus: THashStatus;
  external 'GetHashStatus@{tmp}\XHashEx.dll stdcall delayload';

procedure SetHashMaxProgress(const MaxTotalProgress, MaxFileProgress: Integer);
  external 'SetHashMaxProgress@{tmp}\XHashEx.dll stdcall delayload';

procedure HashCommentDefault(HideComments: Boolean);
  external 'HashCommentDefault@{tmp}\XHashEx.dll stdcall delayload';

procedure HashCommentClear(UseDefaultComments: Boolean);
  external 'HashCommentClear@{tmp}\XHashEx.dll stdcall delayload';

procedure HashCommentAdd(CommentStr: WideString; InNewLine: Boolean);
  external 'HashCommentAdd@{tmp}\XHashEx.dll stdcall delayload';

function GetPreviouslyVerifiedFileCount(ClearCount, ClearBefore: Boolean): Integer;
  external 'GetPreviouslyVerifiedFileCount@{tmp}\XHashEx.dll stdcall delayload';

{ Optional }
function ByteOrTb(const Float: Extended): WideString;
  external 'ByteOrTb@{tmp}\XHashEx.dll stdcall delayload';
(*
procedure ProcessMessages();
  external 'ProcessMessages@{tmp}\XHashEx.dll stdcall delayload';

{ Search for Files + Directories }
function pFindFiles(const Path, FileMasks, ExcludeMasks: WideString; ResultKind: TFFResultKind; Recursive, AFindDirs: Boolean): Longint;
  external 'pFindFiles@{tmp}\XHashEx.dll stdcall delayload';
function pFindFilesEx(const Path, FileMasks, ExcludeMasks: WideString; ResultKind: TFFResultKind; Recursive, HiddenFiles, SystemFiles, FindDirs: Boolean): Longint;
  external 'pFindFilesEx@{tmp}\XHashEx.dll stdcall delayload';

{ Files }
function pFileCount(const FindHandle: Longint): Integer;
  external 'pFileCount@{tmp}\XHashEx.dll stdcall delayload';

function pPickFile(const FindHandle: Longint; Const AIndex: Integer): WideString;
  external 'pPickFile@{tmp}\XHashEx.dll stdcall delayload';
function pPickSize(Const FindHandle: Longint; Const AIndex: Integer): WideString;
  external 'pPickSize@{tmp}\XHashEx.dll stdcall delayload';
function pPickAttrib(Const FindHandle: Longint; Const AIndex: Integer): Integer;
  external 'pPickAttrib@{tmp}\XHashEx.dll stdcall delayload';

{ Directories }
function pDirCount(const FindHandle: Longint): Integer;
  external 'pDirCount@{tmp}\XHashEx.dll stdcall delayload';
function pPickDir(const FindHandle: Longint; const Index: Integer): WideString;
  external 'pPickDir@{tmp}\XHashEx.dll stdcall delayload';

{ Free Memory }
function pFindFree(const FindHandle: Longint): Boolean;
  external 'pFindFree@{tmp}\XHashEx.dll stdcall delayload';
*)


