unit SCARLibSetup;

//**
// By Frédéric Hannes (http://www.scar-divi.com)
// License: http://creativecommons.org/licenses/by/3.0/
//**

interface

uses
  Windows, Graphics, SysUtils;

type
  TSCARPlugFunc = record
    Name: AnsiString;
    Ptr: Pointer;
  end;

var
  WriteLn: procedure(s: AnsiString);
  Status: procedure(s: AnsiString);
  Wait: procedure(ms: Integer);
  GetBitmapDc: function(Bmp: Integer): HDC;
  GetSCARVersion: function: Integer;
  Disguise: procedure(Caption: AnsiString);
  GetClientWindowHandle: function: Hwnd;
  SetClientWindowHandle: procedure(H: Hwnd);
  InCircle: function(x, y, mx, my, r: Integer): Boolean;
  InTriangle: function(x, y, x1, y1, x2, y2, x3, y3: Integer): Boolean;
  Distance: function(x1, y1, x2, y2: Integer): Integer;
  ConvertTime: procedure(Ms: Integer; var H, M, S: Integer);
  TerminateScript: procedure;
  ClearDebug: procedure;
  GetStatus: function: AnsiString;
  AppPath: function: AnsiString;
  ScriptPath: function: AnsiString;
  AddToReport: procedure(s: AnsiString);
  ClearReport: procedure;
  MoveToTray: procedure;
  ActivateClient: procedure;
  GetDebugText: function: AnsiString;
  DeleteDebugLine: procedure(Line: Integer);
  GetDebugLineCount: function: Integer;
  GetDebugLine: function(Line: Integer): AnsiString;
  ClearDebugLine: procedure(Line: Integer);
  ReplaceDebugLine: procedure(Line: Integer; s: AnsiString);
  GetClientCanvas: function: TCanvas;
  GetDebugCanvas: function: TCanvas;
  GetTimeRunning: function: Integer;
  SetTargetDC: procedure(Dc: HDC);
  ResetDC: procedure;
  SetDesktopAsClient: procedure;
  GetTargetDC: function: HDC;
  ResetCaption: procedure;
  Alert: procedure(s: AnsiString);
  GetClientDimensions: procedure(out Width, Height: Integer);
  IncludesPath: function: AnsiString;
  FontsPath: function: AnsiString;
  LogsPath: function: AnsiString;
  GetReportText: function: AnsiString;
  ScreenPath: function: AnsiString;
  GetClipboard: function: AnsiString;
  SetClipboard: procedure(const Text: AnsiString);
  ClearClipboard: procedure;
  BitmapAssigned: function(const Bmp: Integer): Boolean;
  CreateBitmap: function(const Width, Height, Color: Integer): Integer;
  GetBitmapSize: procedure(const Bmp: Integer; out Width, Height: Integer);
  ResizeBitmap: function(const Bmp, Width, Height: Integer): Integer;
  FreeBitmap: function(const Bmp: Integer): Boolean;
  BitmapFromMem: function(const DC: HDC): Integer;

implementation

procedure SetFunctions(Funcs: array of TSCARPlugFunc); stdcall;
var
  Idx: Integer;
  Name: AnsiString;
