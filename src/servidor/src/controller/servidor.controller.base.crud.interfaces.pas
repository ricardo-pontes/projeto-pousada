unit servidor.controller.base.crud.interfaces;

interface

uses
  System.Generics.Collections,
  System.Classes,
  System.JSON;

type
  iControllerBaseCrud<T : class> = interface
    function Alterar(aBody : string) : string;
    function BuscarPorID(aID : string) : TJSONObject;
    function Deletar(aID : string) : string;
    function Inserir(aBody : string) : string;
    function Resolve(aValue : TObjectList<T>) : TJSONArray; overload;
    function Resolve(aValue : TObject) : TJSONObject; overload;
  end;

implementation

end.
