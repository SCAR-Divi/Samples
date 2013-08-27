unit LibAPI.Setup;

//**
// By Frédéric Hannes (http://www.scar-divi.com)
// License: http://creativecommons.org/licenses/by/3.0/
// -
// When a new version of SCAR Divi is available, you can aquire an updated
// copy with additional functionality in the samples git repository:
// https://github.com/SCAR-Divi/Samples/tree/master/libraries/main/
//**

interface

// DO NOT MODIFY THIS UNIT!

uses
  LibAPI.Types;

var
  Exp: PExports = nil;

procedure ExportFunction(const Ref: Pointer; const Def: AnsiString; const Conv: TCallConv);
procedure ExportType(const TypeName, TypeDef: PAnsiChar);

implementation

uses
  Generics.Collections;

var
  Functions: TList<TFunctionExport> = nil;
  Types: TList<TTypeExport> = nil;

procedure ExportFunction(const Ref: Pointer; const Def: AnsiString; const Conv: TCallConv);
begin
  if not Assigned(Functions) then
    Functions := TList<TFunctionExport>.Create;
  Functions.Add(TFunctionExport.Create(Ref, Def, Conv));
end;

procedure ExportType(const TypeName, TypeDef: PAnsiChar);
begin
  if not Assigned(Types) then
    Types := TList<TTypeExport>.Create;
  Types.Add(TTypeExport.Create(TypeName, TypeDef));
end;

// - Function exports
// Do NOT change this!
function OnGetFuncCount: Integer; stdcall;
begin
  if Assigned(Functions) then
    Result := Functions.Count
  else
    Result := 0;
end;

function OnGetFuncInfo(const Idx: Integer; out ProcAddr: Pointer; out ProcDef: PAnsiChar;
  out CallConv: TCallConv): Integer; stdcall;
var
  FuncExp: TFunctionExport;
begin
  if Assigned(Functions) and (Idx >= 0) and (Idx < Functions.Count) then
  begin
    FuncExp := Functions[Idx];
    ProcAddr := FuncExp.Ref;
    ProcDef := PAnsiChar(FuncExp.Def);
    CallConv := FuncExp.Conv;
    Result := Idx;
  end else
    Result := -1;
end;

// - Type exports
// Do NOT change this!
function OnGetTypeCount: Integer; stdcall;
begin
  if Assigned(Types) then
    Result := Types.Count
  else
    Result := 0;
end;

function OnGetTypeInfo(const Idx: Integer; out TypeName, TypeDef: PAnsiChar): Integer; stdcall;
var
  TypeExp: TTypeExport;
begin
  if Assigned(Types) and (Idx >= 0) and (Idx < Types.Count) then
  begin
    TypeExp := Types[Idx];
    TypeName := PAnsiChar(TypeExp.Name);
    TypeDef := PAnsiChar(TypeExp.Def);
    Result := Idx;
  end else
    Result := -1;
end;

// - Load/unload events
// Do NOT change this!

procedure OnLoadLib(const SCARExports: PExports); stdcall;
begin
  Exp := SCARExports; // Do NOT remove this line!
end;

procedure OnUnloadLib; stdcall;
begin
  // Called when the library is unloaded
end;

// - Library architecture
// Do NOT change this!
const
  LIBRARY_ARCHITECTURE_LEGACY = 1;
  LIBRARY_ARCHITECTURE_MAIN   = 2;

function LibArch: Integer; stdcall;
begin
  Result := LIBRARY_ARCHITECTURE_MAIN;
end;

exports OnGetFuncCount;
exports OnGetFuncInfo;
exports OnGetTypeCount;
exports OnGetTypeInfo;
exports OnLoadLib;
exports OnUnloadLib;
exports LibArch;

initialization
finalization
  Functions.Free;
  Types.Free;
end.
