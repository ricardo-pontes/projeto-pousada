unit servidor.infra.repository.unidadehabitacional.interfaces;

interface

uses
  System.Generics.Collections,
  entidades.unidadehabitacional,
  servidor.infra.repository.base.crud.interfaces;

type
  iRepositoryUnidadeHabitacional = interface(iRepositoryBaseCrud<TUnidadeHabitacional>)
    ['{6BA829E3-FA9F-45F2-9E2C-91D282155DB1}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacional>;
  end;
implementation

end.
