object Form10: TForm10
  Left = 181
  Height = 388
  Top = 112
  Width = 549
  Caption = '策略编辑'
  ClientHeight = 388
  ClientWidth = 549
  OnClose = FormClose
  LCLVersion = '6.3'
  object Panel1: TPanel
    Left = 0
    Height = 50
    Top = 0
    Width = 549
    Align = alTop
    Caption = '策 略 编 辑'
    ClientHeight = 50
    ClientWidth = 549
    Font.Height = -16
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object plGradient1: TplGradient
      Left = 1
      Height = 9
      Top = 40
      Width = 547
      Align = alBottom
      BevelWidth = 1
      BevelStyle = bvNone
      Buffered = True
      Direction = gdDownRight
      ColorStart = clWhite
      ColorEnd = clHotLight
      StepWidth = 1
      Style = gsVertical
    end
  end
  object Panel2: TPanel
    Left = 0
    Height = 292
    Top = 50
    Width = 280
    Align = alLeft
    ClientHeight = 292
    ClientWidth = 280
    Color = clWhite
    ParentColor = False
    TabOrder = 1
    object Panel4: TPanel
      Left = 1
      Height = 34
      Top = 1
      Width = 278
      Align = alTop
      Caption = '上 轨'
      Font.Height = -16
      ParentFont = False
      TabOrder = 0
    end
    object Label1: TLabel
      Left = 32
      Height = 19
      Top = 96
      Width = 91
      Caption = '今日开盘价高于'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object Label5: TLabel
      Left = 32
      Height = 19
      Top = 176
      Width = 26
      Caption = '开盘'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object Label6: TLabel
      Left = 120
      Height = 19
      Top = 176
      Width = 78
      Caption = '分钟高点超过'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object Label7: TLabel
      Left = 32
      Height = 19
      Top = 216
      Width = 104
      Caption = '日内上涨幅度高于'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object plGradient2: TplGradient
      Left = 1
      Height = 9
      Top = 282
      Width = 278
      Align = alBottom
      BevelWidth = 1
      BevelStyle = bvNone
      Buffered = True
      Direction = gdDownRight
      ColorStart = clWhite
      ColorEnd = clHotLight
      StepWidth = 1
      Style = gsVertical
    end
    object Label17: TLabel
      Left = 32
      Height = 19
      Top = 54
      Width = 26
      Caption = '高于'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object Label18: TLabel
      Left = 152
      Height = 19
      Top = 54
      Width = 39
      Caption = '日均价'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object Label19: TLabel
      Left = 32
      Height = 19
      Top = 136
      Width = 91
      Caption = '昨日收盘价高于'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object Label21: TLabel
      Left = 32
      Height = 19
      Top = 248
      Width = 104
      Caption = '短均线低于长均线'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object SpinEdit1: TSpinEdit
      Left = 64
      Height = 25
      Top = 48
      Width = 82
      TabOrder = 1
    end
    object FloatSpinEdit1: TFloatSpinEdit
      Left = 128
      Height = 25
      Top = 90
      Width = 88
      Increment = 1
      MaxValue = 100
      MinValue = 0
      TabOrder = 2
      Value = 0
    end
    object FloatSpinEdit4: TFloatSpinEdit
      Left = 128
      Height = 25
      Top = 136
      Width = 88
      Increment = 1
      MaxValue = 100
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
    object FloatSpinEdit5: TFloatSpinEdit
      Left = 200
      Height = 25
      Top = 176
      Width = 66
      Increment = 1
      MaxValue = 100
      MinValue = 0
      TabOrder = 4
      Value = 0
    end
  end
  object Panel6: TPanel
    Left = 0
    Height = 46
    Top = 342
    Width = 549
    Align = alBottom
    BevelColor = clWhite
    BorderStyle = bsSingle
    ClientHeight = 42
    ClientWidth = 545
    Color = clWhite
    ParentColor = False
    TabOrder = 2
    object Button1: TButton
      Left = 424
      Height = 25
      Top = 8
      Width = 80
      Caption = '完成'
      OnClick = Button1Click
      TabOrder = 0
    end
    object Label3: TLabel
      Left = 24
      Height = 21
      Top = 8
      Width = 80
      Caption = '策略名称：'
      Font.Height = -16
      ParentColor = False
      ParentFont = False
    end
    object Edit15: TEdit
      Left = 104
      Height = 25
      Top = 8
      Width = 168
      TabOrder = 1
    end
  end
  object Label2: TLabel
    Left = 32
    Height = 19
    Top = 104
    Width = 26
    Caption = '高于'
    Font.Height = -13
    ParentColor = False
    ParentFont = False
  end
  object Panel3: TPanel
    Left = 280
    Height = 292
    Top = 50
    Width = 269
    Align = alClient
    BevelColor = clWhite
    ClientHeight = 292
    ClientWidth = 269
    Color = clWhite
    ParentColor = False
    TabOrder = 3
    object Panel5: TPanel
      Left = 1
      Height = 34
      Top = 1
      Width = 267
      Align = alTop
      Caption = '下 轨'
      Font.Height = -16
      ParentFont = False
      TabOrder = 0
    end
    object Label9: TLabel
      Left = 32
      Height = 19
      Top = 96
      Width = 91
      Caption = '今日开盘价低于'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object Label10: TLabel
      Left = 32
      Height = 19
      Top = 176
      Width = 26
      Caption = '开盘'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object Label11: TLabel
      Left = 120
      Height = 19
      Top = 176
      Width = 78
      Caption = '分钟低点跌至'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object Label12: TLabel
      Left = 32
      Height = 19
      Top = 216
      Width = 104
      Caption = '日内上涨幅度低于'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object Label13: TLabel
      Left = 32
      Height = 19
      Top = 54
      Width = 26
      Caption = '低于'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object Label15: TLabel
      Left = 32
      Height = 19
      Top = 136
      Width = 91
      Caption = '昨日收盘价低于'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object Label16: TLabel
      Left = 32
      Height = 19
      Top = 248
      Width = 104
      Caption = '短均线高于长均线'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object plGradient3: TplGradient
      Left = 1
      Height = 9
      Top = 282
      Width = 267
      Align = alBottom
      BevelWidth = 1
      BevelStyle = bvNone
      Buffered = True
      Direction = gdDownRight
      ColorStart = clWhite
      ColorEnd = clHotLight
      StepWidth = 1
      Style = gsVertical
    end
    object Label20: TLabel
      Left = 152
      Height = 19
      Top = 54
      Width = 39
      Caption = '日均价'
      Font.Height = -13
      ParentColor = False
      ParentFont = False
    end
    object SpinEdit2: TSpinEdit
      Left = 64
      Height = 25
      Top = 48
      Width = 82
      TabOrder = 1
    end
    object FloatSpinEdit2: TFloatSpinEdit
      Left = 128
      Height = 25
      Top = 90
      Width = 88
      Increment = 1
      MaxValue = 100
      MinValue = 0
      TabOrder = 2
      Value = 0
    end
    object SpinEdit7: TSpinEdit
      Left = 64
      Height = 25
      Top = 176
      Width = 50
      TabOrder = 3
    end
    object FloatSpinEdit6: TFloatSpinEdit
      Left = 200
      Height = 25
      Top = 176
      Width = 66
      Increment = 1
      MaxValue = 100
      MinValue = 0
      TabOrder = 4
      Value = 0
    end
  end
  object Label4: TLabel
    Left = 32
    Height = 19
    Top = 184
    Width = 91
    Caption = '今日开盘价高于'
    Font.Height = -13
    ParentColor = False
    ParentFont = False
  end
  object FloatSpinEdit3: TFloatSpinEdit
    Left = 408
    Height = 25
    Top = 184
    Width = 88
    Increment = 1
    MaxValue = 100
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
  object SpinEdit5: TSpinEdit
    Left = 64
    Height = 25
    Top = 224
    Width = 50
    TabOrder = 5
  end
  object FloatSpinEdit7: TFloatSpinEdit
    Left = 144
    Height = 25
    Top = 264
    Width = 88
    Increment = 1
    MaxValue = 100
    MinValue = 0
    TabOrder = 6
    Value = 0
  end
  object FloatSpinEdit9: TFloatSpinEdit
    Left = 424
    Height = 25
    Top = 264
    Width = 82
    Increment = 1
    MaxValue = 100
    MinValue = 0
    TabOrder = 7
    Value = 0
  end
  object FloatSpinEdit10: TFloatSpinEdit
    Left = 424
    Height = 25
    Top = 296
    Width = 82
    Increment = 1
    MaxValue = 100
    MinValue = 0
    TabOrder = 8
    Value = 0
  end
  object FloatSpinEdit8: TFloatSpinEdit
    Left = 144
    Height = 25
    Top = 292
    Width = 88
    Increment = 1
    MaxValue = 100
    MinValue = 0
    TabOrder = 9
    Value = 0
  end
end
