unit servidor.infra.routes.grupoprodutos;

interface

uses
  Horse;

procedure Registrar;

implementation

uses
  System.SysUtils,
  System.JSON,
  servidor.controller.grupoprodutos;

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

procedure Registrar;
begin
  THorse.Get('/api/v1/empresa/gruposprodutos/:id', BuscarPorID);
  THorse.Get('/api/v1/empresa/:id/gruposprodutos', BuscarPorIDEmpresa);
end;

end.
