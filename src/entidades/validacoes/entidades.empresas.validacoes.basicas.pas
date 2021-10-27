unit entidades.empresas.validacoes.basicas;

interface

uses
  validador.interfaces, entidades.empresa;

type
  TEmpresaValidacoesBasicas = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TEmpresa;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TEmpresaValidacoesBasicasAlterar = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TEmpresa;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TEmpresaValidacoesBasicasInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TEmpresa;
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

{ TEmpresaValidacoesBasicas }

function TEmpresaValidacoesBasicas.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TEmpresa(aValue);
end;

constructor TEmpresaValidacoesBasicas.Create;
begin

end;

destructor TEmpresaValidacoesBasicas.Destroy;
begin

  inherited;
end;

function TEmpresaValidacoesBasicas.Executar : iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.StringNaoPodeSerVazia(FEntidade.RazaoSocial, 'Razão Social');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Fantasia, 'Nome Fantasia');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.CNPJ, 'CNPJ');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Telefone, 'Telefone');
  TValidacoes.DataNaoPodeSerVaziaNemExcederDataHoje(FEntidade.DataCadastro, 'Data de Cadastro');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Logradouro, 'Logradouro');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Numero, 'Número');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Bairro, 'Bairro');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Cidade, 'Município');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.UF, 'UF');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.CEP, 'CEP');
end;

class function TEmpresaValidacoesBasicas.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TEmpresaValidacoesBasicasAlterar }

function TEmpresaValidacoesBasicasAlterar.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TEmpresa(aValue);
end;

constructor TEmpresaValidacoesBasicasAlterar.Create;
begin

end;

destructor TEmpresaValidacoesBasicasAlterar.Destroy;
begin

  inherited;
end;

function TEmpresaValidacoesBasicasAlterar.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.ID, 'ID');
end;

class function TEmpresaValidacoesBasicasAlterar.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TEmpresaValidacoesBasicasInserir }

function TEmpresaValidacoesBasicasInserir.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TEmpresa(aValue);
end;

constructor TEmpresaValidacoesBasicasInserir.Create;
begin

end;

destructor TEmpresaValidacoesBasicasInserir.Destroy;
begin

  inherited;
end;

function TEmpresaValidacoesBasicasInserir.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroSoPodeSerZero(FEntidade.ID, 'ID');
end;

class function TEmpresaValidacoesBasicasInserir.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

end.
