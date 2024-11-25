unit uTratarExcecao;

interface

uses
  System.SysUtils, uTrataExcecaoPai;

type

  TTratarExcecao = class(TTratarExcecaoPai)
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  Vcl.Forms;

{ TTratarExcecao }

constructor TTratarExcecao.Create;
begin
  inherited Create(False);
end;

var
  FTratarExcecao : TTratarExcecaoPai;

initialization;
  FTratarExcecao := TTratarExcecao.Create;

finalization;
  FTratarExcecao.Free;

end.
