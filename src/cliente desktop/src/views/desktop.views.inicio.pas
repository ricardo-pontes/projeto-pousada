unit desktop.views.inicio;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  desktop.views.base,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation;

type
  TViewInicio = class(TViewBase)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Line1: TLine;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewInicio: TViewInicio;

implementation

{$R *.fmx}

end.
