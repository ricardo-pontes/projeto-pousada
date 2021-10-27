unit servidor.controller.estadias.acompanhantes;

interface

uses
  servidor.controller.base.crud,
  servidor.controller.estadias.acompanhantes.interfaces,
  servidor.model.estadias.acompanhantes.interfaces,
  entidades.estadia.acompanhante,
  System.JSON;

type
  TControllerEstadiasAcompanhantes = class(TControllerBaseCrud<TEstadiaAcompanhante>, iControllerEstadiasAcompanhantes)
  private
    FModel : iModelEstadiasAcompanhantes;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerEstadiasAcompanhantes;

    function Alterar(aBody : string) : string; override;
    function BuscarPorIDEstadia(aID : string) : TJSONArray;
    function Inserir(aBody : string) : string; override;
  end;

implementation

uses
  System.SysUtils,
  servidor.infra.conexao,
  conversores.notacoes.factory,
  servidor.model.estadias.acompanhantes,
  servidor.infra.fabricas.repositories,
  servidor.exceptions;

{ TControllerEstadiasAcompanhantes }

function TControllerEstadiasAcompanhantes.Alterar(aBody: string): string;
begin
  Result := inherited;
end;

function TControllerEstadiasAcompanhantes.BuscarPorIDEstadia(aID: string): TJSONArray;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  Result := Resolve(FModel.BuscarPorIDEstadia(lID));
end;

constructor TControllerEstadiasAcompanhantes.Create;
begin
  FModel := TModelEstadiasAcompanhantes.New(TRepositories.EstadiasAcompanhantes);
  inherited Create(FModel);
end;

destructor TControllerEstadiasAcompanhantes.Destroy;
begin

  inherited;
end;

function TControllerEstadiasAcompanhantes.Inserir(aBody: string): string;
begin
  Result := inherited;
end;

class function TControllerEstadiasAcompanhantes.New : iControllerEstadiasAcompanhantes;
begin
  Result := Self.Create;
end;

end.
