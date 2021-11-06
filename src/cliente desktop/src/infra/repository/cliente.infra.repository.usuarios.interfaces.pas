unit cliente.infra.repository.usuarios.interfaces;

interface

uses
  System.Generics.Collections,
  cliente.infra.repository.base.crud.interfaces,
  entidades.usuario;

type
  iRepositoryUsuarios = interface(iRepositoryBaseCrud<TUsuario>)
    ['{4F4FAB16-D4F1-4D82-A180-D63F4546B02E}']
    procedure Ativar(aID : integer);
    function BuscarPorIDEmpresa(aID : string) : TObjectList<TUsuario>;
    procedure Desativar(aID : integer);
    function Logar(aEmail, aSenha : string) : TUsuario;
  end;

implementation

end.
