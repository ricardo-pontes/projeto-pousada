unit servidor.infra.repository.estadias.acompanhantes.interfaces;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud.interfaces,
  entidades.estadia.acompanhante;

type
  iRepositoryEstadiasAcompanhantes = interface(iRepositoryBaseCrud<TEstadiaAcompanhante>)
    ['{762C0664-C18F-4E15-AC7D-8AB38F69D601}']
    function BuscarPorIDEstadia(aID : integer) : TObjectList<TEstadiaAcompanhante>;
  end;
implementation

end.
