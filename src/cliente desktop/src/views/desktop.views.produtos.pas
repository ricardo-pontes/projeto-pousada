unit desktop.views.produtos;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Actions,
  System.Generics.Collections,

  desktop.views.base.cadastro,

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
  FMX.Layouts,
  FMX.ListView,
  FMX.Controls.Presentation,
  FMX.Objects,
  FMX.EditBox,
  FMX.NumberBox,
  FMX.Edit,
  FMX.ListBox,
  FMX.SearchBox,
  FMX.ComboEdit,
  FMX.ComboEdit.Style,
  FMX.ExtCtrls,

  Orion.Bindings.Attributes,

  cliente.presenter.produtos,
  cliente.presenter.grupos.produtos,
  cliente.presenter.grupos.produtos.interfaces,
  cliente.presenter.produtos.interfaces,
  entidades.produtos,
  entidades.grupoprodutos,
  Router4D,
  Router4d.Props;

type
  TViewProdutos = class(TViewBaseCadastro, iPresenterProdutosView, iPresenterGrupoProdutosView)

    [OrionBindingComponent('ID')]
    NumberBoxCodigo: TNumberBox;

    [OrionBindingComponent('Descricao')]
    EditDescricao: TEdit;

    [OrionBindingComponent('ValorVenda')]
    NumberBoxValorVenda: TNumberBox;

    [OrionBindingComponent('ValorCusto')]
    NumberBoxValorCusto: TNumberBox;

    [OrionBindingComponent('IDCategoria')]
    ComboBoxGrupoProduto: TComboBox;

    Label10: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Button3: TButton;
    btnNovoGrupoProdutos: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListViewPesquisaItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnNovoGrupoProdutosClick(Sender: TObject);
  private
    FPresenter : TPresenterProdutos;
    FPresenterGrupoProdutos : TPresenterGrupoProdutos;

    procedure CarregarProdutos(aProdutos : TObjectList<TProduto>);
    procedure CarregarGruposProdutos(aGruposProdutos : TObjectList<TGrupoProduto>);
    function Instancia : TComponent;
  public
    [Subscribe]
    procedure Listening(aValue : TProps);
    function Render : TFMXObject; override;
  end;

var
  ViewProdutos: TViewProdutos;

implementation

uses
  System.Rtti,
  cliente.presenter.usuarios;

{$R *.fmx}

procedure TViewProdutos.btnNovoGrupoProdutosClick(Sender: TObject);
begin
  inherited;
  TRouter4D.Link.&To('gruposprodutos', TProps.Create.Key('gruposprodutos=novocadastro').PropString('produtos'));
end;

procedure TViewProdutos.Button3Click(Sender: TObject);
begin
  inherited;
  var lStyle := ListViewPesquisa.StylesData['Search'];
end;

procedure TViewProdutos.ButtonNovoClick(Sender: TObject);
begin
  inherited;
  FPresenterGrupoProdutos.BuscarPorIDEmpresa(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
end;

procedure TViewProdutos.ButtonSalvarClick(Sender: TObject);
begin
  try
    case EstadoCrud of
      TEstadoCrud.Edicao    : FPresenter.Alterar;
      TEstadoCrud.Insercao  : FPresenter.Inserir(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
    end;
    FPresenterGrupoProdutos.BuscarPorIDEmpresa(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
    inherited;
  except on E: Exception do
    ShowToast(TabItemCadastro, E);
  end;
end;

procedure TViewProdutos.CarregarGruposProdutos(aGruposProdutos: TObjectList<TGrupoProduto>);
begin
  ComboBoxGrupoProduto.ListBox.Clear;
  for var lGrupoProduto in aGruposProdutos do
  begin
    var lItem    := TListBoxItem.Create(ComboBoxGrupoProduto);
    lItem.Parent := ComboBoxGrupoProduto;
    lItem.Name   := 'item' + lGrupoProduto.ID.ToString;
    lItem.Text   := lGrupoProduto.Descricao;
    lItem.Tag    := lGrupoProduto.ID;
  end;
end;

procedure TViewProdutos.CarregarProdutos(aProdutos: TObjectList<TProduto>);
begin
  ListViewPesquisa.Items.Clear;
  for var lProduto in aProdutos do
  begin
    var lItem := ListViewPesquisa.Items.Add;
    TListItemText(lItem.Objects.FindDrawable('ID')).Text         := lProduto.ID.ToString;
    TListItemText(lItem.Objects.FindDrawable('Descricao')).Text  := lProduto.Descricao;
    TListItemText(lItem.Objects.FindDrawable('NomeGrupo')).Text  := lProduto.NomeGrupo;
    TListItemText(lItem.Objects.FindDrawable('ValorVenda')).Text := FormatFloat(',#0.00', lProduto.ValorVenda);
    TListItemText(lItem.Objects.FindDrawable('ValorCusto')).Text := FormatFloat(',#0.00', lProduto.ValorCusto);
    TListItemImage(lItem.Objects.FindDrawable('Editar')).Bitmap  := imgBtnEditar.Bitmap;
  end;
end;

procedure TViewProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  TabControl1.ActiveTab := TabItemPesquisa;
  FPresenter := TPresenterProdutos.Create(Self);
  FPresenterGrupoProdutos := TPresenterGrupoProdutos.Create(Self);
end;

procedure TViewProdutos.FormDestroy(Sender: TObject);
begin
  inherited;
  FPresenter.DisposeOf;
  FPresenterGrupoProdutos.DisposeOf;
end;

function TViewProdutos.Instancia: TComponent;
begin
  Result := Self;
end;

procedure TViewProdutos.Listening(aValue: TProps);
begin
  try
    if aValue.Key = 'produtos=atualizargrupoprodutos' then
      FPresenterGrupoProdutos.BuscarPorIDEmpresa(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
  finally
    aValue.DisposeOf;
  end;
end;

procedure TViewProdutos.ListViewPesquisaItemClickEx(const Sender: TObject; ItemIndex: Integer;
  const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
begin
  inherited;
  if Assigned(ItemObject) then
    if ItemObject.Name = 'Editar' then
    begin
      var lItem := ListViewPesquisa.Items[ItemIndex].Objects.FindDrawable('ID');
      FPresenter.BuscarPorID(TListItemText(lItem).Text.ToInteger);
      EstadoCrud := TEstadoCrud.Edicao;
      ChangeTabActionCadastro.Execute;
    end;
end;

function TViewProdutos.Render: TFMXObject;
begin
  Result := inherited;
  if TabControl1.ActiveTab = TabItemPesquisa then
    FPresenterGrupoProdutos.BuscarPorIDEmpresa(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
end;

end.
