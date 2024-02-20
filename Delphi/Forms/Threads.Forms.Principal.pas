unit Threads.Forms.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.ComCtrls, System.Generics.Collections, Threads.Classes.ThreadContagem;

type
  TfrmPrincipal = class(TForm)
    pnlInformacoes: TPanel;
    lblThreadsAtivas: TLabel;
    lbxThreads: TListBox;
    btnCriarThreadClasse: TButton;
    lblQtdThreads: TLabel;
    btnCriarThreadAnonima: TButton;
    btnComprimirArquivo: TButton;
    procedure btnCriarThreadClasseClick(Sender: TObject);
    procedure btnCriarThreadAnonimaClick(Sender: TObject);
    procedure btnComprimirArquivoClick(Sender: TObject);
  private
    procedure SimularContagemThread;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  Threads.Forms.Compactar;

{$R *.dfm}

procedure TfrmPrincipal.btnComprimirArquivoClick(Sender: TObject);
begin
  if not Assigned(frmCompactador) then
  begin
    frmCompactador := TfrmCompactador.Create(Self);
  end;

  frmCompactador.ShowModal;
end;

procedure TfrmPrincipal.btnCriarThreadAnonimaClick(Sender: TObject);
var
  lThread: TThread;
begin
  lThread := TThread.CreateAnonymousThread(SimularContagemThread);
  lThread.Start;
end;

procedure TfrmPrincipal.btnCriarThreadClasseClick(Sender: TObject);
var
  lThread: TThreadContagem;
begin
  lThread := TThreadContagem.Create;
  lThread.Start;
end;

procedure TfrmPrincipal.SimularContagemThread;
var
  lIndex: Integer;
begin
  lIndex := lbxThreads.Items.Count + 1;
  lbxThreads.Items.Add('Thread An�nima: 0');
  lblQtdThreads.Caption := (StrToIntDef(lblQtdThreads.Caption, 0) + 1).ToString;

  for var I := 0 to 25 do
  begin
    Sleep(500);
    lbxThreads.Items[lIndex - 1] := 'Thread An�nima: ' + I.ToString;
  end;

  lbxThreads.Items[lIndex - 1] := 'Thread An�nima: Terminada';
  lblQtdThreads.Caption := Pred(StrToInt(lblQtdThreads.Caption)).ToString;
end;

end.
