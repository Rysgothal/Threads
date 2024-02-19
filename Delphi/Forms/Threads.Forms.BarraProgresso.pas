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
    FTamanhoTotal: Int64;
    FTamanhoProcessado: int64;
    procedure CompactarArquivo(pItems: TStrings);
    function RetornarTamanhoArquivo(const pNomeArquivo: string): Integer;
    procedure AtualizarProgressoCompactacao(Sender: TObject; pFileName: string; pHeader: TZipHeader; pPosition: Int64);
    procedure DescompactarArquivo;
  public
    { Public declarations }
    constructor Create(pItems: TStrings; pNomePasta, pLocal: string); reintroduce; overload;
    constructor Create(pNomePasta, pLocal: string); reintroduce; overload;
    procedure Show(pItems: TStrings); reintroduce; overload;
    procedure Show; reintroduce; overload;
  end;

var
  frmBarrasProgresso: TfrmBarrasProgresso;

implementation

{$R *.dfm}

procedure TfrmBarrasProgresso.AtualizarProgressoCompactacao(Sender: TObject; pFileName: string; pHeader: TZipHeader;
  pPosition: Int64);
var
  lTamanhoProcessado, lTamanhoTotal: Int64;
  vPorcentagemArquivo: Real;
  vPorcentagemGeral: Real;
begin
  Application.ProcessMessages;



  lTamanhoTotal := TThreadCompressaoArquivos(Sender).FTamanhoTotal;
  lTamanhoProcessado := TThreadCompressaoArquivos(Sender).FTamanhoProcessado;

  vPorcentagemArquivo := pPosition / pHeader.UncompressedSize * 100;
  vPorcentagemGeral := lTamanhoProcessado + pPosition / lTamanhoTotal * 100;
  
  pgbArquivo.Position := Trunc(vPorcentagemArquivo);
  pgbTotal.Position := Trunc(vPorcentagemGeral);

  lblProgressoArquivo.Caption := FormatFloat('0#.## %', vPorcentagemArquivo);
  lblProgressoTotal.Caption := FormatFloat('0#.## %', vPorcentagemGeral);
end;

function TfrmBarrasProgresso.RetornarTamanhoArquivo(const pNomeArquivo: string): Integer;
var
  vStream: TFileStream;
begin
  vStream := TFileStream.Create(pNomeArquivo, fmOpenRead);
  try
    Result := vStream.Size;
  finally
    vStream.Free;
  end;
end;

procedure TfrmBarrasProgresso.Show;
begin
  inherited;
//  DescompactarArquivo;
end;

procedure TfrmBarrasProgresso.Show(pItems: TStrings);
begin
  Visible := True;
  BringToFront;
//  CompactarArquivo(pItems);
end;

procedure TfrmBarrasProgresso.CompactarArquivo(pItems: TStrings);
var
  vZipFile: TZipFile;
  vNomePasta: string;
begin
  for var vArquivo in pItems do
  begin
    FTamanhoTotal := FTamanhoTotal + RetornarTamanhoArquivo(vArquivo);
  end;

  vNomePasta := '\' + lblNomePastaCompactada.Caption + '.zip';
  vZipFile := TZipFile.Create;
  vZipFile.OnProgress := AtualizarProgressoCompactacao;

  try
    if lblNomePastaCompactada.Caption = EmptyStr then
    begin
      vNomePasta := '\ArquivosCompactados.zip';
    end;

    lblNomePastaCompactada.Caption := vNomePasta;
    vZipFile.Open(StatusBar1.Panels[0].Text + vNomePasta, zmWrite);

    for var vArquivo in pItems do
    begin
      lblArquivoCompactado.Caption := vArquivo;
      vZipFile.Add(vArquivo);

      FTamanhoProcessado := FTamanhoProcessado + vZipFile.FileInfo[Pred(vZipFile.FileCount)].UncompressedSize;
    end;

    Application.MessageBox('Compactação Concluida', 'Sucesso');
  finally
    vZipFile.Free;
    Close;
  end;
end;

constructor TfrmBarrasProgresso.Create(pNomePasta, pLocal: string);
begin
  inherited Create(Owner);
  FTamanhoTotal := 0;
  FTamanhoProcessado := 0;

  pgbTotal.Visible := False;
  lblNomePastaCompactada.Visible := False;
  lblArquivoCompactado.Caption := pNomePasta;
  StatusBar1.Panels[0].Text := pLocal;
end;

procedure TfrmBarrasProgresso.DescompactarArquivo;
var
  vUnzip: TZipFile;
  vNomeArquivo, vDiretorio: string;
begin
  vUnzip := TZipFile.Create;
  vNomeArquivo := lblArquivoCompactado.Caption;

  FTamanhoTotal := FTamanhoTotal + RetornarTamanhoArquivo(vNomeArquivo);

  vDiretorio := ExtractFilePath(vNomeArquivo) + ExtractFileName(vNomeArquivo);
  vDiretorio := Copy(vDiretorio, 1, Pred(Pos('.zip', vDiretorio)));

  if vNomeArquivo = EmptyStr then
  begin
    Exit;
  end;

  try
    vUnzip.Open(vNomeArquivo, zmRead);
    vUnzip.ExtractAll(vDiretorio);
    vUnzip.OnProgress := AtualizarProgressoCompactacao;
    vUnzip.Close;
  finally
    FreeAndNil(vUnzip);
    Close;
  end;
end;

constructor TfrmBarrasProgresso.Create(pItems: TStrings; pNomePasta, pLocal: string);
var
  lThread: TThreadCompressaoArquivos;
begin
  inherited Create(Owner);
//  FTamanhoTotal := 0;
//  FTamanhoProcessado := 0;
//

  lThread := TThreadCompressaoArquivos.Create(pItems, pLocal + pNomePasta);
  lThread.Start;

  lblNomePastaCompactada.Caption := pNomePasta;
  StatusBar1.Panels[0].Text := pLocal;
end;

procedure TfrmBarrasProgresso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmBarrasProgresso := nil;
end;

end.
