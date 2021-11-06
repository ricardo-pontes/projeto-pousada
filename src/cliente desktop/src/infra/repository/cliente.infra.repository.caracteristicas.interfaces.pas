unit cliente.infra.repository.caracteristicas.interfaces;

interface

uses
  System.Generics.Collections,
  cliente.infra.repository.base.crud.interfaces,
  entidades.caracteristicas;

type
  iRepositoryCaracteristicas = interface(iRepositoryBaseCrud<TCaracteristica>)
    ['{D64D6D34-5F23-4EF1-A57D-55BF799F520B}']
    function BuscarPorIDEmpresa(aID : string) : TObjectList<TCaracteristica>;
    procedure Ativar(aID : string);
    procedure Desativar(aID : string);
  end;

implementation

end.
