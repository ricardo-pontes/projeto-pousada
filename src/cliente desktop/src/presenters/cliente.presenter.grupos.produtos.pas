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

    procedure BuscarPorIDEmpresa(aID : string);
  end;

implementation

uses
  System.SysUtils,
  cliente.infra.repository.grupos.produtos,
  cliente.infra.conexao;

{ TPresenterGrupoProdutos }

procedure TPresenterGrupoProdutos.BuscarPorIDEmpresa(aID: string);
begin
  var lProdutos := FModelGrupoProdutos.BuscarPorIDEmpresa(aID.ToInteger);
  if Assigned(FView) then
    FView.CarregarGruposProdutos(lProdutos);
end;

constructor TPresenterGrupoProdutos.Create(aView : iPresenterGrupoProdutosView);
begin
  FView := aView;
  FModelGrupoProdutos := TModelGrupoProdutos.Create(TRepositoryGrupoProdutos.New(TConexoes.New.Conexao));
end;

destructor TPresenterGrupoProdutos.Destroy;
begin
  FModelGrupoProdutos.DisposeOf;
  inherited;
end;

end.
