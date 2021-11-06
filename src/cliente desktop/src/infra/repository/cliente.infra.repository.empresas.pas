unit cliente.infra.repository.empresas;

interface

uses
  cliente.infra.repository.empresas.interfaces,
  entidades.empresa,
  RESTRequest4D;

type
  TRepositoryEmpresas = class(TInterfacedObject, iRepositoryEmpresas)
  private
    FConexao : iRequest;
  public
    constructor Create(aConexao : iRequest);
    destructor Destroy; override;
    class function New(aConexao : iRequest) : iRepositoryEmpresas;

    procedure Alterar(aEmpresa : TEmpresa);
    function BuscarPorID(aID : integer) : TEmpresa;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions,
  shared.json;

{ TRepositoryEmpresas }

procedure TRepositoryEmpresas.Alterar(aEmpresa: TEmpresa);
begin
  var lResponse := FConexao.Resource('/empresas').ClearBody.AddBody(TJSONConverter.ObjectToJson(aEmpresa)).Put;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
end;

function TRepositoryEmpresas.BuscarPorID(aID: integer): TEmpresa;
begin
  var lResponse := FConexao.Resource('/empresas/' + aID.ToString).Get;
  TSharedExceptionsRest.Checar(lResponse.StatusCode, lResponse.Content);
  Result := TJSONConverter.JsonToObject<TEmpresa>(lResponse.Content);
end;

constructor TRepositoryEmpresas.Create(aConexao : iRequest);
begin
  FConexao := aConexao;
end;

destructor TRepositoryEmpresas.Destroy;
begin

  inherited;
end;

class function TRepositoryEmpresas.New (aConexao : iRequest) : iRepositoryEmpresas;
begin
  Result := Self.Create(aConexao);
end;

end.
