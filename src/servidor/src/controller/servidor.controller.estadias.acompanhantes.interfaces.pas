unit servidor.controller.estadias.acompanhantes.interfaces;

interface

uses
  System.JSON,
  servidor.controller.base.crud.interfaces,
  entidades.estadia.acompanhante;

type
  iControllerEstadiasAcompanhantes = interface(iControllerBaseCrud<TEstadiaAcompanhante>)
    ['{5FBAFCE2-7D41-406E-91C8-0AE4D78D58E9}']
    function BuscarPorIDEstadia(aID : string) : TJSONArray;
  end;
implementation

end.
