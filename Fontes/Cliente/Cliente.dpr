program Cliente;

uses
  Vcl.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  uCepConsulta in 'uCepConsulta.pas',
  uCepSalva in 'uCepSalva.pas',
  uTratarExcecao in 'uTratarExcecao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
