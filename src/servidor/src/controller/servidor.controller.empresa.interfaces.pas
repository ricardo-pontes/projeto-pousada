unit servidor.controller.empresa.interfaces;

interface

uses
  servidor.controller.base.crud.interfaces,
  entidades.empresa;

type
  iControllerEmpresa = interface(iControllerBaseCrud<TEmpresa>)
    ['{BB587145-65F5-4E4B-992A-01EF2DC9FC34}']
  end;

implementation

end.
