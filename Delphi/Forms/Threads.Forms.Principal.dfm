object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Threads'
  ClientHeight = 317
  ClientWidth = 220
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object pnlInformacoes: TPanel
    Left = 8
    Top = 8
    Width = 201
    Height = 49
    BevelKind = bkSoft
    TabOrder = 0
    object lblThreadsAtivas: TLabel
      Left = 4
      Top = 4
      Width = 82
      Height = 15
      Caption = 'Threads Ativas: '
    end
    object lblQtdThreads: TLabel
      Left = 88
      Top = 4
      Width = 6
      Height = 15
      Caption = '0'
    end
  end
  object lbxThreads: TListBox
    Left = 8
    Top = 104
    Width = 201
    Height = 193
    ItemHeight = 15
    TabOrder = 1
  end
  object btnCriarThread: TButton
    Left = 72
    Top = 63
    Width = 67
    Height = 31
    Caption = 'Criar'
    TabOrder = 2
    OnClick = btnCriarThreadClick
  end
end
