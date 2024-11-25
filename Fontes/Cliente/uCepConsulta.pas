unit uCepConsulta;

interface

uses
  uCepPaiConsulta, uTypes;

type

  TCepConsulta = class(TCepPaiConsulta)
  public
    function Consultar(const aPath: string; const aPorta: integer; const aCEP: string): TEndereco; override;
  end;

implementation

uses
  uFuncoes;

function TCepConsulta.Consultar(const aPath: string; const aPorta: integer; const aCEP: string): TEndereco;
begin
  Result := inherited Consultar(aPath, aPorta, GetValidarCEP(aCEP));
end;

end.
