unit servidor.model.unidadehabitacional.categoria.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud.interfaces,
  entidades.unidadehabitacional.categoria;

type
  iModelUnidadeHabitacionalCategoria = interface(iModelBaseCrud<TUnidadeHabitacionalCategoria>)
    ['{11864A2D-B986-4A3C-A253-74179B4BC906}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacionalCategoria>;
  end;
implementation

end.
