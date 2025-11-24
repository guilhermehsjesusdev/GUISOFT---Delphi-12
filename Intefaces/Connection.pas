unit Connection;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.DApt, IniFiles;

type
  TConnection = class
  private
    FConnection: TFDConnection;
    procedure LoadConfig;
  public
    constructor Create;
    destructor Destroy; override;
    function GetConnection: TFDConnection;
    procedure Conectar;
    procedure Desconectar;
  end;

implementation

{ TConnection }

constructor TConnection.Create;
begin
  inherited;
  FConnection := TFDConnection.Create(nil);
  LoadConfig;
end;

destructor TConnection.Destroy;
begin
  FConnection.Free;
  inherited;
end;

procedure TConnection.LoadConfig;
var
  Ini: TIniFile;
  IniPath: string;
begin
  IniPath := ExtractFilePath(ParamStr(0)) + 'config.ini';

  if not FileExists(IniPath) then
    raise Exception.Create('Arquivo de configuração não encontrado: ' + IniPath);

  Ini := TIniFile.Create(IniPath);
 try
  FConnection.DriverName := Ini.ReadString('Database', 'Driver', '');
  FConnection.Params.Database := Ini.ReadString('Database', 'Database', '');
  FConnection.Params.UserName := Ini.ReadString('Database', 'User', '');
  FConnection.Params.Password := Ini.ReadString('Database', 'Password', '');
  FConnection.Params.Values['Server'] := Ini.ReadString('Database', 'Server', '');
  FConnection.Params.Values['Port'] := Ini.ReadString('Database', 'Port', '');
  FConnection.LoginPrompt := False;
finally
  Ini.Free;
end;
end;

procedure TConnection.Conectar;
begin
  if not FConnection.Connected then
    FConnection.Connected := True;
end;

procedure TConnection.Desconectar;
begin
  if FConnection.Connected then
    FConnection.Connected := False;
end;

function TConnection.GetConnection: TFDConnection;
begin
  Result := FConnection;
end;

end.

