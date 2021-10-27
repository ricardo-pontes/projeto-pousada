unit servidor.model.produtos.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud.interfaces,
  entidades.produtos;

type
  iModelProdutos = interface(iModelBaseCrud<TProduto>)
    ['{3EF1247E-E93F-4ED2-B535-7299C7935E1A}']
    function BuscarPorIDEmpresa(aIDEmpresa : integer) : TObjectList<TProduto>;
  end;

implementation

end.
