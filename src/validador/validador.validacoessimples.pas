unit validador.validacoessimples;

interface

type
  TValidacoes = class
    class procedure CampoAtivoPadrao(aString, aDescricao: string);
    class procedure NumeroNaoPodeSerMenorQueZero(aNumero : integer; aDescricao : string); overload;
    class procedure NumeroNaoPodeSerMenorQueZero(aNumero : Extended; aDescricao : string); overload;
    class procedure NumeroNaoPodeSerIgualAZero(aNumero : integer; aDescricao : string); overload;
    class procedure NumeroNaoPodeSerIgualAZero(aNumero : Extended; aDescricao : string); overload;
    class procedure NumeroDeveSerMaiorQueZero(aNumero : integer; aDescricao : string); overload;
    class procedure NumeroDeveSerMaiorQueZero(aNumero : Extended; aDescricao : string); overload;
    class procedure NumeroSoPodeSerZero(aNumero : integer; aDescricao : string); overload;
    class procedure NumeroSoPodeSerZero(aNumero : Extended; aDescricao : string); overload;

    class procedure StringNaoPodeSerVazia(aString : string; aDescricao : string);
    class procedure StringDeveConterXCaracteres(aString : string; aTamanho : integer; aDescricao : string);
    class procedure StringNaoPodeSerVaziaEDeveConterXCaracteres(aString : string; aTamanho : integer; aDescricao : string);
    class procedure DataNaoPodeSerVazia(aData : TDateTime; aDescricao : string);
    class procedure Data1NaoPodeSerMaiorQueData2(aData1, aData2 : TDateTime; aMensagem : string);
    class procedure DataNaoPodeExcederDataHoje(aData : TDateTime; aDescricao : string);
    class procedure DataNaoPodeSerVaziaNemExcederDataHoje(aData : TDateTime; aDescricao : string);
    class procedure CNPJValido(aCNPJ : string);
    class procedure EmailValido(aEmail : string);
  end;

implementation

uses
  System.SysUtils,
  System.Math,
  System.StrUtils,
  System.RegularExpressions;

{ TValidacoes }

class procedure TValidacoes.CampoAtivoPadrao(aString, aDescricao: string);
begin
  if aString.IsEmpty then
    raise Exception.Create('Informe se (o)a ' + aDescricao + ' está ativa ou não.');

  if (aString <> 'S') and (aString <> 'N') then
    raise Exception.Create('Só são aceitos "S" ou "N" no campo Ativo');
end;

class procedure TValidacoes.CNPJValido(aCNPJ: string);
var
  v: array[1..2] of Word;
  cnpj: array[1..14] of Byte;
  I: Byte;
begin
  { Verificando se tem 11 caracteres }
  if Length(aCNPJ) <> 14 then
  begin
    Exit;
  end;

  { Conferindo se todos dígitos são iguais }
  if aCNPJ = StringOfChar('0', 14) then
    Exit;

  if aCNPJ = StringOfChar('1', 14) then
    Exit;

  if aCNPJ = StringOfChar('2', 14) then
    Exit;

  if aCNPJ = StringOfChar('3', 14) then
    Exit;

  if aCNPJ = StringOfChar('4', 14) then
    Exit;

  if aCNPJ = StringOfChar('5', 14) then
    Exit;

  if aCNPJ = StringOfChar('6', 14) then
    Exit;

  if aCNPJ = StringOfChar('7', 14) then
    Exit;

  if aCNPJ = StringOfChar('8', 14) then
    Exit;

  if aCNPJ = StringOfChar('9', 14) then
    Exit;

  for I := 1 to 14 do
    cnpj[i] := StrToInt(aCNPJ[i]);

  //Nota: Calcula o primeiro dígito de verificação.
  v[1] := 5*cnpj[1] + 4*cnpj[2]  + 3*cnpj[3]  + 2*cnpj[4];
  v[1] := v[1] + 9*cnpj[5] + 8*cnpj[6]  + 7*cnpj[7]  + 6*cnpj[8];
  v[1] := v[1] + 5*cnpj[9] + 4*cnpj[10] + 3*cnpj[11] + 2*cnpj[12];
  v[1] := 11 - v[1] mod 11;
  v[1] := IfThen(v[1] >= 10, 0, v[1]);

  //Nota: Calcula o segundo dígito de verificação.
  v[2] := 6*cnpj[1] + 5*cnpj[2]  + 4*cnpj[3]  + 3*cnpj[4];
  v[2] := v[2] + 2*cnpj[5] + 9*cnpj[6]  + 8*cnpj[7]  + 7*cnpj[8];
  v[2] := v[2] + 6*cnpj[9] + 5*cnpj[10] + 4*cnpj[11] + 3*cnpj[12];
  v[2] := v[2] + 2*v[1];
  v[2] := 11 - v[2] mod 11;
  v[2] := IfThen(v[2] >= 10, 0, v[2]);

  //Nota: Verdadeiro se os dígitos de verificação são os esperados.
  if not ((v[1] = cnpj[13]) and (v[2] = cnpj[14])) then
    raise Exception.Create('O CNPJ informado é inválido');
