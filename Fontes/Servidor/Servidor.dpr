program Servidor;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uFrmServidor in 'uFrmServidor.pas' {FrmServidor},
  uWebDM in 'uWebDM.pas' {WebDM: TWebModule},
  uCepConsultar in 'uCepConsultar.pas',
  uCepBd in 'uCepBd.pas',
  uTrataExcecao in 'uTrataExcecao.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebDM;
  Application.Initialize;
  Application.CreateForm(TFrmServidor, FrmServidor);
  Application.Run;
end.
