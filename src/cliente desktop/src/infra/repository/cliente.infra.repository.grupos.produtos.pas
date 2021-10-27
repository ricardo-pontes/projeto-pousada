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
  end;

implementation

uses
  System.SysUtils, shared.json;

{ TRepositoryGrupoProdutos }

procedure TRepositoryGrupoProdutos.Alterar(aValue: TGrupoProduto);
begin
  var lResponse := FConexao.Resource('/empresa/gruposprodutos').AddBody(TJSONConverter.ObjectToJson(aValue)).Put;
  if lResponse.StatusCode <> 204 then
    raise Exception.Create(lResponse.Content);
end;

function TRepositoryGrupoProdutos.BuscarPorID(aID: string): TGrupoProduto;
begin
  var lResponse := FConexao.Resource('/empresa/gruposprodutos/' + aID).Get;
  if lResponse.StatusCode <> 200 then
    raise Exception.Create(lResponse.Content);

  Result := TJSONConverter.JsonToObject<TGrupoProduto>(lResponse.Content);
end;

function TRepositoryGrupoProdutos.BuscarPorIDEmpresa(aID: string): TObjectList<TGrupoProduto>;
begin
  var lResponse := FConexao.Resource('/empresa/' + aID + '/gruposprodutos').Get;
  if lResponse.StatusCode <> 200 then
    raise Exception.Create(lResponse.Content);

  Result := TJSONConverter.JsonToObjectList<TGrupoProduto>(lResponse.Content);
end;

constructor TRepositoryGrupoProdutos.Create(aConexao : iRequest);
begin
  FConexao := aConexao;
end;

destructor TRepositoryGrupoProdutos.Destroy;
begin

  inherited;
end;

procedure TRepositoryGrupoProdutos.Inserir(aValue: TGrupoProduto);
begin
  var lResponse := FConexao.Resource('/empresa/gruposprodutos').AddBody(TJSONConverter.ObjectToJson(aValue)).Post;
  if lResponse.StatusCode <> 201 then
    raise Exception.Create(lResponse.Content);
end;

class function TRepositoryGrupoProdutos.New (aConexao : iRequest) : iRepositoryGrupoProdutos;
begin
  Result := Self.Create(aConexao);
end;

end.
