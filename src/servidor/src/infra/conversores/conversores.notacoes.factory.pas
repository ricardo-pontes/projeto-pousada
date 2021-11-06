unit conversores.notacoes.factory;

interface

uses
  conversores.notacoes.interfaces;

type
  TNotacoesFactory = class
  private

  public
    class function Categorias : iNotacao;
    class function Cliente : iNotacao;
    class function Empresa : iNotacao;
    class function EmpresaContatos : iNotacao;
    class function Estadia : iNotacao;
    class function EstadiaAcompanhantes : iNotacao;
    class function GrupoProdutos : iNotacao;
    class function Produtos : iNotacao;
    class function UnidadeHabitacional : iNotacao;
    class function UnidadeHabitacionalCategoria : iNotacao;
    class function UnidadeHabitacionalCaracteristicas : iNotacao;
    class function Usuario : iNotacao;
  end;

implementation

{ TNotacoesFactory }

uses
  conversores.notacoes,
  entidades.unidadehabitacional.caracteristicas,
  entidades.grupoprodutos,
  entidades.usuario,
  entidades.empresa,
  entidades.produtos,
  entidades.unidadehabitacional,
  entidades.unidadehabitacional.categoria,
  entidades.empresa.contatos,
  entidades.clientes,
  entidades.estadia,
  entidades.estadia.acompanhante,
  entidades.caracteristicas;

class function TNotacoesFactory.Categorias: iNotacao;
begin
  Result := TNotacao.New.AddTableName(CAT_TABELA);
  Result.AddNotation('ID',        CAT_ID, [TNotacaoConstraint.PK, TNotacaoConstraint.AutoInc])
        .AddNotation('IDEmpresa', CAT_ID_EMPRESA)
        .AddNotation('Descricao', CAT_DESCRICAO)
        .AddNotation('Ativo',     CAT_ATIVO);
end;

class function TNotacoesFactory.Cliente: iNotacao;
begin
  Result := TNotacao.New.AddTableName(CLI_TABELA);
  Result.AddNotation('ID',             CLI_ID, [TNotacaoConstraint.PK, TNotacaoConstraint.AutoInc])
        .AddNotation('IDEmpresa',      CLI_ID_EMPRESA)
        .AddNotation('Nome',           CLI_NOME)
        .AddNotation('CPF',            CLI_CPF)
        .AddNotation('RG',             CLI_RG)
        .AddNotation('Email',          CLI_EMAIL)
        .AddNotation('DataNascimento', CLI_DATA_NASCIMENTO)
        .AddNotation('Telefone',       CLI_TELEFONE)
        .AddNotation('DataCadastro',   CLI_DATA_CADASTRO)
        .AddNotation('Logradouro',     CLI_LOGRADOURO)
        .AddNotation('Numero',         CLI_NUMERO)
        .AddNotation('Bairro',         CLI_BAIRRO)
        .AddNotation('Cidade',         CLI_CIDADE)
        .AddNotation('UF',             CLI_UF)
        .AddNotation('CEP',            CLI_CEP)
end;

class function TNotacoesFactory.Empresa: iNotacao;
begin
  Result := TNotacao.New.AddTableName(EMP_TABELA);
  Result.AddNotation('ID',           EMP_ID, [TNotacaoConstraint.PK, TNotacaoConstraint.AutoInc])
        .AddNotation('RazaoSocial',  EMP_RAZAO_SOCIAL)
        .AddNotation('Fantasia',     EMP_NOME_FANTASIA)
        .AddNotation('CNPJ',         EMP_CNPJ)
        .AddNotation('Email',        EMP_EMAIL)
        .AddNotation('Site',         EMP_SITE)
        .AddNotation('Telefone',     EMP_TELEFONE)
        .AddNotation('DataCadastro', EMP_DATA_CADASTRO, [TNotacaoConstraint.DateField])
        .AddNotation('Logradouro',   EMP_LOGRADOURO)
        .AddNotation('Numero',       EMP_NUMERO)
        .AddNotation('Bairro',       EMP_BAIRRO)
        .AddNotation('Cidade',       EMP_CIDADE)
        .AddNotation('UF',           EMP_UF)
        .AddNotation('CEP',          EMP_CEP)
        .AddNotation('Whatsapp',     EMP_WHATSAPP)
        .AddNotation('Instagram',    EMP_INSTAGRAM)
        .AddNotation('Facebook',     EMP_FACEBOOK)
end;

class function TNotacoesFactory.EmpresaContatos: iNotacao;
begin
  Result := TNotacao.New.AddTableName(EMPC_TABELA);
  Result.AddNotation('ID',          EMPC_ID, [TNotacaoConstraint.PK, TNotacaoConstraint.AutoInc])
        .AddNotation('IDEmpresa',   EMPC_IDEMPRESA)
        .AddNotation('TipoContato', EMPC_TIPO_CONTATO)
        .AddNotation('Descricao',   EMPC_DESCRICAO)
end;

class function TNotacoesFactory.Estadia: iNotacao;
begin
  Result := TNotacao.New.AddTableName(EST_TABELA);
  Result.AddJoin(' inner join ' + CLI_TABELA + ' on ' + CLI_ID + ' = ' + EST_ID_CLIENTE);
  Result.AddNotation('ID',           EST_ID, [TNotacaoConstraint.PK, TNotacaoConstraint.AutoInc])
        .AddNotation('IDEmpresa',    EST_ID_EMPRESA)
        .AddNotation('IDCliente',    EST_ID_CLIENTE)
        .AddNotation('NomeCliente',  CLI_NOME, [TNotacaoConstraint.IgnoreWriteSQLs])
        .AddNotation('DataEntrada',  EST_DATA_ENTRADA)
        .AddNotation('DataSaida',    EST_DATA_SAIDA)
        .AddNotation('DataRegistro', EST_DATA_REGISTRO)
        .AddNotation('Valor',        EST_VALOR)
        .AddNotation('Observacoes',  EST_OBSERVACOES)
