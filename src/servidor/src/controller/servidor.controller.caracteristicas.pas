unit servidor.controller.caracteristicas;

interface

uses
  servidor.controller.base.crud,
  entidades.caracteristicas,
  System.JSON,
  servidor.controller.caracteristicas.interfaces,
  servidor.model.caracteristicas.interfaces;

type
  TControllerCaracteristicas = class(TControllerBaseCrud<TCaracteristica>, iControllerCaracteristicas)
  private
    FModel : iModelCaracteristicas;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerCaracteristicas;

    function Alterar(aBody : string) : string; override;
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
    function Inserir(aBody : string) : string; override;
    function Ativar(aID : string) : string;
    function Desativar(aID : string) : string;

  end;

implementation

uses
  System.SysUtils,
  shared.exceptions,
  servidor.model.caracteristicas,
  servidor.infra.fabricas.repositories,
  entidades.caracteristicas.validacoes.db,
  entidades.caracteristicas.validacoes.basicas;

{ TControllerCaracteristicas }

function TControllerCaracteristicas.Alterar(aBody: string): string;
begin
  FModel.Validador.Clear;
  FModel.Validador.Add(TCaracteristicasValidacoesBasicas.New);
  FModel.Validador.Add(TCaracteristicasValidacoesBasicasAlterar.New);
  FModel.Validador.Add(TCaracteristicasValidacoesDB.New(FModel.Conexao, FModel.Notacao));
  Result := inherited;
end;

function TControllerCaracteristicas.Ativar(aID: string): string;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  Result := FModel.Ativar(lID);
end;

function TControllerCaracteristicas.BuscarPorIDEmpresa(aID: string): TJSONArray;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  Result := Resolve(FModel.BuscarPorIDEmpresa(lID));
end;

constructor TControllerCaracteristicas.Create;
begin
  FModel := TModelCaracteristicas.New(TRepositories.Caracteristicas);
  inherited Create(FModel);
end;

function TControllerCaracteristicas.Desativar(aID: string): string;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  Result := FModel.Desativar(lID);
end;

destructor TControllerCaracteristicas.Destroy;
begin

  inherited;
end;

function TControllerCaracteristicas.Inserir(aBody: string): string;
begin
  FModel.Validador.Clear;
  FModel.Validador.Add(TCaracteristicasValidacoesBasicas.New);
  FModel.Validador.Add(TCaracteristicasValidacoesBasicasInserir.New);
  FModel.Validador.Add(TCaracteristicasValidacoesDB.New(FModel.Conexao, FModel.Notacao));
  Result := inherited;
end;

class function TControllerCaracteristicas.New : iControllerCaracteristicas;
begin
  Result := Self.Create;
end;

end.
