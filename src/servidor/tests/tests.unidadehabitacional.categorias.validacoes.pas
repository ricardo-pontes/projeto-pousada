unit tests.unidadehabitacional.categorias.validacoes;

interface
uses
  DUnitX.TestFramework,
  entidades.unidadehabitacional.categoria,
  entidades.unidadehabitacional.categoria.validacoes.base.alterar,
  entidades.unidadehabitacional.categoria.validacoes.base.inserir,
  entidades.unidadehabitacional.categoria.validacoes.base;

type
  [TestFixture]
  TTestUnidadeHabitacionalCategoriaValidacoesbase = class(TObject)
  private

  public
    [Test]
    procedure InserirCorretamente;
    [Test]
    procedure IDDeveSerZeradoAoInserir;
    [Test]
    procedure IDDeveSerPreenchidoAoAlterar;
    [Test]
    procedure IDEmpresaSoPodeSerMaiorQueZero;
    [Test]
    procedure DescricaoNaoPodeSerVazio;
    [Test]
    procedure AtivoNaoPodeSerVazio;
    [Test]
    procedure AtivoSoPodeReceberLetrasSeN;
  end;

implementation

procedure TTestUnidadeHabitacionalCategoriaValidacoesbase.AtivoNaoPodeSerVazio;
begin
  var lUnidadeHabitacionalCategoria   := TUnidadeHabitacionalCategoria.Create;
  var lValidacao := TUnidadeHabitacionalCategoriaValidacaoBase.New;
  try
    lUnidadeHabitacionalCategoria.ID          := 1;
    lUnidadeHabitacionalCategoria.IDEmpresa   := 1;
    lUnidadeHabitacionalCategoria.Descricao   := 'Test';
    lUnidadeHabitacionalCategoria.Ativo       := '';
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCategoria).Executar.Result;
    Assert.AreEqual('Informe se a Categoria está ativa ou não.', lResult);
  finally
    lUnidadeHabitacionalCategoria.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalCategoriaValidacoesbase.AtivoSoPodeReceberLetrasSeN;
begin
  var lUnidadeHabitacionalCategoria   := TUnidadeHabitacionalCategoria.Create;
  var lValidacao := TUnidadeHabitacionalCategoriaValidacaoBase.New;
  try
    lUnidadeHabitacionalCategoria.ID          := 1;
    lUnidadeHabitacionalCategoria.IDEmpresa   := 1;
    lUnidadeHabitacionalCategoria.Descricao   := 'Test';
    lUnidadeHabitacionalCategoria.Ativo       := 'T';
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCategoria).Executar.Result;
    Assert.AreEqual('Só são aceitos S ou N no campo Ativo', lResult);

    lUnidadeHabitacionalCategoria.Ativo       := 'S';
    lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCategoria).Executar.Result;
    Assert.AreEqual('', lResult);

    lUnidadeHabitacionalCategoria.Ativo       := 'N';
    lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCategoria).Executar.Result;
    Assert.AreEqual('', lResult);
  finally
    lUnidadeHabitacionalCategoria.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalCategoriaValidacoesbase.DescricaoNaoPodeSerVazio;
begin
  var lUnidadeHabitacionalCategoria   := TUnidadeHabitacionalCategoria.Create;
  var lValidacao := TUnidadeHabitacionalCategoriaValidacaoBase.New;
  try
    lUnidadeHabitacionalCategoria.ID        := 1;
    lUnidadeHabitacionalCategoria.IDEmpresa := 1;
    lUnidadeHabitacionalCategoria.Descricao := '';
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCategoria).Executar.Result;
    Assert.AreEqual('A Descrição não pode ser vazia.', lResult);
  finally
    lUnidadeHabitacionalCategoria.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalCategoriaValidacoesbase.IDDeveSerPreenchidoAoAlterar;
begin
  var lUnidadeHabitacionalCategoria   := TUnidadeHabitacionalCategoria.Create;
  var lValidacao := TUnidadeHabitacionalCategoriaValidacaoBaseAlterar.New;
  try
    lUnidadeHabitacionalCategoria.ID := 0;
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCategoria).Executar.Result;
    Assert.AreEqual('O ID não pode ser zero.', lResult);
  finally
    lUnidadeHabitacionalCategoria.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalCategoriaValidacoesbase.IDDeveSerZeradoAoInserir;
begin
  var lUnidadeHabitacionalCategoria   := TUnidadeHabitacionalCategoria.Create;
  var lValidacao := TUnidadeHabitacionalCategoriaValidacaoBaseInserir.New;
  try
    lUnidadeHabitacionalCategoria.ID := 1;
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCategoria).Executar.Result;
    Assert.AreEqual('O ID só aceita zeros.', lResult);
  finally
    lUnidadeHabitacionalCategoria.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalCategoriaValidacoesbase.IDEmpresaSoPodeSerMaiorQueZero;
begin
  var lUnidadeHabitacionalCategoria   := TUnidadeHabitacionalCategoria.Create;
  var lValidacao := TUnidadeHabitacionalCategoriaValidacaoBase.New;
  try
    lUnidadeHabitacionalCategoria.ID := -1;
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCategoria).Executar.Result;
    Assert.AreEqual('O IDEmpresa é inválido.', lResult);

    lUnidadeHabitacionalCategoria.ID := 0;
    lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCategoria).Executar.Result;
    Assert.AreEqual('O IDEmpresa é inválido.', lResult);
  finally
    lUnidadeHabitacionalCategoria.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalCategoriaValidacoesbase.InserirCorretamente;
begin
  var lUnidadeHabitacionalCategoria := TUnidadeHabitacionalCategoria.Create;
  var lValidacaoBase    := TUnidadeHabitacionalCategoriaValidacaoBase.New;
  var lValidacaoInserir := TUnidadeHabitacionalCategoriaValidacaoBaseInserir.New;
  try
    lUnidadeHabitacionalCategoria.ID          := 0;
    lUnidadeHabitacionalCategoria.IDEmpresa   := 1;
    lUnidadeHabitacionalCategoria.Descricao   := 'Teste';
    lUnidadeHabitacionalCategoria.Ativo       := 'S';

    var lResult := lValidacaoBase.AddEntidade(lUnidadeHabitacionalCategoria).Executar.Result;
    Assert.AreEqual('', lResult);
    lResult := lValidacaoInserir.AddEntidade(lUnidadeHabitacionalCategoria).Executar.Result;
    Assert.AreEqual('', lResult);
  finally
    lUnidadeHabitacionalCategoria.DisposeOf;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestUnidadeHabitacionalCategoriaValidacoesbase);
end.

