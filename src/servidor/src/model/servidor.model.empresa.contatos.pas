unit servidor.model.empresa.contatos;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud, servidor.model.empresa.contatos.interfaces, 
  entidades.empresa.contatos,
  servidor.infra.repository.empresa.contatos.interfaces;

type
  TModelEmpresaContatos = class(TModelBaseCrud<TEmpresaContato>, iModelEmpresaContatos)
  private
    FRepository : iRepositoryEmpresaContatos;
  public
    constructor Create(aRepository : iRepositoryEmpresaContatos);
    destructor Destroy; override;
    class function New(aRepository : iRepositoryEmpresaContatos) : iModelEmpresaContatos;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TEmpresaContato>;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;

{ TModelEmpresaContatos }

function TModelEmpresaContatos.BuscarPorIDEmpresa(aID: integer): TObjectList<TEmpresaContato>;
begin
  try
    if Assigned(Entidades) then Entidades.DisposeOf;
    Entidades := FRepository.BuscarPorIDEmpresa(aID);
    Result := Entidades;
  except on E: Exception do
    raise ExceptionFalhaBancoDadosLeitura.Create;
  end;
end;

constructor TModelEmpresaContatos.Create(aRepository : iRepositoryEmpresaContatos);
begin
  FRepository := aRepository;
  inherited Create(aRepository);
end;

destructor TModelEmpresaContatos.Destroy;
begin

  inherited;
end;

class function TModelEmpresaContatos.New (aRepository : iRepositoryEmpresaContatos) : iModelEmpresaContatos;
begin
  Result := Self.Create(aRepository);
end;

end.
