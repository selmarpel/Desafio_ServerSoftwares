unit uRestCliente;

interface

uses
  System.Generics.Collections, System.JSON, REST.Types, REST.Client, System.Classes,
  REST.Authenticator.Basic, uIRestCliente;

type

  TParametros = class
    Campo: string;
    Valor: string;
  end;

  TRestCliente = class(TInterfacedObject, IRestCliente)
  private
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FRESTResponse: TRESTResponse;
    FHTTPBasicAuthenticator: THTTPBasicAuthenticator;
    function GetRESTClient: TRESTClient;
    function GetRESTRequest: TRESTRequest;
    function GetRESTResponse: TRESTResponse;
    procedure TratarMsgErroServidor(const aValor: WideString);
  protected
    function Executar(const aURL: string; const aPorta: integer; var aLista: TObjectList<TParametros>; const aVerbo: TRESTRequestMethod): TJSONValue; overload; virtual;
    function Executar(const aURL: string; const aPorta: integer; const aVerbo: TRESTRequestMethod): TJSONValue; overload; virtual;
    function Executar(const aURL: string): TJSONValue; overload; virtual;

    property RESTClient: TRESTClient read GetRESTClient;
    property RESTRequest: TRESTRequest read GetRESTRequest;
    property RESTResponse: TRESTResponse read GetRESTResponse;
  public
    constructor Create(const aTempoEspera: integer = 5000); virtual;
    destructor Destroy; override;
  end;

implementation

uses
  System.Net.HttpClient, System.SysUtils, uTrataErroComunicacao;

{ TRestCliente }

constructor TRestCliente.Create(const aTempoEspera: integer);
begin
  FRESTClient   := TRESTClient.Create(nil);
  FRESTRequest  := TRESTRequest.Create(nil);
  FRESTResponse := TRESTResponse.Create(nil);
  FHTTPBasicAuthenticator:= THTTPBasicAuthenticator.Create(nil);

  with RESTClient do
  begin
    SynchronizedEvents := False;
    SecureProtocols := [THTTPSecureProtocol.SSL2,
                        THTTPSecureProtocol.SSL3,
                        THTTPSecureProtocol.TLS1,
                        THTTPSecureProtocol.TLS11,
                        THTTPSecureProtocol.TLS12,
                        THTTPSecureProtocol.TLS13];
    FallbackCharsetEncoding := 'UTF-8';
    ContentType := 'application/json';
    ReadTimeout := aTempoEspera;
    Authenticator := nil;
  end;

  with RESTRequest do
  begin
    Client             := FRESTClient;
    Response           := FRESTResponse;
    SynchronizedEvents := False;
  end;
end;

destructor TRestCliente.Destroy;
begin
  FRESTResponse.Free;
  FRESTRequest.Free;
  FRESTClient.Free;
  inherited;
end;

function TRestCliente.Executar(const aURL: string): TJSONValue;
var
  lLista: TObjectList<TParametros>;
begin
  Result:= Executar(aURL, 0,  lLista, rmGET);
end;

function TRestCliente.Executar(const aURL: string; const aPorta: integer; const aVerbo: TRESTRequestMethod): TJSONValue;
var
  lLista: TObjectList<TParametros>;
begin
  Result:= Executar(aURL, 0,  lLista, rmGET);
end;

function TRestCliente.Executar(const aURL: string; const aPorta: integer; var aLista: TObjectList<TParametros>; const aVerbo: TRESTRequestMethod): TJSONValue;
var
  lParametro: TParametros;
begin
  with RESTClient do
  begin
    BaseURL := aURL;
    if (aPorta > 0) then
      BaseURL := BaseURL + ':' + IntToStr(aPorta);

    if Assigned(aLista) then
    begin
      for lParametro in aLista do
        RESTClient.Params.AddItem(lParametro.Campo, lParametro.Valor, pkGETorPOST);
    end;
  end;

  RESTRequest.Method := aVerbo;

  RESTRequest.Execute;

  if not (RESTResponse.StatusCode = 200) then
    TTrataErroCom.TipoErro(RESTResponse.StatusCode);

  TratarMsgErroServidor(RESTResponse.JSONValue.ToString);

  Result := RESTResponse.JSONValue;
end;

function TRestCliente.GetRESTClient: TRESTClient;
begin
  Result := FRESTClient;
end;

function TRestCliente.GetRESTRequest: TRESTRequest;
begin
  Result := FRESTRequest;
end;

function TRestCliente.GetRESTResponse: TRESTResponse;
begin
  Result := FRESTResponse;
end;

procedure TRestCliente.TratarMsgErroServidor(const aValor: WideString);
var
  lJSObj: TJSONObject;
  lMsg: string;
begin
  if TJSONObject.ParseJSONValue(aValor).ClassType = TJSONObject then
  begin
    lJSObj := TJSONObject.ParseJSONValue(aValor) as TJSONObject;
    try
      if Assigned(lJSObj.Get('MSG')) then
      begin
        lMsg := TJSONValue(lJSObj.Get('MSG').JsonValue).Value;

        if not (Trim(lMsg) = EmptyStr) then
          Raise Exception.Create(lMsg);
      end;

    finally
      lJSObj.Free;
  end;
  end;
end;

end.