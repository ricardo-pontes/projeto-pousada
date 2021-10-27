unit entidades.endereco;

interface

type
  TEndereco = class
  private
    FLogradouro: string;
    FNumero: integer;
    FBairro: string;
    FUF: string;
    FCodigoMunicipio: integer;
    FMunicipio: string;
    FCEP: string;

  public
    property Logradouro: string read FLogradouro write FLogradouro;
    property Numero: integer read FNumero write FNumero;
    property Bairro: string read FBairro write FBairro;
    property CodigoMunicipio: integer read FCodigoMunicipio write FCodigoMunicipio;
    property Municipio: string read FMunicipio write FMunicipio;
    property UF: string read FUF write FUF;
    property CEP: string read FCEP write FCEP;
  end;
implementation

end.
