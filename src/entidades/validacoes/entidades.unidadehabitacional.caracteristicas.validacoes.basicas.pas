unit entidades.unidadehabitacional.caracteristicas.validacoes.basicas;

interface

uses
  validador.interfaces,
  entidades.unidadehabitacional.caracteristicas;

type
  TUnidadeHabitacionalCaracteristicasValidacoesBasicas = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUnidadeHabitacionalCaracteristica;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TUnidadeHabitacionalCaracteristicasValidacoesBasicasInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUnidadeHabitacionalCaracteristica;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TUnidadeHabitacionalCaracteristicasValidacoesBasicasAlterar = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUnidadeHabitacionalCaracteristica;
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

{ TUnidadeHabitacionalCaracteristicasValidacoesBasicas }

function TUnidadeHabitacionalCaracteristicasValidacoesBasicas.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUnidadeHabitacionalCaracteristica(aValue);
end;

constructor TUnidadeHabitacionalCaracteristicasValidacoesBasicas.Create;
begin

end;

destructor TUnidadeHabitacionalCaracteristicasValidacoesBasicas.Destroy;
begin

  inherited;
end;

function TUnidadeHabitacionalCaracteristicasValidacoesBasicas.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDEmpresa, 'ID Empresa');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Descricao, 'Descrição');
  TValidacoes.CampoAtivoPadrao(FEntidade.Ativo, 'Produto');
end;

class function TUnidadeHabitacionalCaracteristicasValidacoesBasicas.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TUnidadeHabitacionalCaracteristicasValidacoesBasicasInserir }

function TUnidadeHabitacionalCaracteristicasValidacoesBasicasInserir.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUnidadeHabitacionalCaracteristica(aValue);
end;

constructor TUnidadeHabitacionalCaracteristicasValidacoesBasicasInserir.Create;
begin

end;

destructor TUnidadeHabitacionalCaracteristicasValidacoesBasicasInserir.Destroy;
begin

  inherited;
end;

function TUnidadeHabitacionalCaracteristicasValidacoesBasicasInserir.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroSoPodeSerZero(FEntidade.ID, 'ID');
end;

class function TUnidadeHabitacionalCaracteristicasValidacoesBasicasInserir.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TUnidadeHabitacionalCaracteristicasValidacoesBasicasAlterar }

function TUnidadeHabitacionalCaracteristicasValidacoesBasicasAlterar.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUnidadeHabitacionalCaracteristica(aValue);
end;

constructor TUnidadeHabitacionalCaracteristicasValidacoesBasicasAlterar.Create;
begin

end;

destructor TUnidadeHabitacionalCaracteristicasValidacoesBasicasAlterar.Destroy;
begin

  inherited;
end;

function TUnidadeHabitacionalCaracteristicasValidacoesBasicasAlterar.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.ID, 'ID');
end;

class function TUnidadeHabitacionalCaracteristicasValidacoesBasicasAlterar.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

end.
