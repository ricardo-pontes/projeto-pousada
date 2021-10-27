unit servidor.controller.unidadehabitacional.caracteristicas;

interface

uses
  System.JSON,
  servidor.model.unidadehabitacional.caracteristicas.interfaces,
  servidor.controller.base.crud,
  entidades.unidadehabitacional.caracteristicas,
  servidor.controller.unidadehabitacional.caracteristicas.interfaces;

type
  TControllerUnidadeHabitacionalCaracteristicas = class(TControllerBaseCrud<TUnidadeHabitacionalCaracteristica>, iControllerUnidadeHabitacionalCaracteristicas)
  private
    FModel : iModelUnidadeHabitacionalCaracteristicas;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerUnidadeHabitacionalCaracteristicas;

    function Alterar(aBody : string) : string; override;
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
    function Inserir(aBody : string) : string; override;
  end;

implementation

uses
  System.SysUtils,
  servidor.model.unidadehabitacional.caracteristicas,
  entidades.unidadehabitacional.caracteristicas.validacoes.basicas,
  servidor.exceptions, servidor.infra.fabricas.repositories;

{ TControllerUnidadeHabitacionalCaracteristicas }

function TControllerUnidadeHabitacionalCaracteristicas.Alterar(aBody: string): string;
begin
  FModel.Validador.Add(TUnidadeHabitacionalCaracteristicasValidacoesBasicas.New);
  FModel.Validador.Add(TUnidadeHabitacionalCaracteristicasValidacoesBasicasAlterar.New);
  Result := inherited;
end;

function TControllerUnidadeHabitacionalCaracteristicas.BuscarPorIDEmpresa(aID: string): TJSONArray;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  Result := Resolve(FModel.BuscarPorIDEmpresa(lID));
end;

constructor TControllerUnidadeHabitacionalCaracteristicas.Create;
begin
  FModel := TModelUnidadeHabitacionalCaracteristicas.New(TRepositories.UnidadeHabitacionalCaracteristicas);
  inherited Create(FModel);
end;

destructor TControllerUnidadeHabitacionalCaracteristicas.Destroy;
begin

  inherited;
end;

function TControllerUnidadeHabitacionalCaracteristicas.Inserir(aBody: string): string;
begin
  FModel.Validador.Add(TUnidadeHabitacionalCaracteristicasValidacoesBasicas.New);
  FModel.Validador.Add(TUnidadeHabitacionalCaracteristicasValidacoesBasicasInserir.New);
  Result := inherited;
end;

class function TControllerUnidadeHabitacionalCaracteristicas.New : iControllerUnidadeHabitacionalCaracteristicas;
begin
  Result := Self.Create;
end;

end.
