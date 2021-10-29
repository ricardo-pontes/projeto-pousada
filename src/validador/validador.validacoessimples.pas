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
  end;

implementation

uses
  System.SysUtils;

{ TValidacoes }

class procedure TValidacoes.CampoAtivoPadrao(aString, aDescricao: string);
begin
  if aString.IsEmpty then
    raise Exception.Create('Informe se (o)a ' + aDescricao + ' está ativa ou não.');

  if (aString <> 'S') and (aString <> 'N') then
    raise Exception.Create('Só são aceitos "S" ou "N" no campo Ativo');
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
