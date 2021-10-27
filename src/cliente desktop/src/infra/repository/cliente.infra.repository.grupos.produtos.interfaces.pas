unit cliente.infra.repository.grupos.produtos.interfaces;

interface

uses
  cliente.infra.repository.base.crud.interfaces,
  entidades.grupoprodutos,
  System.Generics.Collections;

type
  iRepositoryGrupoProdutos = interface(iRepositoryBaseCrud<TGrupoProduto>)
    ['{DFCBE7C1-F6AC-4BF5-861D-D54C23FF985E}']
    function BuscarPorIDEmpresa(aID : string) : TObjectList<TGrupoProduto>;
  end;

implementation

end.
