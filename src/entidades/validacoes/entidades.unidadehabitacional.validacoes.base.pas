unit entidades.unidadehabitacional.validacoes.base;

interface

uses
  validador.interfaces, entidades.unidadehabitacional;

type
  TUnidadesHabitacionaisValidacoesBasicas = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUnidadeHabitacional;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TUnidadesHabitacionaisValidacoesBasicasInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUnidadeHabitacional;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TUnidadesHabitacionaisValidacoesBasicasAlterar = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUnidadeHabitacional;
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

{ TUnidadesHabitacionaisValidacoesBasicas }

function TUnidadesHabitacionaisValidacoesBasicas.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUnidadeHabitacional(aValue);
end;

constructor TUnidadesHabitacionaisValidacoesBasicas.Create;
begin

end;

destructor TUnidadesHabitacionaisValidacoesBasicas.Destroy;
begin

  inherited;
end;

function TUnidadesHabitacionaisValidacoesBasicas.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDEmpresa, 'ID Empresa');
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Descricao, 'Descrição');
  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDGrupo, 'Id Grupo');
  TValidacoes.CampoAtivoPadrao(FEntidade.Ativo, 'Unidade Habitacional');
end;

class function TUnidadesHabitacionaisValidacoesBasicas.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TUnidadesHabitacionaisValidacoesBasicasInserir }

function TUnidadesHabitacionaisValidacoesBasicasInserir.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUnidadeHabitacional(aValue);
end;

constructor TUnidadesHabitacionaisValidacoesBasicasInserir.Create;
begin

end;

destructor TUnidadesHabitacionaisValidacoesBasicasInserir.Destroy;
begin

  inherited;
end;

function TUnidadesHabitacionaisValidacoesBasicasInserir.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroSoPodeSerZero(FEntidade.ID, 'ID');
end;

class function TUnidadesHabitacionaisValidacoesBasicasInserir.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TUnidadesHabitacionaisValidacoesBasicasAlterar }

function TUnidadesHabitacionaisValidacoesBasicasAlterar.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUnidadeHabitacional(aValue);
end;

constructor TUnidadesHabitacionaisValidacoesBasicasAlterar.Create;
begin

end;

destructor TUnidadesHabitacionaisValidacoesBasicasAlterar.Destroy;
begin

  inherited;
end;

function TUnidadesHabitacionaisValidacoesBasicasAlterar.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.ID, 'ID');
end;

class function TUnidadesHabitacionaisValidacoesBasicasAlterar.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

end.
