unit servidor.model.unidadehabitacional.interfaces;

interface

uses
  System.Generics.Collections,
  entidades.unidadehabitacional,
  servidor.model.base.crud.interfaces;

type
  iModelUnidadeHabitacional = interface(iModelBaseCrud<TUnidadeHabitacional>)
    ['{868213CA-D513-46BE-A3D1-DF0BDDFB6D4E}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacional>;
  end;
implementation

end.
