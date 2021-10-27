unit servidor.infra.repository.unidadehabitacional.categoria;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces,
  servidor.infra.repository.unidadehabitacional.categoria.interfaces,
  entidades.unidadehabitacional.categoria;

type
  TRepositoryUnidadeHabitacionalCategoria = class(TRepositoryBaseCrud<TUnidadeHabitacionalCategoria>, iRepositoryUnidadeHabitacionalCategoria)
  private
    FConexao : iConexao;
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryUnidadeHabitacionalCategoria;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacionalCategoria>;
  end;

implementation

uses
  System.SysUtils;

{ TRepositoryUnidadeHabitacionalCategoria }

function TRepositoryUnidadeHabitacionalCategoria.BuscarPorIDEmpresa(aID: integer): TObjectList<TUnidadeHabitacionalCategoria>;
begin
  Result := nil;
  var lSQL := 'select * from UNIDADE_HABITACIONAL_CATEGORIA WHERE UHC_ID = ' + aID.ToString;
  FConexao.DataSet.Close.SQL(lSQL).Open;
  if FConexao.DataSet.RecordCount = 0 then
    Exit;

  Result := TObjectList<TUnidadeHabitacionalCategoria>.Create;
  FNotacao.AddObject(Result, TUnidadeHabitacionalCategoria).AddDataSet(FConexao.DataSet.DataSet).ResolveToObject;
end;

constructor TRepositoryUnidadeHabitacionalCategoria.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
  inherited Create(FConexao, FNotacao);
end;

destructor TRepositoryUnidadeHabitacionalCategoria.Destroy;
begin

  inherited;
end;

class function TRepositoryUnidadeHabitacionalCategoria.New(aConexao : iConexao; aNotacao : iNotacao): iRepositoryUnidadeHabitacionalCategoria;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
