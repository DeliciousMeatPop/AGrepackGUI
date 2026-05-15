#define ScriptVersion "1.0"

;#define DEBUG_SCRIPT
;#define DEBUG_FONT

;#define pf32
#define OutputDir          /* create setup.exe inside >> */ "COMPRESSOR\Setup_Files"

;#define InternalDLL        /* Putting Setup.dll next to the script will compress the DLL file into the Setup.exe file  */
;#define DSG_PasswordDLL "123"  /* Same password used in DiskSpan_GUI to extract decompressors from Setup.dll files */

;#define DSG_CreateUninstallList

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define public Settings AddbackSlash(SourcePath) + "Settings.ini"
// Settings
#define NameFromIni ReadIni(Settings, "Settings", "Name", "")
#define Name StringChange(NameFromIni, "'", "''")
#define SanatizedName StringChange(StringChange(StringChange(StringChange(StringChange(StringChange(StringChange(NameFromIni, "'", ""), "<", ""), ">", ""), "/", ""), "|", ""), "?", ""), "*", "")
#define FinalSanatizedName StringChange(SanatizedName, ":", " -")
#define BuildVersion ReadIni(Settings, "Settings", "BuildVersion", "")
#define Repacker ReadIni(Settings, "Settings", "Repacker", "")
#define Creator ReadIni(Settings, "Settings", "Creator", "")
#define SizeMB ReadIni(Settings, "Settings", "Size", "")
#define UWPGame YesNo(ReadIni(Settings, "Settings", "UWPGame", ""))
#define ShowLanguageBox YesNo(ReadIni(Settings, "Settings", "ShowLanguageBox", ""))
#define DefaultDir ReadIni(Settings, "Settings", "DefaultInstallDir", "{FinalSanatizedName}")
#define UnInstallFolder ReadIni(Settings, "Settings", "UnInstallFolder", "")
#define CompactMode YesNo(ReadIni(Settings, "Settings", "CompactMode", ""))
#define Savegamefolder ReadIni(Settings, "Settings", "Savegamefolder", "")
#define Win11Warning YesNo(ReadIni(Settings, "Settings", "Win11Warning", ""))
#define RunAppAsAdmin YesNo(ReadIni(Settings, "Settings", "RunAppAsAdmin", ""))

// Update Settings
#define UpdateMode YesNo(ReadIni(Settings, "UpdateSettings", "UpdateMode", ""))
#define ExeCheck ReadIni(Settings, "UpdateSettings", "FileCheck", "")

// Button
#define PlayButtonSound YesNo(ReadIni(Settings, "Button", "PlaySound", ""))

// INISettings
#define INISettings YesNo(ReadIni(Settings, "INISettings", "Enable", ""))
#define INIFile ReadIni(Settings, "INISettings", "INIFile", "")
#define INISection ReadIni(Settings, "INISettings", "Section", "")
#define INIKey ReadIni(Settings, "INISettings", "Key", "")
#define INIValue ReadIni(Settings, "INISettings", "Value", "")

// ComponentsSettings
#define UseComponents YesNo(ReadIni(Settings, "ComponentsSettings", "Enable", "")) && \
  (ReadIni(Settings, "ComponentsSettings", "Component" + Str(1) + ".Name", "") != "") && \
  (ReadIni(Settings, "ComponentsSettings", "Component" + Str(2) + ".Name", "") != "")

// TasksSettings
#define UseTasks YesNo(ReadIni(Settings, "TasksSettings", "Enable", ""))

// Background
#define UseInstallBackground YesNo(ReadIni(Settings, "Background", "Enable", ""))
#define BGAfterInstall YesNo(ReadIni(Settings, "Background", "BGAfterInstall", ""))
#define Duration ReadIni(Settings, "Background", "BackgroundDuration", "")
#define Animation ReadIni(Settings, "Background", "BackgroundAnimation", "")

// SystemRequirement
#define UseSystemReq YesNo(ReadIni(Settings, "SystemRequirement", "Enable", ""))
#define Processor ReadIni(Settings, "SystemRequirement", "Processor", "")
#define VideoRAM ReadIni(Settings, "SystemRequirement", "VideoRAM", "")
#define RAM ReadIni(Settings, "SystemRequirement", "RAM", "")
#define OS ReadIni(Settings, "SystemRequirement", "OS", "")
#define DX ReadIni(Settings, "SystemRequirement", "DirectX", "")
#define HWSectionLabelColor ReadIni(Settings, "SystemRequirement", "HWSectionLabelColor", "")
#define HWOkLabelColor ReadIni(Settings, "SystemRequirement", "HWOkLabelColor", "")
#define HWNotOkLabelColor ReadIni(Settings, "SystemRequirement", "HWNotOkLabelColor", "")
#define HWGoodLabelColor ReadIni(Settings, "SystemRequirement", "HWGoodLabelColor", "")
#define HWPartiallyGoodLabelColor ReadIni(Settings, "SystemRequirement", "HWPartiallyGoodLabelColor", "")
#define HWNotGoodLabelColor ReadIni(Settings, "SystemRequirement", "HWNotGoodLabelColor", "")

// Text
#define WelcomeLabel1Top ReadIni(Settings, "Text", "WelcomeLabel1Top", "")
#define WelcomeLabel2Top ReadIni(Settings, "Text", "WelcomeLabel2Top", "")
#define FinishLabel1Top ReadIni(Settings, "Text", "FinishLabel1Top", "")
#define FinishLabel2Top ReadIni(Settings, "Text", "FinishLabel2Top", "")
#define WelcomeLabel1FontSize ReadIni(Settings, "Text", "WelcomeLabel1FontSize", "")
#define WelcomeLabel2FontSize ReadIni(Settings, "Text", "WelcomeLabel2FontSize", "")
#define FinishLabel1FontSize ReadIni(Settings, "Text", "FinishLabel1FontSize", "")
#define FinishLabel2FontSize ReadIni(Settings, "Text", "FinishLabel2FontSize", "")
#define Font ReadIni(Settings, "Text", "Font", "")
#define FontColor ReadIni(Settings, "Text", "FontColor", "")
#ifdef DEBUG_FONT
  #define FontSize ReadIni(Settings, "Text", "Fontsize", "")
#endif

// CRCCheck
#define CheckCRC YesNo(ReadIni(Settings, "CRCCheck", "Enable", ""))
#define StartCRC YesNo(ReadIni(Settings, "CRCCheck", "StartCheck", ""))
#define HashFile ReadIni(Settings, "CRCCheck", "HashFile", "")
#define DeleteHashFile YesNo(ReadIni(Settings, "CRCCheck", "DeleteHashFile", ""))
// QuickSFV Options
#define UseQuickSFV YesNo(ReadIni(Settings, "CRCCheck", "QuickSFV", ""))
// RapidCRC Options
#define UseRapidCRC YesNo(ReadIni(Settings, "CRCCheck", "RapidCRC", ""))

// Website
#define WebsiteButton YesNo(ReadIni(Settings, "Website", "Enable", ""))
#define WebBtnName ReadIni(Settings, "Website", "WebsiteButtonText", "")
#define URL ReadIni(Settings, "Website", "URL", "")

// Splash
#define Splash YesNo(ReadIni(Settings, "Splash", "Enable", ""))
#define SplashFile ReadIni(Settings, "Splash", "SplashFile", "")
#define SplashFadeIn ReadIni(Settings, "Splash", "SplashFadeIn", "")
#define SplashShow ReadIni(Settings, "Splash", "SplashShow", "")
#define SplashFadeOut ReadIni(Settings, "Splash", "SplashFadeOut", "")

// Music
#define Music YesNo(ReadIni(Settings, "Music", "Enable", ""))
#define MusicFile ReadIni(Settings, "Music", "MusicFile", "")
#define MusicVolume Min(100, Max(0, Int(ReadIni(Settings, "Music", "MusicVolume", ""), 100)))

// License
#define UseLicense YesNo(ReadIni(Settings, "License", "Enable", ""))

// Info Before
#define UseInfo YesNo(ReadIni(Settings, "InfoBefore", "Enable", ""))

// Skin
#define VCL YesNo(ReadIni(Settings, "Skin", "EnableVCL", ""))
#define VCLName ReadIni(Settings, "Skin", "VCLFile", "")
#define Cjstyles YesNo(ReadIni(Settings, "Skin", "EnableCjstyles", "")) && !VCL
#define CjstylesName ReadIni(Settings, "Skin", "CjstylesFile", "")
#define CjstylesParam ReadIni(Settings, "Skin", "CjstylesParam", "")
#define CjstylesParam StringChange(CjstylesParam, "_INI", ".INI")

// Redists
#define UseRedists YesNo(ReadIni(Settings, "Redists", "Enable", ""))

// Batch
#define UseBatch YesNo(ReadIni(Settings, "Batch", "Enable", ""))
#define BatchFileName ReadIni(Settings, "Batch", "BatchFile", "")
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

