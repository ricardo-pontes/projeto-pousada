unit tests.produtos.validacoes;
//
interface
//uses
//  DUnitX.TestFramework,
//  entidades.produtos,
//  entidades.produtos.validacoes.basicas;
//
//type
//
//  [TestFixture]
//  TTestProdutosInserir = class(TObject)
//  private
//
//  public
//    [Setup]
//    procedure Setup;
//    [TearDown]
//    procedure TearDown;
//    [Test]
//    procedure InserirCorretamente;
//    [Test]
//    procedure AlterarCorretamente;
//    [Test]
//    procedure IDDeveSerZerado;
//    [Test]
//    procedure IDEmpresaSoPodeSerMaiorQueZero;
//    [Test]
//    procedure DescricaoNaoPodeSerVazio;
//    [Test]
//    procedure ValorCustoSoPodeSerMaiorQueZero;
//    [Test]
//    procedure ValorVendaSoPodeSerMaiorQueZero;
//    [Test]
//    procedure IDCategoriaSoPodeSerMaiorQueZero;
//    [Test]
//    procedure AtivoNaoPodeSerVazio;
//    [Test]
//    procedure AtivoSoPodeReceberLetrasSeN;
//  end;
//
implementation
//
//procedure TTestProdutosInserir.AlterarCorretamente;
//begin
//  var lProduto := TProduto.Create;
////  var lValidacao := TProdutosValidacoesBasicas.New;
//  try
//    lProduto.ID          := 1;
//    lProduto.IDEmpresa   := 1;
//    lProduto.Descricao   := 'Teste';
//    lProduto.ValorCusto  := 2;
//    lProduto.ValorVenda  := 4;
//    lProduto.IDCategoria := 1;
//    lProduto.Ativo       := 'S';
//
//    var lResult := entidades.produtos.validacoes.basicas.IDNaoPodeSerZeradoNaEdicao(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.IDEmpresaNaoPodeSerZerado(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.IDEmpresaNaoPodeSerMenorQueZero(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.DescricaoNaoPodeSerVazia(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.ValorCustoNaoPodeSerZerado(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.ValorCustoNaoPodeSerMenorQueZero(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.ValorVendaNaoPodeSerZerado(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.ValorVendaNaoPodeSerMenorQueZero(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.IDCategoriaNaoPodeSerZerado(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.IDCategoriaNaoPodeSerMenorQueZero(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.AtivoNaoPodeSerVazio(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.AtivoSoRecebeLetraSouN(lProduto);
//    Assert.AreEqual('', lResult);
//  finally
//    lProduto.DisposeOf;
//  end;
//end;
//
//procedure TTestProdutosInserir.AtivoNaoPodeSerVazio;
//begin
//  var lProduto := TProduto.Create;
//  try
//    lProduto.Ativo := '';
//    var lResult := entidades.produtos.validacoes.basicas.AtivoNaoPodeSerVazio(lProduto);
//    Assert.AreEqual(MSG_ATIVO_NAO_PODE_SER_VAZIO, lResult);
//  finally
//    lProduto.DisposeOf;
//  end;
//end;
//
//procedure TTestProdutosInserir.AtivoSoPodeReceberLetrasSeN;
//begin
//  var lProduto := TProduto.Create;
//  try
//    lProduto.Ativo := 'T';
//    var lResult := entidades.produtos.validacoes.basicas.AtivoSoRecebeLetraSouN(lProduto);
//    Assert.AreEqual(MSG_ATIVO_SO_RECEBE_LETRAS_S_OU_N, lResult);
//
//    lProduto.Ativo := 'S';
//    lResult := entidades.produtos.validacoes.basicas.AtivoSoRecebeLetraSouN(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lProduto.Ativo := 'N';
//    lResult := entidades.produtos.validacoes.basicas.AtivoSoRecebeLetraSouN(lProduto);
//    Assert.AreEqual('', lResult);
//  finally
//    lProduto.DisposeOf;
//  end;
//end;
//
//procedure TTestProdutosInserir.DescricaoNaoPodeSerVazio;
//begin
//  var lProduto := TProduto.Create;
//  try
//    lProduto.Descricao := '';
//    var lResult := entidades.produtos.validacoes.basicas.DescricaoNaoPodeSerVazia(lProduto);
//    Assert.AreEqual(MSG_DESCRICAO_NAO_PODE_SER_VAZIA, lResult);
//  finally
//    lProduto.DisposeOf;
//  end;
//end;
//
//procedure TTestProdutosInserir.IDCategoriaSoPodeSerMaiorQueZero;
//begin
//  var lProduto := TProduto.Create;
//
//  try
//    lProduto.IDCategoria := -1;
//    var lResult := entidades.produtos.validacoes.basicas.IDCategoriaNaoPodeSerMenorQueZero(lProduto);
//    Assert.AreEqual(MSG_ID_CATEGORIA_NAO_PODE_SER_MENOR_QUE_ZERO, lResult);
//
//    lProduto.IDCategoria := 0;
//    lResult := entidades.produtos.validacoes.basicas.IDCategoriaNaoPodeSerZerado(lProduto);
//    Assert.AreEqual(MSG_ID_CATEGORIA_NAO_PODE_SER_IGUAL_A_ZERO, lResult);
//  finally
//    lProduto.DisposeOf;
//  end;
//end;
//
//procedure TTestProdutosInserir.IDDeveSerZerado;
//begin
//  var lProduto := TProduto.Create;
//  try
//    lProduto.ID := 1;
//    var lResult := entidades.produtos.validacoes.basicas.IDSoPodeSerZeradoNaInsercao(lProduto);
//    Assert.AreEqual(MSG_ID_SO_PODE_SER_ZERADO_NA_INSERCAO, lResult);
//  finally
//    lProduto.DisposeOf;
//  end;
//end;
//
//procedure TTestProdutosInserir.IDEmpresaSoPodeSerMaiorQueZero;
//begin
//  var lProduto := TProduto.Create;
//  try
//    lProduto.IDEmpresa := -1;
//    var lResult := entidades.produtos.validacoes.basicas.IDEmpresaNaoPodeSerMenorQueZero(lProduto);
//    Assert.AreEqual(MSG_ID_EMPRESA_NAO_PODE_MENOR_QUE_ZERO, lResult);
//
//    lProduto.IDEmpresa := 0;
//    lResult := entidades.produtos.validacoes.basicas.IDEmpresaNaoPodeSerZerado(lProduto);
//    Assert.AreEqual(MSG_ID_EMPRESA_NAO_PODE_IGUAL_A_ZERO, lResult);
//  finally
//    lProduto.DisposeOf;
//  end;
//end;
//
//procedure TTestProdutosInserir.InserirCorretamente;
//begin
//  var lProduto := TProduto.Create;
//  try
//    lProduto.ID          := 0;
//    lProduto.IDEmpresa   := 1;
//    lProduto.Descricao   := 'Teste';
//    lProduto.ValorCusto  := 2;
//    lProduto.ValorVenda  := 4;
//    lProduto.IDCategoria := 1;
//    lProduto.Ativo       := 'S';
//
//    var lResult := entidades.produtos.validacoes.basicas.IDSoPodeSerZeradoNaInsercao(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.IDEmpresaNaoPodeSerZerado(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.IDEmpresaNaoPodeSerMenorQueZero(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.DescricaoNaoPodeSerVazia(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.ValorCustoNaoPodeSerZerado(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.ValorCustoNaoPodeSerMenorQueZero(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.ValorVendaNaoPodeSerZerado(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.ValorVendaNaoPodeSerMenorQueZero(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.IDCategoriaNaoPodeSerZerado(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.IDCategoriaNaoPodeSerMenorQueZero(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.AtivoNaoPodeSerVazio(lProduto);
//    Assert.AreEqual('', lResult);
//
//    lResult := entidades.produtos.validacoes.basicas.AtivoSoRecebeLetraSouN(lProduto);
//    Assert.AreEqual('', lResult);
//  finally
//    lProduto.DisposeOf;
//  end;
//end;
//
//procedure TTestProdutosInserir.Setup;
//begin
//
//end;
//
//procedure TTestProdutosInserir.TearDown;
//begin
//
//end;
//
//procedure TTestProdutosInserir.ValorCustoSoPodeSerMaiorQueZero;
//begin
//  var lProduto := TProduto.Create;
//  try
//    lProduto.ValorCusto := -1;
//    var lResult := entidades.produtos.validacoes.basicas.ValorCustoNaoPodeSerMenorQueZero(lProduto);
//    Assert.AreEqual(MSG_VALOR_CUSTO_NAO_PODE_SER_MENOR_QUE_ZERO, lResult);
//
//    lProduto.ValorCusto := 0;
//    lResult := entidades.produtos.validacoes.basicas.ValorCustoNaoPodeSerZerado(lProduto);
//    Assert.AreEqual(MSG_VALOR_CUSTO_NAO_PODE_SER_IGUAL_A_ZERO, lResult);
//  finally
//    lProduto.DisposeOf;
//  end;
//end;
//
//procedure TTestProdutosInserir.ValorVendaSoPodeSerMaiorQueZero;
//begin
//  var lProduto := TProduto.Create;
//  try
//    lProduto.ValorVenda := -1;
//    var lResult := entidades.produtos.validacoes.basicas.ValorVendaNaoPodeSerMenorQueZero(lProduto);
//    Assert.AreEqual(MSG_VALOR_VENDA_NAO_PODE_SER_MENOR_QUE_ZERO, lResult);
//
//    lProduto.ValorVenda := 0;
//    lResult := entidades.produtos.validacoes.basicas.ValorVendaNaoPodeSerZerado(lProduto);
//    Assert.AreEqual(MSG_VALOR_VENDA_NAO_PODE_SER_IGUAL_A_ZERO, lResult);
//  finally
//    lProduto.DisposeOf;
//  end;
//end;
//
//initialization
//  TDUnitX.RegisterTestFixture(TTestProdutosInserir);
end.
