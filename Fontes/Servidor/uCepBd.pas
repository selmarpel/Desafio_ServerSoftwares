unit uCepBd;

interface

uses
  System.Generics.Collections, System.Classes, System.JSON,
  Model.Enderecos, DAO.Enderecos, Controller.Enderecos;

type
  TCepBd = class
  private
    function StringsToEndereco(const aDados: TStrings): TEnderecosModel;
  public
    function GetBD: TJSONArray;
    function SetBD(const aDados: TStrings): Integer;
    function DelBD(const aId: integer): Boolean;
  end;

implementation

uses
  System.SysUtils;

{ TInserirCEP }

function TCepBd.DelBD(const aId: integer): Boolean;
var
  lEnderecosController: TEnderecosController;
begin
  lEnderecosController := TEnderecosController.Create;
  try
    Result := lEnderecosController.Excluir(aId);
  finally
    FreeAndNil(lEnderecosController);
  end;
end;

function TCepBd.GetBD: TJSONArray;
var
  lEnderecosController: TEnderecosController;
  lEndereco: TEnderecosModel;
  lObjeto: TJSONObject;
begin
  Result := TJSONArray.Create;
  lEnderecosController := TEnderecosController.Create;
  try
    for lEndereco in lEnderecosController.GeEnderecosTodos do
    begin
      lObjeto := TJSONObject.Create;
      lObjeto.AddPair('ID', lEndereco.Id.ToString);
      lObjeto.AddPair('CEP', lEndereco.CEP);
      lObjeto.AddPair('UF', lEndereco.UF);
      lObjeto.AddPair('CIDADE', lEndereco.Cidade);
      lObjeto.AddPair('BAIRRO', lEndereco.Bairro);
      lObjeto.AddPair('LOGRADOURO', lEndereco.Logradouro);
      Result.AddElement(lObjeto);
    end;
  finally
    FreeAndNil(lEnderecosController);
  end;
end;

function TCepBd.SetBD(const aDados: TStrings): Integer;
var
  lEnderecosController: TEnderecosController;
begin
  lEnderecosController := TEnderecosController.Create;
  try
    if (StrToIntDef(aDados[0], 0) > 0) then
      Result := lEnderecosController.Atualizar(StringsToEndereco(aDados))
    else
      Result := lEnderecosController.Inserir(StringsToEndereco(aDados));
  finally
    FreeAndNil(lEnderecosController);
  end;
end;

function TCepBd.StringsToEndereco(const aDados: TStrings): TEnderecosModel;
begin
  Result := TEnderecosModel.Create;

  Result.Id         := StrToIntDef(Copy(aDados[0], Pos('=', aDados[0]) + 1, Length(aDados[0])), 0);
  Result.CEP        := Copy(aDados[1], Pos('=', aDados[1]) + 1, Length(aDados[1]));
  Result.UF         := Copy(aDados[2], Pos('=', aDados[2]) + 1, Length(aDados[2]));
  Result.Cidade     := Copy(aDados[3], Pos('=', aDados[3]) + 1, Length(aDados[3]));
  Result.Bairro     := Copy(aDados[4], Pos('=', aDados[4]) + 1, Length(aDados[4]));
  Result.Logradouro := Copy(aDados[5], Pos('=', aDados[5]) + 1, Length(aDados[5]));
end;

end.
