unit form;

//**
// By Frédéric Hannes (http://www.scar-divi.com)
// License: http://creativecommons.org/licenses/by/3.0/
//**

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Vcl.StdCtrls;

type
  TSmallForm = class(TForm)
    Button: TButton;
    procedure ButtonClick(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TSmallForm.ButtonClick(Sender: TObject);
begin
  ShowMessage('Hello World!');
end;

end.
