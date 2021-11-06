unit cliente.model.unidadeshabitacionais;

interface

uses
  System.Generics.Collections,
  cliente.model.base,
  entidades.unidadehabitacional,
  cliente.infra.repository.unidadehabitacional.interfaces;

type
  TModelUnidadesHabitacionais = class(TModelBase<TUnidadeHabitacional>)
  private
    FRepository : iRepositoryUnidadesHabitacionais;
  public
    constructor Create(aRepository : iRepositoryUnidadesHabitacionais);
    destructor Destroy; override;

    function BuscarPorIDEmpresa(aID : integer) : TObjectList<TUnidadeHabitacional>;
    procedure Alterar(aEntidade : TUnidadeHabitacional); override;
    procedure Inserir(aEntidade : TUnidadeHabitacional); override;
  end;
implementation

{ TModelUnidadesHabitacionais }

uses entidades.unidadehabitacional.validacoes.base;

procedure TModelUnidadesHabitacionais.Alterar(aEntidade: TUnidadeHabitacional);
begin
  Validador.Add(TUnidadesHabitacionaisValidacoesBasicas.New);
  Validador.Add(TUnidadesHabitacionaisValidacoesBasicasAlterar.New);
  inherited;
end;

function TModelUnidadesHabitacionais.BuscarPorIDEmpresa(aID: integer): TObjectList<TUnidadeHabitacional>;
begin
  if Assigned(Entidades) then
    Entidades.DisposeOf;

  Entidades := FRepository.BuscarPorIDEmpresa(aID);
  Result := Entidades;
end;

constructor TModelUnidadesHabitacionais.Create(aRepository: iRepositoryUnidadesHabitacionais);
begin
  FRepository := aRepository;
end;

destructor TModelUnidadesHabitacionais.Destroy;
begin

  inherited;
end;

procedure TModelUnidadesHabitacionais.Inserir(aEntidade: TUnidadeHabitacional);
begin
  Validador.Add(TUnidadesHabitacionaisValidacoesBasicas.New);
  Validador.Add(TUnidadesHabitacionaisValidacoesBasicasInserir.New);
  inherited;
end;

end.
