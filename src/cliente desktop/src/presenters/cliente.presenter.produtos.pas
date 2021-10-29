unit cliente.presenter.produtos;

interface

uses
  cliente.presenter.produtos.interfaces,
  cliente.model.produtos,
  Orion.Bindings.Interfaces;

type
  TPresenterProdutos = class
  private
    FBinds : iOrionBindings;
    FView : iPresenterProdutosView;
    FModelProdutos : TModelProdutos;
  public
    constructor Create(aView : iPresenterProdutosView);
    destructor Destroy; override;
    procedure BuscarPorIDEmpresa(aID : integer);
    procedure BuscarPorID(aID : integer);
    procedure Inserir;
    procedure Alterar;
  end;

implementation

{ TPresenterProdutos }

uses
  cliente.infra.repository.produtos,
  cliente.infra.conexao,
  cliente.infra.binds;

procedure TPresenterProdutos.Alterar;
begin
  FBinds.Entity(FModelProdutos.Entidade).BindToEntity;
  FModelProdutos.Alterar(FModelProdutos.Entidade);
end;

procedure TPresenterProdutos.BuscarPorID(aID: integer);
begin
  var lProduto := FModelProdutos.BuscarPorID(aID);
  if Assigned(FView) then
    FBinds.Entity(lProduto).BindToView;
end;

procedure TPresenterProdutos.BuscarPorIDEmpresa(aID: integer);
begin
  var lProdutos := FModelProdutos.BuscarPorIDEmpresa(aID);
  if Assigned(FView) then
    FView.CarregarProdutos(lProdutos);
end;

constructor TPresenterProdutos.Create(aView: iPresenterProdutosView);
begin
  FView          := aView;
  FModelProdutos := TModelProdutos.Create(TRepositoryProdutosRest.New(TConexoes.New.Conexao));
  FBinds         := TBinds.New;
  FBinds.View(FView.Instancia);
end;

destructor TPresenterProdutos.Destroy;
begin
  FModelProdutos.DisposeOf;
end;

procedure TPresenterProdutos.Inserir;
begin
  FBinds.Entity(FModelProdutos.Entidade).BindToEntity;
  FModelProdutos.Entidade.IDEmpresa := 1;
  FModelProdutos.Inserir(FModelProdutos.Entidade);
end;

end.
