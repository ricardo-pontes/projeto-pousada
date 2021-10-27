unit servidor.infra.repository.unidadehabitacional.categoria.interfaces;

interface

uses
  System.Generics.Collections,
  entidades.unidadehabitacional.categoria,
  servidor.infra.repository.base.crud.interfaces;

type
  iRepositoryUnidadeHabitacionalCategoria = interface(iRepositoryBaseCrud<TUnidadeHabitacionalCategoria>)
    ['{B28C873B-F58E-49B9-B5CC-0B3C72DE1831}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacionalCategoria>;
  end;

implementation

end.
