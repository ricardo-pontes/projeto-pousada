unit validador;

interface

uses
  validador.interfaces,
  System.Generics.Collections;

type
  TValidador = class(TInterfacedObject, iValidador)
  private
    FValidacoesEntidade : TList<iValidacaoEntidade>;
    FValidacoes : TList<TValidacaoEntidade>;
  public
    constructor Create;
    destructor Destroy; override;

    function Clear : iValidador;
    function Add(aValidacao : iValidacaoEntidade) : iValidador; overload;
    function Add(aValue : TValidacaoEntidade) : iValidador; overload;
    function Add(aValue : TList<TValidacaoEntidade>) : iValidador; overload;
    function Executar(aEntidade : TObject) : string;
  end;

implementation

uses
  System.SysUtils;

{ TValidador }

function TValidador.Add(aValidacao: iValidacaoEntidade): iValidador;
begin
  Result := Self;
  FValidacoesEntidade.Add(aValidacao);
end;

function TValidador.Add(aValue: TValidacaoEntidade): iValidador;
begin
  Result := Self;
  FValidacoes.Add(aValue);
end;

function TValidador.Add(aValue: TList<TValidacaoEntidade>): iValidador;
begin
  Result := Self;
  for var lValidacao in aValue do
  begin
    if not FValidacoes.Contains(lValidacao) then
      FValidacoes.Add(lValidacao);
  end;
  aValue.DisposeOf;
end;

function TValidador.Clear: iValidador;
begin
  Result := Self;
  FValidacoesEntidade.Clear;
end;

constructor TValidador.Create;
begin
  FValidacoesEntidade := TList<iValidacaoEntidade>.Create;
  FValidacoes         := TList<TValidacaoEntidade>.Create;
end;

destructor TValidador.Destroy;
begin
  FValidacoesEntidade.DisposeOf;
  FValidacoes.DisposeOf;
  inherited;
end;

function TValidador.Executar(aEntidade : TObject) : string;
begin
  for var lValidacao in FValidacoesEntidade do
    lValidacao.AddEntidade(aEntidade).Executar;

  for var lValidacao in FValidacoes do
    lValidacao(aEntidade);
end;

end.
