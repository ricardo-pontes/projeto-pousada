unit servidor.infra.repository.unidadehabitacional.caracteristicas.db;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces,
  servidor.infra.repository.unidadehabitacional.caracteristicas.interfaces,
  entidades.unidadehabitacional.caracteristicas;

type
  TRepositoryUnidadeHabitacionalCaracteristicasDB = class(TRepositoryBaseCrud<TUnidadeHabitacionalCaracteristica>, iRepositoryUnidadeHabitacionalCaracteristicas)
  private
    FConexao : iConexao;
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryUnidadeHabitacionalCaracteristicas;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacionalCaracteristica>;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;
{ TRepositoryUnidadeHabitacionalCaracteristicasDB }

function TRepositoryUnidadeHabitacionalCaracteristicasDB.BuscarPorIDEmpresa(aID: integer): TObjectList<TUnidadeHabitacionalCaracteristica>;
begin
  Result := nil;
  var lSQL := 'select * from ' + UHCAR_TABELA + ' where ' + UHCAR_IDEMPRESA + ' = ' + aID.ToString;
  FConexao.DataSet.SQL(lSQL).Open;
  if FConexao.DataSet.RecordCount = 0 then
    Exit;

  FNotacao.AddObject(Result, TUnidadeHabitacionalCaracteristica);
  FNotacao.AddDataSet(FConexao.DataSet.DataSet);
  FNotacao.ResolveToObject;
end;

constructor TRepositoryUnidadeHabitacionalCaracteristicasDB.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
  inherited Create(FConexao, FNotacao);
end;

destructor TRepositoryUnidadeHabitacionalCaracteristicasDB.Destroy;
begin

  inherited;
end;

class function TRepositoryUnidadeHabitacionalCaracteristicasDB.New(aConexao : iConexao; aNotacao : iNotacao): iRepositoryUnidadeHabitacionalCaracteristicas;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
