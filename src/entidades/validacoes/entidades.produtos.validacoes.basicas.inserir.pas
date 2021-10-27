unit entidades.produtos.validacoes.basicas.inserir;

interface

uses
  entidades.produtos,
  validador.interfaces;

type
  TProdutosValidacoesBasicasInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FProduto : TProduto;
    FResult : string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) :iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
    function Result : string;
  end;

implementation

uses
  System.SysUtils;

{ TProdutosValidacoesBasicasInserir }

function TProdutosValidacoesBasicasInserir.AddEntidade(
  aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FProduto := TProduto(aValue);
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
  FResult := '';
  if not Assigned(FProduto) then
  begin
    FResult := Self.QualifiedClassName + ': Nenhum dado para validar.';
    Exit;
  end;

  if FProduto.ID <> 0 then
  begin
    FResult := 'O ID só pode ser vazio.';
    Exit;
  end;
end;

class function TProdutosValidacoesBasicasInserir.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

function TProdutosValidacoesBasicasInserir.Result: string;
begin
  Result := FResult;
end;

end.
