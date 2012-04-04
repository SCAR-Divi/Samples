library script_callbacks;

//**
// By Frédéric Hannes (http://www.scar-divi.com)
// License: http://creativecommons.org/licenses/by/3.0/
//**

{$R *.res}

uses
  FastShareMem in '..\FastShareMem.pas', // DO NOT REMOVE, !!MUST BE FIRST USES LINE!!
  SCARLibSetup in '..\SCARLibSetup.pas', // DO NOT REMOVE
  SysUtils,
  Windows;

// Callbacks

procedure ScriptPause; stdcall;
begin
  WriteLn('[Paused] Press play to resume!');
end;
exports ScriptPause;

procedure ScriptResume; stdcall;
begin
  WriteLn('Resuming the script!');
end;
exports ScriptResume;

procedure ScriptTerminate; stdcall;
begin
  WriteLn('The script is terminating!');
end;
exports ScriptTerminate;

end.
