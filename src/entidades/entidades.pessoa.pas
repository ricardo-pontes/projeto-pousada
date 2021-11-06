unit entidades.pessoa;

interface

type
  TPessoa = class
  private
    FID: integer;
    FLogradouro: string;
    FNumero: string;
    FBairro: string;
    FCidade: string;
    FUF: string;
    FTelefone: string;
    FDataCadastro: TDateTime;
    FCEP: string;
    FEmail: string;
    FAtivo: string;
    FWhatsapp: string;
    FInstagram: string;
    FFacebook: string;
  public
    property ID: integer read FID write FID;
    property Telefone: string read FTelefone write FTelefone;
    property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Numero: string read FNumero write FNumero;
    property Bairro: string read FBairro write FBairro;
    property Cidade: string read FCidade write FCidade;
    property UF: string read FUF write FUF;
    property CEP: string read FCEP write FCEP;
    property Email: string read FEmail write FEmail;
    property Ativo: string read FAtivo write FAtivo;
    property Whatsapp: string read FWhatsapp write FWhatsapp;
    property Instagram: string read FInstagram write FInstagram;
    property Facebook: string read FFacebook write FFacebook;
  end;

  TPessoaFisica = class(TPessoa)
  private
    FCPF: string;
    FRG: string;
    FDataNascimento: TDateTime;
    FNome: string;
    FSobreNome: string;
    function GetNomeCompleto: string;
  public
    property Nome: string read FNome write FNome;
    property SobreNome: string read FSobreNome write FSobreNome;
    property NomeCompleto: string read GetNomeCompleto;
    property CPF: string read FCPF write FCPF;
    property RG: string read FRG write FRG;
    property DataNascimento: TDateTime read FDataNascimento write FDataNascimento;
  end;

  TPessoaJuridica = class(TPessoa)
  private
    FRazaoSocial: string;
    FFantasia: string;
    FCNPJ: string;
    FSite : string;
  public
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property Fantasia: string read FFantasia write FFantasia;
    property CNPJ: string read FCNPJ write FCNPJ;
    property Site: string read FSite write FSite;
  end;

implementation

uses
  System.SysUtils;

{ TPessoaFisica }

function TPessoaFisica.GetNomeCompleto: string;
begin
  if not FSobreNome.Trim.IsEmpty then
    Result := FNome + ' ' + FSobreNome
  else
    Result := FNome;
end;

end.
