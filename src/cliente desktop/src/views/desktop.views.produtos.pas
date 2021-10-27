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

  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.TabControl,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  FMX.ActnList,
  FMX.ListBox,
  FMX.Edit,

  desktop.views.base,
  entidades.produtos,
  entidades.grupoprodutos,
  cliente.presenter.produtos.interfaces,
  cliente.presenter.grupos.produtos.interfaces,
  cliente.presenter.produtos,
  cliente.presenter.grupos.produtos,
  Orion.Bindings.Attributes, FMX.EditBox, FMX.NumberBox;

type
  TViewProdutos = class(TViewBase, iPresenterProdutosView, iPresenterGrupoProdutosView)

    [OrionBindingComponent('ID')]
    EditCodigo: TEdit;

    [OrionBindingComponent('Descricao')]
    EditDescricao: TEdit;

    [OrionBindingComponent('ValorCusto')]
    NumberBoxValorVenda: TNumberBox;

    [OrionBindingComponent('ValorVenda')]
    NumberBoxValorCusto: TNumberBox;

    [OrionBindingComponent('IDCategoria')]
    ComboBoxGrupoProduto: TComboBox;

    Label7: TLabel;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Button1: TButton;
    Button2: TButton;
    TabControl1: TTabControl;
    TabItemPesquisa: TTabItem;
    Rectangle3: TRectangle;
    TabItemCadastro: TTabItem;
    Label1: TLabel;
    Rectangle4: TRectangle;
    ButtonNovo: TButton;
    ListViewPesquisa: TListView;
    ActionList1: TActionList;
    ChangeTabPesquisa: TChangeTabAction;
    ChangeTabCadastro: TChangeTabAction;
    Layout1: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    imgBtnEditar: TImage;
    Layout2: TLayout;
    ButtonSalvar: TButton;
    FlowLayout1: TFlowLayout;
    Label6: TLabel;
    Label10: TLabel;
    Button4: TButton;
    Label11: TLabel;

    Label8: TLabel;
    Label9: TLabel;
    procedure ButtonNovoClick(Sender: TObject);
    procedure ListViewPesquisaUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListViewPesquisaItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure Button4Click(Sender: TObject);
  private
    FPresenter : TPresenterProdutos;
    FPresenterGrupoProdutos : TPresenterGrupoProdutos;
    procedure CarregarProdutos(aProdutos : TObjectList<TProduto>);
    procedure CarregarGruposProdutos(aGruposProdutos : TObjectList<TGrupoProduto>);
    function Instancia : TComponent;
  public
    { Public declarations }
  end;

var
  ViewProdutos: TViewProdutos;

implementation

{$R *.fmx}

procedure TViewProdutos.ButtonNovoClick(Sender: TObject);
begin
  inherited;
  ChangeTabCadastro.Execute;
end;

procedure TViewProdutos.Button4Click(Sender: TObject);
begin
  inherited;
  ChangeTabPesquisa.Execute;
end;

procedure TViewProdutos.CarregarGruposProdutos(aGruposProdutos: TObjectList<TGrupoProduto>);
begin
  ComboBoxGrupoProduto.Clear;
  for var lGrupoProduto in aGruposProdutos do
  begin
    var lItem    := TListBoxItem.Create(ComboBoxGrupoProduto);
    lItem.Parent := ComboBoxGrupoProduto;
    lItem.Name   := 'item' + lGrupoProduto.ID.ToString;
    lItem.Text   := lGrupoProduto.Descricao;
    lItem.Tag    := lGrupoProduto.ID;
  end;
end;

procedure TViewProdutos.CarregarProdutos(aProdutos : TObjectList<TProduto>);
begin
  ListViewPesquisa.Items.Clear;
  for var lProduto in aProdutos do
  begin
    var lItem := ListViewPesquisa.Items.Add;
    TListItemText(lItem.Objects.FindDrawable('ID')).Text         := lProduto.ID.ToString;
    TListItemText(lItem.Objects.FindDrawable('Descricao')).Text  := lProduto.Descricao;
    TListItemText(lItem.Objects.FindDrawable('Grupo')).Text      := lProduto.NomeGrupo;
    TListItemText(lItem.Objects.FindDrawable('Preco')).Text      := FormatFloat(',#0.00', lProduto.ValorVenda);
    TListItemText(lItem.Objects.FindDrawable('PrecoCusto')).Text := FormatFloat(',#0.00', lProduto.ValorCusto);
    TListItemImage(lItem.Objects.FindDrawable('Editar')).Bitmap  := imgBtnEditar.Bitmap;
  end;
end;

procedure TViewProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  TabControl1.ActiveTab := TabItemPesquisa;
  FPresenter := TPresenterProdutos.Create(Self);
  FPresenterGrupoProdutos := TPresenterGrupoProdutos.Create(Self);
  FPresenter.BuscarPorIDEmpresa(1);
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

procedure TViewProdutos.ListViewPesquisaItemClickEx(const Sender: TObject; ItemIndex: Integer;
  const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
begin
  inherited;
  if Assigned(ItemObject) then
    if ItemObject.Name = 'Editar' then
    begin
      var lItem := ListViewPesquisa.Items[ItemIndex].Objects.FindDrawable('ID');
      FPresenterGrupoProdutos.BuscarPorIDEmpresa('1');
      FPresenter.BuscarPorID(TListItemText(lItem).Text.ToInteger);
      ChangeTabCadastro.Execute;
    end;
end;

procedure TViewProdutos.ListViewPesquisaUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
var
  txt : TListItemText;
begin
  inherited;
  txt := TListItemText(AItem.Objects.FindDrawable('Descricao'));
  txt.Width := ListViewPesquisa.Width - 55 - 145 - 97 - 32-60;
  txt.Height := GetTextHeight(txt, txt.Width, txt.Text);

  Aitem.Height := Trunc(txt.PlaceOffset.Y + txt.Height + 7);
end;

end.
