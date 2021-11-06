unit desktop.views.unidadeshabitacionais.categorias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, desktop.views.base.cadastro,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, System.Actions, FMX.ActnList,
  FMX.TabControl, FMX.Objects, FMX.Layouts, FMX.ListView, FMX.Controls.Presentation;

type
  TViewUnidadesHabitacionaisCategorias = class(TViewBaseCadastro)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewUnidadesHabitacionaisCategorias: TViewUnidadesHabitacionaisCategorias;

implementation

{$R *.fmx}

end.
