unit shared.exceptions;

interface

uses
  System.SysUtils;

type
  ExceptionPersonalizada = class(Exception)

  end;

  ExceptionConversao = class(ExceptionPersonalizada)

  end;

  ExceptionConversaoNumerica = class(ExceptionConversao)
    constructor Create;
  end;

  ExceptionNaoEncontrado = class(ExceptionPersonalizada)

  end;

  ExceptionFalhaBancoDados = class(ExceptionPersonalizada)

  end;

  ExceptionFalhaBancoDadosGravacao = class(ExceptionFalhaBancoDados)
    constructor Create;
  end;

  ExceptionFalhaBancoDadosLeitura = class(ExceptionFalhaBancoDados)
    constructor Create;
  end;

  ExceptionValidacao = class(ExceptionPersonalizada)

  end;

  ExceptionFalhaConversaoObjeto = class(ExceptionConversao)
    constructor Create;
  end;

  TSharedExceptionsRest = class
    class procedure Checar(aStatusCode : integer; aMensagem : string);
  end;

implementation

{ ExceptionFalhaConversaoObjeto }

constructor ExceptionFalhaConversaoObjeto.Create;
begin
  Message := 'As informações enviadas não estão de acordo com o requerido. Ação cancelada';
end;

{ ExceptionConversaoNumerica }

constructor ExceptionConversaoNumerica.Create;
begin
  Message := 'Só são aceitos números no parâmetro.';
end;

{ ExceptionFalhaBancoDadosGravacao }

constructor ExceptionFalhaBancoDadosGravacao.Create;
begin
  Message := 'Não foi possível salvar as informações na nossa base de dados.';
end;

{ ExceptionFalhaBancoDadosLeitura }

constructor ExceptionFalhaBancoDadosLeitura.Create;
begin
  Message := 'Não foi possível buscar as informações na nossa base de dados.';
end;

{ TSharedExceptionsRest }

class procedure TSharedExceptionsRest.Checar(aStatusCode : integer; aMensagem : string);
begin
  if aStatusCode = 404 then
    raise ExceptionNaoEncontrado.Create(aMensagem)
  else if aStatusCode = 428 then
    raise ExceptionValidacao.Create(aMensagem);
end;

end.
