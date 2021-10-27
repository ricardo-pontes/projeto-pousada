unit conversores.notacoes;

interface

uses
  conversores.notacoes.interfaces,
  Data.DB,
  System.Generics.Collections;

type
  TNotacaoItem = record
  private
    PropertyName : string;
    DataSetFieldName : string;
    Constraints : TNotacaoConstraints;
  end;

  TNotacaoEngine = class
  private
    class var FNotacoes : TDictionary<string, iNotacao>;
  public
    class constructor Create;
    class destructor Destroy;
    class procedure AddNotacao(aValue : iNotacao; aClassName : string);
    class function GetNotacao(aClassName : string) : iNotacao;
  end;

  TNotacao = class(TInterfacedObject, iNotacao)
  private
    FDataset : TDataset;
    FObject : TObject;
    FClassType : TClass;
    FTableName : string;
    FJoins : TList<string>;
    FNotacoes : TList<TNotacaoItem>;
    procedure InternalResolveToDataSet(aDataSet : TDataSet; aObject : TObject);
    procedure InternalResolveToObject(aObject : TObject; aDataSet : TDataSet);
    procedure PrepareDataSet(aDataset : TDataSet);
    function BuildSQLInsert(aSetByPK : boolean = true; aSQL : string = '') : string;
    function BuildSQLUpdate(aSetByPK : boolean = true) : string;
    function BuildSqLSelect(aSetByPK : boolean = True) : string;
    function BuildSqLDelete(aSetByPK : boolean = True) : string;
  public
    constructor Create; overload;
    constructor Create(aObject : TObject; aDataSet : TDataSet); overload;
    constructor Create(aObject : TObject; aDataSet : TDataSet; aTableName : string); overload;

    destructor Destroy; override;

    class function New : iNotacao; overload;
    class function New(aObject : TObject; aDataSet : TDataSet) : iNotacao; overload;
    class function New(aObject : TObject; aDataSet : TDataSet; aTableName : string) : iNotacao; overload;

    function AddObject(aObject : TObject; aClasstype : TClass) : iNotacao;
    function AddDataSet(aDataset : TDataset) : iNotacao;
    function AddTableName(aValue : string) : iNotacao;
    function AddJoin(aValue : string) : iNotacao;
    function AddNotation(aObjectPropertyName, aDataSetFieldName : string; aConstraints : TNotacaoConstraints = []) : iNotacao;
    function BuildSQL(aTipoSql : TTipoSql; aSetByPK : boolean = True) : string;
    function GetPKTableName : string;

    procedure ResolveToDataset; overload;
    procedure ResolveToDataSet(aObject : TObject; aDataSet : TDataSet); overload;
    procedure ResolveToObject; overload;
    procedure ResolveToObject(aObject : TObject; aDataSet : TDataSet); overload;
  end;

implementation

uses
  System.Rtti,
  System.SysUtils,
  System.Variants;

{ TNotacao }

function TNotacao.AddDataSet(aDataset: TDataset): iNotacao;
begin
  Result := Self;
  FDataset := aDataset;
end;

function TNotacao.AddJoin(aValue: string): iNotacao;
begin
  Result := Self;
  FJoins.Add(aValue);
end;

function TNotacao.AddNotation(aObjectPropertyName, aDataSetFieldName : string; aConstraints : TNotacaoConstraints = []) : iNotacao;
begin
  Result := Self;
  var lNotacaoItem : TNotacaoItem;
  lNotacaoItem.PropertyName     := aObjectPropertyName;
  lNotacaoItem.DataSetFieldName := aDataSetFieldName;
  lNotacaoItem.Constraints      := aConstraints;
  FNotacoes.Add(lNotacaoItem);
end;

function TNotacao.AddObject(aObject : TObject; aClasstype : TClass) : iNotacao;
begin
  Result := Self;
  FObject := aObject;
  FClassType := aClasstype;
end;

function TNotacao.AddTableName(aValue: string): iNotacao;
begin
  Result := Self;
  FTableName := aValue;
