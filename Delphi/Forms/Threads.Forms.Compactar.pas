unit Threads.Forms.Compactar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.Zip,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.FileCtrl, Vcl.ExtCtrls, Vcl.Mask,
  System.ImageList, Vcl.ImgList, System.StrUtils,
  Threads.Classes.ThreadCompressaoArquivos, Threads.Forms.BarraProgresso;

type
  TfrmCompactador = class(TForm)
    pctPrincipal: TPageControl;
    pgeCompactar: TTabSheet;
    pgeDescompactar: TTabSheet;
    opdSelecionarArquivos: TOpenDialog;
    btnArquivos: TButton;
    lbxArquivosSelecionados: TListBox;
    lblArquivosSelecionados: TLabel;
    btnCompactar: TButton;
    lbeNomePastaParaCompactar: TLabeledEdit;
    btnLimparLista: TButton;
    lbeArquivoComprimidoSelecionado: TLabeledEdit;
    btnDescompactar: TButton;
    lbxArquivosDescompactados: TListBox;
    btnSelecionarPasta: TButton;
    imgIcons: TImageList;
    svdSalvarCaminho: TSaveDialog;
    lbeLocalPastaOndeSalvar: TLabeledEdit;
    lbeLocalDescompactar: TLabeledEdit;
    btnEscolherLocal: TButton;
    procedure btnArquivosClick(Sender: TObject);
    procedure btnCompactarClick(Sender: TObject);
    procedure btnLimparListaClick(Sender: TObject);
    procedure btnDescompactarClick(Sender: TObject);
    procedure btnSelecionarPastaClick(Sender: TObject);
    procedure btnEscolherLocalClick(Sender: TObject);
  private
    procedure CompactarArquivos;
    procedure EscolherOndeSalvar;
    procedure SelecionarArquivos;
    procedure AdicionarArquivosListBox;
    procedure DefinirUltimoDiretorioUsado;
    procedure LimparPaginaCompactar;
    procedure SelecionarArquivoCompactado;
    procedure DescompactarArquivo;
    procedure MostrarArquivosDescomprimidosListBox;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCompactador: TfrmCompactador;

implementation

{$R *.dfm}

procedure TfrmCompactador.AdicionarArquivosListBox;
begin
  for var lFiles in opdSelecionarArquivos.Files do
  begin
    lbxArquivosSelecionados.Items.Add(lFiles);
  end;
end;

procedure TfrmCompactador.btnArquivosClick(Sender: TObject);
begin
  SelecionarArquivos;
end;

procedure TfrmCompactador.btnCompactarClick(Sender: TObject);
begin
  CompactarArquivos;
end;

procedure TfrmCompactador.btnDescompactarClick(Sender: TObject);
begin
  DescompactarArquivo;
end;

procedure TfrmCompactador.btnEscolherLocalClick(Sender: TObject);
begin
  EscolherOndeSalvar;
end;

procedure TfrmCompactador.btnLimparListaClick(Sender: TObject);
begin
  LimparPaginaCompactar;
end;

procedure TfrmCompactador.btnSelecionarPastaClick(Sender: TObject);
begin
  SelecionarArquivoCompactado;
end;

procedure TfrmCompactador.CompactarArquivos;
var
  lNomePasta, lLocalFuturo: string;
