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
    btnCriarThread: TButton;
    lblQtdThreads: TLabel;
    procedure btnCriarThreadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnCriarThreadClick(Sender: TObject);
var
  lThread: TThreadContagem;
begin
  lThread := TThreadContagem.Create;
  lThread.Start;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(frmPrincipal);
end;

end.
