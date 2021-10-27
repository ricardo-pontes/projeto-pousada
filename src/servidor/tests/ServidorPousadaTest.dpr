program ServidorPousadaTest;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  tests.produtos.validacoes in 'tests.produtos.validacoes.pas',
  entidades.contatos in '..\..\entidades\entidades.contatos.pas',
  entidades.empresa.contatos in '..\..\entidades\entidades.empresa.contatos.pas',
  entidades.empresa.endereco in '..\..\entidades\entidades.empresa.endereco.pas',
  entidades.empresa in '..\..\entidades\entidades.empresa.pas',
  entidades.endereco in '..\..\entidades\entidades.endereco.pas',
  entidades.estadia in '..\..\entidades\entidades.estadia.pas',
  entidades.grupoprodutos in '..\..\entidades\entidades.grupoprodutos.pas',
  entidades.produtos in '..\..\entidades\entidades.produtos.pas',
  entidades.unidadehabitacional.caracteristicas in '..\..\entidades\entidades.unidadehabitacional.caracteristicas.pas',
  entidades.unidadehabitacional.categoria in '..\..\entidades\entidades.unidadehabitacional.categoria.pas',
  entidades.unidadehabitacional in '..\..\entidades\entidades.unidadehabitacional.pas',
  shared.json in '..\..\shared\shared.json.pas',
  validador.interfaces in '..\..\validador\validador.interfaces.pas',
  validador in '..\..\validador\validador.pas',
  servidor.infra.conexao.interfaces in '..\src\infra\conexao\servidor.infra.conexao.interfaces.pas',
  servidor.infra.conexao in '..\src\infra\conexao\servidor.infra.conexao.pas',
  conversores.notacoes.factory in '..\src\infra\conversores\conversores.notacoes.factory.pas',
  conversores.notacoes.interfaces in '..\src\infra\conversores\conversores.notacoes.interfaces.pas',
  conversores.notacoes in '..\src\infra\conversores\conversores.notacoes.pas',
  servidor.exceptions in '..\src\infra\exceptions\servidor.exceptions.pas',
  servidor.infra.repository.base.crud.interfaces in '..\src\infra\repository\servidor.infra.repository.base.crud.interfaces.pas',
  servidor.infra.repository.base.crud in '..\src\infra\repository\servidor.infra.repository.base.crud.pas',
  servidor.infra.repository.empresa.interfaces in '..\src\infra\repository\servidor.infra.repository.empresa.interfaces.pas',
  servidor.infra.repository.empresa in '..\src\infra\repository\servidor.infra.repository.empresa.pas',
  servidor.infra.repository.grupoprodutos.db in '..\src\infra\repository\servidor.infra.repository.grupoprodutos.db.pas',
  servidor.infra.repository.grupoprodutos.interfaces in '..\src\infra\repository\servidor.infra.repository.grupoprodutos.interfaces.pas',
  servidor.infra.repository.produtos.interfaces in '..\src\infra\repository\servidor.infra.repository.produtos.interfaces.pas',
  servidor.infra.repository.produtos in '..\src\infra\repository\servidor.infra.repository.produtos.pas',
  servidor.infra.repository.unidadehabitacional.caracteristicas.db in '..\src\infra\repository\servidor.infra.repository.unidadehabitacional.caracteristicas.db.pas',
  servidor.infra.repository.unidadehabitacional.caracteristicas.interfaces in '..\src\infra\repository\servidor.infra.repository.unidadehabitacional.caracteristicas.interfaces.pas',
  servidor.infra.repository.unidadehabitacional.categoria.interfaces in '..\src\infra\repository\servidor.infra.repository.unidadehabitacional.categoria.interfaces.pas',
  servidor.infra.repository.unidadehabitacional.categoria in '..\src\infra\repository\servidor.infra.repository.unidadehabitacional.categoria.pas',
  servidor.infra.repository.unidadehabitacional.interfaces in '..\src\infra\repository\servidor.infra.repository.unidadehabitacional.interfaces.pas',
  servidor.infra.repository.unidadehabitacional in '..\src\infra\repository\servidor.infra.repository.unidadehabitacional.pas',
  entidades.produtos.validacoes.basicas in '..\..\entidades\validacoes\entidades.produtos.validacoes.basicas.pas',
  entidades.unidadehabitacional.caracteristicas.validacoes.base.alterar in '..\..\entidades\validacoes\entidades.unidadehabitacional.caracteristicas.validacoes.base.alterar.pas',
  entidades.unidadehabitacional.caracteristicas.validacoes.base.inserir in '..\..\entidades\validacoes\entidades.unidadehabitacional.caracteristicas.validacoes.base.inserir.pas',
  entidades.unidadehabitacional.caracteristicas.validacoes.basicas in '..\..\entidades\validacoes\entidades.unidadehabitacional.caracteristicas.validacoes.basicas.pas',
  tests.unidadehabitacional.caracteristicas.validacoes in 'tests.unidadehabitacional.caracteristicas.validacoes.pas',
  tests.unidadehabitacional.categorias.validacoes in 'tests.unidadehabitacional.categorias.validacoes.pas',
  entidades.unidadehabitacional.categoria.validacoes.base.alterar in '..\..\entidades\validacoes\entidades.unidadehabitacional.categoria.validacoes.base.alterar.pas',
  entidades.unidadehabitacional.categoria.validacoes.base.inserir in '..\..\entidades\validacoes\entidades.unidadehabitacional.categoria.validacoes.base.inserir.pas',
  entidades.unidadehabitacional.categoria.validacoes.base in '..\..\entidades\validacoes\entidades.unidadehabitacional.categoria.validacoes.base.pas',
  tests.unidadehabitacional.validacoes in 'tests.unidadehabitacional.validacoes.pas',
  entidades.unidadehabitacional.validacoes.base.alterar in '..\..\entidades\validacoes\entidades.unidadehabitacional.validacoes.base.alterar.pas',
  entidades.unidadehabitacional.validacoes.base.inserir in '..\..\entidades\validacoes\entidades.unidadehabitacional.validacoes.base.inserir.pas',
  entidades.unidadehabitacional.validacoes.base in '..\..\entidades\validacoes\entidades.unidadehabitacional.validacoes.base.pas';

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //tell the runner how we will log things
    //Log to the console window
    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.
