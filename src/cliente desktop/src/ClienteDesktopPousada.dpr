program ClienteDesktopPousada;

uses
  System.StartUpCopy,
  FMX.Forms,
  desktop.infra.styles in 'infra\styles\desktop.infra.styles.pas' {ViewStyles},
  desktop.views.principal in 'views\desktop.views.principal.pas' {ViewPrincipal},
  cliente.infra.repository.base.crud.interfaces in 'infra\repository\cliente.infra.repository.base.crud.interfaces.pas',
  shared.json in '..\..\shared\shared.json.pas',
  cliente.infra.conexao.interfaces in 'infra\conexao\cliente.infra.conexao.interfaces.pas',
  cliente.infra.repository.produtos.interfaces in 'infra\repository\cliente.infra.repository.produtos.interfaces.pas',
  entidades.clientes in '..\..\entidades\entidades.clientes.pas',
  entidades.contatos in '..\..\entidades\entidades.contatos.pas',
  entidades.empresa.contatos in '..\..\entidades\entidades.empresa.contatos.pas',
  entidades.empresa.endereco in '..\..\entidades\entidades.empresa.endereco.pas',
  entidades.empresa in '..\..\entidades\entidades.empresa.pas',
  entidades.endereco in '..\..\entidades\entidades.endereco.pas',
  entidades.estadia.acompanhante in '..\..\entidades\entidades.estadia.acompanhante.pas',
  entidades.estadia in '..\..\entidades\entidades.estadia.pas',
  entidades.grupoprodutos in '..\..\entidades\entidades.grupoprodutos.pas',
  entidades.pessoa in '..\..\entidades\entidades.pessoa.pas',
  entidades.produtos in '..\..\entidades\entidades.produtos.pas',
  entidades.unidadehabitacional.caracteristicas in '..\..\entidades\entidades.unidadehabitacional.caracteristicas.pas',
  entidades.unidadehabitacional.categoria in '..\..\entidades\entidades.unidadehabitacional.categoria.pas',
  entidades.unidadehabitacional in '..\..\entidades\entidades.unidadehabitacional.pas',
  entidades.usuario in '..\..\entidades\entidades.usuario.pas',
  cliente.infra.repository.produtos in 'infra\repository\cliente.infra.repository.produtos.pas',
  validador.interfaces in '..\..\validador\validador.interfaces.pas',
  validador in '..\..\validador\validador.pas',
  validador.validacoessimples in '..\..\validador\validador.validacoessimples.pas',
  entidades.produtos.validacoes.basicas in '..\..\entidades\validacoes\entidades.produtos.validacoes.basicas.pas',
  cliente.model.base in 'model\cliente.model.base.pas',
  cliente.model.produtos in 'model\cliente.model.produtos.pas',
  desktop.views.base in 'views\desktop.views.base.pas' {ViewBase},
  desktop.views.produtos in 'views\desktop.views.produtos.pas' {ViewProdutos},
  cliente.infra.routes in 'infra\routes\cliente.infra.routes.pas',
  cliente.presenter.produtos.interfaces in 'presenters\cliente.presenter.produtos.interfaces.pas',
  cliente.presenter.produtos in 'presenters\cliente.presenter.produtos.pas',
  cliente.infra.conexao in 'infra\conexao\cliente.infra.conexao.pas',
  cliente.infra.binds in 'infra\binds\cliente.infra.binds.pas',
  cliente.model.grupos.produtos in 'model\cliente.model.grupos.produtos.pas',
  cliente.infra.repository.grupos.produtos.interfaces in 'infra\repository\cliente.infra.repository.grupos.produtos.interfaces.pas',
  cliente.infra.repository.grupos.produtos in 'infra\repository\cliente.infra.repository.grupos.produtos.pas',
  entidades.grupos.produtos.validacoes.basicas in '..\..\entidades\validacoes\entidades.grupos.produtos.validacoes.basicas.pas',
  cliente.presenter.grupos.produtos in 'presenters\cliente.presenter.grupos.produtos.pas',
  cliente.presenter.grupos.produtos.interfaces in 'presenters\cliente.presenter.grupos.produtos.interfaces.pas',
  desktop.views.base.cadastro in 'views\desktop.views.base.cadastro.pas' {ViewBaseCadastro},
  desktop.views.grupos.produtos in 'views\desktop.views.grupos.produtos.pas' {ViewGrupoProdutos};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.CreateForm(TViewStyles, ViewStyles);
  Application.CreateForm(TViewBaseCadastro, ViewBaseCadastro);
  Application.CreateForm(TViewGrupoProdutos, ViewGrupoProdutos);
  Application.Run;
end.
