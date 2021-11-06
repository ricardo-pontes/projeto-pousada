unit entidades.caracteristicas.validacoes.basicas;

interface

uses
  validador.interfaces, entidades.caracteristicas;

type
  TCaracteristicasValidacoesBasicas = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TCaracteristica;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TCaracteristicasValidacoesBasicasInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TCaracteristica;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TCaracteristicasValidacoesBasicasAlterar = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TCaracteristica;
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

{ TCaracteristicasValidacoesBasicas }

function TCaracteristicasValidacoesBasicas.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TCaracteristica(aValue);
end;

constructor TCaracteristicasValidacoesBasicas.Create;
begin

end;

destructor TCaracteristicasValidacoesBasicas.Destroy;
begin

  inherited;
end;

function TCaracteristicasValidacoesBasicas.Executar : iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDEmpresa, 'ID Empresa');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Descricao, 'Descrição');
  TValidacoes.CampoAtivoPadrao(FEntidade.Ativo, 'Característica');
end;

class function TCaracteristicasValidacoesBasicas.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TCaracteristicasValidacoesBasicasInserir }

function TCaracteristicasValidacoesBasicasInserir.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TCaracteristica(aValue);
end;

constructor TCaracteristicasValidacoesBasicasInserir.Create;
begin

end;

destructor TCaracteristicasValidacoesBasicasInserir.Destroy;
begin

  inherited;
end;

function TCaracteristicasValidacoesBasicasInserir.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroSoPodeSerZero(FEntidade.ID, 'ID');
end;

class function TCaracteristicasValidacoesBasicasInserir.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TCaracteristicasValidacoesBasicasAlterar }

function TCaracteristicasValidacoesBasicasAlterar.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TCaracteristica(aValue);
end;

constructor TCaracteristicasValidacoesBasicasAlterar.Create;
begin

end;

destructor TCaracteristicasValidacoesBasicasAlterar.Destroy;
begin

  inherited;
end;

function TCaracteristicasValidacoesBasicasAlterar.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDEmpresa, 'ID Empresa');
end;

class function TCaracteristicasValidacoesBasicasAlterar.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

end.
