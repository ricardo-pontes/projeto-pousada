unit desktop.views.base.cadastro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, desktop.views.base, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.TabControl, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, System.Actions, FMX.ActnList;

type
  TViewBaseCadastro = class(TViewBase)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    TabControl1: TTabControl;
    TabItemPesquisa: TTabItem;
    TabItemCadastro: TTabItem;
    Layout1: TLayout;
    ButtonNovo: TButton;
    Layout2: TLayout;
    ListViewPesquisa: TListView;
    Layout3: TLayout;
    ButtonSalvar: TButton;
    Button4: TButton;
    FlowLayout1: TFlowLayout;
    ActionList1: TActionList;
    ChangeTabActionCadastro: TChangeTabAction;
    ChangeTabActionPesquisa: TChangeTabAction;
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewBaseCadastro: TViewBaseCadastro;

implementation

{$R *.fmx}

procedure TViewBaseCadastro.ButtonNovoClick(Sender: TObject);
begin
  inherited;
  ChangeTabActionCadastro.Execute;
end;

procedure TViewBaseCadastro.ButtonSalvarClick(Sender: TObject);
begin
  inherited;
  ChangeTabActionPesquisa.Execute;
end;

end.
