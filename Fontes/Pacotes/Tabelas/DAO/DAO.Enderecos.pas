unit DAO.Enderecos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, System.Generics.Collections,
  Datasnap.DBClient, Model.Enderecos;

type
  TEnderecosDAO = class(TDataModule)
  private
    FCdsEndereco: TClientDataSet;
    function ToEnderecoModel(pClient: TDataset): TEnderecosModel;
    procedure SetValues(const pEnderecos: TEnderecosModel);
    procedure CriaDataSet;
    procedure SetFiltro(const aFiltro: string);
    procedure SalvarArquivo;
    procedure LerArquivo;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    function Inserir(const pEndereco: TEnderecosModel): Integer;
    function Atualizar(const pEndereco: TEnderecosModel): integer;
    function Excluir(const pIdEndereco: Integer): Boolean;
    function GeEndereco(const pIdEndereco: Integer): TEnderecosModel;
    function GeEnderecosTodos: TObjectList<TEnderecosModel>;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  Vcl.Forms;

const
  cArqBD: string = 'BD.xml';  // arquivo que armazena os dados

{ TEnderecosDAO }

constructor TEnderecosDAO.Create;
begin
  inherited Create(nil);
  CriaDataSet;
end;

destructor TEnderecosDAO.Destroy;
begin
  FCdsEndereco.EmptyDataSet;
  FreeAndNil(FCdsEndereco);
  inherited;
end;

procedure TEnderecosDAO.CriaDataSet;
  procedure CriaCampoString(const aNome: string; const aTamanho: integer);
  begin
    with TStringField.Create(nil) do
    begin
      FieldName := aNome;
      Size      := aTamanho;
      DataSet   := FCdsEndereco;
    end;
  end;
begin
  FCdsEndereco := TClientDataSet.Create(nil);

  with TUnsignedAutoIncField.Create(nil) do
  begin
    FieldName := 'ID';
    DataSet   := FCdsEndereco;
  end;
  CriaCampoString('CEP', 10);
  CriaCampoString('UF', 2);
  CriaCampoString('CIDADE', 20);
  CriaCampoString('BAIRRO', 20);
  CriaCampoString('LOGRADOURO', 50);

  FCdsEndereco.CreateDataSet;
  LerArquivo;
end;

procedure TEnderecosDAO.SalvarArquivo;
begin
  FCdsEndereco.SaveToFile(ExtractFilePath(Application.ExeName) + cArqBD, dfXML);
end;

procedure TEnderecosDAO.LerArquivo;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + cArqBD) then
    FCdsEndereco.LoadFromFile(ExtractFilePath(Application.ExeName) + cArqBD);
  FCdsEndereco.LogChanges := False;
end;

procedure TEnderecosDAO.SetFiltro(const aFiltro: string);
begin
  With FCdsEndereco do
  begin
    Filtered := False;
    Filter   := aFiltro;
    if not (aFiltro = EmptyStr) then
      Filtered := True;
  end;
end;

procedure TEnderecosDAO.SetValues(const pEnderecos: TEnderecosModel);
begin
  With FCdsEndereco, pEnderecos do
  begin
    FieldByName('CEP').AsString        := CEP;
    FieldByName('UF').AsString         := UF;
    FieldByName('CIDADE').AsString     := Cidade;
    FieldByName('BAIRRO').AsString     := Bairro;
    FieldByName('LOGRADOURO').AsString := Logradouro;
  end;
end;

function TEnderecosDAO.ToEnderecoModel(pClient: TDataset): TEnderecosModel;
begin
  Result := TEnderecosModel.Create;
  if pClient.RecordCount > 0 then
  begin
    With pClient do
    begin
      Result.Id         := FieldByName('ID').AsInteger;
      Result.CEP        := FieldByName('CEP').AsString;
      Result.UF         := FieldByName('UF').AsString;
      Result.Cidade     := FieldByName('CIDADE').AsString;
      Result.Bairro     := FieldByName('BAIRRO').AsString;
      Result.Logradouro := FieldByName('LOGRADOURO').AsString;
    end;
  end;
end;

function TEnderecosDAO.Inserir(const pEndereco: TEnderecosModel): integer;
begin
  SetFiltro('CEP = ' + QuotedStr(pEndereco.CEP));
  With FCdsEndereco, pEndereco do
  begin
    if (RecordCount = 0) then
      Append
    else
      Edit;
    SetValues(pEndereco);
    Post;
    Result := FieldByName('ID').AsInteger;
    SalvarArquivo;
  end;
  SetFiltro(EmptyStr);
end;

function TEnderecosDAO.Atualizar(const pEndereco: TEnderecosModel): integer;
begin
  Result := Inserir(pEndereco);
end;

function TEnderecosDAO.Excluir(const pIdEndereco: Integer): Boolean;
begin
  With FCdsEndereco do
  begin
    if Locate('ID', IntToStr(pIdEndereco), [loPartialKey]) then
    begin
      Delete;
      SalvarArquivo;
      Result := True;
    end
    else
      Result := False;
  end;
  SetFiltro(EmptyStr);
end;

function TEnderecosDAO.GeEndereco(const pIdEndereco: Integer): TEnderecosModel;
begin
  SetFiltro('ID = ' + IntToStr(pIdEndereco));
  Result := ToEnderecoModel(FCdsEndereco);
  SetFiltro(EmptyStr);
end;

function TEnderecosDAO.GeEnderecosTodos: TObjectList<TEnderecosModel>;
begin
  Result := TObjectList<TEnderecosModel>.Create(false);
  SetFiltro(EmptyStr);
  while not FCdsEndereco.Eof do
  begin
    Result.Add(ToEnderecoModel(FCdsEndereco));
    FCdsEndereco.Next;
  end;
end;

end.
