unit entidades.unidadehabitacional.categoria.validacoes.base.inserir;

interface

uses
  validador.interfaces,
  entidades.unidadehabitacional.categoria;

type
  TUnidadeHabitacionalCategoriaValidacaoBaseInserir = class(TInterfacedObject, iValidacaoEntidade)
  private
    FEntidade : TUnidadeHabitacionalCategoria;
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

{ TUnidadeHabitacionalCategoriaValidacaoBaseInserir }

function TUnidadeHabitacionalCategoriaValidacaoBaseInserir.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUnidadeHabitacionalCategoria(aValue);
end;

constructor TUnidadeHabitacionalCategoriaValidacaoBaseInserir.Create;
begin

end;

destructor TUnidadeHabitacionalCategoriaValidacaoBaseInserir.Destroy;
begin

  inherited;
end;

function TUnidadeHabitacionalCategoriaValidacaoBaseInserir.Executar: iValidacaoEntidade;
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

class function TUnidadeHabitacionalCategoriaValidacaoBaseInserir.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

function TUnidadeHabitacionalCategoriaValidacaoBaseInserir.Result: string;
begin
  Result := FResult;
end;

end.
