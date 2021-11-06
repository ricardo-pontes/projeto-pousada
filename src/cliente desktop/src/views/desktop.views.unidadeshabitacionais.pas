unit desktop.views.unidadeshabitacionais;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Actions,
  System.Generics.Collections,

  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ActnList,
  FMX.TabControl,
  FMX.Objects,
  FMX.Layouts,
  FMX.ListView,
  FMX.Controls.Presentation,

  desktop.views.base.cadastro,
  cliente.presenter.unidadeshabitacionais.interfaces,
  cliente.presenter.unidadeshabitacionais,
  entidades.unidadehabitacional, FMX.Edit, FMX.EditBox, FMX.NumberBox;

type
  TViewUnidadesHabitacionais = class(TViewBaseCadastro, iPresenterUnidadesHabitacionaisView)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    NumberBoxCodigo: TNumberBox;
    Label5: TLabel;
    EditDescricao: TEdit;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FPresenter : TPresenterUnidadesHabitacionais;
    procedure CarregarUnidadesHabitacionais(aUnidadesHabitacionais : TObjectList<TUnidadeHabitacional>);
    function Instancia : TComponent;
  public
    function Render : TFMXObject; override;
  end;

var
  ViewUnidadesHabitacionais: TViewUnidadesHabitacionais;

implementation

{$R *.fmx}

uses cliente.presenter.usuarios;

{ TViewUnidadesHabitacionais }

procedure TViewUnidadesHabitacionais.CarregarUnidadesHabitacionais(
  aUnidadesHabitacionais: TObjectList<TUnidadeHabitacional>);
begin
  ListViewPesquisa.Items.Clear;
  for var lUnidadeHabitacional in aUnidadesHabitacionais do
  begin
    var lItem := ListViewPesquisa.Items.Add;
    TListItemText(lItem.Objects.FindDrawable('ID')).Text        := lUnidadeHabitacional.ID.ToString;
    TListItemText(lItem.Objects.FindDrawable('Descricao')).Text := lUnidadeHabitacional.Descricao;
    TListItemText(lItem.Objects.FindDrawable('NomeGrupo')).Text := lUnidadeHabitacional.NomeGrupo;
    TListItemImage(lItem.Objects.FindDrawable('Editar')).Bitmap := imgBtnEditar.Bitmap;
    SetListItemAtivo(lUnidadeHabitacional.Ativo, lItem);
  end;
end;

procedure TViewUnidadesHabitacionais.FormCreate(Sender: TObject);
begin
  inherited;
  TabControl1.ActiveTab := TabItemPesquisa;
  FPresenter := TPresenterUnidadesHabitacionais.Create(Self);
end;

procedure TViewUnidadesHabitacionais.FormDestroy(Sender: TObject);
begin
  inherited;
  FPresenter.DisposeOf;
end;

function TViewUnidadesHabitacionais.Instancia: TComponent;
begin
  Result := Self;
end;

function TViewUnidadesHabitacionais.Render: TFMXObject;
begin
  Result := inherited;
  if TabControl1.ActiveTab = TabItemPesquisa then
    FPresenter.BuscarPorIDEmpresa(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
end;

end.
