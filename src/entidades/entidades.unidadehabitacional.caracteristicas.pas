unit entidades.unidadehabitacional.caracteristicas;

interface

type
  TUnidadeHabitacionalCaracteristica = class
  private
    FID: Int64;
    FIDEmpresa: integer;
    FDescricao: string;
    FAtivo: string;
    FIDCaracteristica: integer;

  public
    property ID: Int64 read FID write FID;
    property IDCaracteristica: integer read FIDCaracteristica write FIDCaracteristica;
    property IDEmpresa: integer read FIDEmpresa write FIDEmpresa;
    property Descricao: string read FDescricao write FDescricao;
    property Ativo: string read FAtivo write FAtivo;
  end;

const
  UHCAR_TABELA = 'UNIDADE_HABITACIONAL_CARACTERISTICAS';
  UHCAR_ID = 'UHCAR_ID';
  UHCAR_IDCARACTERISTICA = 'UHCAR_ID_CARACTERISTICA';
  UHCAR_IDEMPRESA = 'UHCAR_ID_EMPRESA';
  UHCAR_DESCRICAO = 'UHCAR_DESCRICAO';
  UHCAR_ATIVO = 'UHCAR_ATIVO';

implementation

end.
