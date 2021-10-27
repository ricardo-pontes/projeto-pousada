unit cliente.infra.repository.base.crud;

interface

uses
  cliente.infra.repository.base.crud.interfaces,
  System.Generics.Collections,
  System.JSON;

type
  TRepositoryBaseCrud<T : class, constructor> = class(TInterfacedObject, iRepositoryBaseCrud<T>)
  private

  public
    constructor Create;
    destructor Destroy; override;
    class function New : iRepositoryBaseCrud<T>;

    function Alterar(aValue : T) : string;
    function BuscarPorID(aID : integer) : T;
    function Deletar(aID : integer) : string;
    function Inserir(aValue : T) : string;

  protected
    function Resolve(aValue : TObjectList<T>) : TJSONArray; overload;
    function Resolve(aValue : T) : TJSONObject; overload;
  end;

implementation

uses
  System.SysUtils,
  shared.json;

{ TRepositoryBaseCrud<T> }

function TRepositoryBaseCrud<T>.Alterar(aValue: T): string;
begin

end;

function TRepositoryBaseCrud<T>.BuscarPorID(aID: integer): T;
begin

end;

constructor TRepositoryBaseCrud<T>.Create;
begin

end;

function TRepositoryBaseCrud<T>.Deletar(aID: integer): string;
begin

end;

destructor TRepositoryBaseCrud<T>.Destroy;
begin

  inherited;
end;

function TRepositoryBaseCrud<T>.Inserir(aValue: T): string;
begin

end;

class function TRepositoryBaseCrud<T>.New : iRepositoryBaseCrud<T>;
begin
  Result := Self.Create;
end;

function TRepositoryBaseCrud<T>.Resolve(aValue: TObjectList<T>): TJSONArray;
begin
  Result := TJSONConverter.ObjectListToJson<T>(aValue);
end;

function TRepositoryBaseCrud<T>.Resolve(aValue: T): TJSONObject;
begin
  Result := TJSONConverter.ObjectToJson(aValue);
end;

end.
