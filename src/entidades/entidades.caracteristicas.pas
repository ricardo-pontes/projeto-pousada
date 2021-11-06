unit entidades.caracteristicas;

interface

type
  TCaracteristica = class
  private
    FID: integer;
    FDescricao: string;
    FAtivo: string;
    FIDEmpresa: integer;

  public
    property ID: integer read FID write FID;
    property IDEmpresa: integer read FIDEmpresa write FIDEmpresa;
    property Descricao: string read FDescricao write FDescricao;
    property Ativo: string read FAtivo write FAtivo;
  end;

const
  CAT_TABELA = 'CATEGORIAS';
  CAT_ID = 'CAT_ID';
  CAT_ID_EMPRESA = 'CAT_ID_EMPRESA';
  CAT_DESCRICAO = 'CAT_DESCRICAO';
  CAT_ATIVO = 'CAT_ATIVO';

implementation

end.
