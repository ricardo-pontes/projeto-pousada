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
    procedure Ativar(aID : string);
    function BuscarPorIDEmpresa(aID : string) : TJSONArray;
    procedure Desativar(aID : string);
    function Inserir(aBody : string) : string; override;
    function Logar(aParams : string) : TJSONObject;
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  shared.exceptions,
  servidor.model.usuarios,
  servidor.infra.fabricas.repositories,
  entidades.usuarios.validacoes.basicas,
  entidades.usuarios.validacoes.db;

{ TControllerUsuarios }

function TControllerUsuarios.Alterar(aBody: string): string;
begin
  FModel.Validador.Clear;
  FModel.Validador.Add(TUsuariosValidacoesBasicas.New);
  FModel.Validador.Add(TUsuariosValidacoesBasicasAlterar.New);
  FModel.Validador.Add(TUsuariosValidacoesDB.New(FModel.Conexao, FModel.Notacao));
  inherited;
end;

procedure TControllerUsuarios.Ativar(aID: string);
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  FModel.Ativar(lID);
end;

function TControllerUsuarios.BuscarPorIDEmpresa(aID: string): TJSONArray;
begin
 var lID := 0;
 if not TryStrToInt(aID, lID) then
   raise ExceptionConversaoNumerica.Create;

  Result := Resolve(FModel.BuscarPordIDEmpresa(lID));
end;

constructor TControllerUsuarios.Create;
begin
  FModel := TModelUsuarios.New(TRepositories.Usuarios);
  inherited Create(FModel);
end;

procedure TControllerUsuarios.Desativar(aID: string);
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  FModel.Desativar(lID);
end;

destructor TControllerUsuarios.Destroy;
begin

  inherited;
end;

function TControllerUsuarios.Inserir(aBody: string): string;
begin
  FModel.Validador.Clear;
  FModel.Validador.Add(TUsuariosValidacoesBasicas.New);
  FModel.Validador.Add(TUsuariosValidacoesBasicasInserir.New);
  FModel.Validador.Add(TUsuariosValidacoesDB.New(FModel.Conexao, FModel.Notacao));
  inherited;
end;

function TControllerUsuarios.Logar(aParams : string): TJSONObject;
begin
  var lDados := TStringList.Create;
  try
    lDados.Text := aParams;
    Result := Resolve(FModel.Login(lDados.Values['email'], lDados.Values['senha']));
  finally
    lDados.Free;
  end;
end;

class function TControllerUsuarios.New : iControllerUsuarios;
begin
  Result := Self.Create;
end;

end.
