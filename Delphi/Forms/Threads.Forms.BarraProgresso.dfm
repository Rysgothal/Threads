object frmBarrasProgresso: TfrmBarrasProgresso
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Progresso'
  ClientHeight = 169
  ClientWidth = 584
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 169
    Align = alClient
    TabOrder = 0
    object lblProgressoTotal: TLabel
      Left = 532
      Top = 107
      Width = 3
      Height = 15
    end
    object lblProgressoArquivo: TLabel
      Left = 532
      Top = 44
      Width = 3
      Height = 15
    end
    object lblNomePastaCompactada: TLabel
      Left = 29
      Top = 79
      Width = 107
      Height = 15
      Caption = 'Pasta Compactando'
    end
    object lblArquivoCompactado: TLabel
      Left = 29
      Top = 16
      Width = 121
      Height = 15
      Caption = 'Arquivo Compactando'
    end
    object pgbArquivo: TProgressBar
      Left = 29
      Top = 37
      Width = 480
      Height = 29
      TabOrder = 0
    end
    object pgbTotal: TProgressBar
      Left = 29
      Top = 100
      Width = 480
      Height = 29
      TabOrder = 1
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 149
      Width = 582
      Height = 19
      Panels = <
        item
          Text = 'Local do Arquivo:'
          Width = 50
        end>
    end
  end
end
