unit tests.unidadehabitacional.validacoes;

interface
uses
  DUnitX.TestFramework,
  entidades.unidadehabitacional,
  entidades.unidadehabitacional.validacoes.base.alterar,
  entidades.unidadehabitacional.validacoes.base.inserir,
  entidades.unidadehabitacional.validacoes.base;

type
  [TestFixture]
  TTestUnidadeHabitacionalValidacoesbase = class(TObject)
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

procedure TTestUnidadeHabitacionalValidacoesbase.AtivoNaoPodeSerVazio;
begin
  var lUnidadeHabitacional := TUnidadeHabitacional.Create;
  var lValidacao := TUnidadeHabitacionalValidacaoBase.New;
  try
    lUnidadeHabitacional.ID        := 1;
    lUnidadeHabitacional.IDEmpresa := 1;
    lUnidadeHabitacional.Descricao := 'Test';
    lUnidadeHabitacional.IDGrupo   := 1;
    lUnidadeHabitacional.Ativo     := '';
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacional).Executar.Result;
    Assert.AreEqual('Informe se a Unidade Habitacional está ativa ou não.', lResult);
  finally
    lUnidadeHabitacional.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalValidacoesbase.AtivoSoPodeReceberLetrasSeN;
begin
  var lUnidadeHabitacional := TUnidadeHabitacional.Create;
  var lValidacao := TUnidadeHabitacionalValidacaoBase.New;
  try
    lUnidadeHabitacional.ID        := 1;
    lUnidadeHabitacional.IDEmpresa := 1;
    lUnidadeHabitacional.Descricao := 'Test';
    lUnidadeHabitacional.IDGrupo   := 1;
    lUnidadeHabitacional.Ativo     := 'T';
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacional).Executar.Result;
    Assert.AreEqual('Só são aceitos S ou N no campo Ativo', lResult);

    lUnidadeHabitacional.Ativo := 'S';
    lResult := lValidacao.AddEntidade(lUnidadeHabitacional).Executar.Result;
    Assert.AreEqual('', lResult);

    lUnidadeHabitacional.Ativo := 'N';
    lResult := lValidacao.AddEntidade(lUnidadeHabitacional).Executar.Result;
    Assert.AreEqual('', lResult);
  finally
    lUnidadeHabitacional.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalValidacoesbase.DescricaoNaoPodeSerVazio;
begin
  var lUnidadeHabitacional := TUnidadeHabitacional.Create;
  var lValidacao := TUnidadeHabitacionalValidacaoBase.New;
  try
    lUnidadeHabitacional.ID        := 1;
    lUnidadeHabitacional.IDEmpresa := 1;
    lUnidadeHabitacional.Descricao := '';
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacional).Executar.Result;
    Assert.AreEqual('A Descrição não pode ser vazia.', lResult);
  finally
    lUnidadeHabitacional.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalValidacoesbase.IDDeveSerPreenchidoAoAlterar;
begin
  var lUnidadeHabitacional := TUnidadeHabitacional.Create;
  var lValidacao := TUnidadeHabitacionalValidacaoBaseAlterar.New;
  try
    lUnidadeHabitacional.ID := 0;
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacional).Executar.Result;
    Assert.AreEqual('O ID não pode ser zero.', lResult);
  finally
    lUnidadeHabitacional.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalValidacoesbase.IDDeveSerZeradoAoInserir;
begin
  var lUnidadeHabitacional := TUnidadeHabitacional.Create;
  var lValidacao := TUnidadeHabitacionalValidacaoBaseInserir.New;
  try
    lUnidadeHabitacional.ID := 1;
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacional).Executar.Result;
    Assert.AreEqual('Só é aceito zero no ID.', lResult);
  finally
    lUnidadeHabitacional.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalValidacoesbase.IDEmpresaSoPodeSerMaiorQueZero;
begin
  var lUnidadeHabitacional := TUnidadeHabitacional.Create;
  var lValidacao := TUnidadeHabitacionalValidacaoBase.New;
  try
    lUnidadeHabitacional.ID := -1;
    var lResult := lValidacao.AddEntidade(lUnidadeHabitacional).Executar.Result;
    Assert.AreEqual('O IDEmpresa é inválido.', lResult);

    lUnidadeHabitacional.ID := 0;
    lResult := lValidacao.AddEntidade(lUnidadeHabitacional).Executar.Result;
    Assert.AreEqual('O IDEmpresa é inválido.', lResult);
  finally
    lUnidadeHabitacional.DisposeOf;
  end;
end;

procedure TTestUnidadeHabitacionalValidacoesbase.InserirCorretamente;
begin
  var lUnidadeHabitacional := TUnidadeHabitacional.Create;
  var lValidacaoBase       := TUnidadeHabitacionalValidacaoBase.New;
  var lValidacaoInserir    := TUnidadeHabitacionalValidacaoBaseInserir.New;
  try
    lUnidadeHabitacional.ID        := 0;
    lUnidadeHabitacional.IDEmpresa := 1;
    lUnidadeHabitacional.Descricao := 'Teste';
    lUnidadeHabitacional.IDGrupo   := 1;
    lUnidadeHabitacional.Ativo     := 'S';

    var lResult := lValidacaoBase.AddEntidade(lUnidadeHabitacional).Executar.Result;
    Assert.AreEqual('', lResult);
    lResult := lValidacaoInserir.AddEntidade(lUnidadeHabitacional).Executar.Result;
    Assert.AreEqual('', lResult);
  finally
    lUnidadeHabitacional.DisposeOf;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestUnidadeHabitacionalValidacoesbase);
end.


