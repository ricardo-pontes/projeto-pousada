unit entidades.estadia.acompanhante;

interface

type
  TEstadiaAcompanhante = class
  private
    FID: integer;
    FIDEmpresa: integer;
    FIDEstadia: integer;
    FNome: string;
    FCelular: string;

  public
    property ID: integer read FID write FID;
    property IDEmpresa: integer read FIDEmpresa write FIDEmpresa;
    property IDEstadia: integer read FIDEstadia write FIDEstadia;
    property Nome: string read FNome write FNome;
    property Celular: string read FCelular write FCelular;
  end;

const
  ESTA_TABELA = 'ESTADIA_ACOMPANHANTES';

  ESTA_ID = 'ESTA_ID';
  ESTA_ID_DISPLAY = 'ID';

  ESTA_ID_EMPRESA = 'ESTA_ID_EMPRESA';
  ESTA_ID_EMPRESA_DISPLAY = 'ID Empresa';

  ESTA_ID_ESTADIA = 'ESTA_ID_ESTADIA';
  ESTA_ID_ESTADIA_DISPLAY = 'ID Estadia';

  ESTA_NOME = 'ESTA_NOME';
  ESTA_NOME_DISPLAY = 'Nome';

  ESTA_CELULAR = 'ESTA_CELULAR';
  ESTA_CELULAR_DISPLAY = 'Celular';

implementation

end.
