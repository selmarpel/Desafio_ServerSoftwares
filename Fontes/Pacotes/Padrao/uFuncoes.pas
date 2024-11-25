unit uFuncoes;

interface

uses
  System.SysUtils, Vcl.Forms;

  function StrInteiro_2(pCaracter: Char; pListaChar: TSysCharSet): Char;
  function StrInteiro(pCaracter: Char): Char; overload;
  function StrInteiro(Campo: string): string; overload;
  Function GetValidarCEP(const pCEP: string): string;
  function Msg(const aText, aCaption: string; aFlags: Longint): Integer; overload;
  function Msg(const aText: string): Integer; overload;

implementation

uses
  Winapi.Windows;

function StrInteiro_2(pCaracter: Char; pListaChar: TSysCharSet): Char;
begin
  Result := #0;
  if CharInSet(pCaracter, pListaChar) then
    Result := pCaracter;
end;

function StrInteiro(pCaracter: Char): Char;
begin
  Result := StrInteiro_2(pCaracter, ['0'..'9', #8]);
end;

function StrInteiro(Campo: string): string; overload;
var
  I: Integer;
begin
  Result := EmptyStr;
  for I := 1 to Length(Campo) do
    if CharInSet(Campo[I], ['0'..'9',#8]) then
      Result := Result + StrInteiro(Campo[I]);
end;

Function GetValidarCEP(const pCEP: string): string;
var
  i: integer;
begin
  Result := EmptyStr;
  for i := 1 to Length(pCEP) do
    if CharInSet(pCEP[i],['0'..'9']) then
      Result := Result + pCEP[i];

  if not (Length(Result) = 8) then
  begin
    Msg('CEP inválido.') ;
    Abort;
  end;
end;

function Msg(const aText, aCaption: string; aFlags: Longint): Integer;
begin
  Result  := Application.MessageBox(Pchar(aText), Pchar(aCaption), aFlags);
end;

function Msg(const aText: string): Integer;
begin
  Result := Msg(aText,'Informação', MB_OK + MB_ICONINFORMATION);
end;

end.
