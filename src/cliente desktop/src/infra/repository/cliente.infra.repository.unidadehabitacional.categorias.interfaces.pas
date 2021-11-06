unit cliente.infra.repository.unidadehabitacional.categorias.interfaces;

interface

uses
  System.Generics.Collections,
  cliente.infra.repository.base.crud.interfaces,
  entidades.unidadehabitacional.categoria;

type
  iRepositoryUnidadesHabitacionaisCategorias = interface(iRepositoryBaseCrud<TUnidadeHabitacionalCategoria>)
    ['{D4E78B8E-CAFB-43A4-B000-9A8A75FA536D}']
    function BuscarPorIDEmpresa(aIDEmpresa : integer) : TObjectList<TUnidadeHabitacionalCategoria>;
  end;

implementation

end.
