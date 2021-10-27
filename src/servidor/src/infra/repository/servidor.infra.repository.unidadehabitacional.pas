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
  System.SysUtils;

{ TRepositoryUnidadeHabitacionalDB }

function TRepositoryUnidadeHabitacionalDB.BuscarPorIDEmpresa(aID: integer): TObjectList<TUnidadeHabitacional>;
begin
  Result := nil;
  FConexao.DataSet.Close.SQL('select * from UNIDADE_HABITACIONAL where UH_ID_EMPRESA = ' + aID.ToString).Open;
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
