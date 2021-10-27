unit servidor.infra.repository.produtos.interfaces;

interface

uses
  System.Generics.Collections,
  entidades.produtos,
  servidor.infra.repository.base.crud.interfaces;

type
  iRepositoryProdutos = interface(iRepositoryBaseCrud<TProduto>)
    ['{2327FCCF-2828-4F2F-B090-55E118DEA74E}']
    function BucarPorIDEmpresa(aID : integer) : TObjectList<TProduto>;
  end;

implementation

end.
