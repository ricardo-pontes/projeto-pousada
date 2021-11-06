unit servidor.infra.routes.grupoprodutos;

interface

uses
  Horse;

procedure Registrar;

implementation

uses
  System.SysUtils,
  System.JSON,
  servidor.controller.grupoprodutos,
  shared.exceptions.server;

procedure Alterar(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerGrupoProdutos.New;
    aRes.Send(lController.Alterar(aReq.Body)).Status(THttpStatus.NoContent);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Ativar(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerGrupoProdutos.New;
    aRes.Send(lController.Ativar(aReq.Params.Items['id'])).Status(THTTPStatus.NoContent);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Desativar(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerGrupoProdutos.New;
    aRes.Send(lController.Desativar(aReq.Params.Items['id'])).Status(THTTPStatus.NoContent);
  except on E: Exception do
    aRes.Send(E.Message);
  end;
end;

procedure BuscarPorID(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerGrupoProdutos.New;
    aRes.Send<TJSONObject>(lController.BuscarPorID(aReq.Params.Items['id']));
  except on E: Exception do
    aRes.Send(E.Message);
  end;
end;

procedure BuscarPorIDEmpresa(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerGrupoProdutos.New;
    aRes.Send<TJSONArray>(lController.BuscarPorIDEmpresa(aReq.Params.Items['id']));
  except on E: Exception do
    aRes.Send(E.Message);
  end;
end;

procedure Inserir(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerGrupoProdutos.New;
    aRes.Send(lController.Inserir(aReq.Body)).Status(THttpStatus.Created);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Registrar;
begin
  THorse.Put('/api/v1/empresa/gruposprodutos',                Alterar);
  THorse.Get('/api/v1/empresa/gruposprodutos/:id',            BuscarPorID);
  THorse.Get('/api/v1/empresa/:id/gruposprodutos',            BuscarPorIDEmpresa);
  THorse.Post('/api/v1/empresa/gruposprodutos',               Inserir);
  THorse.Post('/api/v1/empresa/gruposprodutos/:id/ativar',    Ativar);
  THorse.Post('/api/v1/empresa/gruposprodutos/:id/desativar', Desativar);
end;

end.
