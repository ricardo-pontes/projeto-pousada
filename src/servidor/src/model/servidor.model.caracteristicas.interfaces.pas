unit servidor.model.caracteristicas.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud.interfaces,
  entidades.caracteristicas;

type
  iModelCaracteristicas = interface(iModelBaseCrud<TCaracteristica>)
    ['{CD02F8D5-345C-4928-97D6-178CA06A5376}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TCaracteristica>;
    function Ativar(aID : integer) : string;
    function Desativar(aID : integer) : string;
  end;

implementation

end.
