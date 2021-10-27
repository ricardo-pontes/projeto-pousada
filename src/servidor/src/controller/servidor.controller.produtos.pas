unit servidor.controller.produtos;

interface

uses
  System.JSON,
  entidades.produtos,
  servidor.controller.base.crud,
  servidor.controller.produtos.interfaces,
  servidor.model.produtos;

type
  TControllerProdutos = class(TControllerBaseCrud<TProduto>, iControllerProdutos)
  private
    FModel : TModelProdutos;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerProdutos;

    function Alterar(aBody : string) : string; override;
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
    function Inserir(aBody : string) : string; override;
  end;

implementation

{ TControllerProdutos }

uses
  System.SysUtils,
  shared.json,
  entidades.produtos.validacoes.basicas,
  entidades.produtos.validacoes.db,
  servidor.exceptions,
  servidor.infra.fabricas.repositories;

function TControllerProdutos.Alterar(aBody: string): string;
begin
  FModel.Validador.Clear;
  FModel.Validador.Add(TProdutosValidacoesBasicas.New);
  FModel.Validador.Add(TProdutosValidacoesBasicasAlterar.New);
  FModel.Validador.Add(TProdutosValidacoesDB.New(FModel.Conexao, FModel.Notacao));
  inherited;
end;

function TControllerProdutos.BuscarPorIDEmpresa(aID: string): TJSONArray;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  Result :=  TJSONConverter.ObjectListToJson<TProduto>(FModel.BuscarPorIDEmpresa(lID));
end;

constructor TControllerProdutos.Create;
begin
  FModel := TModelProdutos.Create(TRepositories.Produtos);
  inherited Create(FModel);
end;

destructor TControllerProdutos.Destroy;
begin
  inherited;
end;

function TControllerProdutos.Inserir(aBody: string): string;
begin
  FModel.Validador.Clear;
  FModel.Validador.Add(TProdutosValidacoesBasicas.New);
  FModel.Validador.Add(TProdutosValidacoesBasicasInserir.New);
  FModel.Validador.Add(TProdutosValidacoesDB.New(FModel.Conexao, FModel.Notacao));
  Result := inherited;
end;

class function TControllerProdutos.New: iControllerProdutos;
begin
  Result := Self.Create;
end;

end.
