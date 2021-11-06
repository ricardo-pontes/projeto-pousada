unit servidor.model.usuarios.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud.interfaces,
  entidades.usuario;

type
  iModelUsuarios = interface(iModelBaseCrud<TUsuario>)
    ['{4D2FF7E3-3F9A-4606-9F3E-4D65C932ABAB}']
    function Ativar(aID : integer) : string;
    function Desativar(aID : integer) : string;
    function BuscarPordIDEmpresa(aIDEmpresa : integer) : TObjectList<TUsuario>;
    function Login(aEmail, aSenha : string) : TUsuario;
  end;

implementation

end.
