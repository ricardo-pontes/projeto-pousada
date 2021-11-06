unit cliente.infra.repository.unidadehabitacional.caracteristicas.interfaces;

interface

uses
  System.Generics.Collections,
  cliente.infra.repository.base.crud.interfaces,
  entidades.unidadehabitacional.caracteristicas;

type
  iRepositoryUnidadeHabitacionalCaracteristicas = interface(iRepositoryBaseCrud<TUnidadeHabitacionalCaracteristica>)
    ['{663E58F5-300E-44CE-A72D-1090EA5F4BF8}']
    function BuscarPorIDUnidadeHabitacional(aID : string) : TObjectList<TUnidadeHabitacionalCaracteristica>;
  end;

implementation

end.