end;

function TNotacao.BuildSQL(aTipoSql : TTipoSql; aSetByPK : boolean = True) : string;
begin
  if FTableName.IsEmpty then
    raise Exception.Create(Self.QualifiedClassName + '.BuildSqL : Nome da tabela não incluso.');

  case aTipoSql of
    TTipoSql.Select: Result := BuildSqLSelect(aSetByPK);
    TTipoSql.Update: Result := BuildSQLUpdate(aSetByPK);
    TTipoSql.Insert: Result := BuildSQLInsert(aSetByPK);
    TTipoSql.Delete: Result := BuildSqLDelete(aSetByPK);
  end;
end;

function TNotacao.BuildSqLDelete(aSetByPK : boolean = True): string;
begin
  Result := 'delete from ' + FTableName;
  if aSetByPK then
  begin
    var lWhere := '';
    for var lNotacaoItem in FNotacoes do
    begin
      for var lConstraint in lNotacaoItem.Constraints do
      begin
        if lConstraint = TNotacaoConstraint.PK then
          lWhere := ' where ' + lNotacaoItem.DataSetFieldName + ' = '
      end;
    end;
    Result := Result + ' ' + lWhere;
  end;
end;

function TNotacao.BuildSQLInsert(aSetByPK : boolean = true; aSQL : string = ''): string;
begin
  var lSQL     := TStringBuilder.Create;
  var lContext := TRttiContext.Create;
  var lType    := lContext.GetType(FObject.ClassInfo);
  var lValues  := TStringBuilder.Create;
  var lSQLReturning := '';
  var lProperty : TRttiProperty;
  try
    var lPassou := False;
    lSQL.Append('insert into ' + FTableName + '(');
    for var lNotacaoItem in FNotacoes do
    begin
      var lAutoInc := False;
      var lIgnore := False;
      for var lConstraint in lNotacaoItem.Constraints do
      begin
        if lConstraint = TNotacaoConstraint.PK then
          lSQLReturning := ' returning ' + lNotacaoItem.DataSetFieldName;

        if lConstraint = TNotacaoConstraint.AutoInc then
          lAutoInc := True;

        if lConstraint = TNotacaoConstraint.IgnoreWriteSQLs then
          lIgnore := True;
      end;

      if lAutoInc then
        Continue;

      if lIgnore then
        Continue;

      if lPassou then
      begin
        lSQL.Append(',');
        lValues.Append(',');
      end;

      lSQL.Append(lNotacaoItem.DataSetFieldName);

      lProperty := lType.GetProperty(lNotacaoItem.PropertyName);
      if Assigned(lProperty) then
      begin
        case lProperty.PropertyType.TypeKind of
          tkInteger     : lValues.Append(lProperty.GetValue(Pointer(FObject)).AsInteger);
          tkChar        : lValues.Append(lProperty.GetValue(Pointer(FObject)).AsString.QuotedString);
          tkFloat       : lValues.Append(lProperty.GetValue(Pointer(FObject)).AsExtended.ToString.Replace(',', '.', [rfReplaceAll]));
          tkString      : lValues.Append(lProperty.GetValue(Pointer(FObject)).AsString.QuotedString);
          tkWChar       : lValues.Append(lProperty.GetValue(Pointer(FObject)).AsString.QuotedString);
          tkLString     : lValues.Append(lProperty.GetValue(Pointer(FObject)).AsString.QuotedString);
          tkWString     : lValues.Append(lProperty.GetValue(Pointer(FObject)).AsString.QuotedString);
          tkUString     : lValues.Append(lProperty.GetValue(Pointer(FObject)).AsString.QuotedString);
          tkInt64       : lValues.Append(lProperty.GetValue(Pointer(FObject)).AsInt64);
          tkSet         : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkSet não implementado.');
          tkClass       : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkClass  não implementado.');
          tkMethod      : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkMethod não implementado.');
          tkUnknown     : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkUnknown não implementado.');
          tkEnumeration : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkEnumetarion não implementado.');
          tkVariant     : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkVariant não implementado.');
          tkArray       : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkArray não implementado.');
          tkRecord      : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkRecord  não implementado.');
          tkInterface   : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkInterface não implementado.');
          tkDynArray    : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkDynArray não implementado.');
          tkClassRef    : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkClassRef não implementado.');
          tkPointer     : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkPointer não implementado.');
          tkProcedure   : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkProcedure não implementado.');
          tkMRecord     : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLInsert : Tipo tkMRecord não implementado.');

        end;
      end;
      lPassou := True;
    end;
    lSQL.Append(') values (').Append(lValues.ToString).Append(')');
    if not lSQLReturning.IsEmpty then
      lSQL.Append(lSQLReturning);

    Result := lSQL.ToString;
  finally
    lSQL.DisposeOf;
    lValues.DisposeOf;
  end;
