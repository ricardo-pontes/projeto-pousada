unit cliente.model.base;

interface

uses
  System.Generics.Collections,
  validador.interfaces,
  cliente.infra.repository.base.crud.interfaces;

type
  TModelBase<T : class, constructor> = class
  private
    FEntidade: T;
    FEntidades: TObjectList<T>;
    FValidador: iValidador;
    [weak]
    FRepository : iRepositoryBaseCrud<T>;
  public
    constructor Create(aRepository : iRepositoryBaseCrud<T>);
    destructor Destroy; override;

    property Entidade: T read FEntidade write FEntidade;
    property Entidades: TObjectList<T> read FEntidades write FEntidades;
    property Validador: iValidador read FValidador write FValidador;

    procedure Alterar(aEntidade : T); virtual;
    function BuscarPorID(aID : integer) : T; virtual;
    procedure Inserir(aEntidade : T); virtual;
    procedure Deletar(aID : integer); virtual;
    procedure PrepararInsercao; virtual;
    procedure PrepararAlteracao; virtual;
  end;

implementation

{ TModelBase<T> }

uses
  shared.exceptions,
  System.SysUtils,
  validador;

procedure TModelBase<T>.Alterar(aEntidade: T);
begin
  try
    FValidador.Executar(aEntidade);
  except on E: Exception do
    raise exceptionValidacao.Create(E.Message);
  end;

  FRepository.Alterar(Entidade);
end;

function TModelBase<T>.BuscarPorID(aID: integer): T;
begin
  if Assigned(FEntidade) then FEntidade.DisposeOf;

  FEntidade := FRepository.BuscarPorID(aID.ToString);
  Result := FEntidade;
end;

constructor TModelBase<T>.Create(aRepository : iRepositoryBaseCrud<T>);
begin
  FValidador  := TValidador.Create;
  FRepository := aRepository;
  FEntidade   := T.Create;
  FEntidades  := TObjectList<T>.Create;
end;

procedure TModelBase<T>.Deletar(aID: integer);
begin

end;

destructor TModelBase<T>.Destroy;
begin
  if Assigned(FEntidade) then
    FEntidade.DisposeOf;

  if Assigned(FEntidades) then
    FEntidades.DisposeOf;

  inherited;
end;

procedure TModelBase<T>.Inserir(aEntidade: T);
begin
  try
    FValidador.Executar(aEntidade);
  except on E: Exception do
    raise exceptionValidacao.Create(E.Message);
  end;
  FRepository.Inserir(Entidade);
end;

procedure TModelBase<T>.PrepararAlteracao;
begin
  if Assigned(FEntidade) then
   FEntidade.DisposeOf;

  FEntidade := T.Create;
end;

procedure TModelBase<T>.PrepararInsercao;
begin
  if Assigned(FEntidade) then
   FEntidade.DisposeOf;

  FEntidade := T.Create;
end;

end.
