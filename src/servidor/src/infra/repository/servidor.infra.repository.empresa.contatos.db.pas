unit servidor.infra.repository.empresa.contatos.db;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces,
  servidor.infra.repository.empresa.contatos.interfaces,
  entidades.empresa.contatos;

type
  TRepositoryEmpresaContatosDB = class(TRepositoryBaseCrud<TEmpresaContato>, iRepositoryEmpresaContatos)
  private
    FConexao : iConexao;
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryEmpresaContatos;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TEmpresaContato>;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;

{ TRepositoryEmpresaContatosDB }

function TRepositoryEmpresaContatosDB.BuscarPorIDEmpresa(aID: integer): TObjectList<TEmpresaContato>;
begin
  Result := nil;
  FConexao.Dataset.Close.SQL('select * from ' + EMPC_TABELA + ' where ' + EMPC_IDEMPRESA + ' = ' + aID.ToString).Open;
  if FConexao.DataSet.RecordCount > 0 then
  begin
    Result := TObjectList<TEmpresaContato>.Create;
    FNotacao.AddObject(Result, TEmpresaContato).AddDataSet(FConexao.DataSet.DataSet).ResolveToObject;
  end;
end;

constructor TRepositoryEmpresaContatosDB.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
  inherited Create(FConexao, FNotacao);
end;

destructor TRepositoryEmpresaContatosDB.Destroy;
begin

  inherited;
end;

class function TRepositoryEmpresaContatosDB.New(aConexao : iConexao; aNotacao : iNotacao): iRepositoryEmpresaContatos;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
