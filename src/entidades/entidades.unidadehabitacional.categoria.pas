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
  UHC_TABELA = 'UNIDADE_HABITACIONAL_CATEGORIA';
  UHC_ID = 'UHC_ID';
  UHC_IDEMPRESA = 'UHC_ID_EMPRESA';
  UHC_DESCRICAO = 'UHC_DESCRICAO';
  UHC_ATIVO = 'UHC_ATIVO';

implementation

end.
