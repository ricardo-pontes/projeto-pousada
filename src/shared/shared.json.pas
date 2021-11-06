unit shared.json;

interface

uses
  System.Generics.Collections,
  System.JSON,
  System.SysUtils,
  Rest.JSON;

type
  TJSONConverter = class
  private
    class function InternaObjectToJSON(aObject : TObject) : TJSONObject;
  public
    class function JsonToObject<T:class, constructor>(aJson : TJSONObject) : T; overload;
    class function JsonToObject<T:class, constructor>(aJson : string) : T; overload;
    class function JsonToObjectList<T: class, constructor>(aJson: string) : TObjectList<T>;
    class function ObjectToJson(aObject : TObject) : TJSONObject;
    class function ObjectoJsonString(aObject : TObject) : string;
    class function ObjectListToJson<T: class, constructor>(aObjectList: TObjectList<T>): TJSONArray;
    class function ObjectListToJsonString<T:class, constructor>(aObjectList : TObjectList<T>) : string;
  end;

implementation

uses
  System.Rtti,
  System.NetEncoding;
{ TJSONConverter }

class function TJSONConverter.InternaObjectToJSON(aObject : TObject) : TJSONObject;
begin
  Result := nil;
  if not Assigned(aObject) then
    Exit;

  Result := TJSONObject.Create;

  var lContext := TRttiContext.Create;
  var lType := lContext.GetType(aObject.ClassInfo);
  try
    for var lProp in lType.GetProperties do
    begin
      case lProp.PropertyType.TypeKind of
        tkInt64:     Result.AddPair(lProp.Name, TJSONNumber.Create(lProp.GetValue(Pointer(aObject)).AsInt64));
        tkInteger:   Result.AddPair(lProp.Name, TJSONNumber.Create(lProp.GetValue(Pointer(aObject)).AsInteger));
        tkFloat:     Result.AddPair(lProp.Name, TJSONNumber.Create(lProp.GetValue(Pointer(aObject)).AsExtended));
        tkString:    Result.AddPair(lProp.Name, lProp.GetValue(Pointer(aObject)).AsString);
        tkWChar:     Result.AddPair(lProp.Name, lProp.GetValue(Pointer(aObject)).AsString);
        tkLString:   Result.AddPair(lProp.Name, lProp.GetValue(Pointer(aObject)).AsString);
        tkWString:   Result.AddPair(lProp.Name, lProp.GetValue(Pointer(aObject)).AsString);
        tkUString:   Result.AddPair(lProp.Name, lProp.GetValue(Pointer(aObject)).AsString);
        tkClass:
        begin
          if lProp.GetValue(Pointer(aObject)).AsObject.QualifiedClassName.Contains('TObjectList') then
          begin
            var lArray := TJSONArray.Create;
            for var lObject in TObjectList<TObject>(lProp.GetValue(Pointer(aObject)).AsObject) do
            begin
              lArray.Add(InternaObjectToJSON(lObject));
            end;
            Result.AddPair(lProp.Name, lArray);
          end
          else
            Result.AddPair(lProp.Name, InternaObjectToJSON(lprop.GetValue(Pointer(aObject)).AsObject));
        end;
        tkUnknown:     raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkUnknown não implementado.');
        tkChar:        raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkChar não implementado.');
        tkEnumeration: raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkEnumeration não implementado.');
        tkSet:         raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkSet não implementado.');
        tkMethod:      raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkMethod não implementado.');
        tkVariant:     raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkVariant não implementado.');
        tkArray:       raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkArray não implementado.');
        tkRecord:      raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkRecord não implementado.');
        tkInterface:   raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkInterface não implementado.');
        tkDynArray:    raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkDynArray não implementado.');
        tkClassRef:    raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkClassRef não implementado.');
        tkPointer:     raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkPointer não implementado.');
        tkProcedure:   raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkProcedure não implementado.');
        tkMRecord:     raise Exception.Create(Self.QualifiedClassName + '.InternalJsonToObject : tipo tkrecord não implementado.');
      end;
    end;
  finally
    lContext.Free;
  end;
end;

class function TJSONConverter.JsonToObject<T>(aJson: string): T;
begin
  Result := TJson.JsonToObject<T>(aJson);
end;

class function TJSONConverter.JsonToObjectList<T>(aJson: string): TObjectList<T>;
begin
  var lJSON := TJSONObject.ParseJSONValue(aJson);
  try
    if Assigned(lJSON) and (lJSON is TJSONArray) then
    begin
      Result := TObjectList<T>.Create;
      for var lJSONObject in TJSONArray(lJSON) do
      begin
        var lObject := TJson.JsonToObject<T>(lJSONObject as TJSONObject);
        Result.Add(lObject);
      end;
    end;
  finally
    if Assigned(lJSON) then lJSON.DisposeOf;
  end;
end;

class function TJSONConverter.JsonToObject<T>(aJson: TJSONObject): T;
begin
  Result := TJson.JsonToObject<T>(aJson);
end;

class function TJSONConverter.ObjectListToJson<T>(aObjectList: TObjectList<T>): TJSONArray;
begin
  Result := TJSONArray.Create;
  if not Assigned(aObjectList) then
    Exit;

  if aObjectList.Count > 0 then
  begin
    for var lObject in aObjectList do
    begin
      Result.AddElement(ObjectToJson(lObject));
    end;
  end;
end;

class function TJSONConverter.ObjectListToJsonString<T>(aObjectList : TObjectList<T>) : string;
begin
  Result := ObjectListToJson<T>(aObjectList).ToJSON;
end;

class function TJSONConverter.ObjectoJsonString(aObject: TObject): string;
begin
  Result := TJson.ObjectToJsonString(aObject);
end;

class function TJSONConverter.ObjectToJson(aObject: TObject): TJSONObject;
begin
  Result := TJson.ObjectToJsonObject(aObject);
//  Result := InternaObjectToJSON(aObject);
end;

end.
