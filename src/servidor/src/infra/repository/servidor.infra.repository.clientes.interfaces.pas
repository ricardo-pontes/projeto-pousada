
unit servidor.infra.repository.clientes.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud.interfaces,
  entidades.clientes;

type
  iRepositoryClientes = interface(iRepositoryBaseCrud<TClientePF>)
    ['{E698A369-AD9B-45F9-A38D-E521244F1298}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TClientePF>;
  end;
implementation

end.
