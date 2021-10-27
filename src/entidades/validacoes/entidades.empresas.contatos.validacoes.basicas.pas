unit entidades.empresas.contatos.validacoes.basicas;

interface

uses
  validador.interfaces, entidades.empresa.contatos;

type
  TEmpresaContatosValidacoesBasicas = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TEmpresaContato;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TEmpresaContatosValidacoesBasicasInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TEmpresaContato;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TEmpresaContatosValidacoesBasicasAlterar = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TEmpresaContato;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

implementation

uses
  System.SysUtils, entidades.empresas.validacoes.basicas,
  validador.validacoessimples;

{ TEmpresaContatosValidacoesBasicas }

function TEmpresaContatosValidacoesBasicas.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TEmpresaContato(aValue);
end;

constructor TEmpresaContatosValidacoesBasicas.Create;
begin

end;

destructor TEmpresaContatosValidacoesBasicas.Destroy;
begin

  inherited;
end;

function TEmpresaContatosValidacoesBasicas.Executar : iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDEmpresa, 'ID Empresa');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.TipoContato, 'Tipo de Contato');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Descricao, 'Descrição');
end;

class function TEmpresaContatosValidacoesBasicas.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TEmpresaContatosValidacoesBasicasInserir }

function TEmpresaContatosValidacoesBasicasInserir.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TEmpresaContato(aValue);
end;

constructor TEmpresaContatosValidacoesBasicasInserir.Create;
begin

end;

destructor TEmpresaContatosValidacoesBasicasInserir.Destroy;
begin

  inherited;
end;

function TEmpresaContatosValidacoesBasicasInserir.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroSoPodeSerZero(FEntidade.ID, 'ID');
end;

class function TEmpresaContatosValidacoesBasicasInserir.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TEmpresaContatosValidacoesBasicasAlterar }

function TEmpresaContatosValidacoesBasicasAlterar.AddEntidade(
  aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TEmpresaContato(aValue);
end;

constructor TEmpresaContatosValidacoesBasicasAlterar.Create;
begin

end;

destructor TEmpresaContatosValidacoesBasicasAlterar.Destroy;
begin

  inherited;
end;

function TEmpresaContatosValidacoesBasicasAlterar.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.ID, 'ID');
end;

class function TEmpresaContatosValidacoesBasicasAlterar.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

end.
