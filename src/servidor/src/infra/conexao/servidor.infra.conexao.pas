unit servidor.infra.conexao;

interface

uses
  servidor.infra.conexao.interfaces,
  Orion.Data.Interfaces;

type
  TConexaoFactory = class(TInterfacedObject, iConexaoFactory)
  private

  public
    constructor Create;
    destructor Destroy; override;
    class function New : iConexaoFactory;

    function Conexao : iConexao;
    function Dataset(aConexao : iConexao) : iDataSet;

  end;

implementation

uses
  Orion.Data.Factory.FireDAC;

{ TConexaoFactory }

function TConexaoFactory.Conexao: iConexao;
begin
  Result := TOrionDataFactoryFireDAC.New.Conexao;
  Result.Parametros
          .CaminhoBanco('E:\Projetos\Pousada\projeto-pousada\Banco de Dados\DB_POUSADA.FDB')
          .UserName('SYSDBA')
          .Senha('masterkey')
          .Porta(3050)
          .TipoBanco(tpFirebird30)
        .EndParametros;
end;

constructor TConexaoFactory.Create;
begin

end;

function TConexaoFactory.Dataset(aConexao: iConexao): iDataSet;
begin
  Result := TOrionDataFactoryFireDAC.New.Query(aConexao);
end;

destructor TConexaoFactory.Destroy;
begin

  inherited;
end;

class function TConexaoFactory.New : iConexaoFactory;
begin
  Result := Self.Create;
end;

end.
