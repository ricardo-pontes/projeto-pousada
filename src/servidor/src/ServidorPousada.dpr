program ServidorPousada;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Compression,
  Horse.Jhonson,
  servidor.model.grupoprodutos in 'model\servidor.model.grupoprodutos.pas',
  servidor.model.grupoprodutos.interfaces in 'model\servidor.model.grupoprodutos.interfaces.pas',
  servidor.infra.repository.grupoprodutos.interfaces in 'infra\repository\servidor.infra.repository.grupoprodutos.interfaces.pas',
  servidor.infra.conexao.interfaces in 'infra\conexao\servidor.infra.conexao.interfaces.pas',
  servidor.infra.conexao in 'infra\conexao\servidor.infra.conexao.pas',
  servidor.infra.repository.grupoprodutos.db in 'infra\repository\servidor.infra.repository.grupoprodutos.db.pas',
  entidades.grupoprodutos in '..\..\entidades\entidades.grupoprodutos.pas',
  conversores.notacoes.interfaces in 'infra\conversores\conversores.notacoes.interfaces.pas',
  conversores.notacoes in 'infra\conversores\conversores.notacoes.pas',
  conversores.notacoes.factory in 'infra\conversores\conversores.notacoes.factory.pas',
  servidor.controller.grupoprodutos.interfaces in 'controller\servidor.controller.grupoprodutos.interfaces.pas',
  servidor.controller.grupoprodutos in 'controller\servidor.controller.grupoprodutos.pas',
  shared.json in '..\..\shared\shared.json.pas',
  servidor.infra.routes.grupoprodutos in 'infra\routes\servidor.infra.routes.grupoprodutos.pas',
  validador.interfaces in '..\..\validador\validador.interfaces.pas',
  validador in '..\..\validador\validador.pas',
  servidor.model.base.crud.interfaces in 'model\servidor.model.base.crud.interfaces.pas',
  servidor.model.base.crud in 'model\servidor.model.base.crud.pas',
  servidor.infra.repository.base.crud.interfaces in 'infra\repository\servidor.infra.repository.base.crud.interfaces.pas',
  servidor.infra.repository.base.crud in 'infra\repository\servidor.infra.repository.base.crud.pas',
  servidor.model.produtos in 'model\servidor.model.produtos.pas',
  servidor.model.produtos.interfaces in 'model\servidor.model.produtos.interfaces.pas',
  entidades.produtos in '..\..\entidades\entidades.produtos.pas',
  servidor.infra.repository.produtos.interfaces in 'infra\repository\servidor.infra.repository.produtos.interfaces.pas',
  servidor.controller.base.crud.interfaces in 'controller\servidor.controller.base.crud.interfaces.pas',
  servidor.controller.base.crud in 'controller\servidor.controller.base.crud.pas',
  servidor.controller.produtos in 'controller\servidor.controller.produtos.pas',
  servidor.infra.repository.produtos in 'infra\repository\servidor.infra.repository.produtos.pas',
  servidor.infra.routes.produtos in 'infra\routes\servidor.infra.routes.produtos.pas',
  servidor.controller.produtos.interfaces in 'controller\servidor.controller.produtos.interfaces.pas',
  shared.exceptions.server in '..\..\shared\shared.exceptions.server.pas',
  servidor.infra.repository.unidadehabitacional.interfaces in 'infra\repository\servidor.infra.repository.unidadehabitacional.interfaces.pas',
  entidades.unidadehabitacional in '..\..\entidades\entidades.unidadehabitacional.pas',
  servidor.infra.repository.unidadehabitacional in 'infra\repository\servidor.infra.repository.unidadehabitacional.pas',
  servidor.model.unidadehabitacional.interfaces in 'model\servidor.model.unidadehabitacional.interfaces.pas',
  servidor.model.unidadehabitacional in 'model\servidor.model.unidadehabitacional.pas',
  servidor.controller.unidadehabitacional.interfaces in 'controller\servidor.controller.unidadehabitacional.interfaces.pas',
  servidor.controller.unidadehabitacional in 'controller\servidor.controller.unidadehabitacional.pas',
  servidor.infra.routes.unidadehabitacional in 'infra\routes\servidor.infra.routes.unidadehabitacional.pas',
  entidades.unidadehabitacional.validacoes.base in '..\..\entidades\validacoes\entidades.unidadehabitacional.validacoes.base.pas',
  entidades.unidadehabitacional.validacoes.base.inserir in '..\..\entidades\validacoes\entidades.unidadehabitacional.validacoes.base.inserir.pas',
  entidades.unidadehabitacional.validacoes.base.alterar in '..\..\entidades\validacoes\entidades.unidadehabitacional.validacoes.base.alterar.pas',
  entidades.unidadehabitacional.categoria in '..\..\entidades\entidades.unidadehabitacional.categoria.pas',
  servidor.infra.repository.unidadehabitacional.categoria.interfaces in 'infra\repository\servidor.infra.repository.unidadehabitacional.categoria.interfaces.pas',
  servidor.infra.repository.unidadehabitacional.categoria in 'infra\repository\servidor.infra.repository.unidadehabitacional.categoria.pas',
  servidor.model.unidadehabitacional.categoria.interfaces in 'model\servidor.model.unidadehabitacional.categoria.interfaces.pas',
  servidor.model.unidadehabitacional.categoria in 'model\servidor.model.unidadehabitacional.categoria.pas',
  servidor.controller.unidadehabitacional.categoria.interfaces in 'controller\servidor.controller.unidadehabitacional.categoria.interfaces.pas',
  servidor.controller.unidadehabitacional.categoria in 'controller\servidor.controller.unidadehabitacional.categoria.pas',
  entidades.unidadehabitacional.categoria.validacoes.base in '..\..\entidades\validacoes\entidades.unidadehabitacional.categoria.validacoes.base.pas',
  entidades.unidadehabitacional.categoria.validacoes.base.inserir in '..\..\entidades\validacoes\entidades.unidadehabitacional.categoria.validacoes.base.inserir.pas',
  entidades.unidadehabitacional.categoria.validacoes.base.alterar in '..\..\entidades\validacoes\entidades.unidadehabitacional.categoria.validacoes.base.alterar.pas',
  entidades.unidadehabitacional.caracteristicas in '..\..\entidades\entidades.unidadehabitacional.caracteristicas.pas',
  servidor.infra.repository.unidadehabitacional.caracteristicas.interfaces in 'infra\repository\servidor.infra.repository.unidadehabitacional.caracteristicas.interfaces.pas',
  servidor.infra.repository.unidadehabitacional.caracteristicas.db in 'infra\repository\servidor.infra.repository.unidadehabitacional.caracteristicas.db.pas',
  servidor.model.unidadehabitacional.caracteristicas.interfaces in 'model\servidor.model.unidadehabitacional.caracteristicas.interfaces.pas',
  servidor.model.unidadehabitacional.caracteristicas in 'model\servidor.model.unidadehabitacional.caracteristicas.pas',
  servidor.controller.unidadehabitacional.caracteristicas.interfaces in 'controller\servidor.controller.unidadehabitacional.caracteristicas.interfaces.pas',
  servidor.controller.unidadehabitacional.caracteristicas in 'controller\servidor.controller.unidadehabitacional.caracteristicas.pas',
  entidades.unidadehabitacional.caracteristicas.validacoes.basicas in '..\..\entidades\validacoes\entidades.unidadehabitacional.caracteristicas.validacoes.basicas.pas',
  servidor.infra.routes.unidadehabitacional.caracteristicas in 'infra\routes\servidor.infra.routes.unidadehabitacional.caracteristicas.pas',
  servidor.infra.routes.unidadehabitacional.categorias in 'infra\routes\servidor.infra.routes.unidadehabitacional.categorias.pas',
  entidades.estadia in '..\..\entidades\entidades.estadia.pas',
  entidades.empresa in '..\..\entidades\entidades.empresa.pas',
  entidades.contatos in '..\..\entidades\entidades.contatos.pas',
  entidades.empresa.contatos in '..\..\entidades\entidades.empresa.contatos.pas',
  entidades.endereco in '..\..\entidades\entidades.endereco.pas',
  servidor.infra.repository.empresa.interfaces in 'infra\repository\servidor.infra.repository.empresa.interfaces.pas',
  servidor.infra.repository.empresa in 'infra\repository\servidor.infra.repository.empresa.pas',
  servidor.model.empresa.interfaces in 'model\servidor.model.empresa.interfaces.pas',
  servidor.model.empresa in 'model\servidor.model.empresa.pas',
  servidor.controller.empresa.interfaces in 'controller\servidor.controller.empresa.interfaces.pas',
  servidor.controller.empresa in 'controller\servidor.controller.empresa.pas',
  entidades.produtos.validacoes.basicas in '..\..\entidades\validacoes\entidades.produtos.validacoes.basicas.pas',
  entidades.pessoa in '..\..\entidades\entidades.pessoa.pas',
  entidades.usuario in '..\..\entidades\entidades.usuario.pas',
  entidades.usuarios.validacoes.basicas in '..\..\entidades\validacoes\entidades.usuarios.validacoes.basicas.pas',
  validador.validacoessimples in '..\..\validador\validador.validacoessimples.pas',
  servidor.infra.repository.usuario.interfaces in 'infra\repository\servidor.infra.repository.usuario.interfaces.pas',
  servidor.infra.repository.usuario in 'infra\repository\servidor.infra.repository.usuario.pas',
  servidor.model.usuarios.interfaces in 'model\servidor.model.usuarios.interfaces.pas',
  servidor.model.usuarios in 'model\servidor.model.usuarios.pas',
  servidor.controller.usuarios.interfaces in 'controller\servidor.controller.usuarios.interfaces.pas',
  servidor.controller.usuarios in 'controller\servidor.controller.usuarios.pas',
  servidor.infra.routes.usuario in 'infra\routes\servidor.infra.routes.usuario.pas',
  entidades.empresas.validacoes.basicas in '..\..\entidades\validacoes\entidades.empresas.validacoes.basicas.pas',
  servidor.infra.repository.empresa.contatos.interfaces in 'infra\repository\servidor.infra.repository.empresa.contatos.interfaces.pas',
  servidor.infra.repository.empresa.contatos.db in 'infra\repository\servidor.infra.repository.empresa.contatos.db.pas',
  servidor.model.empresa.contatos.interfaces in 'model\servidor.model.empresa.contatos.interfaces.pas',
  servidor.model.empresa.contatos in 'model\servidor.model.empresa.contatos.pas',
  servidor.controller.empresa.contatos.interfaces in 'controller\servidor.controller.empresa.contatos.interfaces.pas',
  servidor.controller.empresa.contatos in 'controller\servidor.controller.empresa.contatos.pas',
  entidades.empresas.contatos.validacoes.basicas in '..\..\entidades\validacoes\entidades.empresas.contatos.validacoes.basicas.pas',
  validador.validacoesdb in '..\..\validador\validador.validacoesdb.pas',
  entidades.produtos.validacoes.db in '..\..\entidades\validacoes\entidades.produtos.validacoes.db.pas',
  entidades.clientes in '..\..\entidades\entidades.clientes.pas',
  entidades.clientes.validacoes.basicas in '..\..\entidades\validacoes\entidades.clientes.validacoes.basicas.pas',
  servidor.infra.repository.clientes.interfaces in 'infra\repository\servidor.infra.repository.clientes.interfaces.pas',
  servidor.infra.repository.clientes in 'infra\repository\servidor.infra.repository.clientes.pas',
  servidor.model.clientes.interfaces in 'model\servidor.model.clientes.interfaces.pas',
  servidor.model.clientes in 'model\servidor.model.clientes.pas',
  servidor.controller.clientes.interfaces in 'controller\servidor.controller.clientes.interfaces.pas',
  servidor.controller.clientes in 'controller\servidor.controller.clientes.pas',
  entidades.estadia.validacoes.basicas in '..\..\entidades\validacoes\entidades.estadia.validacoes.basicas.pas',
  servidor.infra.repository.estadias.interfaces in 'infra\repository\servidor.infra.repository.estadias.interfaces.pas',
  servidor.infra.repository.estadias in 'infra\repository\servidor.infra.repository.estadias.pas',
  servidor.model.estadias.interfaces in 'model\servidor.model.estadias.interfaces.pas',
  servidor.model.estadias in 'model\servidor.model.estadias.pas',
  servidor.controller.estadias.interfaces in 'controller\servidor.controller.estadias.interfaces.pas',
  servidor.controller.estadias in 'controller\servidor.controller.estadias.pas',
  servidor.infra.fabricas.repositories in 'infra\fabricas\servidor.infra.fabricas.repositories.pas',
  entidades.estadia.acompanhante in '..\..\entidades\entidades.estadia.acompanhante.pas',
  entidades.estadia.acompanhante.validacoes.basicas in '..\..\entidades\validacoes\entidades.estadia.acompanhante.validacoes.basicas.pas',
  servidor.infra.repository.estadias.acompanhantes.interfaces in 'infra\repository\servidor.infra.repository.estadias.acompanhantes.interfaces.pas',
  servidor.infra.repository.estadias.acompanhantes in 'infra\repository\servidor.infra.repository.estadias.acompanhantes.pas',
  servidor.model.estadias.acompanhantes.interfaces in 'model\servidor.model.estadias.acompanhantes.interfaces.pas',
  servidor.model.estadias.acompanhantes in 'model\servidor.model.estadias.acompanhantes.pas',
  servidor.controller.estadias.acompanhantes.interfaces in 'controller\servidor.controller.estadias.acompanhantes.interfaces.pas',
  servidor.controller.estadias.acompanhantes in 'controller\servidor.controller.estadias.acompanhantes.pas',
  shared.exceptions in '..\..\shared\shared.exceptions.pas',
  entidades.grupos.produtos.validacoes.basicas in '..\..\entidades\validacoes\entidades.grupos.produtos.validacoes.basicas.pas',
  entidades.caracteristicas in '..\..\entidades\entidades.caracteristicas.pas',
  servidor.infra.repository.caracteristicas.interfaces in 'infra\repository\servidor.infra.repository.caracteristicas.interfaces.pas',
  servidor.infra.repository.caracteristicas in 'infra\repository\servidor.infra.repository.caracteristicas.pas',
  servidor.model.caracteristicas.interfaces in 'model\servidor.model.caracteristicas.interfaces.pas',
  servidor.model.caracteristicas in 'model\servidor.model.caracteristicas.pas',
  servidor.controller.caracteristicas.interfaces in 'controller\servidor.controller.caracteristicas.interfaces.pas',
  servidor.controller.caracteristicas in 'controller\servidor.controller.caracteristicas.pas',
  servidor.infra.routes.caracteristicas in 'infra\routes\servidor.infra.routes.caracteristicas.pas',
  entidades.caracteristicas.validacoes.db in '..\..\entidades\validacoes\entidades.caracteristicas.validacoes.db.pas',
  entidades.caracteristicas.validacoes.basicas in '..\..\entidades\validacoes\entidades.caracteristicas.validacoes.basicas.pas',
  servidor.infra.routes.empresa in 'infra\routes\servidor.infra.routes.empresa.pas',
  entidades.usuarios.validacoes.db in '..\..\entidades\validacoes\entidades.usuarios.validacoes.db.pas';

begin
  ReportMemoryLeaksOnShutdown := True;
  THorse.Use(Compression());
  THorse.Use(Jhonson('utf-8'));

  servidor.infra.routes.caracteristicas.Registrar;
  servidor.infra.routes.empresa.Registrar;
  servidor.infra.routes.grupoprodutos.Registrar;
  servidor.infra.routes.produtos.Registrar;
  servidor.infra.routes.unidadehabitacional.Registrar;
  servidor.infra.routes.unidadehabitacional.categorias.Registrar;
  servidor.infra.routes.unidadehabitacional.caracteristicas.Registrar;
  servidor.infra.routes.usuario.Registrar;

  THorse.Listen(9000,
  procedure (aHorse : THorse)
  begin
    Writeln('servidor rodando na porta ' + aHorse.Port.ToString);
    Write('Press return to stop ...');
  end);
end.
