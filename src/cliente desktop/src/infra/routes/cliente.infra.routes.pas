unit cliente.infra.routes;

interface

type
  TRouters = class
  private

  public
    constructor Create;
  end;

var
  Routers : TRouters;

implementation

uses
  Router4D,
  desktop.views.produtos, desktop.views.grupos.produtos;

{ TRouters }

constructor TRouters.Create;
begin
  TRouter4D.Switch.Router('produtos', TViewProdutos);
  TRouter4D.Switch.Router('gruposprodutos', TViewGrupoProdutos);
end;

initialization
  Routers := TRouters.Create;

finalization
  Routers.DisposeOf;

end.
