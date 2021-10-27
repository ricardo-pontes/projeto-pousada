unit servidor.controller.produtos.interfaces;

interface

uses
  System.JSON,
  servidor.controller.base.crud.interfaces,
  entidades.produtos;

type
  iControllerProdutos = interface(iControllerBaseCrud<TProduto>)
    ['{8C6FD0B5-DC17-47A0-8FA1-90EB1263BC10}']
    function BuscarPorIDEmpresa(aIDEmpresa : string) : TJSONArray;
  end;
implementation

end.
