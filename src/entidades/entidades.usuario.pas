unit entidades.usuario;

interface

uses
  entidades.pessoa;

type
  TUsuario = class(TPessoaFisica)
  private
    FSenha: string;
    FIDEmpresa: integer;
  public
    property IDEmpresa: integer read FIDEmpresa write FIDEmpresa;
    property Senha: string read FSenha write FSenha;
  end;

const
  USU_TABELA = 'USUARIOS';
  USU_ID = 'USU_ID';
  USU_ID_EMPRESA = 'USU_ID_EMPRESA';
  USU_NOME = 'USU_NOME';
  USU_SOBRENOME = 'USU_SOBRENOME';
  USU_CPF = 'USU_CPF';
  USU_RG = 'USU_RG';
  USU_EMAIL = 'USU_EMAIL';
  USU_SENHA = 'USU_SENHA';
  USU_DATA_NASCIMENTO = 'USU_DATA_NASCIMENTO';
  USU_TELEFONE = 'USU_TELEFONE';
  USU_DATA_CADASTRO = 'USU_DATA_CADASTRO';
  USU_LOGRADOURO = 'USU_LOGRADOURO';
  USU_NUMERO = 'USU_NUMERO';
  USU_BAIRRO = 'USU_BAIRRO';
  USU_CIDADE = 'USU_CIDADE';
  USU_UF = 'USU_UF';
  USU_CEP = 'USU_CEP';
  USU_ATIVO = 'USU_ATIVO';

implementation

end.
