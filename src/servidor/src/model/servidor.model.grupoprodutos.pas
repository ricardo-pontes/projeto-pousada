unit servidor.model.grupoprodutos;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud,
  servidor.infra.repository.grupoprodutos.interfaces,
  entidades.grupoprodutos,
  servidor.model.grupoprodutos.interfaces;

type
  TModelGrupoProdutos = class(TModelBaseCrud<TGrupoProduto>, iModelGrupoProdutos)
  private
    FRepository : iRepositoryGrupoProdutos;
  public
    constructor Create(aRepository : iRepositoryGrupoProdutos);
    destructor Destroy; override;
    class function New(aRepository : iRepositoryGrupoProdutos) : iModelGrupoProdutos;

    function BuscarPorIDEmpresa(aIDEmpresa : integer) : TObjectList<TGrupoProduto>;
  end;

implementation

uses
  System.SysUtils,
  servidor.exceptions;

{ TModelGrupoProdutos }

function TModelGrupoProdutos.BuscarPorIDEmpresa(aIDEmpresa: integer): TObjectList<TGrupoProduto>;
begin
  if Assigned(Entidades) then Entidades.DisposeOf;
  try
    Entidades := FRepository.BuscarPorIDEmpresa(aIDEmpresa);
    Result := Entidades;
  except on E: Exception do
    raise ExceptionFalhaBancoDadosLeitura.Create;
  end;
end;

constructor TModelGrupoProdutos.Create(aRepository : iRepositoryGrupoProdutos);
begin
  FRepository := aRepository;
  inherited Create(aRepository);
end;

destructor TModelGrupoProdutos.Destroy;
begin

  inherited;
end;

class function TModelGrupoProdutos.New (aRepository : iRepositoryGrupoProdutos) : iModelGrupoProdutos;
begin
  Result := Self.Create(aRepository);
end;

end.
