unit servidor.model.produtos;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud,
  entidades.produtos,
  servidor.model.produtos.interfaces,
  servidor.infra.repository.produtos.interfaces;

type
  TModelProdutos = class(TModelBaseCrud<TProduto>, iModelProdutos)
  private
    FRepository : iRepositoryProdutos;
  public
    constructor Create(aRepository : iRepositoryProdutos);
    destructor Destroy; override;
    class function New(aRepository : iRepositoryProdutos) : iModelProdutos;

    function BuscarPorIDEmpresa(aIDEmpresa : integer) : TObjectList<TProduto>;
  end;

implementation

uses
  servidor.exceptions,
  System.SysUtils;

function TModelProdutos.BuscarPorIDEmpresa(aIDEmpresa: integer): TObjectList<TProduto>;
begin
  if Assigned(Entidades) then Entidades.DisposeOf;
  try
    Entidades := FRepository.BucarPorIDEmpresa(aIDEmpresa);
    Result := Entidades;
  except on E: Exception do
    raise ExceptionFalhaBancoDados.Create('Não foi possível buscar as informações na nossa base de dados.');
  end;
end;

constructor TModelProdutos.Create(aRepository : iRepositoryProdutos);
begin
  FRepository := aRepository;
  inherited Create(FRepository);
end;

destructor TModelProdutos.Destroy;
begin
  inherited;
end;

class function TModelProdutos.New(aRepository : iRepositoryProdutos) : iModelProdutos;
begin
  Result := Self.Create(aRepository);
end;

end.
