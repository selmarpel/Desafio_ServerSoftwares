unit Controller.Enderecos;

interface

uses
  System.Classes, System.Generics.Collections,
  DAO.Enderecos, Model.Enderecos;

type
  TEnderecosController = class
  private
    FEnderecosDao: TEnderecosDAO;
  public
    constructor Create;
    destructor Destroy; override;

    function Inserir(const pEndereco: TEnderecosModel): integer;
    function Atualizar(const pEndereco: TEnderecosModel): integer;
    function Excluir(const pIdEndereco: Integer): Boolean;
    function GeEndereco(const pIdEndereco: Integer): TEnderecosModel;
    function GeEnderecosTodos: TObjectList<TEnderecosModel>;
  end;

implementation

uses
  System.SysUtils;

{ TEnderecosController }

constructor TEnderecosController.Create;
begin
  FEnderecosDao := TEnderecosDAO.Create;
end;

destructor TEnderecosController.Destroy;
begin
  FreeAndNil(FEnderecosDao);
  inherited;
end;

function TEnderecosController.Excluir(const pIdEndereco: Integer): Boolean;
begin
  Result := FEnderecosDao.Excluir(pIdEndereco);
end;

function TEnderecosController.Inserir(const pEndereco: TEnderecosModel): integer;
begin
  Result := FEnderecosDao.Inserir(pEndereco);
end;

function TEnderecosController.Atualizar(const pEndereco: TEnderecosModel): integer;
begin
  Result := FEnderecosDao.Atualizar(pEndereco);
end;

function TEnderecosController.GeEndereco(const pIdEndereco: Integer): TEnderecosModel;
begin
  Result := FEnderecosDao.GeEndereco(pIdEndereco);
end;

function TEnderecosController.GeEnderecosTodos: TObjectList<TEnderecosModel>;
begin
  Result := FEnderecosDao.GeEnderecosTodos();
end;

end.
