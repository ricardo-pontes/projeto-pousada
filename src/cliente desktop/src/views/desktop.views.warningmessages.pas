unit desktop.views.warningmessages;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.StdCtrls, FMX.Effects,
  FMX.Filter.Effects, FMX.Controls.Presentation, FMX.Layouts, FMX.Ani;

type
  TMessageWarning = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Button1: TButton;
    FillRGBEffect1: TFillRGBEffect;
    Layout2: TLayout;
    Layout3: TLayout;
    Label1: TLabel;
    Arc1: TArc;
    FloatAnimation1: TFloatAnimation;
    FloatAnimationSubirMensagem: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    procedure FloatAnimation1Process(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure FloatAnimation2Finish(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Arc1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Mensagem(aTexto : string; aDuracao : Single = 80);
  end;

var
  MessageWarning: TMessageWarning;

implementation

{$R *.fmx}

{ TForm1 }

procedure TMessageWarning.Arc1Click(Sender: TObject);
begin
  Close;
end;

procedure TMessageWarning.FloatAnimation1Finish(Sender: TObject);
begin
  FloatAnimation2.Inverse := True;
  FloatAnimation2.Start;
  FloatAnimationSubirMensagem.Inverse := True;
  FloatAnimationSubirMensagem.Start;
  Layout1.Parent := nil;

end;

procedure TMessageWarning.FloatAnimation1Process(Sender: TObject);
begin
  FloatAnimation2.Start;
  FloatAnimationSubirMensagem.Start;
end;

procedure TMessageWarning.FloatAnimation2Finish(Sender: TObject);
begin
  if FloatAnimation2.Inverse then
    Close;
end;

procedure TMessageWarning.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TMessageWarning.Mensagem(aTexto: string; aDuracao: Single);
begin
  Layout1.BringToFront;
  FloatAnimation2.Inverse             := False;
  FloatAnimationSubirMensagem.Inverse := False;
  Label1.Text                         := aTexto;
  FloatAnimation1.Duration            := aDuracao;
  FloatAnimation1.Start;
end;

end.
