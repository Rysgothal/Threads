program Threads;

uses
  Vcl.Forms,
  Threads.Forms.Principal in 'Forms\Threads.Forms.Principal.pas' {frmPrincipal},
  Threads.Classes.ThreadContagem in 'Classes\Threads.Classes.ThreadContagem.pas',
  Threads.Forms.Compactar in 'Forms\Threads.Forms.Compactar.pas' {frmCompactador},
  Threads.Classes.ThreadCompressaoArquivos in 'Classes\Threads.Classes.ThreadCompressaoArquivos.pas',
  Threads.Forms.BarraProgresso in 'Forms\Threads.Forms.BarraProgresso.pas' {frmBarrasProgresso};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