[Setup]
DirExistsWarning=yes
UsePreviousLanguage=yes
DisableWelcomePage=no
DisableProgramGroupPage=yes
DisableDirPage={#CompactMode ? "yes" : "no"}
DisableFinishedPage={#CompactMode ? "yes" : "no"}
DisableReadyPage={#CompactMode || !UseRedists ? "yes" : "no"}
DisableReadyMemo={#CompactMode ? "yes" : "no"}
ShowLanguageDialog=no
#if UseInfo
  #ifexist "Setup\InfoBefore.txt"
    InfoBeforeFile=Setup\InfoBefore.txt
  #else
    InfoBeforeFile=Setup\InfoBefore.rtf
  #endif
#endif
#if FileExists("Setup\Welcome.bmp")
  WizardImageFile=Setup\Welcome.bmp
#else
  WizardImageFile=Resources\Modules\_WizModernImage.bmp
#endif
#if FileExists ("Setup\Banner.bmp")
  WizardSmallImageFile=Setup\Banner.bmp
#else
  WizardSmallImageFile=Resources\Modules\_WizModernSmallImage.bmp
#endif
#if FileExists(SourcePath + "Setup.ico")
  SetupIconFile=Setup.ico
#else
  SetupIconFile=Resources\Setup.ico
#endif
AppName={#Name}
AppVersion={#BuildVersion}
AppPublisherURL=https://t.me/ARMGDDNGames
AppPublisher=AG Repacks
VersionInfoCompany=AG Repacks
VersionInfoProductVersion={#Copy(ScriptVersion, 1, RPos('.', ScriptVersion) + 1)}
VersionInfoVersion={#Copy(ScriptVersion, 1, RPos('.', ScriptVersion) + 1)}
#if VER >= 0x06000000
  WizardStyle=classic
  WizardResizable=no
  WizardSizePercent=100
  UsedUserAreasWarning=no
  UsePreviousPrivileges=no
  #ifdef pf32
    #define DefaultDir StringChange(StringChange(DefaultDir, "{pf}", "{commonpf32}"), "{commonpf}", "{commonpf32}")
  #else
    #define DefaultDir StringChange(StringChange(DefaultDir, "{pf}", "{commonpf64}"), "{commonpf}", "{commonpf64}")
  #endif
#else
  #ifdef pf32
    #define DefaultDir StringChange(DefaultDir StringChange(DefaultDir, "{pf}", "{pf32}"), "{commonpf}", "{pf32}")
  #else
    #define DefaultDir StringChange(DefaultDir StringChange(DefaultDir, "{pf}", "{pf64}"), "{commonpf}", "{pf64}")
  #endif
#endif
#if CompactMode && UpdateMode
  AppendDefaultDirName=no
  UsePreviousAppDir=yes
  DefaultDirName={src}
  Uninstallable=yes
  CreateUninstallRegKey=no
#else
  UsePreviousGroup=no
  UsePreviousAppDir=no
  DefaultGroupName={#FinalSanatizedName}
  AppendDefaultDirName=yes
  DefaultDirName={#DefaultDir}\{#FinalSanatizedName}
  UninstallFilesDir={app}\{#UnInstallFolder}
  UninstallDisplayIcon={app}\icon.ico
  Uninstallable=IsUninstallable
  CreateUninstallRegKey=IsUninstallable
#endif
#if !defined(OutputDir)
  #define OutputDir "."
#elif !DirExists(OutputDir)
  #define OutputDir "."
#endif
OutputDir={#OutputDir}
OutputBaseFilename=AGRepackInstaller
Compression=lzma2/ultra
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64
ArchitecturesAllowed=x64
#if defined(IS_ENHANCED) || !defined(UNICODE)   /* Don't delete these lines */
  #error "Standard Edition" of Inno Setup "UNICODE" from (JRSoftware) is required to compile this script
#endif

[Files]
#define public i 0
#define public y 0
//////////////// FreeArc/ISDone Files //////////////////////////////////////////
Source: "Resources\DSG\SplitLib.dll"; DestDir: "COMPRESSORS"; Flags: dontcopy
Source: "Resources\DSG\UnArc.dll"; DestDir: "COMPRESSORS"; Flags: dontcopy
Source: "Resources\DSG\ISDone.dll"; DestDir: "COMPRESSORS"; Flags: dontcopy
Source: "Resources\DSG\English.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy
Source: "Resources\DSG\French.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "Resources\DSG\German.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "Resources\DSG\Italian.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "Resources\DSG\Spanish.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "Resources\DSG\Polish.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "Resources\DSG\Russian.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "Resources\DSG\PortugueseBrazil.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
Source: "Resources\DSG\Czech.ini"; DestDir: "COMPRESSORS"; Flags: dontcopy;
#ifdef InternalDLL
  #if FileExists(AddBackslash(SourcePath) + ChangeFileExt(ExtractFileName(SetupSetting("OutputBaseFilename")), "dll"))
  Source: "{#AddBackslash(SourcePath) + ChangeFileExt(ExtractFileName(SetupSetting("OutputBaseFilename")), "dll")}"; DestDir: "DECOMPRESSORS"; Flags: dontcopy
  #else
    #undef InternalDLL
  #endif
#endif
#define public IconFile ExtractFileName(Trim(ReadIni(AddBackslash(ExtractFilePath(SetupSetting("OutputDir"))) + "Resources\DSG_Settings.ini", "CommonSettings", "Icon", "Setup.ico")))
#if FileExists(AddBackslash(SourcePath) + SetupSetting("SetupIconFile")) && (LowerCase(ExtractFileExt(IconFile)) == "ico")
  #if !DirExists(SetupSetting("OutputDir"))
    #expr ForceDirectories(SetupSetting("OutputDir"))
  #endif
  #if FileExists(AddBackslash(SourcePath) + SetupSetting("SetupIconFile"))
    #expr CopyFile(AddBackslash(SourcePath) + SetupSetting("SetupIconFile"), AddBackslash(SetupSetting("OutputDir")) + IconFile)
  #endif
#endif
//////////////// Modules ///////////////////////////////////////////////////////
Source: "Settings.ini"; DestDir: "{tmp}"; Flags: dontcopy;
Source: "Resources\Modules\FolderImage.bmp"; DestDir: "{tmp}"; Flags: dontcopy;
Source: "Resources\Modules\DiskSpaceImage.bmp"; DestDir: "{tmp}"; Flags: dontcopy;
Source: "Resources\Modules\InfoBeforeImage.bmp"; DestDir: "{tmp}"; Flags: dontcopy;
Source: "Resources\Logo.bmp"; DestDir: "{tmp}"; Flags: dontcopy;
////////////////////////////////////////////////////////////////////////////////
{#if PlayButtonSound}Source: "Setup\Button.wav"; DestDir: "{tmp}"; Flags: dontcopy;{#endif}
#if Splash
  Source: "Resources\Modules\Splash\ISGsg.dll"; DestDir: "{tmp}"; Flags: dontcopy;
  Source: "Setup\{#SplashFile}"; DestDir: "{tmp}"; Flags: dontcopy;
#endif

#if Music
  Source: "Resources\Modules\Music\BASS.dll"; DestDir: "{tmp}"; Flags: dontcopy;
  Source: "Setup\{#MusicFile}"; DestDir: "{tmp}"; Flags: dontcopy nocompression;
#endif

#if !CompactMode
  {#if UseComponents}Source: "Resources\Modules\Components\SelectComponentsImage.bmp"; DestDir: "{tmp}"; Flags: dontcopy;{#endif}
  {#if UseTasks}Source: "Resources\Modules\Tasks\SelectTasksImage.bmp"; DestDir: "{tmp}"; Flags: dontcopy;{#endif}
  {#if UseLicense}Source: "Resources\Modules\License\LicenseImage.bmp"; DestDir: "{tmp}"; Flags: dontcopy;{#endif}
  {#if UseRedists}Source: "Resources\Modules\Redist\SelectRedistsImage.bmp"; DestDir: "{tmp}"; Flags: dontcopy;{#endif}
  {#if UWPGame}Source: "Resources\UWP\UWP_Tool.exe"; DestDir: "{tmp}"; Flags: dontcopy;{#endif}

  #if UseSystemReq
    Source: "Resources\Modules\SystemReq\ISSysInfo.dll"; DestDir: "{tmp}"; Flags: dontcopy;
    Source: "Resources\Modules\SystemReq\SysInfo.dll"; DestDir: "{tmp}"; Flags: dontcopy;
    Source: "Resources\Modules\SystemReq\SystemReqImage.bmp"; DestDir: "{tmp}"; Flags: dontcopy;
  #endif

  #if UseInstallBackground
    Source: "Resources\Modules\InstallBG\IsSlideShow.dll"; DestDir: "{tmp}"; Flags: dontcopy
    #sub AddFile2
      Source: "Setup\Background\{#i}.jpg"; DestDir: "{tmp}"; Flags: dontcopy
    #endsub
    #for {i = 1; FileExists("Setup\Background\" + Str(i) + ".jpg" ) != 0; i++} AddFile2
  #endif

  {#ifexist "Setup\Font.ttf"}Source: "Setup\Font.ttf"; DestDir: "{tmp}"; Flags: dontcopy;{#endif}

  #if FileExists("Setup\Finish.bmp")
    Source: "Setup\Finish.bmp"; DestDir: "{tmp}"; Flags: dontcopy;
  #else
    Source: "Resources\Modules\_WizModernImage.bmp"; DestDir: "{tmp}"; Flags: dontcopy;
  #endif
  #if FileExists("Setup\Banner.bmp")
    Source: "Setup\Banner.bmp"; DestDir: "{tmp}"; Flags: dontcopy;
  #else
    Source: "Resources\Modules\_WizModernSmallImage.bmp"; DestDir: "{tmp}"; Flags: dontcopy;
    #endif
#endif

#if CheckCRC
  #if UseQuickSFV || UseRapidCRC
    Source: "Setup\{#HashFile}"; DestDir: "{tmp}"; Flags: dontcopy;
    {#if UseQuickSFV}Source: "Resources\Modules\CRC\QuickSFV.exe"; DestDir: "{tmp}"; Flags: dontcopy;{#endif}
    {#if UseRapidCRC}Source: "Resources\Modules\CRC\RapidCRC.exe"; DestDir: "{tmp}"; Flags: dontcopy;{#endif}
  #else
    Source: "Resources\Modules\CRC\XHashEx.dll"; DestDir: "{tmp}"; Flags: dontcopy;
    Source: "Resources\Modules\CRC\HashCheck.bmp"; DestDir: "{tmp}"; Flags: dontcopy;
  #endif
#endif

#if VCL
  Source: "Resources\Modules\Style\VclStylesinno.dll"; DestDir: "{tmp}"; Flags: dontcopy;
  Source: "Setup\{#VCLName}"; DestDir: "{tmp}"; Flags: dontcopy;
#elif Cjstyles
  Source: "Resources\Modules\Style\ISSkin.dll"; DestDir: "{tmp}"; Flags: dontcopy;
  Source: "Setup\{#CjstylesName}"; DestDir: "{tmp}"; Flags: dontcopy;
#endif

#if UseBatch
  Source: "Setup\{#BatchFileName}"; DestDir: "{tmp}"; Flags: dontcopy;
#endif
////////////////////////////////////////////////////////////////////////////////

#if RunAppAsAdmin
  #include "Registry.iss"
#endif

#include "Resources\DSG\DSG_Module.iss"

#if !CompactMode && UseSystemReq
  #include "Resources\Modules\SystemReq\ISSysInfo.iss"
#endif

#if CheckCRC && !UseQuickSFV && !UseRapidCRC
  #include "Resources\Modules\CRC\XHashEx.iss"
#endif

[Icons]
#if !UpdateMode
  #if !CompactMode
    Name: "{group}\{cm:UninstallProgram,{code:AppName}}"; Filename: "{uninstallexe}"; Check: CreateIconsStartMenu;
  #endif
  #sub AddShortcut
    #emit "Name: ""{userdesktop}\" + Trim(ReadIni(Settings, "Executable" + Str(i), "ShortcutName", "")) + """; " + \
        "FileName: ""{app}\" + Trim(ReadIni(Settings, "Executable" + Str(i), "Exe", "")) + """; " + \
        "WorkingDir: """ + ExtractFileDir("{app}\" + Trim(ReadIni(Settings, "Executable" + Str(i), "Exe", ""))) + """; " + \
        "Parameters: """ + Trim(ReadIni(Settings, "Executable" + Str(i), "ExeParam", "")) + """; " + \
        "IconFilename: """ + Trim(ReadIni(Settings, "Executable" + Str(i), "IconFilename", "")) + """; " + \
        "Check: CreateIconsDesktop and IsComponentChecked(" + Str(Int(Trim(ReadIni(Settings, "Executable" + Str(i), "Component", "")), 0)) + ");"
    #if !CompactMode
    #emit "Name: ""{group}\" + Trim(ReadIni(Settings, "Executable" + Str(i), "ShortcutName", "")) + """; " + \
        "FileName: ""{app}\" + Trim(ReadIni(Settings, "Executable" + Str(i), "Exe", "")) + """; " + \
        "WorkingDir: """ + ExtractFileDir("{app}\" + Trim(ReadIni(Settings, "Executable" + Str(i), "Exe", ""))) + """; " + \
        "Parameters: """ + Trim(ReadIni(Settings, "Executable" + Str(i), "ExeParam", "")) + """; " + \
        "IconFileName: """ + Trim(ReadIni(Settings, "Executable" + Str(i), "IconFileName", "")) + """; " + \
        "Check: CreateIconsStartMenu and IsComponentChecked(" + Str(Int(Trim(ReadIni(Settings, "Executable" + Str(i), "Component", "")), 0)) + ");"
    #endif
  #endsub
  #for {i = 1; Trim(ReadIni(Settings, "Executable" + Str(i), "ShortcutName", "")) != ""; i++} AddShortcut
#endif

[Code]
const
  #ifdef DEBUG_FONT
    FONT_HEIGHT = '{#Fontsize}';
  #endif
  DI_NORMAL = 3;
  FR_PRIVATE = $10;
  BASS_ACTIVE_STOPPED = 0;
  BASS_ACTIVE_PLAYING = 1;
  BASS_ACTIVE_STALLED = 2;
  BASS_ACTIVE_PAUSED = 3;
  BASS_SAMPLE_LOOP = 4;
  BASS_ATTRIB_VOL = 2;
  BASS_UNICODE = $80000000;
  {#if PlayButtonSound}SND_ASYNC = $00000001;{#endif}

  // WizardForm Animation
  AW_ACTIVATE = $00020000;
  AW_BLEND = $00080000;
  AW_CENTER = $00000010;
  AW_HIDE = $00010000;
  AW_HOR_POSITIVE = $00000001;
  AW_HOR_NEGATIVE = $00000002;
  AW_SLIDE = $00040000;
  AW_VER_POSITIVE = $00000004;
  AW_VER_NEGATIVE = $00000008;
  AW_FADE_IN = $00080000;
  AW_FADE_OUT = $00090000;
  AW_SLIDE_IN_LEFT = $00040001;
  AW_SLIDE_OUT_LEFT = $00050002;
  AW_SLIDE_IN_RIGHT = $00040002;
  AW_SLIDE_OUT_RIGHT = $00050001;
  AW_SLIDE_IN_TOP = $00040004;
  AW_SLIDE_OUT_TOP = $00050008;
  AW_SLIDE_IN_BOTTOM = $00040008;
  AW_SLIDE_OUT_BOTTOM = $00050004;
  AW_DIAG_SLIDE_IN_TOPLEFT = $00040005;
  AW_DIAG_SLIDE_OUT_TOPLEFT = $0005000A;
  AW_DIAG_SLIDE_IN_TOPRIGHT = $00040006;
  AW_DIAG_SLIDE_OUT_TOPRIGHT = $00050009;
  AW_DIAG_SLIDE_IN_BOTTOMLEFT = $00040009;
  AW_DIAG_SLIDE_OUT_BOTTOMLEFT = $00050006;
  AW_DIAG_SLIDE_IN_BOTTOMRIGHT = $0004000A;
  AW_DIAG_SLIDE_OUT_BOTTOMRIGHT = $00050005;
  AW_EXPLODE = $00040010;
  AW_IMPLODE = $00050010;

type
  TPBProc = function(h: HWND; uMsg, wParam, lParam: Longint): Longint;
  #if VER < 0x06000000
    TTimerProc = procedure(hWnd, uMsg, idEvent, dwTime: LongWord);
    TFreeArcCallback = function(What: PAnsiChar; Int1, Int2: Integer; Str: PAnsiChar): Integer;
  #endif
  {#if Music}HSTREAM = DWORD;{#endif}

var
  //////////////////////// Check boxes ////////////////////////
  {#if !CompactMode}StartMenuCB, {#endif}{#if CheckCRC}HashCheckCB, {#endif}{#if !CompactMode || !UpdateMode}UninstallCB, {#endif}LimitRAMCB: TNewCheckBox;

  ////////////////////////// Buttons //////////////////////////
  {#if Music}MusicButton,{#endif} PauseButton: TNewButton;
  
  /////////////////////////// Label ///////////////////////////
  {#if !CompactMode}WillkommenLabel1, WillkommenLabel2, FertigLabel1, FertigLabel2, {#endif}FreeSpaceLabel, NeedSpaceLabel: TLabel;

  /////////////////////////// Timer ///////////////////////////
  PercentLabel, ElapsedLabel, RemainingLabel: TNewStaticText;

  //////////////////////// Components /////////////////////////
  #if UseComponents
    ComponentsSize: Extended;
    ComponentsList: TNewCheckListBox;
    SelectComponentsLabel, ComponentsDiskSpaceLabel: TNewStaticText;
    #if CompactMode
      ComponentsPageVisible, ComponentsDiskSpaceLabelVisible: Boolean;
      ComponentsOKButton: TNewButton;
    #else
      ComponentsPage: TWizardPage;
      SelectComponentsImage: TBitmapImage;
    #endif
  #endif

  #if UseTasks
    TasksSize: Extended;
    TasksList: TNewCheckListBox;
    SelectTasksLabel, TasksDiskSpaceLabel: TNewStaticText;
    #if CompactMode
      TasksPageVisible, TasksDiskSpaceLabelVisible: Boolean;
      TasksOKButton: TNewButton;
    #else
      TasksPage: TWizardPage;
      SelectTasksImage: TBitmapImage;
    #endif
  #endif

  ///////////////////////// CRC Check /////////////////////////
  #if CheckCRC && !UseQuickSFV && !UseRapidCRC
    {#if !CompactMode}HashImage: TBitmapImage;{#endif}
    HashPage: TWizardPage;
    HashInfoMemo: TNewMemo;
    HashLogMemo: TNewMemo;
    HashProgressGauge: TNewProgressBar;
    HashStatusLabel: TNewStaticText;
    HashResultLabel: TNewStaticText;
    //HashPercentLabel: TNewStaticText;
    HashNextButton: TNewButton;
    HashBackButton: TNewButton;
    HashCancelButton: TNewButton;
    HashHdrLabel: TNewStatictext;
    HashFileLabel: TNewStatictext;
    HashProgressBar: TNewProgressBar;
  #endif

  /////////////////////////// Others //////////////////////////
  FreeMB, TotalMB: Cardinal;
  StartTick: DWORD;
  ResultCode: Integer;
  StatusPaused: Boolean;
  InstallationSize: Extended;
  NeedSizeFreeSizeBevel: TBevel;
  {#if Music}SoundStream: HSTREAM;{#endif}

  #if CompactMode
    {#if UseInfo}InfoButtonCM,{#endif}AboutButtonCM: TNewButton;
    {#if UseRedists}RedistCB: TNewCheckBox;{#endif}
  #else
    {#if UseInfo}InfoBeforeImage,{#endif}
    {#if UseRedists}SelectRedistsImage,{#endif}
    {#if UseLicense}LicenseImage,{#endif}
    {#if !CompactMode}FolderImage, DiskSpaceImage, BannerImage: TBitmapImage;{#endif}
    {#if WebsiteButton}WebsiteButton,{#endif}AboutButton: TNewButton;
    {#if UseInfo}InfoBeforeMemo: TNewMemo;{#endif}
    {#if UseLicense}LicenseMemo: TNewMemo;{#endif}
    {#if UseRedists}RedistsList: TNewCheckListBox;{#endif}
    #if UseSystemReq
      SystemReqPage: TWizardPage;
      SystemReqImage: TBitmapImage;
      Case1: TPanel;
      SysReqCheckLabel, IfReadyLabel, HardwareDetectLabel: TNewStaticText;
      SystemLabel, SystemNameLabel, CPUGHZLabel, GPUGHZLabel, HwLabel, CPULabel, CPUNameLabel, GPULabel, GPUNameLabel, DirectXLabel, DirectXVersionLabel, RAMLabel, TotalRAMLabel: TLabel;
      ProcessorBevel, VideoCardBevel, DirectXBevel, RAMBevel, SystemBevel, ProcessorNameBevel, VideoCardNameBevel,  DirectXVersionBevel, RAMTotalBevel, SystemNameBevel, CPUMHZBevel, GPUMHZBevel: TBevel;
      Processor, VideoRam, Ram, OpSystem, DirectX, DX, OSNumber: Integer;
    #endif
    #if UseInstallBackground
      BackgroundForm: TForm;
      BackgroundButton: TNewButton;
      BackgroundCB: TNewCheckBox;
      SlideTimerID: LongWord;
      CurrPic: Integer;
    #endif
  #endif

#if VCL
  procedure LoadVCLStyle(VClStyleFile: String); external 'LoadVCLStyleW@{tmp}\VclStylesInno.dll stdcall delayload';
  procedure UnLoadVCLStyles; external 'UnLoadVCLStyles@{tmp}\VclStylesInno.dll stdcall delayload';
#elif Cjstyles
  procedure LoadSkin(lpszPath: String; lpszIniFileName: String); external 'LoadSkin@{tmp}\ISSkin.dll stdcall delayload';
  procedure UnloadSkin(); external 'UnloadSkin@{tmp}\ISSkin.dll stdcall delayload';
  function ShowWindow(hWnd: Integer; uType: Integer): Integer; external 'ShowWindow@user32.dll stdcall';
#endif
#if Splash
  procedure ShowSplashScreen(p1: HWND; p2: AnsiString; p3, p4, p5, p6, p7: Integer; p8: Boolean; p9: Cardinal; p10: Integer); external 'ShowSplashScreen@files:isgsg.dll stdcall delayload';
#endif
#if Music
  function BASS_Init(Device: Integer; Freq, Flags: DWORD; Win: HWND; CLSID: Integer): BOOL; external 'BASS_Init@{tmp}\BASS.dll stdcall delayload';
  function BASS_StreamCreateFile(Mem: BOOL; FileName: {PAnsiChar}String; Offset1: DWORD; Offset2: DWORD; Length1: DWORD; Length2: DWORD; Flags: DWORD): HSTREAM; external 'BASS_StreamCreateFile@{tmp}\BASS.dll stdcall delayload';
  function BASS_StreamFree(Handle: HSTREAM): BOOL; external 'BASS_StreamFree@{tmp}\BASS.dll stdcall delayload';
  function BASS_SetConfig(Option: DWORD; Value: DWORD): BOOL; external 'BASS_SetConfig@{tmp}\BASS.dll stdcall delayload';
  function BASS_Start: BOOL; external 'BASS_Start@{tmp}\BASS.dll stdcall delayload';
  function BASS_Pause: BOOL; external 'BASS_Pause@{tmp}\BASS.dll stdcall delayload';
  function BASS_Stop: BOOL; external 'BASS_Stop@{tmp}\BASS.dll stdcall delayload';
  function BASS_Free: BOOL; external 'BASS_Free@{tmp}\BASS.dll stdcall delayload';
  function BASS_ChannelSetAttribute(Handle, Attrib: DWORD; Value: Single): BOOL; external 'BASS_ChannelSetAttribute@{tmp}\BASS.dll stdcall delayload';
  function BASS_ChannelPlay(Handle: DWORD; Restart: BOOL): BOOL; external 'BASS_ChannelPlay@{tmp}\BASS.dll stdcall delayload';
  function BASS_ChannelStop(Handle: DWORD): BOOL; external 'BASS_ChannelStop@{tmp}\BASS.dll stdcall delayload';
  function BASS_ChannelPause(Handle: DWORD): BOOL; external 'BASS_ChannelPause@{tmp}\BASS.dll stdcall delayload';
  function BASS_ChannelIsActive(Handle: DWORD): DWORD; external 'BASS_ChannelIsActive@{tmp}\BASS.dll stdcall delayload';
  function BASS_ChannelFree(Handle: DWORD): BOOL; external 'BASS_ChannelFree@{tmp}\BASS.dll stdcall delayload';
  function BASS_Vol(Vol: Integer): Double;
  begin
    Result := Double(Vol) / 100;
  end;
#endif
{#if PlayButtonSound}function sndPlaySound(lpszSoundName: String; uFlags: UINT): BOOL; external 'sndPlaySoundW@winmm.dll stdcall delayload';{#endif}

const
  MB_ICONERROR       = $10;
  MB_ICONQUESTION    = $20;
  MB_ICONWARNING     = $30;
  MB_ICONINFORMATION = $40;
  MB_APPLMODAL       = $00000000;
  MB_SYSTEMMODAL     = $00001000;
  MB_TASKMODAL       = $00002000;

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

function MessageBox(hWnd: HWND; lpText, lpCaption: String; uType: UINT): Integer; external 'MessageBoxW@user32.dll stdcall delayload';
function ShellExecute(hWnd: HWND; lpOperation: String; lpFile: String; lpParameters: String; lpDirectory: String; nShowCmd: Integer): THandle;  external 'ShellExecuteW@shell32.dll stdcall delayload';
function ExtractIcon(hInst: Longint; lpszExeFileName: String; nIconIndex: UINT): Longint; external 'ExtractIconW@shell32.dll stdcall delayload';
function DrawIconEx(hdc: Longint; xLeft, yTop: Integer; hIcon: Longint; cxWidth, cyWidth: Integer; istepIfAniCur: Longint; hbrFlickerFreeDraw, diFlags: Longint): Longint;  external 'DrawIconEx@user32.dll stdcall delayload';
function DestroyIcon(hIcon: Longint): Longint; external 'DestroyIcon@user32.dll stdcall delayload';
function GetModuleHandle(lpModuleName: String): THandle; external 'GetModuleHandleW@kernel32.dll stdcall delayload';
function AddFontResource(lpszFilename: String; fl, pdv: DWORD): Integer; external 'AddFontResourceExW@gdi32.dll stdcall delayload';
function RemoveFontResource(lpFileName: String; fl, pdv: DWORD): BOOL; external 'RemoveFontResourceExW@gdi32.dll stdcall delayload';
function GetTickCount: DWORD; external 'GetTickCount@kernel32.dll stdcall delayload';
function CallWindowProc(lpPrevWndFunc: Longint; hWnd: HWND; Msg: UINT; wParam, lParam: Longint): Longint; external 'CallWindowProcW@user32.dll stdcall delayload';
function GetWindowLong(hWnd: HWND; nIndex: Integer): Longint; external 'GetWindowLongW@user32.dll stdcall delayload';
function SetWindowLong(hWnd: HWND; nIndex: Integer; dwNewLong: Longint): Longint; external 'SetWindowLongW@user32.dll stdcall delayload';
function FreeLibrary(hModule: THandle): BOOL; external 'FreeLibrary@kernel32.dll stdcall delayload';
procedure ExitProcess(ExitCode: Integer); external 'ExitProcess@kernel32.dll stdcall delayload';
function AnimateWindow(hWnd: HWND; dwTime: DWord; dwFlags: DWord): Boolean; external 'AnimateWindow@user32 stdcall';

function ExePath(Default: String): String;
var
  I: Integer;
begin
  I := 1;
  Result := GetIniString('Executable' + IntToStr(I), 'Exe', '', ExpandConstant('{tmp}\Settings.ini'));
end;

function AppName(Default: String): String;
begin
  Result := GetIniString('Settings', 'Name', '', ExpandConstant('{tmp}\Settings.ini'));
end;

function AppNameOverride(MsgID: TSetupMessageID): String;
begin
  Result := SetupMessage(MsgID);
  StringChangeEx(Result, '[name]', AppName(''), True);
  StringChangeEx(Result, '[name/ver]', AppName(''), True);
  Result := Result;
end;

function CreateUninstallerMessage(Default:String): String;
begin
  Result := ExpandConstant('{cm:CreateUninstall}');
end;

function IniKeyNotEmpty(Section, Key: String): Boolean;
begin
  Result := GetIniString(Section, Key, '', ExpandConstant('{tmp}\Settings.ini')) <> '';
end;

function CreateLangDialog(): Boolean;
var
  I: Integer;
  TmpStr: String;
  Params: String;
  Instance: THandle;
  SL1, SL2: TStringList;
  LangList: TStringList;
  LangIcon: Longint;
  LangRect: TRect;
  LangDialogForm: TSetupForm;
  LangDialogLabel: TNewStaticText;
  LangDialogComboBox: TNewComboBox;
  LangDialogOKButton: TNewButton;
  LangDialogCancelButton: TNewButton;
begin
  SL1 := TStringList.Create;                           { Values from LanguageName= key, [LangOptions] section in external language file }
  SL1.Add('English');                                  //'English'
  SL1.Add('Fran'#$00E7'ais');                          //'Fran<00E7>ais'
  SL1.Add('Deutsch');                                  //'Deutsch'
  SL1.Add('Italiano');                                 //'Italiano'
  SL1.Add('Espa'#$00F1'ol');                           //'Espa<00F1>ol'
  SL1.Add('Polski');                                   //'Polski'
  SL1.Add(#$0420#$0443#$0441#$0441#$043A#$0438#$0439); //'<0420><0443><0441><0441><043A><0438><0439>'
  SL1.Add('Portugu'#$00EA's Brasileiro');              //'Portugu<00EA>s Brasileiro'
  SL1.Add(#$010C'e'#$0161'tina');                      //'<010C>e<0161>tina'
  SL1.Add('Українська');
  
  SL2 := TStringList.Create;                           {Values from section [Languages] Name: in script}
  SL2.Add('English');
  SL2.Add('French');
  SL2.Add('German');
  SL2.Add('Italian');
  SL2.Add('Spanish');
  SL2.Add('Polish');
  SL2.Add('Russian');
  SL2.Add('PortugueseBrazil');
  SL2.Add('Czech');
  SL2.Add('Ukrainian');

  LangDialogForm := CreateCustomForm();
  try
    with LangDialogForm do
    begin
      ClientWidth  := ScaleX(297);
      ClientHeight := ScaleY(125);
      Position     := poScreenCenter;
      Caption      := SetupMessage(msgSelectLanguageTitle);
      Color        := clBtnFace;
      BorderIcons  := [biSystemMenu];
      ActiveControl := LangDialogOKButton;
    end;

    LangDialogLabel := TNewStaticText.Create(LangDialogForm);
    with LangDialogLabel do
    begin
      Parent   := LangDialogForm;
      Left     := ScaleX(56);
      Top      := ScaleY(8);
      Width    := ScaleX(233);
      Height   := ScaleY(39);
      AutoSize := False;
      WordWrap := True;
      Caption  := SetupMessage(msgSelectLanguageLabel);
    end;

    LangDialogComboBox := TNewComboBox.Create(LangDialogForm);
    with LangDialogComboBox do
    begin
      Left     := ScaleX(56);
      Top      := ScaleY(56);
      Width    := ScaleX(233);
      Height   := ScaleY(21);
      Parent   := LangDialogForm;
      Style    := csDropDownList;
      DropDownCount := 16;
      Sorted   := True;
      Items.AddStrings(SL1);
      ItemIndex := 0;
      LangList  := TStringList.Create;
      for I := 0 to SL2.Count - 1 do
      begin
        LangList.Append(SL2.Strings[SL1.IndexOf(LangDialogComboBox.Items.Strings[I])]);
      end;
      ItemIndex := LangList.IndexOf(ActiveLanguage);
    end;

    LangDialogOKButton := TNewButton.Create(LangDialogForm);
    with LangDialogOKButton do
    begin
      Parent   := LangDialogForm;
      Left     := ScaleX(133);
      Top      := ScaleY(93);
      Width    := ScaleX(75);
      Height   := ScaleY(23);
      Caption  := SetupMessage(msgButtonOK);
      ModalResult := mrOk;
      Default := True;
    end;

    LangDialogCancelButton := TNewButton.Create(LangDialogForm);
    with LangDialogCancelButton do
    begin
      Parent   := LangDialogForm;
      Left     := ScaleX(214);
      Top      := ScaleY(93);
      Width    := ScaleX(75);
      Height   := ScaleY(23);
      Caption  := SetupMessage(msgButtonCancel);
      ModalResult := mrCancel;
    end;

    try
      LangRect.Left   := ScaleX(0);
      LangRect.Top    := ScaleY(0);
      LangRect.Right  := ScaleX(32);
      LangRect.Bottom := ScaleY(32);
      LangIcon := ExtractIcon(GetModuleHandle(''), ExpandConstant('{srcexe}'), 0);
      try
        with TBitmapImage.Create(LangDialogForm) do
        begin
          Parent   := LangDialogForm;
          Left     := ScaleX(10);
          Top      := ScaleY(10);
          Width    := ScaleX(32);
          Height   := ScaleY(32);
          with Bitmap do
          begin
            Width := LangRect.Bottom;
            Height := LangRect.Right;
            Canvas.Brush.Color := LangDialogForm.Color;
            Canvas.FillRect(LangRect);
            DrawIconEx(Canvas.Handle, 0, 0, LangIcon, LangRect.Bottom, LangRect.Right, 0, 0, DI_NORMAL);
          end;
        end;
      finally
        DestroyIcon(LangIcon);
      end;
    except
    end;
    if LangDialogForm.ShowModal = mrOk then
    begin
      for I := 1 to ParamCount do
      begin
        TmpStr := ParamStr(I);
        if CompareText(Copy(TmpStr, 1, 5), '/LOG=') = 0 then
          TmpStr := TmpStr + '-localized';
        if CompareText(Copy(TmpStr, 1, 5), '/SL5=') <> 0 then
          Params := Params + AddQuotes(TmpStr) + ' ';
      end;
      Params := Params + '/LANG=' + LangList[LangDialogComboBox.ItemIndex];
      Instance := ShellExecute(0, '', ExpandConstant('{srcexe}'), Params, '', SW_SHOW);
      if Instance <= 32 then
        MsgBox(Format('Running installer with selected language failed. Code: %d', [Instance]), mbError, MB_OK);
    end;
  finally
    LangDialogForm.Free;
    Result := False;
  end;
end;

function GetTextWidth(aText: String; aFont: TFont): Integer;
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

function IfThen(AValue: Boolean; const ATrue, AFalse: Variant): Variant;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
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


function FormatBytes(const Bytes: Extended; Offset: Integer; HideZero: Boolean): String;
var
  Idx: Byte;
  Amount: Extended;
  Dms: TArrayOfString;
begin
  Dms := ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
  Amount := Bytes;
  Idx := 0;
  while Amount > (0.9 * KFactor) do
  begin
    Idx := Idx + 1;
    Amount := Amount / KFactor;
  end;
  if Idx = 0 then
    Result := Format('%.0f %s', [Amount, Dms[Idx]])
  else
    Result := Format('%.' + IntToStr(Offset) + 'f %s', [Amount, Dms[Idx]]);
  if Result = '0 B' then
  begin
    if HideZero then
      Result := ''
    else
      Result := '0 Byte';
  end;
end;


function FormatDiskSpaceLabel(Labl: String; Size: Extended): String;
begin
  Result := Labl;
  StringChangeEx(Result, '[mb] MBs', '[size]', True);
  StringChangeEx(Result, '[mb] Мб', '[size]', True);
  StringChangeEx(Result, '[mb] Mo', '[size]', True);
  StringChangeEx(Result, '[mb] MB', '[size]', True);
  StringChangeEx(Result, '[size]', FormatBytes(Size, 2, False), True);
end;


function NumToStr(Float: Extended): string;
begin
  Result := Format('%.2n', [Float]);
  StringChange(Result, ',', '.');
  while ((Result[Length(Result)] = '0') or (Result[Length(Result)] = '.')) and (Pos('.', Result) > 0) do
    SetLength(Result, Length(Result)-1);
end;


function MbOrTb(Float: Extended): String;
begin
  if Float < KFactor then
    Result := NumToStr(Float) + ' MB'
  else
    if Float/KFactor < KFactor then
      Result := NumToStr(Float / KFactor) + ' GB'
    else
      Result := NumToStr(Float / (KFactor * KFactor)) + ' TB'
end;


procedure GetFreeSpaceCaption(Sender: TObject);
var
  I: Integer;
  IsEnabled: Boolean;
begin
  I := 0;
  #if UseComponents
    ComponentsSize := 0;
    for I := 0 to ComponentsList.Items.Count - 1 do
      if ComponentsList.Checked[I] then
        ComponentsSize := ComponentsSize + GetSizeBytes(GetIniString('ComponentsSettings', 'Component' + IntToStr(I + 1) + '.Size', '0', ExpandConstant('{tmp}\Settings.ini')), 0);
  #endif
  #if UseTasks
    TasksSize := 0;
    for I := 0 to TasksList.Items.Count - 1 do
      if TasksList.Checked[I] then
        TasksSize := TasksSize + GetSizeBytes(GetIniString('TasksSettings', 'Task' + IntToStr(I + 1) + '.Size', '0', ExpandConstant('{tmp}\Settings.ini')), 0);
  #endif
  #if UseComponents
    InstallationSize := ComponentsSize{#if UseTasks} + TasksSize{#endif};
  #else
    InstallationSize := {#if UseTasks}TasksSize + {#endif}GetSizeBytes(GetIniString('Settings', 'Size', '0', ExpandConstant('{tmp}\Settings.ini')), 0);
  #endif
  GetSpaceOnDisk(ExtractFileDrive(WizardForm.DirEdit.Text), True, FreeMB, TotalMB);
  #if CompactMode
    FreeSpaceLabel.Caption := ' Free: ' + MbOrTb(FreeMB) + ' (' + IntToStr((FreeMB * 100) div TotalMB) + '%)';
    NeedSpaceLabel.Caption := 'Req: ' + FormatBytes(InstallationSize, 2, True);
  #else
    FreeSpaceLabel.Caption := ExpandConstant('{cm:FreeSpace}  ') + MbOrTb(FreeMB) + ' (' + IntToStr((FreeMB * 100) div TotalMB) + '%)';
    NeedSpaceLabel.Caption := ExpandConstant('{cm:NeedSpace}  ') + FormatBytes(InstallationSize, 2, True);
  #endif
  IsEnabled := Extended(FreeMB) >= Extended(InstallationSize / PowerK(1, POWER_MB));
  FreeSpaceLabel.Font.Color := IfThen(IsEnabled, NeedSpaceLabel.Font.Color, clRed);
  {#if UseTasks}TasksDiskSpaceLabel.Caption := FormatDiskSpaceLabel(SetupMessage(msgComponentsDiskSpaceMBLabel), InstallationSize);{#endif}
  {#if UseComponents}ComponentsDiskSpaceLabel.Caption := FormatDiskSpaceLabel(SetupMessage(msgComponentsDiskSpaceMBLabel), InstallationSize);{#endif}
  {#if CompactMode && UpdateMode}IsEnabled := IsEnabled and FileExists(AddBackSlash(WizardForm.DirEdit.Text) + '{#ExeCheck}');{#endif}
  WizardForm.NextButton.Enabled := IsEnabled;
end;


function Scale(Value: Integer): Integer;
begin
  Result := Round((ScaleX(Value) + ScaleY(Value)) / 2);
end;


#if PlayButtonSound
  procedure PlaySound();
  begin
    if FileExists(ExpandConstant('{tmp}\Button.wav')) then
      sndPlaySound(ExpandConstant('{tmp}\Button.wav'), SND_ASYNC);
  end;
#endif


#if Music
  procedure MusicButtonClick(Sender: TObject);
  begin
    {#if PlayButtonSound}PlaySound;{#endif}
    if SoundStream <> 0 then
    begin
      case BASS_ChannelIsActive(SoundStream) of
        BASS_ACTIVE_PLAYING:
        begin
          if BASS_ChannelPause(SoundStream) then
            MusicButton.Caption := ExpandConstant('{cm:MusicButtonCaptionSoundOff}');
        end;
        BASS_ACTIVE_PAUSED:
        begin
          if BASS_ChannelPlay(SoundStream, False) then
            MusicButton.Caption := ExpandConstant('{cm:MusicButtonCaptionSoundOn}');
        end;
      end;
    end;
  end;
#endif

procedure PauseButtonClick(Sender: TObject);
begin
  {#if PlayButtonSound}PlaySound;{#endif}
  StatusPaused := not StatusPaused;
  if StatusPaused then
  begin
    DSG_PauseUnpacker(True);
    PauseButton.Caption := CustomMessage('Resume');
  end else
  begin
    DSG_PauseUnpacker(False);
    PauseButton.Caption := CustomMessage('Pause');
  end;
end;


#if !CompactMode && UseInstallBackground
  procedure BackgroundButtonClick(Sender: TObject);
  begin
    {#if PlayButtonSound}PlaySound;{#endif}
    if BackgroundCB.Checked then
    begin
      BackgroundButton.Caption := ExpandConstant('{cm:BackgroundON}');
      BackgroundForm.Show;
      WizardForm.BringToFront;
    end else
    begin
      BackgroundButton.Caption := ExpandConstant('{cm:BackgroundOFF}');
      BackgroundForm.Hide;
    end;
    BackgroundCB.Checked := not BackgroundCB.Checked;
  end;
#endif


function IsComponentInstalled(const Component: Integer): Boolean;
#if UseComponents
var
  S: String;
#endif
begin
  #if UseComponents
    RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#Name}_is1', 'Inno Setup: Selected Components', S);
    Result := (Component = 0) or ((Component > 0) and (Pos(Format(',%s,', [IntToStr(Component)]), Format(',%s,', [S])) > 0));
  #else
    Result := True;
  #endif
end;


function IsComponentChecked(const Component: Integer): Boolean;
begin
  #if UseComponents
    Result := (Component = 0) or ((Component > 0) and (ComponentsList.Items.Count >= Component) and ComponentsList.Checked[Component - 1]);
  #else
    Result := True;
  #endif
end;


#if !CompactMode || !UpdateMode
  function CreateIconsDesktop: Boolean;
  begin
    Result := (not IsDoneError);
  end;

  function IsUninstallable: Boolean;
  begin
    Result := UninstallCB.Checked;
  end;
#endif


#if !CompactMode
  function CreateIconsStartMenu: Boolean;
  begin
    Result := (not IsDoneError) and (not StartMenuCB.Checked);
  end;

  procedure StartMenuCBClick(Sender: TObject);
  begin
    if StartMenuCB.Checked then
    begin
      WizardForm.GroupEdit.Enabled := False;
      WizardForm.GroupBrowseButton.Enabled := False;
    end else
    begin
      WizardForm.GroupEdit.Enabled := True;
      WizardForm.GroupBrowseButton.Enabled := True;
    end;
  end;
#endif


{Centering for Welcome/Finish messages}
procedure Centering(Control: TControl);
begin
  if Assigned(Control) and Assigned(Control.Parent) then
  begin
    Control.Left := (ScaleX(Control.Parent.Width) - ScaleX(Control.Width)) div 2;
  end;
end;


procedure WebsiteClick(Sender: TObject);
var
  ErrorCode: Integer;
begin
  {#if PlayButtonSound}PlaySound;{#endif}
  ShellExec('open', '{#URL}', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;


#if VER >= 0x06000000
  const
    SWP_NOSIZE         = $0001;
    SWP_NOZORDER       = $0004;
    SWP_NOACTIVATE     = $0010;
    SWP_NOCOPYBITS     = $0100;
    SWP_NOSENDCHANGING = $0400;
    SWP_FLAGS = SWP_NOSENDCHANGING or SWP_NOCOPYBITS or SWP_NOACTIVATE or SWP_NOZORDER or SWP_NOSIZE;

  function SetWindowPos(hWnd: HWND; hWndInsertAfter: HWND; X, Y, cx, cy: Integer; uFlags: UINT): BOOL;
    external 'SetWindowPos@user32.dll stdcall delayload';

  const
    SPI_GETWORKAREA = $00000030;

  function SystemParametersInfo(uiAction, uiParam: LongWord; var pvParam: TRect; fWinIni: LongWord): BOOL;
    external 'SystemParametersInfoW@user32.dll stdcall delayload';

  procedure AboutFormShow(Sender: TObject);
  var
    PosLeft, PosTop: Integer;
    WorkArea: TRect;
  begin
    SystemParametersInfo(SPI_GETWORKAREA, 0, WorkArea, 0);
    {set left position}
    PosLeft := ((WizardForm.Width - TSetupForm(Sender as TSetupForm).Width) div 2) + WizardForm.Left; {AFLeft}
    if PosLeft < 0 then
      PosLeft := 0
    else
    if PosLeft + TSetupForm(Sender as TSetupForm).Width > WorkArea.Right then
      PosLeft := WorkArea.Right - TSetupForm(Sender as TSetupForm).Width;
    {set top position}
    PosTop := ((WizardForm.Height - TSetupForm(Sender as TSetupForm).Height) div 2) + WizardForm.Top; {AFTop}
    if PosTop < 0 then
      PosTop := 0
    else
      if PosTop + TSetupForm(Sender as TSetupForm).Height > WorkArea.Bottom then
        PosTop := WorkArea.Bottom - TSetupForm(Sender as TSetupForm).Height;
    {apply new positions}
    SetWindowPos(TSetupForm(Sender as TSetupForm).Handle, 0, PosLeft, PosTop, 0, 0, SWP_FLAGS);
  end;
#endif


procedure OpenBrowser(Url: string);
var
  ErrorCode: Integer;
begin
  ShellExec('open', Url, '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;


procedure AboutLinkClick(Sender: TObject);
begin
  OpenBrowser('https://t.me/ARMGDDNGames');
end;


procedure AboutButtonClick(Sender: TObject);
var
  AboutForm: TSetupForm;
  AboutOKButton: TNewButton;
  AboutLabel, AboutLink: TNewStaticText;
  LogoImage: TBitmapImage;
begin
  {#if PlayButtonSound}PlaySound;{#endif}
  AboutForm := CreateCustomForm();
  try
    AboutForm.ClientWidth := ScaleX(380);
    AboutForm.ClientHeight := ScaleY(300);
    AboutForm.Caption := SetupMessage(msgAboutSetupTitle);
    #if VER >= 0x06000000 /* Fix to Inno Setup 6 not compile this line (error) */
      AboutForm.OnShow := @AboutFormShow;
    #else
      AboutForm.CenterInsideControl(WizardForm, False);
    #endif

    AboutOKButton := TNewButton.Create(AboutForm);
    AboutOKButton.Parent := AboutForm;
    AboutOKButton.Width := ScaleX(75);
    AboutOKButton.Height := ScaleY(23);
    AboutOKButton.Left := AboutForm.ClientWidth - ScaleX(75 + 10);
    AboutOKButton.Top := AboutForm.ClientHeight - ScaleY(23 + 10);
    AboutOKButton.Caption := SetupMessage(msgButtonOK);
    AboutOKButton.ModalResult := mrOk;
    AboutOKButton.Default := True;

    AboutLabel := TNewStaticText.Create(AboutForm);
    AboutLabel.Parent := AboutForm;
    AboutLabel.Left := ScaleX(5);
    AboutLabel.Top  := ScaleY(160);
    AboutLabel.Width := ScaleX(370);
    AboutLabel.Height := ScaleY(100);
    AboutLabel.Font.Size := 12;
    AboutLabel.Font.Style := [fsBold];
    AboutLabel.Caption := Format('%s', ['{#Name}'])
                          + #13#10 + 'BuildID: {#BuildVersion}'
                          + #13#10 + 'Repack By: {#Repacker}'
                          + #13#10 + ''
                          + #13#10 + 'Repacked For: {#Creator}™';

    AboutLink := TNewStaticText.Create(AboutForm);
    AboutLink.Parent := AboutForm;
    AboutLink.Left := ScaleX(5);
    AboutLink.Top  := ScaleY(260);
    AboutLink.Width := ScaleX(370);
    AboutLink.Height := ScaleY(100);
    AboutLink.Font.Style := [fsBold, fsUnderline];
    AboutLink.Font.Size := 10;
    AboutLink.Font.Color := clFuchsia;
    AboutLink.Cursor := crHand;
    AboutLink.Caption := 'AG Telegram';
    AboutLink.OnClick := @AboutLinkClick;

    ExtractTemporaryFile('Logo.bmp');
    LogoImage := TBitmapImage.Create(WizardForm);
    with LogoImage do begin
      Name             := 'LogoImage';
      Parent           := AboutForm;
      Stretch          := True;
      AutoSize         := False;
      Left             := ScaleX(5);
      Top              := ScaleY(5);
      Width            := ScaleX(373);
      Height           := ScaleY(149);
      Bitmap.AlphaFormat := afDefined;
      Bitmap.LoadFromFile(ExpandConstant('{tmp}\Logo.bmp'));
    end;
    AboutForm.ShowModal()
  finally
    AboutForm.Free();
  end;
end;


#if VER >= 0x06000000
  procedure InfoFormShow(Sender: TObject);
  var
    PosLeft, PosTop: Integer;
    WorkArea: TRect;
  begin
    SystemParametersInfo(SPI_GETWORKAREA, 0, WorkArea, 0);
    {set left position}
    PosLeft := ((WizardForm.Width - TSetupForm(Sender as TSetupForm).Width) div 2) + WizardForm.Left; {AFLeft}
    if PosLeft < 0 then
      PosLeft := 0
    else
    if PosLeft + TSetupForm(Sender as TSetupForm).Width > WorkArea.Right then
      PosLeft := WorkArea.Right - TSetupForm(Sender as TSetupForm).Width;
    {set top position}
    PosTop := ((WizardForm.Height - TSetupForm(Sender as TSetupForm).Height) div 2) + WizardForm.Top; {AFTop}
    if PosTop < 0 then
      PosTop := 0
    else
      if PosTop + TSetupForm(Sender as TSetupForm).Height > WorkArea.Bottom then
        PosTop := WorkArea.Bottom - TSetupForm(Sender as TSetupForm).Height;
    {apply new positions}
    SetWindowPos(TSetupForm(Sender as TSetupForm).Handle, 0, PosLeft, PosTop, 0, 0, SWP_FLAGS);
  end;
#endif


#if CompactMode
  procedure InfoButtonClick(Sender: TObject);
  var
    InfoForm: TSetupForm;
    InfoOKButton: TNewButton;
    InfoBeforeMemo: TNewMemo;
  begin
    {#if PlayButtonSound}PlaySound;{#endif}
    InfoForm := CreateCustomForm();
    try
      InfoForm.ClientWidth := ScaleX(700);
      InfoForm.ClientHeight := ScaleY(400);
      InfoForm.Caption := SetupMessage(msgWizardInfoAfter);
      #if VER >= 0x06000000 /* Fix to Inno Setup 6 not compile this line (error) */
        InfoForm.OnShow := @InfoFormShow;
      #else
        InfoForm.CenterInsideControl(WizardForm, False);
      #endif

      WizardForm.InfoBeforeMemo.Visible := False;

      InfoBeforeMemo := TNewMemo.Create(WizardForm);
      with InfoBeforeMemo do
      begin
        Parent     := InfoForm;
        Left       := ScaleX(30);
        Top        := ScaleY(30);
        Width      := ScaleX(640);
        Height     := ScaleY(311);
        Color      := TColor($d3d3d3);
        Font.Color := clBlack;
        ScrollBars := ssVertical;
        Text       := StrAsAnsi(WizardForm.InfoBeforeMemo.Text);
        ReadOnly   := True;
      end;

      InfoOKButton := TNewButton.Create(InfoForm);
      InfoOKButton.Parent := InfoForm;
      InfoOKButton.Left := ScaleX(598);
      InfoOKButton.Top := ScaleY(358);
      InfoOKButton.Width := ScaleX(75);
      InfoOKButton.Height := ScaleY(23);
      InfoOKButton.Caption := SetupMessage(msgButtonOK);
      InfoOKButton.ModalResult := mrOk;
      InfoOKButton.Default := True;

      InfoForm.ShowModal()
    finally
      InfoForm.Free();
    end;
  end;
#endif


{DPI Calculator by Yener90}
function DPICalculator(Value: Integer): Integer;
var
  SystemDPI: DWORD;
begin
  if not RegQueryDWordValue(HKCU, 'Control Panel\Desktop', 'LogPixels', SystemDPI) then
    SystemDPI := 96;
  Result := ((96 * 100 / SystemDPI) * Value) / 100;
end;


{Color Converter from BGR to RGB by BAMsE}
function GetValInt(Section, Key: String; Default: Integer): Integer;
begin
  Result := GetIniInt(Section, Key, Default, 0, 0, ExpandConstant('{tmp}\Settings.ini'));
end;


function ColorConverter(InputColor: Integer): Integer;
var
  TmpStr: String;
  i: Integer;
begin
  SetLength(TmpStr, 6);
  for i := 6 downto 1 do
  begin
    TmpStr[i] := '0123456789ABCDEF'[(InputColor and 15) + 1];
    InputColor := InputColor shr 4;
  end;
  while InputColor <> 0 do
  begin
    TmpStr := '0123456789ABCDEF[(InputColor and 15) + 1]' + TmpStr; {errate - this part not work}
    InputColor := InputColor shr 4;
  end;
  Result := StrToInt('$' + (Copy(TmpStr, 5, 2) + Copy(TmpStr, 3, 2) + Copy(TmpStr, 1, 2)));
end;

#if !CompactMode && UseSystemReq
  procedure SystemReq();
  var
    RemoveRunningLabel: String;
    HWScore: Integer;
  begin
    Processor     := {#Processor};
    VideoRam      := {#VideoRAM};
    Ram           := {#RAM};
    OpSystem      := {#OS}
    DirectX       := {#DX};
    SystemReqPage := CreateCustomPage(wpInfoBefore, '', '');
    RemoveRunningLabel := GetGpuName;
    StringChangeEx(RemoveRunningLabel, 'x 1 (Running)', '', true);

    with SystemReqPage.Surface do
    begin
      Name := 'SystemReqPage';
    end;

    SystemReqImage := TBitmapImage.Create(WizardForm);
    with SystemReqImage do
    begin
      Parent := SystemReqPage.Surface;
      Stretch := True;
      AutoSize := False;
      Left   := ScaleX(0);
      Top    := ScaleY(0);
      Width  := ScaleX(32);
      Height := ScaleY(32);
      ExtractTemporaryFile('SystemReqImage.bmp');
      Bitmap.AlphaFormat := afDefined;
      Bitmap.LoadFromFile(ExpandConstant('{tmp}\SystemReqImage.bmp'));
    end;

    SysReqCheckLabel := TNewStaticText.Create(WizardForm);
    with SysReqCheckLabel do
    begin
      Parent   := SystemReqPage.Surface;
      WordWrap := True;
      Caption  := ExpandConstant('{cm:SystemReqLabel1}');
      Left     := WizardForm.PageDescriptionLabel.Left;
      Top      := 0;
      Width    := ScaleX(488);
      Height   := ScaleY(50);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;

    IfReadyLabel := TNewStaticText.Create(WizardForm);
    with IfReadyLabel do
    begin
      Parent  := SystemReqPage.Surface;
      Caption := WizardForm.InfoBeforeClickLabel.Caption;
      Left    := ScaleX(0);
      Top     := ScaleY(216);
      Width   := ScaleX(400);
      Height  := ScaleY(14);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;

    HardwareDetectLabel := TNewStaticText.Create(WizardForm);
    with HardwareDetectLabel do
    begin
      Parent  := SystemReqPage.Surface;
      Caption := ExpandConstant('{cm:SystemReqLabel2}');
      Left    := ScaleX(0);
      Top     := ScaleY(56);
      Width   := ScaleX(287);
      Height  := ScaleY(14);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;

    Case1 := TPanel.Create(WizardForm);
    with Case1 do
    begin
      Parent     := SystemReqPage.Surface;
      Left       := ScaleX(0);
      Top        := ScaleY(80);
      Width      := ScaleX(520);
      Height     := ScaleY(150);
      BevelInner := bvNone;
      BevelOuter := bvLowered;
      Color      := clWindow;
      ParentBackground := False;
      Caption := '';
    end;

    //////////////////////////// PROCESSOR ////////////////////////////
    ProcessorBevel := TBevel.Create(WizardForm);
    with ProcessorBevel do
    begin
      Parent := Case1;
      Left   := ScaleX(8);
      Top    := ScaleY(8);
      Width  := ScaleX(74);
      Height := ScaleY(18);
      Shape  := bsFrame;
    end;

    CPULabel := TLabel.Create(WizardForm);
    with CPULabel do
    begin
      AutoSize    := False;
      Left        := ScaleX(12);
      Top         := ScaleY(10);
      Width       := ScaleX(68);
      Height      := ScaleY(14);
      Transparent := True;
      Font.Style  := [fsBold];
      Font.Color  := ColorConverter(GetValInt('SystemRequirement', 'HWSectionLabelColor', 0));
      Caption     := 'CPU';
      Parent      := Case1;
    end;

    ProcessorNameBevel := TBevel.Create(WizardForm);
    with ProcessorNameBevel do
    begin
      Parent := Case1;
      Left   := ScaleX(96);
      Top    := ScaleY(8);
      Width  := ScaleX(329);
      Height := ScaleY(18);
      Shape  := bsFrame;
    end;

    CPUNameLabel := TLabel.Create(SystemReqPage);
    with CPUNameLabel do
    begin
      AutoSize    := False;
      Left        := ScaleX(100);
      Top         := ScaleY(10);
      Width       := ScaleX(410);
      Height      := ScaleY(14);
      Transparent := True;
      Font.Color  := ColorConverter(GetValInt('SystemRequirement', 'HWOkLabelColor', 0));
      Caption     := GetCpuName;
      Parent      := Case1;
    end;

    if (GetCpuMaxClockSpeed) < Processor then
    begin
      CPUNameLabel.Font.Color := ColorConverter(GetValInt('SystemRequirement', 'HWNotOkLabelColor', 0));
      CPUNameLabel.Caption := 'CPU: '+IntToStr(GetCpuMaxClockSpeed)+' MHz,' + (ExpandConstant('  {cm:DirectXNeeded} ')) + '{#Processor}'+' MHz';
    end;

    CPUMHZBevel := TBevel.Create(WizardForm);
    with CPUMHZBevel do
    begin
      Parent := Case1;
      Left   := ScaleX(439);
      Top    := ScaleY(8);
      Width  := ScaleX(74);
      Height := ScaleY(18);
      Shape  := bsFrame;
    end;

    CPUGHZLabel := TLabel.Create(SystemReqPage);
    with CPUGHZLabel do
    begin
      AutoSize    := False;
      Left        := ScaleX(443);
      Top         := ScaleY(10);
      Width       := ScaleX(66);
      Height      := ScaleY(14);
      Transparent := True;
      Font.Color  := ColorConverter(GetValInt('SystemRequirement', 'HWOkLabelColor', 0));
      Caption     := IntToStr(GetCpuMaxClockSpeed)+' MHz';
      Parent      := Case1;
    end;

    if (GetCpuMaxClockSpeed) < Processor then
    begin
      CPUGHZLabel.Font.Color := ColorConverter(GetValInt('SystemRequirement', 'HWNotOkLabelColor', 0));
      CPUGHZLabel.Caption := IntToStr(GetCpuMaxClockSpeed)+' MHz';
    end;


    //////////////////////////// VIDEO CARD ////////////////////////////
    VideoCardBevel := TBevel.Create(WizardForm);
    with VideoCardBevel do
    begin
      Parent := Case1;
      Left   := ScaleX(8);
      Top    := ScaleY(32);
      Width  := ScaleX(74);
      Height := ScaleY(18);
      Shape  := bsFrame;
    end;

    GPULabel := TLabel.Create(SystemReqPage);
    with GPULabel do
    begin
      AutoSize    := False;
      Left        := ScaleX(12);
      Top         := ScaleY(34);
      Width       := ScaleX(68);
      Height      := ScaleY(14);
      Transparent := True;
      Font.Style  := [fsBold];
      Font.Color  := ColorConverter(GetValInt('SystemRequirement', 'HWSectionLabelColor', 0));
      Caption     := 'GPU';
      Parent      := Case1;
    end;

    VideoCardNameBevel := TBevel.Create(WizardForm);
    with VideoCardNameBevel do
    begin
      Parent := Case1;
      Left   := ScaleX(96);
      Top    := ScaleY(32);
      Width  := ScaleX(329);
      Height := ScaleY(18);
      Shape  := bsFrame;
    end;

    GPUNameLabel := TLabel.Create(SystemReqPage);
    with GPUNameLabel do
    begin
      AutoSize    := False;
      Left        := ScaleX(100);
      Top         := ScaleY(34);
      Width       := ScaleX(410);
      Height      := ScaleY(14);
      Transparent := True;
      Font.Color  := ColorConverter(GetValInt('SystemRequirement', 'HWOkLabelColor', 0));
      Caption     := RemoveRunningLabel;
      Parent      := Case1;
    end;

    if GetGpuVRam < VideoRam then
    begin
      GPUNameLabel.Font.Color := ColorConverter(GetValInt('SystemRequirement', 'HWNotOkLabelColor', 0));
      GPUNameLabel.Caption := 'GPU: '+IntToStr(GetGpuVRam)+' MB,' + (ExpandConstant('  {cm:DirectXNeeded} ')) + '{#VideoRAM}'+' MB';
    end;

    GPUMHZBevel := TBevel.Create(WizardForm);
    with GPUMHZBevel do
    begin
      Parent := Case1;
      Left   := ScaleX(439);
      Top    := ScaleY(32);
      Width  := ScaleX(74);
      Height := ScaleY(18);
      Shape  := bsFrame;
    end;

    GPUGHZLabel := TLabel.Create(SystemReqPage);
    with GPUGHZLabel do
    begin
      AutoSize    := False;
      Left        := ScaleX(443);
      Top         := ScaleY(34);
      Width       := ScaleX(66);
      Height      := ScaleY(14);
      Transparent := True;
      Font.Color  := ColorConverter(GetValInt('SystemRequirement', 'HWOkLabelColor', 0));
      Caption     := IntToStr(GetGpuVRam)+' MB';
      Parent      := Case1;
    end;

    if GetGpuVRam < VideoRam then
    begin
      GPUGHZLabel.Font.Color := ColorConverter(GetValInt('SystemRequirement', 'HWNotOkLabelColor', 0));
      GPUGHZLabel.Caption := IntToStr(GetGpuVRam)+' MB';
    end;


    //////////////////////////// RAM ////////////////////////////
    RAMBevel := TBevel.Create(WizardForm);
    with RAMBevel do
    begin
      Parent := Case1;
      Left   := ScaleX(8);
      Top    := ScaleY(80);
      Width  := ScaleX(74);
      Height := ScaleY(18);
      Shape  := bsFrame;
    end;

    RAMLabel := TLabel.Create(SystemReqPage);
    with RAMLabel do
    begin
      AutoSize    := False;
      Left        := ScaleX(12);
      Top         := ScaleY(82);
      Width       := ScaleX(68);
      Height      := ScaleY(14);
      Transparent := True;
      Font.Style  := [fsBold];
      Font.Color  := ColorConverter(GetValInt('SystemRequirement', 'HWSectionLabelColor', 0));
      Caption     := 'RAM';
      Parent      := Case1;
    end;

    RAMTotalBevel := TBevel.Create(WizardForm);
    with RAMTotalBevel do
    begin
      Parent := Case1;
      Left   := ScaleX(96);
      Top    := ScaleY(80);
      Width  := ScaleX(417);
      Height := ScaleY(18);
      Shape  := bsFrame;
    end;

    TotalRAMLabel := TLabel.Create(SystemReqPage);
    with TotalRAMLabel do
    begin
      AutoSize    := False;
      Left        := ScaleX(100);
      Top         := ScaleY(82);
      Width       := ScaleX(410);
      Height      := ScaleY(14);
      Transparent := True;
      Font.Color  := ColorConverter(GetValInt('SystemRequirement', 'HWOkLabelColor', 0));
      Caption     := IntToStr(GetTotalVisibleMemory + 1) + ' MB';
      Parent      := Case1;
    end;

    if (GetTotalVisibleMemory + 1) < RAM then
    begin
      TotalRAMLabel.Font.Color := ColorConverter(GetValInt('SystemRequirement', 'HWNotOkLabelColor', 0));
      TotalRAMLabel.Caption := 'RAM: '+IntToStr(GetTotalVisibleMemory)+' MB,' + (ExpandConstant('  {cm:DirectXNeeded} ')) + '{#RAM}'+' MB';
    end;


    //////////////////////////// DirectX ////////////////////////////
    DirectXBevel := TBevel.Create(WizardForm);
    with DirectXBevel do
    begin
      Parent := Case1;
      Left   := ScaleX(8);
      Top    := ScaleY(56);
      Width  := ScaleX(74);
      Height := ScaleY(18);
      Shape  := bsFrame;
    end;

    DirectXLabel := TLabel.Create(SystemReqPage);
    with DirectXLabel do
    begin
      AutoSize    := False;
      Left        := ScaleX(12);
      Top         := ScaleY(58);
      Width       := ScaleX(67);
      Height      := ScaleY(14);
      Transparent := True;
      Font.Style  := [fsBold];
      Font.Color  := ColorConverter(GetValInt('SystemRequirement', 'HWSectionLabelColor', 0));
      Caption     := 'DirectX';
      Parent      := Case1;
    end;

    DirectXVersionBevel := TBevel.Create(WizardForm);
    with DirectXVersionBevel do
    begin
      Parent := Case1;
      Left   := ScaleX(96);
      Top    := ScaleY(56);
      Width  := ScaleX(417);
      Height := ScaleY(18);
      Shape  := bsFrame;
    end;

    DX := Round(GetDirectXVersion(Dx_gpu));

    DirectXVersionLabel := TLabel.Create(SystemReqPage);
    with DirectXVersionLabel do
    begin
      AutoSize    := False;
      Left        := ScaleX(100);
      Top         := ScaleY(58);
      Width       := ScaleX(410);
      Height      := ScaleY(14);
      Transparent := True;
      Font.Color  := ColorConverter(GetValInt('SystemRequirement', 'HWOkLabelColor', 0));
      Caption     := IntToStr(DX)
      Parent      := Case1;
    end;

    if (DX) < DirectX then
    begin
      DirectXVersionLabel.Font.Color := ColorConverter(GetValInt('SystemRequirement', 'HWNotOkLabelColor', 0));
      DirectXVersionLabel.Caption := 'DirectX: '+IntToStr(DX) + (ExpandConstant('  {cm:DirectXNeeded} ')) + '{#DX}'
    end;


    //////////////////////////// SYSTEM ////////////////////////////
    SystemBevel := TBevel.Create(WizardForm);
    with SystemBevel do
    begin
      Parent := Case1;
      Left   := ScaleX(8);
      Top    := ScaleY(104);
      Width  := ScaleX(74);
      Height := ScaleY(18);
      Shape  := bsFrame;
    end;

    SystemLabel := TLabel.Create(SystemReqPage);
    with SystemLabel do
    begin
      AutoSize    := False;
      Left        := ScaleX(12);
      Top         := ScaleY(106);
      Width       := ScaleX(68);
      Height      := ScaleY(14);
      Transparent := True;
      Font.Style  := [fsBold];
      Font.Color  := ColorConverter(GetValInt('SystemRequirement', 'HWSectionLabelColor', 0));
      Caption     := 'System';
      Parent      := Case1;
    end;

    SystemNameBevel := TBevel.Create(WizardForm);
    with SystemNameBevel do
    begin
      Parent := Case1;
      Left   := ScaleX(96);
      Top    := ScaleY(104);
      Width  := ScaleX(417);
      Height := ScaleY(18);
      Shape  := bsFrame;
    end;

    SystemNameLabel := TLabel.Create(SystemReqPage);
    with SystemNameLabel do
    begin
      AutoSize    := False;
      Left        := ScaleX(100);
      Top         := ScaleY(106);
      Width       := ScaleX(410);
      Height      := ScaleY(14);
      Transparent := True;
      Font.Color  := ColorConverter(GetValInt('SystemRequirement', 'HWOkLabelColor', 0));
      Caption     := GetOSName+' ('+IntToStr(GetOSArchitecture)+' Bit)';
      Parent      := Case1;
    end;

    OSNumber := StrToInt(IntToStr(GetOSVersionMajor)+IntToStr(GetOSVersionMinor)+IntToStr(GetServicePackMajorVersion));

    if not (OSNumber >= {#OS}) then
    begin
      SystemNameLabel.Font.Color := ColorConverter(GetValInt('SystemRequirement', 'HWNotOkLabelColor', 0));
    end;


    //////////////////////// HW CHECK LABEL ////////////////////////
    HwLabel := TLabel.Create(SystemReqPage);
    with HwLabel do
    begin
      Parent      := Case1;
      AutoSize    := False;
      Left        := ScaleX(8);
      Top         := ScaleY(130);
      Width       := ScaleX(505);
      Height      := ScaleY(14);
      Transparent := True;
      Font.Color  := clGreen;
      Font.Style  := [fsBold];
      Alignment   := taCenter;
    end;


    {Increase points if HW greater or equal}
    HWScore := 0;
    if (GetCpuMaxClockSpeed >= Processor) then Inc(HWScore);
    if (GetGpuVRam >= VideoRam) then Inc(HWScore);
    if ((GetTotalVisibleMemory + 1) >= RAM) then Inc(HWScore);
    if (DX >= DirectX) then Inc(HWScore);
    if (OSNumber >= {#OS}) then Inc(HWScore);

    case HWScore of
      5: begin
        HwLabel.Font.Color := ColorConverter(GetValInt('SystemRequirement', 'HWGoodLabelColor', 0));
        HwLabel.Caption := ExpandConstant('{cm:Hardware100}');
      end;
      1..4: begin
        HwLabel.Font.Color := ColorConverter(GetValInt('SystemRequirement', 'HWPartiallyGoodLabelColor', 0));
        HwLabel.Caption := ExpandConstant('{cm:Hardware50}');
      end;
      0: begin
        HwLabel.Font.Color := ColorConverter(GetValInt('SystemRequirement', 'HWNotGoodLabelColor', 0));
        HwLabel.Caption := ExpandConstant('{cm:Hardware0}');
      end;
    end;
  end;
#endif


{Controls for resizing wizard}
#if !CompactMode
  procedure ShiftDown(Control: TControl; DeltaY: Integer);
  begin
    Control.Top := Control.Top + DeltaY;
  end;

  procedure ShiftRight(Control: TControl; DeltaX: Integer);
  begin
    Control.Left := Control.Left + DeltaX;
  end;

  procedure ShiftDownAndRight(Control: TControl; DeltaX, DeltaY: Integer);
  begin
    ShiftDown(Control, DeltaY);
    ShiftRight(Control, DeltaX);
  end;

  procedure GrowDown(Control: TControl; DeltaY: Integer);
  begin
    Control.Height := Control.Height + DeltaY;
  end;

  procedure GrowRight(Control: TControl; DeltaX: Integer);
  begin
    Control.Width := Control.Width + DeltaX;
  end;

  procedure GrowRightAndDown(Control: TControl; DeltaX, DeltaY: Integer);
  begin
    GrowRight(Control, DeltaX);
    GrowDown(Control, DeltaY);
  end;

  procedure GrowRightAndShiftDown(Control: TControl; DeltaX, DeltaY: Integer);
  begin
    GrowRight(Control, DeltaX);
    ShiftDown(Control, DeltaY);
  end;

  procedure GrowWizard(DeltaX, DeltaY: Integer);
  begin
    GrowRightAndDown(WizardForm, DeltaX, DeltaY);

    with WizardForm do
    begin
      GrowRightAndShiftDown(Bevel, DeltaX, DeltaY);
      ShiftDownAndRight(CancelButton, DeltaX, DeltaY);
      ShiftDownAndRight(NextButton, DeltaX, DeltaY);
      ShiftDownAndRight(BackButton, DeltaX, DeltaY);
      GrowRightAndDown(OuterNotebook, DeltaX, DeltaY);
      GrowRight(BeveledLabel, DeltaX);

      { WelcomePage }
      GrowDown(WizardBitmapImage, DeltaY);
      GrowRight(WelcomeLabel2, DeltaX);
      GrowRight(WelcomeLabel1, DeltaX);

      { InnerPage }
      GrowRight(Bevel1, DeltaX);
      GrowRightAndDown(InnerNotebook, DeltaX, DeltaY);

      { LicensePage }
      ShiftDown(LicenseNotAcceptedRadio, DeltaY);
      ShiftDown(LicenseAcceptedRadio, DeltaY);
      GrowRightAndDown(LicenseMemo, DeltaX, DeltaY);
      GrowRight(LicenseLabel1, DeltaX);

      { SelectDirPage }
      GrowRightAndShiftDown(DiskSpaceLabel, DeltaX, DeltaY);
      ShiftRight(DirBrowseButton, DeltaX);
      GrowRight(DirEdit, DeltaX);
      GrowRight(SelectDirBrowseLabel, DeltaX);
      GrowRight(SelectDirLabel, DeltaX);

      #if UseComponents
      { SelectComponentsPage }
      GrowRightAndShiftDown(ComponentsDiskSpaceLabel, DeltaX, DeltaY);
      GrowRightAndDown(ComponentsList, DeltaX, DeltaY);
      GrowRight(TypesCombo, DeltaX);
      GrowRight(SelectComponentsLabel, DeltaX);
      #endif

      #if UseTasks
      { SelectTasksPage }
      GrowRightAndDown(TasksList, DeltaX, DeltaY);
      GrowRight(SelectTasksLabel, DeltaX);
      #endif

      { ReadyPage }
      GrowRightAndDown(ReadyMemo, DeltaX, DeltaY);
      GrowRight(ReadyLabel, DeltaX);

      { InstallingPage }
      GrowRight(FilenameLabel, DeltaX);
      GrowRight(StatusLabel, DeltaX);
      GrowRight(ProgressGauge, DeltaX);

      { MainPanel }
      GrowRight(Mainpanel, DeltaX);
      ShiftRight(WizardSmallBitmapImage, DeltaX);
      GrowRight(PageDescriptionLabel, DeltaX);
      GrowRight(PageNameLabel, DeltaX);

      { FinishedPage }
      GrowDown(WizardBitmapImage2, DeltaY);
      GrowRight(RunList, DeltaX);
      GrowRight(FinishedLabel, DeltaX);
      GrowRight(FinishedHeadingLabel, DeltaX);
    end;
  end;
#endif


#if UseComponents || UseTasks
  function TranslateLanguageNames(StrName: String): String;
  begin
    case Trim(Uppercase(Copy(StrName, Pos('cm:', LowerCase(StrName)) + Length('cm:'), Length(StrName)))) of
      'EN', 'ENGLISH'   : Result := CustomMessage('CompEnglish');
      'FR', 'FRENCH'    : Result := CustomMessage('CompFrench');
      'DE', 'GERMAN'    : Result := CustomMessage('CompGerman');
      'IT', 'ITALIAN'   : Result := CustomMessage('CompItalian');
      'ES', 'SPANISH'   : Result := CustomMessage('CompSpanish');
      'PL', 'POLISH'    : Result := CustomMessage('CompPolish');
      'RU', 'RUSSIAN'   : Result := CustomMessage('CompRussian');
      'BR', 'BRAZILIAN' : Result := CustomMessage('CompPortugueseBrazil');
      'MX', 'MEXICAN'   : Result := CustomMessage('CompMexican');
      'CZ', 'CZECH'     : Result := CustomMessage('CompCzech');
      else
        Result := StrName;
    end;
  end;
#endif


#if UseComponents
  #if CompactMode
    procedure ComponentsPageClick(Sender: TObject);
    var
      I: Integer;
    begin
      ComponentsPageVisible := (not ComponentsPageVisible);
      WizardForm.WelcomePage.Visible := (not ComponentsPageVisible);
      WizardForm.DirEdit.Visible := (not ComponentsPageVisible);
      WizardForm.DirBrowseButton.Visible := (not ComponentsPageVisible);
      WizardForm.NextButton.Visible := (not ComponentsPageVisible);
      WizardForm.ProgressGauge.Visible := (not ComponentsPageVisible);
      WizardForm.CancelButton.Visible := (not ComponentsPageVisible);
      FreeSpaceLabel.Visible := (not ComponentsPageVisible);
      NeedSpaceLabel.Visible := (not ComponentsPageVisible);
      PauseButton.Visible := (not ComponentsPageVisible);
      LimitRamCB.Visible := (not ComponentsPageVisible);
      #if !UpdateMode
        UnInstallCB.Visible := (not ComponentsPageVisible);
      #endif
      {#if CheckCRC}HashCheckCB.Visible := (not ComponentsPageVisible);{#endif}
      {#if Music}MusicButton.Visible := (not ComponentsPageVisible);{#endif}
      {#if UseRedists}RedistCB.Visible := (not ComponentsPageVisible);{#endif}
      #if UseTasks
        SelectTasksLabel.Visible := (not ComponentsPageVisible);
        TasksList.Visible := False;
        TasksDiskSpaceLabel.Visible := False;
        TasksOKButton.Visible := False;
      #endif
      {#if UseInfo}InfoButtonCM.Visible := (not ComponentsPageVisible);{#endif}
      AboutButtonCM.Visible := (not ComponentsPageVisible);
      SelectComponentsLabel.Visible := (not ComponentsPageVisible);
      ComponentsList.Visible := ComponentsPageVisible;
      ComponentsDiskSpaceLabel.Visible := ComponentsDiskSpaceLabelVisible and ComponentsPageVisible;
      ComponentsOKButton.Visible := ComponentsPageVisible;
      GetFreeSpaceCaption(nil);
      if not ComponentsPageVisible then
      begin
        for I := 0 to ComponentsList.Items.Count - 1 do
          if ComponentsList.Checked[I] then
            Break;

        WizardForm.NextButton.Enabled := WizardForm.NextButton.Enabled and (I < ComponentsList.Items.Count);
      end;
    end;
  #endif

  procedure ComponentsOnCheck(Sender: TObject);
  var
    I: Integer;
  begin
    ComponentsSize := 0;
    for I := 0 to ComponentsList.Items.Count - 1 do
      if ComponentsList.Checked[I] then
        ComponentsSize := ComponentsSize + GetSizeBytes(GetIniString('ComponentsSettings', 'Component' + IntToStr(I + 1) + '.Size', '0', ExpandConstant('{tmp}\Settings.ini')), 0);
    #if UseTasks
      TasksSize := 0;
      for I := 0 to TasksList.Items.Count - 1 do
        if TasksList.Checked[I] then
          TasksSize := TasksSize + GetSizeBytes(GetIniString('TasksSettings', 'Task' + IntToStr(I + 1) + '.Size', '0', ExpandConstant('{tmp}\Settings.ini')), ComponentsSize);
    #endif
    ComponentsDiskSpaceLabel.Caption := FormatDiskSpaceLabel(SetupMessage(msgComponentsDiskSpaceMBLabel), ComponentsSize{#if UseTasks} + TasksSize{#endif});
    ComponentsDiskSpaceLabel.Refresh;
    for I := 0 to ComponentsList.Items.Count - 1 do
      if ComponentsList.Checked[I] then
        Break;
    WizardForm.NextButton.Enabled := I < ComponentsList.Items.Count;
    {#if CompactMode}ComponentsOKButton.Enabled := WizardForm.NextButton.Enabled;{#endif}
  end;

  procedure AddComponentsItems;
  var
    I, Y: Integer;
    ItemType: Integer;
    CurrSize: Extended;
    ItemName: String;
    IniFile: String;
  begin
    {#if UseTasks}TasksSize := 0;{#endif}
    {#if CompactMode}ComponentsDiskSpaceLabelVisible := True;{#endif}
    I := 1;
    ComponentsSize := 0;
    IniFile := ExpandConstant('{tmp}\Settings.ini');
    while IniKeyExists('ComponentsSettings', 'Component' + IntToStr(I) + '.Name', IniFile) do
    begin
      case UpperCase(GetIniString('ComponentsSettings', 'Component' + IntToStr(I) + '.ItemType', '', IniFile)) of
        'CHECK' : ItemType := 0;
        'RADIO' : ItemType := 1;
        'GROUP' : ItemType := 2;
        else
          ItemType := 0;
      end;
      ItemName := GetIniString('ComponentsSettings', 'Component' + IntToStr(I) + '.Name', '', IniFile);
      if Pos('cm:', LowerCase(ItemName)) > 0 then
        ItemName := TranslateLanguageNames(ItemName);

      case ItemType of
        0 : Y := ComponentsList.AddCheckBox(ItemName, '', GetIniInt('ComponentsSettings', 'Component' + IntToStr(I) + '.Level', 0,0,0, IniFile), GetIniBool('ComponentsSettings', 'Component' + IntToStr(I) + '.Checked', True, IniFile), GetIniBool('ComponentsSettings', 'Component' + IntToStr(I) + '.Enabled', True, IniFile), False, True, nil);
        1 : Y := ComponentsList.AddRadioButton(ItemName, '', GetIniInt('ComponentsSettings', 'Component' + IntToStr(I) + '.Level', 0,0,0, IniFile), GetIniBool('ComponentsSettings', 'Component' + IntToStr(I) + '.Checked', True, IniFile), GetIniBool('ComponentsSettings', 'Component' + IntToStr(I) + '.Enabled', True, IniFile), nil);
        2 : Y := ComponentsList.AddGroup(ItemName, '', GetIniInt('ComponentsSettings', 'Component' + IntToStr(I) + '.Level', 0,0,0, IniFile), nil);
      end;
      if ItemType < 2 then
      begin
        CurrSize := GetSizeBytes(GetIniString('ComponentsSettings', 'Component' + IntToStr(I) + '.Size', '0', IniFile), 0);
        if ComponentsList.Checked[Y] then
          ComponentsSize := ComponentsSize + CurrSize;

        if GetIniBool('ComponentsSettings', 'ShowComponentSize', False, IniFile) then
          ComponentsList.ItemSubItem[Y] := FormatBytes(CurrSize, 2, True);

        #if CompactMode
          if GetIniString('ComponentsSettings', 'Component' + IntToStr(I) + '.Size', '', IniFile) = '' then
            ComponentsDiskSpaceLabelVisible := False;
        #endif
      end;
      Inc(I);
    end;
    ComponentsDiskSpaceLabel.Caption := FormatDiskSpaceLabel(SetupMessage(msgComponentsDiskSpaceMBLabel), ComponentsSize{#if UseTasks} + TasksSize{#endif});
    if GetIniBool('ComponentsSettings', 'FlatPageMode', False, IniFile) then
    begin
      ComponentsList.Flat := False;
      ComponentsList.BorderStyle := bsNone;
      ComponentsList.ParentColor := True;
      ComponentsList.MinItemHeight := WizardForm.TasksList.MinItemHeight; {22}
    end;
  end;
#endif

#if UseTasks
  #if CompactMode
    procedure TasksPageClick(Sender: TObject);
    begin
      TasksPageVisible := (not TasksPageVisible);
      WizardForm.WelcomePage.Visible := (not TasksPageVisible);
      WizardForm.DirEdit.Visible := (not TasksPageVisible);
      WizardForm.DirBrowseButton.Visible := (not TasksPageVisible);
      WizardForm.NextButton.Visible := (not TasksPageVisible);
      WizardForm.ProgressGauge.Visible := (not TasksPageVisible);
      WizardForm.CancelButton.Visible := (not TasksPageVisible);
      FreeSpaceLabel.Visible := (not TasksPageVisible);
      NeedSpaceLabel.Visible := (not TasksPageVisible);
      PauseButton.Visible := (not TasksPageVisible);
      LimitRAMCB.Visible := (not TasksPageVisible);
      #if !UpdateMode
        UnInstallCB.Visible := (not TasksPageVisible);
      #endif
      {#if CheckCRC}HashCheckCB.Visible := (not TasksPageVisible);{#endif}
      {#if Music}MusicButton.Visible := (not TasksPageVisible);{#endif}
      {#if UseRedists}RedistCB.Visible := (not TasksPageVisible);{#endif}
      #if UseComponents
        SelectComponentsLabel.Visible := (not TasksPageVisible);
        ComponentsList.Visible := False;
        ComponentsDiskSpaceLabel.Visible := False;
        ComponentsOKButton.Visible := False;
      #endif
      {#if UseInfo}InfoButtonCM.Visible := (not TasksPageVisible);{#endif}
      AboutButtonCM.Visible := (not TasksPageVisible);
      SelectTasksLabel.Visible := (not TasksPageVisible);
      TasksList.Visible := TasksPageVisible;
      TasksDiskSpaceLabel.Visible := TasksDiskSpaceLabelVisible and TasksPageVisible;
      TasksOKButton.Visible := TasksPageVisible;
      GetFreeSpaceCaption(nil);
    end;
  #endif

  procedure TasksOnCheck(Sender: TObject);
  var
    I: Integer;
  begin
    #if UseComponents
      ComponentsSize := 0;
      for I := 0 to ComponentsList.Items.Count  - 1 do
        if ComponentsList.Checked[I] then
          ComponentsSize := ComponentsSize + GetSizeBytes(GetIniString('ComponentsSettings', 'Component' + IntToStr(I + 1) + '.Size', '0', ExpandConstant('{tmp}\Settings.ini')), 0);
    #endif
    TasksSize := 0;
    for I := 0 to TasksList.Items.Count - 1 do
      if TasksList.Checked[I] then
        TasksSize := TasksSize + GetSizeBytes(GetIniString('TasksSettings', 'Task' + IntToStr(I + 1) + '.Size', '0', ExpandConstant('{tmp}\Settings.ini')), 0);

    TasksDiskSpaceLabel.Caption := FormatDiskSpaceLabel(SetupMessage(msgComponentsDiskSpaceMBLabel), TasksSize + {#if UseComponents}ComponentsSize{#else}GetSizeBytes(GetIniString('Settings', 'Size', '0', ExpandConstant('{tmp}\Settings.ini')), 0){#endif});
    TasksDiskSpaceLabel.Refresh;
  end;

  procedure AddTasksItems;
  var
    I, Y: Integer;
    ItemType: Integer;
    CurrSize: Extended;
    ItemName: String;
    IniFile: String;
  begin
    #if UseComponents
      ComponentsSize := 0;
      for I := 0 to ComponentsList.Items.Count  - 1 do
        if ComponentsList.Checked[I] then
          ComponentsSize := ComponentsSize + GetSizeBytes(GetIniString('ComponentsSettings', 'Component' + IntToStr(I + 1) + '.Size', '0', ExpandConstant('{tmp}\Settings.ini')), 0);
    #endif
    {#if CompactMode}TasksDiskSpaceLabelVisible := True; {#endif}
    I := 1;
    TasksSize := 0;
    IniFile := ExpandConstant('{tmp}\Settings.ini');
    while IniKeyExists('TasksSettings', 'Task' + IntToStr(I) + '.Name', IniFile) do
    begin
      case UpperCase(GetIniString('TasksSettings', 'Task' + IntToStr(I) + '.ItemType', '', IniFile)) of
        'CHECK' : ItemType := 0;
        'RADIO' : ItemType := 1;
        'GROUP' : ItemType := 2;
        else
          ItemType := 0;
      end;
      ItemName := GetIniString('TasksSettings', 'Task' + IntToStr(I) + '.Name', '', IniFile);
      if Pos('cm:', LowerCase(ItemName)) > 0 then
        ItemName := TranslateLanguageNames(ItemName);

      case ItemType of
        0 : Y := TasksList.AddCheckBox(ItemName, '', GetIniInt('TasksSettings', 'Task' + IntToStr(I) + '.Level', 0,0,0, IniFile), GetIniBool('TasksSettings', 'Task' + IntToStr(I) + '.Checked', True, IniFile), GetIniBool('TasksSettings', 'Task' + IntToStr(I) + '.Enabled', True, IniFile), False, True, nil);
        1 : Y := TasksList.AddRadioButton(ItemName, '', GetIniInt('TasksSettings', 'Task' + IntToStr(I) + '.Level', 0,0,0, IniFile), GetIniBool('TasksSettings', 'Task' + IntToStr(I) + '.Checked', True, IniFile), GetIniBool('TasksSettings', 'Task' + IntToStr(I) + '.Enabled', True, IniFile), nil);
        2 : Y := TasksList.AddGroup(ItemName, '', GetIniInt('TasksSettings', 'Task' + IntToStr(I) + '.Level', 0,0,0, IniFile), nil);
      end;
      if ItemType < 2 then
      begin
        CurrSize := GetSizeBytes(GetIniString('TasksSettings', 'Task' + IntToStr(I) + '.Size', '0', IniFile), 0);
        if TasksList.Checked[Y] then
          TasksSize := TasksSize + CurrSize;

        if GetIniBool('TasksSettings', 'ShowTaskSize', False, IniFile) then
          TasksList.ItemSubItem[Y] := FormatBytes(CurrSize, 2, True);

        #if CompactMode
          if GetIniString('TasksSettings', 'Task' + IntToStr(I) + '.Size', '', IniFile) = '' then
            TasksDiskSpaceLabelVisible := False;
        #endif
      end;
      Inc(I);
    end;
    TasksDiskSpaceLabel.Caption := FormatDiskSpaceLabel(SetupMessage(msgComponentsDiskSpaceMBLabel), TasksSize + {#if UseComponents}ComponentsSize{#else}GetSizeBytes(GetIniString('Settings', 'Size', '0', ExpandConstant('{tmp}\Settings.ini')), 0){#endif});
    if GetIniBool('TasksSettings', 'FlatPageMode', False, IniFile) then
    begin
      TasksList.Flat := False;
      TasksList.BorderStyle := bsNone;
      TasksList.ParentColor := True;
      TasksList.MinItemHeight := WizardForm.TasksList.MinItemHeight; {22}
    end;
  end;
#endif

#if CheckCRC && !UseQuickSFV && !UseRapidCRC
procedure CreateHashPageDesign(); forward;
#endif

procedure InitializeWizard();
var
  X: Integer;
  ITop: Integer;
begin
  X := 0;
  ExtractTemporaryFile('Settings.ini');
  ExtractTemporaryFile('ISDone.dll');
  #if VER >= 0x06000000 /* if inno setup 6 or newer */
    WizardForm.CancelButton.Top := WizardForm.NextButton.Top;
    for X := 0 to WizardForm.ComponentCount - 1 do
    begin
      if WizardForm.Components[X] is TNewButton then
        TNewButton(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TNewNotebook then
        TNewNotebook(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TNewStaticText then
        TNewStaticText(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TEdit then
        TEdit(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TNewEdit then
        TNewEdit(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TNewCheckBox then
        TNewCheckBox(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TPasswordEdit then
        TPasswordEdit(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TNewMemo then
        TNewMemo(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TNewComboBox then
        TNewComboBox(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TBevel then
        TBevel(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TBitmapImage then
        TBitmapImage(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TNewRadioButton then
        TNewRadioButton(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TNewCheckListBox then
        TNewCheckListBox(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TNewProgressBar then
        TNewProgressBar(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TRichEditViewer then
        TRichEditViewer(WizardForm.Components[X]).Anchors := [akLeft, akTop]
      else if WizardForm.Components[X] is TPanel then
        TPanel(WizardForm.Components[X]).Anchors := [akLeft, akTop];
    end;
  #endif
  #if Music
    ExtractTemporaryFile('BASS.dll');
    ExtractTemporaryFile('{#MusicFile}');
    if BASS_Init(-1, 44100, 0, 0, 0) and BASS_Start then
    begin
      SoundStream := BASS_StreamCreateFile(False, ExpandConstant('{tmp}\{#MusicFile}'), 0, 0, 0, 0, BASS_UNICODE or BASS_SAMPLE_LOOP);
      if SoundStream <> 0 then
      begin
        BASS_ChannelSetAttribute(SoundStream, BASS_ATTRIB_VOL, BASS_Vol({#MusicVolume}));
        BASS_ChannelPlay(SoundStream, True);
      end;
    end;
  #endif
  #if CheckCRC && UseQuickSFV || UseRapidCRC
    ExtractTemporaryFile('{#HashFile}');
    {#if UseQuickSFV}ExtractTemporaryFile('QuickSFV.exe');{#endif}
    {#if UseRapidCRC}ExtractTemporaryFile('RapidCRC.exe');{#endif}
  #endif
  #if Splash
    ExtractTemporaryFile('{#SplashFile}');
    ShowSplashScreen(WizardForm.Handle, ExpandConstant('{tmp}\{#SplashFile}'), {#SplashFadeIn}, {#SplashShow}, {#SplashFadeOut}, 0, 255, True, $FFFFFF, 10);
  #endif
  {#if UWPGame}ExtractTemporaryFile('UWP_Tool.exe');{#endif}
  {#if UseBatch}ExtractTemporaryFile('{#BatchFileName}');{#endif}
  FileCopy(ExpandConstant('{src}\Records.ini'), ExpandConstant('{tmp}\Records.ini'), False);
  WizardForm.WizardSmallBitmapImage.Hide;
  WizardForm.WelcomeLabel1.Hide;
  WizardForm.WelcomeLabel2.Hide;
  WizardForm.FinishedHeadingLabel.Hide;
  WizardForm.FinishedLabel.Hide;

  #if !CompactMode
    {#if UseSystemReq}SystemReq();{#endif}
    {#if UseLicense}ExtractTemporaryFile('LicenseImage.bmp');{#endif}
    {#if UseInfo}ExtractTemporaryFile('InfoBeforeImage.bmp');{#endif}
    {#if CheckCRC && !UseQuickSFV && !UseRapidCRC}ExtractTemporaryFile('HashCheck.bmp');{#endif}
    {#if UseComponents}ExtractTemporaryFile('SelectComponentsImage.bmp');{#endif}
    {#if UseTasks}ExtractTemporaryFile('SelectTasksImage.bmp');{#endif}
    {#if UseRedists}ExtractTemporaryFile('SelectRedistsImage.bmp');{#endif}
    #if FileExists ("Setup\Banner.bmp")
      ExtractTemporaryFile('Banner.bmp');
    #else
      ExtractTemporaryFile('_WizModernSmallImage.bmp');
    #endif
    #if FileExists("Setup\Finish.bmp")
      ExtractTemporaryFile('Finish.bmp');
      WizardForm.WizardBitmapImage2.Bitmap.LoadFromFile(ExpandConstant('{tmp}\Finish.bmp'));
    #else
      ExtractTemporaryFile('_WizModernImage.bmp');
      WizardForm.WizardBitmapImage2.Bitmap.LoadFromFile(ExpandConstant('{tmp}\_WizModernImage.bmp'));
    #endif
    ExtractTemporaryFile('FolderImage.bmp');
    ExtractTemporaryFile('DiskSpaceImage.bmp');

    {Resize wizardform}
    GrowWizard(ScaleX(103), ScaleY(66));

    WizardForm.InnerPage.Width := ScaleX(600);
    WizardForm.InnerPage.Height := ScaleY(379);
    WizardForm.WizardBitmapImage.Width := ScaleX(600);
    WizardForm.WizardBitmapImage.Height := ScaleY(379);
    WizardForm.WizardBitmapImage2.Width := ScaleX(600);
    WizardForm.WizardBitmapImage2.Height := ScaleY(379);
  #else
    WizardForm.InnerPage.Width := ScaleX(460);
    WizardForm.WizardBitmapImage.Width := ScaleX(0);
    WizardForm.WizardBitmapImage.Height := ScaleY(0);
    WizardForm.WizardBitmapImage2.Width := ScaleX(0);
    WizardForm.WizardBitmapImage2.Height := ScaleY(0);
    WizardForm.OuterNotebook.Hide;
    WizardForm.InnerNotebook.Hide;
  #endif
  WizardForm.WizardBitmapImage.Parent := WizardForm.WelcomePage;
  #if !CompactMode
    WillkommenLabel1               := TLabel.Create(WizardForm);
    WillkommenLabel1.Left          := ScaleX(0);
    WillkommenLabel1.Top           := ScaleY({#WelcomeLabel1Top});
    WillkommenLabel1.Width         := ScaleX(594);
    WillkommenLabel1.Height        := ScaleY(54);
    WillkommenLabel1.AutoSize      := False;
    WillkommenLabel1.WordWrap      := True;
    WillkommenLabel1.Font.Name     := '{#Font}';
    WillkommenLabel1.Font.Size     := DPICalculator({#WelcomeLabel1FontSize});
    WillkommenLabel1.Font.Style    := [fsBold];
    WillkommenLabel1.Font.Color    := ColorConverter(GetValInt('Text', 'FontColor', 0));
    WillkommenLabel1.ShowAccelChar := False;
    WillkommenLabel1.Alignment     := alBottom;
    WillkommenLabel1.Caption       := AppNameOverride(msgWelcomeLabel1);
    WillkommenLabel1.Transparent   := True;
    WillkommenLabel1.Parent        := WizardForm.WelcomePage;
    Centering(WillkommenLabel1);

    WillkommenLabel2               := TLabel.Create(WizardForm);
    WillkommenLabel2.Left          := ScaleX(0);
    WillkommenLabel2.Top           := ScaleY({#WelcomeLabel2Top});
    WillkommenLabel2.Width         := ScaleX(594);
    WillkommenLabel2.Height        := ScaleY(234);
    WillkommenLabel2.AutoSize      := False;
    WillkommenLabel2.WordWrap      := True;
    WillkommenLabel2.Font.Name     := '{#Font}';
    WillkommenLabel2.Font.Size     := DPICalculator({#WelcomeLabel2FontSize});
    WillkommenLabel2.Font.Color    := ColorConverter(GetValInt('Text', 'FontColor', 0));
    WillkommenLabel2.ShowAccelChar := False;
    WillkommenLabel2.Alignment     := alBottom;
    WillkommenLabel2.Caption       := AppNameOverride(msgWelcomeLabel2);
    WillkommenLabel2.Transparent   := True;
    WillkommenLabel2.Parent        := WizardForm.WelcomePage;
    Centering(WillkommenLabel2);

    FertigLabel1               := TLabel.Create(WizardForm);
    FertigLabel1.Left          := ScaleX(0);
    FertigLabel1.Top           := ScaleY({#FinishLabel1Top});
    FertigLabel1.Width         := ScaleX(594);
    FertigLabel1.Height        := ScaleY(54);
    FertigLabel1.AutoSize      := False;
    FertigLabel1.WordWrap      := True;
    FertigLabel1.Font.Name     := '{#Font}';
    FertigLabel1.Font.Size     := DPICalculator({#FinishLabel1FontSize});
    FertigLabel1.Font.Style    := [fsBold];
    FertigLabel1.Font.Color    := ColorConverter(GetValInt('Text', 'FontColor', 0));
    FertigLabel1.ShowAccelChar := False;
    FertigLabel1.Alignment     := alBottom;
    FertigLabel1.Caption       := AppNameOverride(msgFinishedHeadingLabel);
    FertigLabel1.Transparent   := True;
    FertigLabel1.Parent        := WizardForm.FinishedPage;
    Centering(FertigLabel1);

    FertigLabel2               := TLabel.Create(WizardForm);
    FertigLabel2.Left          := ScaleX(0);
    FertigLabel2.Top           := ScaleY({#FinishLabel2Top});
    FertigLabel2.Width         := ScaleX(594);
    FertigLabel2.Height        := ScaleY(234);
    FertigLabel2.AutoSize      := False;
    FertigLabel2.WordWrap      := True;
    FertigLabel2.Font.Name     := '{#Font}';
    FertigLabel2.Font.Size     := DPICalculator({#FinishLabel2FontSize});
    FertigLabel2.Font.Color    := ColorConverter(GetValInt('Text', 'FontColor', 0));
    FertigLabel2.ShowAccelChar := False;
    FertigLabel2.Alignment     := alBottom;
    FertigLabel2.Caption       := AppNameOverride(msgFinishedLabel);
    FertigLabel2.Transparent   := True;
    FertigLabel2.Parent        := WizardForm.FinishedPage;
    Centering(FertigLabel2);
  #endif

  with WizardForm do
  begin
    Caption                 := ExpandConstant('{code:AppName}');
    Position                := poScreenCenter;
    #if !CompactMode
      WizardForm.ClientWidth  := ScaleX(600);
      WizardForm.ClientHeight := ScaleY(429);
    #else
      ClientWidth          := ScaleX(460);
      ClientHeight         := ScaleY(250);
      InnerNotebook.Width  := ClientWidth;
      InnerNotebook.Height := ClientHeight;
      OuterNotebook.Width  := ClientWidth;
      OuterNotebook.Height := ClientHeight;
      WelcomePage.Width    := ClientWidth - 2 * WelcomePage.Left;
      WelcomePage.Height   := ClientWidth - 2 * WelcomePage.Top;
    #endif
  end;

  with WizardForm.NextButton do
  begin
    Parent  := WizardForm;
    #if !CompactMode
      Left    := ScaleX(431);
      Top     := WizardForm.CancelButton.Top;
      Width   := ScaleX(79);
      Height  := ScaleY(23);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    #else
      Left    := ScaleX(379);
      Top     := ScaleY(126);
      Width   := ScaleX(75);
      Height  := ScaleY(23);
    #endif
  end;

  with WizardForm.BackButton do
  begin
    Parent  := WizardForm;
    Left    := ScaleX(351);
    Top     := WizardForm.CancelButton.Top;
    Width   := ScaleX(79);
    Height  := ScaleY(23);
    #if !CompactMode
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    #endif
  end;

  with WizardForm.CancelButton do
  begin
    #if !CompactMode
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    #else
      Parent  := WizardForm;
      Left    := ScaleX(379);
      Top     := ScaleY(76);
      Width   := ScaleX(75);
      Height  := ScaleY(23);
    #endif
  end;

  #if !CompactMode
    BannerImage := TBitmapImage.Create(WizardForm)
    with BannerImage do
    begin
      Parent   := WizardForm.MainPanel;
      Stretch  := True;
      AutoSize := False;
      Left     := ScaleX(0);
      Top      := ScaleY(0);
      Width    := WizardForm.MainPanel.Width
      Height   := WizardForm.MainPanel.Height;
      #if FileExists("Setup\Banner.bmp")
        Bitmap.LoadFromFile(ExpandConstant('{tmp}\Banner.bmp'));
      #else
        Bitmap.LoadFromFile(ExpandConstant('{tmp}\_WizModernSmallImage.bmp'));
      #endif
    end;
  #endif
  ///////////////////////////////////////////////////////////////////////////////////////////////////

  /////////////////////////////////////////// LicensePage ///////////////////////////////////////////
  #if UseLicense && !CompactMode
    LicenseImage := TBitmapImage.Create(WizardForm);
    with LicenseImage do
    begin
      Name             := 'LicenseImage';
      Parent           := WizardForm.LicensePage;
      Stretch          := True;
      AutoSize         := False;
      Left             := ScaleX(0);
      Top              := ScaleY(0);
      Width            := ScaleX(32);
      Height           := ScaleY(32);
      Bitmap.AlphaFormat := afDefined;
      Bitmap.LoadFromFile(ExpandConstant('{tmp}\LicenseImage.bmp'));
    end;

    with WizardForm.LicenseLabel1 do
    begin
      Caption  := WizardForm.LicenseLabel1.Caption
      WordWrap := True;
      Left     := LicenseImage.Left + ScaleX(42);
      Top      := ScaleY(0);
      Width    := ScaleX(488);
      Height   := ScaleY(50);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;

    with WizardForm.LicenseAcceptedRadio do
    begin
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;

    with WizardForm.LicenseNotAcceptedRadio do
    begin
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;

    WizardForm.LicenseMemo.Visible := False;

    LicenseMemo := TNewMemo.Create(WizardForm);
    with LicenseMemo do
    begin
      Parent     := WizardForm.LicensePage;
      Left       := ScaleX(0);
      Top        := ScaleY(50);
      Width      := ScaleX(520);
      Height     := ScaleY(210);
      Color      := TColor($d3d3d3);
      Font.Color := clBlack;
      ScrollBars := ssVertical;
      Text       := StrAsAnsi(WizardForm.LicenseMemo.Text);
      ReadOnly   := True;
    end;
  #endif
  ///////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////////////// InfoBeforePage //////////////////////////////////////////
  #if UseInfo && !CompactMode
    InfoBeforeImage := TBitmapImage.Create(WizardForm);
    with InfoBeforeImage do
    begin
      Name             := 'InfoBeforeImage';
      Parent           := WizardForm.InfoBeforePage;
      Stretch          := True;
      AutoSize         := False;
      Left             := ScaleX(0);
      Top              := ScaleY(0);
      Width            := ScaleX(32);
      Height           := ScaleY(32);
      Bitmap.AlphaFormat := afDefined;
      Bitmap.LoadFromFile(ExpandConstant('{tmp}\InfoBeforeImage.bmp'));
    end;

    WizardForm.InfoBeforeMemo.Visible := False;

    InfoBeforeMemo := TNewMemo.Create(WizardForm);
    with InfoBeforeMemo do
    begin
      Parent     := WizardForm.InfoBeforePage;
      Left       := ScaleX(0);
      Top        := ScaleY(50);
      Width      := ScaleX(520);
      Height     := ScaleY(210);
      Color      := TColor($d3d3d3);
      Font.Color := clBlack;
      ScrollBars := ssVertical;
      Text       := StrAsAnsi(WizardForm.InfoBeforeMemo.Text);
      ReadOnly   := True;
    end;

    with WizardForm.InfoBeforeClickLabel do
    begin
      WordWrap := True;
      Left     := InfoBeforeImage.Left + ScaleX(42);
      Top      := ScaleY(0);
      Width    := ScaleX(488);
      Height   := ScaleY(50);
      Caption  := SetupMessage(msgInfoBeforeLabel);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;
  #endif
  ///////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////// Components ////////////////////////////////////////////
  #if UseComponents
    #if !CompactMode
      ComponentsPage := CreateCustomPage({#if UseSystemReq}SystemReqPage.ID{#else}wpInfoBefore{#endif}, SetupMessage(msgWizardSelectComponents), SetupMessage(msgSelectComponentsDesc));

      SelectComponentsImage := TBitmapImage.Create(WizardForm);
      with SelectComponentsImage do
      begin
        Name             := 'SelectComponentsImage';
        Parent           := ComponentsPage.Surface;
        Stretch          := True;
        AutoSize         := False;
        Left             := ScaleX(0);
        Top              := ScaleY(0);
        Width            := ScaleX(32);
        Height           := ScaleY(32);
        Bitmap.AlphaFormat := afDefined;
        Bitmap.LoadFromFile(ExpandConstant('{tmp}\SelectComponentsImage.bmp'));
      end;
    #endif

    SelectComponentsLabel := TNewStaticText.Create(WizardForm);
    with SelectComponentsLabel do
    begin
      #if !CompactMode
        Parent   := ComponentsPage.Surface;
        Left     := WizardForm.PageDescriptionLabel.Left;
        Top      := 0;
        Width    := ScaleX(488);
        Height   := ScaleY(50);
        WordWrap := True;
        ShowAccelChar := False;
        Caption  := SetupMessage(msgSelectComponentsDesc);
        WizardForm.AdjustLabelHeight(SelectComponentsLabel);
        #ifdef DEBUG_FONT
        Font.Name := '{#Font}';
        Font.Height := ScaleY(FONT_HEIGHT);
        #endif
      #else
        Parent  := WizardForm;
        Left    := ScaleX(6);
        Top     := ScaleY(230);
        Width   := ScaleX(364);
        Height  := ScaleY(14);
        Caption := ExpandConstant('{cm:SelectComponents}');
        Cursor  := crHand;
        OnClick := @ComponentsPageClick;
        Visible := False;
      #endif
    end;

    ComponentsList := TNewCheckListBox.Create(WizardForm);
    with ComponentsList do
    begin
      #if !CompactMode
        Parent := ComponentsPage.Surface;
        Flat   := True;
        Left   := 0;
        Top    := SelectComponentsImage.Top + ScaleY(40);
        Width  := ComponentsPage.SurfaceWidth;
        Height := ComponentsPage.SurfaceHeight - ComponentsList.Top - ScaleY(33);
      #else
        Parent  := WizardForm;
        Left    := ScaleX(6);
        Top     := ScaleY(6);
        Width   := ScaleX(448);
        Height  := ScaleY(212);
        Visible := False;
      #endif
      OnClickCheck := @ComponentsOnCheck;
    end;

    #if CompactMode
      ComponentsOKButton := TNewButton.Create(WizardForm)
      with ComponentsOKButton do
      begin
        Parent  := WizardForm;
        Left    := ScaleX(379);
        Top     := ScaleY(221);
        Width   := ScaleX(75);
        Height  := ScaleY(23);
        Caption := SetupMessage(msgButtonOK);
        OnClick := @ComponentsPageClick;
        Visible := False;
      end;
    #endif

    ComponentsDiskSpaceLabel := TNewStaticText.Create(WizardForm);
    with ComponentsDiskSpaceLabel do
    begin
      #if !CompactMode
        Parent   := ComponentsPage.Surface;
        Left     := 0;
        Top      := ComponentsList.Top + ComponentsList.Height + ScaleY(10);
        Width    := ComponentsPage.SurfaceWidth;
        Height   := ScaleY(18);
        WordWrap := True;
        WizardForm.AdjustLabelHeight(ComponentsDiskSpaceLabel);
        #ifdef DEBUG_FONT
        Font.Name := '{#Font}';
        Font.Height := ScaleY(FONT_HEIGHT);
        #endif
      #else
        Parent  := WizardForm;
        Left    := ScaleX(6);
        Top     := ScaleY(226);
        Width   := ScaleX(372);
        Height  := ScaleY(14);
        AutoSize      := True;
        WordWrap      := False;
        ShowAccelChar := False;
        Visible       := False;
      #endif
      Caption  := FormatDiskSpaceLabel(SetupMessage(msgComponentsDiskSpaceMBLabel), 0);
    end;
    AddComponentsItems;
  #endif

  #if UseTasks
    #if !CompactMode
      TasksPage := CreateCustomPage({#if UseComponents}ComponentsPage.ID{#elif UseSystemReq}SystemReqPage.ID{#else}wpInfoBefore{#endif}, SetupMessage(msgWizardSelectComponents), SetupMessage(msgSelectComponentsDesc));

      SelectTasksImage := TBitmapImage.Create(WizardForm);
      with SelectTasksImage do
      begin
        Name             := 'SelectTasksImage';
        Parent           := TasksPage.Surface;
        Stretch          := True;
        AutoSize         := False;
        Left             := ScaleX(0);
        Top              := ScaleY(0);
        Width            := ScaleX(32);
        Height           := ScaleY(32);
        Bitmap.AlphaFormat := afDefined;
        Bitmap.LoadFromFile(ExpandConstant('{tmp}\SelectTasksImage.bmp'));
      end;
    #endif

    SelectTasksLabel := TNewStaticText.Create(WizardForm);
    with SelectTasksLabel do
    begin
      #if !CompactMode
        Parent   := TasksPage.Surface;
        Left     := WizardForm.PageDescriptionLabel.Left;
        Top      := 0;
        Width    := ScaleX(488);
        Height   := ScaleY(50);
        Caption  := SetupMessage(msgSelectTasksDesc);
        WordWrap := True;
        ShowAccelChar := False;
        WizardForm.AdjustLabelHeight(SelectTasksLabel);
        #ifdef DEBUG_FONT
        Font.Name := '{#Font}';
        Font.Height := ScaleY(FONT_HEIGHT);
        #endif
      #else
        Parent  := WizardForm;
        Left    := ScaleX(6);
        Top     := ScaleY(215);
        Width   := ScaleX(364);
        Height  := ScaleY(14);
        Caption := ExpandConstant('{cm:SelectTasks}');
        Cursor  := crHand;
        OnClick := @TasksPageClick;
        Visible := False;
      #endif
      WordWrap := True;
    end;

    TasksList := TNewCheckListBox.Create(WizardForm);
    with TasksList do
    begin
      #if !CompactMode
        Parent := TasksPage.Surface;
        Flat   := True;
        Left   := 0;
        Top    := SelectTasksImage.Top + ScaleY(40);
        Width  := TasksPage.SurfaceWidth;
        Height := TasksPage.SurfaceHeight - TasksList.Top - ScaleY(33);
      #else
        Parent  := WizardForm;
        Left    := ScaleX(6);
        Top     := ScaleY(6);
        Width   := ScaleX(448);
        Height  := ScaleY(212);
        Visible := False;
      #endif
      OnClickCheck := @TasksOnCheck;
    end;

    #if CompactMode
      TasksOKButton := TNewButton.Create(WizardForm)
      with TasksOKButton do
      begin
        Parent  := WizardForm;
        Left    := ScaleX(379);
        Top     := ScaleY(221);
        Width   := ScaleX(75);
        Height  := ScaleY(23);
        Caption := SetupMessage(msgButtonOK);
        OnClick := @TasksPageClick;
        Visible := False;
      end;
    #endif

    TasksDiskSpaceLabel := TNewStaticText.Create(WizardForm);
    with TasksDiskSpaceLabel do
    begin
      #if !CompactMode
        Parent   := TasksPage.Surface;
        Left     := 0;
        Top      := TasksList.Top + TasksList.Height + ScaleY(10);
        Width    := TasksPage.SurfaceWidth;
        Height   := ScaleY(18);
        WordWrap := True;
        AutoSize := True;
        WizardForm.AdjustLabelHeight(TasksDiskSpaceLabel);
        #ifdef DEBUG_FONT
        Font.Name := '{#Font}';
        Font.Height := ScaleY(FONT_HEIGHT);
        #endif
      #else
        Parent   := WizardForm;
        Left     := ScaleX(6);
        Top      := ScaleY(226);
        Width    := ScaleX(372);
        Height   := ScaleY(14);
        AutoSize := True;
        WordWrap := False;
        Visible  := False;
      #endif
      Caption  := FormatDiskSpaceLabel(SetupMessage(msgComponentsDiskSpaceMBLabel), 0);
    end;
    AddTasksItems;
  #endif
  ///////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////// SelectDirPage //////////////////////////////////////////
  #if !CompactMode
    FolderImage := TBitmapImage.Create(WizardForm);
    with FolderImage do
    begin
      Name             := 'FolderImage';
      Parent           := WizardForm.SelectDirPage;
      Stretch          := True;
      AutoSize         := False;
      Left             := ScaleX(0);
      Top              := ScaleY(0);
      Width            := ScaleX(32);
      Height           := ScaleY(32);
      Bitmap.AlphaFormat := afDefined;
      Bitmap.LoadFromFile(ExpandConstant('{tmp}\FolderImage.bmp'));
    end;
  
    with WizardForm.SelectDirLabel do
    begin
      Caption  := AppNameOverride(msgSelectDirLabel3);
      Left     := FolderImage.Left + ScaleX(42);
      Top      := ScaleY(0);
      Width    := ScaleX(480);
      WordWrap := True;
      AutoSize := True;
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;

    with WizardForm.SelectDirBrowseLabel do
    begin
      Caption := SetupMessage(msgReadyMemoDir);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;

    with WizardForm.SelectStartMenuFolderBrowseLabel do
    begin
      Parent   := WizardForm.SelectDirPage;
      Caption  := SetupMessage(msgReadyMemoGroup);
      Left     := ScaleX(0);
      Top      := ScaleY(104);
      Width    := ScaleX(400);
      Height   := ScaleY(14);
      WordWrap := True;
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;
  #endif

  with WizardForm.DirEdit do
  begin
    #if !CompactMode
      Parent   := WizardForm.InnerPage;
      Left     := ScaleX(40);
      Top      := ScaleY(133);
      Width    := ScaleX(420);
      Height   := ScaleY(21);
    #else
      Parent   := WizardForm;
      Left     := ScaleX(6);
      Top      := ScaleY(6);
      Width    := ScaleX(364);
      Height   := ScaleY(21);
    #endif
    Text     := WizardForm.DirEdit.Text;
  end;

  with WizardForm.DirBrowseButton do
  begin
    #if !CompactMode
      Parent   := WizardForm.InnerPage;
      Left     := ScaleX(470);
      Top      := ScaleY(132);
      Width    := ScaleX(90);
      Height   := ScaleY(23);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    #else
      Parent   := WizardForm;
      Left     := ScaleX(379);
      Top      := ScaleY(6);
      Width    := ScaleX(75);
      Height   := ScaleY(23);
      Caption  := '. . .'
    #endif
  end;

  ITop := 150;
  #if !CompactMode
    with WizardForm.GroupEdit do
    begin
      Parent   := WizardForm.SelectDirPage;
      Left     := ScaleX(0);
      Top      := ScaleY(121);
      Width    := ScaleX(420);
      Height   := ScaleY(21);
      Text     := WizardForm.GroupEdit.Text;
    end;

    with WizardForm.GroupBrowseButton do
    begin
      Parent   := WizardForm.InnerPage;
      Left     := ScaleX(470);
      Top      := ScaleY(192);
      Width    := ScaleX(90);
      Height   := ScaleY(23);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;

    StartMenuCB := TNewCheckBox.Create(WizardForm);
    with StartMenuCB do
    begin
      Parent   := WizardForm.SelectDirPage;
      Left     := ScaleX(8);
      Top      := ScaleY(150);
      Width    := ScaleX(333);
      Height   := ScaleY(17);
      Caption  := WizardForm.NoIconsCheck.Caption;
      OnClick  := @StartMenuCBClick;
      Checked  := False;
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;
  #endif

  #if !UpdateMode
    UninstallCB := TNewCheckBox.Create(WizardForm);
    with UninstallCB do
    begin
      #if !CompactMode
        Parent   := WizardForm.SelectDirPage;
        Left     := ScaleX(270);
        Top      := ScaleY(150);
        Width    := ScaleX(240);
        #ifdef DEBUG_FONT
        Font.Name := '{#Font}';
        Font.Height := ScaleY(FONT_HEIGHT);
        #endif
      #else
        Parent   := WizardForm;
        Left     := ScaleX(6);
        Top      := ScaleY(57);
        Width    := ScaleX(364);
      #endif
      Height     := ScaleY(17);
      Caption    := ExpandConstant('{cm:CreateUninstall}');
      Checked    := True;
    end;
  #endif

  #if CompactMode && UseRedists
    RedistCB := TNewCheckBox.Create(WizardForm);
    with RedistCB do
    begin
      Parent  := WizardForm;
      Left    := ScaleX(6);
      Top     := ScaleY(93);
      Width   := ScaleX(364);
      Height  := ScaleY(17);
      Caption := ExpandConstant('{cm:InstallRedistCM}');
    end;
  #endif

  LimitRAMCB := TNewCheckBox.Create(WizardForm);
  with LimitRAMCB do
  begin
    #if !CompactMode
      Parent   := WizardForm.SelectDirPage;
      Left     := ScaleX(8);
      Top      := ScaleY(170);
      Width    := ScaleX(333);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    #else
      Parent   := WizardForm;
      Left     := ScaleX(6);
      #if UseRedists
      Top      := ScaleY(111);
      #else
      Top      := ScaleY(93);
      #endif
      Width    := ScaleX(364);
      Height   := ScaleY(17);
    #endif
    Caption  := ExpandConstant('{cm:LimitRAMCB}');
    Enabled  := True;
  end;

  NeedSizeFreeSizeBevel := TBevel.Create(WizardForm);
  with NeedSizeFreeSizeBevel do
  begin
    #if !CompactMode
      Parent := WizardForm.SelectDirPage;
      Left   := ScaleX(0);
      Top    := ScaleY(220);
      Width  := ScaleX(520);
      Height := ScaleY(39);
    #else
      Parent := WizardForm;
      Left   := ScaleX(6);
      Top    := ScaleY(29);
      Width  := ScaleX(364);
      Height := ScaleY(20);
    #endif
    Shape  := bsFrame;
    Style  := bsLowered;
  end;

  FreeSpaceLabel := TLabel.Create(WizardForm);
  with FreeSpaceLabel do
  begin
    #if !CompactMode
      Parent     := WizardForm.SelectDirPage;
      Left       := NeedSizeFreeSizeBevel.Left + ScaleX(42);
      Top        := ScaleY(224);
      Width      := ScaleX(450);
      Height     := ScaleY(14);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    #else
      Parent     := WizardForm;
      Left       := ScaleX(8);
      Top        := ScaleY(32);
      Width      := ScaleX(180);
      Height     := ScaleY(14);
    #endif
    Font.Style := [fsBold];
  end;

  NeedSpaceLabel := TLabel.Create(WizardForm);
  with NeedSpaceLabel do
  begin
    #if !CompactMode
      Parent     := WizardForm.SelectDirPage;
      Left       := NeedSizeFreeSizeBevel.Left + ScaleX(42);
      Top        := ScaleY(242);
      Width      := ScaleX(450);
      Height     := ScaleY(14);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    #else
      Parent     := WizardForm;
      Left       := ScaleX(256);
      Top        := ScaleY(32);
      Width      := ScaleX(180);
      Height     := ScaleY(14);
    #endif
    Font.Style := [fsBold];
  end;
  WizardForm.DirEdit.OnChange := @GetFreeSpaceCaption;

  #if !CompactMode
    DiskSpaceImage := TBitmapImage.Create(WizardForm);
    with DiskSpaceImage do
    begin
      Parent           := WizardForm.SelectDirPage;
      Stretch          := True;
      AutoSize         := False;
      Left             := FolderImage.Left + ScaleX(2);
      Top              := FreeSpaceLabel.Top + ScaleY(1);
      Width            := ScaleX(32);
      Height           := ScaleY(32);
      Bitmap.AlphaFormat := afDefined;
      Bitmap.LoadFromFile(ExpandConstant('{tmp}\DiskSpaceImage.bmp'));
    end;

    #if INISettings
      with WizardForm.UserInfoNameLabel do
      begin
        Parent   := WizardForm;
        Left     := ScaleX(40);
        Top      := ScaleY(340);
        Caption  := ExpandConstant('{cm:EnterPlayerName}');
        #ifdef DEBUG_FONT
        Font.Name := '{#Font}';
        Font.Height := ScaleY(FONT_HEIGHT);
        #endif
      end;

      with WizardForm.UserInfoNameEdit do
      begin
        Parent   := WizardForm;
        Left     := (WizardForm.UserInfoNameLabel.Left);
        Top      := (WizardForm.UserInfoNameLabel.Top + ScaleY(15));
        Width    := ScaleX(200);
        Height   := ScaleY(21);
        Text     := GetUserNameString;
      end;
    #endif
  #endif
  ///////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////// CRC Page /////////////////////////////////////////////
  #if CheckCRC
    HashCheckCB := TNewCheckBox.Create(WizardForm);
    with HashCheckCB do
    begin
      Caption := ExpandConstant('{cm:CheckCRC}');
      #if !CompactMode
        Parent   := WizardForm.SelectDirPage;
        Left     := ScaleX(270);
        Top      := ScaleY(170);
        Width    := ScaleX(240);
        Height   := ScaleY(17);
        #ifdef DEBUG_FONT
        Font.Name := '{#Font}';
        Font.Height := ScaleY(FONT_HEIGHT);
        #endif
      #else
        Parent  := WizardForm;
        Left    := ScaleX(6);
        Top     := ScaleY(129);
        Width   := ScaleX(364);
        Height  := ScaleY(17);
        Enabled := {#CheckCRC ? "True" : "False"};
      #endif
      Checked := {#StartCRC && !UseQuickSFV && !UseRapidCRC ? "True" : "False"};
    end;
    #if !UseQuickSFV && !UseRapidCRC
      CreateHashPageDesign();
    #endif
  #endif
  ///////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////////// Website / Music / About /////////////////////////////////////
  #if !CompactMode
    #if WebsiteButton && Music
      WebsiteButton := TNewButton.Create(WizardForm);
      with WebsiteButton do
      begin
        Parent  := WizardForm;
        Left    := ScaleX(13);
        Top     := WizardForm.NextButton.Top;
        Width   := ScaleX(156);
        Height  := ScaleY(23);
        #if WebBtnName == ""
          Caption := ExpandConstant('{cm:WebsiteText}');
        #else
          Caption := '{#WebBtnName}';
        #endif
        OnClick := @WebsiteClick;
        #ifdef DEBUG_FONT
        Font.Name := '{#Font}';
        Font.Height := ScaleY(FONT_HEIGHT);
        #endif
      end;

      MusicButton := TNewButton.Create(WizardForm);
      with MusicButton do
      begin
        Parent  := WizardForm;
        Left    := ScaleX(170);
        Top     := WizardForm.NextButton.Top;
        Width   := ScaleX(75);
        Height  := ScaleY(23);
        Caption := ExpandConstant('{cm:MusicButtonCaptionSoundOn}');
        OnClick := @MusicButtonClick;
        #ifdef DEBUG_FONT
        Font.Name := '{#Font}';
        Font.Height := ScaleY(FONT_HEIGHT);
        #endif
      end;
    #endif

    #if !WebsiteButton && Music
      MusicButton := TNewButton.Create(WizardForm);
      with MusicButton do
      begin
        Parent  := WizardForm;
        Left    := ScaleX(13);
        Top     := WizardForm.NextButton.Top;
        Width   := ScaleX(75);
        Height  := ScaleY(23);
        Caption := ExpandConstant('{cm:MusicButtonCaptionSoundOn}');
        OnClick := @MusicButtonClick;
        #ifdef DEBUG_FONT
        Font.Name := '{#Font}';
        Font.Height := ScaleY(FONT_HEIGHT);
        #endif
      end;
    #endif

    #if WebsiteButton && !Music
      WebsiteButton := TNewButton.Create(WizardForm);
      with WebsiteButton do
      begin
        Parent  := WizardForm;
        Left    := ScaleX(13);
        Top     := WizardForm.NextButton.Top;
        Width   := ScaleX(156);
        Height  := ScaleY(23);
        #if WebBtnName == ""
          Caption := ExpandConstant('{cm:WebsiteText}');
        #else
          Caption := '{#WebBtnName}';
        #endif
        OnClick := @WebsiteClick;
        #ifdef DEBUG_FONT
        Font.Name := '{#Font}';
        Font.Height := ScaleY(FONT_HEIGHT);
        #endif
      end;
    #endif

    AboutButton := TNewButton.Create(WizardForm);
    with AboutButton do
    begin
      Parent     := WizardForm;
      Left       := ScaleX(579);
      Top        := ScaleY(2);
      Width      := ScaleX(20);
      Height     := ScaleY(20);
      Caption    := '?'
      Font.Style := [fsBold];
      OnClick    := @AboutButtonClick;
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;
  #else
    #if Music
      MusicButton := TNewButton.Create(WizardForm);
      with MusicButton do
      begin
        Parent  := WizardForm;
        Left    := ScaleX(379);
        Top     := ScaleY(31);
        Width   := ScaleX(75);
        Height  := ScaleY(23);
        Caption := ExpandConstant('{cm:MusicButtonCaptionSoundOn}');
        OnClick := @MusicButtonClick;
      end;
    #endif

    AboutButtonCM := TNewButton.Create(WizardForm);
    with AboutButtonCM do
    begin
      Parent  := WizardForm;
      Left    := ScaleX(379);
      Top     := ScaleY(230);
      Width   := ScaleX(75);
      Height  := ScaleY(14);
      Caption := '?';
      OnClick := @AboutButtonClick;
    end;

    #if UseInfo
      InfoButtonCM := TNewButton.Create(WizardForm);
      with InfoButtonCM do
      begin
        Parent  := WizardForm;
        Left    := ScaleX(379);
        Top     := ScaleY(214);
        Width   := ScaleX(75);
        Height  := ScaleY(14);
        Caption := 'i';
        OnClick := @InfoButtonClick;
      end;
    #endif
  #endif
  ///////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////////////////// Redists /////////////////////////////////////////////
  #if UseRedists
    #if !CompactMode
      SelectRedistsImage := TBitmapImage.Create(WizardForm);
      with SelectRedistsImage do
      begin
        Name             := 'SelectRedistsImage';
        Parent           := WizardForm.ReadyPage;
        Stretch          := True;
        AutoSize         := False;
        Left             := ScaleX(0);
        Top              := ScaleY(0);
        Width            := ScaleX(32);
        Height           := ScaleY(32);
        Bitmap.AlphaFormat := afDefined;
        Bitmap.LoadFromFile(ExpandConstant('{tmp}\SelectRedistsImage.bmp'));
      end;

      with WizardForm.ReadyLabel do
      begin
        Caption  := WizardForm.SelectTasksLabel.Caption
        WordWrap := True;
        Left     := SelectRedistsImage.Left + ScaleX(42);
        Top      := ScaleY(0);
        Width    := ScaleX(488);
        Height   := ScaleY(50);
        #ifdef DEBUG_FONT
        Font.Name := '{#Font}';
        Font.Height := ScaleY(FONT_HEIGHT);
        #endif
      end;

      RedistsList := TNewCheckListBox.Create(WizardForm);
      with RedistsList do
      begin
        Left             := ScaleX(5);
        Top              := ScaleY(55);
        Width            := ScaleX(512);
        Height           := ScaleY(210);
        RedistsList.Flat := True;
        RedistsList.Parent := WizardForm.ReadyPage;
        #sub AddRedistItem
          #if YesNo(ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Enable", "1"))
            #define public ItemLevel Max(0, Int(ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Level", "0"), 0))
            #define public ItemType LowerCase(Trim(ReadIni(Settings, "Redists", "Redist" + Str(i) + ".ItemType", "")))
            #if ItemType == "group"
              RedistsList.AddGroup('{#ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Name", "")}', '', {#ItemLevel}, nil);
            #else
              #if ItemType == "radio"
                RedistsList.AddRadioButton('{#ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Name", "")}', '', {#ItemLevel}, {#YesNo(ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Checked", "1")) ? "True" : "False"}, {#YesNo(ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Enabled", "1")) ? "True" : "False"}, nil);
              #else
                RedistsList.AddCheckBox('{#ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Name", "")}', '', {#ItemLevel}, {#YesNo(ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Checked", "1")) ? "True" : "False"}, {#YesNo(ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Enabled", "1")) ? "True" : "False"}, False, True, nil);
              #endif
            #endif
          #endif
        #endsub
        #for {i = 1; (ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Name", "") != ""); i++} AddRedistItem
      end;
    #endif
  #endif
  ///////////////////////////////////////////////////////////////////////////////////////////////////

   ///////////////////////////////////////// Installing Page /////////////////////////////////////////
  with WizardForm.ProgressGauge do
  begin
    Parent := WizardForm;
    #if !CompactMode
      Left   := ScaleX(6);
      Top    := ScaleY(0);
      Width  := ScaleX(586);
      Height := ScaleY(24);
    #else
      Left   := ScaleX(6);
      Top    := ScaleY(176);
      Width  := ScaleX(364);
      Height := ScaleY(21);
    #endif
    Max    := 1000;
  end;

  PauseButton := TNewButton.Create(WizardForm);
  with PauseButton do
  begin
    Parent  := WizardForm;
    #if !CompactMode
      Left    := (WizardForm.CancelButton.Left - WizardForm.CancelButton.Width) - ScaleX(25);
      Top     := WizardForm.CancelButton.Top;
      Width   := WizardForm.CancelButton.Width;
      Height  := WizardForm.CancelButton.Height;
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    #else
      Left    := ScaleX(379);
      Top     := ScaleY(101);
      Width   := ScaleX(75);
      Height  := ScaleY(23);
    #endif
    Caption := ExpandConstant('{cm:Pause}');
    OnClick := @PauseButtonClick;
  end;

  #if UseInstallBackground && !CompactMode
    BackgroundCB := TNewCheckBox.Create(WizardForm);
    with BackgroundCB do
    begin
      Parent  := WizardForm;
      Left    := ScaleX(0);
      Top     := ScaleY(0);
      Width   := ScaleX(0);
      Height  := ScaleY(0);
      Visible := False;
      Checked := False;
    end;

    BackgroundButton := TNewButton.Create(WizardForm);
    with BackgroundButton do
    begin
      Parent  := WizardForm;
      Left    := ScaleX(13);
      Top     := ScaleY(394);
      Width   := ScaleX(156);
      Height  := ScaleY(23);
      Caption := ExpandConstant('{cm:BackgroundON}');
      OnClick := @BackgroundButtonClick;
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    end;
  #endif

  PercentLabel := TNewStaticText.Create(WizardForm);
  with PercentLabel do
  begin
    Parent     := WizardForm.ProgressGauge.Parent;
    #if !CompactMode
      Left       := (WizardForm.ProgressGauge.Width / 2) - ScaleX(10);
      Top        := ScaleY(69);
      Width      := ScaleX(20);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    #else
      Left       := ScaleX(WizardForm.ProgressGauge.Width / 2) - ScaleX(10);
      Top        := ScaleY(198);
      Width      := ScaleX(20);
    #endif
    Font.Style := [fsBold];
  end;

  ElapsedLabel := TNewStaticText.Create(WizardForm);
  with ElapsedLabel do
  begin
    Parent   := WizardForm.ProgressGauge.Parent;
    Left     := WizardForm.ProgressGauge.Left;
    #if !CompactMode
      Top      := ScaleY(69);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    #else
      Top      := ScaleY(198);
    #endif
    AutoSize := True;
  end;

  RemainingLabel := TNewStaticText.Create(WizardForm);
  with RemainingLabel do
  begin
    Parent   := WizardForm.ProgressGauge.Parent;
    #if !CompactMode
      Left     := ScaleX(437);
      Top      := ScaleY(69);
      Height   := ScaleY(14);
      #ifdef DEBUG_FONT
      Font.Name := '{#Font}';
      Font.Height := ScaleY(FONT_HEIGHT);
      #endif
    #else
      Left     := ScaleX(256);
      Top      := ScaleY(198);
    #endif
    AutoSize := True;
  end;
///////////////////////////////////////////////////////////////////////////////////////////////////
end;


#if !CompactMode && UseInstallBackground
  procedure InitializeSlideShow(hWnd: HWND; Left, Top, Width, Height: Integer; Animate: Boolean; Stretch: Integer);  external 'InitializeSlideShow@{tmp}\IsSlideShow.dll stdcall delayload';
  procedure DeinitializeSlideShow; external 'DeinitializeSlideShow@{tmp}\IsSlideShow.dll stdcall delayload';
  procedure ShowImage(iPath: PAnsiChar; Effect: Integer); external 'ShowImage@{tmp}\IsSlideShow.dll stdcall delayload';

  function GetSystemMetrics(nIndex : Integer): Integer; external 'GetSystemMetrics@user32 stdcall delayload';
  function SetTimer(hWnd, nIDEvent, uElapse, lpTimerFunc: LongWord): LongWord; external 'SetTimer@user32.dll stdcall delayload';
  function KillTimer(hWnd, nIDEvent: LongWord): LongWord; external 'KillTimer@user32.dll stdcall delayload';

  procedure OnSlideTimerProc(hWnd, uMsg, idEvent, dwTime: LongWord);
  begin
    CurrPic := CurrPic + 1;
    if not FileExists(ExpandConstant('{tmp}\' + IntToStr(CurrPic) + '.jpg')) then CurrPic := 1;
    ShowImage(ExpandConstant('{tmp}\' + IntToStr(CurrPic) + '.jpg'), 1);
  end;

  procedure MakeSlideShow();
  begin
    ExtractTemporaryFile('IsSlideShow.dll');
    BackgroundForm := TForm.Create(nil);
    with BackgroundForm do
    begin
      BorderStyle := bsNone;
      Color := clBlack;
      Left := ScaleX(0);
      Top := ScaleY(0);
      Width := ScaleX(GetSystemMetrics(0));
      Height := ScaleY(GetSystemMetrics(1));
      Visible := True;
      Enabled := False;
    end;
    #sub ExtractFile2
      ExtractTemporaryFile('{#i}.jpg');
    #endsub
    #for {i = 1; FileExists("Setup\Background\" + Str(i) + ".jpg") != 0; i++} ExtractFile2
    CurrPic := 1;
    if FileExists(ExpandConstant('{tmp}\' +  IntToStr(CurrPic) + '.jpg')) then
    begin
      BackgroundForm.Show;
      #if Animation == "1"
        InitializeSlideShow(BackgroundForm.Handle, 0, 0, GetSystemMetrics(0), GetSystemMetrics(1), True, 1);
      #else
        InitializeSlideShow(BackgroundForm.Handle, 0, 0, GetSystemMetrics(0), GetSystemMetrics(1), False, 1);
      #endif
      ShowImage(ExpandConstant('{tmp}\' +  IntToStr(CurrPic) + '.jpg'), 1);
      #if VER >= 0x06000000
        SlideTimerID := SetTimer(0, 0, {#Duration}, CreateCallBack(@OnSlideTimerProc));
      #else
        if not FileExists(ExpandConstant('{tmp}\ISDone.dll')) then
          ExtractTemporaryFileEx('ISDone.dll');
        SlideTimerID := SetTimer(0, 0, {#Duration}, WrapTimerProc(@OnSlideTimerProc, 4));
      #endif
    end;
  end;
#endif

{ DiskSpan GUI functions - BEGIN }
function MergeFileCallback(const State: TSplitState; const SrcFile, DstFile: WideString; SplitPos, MinProg, MaxProg: Integer; SrcPos, SrcSize, DstPos, DstSize: Extended): Boolean;
var
  Progress: Integer;
  SourcePct: Integer;
  DestinPct: Integer;
begin
  if State <> ssRead then
  begin
    SourcePct := Round(SrcPos * 1000 / DSG_MaxFloat(1, SrcSize));
    DestinPct := Round(DstPos * 1000 / DSG_MaxFloat(1, DstSize));
    Progress  := Round(SrcPos * MaxProg / DSG_MaxFloat(1, SrcSize * 1000)) + MinProg;
    WizardForm.FileNameLabel.Caption := FmtMessage(CustomMessage('MergingFile'), [ExtractFileName(SrcFile), ExtractFileName(DstFile), IntToStr(SourcePct div 10) + '.' + IntToStr(SourcePct mod 10), IntToStr(DestinPct div 10) + '.' + IntToStr(DestinPct mod 10)]);
    if Progress <= 1000 then
      WizardForm.ProgressGauge.Position := Progress;
  end;
  Result := ISDoneCancel = 0;
end;

function ProgressCallback(OveralPct, CurrentPct: Integer; CurrentFile, TimeStr1, TimeStr2, TimeStr3: PAnsiChar): LongWord;
var
  Progress: Integer;
begin
  Progress := Round(SplitPct + Double(OveralPct));
  if Progress <= 1000 then
    WizardForm.Progressgauge.Position := Progress;

  WizardForm.FileNameLabel.Caption := FmtMessage(CustomMessage('Extracting'), [MinimizePathName(
    IfThen(ArcSubDir = '', '', AddBackSlash('...\' + ArcSubDir)) + CurrentFile, WizardForm.FileNameLabel.Font, WizardForm.FileNameLabel.Width - DSG_GetTextWidth(CustomMessage('Extracting'), WizardForm.FileNameLabel.Font))]);
  PercentLabel.Caption := IntToStr(Progress div 10) + '.' + Chr(48 + Progress mod 10) + '%';
  ElapsedLabel.Caption := FmtMessage(CustomMessage('ElapsedTime'), [TimeStr2]);
  RemainingLabel.Caption := FmtMessage(CustomMessage('RemainingTime'), [TimeStr1]);
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

procedure DSG_RefreshSelectedItems();
begin
  if not Assigned(DSG_LangList) then
  begin
    DSG_LangList := TStringList.Create;
  end;
  DSG_LangList.Clear;
  case LowerCase(ActiveLanguage) of
    'czech'            : DSG_LangList.Append('CZ');
    'english'          : DSG_LangList.Append('EN');
    'french'           : DSG_LangList.Append('FR');
    'german'           : DSG_LangList.Append('DE');
    'italian'          : DSG_LangList.Append('IT');
    'polish'           : DSG_LangList.Append('PL');
    'portuguesebrazil' : DSG_LangList.Append('PTBR');
    'russian'          : DSG_LangList.Append('RU');
    'spanish'          : DSG_LangList.Append('ES');
  end;
  #if UseComponents
  if not Assigned(DSG_CompList) then
  begin
    DSG_CompList := TStringList.Create;
  end;
  DSG_CompList.Clear;
  for I := 0 to ComponentsList.Items.Count - 1 do
    if ComponentsList.Checked[I] then
      DSG_CompList.Append(IntToStr(I + 1));
  #endif
  #if UseTasks
  if not Assigned(DSG_TaskList) then
  begin
    DSG_TaskList := TStringList.Create;
  end;
  DSG_TaskList.Clear;
  for I := 0 to TasksList.Items.Count - 1 do
    if TasksList.Checked[I] then
      DSG_TaskList.Append(IntToStr(I + 1));
  #endif
end;
{ DiskSpan GUI functions - END }

#if CheckCRC && !UseQuickSFV && !UseRapidCRC
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
begin
  if GetArrayLength(HashFileList) > 0 then
  begin
    FileList := TStringList.Create;
    PathList := TStringList.Create;
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
          Y := PathList.IndexOf(HashFileList[I].BasePath);
          if Y < 0 then
          begin
            Y := PathList.Add(HashFileList[I].BasePath);
            FileList.Add(GenerateUniqueName(ExpandConstant('{tmp}'), '.dat'));
          end;
          MergeHashFile(HashFileList[I].FileName, FileList.Strings[Y]);
        end;
      end;
      SetArrayLength(HashFileList, FileList.Count);
      for I := 0 to FileList.Count - 1 do
      begin
        HashFileList[I].FileName := FileList.Strings[I];
        HashFileList[I].BasePath := PathList.Strings[I];
      end;
    finally
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
  end;
  HashProgressBar.Position := FileProgress;
  HashProgressGauge.Position := HashPrevProgress + Round(TotalProgress * HashFileList[HashListItem].PctOfTotal / 1000000);
  #if !CompactMode
  HashStatusLabel.Caption := FmtMessage(ExpandConstant('{cm:HashStatusLabel}'), [IntToStr(FileCounted), IntToStr(HashTotalFiles), IntToStr(HashProgressGauge.Position div 10) + '.' + IntToStr(HashProgressGauge.Position mod 10)]);
  HashResultLabel.Caption := FmtMessage(ExpandConstant('{cm:HashResultLabel}'), [IntToStr(HashOk), IntToStr(HashMissing), IntToStr(HashBad)]);
  #else
  HashStatusLabel.Caption := FmtMessage(ExpandConstant('{cm:HashStatusLabel}'), [IntToStr(HashProgressGauge.Position div 10) + '%']);
  #endif
  HashFileLabel.Caption := FmtMessage(ExpandConstant('{cm:HashFileLabel}'), [IfThen(Pos(AddBackslash(HashFileList[HashListItem].BasePath), TrimLeft(FileName)) = 1, '...' + Copy(TrimLeft(FileName), Length(AddBackslash(HashFileList[HashListItem].BasePath)), Length(FileName)), FileName), FormatBytes(FileSize * FileProgress / 100, 2, False), FormatBytes(FileSize, 2, False)]) + ' ' + IntToStr(FileProgress) + '%';
  DSG_ProcessMessages();
  Result := HashCancel;
end;

procedure NextBtnClick(Sender: TObject);
begin
  WizardForm.NextButton.Enabled := True;
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
  HashHdrLabel.Caption := ExpandConstant('{cm:HashPageTitle}');
  HashNextButton.Caption := ExpandConstant('{cm:HashPause}');
  HashBackButton.Caption := ExpandConstant('{cm:HashStop}');
  HashNextButton.OnClick := @PauseHashClick;
  HashBackButton.OnClick := @StopHashClick;
  #if CompactMode
  HashCancelButton.Show;
  #endif
  { checking... }
  HashOk := 0;
  HashBad := 0;
  HashMissing := 0;
  HashInfoMemo.Clear;
  HashStarted := True;
  HashCancel := False;
  HashAborted := False;
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
    HashStatusLabel.Caption := FmtMessage(ExpandConstant('{cm:HashStatusLabel}'), ['0', '0', '0']);
    HashResultLabel.Caption := FmtMessage(ExpandConstant('{cm:HashResultLabel}'), ['0', '0']);
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
    for I := 0 to GetArrayLength(HashFileList) - 1 do
    begin
      HashFileList[I].PctOfTotal := Double(HashFileList[I].FilesCount) * 1000000 / Double(HashTotalFiles);
    end;
    for HashListItem := 0 to GetArrayLength(HashFileList) - 1 do
    begin
      HashPrevProgress := HashProgressGauge.Position;
      HashResult := VerifyHashesAutoFromFile(HashFileList[HashListItem].FileName, HashFileList[HashListItem].BasePath, GetPreviouslyVerifiedFileCount(HashListItem = 0, True), False, @VerifyHashCallback);
      if HashResult = H_PROCESS_ABORTED then
        Break;
    end;
    HashResultLabel.Caption := FmtMessage(ExpandConstant('{cm:HashResultLabel}'), [IntToStr(HashOk), IntToStr(HashMissing), IntToStr(HashBad)]);
    HashLogMemo.Lines.Text := String(GetHashLogString(True));
    SendMessage(HashLogMemo.Handle, WM_VSCROLL, SB_BOTTOM, 0);
  end;
  #if CompactMode
  HashCancelButton.Hide;
  #endif
  if HashResult = H_PROCESS_ABORTED then
  begin
    HashNextButton.Caption := ExpandConstant('{cm:HashVerify}');
    //HashBackButton.Caption := ExpandConstant('{cm:HashNext}');
    HashBackButton.Caption := SetupMessage(msgButtonFinish);
    HashNextButton.OnClick := @VerifyHashClick;
    HashBackButton.OnClick := @NextBtnClick;
  end else
  begin
    //HashNextButton.Caption := ExpandConstant('{cm:HashNext}');
    HashNextButton.Caption := SetupMessage(msgButtonFinish);
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
  DSG_ProcessMessages();
  if HashAborted then
    WizardForm.NextButton.OnClick(nil);
end;

procedure HashBackButtonOnClick(Sender: TObject);
begin
  HashNextButton.Caption := ExpandConstant('{cm:HashVerify}');
  WizardForm.NextButton.OnClick(nil);
end;

procedure CreateHashPageDesign();
begin
  ExtractTemporaryFile('XHashEx.dll');
  HashPage := CreateCustomPage({#CompactMode ? "wpInstalling" : "wpInfoAfter"}, '', '');

  #if !CompactMode
  HashImage := TBitmapImage.Create(WizardForm);
  with HashImage do
  begin
    Parent   := HashPage.Surface;
    Stretch  := True;
    AutoSize := False;
    Left     := ScaleX(0);
    Top      := ScaleY(0);
    Width    := ScaleX(32);
    Height   := ScaleY(32);
    Bitmap.AlphaFormat := afDefined;
    Bitmap.LoadFromFile(ExpandConstant('{tmp}\HashCheck.bmp'));
  end;
  #endif
  HashHdrLabel := TNewStaticText.Create(WizardForm);
  with HashHdrLabel do
  begin
    Parent   := HashPage.Surface;
    Caption  := ExpandConstant('{cm:HashWaitingLabel}');
    #if !CompactMode
      Parent := HashPage.Surface;
      Left   := ScaleX(42);
      Top    := ScaleY(0);
      Width  := ScaleX(488);
      Height := ScaleY(15);
    #else
      Parent := WizardForm;
      Left   := ScaleX(0);
      Top    := ScaleY(0);
      Width  := ScaleX(0);
      Height := ScaleY(0);
    #endif
    WordWrap := True;
  end;
  HashFileLabel := TNewStaticText.Create(WizardForm);
  with HashFileLabel do begin
    AutoSize := False;
    #if !CompactMode
      Parent := HashPage.Surface;
      Left   := ScaleX(4);
      Top    := ScaleY(38);
      Width  := ScaleX(520);
      Height := ScaleY(18);
    #else
      Parent := WizardForm;
      Left   := ScaleX(6);
      Top    := ScaleY(6);
      Width  := ScaleX(448);
      Height := ScaleY(14);
    #endif
  end;
  HashProgressBar := TNewProgressBar.Create(WizardForm);
  with HashProgressBar do begin
    #if !CompactMode
      Parent := HashPage.Surface;
      Left   := ScaleX(0);
      Top    := ScaleY(56);
      Width  := ScaleX(520);
      Height := ScaleY(15);
    #else
      Parent := WizardForm;
      Left   := ScaleX(6);
      Top    := ScaleY(23);
      Width  := ScaleX(448);
      Height := ScaleY(14);
    #endif
    Max      := 100;
    Position := 0;
  end;
  HashStatusLabel := TNewStaticText.Create(WizardForm);
  with HashStatusLabel do begin
    AutoSize := False;
    #if !CompactMode
      Parent := HashPage.Surface;
      Left   := ScaleX(4);
      Top    := ScaleY(80);
      Width  := ScaleX(256);
      Height := ScaleY(18);
    #else
      Parent := WizardForm;
      Left   := ScaleX(6);
      Top    := ScaleY(43);
      Width  := ScaleX(448);
      Height := ScaleY(14);
    #endif
  end;
  HashResultLabel := TNewStaticText.Create(WizardForm);
  with HashResultLabel do begin
    AutoSize := False;
    #if !CompactMode
      Parent := HashPage.Surface;
      Left   := ScaleX(260);
      Top    := ScaleY(80);
      Width  := ScaleX(256);
      Height := ScaleY(18);
    #else
      Parent := WizardForm;
      Left   := ScaleX(6);
      Top    := ScaleY(43);
      Width  := ScaleX(448);
      Height := ScaleY(14);
    #endif
    SetWindowLong(Handle, GWL_STYLE, (GetWindowLong(Handle, GWL_STYLE) and (not SS_LEFT) and (not SS_CENTER) and (not SS_RIGHT) and (not SS_LEFTNOWORDWRAP)) or SS_RIGHT);
  end;
  HashProgressGauge := TNewProgressBar.Create(WizardForm);
  with HashProgressGauge do begin
    #if !CompactMode
      Parent := HashPage.Surface;
      Left   := ScaleX(0);
      Top    := ScaleY(98);
      Width  := ScaleX(520);
      Height := ScaleY(15);
    #else
      Parent := WizardForm;
      Left   := ScaleX(6);
      Top    := ScaleY(60);
      Width  := ScaleX(448);
      Height := ScaleY(14);
    #endif
    Max      := 1000;
    Position := 0;
  end;
  HashInfoMemo := TNewMemo.Create(WizardForm);
  with HashInfoMemo do begin
    #if !CompactMode
      Parent := HashPage.Surface;
      Left   := ScaleX(0);
      Top    := ScaleY(118);
      Width  := ScaleX(520);
      Height := ScaleY(150);
    #else
      Parent := WizardForm;
      Left   := ScaleX(6);
      Top    := ScaleY(77);
      Width  := ScaleX(448);
      Height := ScaleY(138);
    #endif
    ScrollBars := ssBoth;
  end;
  HashLogMemo := TNewMemo.Create(WizardForm);
  with HashLogMemo do begin
    #if !CompactMode
      Parent := HashPage.Surface;
      Left   := ScaleX(0);
      Top    := ScaleY(118);
      Width  := ScaleX(520);
      Height := ScaleY(150);
    #else
      Parent := WizardForm;
      Left   := ScaleX(6);
      Top    := ScaleY(77);
      Width  := ScaleX(448);
      Height := ScaleY(138);
    #endif
    ScrollBars := ssBoth;
    Visible    := False;
  end;
  HashBackButton := TNewButton.Create(WizardForm);
  with HashBackButton do begin
    Parent   := WizardForm;
    //Caption  := ExpandConstant('{cm:HashNext}');
    Caption  := SetupMessage(msgButtonFinish);
    #if !CompactMode
      Left   := WizardForm.BackButton.Left;
      Top    := WizardForm.BackButton.Top;
      Width  := WizardForm.BackButton.Width;
      Height := WizardForm.BackButton.Height;
    #else
      Left   := ScaleX(6);
      Top    := ScaleY(221);
      Width  := ScaleX(75);
      Height := ScaleY(23);
    #endif
    OnClick  := @NextBtnClick;
  end;
  HashNextButton := TNewButton.Create(WizardForm);
  with HashNextButton do begin
    Parent   := WizardForm;
    Caption  := ExpandConstant('{cm:HashVerify}');
    #if !CompactMode
    Left     := WizardForm.NextButton.Left;
    Top      := WizardForm.NextButton.Top;
    Width    := WizardForm.NextButton.Width;
    Height   := WizardForm.NextButton.Height;
    #else
      Left   := ScaleX(379);
      Top    := ScaleY(221);
      Width  := ScaleX(75);
      Height := ScaleY(23);
    #endif
    OnClick  := @VerifyHashClick;
  end;
  HashCancelButton := TNewButton.Create(WizardForm);
  with HashCancelButton do begin
    Parent   := WizardForm;
    Caption  := ExpandConstant('{cm:HashCancel}');
    #if !CompactMode
      Left   := WizardForm.CancelButton.Left;
      Top    := WizardForm.CancelButton.Top;
      Width  := WizardForm.CancelButton.Width;
      Height := WizardForm.CancelButton.Height;
    #else
      Left   := ScaleX(193);
      Top    := ScaleY(221);
      Width  := ScaleX(75);
      Height := ScaleY(23);
    #endif
    OnClick  := @CancelHashClick;
  end;
end;
#endif


procedure CurStepChanged(CurStep: TSetupStep);
#if UseComponents
var
  I: Integer;
  S: String;
#endif
begin
  if (CurStep = ssInstall) then
  begin
    DSG_Unpack_Process(not LimitRAMCB.Checked, '', nil, WizardForm.FilenameLabel, WizardForm.CancelButton, WizardForm.ProgressGauge, nil, @ProgressCallback, @MergeFileCallback, @DiskSpanCallback);
    if Pos('/IGNOREERROR', UpperCase(GetCmdTail)) > 0 then
      IsDoneError := False;
  end;

  if (CurStep = ssPostInstall) then
  begin
    if not IsDoneError then
    begin
      #ifdef DSG_CreateUninstallList
      if FileCopy(ExpandConstant('{tmp}\Uninstall.dat'), ChangeFileExt(ExpandConstant('{uninstallexe}'), '.msg'), False) then
        DeleteFile(ExpandConstant('{tmp}\Uninstall.dat'));
      #endif
      #if UseBatch
        PercentLabel.Hide;
        ElapsedLabel.Hide;
        RemainingLabel.Hide;
        if FileExists(ExpandConstant('{tmp}\{#BatchFileName}')) then
        begin
          FileCopy(ExpandConstant('{tmp}\{#BatchFileName}'), ExpandConstant('{app}\{#BatchFileName}'), False);
          WizardForm.FilenameLabel.Caption := ExpandConstant('{cm:BatchExecution}');
          WizardForm.FilenameLabel.Font.Size := 12;
          WizardForm.FilenameLabel.Left := WizardForm.ProgressGauge.Left;
          WizardForm.FilenameLabel.Top := WizardForm.ProgressGauge.Top;
          WizardForm.FilenameLabel.Width := WizardForm.ProgressGauge.Width;
          WizardForm.FilenameLabel.Height := WizardForm.ProgressGauge.Height;
          WizardForm.ProgressGauge.Hide;
          ShellExec('open', ExpandConstant('{app}\{#BatchFileName}'), '', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
        end;
      #endif
      #if UseRedists
        PercentLabel.Hide;
        ElapsedLabel.Hide;
        RemainingLabel.Hide;
        #sub LaunchRedistItem
          #if YesNo(ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Enable", ""))
            #expr y++
            if {#if CompactMode}RedistCB.Checked{#else}RedistsList.Checked[{#y}]{#endif} then
            begin
              #define Name   ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Name", "")
              #define Exec64 ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Exe64", "")
              #define Exec32 ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Exe32", "")
              #define Param  ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Param", "")
              WizardForm.ProgressGauge.Hide;
              #if CompactMode
                WizardForm.FilenameLabel.Caption := ExpandConstant('{cm:InstallingRedistCM}');
                WizardForm.FilenameLabel.Font.Size := 12;
                WizardForm.FilenameLabel.Left := WizardForm.ProgressGauge.Left;
                WizardForm.FilenameLabel.Top := WizardForm.ProgressGauge.Top;
                WizardForm.FilenameLabel.Width := WizardForm.ProgressGauge.Width;
                WizardForm.FilenameLabel.Height := WizardForm.ProgressGauge.Height;
              #else
                WizardForm.FilenameLabel.Caption := FmtMessage(ExpandConstant('{cm:InstallingRedist}'), ['{#Name}']);
                WizardForm.FilenameLabel.Font.Size := 12;
                WizardForm.FilenameLabel.Left := WizardForm.ProgressGauge.Left;
                WizardForm.FilenameLabel.Top := WizardForm.ProgressGauge.Top;
                WizardForm.FilenameLabel.Width := WizardForm.ProgressGauge.Width;
                WizardForm.FilenameLabel.Height := WizardForm.ProgressGauge.Height;
              #endif
              if IsWin64 then
              begin
                ShellExec('open', ExpandConstant('{#Exec64}'), '{#Param}', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
              end;
              ShellExec('open', ExpandConstant('{#Exec32}'), '{#Param}', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
            end;
          #endif
        #endsub
        #for {i = 1, y = (-1); (ReadIni(Settings, "Redists", "Redist" + Str(i) + ".Name", "") != ""); i++} LaunchRedistItem
      #endif
      #if UWPGame
        if not IsDoneError then
          FileCopy(ExpandConstant('{tmp}\UWP_Tool.exe'), ExpandConstant('{app}\UWP_Tool.exe'), False);
          ShellExec('open', ExpandConstant('{app}\UWP_Tool.exe'), '', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
      #endif
      #if INISettings
        if (not IsDoneError) and FileExists(ExpandConstant('{#INIFile}')) then
        begin
          #if CompactMode
            #if INIValue == ""
              SetIniString('{#INISection}', '{#INIKey}', ExpandConstant('{username}'), ExpandConstant('{#INIFile}'));
            #else
              SetIniString('{#INISection}', '{#INIKey}', '{#INIValue}', ExpandConstant('{#INIFile}'));
            #endif
          #else
            SetIniString('{#INISection}', '{#INIKey}', WizardForm.UserInfoNameEdit.Text, ExpandConstant('{#INIFile}'));
          #endif
          SetIniString('{#INISection}', 'Language', ActiveLanguage, ExpandConstant('{#INIFile}'));
        end;
      #endif
      #if !CompactMode || !UpdateMode
        if UninstallCB.Checked then
        begin
          #if VCL
            FileCopy(ExpandConstant('{tmp}\VclStylesinno.dll'), ExpandConstant('{app}\{#UnInstallFolder}\VclStylesInno.dll'), False);
            FileCopy(ExpandConstant('{tmp}\{#VCLName}'), ExpandConstant('{app}\{#UnInstallFolder}\{#VCLName}'), False);
          #elif Cjstyles
            FileCopy(ExpandConstant('{tmp}\ISSkin.dll'), ExpandConstant('{app}\{#UnInstallFolder}\ISSkin.dll'), False);
            FileCopy(ExpandConstant('{tmp}\{#CjstylesName}'), ExpandConstant('{app}\{#UnInstallFolder}\{#CjstylesName}'), False);
          #endif
          #if UseComponents
            S := '';
            for I := 0 to ComponentsList.Items.Count - 1 do
              if ComponentsList.Checked[I] then
                S := S + IfThen(S = '', '', ',') + IntToStr(I + 1);
            RegWriteStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#Name}_is1', 'Inno Setup: Selected Components', S);
          #endif
          RegWriteDWordValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#Name}_is1', 'EstimatedSize',  Round(InstallationSize / PowerK(1, POWER_KB)));
        end;
      #endif
      #if CheckCRC
        #if !UseQuickSFV && !UseRapidCRC
          ParseHashFileList();
        #else
          if HashCheckCB.Checked then
          begin
            PercentLabel.Hide;
            ElapsedLabel.Hide;
            RemainingLabel.Hide;
            WizardForm.FilenameLabel.Caption := ExpandConstant('{cm:HashPageTitle}');
            WizardForm.ProgressGauge.Hide;
            {#if UseQuickSFV}FileCopy(ExpandConstant('{tmp}\QuickSFV.exe'), ExpandConstant('{app}\QuickSFV.exe'), False);{#endif}
            {#if UseRapidCRC}FileCopy(ExpandConstant('{tmp}\RapidCRC.exe'), ExpandConstant('{app}\RapidCRC.exe'), False);{#endif}
            FileCopy(ExpandConstant('{tmp}\{#HashFile}'), ExpandConstant('{app}\{#HashFile}'), False);
            {#if UseQuickSFV}ShellExec('open', ExpandConstant('{app}\QuickSFV.exe'), ExpandConstant('"{app}\{#HashFile}"'), '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);{#endif}
            {#if UseQuickSFV}DeleteFile(ExpandConstant('{app}\QuickSFV.exe'));{#endif}
            {#if UseQuickSFV}DeleteFile(ExpandConstant('{app}\QuickSFV.ini'));{#endif}
            {#if UseRapidCRC}ShellExec('open', ExpandConstant('{app}\RapidCRC.exe'), ExpandConstant('"{app}\{#HashFile}"'), '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);{#endif}
            {#if UseRapidCRC}DeleteFile(ExpandConstant('{app}\RapidCRC.exe'));{#endif}
            {#if DeleteHashFile}DeleteFile(ExpandConstant('{app}\{#HashFile}'));{#endif}
          end;
        #endif
      #endif
    end else
      if FileExists(ExpandConstant('{uninstallexe}')) then
        ShellExec('open', ExpandConstant('{uninstallexe}'), '/VERYSILENT', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
  end;

  if (CurStep = ssDone) then
  begin
    #if CompactMode
      #if UpdateMode
        if ISDoneError then
          MsgBox(AppNameOverride(msgSetupAborted), mbInformation, MB_OK);
      #else
        if ISDoneError then
          MsgBox(AppNameOverride(msgSetupAborted), mbInformation, MB_OK)
        else
          begin
            #if CheckCRC && !UseQuickSFV && !UseRapidCRC
              if (not HashCheckCB.Checked) or (not HashAborted) then
                MsgBox(AppNameOverride(msgFinishedLabel), mbInformation, MB_OK);
            #else
              MsgBox(AppNameOverride(msgFinishedLabel), mbInformation, MB_OK);
            #endif
          end else
          begin
            MsgBox(AppNameOverride(msgFinishedLabelNoIcons), mbInformation, MB_OK);
          end;
      #endif
    #endif
  end;
end;


function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := False;
  #if CheckCRC && !UseQuickSFV && !UseRapidCRC
    if (PageID = HashPage.ID) then
      Result := (PageID = HashPage.ID) and (ISDoneError or (not HashCheckCB.Checked) or (GetArrayLength(HashFileList) = 0));
  #endif
  #if CompactMode && UseInfo
    if (PageID = wpInfoBefore) then
      Result := True;
  #endif
end;


procedure CurPageChanged(CurPageID: integer);
begin
  if CurPageID = wpWelcome then
  begin
    #if !CompactMode
      AboutButton.Show;
      PercentLabel.Hide;
      ElapsedLabel.Hide;
      RemainingLabel.Hide;
      PauseButton.Hide;
      WizardForm.DirEdit.Hide;
      WizardForm.DirBrowseButton.Hide;
      WizardForm.GroupEdit.Hide;
      WizardForm.GroupBrowseButton.Hide;
      WizardForm.PageNameLabel.Hide;
      WizardForm.PageDescriptionLabel.Hide;
      WizardForm.ProgressGauge.Hide;
      WizardForm.UserInfoNameLabel.Hide;
      WizardForm.UserInfoNameEdit.Hide;
      {#if UseInstallBackground}BackgroundButton.Hide;{#endif}
      #if WebsiteButton && !Music
        WizardForm.NextButton.Top := WizardForm.CancelButton.Top;
        WizardForm.BackButton.Top := WizardForm.CancelButton.Top;
      #endif
      #if !WebsiteButton && Music
        WizardForm.NextButton.Top := WizardForm.CancelButton.Top;
        WizardForm.BackButton.Top := WizardForm.CancelButton.Top;
      #endif
      #if CheckCRC && !UseQuickSFV && !UseRapidCRC
        HashNextButton.Hide;
        HashBackButton.Hide;
        HashCancelButton.Hide;
      #endif
    #else
      WizardForm.CancelButton.Show;
      WizardForm.NextButton.Show;
      WizardForm.NextButton.Caption := AppNameOverride(msgButtonInstall);
      WizardForm.ProgressGauge.Show;
      WizardForm.ProgressGauge.Enabled := False;
      WizardForm.DiskSpaceLabel.Hide;
      PauseButton.Show;
      PauseButton.Enabled := False;
      FreeSpaceLabel.Show;
      NeedSpaceLabel.Show;
      GetFreeSpaceCaption(nil);
      PercentLabel.Hide;
      ElapsedLabel.Hide;
      RemainingLabel.Hide;
      #if !UpdateMode
        UninstallCB.Show;
      #endif
      #if CheckCRC
        HashCheckCB.Show;
        #if !UseQuickSFV && !UseRapidCRC
          HashInfoMemo.Hide;
          HashLogMemo.Hide;
          HashProgressGauge.Hide;
          HashStatusLabel.Hide;
          HashResultLabel.Hide;
          HashHdrLabel.Hide;
          HashFileLabel.Hide;
          HashProgressBar.Hide;
          HashNextButton.Hide;
          HashBackButton.Hide;
          HashCancelButton.Hide;
        #endif
      #endif
      {#if UseComponents}SelectComponentsLabel.Show;{#endif}
      {#if UseTasks}SelectTasksLabel.Show;{#endif}
    #endif
  end;

  #if !CompactMode
    #if UseLicense
      if CurPageID = wpLicense then
      begin
        AboutButton.Hide;
        WizardForm.DirEdit.Hide;
        WizardForm.DirBrowseButton.Hide;
        WizardForm.GroupEdit.Hide;
        WizardForm.GroupBrowseButton.Hide;
        WizardForm.PageNameLabel.Hide;
        WizardForm.PageDescriptionLabel.Hide;
        WizardForm.UserInfoNameLabel.Hide;
        WizardForm.UserInfoNameEdit.Hide;
      end;
    #endif

    #if UseInfo
      if CurPageID = wpInfoBefore then
      begin
        AboutButton.Hide;
        WizardForm.DirEdit.Hide;
        WizardForm.DirBrowseButton.Hide;
        WizardForm.GroupEdit.Hide;
        WizardForm.GroupBrowseButton.Hide;
        WizardForm.PageNameLabel.Hide;
        WizardForm.PageDescriptionLabel.Hide;
        WizardForm.UserInfoNameLabel.Hide;
        WizardForm.UserInfoNameEdit.Hide;
      end;
    #endif

    #if UseSystemReq
      if CurPageID = SystemReqPage.ID then
      begin
        AboutButton.Hide;
        WizardForm.DirEdit.Hide;
        WizardForm.DirBrowseButton.Hide;
        WizardForm.GroupEdit.Hide;
        WizardForm.GroupBrowseButton.Hide;
        WizardForm.PageNameLabel.Hide;
        WizardForm.PageDescriptionLabel.Hide;
        WizardForm.UserInfoNameLabel.Hide;
        WizardForm.UserInfoNameEdit.Hide;
      end;
    #endif

    #if UseComponents
      if CurPageID = ComponentsPage.ID then
      begin
        WizardForm.DirEdit.Hide;
        WizardForm.DirBrowseButton.Hide;
        WizardForm.GroupBrowseButton.Hide;
        WizardForm.UserInfoNameLabel.Hide;
        WizardForm.UserInfoNameEdit.Hide;
      end;
    #endif

    #if UseTasks
      if CurPageID = TasksPage.ID then
      begin
        WizardForm.DirEdit.Hide;
        WizardForm.DirBrowseButton.Hide;
        WizardForm.GroupBrowseButton.Hide;
        WizardForm.UserInfoNameLabel.Hide;
        WizardForm.UserInfoNameEdit.Hide;
      end;
    #endif

    if CurPageID = wpSelectDir then
    begin
      WizardForm.DirEdit.Show;
      WizardForm.DirBrowseButton.Show;
      WizardForm.GroupEdit.Show;
      WizardForm.GroupBrowseButton.Show;
      WizardForm.DiskSpaceLabel.Hide;
      WizardForm.UserInfoNameLabel.Show;
      WizardForm.UserInfoNameEdit.Show;
      StartMenuCB.Show;
      AboutButton.Hide;
      FreeSpaceLabel.Show;
      NeedSpaceLabel.Show;
      GetFreeSpaceCaption(nil);
      #if UseRedists
        WizardForm.NextButton.Caption := SetupMessage(msgButtonNext);
      #else
        WizardForm.NextButton.Caption := SetupMessage(msgButtonInstall);
      #endif
    end;

    #if UseRedists
      if CurPageID = wpReady then
      begin
        WizardForm.NextButton.Caption := SetupMessage(msgButtonInstall);
        WizardForm.ReadyMemo.Hide;
        WizardForm.DirEdit.Hide;
        WizardForm.DirBrowseButton.Hide;
        WizardForm.GroupEdit.Hide;
        WizardForm.GroupBrowseButton.Hide;
        WizardForm.UserInfoNameLabel.Hide;
        WizardForm.UserInfoNameEdit.Hide;
      end;
    #endif
  #endif

  if CurPageID = wpInstalling then
  begin
    DSG_RefreshSelectedItems();
    #if !CompactMode
      WizardForm.ClientWidth := ScaleX(600);
      WizardForm.ClientHeight := ScaleY(149);
      WizardForm.UserInfoNameLabel.Hide;
      WizardForm.UserInfoNameEdit.Hide;
      WizardForm.ProgressGauge.Show;
      WizardForm.PageDescriptionLabel.Hide;
      WizardForm.PageNameLabel.Hide;
      WizardForm.MainPanel.Hide;
      WizardForm.Bevel.Hide;
      WizardForm.Bevel1.Hide;
      WizardForm.DirBrowseButton.Hide;
      WizardForm.DirEdit.Hide;
      WizardForm.GroupEdit.Hide;
      WizardForm.GroupBrowseButton.Hide;
      WizardForm.SelectDirBitmapImage.Hide;
      WizardForm.PageNameLabel.Hide;
      WizardForm.PageDescriptionLabel.Hide;
      WizardForm.StatusLabel.Parent := WizardForm.InnerPage;
      WizardForm.StatusLabel.Left := WizardForm.ProgressGauge.Left;
      WizardForm.StatusLabel.Top := ScaleY(9);
      WizardForm.FileNameLabel.Parent := WizardForm.InnerPage;
      WizardForm.FileNameLabel.Left := WizardForm.ProgressGauge.Left;
      WizardForm.FileNameLabel.Top := ScaleY(26);
      WizardForm.FilenameLabel.Width := WizardForm.ProgressGauge.Width;
      WizardForm.CancelButton.Parent := WizardForm.InnerPage;
      WizardForm.CancelButton.Left := ScaleX(514);
      WizardForm.CancelButton.Top := ScaleY(113);
      WizardForm.ProgressGauge.Top := ScaleY(43);
      PercentLabel.Show;
      ElapsedLabel.Show;
      PauseButton.Show;
      PauseButton.Left := (WizardForm.CancelButton.Left - WizardForm.CancelButton.Width) - ScaleX(10);
      PauseButton.Top := WizardForm.CancelButton.Top;
      {#if WebsiteButton}WebsiteButton.Hide;{#endif}
      #if UseInstallBackground
        #if Music
          MusicButton.Left := ScaleX(170);
          MusicButton.Top := WizardForm.CancelButton.Top;
        #endif
        WizardForm.Position := poScreenCenter;
        WizardForm.Hide;
        MakeSlideShow();
        WizardForm.Top := GetSystemMetrics(1) - ScaleY(225);
        WizardForm.Show;
        BackgroundButton.Show;
        BackgroundButton.Left := ScaleX(11);
        BackgroundButton.Top := WizardForm.CancelButton.Top;
      #else
        #if Music
          MusicButton.Left := ScaleX(11);
          MusicButton.Top := WizardForm.CancelButton.Top;
        #endif
        WizardForm.Position := poScreenCenter;
      #endif
    #else
      WizardForm.CancelButton.Show;
      WizardForm.CancelButton.Parent := WizardForm;
      WizardForm.NextButton.Show;
      WizardForm.NextButton.Enabled := False;
      WizardForm.NextButton.Parent := WizardForm;
      WizardForm.NextButton.Caption := AppNameOverride(msgButtonInstall);
      WizardForm.NextButton.Hide;
      WizardForm.ProgressGauge.Show;
      WizardForm.ProgressGauge.Enabled := True;
      WizardForm.DiskSpaceLabel.Hide;
      WizardForm.FilenameLabel.Parent := WizardForm;
      WizardForm.FilenameLabel.Left := WizardForm.ProgressGauge.Left;
      WizardForm.FilenameLabel.Top := ScaleY(161);
      WizardForm.FilenameLabel.Width := WizardForm.ProgressGauge.Width;
      WizardForm.FilenameLabel.Height := ScaleY(14);
      WizardForm.FilenameLabel.Show;
      WizardForm.DirBrowseButton.Enabled := False;
      WizardForm.DirEdit.Enabled := False;
      PauseButton.Show;
      PauseButton.Enabled := True;
      PauseButton.Parent := WizardForm;
      FreeSpaceLabel.Show;
      FreeSpaceLabel.Enabled := False;
      NeedSpaceLabel.Show;
      NeedSpaceLabel.Enabled := False;
      GetFreeSpaceCaption(nil);
      LimitRAMCB.Enabled := False;
      AboutButtonCM.Enabled := False;
      PercentLabel.Show;
      ElapsedLabel.Show;
      {#if UseRedists}RedistCB.Enabled := False;{#endif}
      {#if Music}MusicButton.Parent := WizardForm;{#endif}
      {#if UseComponents}SelectComponentsLabel.Hide;{#endif}
      {#if UseTasks}SelectTasksLabel.Hide;{#endif}
      {#if UseInfo}InfoButtonCM.Enabled := False;{#endif}
      #if !UpdateMode
        UninstallCB.Show;
        UninstallCB.Enabled := False;
        UninstallCB.Parent := WizardForm;
      #endif
      #if CheckCRC
        HashCheckCB.Show;
        HashCheckCB.Enabled := False;
        HashCheckCB.Parent := WizardForm;
        {#if UseQuickSFV || UseRapidCRC}FileCopy(ExpandConstant('{tmp}\{#HashFile}'), ExpandConstant('{app}\{#HashFile}'), False);{#endif}
      #endif
    #endif
    StartTick := GetTickCount;
    if not IniKeyExists('Record2', 'Type', ExpandConstant('{tmp}\Records.ini')) then
      RemainingLabel.Show;
  end;

  #if CheckCRC && !UseQuickSFV && !UseRapidCRC
    if CurPageID = HashPage.ID then
    begin
      WizardForm.NextButton.Enabled := False;
      WizardForm.NextButton.Hide;
      #if !CompactMode
        WizardForm.ClientWidth := ScaleX(600);
        WizardForm.ClientHeight := ScaleY(429);
        WizardForm.StatusLabel.Hide;
        WizardForm.FileNameLabel.Hide;
        WizardForm.MainPanel.Show;
        WizardForm.StatusLabel.Hide;
        WizardForm.PageNameLabel.Hide;
        WizardForm.PageDescriptionLabel.Hide;
        WizardForm.CancelButton.Hide;
        WizardForm.ProgressGauge.Hide;
        WizardForm.UserInfoNameLabel.Hide;
        WizardForm.UserInfoNameEdit.Hide;
        PercentLabel.Hide;
        ElapsedLabel.Hide;
        RemainingLabel.Hide;
        PauseButton.Hide;
        WizardForm.Position := poScreenCenter;
        #if WebsiteButton
          WebsiteButton.Show;
          WebsiteButton.Left := ScaleX(13);
          WebsiteButton.Top := ScaleY(394);
          WebsiteButton.Parent := WizardForm;
        #endif
        #if Music && WebsiteButton
          MusicButton.Left := ScaleX(169);
          MusicButton.Top := ScaleY(394);
        #endif
        #if Music && !WebsiteButton
          MusicButton.Left := ScaleX(13);
          MusicButton.Top := ScaleY(394);
        #endif
        #if UseInstallBackground
          BackgroundButton.Hide;
          #if !BGAfterInstall
            BackgroundForm.Visible := False
            DeinitializeSlideShow;
            if BOOL(SlideTimerID <> 0) and KillTimer(0, SlideTimerID) then
              SlideTimerID := 0;
          #endif
        #endif
      #else
        WizardForm.ClientWidth := ScaleX(460);
        WizardForm.ClientHeight := ScaleY(250);
        WizardForm.Position := poScreenCenter;
        WizardForm.InnerNotebook.Hide;
        WizardForm.OuterNotebook.Hide;
        WizardForm.InnerPage.Hide;
        WizardForm.StatusLabel.Hide;
        WizardForm.FileNameLabel.Hide;
        WizardForm.MainPanel.Show;
        WizardForm.StatusLabel.Hide;
        WizardForm.PageNameLabel.Hide;
        WizardForm.PageDescriptionLabel.Hide;
        WizardForm.CancelButton.Hide;
        WizardForm.ProgressGauge.Hide;
        WizardForm.UserInfoNameLabel.Hide;
        WizardForm.UserInfoNameEdit.Hide;
        WizardForm.DirEdit.Hide;
        WizardForm.DirBrowseButton.Hide;
        WizardForm.MainPanel.Hide;
        HashCheckCB.Hide;
        LimitRAMCB.Hide;
        PercentLabel.Hide;
        ElapsedLabel.Hide;
        RemainingLabel.Hide;
        {#if UseInfo}InfoButtonCM.Hide;{#endif}
        AboutButtonCM.Hide;
        FreeSpaceLabel.Hide;
        NeedSizeFreeSizeBevel.Hide;
        NeedSpaceLabel.Hide;
        PauseButton.Hide;
        HashInfoMemo.Show;
        HashProgressGauge.Show;
        HashStatusLabel.Show;
        HashHdrLabel.Show;
        HashFileLabel.Show;
        HashProgressBar.Show;
        {#if UseRedists}RedistCB.Hide;{#endif}
        #if !UpdateMode
          UninstallCB.Hide;
        #endif
        {#if UseComponents}SelectComponentsLabel.Hide;{#endif}
        {#if UseTasks}SelectTasksLabel.Hide;{#endif}
        {#if Music}MusicButton.Hide;{#endif}
      #endif
      HashNextButton.Show;
      HashBackButton.Show;
      #if !CompactMode
      HashCancelButton.Show;
      #endif
      SetWindowLong(HashResultLabel.Handle, GWL_STYLE, (GetWindowLong(HashResultLabel.Handle, GWL_STYLE) and (not SS_LEFT) and (not SS_CENTER) and (not SS_RIGHT) and (not SS_LEFTNOWORDWRAP)) or SS_RIGHT);
      #if StartCRC
      if (not HashStarted) and HashCheckCB.Checked then
        HashNextButton.OnClick(nil);
      #endif
    end;
  #endif

  if CurPageID = wpFinished then
  begin
    if not IsDoneError then
    begin
      WizardForm.NextButton.Show;
      #if !CompactMode
        WizardForm.ClientWidth := ScaleX(600);
        WizardForm.ClientHeight := ScaleY(429);
        #if CheckCRC
          if not HashCheckCB.Checked then
          begin
            WizardForm.NextButton.Parent := WizardForm;
            #if UseInstallBackground
              BackgroundButton.Hide;
              #if !BGAfterInstall
                BackgroundForm.Visible := False
                DeinitializeSlideShow;
                if BOOL(SlideTimerID <> 0) and KillTimer(0, SlideTimerID) then
                  SlideTimerID := 0;
              #endif
            #endif
          end;
          if HashCheckCB.Checked then
          begin
            HashCheckCB.Hide;
            #if !UseQuickSFV && !UseRapidCRC
              HashNextButton.Hide;
              HashBackButton.Hide;
              HashCancelButton.Hide;
            #endif
            WizardForm.BackButton.Visible := False;
            WizardForm.NextButton.Parent := WizardForm;
          end;
        #endif
        WizardForm.CancelButton.Hide;
        WizardForm.UserInfoNameLabel.Hide;
        WizardForm.UserInfoNameEdit.Hide;
        AboutButton.Show;
        PauseButton.Hide;
        PercentLabel.Hide;
        RemainingLabel.Hide;
        ElapsedLabel.Hide;
        WizardForm.ProgressGauge.Hide;
        WizardForm.Position := poScreenCenter;
        WizardForm.WizardBitmapImage2.Width := ScaleX(600);
        WizardForm.WizardBitmapImage2.Height := ScaleY(379);
        WizardForm.WizardBitmapImage2.Show;
        WizardForm.WizardBitmapImage.Hide;
        WizardForm.WizardSmallBitmapImage.Hide;
        #if WebsiteButton && Music && UseInstallBackground
          WebsiteButton.Left := ScaleX(13);
          WebsiteButton.Top := WizardForm.NextButton.Top;
          WebsiteButton.Show;
          MusicButton.Left := ScaleX(170);
          MusicButton.Top := WizardForm.NextButton.Top;
          MusicButton.Show;
          BackgroundButton.Left := ScaleX(246);
          BackgroundButton.Top := WizardForm.NextButton.Top;
          BackgroundButton.Show;
        #endif
        #if WebsiteButton && Music && !UseInstallBackground
          WebsiteButton.Left := ScaleX(13);
          WebsiteButton.Top := WizardForm.NextButton.Top;
          WebsiteButton.Show;
          MusicButton.Left := ScaleX(170);
          MusicButton.Top := WizardForm.NextButton.Top;
          MusicButton.Show;
        #endif
        #if WebsiteButton && !Music && !UseInstallBackground
          WebsiteButton.Left := ScaleX(13);
          WebsiteButton.Top := WizardForm.NextButton.Top;
          WebsiteButton.Show;
        #endif
        #if !WebsiteButton && !Music && UseInstallBackground
          BackgroundButton.Left := ScaleX(13);
          BackgroundButton.Top := WizardForm.NextButton.Top;
          BackgroundButton.Show;
        #endif
        #if !WebsiteButton && Music && UseInstallBackground
          MusicButton.Left := ScaleX(13);
          MusicButton.Top := WizardForm.NextButton.Top;
          MusicButton.Show;
          BackgroundButton.Left := ScaleX(89);
          BackgroundButton.Top := WizardForm.NextButton.Top;
          BackgroundButton.Show;
        #endif
        #if !WebsiteButton && Music && !UseInstallBackground
          MusicButton.Left := ScaleX(13);
          MusicButton.Top := WizardForm.NextButton.Top;
          MusicButton.Show;
        #endif
        #if WebsiteButton && !Music && UseInstallBackground
          WebsiteButton.Left := ScaleX(13);
          WebsiteButton.Top := WizardForm.NextButton.Top;
          WebsiteButton.Show;
          BackgroundButton.Left := ScaleX(170);
          BackgroundButton.Top := WizardForm.NextButton.Top;
          BackgroundButton.Show;
        #endif
      #else
        WizardForm.InnerNotebook.Show;
        WizardForm.OuterNotebook.Show;
        {#if UseComponents}SelectComponentsLabel.Show;{#endif}
        {#if UseTasks}SelectTasksLabel.Show;{#endif}
        WizardForm.NextButton.Show;
        WizardForm.CancelButton.Hide;
        PauseButton.Hide;
        PercentLabel.Hide;
        ElapsedLabel.Hide;
        WizardForm.Position := poScreenCenter;
      #endif
      #if CheckCRC && !UseQuickSFV && !UseRapidCRC
        if HashCheckCB.Checked and HashAborted then
          WizardForm.NextButton.OnClick(nil);
      #endif
    end else
      WizardForm.NextButton.OnClick(nil);
  end;
end;


procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
  {#if PlayButtonSound}PlaySound;{#endif}
  Cancel := False;
  Confirm := False;
  SuspendProc();
  if MessageBox(0, SetupMessage(msgExitSetupMessage), SetupMessage(msgExitSetupTitle), MB_YESNO or MB_ICONQUESTION or MB_TASKMODAL) = IDYES then
  begin
    Cancel := True;
    ISDoneError := True;
    AnimateWindow(WizardForm.Handle, 300, AW_FADE_OUT);
    if CurPageID = wpInstalling then
    begin
      Cancel := False;
      WizardForm.FileNameLabel.Hide;
      WizardForm.StatusLabel.Width := ScaleX(350);
      WizardForm.StatusLabel.Caption := SetupMessage(msgStatusRollback);
      WizardForm.CancelButton.Enabled := False;
      ISDoneCancel := 1;
      ResumeProc();
      #if Music
      if SoundStream <> 0 then
        BASS_ChannelStop(SoundStream);
      #endif
      WizardForm.NextButton.OnClick(nil);
    end else
      if CurPageID = wpFinished then
        WizardForm.NextButton.OnClick(nil);
        AnimateWindow(WizardForm.Handle, 300, AW_FADE_OUT);
  end;
  ResumeProc();
end;


#if PlayButtonSound
  function NextButtonClick(CurPageID: Integer): Boolean;
  begin
    PlaySound;
    Result := True;
  end;


  function BackButtonClick(CurPageID: Integer): Boolean;
  begin
    PlaySound;
    Result := True;
  end;
#endif


function InitializeSetup(): Boolean;
begin
  Result := True;
  ExtractTemporaryFile('SplitLib.dll');
  ExtractTemporaryFile('Settings.ini');
  #if VCL
    ExtractTemporaryFile('VclStylesInno.dll');
    ExtractTemporaryFile('{#VCLName}');
    LoadVCLStyle(ExpandConstant('{tmp}\{#VCLName}'));
  #elif Cjstyles
    ExtractTemporaryFile('ISSkin.dll');
    ExtractTemporaryFile('{#CjstylesName}');
    LoadSkin(ExpandConstant('{tmp}\{#CjstylesName}'), '{#CjstylesParam}');
  #endif
  #if !CompactMode
  if (not FontExists('{#Font}')){#if ShowLanguageBox} and (Pos('/LANG=', UpperCase(GetCmdTail)) > 0){#endif} then
  begin
    ExtractTemporaryFile('Font.ttf');
    AddFontResource(ExpandConstant('{tmp}\Font.ttf'), FR_PRIVATE, 0);
  end;
  #endif
  #if ShowLanguageBox
    if Pos('/LANG=', UpperCase(GetCmdTail)) = 0 then
      Result := CreateLangDialog;
  #endif
  {#if PlayButtonSound}ExtractTemporaryFile('Button.wav');{#endif}
end;


procedure DeinitializeSetup();
begin
  #if !CompactMode
  if FileExists(ExpandConstant('{tmp}\Font.ttf')) then
    RemoveFontResource(ExpandConstant('{tmp}\Font.ttf'), FR_PRIVATE, 0);
  #endif
  #if VCL
    UnLoadVCLStyles();
  #elif Cjstyles
    ShowWindow(StrToInt(ExpandConstant('{wizardhwnd}')), SW_HIDE);
    UnloadSkin();
  #endif
  #if Music
    if FileExists(ExpandConstant('{tmp}\BASS.dll')) then
    begin
      BASS_Stop;
      BASS_Free;
    end;
  #endif
  #if !CompactMode && UseInstallBackground
    if FileExists(ExpandConstant('{tmp}\IsSlideShow.dll')) then
      DeinitializeSlideShow;
    if SlideTimerID <> 0 then
      KillTimer(0, SlideTimerID);
  #endif
end;


function InitializeUninstall(): Boolean;
begin
  Result := True;
  #if VCL
    if FileCopy(ExpandConstant('{app}\{#UnInstallFolder}\VclStylesInno.dll'), ExpandConstant('{tmp}\VclStylesInno.dll'), False)
    and FileCopy(ExpandConstant('{app}\{#UnInstallFolder}\{#VCLName}'), ExpandConstant('{tmp}\{#VCLName}'), False) then
      LoadVCLStyle(ExpandConstant('{tmp}\{#VCLName}'));
  #elif Cjstyles
    if FileCopy(ExpandConstant('{app}\{#UnInstallFolder}\ISSkin.dll'), ExpandConstant('{tmp}\ISSkin.dll'), False)
    and FileCopy(ExpandConstant('{app}\{#UnInstallFolder}\{#CjstylesName}'), ExpandConstant('{tmp}\{#CjstylesName}'), False) then
      LoadSkin(ExpandConstant('{tmp}\{#CjstylesName}'), '{#CjstylesParam}');
  #endif
end;


procedure DeinitializeUninstall();
begin
  #if VCL
    if FileExists(ExpandConstant('{tmp}\VclStylesInno.dll')) and FileExists(ExpandConstant('{tmp}\{#VCLName}')) then
      UnLoadVCLStyles();
  #elif Cjstyles
    if FileExists(ExpandConstant('{tmp}\ISSkin.dll')) and FileExists(ExpandConstant('{tmp}\{#CjstylesName}')) then
    begin
      ShowWindow(0, SW_HIDE);
      UnloadSkin();
    end;
  #endif
end;


procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  #ifdef DSG_CreateUninstallList
  case CurUninstallStep of
    usUninstall     : DSG_CurUninstallStepChanged(CurUninstallStep, UninstallProgressForm.ProgressBar, nil);
    usPostUninstall : DSG_CurUninstallStepChanged(CurUninstallStep, nil, nil);
  end;
  #endif
  if (CurUninstallStep = usPostUninstall) and DirExists(ExpandConstant('{#Savegamefolder}')) and (MsgBox(ExpandConstant('{cm:Savegamefolder}'), mbConfirmation, MB_YESNO or MB_DEFBUTTON2) = IDYES) then
    DelTree(ExpandConstant('{#Savegamefolder}'), True, True, True);
end;


[UninstallDelete]
Type: filesandordirs; Name: "{app}"
#sub RemoveShortcut
  #emit "Type: Files; Name: ""{userdesktop}\" + Trim(ReadIni(Settings, "Executable" + Str(i), "ShortcutName", "")) + ".lnk""; Check: IsComponentChecked(" + Str(Int(Trim(ReadIni(Settings, "Executable" + Str(i), "Component", "")), 0)) + ");"
  #emit "Type: Files; Name: ""{userprograms}\" + Trim(ReadIni(Settings, "Settings", "ShortcutName", "")) + "\" + Trim(ReadIni(Settings, "Executable" + Str(i), "ShortcutName", "")) + ".lnk""; Check: IsComponentChecked(" + Str(Int(Trim(ReadIni(Settings, "Executable" + Str(i), "Component", "")), 0)) + ");"
#endsub
#for {i = 1; Trim(ReadIni(Settings, "Executable" + Str(i), "ShortcutName", "")) != ""; i++} RemoveShortcut


[Languages]
#if UseLicense && !CompactMode
  #define GetLicenseFile(str FileName) ( \
    FileExists(AddBackSlash(SourcePath) + "Setup\EULA\" + FileName + ".txt") ? "Setup\EULA\" + FileName + ".txt" : ( \
    FileExists(AddBackSlash(SourcePath) + "Setup\EULA\" + FileName + ".rtf") ? "Setup\EULA\" + FileName + ".rtf" : ( \
    FileExists(AddBackSlash(SourcePath) + "Setup\EULA\English.txt") ? "Setup\EULA\English.txt" : "Setup\EULA\English.rtf" )))

  Name: "english"; MessagesFile: "compiler:Default.isl"; LicenseFile: {#GetLicenseFile("English.txt")};
  Name: "french"; MessagesFile: "compiler:Languages\french.isl"; LicenseFile: {#GetLicenseFile("French")};
  Name: "german"; MessagesFile: "compiler:Languages\german.isl"; LicenseFile: {#GetLicenseFile("German")};
  Name: "italian"; MessagesFile: "compiler:Languages\italian.isl"; LicenseFile: {#GetLicenseFile("Italian")};
  Name: "spanish"; MessagesFile: "compiler:Languages\spanish.isl"; LicenseFile: {#GetLicenseFile("Spanish")};
  Name: "polish"; MessagesFile: "compiler:Languages\polish.isl"; LicenseFile: {#GetLicenseFile("Polish")};
  Name: "russian"; MessagesFile: "compiler:Languages\russian.isl"; LicenseFile: {#GetLicenseFile("Russian")};
  Name: "portuguesebrazil"; MessagesFile: "compiler:Languages\brazilianportuguese.isl"; LicenseFile: {#GetLicenseFile("PortugueseBrazil")};
  Name: "czech"; MessagesFile: "compiler:Languages\czech.isl"; LicenseFile: {#GetLicenseFile("Czech")};
  Name: "ukrainian"; MessagesFile: "compiler:Languages\ukrainian.isl"; LicenseFile: {#GetLicenseFile("Ukrainian")};
#else
  Name: "english"; MessagesFile: "compiler:Default.isl";
  Name: "french"; MessagesFile: "compiler:Languages\french.isl";
  Name: "german"; MessagesFile: "compiler:Languages\german.isl";
  Name: "italian"; MessagesFile: "compiler:Languages\italian.isl";
  Name: "spanish"; MessagesFile: "compiler:Languages\spanish.isl";
  Name: "polish"; MessagesFile: "compiler:Languages\polish.isl";
  Name: "russian"; MessagesFile: "compiler:Languages\russian.isl";
  Name: "portuguesebrazil"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl";
  Name: "czech"; MessagesFile: "compiler:Languages\czech.isl";
  Name: "ukrainian"; MessagesFile: "compiler:Languages\ukrainian.isl";
#endif

[Messages]
ExitSetupTitle={#Name}

czech.ExitSetupMessage=Chcete prùvodce instalací ukonèit?
english.ExitSetupMessage=Exit Setup?
french.ExitSetupMessage=Quitter l'installation?
german.ExitSetupMessage=Setup verlassen?
italian.ExitSetupMessage=Uscire dall'installazione?
polish.ExitSetupMessage=Anulowanie instalacji?
portuguesebrazil.ExitSetupMessage=Sair do Programa de Instalação?
russian.ExitSetupMessage=Выход из программы установки?
spanish.ExitSetupMessage=¿Salir de la Instalación?
ukrainian.ExitSetupMessage=Вийти  з програми встановлення?

[CustomMessages]
czech.Extracting=Rozbaluje se %1...
czech.MergingFile=Merging file %1 (%3%) to %2 (%4%)...
czech.ChangeDiskLabel=Please insert disk %1 with %2 file.%nBrowse for required file?
czech.CreateDesktopIcon=Create a desktop icon
czech.FinishLabel=Setup has finished installing {code:AppName} on your computer.
czech.FreeSpace=Available disk space:
czech.NeedSpace=Required disk space:
czech.ElapsedTime=Uplynulý čas: %1
czech.RemainingTime=Zbývající čas: %1
czech.CheckCRC=Check CRC
czech.Pause=Pause
czech.Resume=Resume
czech.InstallRedistCM=Install Redists
czech.LimitRAMCB=Limit RAM and CPU usage
czech.CreateUninstall=Create uninstaller
czech.SavegameFolder=Do you want to delete savegame folder?
{#if Music}czech.MusicButtonCaptionSoundOn=Hudba: ON{#endif}
{#if Music}czech.MusicButtonCaptionSoundOff=Hudba: OFF{#endif}
{#if UseTasks}czech.SelectTasks=Klepnutím vyberte úkoly ...{#endif}
{#if UseRedists}czech.InstallingRedist=Installing %1 ...{#endif}
{#if UseRedists}czech.InstallingRedistCM=Installing Redists...{#endif}
{#if INISettings}czech.EnterPlayerName=Enter your player name:{#endif}
{#if UseSystemReq}czech.SystemReqLabel1=Setup will now check the system requirements. Entries displayed with a red color indicate that your hardware does not match the specified requirement.{#endif}
{#if UseSystemReq}czech.SystemReqLabel2=The following hardware has been detected on your system:{#endif}
{#if UseSystemReq}czech.DirectXNeeded=Required:{#endif}
{#if UseSystemReq}czech.Hardware0=Your system does NOT meet the minimum hardware requirements.{#endif}
{#if UseSystemReq}czech.Hardware100=Your system meets the recommended hardware requirements.{#endif}
{#if UseSystemReq}czech.Hardware50=Your system does partially meet the hardware reuirements.{#endif}
{#if UseComponents}czech.SelectComponents=Klepnutím vyberte komponenty...{#endif}
{#if UseComponents || UseTasks}czech.CompEnglish=Angličtina{#endif}
{#if UseComponents || UseTasks}czech.CompFrench=Francouzština{#endif}
{#if UseComponents || UseTasks}czech.CompGerman=Němec{#endif}
{#if UseComponents || UseTasks}czech.CompItalian=Italština{#endif}
{#if UseComponents || UseTasks}czech.CompSpanish=španělština{#endif}
{#if UseComponents || UseTasks}czech.CompPolish=Polština{#endif}
{#if UseComponents || UseTasks}czech.CompRussian=Ruština{#endif}
{#if UseComponents || UseTasks}czech.CompPortugueseBrazil=Portugalština (Brazílie){#endif}
{#if UseComponents || UseTasks}czech.CompCzech=čeština{#endif}
{#if WebsiteButton}czech.WebsiteText=Webová Stránka{#endif}
{#if UseInstallBackground}czech.BackgroundON=Background: ON{#endif}
{#if UseInstallBackground}czech.BackgroundOFF=Background: OFF{#endif}
{#if UseBatch}czech.BatchExecution=Wait for batch execution...{#endif}

english.Extracting=Extracting %1...
english.MergingFile=Merging file %1 (%3%) to %2 (%4%)...
english.ChangeDiskLabel=Please insert disk %1 with %2 file.%nBrowse for required file?
english.CreateDesktopIcon=Create a desktop icon
english.FinishLabel=Setup has finished installing {code:AppName} on your computer.
english.FreeSpace=Available disk space:
english.NeedSpace=Required disk space:
english.ElapsedTime=Elapsed: %1
english.RemainingTime=Remaining: %1
english.CheckCRC=Check CRC
english.Pause=Pause
english.Resume=Resume
english.InstallRedistCM=Install Redists
english.LimitRAMCB=Limit RAM and CPU usage
english.CreateUninstall=Create uninstaller
english.SavegameFolder=Do you want to delete savegame folder?
{#if Music}english.MusicButtonCaptionSoundOn=Music: ON{#endif}
{#if Music}english.MusicButtonCaptionSoundOff=Music: OFF{#endif}
{#if UseTasks}english.SelectTasks=Click to select tasks...{#endif}
{#if UseRedists}english.InstallingRedist=Installing %1 ...{#endif}
{#if UseRedists}english.InstallingRedistCM=Installing Redists...{#endif}
{#if INISettings}english.EnterPlayerName=Enter your player name:{#endif}
{#if UseSystemReq}english.SystemReqLabel1=Setup will now check the system requirements. Entries displayed with a red color indicate that your hardware does not match the specified requirement.{#endif}
{#if UseSystemReq}english.SystemReqLabel2=The following hardware has been detected on your system:{#endif}
{#if UseSystemReq}english.DirectXNeeded=Required:{#endif}
{#if UseSystemReq}english.Hardware0=Your system does NOT meet the minimum hardware requirements.{#endif}
{#if UseSystemReq}english.Hardware100=Your system meets the recommended hardware requirements.{#endif}
{#if UseSystemReq}english.Hardware50=Your system does partially meet the hardware reuirements.{#endif}
{#if UseComponents}english.SelectComponents=Click to select components...{#endif}
{#if UseComponents || UseTasks}english.CompEnglish=English{#endif}
{#if UseComponents || UseTasks}english.CompFrench=French{#endif}
{#if UseComponents || UseTasks}english.CompGerman=German{#endif}
{#if UseComponents || UseTasks}english.CompItalian=Italian{#endif}
{#if UseComponents || UseTasks}english.CompSpanish=Spanish{#endif}
{#if UseComponents || UseTasks}english.CompPolish=Polish{#endif}
{#if UseComponents || UseTasks}english.CompRussian=Russian{#endif}
{#if UseComponents || UseTasks}english.CompPortuguesebrazil=Portuguese (Brazil){#endif}
{#if UseComponents || UseTasks}english.CompCzech=Czech{#endif}
{#if WebsiteButton}english.WebsiteText=Website{#endif}
{#if UseInstallBackground}english.BackgroundON=Background: ON{#endif}
{#if UseInstallBackground}english.BackgroundOFF=Background: OFF{#endif}
{#if UseBatch}english.BatchExecution=Wait for batch execution...{#endif}

french.Extracting=%1 d'extraction...
french.MergingFile=Fusionner le fichier %1 (%3%) à %2 (%4%)...
french.ChangeDiskLabel=Veuillez insérer le disque %1 avec %2 fichier.%nRecherchez le fichier requis?
french.CreateDesktopIcon=Créer une icône sur le Bureau
french.FinishLabel=L'assistant a terminé l'installation de {code:AppName} sur votre ordinateur.
french.FreeSpace=Espace disque disponible:
french.NeedSpace=Espace disque requis:
french.ElapsedTime=Passé: %1
french.RemainingTime=Restantes: %1
french.CheckCRC=Vérification CRC
french.Pause=Pause
french.Resume=Continuer
french.InstallRedistCM=Installer des  Redists
french.LimitRAMCB=Limiter l'utilisation de la RAM et du CPU
french.CreateUninstall=Créer un programme de désinstallation
french.SavegameFolder=Voulez-vous supprimer le dossier de sauvegarde?
{#if Music}french.MusicButtonCaptionSoundOn=Musique: ON{#endif}
{#if Music}french.MusicButtonCaptionSoundOff=Musique: OFF{#endif}
{#if UseTasks}french.SelectTasks=Cliquez pour sélectionner les tâches...{#endif}
{#if UseRedists}french.InstallingRedist=Installation %1 ...{#endif}
{#if UseRedists}french.InstallingRedistCM=Installation des Redists...{#endif}
{#if INISettings}french.EnterPlayerName=Entrez votre nom de joueur: {#endif}
{#if UseSystemReq}french.SystemReqLabel1=L'Assistant va contrôler si votre système répond aux conditions requises.{#endif}
{#if UseSystemReq}french.SystemReqLabel2=Le matériel suivant a été détecté sur votre système:{#endif}
{#if UseSystemReq}french.DirectXNeeded=Nécessaire:{#endif}
{#if UseSystemReq}french.Hardware0=Votre système NE répond pas à la configuration minimale requise.{#endif}
{#if UseSystemReq}french.Hardware100=Votre système répond à la configuration conseillé requise.{#endif}
{#if UseSystemReq}french.Hardware50=Votre système ne répond que partiellement aux exigences matérielles.{#endif}
{#if UseComponents}french.SelectComponents=Cliquez pour sélectionner les composants...{#endif}
{#if UseComponents || UseTasks}french.CompEnglish=Anglais{#endif}
{#if UseComponents || UseTasks}french.CompFrench=Français{#endif}
{#if UseComponents || UseTasks}french.CompGerman=Allemand{#endif}
{#if UseComponents || UseTasks}french.CompItalian=Italien{#endif}
{#if UseComponents || UseTasks}french.CompSpanish=Espanol{#endif}
{#if UseComponents || UseTasks}french.CompPolish=Polonais{#endif}
{#if UseComponents || UseTasks}french.CompRussian=Russe{#endif}
{#if UseComponents || UseTasks}french.CompPortugueseBrazil=Brésil brésilien{#endif}
{#if UseComponents || UseTasks}french.CompCzech=Tchèque{#endif}
{#if WebsiteButton}french.WebsiteText=Site web{#endif}
{#if UseInstallBackground}french.BackgroundON=Background: ON{#endif}
{#if UseInstallBackground}french.BackgroundOFF=Background: OFF{#endif}
{#if UseBatch}french.BatchExecution=Wait for batch execution...{#endif}

german.Extracting=Extrahiere %1...
german.MergingFile=Füge Detei %1 (%3%) zu %2 (%4%) zusammen...
german.ChangeDiskLabel=Bitte legen Sie den Datenträger %1 mit Datei %2 ein.%nNach benötigter Datei suchen?
german.CreateDesktopIcon=Desktop-Symbol erstellen
german.FinishLabel=Das Setup hat die Installation von {code:AppName} auf Ihrem Computer abgeschlossen.
german.FreeSpace=Verfügbarer Speicherplatz:
german.NeedSpace=Benötigter Speicherplatz:
german.ElapsedTime=Vergangen: %1
german.RemainingTime=Verbleibend: %1
german.CheckCRC=Überprüfe CRC
german.Pause=Unterbrechen
german.Resume=Fortsetzen
german.InstallRedistCM=Installiere Redists
german.LimitRAMCB=Begrenze RAM und CPU Nutzung
german.CreateUninstall=Deinstallationsprogramm erstellen
german.SavegameFolder=Willst du gespeicherte Spielstände löschen?
{#if Music}german.MusicButtonCaptionSoundOn=Musik: AN{#endif}
{#if Music}german.MusicButtonCaptionSoundOff=Musik: AUS{#endif}
{#if UseTasks}german.SelectTasks=Klicke um Aufgaben auszuwählen...{#endif}
{#if UseRedists}german.InstallingRedist=Installiere %1 ...{#endif}
{#if UseRedists}german.InstallingRedistCM=Installiere Redists...{#endif}
{#if INISettings}german.EnterPlayerName=Geben Sie Ihren Spielernamen ein:{#endif}
{#if UseSystemReq}german.SystemReqLabel1=Das Setup wird nun die Hardware-Anforderungen überprüfen. Einträge in roter Farbe deuten darauf hin, dass die betreffende Hardware nicht ausreichend ist.{#endif}
{#if UseSystemReq}german.SystemReqLabel2=Die folgende Hardware wurde auf Ihrem System erkannt:{#endif}
{#if UseSystemReq}german.DirectXNeeded=Erforderlich:{#endif}
{#if UseSystemReq}german.Hardware0=Ihr System erfüllt NICHT die Mindestsystemanforderungen.{#endif}
{#if UseSystemReq}german.Hardware100=Ihr System erfüllt die empfohlenen Systemanforderungen.{#endif}
{#if UseSystemReq}german.Hardware50=Ihr System erfüllt die Hardwareanforderungen nur teilweise.{#endif}
{#if UseComponents}german.SelectComponents=Klicke um Komponenten auszuwählen...{#endif}
{#if UseComponents || UseTasks}german.CompEnglish=Englisch{#endif}
{#if UseComponents || UseTasks}german.CompFrench=Französisch{#endif}
{#if UseComponents || UseTasks}german.CompGerman=Deutsch{#endif}
{#if UseComponents || UseTasks}german.CompItalian=Italienisch{#endif}
{#if UseComponents || UseTasks}german.CompSpanish=Spanisch{#endif}
{#if UseComponents || UseTasks}german.CompPolish=Polnisch{#endif}
{#if UseComponents || UseTasks}german.CompRussian=Russisch{#endif}
{#if UseComponents || UseTasks}german.CompPortugueseBrazil=Portugiesisch (Brasilianisch){#endif}
{#if UseComponents || UseTasks}german.CompCzech=Tschechisch{#endif}
{#if WebsiteButton}german.WebsiteText=Webseite{#endif}
{#if UseInstallBackground}german.BackgroundON=Hintergrund: AN{#endif}
{#if UseInstallBackground}german.BackgroundOFF=Hintergrund: AUS{#endif}
{#if UseBatch}german.BatchExecution=Warte auf Batch-Ausführung...{#endif}

italian.Extracting=Estrazione di %1...
italian.MergingFile=Unione file %1 (%3%) in %2 (%4%)...
italian.ChangeDiskLabel=Prego inserire disco %1 con il file %2.%nSfogliare per il file richiesto?
italian.CreateDesktopIcon=Crea un'icona sul desktop
italian.FinishLabel=L'installazione di {code:AppName} è stata completata con successo.
italian.FreeSpace=Spazio disponibile sul disco:
italian.NeedSpace=Spazio su disco richiesto:
italian.ElapsedTime=Trascorso: %1
italian.RemainingTime=Rimanente: %1
italian.CheckCRC=Controllo CRC
italian.Pause=Pausa
italian.Resume=Riprendi
italian.InstallRedistCM=Installa Redists
italian.LimitRAMCB=Limita l'utilizzo di RAM e CPU
italian.CreateUninstall=Crea un programma di disinstallazione
italian.SavegameFolder=Do you want to delete savegame folder?
{#if Music}italian.MusicButtonCaptionSoundOn=Musica: ON{#endif}
{#if Music}italian.MusicButtonCaptionSoundOff=Musica: OFF{#endif}
{#if UseTasks}italian.SelectTasks=Clicca per selezionare le attività...{#endif}
{#if UseRedists}italian.InstallingRedist=Installazione %1 ...{#endif}
{#if UseRedists}italian.InstallingRedistCM=Installazione di Redists...{#endif}
{#if INISettings}italian.EnterPlayerName=Inserisci il nome del tuo giocatore:{#endif}
{#if UseSystemReq}italian.SystemReqLabel1=L'Installazione guidata verificherà se il sistema soddisfa i requisiti del Gioco e anche quali requisiti soddisfa o non soddisfa.{#endif}
{#if UseSystemReq}italian.SystemReqLabel2=Il seguente hardware è stato rilevato sul tuo sistema:{#endif}
{#if UseSystemReq}italian.DirectXNeeded=Necessario:{#endif}
{#if UseSystemReq}italian.Hardware0=Il sistema NON soddisfa uno o più requisiti di sistema.{#endif}
{#if UseSystemReq}italian.Hardware100=Il sistema soddisfa i requisiti consigliati.{#endif}
{#if UseSystemReq}italian.Hardware50=Il sistema soddisfa solo parzialmente i requisiti hardware richiesti.{#endif}
{#if UseComponents}italian.SelectComponents=Clicca per selezionare i componenti...{#endif}
{#if UseComponents || UseTasks}italian.CompEnglish=Inglese{#endif}
{#if UseComponents || UseTasks}italian.CompFrench=Francese{#endif}
{#if UseComponents || UseTasks}italian.CompGerman=Tedesco{#endif}
{#if UseComponents || UseTasks}italian.CompItalian=italiano{#endif}
{#if UseComponents || UseTasks}italian.CompSpanish=Spagnolo{#endif}
{#if UseComponents || UseTasks}italian.CompPolish=Polacco{#endif}
{#if UseComponents || UseTasks}italian.CompRussian=Russo{#endif}
{#if UseComponents || UseTasks}italian.CompPortugueseBrazil=Portoghese Brasiliano{#endif}
{#if UseComponents || UseTasks}italian.CompCzech=Ceco{#endif}
{#if WebsiteButton}italian.WebsiteText=Sito Web{#endif}
{#if UseInstallBackground}italian.BackgroundON=Background: ON{#endif}
{#if UseInstallBackground}italian.BackgroundOFF=Background: OFF{#endif}
{#if UseBatch}italian.BatchExecution=Wait for batch execution...{#endif}

polish.Extracting=Dekompresowanie %1...
polish.MergingFile=Łączenie pliku %1 (%3%) do %2 (%4%)...
polish.ChangeDiskLabel=Proszę o włożenie dysku %1 z plikiem %2.%nWyszukaj wymagany plik?
polish.CreateDesktopIcon=Utwórz ikonę na pulpicie
polish.FinishLabel=Instalator zakończył instalację programu {code:AppName} na twoim komputerze.
polish.FreeSpace=Dostępne miejsce na dysku:
polish.NeedSpace=Wymagane miejsce na dysku:
polish.ElapsedTime=Upłynęło: %1
polish.RemainingTime=Pozostało: %1
polish.CheckCRC=Sprawdź pliki pod kątem błędów CRC
polish.Pause=Wstrzymaj
polish.Resume=Wznów
polish.InstallRedistCM=Install Redists
polish.LimitRAMCB=Limit RAM and CPU usage
polish.CreateUninstall=Stwórz dezinstalator
polish.SavegameFolder=Do you want to delete savegame folder?
{#if Music}polish.MusicButtonCaptionSoundOn=Muzyka: TAK{#endif}
{#if Music}polish.MusicButtonCaptionSoundOff=Muzyka: NIE{#endif}
{#if UseTasks}polish.SelectTasks=Kliknij, aby wybrać zadania...{#endif}
{#if UseRedists}polish.InstallingRedist=Instaluję %1 ...{#endif}
{#if UseRedists}polish.InstallingRedistCM=Installing Redists...{#endif}
{#if INISettings}polish.EnterPlayerName=Wpisz swoją nazwę gracza:{#endif}
{#if UseSystemReq}polish.SystemReqLabel1=Kreator sprawdzi teraz konfigurację twojego komputera i określi, czy spełnia on wymagania instalowanego oprogramowania.{#endif}
{#if UseSystemReq}polish.SystemReqLabel2=Następujące podzespoły zostały wykryte w Twoim systemie:{#endif}
{#if UseSystemReq}polish.DirectXNeeded=Wymagany:{#endif}
{#if UseSystemReq}polish.Hardware0=Twój system NIE spełnia minimalnych wymagań systemowych.{#endif}
{#if UseSystemReq}polish.Hardware100=Twój system spełnia zalecane wymagania systemowe.{#endif}
{#if UseSystemReq}polish.Hardware50=Twój system tylko częściowo spełnia wymagania sprzętowe.{#endif}
{#if UseComponents}polish.SelectComponents=Kliknij, aby wybrać komponenty...{#endif}
{#if UseComponents || UseTasks}polish.CompEnglish=Język angielski{#endif}
{#if UseComponents || UseTasks}polish.CompFrench=Francuski{#endif}
{#if UseComponents || UseTasks}polish.CompGerman=Niemiecki{#endif}
{#if UseComponents || UseTasks}polish.CompItalian=Włoski{#endif}
{#if UseComponents || UseTasks}polish.CompSpanish=Hiszpański{#endif}
{#if UseComponents || UseTasks}polish.CompPolish=Polskie{#endif}
{#if UseComponents || UseTasks}polish.CompRussian=Rosyjski{#endif}
{#if UseComponents || UseTasks}polish.CompPortugueseBrazil=Portugalski Brazylia{#endif}
{#if UseComponents || UseTasks}polish.CompCzech=Czeski{#endif}
{#if WebsiteButton}polish.WebsiteText=Strona WWW{#endif}
{#if UseInstallBackground}polish.BackgroundON=Background: ON{#endif}
{#if UseInstallBackground}polish.BackgroundOFF=Background: OFF{#endif}
{#if UseBatch}polish.BatchExecution=Wait for batch execution...{#endif}

portuguesebrazil.Extracting=Extraindo %1...
portuguesebrazil.MergingFile=Juntando arquivo %1 (%3%) para %2 (%4%)...
portuguesebrazil.ChangeDiskLabel=Por favor, insira o disco %1 com o arquivo %2.%nProcurar arquivo requerido?
portuguesebrazil.CreateDesktopIcon=Criar um ícone na Área de Trabalho
portuguesebrazil.FinishLabel=O Programa de Instalação terminou de instalar {code:AppName} no seu computador.
portuguesebrazil.FreeSpace=Espaço disponível no disco:
portuguesebrazil.NeedSpace=Espaço em disco necessário:
portuguesebrazil.ElapsedTime=Decorrido: %1
portuguesebrazil.RemainingTime=Restando: %1
portuguesebrazil.CheckCRC=Verificar CRC
portuguesebrazil.Pause=Pausar
portuguesebrazil.Resume=Continuar
portuguesebrazil.InstallRedistCM=Installar Redists
portuguesebrazil.LimitRAMCB=Limite de uso de CPU e RAM
portuguesebrazil.CreateUninstall=Criar desinstalador
portuguesebrazil.SavegameFolder=Deseja excluir a pasta de savegame?
{#if Music}portuguesebrazil.MusicButtonCaptionSoundOn=Música: ON{#endif}
{#if Music}portuguesebrazil.MusicButtonCaptionSoundOff=Música: OFF{#endif}
{#if UseTasks}portuguesebrazil.SelectTasks=Clique para selecionar tarefas...{#endif}
{#if UseRedists}portuguesebrazil.InstallingRedist=Instalando %1 ...{#endif}
{#if UseRedists}portuguesebrazil.InstallingRedistCM=Installando Redists...{#endif}
{#if INISettings}portuguesebrazil.EnterPlayerName=Digite o nome do seu jogador:{#endif}
{#if UseSystemReq}portuguesebrazil.SystemReqLabel1=O instalador irá verificar os requisitos do sistema. As entradas exibidas com uma cor vermelha indicam que seu hardware não corresponde ao requisito especificado.{#endif}
{#if UseSystemReq}portuguesebrazil.SystemReqLabel2=O hardware abaixo foi detectado em seu sistema:{#endif}
{#if UseSystemReq}portuguesebrazil.DirectXNeeded=Requeridos:{#endif}
{#if UseSystemReq}portuguesebrazil.Hardware0=O seu sistema NÃO possui os requisitos mínimos de hardware.{#endif}
{#if UseSystemReq}portuguesebrazil.Hardware100=O seu sistema possui os requisitos recomendados de hardware.{#endif}
{#if UseSystemReq}portuguesebrazil.Hardware50=Seu sistema atende apenas parcialmente aos requisitos de hardware.{#endif}
{#if UseComponents}portuguesebrazil.SelectComponents=Clique para selecionar componentes...{#endif}
{#if UseComponents || UseTasks}portuguesebrazil.CompEnglish=Inglês{#endif}
{#if UseComponents || UseTasks}portuguesebrazil.CompFrench=Francês{#endif}
{#if UseComponents || UseTasks}portuguesebrazil.CompGerman=Alemão{#endif}
{#if UseComponents || UseTasks}portuguesebrazil.CompItalian=Italiano{#endif}
{#if UseComponents || UseTasks}portuguesebrazil.CompSpanish=Espanhol{#endif}
{#if UseComponents || UseTasks}portuguesebrazil.CompPolish=Polonês{#endif}
{#if UseComponents || UseTasks}portuguesebrazil.CompRussian=Russo{#endif}
{#if UseComponents || UseTasks}portuguesebrazil.CompPortugueseBrazil=Português Brasil{#endif}
{#if UseComponents || UseTasks}portuguesebrazil.CompCzech=Tcheco{#endif}
{#if WebsiteButton}portuguesebrazil.WebsiteText=Website{#endif}
{#if UseInstallBackground}portuguesebrazil.BackgroundON=Background: ON{#endif}
{#if UseInstallBackground}portuguesebrazil.BackgroundOFF=Background: OFF{#endif}
{#if UseBatch}portuguesebrazil.BatchExecution=Wait for batch execution...{#endif}

russian.Extracting=Извлекается %1...
russian.MergingFile=Слияние файла %1 (%3%) с %2 (%4%)...
russian.ChangeDiskLabel=Пожалуйста, вставьте диск %1 с файлом %2 File.%nНайти нужный файл?
russian.CreateDesktopIcon=Создать значок на Рабочем столе
russian.FinishLabel=Программа {code:AppName} установлена на ваш компьютер.
russian.FreeSpace=Доступное дисковое пространство:
russian.NeedSpace=Требуемое дисковое пространство:
russian.ElapsedTime=Прошло: %1
russian.RemainingTime=Осталось: %1
russian.CheckCRC=Проверка хеша
russian.Pause=Приостановить
russian.Resume=Продолжить
russian.InstallRedistCM=Установка доп.компонентов
russian.LimitRAMCB=Limit RAM and CPU usage
russian.CreateUninstall=Создать деинсталлятор
russian.SavegameFolder=Do you want to delete savegame folder?
{#if Music}russian.MusicButtonCaptionSoundOn=Музыка: ON{#endif}
{#if Music}russian.MusicButtonCaptionSoundOff=Музыка: OFF{#endif}
{#if UseTasks}russian.SelectTasks=Выберите нужные задачи...{#endif}
{#if UseRedists}russian.InstallingRedist=Installing %1 ...{#endif}
{#if UseRedists}russian.InstallingRedistCM=Установка доп.компонентов ...{#endif}
{#if INISettings}russian.EnterPlayerName=Введите имя игрока:{#endif}
{#if UseSystemReq}russian.SystemReqLabel1=Мастер установки проверит, соответствует ли ваше оборудование требованиям, и, если да, каким.{#endif}
{#if UseSystemReq}russian.SystemReqLabel2=Установщик определелил железо на вашем компьютере:{#endif}
{#if UseSystemReq}russian.DirectXNeeded=необходимые:{#endif}
{#if UseSystemReq}russian.Hardware0=Ваша система не соответствует минимальным требованиям к оборудованию.{#endif}
{#if UseSystemReq}russian.Hardware100=Ваша система соответствует рекомендуемым требованиям к оборудованию.{#endif}
{#if UseSystemReq}russian.Hardware50=Ваша система только частично отвечает требованиям к оборудованию.{#endif}
{#if UseComponents}russian.SelectComponents=Выберите нужные компоненты...{#endif}
{#if UseComponents || UseTasks}russian.CompEnglish=Aнглийский{#endif}
{#if UseComponents || UseTasks}russian.CompFrench=Французский{#endif}
{#if UseComponents || UseTasks}russian.CompGerman=Немецкий{#endif}
{#if UseComponents || UseTasks}russian.CompItalian=итальянский{#endif}
{#if UseComponents || UseTasks}russian.CompSpanish=испанский{#endif}
{#if UseComponents || UseTasks}russian.CompPolish=польский{#endif}
{#if UseComponents || UseTasks}russian.CompRussian=Pусский{#endif}
{#if UseComponents || UseTasks}russian.CompPortugueseBrazil=Португальский бразилия{#endif}
{#if UseComponents || UseTasks}russian.CompCzech=чешский{#endif}
{#if WebsiteButton}russian.WebsiteText=Веб сайт{#endif}
{#if UseInstallBackground}russian.BackgroundON=Background: ON{#endif}
{#if UseInstallBackground}russian.BackgroundOFF=Background: OFF{#endif}
{#if UseBatch}russian.BatchExecution=Wait for batch execution...{#endif}

spanish.Extracting=Extrayendo %1...
spanish.MergingFile=Fusionando archivos %1 (%3%) to %2 (%4%)...
spanish.ChangeDiskLabel=Por favor inserte el disco %1 con %2 el archivo.%n¿Buscar el archivo requerido?
spanish.CreateDesktopIcon=Crear un icono en el escritorio
spanish.FinishLabel=El programa completó la instalación de {code:AppName} en su sistema.
spanish.FreeSpace=Espacio de disco disponible:
spanish.NeedSpace=Espacio en disco requerido:
spanish.ElapsedTime=Transcurrido: %1
spanish.RemainingTime=Restante: %1
spanish.CheckCRC=Check CRC
spanish.Pause=Pausa
spanish.Resume=Continuar
spanish.InstallRedistCM=Install Redists
spanish.LimitRAMCB=Limit RAM and CPU usage
spanish.CreateUninstall=Crear desinstalador
spanish.SavegameFolder=Do you want to delete savegame folder?
{#if Music}spanish.MusicButtonCaptionSoundOn=Música: ON{#endif}
{#if Music}spanish.MusicButtonCaptionSoundOff=Música: OFF{#endif}
{#if UseTasks}spanish.SelectTasks=Haga clic para seleccionar tareas...{#endif}
{#if UseRedists}spanish.InstallingRedist=Installing %1 ...{#endif}
{#if UseRedists}spanish.InstallingRedistCM=Installing Redists...{#endif}
{#if INISettings}spanish.EnterPlayerName=Ingrese su nombre de jugador:{#endif}
{#if UseSystemReq}spanish.SystemReqLabel1=Setup comprobará ahora los requisitos del sistema. Las entradas mostradas con color rojo indican que su hardware no cumple el requisito especificado.{#endif}
{#if UseSystemReq}spanish.SystemReqLabel2=El siguiente hardware ha sido detectado en su sistema:{#endif}
{#if UseSystemReq}spanish.DirectXNeeded=Necesario:{#endif}
{#if UseSystemReq}spanish.Hardware0=El sistema NO cumple con los requisitos mínimos de hardware.{#endif}
{#if UseSystemReq}spanish.Hardware100=Su sistema cumple con los requisitos recomendados de hardware.{#endif}
{#if UseSystemReq}spanish.Hardware50=Su sistema solo cumple parcialmente los requisitos de hardware.{#endif}
{#if UseComponents}spanish.SelectComponents=Haga clic para seleccionar componentes...{#endif}
{#if UseComponents || UseTasks}spanish.CompEnglish=Inglés{#endif}
{#if UseComponents || UseTasks}spanish.CompFrench=Francés{#endif}
{#if UseComponents || UseTasks}spanish.CompGerman=Alemán{#endif}
{#if UseComponents || UseTasks}spanish.CompItalian=italiano{#endif}
{#if UseComponents || UseTasks}spanish.CompSpanish=Español{#endif}
{#if UseComponents || UseTasks}spanish.CompPolish=Polaco{#endif}
{#if UseComponents || UseTasks}spanish.CompRussian=Ruso{#endif}
{#if UseComponents || UseTasks}spanish.CompPortugueseBrazil=Brasil Portugués{#endif}
{#if UseComponents || UseTasks}spanish.CompCzech=Checo{#endif}
{#if WebsiteButton}spanish.WebsiteText=Website{#endif}
{#if UseInstallBackground}spanish.BackgroundON=Background: ON{#endif}
{#if UseInstallBackground}spanish.BackgroundOFF=Background: OFF{#endif}
{#if UseBatch}spanish.BatchExecution=Wait for batch execution...{#endif}

ukrainian.Extracting=Видобування %1...
ukrainian.MergingFile=Об'єднання файлу %1 (%3%) з %2 (%4%)...
ukrainian.ChangeDiskLabel=Будь ласка, вставте диск %1, що містить файл %2.%nЗнайти файл вручну?
ukrainian.CreateDesktopIcon=Створити ярлик на робочому столі
ukrainian.FinishLabel=Програма завершила встановлення {code:AppName} на ваш комп'ютер.
ukrainian.FreeSpace=Доступно простору на диску:
ukrainian.NeedSpace=Необхідно простору на диску:
ukrainian.ElapsedTime=Минуло: %1
ukrainian.RemainingTime=Залишилось: %1
ukrainian.CheckCRC=Перевірити CRC
ukrainian.Pause=Пауза
ukrainian.Resume=Віднновити
ukrainian.InstallRedistCM=Встановити додаткове ПЗ
ukrainian.LimitRAMCB=Обмежити використання ОЗП та ЦП
ukrainian.CreateUninstall=Створити деінсталятор
ukrainian.SavegameFolder=Видалити папку зі збереженнями?
{#if Music}ukrainian.MusicButtonCaptionSoundOn=Музика: ВКЛ{#endif}
{#if Music}ukrainian.MusicButtonCaptionSoundOff=Музика: ВИКЛ{#endif}
{#if UseTasks}ukrainian.SelectTasks=Клацніть, щоб вибрати завдання...{#endif}
{#if UseRedists}ukrainian.InstallingRedist=Встановлення %1 ...{#endif}
{#if UseRedists}ukrainian.InstallingRedistCM=Встановлення додаткового ПЗ...{#endif}
{#if INISettings}ukrainian.EnterPlayerName=Введіть ім'я гравця:{#endif}
{#if UseSystemReq}ukrainian.SystemReqLabel1=Програма інсталяції перевірить системні вимоги. Пункти, позначені червоним кольором, вказують на те, що ваше обладнання не відповідає вказаним вимогам.{#endif}
{#if UseSystemReq}ukrainian.SystemReqLabel2=У вашій системі виявлено таке обладнання:{#endif}
{#if UseSystemReq}ukrainian.DirectXNeeded=Необхідно:{#endif}
{#if UseSystemReq}ukrainian.Hardware0=Ваша система НЕ відповідає мінімальним системним вимогам.{#endif}
{#if UseSystemReq}ukrainian.Hardware100=Ваша система відповідає рекомендованим системним вимогам.{#endif}
{#if UseSystemReq}ukrainian.Hardware50=Ваша система лише частково відповідає системним вимогам.{#endif}
{#if UseComponents}ukrainian.SelectComponents=Клацніть, щоб вибрати компоненти...{#endif}
{#if UseComponents || UseTasks}ukrainian.CompEnglish=Angličtina{#endif}
{#if UseComponents || UseTasks}ukrainian.CompFrench=Francouzština{#endif}
{#if UseComponents || UseTasks}ukrainian.CompGerman=Němec{#endif}
{#if UseComponents || UseTasks}ukrainian.CompItalian=Italština{#endif}
{#if UseComponents || UseTasks}ukrainian.CompSpanish=španělština{#endif}
{#if UseComponents || UseTasks}ukrainian.CompPolish=Polština{#endif}
{#if UseComponents || UseTasks}ukrainian.CompRussian=Ruština{#endif}
{#if UseComponents || UseTasks}ukrainian.CompPortugueseBrazil=Portugalština (Brazílie){#endif}
{#if UseComponents || UseTasks}ukrainian.CompCzech=čeština{#endif}
{#if UseComponents || UseTasks}ukrainian.Compukrainian=Українська{#endif}
{#if WebsiteButton}ukrainian.WebsiteText=Вебсайт{#endif}
{#if UseInstallBackground}ukrainian.BackgroundON=Фон: ВКЛ{#endif}
{#if UseInstallBackground}ukrainian.BackgroundOFF=Фон: ВИКЛ{#endif}
{#if UseBatch}ukrainian.BatchExecution=Очікування виконання пакета...{#endif}

#if CheckCRC
  czech.HashPageTitle=Kontrola integrity souborů, čekejte prosím...
  english.HashPageTitle=Checking files integrity, please wait...
  french.HashPageTitle=Vérification de l'intégrité des fichiers, veuillez patienter...
  german.HashPageTitle=Prüfe Dateiintegrität, bitte warten...
  italian.HashPageTitle={#if CompactMode}Verifica dell'integrità dei file, attendi...{#else}Verifica l'integrità dei file, attendere...{#endif}
  polish.HashPageTitle=Weryfikuję integralność plików, proszę czekać...
  portuguesebrazil.HashPageTitle=Verificando a integridade dos arquivos, por favor aguarde...
  russian.HashPageTitle=Проверка файлов, пожалуйста подождите...
  spanish.HashPageTitle=Checking files integrity, please wait...
  ukrainian.HashPageTitle=Перевірка цілісності файлів, зачекайте...

  #if !UseQuickSFV && !UseRapidCRC
    //czech.HashPageDescription=Zkontrolujte integritu nainstalovaných souborů?
    czech.HashFileLabel=Checking %1 (%2 of %3):
    czech.HashStatusLabel={#if CompactMode}Celkový postup: %1{#else}Ověřeno %1 z %2 souborů (%3%){#endif}
    czech.HashResultLabel=Dobře: %1     Chybí: %2     Špatné: %3
    czech.HashWaitingLabel=Instalační program je připraven provést kontrolu integrity souborů
    czech.HashOk=Hash_OK
    czech.HashNotFound=Soubor nenalezen!
    czech.HashAbort=Kontrola souborů byla přerušena!
    czech.HashBadParam=Neplatný hash algoritmus!
    czech.HashBadHash=Hash souboru se neshoduje!
    czech.HashGeneralError=Obecná chyba!
    czech.HashPause=Pau&za
    czech.HashResume=&Životopis
    czech.HashVerify=&Ověřte
    czech.HashStop=Zas&tavit
    czech.HashCancel=Z&rušit
    czech.HashNext=&Další
    czech.HashLog=L&og
    czech.HashInfo=Inf&o
    czech.HashFileHash=HashSouboru
    czech.HashCalcHash=VypočítanýHash
    czech.HashHashStatus=StavHash
    czech.HashNoFile=ŽádnýSoubor
    czech.HashNotMatched=Nesouhlasí
    czech.HashMatched=Shoda
    czech.HashNull=Nula

    //english.HashPageDescription=Check the integrity of installed files?
    english.HashFileLabel=Checking %1 (%2 of %3):
    english.HashStatusLabel={#if CompactMode}Overall progress: %1{#else}Verifyed %1 of %2 files (%3%){#endif}
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

    //french.HashPageDescription=Vérifier l'intégrité des fichiers installés?
    french.HashFileLabel=Contrôle %1 (%2 sur %3):
    french.HashStatusLabel={#if CompactMode}Progression générale: %1{#else}Analyse %1 des %2 fichiers (%3%){#endif}
    french.HashResultLabel=Ok: %1     Manquant: %2     Mauvais: %3
    french.HashWaitingLabel=Le programme d'installation est prêt à effectuer la vérification du hachage des fichiers
    french.HashOk=Hachage_OK
    french.HashNotFound=Fichier non trouvé!
    french.HashAbort=La vérification des fichiers a été interrompue!
    french.HashBadParam=Algorithme de hachage non valide!
    french.HashBadHash=Le hachage du fichier ne correspond pas!
    french.HashGeneralError=Erreur générale!
    french.HashPause=&Suspendre
    french.HashResume=Résu&mé
    french.HashVerify=&Vérifie
    french.HashStop=S&top
    french.HashCancel=&Annuler
    french.HashNext=&Suivant
    french.HashLog=&Journal
    french.HashInfo=In&fo
    french.HashFileHash=FichierDeHachage
    french.HashCalcHash=CalculerLeHachage
    french.HashHashStatus=StatutDeHachage
    french.HashNoFile=AucunFichier
    french.HashNotMatched=PasDeCorrespondance
    french.HashMatched=LeHashcorrespond
    french.HashNull=Nul

    //german.HashPageDescription=ÜSoll die Dateiintegrität geprüft werden?
    german.HashFileLabel=Prüfe %1 (%2 von %3):
    german.HashStatusLabel={#if CompactMode}Gesammtfortschritt: %1{#else}Geprüft: %1 von %2 Dateien (%3%){#endif}
    german.HashResultLabel=Ok: %1     Fehlend: %2     Fehlerhaft: %3
    german.HashWaitingLabel=Das Setup ist nun bereit die Dateien zu überprüfen
    german.HashOk=Hash_OK
    german.HashNotFound=Datei nicht gefunden!
    german.HashAbort=Dateiüberprüfung wurde unterbrochen!
    german.HashBadParam=Ungültiger Hash-Algorithmus!
    german.HashBadHash=Datei-Hash stimmt nicht überein!
    german.HashGeneralError=Allgemeiner Fehler!
    german.HashPause=Pa&use
    german.HashResume=Forts&etzen
    german.HashVerify=&Prüfen
    german.HashStop=&Stoppen
    german.HashCancel=A&bbrechen
    german.HashNext=&Weiter
    german.HashLog=L&og
    german.HashInfo=Inf&o
    german.HashFileHash=DateiHash
    german.HashCalcHash=CalcHash
    german.HashHashStatus=HashStatus
    german.HashNoFile=KeineDatei
    german.HashNotMatched=NichtÜbereinstimmend
    german.HashMatched=Übereinstimmend
    german.HashNull=Null

    //italian.HashPageDescription=Verificare l'integrità dei file installati?
    italian.HashFileLabel={#if CompactMode}Controllo %1 (%2 di %3):{#else}italian.HashFileLabel=Verifica %1 (%2 di %3):{#endif}
    italian.HashStatusLabel={#if CompactMode}Progressi generali: %1{#else}Verificato %1 di %2 file (%3%){#endif}
    italian.HashResultLabel=Ok: %1     Mancante: %2     Non valido: %3
    italian.HashWaitingLabel=Il programma di installazione è pronto per eseguire il controllo
    italian.HashOk=Hash_OK
    italian.HashNotFound=File non trovato!
    italian.HashAbort=Il controllo dei file è stato interrotto!
    italian.HashBadParam=Algoritmo hash non valido!
    italian.HashBadHash=L'hash del file non corrisponde!
    italian.HashGeneralError=Errore generale!
    italian.HashPause=Pa&usa
    italian.HashResume=R&iprendere
    italian.HashVerify=&Verificare
    italian.HashStop=&Fermare
    italian.HashCancel=&Annulla
    italian.HashNext=&Prossimo
    italian.HashLog=L&og
    italian.HashInfo=Inf&o
    italian.HashFileHash=FileHash
    italian.HashCalcHash=CalcHash
    italian.HashHashStatus=HashStato
    italian.HashNoFile=NessunFile
    italian.HashNotMatched=NonAbbinato
    italian.HashMatched=Abbinato
    italian.HashNull=Nullo

    //polish.HashPageDescription=Sprawdź integralność zainstalowanych plików?
    polish.HashFileLabel=Zweryfikowano %1 (%2 of %3):
    polish.HashStatusLabel={#if CompactMode}Ogólny postęp: %1{#else}Zweryfikowano %1 z %2 plików (%3%){#endif}
    polish.HashResultLabel=Ok: %1     Brakuje: %2     ŹUszkodzonele: %3
    polish.HashWaitingLabel=Instalator jest gotowy do sprawdzenia integralności plików
    polish.HashOk=Hash_OK
    polish.HashNotFound=Nie znaleziono pliku!
    polish.HashAbort=Sprawdzanie plików zostało przerwane!
    polish.HashBadParam=Nieprawidłowy algorytm hash!
    polish.HashBadHash=Niezgodny hash plików!
    polish.HashGeneralError=Błąd ogólny!
    polish.HashPause=Wstr&zymaj
    polish.HashResume=W&znów
    polish.HashVerify=Zw&eryfikuj
    polish.HashStop=Zat&rzymaj
    polish.HashCancel=&Anuluj
    polish.HashNext=&Dalej
    polish.HashLog=L&og
    polish.HashInfo=Inf&o
    polish.HashFileHash=PlikuHash
    polish.HashCalcHash=ObliczonyHash
    polish.HashHashStatus=HashStatus
    polish.HashNoFile=BrakPliku
    polish.HashNotMatched=Niedopasowane
    polish.HashMatched=Dopasowane
    polish.HashNull=Null

    //portuguesebrazil.HashPageDescription=Verificar a integridade dos arquivos instalados?
    portuguesebrazil.HashFileLabel=Verificando %1 (%2 de %3)
    portuguesebrazil.HashStatusLabel={#if CompactMode}Progresso geral: %1{#else}Verificados %1 de %2 arquivos (%3%){#endif}
    portuguesebrazil.HashResultLabel=Ok: %1     Ausentes: %2     Falhas: %3
    portuguesebrazil.HashWaitingLabel=O instalador está pronto para verificar o integridade dos arquivos
    portuguesebrazil.HashOk=Hash_OK
    portuguesebrazil.HashNotFound=Arquivo não encontrado!
    portuguesebrazil.HashAbort=A verificação de hash dos arquivos foi interrompida!
    portuguesebrazil.HashBadParam=Algoritmo de hash inválido!
    portuguesebrazil.HashBadHash=O hash do arquivo não corresponde!
    portuguesebrazil.HashGeneralError=Erro geral!
    portuguesebrazil.HashPause=Pa&usar
    portuguesebrazil.HashResume=Contin&uar
    portuguesebrazil.HashVerify=&Verificar
    portuguesebrazil.HashStop=&Parar
    portuguesebrazil.HashCancel=&Cancelar
    portuguesebrazil.HashNext=&Avançar
    portuguesebrazil.HashLog=L&og
    portuguesebrazil.HashInfo=Inf&o
    portuguesebrazil.HashFileHash=HashDoArquivo
    portuguesebrazil.HashCalcHash=HashCalculado
    portuguesebrazil.HashHashStatus=HashStatus
    portuguesebrazil.HashNoFile=ArquivoAusente
    portuguesebrazil.HashNotMatched=NãoCorresponde
    portuguesebrazil.HashMatched=Corresponde
    portuguesebrazil.HashNull=Nulo

    //russian.HashPageDescription=Проверить целостность установленных файлов?
    russian.HashFileLabel=Проверка %1 (%2 of %3)
    russian.HashStatusLabel={#if CompactMode}Общий прогресс: %1{#else}Выполнено %1 из %2 файлов (%3%){#endif}
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

    //spanish.HashPageDescription=¿Check the integrity of installed files?
    spanish.HashFileLabel=Verificado %1 (%2 of %3):
    spanish.HashStatusLabel={#if CompactMode}Progreso general:{#else}Verificado %1 de %2 archivos (%3%){#endif}
    spanish.HashResultLabel=Ok: %1     Falta: %2     Malo: %3
    spanish.HashWaitingLabel=El instalador está listo para hacer la comprobación de hash de los archivos
    spanish.HashOk=Hash_OK
    spanish.HashNotFound=¡Archivo no encontrado!
    spanish.HashAbort=¡La verificación del hash de archivos ha sido interrumpida!
    spanish.HashBadParam=¡Algoritmo de hash inválido!
    spanish.HashBadHash=¡El hash de archivo no coincide!
    spanish.HashGeneralError=¡Error general!
    spanish.HashPause=Pa&usa
    spanish.HashResume=Contin&uar
    spanish.HashVerify=&Verify
    spanish.HashStop=De&tener
    spanish.HashCancel=C&ancelar
    spanish.HashNext=&Siguiente
    spanish.HashLog=&Log
    spanish.HashInfo=In&formación
    spanish.HashFileHash=ArchivoHash
    spanish.HashCalcHash=CalculadoHash
    spanish.HashHashStatus=HashEstado
    spanish.HashNoFile=NingúnArchivo
    spanish.HashNotMatched=NoCoinciden
    spanish.HashMatched=Coincidió
    spanish.HashNull=Nulo

    //ukrainian.HashPageDescription=Перевірити цілісність встановлених файлів?
    ukrainian.HashFileLabel=Перевірка %1 (%2 з %3):
    ukrainian.HashStatusLabel={#if CompactMode}Загальний прогрес: %1{#else}Перевірено %1 з %2 файлів (%3%){#endif}
    ukrainian.HashResultLabel=Успішно: %1     Відсутні: %2     Помилкові: %3
    ukrainian.HashWaitingLabel=Програма інсталяції готова розпочати перевірку цілісності файлів
    ukrainian.HashOk=Hash_OK
    ukrainian.HashNotFound=Файл не знайдено!
    ukrainian.HashAbort=Перевірку файлів перервано!
    ukrainian.HashBadParam=Неправильний алгоритм хешування!
    ukrainian.HashBadHash=Хеш файлу не збігається!
    ukrainian.HashGeneralError=Загальна помилка!
    ukrainian.HashPause=Пауза
    ukrainian.HashResume=Продовжити
    ukrainian.HashVerify=&Перевірити
    ukrainian.HashStop=Зупинити
    ukrainian.HashCancel=Скасувати
    ukrainian.HashNext=Далі
    ukrainian.HashLog=Журнал
    ukrainian.HashInfo=Інфо
    ukrainian.HashFileHash=Хеш Файлу
    ukrainian.HashCalcHash=Обчислений Хеш
    ukrainian.HashHashStatus=Статус Хешу
    ukrainian.HashNoFile=Немає Файлу
    ukrainian.HashNotMatched=Не збігається
    ukrainian.HashMatched=Збігається
    ukrainian.HashNull=Нуль
  #endif
#endif

#ifdef DEBUG_SCRIPT
  #expr SaveToFile(AddBackslash(SourcePath) + "Script_PREPROCESSED.iss")
#endif
