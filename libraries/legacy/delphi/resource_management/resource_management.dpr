library resource_management;

//**
// By Frédéric Hannes (http://www.scar-divi.com)
// License: http://creativecommons.org/licenses/by/3.0/
//**

{$R *.res}

uses
  FastShareMem in '..\FastShareMem.pas', // DO NOT REMOVE, !!MUST BE FIRST USES LINE!!
  SCARLibSetup in '..\SCARLibSetup.pas', // DO NOT REMOVE
  Generics.Collections,
  SysUtils;

var
  Map: TDictionary<AnsiString, AnsiString>;

procedure SetMapString(const Key, Value: AnsiString); stdcall;
begin
  Map.Add(Key, Value);
end;

function GetMapString(const Key: AnsiString): AnsiString; stdcall;
begin
  Result := '';
  if Map.ContainsKey(Key) then
    Result:= Map[Key];
end;

// Callbacks

procedure OnLoadLib; stdcall;
begin
  // Create hashmap
  Map := TDictionary<AnsiString, AnsiString>.Create;
end;
exports OnLoadLib;

procedure OnUnLoadLib; stdcall;
begin
  // Free map when the plugin is unloaded to prevent memory leak!
  Map.Free;
end;
exports OnUnLoadLib;

// Exporting code

function GetFunctionCount: Integer; stdcall;
begin
  Result := 2;
end;
exports GetFunctionCount;

function GetFunctionInfo(X: Integer; var ProcRef: Pointer; var ProcDef: PAnsiChar): Integer; stdcall;
begin
  Result := X;
  case X of
    0: begin
      ProcRef := @SetMapString;
      StrPCopy(ProcDef, 'procedure SetMapString(const Key, Value: AnsiString);');
    end;
    1: begin
      ProcRef := @GetMapString;
      StrPCopy(ProcDef, 'function GetMapString(const Key: AnsiString): AnsiString;');
    end;
    else Exit(-1);
  end;
end;
exports GetFunctionInfo;

end.
