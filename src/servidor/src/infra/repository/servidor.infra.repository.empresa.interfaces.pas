unit servidor.infra.repository.empresa.interfaces;

interface

uses
  servidor.infra.repository.base.crud.interfaces,
  entidades.empresa;

type
  iRepositoryEmpresa = interface(iRepositoryBaseCrud<TEmpresa>)
    ['{776F3875-CAFB-4ACF-AC34-4E4B4DC5645F}']
    function BuscarPorCNPJ(aCNPJ : string) : TEmpresa;
  end;

implementation

end.
