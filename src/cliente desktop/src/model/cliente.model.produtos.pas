unit cliente.model.produtos;

interface

uses
  cliente.model.base,
  entidades.produtos,
  System.Generics.Collections,
  cliente.infra.repository.produtos.interfaces;

type
  TModelProdutos = class(TModelBase<TProduto>)
  private
    FRepository : iRepositoryProdutos;
  public
    constructor Create(aRepository : iRepositoryProdutos);
    destructor Destroy; override;

    procedure Alterar(aProduto : TProduto); override;
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TProduto>;
    procedure Inserir(aProduto : TProduto); override;
  end;

implementation

uses
  System.SysUtils,
  entidades.produtos.validacoes.basicas;

{ TModelProdutos }

procedure TModelProdutos.Alterar(aProduto: TProduto);
begin
  Validador.Clear;
  Validador.Add(TProdutosValidacoesBasicas.New);
  Validador.Add(TProdutosValidacoesBasicasAlterar.New);
  inherited;
end;

function TModelProdutos.BuscarPorIDEmpresa(aID: integer): TObjectList<TProduto>;
begin
  if Assigned(Entidades) then Entidades.DisposeOf;
  Entidades := FRepository.BuscarPorIDEmpresa(aID.ToString);
  Result := Entidades;
end;

constructor TModelProdutos.Create(aRepository: iRepositoryProdutos);
begin
  inherited Create(aRepository);
  FRepository := aRepository;
end;

destructor TModelProdutos.Destroy;
begin

  inherited;
end;

procedure TModelProdutos.Inserir(aProduto: TProduto);
begin
  Validador.Clear;
  Validador.Add(TProdutosValidacoesBasicas.New);
  Validador.Add(TProdutosValidacoesBasicasInserir.New);
  inherited;
end;

end.
