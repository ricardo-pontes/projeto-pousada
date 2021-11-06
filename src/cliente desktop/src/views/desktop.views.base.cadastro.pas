unit desktop.views.base.cadastro;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Actions,
  System.Generics.Collections,

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
  FMX.DateTimeCtrls,
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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FEstadoCrud : TEstadoCrud;
    FListen: TDictionary<string, string>;
    FFormAnterior: string;
  public
    { Public declarations }
    property EstadoCrud: TEstadoCrud read FEstadoCrud write FEstadoCrud;
    procedure LimparComponentesCrud;
    procedure SetListItemAtivo(aValue : string; aItem : TListViewItem);

    property Listen: TDictionary<string, string> read FListen write FListen;
    property FormAnterior: string read FFormAnterior write FFormAnterior;
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

procedure TViewBaseCadastro.FormCreate(Sender: TObject);
begin
  inherited;
  FListen:= TDictionary<string, string>.Create;
end;

procedure TViewBaseCadastro.FormDestroy(Sender: TObject);
begin
  inherited;
  FListen.DisposeOf;
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
    end
    else if lComponent is TDateEdit then
      TDateEdit(lComponent).Text := EmptyStr;

  end;

end;

procedure TViewBaseCadastro.SetListItemAtivo(aValue: string; aItem: TListViewItem);
begin
  if aValue = 'S' then
  begin
    TListItemText(aItem.Objects.FindDrawable('Situacao')).TextColor := TAlphaColorRec.Red;
    TListItemText(aItem.Objects.FindDrawable('Situacao')).Font.Style := [TFontStyle.fsUnderline];
    TListItemText(aItem.Objects.FindDrawable('Situacao')).Text := 'desativar';
  end
  else if aValue = 'N' then
  begin
    TListItemText(aItem.Objects.FindDrawable('Situacao')).TextColor := TAlphaColorRec.Green;
    TListItemText(aItem.Objects.FindDrawable('Situacao')).Font.Style := [TFontStyle.fsUnderline];
    TListItemText(aItem.Objects.FindDrawable('Situacao')).Text := 'ativar';
  end;
end;

end.
