unit servidor.model.empresa.contatos.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud.interfaces,
  entidades.empresa.contatos;

type
  iModelEmpresaContatos = interface(iModelBaseCrud<TEmpresaContato>)
    ['{BCE864EF-DD5D-4E00-8B10-F6521DD7884D}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TEmpresaContato>;
  end;
implementation

end.
