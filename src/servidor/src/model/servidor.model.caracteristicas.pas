unit servidor.model.caracteristicas;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud,
  entidades.caracteristicas,
  servidor.model.caracteristicas.interfaces,
  servidor.infra.repository.caracteristicas.interfaces;

type
  TModelCaracteristicas = class(TModelBaseCrud<TCaracteristica>, iModelCaracteristicas)
  private
    FRepository : iRepositoryCaracteristicas;
  public
    constructor Create(aRepository : iRepositoryCaracteristicas);
    destructor Destroy; override;
    class function New(aRepository : iRepositoryCaracteristicas) : iModelCaracteristicas;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TCaracteristica>;
    function Ativar(aID : integer) : string;
    function Desativar(aID : integer) : string;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions;

{ TModelCaracteristicas }

function TModelCaracteristicas.Ativar(aID: integer): string;
begin
  Result := FRepository.Ativar(aID);
end;

function TModelCaracteristicas.BuscarPorIDEmpresa(aID: integer): TObjectList<TCaracteristica>;
begin
  if Assigned(Entidades) then Entidades.DisposeOf;
  Entidades := FRepository.BuscarPorIDEmpresa(aID);
  Result := Entidades;
end;

constructor TModelCaracteristicas.Create(aRepository : iRepositoryCaracteristicas);
begin
  FRepository := aRepository;
  inherited Create(aRepository);
end;

function TModelCaracteristicas.Desativar(aID: integer): string;
begin
  Result := FRepository.Desativar(aID);
end;

destructor TModelCaracteristicas.Destroy;
begin

  inherited;
end;

class function TModelCaracteristicas.New (aRepository : iRepositoryCaracteristicas) : iModelCaracteristicas;
begin
  Result := Self.Create(aRepository);
end;

end.
