unit servidor.infra.repository.unidadehabitacional.caracteristicas.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud.interfaces,
  entidades.unidadehabitacional.caracteristicas;

type
  iRepositoryUnidadeHabitacionalCaracteristicas = interface(iRepositorybaseCrud<TUnidadeHabitacionalCaracteristica>)
    ['{90EBA567-822D-4213-B3CA-9B85A82868D1}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacionalCaracteristica>;
  end;
implementation

end.
