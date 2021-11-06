unit cliente.infra.repository.unidadehabitacional.categorias;

interface

uses
  cliente.infra.repository.unidadehabitacional.categorias.interfaces,
  System.Generics.Collections,
  entidades.unidadehabitacional.categoria,
  RESTRequest4D;

type
  TRepositoryUnidadesHabitacionaisCategoriasRest = class(TInterfacedObject, iRepositoryUnidadesHabitacionaisCategorias)
  private
    FConexao : iRequest;
  public
    constructor Create(aConexao : iRequest);
    destructor Destroy; override;
    class function New(aConexao : iRequest) : iRepositoryUnidadesHabitacionaisCategorias;

    function BuscarPorIDEmpresa(aIDEmpresa : integer) : TObjectList<TUnidadeHabitacionalCategoria>;
    procedure Alterar(aValue : TUnidadeHabitacionalCategoria);
    function BuscarPorID(aID : string) : TUnidadeHabitacionalCategoria;
    procedure Inserir(aValue : TUnidadeHabitacionalCategoria);
  end;

implementation

{ TRepositoryUnidadesHabitacionaisCategoriasRest }

procedure TRepositoryUnidadesHabitacionaisCategoriasRest.Alterar(aValue: TUnidadeHabitacionalCategoria);
begin

end;

function TRepositoryUnidadesHabitacionaisCategoriasRest.BuscarPorID(aID: string): TUnidadeHabitacionalCategoria;
begin

end;

function TRepositoryUnidadesHabitacionaisCategoriasRest.BuscarPorIDEmpresa(aIDEmpresa: integer): TObjectList<TUnidadeHabitacionalCategoria>;
begin

end;

constructor TRepositoryUnidadesHabitacionaisCategoriasRest.Create(aConexao : iRequest);
begin

end;

destructor TRepositoryUnidadesHabitacionaisCategoriasRest.Destroy;
begin

  inherited;
end;

procedure TRepositoryUnidadesHabitacionaisCategoriasRest.Inserir(aValue: TUnidadeHabitacionalCategoria);
begin

end;

class function TRepositoryUnidadesHabitacionaisCategoriasRest.New (aConexao : iRequest) : iRepositoryUnidadesHabitacionaisCategorias;
begin
  Result := Self.Create(aConexao);
end;

end.
