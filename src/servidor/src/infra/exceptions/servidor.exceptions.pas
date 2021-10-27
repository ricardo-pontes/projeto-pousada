unit servidor.exceptions;

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

  TExceptions = class
  public
    class procedure Tratar(aException : Exception; aFramework : TObject);
  end;
implementation

uses
  Horse,
  Horse.Commons;

{ TExceptions }

class procedure TExceptions.Tratar(aException : Exception; aFramework : TObject);
begin
  if aFramework is THorseResponse then
  begin
    if aException is ExceptionNaoEncontrado then
      THorseResponse(aFramework).Send(aException.Message).Status(THttpStatus.NotFound)
    else if aException is ExceptionValidacao then
      THorseResponse(aFramework).Send(aException.Message).Status(THTTPStatus.UnprocessableEntity)
    else if aException is ExceptionFalhaBancoDados then
      THorseResponse(aFramework).Send(aException.Message).Status(THTTPStatus.InternalServerError)
    else if aException is ExceptionConversao then
      THorseResponse(aFramework).Send(aException.Message).Status(THTTPStatus.BadRequest)
    else
      THorseResponse(aFramework).Send('Houve uma falha n�o catalogada em nosso servidor.').Status(THTTPStatus.InternalServerError)
  end;
end;

{ ExceptionFalhaBancoDadosInserir }

constructor ExceptionFalhaBancoDadosGravacao.Create;
begin
  Message := 'N�o foi poss�vel salvar as informa��es na nossa base de dados.';
end;

{ ExceptionFalhaBancoDadosBuscar }

constructor ExceptionFalhaBancoDadosLeitura.Create;
begin
  Message := 'N�o foi poss�vel buscar as informa��es na nossa base de dados.';
end;

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

end.
