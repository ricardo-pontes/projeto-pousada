unit cliente.presenter.unidadeshabitacionais.interfaces;

interface

uses
  System.Generics.Collections,
  System.Classes,
  entidades.unidadehabitacional;

type
  iPresenterUnidadesHabitacionaisView = interface
    ['{9D340DA9-BD5E-4F67-A508-082F0C9125BC}']
    procedure CarregarUnidadesHabitacionais(aUnidadesHabitacionais : TObjectList<TUnidadeHabitacional>);
    function Instancia : TComponent;
  end;

implementation

end.