end;

class function TNotacoesFactory.EstadiaAcompanhantes: iNotacao;
begin
  Result := TNotacao.New.AddTableName(ESTA_TABELA);
  Result.AddNotation('ID', ESTA_ID, [TNotacaoConstraint.PK, TNotacaoConstraint.AutoInc])
        .AddNotation('IDEmpresa', ESTA_ID_EMPRESA)
        .AddNotation('IDEstadia', ESTA_ID_ESTADIA)
        .AddNotation('Nome', ESTA_NOME)
        .AddNotation('Celular', ESTA_CELULAR);
end;

class function TNotacoesFactory.GrupoProdutos: iNotacao;
begin
  Result := TNotacao.New.AddTableName(PG_TABELA);
  Result.AddNotation('ID',        PG_ID, [TNotacaoConstraint.PK, TNotacaoConstraint.AutoInc])
        .AddNotation('IDEmpresa', PG_IDEMPRESA)
        .AddNotation('Descricao', PG_DESCRICAO)
        .AddNotation('Ativo',     PG_ATIVO);
end;

class function TNotacoesFactory.Produtos: iNotacao;
begin
  Result := TNotacao.New.AddTableName(PROD_TABELA);
  Result.AddJoin(' inner join ' + PG_TABELA + ' on ' + PG_ID + ' = ' + PROD_ID_GRUPO);
  Result.AddNotation('ID',          PROD_ID, [TNotacaoConstraint.PK, TNotacaoConstraint.AutoInc])
        .AddNotation('IDEmpresa',   PROD_ID_EMPRESA)
        .AddNotation('Descricao',   PROD_DESCRICAO)
        .AddNotation('NomeGrupo',   PG_DESCRICAO, [TNotacaoConstraint.IgnoreWriteSQLs])
        .AddNotation('ValorCusto',  PROD_VALOR_CUSTO)
        .AddNotation('ValorVenda',  PROD_VALOR_VENDA)
        .AddNotation('IDCategoria', PROD_ID_GRUPO)
        .AddNotation('Ativo',       PROD_ATIVO);
end;

class function TNotacoesFactory.UnidadeHabitacional: iNotacao;
begin
  Result := TNotacao.New.AddTableName(UH_TABELA);
  Result.AddJoin(' inner join ' + UHCAT_TABELA + ' on ' + UHCAT_ID + ' = ' + UH_ID_GRUPO);
  Result.AddNotation('ID',        UH_ID, [TNotacaoConstraint.PK, TNotacaoConstraint.AutoInc])
        .AddNotation('IDEmpresa', UH_ID_EMPRESA)
        .AddNotation('Descricao', UH_DESCRICAO)
        .AddNotation('IDGrupo',   UH_ID_GRUPO)
        .AddNotation('NomeGrupo', UHCAT_DESCRICAO, [TNotacaoConstraint.IgnoreWriteSQLs])
        .AddNotation('Ativo',     UH_ATIVO);
end;

class function TNotacoesFactory.UnidadeHabitacionalCaracteristicas: iNotacao;
begin
  Result := TNotacao.New.AddTableName(UHCAR_TABELA);
  Result.AddNotation('ID',        UHCAR_ID, [TNotacaoConstraint.PK, TNotacaoConstraint.AutoInc])
        .AddNotation('IDEmpresa', UHCAR_IDEMPRESA)
        .AddNotation('Descricao', UHCAR_DESCRICAO)
        .AddNotation('Ativo',     UHCAR_ATIVO);
end;

class function TNotacoesFactory.UnidadeHabitacionalCategoria: iNotacao;
begin
  Result := TNotacao.New.AddTableName('UNIDADE_HABITACIONAL_CATEGORIA');
  Result.AddNotation('ID',        'UHC_ID', [TNotacaoConstraint.PK, TNotacaoConstraint.AutoInc])
        .AddNotation('IDEmpresa', 'UHC_ID_EMPRESA')
        .AddNotation('Descricao', 'UHC_DESCRICAO')
        .AddNotation('Ativo',     'UHC_ATIVO');
end;

class function TNotacoesFactory.Usuario: iNotacao;
begin
  Result := TNotacao.New.AddTableName(USU_TABELA);
  Result.AddNotation('ID',             USU_ID, [TNotacaoConstraint.PK, TNotacaoConstraint.AutoInc])
        .AddNotation('IDEmpresa',      USU_ID_EMPRESA)
        .AddNotation('Nome',           USU_NOME)
        .AddNotation('SobreNome',      USU_SOBRENOME)
        .AddNotation('CPF',            USU_CPF)
        .AddNotation('RG',             USU_RG)
        .AddNotation('Email',          USU_EMAIL)
        .AddNotation('Senha',          USU_SENHA)
        .AddNotation('DataNascimento', USU_DATA_NASCIMENTO, [TNotacaoConstraint.DateField])
        .AddNotation('Telefone',       USU_TELEFONE)
        .AddNotation('DataCadastro',   USU_DATA_CADASTRO, [TNotacaoConstraint.DateField])
        .AddNotation('Logradouro',     USU_LOGRADOURO)
        .AddNotation('Numero',         USU_NUMERO)
        .AddNotation('Bairro',         USU_BAIRRO)
        .AddNotation('Cidade',         USU_CIDADE)
        .AddNotation('UF',             USU_UF)
        .AddNotation('CEP',            USU_CEP)
        .AddNotation('Ativo',          USU_ATIVO)
end;

end.
