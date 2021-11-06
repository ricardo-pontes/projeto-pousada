unit servidor.infra.repository.unidadehabitacional;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.unidadehabitacional.interfaces,
  servidor.infra.repository.base.crud,
  entidades.unidadehabitacional,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces;

type
  TRepositoryUnidadeHabitacionalDB = class(TRepositoryBaseCrud<TUnidadeHabitacional>, iRepositoryUnidadeHabitacional)
  private
    FConexao : iConexao;
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryUnidadeHabitacional;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacional>;
  end;

implementation

uses
  System.SysUtils, entidades.unidadehabitacional.categoria;

{ TRepositoryUnidadeHabitacionalDB }

function TRepositoryUnidadeHabitacionalDB.BuscarPorIDEmpresa(aID: integer): TObjectList<TUnidadeHabitacional>;
begin
  Result := nil;
  var lSQL := TStringBuilder.Create;
  try
    lSQL.Append('select ' + UH_TABELA + '.*, ' + UHCAT_DESCRICAO + ' from ' + UH_TABELA);
    lSQL.Append(' inner join ' + UHCAT_TABELA + ' on ' + UHCAT_ID + ' = ' + UH_ID_GRUPO);
    lSQL.Append(' where ' + UH_ID_EMPRESA + ' = ' + aID.ToString);
    FConexao.DataSet.Close.SQL(lSQL.ToString).Open;
  finally
    lSQL.DisposeOf;
  end;

  if FConexao.DataSet.RecordCount = 0 then
    Exit;

  Result := TObjectList<TUnidadeHabitacional>.Create;

  FNotacao.AddObject(Result, TUnidadeHabitacional);
  FNotacao.AddDataSet(FConexao.DataSet.DataSet);
  FNotacao.ResolveToObject;
end;

constructor TRepositoryUnidadeHabitacionalDB.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
  inherited Create(FConexao, FNotacao);
end;

destructor TRepositoryUnidadeHabitacionalDB.Destroy;
begin

  inherited;
end;

class function TRepositoryUnidadeHabitacionalDB.New(aConexao : iConexao; aNotacao : iNotacao): iRepositoryUnidadeHabitacional;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
