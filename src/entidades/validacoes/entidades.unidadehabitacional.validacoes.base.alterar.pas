unit entidades.unidadehabitacional.validacoes.base.alterar;

interface

uses
  validador.interfaces, entidades.unidadehabitacional;

type
  TUnidadeHabitacionalValidacaoBaseAlterar = class(TInterfacedObject, iValidacaoEntidade)
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

{ TUnidadeHabitacionalValidacaoBaseAlterar }

function TUnidadeHabitacionalValidacaoBaseAlterar.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUnidadeHabitacional(aValue);
end;

constructor TUnidadeHabitacionalValidacaoBaseAlterar.Create;
begin

end;

destructor TUnidadeHabitacionalValidacaoBaseAlterar.Destroy;
begin

  inherited;
end;

function TUnidadeHabitacionalValidacaoBaseAlterar.Executar: iValidacaoEntidade;
begin
  Result := Self;
  FResult := '';
  if not Assigned(FEntidade) then
  begin
    FResult := Self.QualifiedClassName + ': Nenhum dado para validar.';
  end;

  if FEntidade.ID = 0 then
  begin
    FResult := 'O ID n�o pode ser zero.';
    Exit;
  end;
end;

class function TUnidadeHabitacionalValidacaoBaseAlterar.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

function TUnidadeHabitacionalValidacaoBaseAlterar.Result: string;
begin
  Result := FResult;
end;

end.
