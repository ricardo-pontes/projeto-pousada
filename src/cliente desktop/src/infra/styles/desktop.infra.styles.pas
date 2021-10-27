unit desktop.infra.styles;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl;

type
  TViewStyles = class(TForm)
    Button1: TButton;
    StyleBook1: TStyleBook;
    Button2: TButton;
    TabControl1: TTabControl;
    Button3: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewStyles: TViewStyles;

implementation

{$R *.fmx}

end.
