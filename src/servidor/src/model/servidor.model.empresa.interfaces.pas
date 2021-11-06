unit servidor.model.empresa.interfaces;

interface

uses
  servidor.model.base.crud.interfaces,
  entidades.empresa;

type
  iModelEmpresa = interface(iModelBaseCrud<TEmpresa>)
    ['{F6C68966-817C-4074-8A49-62F8C0203A91}']
    function BuscarPorCNPJ(aCNPJ : string) : TEmpresa;
  end;

implementation

end.
