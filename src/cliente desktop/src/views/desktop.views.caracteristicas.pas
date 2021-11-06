unit desktop.views.caracteristicas;

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
  FMX.Edit,
  FMX.EditBox,
  FMX.NumberBox,

  desktop.views.base.cadastro,
  cliente.presenter.caracteristicas.interfaces,
  entidades.caracteristicas,
  cliente.presenter.caracteristicas,
  Orion.Bindings.Attributes;

type
  TViewCaracteristicas = class(TViewBaseCadastro, iPresenterCaracteristicasView)

    [OrionBindingComponent('ID')]
    NumberBoxCodigo: TNumberBox;
    [OrionBindingComponent('Descricao')]
    EditDescricao: TEdit;
    [OrionBindingComponent('Ativo')]
    SwitchAtivo: TSwitch;

    Label5: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    procedure ListViewPesquisaItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
  private
    FPresenter : TPresenterCaracteristicas;
    {iPresenterCaracteristicasView}
    procedure CarregarCaracteristicas(aCaracteristicas : TObjectList<TCaracteristica>);
    function Instancia : TComponent;
  public
    function Render : TFMXObject; override;
  end;

var
  ViewCaracteristicas: TViewCaracteristicas;

implementation

{$R *.fmx}

uses
  cliente.presenter.grupos.produtos.interfaces,
  cliente.presenter.usuarios;

{ TViewCaracteristicas }


procedure TViewCaracteristicas.ButtonSalvarClick(Sender: TObject);
begin
  try
    case EstadoCrud of
      TEstadoCrud.Edicao   : FPresenter.Alterar;
      TEstadoCrud.Insercao : FPresenter.Inserir(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
    end;
    FPresenter.BuscarPorIDEmpresa(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
    inherited;
  except on E: Exception do
    ShowToast(TabControl1, E);
  end;
end;

procedure TViewCaracteristicas.CarregarCaracteristicas(aCaracteristicas: TObjectList<TCaracteristica>);
begin
  ListViewPesquisa.Items.Clear;
  for var lCaracteristica in aCaracteristicas do
  begin
    var lItem := ListViewPesquisa.Items.Add;
    TListItemText(lItem.Objects.FindDrawable('ID')).Text        := lCaracteristica.ID.ToString;
    TListItemText(lItem.Objects.FindDrawable('Descricao')).Text := lCaracteristica.Descricao;
    TListItemImage(lItem.Objects.FindDrawable('Editar')).Bitmap := imgBtnEditar.Bitmap;
    if lCaracteristica.Ativo.Equals('S') then
    begin
      TListItemText(lItem.Objects.FindDrawable('Situacao')).Text       := 'desativar';
      TListItemText(lItem.Objects.FindDrawable('Situacao')).Font.Style := [TFontStyle.fsUnderline];
      TListItemText(lItem.Objects.FindDrawable('Situacao')).TextColor  := TAlphaColorRec.Red;
    end
    else if lCaracteristica.Ativo.Equals('N') then
    begin
      TListItemText(lItem.Objects.FindDrawable('Situacao')).Text       := 'ativar';
      TListItemText(lItem.Objects.FindDrawable('Situacao')).Font.Style := [TFontStyle.fsUnderline];
      TListItemText(lItem.Objects.FindDrawable('Situacao')).TextColor  := TAlphaColorRec.Green;
    end;
  end;
end;

procedure TViewCaracteristicas.FormCreate(Sender: TObject);
begin
  inherited;
  FPresenter := TPresenterCaracteristicas.Create(Self);
  TabControl1.ActiveTab := TabItemPesquisa;
end;

procedure TViewCaracteristicas.FormDestroy(Sender: TObject);
begin
  inherited;
  FPresenter.DisposeOf;
end;

function TViewCaracteristicas.Instancia: TComponent;
begin
  Result := Self;
end;

procedure TViewCaracteristicas.ListViewPesquisaItemClickEx(const Sender: TObject; ItemIndex: Integer;
  const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
begin
  inherited;
  if Assigned(ItemObject) then
  begin
    if ItemObject.Name = 'Editar' then
    begin
      var lID   := ListViewPesquisa.Items[ItemIndex].Objects.FindDrawable('ID');
      FPresenter.BuscarPorID(TListItemText(lID).Text);
      EstadoCrud := TEstadoCrud.Edicao;
      ChangeTabActionCadastro.Execute;
    end;

    if ItemObject.Name = 'Situacao' then
    begin
      var lID   := ListViewPesquisa.Items[ItemIndex].Objects.FindDrawable('ID');
      if TListItemText(ITemObject).Text = 'ativar' then
      begin
        FPresenter.Ativar(TListItemText(lID).Text);
        TListItemText(ItemObject).TextColor  := TAlphaColorRec.Red;
        TListItemText(ItemObject).Font.Style := [TFontStyle.fsUnderline];
        TListItemText(ItemObject).Text       := 'desativar';
      end
      else if TListItemText(ITemObject).Text = 'desativar' then
      begin
        FPresenter.Desativar(TListItemText(lID).Text);
        TListItemText(ItemObject).TextColor  := TAlphaColorRec.Green;
        TListItemText(ItemObject).Font.Style := [TFontStyle.fsUnderline];
        TListItemText(ItemObject).Text       := 'ativar';
      end;
    end;
  end;
end;

function TViewCaracteristicas.Render: TFMXObject;
begin
  Result := inherited;
  if TabControl1.ActiveTab = TabItemPesquisa then
    FPresenter.BuscarPorIDEmpresa(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
end;

end.
