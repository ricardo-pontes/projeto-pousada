unit entidades.clientes;

interface

uses
  entidades.pessoa;

type
  TClientePF = class(TPessoaFisica)
  private
    FIDEmpresa: integer;

  public
    property IDEmpresa: integer read FIDEmpresa write FIDEmpresa;
  end;

const
  CLI_TABELA = 'PESSOAS';
  CLI_ID = 'PES_ID';
  CLI_ID_EMPRESA = 'PES_ID_EMPRESA';
  CLI_NOME = 'PES_NOME_COMPLETO';
  CLI_CPF = 'PES_CNPJ_CPF';
  CLI_RG = 'PES_RG';
  CLI_EMAIL = 'PES_EMAIL';
  CLI_DATA_NASCIMENTO = 'PES_DATA_NASCIMENTO';
  CLI_TELEFONE = 'PES_TELEFONE';
  CLI_CELULAR = 'PES_CELULAR';
  CLI_DATA_CADASTRO = 'PES_DATA_CADASTRO';
  CLI_LOGRADOURO = 'PES_LOGRADOURO';
  CLI_NUMERO = 'PES_NUMERO';
  CLI_BAIRRO = 'PES_BAIRRO';
  CLI_CIDADE = 'PES_CIDADE';
  CLI_UF = 'PES_UF';
  CLI_CEP = 'PES_CEP';

implementation

end.
