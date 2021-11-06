unit servidor.model.empresa;

interface

uses
  System.Generics.Collections,
  servidor.model.base.crud,
  servidor.model.empresa.interfaces,
  servidor.infra.repository.empresa.interfaces,
  entidades.empresa;

type
  TModelEmpresa = class(TModelBaseCrud<TEmpresa>, iModelEmpresa)
  private
    FRepository : iRepositoryEmpresa;
  public
    constructor Create(aRepository : iRepositoryEmpresa);
    destructor Destroy; override;
    class function New(aRepository : iRepositoryEmpresa) : iModelEmpresa;

    function BuscarPorCNPJ(aCNPJ : string) : TEmpresa;
  end;

implementation

uses
  System.SysUtils,
  shared.exceptions, entidades.empresas.validacoes.basicas;

{ TModelEmpresa }

function TModelEmpresa.BuscarPorCNPJ(aCNPJ: string): TEmpresa;
begin
  try
    Validador.Add(TEmpresaValidacoesBasicasValidarCNPJ.New(aCNPJ));
    Validador.Executar(nil);
  except on E: Exception do
    raise ExceptionValidacao.Create(E.Message);
  end;
  Result := FRepository.BuscarPorCNPJ(aCNPJ);
end;

constructor TModelEmpresa.Create(aRepository : iRepositoryEmpresa);
begin
  FRepository := aRepository;
  inherited Create(aRepository);
end;

destructor TModelEmpresa.Destroy;
begin

  inherited;
end;

class function TModelEmpresa.New (aRepository : iRepositoryEmpresa) : iModelEmpresa;
begin
  Result := Self.Create(aRepository);
end;

end.
