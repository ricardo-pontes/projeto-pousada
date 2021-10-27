unit servidor.model.estadias.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud.interfaces,
  entidades.estadia;

type
  iModelEstadias = interface(iModelBaseCrud<TEstadia>)
    ['{CF46A21D-5192-4CAB-970B-B06D29E208FF}']
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TEstadia>;
  end;

implementation

end.
