unit conversores.notacoes.interfaces;

interface

uses
  Data.DB;

type
  iNotacao = interface;
  {$SCOPEDENUMS ON}
  TTipoSql = (Select, Update, Insert, Delete);
  TNotacaoConstraint = (PK, AutoInc, IgnoreWriteSQLs, DateField);
  {$SCOPEDENUMS OFF}

  TNotacaoConstraints = set of TNotacaoConstraint;

  iNotacaoEngine = interface
    ['{42952664-A60E-4F02-9EE9-3F9F9E596FBC}']
    function AddNotacao(aNotacao : iNotacao) : iNotacaoEngine;
  end;

  iNotacao = interface
    ['{5F108790-9F74-46BF-B09C-90831CB9AC31}']
    function AddObject(aObject : TObject; aClasstype : TClass) : iNotacao;
    function AddDataSet(aDataset : TDataset) : iNotacao;
    function AddTableName(aValue : string) : iNotacao;
    function AddJoin(aValue : string) : iNotacao;
    function AddNotation(aObjectPropertyName, aDataSetFieldName : string; aConstraints : TNotacaoConstraints = []) : iNotacao;
    function BuildSQL(aTipoSql : TTipoSql; aSetByPK : boolean = True) : string;
    function GetPKTableName : string;
    procedure ResolveToDataset;
    procedure ResolveToObject;
  end;

implementation

end.
