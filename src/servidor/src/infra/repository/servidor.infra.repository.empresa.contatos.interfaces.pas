
unit servidor.infra.repository.empresa.contatos.interfaces;

interface

uses
  System.Generics.Collections,
  entidades.empresa.contatos,
  servidor.infra.repository.base.crud.interfaces;

type
  iRepositoryEmpresaContatos = interface(iRepositoryBaseCrud<TEmpresaContato>)
    ['{1479ED23-6D05-45E8-B1D6-752722C2B9C2}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TEmpresaContato>;
  end;

implementation

end.
