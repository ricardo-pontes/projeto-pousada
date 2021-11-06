unit cliente.presenter.usuarios;

interface

uses
  Orion.Bindings.Interfaces,
  cliente.model.usuarios,
  cliente.presenter.usuarios.interfaces,
  entidades.usuario;

type
  TPresenterUsuarios = class
  private
    FBinds : iOrionBindings;
    FModel : TModelUsuarios;
    FView : iPresenterUsuariosView;
    procedure InternalBuscarPorIDEmpresa(aID : integer);
  public
    constructor Create(aView : iPresenterUsuariosView);
    destructor Destroy; override;

    procedure Ativar(aID : string);
    procedure Alterar;
    procedure BuscarPorIDEmpresa(aID : string); overload;
    procedure BuscarPorIDEmpresa(aID : integer); overload;
    procedure BuscarPorID(aID : string);
    procedure Desativar(aID : string);
    procedure Inserir;
    procedure SetView(aView : iPresenterUsuariosView);
    procedure Logar(aEmail, aSenha : string);
    function UsuarioLogado : TUsuario;
  end;

var
  FPresenterUsuarios : TPresenterUsuarios;

implementation

{ TPresenterUsuarios }

uses
  cliente.infra.repository.usuarios,
  cliente.infra.conexao,
  cliente.infra.binds,
  System.SysUtils,
  shared.exceptions;

procedure TPresenterUsuarios.Alterar;
begin
  if not Assigned(FView) then
    raise ExceptionValidacao.Create('Sem view para fazer o bind.');

  FBinds.Entity(FModel.UsuarioLogado).View(FView.Instancia).BindToEntity;
  FModel.Alterar(FModel.UsuarioLogado);
end;

procedure TPresenterUsuarios.Ativar(aID: string);
begin
  var lID := 0;
  if not TryStrToInt(AID, lID) then
    raise ExceptionConversaoNumerica.Create;

  FModel.Ativar(lID);
end;

procedure TPresenterUsuarios.BuscarPorID(aID: string);
begin
  var lID := 0;
  if not TryStrToInt(AID, lID) then
    raise ExceptionConversaoNumerica.Create;

  var lUsuario := FModel.BuscarPorID(lID);
  if Assigned(FView) then
    FBinds.Entity(lUsuario).View(FView.Instancia).BindToView;
end;

procedure TPresenterUsuarios.BuscarPorIDEmpresa(aID: integer);
begin
  InternalBuscarPorIDEmpresa(aID);
end;

procedure TPresenterUsuarios.BuscarPorIDEmpresa(aID: string);
begin
  var lID := 0;
  if not TryStrToInt(AID, lID) then
    raise ExceptionConversaoNumerica.Create;

  InternalBuscarPorIDEmpresa(lID);
end;

constructor TPresenterUsuarios.Create(aView : iPresenterUsuariosView);
begin
  FView  := aView;
  FModel := TModelUsuarios.Create(TRepositoryUsuariosRest.New(TConexoes.New.Conexao));
  FBinds := TBinds.New;
  if Assigned(FView) then
    FBinds.View(FView.Instancia);
end;

procedure TPresenterUsuarios.Desativar(aID: string);
begin
  var lID := 0;
  if not TryStrToInt(AID, lID) then
    raise ExceptionConversaoNumerica.Create;

  FModel.Desativar(lID);
end;

destructor TPresenterUsuarios.Destroy;
begin
  FModel.DisposeOf;
  inherited;
end;

function TPresenterUsuarios.UsuarioLogado: TUsuario;
begin
  Result := FModel.UsuarioLogado;
end;

procedure TPresenterUsuarios.Inserir;
begin
  if not Assigned(FView) then
    raise ExceptionValidacao.Create('Sem view para fazer o bind.');

  FModel.PrepararInsercao;
  FBinds.Entity(FModel.UsuarioLogado).View(FView.Instancia).BindToEntity;
  FModel.Inserir(FModel.UsuarioLogado);
end;

procedure TPresenterUsuarios.InternalBuscarPorIDEmpresa(aID: integer);
begin
  var lUsuarios := FModel.BuscarPorIDEmpresa(aID);
  if Assigned(FView) then
    FView.CarregarUsuarios(lUsuarios);
end;

procedure TPresenterUsuarios.Logar(aEmail, aSenha: string);
begin
  FModel.Login(aEmail, aSenha);
end;

procedure TPresenterUsuarios.SetView(aView: iPresenterUsuariosView);
begin
  FView := aView;
end;

end.
