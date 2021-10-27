unit entidades.unidadehabitacional.caracteristicas.validacoes.base.inserir;

interface

uses
  validador.interfaces,
  entidades.unidadehabitacional.caracteristicas;

type
  TUnidadeHabitacionalCaracteristicasValidacaoBaseInserir = class(TInterfacedObject, iValidacaoEntidade)
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

{ TUnidadeHabitacionalCaracteristicasValidacaoBaseInserir }

function TUnidadeHabitacionalCaracteristicasValidacaoBaseInserir.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUnidadeHabitacionalCaracteristica(aValue);
end;

constructor TUnidadeHabitacionalCaracteristicasValidacaoBaseInserir.Create;
begin

end;

destructor TUnidadeHabitacionalCaracteristicasValidacaoBaseInserir.Destroy;
begin

  inherited;
end;

function TUnidadeHabitacionalCaracteristicasValidacaoBaseInserir.Executar: iValidacaoEntidade;
begin
  Result := Self;
  FResult := '';
  if not Assigned(FEntidade) then
  begin
    FResult := Self.QualifiedClassName + ': Nenhum dado para validar.';
    Exit;
  end;

  if FEntidade.ID <> 0 then
  begin
    FResult := 'O ID só aceita zeros.';
    Exit;
  end;
end;

class function TUnidadeHabitacionalCaracteristicasValidacaoBaseInserir.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

function TUnidadeHabitacionalCaracteristicasValidacaoBaseInserir.Result: string;
begin
  Result := FResult;
end;

end.
