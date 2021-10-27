unit entidades.grupoprodutos;

interface

type
  TGrupoProduto = class
  private
    FID: integer;
    FIDEmpresa: integer;
    FDescricao: string;
    FAtivo: string;

  public
    property ID: integer read FID write FID;
    property IDEmpresa: integer read FIDEmpresa write FIDEmpresa;
    property Descricao: string read FDescricao write FDescricao;
    property Ativo: string read FAtivo write FAtivo;
  end;

const
  PG_TABELA = 'PRODUTOS_GRUPO';
  PG_ID = 'PG_ID';
  PG_IDEMPRESA = 'PG_ID_EMPRESA';
  PG_DESCRICAO = 'PG_DESCRICAO';
  PG_ATIVO = 'PG_ATIVO';

implementation

end.
