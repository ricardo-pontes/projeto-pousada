unit cliente.infra.repository.base.crud.interfaces;

interface

type
  iRepositoryBaseCrud<T:class, constructor> = interface
    ['{19D5FF0C-B7C3-4E3C-84C3-5A10BB9D9513}']
    procedure Alterar(aValue : T);
    function BuscarPorID(aID : string) : T;
    procedure Inserir(aValue : T);
  end;

implementation

end.
