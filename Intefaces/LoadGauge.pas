unit LoadGauge;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TLoadGauge = class(TObject)
  private
    FGauge: TProgressBar;
    FLabel: TLabel;
    FOwner: TForm;
  public
    constructor Create(AOwner: TForm);
    procedure Show;
    procedure Hide;
    procedure SetProgress(Value: Integer);
    procedure SetIndeterminate;
  end;

implementation

{ TLoadGauge }

constructor TLoadGauge.Create(AOwner: TForm);
begin
  inherited Create;
  FOwner := AOwner;

  FGauge := TProgressBar.Create(AOwner);
  FGauge.Parent := AOwner;
  FGauge.Width := 300;
  FGauge.Height := 25;
  FGauge.Left := (FOwner.ClientWidth - FGauge.Width) div 2;
  FGauge.Top := (FOwner.ClientHeight - FGauge.Height) div 2;
  FGauge.Min := 0;
  FGauge.Max := 100;
  FGauge.Position := 0;
  FGauge.Visible := False;

  FLabel := TLabel.Create(AOwner);
  FLabel.Parent := AOwner;
  FLabel.Caption := 'Carregando...';
  FLabel.Left := FGauge.Left + (FGauge.Width - FLabel.Width) div 2;
  FLabel.Top := FGauge.Top - 25;
  FLabel.Visible := False;
end;

procedure TLoadGauge.Show;
begin
  FGauge.Visible := True;
  FLabel.Visible := True;
  Application.ProcessMessages;
end;

procedure TLoadGauge.Hide;
begin
  FGauge.Visible := False;
  FLabel.Visible := False;
  Application.ProcessMessages;
end;

procedure TLoadGauge.SetProgress(Value: Integer);
begin
  if Value < FGauge.Min then Value := FGauge.Min;
  if Value > FGauge.Max then Value := FGauge.Max;
  FGauge.Position := Value;
  Application.ProcessMessages;
end;

procedure TLoadGauge.SetIndeterminate;
begin
  FGauge.Style := pbstMarquee;
end;

end.

