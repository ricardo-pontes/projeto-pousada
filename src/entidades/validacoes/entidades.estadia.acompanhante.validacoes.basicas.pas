unit entidades.estadia.acompanhante.validacoes.basicas;

interface

uses
  validador.interfaces, entidades.estadia.acompanhante;

type
  TEstadiaAcompanhanteValidacoesBasicas = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TEstadiaAcompanhante;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TEstadiaAcompanhanteValidacoesBasicasInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TEstadiaAcompanhante;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TEstadiaAcompanhanteValidacoesBasicasAlterar = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TEstadiaAcompanhante;
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

{ TEstadiaAcompanhanteValidacoesBasicas }

function TEstadiaAcompanhanteValidacoesBasicas.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TEstadiaAcompanhante(aValue);
end;

constructor TEstadiaAcompanhanteValidacoesBasicas.Create;
begin

end;

destructor TEstadiaAcompanhanteValidacoesBasicas.Destroy;
begin

  inherited;
end;

function TEstadiaAcompanhanteValidacoesBasicas.Executar : iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDEmpresa, ESTA_ID_EMPRESA_DISPLAY);
  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDEstadia, ESTA_ID_ESTADIA_DISPLAY);
  TValidacoes.StringNaoPodeSerVazia(FEntidade.Nome, ESTA_NOME_DISPLAY);
  TValidacoes.StringNaoPodeSerVaziaEDeveConterXCaracteres(FEntidade.Celular, 11, ESTA_CELULAR_DISPLAY);
end;

class function TEstadiaAcompanhanteValidacoesBasicas.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TEstadiaAcompanhanteValidacoesBasicasInserir }

function TEstadiaAcompanhanteValidacoesBasicasInserir.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TEstadiaAcompanhante(aValue);
end;

constructor TEstadiaAcompanhanteValidacoesBasicasInserir.Create;
begin

end;

destructor TEstadiaAcompanhanteValidacoesBasicasInserir.Destroy;
begin

  inherited;
end;

function TEstadiaAcompanhanteValidacoesBasicasInserir.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroSoPodeSerZero(FEntidade.ID, ESTA_ID_DISPLAY);
end;

class function TEstadiaAcompanhanteValidacoesBasicasInserir.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TEstadiaAcompanhanteValidacoesBasicasAlterar }

function TEstadiaAcompanhanteValidacoesBasicasAlterar.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TEstadiaAcompanhante(aValue);
end;

constructor TEstadiaAcompanhanteValidacoesBasicasAlterar.Create;
begin

end;

destructor TEstadiaAcompanhanteValidacoesBasicasAlterar.Destroy;
begin

  inherited;
end;

function TEstadiaAcompanhanteValidacoesBasicasAlterar.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.ID, ESTA_ID_DISPLAY);
end;

class function TEstadiaAcompanhanteValidacoesBasicasAlterar.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

end.
