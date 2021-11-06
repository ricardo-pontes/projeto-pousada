unit cliente.infra.repository.caracteristicas;

interface

uses
  cliente.infra.repository.caracteristicas.interfaces,
  entidades.caracteristicas,
  System.Generics.Collections,
  RestRequest4D;

type
  TRepositoryCaracteristicasRest = class(TInterfacedObject, iRepositoryCaracteristicas)
  private
    FConexao : iRequest;
  public
    constructor Create(aConexao : iRequest);
    destructor Destroy; override;
    class function New(aConexao : iRequest) : iRepositoryCaracteristicas;

    procedure Alterar(aValue : TCaracteristica);
    function BuscarPorID(aID : string) : TCaracteristica;
    function BuscarPorIDEmpresa(aID : string) : TObjectList<TCaracteristica>;
    procedure Inserir(aValue : TCaracteristica);
    procedure Ativar(aID : string);
    procedure Desativar(aID : string);
  end;

implementation

{ TRepositoryCaracteristicasRest }

uses
  shared.json,
  shared.exceptions,
  System.SysUtils,
  Rest.HttpClient;

procedure TRepositoryCaracteristicasRest.Alterar(aValue: TCaracteristica);
begin
  var lResponse := FConexao.Resource('/empresas/caracteristicas').ClearBody.AddBody(TJSONConverter.ObjectToJson(aValue)).Put;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

procedure TRepositoryCaracteristicasRest.Ativar(aID: string);
begin
  var lResponse := FConexao.Resource('/empresas/caracteristicas/' + aID + '/ativar').ClearBody.Post;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

function TRepositoryCaracteristicasRest.BuscarPorID(aID: string): TCaracteristica;
begin
  var lResponse := FConexao.Resource('/empresas/caracteristicas/' + aID).ClearBody.Get;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  Result := TJSONConverter.JsonToObject<TCaracteristica>(lResponse.Content);
end;

function TRepositoryCaracteristicasRest.BuscarPorIDEmpresa(aID: string): TObjectList<TCaracteristica>;
begin
  var lResponse := FConexao.Resource('/empresas/' + aID + '/caracteristicas').ClearBody.Get;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  Result := TJSONConverter.JsonToObjectList<TCaracteristica>(lResponse.Content);
end;

constructor TRepositoryCaracteristicasRest.Create(aConexao : iRequest);
begin
  FConexao := aConexao;
end;

procedure TRepositoryCaracteristicasRest.Desativar(aID: string);
begin
  var lResponse := FConexao.Resource('/empresas/caracteristicas/' + aID + '/desativar').ClearBody.Post;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

destructor TRepositoryCaracteristicasRest.Destroy;
begin

  inherited;
end;

procedure TRepositoryCaracteristicasRest.Inserir(aValue : TCaracteristica);
begin
  var lResponse := FConexao.Resource('/empresas/caracteristicas').ClearBody.AddBody(TJSONConverter.ObjectToJson(aValue)).Post;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  aValue.ID := lResponse.Content.ToInteger;
end;

class function TRepositoryCaracteristicasRest.New (aConexao : iRequest) : iRepositoryCaracteristicas;
begin
  Result := Self.Create(aConexao);
end;

end.
