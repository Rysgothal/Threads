unit Threads.Forms.BarraProgresso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, System.Zip, Vcl.ExtCtrls,
  Threads.Classes.ThreadCompressaoArquivos;

type
  TfrmBarrasProgresso = class(TForm)
    Panel1: TPanel;
    lblProgressoTotal: TLabel;
    lblProgressoArquivo: TLabel;
    lblNomePastaCompactada: TLabel;
    lblArquivoCompactado: TLabel;
    pgbArquivo: TProgressBar;
    pgbTotal: TProgressBar;
    StatusBar1: TStatusBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CompactarArquivo(pArquivos: TStrings);
  public
    { Public declarations }
    constructor Create(pCaminhoAlvo: string); reintroduce; overload;
    procedure Show(pArquivos: TStrings); overload;
  end;

var
  frmBarrasProgresso: TfrmBarrasProgresso;

implementation

{$R *.dfm}

procedure TfrmBarrasProgresso.Show(pArquivos: TStrings);
begin
  inherited Show;
  CompactarArquivo(pArquivos);
end;

procedure TfrmBarrasProgresso.CompactarArquivo;
var
  lThread: TThreadCompressaoArquivos;
begin
  lThread := TThreadCompressaoArquivos.Create(pArquivos, StatusBar1.Panels[0].Text + lblNomePastaCompactada.Caption);
  lThread.Start;
end;

constructor TfrmBarrasProgresso.Create(pCaminhoAlvo: string);
begin
  inherited Create(Owner);

  lblNomePastaCompactada.Caption := ExtractFileName(pCaminhoAlvo);
  StatusBar1.Panels[0].Text := ExtractFileDir(pCaminhoAlvo);
end;

procedure TfrmBarrasProgresso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmBarrasProgresso := nil;
end;

end.
