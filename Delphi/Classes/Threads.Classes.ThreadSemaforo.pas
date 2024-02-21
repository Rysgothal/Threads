unit Threads.Classes.ThreadSemaforo;

interface

uses
  System.Classes, Threads.Helpers.TiposAuxiliares, Threads.Forms.Semaforo;

type
  TThreadSemaforo = class(TThread)
  private
    FFormPai: TfrmSemaforo;
    FSinal: TCorSemafaro;
    procedure SimularSemaforo;
    procedure AtualizarSemaforo;
  protected
    procedure Execute; override;
  public
    constructor Create(const pFormulario: TfrmSemaforo);
    property Sinal: TCorSemafaro read FSinal;
  end;

implementation

uses
  Vcl.Graphics;

{ TThreadSemaforo }

procedure TThreadSemaforo.AtualizarSemaforo;
begin
  FFormPai.shpVermelho.Brush.Color := clBlack;
  FFormPai.shpAmarelo.Brush.Color := clBlack;
  FFormPai.shpVerde.Brush.Color := clBlack;

  case FSinal of
    csVermelho: FFormPai.shpVermelho.Brush.Color := clRed;
    csVerde: FFormPai.shpVerde.Brush.Color := clGreen;
    csAmarelo: FFormPai.shpAmarelo.Brush.Color := clYellow;
  end;
end;

constructor TThreadSemaforo.Create(const pFormulario: TfrmSemaforo);
begin
  inherited Create(True);
  FreeOnTerminate := True;

  FSinal := csDesligado;
  FFormPai := pFormulario;
end;

procedure TThreadSemaforo.Execute;
begin
  inherited;
  SimularSemaforo;
end;

procedure TThreadSemaforo.SimularSemaforo;
var
  lVoltas: Integer;
begin
  lVoltas := 0;

  while True do
  begin
    if lVoltas = 5 then
    begin
      Break;
    end;

    FSinal := csAmarelo;
    AtualizarSemaforo;
    Sleep(1500);

    FSinal := csVermelho;
    AtualizarSemaforo;
    Sleep(6000);

    FSinal := csVerde;
    AtualizarSemaforo;
    Sleep(4000);

    Inc(lVoltas);
  end;
end;

end.
