unit desktop.views.principal;

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
  FMX.Objects,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  Router4D,
  cliente.presenter.usuarios;

type
  TViewPrincipal = class(TForm)
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle1: TRectangle;
    Rectangle5: TRectangle;
    lytForms: TLayout;
    ButtonProdutos: TButton;
    ButtonGrupoProdutos: TButton;
    Label1: TLabel;
    ButtonCaracteristicas: TButton;
    Button1: TButton;
    ButtonUsuarios: TButton;
    ButtonEmpresas: TButton;
    ButtonUnidadesHabitacionais: TButton;
    ButtonUnidadesHabitacionaisCategorias: TButton;
    procedure ButtonProdutosClick(Sender: TObject);
    procedure ButtonUnidadesHabitacionaisCategoriasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonGrupoProdutosClick(Sender: TObject);
    procedure ButtonCaracteristicasClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonUsuariosClick(Sender: TObject);
    procedure ButtonEmpresasClick(Sender: TObject);
    procedure ButtonUnidadesHabitacionaisClick(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.fmx}

uses
  desktop.views.inicio,
  Router4D.Props;

procedure TViewPrincipal.ButtonCaracteristicasClick(Sender: TObject);
begin
  TRouter4D.Link.&To('caracteristicas');
end;

procedure TViewPrincipal.ButtonEmpresasClick(Sender: TObject);
begin
  TRouter4D.Link.&To('empresas');
end;

procedure TViewPrincipal.ButtonGrupoProdutosClick(Sender: TObject);
begin
  TRouter4D.Link.&To('gruposprodutos');
end;

procedure TViewPrincipal.ButtonProdutosClick(Sender: TObject);
begin
  TRouter4D.Link.&To('produtos');
end;

procedure TViewPrincipal.ButtonUnidadesHabitacionaisCategoriasClick(Sender: TObject);
begin
  TRouter4D.Link.&To('unidadeshabitacionaiscategorias');
end;

procedure TViewPrincipal.ButtonUnidadesHabitacionaisClick(Sender: TObject);
begin
  TRouter4D.Link.&To('unidadeshabitacionais');
end;

procedure TViewPrincipal.ButtonUsuariosClick(Sender: TObject);
begin
  TRouter4D.Link.&To('usuarios');
end;

procedure TViewPrincipal.Button1Click(Sender: TObject);
begin
  TRouter4D.Link.&To('inicio');
end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin
  TRouter4D.Render<TViewInicio>.SetElement(lytForms, Layout2);
  TRouter4D.Link.&To('inicio');
end;

procedure TViewPrincipal.FormDestroy(Sender: TObject);
begin
  if Assigned(FPresenterUsuarios) then
    FPresenterUsuarios.DisposeOf;
end;

end.
