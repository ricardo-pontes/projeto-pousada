unit desktop.views.login;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Generics.Collections,

  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Objects,
  FMX.Effects,
  FMX.TabControl,
  FMX.Edit,
  FMX.Controls.Presentation,
  desktop.views.base,
  cliente.presenter.usuarios,
  cliente.presenter.usuarios.interfaces,
  entidades.usuario;

type
  TViewLogin = class(TViewBase, iPresenterUsuariosView)
    Rectangle1: TRectangle;
    rectLogin: TRectangle;
    ShadowEffect1: TShadowEffect;
    Layout1: TLayout;
    Button1: TButton;
    EditEmail: TEdit;
    Label2: TLabel;
    EditSenha: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Layout2: TLayout;
    Label1: TLabel;
    Layout3: TLayout;
    Image1: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Circle1: TCircle;
    Circle2: TCircle;
    Circle3: TCircle;
    Circle4: TCircle;
    Circle5: TCircle;
    Circle6: TCircle;
    Circle7: TCircle;
    Circle8: TCircle;
    Circle9: TCircle;
    Circle10: TCircle;
    Circle11: TCircle;
    Circle12: TCircle;
    Circle13: TCircle;
    Circle14: TCircle;
    Circle15: TCircle;
    Circle16: TCircle;
    Circle17: TCircle;
    Circle18: TCircle;
    Circle19: TCircle;
    Circle20: TCircle;
    Line1: TLine;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure CarregarUsuarios(aUsuarios : TObjectList<TUsuario>);
    function Instancia : TComponent;
  public
    { Public declarations }
  end;

var
  ViewLogin: TViewLogin;

implementation

uses
  Router4D,
  desktop.views.principal;

{$R *.fmx}

procedure TViewLogin.Button1Click(Sender: TObject);
begin
  inherited;
  try
    FPresenterUsuarios.Logar(EditEmail.Text, EditSenha.Text);
    Application.MainForm := ViewPrincipal;
    ViewPrincipal.Show;
    Self.Hide;
  except on E: Exception do
    ShowToast(rectLogin, E);
  end;
end;

procedure TViewLogin.CarregarUsuarios(aUsuarios: TObjectList<TUsuario>);
begin

end;

procedure TViewLogin.FormCreate(Sender: TObject);
begin
  inherited;
  FPresenterUsuarios := TPresenterUsuarios.Create(Self);
end;

function TViewLogin.Instancia: TComponent;
begin
  Result := Self;
end;

end.
