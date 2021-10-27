unit entidades.produtos.validacoes.basicas.alterar;

interface

uses
  validador.interfaces,
  entidades.produtos;

type
  TProdutosValidacoesBasicasAlterar = class(TInterfacedObject, iValidacaoEntidade)
  private
    FProduto : TProduto;
    FResult : string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
    function Result : string;
  end;

implementation

uses
  System.SysUtils;

{ TProdutosValidacoesBasicasAlterar }

function TProdutosValidacoesBasicasAlterar.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FProduto := TProduto(aValue);
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
  FResult := '';
  if not Assigned(FProduto) then
  begin
    FResult := Self.QualifiedClassName + ': Nenhum dado para validar.';
    Exit;
  end;

  if FProduto.ID = 0 then
  begin
    FResult := 'O ID não pode ser zerado.';
    Exit;
  end;
end;

class function TProdutosValidacoesBasicasAlterar.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

function TProdutosValidacoesBasicasAlterar.Result: string;
begin
  Result := FResult;
end;

end.
