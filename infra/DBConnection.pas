unit DBConnection;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Param,
  FireDAC.Stan.Option,
  FireDAC.DApt,
  ConfigReader;

type
  TDBConnection = class
  private
    class var FConnection: TFDConnection;
  public
    class function GetConnection: TFDConnection;
    class procedure CloseConnection;
  end;

implementation

var
  MySQLDriver: TFDPhysMySQLDriverLink;

class function TDBConnection.GetConnection: TFDConnection;
begin
  if FConnection = nil then
  begin
    FConnection := TFDConnection.Create(nil);
    FConnection.DriverName := 'MySQL';

    FConnection.Params.Values['Server']   := TConfigReader.Read('Database', 'Host');
    FConnection.Params.Values['Port']     := TConfigReader.Read('Database', 'Port');
    FConnection.Params.Values['Database'] := TConfigReader.Read('Database', 'Name');
    FConnection.Params.Values['User_Name'] := TConfigReader.Read('Database', 'User');
    FConnection.Params.Values['Password'] := TConfigReader.Read('Database', 'Password');

    FConnection.Params.Values['CharacterSet'] := 'utf8mb4';

    FConnection.LoginPrompt := False;
    FConnection.Connected := True;
  end;

  Result := FConnection;
end;

class procedure TDBConnection.CloseConnection;
begin
  if Assigned(FConnection) then
  begin
    FConnection.Connected := False;
    FreeAndNil(FConnection);
  end;
end;

initialization
  MySQLDriver := TFDPhysMySQLDriverLink.Create(nil);
  MySQLDriver.VendorLib := 'libmariadb.dll';

finalization
  FreeAndNil(MySQLDriver);
  TDBConnection.CloseConnection;

end.

