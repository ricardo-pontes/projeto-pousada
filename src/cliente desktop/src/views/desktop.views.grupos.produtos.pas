unit desktop.views.grupos.produtos;

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
  FMX.Layouts,
  FMX.ListView,
  FMX.TabControl,
  FMX.Controls.Presentation,
  FMX.Objects,
  FMX.ActnList,
  FMX.Edit,

  desktop.views.base.cadastro,
  cliente.presenter.grupos.produtos.interfaces,
  cliente.presenter.grupos.produtos,
  entidades.grupoprodutos,
  Orion.Bindings.Attributes, FMX.EditBox, FMX.NumberBox;

type
  TViewGrupoProdutos = class(TViewBaseCadastro, iPresenterGrupoProdutosView)

    [OrionBindingComponent('ID')]
    NumberBoxCodigo: TNumberBox;

    [OrionBindingComponent('Descricao')]
    EditDescricao: TEdit;

    [OrionBindingComponent('Ativo')]
    SwitchAtivo: TSwitch;

    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListViewPesquisaItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure ButtonSalvarClick(Sender: TObject);
  private
    FPresenter : TPresenterGrupoProdutos;

    procedure CarregarGruposProdutos(aGruposProdutos : TObjectList<TGrupoProduto>);
    function Instancia : TComponent;
  public
    { Public declarations }
  end;

var
  ViewGrupoProdutos: TViewGrupoProdutos;

implementation

{$R *.fmx}

{ TViewGrupoProdutos }

procedure TViewGrupoProdutos.ButtonSalvarClick(Sender: TObject);
begin
  try
    case EstadoCrud of
      TEstadoCrud.Edicao:
      begin
        FPresenter.Alterar;
      end;
      TEstadoCrud.Insercao:
      begin
        FPresenter.Inserir;
        FPresenter.BuscarPorIDEmpresa('1');
      end;
    end;
    inherited;
  except on E: Exception do
    ShowToast(TabItemCadastro, E);
  end;
end;

procedure TViewGrupoProdutos.CarregarGruposProdutos(aGruposProdutos: TObjectList<TGrupoProduto>);
begin
  ListViewPesquisa.Items.Clear;
  for var lGrupo in aGruposProdutos do
  begin
    var lItem := ListViewPesquisa.Items.Add;
    TListItemText(lItem.Objects.FindDrawable('ID')).Text        := lGrupo.ID.ToString;
    TListItemText(lItem.Objects.FindDrawable('Descricao')).Text := lGrupo.Descricao;
    TListItemImage(lItem.Objects.FindDrawable('Editar')).Bitmap := imgBtnEditar.Bitmap;

    if lGrupo.Ativo = 'S' then
    begin
      TListItemText(lItem.Objects.FindDrawable('Situacao')).TextColor := TAlphaColorRec.Red;
      TListItemText(lItem.Objects.FindDrawable('Situacao')).Font.Style := [TFontStyle.fsUnderline];
      TListItemText(lItem.Objects.FindDrawable('Situacao')).Text := 'desativar';
    end
    else
    begin
      TListItemText(lItem.Objects.FindDrawable('Situacao')).TextColor := TAlphaColorRec.Green;
      TListItemText(lItem.Objects.FindDrawable('Situacao')).Font.Style := [TFontStyle.fsUnderline];
      TListItemText(lItem.Objects.FindDrawable('Situacao')).Text := 'ativar';
    end;
  end;
end;

procedure TViewGrupoProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  TabControl1.ActiveTab := TabItemPesquisa;
  FPresenter := TPresenterGrupoProdutos.Create(Self);
  FPresenter.BuscarPorIDEmpresa('1');
end;

procedure TViewGrupoProdutos.FormDestroy(Sender: TObject);
begin
  inherited;
  FPresenter.DisposeOf;
end;

function TViewGrupoProdutos.Instancia: TComponent;
begin
  Result := Self;
end;

procedure TViewGrupoProdutos.ListViewPesquisaItemClickEx(const Sender: TObject; ItemIndex: Integer;
  const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
begin
  inherited;
  if Assigned(ItemObject) then
    if ItemObject.Name = 'Editar' then
    begin
      var lItem := ListViewPesquisa.Items[ItemIndex].Objects.FindDrawable('ID');
      FPresenter.BuscarPorID(TListItemText(lItem).Text);
      EstadoCrud := TEstadoCrud.Edicao;
      ChangeTabActionCadastro.Execute;
    end;
end;

end.
