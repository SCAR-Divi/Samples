unit MyExports;

//**
// By Frédéric Hannes (http://www.scar-divi.com)
// License: http://creativecommons.org/licenses/by/3.0/
// -
// When a new version of SCAR Divi is available, you can aquire an updated
// copy with additional functionality in the samples git repository:
// https://github.com/SCAR-Divi/Samples/tree/master/libraries/main/
//**

interface

uses
  LibAPI.Setup, LibAPI.Types, LibAPI.Wrapper;

implementation

procedure HelloWorld; stdcall;
begin
  SCAR_DebugLn('Hello World!');
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

initialization
  ExportFunction(@HelloWorld, 'procedure HelloWorld;', ccStdCall);
  ExportFunction(@SaveBitmapToPng, 'procedure SaveBitmapToPng(const Bmp: TSCARBitmap; const Path: string);', ccStdCall);
  ExportFunction(@BmpToPng, 'procedure BmpToPng(const BmpPath, PngPath: string);', ccStdCall);

  ExportType('T3DPoint', 'record X, Y, Z: Integer; end;');
end.
