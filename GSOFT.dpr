program GSOFT;

uses
  Vcl.Forms,
  Main in 'View\Main.pas' {Form1},
  LoadGauge in 'Intefaces\LoadGauge.pas',
  LoadBarProgress in 'Intefaces\LoadBarProgress.pas',
  Connection in 'Intefaces\Connection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
