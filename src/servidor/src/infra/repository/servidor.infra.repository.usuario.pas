unit servidor.infra.repository.usuario;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces,
  entidades.usuario,
  servidor.infra.repository.usuario.interfaces;

type
  TRepositoryUsuarios = class(TRepositoryBaseCrud<TUsuario>, iRepositoryUsuarios)
  private
    FConexao : iConexao;
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryUsuarios;

    function Ativar(aID : integer) : string;
    function BuscarPorIDEmpresa(aIDEmpresa : integer) : TObjectList<TUsuario>;
    function Desativar(aID : integer) : string;
    function Login(aEmail, aSenha : string) : TUsuario;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;

{ TRepositoryUsuarios }

function TRepositoryUsuarios.Ativar(aID: integer): string;
begin
  var lSQL := TStringBuilder.Create;
  try
    lSQL.Append('update ' + USU_TABELA + ' set ' + USU_ATIVO + ' = ' + QuotedStr('S'));
    lSQL.Append(' where ' + USU_ID + ' = ' + aID.ToString);
    FConexao.DataSet.ExecSQL(lSQL.ToString);
  finally
    lSQL.DisposeOf;
  end;
end;

function TRepositoryUsuarios.BuscarPorIDEmpresa(aIDEmpresa: integer): TObjectList<TUsuario>;
begin
  Result := nil;
  FConexao.DataSet.SQL('select * from ' + USU_TABELA + ' where ' + USU_ID_EMPRESA + ' = ' + aIDEmpresa.ToString).Open;
  if FConexao.DataSet.RecordCount > 0 then
  begin
    Result := TObjectList<TUsuario>.Create;
    FNotacao.AddObject(Result, TUsuario).AddDataSet(FConexao.DataSet.DataSet).ResolveToObject;
  end;
end;

constructor TRepositoryUsuarios.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
  inherited Create(FConexao, FNotacao);
end;

function TRepositoryUsuarios.Desativar(aID: integer): string;
begin
  var lSQL := TStringBuilder.Create;
  try
    lSQL.Append('update ' + USU_TABELA + ' set ' + USU_ATIVO + ' = ' + QuotedStr('N'));
    lSQL.Append(' where ' + USU_ID + ' = ' + aID.ToString);
    FConexao.DataSet.ExecSQL(lSQL.ToString);
  finally
    lSQL.DisposeOf;
  end;
end;

destructor TRepositoryUsuarios.Destroy;
begin

  inherited;
end;

function TRepositoryUsuarios.Login(aEmail, aSenha: string): TUsuario;
begin
  Result := nil;
  var lSQL := TStringBuilder.Create;
  try
    lSQL.Append('select * from ' + USU_TABELA);
    lSQL.Append(' where ' + USU_EMAIL + ' = ' + aEmail.QuotedString);
    lSQL.Append(' and ' + USU_SENHA + ' = ' + aSenha.QuotedString);
    FConexao.DataSet.SQL(lSQL.ToString).Open;
    if FConexao.DataSet.RecordCount = 1 then
    begin
      Result := TUsuario.Create;
      FNotacao.AddObject(Result, TUsuario).AddDataSet(FConexao.DataSet.DataSet).ResolveToObject;
    end;
  finally
    lSQL.DisposeOf;
  end;
end;

class function TRepositoryUsuarios.New(aConexao : iConexao; aNotacao : iNotacao): iRepositoryUsuarios;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
