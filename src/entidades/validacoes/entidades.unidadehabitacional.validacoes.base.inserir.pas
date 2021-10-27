unit entidades.unidadehabitacional.validacoes.base.inserir;

interface

uses
  validador.interfaces,
  entidades.unidadehabitacional;

type
  TUnidadeHabitacionalValidacaoBaseInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUnidadeHabitacional;
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

{ TUnidadeHabitacionalValidacaoBaseInserir }

function TUnidadeHabitacionalValidacaoBaseInserir.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUnidadeHabitacional(aValue);
end;

constructor TUnidadeHabitacionalValidacaoBaseInserir.Create;
begin

end;

destructor TUnidadeHabitacionalValidacaoBaseInserir.Destroy;
begin

  inherited;
end;

function TUnidadeHabitacionalValidacaoBaseInserir.Executar: iValidacaoEntidade;
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
    FResult := 'Só é aceito zero no ID.';
    Exit;
  end;
end;

class function TUnidadeHabitacionalValidacaoBaseInserir.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

function TUnidadeHabitacionalValidacaoBaseInserir.Result: string;
begin
  Result := FResult;
end;

end.
