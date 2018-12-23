object frmMain: TfrmMain
  Left = 230
  Height = 494
  Top = 125
  Width = 734
  Caption = 'New StockChart'
  ClientHeight = 494
  ClientWidth = 734
  OnCreate = FormCreate
  OnResize = FormResize
  LCLVersion = '6.3'
  object box: TPaintBox32
    Left = 0
    Height = 392
    Top = 102
    Width = 734
    Align = alClient
    TabOrder = 0
  end
  object PageControl1: TPageControl
    Left = 0
    Height = 102
    Top = 0
    Width = 734
    ActivePage = TabSheet3
    Align = alTop
    TabIndex = 2
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = '函数测试'
      ClientHeight = 71
      ClientWidth = 680
      object Button1: TButton
        Left = 10
        Height = 25
        Top = 15
        Width = 120
        Caption = 'Area Gradient'
        OnClick = Button1Click
        TabOrder = 0
      end
      object Button2: TButton
        Left = 138
        Height = 25
        Top = 15
        Width = 120
        Caption = 'Area Gradient H'
        OnClick = Button2Click
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'ChartItemBase'
      ClientHeight = 72
      ClientWidth = 726
      object Button3: TButton
        Left = 14
        Height = 25
        Top = 14
        Width = 75
        Caption = '绘制'
        OnClick = Button3Click
        TabOrder = 0
      end
      object CheckBox1: TCheckBox
        Left = 95
        Height = 21
        Top = 15
        Width = 70
        Caption = '渐变背景'
        TabOrder = 1
      end
      object RadioButton1: TRadioButton
        Left = 170
        Height = 21
        Top = 15
        Width = 46
        Caption = '垂直'
        Checked = True
        TabOrder = 3
        TabStop = True
      end
      object RadioButton2: TRadioButton
        Left = 220
        Height = 21
        Top = 15
        Width = 46
        Caption = '水平'
        TabOrder = 2
      end
      object Button4: TButton
        Left = 278
        Height = 25
        Top = 14
        Width = 75
        Caption = '加背景图'
        OnClick = Button4Click
        TabOrder = 4
      end
      object Button5: TButton
        Left = 360
        Height = 25
        Top = 14
        Width = 75
        Caption = '去背景图'
        OnClick = Button5Click
        TabOrder = 5
      end
      object CheckBox2: TCheckBox
        Left = 444
        Height = 21
        Top = 15
        Width = 70
        Caption = '背景拉伸'
        TabOrder = 6
      end
      object CheckBox3: TCheckBox
        Left = 516
        Height = 21
        Top = 15
        Width = 70
        Caption = '背景居中'
        TabOrder = 7
      end
      object ColorButton1: TColorButton
        Left = 96
        Height = 25
        Top = 45
        Width = 75
        BorderWidth = 2
        ButtonColorSize = 16
        ButtonColor = clBlack
      end
      object ColorButton2: TColorButton
        Left = 176
        Height = 25
        Top = 45
        Width = 75
        BorderWidth = 2
        ButtonColorSize = 16
        ButtonColor = clBlack
      end
      object CheckBox4: TCheckBox
        Left = 278
        Height = 21
        Top = 48
        Width = 94
        Caption = '降低特效质量'
        TabOrder = 8
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Box && Grid'
      ClientHeight = 72
      ClientWidth = 726
      object Button6: TButton
        Left = 14
        Height = 25
        Top = 10
        Width = 75
        Caption = '绘制Box'
        OnClick = Button6Click
        TabOrder = 0
      end
      object Button7: TButton
        Left = 93
        Height = 25
        Top = 10
        Width = 126
        Caption = '绘制Grid和Y轴'
        OnClick = Button7Click
        TabOrder = 1
      end
      object Button8: TButton
        Left = 227
        Height = 25
        Top = 11
        Width = 75
        Caption = 'FPS'
        OnClick = Button8Click
        TabOrder = 2
      end
      object Button9: TButton
        Left = 314
        Height = 25
        Top = 10
        Width = 75
        Caption = 'Button9'
        OnClick = Button9Click
        TabOrder = 3
      end
      object SpinEdit1: TSpinEdit
        Left = 136
        Height = 25
        Top = 42
        Width = 50
        MinValue = 1
        TabOrder = 4
        Value = 1
      end
      object Label1: TLabel
        Left = 102
        Height = 17
        Top = 44
        Width = 24
        Caption = '线宽'
        ParentColor = False
      end
      object ColorButton3: TColorButton
        Left = 190
        Height = 25
        Top = 42
        Width = 75
        BorderWidth = 2
        ButtonColorSize = 16
        ButtonColor = clWhite
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Account'
      ClientHeight = 72
      ClientWidth = 726
      object Button10: TButton
        Left = 17
        Height = 25
        Top = 14
        Width = 75
        Caption = '绘制'
        TabOrder = 0
      end
    end
  end
end
