unit uTrataExcecaoPai;

interface

uses
  System.SysUtils, System.Classes;

type

  TTratarExcecaoPai = class
  private
    FLogFile : String;
    procedure GravarLog(const aMsg : String);
  public
    constructor Create(const aLog: Boolean); virtual;
    procedure TratarErro(Sender : TObject; E : Exception); virtual;
  end;

implementation

uses
  Vcl.Forms, uFuncoes;

{ TTratarExcecaoPai }

constructor TTratarExcecaoPai.Create(const aLog: Boolean);
begin
  Application.onException := TratarErro;
  if aLog then
    FLogFile := ChangeFileExt(ExtractFilePath(Application.ExeName) + 'Erro', '.log');
end;

procedure TTratarExcecaoPai.GravarLog(const aMsg : String);
var
  lLog : TextFile;
begin
  AssignFile(lLog, FLogFile);
  if FileExists(FLogFile) then
      Append(lLog)
  else
      Rewrite(lLog);
  Writeln(lLog, FormatDateTime('dd/mm/YY hh:mm:ss - ', Now) + aMsg);
  CloseFile(lLog);
end;

procedure TTratarExcecaoPai.TratarErro(Sender: TObject; E: Exception);
begin
  if (Trim(FLogFile) = EmptyStr) then
    Msg(E.Message)
  else
    GravarLog(E.Message);
end;

end.
