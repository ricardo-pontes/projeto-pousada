unit servidor.model.base.crud.interfaces;

interface

uses
  validador.interfaces,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces;

type
  iModelBaseCrud<T:class> = interface
    ['{A8272F10-AC4C-48A2-AA33-ECD5C3D21B3F}']
    function Alterar(aValue : T) : string;
    function BuscarPorID(aID : integer) : T;
    function Deletar(aID : integer) : string;
    function Inserir(aValue : T): string;
    function Validador : iValidador;
    function Conexao : iConexao;
    function Notacao : iNotacao;
  end;

implementation

end.
