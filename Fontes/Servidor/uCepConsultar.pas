unit uCepConsultar;

interface

uses
  uRestCliente, JSON;

type
  TCepConsultar = class(TRestCliente)
  public
    function GetServidor(const aCEP: string): String;
  end;

implementation

uses
  System.SysUtils, REST.Types;

const
  cURL_CONSULTAR_CEP = 'https://brasilapi.com.br/api/cep/v1/%s';

{ TConsultarCEP }

function TCepConsultar.GetServidor(const aCEP: string): String;
begin
  try
    Result := Executar(Format(cURL_CONSULTAR_CEP, [aCEP])).ToString;
  Except
    on E: Exception do
      Result := '{"MSG":"' + e.Message + '"}';
  end;
end;

end.
