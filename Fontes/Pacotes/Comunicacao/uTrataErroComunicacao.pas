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
    400: Result := 'Solicita��o inv�lida.';
    401: Result := 'Acesso negado.';
    403: Result := 'Proibido.';
    404: Result := 'N�o encontrado.';
    405: Result := 'M�todo n�o permitido.';
    406: Result := 'N�o aceit�vel.';
    408: Result := 'Tempo limite da solicita��o.';
    409: Result := 'Conflito.';
    412: Result := 'Falha na pr�-condi��o.';
    429: Result := 'solicita��es em excesso.';
    500: Result := 'Erro interno do servidor.';
    501: Result := 'N�o implementado.';
    502: Result := 'Gateway ruim.';
    503: Result := 'servi�o n�o dispon�vel.';
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
