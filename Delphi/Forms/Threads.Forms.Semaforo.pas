unit Threads.Forms.Semaforo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TfrmSemaforo = class(TForm)
    pnlViaHorizontal: TPanel;
    shpVermelhoHorizontal: TShape;
    shpAmareloHorizontal: TShape;
    shpVerdeHorizontal: TShape;
    pnlViaVertical: TPanel;
    shpVermelhoVertical: TShape;
    shpAmareloVertical: TShape;
    shpVerdeVertical: TShape;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSemaforo: TfrmSemaforo;

implementation

uses
  Vcl.Graphics, Threads.Classes.ThreadSemaforo,
  Threads.Helpers.TiposAuxiliares;

{$R *.dfm}

procedure TfrmSemaforo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(frmSemaforo);
end;

procedure TfrmSemaforo.FormCreate(Sender: TObject);
begin
  shpVermelhoHorizontal.Brush.Color := clblack;
  shpAmareloHorizontal.Brush.Color := clblack;
  shpVerdeHorizontal.Brush.Color := clblack;
  shpVermelhoVertical.Brush.Color := clblack;
  shpAmareloVertical.Brush.Color := clblack;
  shpVerdeVertical.Brush.Color := clblack;
end;

procedure TfrmSemaforo.FormShow(Sender: TObject);
var
  lThreadHorizontal, lThreadVertical: TThreadSemaforo;
begin
  lThreadHorizontal := TThreadSemaforo.Create(vsHorizontal);
  lThreadVertical := TThreadSemaforo.Create(vsVertical);

  lThreadHorizontal.VincularThreadIrma(lThreadVertical);
  lThreadVertical.VincularThreadIrma(lThreadHorizontal);

  lThreadHorizontal.Start;
  lThreadVertical.Start;
end;

end.
