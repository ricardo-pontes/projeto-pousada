unit servidor.model.clientes.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud.interfaces,
  entidades.clientes;

type
  iModelClientes = interface(iModelBaseCrud<TClientePF>)
    ['{06B05330-6089-4C04-A74C-268A8F602A44}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TClientePF>;
  end;

implementation

end.
