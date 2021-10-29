unit servidor.model.usuarios;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud,
  servidor.model.usuarios.interfaces,
  servidor.infra.repository.usuario.interfaces,
  entidades.usuario;

type
  TModelUsuarios = class(TModelBaseCrud<TUsuario>, iModelUsuarios)
  private
    FRepository : iRepositoryUsuarios;
  public
    constructor Create(aRepository : iRepositoryUsuarios);
    destructor Destroy; override;
    class function New(aRepository : iRepositoryUsuarios) : iModelUsuarios;

    function BuscarPordIDEmpresa(aIDEmpresa : integer) : TObjectList<TUsuario>;
    function Login(aEmail, aSenha : string) : TUsuario;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions,
  validador.validacoessimples;

{ TModelUsuarios }

function TModelUsuarios.BuscarPordIDEmpresa(aIDEmpresa: integer): TObjectList<TUsuario>;
begin
  if Assigned(Entidades) then Entidades.DisposeOf;
  try
    Entidades := FRepository.BuscarPorIDEmpresa(aIDEmpresa);
    Result := Entidades;
  except on E: Exception do
    raise ExceptionFalhaBancoDadosLeitura.Create;
  end;
end;

constructor TModelUsuarios.Create(aRepository : iRepositoryUsuarios);
begin
  FRepository := aRepository;
  inherited Create(aRepository);
end;

destructor TModelUsuarios.Destroy;
begin

  inherited;
end;

function TModelUsuarios.Login(aEmail, aSenha: string): TUsuario;
begin
  try
    TValidacoes.StringNaoPodeSerVazia(aEmail, 'Email');
    TValidacoes.StringNaoPodeSerVazia(aSenha, 'Senha');
  except on E: Exception do
    raise ExceptionValidacao.Create(E.Message);
  end;

  if Assigned(Entidade) then Entidade.DisposeOf;
  try
    Entidade := FRepository.Login(aEmail, aSenha);
  except on E: Exception do
    raise ExceptionFalhaBancoDadosLeitura.Create;
  end;

  if not Assigned(Entidade) then
    raise ExceptionNaoEncontrado.Create('Usuário/Senha inválidos.');
  Result := Entidade;
end;

class function TModelUsuarios.New (aRepository : iRepositoryUsuarios) : iModelUsuarios;
begin
  Result := Self.Create(aRepository);
end;

end.
