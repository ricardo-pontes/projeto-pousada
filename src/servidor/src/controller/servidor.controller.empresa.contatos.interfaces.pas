unit servidor.controller.empresa.contatos.interfaces;

interface

uses
  System.JSON,
  servidor.controller.base.crud.interfaces,
  entidades.empresa.contatos;

type
  iControllerEmpresaContatos = interface(iControllerBaseCrud<TEmpresaContato>)
    ['{85328209-A911-4B90-956D-916452BF0AF4}']
  end;
implementation

end.
