unit uCepPaiConsulta;

interface

uses
  REST.Types, System.JSON, System.Generics.Collections,
  uRestCliente, uTypes;

type
  TCepPaiConsulta = class
  private
    FRestCliente: TRestCliente;
    function GetEndereco(const aValor: string): TEndereco;
    function AddParametroCep(const aPath: string; const aPorta: integer; const aCEP: string): TJSONValue;
    procedure CarregarArray(const aEnderecos: TJSONValue; out aResultado: TEnderecos);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Consultar(const aPath: string; const aPorta: integer; const aCEP: string): TEndereco; overload; virtual;
    function Consultar(const aPath: string; const aPorta: integer): TEnderecos; overload; virtual;
  end;

implementation

uses
  System.SysUtils, uConst, uFuncoes;

{ TBuscarCEP }

constructor TCepPaiConsulta.Create;
begin
  FRestCliente:= TRestCliente.Create;
end;

destructor TCepPaiConsulta.Destroy;
begin
  FreeAndNil(FRestCliente);
  inherited;
end;

function TCepPaiConsulta.AddParametroCep(const aPath: string; const aPorta: integer; const aCEP: string): TJSONValue;
var
  lLista: TObjectList<TParametros>;
  lItem: TParametros;
begin
  lLista := TObjectList<TParametros>.Create(True);
  try
    lItem       := TParametros.Create;
    lItem.Campo := 'CEP';
    lItem.Valor := StrInteiro(aCEP);
    lLista.Add(lItem);
    Result := FRestCliente.OnExecutarCliente(aPath, aPorta, lLista, rmGET);
  finally
    lLista.Clear;
    FreeAndNil(lLista);
  end;
end;

procedure TCepPaiConsulta.CarregarArray(const aEnderecos: TJSONValue; out aResultado: TEnderecos);
var
  lJSONArray: TJSONArray;
  i: integer;
begin
  lJSONArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(aEnderecos.ToString), 0) as TJSONArray;
  try
    SetLength(aResultado, 0);
    for i := 0 to lJSONArray.Count - 1 do
    begin
      setlength(aResultado, length(aResultado) +1);
      aResultado[i].Id         := lJSONArray.Items[i].GetValue<Integer>('ID', 0);
      aResultado[i].CEP        := lJSONArray.Items[i].GetValue<string>('CEP', EmptyStr);
      aResultado[i].UF         := lJSONArray.Items[i].GetValue<string>('UF', EmptyStr);
      aResultado[i].Cidade     := lJSONArray.Items[i].GetValue<string>('CIDADE', EmptyStr);
      aResultado[i].Bairro     := lJSONArray.Items[i].GetValue<string>('BAIRRO', EmptyStr);
      aResultado[i].Logradouro := lJSONArray.Items[i].GetValue<string>('LOGRADOURO', EmptyStr);
    end;
  finally
    lJSONArray.Free;
  end;
end;

function TCepPaiConsulta.Consultar(const aPath: string; const aPorta: integer): TEnderecos;
begin
  CarregarArray(AddParametroCep(aPath + cGetCeps, aPorta, EmptyStr), Result);
end;

function TCepPaiConsulta.Consultar(const aPath: string; const aPorta: integer; const aCEP: string): TEndereco;
begin
  Result := GetEndereco(AddParametroCep(aPath + cGetCep, aPorta, aCEP).ToString);
end;

function TCepPaiConsulta.GetEndereco(const aValor: string): TEndereco;
var
  lJSObj: TJSONObject;
begin
  lJSObj := TJSONObject.ParseJSONValue(aValor) as TJSONObject;
  try
    Result.CEP        := TJSONValue(lJSObj.Get('cep').JsonValue).Value;
    Result.UF         := TJSONValue(lJSObj.Get('state').JsonValue).Value;
    Result.Cidade     := TJSONValue(lJSObj.Get('city').JsonValue).Value;
    Result.Bairro     := TJSONValue(lJSObj.Get('neighborhood').JsonValue).Value;
    Result.Logradouro := TJSONValue(lJSObj.Get('street').JsonValue).Value;
  finally
    lJSObj.Free;
  end;
end;

end.
