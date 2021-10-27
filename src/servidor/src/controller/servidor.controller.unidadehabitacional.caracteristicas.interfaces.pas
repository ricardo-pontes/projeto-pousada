unit servidor.controller.unidadehabitacional.caracteristicas.interfaces;

interface

uses
  servidor.controller.base.crud.interfaces,
  entidades.unidadehabitacional.caracteristicas,
  System.JSON;

type
  iControllerUnidadeHabitacionalCaracteristicas = interface(iControllerbaseCrud<TUnidadeHabitacionalCaracteristica>)
    ['{ABE8A788-1768-45D8-9EA6-C5EE2AACDC25}']
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
  end;
implementation

end.
