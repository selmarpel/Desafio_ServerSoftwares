unit uCepConsultar;

interface

uses
  uRestCliente, JSON;

type
  TCepConsultar = class
  private
    FRestCliente: TRestCliente;
  public
    constructor Create(const aTempoEspera: integer); virtual;
    destructor Destroy; override;
    function GetServidor(const aCEP: string): String;
  end;

implementation

uses
  System.SysUtils, REST.Types;

const
  cURL_CONSULTAR_CEP = 'https://brasilapi.com.br/api/cep/v1/%s';

{ TConsultarCEP }

constructor TCepConsultar.Create(const aTempoEspera: integer);
begin
  FRestCliente:= TRestCliente.Create(aTempoEspera);
end;

destructor TCepConsultar.Destroy;
begin
  FreeAndNil(FRestCliente);
  inherited;
end;

function TCepConsultar.GetServidor(const aCEP: string): String;
begin
  try
    Result := FRestCliente.OnExecutarServidor(Format(cURL_CONSULTAR_CEP, [aCEP])).ToString;
  Except
    on E: Exception do
      Result := '{"MSG":"' + e.Message + '"}';
  end;
end;

end.
