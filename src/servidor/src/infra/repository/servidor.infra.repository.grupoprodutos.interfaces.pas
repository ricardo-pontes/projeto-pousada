unit servidor.infra.repository.grupoprodutos.interfaces;

interface

uses
  Orion.Data.Interfaces,
  entidades.grupoprodutos,
  System.Generics.Collections,
  servidor.infra.repository.base.crud.interfaces;

type
  iRepositoryGrupoProdutos = interface(iRepositoryBaseCrud<TGrupoProduto>)
    ['{35C4C6E8-D400-4AE2-9DAD-B82FB5D96B1F}']
    function BuscarPorIDEmpresa(aIDEmpresa : integer) : TObjectList<TGrupoProduto>;
    function Ativar(aID : integer) : string;
    function Desativar(aID : integer) : string;
  end;

implementation

end.
