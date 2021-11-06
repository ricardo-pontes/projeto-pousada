unit entidades.unidadehabitacional;

interface

type
  TUnidadeHabitacional = class
  private
    FID: Int64;
    FIDEmpresa: integer;
    FDescricao: string;
    FIDGrupo: integer;
    FAtivo: string;
    FNomeGrupo: string;

  public
    property ID: Int64 read FID write FID;
    property IDEmpresa: integer read FIDEmpresa write FIDEmpresa;
    property Descricao: string read FDescricao write FDescricao;
    property IDGrupo: integer read FIDGrupo write FIDGrupo;
    property NomeGrupo: string read FNomeGrupo write FNomeGrupo;
    property Ativo: string read FAtivo write FAtivo;
  end;

const
  UH_TABELA = 'UNIDADE_HABITACIONAL';
  UH_ID = 'UH_ID';
  UH_ID_EMPRESA = 'UH_ID_EMPRESA';
  UH_DESCRICAO = 'UH_DESCRICAO';
  UH_ID_GRUPO = 'UH_ID_GRUPO';
  UH_ATIVO = 'UH_ATIVO';

implementation

end.