end;

function TNotacao.BuildSqLSelect(aSetByPK : boolean = True) : string;
begin
  if FNotacoes.Count = 0 then
    raise Exception.Create(Self.QualifiedClassName +  '.BuildSqlSelect : Nenhuma notação adicionada.');

  var lSQL    := TStringBuilder.Create;
  var lPassou := False;
  var lWhere  := '';
  try
    lSQL.Append('select ');
    for var lNotacaoItem in FNotacoes do
    begin
      if aSetByPK then
      begin
        for var lConstraint in lNotacaoItem.Constraints do
        begin
          if lConstraint = TNotacaoConstraint.PK then
            lWhere := ' where ' + lNotacaoItem.DataSetFieldName + ' = ';
        end;
      end;

      if lPassou then
        lSQL.Append(', ');

      lSQL.Append(lNotacaoItem.DataSetFieldName);
      lPassou := True;
    end;
     lSQL.Append(' from ' + FTableName);

    if FJoins.Count > 0 then
    begin
      for var lJoin in FJoins do
        lSQL.Append(lJoin);
    end;

    if not lWhere.IsEmpty then
      lSQL.Append(lWhere);

    Result := lSQL.ToString;
  finally
    lSQL.DisposeOf;
  end;
end;

function TNotacao.BuildSQLUpdate(aSetByPK : boolean): string;
begin
  if not Assigned(FObject) then
    Exit;

  var lCampo : string;
  var lValor : Variant;
  var lSQL     := TStringBuilder.Create;
  var lContext := TRttiContext.Create;
  var lType    := lContext.GetType(FObject.ClassInfo);
  var lPassou  := False;

  try
    lSQL.Append('update ' + FTableName + ' set ');

    for var lNotacaoItem in FNotacoes do
    begin
      var lProperty := lType.GetProperty(lNotacaoItem.PropertyName);
      var lIgnore := False;
      if Assigned(lProperty) then
      begin
        for var lConstraint in lNotacaoItem.Constraints do
        begin
          if lConstraint = TNotacaoConstraint.PK then
          begin
            lCampo := lNotacaoItem.DataSetFieldName;
            lValor := lProperty.GetValue(Pointer(FObject)).AsInteger;
          end;

          if lConstraint = TNotacaoConstraint.IgnoreWriteSQLs then
            lIgnore := True;
        end;

        if lIgnore then
          Continue;

        if lPassou then
        begin
          lSQL.Append(',');
        end;

        case lProperty.PropertyType.TypeKind of
          tkInteger     : lSQL.Append(lNotacaoItem.DataSetFieldName).Append('=').Append(lProperty.GetValue(Pointer(FObject)).AsInteger);
          tkInt64       : lSQL.Append(lNotacaoItem.DataSetFieldName).Append('=').Append(lProperty.GetValue(Pointer(FObject)).AsInt64);
          tkChar        : lSQL.Append(lNotacaoItem.DataSetFieldName).Append('=').Append(lProperty.GetValue(Pointer(FObject)).AsString.QuotedString);
          tkFloat       : lSQL.Append(lNotacaoItem.DataSetFieldName).Append('=').Append(lProperty.GetValue(Pointer(FObject)).AsExtended.ToString.Replace(',', '.', [rfReplaceAll]));
          tkString      : lSQL.Append(lNotacaoItem.DataSetFieldName).Append('=').Append(lProperty.GetValue(Pointer(FObject)).AsString.QuotedString);
          tkWChar       : lSQL.Append(lNotacaoItem.DataSetFieldName).Append('=').Append(lProperty.GetValue(Pointer(FObject)).AsString.QuotedString);
          tkLString     : lSQL.Append(lNotacaoItem.DataSetFieldName).Append('=').Append(lProperty.GetValue(Pointer(FObject)).AsString.QuotedString);
          tkWString     : lSQL.Append(lNotacaoItem.DataSetFieldName).Append('=').Append(lProperty.GetValue(Pointer(FObject)).AsString.QuotedString);
          tkUString     : lSQL.Append(lNotacaoItem.DataSetFieldName).Append('=').Append(lProperty.GetValue(Pointer(FObject)).AsString.QuotedString);
          tkSet         : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkSet não implementado.');
          tkClass       : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkClass  não implementado.');
          tkMethod      : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkMethod não implementado.');
          tkUnknown     : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkUnknown não implementado.');
          tkEnumeration : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkEnumetarion não implementado.');
          tkVariant     : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkVariant não implementado.');
          tkArray       : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkArray não implementado.');
          tkRecord      : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkRecord  não implementado.');
          tkInterface   : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkInterface não implementado.');
          tkDynArray    : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkDynArray não implementado.');
          tkClassRef    : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkClassRef não implementado.');
          tkPointer     : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkPointer não implementado.');
          tkProcedure   : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkProcedure não implementado.');
          tkMRecord     : raise Exception.Create(Self.QualifiedClassName + '.BuildSQLUpdate : Tipo tkMRecord não implementado.');
        end;
        lPassou := True;
      end;
    end;

    if not lCampo.IsEmpty then
    begin
      lSQL.Append(' where ' + lCampo + ' = ' + VarToStr(lValor));
    end;
    Result := lSQL.ToString;
  finally
    lSQL.DisposeOf;
  end;
