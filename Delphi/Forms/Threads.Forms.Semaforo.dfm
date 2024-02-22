object frmSemaforo: TfrmSemaforo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Sem'#225'foro'
  ClientHeight = 183
  ClientWidth = 196
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object pnlViaHorizontal: TPanel
    Left = 37
    Top = 24
    Width = 49
    Height = 145
    TabOrder = 0
    object shpVermelhoHorizontal: TShape
      Left = 0
      Top = 11
      Width = 49
      Height = 38
      Brush.Color = clRed
      Shape = stCircle
    end
    object shpAmareloHorizontal: TShape
      Left = 0
      Top = 55
      Width = 49
      Height = 38
      Brush.Color = clYellow
      Shape = stCircle
    end
    object shpVerdeHorizontal: TShape
      Left = 0
      Top = 99
      Width = 49
      Height = 38
      Brush.Color = clLime
      Shape = stCircle
    end
  end
  object pnlViaVertical: TPanel
    Left = 125
    Top = 24
    Width = 49
    Height = 145
    TabOrder = 1
    object shpVermelhoVertical: TShape
      Left = 0
      Top = 11
      Width = 49
      Height = 38
      Brush.Color = clRed
      Shape = stCircle
    end
    object shpAmareloVertical: TShape
      Left = 0
      Top = 55
      Width = 49
      Height = 38
      Brush.Color = clYellow
      Shape = stCircle
    end
    object shpVerdeVertical: TShape
      Left = 0
      Top = 99
      Width = 49
      Height = 38
      Brush.Color = clLime
      Shape = stCircle
    end
  end
end
