object DM: TDM
  OldCreateOrder = False
  OnCreate = ServerMethodDataModuleCreate
  Encoding = esASCII
  Height = 267
  Width = 373
  object DWEvents: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'hora'
        OnReplyEvent = DWEventsEventshoraReplyEvent
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'login'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'senha'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'login'
        OnReplyEvent = DWEventsEventsloginReplyEvent
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'nomeusuario'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'email'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'telefone'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'tipousuario'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'senha'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'celular'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'incluirusuario'
        OnReplyEvent = DWEventsEventsincluirusuarioReplyEvent
      end>
    Left = 56
    Top = 40
  end
  object conn: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\WIN 8.1\Documents\sistemas\sistema-cardapio-di' +
        'gital-server\db\DBCARDAPIO.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = Transaction
    Left = 160
    Top = 48
  end
  object Transaction: TFDTransaction
    Connection = conn
    Left = 256
    Top = 56
  end
end
