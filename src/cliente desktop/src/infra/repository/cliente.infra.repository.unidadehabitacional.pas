unit cliente.infra.repository.unidadehabitacional;

interface

uses
  System.Generics.Collections,
  cliente.infra.repository.unidadehabitacional.interfaces,
  entidades.unidadehabitacional,
  RESTRequest4D;

type
  TRepositoryUnidadeHabitacionalRest = class(TInterfacedObject, iRepositoryUnidadesHabitacionais)
  private
    FConexao : iRequest;
  public
    constructor Create(aConexao : iRequest);
    destructor Destroy; override;
    class function New(aConexao : iRequest) : iRepositoryUnidadesHabitacionais;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacional>;
    procedure Alterar(aValue : TUnidadeHabitacional);
    function BuscarPorID(aID : string) : TUnidadeHabitacional;
    procedure Inserir(aValue : TUnidadeHabitacional);
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions,
  shared.json;

{ TRepositoryUnidadeHabitacionalRest }

procedure TRepositoryUnidadeHabitacionalRest.Alterar(aValue: TUnidadeHabitacional);
begin
  var lResponse := FConexao.Resource('/empresas/unidadeshabitacionais').ClearBody.AddBody(aValue).Put;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

function TRepositoryUnidadeHabitacionalRest.BuscarPorID(aID: string): TUnidadeHabitacional;
begin
  var lResponse := FConexao.Resource('/empresas/unidadeshabitacionais/' + aID).ClearBody.Get;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  Result := TJSONConverter.JsonToObject<TUnidadeHabitacional>(lResponse.Content);
end;

function TRepositoryUnidadeHabitacionalRest.BuscarPorIDEmpresa(aID: integer): TObjectList<TUnidadeHabitacional>;
begin
  var lResponse := FConexao.Resource('/empresas/' + aID.ToString + '/unidadeshabitacionais').ClearBody.Get;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  Result := TJSONConverter.JsonToObjectList<TUnidadeHabitacional>(lResponse.Content);
end;

constructor TRepositoryUnidadeHabitacionalRest.Create(aConexao : iRequest);
begin
  FConexao := aConexao;
end;

destructor TRepositoryUnidadeHabitacionalRest.Destroy;
begin

  inherited;
end;

procedure TRepositoryUnidadeHabitacionalRest.Inserir(aValue: TUnidadeHabitacional);
begin
  var lResponse := FConexao.Resource('/empresas/unidadeshabitacionais').ClearBody.AddBody(aValue).Post;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

class function TRepositoryUnidadeHabitacionalRest.New (aConexao : iRequest) : iRepositoryUnidadesHabitacionais;
begin
  Result := Self.Create(aConexao);
end;

end.
