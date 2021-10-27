unit tests.unidadehabitacional.caracteristicas.validacoes;

interface
uses
  DUnitX.TestFramework,
  entidades.unidadehabitacional.caracteristicas,
  entidades.unidadehabitacional.caracteristicas.validacoes.base.alterar,
  entidades.unidadehabitacional.caracteristicas.validacoes.base.inserir,
  entidades.unidadehabitacional.caracteristicas.validacoes.base;

type
  [TestFixture]
  TTestUnidadeHabitacionalCaracteristicasValidacoesbase = class(TObject)
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

procedure TTestUnidadeHabitacionalCaracteristicasValidacoesbase.AtivoNaoPodeSerVazio;
begin
  var lUnidadeHabitacionalCaracteristica   := TUnidadeHabitacionalCaracteristica.Create;
  var lValidacao := TUnidadeHabitacionalCaracteristicasValidacaoBase.New;
  try
    lUnidadeHabitacionalCaracteristica.ID          := 1;
    lUnidadeHabitacionalCaracteristica.IDEmpresa   := 1;
    lUnidadeHabitacionalCaracteristica.Descricao   := 'Test';
    lUnidadeHabitacionalCaracteristica.Ativo       := '';
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCaracteristica).Executar.Result;
    Assert.AreEqual('Informe se a Característica está ativa ou não.', lResult);
  finally
    lUnidadeHabitacionalCaracteristica.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalCaracteristicasValidacoesbase.AtivoSoPodeReceberLetrasSeN;
begin
  var lUnidadeHabitacionalCaracteristica   := TUnidadeHabitacionalCaracteristica.Create;
  var lValidacao := TUnidadeHabitacionalCaracteristicasValidacaoBase.New;
  try
    lUnidadeHabitacionalCaracteristica.ID          := 1;
    lUnidadeHabitacionalCaracteristica.IDEmpresa   := 1;
    lUnidadeHabitacionalCaracteristica.Descricao   := 'Test';
    lUnidadeHabitacionalCaracteristica.Ativo       := 'T';
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCaracteristica).Executar.Result;
    Assert.AreEqual('Só são aceitos S ou N no campo Ativo', lResult);

    lUnidadeHabitacionalCaracteristica.Ativo       := 'S';
    lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCaracteristica).Executar.Result;
    Assert.AreEqual('', lResult);

    lUnidadeHabitacionalCaracteristica.Ativo       := 'N';
    lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCaracteristica).Executar.Result;
    Assert.AreEqual('', lResult);
  finally
    lUnidadeHabitacionalCaracteristica.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalCaracteristicasValidacoesbase.DescricaoNaoPodeSerVazio;
begin
  var lUnidadeHabitacionalCaracteristica   := TUnidadeHabitacionalCaracteristica.Create;
  var lValidacao := TUnidadeHabitacionalCaracteristicasValidacaoBase.New;
  try
    lUnidadeHabitacionalCaracteristica.ID        := 1;
    lUnidadeHabitacionalCaracteristica.IDEmpresa := 1;
    lUnidadeHabitacionalCaracteristica.Descricao := '';
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCaracteristica).Executar.Result;
    Assert.AreEqual('A Descrição não pode ser vazia.', lResult);
  finally
    lUnidadeHabitacionalCaracteristica.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalCaracteristicasValidacoesbase.IDDeveSerPreenchidoAoAlterar;
begin
  var lUnidadeHabitacionalCaracteristica   := TUnidadeHabitacionalCaracteristica.Create;
  var lValidacao := TUnidadeHabitacionalCaracteristicasValidacaoBaseAlterar.New;
  try
    lUnidadeHabitacionalCaracteristica.ID := 0;
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCaracteristica).Executar.Result;
    Assert.AreEqual('O ID não pode ser zero.', lResult);
  finally
    lUnidadeHabitacionalCaracteristica.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalCaracteristicasValidacoesbase.IDDeveSerZeradoAoInserir;
begin
  var lUnidadeHabitacionalCaracteristica   := TUnidadeHabitacionalCaracteristica.Create;
  var lValidacao := TUnidadeHabitacionalCaracteristicasValidacaoBaseInserir.New;
  try
    lUnidadeHabitacionalCaracteristica.ID := 1;
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCaracteristica).Executar.Result;
    Assert.AreEqual('O ID só aceita zeros.', lResult);
  finally
    lUnidadeHabitacionalCaracteristica.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalCaracteristicasValidacoesbase.IDEmpresaSoPodeSerMaiorQueZero;
begin
  var lUnidadeHabitacionalCaracteristica   := TUnidadeHabitacionalCaracteristica.Create;
  var lValidacao := TUnidadeHabitacionalCaracteristicasValidacaoBase.New;
  try
    lUnidadeHabitacionalCaracteristica.ID := -1;
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCaracteristica).Executar.Result;
    Assert.AreEqual('O IDEmpresa é inválido.', lResult);

    lUnidadeHabitacionalCaracteristica.ID := 0;
    lResult := lValidacao.AddEntidade(lUnidadeHabitacionalCaracteristica).Executar.Result;
    Assert.AreEqual('O IDEmpresa é inválido.', lResult);
  finally
    lUnidadeHabitacionalCaracteristica.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalCaracteristicasValidacoesbase.InserirCorretamente;
begin
  var lUnidadeHabitacionalCaracteristica := TUnidadeHabitacionalCaracteristica.Create;
  var lValidacaoBase    := TUnidadeHabitacionalCaracteristicasValidacaoBase.New;
  var lValidacaoInserir := TUnidadeHabitacionalCaracteristicasValidacaoBaseInserir.New;
  try
    lUnidadeHabitacionalCaracteristica.ID          := 0;
    lUnidadeHabitacionalCaracteristica.IDEmpresa   := 1;
    lUnidadeHabitacionalCaracteristica.Descricao   := 'Teste';
    lUnidadeHabitacionalCaracteristica.Ativo       := 'S';

    var lResult := lValidacaoBase.AddEntidade(lUnidadeHabitacionalCaracteristica).Executar.Result;
    Assert.AreEqual('', lResult);
    lResult := lValidacaoInserir.AddEntidade(lUnidadeHabitacionalCaracteristica).Executar.Result;
    Assert.AreEqual('', lResult);
  finally
    lUnidadeHabitacionalCaracteristica.DisposeOf;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestUnidadeHabitacionalCaracteristicasValidacoesbase);
end.

