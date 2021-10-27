unit entidades.produtos.validacoes.basicas;

interface

uses
  validador.interfaces,
  entidades.produtos;

type
  TProdutosValidacoesBasicas = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TProduto;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TProdutosValidacoesBasicasInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TProduto;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TProdutosValidacoesBasicasAlterar = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TProduto;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

implementation

uses
  System.SysUtils, validador.validacoessimples;

{ TProdutosValidacoesBasicas }

function TProdutosValidacoesBasicas.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TProduto(aValue);
end;

constructor TProdutosValidacoesBasicas.Create;
begin

end;

destructor TProdutosValidacoesBasicas.Destroy;
begin

  inherited;
end;

function TProdutosValidacoesBasicas.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDEmpresa, 'ID Empresa');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Descricao, 'Descrição');
  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.ValorCusto, 'Valor de Custo');
  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.ValorVenda, 'Valor de Venda');
  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDCategoria, 'ID Categoria');
end;

class function TProdutosValidacoesBasicas.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TProdutosValidacoesBasicasInserir }

function TProdutosValidacoesBasicasInserir.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TProduto(aValue);
end;

constructor TProdutosValidacoesBasicasInserir.Create;
begin

end;

destructor TProdutosValidacoesBasicasInserir.Destroy;
begin

  inherited;
end;

function TProdutosValidacoesBasicasInserir.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroSoPodeSerZero(FEntidade.ID, 'ID');
end;

class function TProdutosValidacoesBasicasInserir.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TProdutosValidacoesBasicasAlterar }

function TProdutosValidacoesBasicasAlterar.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := Tproduto(aValue);
end;

constructor TProdutosValidacoesBasicasAlterar.Create;
begin

end;

destructor TProdutosValidacoesBasicasAlterar.Destroy;
begin

  inherited;
end;

function TProdutosValidacoesBasicasAlterar.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.ID, 'ID');
end;

class function TProdutosValidacoesBasicasAlterar.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

end.
