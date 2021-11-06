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
  desktop.views.produtos,
  desktop.views.grupos.produtos,
  desktop.views.caracteristicas,
  desktop.views.inicio,
  desktop.views.usuario,
  desktop.views.empresa,
  desktop.views.unidadeshabitacionais,
  desktop.views.unidadeshabitacionais.categorias;

{ TRouters }

constructor TRouters.Create;
begin
  TRouter4D.Switch.Router('produtos', TViewProdutos);
  TRouter4D.Switch.Router('gruposprodutos', TViewGrupoProdutos);
  TRouter4D.Switch.Router('caracteristicas', TViewCaracteristicas);
  TRouter4D.Switch.Router('inicio', TViewInicio);
  TRouter4D.Switch.Router('usuarios', TViewUsuarios);
  TRouter4D.Switch.Router('empresas', TViewEmpresas);
  TRouter4D.Switch.Router('unidadeshabitacionais', TViewUnidadesHabitacionais);
  TRouter4D.Switch.Router('unidadeshabitacionaiscategorias', TViewUnidadesHabitacionaisCategorias);
end;

initialization
  Routers := TRouters.Create;

finalization
  Routers.DisposeOf;

end.
