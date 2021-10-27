unit entidades.clientes.validacoes.basicas;

interface

uses
  validador.interfaces, entidades.clientes;

type
  TClientesValidacoesBasicas = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TClientePF;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TClientesValidacoesBasicasInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TClientePF;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TClientesValidacoesBasicasAlterar = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TClientePF;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

implementation

uses
  System.SysUtils,
  validador.validacoessimples;

{ TClientesValidacoesBasicas }

function TClientesValidacoesBasicas.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TClientePF(aValue);
end;

constructor TClientesValidacoesBasicas.Create;
begin

end;

destructor TClientesValidacoesBasicas.Destroy;
begin

  inherited;
end;

function TClientesValidacoesBasicas.Executar : iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDEmpresa, 'ID Empresa');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.NomeCompleto, 'Nome');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.CPF, 'CPF');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.RG, 'RG');
  TValidacoes.DataNaoPodeSerVaziaNemExcederDataHoje(FEntidade.DataNascimento, 'Data de Nascimento');
  TValidacoes.DataNaoPodeSerVaziaNemExcederDataHoje(FEntidade.DataCadastro, 'Data de Cadastro');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Logradouro, 'Logradouro');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Numero, 'Número');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Bairro, 'Bairro');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Cidade, 'Cidade');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.UF, 'UF');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.CEP, 'CEP');
end;

class function TClientesValidacoesBasicas.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TClientesValidacoesBasicasInserir }

function TClientesValidacoesBasicasInserir.AddEntidade(
  aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TClientePF(aValue);
end;

constructor TClientesValidacoesBasicasInserir.Create;
begin

end;

destructor TClientesValidacoesBasicasInserir.Destroy;
begin

  inherited;
end;

function TClientesValidacoesBasicasInserir.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroSoPodeSerZero(FEntidade.ID, 'ID');
end;

class function TClientesValidacoesBasicasInserir.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TClientesValidacoesBasicasAlterar }

function TClientesValidacoesBasicasAlterar.AddEntidade(
  aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TClientePF(aValue);
end;

constructor TClientesValidacoesBasicasAlterar.Create;
begin

end;

destructor TClientesValidacoesBasicasAlterar.Destroy;
begin

  inherited;
end;

function TClientesValidacoesBasicasAlterar.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.ID, 'ID');
end;

class function TClientesValidacoesBasicasAlterar.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

end.
