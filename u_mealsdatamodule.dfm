object mealsdatamodule: Tmealsdatamodule
  OldCreateOrder = False
  Height = 336
  Width = 346
  object dsrtblevents: TDataSource
    DataSet = tblevents
    Left = 240
    Top = 48
  end
  object dsrtblvehicles: TDataSource
    DataSet = tblvehicles
    Left = 240
    Top = 144
  end
  object ADOConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=dbsouptruck.mdb;Per' +
      'sist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 152
  end
  object tblvehicles: TADOTable
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    TableDirect = True
    TableName = 'tblvehicles'
    Left = 128
    Top = 144
  end
  object tblevents: TADOTable
    Active = True
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'tblevents'
    Left = 128
    Top = 40
  end
  object QRYmeals: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 144
    Top = 240
  end
  object dsrmeals: TDataSource
    DataSet = QRYmeals
    Left = 240
    Top = 248
  end
end
