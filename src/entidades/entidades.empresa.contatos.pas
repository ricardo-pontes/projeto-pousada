unit entidades.empresa.contatos;

interface

uses
  entidades.contatos;

type
  TEmpresaContato = class(TContato)
  private
    FIDEmpresa : integer;
  public
    property IDEmpresa: integer read FIDEmpresa write FIDEmpresa;
  end;

const
  EMPC_TABELA = 'EMPRESSA_CONTATOS';
  EMPC_ID = 'EMPC_ID';
  EMPC_IDEMPRESA = 'EMPC_ID_EMPRESA';
  EMPC_TIPO_CONTATO = 'EMPC_TIPO_CONTATO';
  EMPC_DESCRICAO = 'EMPC_DESCRICAO';

implementation

end.
