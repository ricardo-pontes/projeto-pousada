unit cliente.infra.repository.empresas.interfaces;

interface

uses
  entidades.empresa;

type
  iRepositoryEmpresas = interface
    ['{B9F2AE1A-238F-4306-AC21-B361508A3558}']
    procedure Alterar(aEmpresa : TEmpresa);
    function BuscarPorID(aID : integer) : TEmpresa;
  end;

implementation

end.