begin
  for Idx := 0 to Length(Funcs) - 1 do
  begin
    Name := AnsiString(UpperCase(string(Funcs[Idx].Name)));
    if Name = 'WRITELN' then
      WriteLn := Funcs[Idx].Ptr
    else if Name = 'STATUS' then
      Status := Funcs[Idx].Ptr
    else if Name = 'WAIT' then
      Wait := Funcs[Idx].Ptr
    else if Name = 'GETBITMAPDC' then
      GetBitmapDc := Funcs[Idx].Ptr
    else if Name = 'GETSCARVERSION' then
      GetSCARVersion := Funcs[Idx].Ptr
    else if Name = 'DISGUISE' then
      Disguise := Funcs[Idx].Ptr
    else if Name = 'GETCLIENTWINDOWHANDLE' then
      GetClientWindowHandle := Funcs[Idx].Ptr
    else if Name = 'SETCLIENTWINDOWHANDLE' then
      SetClientWindowHandle := Funcs[Idx].Ptr
    else if Name = 'INCIRCLE' then
      InCircle := Funcs[Idx].Ptr
    else if Name = 'INTRIANGLE' then
      InTriangle := Funcs[Idx].Ptr
    else if Name = 'DISTANCE' then
      Distance := Funcs[Idx].Ptr
    else if Name = 'CONVERTTIME' then
      ConvertTime := Funcs[Idx].Ptr
    else if Name = 'TERMINATESCRIPT' then
      TerminateScript := Funcs[Idx].Ptr
    else if Name = 'CLEARDEBUG' then
      ClearDebug := Funcs[Idx].Ptr
    else if Name = 'GETSTATUS' then
      GetStatus := Funcs[Idx].Ptr
    else if Name = 'APPPATH' then
      AppPath := Funcs[Idx].Ptr
    else if Name = 'SCRIPTPATH' then
      ScriptPath := Funcs[Idx].Ptr
    else if Name = 'ADDTOREPORT' then
      AddToReport := Funcs[Idx].Ptr
    else if Name = 'CLEARREPORT' then
      ClearReport := Funcs[Idx].Ptr
    else if Name = 'MOVETOTRAY' then
      MoveToTray := Funcs[Idx].Ptr
    else if Name = 'DISTANCE' then
      Distance := Funcs[Idx].Ptr
    else if Name = 'ACTIVATECLIENT' then
      ActivateClient := Funcs[Idx].Ptr
    else if Name = 'GETDEBUGTEXT' then
      GetDebugText := Funcs[Idx].Ptr
    else if Name = 'DELETEDEBUGLINE' then
      DeleteDebugLine := Funcs[Idx].Ptr
    else if Name = 'GETDEBUGLINECOUNT' then
      GetDebugLineCount := Funcs[Idx].Ptr
    else if Name = 'GETDEBUGLINE' then
      GetDebugLine := Funcs[Idx].Ptr
    else if Name = 'CLEARDEBUGLINE' then
      ClearDebugLine := Funcs[Idx].Ptr
    else if Name = 'REPLACEDEBUGLINE' then
      ReplaceDebugLine := Funcs[Idx].Ptr
    else if Name = 'GETCLIENTCANVAS' then
      GetClientCanvas := Funcs[Idx].Ptr
    else if Name = 'GETDEBUGCANVAS' then
      GetDebugCanvas := Funcs[Idx].Ptr
    else if Name = 'GETTIMERUNNING' then
      GetTimeRunning := Funcs[Idx].Ptr
    else if Name = 'SETTARGETDC' then
      SetTargetDC := Funcs[Idx].Ptr
    else if Name = 'RESETDC' then
      ResetDC := Funcs[Idx].Ptr
    else if Name = 'SETDESKTOPASCLIENT' then
      SetDesktopAsClient := Funcs[Idx].Ptr
    else if Name = 'GETTARGETDC' then
      GetTargetDC := Funcs[Idx].Ptr
    else if Name = 'RESETCAPTION' then
      ResetCaption := Funcs[Idx].Ptr
    else if Name = 'ALERT' then
      Alert := Funcs[Idx].Ptr
    else if Name = 'GETCLIENTDIMENSIONS' then
      GetClientDimensions := Funcs[Idx].Ptr
    else if Name = 'INCLUDESPATH' then
      IncludesPath := Funcs[Idx].Ptr
    else if Name = 'FONTSPATH' then
      FontsPath := Funcs[Idx].Ptr
    else if Name = 'LOGSPATH' then
      LogsPath := Funcs[Idx].Ptr
    else if Name = 'GETREPORTTEXT' then
      GetReportText := Funcs[Idx].Ptr
    else if Name = 'SCREENPATH' then
      ScreenPath := Funcs[Idx].Ptr
    else if Name = 'GETCLIPBOARD' then
      GetClipboard := Funcs[Idx].Ptr
    else if Name = 'SETCLIPBOARD' then
      SetClipboard := Funcs[Idx].Ptr
    else if Name = 'CLEARCLIPBOARD' then
      ClearClipboard := Funcs[Idx].Ptr
    else if Name = 'BITMAPASSIGNED' then
      BitmapAssigned := Funcs[Idx].Ptr
    else if Name = 'CREATEBITMAP' then
      CreateBitmap := Funcs[Idx].Ptr
    else if Name = 'GETBITMAPSIZE' then
      GetBitmapSize := Funcs[Idx].Ptr
    else if Name = 'RESIZEBITMAP' then
      ResizeBitmap := Funcs[Idx].Ptr
    else if Name = 'FREEBITMAP' then
      FreeBitmap := Funcs[Idx].Ptr
    else if Name = 'BITMAPFROMMEM' then
      BitmapFromMem := Funcs[Idx].Ptr;
  end;
end;

exports SetFunctions;

end.
 