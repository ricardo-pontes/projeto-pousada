unit desktop.views.caracteristicas2;

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
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ActnList,
  FMX.TabControl,
  FMX.Objects,
  FMX.Layouts,
  FMX.ListView,
  FMX.Controls.Presentation,
  desktop.views.base.cadastro,
  cliente.presenter.caracteristicas.interfaces,
  cliente.presenter.caracteristicas,
  entidades.caracteristicas;

type
  TViewBaseCadastro1 = class(TViewBaseCadastro, iPresenterCaracteristicasView)
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FPresenter : TPresenterCaracteristicas;
    procedure CarregarCaracteristicas(aCaracteristicas : TObjectList<TCaracteristica>);
    function Instancia : TComponent;
  public
    { Public declarations }
  end;

var
  ViewBaseCadastro1: TViewBaseCadastro1;

implementation

{$R *.fmx}

{ TViewBaseCadastro1 }

procedure TViewBaseCadastro1.CarregarCaracteristicas(aCaracteristicas: TObjectList<TCaracteristica>);
begin
  ListViewPesquisa.Items.Clear;
  for var lCaracteristica in aCaracteristicas do
  begin
    var lItem := ListViewPesquisa.Items.Add;
    TListItemText(lItem.Objects.FindDrawable('ID')).Text        := lCaracteristica.ID.ToString;
    TListItemText(lItem.Objects.FindDrawable('Descricao')).Text := lCaracteristica.Descricao;
    TListItemImage(lItem.Objects.FindDrawable('Editar')).Bitmap := imgBtnEditar.Bitmap;
  end;
end;

procedure TViewBaseCadastro1.FormCreate(Sender: TObject);
begin
  inherited;
  FPresenter := TPresenterCaracteristicas.Create(Self);
  FPresenter.BuscarPorIEmpresa('1');
end;

procedure TViewBaseCadastro1.FormDestroy(Sender: TObject);
begin
  inherited;
  FPresenter.DisposeOf;
end;

function TViewBaseCadastro1.Instancia: TComponent;
begin
  Result := Self;
end;

end.
