;#define DSG_InternalDLL         /* Adding Setup.dll/<outputfiename>.dll next to the script will compress the DLL file into the Setup.exe/<outputfiename>.exe file  */
;#define DSG_PasswordDLL "123"   /* Same password used in DiskSpan_GUI to extract decompressors from Setup.dll files */


[Setup]
AppName=Unpacker
AppVersion=1.0
CreateAppDir=no
OutputBaseFilename=Unpacker

#include "Include\DSG_Module.iss"

[code]
var
  Form: TSetupForm;

function FreeLibrary(hModule: THandle): BOOL; external 'FreeLibrary@kernel32.dll stdcall delayload';
function GetModuleHandle(lpModuleName: String): THandle; external 'GetModuleHandle{#AW}@kernel32.dll stdcall delayload';

function Callback(OveralPct, CurrentPct: Integer; CurrentFile, TimeStr1, TimeStr2, TimeStr3: PAnsiChar): LongWord;
begin
  Form.Caption := ' Unpacking...       ' + IntToStr(Round(SplitPct + Double(OveralPct)) div 10) + '.' + Chr(48 + Round(SplitPct + Double(OveralPct)) mod 10) + '%     ' + TimeStr1;
  Result := ISDoneCancel;
end;

procedure Unpack_OnClick(Sender: TObject);
begin
  if FileExists(ExpandConstant('{src}\Setup.dll')) then
  begin
    if not DSG_Unpacking then
    begin
      DSG_OutputPath := ExpandConstant('{src}\Unpacked');
      TNewButton(Sender as TNewButton).Caption := 'Cancel';
      if (TNewButton(Sender as TNewButton).Tag = 1) or BrowseForFolder('Select folder to unpack files', DSG_OutputPath, True) then
        if DSG_Unpack_Process(True, '', nil, nil, nil, nil, nil, @Callback, nil, nil) then { unpack files }
          MsgBox('Unpacked successfully!', mbInformation, MB_OK);

      (*
      UnloadDLL(ExpandConstant('{tmp}\IsDone.dll'));
      UnloadDLL(ExpandConstant('{tmp}\UnArc.dll'));
      while FileExists(ExpandConstant('{tmp}\XDelta3.dll'))
      and BOOLEAN(FreeLibrary(GetModuleHandle(ExpandConstant('{tmp}\XDelta3.dll')))) do
      begin
        UnloadDLL(ExpandConstant('{tmp}\XDelta3.dll'));
        DeleteFile(ExpandConstant('{tmp}\XDelta3.dll'));
      end;
      *)

      TNewButton(Sender as TNewButton).Caption := DSG_IfThen(TNewButton(Sender as TNewButton).Tag = 0, 'Unpack (Browse)', 'Unpack (Unpacked)');
      Form.Caption := 'Mini Unpacker';
    end else
      ISDoneCancel := 1;
  end else
    MsgBox('The setup.dll file was not found.' + #13#10 + 'Place Unpacker.exe in the same folder as Setup.dll.', mbInformation, MB_OK);
end;

function InitializeSetup(): Boolean;
begin
  Form := CreateCustomForm();
  try
    with Form do begin
      ClientWidth := ScaleX(250);
      ClientHeight := ScaleY(45);
      BorderIcons := [biSystemMenu];
      Position := poScreenCenter;
      Caption := 'Mini Unpacker';
    end;
    with TNewButton.Create(Form) do begin
      Parent := Form;
      SetBounds(ScaleX(10), ScaleX(10), ScaleX(110), ScaleY(25));
      Caption := 'Unpack (Browse)';
      Tag := 0;
      OnClick := @Unpack_OnClick;
    end;
    with TNewButton.Create(Form) do begin
      Parent := Form;
      SetBounds(ScaleX(130), ScaleX(10), ScaleX(110), ScaleY(25));
      Caption := 'Unpack (Unpacked)';
      Tag := 1;
      OnClick := @Unpack_OnClick;
    end;
    Form.ShowModal;
  finally
    Form.Free;
  end;
  Result := False;
end;


