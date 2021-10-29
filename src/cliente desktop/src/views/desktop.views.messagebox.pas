unit desktop.views.messagebox;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Effects,
  FMX.Objects,
  FMX.Layouts;

type
  TMessageBox = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    ShadowEffect1: TShadowEffect;
    Layout2: TLayout;
    Button1: TButton;
    lblTitulo: TLabel;
    Layout3: TLayout;
    Layout4: TLayout;
    lblMensagem: TLabel;
    ButtonSim: TButton;
    ButtonNao: TButton;
    ButtonOk: TButton;
    procedure ButtonSimClick(Sender: TObject);
    procedure ButtonNaoClick(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
  private
    FProcSim : TProc;
    FProcNao : TProc;
    FProcOK : TProc;
    FRender: TFMXObject;
  public
    procedure MensagemSimNao(aTitulo, aMensagem : string; aProcSim, aProcNao : TProc); overload;
    procedure MensagemSimNao(aTitulo, aMensagem : string; aProcSim : TProc); overload;
    procedure MensagemOk(aTitulo, aMensagem : string; aProcOk : TProc);
    property Render: TFMXObject read FRender write FRender;
  end;

var
  MessageBox: TMessageBox;

implementation

{$R *.fmx}

procedure TMessageBox.ButtonNaoClick(Sender: TObject);
begin
  Layout1.Parent := nil;
  FProcNao;
end;

procedure TMessageBox.ButtonOkClick(Sender: TObject);
begin
  Layout1.Parent := nil;
  FProcOk;
end;

procedure TMessageBox.ButtonSimClick(Sender: TObject);
begin
  Layout1.Parent := nil;
  FProcSim;
end;

procedure TMessageBox.MensagemOk(aTitulo, aMensagem: string; aProcOk: TProc);
begin
  ButtonOk.Visible  := True;
  ButtonSim.Visible := False;
  ButtonNao.Visible := False;
  lblTitulo.Text    := aTitulo;
  lblMensagem.Text  := aMensagem;
  FProcOK           := aProcOK;
  Layout1.Align     := TAlignLayout.Contents;
  Layout1.Parent    := FRender;
end;

procedure TMessageBox.MensagemSimNao(aTitulo, aMensagem: string; aProcSim: TProc);
begin
  MensagemSimNao(aTitulo, aMensagem, aProcSim, procedure begin end);
end;

procedure TMessageBox.MensagemSimNao(aTitulo, aMensagem: string; aProcSim, aProcNao: TProc);
begin
  ButtonOk.Visible  := False;
  ButtonSim.Visible := True;
  ButtonNao.Visible := True;
  lblTitulo.Text    := aTitulo;
  lblMensagem.Text  := aMensagem;
  FProcSim          := aProcSim;
  FProcNao          := aProcNao;
  Layout1.Align     := TAlignLayout.Contents;
  Layout1.Parent    := FRender;
end;

end.
