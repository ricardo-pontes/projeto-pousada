unit servidor.model.base.crud;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud.interfaces,
  validador.interfaces,
  servidor.infra.repository.base.crud.interfaces,
  Orion.Data.Interfaces, conversores.notacoes.interfaces;

type
  TModelBaseCrud<T:class, constructor> = class(TInterfacedObject, iModelBaseCrud<T>)
  private
    FValidador : iValidador;
    [weak]
    FRepository : iRepositoryBaseCrud<T>;
  protected
    Entidade : T;
    Entidades : TObjectList<T>;
  public
    constructor Create(aRepository : iRepositoryBaseCrud<T>);
    destructor Destroy; override;
    class function New(aRepository : iRepositoryBaseCrud<T>) : iModelBaseCrud<T>;

    function Alterar(aValue : T) : string;
    function BuscarPorID(aID : integer) : T;
    function Deletar(aID : integer) : string;
    function Inserir(aValue : T): string;
    function Validador : iValidador;
    function Conexao : iConexao;
    function Notacao : iNotacao;
  end;

implementation

{ TModelBaseCrud }

uses
  System.SysUtils,
  validador,
  shared.exceptions;

function TModelBaseCrud<T>.Alterar(aValue: T): string;
begin
  if Assigned(Entidade) then Entidade.DisposeOf;
  Entidade := aValue;
  try
    FValidador.Executar(Entidade);
  except on E: Exception do
    raise ExceptionValidacao.Create(E.Message);
  end;

  try
    FRepository.Alterar(Entidade);
    Result := 'OK';
  except on E: Exception do
    raise ExceptionFalhaBancoDadosGravacao.Create;
  end;
end;

function TModelBaseCrud<T>.BuscarPorID(aID: integer): T;
begin
  if Assigned(Entidade) then Entidade.DisposeOf;
  try
    Entidade := FRepository.BuscarPorID(aID);
  except on E: Exception do
    raise ExceptionFalhaBancoDadosLeitura.Create;
  end;

  if not Assigned(Entidade) then
    raise ExceptionNaoEncontrado.Create('A(s) informação(es) não existe(m) em nossa base de dados.');

  Result := Entidade;
end;

function TModelBaseCrud<T>.Conexao: iConexao;
begin
  Result := FRepository.Conexao;
end;

constructor TModelBaseCrud<T>.Create(aRepository : iRepositoryBaseCrud<T>);
begin
  FValidador  := TValidador.Create;
  FRepository := aRepository;
end;

function TModelBaseCrud<T>.Deletar(aID: integer): string;
begin
  try
    FRepository.Deletar(aID);
    Result := 'OK';
  except on E: Exception do
    Result := 'Não foi possível apagar as informações em nossa base de dados.';
  end;
end;

destructor TModelBaseCrud<T>.Destroy;
begin
  if Assigned(Entidade) then Entidade.DisposeOf;
  if Assigned(Entidades) then Entidades.DisposeOf;
  
  inherited;
end;

function TModelBaseCrud<T>.Inserir(aValue: T): string;
begin
  if not Assigned(aValue) then raise ExceptionFalhaConversaoObjeto.Create;
  if Assigned(Entidade) then Entidade.DisposeOf;
  Entidade := aValue;
  try
    FValidador.Executar(Entidade);
  except on E: Exception do
    raise ExceptionValidacao.Create(E.Message);
  end;

  try
    Result := FRepository.Inserir(Entidade);
  except on E: Exception do
    raise ExceptionFalhaBancoDadosGravacao.Create;
  end;
end;

class function TModelBaseCrud<T>.New(aRepository : iRepositoryBaseCrud<T>) : iModelBaseCrud<T>;
begin
  Result := Self.Create(aRepository);
end;

function TModelBaseCrud<T>.Notacao: iNotacao;
begin
  Result := FRepository.Notacao;
end;

function TModelBaseCrud<T>.Validador: iValidador;
begin
  Result := FValidador;
end;

end.
