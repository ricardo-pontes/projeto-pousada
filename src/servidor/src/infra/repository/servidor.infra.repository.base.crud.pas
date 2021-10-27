unit servidor.infra.repository.base.crud;

interface

uses
  servidor.infra.repository.base.crud.interfaces, Orion.Data.Interfaces,
  conversores.notacoes.interfaces;

type
  TRepositoryBaseCrud<T : class, constructor> = class(TInterfacedObject, iRepositoryBaseCrud<T>)
  private
    [weak]
    FConexao : iConexao;
    [weak]
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryBaseCrud<T>;

    function Alterar(aValue : T) : string;
    function BuscarPorID(aID : integer) : T;
    function Deletar(aID : integer) : string;
    function Inserir(aValue : T) : string;
    function Conexao : iConexao;
    function Notacao : iNotacao;
  end;

implementation

uses
  System.SysUtils;

{ TRepositoryBaseCrud<T> }

function TRepositoryBaseCrud<T>.Alterar(aValue: T): string;
begin
  var lSQL := FNotacao.AddObject(aValue, T).BuildSQL(TTipoSql.Update);
  FConexao.DataSet.SQL(lSQL).ExecSQL;
  Result := 'Dados alterados com sucesso!';
end;

function TRepositoryBaseCrud<T>.BuscarPorID(aID: integer): T;
begin
  var lSQL := FNotacao.BuildSQL(TTipoSql.Select) + aID.ToString;
  FConexao.DataSet.SQL(lSql).Open;
  if FConexao.DataSet.RecordCount > 0 then
  begin
    Result := T.Create;
    FNotacao.AddObject(Result, T).AddDataSet(FConexao.DataSet.DataSet).ResolveToObject;
  end;
end;

function TRepositoryBaseCrud<T>.Conexao: iConexao;
begin
  Result := FConexao;
end;

constructor TRepositoryBaseCrud<T>.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
end;

function TRepositoryBaseCrud<T>.Deletar(aID: integer): string;
begin
  FConexao.DataSet.SQL(FNotacao.BuildSQL(TTipoSql.Delete) + aID.ToString).ExecSQL;
  Result := 'Registro apagado com sucesso!';
end;

destructor TRepositoryBaseCrud<T>.Destroy;
begin

  inherited;
end;

function TRepositoryBaseCrud<T>.Inserir(aValue: T): string;
begin
  FNotacao.AddObject(aValue, T);
  FConexao.DataSet.SQL(FNotacao.BuildSQL(TTipoSql.Insert)).Open;
  Result := FConexao.DataSet.Fields.FieldByName(FNotacao.GetPKTableName).AsString;
end;

class function TRepositoryBaseCrud<T>.New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryBaseCrud<T>;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

function TRepositoryBaseCrud<T>.Notacao: iNotacao;
begin
  Result := FNotacao;
end;

end.
