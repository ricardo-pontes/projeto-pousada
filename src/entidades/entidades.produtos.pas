unit entidades.produtos;

interface

type
  TProduto = class
  private
    FID: Int64;
    FIDEmpresa: integer;
    FDescricao: string;
    FValorCusto: Extended;
    FValorVenda: Extended;
    FIDCategoria: integer;
    FAtivo: string;
    FNomeGrupo: string;

  public
    property ID: Int64 read FID write FID;
    property IDEmpresa: integer read FIDEmpresa write FIDEmpresa;
    property Descricao: string read FDescricao write FDescricao;
    property NomeGrupo: string read FNomeGrupo write FNomeGrupo;
    property ValorCusto: Extended read FValorCusto write FValorCusto;
    property ValorVenda: Extended read FValorVenda write FValorVenda;
    property IDCategoria: integer read FIDCategoria write FIDCategoria;
    property Ativo: string read FAtivo write FAtivo;
  end;

const
  PROD_TABELA = 'PRODUTOS';

  PROD_ID = 'PROD_ID';
  PROD_ID_EMPRESA = 'PROD_ID_EMPRESA';
  PROD_DESCRICAO = 'PROD_DESCRICAO';
  PROD_VALOR_CUSTO = 'PROD_VALOR_CUSTO';
  PROD_VALOR_VENDA = 'PROD_VALOR_VENDA';
  PROD_ID_GRUPO = 'PROD_ID_GRUPO';
  PROD_ATIVO = 'PROD_ATIVO';

implementation

end.
