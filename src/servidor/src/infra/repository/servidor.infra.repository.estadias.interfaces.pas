unit servidor.infra.repository.estadias.interfaces;

interface

uses
  System.Generics.Collections,
  entidades.estadia,
  servidor.infra.repository.base.crud.interfaces;

type
  iRepositoryEstadias = interface(iRepositoryBaseCrud<TEstadia>)
    ['{DE727978-CD95-423E-93B3-FDD89DA752D9}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TEstadia>;
  end;

implementation

end.
