unit cliente.infra.repository.unidadehabitacional.interfaces;

interface

uses
  System.Generics.Collections,
  cliente.infra.repository.base.crud.interfaces,
  entidades.unidadehabitacional;

type
  iRepositoryUnidadesHabitacionais = interface(iRepositoryBaseCrud<TUnidadeHabitacional>)
    ['{1F5ACD2F-1704-41C7-ACBE-F13A8AC46884}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacional>;
  end;

implementation

end.
