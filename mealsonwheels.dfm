object Form1: TForm1
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Form1'
  ClientHeight = 720
  ClientWidth = 1280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pcmain: TPageControl
    Left = 0
    Top = 0
    Width = 1280
    Height = 720
    ActivePage = tsadmin
    TabOrder = 0
    object tshome: TTabSheet
      Caption = 'tshome'
    end
    object tsevents: TTabSheet
      Caption = 'tsevents'
      ImageIndex = 1
    end
    object tsregister: TTabSheet
      Caption = 'tsregister'
      ImageIndex = 2
    end
    object tshelp: TTabSheet
      Caption = 'tshelp'
      ImageIndex = 3
      ExplicitLeft = 100
      ExplicitTop = 56
    end
    object tsleader: TTabSheet
      Caption = 'tsleader'
      ImageIndex = 4
    end
    object tsadmin: TTabSheet
      Caption = 'tsadmin'
      ImageIndex = 5
      object pnlloginadmin: TPanel
        Left = 3
        Top = 3
        Width = 222
        Height = 158
        Color = clMenu
        ParentBackground = False
        TabOrder = 0
        object edtusernameadmin: TEdit
          Left = 10
          Top = 8
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'User Name'
        end
        object edtpasswordadmin: TEdit
          Left = 10
          Top = 35
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'Password'
        end
        object btnloginadmin: TButton
          Left = 137
          Top = 8
          Width = 75
          Height = 21
          Caption = 'Login'
          TabOrder = 2
        end
        object btnlogoutadmin: TButton
          Left = 137
          Top = 35
          Width = 75
          Height = 21
          Caption = 'Logout'
          TabOrder = 3
        end
        object redstatusadmin: TRichEdit
          Left = 10
          Top = 62
          Width = 202
          Height = 89
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Lines.Strings = (
            'Sesion Status:'
            'Logged Out...'
            '')
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
      end
    end
  end
end
