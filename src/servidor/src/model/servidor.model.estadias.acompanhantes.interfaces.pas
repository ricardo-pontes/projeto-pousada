unit servidor.model.estadias.acompanhantes.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud.interfaces,
  entidades.estadia.acompanhante;

type
  iModelEstadiasAcompanhantes = interface(iModelBaseCrud<TEstadiaAcompanhante>)
    ['{A30AAC38-6FD3-4858-8CD2-0991F023088F}']
    function BuscarPorIDEstadia(aID : integer) : TObjectList<TEstadiaAcompanhante>;
  end;
implementation

end.
