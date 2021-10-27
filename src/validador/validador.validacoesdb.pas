unit validador.validacoesdb;

interface

uses
  Orion.Data.Interfaces, conversores.notacoes.interfaces;

type
  TValidacoesDB = class
    class procedure InformacaoNaoPodeExistir(aConexao: iConexao; aNotacao : iNotacao; aTabela, aCampo, aDescricao : string; aID: integer; aValor: Variant);
  end;

implementation

uses
  System.SysUtils,
  System.Variants;

{ TValidacoesDB }

class procedure TValidacoesDB.InformacaoNaoPodeExistir(aConexao: iConexao; aNotacao : iNotacao; aTabela, aCampo, aDescricao : string; aID: integer; aValor: Variant);
begin
  var lSQL := TStringBuilder.Create;
  try
    if aID = 0 then
      lSQL.Append('select * from ' + aTabela + ' where ' + aCampo + ' = ' + VarToStr(aValor).QuotedString)
    else
    begin
      lSQL.Append('select * from ' + aTabela + ' where ' + aNotacao.GetPKTableName + ' <> ' + aID.ToString);
      lSQL.Append(' and ' + aCampo + ' = ' + VarToStr(aValor).QuotedString);
    end;

    aConexao.DataSet.SQL(lSQL.ToString).Open;
    if aConexao.DataSet.RecordCount > 0 then
      raise Exception.Create('O(A) ' + aDescricao + ' ' + VarToStr(aValor).QuotedString + ' já existe na base de dados.');
  finally
    lSQL.DisposeOf;
  end;

end;

end.
