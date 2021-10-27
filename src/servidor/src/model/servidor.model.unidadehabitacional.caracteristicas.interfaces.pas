unit servidor.model.unidadehabitacional.caracteristicas.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud.interfaces,
  entidades.unidadehabitacional.caracteristicas;

type
  iModelUnidadeHabitacionalCaracteristicas = interface(iModelBaseCrud<TUnidadeHabitacionalCaracteristica>)
    ['{4988D41A-A2F6-4A61-90D0-D51DF9275774}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacionalCaracteristica>;
  end;
implementation

end.
