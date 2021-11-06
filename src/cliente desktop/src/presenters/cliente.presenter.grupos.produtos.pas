unit cliente.presenter.grupos.produtos;

interface

uses
  cliente.model.grupos.produtos,
  cliente.presenter.grupos.produtos.interfaces,
  Orion.Bindings.Interfaces;

type
  TPresenterGrupoProdutos = class
  private
    FView : iPresenterGrupoProdutosView;
    FBinds : iOrionBindings;
    FModelGrupoProdutos : TModelGrupoProdutos;
  public
    constructor Create(aView : iPresenterGrupoProdutosView);
    destructor Destroy; override;

    procedure Alterar;
    procedure Inserir(aID : integer);
    procedure BuscarPorIDEmpresa(aID : integer);
    procedure BuscarPorID(aID : string);
    procedure Ativar(aID : string);
    procedure Desativar(aID : string);
  end;

implementation

uses
  System.SysUtils,
  cliente.infra.repository.grupos.produtos,
  cliente.infra.conexao,
  cliente.infra.binds;

{ TPresenterGrupoProdutos }

procedure TPresenterGrupoProdutos.Alterar;
begin
  FBinds.Entity(FModelGrupoProdutos.Entidade).BindToEntity;
  FModelGrupoProdutos.Alterar(FModelGrupoProdutos.Entidade);
end;

procedure TPresenterGrupoProdutos.Ativar(aID: string);
begin
  FModelGrupoProdutos.Ativar(aID.ToInteger);
end;

procedure TPresenterGrupoProdutos.BuscarPorID(aID: string);
begin
  var lProduto := FModelGrupoProdutos.BuscarPorID(aID.ToInteger);
  if Assigned(FView) then
    FBinds.Entity(lProduto).BindToView;
end;

procedure TPresenterGrupoProdutos.BuscarPorIDEmpresa(aID: integer);
begin
  var lProdutos := FModelGrupoProdutos.BuscarPorIDEmpresa(aID);
  if Assigned(FView) then
    FView.CarregarGruposProdutos(lProdutos);
end;

constructor TPresenterGrupoProdutos.Create(aView : iPresenterGrupoProdutosView);
begin
  FView := aView;
  FModelGrupoProdutos := TModelGrupoProdutos.Create(TRepositoryGrupoProdutos.New(TConexoes.New.Conexao));
  FBinds := TBinds.New.View(FView.Instancia);
end;

procedure TPresenterGrupoProdutos.Desativar(aID: string);
begin
  FModelGrupoProdutos.Desativar(aID.ToInteger);
end;

destructor TPresenterGrupoProdutos.Destroy;
begin
  FModelGrupoProdutos.DisposeOf;
  inherited;
end;

procedure TPresenterGrupoProdutos.Inserir(aID : integer);
begin
  FModelGrupoProdutos.PrepararInsercao;
  FModelGrupoProdutos.Entidade.IDEmpresa := aID;
  FBinds.Entity(FModelGrupoProdutos.Entidade).BindToEntity;
  FModelGrupoProdutos.Inserir(FModelGrupoProdutos.Entidade);
end;

end.
