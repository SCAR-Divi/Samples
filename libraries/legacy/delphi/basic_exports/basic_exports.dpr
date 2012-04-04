library basic_exports;

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

type
  TPoint3D = record
    X, Y, Z: Integer;
  end;

procedure WriteHello; stdcall;
begin
  WriteLn('Hello World!');
end;

function Point3D(const X, Y, Z: Integer): TPoint3D; stdcall;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
end;

function Distance3D(const P1, P2: TPoint3D): Extended; stdcall;
begin
  Result := Sqrt(Sqr(P1.X - P2.X) + Sqr(P1.Y - P2.Y) + Sqr(P1.Z - P2.Z));
end;

// Exporting code

function GetFunctionCount: Integer; stdcall;
begin
  Result := 3;
end;
exports GetFunctionCount;

function GetFunctionInfo(X: Integer; var ProcRef: Pointer; var ProcDef: PAnsiChar): Integer; stdcall;
begin
  Result := X;
  case X of
    0: begin
      ProcRef := @WriteHello;
      StrPCopy(ProcDef, 'procedure WriteHello;');
    end;
    1: begin
      ProcRef := @Point3D;
      StrPCopy(ProcDef, 'function Point3D(const X, Y, Z: Integer): TPoint3D;');
    end;
    2: begin
      ProcRef := @Distance3D;
      StrPCopy(ProcDef, 'function Distance3D(const P1, P2: TPoint3D): Extended;');
    end;
    else Exit(-1);
  end;
end;
exports GetFunctionInfo;

function GetTypeCount: Integer; stdcall;
begin
  Result := 1;
end;
exports GetTypeCount;

function GetTypeInfo(X: Integer; var TypeName, TypeDef: AnsiString): Integer; stdcall;
begin
  case X of
    0: begin
      TypeName := 'TPoint3D';
      TypeDef := 'record X, Y, Z: Integer; end;';
    end;
  else
    X := -1;
  end;
  Result := X;
end;
exports GetTypeInfo;

end.
