
unit entidades.usuarios.validacoes.basicas;

interface

uses
  validador.interfaces, entidades.usuario;

type
  TUsuariosValidacoesBasicas = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUsuario;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TUsuariosValidacoesBasicasAlterar = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUsuario;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TUsuariosValidacoesBasicasInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUsuario;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  TUsuariosValidacoesBasicasLogin = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUsuario;
    FEmail : string;
    FSenha : string;
  public
    constructor Create(aEmail, aSenha : string);
    destructor Destroy; override;
    class function New(aEmail, aSenha : string) : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

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
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.IDEmpresa, 'ID Empresa');
  TValidacoes.StringNaoPodeSerVaziaEDeveConterXCaracteres(FEntidade.Email, 200, 'Email');
  TValidacoes.StringNaoPodeSerVaziaEDeveConterXCaracteres(FEntidade.Senha, 20, 'Senha');
  TValidacoes.StringNaoPodeSerVaziaEDeveConterXCaracteres(FEntidade.Nome, 200, 'Nome');
  if FEntidade.Nome.Trim <> 'Administrador' then
  begin
    TValidacoes.StringNaoPodeSerVaziaEDeveConterXCaracteres(FEntidade.SobreNome, 200, 'Nome');
    TValidacoes.DataNaoPodeSerVaziaNemExcederDataHoje(FEntidade.DataNascimento, 'Data de Nascimento');
    TValidacoes.DataNaoPodeSerVaziaNemExcederDataHoje(FEntidade.DataCadastro, 'Data de Nascimento');
  end;
end;

class function TUsuariosValidacoesBasicas.New : iValidacaoEntidade;
begin
  Result := Self.Create;
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
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroSoPodeSerZero(FEntidade.ID, 'ID');;
end;

class function TUsuariosValidacoesBasicasInserir.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

{ TUsuariosValidacoesBasicasLogin }

function TUsuariosValidacoesBasicasLogin.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUsuario(aValue);
end;

constructor TUsuariosValidacoesBasicasLogin.Create(aEmail, aSenha : string);
begin
  FEmail := aEmail;
  FSenha := aSenha;
end;

destructor TUsuariosValidacoesBasicasLogin.Destroy;
begin

  inherited;
end;

function TUsuariosValidacoesBasicasLogin.Executar: iValidacaoEntidade;
begin
  TValidacoes.StringNaoPodeSerVazia(FEmail, 'Email');
  TValidacoes.StringNaoPodeSerVaziaEDeveConterXCaracteres(FSenha, 20, 'Senha');
  TValidacoes.EmailValido(FEmail);
end;

class function TUsuariosValidacoesBasicasLogin.New(aEmail, aSenha : string) : iValidacaoEntidade;
begin
  Result := Self.Create(aEmail, aSenha);
end;

{ TUsuariosValidacoesBasicasAlterar }

function TUsuariosValidacoesBasicasAlterar.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUsuario(aValue);
end;

constructor TUsuariosValidacoesBasicasAlterar.Create;
begin

end;

destructor TUsuariosValidacoesBasicasAlterar.Destroy;
begin

  inherited;
end;

function TUsuariosValidacoesBasicasAlterar.Executar: iValidacaoEntidade;
begin
  if not Assigned(FEntidade) then
    raise Exception.Create(Self.QualifiedClassName + ': Nenhum dado para validar.');

  TValidacoes.NumeroDeveSerMaiorQueZero(FEntidade.ID, 'ID');
end;

class function TUsuariosValidacoesBasicasAlterar.New: iValidacaoEntidade;
begin
  Result := Self.Create;
end;

end.
