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
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;

{ TRepositoryEmpresaDB }

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
