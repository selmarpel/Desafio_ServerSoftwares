object FrmPadraoCliente: TFrmPadraoCliente
  Left = 0
  Top = 0
  Caption = 'FrmPadraoCliente'
  ClientHeight = 436
  ClientWidth = 663
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 23
  object pnlCabecalho: TPanel
    Left = 0
    Top = 0
    Width = 663
    Height = 73
    Align = alTop
    BevelInner = bvLowered
    BorderStyle = bsSingle
    TabOrder = 0
    object lblCEP: TLabel
      Left = 12
      Top = 27
      Width = 64
      Height = 23
      Caption = 'Informe:'
    end
    object btnConsultar: TButton
      Left = 263
      Top = 19
      Width = 123
      Height = 31
      Action = acConsultar
      TabOrder = 1
    end
    object edtCodigo: TEdit
      Left = 96
      Top = 19
      Width = 121
      Height = 31
      TabOrder = 0
    end
  end
  object pnlCorpo: TPanel
    Left = 0
    Top = 73
    Width = 663
    Height = 290
    Align = alClient
    BevelInner = bvLowered
    BorderStyle = bsSingle
    TabOrder = 1
  end
  object pnlBotao: TPanel
    Left = 0
    Top = 363
    Width = 663
    Height = 73
    Align = alBottom
    BevelInner = bvLowered
    BorderStyle = bsSingle
    TabOrder = 2
    DesignSize = (
      659
      69)
    object BtnCarregar: TButton
      Left = 15
      Top = 15
      Width = 150
      Height = 40
      Action = acCarregar
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
    object BtnSalvar: TButton
      Left = 175
      Top = 15
      Width = 150
      Height = 40
      Action = acSalvar
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object BtmExcluir: TButton
      Left = 335
      Top = 15
      Width = 150
      Height = 40
      Action = acExbluir
      Anchors = [akTop, akRight]
      TabOrder = 2
    end
    object btnSair: TButton
      Left = 494
      Top = 15
      Width = 150
      Height = 40
      Action = acSair
      Anchors = [akTop, akRight]
      TabOrder = 3
    end
  end
  object aclTeclas: TActionList
    Left = 416
    Top = 24
    object acConsultar: TAction
      Caption = 'Consultar (F9)'
      Hint = 'Consultar (F9)'
      ShortCut = 120
      OnExecute = acConsultarExecute
    end
    object acSair: TAction
      Caption = 'Sair (Esc)'
      Hint = 'Sair (Esc)'
      ShortCut = 27
      OnExecute = acSairExecute
    end
    object acSalvar: TAction
      Caption = 'Salvar (F4)'
      Hint = 'Salvar (F4)'
      ShortCut = 115
      OnExecute = acSalvarExecute
    end
    object acExbluir: TAction
      Caption = 'Excluir (Del)'
      Hint = 'Excluir (Del)'
      ShortCut = 46
      OnExecute = acExbluirExecute
    end
    object acCarregar: TAction
      Caption = 'Carregar (F3)'
      Hint = 'Carregar (F3)'
      ShortCut = 114
      OnExecute = acCarregarExecute
    end
  end
end
