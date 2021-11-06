unit servidor.infra.repository.empresa;

interface

uses
  System.Generics.Collections,
  servidor.infra.repository.base.crud,
  Orion.Data.Interfaces,
  conversores.notacoes.interfaces,
  servidor.infra.repository.empresa.interfaces,
  entidades.empresa;

type
  TRepositoryEmpresaDB = class(TRepositoryBaseCrud<TEmpresa>, iRepositoryEmpresa)
  private
    FConexao : iConexao;
    FNotacao : iNotacao;
  public
    constructor Create(aConexao : iConexao; aNotacao : iNotacao);
    destructor Destroy; override;
    class function New(aConexao : iConexao; aNotacao : iNotacao) : iRepositoryEmpresa;

    function BuscarPorCNPJ(aCNPJ : string) : TEmpresa;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;

{ TRepositoryEmpresaDB }

function TRepositoryEmpresaDB.BuscarPorCNPJ(aCNPJ: string): TEmpresa;
begin
  var lSQL := 'select * from ' + EMP_TABELA + ' where ' + EMP_CNPJ + ' = ' + aCNPJ;
  FConexao.DataSet.SQL(lSQL).Open;
  if FConexao.DataSet.RecordCount = 0 then
    Exit;

  Result := TEmpresa.Create;
  FNotacao.AddObject(Result, TEmpresa).AddDataSet(FConexao.DataSet.DataSet).ResolveToObject;
end;

constructor TRepositoryEmpresaDB.Create(aConexao : iConexao; aNotacao : iNotacao);
begin
  FConexao := aConexao;
  FNotacao := aNotacao;
  inherited Create(FConexao, FNotacao);
end;

destructor TRepositoryEmpresaDB.Destroy;
begin

  inherited;
end;

class function TRepositoryEmpresaDB.New(aConexao : iConexao; aNotacao : iNotacao): iRepositoryEmpresa;
begin
  Result := Self.Create(aConexao, aNotacao);
end;

end.
