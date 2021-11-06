unit cliente.model.empresas;

interface

uses
  entidades.empresa,
  cliente.infra.repository.empresas.interfaces,
  validador.interfaces;

type
  TModelEmpresas = class
  private
    FRepository : iRepositoryEmpresas;
    FEntidade: TEmpresa;
    FValidador: iValidador;
  public
    constructor Create(aRepository : iRepositoryEmpresas);
    destructor Destroy; override;

    property Entidade: TEmpresa read FEntidade write FEntidade;
    property Validador: iValidador read FValidador write FValidador;
    procedure Alterar(aEmpresa : TEmpresa);
    function BuscarPorID(aID : integer) : TEmpresa;
  end;
implementation

uses
  System.SysUtils,
  validador,
  entidades.empresas.validacoes.basicas,
  shared.exceptions;

{ TModelEmpresas }

procedure TModelEmpresas.Alterar(aEmpresa: TEmpresa);
begin
  try
    FValidador.Clear;
    FValidador.Add(TEmpresaValidacoesBasicas.New);
    FValidador.Add(TEmpresaValidacoesBasicasAlterar.New);
    Fvalidador.Executar(aEmpresa);
  except on E: Exception do
    raise ExceptionValidacao.Create(E.Message);
  end;

  FRepository.Alterar(aEmpresa);
end;

function TModelEmpresas.BuscarPorID(aID: integer): TEmpresa;
begin
  if Assigned(FEntidade) then
    FEntidade.DisposeOf;

  FEntidade := FRepository.BuscarPorID(aID);
  Result := FEntidade;
end;

constructor TModelEmpresas.Create(aRepository: iRepositoryEmpresas);
begin
  FRepository := aRepository;
  FEntidade := TEmpresa.Create;
  FValidador := TValidador.Create;
end;

destructor TModelEmpresas.Destroy;
begin
  if Assigned(FEntidade) then
    FEntidade.DisposeOf;

  inherited;
end;

end.
