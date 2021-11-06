unit servidor.controller.grupoprodutos;

interface

uses
  servidor.controller.base.crud,
  servidor.controller.grupoprodutos.interfaces,
  System.JSON, servidor.model.grupoprodutos.interfaces,
  entidades.grupoprodutos;

type
  TControllerGrupoProdutos = class(TControllerBaseCrud<TGrupoProduto>, iControllerGrupoProdutos)
  private
    FModel : iModelGrupoProdutos;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerGrupoProdutos;

    function Alterar(aBody : string) : string; override;
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
    function Inserir(aBody : string) : string; override;
    function Ativar(aID : string) : string;
    function Desativar(aID : string) : string;
  end;

implementation

uses
  System.SysUtils,
  servidor.model.grupoprodutos,
  servidor.infra.fabricas.repositories,
  entidades.grupos.produtos.validacoes.basicas;

{ TControllerGrupoProdutos }

function TControllerGrupoProdutos.Alterar(aBody: string): string;
begin
  FModel.Validador.Clear;
  FModel.Validador.Add(TGrupoProdutosValidacoesBasicas.New);
  FModel.Validador.Add(TGrupoProdutosValidacoesBasicasAlterar.New);
  inherited;
end;

function TControllerGrupoProdutos.Ativar(aID: string): string;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise Exception.Create('S� s�o aceitos n�meros no par�metro.');

  Result := FModel.Ativar(lID);
end;

function TControllerGrupoProdutos.BuscarPorIDEmpresa(aID: string): TJSONArray;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise Exception.Create('S� s�o aceitos n�meros no par�metro.');

  Result := Resolve(FModel.BuscarPorIDEmpresa(lID));
end;

constructor TControllerGrupoProdutos.Create;
begin
  FModel := TModelGrupoProdutos.New(TRepositories.GrupoProdutos);
  inherited Create(FModel);
end;

function TControllerGrupoProdutos.Desativar(aID: string): string;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise Exception.Create('S� s�o aceitos n�meros no par�metro.');

  Result := FModel.Desativar(lID);
end;

destructor TControllerGrupoProdutos.Destroy;
begin

  inherited;
end;

function TControllerGrupoProdutos.Inserir(aBody: string): string;
begin
  FModel.Validador.Clear;
  FModel.Validador.Add(TGrupoProdutosValidacoesBasicas.New);
  FModel.Validador.Add(TGrupoProdutosValidacoesBasicasInserir.New);
  Result := inherited;
end;

class function TControllerGrupoProdutos.New : iControllerGrupoProdutos;
begin
  Result := Self.Create;
end;

end.
