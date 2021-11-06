unit servidor.controller.caracteristicas.interfaces;

interface

uses
  System.JSON,
  servidor.controller.base.crud.interfaces,
  entidades.caracteristicas;

type
  iControllerCaracteristicas = interface(iControllerBaseCrud<TCaracteristica>)
    ['{B368E06F-3CA5-462E-AAAA-7A3B2C4D07CC}']
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
    function Ativar(aID : string) : string;
    function Desativar(aID : string) : string;
  end;

implementation

end.
