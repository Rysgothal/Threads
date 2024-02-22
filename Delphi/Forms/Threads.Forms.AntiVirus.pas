unit Threads.Forms.AntiVirus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmAntivirus = class(TForm)
    btnAtivar: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAntivirus: TfrmAntivirus;

implementation

{$R *.dfm}

end.
