unit servidor.infra.repository.produtos;

interface

uses
  System.Generics.Collections,
  entidades.produtos,
  servidor.infra.repository.base.crud,
  servidor.infra.repository.produtos.interfaces,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces;

type
  TRepositoryProdutos = class(TRepositorybaseCrud<TProduto>, iRepositoryProdutos)
  private
    FConexao : iConexao;
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryProdutos;

    function BucarPorIDEmpresa(aID : integer) : TObjectList<TProduto>;
  end;

implementation

uses
  System.SysUtils,
  entidades.grupoprodutos;

{ TRepositoryProdutos }

function TRepositoryProdutos.BucarPorIDEmpresa(aID: integer): TObjectList<TProduto>;
begin
  Result := nil;
  var lSQL := TStringBuilder.Create;
  try
    lSQL.Append('select ' + PROD_TABELA + '.*, ' + PG_DESCRICAO + ' from ' + PROD_TABELA);
    lSQL.Append(' inner join ' + PG_TABELA + ' on ' + PG_ID + ' = ' + PROD_ID_GRUPO);
    lSQL.Append(' where ' + PROD_ID_EMPRESA + ' = ' + aID.ToString);
    FConexao.DataSet.SQL(lSQL.ToString).Open;
    if FConexao.DataSet.RecordCount = 0 then
      Exit;

    Result := TObjectList<TProduto>.Create;
    FNotacao.AddObject(Result, TProduto).AddDataSet(FConexao.DataSet.Dataset).ResolveToObject;
  finally
    lSQL.DisposeOf;
  end;
end;

constructor TRepositoryProdutos.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
  inherited Create(FConexao, aNotacao);
end;

destructor TRepositoryProdutos.Destroy;
begin

  inherited;
end;

class function TRepositoryProdutos.New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryProdutos;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
