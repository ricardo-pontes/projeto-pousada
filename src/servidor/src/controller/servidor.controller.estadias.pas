unit servidor.controller.estadias;

interface

uses
  servidor.controller.base.crud,
  servidor.controller.estadias.interfaces,
  System.JSON,
  servidor.model.estadias.interfaces,
  entidades.estadia;

type
  TControllerEstadias = class(TControllerBaseCrud<TEstadia>, iControllerEstadias)
  private
    FModel : iModelEstadias;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerEstadias;

    function Alterar(aBody : string) : string; override;
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
    function Inserir(aBody : string) : string; override;
  end;

implementation

uses
  System.SysUtils,
  servidor.exceptions,
  servidor.infra.repository.estadias,
  servidor.model.estadias,
  entidades.estadia.validacoes.basicas,
  servidor.infra.fabricas.repositories;

{ TControllerEstadias }

function TControllerEstadias.Alterar(aBody: string): string;
begin
  FModel.Validador.Add(TEstadiaValidacoesBasicas.New);
  FModel.Validador.Add(TEstadiaValidacoesBasicasAlterar.New);
  Result := inherited;
end;

function TControllerEstadias.BuscarPorIDEmpresa(aID: string): TJSONArray;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  Result := Resolve(FModel.BuscarPorIDEmpresa(lID));
end;

constructor TControllerEstadias.Create;
begin
  FModel := TModelEstadias.New(TRepositories.Estadias);
  inherited Create(FModel);
end;

destructor TControllerEstadias.Destroy;
begin

  inherited;
end;

function TControllerEstadias.Inserir(aBody: string): string;
begin
  FModel.Validador.Add(TEstadiaValidacoesBasicas.New);
  FModel.Validador.Add(TEstadiaValidacoesBasicasInserir.New);
  Result := inherited;
end;

class function TControllerEstadias.New : iControllerEstadias;
begin
  Result := Self.Create;
end;

end.
