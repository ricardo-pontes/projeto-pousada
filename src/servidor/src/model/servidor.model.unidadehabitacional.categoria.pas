unit servidor.model.unidadehabitacional.categoria;

interface

uses
  System.Generics.Collections,
  servidor.model.unidadehabitacional.interfaces,
  servidor.infra.repository.unidadehabitacional.categoria.interfaces,
  servidor.model.base.crud,
  entidades.unidadehabitacional.categoria,
  servidor.model.unidadehabitacional.categoria.interfaces;

type
  TModelUnidadeHabitacionalCategoria = class(TModelBaseCrud<TUnidadeHabitacionalCategoria>, iModelUnidadeHabitacionalCategoria)
  private
    FRepository : iRepositoryUnidadeHabitacionalCategoria;
  public
    constructor Create(aRepository : iRepositoryUnidadeHabitacionalCategoria);
    destructor Destroy; override;
    class function New(aRepository : iRepositoryUnidadeHabitacionalCategoria) : iModelUnidadeHabitacionalCategoria;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacionalCategoria>;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;

{ TModelUnidadeHabitacionalCategoria }

function TModelUnidadeHabitacionalCategoria.BuscarPorIDEmpresa(aID: integer): TObjectList<TUnidadeHabitacionalCategoria>;
begin
  if Assigned(Entidades) then Entidades.DisposeOf;
  try
    Entidades := FRepository.BuscarPorIDEmpresa(aID);
    Result := Entidades;
  except on E: Exception do
    raise ExceptionFalhaBancoDadosLeitura.Create;
  end;
end;

constructor TModelUnidadeHabitacionalCategoria.Create(aRepository : iRepositoryUnidadeHabitacionalCategoria);
begin
  FRepository := aRepository;
  inherited Create(aRepository);
end;

destructor TModelUnidadeHabitacionalCategoria.Destroy;
begin

  inherited;
end;

class function TModelUnidadeHabitacionalCategoria.New (aRepository : iRepositoryUnidadeHabitacionalCategoria) : iModelUnidadeHabitacionalCategoria;
begin
  Result := Self.Create(aRepository);
end;

end.
