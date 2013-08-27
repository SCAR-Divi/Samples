library basic_exports;

//**
// By Frédéric Hannes (http://www.scar-divi.com)
// License: http://creativecommons.org/licenses/by/3.0/
// -
// When a new version of SCAR Divi is available, you can aquire an updated
// copy with additional functionality in the samples git repository:
// https://github.com/SCAR-Divi/Samples/tree/master/libraries/main/
//**

{$R *.res}

uses
  FastShareMem in '..\FastShareMem.pas',     // DO NOT REMOVE, !!MUST BE FIRST USES LINE!!
  LibAPI.Setup in '..\LibAPI.Setup.pas',     // DO NOT REMOVE
  LibAPI.Types in '..\LibAPI.Types.pas',     // DO NOT REMOVE
  LibAPI.Wrapper in '..\LibAPI.Wrapper.pas', // DO NOT REMOVE
  MyExports in 'MyExports.pas';

end.
