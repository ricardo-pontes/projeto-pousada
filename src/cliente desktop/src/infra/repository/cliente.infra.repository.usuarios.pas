unit cliente.infra.repository.usuarios;

interface

uses
  System.Generics.Collections,
  cliente.infra.repository.usuarios.interfaces,
  entidades.usuario,
  RESTRequest4D;

type
  TRepositoryUsuariosRest = class(TInterfacedObject, iRepositoryUsuarios)
  private
    FConexao : iRequest;
  public
    constructor Create(aConexao : iRequest);
    destructor Destroy; override;
    class function New(aConexao : iRequest) : iRepositoryUsuarios;

    procedure Alterar(aValue : TUsuario);
    procedure Ativar(aID : integer);
    function BuscarPorIDEmpresa(aID : string) : TObjectList<TUsuario>;
    function BuscarPorID(aID : string) : TUsuario;
    procedure Desativar(aID : integer);
    procedure Inserir(aValue : TUsuario);
    function Logar(aEmail, aSenha : string) : TUsuario;
  end;

implementation

{ TRepositoryUsuariosRest }

uses
  System.SysUtils,
  System.Classes,
  shared.json,
  shared.exceptions;

procedure TRepositoryUsuariosRest.Alterar(aValue: TUsuario);
begin
  var lResponse := FConexao.Resource('/empresas/usuarios').ClearBody.AddBody(TJSONConverter.ObjectToJson(aValue)).Put;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

procedure TRepositoryUsuariosRest.Ativar(aID: integer);
begin
  var lResponse := FConexao.Resource('/empresas/usuarios/' + aID.ToString + '/ativar').ClearBody.Post;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

function TRepositoryUsuariosRest.BuscarPorID(aID: string): TUsuario;
begin
  var lResponse := FConexao.Resource('/empresas/usuarios/' + aID).ClearBody.Get;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  Result := TJSONConverter.JsonToObject<TUsuario>(lResponse.Content);
end;

function TRepositoryUsuariosRest.BuscarPorIDEmpresa(aID: string): TObjectList<TUsuario>;
begin
  var lResponse := FConexao.Resource('/empresas/' + aID + '/usuarios').ClearBody.Get;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  Result := TJSONConverter.JsonToObjectList<TUsuario>(lResponse.Content);
end;

constructor TRepositoryUsuariosRest.Create(aConexao : iRequest);
begin
  FConexao := aConexao;
end;

procedure TRepositoryUsuariosRest.Desativar(aID: integer);
begin
  var lResponse := FConexao.Resource('/empresas/usuarios/' + aID.ToString + '/desativar').ClearBody.Post;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

destructor TRepositoryUsuariosRest.Destroy;
begin

  inherited;
end;

procedure TRepositoryUsuariosRest.Inserir(aValue: TUsuario);
begin
  var lResponse := FConexao.Resource('/empresas/usuarios').ClearBody.AddBody(TJSONConverter.ObjectToJson(aValue)).Post;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  aValue.ID := lResponse.Content.ToInteger;
end;

function TRepositoryUsuariosRest.Logar(aEmail, aSenha: string): TUsuario;
begin
  Result := nil;
  var lDados := TStringList.Create;
  try
    lDados.AddPair('email', aEmail);
    lDados.AddPair('senha', aSenha);
    var lResponse := FConexao.Resource('/empresas/usuarios/logar').ClearBody.AddBody(lDados.Text).Post;
    TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
    Result := TJSONConverter.JsonToObject<TUsuario>(lResponse.Content);
  finally
    lDados.DisposeOf;
  end;
end;

class function TRepositoryUsuariosRest.New (aConexao : iRequest) : iRepositoryUsuarios;
begin
  Result := Self.Create(aConexao);
end;

end.
