unit servidor.controller.base.crud;

interface

uses
  System.JSON,
  System.Classes,
  System.Generics.Collections,
  servidor.controller.base.crud.interfaces,
  servidor.model.base.crud.interfaces,

  validador.interfaces;

type
  TControllerBaseCrud<T : class, constructor> = class(TInterfacedObject, iControllerBaseCrud<T>)
  private
    FModel : iModelBaseCrud<T>;

  public
    constructor Create(aModel : iModelBaseCrud<T>);
    destructor Destroy; override;

    function Alterar(aBody : string) : string; virtual;
    function BuscarPorID(aID : string) : TJSONObject; virtual;
    function Deletar(aID : string) : string; virtual;
    function Inserir(aBody : string) : string; virtual;
  protected
    class function New(aModel : iModelBaseCrud<T>) : iControllerBaseCrud<T>;

    function Resolve(aValue : TObjectList<T>) : TJSONArray; overload;
    function Resolve(aValue : TObject) : TJSONObject; overload;
    function Resolve(aValue : string) : T; overload;
  end;

implementation

{ TControllerBaseCrud<T> }

uses
  servidor.exceptions,
  System.SysUtils,
  shared.json;

function TControllerBaseCrud<T>.Alterar(aBody: string) : string;
begin
  var lEntidade : T;
  try
    lEntidade := Resolve(aBody);
  except on E: Exception do
    raise ExceptionFalhaConversaoObjeto.Create;
  end;

  FModel.Alterar(lEntidade);
end;

function TControllerBaseCrud<T>.BuscarPorID(aID: string) : TJSONObject;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise Exception.Create('só é aceito número no parâmetro ID');

  Result := Resolve(FModel.BuscarPorID(lID));
end;

constructor TControllerBaseCrud<T>.Create(aModel : iModelBaseCrud<T>);
begin
  FModel := aModel;
end;

function TControllerBaseCrud<T>.Deletar(aID : string) : string;
begin
  var lID := 0;
  if not TryStrToInt(aID, lID) then
    raise Exception.Create('só é aceito número no parâmetro ID');

  FModel.Deletar(lID);
end;

destructor TControllerBaseCrud<T>.Destroy;
begin

  inherited;
end;

function TControllerBaseCrud<T>.Inserir(aBody : string) : string;
begin
  var lEntidade : T;
  try
    lEntidade := Resolve(aBody);
  except on E: Exception do
    raise ExceptionFalhaConversaoObjeto.Create;
  end;
  Result := FModel.Inserir(lEntidade);
end;

class function TControllerBaseCrud<T>.New(aModel : iModelBaseCrud<T>) : iControllerBaseCrud<T>;
begin
  Result := Self.Create(aModel);
end;

function TControllerBaseCrud<T>.Resolve(aValue: string): T;
begin
  try
    Result := TJSONConverter.JsonToObject<T>(aValue);
  except on E: Exception do
    raise ExceptionFalhaConversaoObjeto.Create;
  end;
end;

function TControllerBaseCrud<T>.Resolve(aValue: TObject): TJSONObject;
begin
  Result := TJSONConverter.ObjectToJson(aValue);
end;

function TControllerBaseCrud<T>.Resolve(aValue: TObjectList<T>): TJSONArray;
begin
  Result := TJSONConverter.ObjectListToJson<T>(aValue);
end;

end.
