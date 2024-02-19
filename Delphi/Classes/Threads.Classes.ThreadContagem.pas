unit Threads.Classes.ThreadContagem;

interface

uses
  System.Classes, System.StrUtils;

type
  TThreadContagem = class(TThread)
  private
    FIndex: Integer;
  protected
    procedure Execute; override;
  public
    constructor Create;
  end;

implementation

uses
  System.SysUtils, Threads.Forms.Principal;

{ TThreadContagem }

constructor TThreadContagem.Create;
begin
  inherited Create(True);     // Estado de espera
  FreeOnTerminate := True;    // Liberar ao finalizar

  FIndex := frmPrincipal.lbxThreads.Items.Count + 1;
  frmPrincipal.lbxThreads.Items.Add('Thread ' + FIndex.ToString + ': 0');
  frmPrincipal.lblQtdThreads.Caption := (StrToIntDef(frmPrincipal.lblQtdThreads.Caption, 0) + 1).ToString;
//  Priority := tpHigher;
end;

procedure TThreadContagem.Execute;
begin
  inherited;

  for var I := 0 to 25 do
  begin
    Sleep(500);
    frmPrincipal.lbxThreads.Items[FIndex - 1] := 'Thread ' + FIndex.ToString + ': ' + I.ToString;
  end;

  frmPrincipal.lbxThreads.Items[FIndex - 1] := 'Thread ' + FIndex.ToString + ': Terminada';
  frmPrincipal.lblQtdThreads.Caption := Pred(StrToInt(frmPrincipal.lblQtdThreads.Caption)).ToString;
end;

end.
