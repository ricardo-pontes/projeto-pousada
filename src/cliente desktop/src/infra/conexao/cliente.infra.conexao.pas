unit cliente.infra.conexao;

interface

uses
  cliente.infra.conexao.interfaces,
  RESTRequest4D;

type
  TConexoes = class(TInterfacedObject, iConexoes)
  private

  public
    constructor Create;
    destructor Destroy; override;
    class function New : iConexoes;

    function Conexao : iRequest;
  end;

implementation

{ TConexoes }

function TConexoes.Conexao: iRequest;
begin
  result := TRequest.New.BaseURL('http://localhost:9000/api/v1').AcceptEncoding('gzip').ContentType('application/json; charset=utf-8');
end;

constructor TConexoes.Create;
begin

end;

destructor TConexoes.Destroy;
begin

  inherited;
end;

class function TConexoes.New : iConexoes;
begin
  Result := Self.Create;
end;

end.
