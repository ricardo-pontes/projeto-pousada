unit entidades.grupos.produtos.validacoes.basicas;

interface

uses
  validador.interfaces, entidades.grupoprodutos;

type
  TGrupoProdutosValidacoesBasicas = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TGrupoProduto;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TGrupoProdutosValidacoesBasicasAlterar = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TGrupoProduto;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TGrupoProdutosValidacoesBasicasInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TGrupoProduto;
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

{ TGrupoProdutosValidacoesBasicas }

function TGrupoProdutosValidacoesBasicas.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TGrupoProduto(aValue);
end;

constructor TGrupoProdutosValidacoesBasicas.Create;
begin

end;

destructor TGrupoProdutosValidacoesBasicas.Destroy;
begin

  inherited;
end;

function TGrupoProdutosValidacoesBasicas.Executar : iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDEmpresa, 'ID Empresa');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Descricao, 'Descrição');
  TValidacoes.CampoAtivoPadrao(FEntidade.Ativo, 'Ativo');
end;

class function TGrupoProdutosValidacoesBasicas.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TGrupoProdutosValidacoesBasicasAlterar }

function TGrupoProdutosValidacoesBasicasAlterar.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TGrupoProduto(aValue);
end;

constructor TGrupoProdutosValidacoesBasicasAlterar.Create;
begin

end;

destructor TGrupoProdutosValidacoesBasicasAlterar.Destroy;
begin

  inherited;
end;

function TGrupoProdutosValidacoesBasicasAlterar.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.ID, 'ID');
end;

class function TGrupoProdutosValidacoesBasicasAlterar.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TGrupoProdutosValidacoesBasicasInserir }

function TGrupoProdutosValidacoesBasicasInserir.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TGrupoProduto(aValue);
end;

constructor TGrupoProdutosValidacoesBasicasInserir.Create;
begin

end;

destructor TGrupoProdutosValidacoesBasicasInserir.Destroy;
begin

  inherited;
end;

function TGrupoProdutosValidacoesBasicasInserir.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroSoPodeSerZero(FEntidade.ID, 'ID');
end;

class function TGrupoProdutosValidacoesBasicasInserir.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

end.
