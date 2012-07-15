unit SCARUtils;

interface

//**
// By Frédéric Hannes (http://www.scar-divi.com)
// License: http://creativecommons.org/licenses/by/3.0/
//**

type
  TCallConv = (ccRegister, ccPascal, ccCdecl, ccStdCall, ccSafeCall);

  TFunctionExport = record
    Ref: Pointer;
    Def: AnsiString;
    Conv: TCallConv;
  end;

  PSCARBmpData = ^TSCARBmpData;
  TSCARBmpData = record
    B, G, R, A: Byte;
  end;

  PSCARBmpDataArray = ^TSCARBmpDataArray;
  TSCARBmpDataArray = array[0..0] of TSCARBmpData;

implementation

end.
