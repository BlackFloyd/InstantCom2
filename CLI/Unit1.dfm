object Form1: TForm1
  Left = 291
  Top = 190
  Width = 922
  Height = 484
  Caption = 'InstantCom2'
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnClose = V
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    914
    457)
  PixelsPerInch = 96
  TextHeight = 13
  object act_deselect: TLabel
    Left = 752
    Top = 392
    Width = 48
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = '[Deselect]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = act_deselectClick
  end
  object act_username: TLabel
    Left = 752
    Top = 408
    Width = 97
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = '[Request Username]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = act_usernameClick
  end
  object act_send: TLabel
    Left = 752
    Top = 424
    Width = 31
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = '[Send]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = act_sendClick
  end
  object input: TEdit
    Left = 0
    Top = 424
    Width = 745
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyPress = inputKeyPress
  end
  object outputbox: TMemo
    Left = 0
    Top = 0
    Width = 745
    Height = 425
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object userlist: TListBox
    Left = 744
    Top = 0
    Width = 169
    Height = 385
    Anchors = [akTop, akRight, akBottom]
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    ScrollWidth = 1
    TabOrder = 2
    OnClick = userlistClick
  end
  object BoxActive: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = BoxActiveTimer
    Left = 448
    Top = 232
  end
end
