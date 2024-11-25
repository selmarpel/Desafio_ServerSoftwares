unit uWebDM;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Model.Enderecos;

type
  TWebDM = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    function ConsultarGeralTipos(const aDados: string):string;
    function ConsultarCeps:string;
    function ConsultarCep(const aCEP: string):string;

    function SalvarBdGeralTipos(const aDados: TStrings):string;
    function SalvarBdCep(const aCEP: TStrings): string;

    function RemoverBdGeralTipos(const aDados: string):string;
    function RemoverBdCep(const aId: string): Boolean;
  public
    { Public declarations }
  end;

var
  WebDM: TComponentClass = TWebDM;

implementation

uses
  System.StrUtils, uConst, uCepConsultar, uCepBd;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TWebDM.ConsultarCep(const aCEP: string): string;
begin
  with TCepConsultar.Create(3000) do
  begin
    try
      Result := GetServidor(aCEP);
    finally
      Free;
    end;
  end;
end;

function TWebDM.ConsultarCeps: string;
begin
  with TCepBd.Create do
  begin
    try
      Result := GetBD.ToString;
    finally
      Free;
    end;
  end;
end;

function TWebDM.ConsultarGeralTipos(const aDados: string):string;
begin
  if (UpperCase(Copy(Request.PathTranslated, 1, 8)) = cGetCeps) then
    Result := ConsultarCeps
  else if (UpperCase(Copy(Request.PathTranslated, 1, 7)) = cGetCep) then
    Result := ConsultarCep(aDados)
  else
    Result := '{"MSG":"Comando desconhecido."}';
end;

function TWebDM.RemoverBdCep(const aId: string): Boolean;
var
  lId: string;
begin
  lId := Copy(aId, 4, 20);
  with TCepBd.Create do
  begin
    try
      Result := DelBD(StrToIntDef(lId, 0));
    finally
      Free;
    end;
  end;
end;

function TWebDM.RemoverBdGeralTipos(const aDados: string): string;
begin
  if (UpperCase(Copy(Request.PathTranslated, 1, 7)) = cDeleteCep) then
    Result := IfThen(RemoverBdCep(aDados), 'Excluido com Sucesso.', 'Nao foi possivel Excluir.')
  else
    Result := 'Comando desconhecido.';
  Result := '{"MSG":"' + Result + '"}';
end;

function TWebDM.SalvarBdCep(const aCEP: TStrings): string;
begin
  with TCepBd.Create do
  begin
    try
      Result := IntToStr(SetBD(aCEP));
    finally
      Free;
    end;
  end;
end;

function TWebDM.SalvarBdGeralTipos(const aDados: TStrings): string;
begin
  if (UpperCase(Copy(Request.PathTranslated, 1, 8)) = cPostCep) then
    Result := SalvarBdCep(aDados)
  else if (UpperCase(Copy(Request.PathTranslated, 1, 7)) = cPutCep) then
    Result := SalvarBdCep(aDados)
  else
    Result := '0';
end;

procedure TWebDM.WebModule1DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.ContentType := 'application/json';
  Response.ContentEncoding := 'UTF-8';

  if (Request.ContentFields.Count = 0) then
    Response.Content := '{"MSG":"Parâmetro não informado."}'
  else
    case Request.MethodType of
      mtGet: Response.Content    :=  ConsultarGeralTipos(Request.ContentFields.strings[0]); // Buscar
      mtPut: Response.Content    := SalvarBdGeralTipos(Request.ContentFields); // Atualizar
      mtPost: Response.Content   := SalvarBdGeralTipos(Request.ContentFields); // criar
      mtDelete: Response.Content := RemoverBdGeralTipos(Request.ContentFields.strings[0]); // Remover
      else Response.Content      := '{"MSG":"Verbo desconhecido."}';
    end;

  {$WARNINGS OFF}
  Response.Content := UTF8Decode(Response.Content);
  {$WARNINGS ON}

end;

end.
