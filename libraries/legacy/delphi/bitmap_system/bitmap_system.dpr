library bitmap_system;

//**
// By Frédéric Hannes (http://www.scar-divi.com)
// License: http://creativecommons.org/licenses/by/3.0/
//**

{$R *.res}

uses
  FastShareMem in '..\FastShareMem.pas', // DO NOT REMOVE, !!MUST BE FIRST USES LINE!!
  SCARLibSetup in '..\SCARLibSetup.pas', // DO NOT REMOVE
  SysUtils,
  Windows,
  Graphics,
  Jpeg,
  PngImage;

// Drawing on bitmap in SCAR's bitmap system
procedure DrawLine(const Bmp: Integer); stdcall;
var
  Canvas: TCanvas;
  W, H: Integer;
begin
  if not BitmapAssigned(Bmp) then
    raise Exception.Create('Bitmap not assigned');

  GetBitmapSize(Bmp, W, H);

  Canvas := TCanvas.Create;
  try
    Canvas.Handle := GetBitmapDc(Bmp);
    Canvas.Pen.Color := clRed;
    Canvas.MoveTo(0, 0);
    Canvas.LineTo(W, H);
  finally
    Canvas.Free;
  end;
end;

// Export bitmap from library to SCAR's bitmap system
function BitmapFromJPEG(const Path: AnsiString): Integer; stdcall;
var
  Jpg: TJpegImage;
  Bmp: TBitmap;
begin
  if not FileExists(Path) then
    Exit(-1);

  Jpg := TJpegImage.Create;
  Bmp := TBitmap.Create;
  try
    Jpg.LoadFromFile(Path);
    Bmp.Assign(Jpg);
    Result := SCARLibSetup.CreateBitmap(Bmp.Width, Bmp.Height, 0);
    BitBlt(GetBitmapDc(Result), 0, 0, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
  finally
    Jpg.Free;
    Bmp.Free;
  end;
end;

// Import bitmap from library from SCAR's bitmap system
procedure BitmapToPNG(const BmpIdx: Integer; const Path: AnsiString); stdcall;
var
  Bmp: TBitmap;
  Png: TPngImage;
  W, H: Integer;
begin
  if not BitmapAssigned(BmpIdx) then
    raise Exception.Create('Bitmap not assigned');

  GetBitmapSize(BmpIdx, W, H);

  Bmp := TBitmap.Create;
  Png := TPngImage.Create;
  try
    Bmp.SetSize(W, H);
    BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, GetBitmapDc(BmpIdx), 0, 0, SRCCOPY);
    Png.Assign(Bmp);
    Png.SaveToFile(Path);
  finally
    Bmp.Free;
    Png.Free;
  end;
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
      ProcRef := @DrawLine;
      StrPCopy(ProcDef, 'procedure DrawLine(const Bmp: Integer);');
    end;
    1: begin
      ProcRef := @BitmapFromJPEG;
      StrPCopy(ProcDef, 'function BitmapFromJPEG(const Path: AnsiString): Integer;');
    end;
    2: begin
      ProcRef := @BitmapToPNG;
      StrPCopy(ProcDef, 'procedure BitmapToPNG(const BmpIdx: Integer; const Path: AnsiString);');
    end;
    else Exit(-1);
  end;
end;
exports GetFunctionInfo;

end.
