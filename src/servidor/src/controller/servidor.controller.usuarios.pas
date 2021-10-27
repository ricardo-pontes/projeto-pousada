unit servidor.controller.usuarios;

interface

uses
  servidor.controller.base.crud,
  servidor.controller.usuarios.interfaces,
  System.JSON,
  entidades.usuario,
  servidor.model.usuarios.interfaces;

type
  TControllerUsuarios = class(TControllerBaseCrud<TUsuario>, iControllerUsuarios)
  private
    FModel : iModelUsuarios;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iControllerUsuarios;

    function Alterar(aBody : string) : string; override;
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
    function Inserir(aBody : string) : string; override;
  end;

implementation

uses
  System.SysUtils,
  servidor.model.usuarios,
  servidor.infra.fabricas.repositories;

{ TControllerUsuarios }

function TControllerUsuarios.Alterar(aBody: string): string;
begin
  inherited;
end;

function TControllerUsuarios.BuscarPorIDEmpresa(aID: string): TJSONArray;
begin
 var lID := 0;
 if not TryStrToInt(aID, lID) then
   raise Exception.Create('Só são aceitos números no parâmetro ID.');

  Result := Resolve(FModel.BuscarPordIDEmpresa(lID));
end;

constructor TControllerUsuarios.Create;
begin
  FModel := TModelUsuarios.New(TRepositories.Usuarios);
  inherited Create(FModel);
end;

destructor TControllerUsuarios.Destroy;
begin

  inherited;
end;

function TControllerUsuarios.Inserir(aBody: string): string;
begin
  inherited;
end;

class function TControllerUsuarios.New : iControllerUsuarios;
begin
  Result := Self.Create;
end;

end.
