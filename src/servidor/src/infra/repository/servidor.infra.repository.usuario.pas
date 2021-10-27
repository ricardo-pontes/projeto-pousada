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

    function BuscarPorIDEmpresa(aIDEmpresa : integer) : TObjectList<TUsuario>;
    function Login(aEmail, aSenha : string) : TUsuario;
  end;

implementation

uses
  System.SysUtils,
  servidor.exceptions;

{ TRepositoryUsuarios }

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
    lSQL.Append(' where ' + USU_EMAIL + ' = ' + aEmail);
    lSQL.Append(' and ' + USU_SENHA + ' = ' + aSenha);
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
