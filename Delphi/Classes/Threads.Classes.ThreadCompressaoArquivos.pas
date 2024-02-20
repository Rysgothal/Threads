unit Threads.Classes.ThreadCompressaoArquivos;

interface

uses
  System.Zip, System.Classes, System.SysUtils;

type
  TThreadCompressaoArquivos = class(TThread)
  private
    FArquivos: TStrings;
    FCaminhoAlvo: string;
    procedure CompactarArquivos;
    function RetornarTamanhoArquivo(const pCaminhoArquivo: string): Int64;
    procedure AtualizarTamanho;
    procedure AtualizarProgressoCompactacao(Sender: TObject; pFileName: string; pHeader: TZipHeader; pPosition: Int64);
  protected
    procedure Execute; override;
  public
    FTamanhoTotal: Int64;
    FTamanhoProcessado: Int64;
    constructor Create(pArquivos: TStrings; pCaminhoAlvo: string);
  end;

implementation

uses
  Threads.Forms.BarraProgresso;

{ TThreadCompressaoArquivos }

procedure TThreadCompressaoArquivos.AtualizarProgressoCompactacao(Sender: TObject; pFileName: string; pHeader: TZipHeader;
  pPosition: Int64);
var
  lPorcentagemArquivo, lPorcentagemGeral: Real;
begin
  lPorcentagemArquivo := pPosition / pHeader.UncompressedSize * 100;
  lPorcentagemGeral := (FTamanhoProcessado + pPosition) / (FTamanhoTotal) * 100;

  frmBarrasProgresso.pgbArquivo.Position := Trunc(lPorcentagemArquivo);
  frmBarrasProgresso.pgbTotal.Position := Trunc(lPorcentagemGeral);

  frmBarrasProgresso.lblProgressoArquivo.Caption := FormatFloat('0#.## %', lPorcentagemArquivo);
  frmBarrasProgresso.lblProgressoTotal.Caption := FormatFloat('0#.## %', lPorcentagemGeral);
end;

procedure TThreadCompressaoArquivos.AtualizarTamanho;
begin
  for var lArquivo in FArquivos do
  begin
    FTamanhoTotal := FTamanhoTotal + RetornarTamanhoArquivo(lArquivo);
  end;
end;

procedure TThreadCompressaoArquivos.CompactarArquivos;
var
  lCompactador: TZipFile;
begin
  lCompactador := TZipFile.Create;

  try
    frmBarrasProgresso.lblNomePastaCompactada.Caption := FCaminhoAlvo + '.zip';
    AtualizarTamanho;
    lCompactador.OnProgress := AtualizarProgressoCompactacao;
    lCompactador.Open(FCaminhoAlvo + '.zip', zmWrite);

    for var lArquivo in FArquivos do
    begin
      frmBarrasProgresso.lblArquivoCompactado.Caption := lArquivo;
      lCompactador.Add(lArquivo);
      FTamanhoProcessado := FTamanhoProcessado + lCompactador.FileInfo[Pred(lCompactador.FileCount)].UncompressedSize;
    end;

  finally
    FreeAndNil(lCompactador);
  end;
end;

constructor TThreadCompressaoArquivos.Create(pArquivos: TStrings; pCaminhoAlvo: string);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  Priority := tpHigher;

  FArquivos := pArquivos;
  FCaminhoAlvo := pCaminhoAlvo;
  FTamanhoTotal := 0;
  FTamanhoProcessado := 0;
end;

procedure TThreadCompressaoArquivos.Execute;
begin
  inherited;
  CompactarArquivos;
end;

function TThreadCompressaoArquivos.RetornarTamanhoArquivo(const pCaminhoArquivo: string): Int64;
var
  lArquivo: TFileStream;
begin
  lArquivo := TFileStream.Create(pCaminhoArquivo, fmOpenRead);

  try
    Result := lArquivo.Size;
  finally
    lArquivo.Free;
  end;
end;

end.
