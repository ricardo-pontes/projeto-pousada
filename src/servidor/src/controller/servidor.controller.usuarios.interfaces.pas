unit servidor.controller.usuarios.interfaces;

interface

uses
  servidor.controller.base.crud.interfaces,
  entidades.usuario, System.JSON;

type
  iControllerUsuarios = interface(iControllerBaseCrud<TUsuario>)
    ['{7EEC58B4-60BF-4614-BE0D-12CE7772723D}']
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
  end;
implementation

end.
