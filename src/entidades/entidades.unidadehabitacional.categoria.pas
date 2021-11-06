unit entidades.unidadehabitacional.categoria;

interface

type
  TUnidadeHabitacionalCategoria = class
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
  UHCAT_TABELA = 'UNIDADE_HABITACIONAL_CATEGORIA';
  UHCAT_ID = 'UHC_ID';
  UHCAT_IDEMPRESA = 'UHC_ID_EMPRESA';
  UHCAT_DESCRICAO = 'UHC_DESCRICAO';
  UHCAT_ATIVO = 'UHC_ATIVO';

implementation

end.
