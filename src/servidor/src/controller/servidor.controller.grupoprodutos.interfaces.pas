unit servidor.controller.grupoprodutos.interfaces;

interface

uses
  System.JSON,
  servidor.controller.base.crud.interfaces,
  entidades.grupoprodutos;

type
  iControllerGrupoProdutos = interface(iControllerBaseCrud<TGrupoProduto>)
    ['{5F34D9A6-EDE7-4A1C-B811-C26DA7EA9F00}']
    function BuscarPorIDEmpresa(aIDEmpresa : string) : TJSONArray;
  end;
implementation

end.
