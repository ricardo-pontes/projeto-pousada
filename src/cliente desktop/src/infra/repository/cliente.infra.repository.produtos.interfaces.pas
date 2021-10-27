unit cliente.infra.repository.produtos.interfaces;

interface

uses
  entidades.produtos,
  System.Generics.Collections, cliente.infra.repository.base.crud.interfaces;

type
  iRepositoryProdutos = interface(iRepositoryBaseCrud<TProduto>)
    ['{FB898986-0DA4-4E96-95F1-D9B6C8677D7B}']
    function BuscarPorIDEmpresa(aID : string) : TObjectList<TProduto>;
  end;

implementation

end.
