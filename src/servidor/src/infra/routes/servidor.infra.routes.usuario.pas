unit servidor.infra.routes.usuario;

interface

uses
  Horse,
  System.JSON;

procedure Registrar;

implementation

uses
  System.SysUtils,
  servidor.controller.usuarios,
  shared.exceptions.server;

procedure BuscarPorID(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerUsuarios.New;
    aRes.Send<TJSONObject>(lController.BuscarPorID(aReq.Params.Items['id']));
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure BuscarPorIDEmpresa(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerUsuarios.New;
    aRes.Send<TJSONArray>(lController.BuscarPorIDEmpresa(aReq.Params.Items['idempresa']));
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Inserir(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerUsuarios.New;
    aRes.Send(lController.Inserir(aReq.Body)).Status(THTTPStatus.Created);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Alterar(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerUsuarios.New;
    aRes.Send(lController.Alterar(aReq.Body)).Status(THTTPStatus.NoContent);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Logar(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerUsuarios.New;
    aRes.Send(lController.Logar(aReq.Body));
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Ativar(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerUsuarios.New;
    lController.Ativar(aReq.Params.Items['id']);
    aRes.Status(THTTPStatus.NoContent);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Desativar(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerUsuarios.New;
    lController.Desativar(aReq.Params.Items['id']);
    aRes.Status(THTTPStatus.NoContent);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Registrar;
begin
  THorse.Post('/api/v1/empresas/usuarios',               Inserir);
  THorse.Post('/api/v1/empresas/usuarios/:id/ativar',    Ativar);
  THorse.Post('/api/v1/empresas/usuarios/:id/desativar', Desativar);
  THorse.Post('/api/v1/empresas/usuarios/logar',         Logar);
  THorse.Put('/api/v1/empresas/usuarios',                Alterar);
  THorse.Get('/api/v1/empresas/:idempresa/usuarios',     BuscarPorIDEmpresa);
  THorse.Get('/api/v1/empresas/usuarios/:id',            BuscarPorID);
end;

end.
