unit entidades.unidadehabitacional.categoria.validacoes.base.alterar;

interface

uses
  validador.interfaces,
  entidades.unidadehabitacional.categoria;

type
  TUnidadeHabitacionalCategoriaValidacaoBaseAlterar = class(TInterfacedObject, iValidacaoEntidade)
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

{ TUnidadeHabitacionalCategoriaValidacaoBaseAlterar }

function TUnidadeHabitacionalCategoriaValidacaoBaseAlterar.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUnidadeHabitacionalCategoria(aValue);
end;

constructor TUnidadeHabitacionalCategoriaValidacaoBaseAlterar.Create;
begin

end;

destructor TUnidadeHabitacionalCategoriaValidacaoBaseAlterar.Destroy;
begin

  inherited;
end;

function TUnidadeHabitacionalCategoriaValidacaoBaseAlterar.Executar: iValidacaoEntidade;
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
    FResult := 'O ID não pode ser zero.';
    Exit;
  end;
end;

class function TUnidadeHabitacionalCategoriaValidacaoBaseAlterar.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

function TUnidadeHabitacionalCategoriaValidacaoBaseAlterar.Result: string;
begin
  Result := FResult;
end;

end.
