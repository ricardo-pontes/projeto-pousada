unit servidor.infra.routes.caracteristicas;

interface

uses
  Horse,
  System.JSON;

procedure Registrar;

implementation

uses
  System.SysUtils,
  servidor.controller.caracteristicas,
  shared.exceptions.server;

procedure BuscarPorID(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerCaracteristicas.New;
    aRes.Send<TJSONObject>(lController.BuscarPorID(aReq.Params.Items['id']));
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Ativar(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerCaracteristicas.New;
    aRes.Send(lController.Ativar(aReq.Params.Items['id'])).Status(THTTPStatus.NoContent);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Desativar(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerCaracteristicas.New;
    aRes.Send(lController.Desativar(aReq.Params.Items['id'])).Status(THTTPStatus.NoContent);
  except on E: Exception do
    aRes.Send(E.Message);
  end;
end;

procedure BuscarPorIDEmpresa(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerCaracteristicas.New;
    aRes.Send<TJSONArray>(lController.BuscarPorIDEmpresa(aReq.Params.Items['idempresa']));
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Inserir(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerCaracteristicas.New;
    aRes.Send(lController.Inserir(aReq.Body)).Status(THTTPStatus.Created);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Alterar(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerCaracteristicas.New;
    aRes.Send(lController.Alterar(aReq.Body)).Status(THTTPStatus.NoContent);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Registrar;
begin
  THorse.Post('/api/v1/empresas/caracteristicas',              Inserir);
  THorse.Put('/api/v1/empresas/caracteristicas',               Alterar);
  THorse.Get('/api/v1/empresas/:idempresa/caracteristicas',    BuscarPorIDEmpresa);
  THorse.Get('/api/v1/empresas/caracteristicas/:id',           BuscarPorID);
  THorse.Post('/api/v1/empresas/caracteristicas/:id/ativar',    Ativar);
  THorse.Post('/api/v1/empresas/caracteristicas/:id/desativar', Desativar);
end;

end.
