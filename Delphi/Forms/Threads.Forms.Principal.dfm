object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Threads'
  ClientHeight = 389
  ClientWidth = 220
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object pnlInformacoes: TPanel
    Left = 9
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
    Left = 9
    Top = 104
    Width = 201
    Height = 193
    ItemHeight = 15
    TabOrder = 1
  end
  object btnCriarThreadClasse: TButton
    Left = 15
    Top = 63
    Width = 89
    Height = 31
    Caption = 'Criar Classe'
    TabOrder = 2
    OnClick = btnCriarThreadClasseClick
  end
  object btnCriarThreadAnonima: TButton
    Left = 110
    Top = 63
    Width = 89
    Height = 31
    Caption = 'Criar Anonima'
    TabOrder = 3
    OnClick = btnCriarThreadAnonimaClick
  end
  object btnComprimirArquivo: TButton
    Left = 34
    Top = 305
    Width = 153
    Height = 34
    Caption = 'Comprimir Arquivos'
    TabOrder = 4
    OnClick = btnComprimirArquivoClick
  end
  object btnSemafaro: TButton
    Left = 34
    Top = 345
    Width = 153
    Height = 34
    Caption = 'Sem'#225'foro'
    TabOrder = 5
    OnClick = btnSemafaroClick
  end
end
