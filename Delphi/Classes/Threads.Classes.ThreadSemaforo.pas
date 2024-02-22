unit Threads.Classes.ThreadSemaforo;

interface

uses
  System.Classes, Threads.Helpers.TiposAuxiliares, Threads.Forms.Semaforo;

type
  TThreadSemaforo = class(TThread)
  private
    FThreadIrma: TThreadSemaforo;
    FSinal: TCorSemafaro;
    FViaSemaforo: TViaSemaforo;
    procedure SimularSemaforo;
    procedure AtualizarSemaforo;
    procedure AtualizarSemaforoViaHorizontal;
    procedure AtualizarSemaforoViaVertical;
    procedure MudarSinal(pSinal: TCorSemafaro; pTempo: Integer);
  protected
    procedure Execute; override;
  public
    constructor Create(pVia: TViaSemaforo);
    procedure VincularThreadIrma(pThreadIrma: TThreadSemaforo);
    property Sinal: TCorSemafaro read FSinal;
  end;

implementation

uses
  Vcl.Graphics;

{ TThreadSemaforo }

procedure TThreadSemaforo.AtualizarSemaforo;
begin
  case FViaSemaforo of
    vsHorizontal: AtualizarSemaforoViaHorizontal;
    vsVertical: AtualizarSemaforoViaVertical;
  end;
end;

constructor TThreadSemaforo.Create(pVia: TViaSemaforo);
begin
  inherited Create(True);
  FreeOnTerminate := True;

  FSinal := csDesligado;
  FViaSemaforo := pVia;
end;

procedure TThreadSemaforo.MudarSinal(pSinal: TCorSemafaro; pTempo: Integer);
begin
  FSinal := pSinal;
  Synchronize(AtualizarSemaforo);
  Sleep(pTempo);
end;

procedure TThreadSemaforo.AtualizarSemaforoViaHorizontal;
begin
  frmSemaforo.shpVermelhoHorizontal.Brush.Color := clBlack;
  frmSemaforo.shpVerdeHorizontal.Brush.Color := clBlack;
  frmSemaforo.shpAmareloHorizontal.Brush.Color := clBlack;

  case FSinal of
    csVermelho: frmSemaforo.shpVermelhoHorizontal.Brush.Color := clRed;
    csVerde: frmSemaforo.shpVerdeHorizontal.Brush.Color := clGreen;
    csAmarelo: frmSemaforo.shpAmareloHorizontal.Brush.Color := clYellow;
  end;
end;

procedure TThreadSemaforo.AtualizarSemaforoViaVertical;
begin
  frmSemaforo.shpVermelhoVertical.Brush.Color := clBlack;
  frmSemaforo.shpVerdeVertical.Brush.Color := clBlack;
  frmSemaforo.shpAmareloVertical.Brush.Color := clBlack;

  case FSinal of
    csVermelho: frmSemaforo.shpVermelhoVertical.Brush.Color := clRed;
    csVerde: frmSemaforo.shpVerdeVertical.Brush.Color := clGreen;
    csAmarelo: frmSemaforo.shpAmareloVertical.Brush.Color := clYellow;
  end;
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

  case FThreadIrma.Sinal of
    csDesligado: MudarSinal(csVermelho, 0);
    else MudarSinal(csAmarelo, 0);
  end;

  while not self.Terminated do
  begin
    if (lVoltas = 10) or FThreadIrma.Terminated then
    begin
      Terminate;
    end;

    if (FThreadIrma.Sinal = csVermelho) or (Sinal = csVerde) then
    begin
      MudarSinal(csAmarelo, 1500);
    end;

    if (FThreadIrma.Sinal = csVermelho) or (Sinal = csAmarelo) then
    begin
      MudarSinal(csVermelho, 5000);
    end;

    if (FThreadIrma.Sinal = csVermelho) or (Sinal = csVermelho) then
    begin
      MudarSinal(csVerde, 3500);
    end;

    Inc(lVoltas);
  end;

  MudarSinal(csAmarelo, 0);
end;

procedure TThreadSemaforo.VincularThreadIrma(pThreadIrma: TThreadSemaforo);
begin
  FThreadIrma := pThreadIrma;
end;

end.
