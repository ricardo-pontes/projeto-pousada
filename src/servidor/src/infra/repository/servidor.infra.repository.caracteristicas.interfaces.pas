unit servidor.infra.repository.caracteristicas.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud.interfaces,
  entidades.caracteristicas;

type
  iRepositoryCaracteristicas = interface(iRepositoryBaseCrud<TCaracteristica>)
    ['{ECC2C8C3-8D43-4587-8868-62FDF94E1A26}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TCaracteristica>;
    function Ativar(aID : integer) : string;
    function Desativar(aID : integer) : string;
  end;
implementation

end.
