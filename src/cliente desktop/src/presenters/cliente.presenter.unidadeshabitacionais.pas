unit cliente.presenter.unidadeshabitacionais;

interface

uses
  Orion.Bindings.Interfaces,
  cliente.presenter.unidadeshabitacionais.interfaces,
  cliente.model.unidadeshabitacionais;


type
  TPresenterUnidadesHabitacionais = class
  private
    FBinds : iOrionBindings;
    FView : iPresenterUnidadesHabitacionaisView;
    FModel : TModelUnidadesHabitacionais;
  public
    constructor Create(aView : iPresenterUnidadesHabitacionaisView);
    destructor Destroy; override;
    procedure BuscarPorIDEmpresa(aID : integer);
    procedure BuscarPorID(aID : integer);
    procedure Alterar;
    procedure Inserir(aIDEmpresa : integer);
  end;

implementation

uses
  System.SysUtils,
  cliente.infra.binds,
  cliente.infra.conexao,
  cliente.infra.repository.unidadehabitacional;

{ TPresenterUnidadesHabitacionais }

procedure TPresenterUnidadesHabitacionais.Alterar;
begin
  if not Assigned(FView) then
    raise Exception.Create('Sem View para trabalhar');

  FBinds.Entity(FModel.Entidade).View(FView.Instancia).BindToEntity;
  FModel.Alterar(FModel.Entidade);
end;

procedure TPresenterUnidadesHabitacionais.BuscarPorID(aID: integer);
begin
  var lUnidadeHabitacional := FModel.BuscarPorID(aID);
  if Assigned(FView) then
    FBinds.Entity(lUnidadeHabitacional).View(FView.Instancia).BindToView;
end;

procedure TPresenterUnidadesHabitacionais.BuscarPorIDEmpresa(aID: integer);
begin
  var lUnidadeshabitacionais := FModel.BuscarPorIDEmpresa(aID);
  if Assigned(FView) then
    FView.CarregarUnidadesHabitacionais(lUnidadesHabitacionais);
end;

constructor TPresenterUnidadesHabitacionais.Create(aView: iPresenterUnidadesHabitacionaisView);
begin
  FView  := aView;
  FBinds := TBinds.New.View(FView.Instancia);
  FModel := TModelUnidadesHabitacionais.Create(TRepositoryUnidadeHabitacionalRest.New(TConexoes.New.Conexao));
end;

destructor TPresenterUnidadesHabitacionais.Destroy;
begin
  FModel.DisposeOf;
  inherited;
end;

procedure TPresenterUnidadesHabitacionais.Inserir(aIDEmpresa: integer);
begin
  if not Assigned(FView) then
    raise Exception.Create('Sem View para trabalhar');

  FModel.PrepararInsercao;
  FModel.Entidade.IDEmpresa := aIDEmpresa;
  FBinds.Entity(FModel.Entidade).View(FView.Instancia).BindToEntity;
  FModel.Inserir(FModel.Entidade);
end;

end.
