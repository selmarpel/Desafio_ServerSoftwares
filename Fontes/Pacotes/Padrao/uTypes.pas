unit uTypes;

interface

type

  TEndereco = record
    Id: Integer;
    CEP: string;
    UF: string;
    Cidade: string;
    Bairro: string;
    Logradouro: string;
  end;

  TEnderecos = array of TEndereco;

implementation

end.
