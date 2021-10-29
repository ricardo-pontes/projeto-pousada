unit cliente.infra.repository.produtos;

interface

uses
  cliente.infra.repository.produtos.interfaces,
  entidades.produtos,
  System.Generics.Collections,
  RestRequest4D;

type
  TRepositoryProdutosRest = class(TInterfacedObject, iRepositoryProdutos)
  private
    FConexao : iRequest;
  public
    constructor Create(aConexao : iRequest);
    destructor Destroy; override;
    class function New(aConexao : iRequest) : iRepositoryProdutos;

    procedure Alterar(aValue : TProduto);
    function BuscarPorID(aID : string) : TProduto;
    function BuscarPorIDEmpresa(aID : string) : TObjectList<TProduto>;
    procedure Inserir(aValue : TProduto);
  end;

implementation

{ TRepositoryProdutosRest }

uses
  shared.json,
  shared.exceptions,
  System.SysUtils;

procedure TRepositoryProdutosRest.Alterar(aValue: TProduto);
begin
  var lResponse := FConexao.Resource('/empresa/produtos').AddBody(TJSONConverter.ObjectToJson(aValue)).Put;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

function TRepositoryProdutosRest.BuscarPorID(aID: string): TProduto;
begin
  var lResponse := FConexao.Resource('/empresa/produtos/' + aID).Get;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  Result := TJSONConverter.JsonToObject<TProduto>(lResponse.Content);
end;

function TRepositoryProdutosRest.BuscarPorIDEmpresa(aID: string): TObjectList<TProduto>;
begin
  var lResponse := FConexao.Resource('/empresa/' + aID + '/produtos').Get;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  Result := TJSONConverter.JsonToObjectList<TProduto>(lResponse.Content);
end;

constructor TRepositoryProdutosRest.Create(aConexao : iRequest);
begin
  FConexao := aConexao;
end;

destructor TRepositoryProdutosRest.Destroy;
begin

  inherited;
end;

procedure TRepositoryProdutosRest.Inserir(aValue : TProduto);
begin
  var lResponse := FConexao.Resource('/empresa/produtos').AddBody(TJSONConverter.ObjectToJson(aValue)).Post;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  aValue.ID := lResponse.Content.ToInteger;
end;

class function TRepositoryProdutosRest.New (aConexao : iRequest) : iRepositoryProdutos;
begin
  Result := Self.Create(aConexao);
end;

end.