//  frmBarrasProgresso: TfrmBarrasProgresso;
begin
  lNomePasta := lbeNomePastaParaCompactar.Text;
  lLocalFuturo := lbeLocalPastaOndeSalvar.Text;

  lNomePasta := IfThen(lNomePasta = EmptyStr, 'Pasta-Compactada', lNomePasta);
  lLocalFuturo := IfThen(lLocalFuturo = EmptyStr, GetCurrentDir + '\' + lNomePasta, lLocalFuturo);

  if (lbxArquivosSelecionados.Items.Count = 0) then
  begin
    Exit;
  end;

  frmBarrasProgresso := TfrmBarrasProgresso.Create(lbxArquivosSelecionados.Items, lNomePasta, lLocalFuturo);
  frmBarrasProgresso.Show(lbxArquivosSelecionados.Items);
end;

procedure TfrmCompactador.DefinirUltimoDiretorioUsado;
var
  lDiretorio: string;
begin
  if lbxArquivosSelecionados.Items.Count = 0 then
  begin
    Exit;
  end;

  lDiretorio := lbxArquivosSelecionados.Items[lbxArquivosSelecionados.Items.Count -1];
  opdSelecionarArquivos.InitialDir := lDiretorio;
end;

procedure TfrmCompactador.DescompactarArquivo;
begin
  if lbeArquivoComprimidoSelecionado.Text = EmptyStr then
  begin
    Exit;
  end;

//  if not Assigned(frmBarrasProgresso) then
//  begin
//    frmBarrasProgresso := TfrmBarrasProgresso.Create(lbeArquivoComprimidoSelecionado.Text, lbeLocalDescompactar.Text);
//    frmBarrasProgresso.Show;
//  end;

  MostrarArquivosDescomprimidosListBox;
end;

procedure TfrmCompactador.EscolherOndeSalvar;
var
  lNomeArquivo: string;
begin
  lNomeArquivo := lbeNomePastaParaCompactar.Text;
  lNomeArquivo := IfThen(lNomeArquivo = EmptyStr, 'Pasta-Compactada', lNomeArquivo);

  try
    svdSalvarCaminho.FileName := lNomeArquivo;

    if not svdSalvarCaminho.Execute then
    begin
      Exit;
    end;

    lbeLocalPastaOndeSalvar.Text := ExtractFilePath(svdSalvarCaminho.FileName);
  except
    on E: Exception do
    begin
      Application.MessageBox('Houve uma Falha e não foi possivel selecionar o local do arquivo', 'Falha Desconhecida',
        MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TfrmCompactador.LimparPaginaCompactar;
begin
  lbxArquivosSelecionados.Clear;
  lbeNomePastaParaCompactar.Clear;
end;

procedure TfrmCompactador.MostrarArquivosDescomprimidosListBox;
var
  lDiretorio: string;
  lSRC: TSearchRec;
  I: Integer;
begin
  lDiretorio := lbeArquivoComprimidoSelecionado.Text;
  lDiretorio := StringReplace(lDiretorio, '.zip', '', [rfReplaceAll]);
  lbxArquivosDescompactados.Clear;

  if not System.SysUtils.DirectoryExists(lDiretorio) then
  begin
    Exit;
  end;

  I := FindFirst(lDiretorio + '\*', faAnyFile, lSRC);
  while I = 0 do
  begin
    if not (lSRC.Name = '.') then
    begin
      lbxArquivosDescompactados.Items.Add(lSRC.Name);
    end;

    I := FindNext(lSRC);
  end;

  lbxArquivosDescompactados.Items.Delete(0);
end;

procedure TfrmCompactador.SelecionarArquivoCompactado;
begin
  try
    if not opdSelecionarArquivos.Execute then
    begin
      Exit;
    end;

    if ExtractFileExt(opdSelecionarArquivos.FileName) <> '.zip' then
    begin
      Application.MessageBox('Por favor, selecione um arquivo que esteja compactado', 'Arquivo selecionado não ' +
        'compactado', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

    lbeArquivoComprimidoSelecionado.Text := opdSelecionarArquivos.FileName;
  except
    on E: Exception do
    begin
      Application.MessageBox('Houve uma Falha e não foi possivel selecionaro arquivo', 'Falha Desconhecida',
        MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TfrmCompactador.SelecionarArquivos;
begin
  try
    DefinirUltimoDiretorioUsado;

    if not opdSelecionarArquivos.Execute then
    begin
      Exit;
    end;

    AdicionarArquivosListBox;
  except
    on E: Exception do
    begin
      Application.MessageBox('Falha inesperada, verifique', 'Falha Desconhecida');
      LimparPaginaCompactar;
    end;
  end;
end;

end.
