unit Model.Enderecos;

interface

type
  TEnderecosModel = class
  private
    FId: Integer;
    FCEP: String;
    FUF: string;
    FCidade: String;
    FBairro: string;
    FLogradouro: string;
  public
    property Id: Integer read FId write FId;
    property CEP: String read FCEP write FCEP;
    property UF: string read FUF write FUF;
    property Cidade: String read FCidade write FCidade;
    property Bairro: string read FBairro write FBairro;
    property Logradouro: string read FLogradouro write FLogradouro;
  end;

implementation

end.
