unit servidor.infra.repository.base.crud.interfaces;

interface

uses
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces;

type
  iRepositoryBaseCrud<T:class, constructor> = interface
    ['{19D5FF0C-B7C3-4E3C-84C3-5A10BB9D9513}']
    function Alterar(aValue : T) : string;
    function BuscarPorID(aID : integer) : T;
    function Deletar(aID : integer) : string;
    function Inserir(aValue : T) : string;
    function Conexao : iConexao;
    function Notacao : iNotacao;
  end;
implementation

end.
