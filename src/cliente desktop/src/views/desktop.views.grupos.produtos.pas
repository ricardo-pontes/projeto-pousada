unit desktop.views.grupos.produtos;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Actions,

  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,

  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.Layouts,
  FMX.ListView,
  FMX.TabControl,
  FMX.Controls.Presentation,
  FMX.Objects,
  FMX.ActnList,

  desktop.views.base.cadastro, FMX.Edit;

type
  TViewGrupoProdutos = class(TViewBaseCadastro)
    Edit1: TEdit;
    Label0: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Switch1: TSwitch;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewGrupoProdutos: TViewGrupoProdutos;

implementation

{$R *.fmx}

end.
