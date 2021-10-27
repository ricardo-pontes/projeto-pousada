unit servidor.infra.repository.usuario.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud.interfaces,
  entidades.usuario;

type
  iRepositoryUsuarios = interface(iRepositoryBaseCrud<TUsuario>)
    ['{6E0CBE3E-4EB9-41D2-9EFF-1B54057BADAB}']
    function BuscarPorIDEmpresa(aIDEmpresa : integer) : TObjectList<TUsuario>;
    function Login(aEmail, aSenha : string) : TUsuario;
  end;

implementation

end.
