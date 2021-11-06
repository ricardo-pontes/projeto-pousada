unit servidor.controller.empresa;

interface

uses
  servidor.controller.base.crud,
  servidor.controller.empresa.interfaces,
  servidor.model.empresa.interfaces,
  System.JSON,
  entidades.empresa;

type
  TControllerEmpresas = class(TControllerBaseCrud<TEmpresa>, iControllerEmpresa)
  private
    FModel : iModelEmpresa;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerEmpresa;

    function Alterar(aBody : string) : string; override;
    function BuscarPorCNPJ(aCNPJ : string) : TJSONObject;
    function Inserir(aBody : string) : string; override;
  end;

implementation

uses
  servidor.model.empresa,
  entidades.empresas.validacoes.basicas,
  servidor.infra.fabricas.repositories;

{ TControllerEmpresas }

function TControllerEmpresas.Alterar(aBody: string): string;
begin
  FModel.Validador.Add(TEmpresaValidacoesBasicas.New);
  FModel.Validador.Add(TEmpresaValidacoesBasicasAlterar.New);
  Result := inherited;
end;

function TControllerEmpresas.BuscarPorCNPJ(aCNPJ: string): TJSONObject;
begin
  Result := Resolve(FModel.BuscarPorCNPJ(aCNPJ));
end;

constructor TControllerEmpresas.Create;
begin
  FModel := TModelEmpresa.New(TRepositories.Empresas);
  inherited Create(FModel);
end;

destructor TControllerEmpresas.Destroy;
begin

  inherited;
end;

function TControllerEmpresas.Inserir(aBody: string): string;
begin
  FModel.Validador.Add(TEmpresaValidacoesBasicas.New);
  FModel.Validador.Add(TEmpresaValidacoesBasicasInserir.New);
  Result := inherited;
end;

class function TControllerEmpresas.New : iControllerEmpresa;
begin
  Result := Self.Create;
end;

end.
