unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  LoadBarProgress, // Unit customizada para o progress bar
  Connection,      // Unit customizada da sua classe de conexão
  FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.MySQL;

type
  TForm1 = class(TForm)
    Image1: TImage;
    ProgressBar1: TProgressBar;
    // O componente FDPhysMySQLDriverLink1 é essencial para o MariaDB/MySQL
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure FormShow(Sender: TObject);
    // Declaração da procedure com o parâmetro de início
    procedure UpdateLoader(StartValue: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Conexao: TConnection; // Objeto de conexão
  Msg: string;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
  // Inicialização do ProgressBar
  ProgressBar1.Min := 0;
  ProgressBar1.Max := 100;
  ProgressBar1.Position := 0;
  Application.ProcessMessages;

  Conexao := TConnection.Create;
  try
    try
      Conexao.Conectar;

      // ✅ Conexão bem-sucedida: Seta 20%
      ProgressBar1.Position := 20;
      Application.ProcessMessages;

      ShowMessage('Conexão feita com sucesso!!');

      // Continua o carregamento de 20% a 100%
      UpdateLoader(20);

    except
      // 🛑 Correção: Bloco "on E: Exception do" estava faltando
      on E: Exception do
      begin
        ShowMessage('Problema ao estabelecer a conexão: ' + E.Message);
        ProgressBar1.Position := 0; // Opcional: Reseta a barra em caso de falha
      end;
    end;

  finally
    // Garante que a conexão seja fechada e o objeto liberado
    Conexao.Desconectar;
    Conexao.Free;
  end;
end;

procedure TForm1.UpdateLoader(StartValue: Integer);
var
  i, Value: Integer;
begin
  // O loop começa do valor inicial (20)
  for i := StartValue to 100 do
  begin
    Value := LoadBarProgress.LoadProgressBar(i);
    ProgressBar1.Position := Value;
    Application.ProcessMessages;

    // Adiciona uma pausa (10ms) para tornar o carregamento visível
    Sleep(10);
  end;
end;

end.
