
unit entidades.usuarios.validacoes.basicas;

interface

uses
  validador.interfaces, entidades.usuario;

type
  TUsuariosValidacoesBasicas = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUsuario;
    FResult : string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
    function Result : string;
  end;

  TUsuariosValidacoesBasicasInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUsuario;
    FResult : string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
    function Result : string;
  end;
const
  MSG_ID_DEVE_SER_ZERO_NA_INSERCAO = 'Ao inserir um novo cadastro, o ID deve ser zero.';
  MSG_ID_NAODEVE_SER_ZERO_NA_INSERCAO = 'Ao alterar um cadastro, é obrigatório passar o ID.';
  MSG_ID_EMPRESA_NAO_PODE_RECEBER_ZERO = 'O ID Empresa nao pode receber zero.';
  MSG_ID_EMPRESA_NAO_PODE_SER_MENOR_QUE_ZERO = 'O ID Empresa nao pode ser menor que zero.';
  MSG_EMAIL_NAO_PODE_SER_VAZIO = 'O email precisa ser preenchido.';
  MSG_SENHA_NAO_PODE_SER_VAZIA = 'A senha precisa ser preenchida.';
  MSG_LIMITE_TAMANHO_SENHA = 'A senha deve conter no máximo 20 caracteres.';

implementation

uses
  System.SysUtils, validador.validacoessimples;

{ TUsuariosValidacoesBasicas }

function TUsuariosValidacoesBasicas.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUsuario(aValue);
end;

constructor TUsuariosValidacoesBasicas.Create;
begin

end;

destructor TUsuariosValidacoesBasicas.Destroy;
begin

  inherited;
end;

function TUsuariosValidacoesBasicas.Executar : iValidacaoEntidade;
begin
  Result := Self;
  Fresult := '';
  try
    if not Assigned(FEntidade) then
      raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

    TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDEmpresa, 'ID Empresa');
    TValidacoes.StringNaoPodeSerVaziaEDeveConterXCaracteres(FEntidade.Email, 200, 'Email');
    TValidacoes.StringNaoPodeSerVaziaEDeveConterXCaracteres(FEntidade.Senha, 20, 'Senha');
    TValidacoes.StringNaoPodeSerVaziaEDeveConterXCaracteres(FEntidade.NomeCompleto, 200, 'Nome');
    TValidacoes.DataNaoPodeSerVaziaNemExcederDataHoje(FEntidade.DataNascimento, 'Data de Nascimento');
    TValidacoes.DataNaoPodeSerVaziaNemExcederDataHoje(FEntidade.DataCadastro, 'Data de Nascimento');
  except on E: Exception do
    FResult := E.Message;
  end;
end;

class function TUsuariosValidacoesBasicas.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

function TUsuariosValidacoesBasicas.Result : string;
begin
  Result := FResult;
end;

{ TUsuariosValidacoesBasicasInserir }

function TUsuariosValidacoesBasicasInserir.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUsuario(aValue);
end;

constructor TUsuariosValidacoesBasicasInserir.Create;
begin

end;

destructor TUsuariosValidacoesBasicasInserir.Destroy;
begin

  inherited;
end;

function TUsuariosValidacoesBasicasInserir.Executar: iValidacaoEntidade;
begin
  Result := Self;
  FResult := '';

  if not Assigned(FEntidade) then
  begin
    FResult := Self.QualifiedClassName + ': Nenhum dado para validar.';
    Exit;
  end;

  if FEntidade.ID <> 0 then
  begin
    FResult := MSG_ID_DEVE_SER_ZERO_NA_INSERCAO;
    Exit;
  end;
end;

class function TUsuariosValidacoesBasicasInserir.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

function TUsuariosValidacoesBasicasInserir.Result: string;
begin
  Result := FResult;
end;

end.
