unit entidades.estadia.validacoes.basicas;

interface

uses
  validador.interfaces, entidades.estadia;

type
  TEstadiaValidacoesBasicas = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TEstadia;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TEstadiaValidacoesBasicasInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TEstadia;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TEstadiaValidacoesBasicasAlterar = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TEstadia;
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

{ TEstadiaValidacoesBasicas }

function TEstadiaValidacoesBasicas.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TEstadia(aValue);
end;

constructor TEstadiaValidacoesBasicas.Create;
begin

end;

destructor TEstadiaValidacoesBasicas.Destroy;
begin

  inherited;
end;

function TEstadiaValidacoesBasicas.Executar : iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDEmpresa, EST_ID_EMPRESA_DISPLAY);
  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDCliente, EST_ID_CLIENTE);
  TValidacoes.DataNaoPodeSerVazia(FEntidade.DataEntrada, EST_DATA_ENTRADA_DISPLAY);
  TValidacoes.DataNaoPodeSerVazia(FEntidade.DataSaida, EST_DATA_SAIDA_DISPLAY);
  TValidacoes.Data1NaoPodeSerMaiorQueData2(FEntidade.DataEntrada, FEntidade.DataSaida, 'A' + EST_DATA_ENTRADA_DISPLAY + ' não pode ser maior que a ' + EST_DATA_SAIDA_DISPLAY);
  TValidacoes.DataNaoPodeSerVazia(FEntidade.DataRegistro, EST_DATA_REGISTRO_DISPLAY);
  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.Valor, EST_VALOR_DISPLAY);
end;

class function TEstadiaValidacoesBasicas.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TEstadiaValidacoesBasicasInserir }

function TEstadiaValidacoesBasicasInserir.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TEstadia(aValue);
end;

constructor TEstadiaValidacoesBasicasInserir.Create;
begin

end;

destructor TEstadiaValidacoesBasicasInserir.Destroy;
begin

  inherited;
end;

function TEstadiaValidacoesBasicasInserir.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroSoPodeSerZero(FEntidade.ID, EST_ID_DISPLAY);
end;

class function TEstadiaValidacoesBasicasInserir.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TEstadiaValidacoesBasicasAlterar }

function TEstadiaValidacoesBasicasAlterar.AddEntidade(
  aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TEstadia(aValue);
end;

constructor TEstadiaValidacoesBasicasAlterar.Create;
begin

end;

destructor TEstadiaValidacoesBasicasAlterar.Destroy;
begin

  inherited;
end;

function TEstadiaValidacoesBasicasAlterar.Executar: iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.ID, EST_ID_DISPLAY);
end;

class function TEstadiaValidacoesBasicasAlterar.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

end.
