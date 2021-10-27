unit cliente.infra.binds;

interface

uses
  Orion.Bindings.Interfaces;

type
  TBinds = class
    class function New : iOrionBindings;
  end;

implementation

uses
  Orion.Bindings,
  Orion.Bindings.Middlewares.NativeDelphi;

{ TBinds }

class function TBinds.New: iOrionBindings;
begin
  Result := TOrionBindings.New.Use(NativeDelphiComponents);
end;

end.
