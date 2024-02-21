object frmSemaforo: TfrmSemaforo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmSemaforo'
  ClientHeight = 168
  ClientWidth = 50
  Color = clBtnFace
  Constraints.MaxHeight = 207
  Constraints.MaxWidth = 66
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object shpVermelho: TShape
    Left = -1
    Top = 9
    Width = 49
    Height = 38
    Brush.Color = clRed
    Shape = stCircle
  end
  object shpAmarelo: TShape
    Left = -1
    Top = 65
    Width = 49
    Height = 38
    Brush.Color = clYellow
    Shape = stCircle
  end
  object shpVerde: TShape
    Left = -1
    Top = 121
    Width = 49
    Height = 38
    Brush.Color = clLime
    Shape = stCircle
  end
end
