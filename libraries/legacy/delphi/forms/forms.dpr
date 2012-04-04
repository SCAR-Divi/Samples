library forms;

//**
// By Frédéric Hannes (http://www.scar-divi.com)
// License: http://creativecommons.org/licenses/by/3.0/
//**

{$R *.res}

uses
  FastShareMem in '..\FastShareMem.pas', // DO NOT REMOVE, !!MUST BE FIRST USES LINE!!
  SCARLibSetup in '..\SCARLibSetup.pas', // DO NOT REMOVE
  form in 'form.pas',
  Generics.Collections,
  Controls,
  Forms,
  SysUtils;

var
  Form: TSmallForm;

function CreateSmallForm: TForm; stdcall;
begin
  Form := TSmallForm.Create(nil);
  Result := Form;
end;

function SmallFormShowModal: TModalResult; stdcall;
begin
  REsult := Form.ShowModal;
end;

procedure FreeSmallForm; stdcall;
begin
  if Assigned(Form) then
    FreeAndNil(Form);
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
      ProcRef := @CreateSmallForm;
      StrPCopy(ProcDef, 'function CreateSmallForm: TForm;');
    end;
    1: begin
      ProcRef := @SmallFormShowModal;
      StrPCopy(ProcDef, 'function SmallFormShowModal: TModalResult');
    end;
    2: begin
      ProcRef := @FreeSmallForm;
      StrPCopy(ProcDef, 'procedure FreeSmallForm;');
    end;
    else Exit(-1);
  end;
end;
exports GetFunctionInfo;

end.
