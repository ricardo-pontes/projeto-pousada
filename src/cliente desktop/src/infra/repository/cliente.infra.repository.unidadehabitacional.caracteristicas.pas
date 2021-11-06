unit cliente.infra.repository.unidadehabitacional.caracteristicas;

interface

uses
  cliente.infra.repository.unidadehabitacional.caracteristicas.interfaces,
  entidades.unidadehabitacional.caracteristicas,
  System.Generics.Collections,
  RestRequest4D;

type
  TRepositoryUnidadeHabitacionalCaracteristicasRest = class(TInterfacedObject, iRepositoryUnidadeHabitacionalCaracteristicas)
  private
    FConexao : iRequest;
  public
    constructor Create(aConexao : iRequest);
    destructor Destroy; override;
    class function New(aConexao : iRequest) : iRepositoryUnidadeHabitacionalCaracteristicas;

    procedure Alterar(aValue : TUnidadeHabitacionalCaracteristica);
    function BuscarPorID(aID : string) : TUnidadeHabitacionalCaracteristica;
    function BuscarPorIDUnidadeHabitacional(aID : string) : TObjectList<TUnidadeHabitacionalCaracteristica>;
    procedure Inserir(aValue : TUnidadeHabitacionalCaracteristica);
  end;

implementation

{ TRepositoryUnidadeHabitacionalCaracteristicasRest }

uses
  shared.json,
  shared.exceptions,
  System.SysUtils;

procedure TRepositoryUnidadeHabitacionalCaracteristicasRest.Alterar(aValue: TUnidadeHabitacionalCaracteristica);
begin
  var lResponse := FConexao.Resource('/empresas/unidadeshabitacionais/caracteristicas').AddBody(TJSONConverter.ObjectToJson(aValue)).Put;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

function TRepositoryUnidadeHabitacionalCaracteristicasRest.BuscarPorID(aID: string): TUnidadeHabitacionalCaracteristica;
begin
  var lResponse := FConexao.Resource('/empresas/unidadeshabitacionais/caracteristicas/' + aID).Get;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  Result := TJSONConverter.JsonToObject<TUnidadeHabitacionalCaracteristica>(lResponse.Content);
end;

function TRepositoryUnidadeHabitacionalCaracteristicasRest.BuscarPorIDUnidadeHabitacional(aID: string): TObjectList<TUnidadeHabitacionalCaracteristica>;
begin
  var lResponse := FConexao.Resource('/empresas/unidadeshabitacionais/' + aID + '/caracteristicas').Get;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  Result := TJSONConverter.JsonToObjectList<TUnidadeHabitacionalCaracteristica>(lResponse.Content);
end;

constructor TRepositoryUnidadeHabitacionalCaracteristicasRest.Create(aConexao : iRequest);
begin
  FConexao := aConexao;
end;

destructor TRepositoryUnidadeHabitacionalCaracteristicasRest.Destroy;
begin

  inherited;
end;

procedure TRepositoryUnidadeHabitacionalCaracteristicasRest.Inserir(aValue : TUnidadeHabitacionalCaracteristica);
begin
  var lResponse := FConexao.Resource('/empresas/unidadeshabitacionais/caracteristicas').AddBody(TJSONConverter.ObjectToJson(aValue)).Post;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  aValue.ID := lResponse.Content.ToInteger;
end;

class function TRepositoryUnidadeHabitacionalCaracteristicasRest.New (aConexao : iRequest) : iRepositoryUnidadeHabitacionalCaracteristicas;
begin
  Result := Self.Create(aConexao);
end;

end.
