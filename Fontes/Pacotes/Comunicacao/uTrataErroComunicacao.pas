unit uTrataErroComunicacao;

interface

uses
  System.SysUtils;

type
  TTrataErroCom = class
  private
    class function GetMsgErro(const aCodErro: integer): string;
  public
    class procedure TipoErro(const aCodErro: integer);
  end;

implementation

{ TTrataErroCom }

class function TTrataErroCom.GetMsgErro(const aCodErro: integer): string;
begin
  case aCodErro of
    400: Result := 'Solicitação inválida.';
    401: Result := 'Acesso negado.';
    403: Result := 'Proibido.';
    404: Result := 'Não encontrado.';
    405: Result := 'Método não permitido.';
    406: Result := 'Não aceitável.';
    408: Result := 'Tempo limite da solicitação.';
    409: Result := 'Conflito.';
    412: Result := 'Falha na pré-condição.';
    429: Result := 'solicitações em excesso.';
    500: Result := 'Erro interno do servidor.';
    501: Result := 'Não implementado.';
    502: Result := 'Gateway ruim.';
    503: Result := 'serviço não disponível.';
    504: Result := 'Tempo limite do gateway.';
    else Result := 'Erro retornado.';
  end;
  Result := IntToStr(aCodErro) + ' - ' + Result;
end;

class procedure TTrataErroCom.TipoErro(const aCodErro: integer);
begin
  raise Exception.Create(GetMsgErro(aCodErro));
end;

end.
