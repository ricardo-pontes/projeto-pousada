unit servidor.controller.estadias.interfaces;

interface

uses
  System.JSON,
  servidor.controller.base.crud.interfaces,
  entidades.estadia;

type
  iControllerEstadias = interface(iControllerBaseCrud<TEstadia>)
    ['{4567EAB1-22C1-4346-B20F-6FB0777294CB}']
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
  end;
implementation

end.
