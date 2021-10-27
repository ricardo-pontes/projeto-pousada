unit servidor.controller.clientes;

interface

uses
  servidor.controller.base.crud,
  servidor.model.clientes.interfaces,
  System.JSON,
  servidor.controller.clientes.interfaces,
  entidades.clientes;

type
  TControllerClientes = class(TControllerBaseCrud<TClientePF>, iControllerClientes)
  private
    FModel : iModelClientes;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerClientes;

    function Alterar(aBody : string) : string; override;
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
    function Inserir(aBody : string) : string; override;
  end;

implementation

uses
  System.SysUtils,
  servidor.model.clientes,
  servidor.exceptions,
  entidades.clientes.validacoes.basicas,
  servidor.infra.fabricas.repositories;

{ TControllerClientes }

function TControllerClientes.Alterar(aBody: string): string;
begin
  FModel.Validador.Add(TClientesValidacoesBasicas.New);
  FModel.Validador.Add(TClientesValidacoesBasicasAlterar.New);
  Result := inherited;
end;

function TControllerClientes.BuscarPorIDEmpresa(aID: string): TJSONArray;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  Result := Resolve(FModel.BuscarPorIDEmpresa(lID));
end;

constructor TControllerClientes.Create;
begin
  FModel := TModelClientes.New(TRepositories.Clientes);
  inherited Create(FModel);
end;

destructor TControllerClientes.Destroy;
begin

  inherited;
end;

function TControllerClientes.Inserir(aBody: string): string;
begin
  FModel.Validador.Add(TClientesValidacoesBasicas.New);
  FModel.Validador.Add(TClientesValidacoesBasicasInserir.New);
  Result := inherited;
end;

class function TControllerClientes.New : iControllerClientes;
begin
  Result := Self.Create;
end;

end.
