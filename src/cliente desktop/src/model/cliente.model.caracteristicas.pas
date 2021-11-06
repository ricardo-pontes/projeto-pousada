unit cliente.model.caracteristicas;

interface

uses
  System.Generics.Collections,
  cliente.model.base,
  entidades.caracteristicas,
  cliente.infra.repository.caracteristicas.interfaces;

type
  TModelCaracteristicas = class(TModelBase<TCaracteristica>)
  private
    FRepository : iRepositoryCaracteristicas;
  public
    constructor Create(aRepository : iRepositoryCaracteristicas);
    destructor Destroy; override;

    procedure Alterar(aProduto : TCaracteristica); override;
    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TCaracteristica>;
    procedure Inserir(aProduto : TCaracteristica); override;
    procedure Ativar(aID : integer);
    procedure Desativar(aID : integer);
  end;
implementation

{ TModelCaracteristicas }

uses
  System.SysUtils,
  entidades.caracteristicas.validacoes.basicas;

procedure TModelCaracteristicas.Alterar(aProduto: TCaracteristica);
begin
  Validador.Clear;
  Validador.Add(TCaracteristicasValidacoesBasicas.New);
  Validador.Add(TCaracteristicasValidacoesBasicasAlterar.New);
  inherited;
end;

procedure TModelCaracteristicas.Ativar(aID: integer);
begin
  FRepository.Ativar(aID.ToString);
end;

function TModelCaracteristicas.BuscarPorIDEmpresa(aID: integer): TObjectList<TCaracteristica>;
begin
  if Assigned(Entidades) then Entidades.DisposeOf;
  Entidades := FRepository.BuscarPorIDEmpresa(aID.ToString);
  Result := Entidades;
end;

constructor TModelCaracteristicas.Create(aRepository: iRepositoryCaracteristicas);
begin
  FRepository := aRepository;
  inherited Create(FRepository);
end;

procedure TModelCaracteristicas.Desativar(aID: integer);
begin
  FRepository.Desativar(aID.ToString);
end;

destructor TModelCaracteristicas.Destroy;
begin

  inherited;
end;

procedure TModelCaracteristicas.Inserir(aProduto: TCaracteristica);
begin
  Validador.Clear;
  Validador.Add(TCaracteristicasValidacoesBasicas.New);
  Validador.Add(TCaracteristicasValidacoesBasicasInserir.New);
  inherited;
end;

end.
