unit servidor.infra.routes.produtos;

interface

uses
  Horse,
  System.JSON;

procedure Registrar;

implementation

uses
  System.SysUtils,
  servidor.controller.produtos,
  servidor.exceptions;

procedure BuscarPorID(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerProdutos.New;
    aRes.Send<TJSONObject>(lController.BuscarPorID(aReq.Params.Items['id']));
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure BuscarPorIDEmpresa(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerProdutos.New;
    aRes.Send<TJSONArray>(lController.BuscarPorIDEmpresa(aReq.Params.Items['idempresa']));
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Inserir(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerProdutos.New;
    aRes.Send(lController.Inserir(aReq.Body)).Status(THTTPStatus.Created);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Alterar(aReq : THorseRequest; aRes : THorseResponse; aNext : TProc);
begin
  try
    var lController := TControllerProdutos.New;
    aRes.Send(lController.Alterar(aReq.Body)).Status(THTTPStatus.NoContent);
  except on E: Exception do
    TExceptions.Tratar(E, aRes);
  end;
end;

procedure Registrar;
begin
  THorse.Post('/api/v1/empresa/produtos',           Inserir);
  THorse.Put('/api/v1/empresa/produtos',            Alterar);
  THorse.Get('/api/v1/empresa/:idempresa/produtos', BuscarPorIDEmpresa);
  THorse.Get('/api/v1/empresa/produtos/:id',        BuscarPorID);
end;

end.
