unit entidades.contatos;

interface

type
  TContato = class
  private
    FDescricao: string;
    FTipoContato: string;
    FID: integer;

  public
    property ID: integer read FID write FID;
    property TipoContato: string read FTipoContato write FTipoContato;
    property Descricao: string read FDescricao write FDescricao;
  end;

implementation

end.
