unit servidor.infra.repository.caracteristicas;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces,
  entidades.caracteristicas,
  servidor.infra.repository.caracteristicas.interfaces;

type
  TRepositoryCaracteristicas = class(TRepositoryBaseCrud<TCaracteristica>, iRepositoryCaracteristicas)
  private
    FConexao : iConexao;
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryCaracteristicas;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TCaracteristica>;
    function Ativar(aID : integer) : string;
    function Desativar(aID : integer) : string;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;

{ TRepositoryCaracteristicas }

function TRepositoryCaracteristicas.Ativar(aID: integer): string;
begin
  var lSQL := TStringBuilder.Create;
  try
    lSQL.Append('update ' + CAT_TABELA + ' set ' + CAT_ATIVO + ' = ' + QuotedStr('S'));
    lSQL.Append(' where ' + CAT_ID + ' = ' + aID.ToString);
    FConexao.DataSet.ExecSQL(lSQL.ToString);
  finally
    lSQL.DisposeOf;
  end;
end;

function TRepositoryCaracteristicas.BuscarPorIDEmpresa(aID: integer): TObjectList<TCaracteristica>;
begin
  var lSQL := 'select * from ' + CAT_TABELA + ' where ' + CAT_ID_EMPRESA + ' = ' + aID.ToString;
  FConexao.DataSet.SQL(lSQL).Open;
  if FConexao.DataSet.RecordCount = 0 then Exit;

  Result := TObjectList<TCaracteristica>.Create;
  FNotacao.AddObject(Result, TCaracteristica).AddDataSet(FConexao.DataSet.DataSet).ResolveToObject;
end;

constructor TRepositoryCaracteristicas.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
  inherited Create(FConexao, FNotacao);
end;

function TRepositoryCaracteristicas.Desativar(aID: integer): string;
begin
  var lSQL := TStringBuilder.Create;
  try
    lSQL.Append('update ' + CAT_TABELA + ' set ' + CAT_ATIVO + ' = ' + QuotedStr('N'));
    lSQL.Append(' where ' + CAT_ID + ' = ' + aID.ToString);
    FConexao.DataSet.ExecSQL(lSQL.ToString);
  finally
    lSQL.DisposeOf;
  end;
end;

destructor TRepositoryCaracteristicas.Destroy;
begin

  inherited;
end;

class function TRepositoryCaracteristicas.New(aConexao : iConexao; aNotacao : iNotacao): iRepositoryCaracteristicas;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
