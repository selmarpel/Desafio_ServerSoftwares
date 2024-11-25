unit uFrmPadraoCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  System.Actions, Vcl.ActnList;

type
  TFrmPadraoCliente = class(TForm)
    pnlCabecalho: TPanel;
    pnlCorpo: TPanel;
    btnConsultar: TButton;
    lblCEP: TLabel;
    edtCodigo: TEdit;
    pnlBotao: TPanel;
    BtnCarregar: TButton;
    BtnSalvar: TButton;
    aclTeclas: TActionList;
    acConsultar: TAction;
    acSair: TAction;
    acSalvar: TAction;
    BtmExcluir: TButton;
    btnSair: TButton;
    acExbluir: TAction;
    acCarregar: TAction;
    procedure acConsultarExecute(Sender: TObject);
    procedure acSalvarExecute(Sender: TObject);
    procedure acSairExecute(Sender: TObject);
    procedure acCarregarExecute(Sender: TObject);
    procedure acExbluirExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrmPadraoCliente.acCarregarExecute(Sender: TObject);
begin
//
end;

procedure TFrmPadraoCliente.acConsultarExecute(Sender: TObject);
begin
//
end;

procedure TFrmPadraoCliente.acExbluirExecute(Sender: TObject);
begin
//
end;

procedure TFrmPadraoCliente.acSairExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmPadraoCliente.acSalvarExecute(Sender: TObject);
begin
//
end;

end.
