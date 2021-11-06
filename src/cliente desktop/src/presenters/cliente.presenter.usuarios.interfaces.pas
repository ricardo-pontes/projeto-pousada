unit cliente.presenter.usuarios.interfaces;

interface

uses
  System.Classes,
  System.Generics.Collections,
  entidades.usuario;

type
  iPresenterUsuariosView = interface
    ['{92B23F66-D257-4671-9528-29A219C1E707}']
    procedure CarregarUsuarios(aUsuarios : TObjectList<TUsuario>);
    function Instancia : TComponent;
  end;
implementation

end.
