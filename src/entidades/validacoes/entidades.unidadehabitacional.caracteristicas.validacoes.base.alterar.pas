unit entidades.unidadehabitacional.caracteristicas.validacoes.base.alterar;

interface

uses
  validador.interfaces,
  entidades.unidadehabitacional.caracteristicas;

type
  TUnidadeHabitacionalCaracteristicasValidacaoBaseAlterar = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUnidadeHabitacionalCaracteristica;
    FResult : string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iValidacaoEntidade;

    function AddEntidade(aValue : TObject) : iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
    function Result : string;
  end;

implementation

uses
  System.SysUtils;

{ TUnidadeHabitacionalCaracteristicasValidacaoBaseAlterar }

function TUnidadeHabitacionalCaracteristicasValidacaoBaseAlterar.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUnidadeHabitacionalCaracteristica(aValue);
end;

constructor TUnidadeHabitacionalCaracteristicasValidacaoBaseAlterar.Create;
begin

end;

destructor TUnidadeHabitacionalCaracteristicasValidacaoBaseAlterar.Destroy;
begin

  inherited;
end;

function TUnidadeHabitacionalCaracteristicasValidacaoBaseAlterar.Executar: iValidacaoEntidade;
begin
  Result := Self;
  FResult := '';
  if not Assigned(FEntidade) then
  begin
    FResult := Self.QualifiedClassName + ': Nenhum dado para validar.';
    Exit;
  end;

  if FEntidade.ID = 0 then
  begin
    FResult := 'O ID n?o pode ser zero.';
    Exit;
  end;
end;

class function TUnidadeHabitacionalCaracteristicasValidacaoBaseAlterar.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

function TUnidadeHabitacionalCaracteristicasValidacaoBaseAlterar.Result: string;
begin
  Result := FResult;
end;

end.
