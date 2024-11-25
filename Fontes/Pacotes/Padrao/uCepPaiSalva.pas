unit uCepPaiSalva;

interface

uses
  System.JSON, REST.Types, uRestCliente, uTypes;

type
  TCepPaiSalva = class(TRestCliente)
  private
    function GetVerboSalvar(aId: integer): TRESTRequestMethod;
    function GetVerboSalvar1(aId: integer): string;
    function PrepararEnviar(const aPath: string; const aPorta: integer; const aEndereco: TEndereco): TJSONValue;
  public
    function EnviarSalvar(const aPath: string; const aPorta: integer; const aEndereco: TEndereco): integer;
    function EnviarExcluir(const aPath: string; const aPorta, aId: integer): string;
  end;

implementation

uses
  System.Generics.Collections, System.SysUtils,
  uFuncoes, uConst;

{ TSalvaCepPai }

function TCepPaiSalva.GetVerboSalvar(aId: integer): TRESTRequestMethod;
begin
  if (aId > 0) then
    Result := rmPUT
  else
    Result := rmPOST;
end;

function TCepPaiSalva.GetVerboSalvar1(aId: integer): string;
begin
  if (aId > 0) then
    Result := cPutCep
  else
    Result := cPostCep;
end;

function TCepPaiSalva.PrepararEnviar(const aPath: string; const aPorta: integer; const aEndereco: TEndereco): TJSONValue;
var
  lLista: TObjectList<TParametros>;
  lItem: TParametros;
begin
  lLista := TObjectList<TParametros>.Create(True);
  try
    with aEndereco do
    begin
      lItem       := TParametros.Create;
      lItem.Campo := 'ID';
      lItem.Valor := IntToStr(Id);
      lLista.Add(lItem);

      lItem       := TParametros.Create;
      lItem.Campo := 'CEP';
      lItem.Valor := StrInteiro(CEP);
      lLista.Add(lItem);

      lItem       := TParametros.Create;
      lItem.Campo := 'UF';
      lItem.Valor := UF;
      lLista.Add(lItem);

      lItem       := TParametros.Create;
      lItem.Campo := 'CIDADE';
      lItem.Valor := Cidade;
      lLista.Add(lItem);

      lItem       := TParametros.Create;
      lItem.Campo := 'BAIRRO';
      lItem.Valor := Bairro;
      lLista.Add(lItem);

      lItem       := TParametros.Create;
      lItem.Campo := 'LOGRADOURO';
      lItem.Valor := Logradouro;
      lLista.Add(lItem);
    end;
    Result := Executar(aPath, aPorta, lLista, GetVerboSalvar(aEndereco.Id));
  finally
    lLista.Clear;
    FreeAndNil(lLista);
  end;
end;

function TCepPaiSalva.EnviarExcluir(const aPath: string; const aPorta, aId: integer): string;
var
  lLista: TObjectList<TParametros>;
  lItem: TParametros;
  lRetorno: TJSONObject;
begin
  lLista := TObjectList<TParametros>.Create(True);
  try
    lItem       := TParametros.Create;
    lItem.Campo := 'ID';
    lItem.Valor := IntToStr(aId);
    lLista.Add(lItem);

    lRetorno := TJSONObject.ParseJSONValue(Executar(aPath + cDeleteCep, aPorta, lLista, rmDELETE).ToString) as TJSONObject;
    try
      Result := TJSONValue(lRetorno.Get('MSG').JsonValue).Value;
    finally
      lRetorno.Free;
    end;

  finally
    lLista.Clear;
    FreeAndNil(lLista);
  end;
end;

function TCepPaiSalva.EnviarSalvar(const aPath: string; const aPorta: integer; const aEndereco: TEndereco): integer;
begin
  Result := StrToIntDef(PrepararEnviar(aPath + GetVerboSalvar1(aEndereco.Id), aPorta, aEndereco).ToString, 0);
end;

end.