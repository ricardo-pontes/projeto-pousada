unit entidades.unidadehabitacional.categoria.validacoes.base;

interface

uses
  validador.interfaces,
  entidades.unidadehabitacional.categoria;

type
  TUnidadeHabitacionalCategoriaValidacaoBase = class(TInterfacedObject, iValidacaoEntidade)
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

{ TUnidadeHabitacionalCategoriaValidacaoBase }

function TUnidadeHabitacionalCategoriaValidacaoBase.AddEntidade(aValue: TObject): iValidacaoEntidade;
begin
  Result := Self;
  FEntidade := TUnidadeHabitacionalCategoria(aValue);
end;

constructor TUnidadeHabitacionalCategoriaValidacaoBase.Create;
begin

end;

destructor TUnidadeHabitacionalCategoriaValidacaoBase.Destroy;
begin

  inherited;
end;

function TUnidadeHabitacionalCategoriaValidacaoBase.Executar: iValidacaoEntidade;
begin
  Result := Self;
  FResult := '';
  if not Assigned(FEntidade) then
  begin
    FResult := Self.QualifiedClassName + ': Nenhum dado para validar.';
    Exit;
  end;

  if FEntidade.IDEmpresa <= 0 then
  begin
    FResult := 'O IDEmpresa é inválido.';
    Exit;
  end;

  if FEntidade.Descricao.IsEmpty then
  begin
    FResult := 'A Descrição não pode ser vazia.';
    Exit;
  end;

  if FEntidade.Ativo.IsEmpty then
  begin
    FResult := 'Informe se a Categoria está ativa ou não.';
    Exit;
  end;

  if (FEntidade.Ativo <> 'S') and (FEntidade.Ativo <> 'N') then
  begin
    FResult := 'Só são aceitos S ou N no campo Ativo';
    Exit;
  end;

end;

class function TUnidadeHabitacionalCategoriaValidacaoBase.New : iValidacaoEntidade;
begin
  Result := Self.Create;
end;

function TUnidadeHabitacionalCategoriaValidacaoBase.Result: string;
begin
  Result := FResult;
end;

end.
