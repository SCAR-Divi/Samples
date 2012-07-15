library basic_exports;

//**
// By Fr�d�ric Hannes (http://www.scar-divi.com)
// License: http://creativecommons.org/licenses/by/3.0/
//**

{$R *.res}

uses
  FastShareMem in '..\FastShareMem.pas',
  SCARLibSetup in '..\SCARLibSetup.pas',
  SCARUtils in '..\SCARUtils.pas',
  SCARApi in '..\SCARApi.pas',
  SysUtils;

procedure HelloWorld; stdcall;
begin
  WriteLn('Hello World!');
end;

procedure SaveBitmapToPng(const Bmp: Pointer; const Path: string); stdcall;
var
  Wrapper: TSCARBitmapWrapper;
begin
  Wrapper := TSCARBitmapWrapper.Create(Bmp);
  try
    Wrapper.SaveToPng(Path);
  finally
    Wrapper.Free;
  end;
end;

procedure BmpToPng(const BmpPath, PngPath: string); stdcall;
var
  Wrapper: TSCARBitmapWrapper;
begin
  Wrapper := TSCARBitmapWrapper.Create;
  try
    Wrapper.OwnsObject := True;
    Wrapper.LoadFromBmp(BmpPath);
    Wrapper.SaveToPng(PngPath);
  finally
    Wrapper.Free;
  end;
end;

const
  FunctionExports: array[0..2] of TFunctionExport = (
    (Ref: @HelloWorld; Def: 'procedure HelloWorld;'; Conv: ccStdCall),
    (Ref: @SaveBitmapToPng; Def: 'procedure SaveBitmapToPng(const Bmp: TSCARBitmap; const Path: string);'; Conv: ccStdCall),
    (Ref: @BmpToPng; Def: 'procedure BmpToPng(const BmpPath, PngPath: string);'; Conv: ccStdCall)
  );

procedure OnLoadLib(const SCARExports: PExports); stdcall;
begin
  Exp := SCARExports; // Do NOT remove this line!
  // Called when the library is loaded
end;

procedure OnUnloadLib; stdcall;
begin
  // Called when the library is unloaded
end;

// Function exports
// Do NOT change this!
function OnGetFuncCount: Integer; stdcall;
begin
  Result := High(FunctionExports) - Low(FunctionExports) + 1;
end;

function OnGetFuncInfo(const Idx: Integer; out ProcAddr: Pointer; out ProcDef: PAnsiChar;
  out CallConv: TCallConv): Integer; stdcall;
var
  FuncExp: TFunctionExport;
begin
  if (Idx >= Low(FunctionExports)) and (Idx <= High(FunctionExports)) then
  begin
    FuncExp := FunctionExports[Idx + Low(FunctionExports)];
    ProcAddr := FuncExp.Ref;
    ProcDef := PAnsiChar(FuncExp.Def);
    CallConv := FuncExp.Conv;
    Result := Idx;
  end else
    Result := -1;
end;

// Library architecture
// Do NOT change this!
const
  LIBRARY_ARCHITECTURE_LEGACY = 1;
  LIBRARY_ARCHITECTURE_MAIN   = 2;

function LibArch: Integer; stdcall;
begin
  Result := LIBRARY_ARCHITECTURE_MAIN;
end;

exports OnLoadLib;
exports OnUnloadLib;
exports OnGetFuncCount;
exports OnGetFuncInfo;
exports LibArch;

end.