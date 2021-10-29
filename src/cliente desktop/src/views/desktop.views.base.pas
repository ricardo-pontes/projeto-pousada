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

  desktop.views.messagebox,

  Router4D.Interfaces;

type
  TViewBase = class(TForm, iRouter4DComponent)
    lytPrincipal: TLayout;
  private

    { Private declarations }
  public
    function Render : TFMXObject;
    procedure UnRender;
    function GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;
    function MessageBox : TMessageBox;
  end;

var
  ViewBase: TViewBase;

implementation

{$R *.fmx}

uses
  desktop.views.principal,
  FMX.Toast;

{ TViewBase }

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

procedure TViewBase.UnRender;
begin

end;

end.
