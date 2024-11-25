unit uServidor;

interface

uses
  uBuscaCEP;

type
  TServidor = class
  private
    FBuscaCEP: TBuscaCEP;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Executar;
end;

implementation

{ TServidor }

constructor TServidor.Create;
begin
 FBuscaCEP := TBuscaCEP.Create;
end;

destructor TServidor.Destroy;
begin
  FBuscaCEP.Free;
  inherited;
end;

procedure TServidor.Executar;
var
  lCode: integer;
begin
  FBuscaCEP.GetCEP('08040620', lCode);
end;

end.
