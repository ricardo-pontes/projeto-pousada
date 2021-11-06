unit servidor.model.grupoprodutos.interfaces;

interface

uses
  System.Generics.Collections,
  entidades.grupoprodutos,
  validador.interfaces,
  servidor.model.base.crud.interfaces;

type
  iModelGrupoProdutos = interface(iModelBaseCrud<TGrupoProduto>)
    ['{DB839648-44C9-4BE6-848D-C6045856D413}']
    function BuscarPorIDEmpresa(aIDEmpresa : integer) : TObjectList<TGrupoProduto>;
    function Ativar(AID : integer) : string;
    function Desativar(aID : integer) : string;
  end;

implementation

end.
