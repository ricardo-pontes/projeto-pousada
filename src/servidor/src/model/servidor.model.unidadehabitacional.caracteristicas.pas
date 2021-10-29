unit servidor.model.unidadehabitacional.caracteristicas;

interface

uses
  System.Generics.Collections,
  servidor.model.unidadehabitacional.caracteristicas.interfaces,
  servidor.infra.repository.unidadehabitacional.caracteristicas.interfaces,
  servidor.model.base.crud,
  entidades.unidadehabitacional.caracteristicas;

type
  TModelUnidadeHabitacionalCaracteristicas = class(TModelBaseCrud<TUnidadeHabitacionalCaracteristica>, iModelUnidadeHabitacionalCaracteristicas)
  private
    FRepository : iRepositoryUnidadeHabitacionalCaracteristicas;
  public
    constructor Create(aRepository : iRepositoryUnidadeHabitacionalCaracteristicas);
    destructor Destroy; override;
    class function New(aRepository : iRepositoryUnidadeHabitacionalCaracteristicas) : iModelUnidadeHabitacionalCaracteristicas;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacionalCaracteristica>;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;

{ TModelUnidadeHabitacionalCaracteristicas }

function TModelUnidadeHabitacionalCaracteristicas.BuscarPorIDEmpresa(aID: integer): TObjectList<TUnidadeHabitacionalCaracteristica>;
begin
  if Assigned(Entidades) then Entidades.DisposeOf;
  try
    Entidades := FRepository.BuscarPorIDEmpresa(aID);
    Result := Entidades;
  except on E: Exception do
    raise ExceptionFalhaBancoDadosLeitura.Create;
  end;
end;

constructor TModelUnidadeHabitacionalCaracteristicas.Create(aRepository : iRepositoryUnidadeHabitacionalCaracteristicas);
begin
  FRepository := aRepository;
  inherited Create(aRepository);
end;

destructor TModelUnidadeHabitacionalCaracteristicas.Destroy;
begin

  inherited;
end;

class function TModelUnidadeHabitacionalCaracteristicas.New (aRepository : iRepositoryUnidadeHabitacionalCaracteristicas) : iModelUnidadeHabitacionalCaracteristicas;
begin
  Result := Self.Create(aRepository);
end;

end.

