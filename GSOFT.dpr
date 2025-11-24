program GSOFT;

uses
  System.SysUtils,
  Winapi.Windows,
  Vcl.Forms,
  SplashScreen in 'View\SplashScreen.pas' {SplasScreen},
  Main in 'View\Main.pas' {FrmMain},
  ConfigReader in 'infra\ConfigReader.pas',
  DBConnection in 'infra\DBConnection.pas',
  LoadBarProgress in 'Intefaces\LoadBarProgress.pas',
  LoadGauge in 'Intefaces\LoadGauge.pas';

{$R *.res}

var
  FrmSplash: TSplashScreen;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  FrmSplash := TSplashScreen.Create(nil);
  FrmSplash.Show;
  FrmSplash.Update;

  //Tempo mínimo de exibição do splash
  Sleep(1500);
  Application.ProcessMessages;

  try
    try
      // Testa a conexão
      TDBConnection.GetConnection;

    except
      on E: Exception do
      begin
        MessageBox(
          0,
          PChar('Falha ao conectar ao banco de dados:' + sLineBreak + E.Message),
          'Erro',
          MB_ICONERROR or MB_OK
        );

        FrmSplash.Free;
        //Exit;
      end;
    end;

    // Conexão OK → cria o Main e define como MainForm automaticamente
    Application.CreateForm(TMain, FrmMain);

  finally
    FrmSplash.Free;
  end;

  Application.Run;
end.

