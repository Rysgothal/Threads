unit Threads.Classes.ThreadAntivirus;

interface

uses
  System.Classes;

type
  TThreadAntiVirus = class(TThread)
  private
    FProcessosAtivos: TStringList;
    FProcessosSuspeitos: TStringList;
    procedure ListarProcessos;
    function ProcurarProcessoSuspeito(const pProcesso: string): Boolean;
    procedure MatarProcessoSuspeito(const pProcesso: string);
  protected
    procedure Execute; override;
  public
    constructor Create;
    property ProcessosSuspeitos: TStringList read FProcessosSuspeitos;
    procedure AdicionarProcessoSuspeito(const pNomeProcesso: string);
  end;

implementation

uses
  Winapi.Windows, Winapi.TlHelp32, System.SysUtils;

{ TThreadAntiVirus }

procedure TThreadAntiVirus.AdicionarProcessoSuspeito(const pNomeProcesso: string);
begin
  FProcessosSuspeitos.Add(pNomeProcesso);
end;

constructor TThreadAntiVirus.Create;
begin
  inherited Create(True);
  FreeOnTerminate := True;
  Priority := tpHighest;

  FProcessosSuspeitos := TStringList.Create;
  FProcessosAtivos := TStringList.Create;
end;

procedure TThreadAntiVirus.Execute;
begin
  inherited;

  while not Terminated do
  begin
    ListarProcessos;

    for var lProcessoSuspeito in FProcessosSuspeitos do
    begin
      if not ProcurarProcessoSuspeito(lProcessoSuspeito) then
      begin
        Continue;
      end;


    end;
  end;
end;

procedure TThreadAntiVirus.ListarProcessos;
var
  lContinuarLoop: BOOL;
  lProcessoHandle: THandle;
  lProcesso: TProcessEntry32;
begin
  lProcessoHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  lProcesso.dwSize := SizeOf(lProcesso);
  lContinuarLoop := Process32First(lProcessoHandle, lProcesso);

  FProcessosAtivos.Clear;

  while Integer(lContinuarLoop) <> 0 do
  begin
    FProcessosSuspeitos.Add(lProcesso.szExeFile);
    lContinuarLoop := Process32Next(lProcessoHandle, lProcesso);
  end;

  CloseHandle(lProcessoHandle);
end;

procedure TThreadAntiVirus.MatarProcessoSuspeito(const pProcesso: string);
const
  TERMINAR_PROCESSO = $0001;
var
  lContinuarLoop: BOOL;
  lProcessoHandle: THandle;
  lProcesso: TProcessEntry32;
begin
  lProcessoHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  lProcesso.dwSize := SizeOf(lProcesso);
  lContinuarLoop := Process32First(lProcessoHandle, lProcesso);

  while Integer(lContinuarLoop) <> 0 do
  begin
    if (ExtractFileName(lProcesso.szExeFile).ToUpper = pProcesso.ToUpper) or
      (UpperCase(lProcesso.szExeFile) = pProcesso.ToUpper) then
    begin
      TerminateProcess(
        OpenProcess(
          TERMINAR_PROCESSO, BOOL(0), lProcesso.th32ProcessID
        ), 0
      );


    end;

     lContinuarLoop := Process32Next(lProcessoHandle, lProcesso);
//      Result := Integer(TerminateProcess(
//                        OpenProcess(TERMINAR_PROCESSO,
//                                    BOOL(0),
//                                    lProcesso.th32ProcessID),
//                                    0));
  end;

  CloseHandle(lProcessoHandle);
end;

function TThreadAntiVirus.ProcurarProcessoSuspeito(const pProcesso: string): Boolean;
begin
  Result := False;

  for var lProcessoAtivo in FProcessosAtivos do
  begin
    if lProcessoAtivo <> pProcesso then
    begin
      Continue;
    end;

    Result := True;
    Break;
  end;
end;

end.
