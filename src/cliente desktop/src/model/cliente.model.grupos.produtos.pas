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
  Validador.Clear;
  Validador.Add(TGrupoProdutosValidacoesBasicas.New);
  Validador.Add(TGrupoProdutosValidacoesBasicasAlterar.New);
  inherited;
end;

function TModelGrupoProdutos.BuscarPorIDEmpresa(aID: integer): TObjectList<TGrupoProduto>;
begin
  if Assigned(Entidades) then Entidades.DisposeOf;
  Entidades := FRepository.BuscarPorIDEmpresa(aID.ToString);
  Result := Entidades;
end;

constructor TModelGrupoProdutos.Create(aRepository: iRepositoryGrupoProdutos);
begin
  FRepository := aRepository;
  inherited Create(FRepository);
end;

destructor TModelGrupoProdutos.Destroy;
begin

  inherited;
end;

procedure TModelGrupoProdutos.Inserir(aGrupoProduto: TGrupoProduto);
begin
  Validador.Clear;
  Validador.Add(TGrupoProdutosValidacoesBasicas.New);
  Validador.Add(TGrupoProdutosValidacoesBasicasInserir.New);

  inherited;
end;

end.
