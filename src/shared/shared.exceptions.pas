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
  Message := 'As informa��es enviadas n�o est�o de acordo com o requerido. A��o cancelada';
end;

{ ExceptionConversaoNumerica }

constructor ExceptionConversaoNumerica.Create;
begin
  Message := 'S� s�o aceitos n�meros no par�metro.';
end;

{ ExceptionFalhaBancoDadosGravacao }

constructor ExceptionFalhaBancoDadosGravacao.Create;
begin
  Message := 'N�o foi poss�vel salvar as informa��es na nossa base de dados.';
end;

{ ExceptionFalhaBancoDadosLeitura }

constructor ExceptionFalhaBancoDadosLeitura.Create;
begin
  Message := 'N�o foi poss�vel buscar as informa��es na nossa base de dados.';
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
