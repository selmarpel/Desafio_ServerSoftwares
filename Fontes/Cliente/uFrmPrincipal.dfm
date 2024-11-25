inherited FrmPrincipal: TFrmPrincipal
  Caption = 'Cliente'
  ClientHeight = 687
  ClientWidth = 1090
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 1106
  ExplicitHeight = 726
  TextHeight = 23
  inherited pnlCabecalho: TPanel
    Width = 1090
    Height = 97
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 1090
    ExplicitHeight = 97
    inherited lblCEP: TLabel
      Left = 38
      Top = 60
      Width = 114
      Caption = 'Informe o CEP:'
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 38
      ExplicitTop = 60
      ExplicitWidth = 114
    end
    object LblCaminhoServ: TLabel [1]
      Left = 12
      Top = 19
      Width = 140
      Height = 23
      Caption = 'Caminho Servidor:'
    end
    object LblPortaServ: TLabel [2]
      Left = 574
      Top = 19
      Width = 111
      Height = 23
      Caption = 'Porta Servidor:'
    end
    inherited btnConsultar: TButton
      Left = 285
      Top = 52
      TabOrder = 3
      ExplicitLeft = 285
      ExplicitTop = 52
    end
    inherited edtCodigo: TEdit
      Left = 158
      Top = 52
      TabOrder = 2
      Text = '01153-000'
      StyleElements = [seFont, seClient, seBorder]
      OnEnter = edtCodigoEnter
      OnExit = edtCodigoExit
      OnKeyPress = edtCodigoKeyPress
      ExplicitLeft = 158
      ExplicitTop = 52
    end
    object EdtCaminhoServ: TEdit
      Left = 158
      Top = 11
      Width = 400
      Height = 31
      TabOrder = 0
      Text = 'http://localhost'
    end
    object EdtPorta: TEdit
      Left = 691
      Top = 11
      Width = 87
      Height = 31
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 1
      Text = '80'
    end
  end
  inherited pnlCorpo: TPanel
    Top = 97
    Width = 1090
    Height = 517
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 97
    ExplicitWidth = 1090
    ExplicitHeight = 517
    object DbgCEPs: TDBGrid
      Left = 2
      Top = 2
      Width = 1082
      Height = 509
      Align = alClient
      DataSource = DsEndereco
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -17
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  inherited pnlBotao: TPanel
    Top = 614
    Width = 1090
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 614
    ExplicitWidth = 1090
    DesignSize = (
      1086
      69)
    inherited BtnCarregar: TButton
      Left = 448
      ExplicitLeft = 448
    end
    inherited BtnSalvar: TButton
      Left = 604
      ExplicitLeft = 604
    end
    inherited BtmExcluir: TButton
      Left = 760
      ExplicitLeft = 760
    end
    inherited btnSair: TButton
      Left = 916
      ExplicitLeft = 916
    end
  end
  inherited aclTeclas: TActionList
    OnUpdate = aclTeclasUpdate
  end
  object CdsEndereco: TClientDataSet
    PersistDataPacket.Data = {
      A90000009619E0BD010000001800000006000000000003000000A90002496404
      00010000000000034345500100490000000100055749445448020002000A0002
      5546010049000000010005574944544802000200020006436964616465010049
      00000001000557494454480200020014000642616972726F0100490000000100
      0557494454480200020014000A4C6F677261646F75726F010049000000010005
      57494454480200020032000000}
    Active = True
    Aggregates = <>
    AutoCalcFields = False
    Params = <>
    Left = 384
    Top = 217
    object CdsEnderecoId: TIntegerField
      DisplayWidth = 10
      FieldName = 'Id'
    end
    object CdsEnderecoCEP: TStringField
      DisplayWidth = 10
      FieldName = 'CEP'
      Size = 10
    end
    object CdsEnderecoUF: TStringField
      DisplayWidth = 2
      FieldName = 'UF'
      Size = 2
    end
    object CdsEnderecoCidade: TStringField
      DisplayWidth = 20
      FieldName = 'Cidade'
    end
    object CdsEnderecoBairro: TStringField
      DisplayWidth = 20
      FieldName = 'Bairro'
    end
    object CdsEnderecoLogradouro: TStringField
      DisplayWidth = 50
      FieldName = 'Logradouro'
      Size = 50
    end
  end
  object DsEndereco: TDataSource
    AutoEdit = False
    DataSet = CdsEndereco
    Left = 496
    Top = 209
  end
end
