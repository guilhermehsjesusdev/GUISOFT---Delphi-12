unit LoadBarProgress;

interface

uses
  System.SysUtils, System.Classes;

function ProgressBarStatus(vReturn: Boolean): string;
function LoadArchivesNumber(vReturn : Integer): string;
function LoadProgressBar(vValue : Integer): Integer;

implementation

function LoadProgressBar(vValue: Integer): Integer;
begin
  if vValue < 0 then
    vValue := 0
  else if vValue > 100 then
    vValue := 100;

  Result := vValue;
end;

function LoadArchivesNumber(vReturn : Integer) : string;
  begin
    try
    if vReturn > 0 then
      Result := 'Foram retornados a quantidade ' + IntToStr(vReturn) + ' De Arquivos'
    else
      Result := 'Não foram possui arquivos a serem Retornados';
    except
      on E : Exception do
        Result := 'Houve um erro no carregamento ' + E.Message;

    end
end;

function ProgressBarStatus(vReturn: Boolean): string;
begin
  try
    if vReturn then
      Result := 'Carregamento concluído'
    else
      Result := 'Falha ao carregar';
  except
    on E: Exception do
      Result := 'Houve um erro no carregamento: ' + E.Message;
  end;
end;




end.

