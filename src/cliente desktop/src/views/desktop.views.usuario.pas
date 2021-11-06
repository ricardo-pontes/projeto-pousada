unit desktop.views.usuario;

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
  FMX.DateTimeCtrls,
  FMX.ListBox,
  desktop.views.base.cadastro,
  cliente.presenter.usuarios.interfaces,
  cliente.presenter.usuarios,
  entidades.usuario,
  Orion.Bindings.Attributes;

type
  TViewUsuarios = class(TViewBaseCadastro, iPresenterUsuariosView)

    [OrionBindingComponent('ID')]
    NumberBoxCodigo: TNumberBox;

    [OrionBindingComponent('Nome')]
    EditNome: TEdit;

    [OrionBindingComponent('SobreNome')]
    EditSobrenome: TEdit;

    [OrionBindingComponent('CPF')]
    EditCPF: TEdit;

    [OrionBindingComponent('RG')]
    EditRG: TEdit;

    [OrionBindingComponent('DataNascimento')]
    DateEditDataNascimento: TDateEdit;

    [OrionBindingComponent('Telefone')]
    EditCelular: TEdit;

    [OrionBindingComponent('Logradouro')]
    EditLogradouro: TEdit;

    [OrionBindingComponent('Numero')]
    EditNumero: TEdit;

    [OrionBindingComponent('Bairro')]
    EditBairro: TEdit;

    [OrionBindingComponent('Cidade')]
    EditCidade: TEdit;

    [OrionBindingComponent('CEP')]
    EditCEP: TEdit;

    [OrionBindingComponent('UF')]
    ComboBoxUF: TComboBox;

    [OrionBindingComponent('Email')]
    EditEmail: TEdit;

    [OrionBindingComponent('Senha')]
    EditSenha: TEdit;

    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ListViewPesquisaItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure EditEmailEnter(Sender: TObject);
  private
    procedure CarregarUsuarios(aUsuarios : TObjectList<TUsuario>);
    function Instancia : TComponent;
  public
    function Render : TFMXObject; override;
  end;

var
  ViewUsuarios: TViewUsuarios;

implementation

{$R *.fmx}

{ TViewUsuarios }

procedure TViewUsuarios.ButtonNovoClick(Sender: TObject);
begin
  inherited;
  CarregarComboBoxUF(ComboBoxUF);
end;

procedure TViewUsuarios.ButtonSalvarClick(Sender: TObject);
begin
  try
    case EstadoCrud of
      TEstadoCrud.Edicao   : FPresenterUsuarios.Alterar;
      TEstadoCrud.Insercao : FPresenterUsuarios.Inserir;
    end;
    FPresenterUsuarios.BuscarPorIDEmpresa(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
    inherited;
  except on E: Exception do
    ShowToast(TabItemCadastro, E);
  end;
end;

procedure TViewUsuarios.CarregarUsuarios(aUsuarios: TObjectList<TUsuario>);
begin
  ListViewPesquisa.Items.Clear;
  for var lUsuario in aUsuarios do
  begin
    var lItem := ListViewPesquisa.Items.Add;
    TListItemText(lItem.Objects.FindDrawable('ID')).Text           := lUsuario.ID.ToString;
    TListItemText(lItem.Objects.FindDrawable('NomeCompleto')).Text := lUsuario.NomeCompleto;
    TListItemText(lItem.Objects.FindDrawable('Email')).Text        := lUsuario.Email;
    TListItemImage(lItem.Objects.FindDrawable('Editar')).Bitmap    := imgBtnEditar.Bitmap;
    if TListItemText(lItem.Objects.FindDrawable('NomeCompleto')).Text.Trim <> 'Administrador' then
    begin
      if (lUsuario.Ativo = 'S') then
      begin
        TListItemText(lItem.Objects.FindDrawable('Situacao')).Text       := 'desativar';
        TListItemText(lItem.Objects.FindDrawable('Situacao')).TextColor  := TAlphaColorRec.Crimson;
        TListItemText(lItem.Objects.FindDrawable('Situacao')).Font.Style := [TFontStyle.fsUnderline];
      end
      else
      begin
        TListItemText(lItem.Objects.FindDrawable('Situacao')).Text       := 'ativar';
        TListItemText(lItem.Objects.FindDrawable('Situacao')).TextColor  := TAlphaColorRec.Green;
        TListItemText(lItem.Objects.FindDrawable('Situacao')).Font.Style := [TFontStyle.fsUnderline];
      end;
    end;
  end;
end;

procedure TViewUsuarios.EditEmailEnter(Sender: TObject);
var
  Edit : TEdit absolute Sender;
begin
  inherited;
end;

procedure TViewUsuarios.FormCreate(Sender: TObject);
begin
  inherited;
  TabControl1.ActiveTab := TabItemPesquisa;
end;

function TViewUsuarios.Instancia: TComponent;
begin
  Result := Self;
end;

procedure TViewUsuarios.ListViewPesquisaItemClickEx(const Sender: TObject; ItemIndex: Integer;
  const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
begin
  inherited;
  if ItemObject.Name = 'Editar' then
  begin
    var lItem := ListViewPesquisa.Items[ItemIndex].Objects.FindDrawable('ID');
    FPresenterUsuarios.BuscarPorID(TListItemText(lItem).Text);
    EstadoCrud := TEstadoCrud.Edicao;
    ChangeTabActionCadastro.Execute;
  end;

  if ItemObject.Name = 'Situacao' then
  begin
    var lItem := ListViewPesquisa.Items[ItemIndex].Objects.FindDrawable('ID');
    if TListItemText(ItemObject).Text = 'ativar' then
    begin
      FPresenterUsuarios.Ativar(TListItemText(lItem).Text);
      TListItemText(ItemObject).Text := 'desativar';
      TListItemText(ItemObject).TextColor := TAlphaColorRec.Crimson;
    end
    else
    begin
      FPresenterUsuarios.Desativar(TListItemText(lItem).Text);
      TListItemText(ItemObject).Text := 'ativar';
      TListItemText(ItemObject).TextColor := TAlphaColorRec.Green;
    end;
  end;
end;

function TViewUsuarios.Render: TFMXObject;
begin
  Result := inherited;
  FPresenterUsuarios.SetView(Self);
  if TabControl1.ActiveTab = TabItemPesquisa then
    FPresenterUsuarios.BuscarPorIDEmpresa(FPresenterUsuarios.UsuarioLogado.IDEmpresa);
end;

end.
