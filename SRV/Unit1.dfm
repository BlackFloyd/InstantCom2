object Form1: TForm1
  Left = 465
  Top = 141
  Width = 851
  Height = 463
  Caption = 'ICom2 Server'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    843
    436)
  PixelsPerInch = 96
  TextHeight = 13
  object output: TMemo
    Left = 0
    Top = 0
    Width = 601
    Height = 377
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'output')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object input: TEdit
    Left = 0
    Top = 376
    Width = 601
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    OnKeyPress = inputKeyPress
  end
  object userlist: TListBox
    Left = 600
    Top = 0
    Width = 121
    Height = 369
    Anchors = [akTop, akRight, akBottom]
    ItemHeight = 13
    ScrollWidth = 1
    TabOrder = 2
    OnClick = userlistClick
  end
  object btn_kick: TButton
    Left = 720
    Top = 0
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Kick'
    TabOrder = 3
    OnClick = btn_kickClick
  end
  object btn_info: TButton
    Left = 720
    Top = 24
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Get Info'
    TabOrder = 4
    OnClick = btn_infoClick
  end
  object btn_priv_on: TButton
    Left = 720
    Top = 48
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Private on'
    TabOrder = 5
    OnClick = btn_priv_onClick
  end
  object btn_priv_off: TButton
    Left = 720
    Top = 72
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Private off'
    TabOrder = 6
    OnClick = btn_priv_offClick
  end
  object btn_privmsg: TButton
    Left = 720
    Top = 96
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Send Message'
    TabOrder = 7
    OnClick = btn_privmsgClick
  end
  object btn_kickall: TButton
    Left = 720
    Top = 120
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Kick all'
    TabOrder = 8
    OnClick = btn_kickallClick
  end
  object accept: TCheckBox
    Left = 608
    Top = 376
    Width = 121
    Height = 17
    Anchors = [akRight, akBottom]
    Caption = 'Accept connections'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object btn_save: TButton
    Left = 720
    Top = 144
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Save Logs'
    TabOrder = 10
    OnClick = btn_saveClick
  end
  object block: TListBox
    Left = 720
    Top = 216
    Width = 121
    Height = 153
    Anchors = [akTop, akRight, akBottom]
    ItemHeight = 13
    ScrollWidth = 1
    TabOrder = 11
  end
  object btn_block: TButton
    Left = 720
    Top = 168
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Block'
    TabOrder = 12
    OnClick = btn_blockClick
  end
  object btn_unblock: TButton
    Left = 720
    Top = 192
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Unblock'
    TabOrder = 13
    OnClick = btn_unblockClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 417
    Width = 843
    Height = 19
    Panels = <
      item
        Text = 'Select User'
        Width = 50
      end>
  end
  object UserRefresh: TTimer
    Interval = 10
    OnTimer = UserRefreshTimer
    Left = 760
    Top = 376
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Text Files|*.txt'
    Left = 728
    Top = 376
  end
end
