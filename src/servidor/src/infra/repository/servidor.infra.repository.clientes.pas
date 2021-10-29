unit servidor.infra.repository.clientes;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces,
  entidades.clientes,
  servidor.infra.repository.clientes.interfaces;

type
  TRepositoryClientesDB = class(TRepositoryBaseCrud<TClientePF>, iRepositoryClientes)
  private
    FConexao : iConexao;
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryClientes;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TClientePF>;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;

{ TRepositoryClientesDB }

function TRepositoryClientesDB.BuscarPorIDEmpresa(aID: integer): TObjectList<TClientePF>;
begin
  Result := nil;
  var lSQL := 'select * from ' + CLI_TABELA + ' where ' + CLI_ID_EMPRESA + ' = ' + aID.ToString;
  FConexao.DataSet.Close.SQL(lSQL).Open;
  if FConexao.DataSet.RecordCount > 0 then
  begin
    Result := TObjectList<TClientePF>.Create;
    FNotacao.AddObject(Result, TClientePF).AddDataSet(FConexao.DataSet.Dataset).ResolveToObject;
  end;
end;

constructor TRepositoryClientesDB.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
  inherited Create(FConexao, FNotacao);
end;

destructor TRepositoryClientesDB.Destroy;
begin

  inherited;
end;

class function TRepositoryClientesDB.New(aConexao : iConexao; aNotacao : iNotacao): iRepositoryClientes;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
