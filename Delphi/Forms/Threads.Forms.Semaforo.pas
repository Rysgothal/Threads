unit Threads.Forms.Semaforo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TfrmSemaforo = class(TForm)
    shpVermelho: TShape;
    shpAmarelo: TShape;
    shpVerde: TShape;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

var
  frmSemaforoViaHorizontal: TfrmSemaforo;
  frmSemaforoViaVertical: TfrmSemaforo;

implementation

uses
  Vcl.Graphics, Threads.Classes.ThreadSemaforo;

{$R *.dfm}

constructor TfrmSemaforo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

end;

procedure TfrmSemaforo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(frmSemaforoViaHorizontal);
  FreeAndNil(frmSemaforoViaVertical);
end;

procedure TfrmSemaforo.FormCreate(Sender: TObject);
begin
  shpVermelho.Brush.Color := clblack;
  shpAmarelo.Brush.Color := clblack;
  shpVerde.Brush.Color := clblack;
end;

procedure TfrmSemaforo.FormShow(Sender: TObject);
var
  lThread: TThreadSemaforo;
begin
  lThread := TThreadSemaforo.Create(Self);
  lThread.Start;
end;

end.
