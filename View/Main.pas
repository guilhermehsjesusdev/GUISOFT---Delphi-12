unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, LoadBarProgress;

type
  TForm1 = class(TForm)
    Image1: TImage;
    ProgressBar1: TProgressBar;
    procedure FormShow(Sender: TObject);
    procedure UpdateLoader;
  private
  public
  end;

var
  Form1: TForm1;
  Msg : string;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
  Application.ProcessMessages;
  UpdateLoader;
end;

procedure TForm1.UpdateLoader;
var
  i, Value: Integer;
begin
  ProgressBar1.Min := 0;
  ProgressBar1.Max := 100;

  for i := 0 to 100 do

  begin
    Value := LoadBarProgress.LoadProgressBar(i);
    ProgressBar1.Position := Value;
    Application.ProcessMessages;
  end;
  end;

end.

