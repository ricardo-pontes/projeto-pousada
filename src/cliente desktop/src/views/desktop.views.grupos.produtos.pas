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
  FMX.EditBox,
  FMX.NumberBox,

  desktop.views.base.cadastro,
  cliente.presenter.grupos.produtos.interfaces,
  cliente.presenter.grupos.produtos,
  entidades.grupoprodutos,
  Orion.Bindings.Attributes,
  Router4D.Props;

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
    [Subscribe]
    procedure Listening(aValue : TProps);
    procedure VoltarParaFormAnterior;
    function Render : TFMXObject; override;
  end;

var
  ViewGrupoProdutos: TViewGrupoProdutos;

implementation

uses
  Router4D,
  cliente.presenter.usuarios;

{$R *.fmx}

{ TViewGrupoProdutos }

procedure TViewGrupoProdutos.ButtonSalvarClick(Sender: TObject);
begin
  try
    case EstadoCrud of
      TEstadoCrud.Edicao   : FPresenter.Alterar;
      TEstadoCrud.Insercao : FPresenter.Inserir(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
    end;
    FPresenter.BuscarPorIDEmpresa(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
    inherited;
    if not FormAnterior.IsEmpty then
      VoltarParaFormAnterior;
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
    SetListItemAtivo(lGrupo.Ativo, lItem);
  end;
end;

procedure TViewGrupoProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  TabControl1.ActiveTab := TabItemPesquisa;
  FPresenter := TPresenterGrupoProdutos.Create(Self);
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
  begin
    if ItemObject.Name = 'Editar' then
    begin
      var lItem := ListViewPesquisa.Items[ItemIndex].Objects.FindDrawable('ID');
      FPresenter.BuscarPorID(TListItemText(lItem).Text);
      EstadoCrud := TEstadoCrud.Edicao;
      ChangeTabActionCadastro.Execute;
    end;

    if ItemObject.Name = 'Situacao' then
    begin
      var lItem := ListViewPesquisa.Items[ItemIndex].Objects.FindDrawable('Situacao');
      var lID   := ListViewPesquisa.Items[ItemIndex].Objects.FindDrawable('ID');
      if TListItemText(lItem).Text = 'ativar' then
      begin
        FPresenter.Ativar(TListItemText(lID).Text);
        TListItemText(lItem).TextColor  := TAlphaColorRec.Red;
        TListItemText(lItem).Font.Style := [TFontStyle.fsUnderline];
        TListItemText(lItem).Text       := 'desativar';
      end
      else if TListItemText(lItem).Text = 'desativar' then
      begin
        FPresenter.Desativar(TListItemText(lID).Text);
        TListItemText(lItem).TextColor  := TAlphaColorRec.Green;
        TListItemText(lItem).Font.Style := [TFontStyle.fsUnderline];
        TListItemText(lItem).Text       := 'ativar';
      end;
    end;

  end;
end;

function TViewGrupoProdutos.Render: TFMXObject;
begin
  Result := inherited;
  if TabControl1.ActiveTab = TabItemPesquisa then
    FPresenter.BuscarPorIDEmpresa(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
end;

procedure TViewGrupoProdutos.VoltarParaFormAnterior;
begin
  TRouter4D.Link.&To(FormAnterior, TProps.Create.Key('produtos=atualizargrupoprodutos'));
  FormAnterior := EmptyStr;
end;

procedure TViewGrupoProdutos.Listening(aValue : TProps);
begin
  try
    if aValue.Key = 'gruposprodutos=novocadastro' then
    begin
      FormAnterior := aValue.PropString;
      ButtonNovoClick(Self);
    end;
  finally
    aValue.DisposeOf;
  end
end;

end.