end;

constructor TNotacao.Create(aObject: TObject; aDataSet: TDataSet;
  aTableName: string);
begin
  Create;
  FDataset   := aDataSet;
  FObject    := aObject;
  FTableName := aTableName;
end;

constructor TNotacao.Create(aObject: TObject; aDataSet: TDataSet);
begin
  Create;
  FDataset  := aDataSet;
  FObject   := aObject;
end;

constructor TNotacao.Create;
begin
  FNotacoes := TList<TNotacaoItem>.Create;
  FJoins    := TList<string>.Create;
end;

destructor TNotacao.Destroy;
begin
  FNotacoes.DisposeOf;
  FJoins.DisposeOf;
  inherited;
end;

function TNotacao.GetPKTableName: string;
begin
  for var lNotacaoItem in FNotacoes do
  begin
    for var lConstraint in lNotacaoItem.Constraints do
    begin
      if lConstraint = TNotacaoConstraint.PK then
      begin
        Result := lNotacaoItem.DataSetFieldName;
        Exit;
      end;
    end;
  end;
end;

procedure TNotacao.InternalResolveToDataSet(aDataSet: TDataSet; aObject: TObject);
begin
  var lContextObject := TRttiContext.Create;
  var lTypeObject    := lContextObject.GetType(aObject.ClassInfo);
  var lPropObject : TRttiProperty;
  var lField :TField;

  for var lNotacaoItem in FNotacoes do
  begin
    lPropObject := lTypeObject.GetProperty(lNotacaoItem.PropertyName);
    if Assigned(lPropObject) then
    begin
      lField := aDataSet.FindField(lNotacaoItem.DataSetFieldName);
      if Assigned(lField) then
      begin
        case lField.DataType of
          ftString     : lField.AsString     := lPropObject.GetValue(Pointer(aObject.ClassInfo)).AsString;
          ftSmallint   : lField.AsInteger    := lPropObject.GetValue(Pointer(aObject.ClassInfo)).AsInteger;
          ftInteger    : lField.AsInteger    := lPropObject.GetValue(Pointer(aObject.ClassInfo)).AsInteger;
          ftBoolean    : lField.AsBoolean    := lPropObject.GetValue(Pointer(aObject.ClassInfo)).AsBoolean;
          ftFloat      : lField.AsFloat      := lPropObject.GetValue(Pointer(aObject.ClassInfo)).AsExtended;
          ftCurrency   : lField.AsCurrency   := lPropObject.GetValue(Pointer(aObject.ClassInfo)).AsCurrency;
          ftBCD        : lField.AsVariant    := lPropObject.GetValue(Pointer(aObject.ClassInfo)).AsVariant;
          ftDate       : lField.AsVariant    := lPropObject.GetValue(Pointer(aObject.ClassInfo)).AsVariant;
          ftTime       : lField.AsVariant    := lPropObject.GetValue(Pointer(aObject.ClassInfo)).AsVariant;
          ftDateTime   : lField.AsVariant    := lPropObject.GetValue(Pointer(aObject.ClassInfo)).AsVariant;
          ftFixedChar  : lField.AsString     := lPropObject.GetValue(Pointer(aObject.ClassInfo)).AsString;
          ftWideString : lField.AsWideString := lPropObject.GetValue(Pointer(aObject.ClassInfo)).AsString;
          ftLargeint   : lField.AsLargeInt   := lPropObject.GetValue(Pointer(aObject.ClassInfo)).AsInt64;
          ftBlob: raise Exception.Create('conversores.notacoes.TNotacao.InternalResolveToDataset : Formato Blob não suportado.');
        end;
      end;
    end;
  end;
