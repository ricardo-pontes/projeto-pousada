
unit servidor.model.estadias;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud,
  servidor.model.estadias.interfaces,
  servidor.infra.repository.estadias.interfaces,
  entidades.estadia;

type
  TModelEstadias = class(TModelBaseCrud<TEstadia>, iModelEstadias)
  private
    FRepository : iRepositoryEstadias;
  public
    constructor Create(aRepository : iRepositoryEstadias);
    destructor Destroy; override;
    class function New(aRepository : iRepositoryEstadias) : iModelEstadias;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TEstadia>;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;

{ TModelEstadias }

function TModelEstadias.BuscarPorIDEmpresa(aID: integer): TObjectList<TEstadia>;
begin
  try
    if Assigned(Entidades) then Entidades.DisposeOf;
    Entidades := FRepository.BuscarPorIDEmpresa(aID);
    Result := Entidades;
  except on E: Exception do
    raise ExceptionFalhaBancoDadosLeitura.Create;
  end;
end;

constructor TModelEstadias.Create(aRepository : iRepositoryEstadias);
begin
  FRepository := aRepository;
  inherited Create(aRepository);
end;

destructor TModelEstadias.Destroy;
begin

  inherited;
end;

class function TModelEstadias.New (aRepository : iRepositoryEstadias) : iModelEstadias;
begin
  Result := Self.Create(aRepository);
end;

end.
