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
  System.SysUtils;

procedure TRepositoryProdutosRest.Alterar(aValue: TProduto);
begin
  var lResponse := FConexao.Resource('/empresa/produtos').AddBody(TJSONConverter.ObjectToJson(aValue)).Put;
  if lResponse.StatusCode <> 204 then
    raise Exception.Create(lResponse.Content);
end;

function TRepositoryProdutosRest.BuscarPorID(aID: string): TProduto;
begin
  var lResponse := FConexao.Resource('/empresa/produtos/' + aID).Get;
  if lResponse.StatusCode <> 200 then
    raise Exception.Create(lResponse.Content);

  Result := TJSONConverter.JsonToObject<TProduto>(lResponse.Content);
end;

function TRepositoryProdutosRest.BuscarPorIDEmpresa(aID: string): TObjectList<TProduto>;
begin
  var lResponse := FConexao.Resource('/empresa/' + aID + '/produtos').Get;
  if lResponse.StatusCode <> 200 then
    raise Exception.Create(lResponse.Content);

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
  if lResponse.StatusCode <> 201 then
    raise Exception.Create(lResponse.Content);
end;

class function TRepositoryProdutosRest.New (aConexao : iRequest) : iRepositoryProdutos;
begin
  Result := Self.Create(aConexao);
end;

end.
