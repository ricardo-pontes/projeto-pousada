unit desktop.views.base.cadastro;

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
  FMX.Layouts,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.TabControl,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  FMX.ActnList,
  FMX.Edit,
  FMX.ListBox,
  desktop.views.base;

type
  {$SCOPEDENUMS ON}
  TEstadoCrud = (Edicao, Insercao, Nenhum);
  {$SCOPEDENUMS OFF}
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
    imgBtnEditar: TImage;
    Line1: TLine;
    Line2: TLine;
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    FEstadoCrud : TEstadoCrud;
  public
    { Public declarations }
    property EstadoCrud: TEstadoCrud read FEstadoCrud write FEstadoCrud;
    procedure LimparComponentesCrud;
    procedure ShowToast(aOwner : TComponent; aException : Exception); overload;
    procedure ShowToast(aOwner : TComponent; aMessage : string); overload;
    procedure ShowToastSuccess(aOwner : TComponent; aMessage : string);
  end;

var
  ViewBaseCadastro: TViewBaseCadastro;

implementation

uses
  FMX.Toast, shared.exceptions;

{$R *.fmx}

procedure TViewBaseCadastro.Button4Click(Sender: TObject);
begin
  inherited;
  ChangeTabActionPesquisa.Execute;
end;

procedure TViewBaseCadastro.ButtonNovoClick(Sender: TObject);
begin
  inherited;
  LimparComponentesCrud;
  ChangeTabActionCadastro.Execute;
  EstadoCrud := TEstadoCrud.Insercao;
end;

procedure TViewBaseCadastro.ButtonSalvarClick(Sender: TObject);
begin
  inherited;
  EstadoCrud := TEstadoCrud.Nenhum;
  ChangeTabActionPesquisa.Execute;
  ShowToastSuccess(TabControl1, 'Informações salvas com sucesso.');
end;

procedure TViewBaseCadastro.LimparComponentesCrud;
begin
  for var lComponent in FlowLayout1.Controls do
  begin
    if lComponent is TCustomEdit then
      TCustomEdit(lComponent).Text := EmptyStr
    else if lComponent is TComboBox then
    begin
      TComboBox(lComponent).ListBox.Clear;
      TComboBox(lComponent).ItemIndex := -1;
    end;
  end;

end;

procedure TViewBaseCadastro.ShowToast(aOwner: TComponent; aMessage: string);
begin
  TToast.New(TFMXObject(aOwner)).Success(aMessage);
end;

procedure TViewBaseCadastro.ShowToastSuccess(aOwner: TComponent; aMessage: string);
begin
  TToast.New(TFMXObject(aOwner)).Success(aMessage);
end;

procedure TViewBaseCadastro.ShowToast(aOwner : TComponent; aException: Exception);
begin
  if aException is ExceptionNaoEncontrado then
    TToast.New(TFMXObject(aOwner)).Info(aException.Message)
  else if aException is ExceptionValidacao then
    TToast.New(TFMXObject(aOwner)).Warning(aException.Message)
  else if aException is ExceptionConversao then
    TToast.New(TFMXObject(aOwner)).Error(aException.Message)
  else
    TToast.New(TFMXObject(aOwner)).Error('Houve uma falha inesperada na ação.');
end;

end.
