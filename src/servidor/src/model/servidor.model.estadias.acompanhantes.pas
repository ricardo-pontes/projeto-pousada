unit servidor.model.estadias.acompanhantes;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud, entidades.estadia.acompanhante,
  servidor.model.estadias.acompanhantes.interfaces,
  servidor.infra.repository.estadias.acompanhantes.interfaces;

type
  TModelEstadiasAcompanhantes = class(TModelBaseCrud<TEstadiaAcompanhante>, iModelEstadiasAcompanhantes)
  private
    FRepository : iRepositoryEstadiasAcompanhantes;
  public
    constructor Create(aRepository : iRepositoryEstadiasAcompanhantes);
    destructor Destroy; override;
    class function New(aRepository : iRepositoryEstadiasAcompanhantes) : iModelEstadiasAcompanhantes;

    function BuscarPorIDEstadia(aID : integer) : TObjectList<TEstadiaAcompanhante>;
  end;

implementation

uses
  System.SysUtils,
  servidor.exceptions;

{ TModelEstadiasAcompanhantes }

function TModelEstadiasAcompanhantes.BuscarPorIDEstadia(aID: integer): TObjectList<TEstadiaAcompanhante>;
begin
  try
    if Assigned(Entidades) then Entidades.DisposeOf;
    Entidades := FRepository.BuscarPorIDEstadia(aID);
    Result := Entidades;
  except on E: Exception do
    raise ExceptionFalhaBancoDadosLeitura.Create;
  end;
end;

constructor TModelEstadiasAcompanhantes.Create(aRepository : iRepositoryEstadiasAcompanhantes);
begin
  FRepository := aRepository;
  inherited Create(aRepository);
end;

destructor TModelEstadiasAcompanhantes.Destroy;
begin

  inherited;
end;

class function TModelEstadiasAcompanhantes.New (aRepository : iRepositoryEstadiasAcompanhantes) : iModelEstadiasAcompanhantes;
begin
  Result := Self.Create(aRepository);
end;

end.
