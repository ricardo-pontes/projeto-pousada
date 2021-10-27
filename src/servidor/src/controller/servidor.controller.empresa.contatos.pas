unit servidor.controller.empresa.contatos;

interface

uses
  servidor.controller.base.crud,
  servidor.model.empresa.contatos.interfaces,
  System.JSON, entidades.empresa.contatos,
  servidor.controller.empresa.contatos.interfaces;

type
  TControllerEmpresaContatos = class(TControllerBaseCrud<TEmpresaContato>, iControllerEmpresaContatos)
  private
    FModel : iModelEmpresaContatos;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerEmpresaContatos;

    function Alterar(aBody : string) : string; override;
    function Inserir(aBody : string) : string; override;
  end;

implementation

uses
  servidor.model.empresa.contatos,
  servidor.infra.fabricas.repositories;

{ TControllerEmpresaContatos }

function TControllerEmpresaContatos.Alterar(aBody: string): string;
begin
  inherited;
end;

constructor TControllerEmpresaContatos.Create;
begin
  FModel := TModelEmpresaContatos.New(TRepositories.EmpresaContatos);
  inherited Create(FModel);
end;

destructor TControllerEmpresaContatos.Destroy;
begin

  inherited;
end;

function TControllerEmpresaContatos.Inserir(aBody: string): string;
begin
  inherited;
end;

class function TControllerEmpresaContatos.New : iControllerEmpresaContatos;
begin
  Result := Self.Create;
end;

end.
