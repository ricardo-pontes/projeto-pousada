unit cliente.presenter.caracteristicas;

interface

uses
  cliente.presenter.caracteristicas.interfaces,
  cliente.model.caracteristicas,
  Orion.Bindings.Interfaces;

type
  TPresenterCaracteristicas = class
  private
    FModel : TModelCaracteristicas;
    FView : iPresenterCaracteristicasView;
    FBinds : iOrionBindings;
  public
    constructor Create(aView : iPresenterCaracteristicasView);
    destructor Destroy; override;

    procedure Alterar;
    procedure BuscarPorIDEmpresa(aID : string); overload;
    procedure BuscarPorIDEmpresa(aID : integer); overload;
    procedure BuscarPorID(aID : string);
    procedure Ativar(aID : string);
    procedure Desativar(aID : string);
    procedure Inserir(aIDEmpresa : integer);
  end;

implementation

{ TPresenterCaracteristicas }

uses
  System.SysUtils,
  cliente.infra.repository.caracteristicas,
  cliente.infra.conexao,
  cliente.infra.binds,
  shared.exceptions;

procedure TPresenterCaracteristicas.Alterar;
begin
  FBinds.Entity(FModel.Entidade).BindToEntity;
  FModel.Alterar(FModel.Entidade);
end;

procedure TPresenterCaracteristicas.Ativar(aID: string);
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  FModel.Ativar(lID);
end;

procedure TPresenterCaracteristicas.BuscarPorID(aID: string);
begin
  FModel.BuscarPorID(aID.ToInteger);
  if Assigned(FView) then
    FBinds.Entity(FModel.Entidade).View(FView.Instancia).BindToView;
end;

procedure TPresenterCaracteristicas.BuscarPorIDEmpresa(aID: integer);
begin
  var lCaracteristicas := FModel.BuscarPorIDEmpresa(aID);
  if Assigned(FView) then
    FView.CarregarCaracteristicas(lCaracteristicas);
end;

procedure TPresenterCaracteristicas.BuscarPorIDEmpresa(aID: string);
begin
  var lCaracteristicas := FModel.BuscarPorIDEmpresa(aID.ToInteger);
  if Assigned(FView) then
    FView.CarregarCaracteristicas(lCaracteristicas);
end;

constructor TPresenterCaracteristicas.Create(aView: iPresenterCaracteristicasView);
begin
  FModel := TModelCaracteristicas.Create(TRepositoryCaracteristicasRest.New(TConexoes.New.Conexao));
  FView := aView;
  FBinds := TBinds.New;
  if Assigned(FView) then
    FBinds.View(FView.Instancia);
end;

procedure TPresenterCaracteristicas.Desativar(aID: string);
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise ExceptionConversaoNumerica.Create;

  FModel.Desativar(lID);
end;

destructor TPresenterCaracteristicas.Destroy;
begin
  FModel.DisposeOf;
  inherited;
end;

procedure TPresenterCaracteristicas.Inserir(aIDEmpresa : integer);
begin
  FBinds.Entity(FModel.Entidade).BindToEntity;
  FModel.Entidade.IDEmpresa := aIDEmpresa;
  FModel.Inserir(FModel.Entidade);
end;

end.
