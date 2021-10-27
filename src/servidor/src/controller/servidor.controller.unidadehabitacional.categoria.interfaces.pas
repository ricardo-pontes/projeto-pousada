unit servidor.controller.unidadehabitacional.categoria.interfaces;

interface

uses
  System.JSON,
  servidor.controller.base.crud.interfaces,
  entidades.unidadehabitacional.categoria;

type
  iControllerUnidadeHabitacionalCategoria = interface(iControllerBaseCrud<TUnidadeHabitacionalCategoria>)
    ['{6759C1E1-37D8-46AC-BD51-2ABE31F97F92}']

    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
  end;
implementation

end.
