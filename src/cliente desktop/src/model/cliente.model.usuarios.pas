unit cliente.model.usuarios;

interface

uses
  cliente.model.base,
  entidades.usuario,
  cliente.infra.repository.usuarios.interfaces,
  System.Generics.Collections;


type
  TModelUsuarios = class(TModelBase<TUsuario>)
  private
    FRepository : iRepositoryUsuarios;
    FUsuarioLogado : TUsuario;
  public
    constructor Create(aRepository : iRepositoryUsuarios);
    destructor Destroy; override;
    function UsuarioLogado : TUsuario;
    procedure Alterar(aEntidade : TUsuario); override;
    procedure Ativar(aID : integer);
    procedure Inserir(aEntidade : TUsuario); override;
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUsuario>;
    procedure Desativar(aID : integer);
    procedure Login(aEmail, aSenha : string);
    procedure PrepararInsercao; override;
  end;
implementation

{ TModelUsuarios }

uses
  System.SysUtils,
  shared.exceptions,
  entidades.usuarios.validacoes.basicas;

procedure TModelUsuarios.Alterar(aEntidade: TUsuario);
begin
  Validador.Clear;
  Validador.Add(TUsuariosValidacoesBasicas.New);
  Validador.Add(TUsuariosValidacoesBasicasAlterar.New);

  inherited;
end;

procedure TModelUsuarios.Ativar(aID: integer);
begin
  FRepository.Ativar(aID);
end;

function TModelUsuarios.BuscarPorIDEmpresa(aID : integer) : TObjectList<TUsuario>;
begin
  if Assigned(Entidades) then
    Entidades.DisposeOf;

  Entidades := FRepository.BuscarPorIDEmpresa(aID.ToString);
  Result := Entidades;
end;

constructor TModelUsuarios.Create(aRepository : iRepositoryUsuarios);
begin
  FRepository := aRepository;
  inherited Create(FRepository)
end;

procedure TModelUsuarios.Desativar(aID: integer);
begin
  FRepository.Desativar(aID);
end;

destructor TModelUsuarios.Destroy;
begin
  if Assigned(FUsuarioLogado) then
    FUsuarioLogado.DisposeOf;

  inherited;
end;

procedure TModelUsuarios.Inserir(aEntidade: TUsuario);
begin
  Validador.Clear;
  Validador.Add(TUsuariosValidacoesBasicas.New);
  Validador.Add(TUsuariosValidacoesBasicasInserir.New);
  inherited;
end;

procedure TModelUsuarios.Login(aEmail, aSenha: string);
begin
  try
    Validador.Clear;
    Validador.Add(TUsuariosValidacoesBasicasLogin.New(aEmail, aSenha));
    Validador.Executar(nil);
  except on E: Exception do
    raise ExceptionValidacao.Create(E.Message);
  end;

  var lEntidade := FRepository.Logar(aEmail, aSenha);
  FUsuarioLogado := lEntidade;
end;

procedure TModelUsuarios.PrepararInsercao;
begin
  inherited;
  Entidade.IDEmpresa    := FUsuarioLogado.IDEmpresa;
  Entidade.DataCadastro := Now;
  Entidade.Ativo        := 'S';
end;

function TModelUsuarios.UsuarioLogado: TUsuario;
begin
  Result := FUsuarioLogado;
end;

end.
