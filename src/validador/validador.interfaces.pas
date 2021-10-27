unit validador.interfaces;

interface

uses
  System.SysUtils,
  System.Generics.Collections;

type
  iValidacao = interface
    ['{6389A67A-0FA5-4DE5-A8A8-3D93349E5D39}']
  end;

  TValidacaoEntidade = TFunc<TObject, string>;

  iValidacaoEntidade = interface(iValidacao)
    ['{4EB0018A-8491-45B4-851B-1F5A1A59E7D2}']
    function AddEntidade(aValue : TObject) :iValidacaoEntidade;
    function Executar : iValidacaoEntidade;
  end;

  iValidador = interface
    ['{5A0F4764-C23B-43DE-BBD9-FCD00F8DDCC9}']
    function Clear : iValidador;
    function Add(aValue : TValidacaoEntidade) : iValidador; overload;
    function Add(aValidacao : iValidacaoEntidade) : iValidador; overload;
    function Add(aValue : TList<TValidacaoEntidade>) : iValidador; overload;
    function Executar(aEntidade : TObject) : string;
  end;

implementation

end.
