object SmallForm: TSmallForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Form'
  ClientHeight = 41
  ClientWidth = 97
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button: TButton
    Left = 8
    Top = 8
    Width = 81
    Height = 25
    Caption = 'Press Me!'
    TabOrder = 0
    OnClick = ButtonClick
  end
end
