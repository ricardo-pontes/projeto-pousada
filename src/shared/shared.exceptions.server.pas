unit shared.exceptions.server;

interface

uses
  System.SysUtils,
  shared.exceptions;

type
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
      THorseResponse(aFramework).Send(aException.Message).Status(THTTPStatus.Conflict)
    else if aException is ExceptionFalhaBancoDados then
      THorseResponse(aFramework).Send(aException.Message).Status(THTTPStatus.InternalServerError)
    else if aException is ExceptionConversao then
      THorseResponse(aFramework).Send(aException.Message).Status(THTTPStatus.BadRequest)
    else
      THorseResponse(aFramework).Send('Houve uma falha não catalogada em nosso servidor.').Status(THTTPStatus.InternalServerError)
  end;
end;

end.
