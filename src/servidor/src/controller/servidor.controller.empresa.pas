unit servidor.controller.empresa;

interface

uses
  servidor.controller.base.crud,
  servidor.controller.empresa.interfaces,
  servidor.model.empresa.interfaces,
  System.JSON,
  entidades.empresa;

type
  TControllerEmpresa = class(TControllerBaseCrud<TEmpresa>, iControllerEmpresa)
  private
    FModel : iModelEmpresa;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerEmpresa;

    function Alterar(aBody : string) : string; override;
    function Inserir(aBody : string) : string; override;
  end;

implementation

uses
  servidor.model.empresa,
  entidades.empresas.validacoes.basicas,
  servidor.infra.fabricas.repositories;

{ TControllerEmpresa }

function TControllerEmpresa.Alterar(aBody: string): string;
begin
  FModel.Validador.Add(TEmpresaValidacoesBasicas.New);
  FModel.Validador.Add(TEmpresaValidacoesBasicasAlterar.New);
  Result := inherited;
end;

constructor TControllerEmpresa.Create;
begin
  FModel := TModelEmpresa.New(TRepositories.Empresas);
  inherited Create(FModel);
end;

destructor TControllerEmpresa.Destroy;
begin

  inherited;
end;

function TControllerEmpresa.Inserir(aBody: string): string;
begin
  FModel.Validador.Add(TEmpresaValidacoesBasicas.New);
  FModel.Validador.Add(TEmpresaValidacoesBasicasInserir.New);
  Result := inherited;
end;

class function TControllerEmpresa.New : iControllerEmpresa;
begin
  Result := Self.Create;
end;

end.
