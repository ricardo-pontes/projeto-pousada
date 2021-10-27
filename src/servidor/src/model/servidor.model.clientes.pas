unit servidor.model.clientes;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud,
  servidor.model.clientes.interfaces,
  entidades.clientes,
  servidor.infra.repository.clientes.interfaces;

type
  TModelClientes = class(TModelBaseCrud<TClientePF>, iModelClientes)
  private
    FRepository : iRepositoryClientes;
  public
    constructor Create(aRepository : iRepositoryClientes);
    destructor Destroy; override;
    class function New(aRepository : iRepositoryClientes) : iModelClientes;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TClientePF>;
  end;

implementation

uses
  System.SysUtils,
  servidor.exceptions;

{ TModelClientes }

function TModelClientes.BuscarPorIDEmpresa(aID: integer): TObjectList<TClientePF>;
begin
  try
    if Assigned(Entidades) then Entidades.DisposeOf;
    Entidades := FRepository.BuscarPorIDEmpresa(aID);
    Result := Entidades;
  except on E: Exception do
    raise ExceptionFalhaBancoDadosLeitura.Create;
  end;
end;

constructor TModelClientes.Create(aRepository : iRepositoryClientes);
begin
  FRepository := aRepository;
  inherited Create(aRepository);
end;

destructor TModelClientes.Destroy;
begin

  inherited;
end;

class function TModelClientes.New (aRepository : iRepositoryClientes) : iModelClientes;
begin
  Result := Self.Create(aRepository);
end;

end.
