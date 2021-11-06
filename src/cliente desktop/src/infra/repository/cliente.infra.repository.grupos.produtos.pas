unit cliente.infra.repository.grupos.produtos;

interface

uses
  System.Generics.Collections,
  entidades.grupoprodutos,
  cliente.infra.repository.grupos.produtos.interfaces,
  RestRequest4D;

type
  TRepositoryGrupoProdutos = class(TInterfacedObject, iRepositoryGrupoProdutos)
  private
    FConexao : iRequest;
  public
    constructor Create(aConexao : iRequest);
    destructor Destroy; override;
    class function New(aConexao : iRequest) : iRepositoryGrupoProdutos;

    procedure Alterar(aValue : TGrupoProduto);
    function BuscarPorID(aID : string) : TGrupoProduto;
    procedure Inserir(aValue : TGrupoProduto);
    function BuscarPorIDEmpresa(aID : string) : TObjectList<TGrupoProduto>;
    procedure Ativar(aID : string);
    procedure Desativar(aID : string);
  end;

implementation

uses
  System.SysUtils,
  shared.json,
  shared.exceptions;

{ TRepositoryGrupoProdutos }

procedure TRepositoryGrupoProdutos.Alterar(aValue: TGrupoProduto);
begin
  var lResponse := FConexao.Resource('/empresa/gruposprodutos').AddBody(TJSONConverter.ObjectToJson(aValue)).Put;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

procedure TRepositoryGrupoProdutos.Ativar(aID: string);
begin
  var lResponse := FConexao.Resource('/empresa/gruposprodutos/' + aID + '/ativar').Post;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

function TRepositoryGrupoProdutos.BuscarPorID(aID: string): TGrupoProduto;
begin
  var lResponse := FConexao.Resource('/empresa/gruposprodutos/' + aID).Get;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  Result := TJSONConverter.JsonToObject<TGrupoProduto>(lResponse.Content);
end;

function TRepositoryGrupoProdutos.BuscarPorIDEmpresa(aID: string): TObjectList<TGrupoProduto>;
begin
  var lResponse := FConexao.Resource('/empresa/' + aID + '/gruposprodutos').Get;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  Result := TJSONConverter.JsonToObjectList<TGrupoProduto>(lResponse.Content);
end;

constructor TRepositoryGrupoProdutos.Create(aConexao : iRequest);
begin
  FConexao := aConexao;
end;

procedure TRepositoryGrupoProdutos.Desativar(aID: string);
begin
  var lResponse := FConexao.Resource('/empresa/gruposprodutos/' + aID + '/desativar').Post;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

destructor TRepositoryGrupoProdutos.Destroy;
begin

  inherited;
end;

procedure TRepositoryGrupoProdutos.Inserir(aValue: TGrupoProduto);
begin
  var lResponse := FConexao.Resource('/empresa/gruposprodutos').AddBody(TJSONConverter.ObjectToJson(aValue)).Post;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  aValue.ID := lResponse.Content.ToInteger;
end;

class function TRepositoryGrupoProdutos.New (aConexao : iRequest) : iRepositoryGrupoProdutos;
begin
  Result := Self.Create(aConexao);
end;

end.
