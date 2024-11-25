unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Graphics,
  System.Actions, Vcl.ActnList, Data.DB, Datasnap.DBClient,
  Vcl.Grids, Vcl.DBGrids, REST.Types, uFrmPadraoCliente, uTypes;

type
  TFrmPrincipal = class(TFrmPadraoCliente)
    LblCaminhoServ: TLabel;
    EdtCaminhoServ: TEdit;
    LblPortaServ: TLabel;
    EdtPorta: TEdit;
    DbgCEPs: TDBGrid;
    CdsEndereco: TClientDataSet;
    CdsEnderecoId: TIntegerField;
    CdsEnderecoCEP: TStringField;
    CdsEnderecoUF: TStringField;
    CdsEnderecoCidade: TStringField;
    CdsEnderecoBairro: TStringField;
    CdsEnderecoLogradouro: TStringField;
    DsEndereco: TDataSource;
    procedure acConsultarExecute(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure acSalvarExecute(Sender: TObject);
    procedure acCarregarExecute(Sender: TObject);
    procedure acExbluirExecute(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure aclTeclasUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    function GetEnderecoTela: TEndereco;
    procedure CarregarClient(const aEndereco: TEndereco);
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
 System.MaskUtils, uCepConsulta, uCepSalva, uFuncoes;

{$R *.dfm}

procedure TFrmPrincipal.acCarregarExecute(Sender: TObject);

  procedure GetArray(aEnderecos: TEnderecos);
  var
    I: integer;
  begin
    cdsEndereco.EmptyDataSet;
    for i := 0 to Length(aEnderecos) -1 do
    begin
      CarregarClient(aEnderecos[i]);
      aEnderecos[i].Id         := 0;
      aEnderecos[i].CEP        := EmptyStr;
      aEnderecos[i].UF         := EmptyStr;
      aEnderecos[i].Cidade     := EmptyStr;
      aEnderecos[i].Bairro     := EmptyStr;
      aEnderecos[i].Logradouro := EmptyStr;
    end;
    SetLength(aEnderecos, 0);
  end;

begin
  acCarregar.Enabled:= False;
  try
    inherited;
    with TCepConsulta.Create do
    begin
      try
        GetArray(Consultar(EdtCaminhoServ.Text, StrToIntDef(EdtPorta.Text, 80)));
      finally
        Free;
      end;
    end;
  finally
    acCarregar.Enabled:= True;
  end;
end;

procedure TFrmPrincipal.acConsultarExecute(Sender: TObject);
var
  lCEP: Boolean;
begin
  acConsultar.Enabled:= False;
  try
    With CdsEndereco do
    begin
      Filtered := False;
      Filter   := 'CEP = ' + FormatMaskText('00000-0000;0;', StrInteiro(edtCodigo.Text));
      Filtered := True;
      lCEP := (CdsEndereco.RecordCount > 0);
      Filtered := False;
    end;

    if lCEP then
    begin
      Msg('Não será possível Incluir! ' + #13 +'CEP: ' + FormatMaskText('00000-0000;0;', StrInteiro(edtCodigo.Text)) + ' já existe.');
      Exit;
    end;

    inherited;

    with TCepConsulta.Create do
    begin
      try
        CarregarClient(Consultar(EdtCaminhoServ.Text, StrToIntDef(EdtPorta.Text, 80), edtCodigo.Text));
      finally
        Free;
      end;
    end;
  finally
    acConsultar.Enabled:= True;
    edtCodigo.Text := EmptyStr;
    if edtCodigo.CanFocus then
      edtCodigo.SetFocus;
  end;
end;

procedure TFrmPrincipal.acExbluirExecute(Sender: TObject);
var
  lMsg: string;
begin
  acExbluir.Enabled:= False;
  try
    if not (Msg('Tem certeza que deseja excluir o CEP: ' + CdsEndereco.FieldByName('CEP').AsString + '?', 'Excluir', MB_ICONQUESTION + MB_YESNO) = mrYes) then
      exit;

    if not (CdsEndereco.FieldByName('Id').AsInteger > 0) then
    begin
      CdsEndereco.Delete;
      exit;
    end;

    inherited;
    with TCepSalva.Create do
    begin
      try
        lMsg := EnviarExcluir(EdtCaminhoServ.Text, StrToIntDef(EdtPorta.Text, 80), CdsEndereco.FieldByName('Id').AsInteger);
      finally
        Free;
      end;
    end;

    if Not (Trim(Copy(lMsg, 1, 1)) = 'N') then
      CdsEndereco.Delete;

    Msg(lMsg);
  finally
    acExbluir.Enabled:= True;
  end;
end;

procedure TFrmPrincipal.aclTeclasUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  acSalvar.Enabled := (CdsEndereco.RecordCount > 0) and (not (CdsEndereco.State in [dsEdit, dsInsert]));
  acExbluir.Enabled := (CdsEndereco.RecordCount > 0) and (not (CdsEndereco.State in [dsEdit, dsInsert]));
end;

procedure TFrmPrincipal.acSalvarExecute(Sender: TObject);
var
  lId: integer;
begin
  acSalvar.Enabled:= False;
  try
    inherited;
    with TCepSalva.Create do
    begin
      try
        lId := EnviarSalvar(EdtCaminhoServ.Text, StrToIntDef(EdtPorta.Text, 80), GetEnderecoTela);
        with CdsEndereco do
        begin
          Edit;
          FieldByName('Id').AsInteger:= lId;
          Post;
        end;
        if (lId > 0) then
          Msg('Operação efetuada com sucesso.')
        else
          Msg('Não foi possível.');
      finally
        Free;
      end;
    end;
  finally
    acSalvar.Enabled:= True;
  end;
end;

procedure TFrmPrincipal.CarregarClient(const aEndereco: TEndereco);
begin
  with cdsEndereco do
  begin
    Append;

    if (aEndereco.Id > 0) then
      FieldByName('Id').AsInteger := aEndereco.Id;

    FieldByName('CEP').AsString        := FormatMaskText('00000-0000;0;', StrInteiro(aEndereco.CEP));
    FieldByName('UF').AsString         := String(aEndereco.UF);
    FieldByName('Cidade').AsString     := aEndereco.Cidade;
    FieldByName('Bairro').AsString     := aEndereco.Bairro;
    FieldByName('Logradouro').AsString := aEndereco.Logradouro;
    Post;
  end;
end;

procedure TFrmPrincipal.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Text := StrInteiro(TEdit(Sender).Text);
  TEdit(Sender).MaxLength := 8;
end;

procedure TFrmPrincipal.edtCodigoExit(Sender: TObject);
begin
  inherited;
  TEdit(Sender).MaxLength := 9;
  TEdit(Sender).Text := FormatMaskText('00000-0000;0;', StrInteiro(TEdit(Sender).Text));
end;

procedure TFrmPrincipal.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  Key := StrInteiro(Key);
  inherited;
end;

function TFrmPrincipal.GetEnderecoTela: TEndereco;
begin
  with cdsEndereco do
  begin
    Result.Id         := FieldByName('Id').AsInteger;
    Result.CEP        := FieldByName('CEP').AsString;
    Result.UF         := FieldByName('UF').AsString;
    Result.Cidade     := FieldByName('Cidade').AsString;
    Result.Bairro     := FieldByName('Bairro').AsString;
    Result.Logradouro := FieldByName('Logradouro').AsString;
  end;
end;

end.
