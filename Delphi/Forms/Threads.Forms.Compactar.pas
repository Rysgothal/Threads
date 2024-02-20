unit Threads.Forms.Compactar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.Zip,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.FileCtrl, Vcl.ExtCtrls, Vcl.Mask,
  System.ImageList, Vcl.ImgList, System.StrUtils,
  Threads.Classes.ThreadCompressaoArquivos, Threads.Forms.BarraProgresso;

type
  TfrmCompactador = class(TForm)
    pnlPrimcipal: TPanel;
    btnArquivos: TButton;
    btnCompactar: TButton;
    btnEscolherLocal: TButton;
    imgIcons: TImageList;
    lbeLocalPastaOndeSalvar: TLabeledEdit;
    lbeNomePastaParaCompactar: TLabeledEdit;
    opdSelecionarArquivos: TOpenDialog;
    svdSalvarCaminho: TSaveDialog;
    lbxArquivosSelecionados: TListBox;
    lblArquivosSelecionados: TLabel;
    btnLimparLista: TButton;
    procedure btnArquivosClick(Sender: TObject);
    procedure btnCompactarClick(Sender: TObject);
    procedure btnLimparListaClick(Sender: TObject);
    procedure btnEscolherLocalClick(Sender: TObject);
  private
    procedure CompactarArquivos;
    procedure EscolherOndeSalvar;
    procedure SelecionarArquivos;
    procedure AdicionarArquivosListBox;
    procedure DefinirUltimoDiretorioUsado;
    procedure Limpar;
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

procedure TfrmCompactador.btnEscolherLocalClick(Sender: TObject);
begin
  EscolherOndeSalvar;
end;

procedure TfrmCompactador.btnLimparListaClick(Sender: TObject);
begin
  Limpar;
end;

procedure TfrmCompactador.CompactarArquivos;
var
  lNomePasta, lLocalFuturo: string;
begin
  lNomePasta := lbeNomePastaParaCompactar.Text;
  lLocalFuturo := lbeLocalPastaOndeSalvar.Text;

  lNomePasta := IfThen(lNomePasta = EmptyStr, 'Pasta-Compactada', lNomePasta);
  lLocalFuturo := IfThen(lLocalFuturo = EmptyStr, GetCurrentDir + '\' + lNomePasta, lLocalFuturo);

  if (lbxArquivosSelecionados.Items.Count = 0) then
  begin
    Exit;
  end;

  if not Assigned(frmBarrasProgresso) then
  begin
    frmBarrasProgresso := TfrmBarrasProgresso.Create(lLocalFuturo + lNomePasta);
  end;

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

procedure TfrmCompactador.Limpar;
begin
  lbxArquivosSelecionados.Clear;
  lbeNomePastaParaCompactar.Clear;
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
      Limpar;
    end;
  end;
end;

end.
