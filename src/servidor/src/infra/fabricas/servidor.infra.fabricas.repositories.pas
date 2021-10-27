unit servidor.infra.fabricas.repositories;

interface

uses
  servidor.infra.repository.estadias.interfaces,
  servidor.infra.repository.clientes.interfaces,
  servidor.infra.repository.clientes,
  servidor.infra.repository.empresa.contatos.db,
  servidor.infra.repository.empresa.contatos.interfaces,
  servidor.infra.repository.empresa.interfaces,
  servidor.infra.repository.empresa, servidor.infra.repository.estadias,
  servidor.infra.repository.grupoprodutos.db,
  servidor.infra.repository.grupoprodutos.interfaces,
  servidor.infra.repository.produtos.interfaces,
  servidor.infra.repository.produtos,
  servidor.infra.repository.unidadehabitacional.caracteristicas.db,
  servidor.infra.repository.unidadehabitacional.caracteristicas.interfaces,
  servidor.infra.repository.unidadehabitacional.categoria.interfaces,
  servidor.infra.repository.unidadehabitacional.categoria,
  servidor.infra.repository.unidadehabitacional.interfaces,
  servidor.infra.repository.unidadehabitacional,
  servidor.infra.repository.usuario.interfaces,
  servidor.infra.repository.usuario,
  servidor.infra.repository.estadias.acompanhantes.interfaces,
  servidor.infra.repository.estadias.acompanhantes;

type
  TRepositories = class
    class function Clientes : iRepositoryClientes;
    class function Estadias : iRepositoryEstadias;
    class function EstadiasAcompanhantes : iRepositoryEstadiasAcompanhantes;
    class function Empresas : iRepositoryEmpresa;
    class function EmpresaContatos : iRepositoryEmpresaContatos;
    class function GrupoProdutos : iRepositoryGrupoProdutos;
    class function Produtos : iRepositoryProdutos;
    class function UnidadeHabitacional : iRepositoryUnidadeHabitacional;
    class function UnidadeHabitacionalCategoria : iRepositoryUnidadeHabitacionalCategoria;
    class function UnidadeHabitacionalCaracteristicas : iRepositoryUnidadeHabitacionalCaracteristicas;
    class function Usuarios : iRepositoryUsuarios;
  end;

implementation

{ TRepositories }

uses conversores.notacoes.factory, servidor.infra.conexao;

class function TRepositories.Clientes: iRepositoryClientes;
begin
  Result := TRepositoryClientesDB.New(TConexaoFactory.New.Conexao, TNotacoesFactory.Cliente);
end;

class function TRepositories.EmpresaContatos: iRepositoryEmpresaContatos;
begin
  Result := TRepositoryEmpresaContatosDB.New(TConexaoFactory.New.Conexao, TNotacoesFactory.EmpresaContatos);
end;

class function TRepositories.Empresas: iRepositoryEmpresa;
begin
  Result := TRepositoryEmpresaDB.New(TConexaoFactory.New.Conexao, TNotacoesFactory.Empresa)
end;

class function TRepositories.Estadias: iRepositoryEstadias;
begin
  Result := TRepositoryEstadiasDB.New(TConexaoFactory.New.Conexao, TNotacoesFactory.Estadia);
end;

class function TRepositories.EstadiasAcompanhantes: iRepositoryEstadiasAcompanhantes;
begin
  Result := TRepositoryEstadiasAcompanhantesDB.New(TConexaoFactory.New.Conexao, TNotacoesFactory.EstadiaAcompanhantes);
end;

class function TRepositories.GrupoProdutos: iRepositoryGrupoProdutos;
begin
  Result := TRepositoryGrupoProdutosDB.New(TConexaoFactory.New.Conexao, TNotacoesFactory.GrupoProdutos)
end;

class function TRepositories.Produtos: iRepositoryProdutos;
begin
  Result := TRepositoryProdutos.New(TConexaoFactory.New.Conexao, TNotacoesFactory.Produtos);
end;

class function TRepositories.UnidadeHabitacional: iRepositoryUnidadeHabitacional;
begin
  Result := TRepositoryUnidadeHabitacionalDB.New(TConexaoFactory.New.Conexao, TNotacoesFactory.UnidadeHabitacional);
end;

class function TRepositories.UnidadeHabitacionalCaracteristicas: iRepositoryUnidadeHabitacionalCaracteristicas;
begin
  Result := TRepositoryUnidadeHabitacionalCaracteristicasDB.New(TConexaoFactory.New.Conexao, TNotacoesFactory.UnidadeHabitacionalCaracteristicas);
end;

class function TRepositories.UnidadeHabitacionalCategoria: iRepositoryUnidadeHabitacionalCategoria;
begin
  Result := TRepositoryUnidadeHabitacionalCategoria.New(TConexaoFactory.New.Conexao, TNotacoesFactory.UnidadeHabitacionalCategoria);
end;

class function TRepositories.Usuarios: iRepositoryUsuarios;
begin
  Result := TRepositoryUsuarios.New(TConexaoFactory.New.Conexao, TNotacoesFactory.Usuario);
end;

end.
