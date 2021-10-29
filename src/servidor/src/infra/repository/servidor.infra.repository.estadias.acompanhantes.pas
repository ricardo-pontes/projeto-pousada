unit servidor.infra.repository.estadias.acompanhantes;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces,
  entidades.estadia.acompanhante,
  servidor.infra.repository.estadias.acompanhantes.interfaces;

type
  TRepositoryEstadiasAcompanhantesDB = class(TRepositoryBaseCrud<TEstadiaAcompanhante>, iRepositoryEstadiasAcompanhantes)
  private
    FConexao : iConexao;
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryEstadiasAcompanhantes;

    function BuscarPorIDEstadia(aID : integer) : TObjectList<TEstadiaAcompanhante>;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;

{ TRepositoryEstadiasAcompanhantesDB }

function TRepositoryEstadiasAcompanhantesDB.BuscarPorIDEstadia(aID: integer): TObjectList<TEstadiaAcompanhante>;
begin
  Result := nil;
  var lSQL := 'select * from ' + ESTA_TABELA + ' where ' + ESTA_ID_ESTADIA + ' = ' + aID.ToString;
  FConexao.DataSet.Close.SQL(lSQL).Open;
  if FConexao.DataSet.RecordCount = 0 then Exit;

  Result := TObjectList<TEstadiaAcompanhante>.Create;
  FNotacao.AddObject(Result, TEstadiaAcompanhante).AddDataSet(FConexao.DataSet.DataSet).ResolveToObject;
end;

constructor TRepositoryEstadiasAcompanhantesDB.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
  inherited Create(FConexao, FNotacao);
end;

destructor TRepositoryEstadiasAcompanhantesDB.Destroy;
begin

  inherited;
end;

class function TRepositoryEstadiasAcompanhantesDB.New(aConexao : iConexao; aNotacao : iNotacao): iRepositoryEstadiasAcompanhantes;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
