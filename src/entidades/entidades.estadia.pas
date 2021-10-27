unit entidades.estadia;

interface

type
  TEstadia = class
  private
    FID: integer;
    FIDEmpresa: integer;
    FIDCliente: integer;
    FDataEntrada: TDateTime;
    FDataSaida: TDateTime;
    FDataRegistro: TDateTime;
    FValor: Extended;
    FObservacoes: string;
    FNomeCliente: string;
  public
    property ID: integer read FID write FID;
    property IDEmpresa: integer read FIDEmpresa write FIDEmpresa;
    property IDCliente: integer read FIDCliente write FIDCliente;
    property NomeCliente: string read FNomeCliente write FNomeCliente;
    property DataEntrada: TDateTime read FDataEntrada write FDataEntrada;
    property DataSaida: TDateTime read FDataSaida write FDataSaida;
    property DataRegistro: TDateTime read FDataRegistro write FDataRegistro;
    property Valor: Extended read FValor write FValor;
    property Observacoes: string read FObservacoes write FObservacoes;
  end;

const
  EST_TABELA = 'ESTADIAS';
  EST_ID = 'EST_ID';
  EST_ID_DISPLAY = 'ID';
  EST_ID_EMPRESA = 'EST_ID_EMPRESA';
  EST_ID_EMPRESA_DISPLAY = 'ID Empresa';
  EST_ID_CLIENTE = 'EST_ID_CLIENTE';
  EST_ID_CLIENTE_DISPLAY = 'ID Cliente';
  EST_DATA_ENTRADA = 'EST_DATA_ENTRADA';
  EST_DATA_ENTRADA_DISPLAY = 'Data de Entrada';
  EST_DATA_SAIDA = 'EST_DATA_SAIDA';
  EST_DATA_SAIDA_DISPLAY = 'Data de Saída';
  EST_DATA_REGISTRO = 'EST_DATA_REGISTRO';
  EST_DATA_REGISTRO_DISPLAY = 'Data de Registro';
  EST_VALOR = 'EST_VALOR';
  EST_VALOR_DISPLAY = 'Valor';
  EST_OBSERVACOES = 'EST_OBSERVACOES';
  EST_OBSERVACOES_DISPLAY = 'Observações';

implementation

end.
