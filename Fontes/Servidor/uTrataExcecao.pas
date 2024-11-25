unit uTrataExcecao;

interface

uses
  uTrataExcecaoPai;

type

  TTrataExcecao = class(TTratarExcecaoPai)
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  Vcl.Forms;

{ TTrataExcecao }

constructor TTrataExcecao.Create;
begin
  inherited Create(True);
end;

var
  FTratarExcecao : TTratarExcecaoPai;

initialization;
  FTratarExcecao := TTrataExcecao.Create;

finalization;
  FTratarExcecao.Free;

end.
