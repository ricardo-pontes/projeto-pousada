unit servidor.infra.routes.unidadehabitacional;

interface

uses
  Horse,
  System.JSON;

procedure Registrar;

implementation

uses
  System.SysUtils,
  servidor.controller.unidadehabitacional,
  shared.exceptions.server;

procedure BuscarPorID(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerUnidadeHabitacional.New;
    aRes.Send<TJSONObject>(lController.BuscarPorID(aReq.Params.Items['id']));
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure BuscarPorIDEmpresa(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerUnidadeHabitacional.New;
    aRes.Send<TJSONArray>(lController.BuscarPorIDEmpresa(aReq.Params.Items['idempresa']));
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Inserir(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerUnidadeHabitacional.New;
    aRes.Send(lController.Inserir(aReq.Body)).Status(THTTPStatus.Created);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Alterar(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerUnidadeHabitacional.New;
    aRes.Send(lController.Alterar(aReq.Body)).Status(THTTPStatus.NoContent);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Registrar;
begin
  THorse.Post('/api/v1/empresas/unidadeshabitacionais',           Inserir);
  THorse.Put('/api/v1/empresas/unidadeshabitacionais',            Alterar);
  THorse.Get('/api/v1/empresas/:idempresa/unidadeshabitacionais', BuscarPorIDEmpresa);
  THorse.Get('/api/v1/empresas/unidadeshabitacionais/:id',        BuscarPorID);
end;

end.
