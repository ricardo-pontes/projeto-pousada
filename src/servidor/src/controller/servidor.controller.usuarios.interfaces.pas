unit servidor.controller.usuarios.interfaces;

interface

uses
  servidor.controller.base.crud.interfaces,
  entidades.usuario, System.JSON;

type
  iControllerUsuarios = interface(iControllerBaseCrud<TUsuario>)
    ['{7EEC58B4-60BF-4614-BE0D-12CE7772723D}']
    procedure Ativar(aID : string);
    procedure Desativar(aID : string);
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
    function Logar(aParams : string) : TJSONObject;
  end;
implementation

end.
