unit servidor.infra.repository.estadias;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces,
  servidor.infra.repository.estadias.interfaces,
  entidades.estadia;

type
  TRepositoryEstadiasDB = class(TRepositoryBaseCrud<TEstadia>, iRepositoryEstadias)
  private
    FConexao : iConexao;
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryEstadias;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TEstadia>;
  end;

implementation

uses
  System.SysUtils,
  servidor.exceptions;

{ TRepositoryEstadiasDB }

function TRepositoryEstadiasDB.BuscarPorIDEmpresa(
  aID: integer): TObjectList<TEstadia>;
begin
  Result := nil;
  var lSQL := 'select * from ' + EST_TABELA + ' where ' + EST_ID_EMPRESA + ' = ' + aID.ToString;
  FConexao.DataSet.SQL(lSQL).Open;
  if FConexao.DataSet.RecordCount = 0 then
    Exit;

  FNotacao.AddObject(Result, TEstadia).AddDataSet(FConexao.DataSet.DataSet).ResolveToObject;
end;

constructor TRepositoryEstadiasDB.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
  inherited Create(FConexao, FNotacao);
end;

destructor TRepositoryEstadiasDB.Destroy;
begin

  inherited;
end;

class function TRepositoryEstadiasDB.New(aConexao : iConexao; aNotacao : iNotacao): iRepositoryEstadias;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
