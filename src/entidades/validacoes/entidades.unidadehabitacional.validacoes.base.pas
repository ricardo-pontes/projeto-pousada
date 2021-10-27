unit entidades.unidadehabitacional.validacoes.base;

interface

uses
  validador.interfaces, entidades.unidadehabitacional;

type
  TUnidadeHabitacionalValidacaoBase = class(TInterfacedObject, iValidacaoEntidade)
  private
    FUnidadeHabitacional : TUnidadeHabitacional;
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

{ TUnidadeHabitacionalValidacaoBase }

function TUnidadeHabitacionalValidacaoBase.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FUnidadeHabitacional := TUnidadeHabitacional(aValue);
end;

constructor TUnidadeHabitacionalValidacaoBase.Create;
begin

end;

destructor TUnidadeHabitacionalValidacaoBase.Destroy;
begin

  inherited;
end;

function TUnidadeHabitacionalValidacaoBase.Executar: iValidacaoEntidade;
begin
  Result := Self;
  FResult := '';

  if not Assigned(FUnidadeHabitacional) then
  begin
    FResult := Self.QualifiedClassName + ': Nenhum dado para validar.';
    Exit;
  end;

  if FUnidadeHabitacional.IDEmpresa <= 0 then
  begin
    FResult := 'O IDEmpresa é inválido.';
    Exit;
  end;

  if FUnidadeHabitacional.Descricao.IsEmpty then
  begin
    FResult := 'A Descrição não pode ser vazia.';
    Exit;
  end;

  if FUnidadeHabitacional.IDGrupo <= 0 then
  begin
    FResult := 'A Categoria deve ser preenchida.';
    Exit;
  end;

  if FUnidadeHabitacional.Ativo.IsEmpty then
  begin
    FResult := 'Informe se a Unidade Habitacional está ativa ou não.';
    Exit;
  end;

  if (FUnidadeHabitacional.Ativo <> 'S') and (FUnidadeHabitacional.Ativo <> 'N') then
  begin
    FResult := 'Só são aceitos S ou N no campo Ativo';
    Exit;
  end;
end;

class function TUnidadeHabitacionalValidacaoBase.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

function TUnidadeHabitacionalValidacaoBase.Result: string;
begin
  Result := FResult;
end;

end.
