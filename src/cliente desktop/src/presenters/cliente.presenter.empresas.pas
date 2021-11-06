unit cliente.presenter.empresas;

interface

uses
  cliente.model.empresas,
  Orion.Bindings.Interfaces,
  cliente.presenter.empresas.interfaces;

type
  TPresenterEmpresas = class
  private
    FBinds : iOrionBindings;
    FModel : TModelEmpresas;
    FView : iPresenterEmpresasView;
  public
    constructor Create(aView : iPresenterEmpresasView);
    destructor Destroy; override;

    procedure BuscarPorID(aID : integer);
    procedure Alterar;
  end;
implementation

{ TPresenterEmpresas }

uses
  cliente.infra.binds,
  cliente.infra.repository.empresas,
  cliente.infra.conexao;

procedure TPresenterEmpresas.Alterar;
begin
  FBinds.Entity(FModel.Entidade).View(FView.Instancia).BindToEntity;
  FModel.Alterar(FModel.Entidade);
end;

procedure TPresenterEmpresas.BuscarPorID(aID: integer);
begin
  var lEmpresa := FModel.BuscarPorID(aID);
  if Assigned(lEmpresa) then
    FBinds.View(FView.Instancia).Entity(lEmpresa).BindToView;
end;

constructor TPresenterEmpresas.Create(aView : iPresenterEmpresasView);
begin
  FModel := TModelEmpresas.Create(TRepositoryEmpresas.New(TConexoes.New.Conexao));
  FView  := aView;
  FBinds := TBinds.New.View(FView.Instancia);
end;

destructor TPresenterEmpresas.Destroy;
begin
  FModel.DisposeOf;
  inherited;
end;

end.
