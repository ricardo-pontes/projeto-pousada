
unit cliente.presenter.produtos.interfaces;

interface

uses
  System.Classes,
  System.Generics.Collections,
  entidades.produtos;

type
  iPresenterProdutosView = interface
    ['{9547116B-1AF8-4ADF-8CCA-FB7184AEA1F7}']
    procedure CarregarProdutos(aProdutos : TObjectList<TProduto>);
    function Instancia : TComponent;
  end;

  iPresenterProdutos = interface
    ['{4C8A6BC2-159C-4F30-98F9-3250AC13E0E9}']
    function BuscarPorIDEmpresa(aID : integer) : iPresenterProdutos;
  end;
implementation

end.