end;

procedure TNotacao.InternalResolveToObject(aObject: TObject; aDataSet: TDataSet);
begin
  var lContextObject := TRttiContext.Create;
  var lTypeObject    := lContextObject.GetType(aObject.ClassInfo);
  var lPropObject : TRttiProperty;
  var lField :TField;

  for var lNotacaoItem in FNotacoes do
  begin
//    lPropObject := nil;
    lPropObject := lTypeObject.GetProperty(lNotacaoItem.PropertyName);
    if Assigned(lPropObject) then
    begin
//      lField := nil;
      lField := aDataSet.FindField(lNotacaoItem.DataSetFieldName);
      if Assigned(lField) then
      begin
        case lPropObject.PropertyType.TypeKind of
          tkInteger     : lPropObject.SetValue(Pointer(aObject), lField.AsInteger);
          tkChar        : lPropObject.SetValue(Pointer(aObject), lField.AsString);
          tkFloat       : lPropObject.SetValue(Pointer(aObject), lField.AsFloat);
          tkString      : lPropObject.SetValue(Pointer(aObject), lField.AsString);
          tkWChar       : lPropObject.SetValue(Pointer(aObject), lField.AsString);
          tkLString     : lPropObject.SetValue(Pointer(aObject), lField.AsString);
          tkWString     : lPropObject.SetValue(Pointer(aObject), lField.AsString);
          tkVariant     : lPropObject.SetValue(Pointer(aObject), TValue.FromVariant(lField.AsVariant));
          tkInt64       : lPropObject.SetValue(Pointer(aObject), lField.AsLargeInt);
          tkUString     : lPropObject.SetValue(Pointer(aObject), lField.AsString);
          tkSet         : raise Exception.Create(Self.QualifiedClassName + '.InternalResolveToObject : Formato tkSet não suportado.');
          tkClass       : raise Exception.Create(Self.QualifiedClassName + '.InternalResolveToObject : Formato tkClass não suportado.');
          tkMethod      : raise Exception.Create(Self.QualifiedClassName + '.InternalResolveToObject : Formato tkMethod não suportado.');
          tkArray       : raise Exception.Create(Self.QualifiedClassName + '.InternalResolveToObject : Formato tkArray não suportado.');
          tkRecord      : raise Exception.Create(Self.QualifiedClassName + '.InternalResolveToObject : Formato tkRecord não suportado.');
          tkInterface   : raise Exception.Create(Self.QualifiedClassName + '.InternalResolveToObject : Formato tkInterface não suportado.');
          tkDynArray    : raise Exception.Create(Self.QualifiedClassName + '.InternalResolveToObject : Formato tkDynArray não suportado.');
          tkEnumeration : raise Exception.Create(Self.QualifiedClassName + '.InternalResolveToObject : Formato tkEnumeration não suportado.');
          tkClassRef    : raise Exception.Create(Self.QualifiedClassName + '.InternalResolveToObject : Formato tkClassRef não suportado.');
          tkPointer     : raise Exception.Create(Self.QualifiedClassName + '.InternalResolveToObject : Formato tkPointer não suportado.');
          tkProcedure   : raise Exception.Create(Self.QualifiedClassName + '.InternalResolveToObject : Formato tkProcedure não suportado.');
          tkMRecord     : raise Exception.Create(Self.QualifiedClassName + '.InternalResolveToObject : Formato tkMRecord não suportado.');
        end;
      end;
    end;
  end;
