unit servidor.controller.unidadehabitacional.interfaces;

interface

uses
  servidor.controller.base.crud.interfaces,
  entidades.unidadehabitacional,
  System.JSON;

type
  iControllerUnidadeHabitacional = interface(iControllerBaseCrud<TUnidadeHabitacional>)
    ['{ED660ED4-03F0-4EF8-AD66-E1FE6FBD5E6C}']
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
  end;
implementation

end.
