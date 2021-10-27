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
  end;

implementation

{ TModelBase<T> }

uses
  System.SysUtils,
  validador;

procedure TModelBase<T>.Alterar(aEntidade: T);
begin
  FValidador.Executar(Entidade);
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
end;

procedure TModelBase<T>.Deletar(aID: integer);
begin

end;

destructor TModelBase<T>.Destroy;
begin
  if Assigned(FEntidade) then FEntidade.DisposeOf;
  if Assigned(FEntidades) then FEntidades.DisposeOf;

  inherited;
end;

procedure TModelBase<T>.Inserir(aEntidade: T);
begin
  FValidador.Executar(Entidade);
  FRepository.Inserir(Entidade);
end;

end.