end;

class function TNotacao.New(aObject: TObject; aDataSet: TDataSet): iNotacao;
begin
  Result := Self.Create(aObject, aDataSet);
end;

procedure TNotacao.PrepareDataSet(aDataset: TDataSet);
begin
  if aDataset.RecordCount > 0 then
    aDataset.Edit
  else
    aDataset.Append;
end;

class function TNotacao.New: iNotacao;
begin
  Result := Self.Create;
end;

procedure TNotacao.ResolveToDataset;
begin
  if FObject.ClassName = 'TObjectList<T>' then
  begin
    for var lObject in TObjectList<TObject>(FObject) do
    begin
      PrepareDataSet(FDataset);
      InternalResolveToDataSet(FDataset, lObject);
      FDataset.Post;
    end;
    Exit;
  end;
  PrepareDataSet(FDataset);
  InternalResolveToDataSet(FDataset, FObject);
  FDataset.Post;
end;

procedure TNotacao.ResolveToObject;
begin
  if FObject.ClassName.Contains('TObjectList') then
  begin
    FDataset.First;
    while not FDataset.Eof do
    begin
      var lObject := FClassType.Create;
      InternalResolveToObject(lObject, FDataset);
      TObjectList<TObject>(FObject).Add(lObject);
      FDataset.Next;
    end;
    Exit;
  end;
  InternalResolveToObject(FObject, FDataset);
end;

procedure TNotacao.ResolveToDataset(aObject: TObject; aDataSet: TDataSet);
begin
  FDataset := aDataSet;
  FObject  := aObject;
  InternalResolveToDataSet(aDataSet, aObject);
end;

procedure TNotacao.ResolveToObject(aObject: TObject; aDataSet: TDataSet);
begin
  FDataset := aDataSet;
  FObject  := aObject;
  InternalResolveToObject(aObject, aDataSet);
end;

class function TNotacao.New(aObject: TObject; aDataSet: TDataSet; aTableName: string): iNotacao;
begin
  Result := Self.Create(aObject, aDataset, aTableName);
end;

{ TNotacaoEngine }

class procedure TNotacaoEngine.AddNotacao(aValue : iNotacao; aClassName : string);
begin
  FNotacoes.Add(aClassName, aValue);
end;

class constructor TNotacaoEngine.Create;
begin
  FNotacoes := TDictionary<string, iNotacao>.Create;
end;

class destructor TNotacaoEngine.Destroy;
begin
  FNotacoes.DisposeOf;
end;

class function TNotacaoEngine.GetNotacao(aClassName: string): iNotacao;
begin
  if not FNotacoes.ContainsKey(aClassName) then
    raise Exception.Create(Self.QualifiedClassName + 'GetNotacao : classtype ' + aClassName + 'não foi encontrado.');

  Result := FNotacoes.Items[aClassName];
end;

end.
