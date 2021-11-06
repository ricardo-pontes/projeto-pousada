unit entidades.caracteristicas.validacoes.db;

interface

uses
  validador.interfaces,
  entidades.caracteristicas,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces;

type
  TCaracteristicasValidacoesDB = class(TInterfacedObject, iValidacaoEntidade)
  private
    [weak]
    FConexao : iConexao;
    [weak]
    FNotacao : iNotacao;
    FEntidade : TCaracteristica;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

implementation

uses
  System.SysUtils, validador.validacoesdb;

{ TCaracteristicasValidacoesDB }

function TCaracteristicasValidacoesDB.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TCaracteristica(aValue);
end;

constructor TCaracteristicasValidacoesDB.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
end;

destructor TCaracteristicasValidacoesDB.Destroy;
begin

  inherited;
end;

function TCaracteristicasValidacoesDB.Executar : iValidacaoEntidade;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  if not Assigned(FConexao) then
    raise Exception.Create(Self.QualifiedClassName + ': Conexão não instanciada.');

  if not Assigned(FNotacao) then
    raise Exception.Create(Self.QualifiedClassName + ': Notação não instanciada.');

  TValidacoesDB.InformacaoNaoPodeExistir(FConexao, FNotacao, CAT_TABELA, CAT_DESCRICAO, 'Característica', FEntidade.ID, FEntidade.Descricao);
end;

class function TCaracteristicasValidacoesDB.New (aConexao : iConexao; aNotacao : iNotacao) : iValidacaoEntidade;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
