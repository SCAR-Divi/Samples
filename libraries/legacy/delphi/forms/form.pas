unit form;

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
