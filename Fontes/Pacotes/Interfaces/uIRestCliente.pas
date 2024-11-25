unit uIRestCliente;

interface

uses
  REST.Client;

type
  IRestCliente = interface['{B1DE5A84-41E8-4206-92FD-7EBCCC7018E5}']
    function GetRESTClient: TRESTClient;
    function GetRESTRequest: TRESTRequest;
    function GetRESTResponse: TRESTResponse;
    property RESTClient: TRESTClient read GetRESTClient;
    property RESTRequest: TRESTRequest read GetRESTRequest;
    property RESTResponse: TRESTResponse read GetRESTResponse;
  end;

implementation

end.
