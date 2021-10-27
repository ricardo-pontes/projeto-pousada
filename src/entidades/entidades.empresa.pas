unit entidades.empresa;

interface

uses
  entidades.empresa.contatos,
  entidades.endereco,
  System.Generics.Collections,
  entidades.pessoa;

type
  TEmpresa = class(TPessoaJuridica)
  private

  public
    constructor Create;
    destructor Destroy; override;
  end;

const
  EMP_TABELA = 'EMPRESA';
  EMP_ID = 'EMP_ID';
  EMP_RAZAO_SOCIAL = 'EMP_RAZAO_SOCIAL';
  EMP_NOME_FANTASIA = 'EMP_NOME_FANTASIA';
  EMP_CNPJ = 'EMP_CNPJ';
  EMP_EMAIL = 'EMP_EMAIL';
  EMP_SITE = 'EMP_SITE';
  EMP_TELEFONE = 'EMP_TELEFONE';
  EMP_DATA_CADASTRO = 'EMP_DATA_CADASTRO';
  EMP_LOGRADOURO = 'EMP_LOGRADOURO';
  EMP_NUMERO = 'EMP_NUMERO';
  EMP_BAIRRO = 'EMP_BAIRRO';
  EMP_CIDADE = 'EMP_CIDADE';
  EMP_UF = 'EMP_UF';
  EMP_CEP = 'EMP_CEP';

implementation

{ TEmpresa }

constructor TEmpresa.Create;
begin

end;

destructor TEmpresa.Destroy;
begin
  inherited;
end;

end.
