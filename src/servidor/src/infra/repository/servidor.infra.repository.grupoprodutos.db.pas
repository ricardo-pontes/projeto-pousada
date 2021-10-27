unit servidor.infra.repository.grupoprodutos.db;

interface

uses
  Orion.Data.Interfaces,
  servidor.infra.repository.grupoprodutos.interfaces,
  entidades.grupoprodutos,
  System.Generics.Collections,
  servidor.infra.repository.base.crud,
  conversores.notacoes.interfaces;

type
  TRepositoryGrupoProdutosDB = class(TRepositoryBaseCrud<TGrupoProduto>, iRepositoryGrupoProdutos)
  private
    FConexao : iConexao;
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryGrupoProdutos;

    function BuscarPorIDEmpresa(aIDEmpresa : integer) : TObjectList<TGrupoProduto>;
  end;

implementation

uses
  System.SysUtils,
  conversores.notacoes.factory;

{ TRepositoryGrupoProdutosDB }

function TRepositoryGrupoProdutosDB.BuscarPorIDEmpresa(aIDEmpresa : integer) : TObjectList<TGrupoProduto>;
begin
  Result := nil;
  FConexao.DataSet.SQL('select * from ' + PG_TABELA + ' where ' + PG_IDEMPRESA + ' = ' + aIDEmpresa.ToString).Open;
  if FConexao.DataSet.RecordCount = 0 then Exit;

  Result := TObjectList<TGrupoProduto>.Create;
  FNotacao.AddObject(Result, TGrupoProduto).AddDataSet(FConexao.DataSet.DataSet).ResolveToObject;
end;

constructor TRepositoryGrupoProdutosDB.Create(aConexao: iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
  inherited Create(FConexao, FNotacao);
end;

destructor TRepositoryGrupoProdutosDB.Destroy;
begin

  inherited;
end;

class function TRepositoryGrupoProdutosDB.New(aConexao: iConexao; aNotacao : iNotacao): iRepositoryGrupoProdutos;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
