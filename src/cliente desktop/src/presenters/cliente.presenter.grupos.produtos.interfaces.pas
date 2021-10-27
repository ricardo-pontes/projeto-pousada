unit cliente.presenter.grupos.produtos.interfaces;

interface

uses
  System.Generics.Collections,
  entidades.grupoprodutos;

type
  iPresenterGrupoProdutosView = interface
    ['{AFC0A143-2BC9-43F7-A0D6-9FEE0E06E085}']
    procedure CarregarGruposProdutos(aGruposProdutos : TObjectList<TGrupoProduto>);
  end;

implementation

end.
