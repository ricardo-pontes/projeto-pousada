unit servidor.controller.clientes.interfaces;

interface

uses
  System.JSON,
  servidor.controller.base.crud.interfaces,
  entidades.clientes;

type
  iControllerClientes = interface(iControllerBaseCrud<TClientePF>)
    ['{8F40E503-A309-4CAF-AD54-85D741A9EB00}']
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
  end;
implementation

end.
