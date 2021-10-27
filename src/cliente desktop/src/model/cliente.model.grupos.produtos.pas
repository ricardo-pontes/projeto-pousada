unit cliente.model.grupos.produtos;

interface

uses
  System.Generics.Collections,
  cliente.model.base,
  entidades.grupoprodutos,
  cliente.infra.repository.grupos.produtos.interfaces;

type
  TModelGrupoProdutos = class(TModelBase<TGrupoProduto>)
  private
    FRepository : iRepositoryGrupoProdutos;
  public
    constructor Create(aRepository : iRepositoryGrupoProdutos);
    destructor Destroy; override;

    procedure Alterar(aGrupoProduto : TGrupoProduto); override;
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TGrupoProduto>;
    procedure Inserir(aGrupoProduto : TGrupoProduto); override;
  end;

implementation

{ TModelGrupoProdutos }

uses
  System.SysUtils,
  entidades.grupos.produtos.validacoes.basicas;

procedure TModelGrupoProdutos.Alterar(aGrupoProduto: TGrupoProduto);
begin
  Validador.Add(TGrupoProdutosValidacoesBasicas.New);
  Validador.Add(TGrupoProdutosValidacoesBasicasAlterar.New);
  inherited;
end;

function TModelGrupoProdutos.BuscarPorIDEmpresa(aID: integer): TObjectList<TGrupoProduto>;
begin
  Result := FRepository.BuscarPorIDEmpresa(aID.ToString);
end;

constructor TModelGrupoProdutos.Create(aRepository: iRepositoryGrupoProdutos);
begin
  FRepository := aRepository;
end;

destructor TModelGrupoProdutos.Destroy;
begin

  inherited;
end;

procedure TModelGrupoProdutos.Inserir(aGrupoProduto: TGrupoProduto);
begin
  Validador.Add(TGrupoProdutosValidacoesBasicas.New);
  Validador.Add(TGrupoProdutosValidacoesBasicasInserir.New);

  inherited;
end;

end.