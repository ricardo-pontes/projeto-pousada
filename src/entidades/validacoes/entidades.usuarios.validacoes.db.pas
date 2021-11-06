unit entidades.usuarios.validacoes.db;

interface

uses
  validador.interfaces,
  entidades.usuario,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces;

type
  TUsuariosValidacoesDB = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUsuario;
    [weak]
    FConexao : iConexao;
    [weak]
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

implementation

uses
  System.SysUtils,
  validador.validacoesdb;

{ TUsuariosValidacoesDB }

function TUsuariosValidacoesDB.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUsuario(aValue);
end;

constructor TUsuariosValidacoesDB.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
end;

destructor TUsuariosValidacoesDB.Destroy;
begin

  inherited;
end;

function TUsuariosValidacoesDB.Executar : iValidacaoEntidade;
begin
  Result := Self;

  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  if not FEntidade.Email.Trim.IsEmpty then
    TValidacoesDB.InformacaoNaoPodeExistir(FConexao, FNotacao, USU_TABELA, USU_EMAIL, 'Email', FEntidade.ID, FEntidade.Email);
  if not FEntidade.CPF.Trim.IsEmpty then
    TValidacoesDB.InformacaoNaoPodeExistir(FConexao, FNotacao, USU_TABELA, USU_EMAIL, 'CPF', FEntidade.ID, FEntidade.CPF);
end;

class function TUsuariosValidacoesDB.New (aConexao : iConexao; aNotacao : iNotacao) : iValidacaoEntidade;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
