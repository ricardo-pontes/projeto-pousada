unit servidor.model.unidadehabitacional;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud,
  entidades.unidadehabitacional,
  servidor.model.unidadehabitacional.interfaces,
  servidor.infra.repository.unidadehabitacional.interfaces;

type
  TModelUnidadeHabitacional = class(TModelBaseCrud<TUnidadeHabitacional>, iModelUnidadeHabitacional)
  private
    FRepository : iRepositoryUnidadeHabitacional;
  public
    constructor Create(aRepository : iRepositoryUnidadeHabitacional);
    destructor Destroy; override;
    class function New(aRepository : iRepositoryUnidadeHabitacional) : iModelUnidadeHabitacional;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacional>;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;

{ TModelUnidadeHabitacional }

function TModelUnidadeHabitacional.BuscarPorIDEmpresa(aID: integer): TObjectList<TUnidadeHabitacional>;
begin
  if Assigned(Entidades) then Entidades.DisposeOf;  
  try
    Entidades := FRepository.BuscarPorIDEmpresa(aID);
    Result := Entidades;
  except on E: Exception do
    raise ExceptionFalhaBancoDadosLeitura.Create;
  end;
end;

constructor TModelUnidadeHabitacional.Create(aRepository : iRepositoryUnidadeHabitacional);
begin
  FRepository := aRepository;
  inherited Create(aRepository);
end;

destructor TModelUnidadeHabitacional.Destroy;
begin

  inherited;
end;

class function TModelUnidadeHabitacional.New (aRepository : iRepositoryUnidadeHabitacional) : iModelUnidadeHabitacional;
begin
  Result := Self.Create(aRepository);
end;

end.
