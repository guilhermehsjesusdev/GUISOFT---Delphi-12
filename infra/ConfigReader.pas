unit ConfigReader;

interface

uses
  System.IniFiles, System.SysUtils;

type
  TConfigReader = class
  public
    class function Read(const Section, Key: string): string;
  end;

implementation

class function TConfigReader.Read(const Section, Key: string): string;
var
  Ini: TIniFile;
  FileName: string;
begin
  FileName := ExtractFilePath(ParamStr(0)) + 'config.ini';
  Ini := TIniFile.Create(FileName);
  try
    Result := Ini.ReadString(Section, Key, '');
  finally
    Ini.Free;
  end;
end;

end.

