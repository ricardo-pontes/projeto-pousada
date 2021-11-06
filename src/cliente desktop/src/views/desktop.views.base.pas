unit desktop.views.base;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.ListView.Types,
  FMX.TextLayout,
  FMX.ListBox,

  desktop.views.messagebox,

  Router4D.Interfaces;

type
  TViewBase = class(TForm, iRouter4DComponent)
    lytPrincipal: TLayout;
  private

  public
    function Render : TFMXObject; virtual;
    procedure UnRender; virtual;
    function GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;
    function MessageBox : TMessageBox;
    procedure ShowToast(aOwner : TComponent; aException : Exception); overload;
    procedure ShowToast(aOwner : TComponent; aMessage : string); overload;
    procedure ShowToast(aOwner : TComponent; aMessage : string; aDuracao : integer); overload;
    procedure ShowToastSuccess(aOwner : TComponent; aMessage : string);
    procedure CarregarComboBoxUF(aComboBox : TComboBox);
  end;

var
  ViewBase: TViewBase;

implementation

{$R *.fmx}

uses
  desktop.views.principal,
  FMX.Toast,
  shared.exceptions;

{ TViewBase }

procedure TViewBase.CarregarComboBoxUF(aComboBox: TComboBox);
begin
  aComboBox.Items.Clear;
  aCombobox.Items.Append('AC');
  aCombobox.Items.Append('AL');
  aCombobox.Items.Append('AP');
  aCombobox.Items.Append('AM');
  aCombobox.Items.Append('BA');
  aCombobox.Items.Append('CE');
  aCombobox.Items.Append('DF');
  aCombobox.Items.Append('ES');
  aCombobox.Items.Append('GO');
  aCombobox.Items.Append('MA');
  aCombobox.Items.Append('MT');
  aCombobox.Items.Append('MS');
  aCombobox.Items.Append('MG');
  aCombobox.Items.Append('PA');
  aCombobox.Items.Append('PB');
  aCombobox.Items.Append('PR');
  aCombobox.Items.Append('PE');
  aCombobox.Items.Append('PI');
  aCombobox.Items.Append('RJ');
  aCombobox.Items.Append('RN');
  aCombobox.Items.Append('RS');
  aCombobox.Items.Append('RO');
  aCombobox.Items.Append('RR');
  aCombobox.Items.Append('SC');
  aCombobox.Items.Append('SP');
  aCombobox.Items.Append('SE');
  aCombobox.Items.Append('TO');
end;

function TViewBase.GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;
var
  Layout: TTextLayout;
begin
  // Create a TTextLayout to measure text dimensions
  Layout := TTextLayoutManager.DefaultTextLayout.Create;
  try
    Layout.BeginUpdate;
    try
      // Initialize layout parameters with those of the drawable
      Layout.Font.Assign(D.Font);
      Layout.VerticalAlign := D.TextVertAlign;
      Layout.HorizontalAlign := D.TextAlign;
      Layout.WordWrap := D.WordWrap;
      Layout.Trimming := D.Trimming;
      Layout.MaxSize := TPointF.Create(Width, TTextLayout.MaxLayoutSize.Y);
      Layout.Text := Text;
    finally
      Layout.EndUpdate;
    end;
    // Get layout height
    Result := Round(Layout.Height);
    // Add one em to the height
    Layout.Text := 'm';
    Result := Result + Round(Layout.Height);
  finally
    Layout.Free;
  end;
end;

function TViewBase.MessageBox: TMessageBox;
begin
  Result := MessageBox;
  Result.Render := ViewPrincipal.Layout2;
end;

function TViewBase.Render: TFMXObject;
begin
  Result := lytPrincipal;
end;

procedure TViewBase.ShowToast(aOwner: TComponent; aException: Exception);
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

procedure TViewBase.ShowToast(aOwner: TComponent; aMessage: string);
begin
  TToast.New(TFMXObject(aOwner)).Success(aMessage);
end;

procedure TViewBase.ShowToastSuccess(aOwner: TComponent; aMessage: string);
begin
  TToast.New(TFMXObject(aOwner)).Success(aMessage);
end;

procedure TViewBase.UnRender;
begin

end;

procedure TViewBase.ShowToast(aOwner: TComponent; aMessage: string; aDuracao: integer);
begin
  TToast.New(TFMXObject(aOwner)).Duration(aDuracao).Info(aMessage);
end;

end.
