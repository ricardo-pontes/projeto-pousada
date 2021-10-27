unit servidor.infra.conexao.interfaces;

interface

uses
  Orion.Data.Interfaces;

type
  iConexaoFactory = interface
    ['{0F0C74EF-6BD5-4E74-A42A-A83D56583FF7}']
    function Conexao : iConexao;
    function Dataset(aConexao : iConexao) : iDataSet;
  end;

implementation

end.
