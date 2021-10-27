unit servidor.controller.unidadehabitacional;

interface

uses
  entidades.unidadehabitacional,
  servidor.controller.base.crud,
  servidor.controller.unidadehabitacional.interfaces,
  servidor.model.unidadehabitacional.interfaces,
  System.JSON;

type
  TControllerUnidadeHabitacional = class(TControllerBaseCrud<TUnidadeHabitacional>, iControllerUnidadeHabitacional)
  private
    FModel : iModelUnidadeHabitacional;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerUnidadeHabitacional;
    function Alterar(aBody : string) : string; override;
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
    function Inserir(aBody : string) : string; override;
  end;

implementation

{ TControllerUnidadeHabitacional }

uses
  System.SysUtils,
  servidor.exceptions,
  servidor.model.unidadehabitacional,
  entidades.unidadehabitacional.validacoes.base.alterar,
  entidades.unidadehabitacional.validacoes.base.inserir,
  entidades.unidadehabitacional.validacoes.base,
  servidor.infra.fabricas.repositories;

function TControllerUnidadeHabitacional.Alterar(aBody: string): string;
begin
  FModel.Validador.Add(TUnidadeHabitacionalValidacaoBase.New);
  FModel.Validador.Add(TUnidadeHabitacionalValidacaoBaseAlterar.New);
  inherited;
end;

function TControllerUnidadeHabitacional.BuscarPorIDEmpresa(aID: string): TJSONArray;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  Result := Resolve(FModel.BuscarPorIDEmpresa(lID));
end;

constructor TControllerUnidadeHabitacional.Create;
begin
  FModel := TModelUnidadeHabitacional.New(TRepositories.UnidadeHabitacional);
  inherited Create(FModel);
end;

destructor TControllerUnidadeHabitacional.Destroy;
begin

  inherited;
end;

function TControllerUnidadeHabitacional.Inserir(aBody: string): string;
begin
  FModel.Validador.Add(TUnidadeHabitacionalValidacaoBase.New);
  FModel.Validador.Add(TUnidadeHabitacionalValidacaoBaseInserir.New);
  inherited;
end;

class function TControllerUnidadeHabitacional.New : iControllerUnidadeHabitacional;
begin
  Result := Self.Create;
end;

end.
