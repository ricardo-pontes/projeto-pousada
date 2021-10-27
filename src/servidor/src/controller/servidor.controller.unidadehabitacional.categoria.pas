unit servidor.controller.unidadehabitacional.categoria;

interface

uses
  System.JSON,
  servidor.controller.base.crud,
  entidades.unidadehabitacional.categoria,
  servidor.controller.unidadehabitacional.categoria.interfaces,
  servidor.model.unidadehabitacional.categoria.interfaces;

type
  TControllerUnidadeHabitacionalCategoria = class(TControllerBaseCrud<TUnidadeHabitacionalCategoria>, iControllerUnidadeHabitacionalCategoria)
  private
    FModel : iModelUnidadeHabitacionalCategoria;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerUnidadeHabitacionalCategoria;

    function Alterar(aBody : string) : string; override;
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
    function Inserir(aBody : string) : string; override;
  end;

implementation

{ TControllerUnidadeHabitacionalCategoria }

uses
  System.SysUtils,
  servidor.model.unidadehabitacional.categoria,
  entidades.unidadehabitacional.categoria.validacoes.base.alterar,
  entidades.unidadehabitacional.categoria.validacoes.base.inserir,
  entidades.unidadehabitacional.categoria.validacoes.base,
  servidor.exceptions,
  servidor.infra.fabricas.repositories;

function TControllerUnidadeHabitacionalCategoria.Alterar(aBody: string): string;
begin
  FModel.Validador.Add(TUnidadeHabitacionalCategoriaValidacaoBase.New);
  FModel.Validador.Add(TUnidadeHabitacionalCategoriaValidacaoBaseAlterar.New);
  inherited;
end;

function TControllerUnidadeHabitacionalCategoria.BuscarPorIDEmpresa(aID: string): TJSONArray;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  Result := Resolve(FModel.BuscarPorIDEmpresa(lID));
end;

constructor TControllerUnidadeHabitacionalCategoria.Create;
begin
  FModel := TModelUnidadeHabitacionalCategoria.New(TRepositories.UnidadeHabitacionalCategoria);
  inherited Create(FModel);
end;

destructor TControllerUnidadeHabitacionalCategoria.Destroy;
begin

  inherited;
end;

function TControllerUnidadeHabitacionalCategoria.Inserir(aBody: string): string;
begin
  inherited;
end;

class function TControllerUnidadeHabitacionalCategoria.New : iControllerUnidadeHabitacionalCategoria;
begin
  Result := Self.Create;
end;

end.
