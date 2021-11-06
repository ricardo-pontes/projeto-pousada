unit desktop.views.empresa;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.Edit,
  FMX.EditBox,
  FMX.NumberBox,
  FMX.ListBox,

  desktop.views.base,
  cliente.presenter.empresas.interfaces,
  cliente.presenter.empresas,
  Orion.Bindings.Attributes;

type
  TViewEmpresas = class(TViewBase, iPresenterEmpresasView)

    [OrionBindingComponent('ID')]
    NumberBoxCodigo: TNumberBox;

    [OrionBindingComponent('RazaoSocial')]
    EditRazaoSocial: TEdit;

    [OrionBindingComponent('Fantasia')]
    EditNomeFantasia: TEdit;

    [OrionBindingComponent('CNPJ')]
    EditCNPJ: TEdit;

    [OrionBindingComponent('Site')]
    EditSite: TEdit;

    [OrionBindingComponent('Telefone')]
    EditTelefone: TEdit;

    [OrionBindingComponent('Whatsapp')]
    EditWhatsapp: TEdit;

    [OrionBindingComponent('Instagram')]
    EditInstagram: TEdit;

    [OrionBindingComponent('Facebook')]
    EditFacebook: TEdit;

    [OrionBindingComponent('CEP')]
    EditCEP: TEdit;

    [OrionBindingComponent('Logradouro')]
    EditLogradouro: TEdit;

    [OrionBindingComponent('Numero')]
    EditNumero: TEdit;

    [OrionBindingComponent('Bairro')]
    EditBairro: TEdit;

    [OrionBindingComponent('Cidade')]
    EditCidade: TEdit;

    [OrionBindingComponent('UF')]
    ComboBoxUF: TComboBox;

    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Line1: TLine;
    FlowLayout1: TFlowLayout;
    Label12: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label17: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Layout3: TLayout;
    ButtonSalvar: TButton;
    Line2: TLine;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
  private
    FPresenter : TPresenterEmpresas;
  public
    function Instancia : TComponent;
    function Render : TFMXObject; override;
  end;

var
  ViewEmpresas: TViewEmpresas;

implementation

{$R *.fmx}

uses cliente.presenter.usuarios;

{ TViewBase1 }

procedure TViewEmpresas.ButtonSalvarClick(Sender: TObject);
begin
  inherited;
  try
    FPresenter.Alterar;
  except on E: Exception do
    ShowToast(FlowLayout1, E);
  end;
end;

procedure TViewEmpresas.FormCreate(Sender: TObject);
begin
  inherited;
  FPresenter := TPresenterEmpresas.Create(Self);
end;

procedure TViewEmpresas.FormDestroy(Sender: TObject);
begin
  inherited;
  FPresenter.DisposeOf;
end;

function TViewEmpresas.Instancia: TComponent;
begin
  Result := Self;
end;

function TViewEmpresas.Render: TFMXObject;
begin
  Result := inherited;
  FPresenter.BuscarPorID(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
end;

end.
