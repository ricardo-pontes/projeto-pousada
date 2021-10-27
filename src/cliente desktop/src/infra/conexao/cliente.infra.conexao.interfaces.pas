unit cliente.infra.conexao.interfaces;

interface

uses
  RESTRequest4D;

type
  iConexoes = interface
    ['{A6666C15-D1CF-4DB4-B68D-7493FEB375AA}']
    function Conexao : iRequest;
  end;
implementation

end.