end;

class procedure TValidacoes.Data1NaoPodeSerMaiorQueData2(aData1,
  aData2: TDateTime; aMensagem: string);
begin
  if aData1 > aData2 then
    raise Exception.Create(aMensagem);
end;

class procedure TValidacoes.DataNaoPodeExcederDataHoje(aData: TDateTime;aDescricao: string);
begin
  if aData > Now then
    raise Exception.Create('A ' + aDescricao + ' não pode ser maior que a data de hoje');
end;

class procedure TValidacoes.DataNaoPodeSerVazia(aData: TDateTime;
  aDescricao: string);
begin
  if aData = 0 then
    raise Exception.Create('A' + aDescricao + ' precisa ser preenchida.');
end;

class procedure TValidacoes.DataNaoPodeSerVaziaNemExcederDataHoje(
  aData: TDateTime; aDescricao: string);
begin
  DataNaoPodeSerVazia(aData, aDescricao);
  DataNaoPodeExcederDataHoje(aData, aDescricao);
end;

class procedure TValidacoes.EmailValido(aEmail: string);
const
  EXPRESSION = '[_a-zA-Z\d\-\.]+@([_a-zA-Z\d\-]+(\.[_a-zA-Z\d\-]+)+)';
begin
  if not TRegEx.IsMatch(aEmail, EXPRESSION) then
    raise Exception.Create('O Email informado é inválido.');
end;
class procedure TValidacoes.NumeroDeveSerMaiorQueZero(aNumero: Extended; aDescricao : string);
begin
  NumeroNaoPodeSerMenorQueZero(aNumero, aDescricao);
  NumeroNaoPodeSerIgualAZero(aNumero, aDescricao);
end;

class procedure TValidacoes.NumeroNaoPodeSerIgualAZero(aNumero: Extended;
  aDescricao: string);
begin
  if aNumero = 0 then
    raise Exception.Create('O(A) ' + aDescricao + ' não pode ser zero.');
end;

class procedure TValidacoes.NumeroNaoPodeSerIgualAZero(aNumero: integer;
  aDescricao: string);
begin
  if aNumero = 0 then
    raise Exception.Create('O(A) ' + aDescricao + ' não pode ser zero.');
end;

class procedure TValidacoes.NumeroNaoPodeSerMenorQueZero(
  aNumero: Extended; aDescricao: string);
begin
  if aNumero < 0 then
    raise Exception.Create('O(A) ' + aDescricao + ' não pode ser menor que zero.');
end;

class procedure TValidacoes.NumeroSoPodeSerZero(aNumero: Extended; aDescricao: string);
begin
  if aNumero <> 0 then
    raise Exception.Create('O(A) ' + aDescricao + ' só pode ser zero.');
end;

class procedure TValidacoes.NumeroSoPodeSerZero(aNumero: integer; aDescricao: string);
begin
  if aNumero <> 0 then
    raise Exception.Create('O(A) ' + aDescricao + ' só pode ser zero.');

end;

class procedure TValidacoes.NumeroNaoPodeSerMenorQueZero(
  aNumero: integer; aDescricao: string);
begin
  if aNumero < 0 then
    raise Exception.Create('O(A) ' + aDescricao + ' não pode ser menor que zero.');
end;

class procedure TValidacoes.StringDeveConterXCaracteres(aString : string; aTamanho : integer; aDescricao : string);
begin
  if aString.Length > aTamanho then
    raise Exception.Create('O(A) ' + ' não pode ultrapassar ' + aTamanho.ToString + ' caracteres.');
end;

class procedure TValidacoes.StringNaoPodeSerVazia(aString, aDescricao: string);
begin
  if aString.IsEmpty then
    raise Exception.Create('O(A) ' + aDescricao + ' precisa ser preenchido(a).');
end;

class procedure TValidacoes.StringNaoPodeSerVaziaEDeveConterXCaracteres(
  aString: string; aTamanho: integer; aDescricao: string);
begin
  StringNaoPodeSerVazia(aString, aDescricao);
  StringDeveConterXCaracteres(aString, aTamanho, aDescricao);
end;

class procedure TValidacoes.NumeroDeveSerMaiorQueZero(aNumero: integer; aDescricao : string);
begin
  NumeroNaoPodeSerMenorQueZero(aNumero, aDescricao);
  NumeroNaoPodeSerIgualAZero(aNumero, aDescricao);
end;

end.
