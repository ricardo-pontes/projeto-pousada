unit cliente.presenter.caracteristicas.interfaces;

interface

uses
  System.Generics.Collections,
  System.Classes,
  entidades.caracteristicas;

type
  iPresenterCaracteristicasView = interface
    ['{45B0AF6D-B5F3-4430-8825-0D4F3B2580B3}']
    procedure CarregarCaracteristicas(aCaracteristicas : TObjectList<TCaracteristica>);
    function Instancia : TComponent;
  end;

implementation

end.
