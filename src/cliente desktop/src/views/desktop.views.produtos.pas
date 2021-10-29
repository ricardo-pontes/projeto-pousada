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

  Orion.Bindings.Attributes,

  cliente.presenter.produtos,
  cliente.presenter.grupos.produtos,
  cliente.presenter.grupos.produtos.interfaces,
  cliente.presenter.produtos.interfaces,
  entidades.produtos,
  entidades.grupoprodutos;

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
    procedure ListViewPesquisaUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListViewPesquisaItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    FPresenter : TPresenterProdutos;
    FPresenterGrupoProdutos : TPresenterGrupoProdutos;

    procedure CarregarProdutos(aProdutos : TObjectList<TProduto>);
    procedure CarregarGruposProdutos(aGruposProdutos : TObjectList<TGrupoProduto>);
    function Instancia : TComponent;
    procedure MostrarErro(aMensagem : string);
  public

  end;

var
  ViewProdutos: TViewProdutos;

implementation

{$R *.fmx}

procedure TViewProdutos.Button3Click(Sender: TObject);
begin
  inherited;
  var lStyle := ListViewPesquisa.StylesData['Search'];
end;

procedure TViewProdutos.ButtonNovoClick(Sender: TObject);
begin
  inherited;
  FPresenterGrupoProdutos.BuscarPorIDEmpresa('1');
end;

procedure TViewProdutos.ButtonSalvarClick(Sender: TObject);
begin
  try
    case EstadoCrud of
      TEstadoCrud.Edicao  :
      begin
        FPresenter.Alterar;
        FPresenter.BuscarPorIDEmpresa(1);
      end;
      TEstadoCrud.Insercao  :
      begin
        FPresenter.Inserir;
        FPresenter.BuscarPorIDEmpresa(1);
      end;
    end;
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
      EstadoCrud := TEstadoCrud.Edicao;
      ChangeTabActionCadastro.Execute;
    end;
end;

procedure TViewProdutos.ListViewPesquisaUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
begin
  inherited;
  var txt      := TListItemText(AItem.Objects.FindDrawable('Descricao'));
  txt.Width    := ListViewPesquisa.Width - 55 - 145 - 97 - 32-60;
  txt.Height   := GetTextHeight(txt, txt.Width, txt.Text);
  Aitem.Height := Trunc(txt.PlaceOffset.Y + txt.Height + 7);
end;

procedure TViewProdutos.MostrarErro(aMensagem: string);
begin

end;

end.
