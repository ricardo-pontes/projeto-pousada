unit desktop.views.principal;

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
  FMX.Objects,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  Router4D;

type
  TViewPrincipal = class(TForm)
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle1: TRectangle;
    Rectangle5: TRectangle;
    lytForms: TLayout;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.fmx}

uses desktop.views.produtos;

procedure TViewPrincipal.Button1Click(Sender: TObject);
begin
  WindowState := TWindowState.wsMinimized;
end;

procedure TViewPrincipal.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin
  TRouter4D.Render<TViewProdutos>.SetElement(lytForms, Layout2);
  TRouter4D.Link.&To('produtos');
end;

end.