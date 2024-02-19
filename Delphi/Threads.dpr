program Threads;

uses
  Vcl.Forms,
  Threads.Forms.Principal in 'Forms\Threads.Forms.Principal.pas' {frmPrincipal},
  Threads.Classes.ThreadContagem in 'Classes\Threads.Classes.ThreadContagem.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
