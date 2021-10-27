unit entidades.produtos.validacoes.db;

interface

uses
  validador.interfaces, entidades.produtos, conversores.notacoes.interfaces,
  Orion.Data.Interfaces;

type
  TProdutosValidacoesDB = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TProduto;
    [weak]
    FNotacao : iNotacao;
    [weak]
    FConexao : iConexao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

implementation

uses
  System.SysUtils, validador.validacoesdb;

{ TProdutosValidacoesDB }

function TProdutosValidacoesDB.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TProduto(aValue);
end;

constructor TProdutosValidacoesDB.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
end;

destructor TProdutosValidacoesDB.Destroy;
begin

  inherited;
end;

function TProdutosValidacoesDB.Executar : iValidacaoEntidade;
begin
  Result := Self;

  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoesDB.InformacaoNaoPodeExistir(FConexao, FNotacao, PROD_TABELA, PROD_DESCRICAO, 'Descrição', FEntidade.ID, FEntidade.Descricao);
end;

class function TProdutosValidacoesDB.New (aConexao : iConexao; aNotacao : iNotacao) : iValidacaoEntidade;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
