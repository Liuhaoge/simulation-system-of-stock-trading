object Form3: TForm3
  Left = 181
  Height = 475
  Top = 112
  Width = 634
  BorderStyle = bsDialog
  Caption = '人工交易'
  ClientHeight = 475
  ClientWidth = 634
  Icon.Data = {
    C20400000000010001001011000001002000AC04000016000000280000001000
    0000220000000100200000000000400400006400000064000000000000000000
    0000FFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFEFE9E0FFC9B9A0FFBDA8
    87FFBDA989FFCFBEA6FFF4F0ECFFFFFFFFFFFDFFFFFFFEFEFEFFFEFFFFFFFDFC
    FDFFFEFEFEFFFFFEFDFFFFFFFFFFE3DACDFF90662DFF7B4900FF84510BFF8753
    0EFF84530FFF83500DFF794602FF95703BFFEEE8DDFFFFFFFFFFFEFDFEFFFCFE
    FEFFFCFDFDFFFFFFFFFFBEA888FF7B4500FF875817FF8A5D1DFF8A5C1DFF8A5C
    1DFF8A5C1CFF8A5D1DFF8A5C1CFF875613FF784701FFD0C0A7FFFFFFFFFFFCFD
    FEFFFFFFFFFFCAB89BFF7C4800FF895C1AFF8B5D1DFF8B5D1DFF8B5D1DFF8B5D
    1DFF8B5D1DFF8B5D1DFF8B5D1DFF895C1CFF895B1AFF7B4700FFDAD1C0FFFFFF
    FFFFFAFCF8FF794704FF8A5C1AFF8A5D1DFF8B5D1DFF8B5D1DFF8B5D1DFF8A5D
    1DFF8A5C1DFF8A5C1DFF8A5C1DFF8A5C1DFF8A5C1DFF86591BFF814F0EFFFFFF
    FFFFBAA583FF84530FFF8A5C1CFF8B5D1DFF8B5D1DFF8B5D1DFF8A5C1CFF895C
    1CFF895D1DFF8B5D1DFF8D5F1CFF8F601BFF8D5F1BFF8A5D18FF804F0AFFCDBC
    A1FF8F6629FF82520FFF885817FF885917FF875815FF855512FF81500BFF824F
    09FF825214FF704515FF643D14FF653D19FF724517FF845118FF8C540EFFA67C
    44FFE7E0D4FFA28556FF9C7843FFA27D49FFA78958FFC0A57AFFDDCCB2FFF3F1
    EBFF402F2DFF1F0500FF361600FF4C2708FF65340CFF7A4009FF93560BFFDEC3
    99FFFFFFFFFFD2BAA0FFAA8B68FF8A6B50FF795F4DFF7A6458FF958985FFE7E7
    ECFFFFFFFFFFFFFFFFFFD7CFC8FFBDAB99FFBDA88EFFD3C4ADFFFCFDFAFFFFFF
    FFFFA66610FF924C00FF76430DFF613810FF4E290FFF371904FF2D0E00FF3215
    00FFB09264FF8E5F21FF83520FFF85540FFF85540FFF82510CFF784500FFC1AA
    87FF9E7C4BFF895816FF885919FF825519FF83551BFF8C5E1CFF93631EFF9262
    19FF875513FF895918FF8A5B1BFF8B5D1DFF8B5D1DFF8A5C1DFF855410FFB397
    70FFD2C5AEFF7F4C05FF8B5D1CFF8B5D1CFF8C5D1DFF8B5D1CFF8A5C1CFF8A5C
    1DFF8A5C1CFF8A5C1CFF8B5D1DFF8A5D1DFF8B5D1CFF875B1BFF7B4700FFEBE7
    DEFFFFFFFFFF8C6027FF855614FF895C1DFF8B5D1DFF8B5D1DFF8B5D1DFF8B5D
    1DFF8B5D1DFF8B5D1DFF8B5D1DFF8B5D1CFF895B1DFF84520CFFA28253FFFFFF
    FFFFFFFFFFFFF5F5F1FF7F500EFF895610FF8A5C1CFF8A5D1CFF8A5D1DFF8B5D
    1DFF8B5D1DFF8B5C1DFF8A5D1DFF885B1BFF85530AFF8D6324FFFFFFFFFFFFFF
    FFFFFEFDFCFFFFFFFFFFF7F7F3FF8C6533FF7D4B05FF865716FF8B5B1AFF8A5B
    1CFF895C1CFF895A1AFF855514FF7E4900FF9C7B4EFFFFFFFFFFFFFFFFFFFDFE
    FEFFFEFEFFFFFEFFFDFFFEFFFFFFFFFFFFFFD1C4ACFF9C743BFF7C4F0CFF7A49
    03FF7D4904FF81510FFF9F7E50FFDED4C5FFFFFFFFFFFEFFFFFFFFFFFEFFFEFE
    FFFFFFFFFFFFFEFFFEFFFEFEFDFFFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6
    F5FFF9F9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFEFFFDFEFEFFFFFFFFFFFFFF
    FFFF000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000
  }
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  LCLVersion = '6.3'
  object Panel1: TPanel
    Left = 0
    Height = 475
    Top = 0
    Width = 384
    Align = alLeft
    BevelColor = 16744448
    BevelInner = bvSpace
    BevelOuter = bvNone
    ClientHeight = 475
    ClientWidth = 384
    Color = clWhite
    Font.Color = 1966318
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Edit1: TEdit
      Left = 98
      Height = 25
      Top = 106
      Width = 108
      OnEditingDone = Edit1EditingDone
      ParentFont = False
      TabOrder = 0
    end
    object SpinEdit1: TSpinEdit
      Left = 98
      Height = 25
      Top = 258
      Width = 108
      MaxValue = 100000000
      OnEditingDone = SpinEdit1EditingDone
      ParentFont = False
      TabOrder = 1
    end
    object FloatSpinEdit1: TFloatSpinEdit
      Left = 96
      Height = 25
      Top = 210
      Width = 108
      Increment = 1
      MaxValue = 100000
      MinValue = 0
      OnEditingDone = FloatSpinEdit1EditingDone
      ParentFont = False
      TabOrder = 2
      Value = 0
    end
    object Button1: TButton
      Left = 98
      Height = 25
      Top = 160
      Width = 51
      Caption = '买入'
      Color = clBlack
      OnClick = Button1Click
      TabOrder = 3
    end
    object Button2: TButton
      Left = 153
      Height = 25
      Top = 160
      Width = 51
      Caption = '卖出'
      OnClick = Button2Click
      TabOrder = 4
    end
    object Label1: TLabel
      Left = 24
      Height = 19
      Top = 112
      Width = 64
      Caption = '股票代码'
      Font.CharSet = ANSI_CHARSET
      Font.Height = -16
      Font.Name = 'Adobe Gurmukhi'
      Font.Pitch = fpVariable
      Font.Quality = fqDraft
      ParentColor = False
      ParentFont = False
    end
    object Label2: TLabel
      Left = 24
      Height = 19
      Top = 166
      Width = 64
      Caption = '交易方向'
      Font.CharSet = ANSI_CHARSET
      Font.Height = -16
      Font.Name = 'Adobe Gurmukhi'
      Font.Pitch = fpVariable
      Font.Quality = fqDraft
      ParentColor = False
      ParentFont = False
    end
    object Label3: TLabel
      Left = 24
      Height = 19
      Top = 216
      Width = 64
      Caption = '交易价格'
      Font.CharSet = ANSI_CHARSET
      Font.Height = -16
      Font.Name = 'Adobe Gurmukhi'
      Font.Pitch = fpVariable
      Font.Quality = fqDraft
      ParentColor = False
      ParentFont = False
    end
    object Label4: TLabel
      Left = 24
      Height = 19
      Top = 264
      Width = 64
      Caption = '交易数量'
      Font.CharSet = ANSI_CHARSET
      Font.Height = -16
      Font.Name = 'Adobe Gurmukhi'
      Font.Pitch = fpVariable
      Font.Quality = fqDraft
      ParentColor = False
      ParentFont = False
    end
    object Label6: TLabel
      Left = 232
      Height = 19
      Top = 112
      Width = 48
      Caption = '名称：'
      Font.CharSet = ANSI_CHARSET
      Font.Height = -16
      Font.Name = 'Adobe Gurmukhi'
      Font.Pitch = fpVariable
      Font.Quality = fqDraft
      ParentColor = False
      ParentFont = False
    end
    object Label7: TLabel
      Left = 226
      Height = 1
      Top = 210
      Width = 1
      Font.CharSet = ANSI_CHARSET
      Font.Height = -16
      Font.Name = 'Adobe Gurmukhi'
      Font.Pitch = fpVariable
      Font.Quality = fqDraft
      ParentColor = False
      ParentFont = False
    end
    object Label8: TLabel
      Left = 40
      Height = 19
      Top = 320
      Width = 48
      Caption = '金额：'
      Font.CharSet = ANSI_CHARSET
      Font.Height = -16
      Font.Name = 'Adobe Gurmukhi'
      Font.Pitch = fpVariable
      Font.Quality = fqDraft
      ParentColor = False
      ParentFont = False
    end
    object BCButton1: TBCButton
      Left = 97
      Height = 39
      Top = 368
      Width = 110
      StateClicked.Background.Color = clBlack
      StateClicked.Background.ColorOpacity = 255
      StateClicked.Background.Gradient1.StartColor = 8404992
      StateClicked.Background.Gradient1.StartColorOpacity = 255
      StateClicked.Background.Gradient1.DrawMode = dmSet
      StateClicked.Background.Gradient1.EndColor = 4194304
      StateClicked.Background.Gradient1.EndColorOpacity = 255
      StateClicked.Background.Gradient1.ColorCorrection = True
      StateClicked.Background.Gradient1.GradientType = gtRadial
      StateClicked.Background.Gradient1.Point1XPercent = 50
      StateClicked.Background.Gradient1.Point1YPercent = 100
      StateClicked.Background.Gradient1.Point2XPercent = 0
      StateClicked.Background.Gradient1.Point2YPercent = 0
      StateClicked.Background.Gradient1.Sinus = False
      StateClicked.Background.Gradient2.StartColor = clWhite
      StateClicked.Background.Gradient2.StartColorOpacity = 255
      StateClicked.Background.Gradient2.DrawMode = dmSet
      StateClicked.Background.Gradient2.EndColor = clBlack
      StateClicked.Background.Gradient2.EndColorOpacity = 255
      StateClicked.Background.Gradient2.ColorCorrection = True
      StateClicked.Background.Gradient2.GradientType = gtLinear
      StateClicked.Background.Gradient2.Point1XPercent = 0
      StateClicked.Background.Gradient2.Point1YPercent = 0
      StateClicked.Background.Gradient2.Point2XPercent = 0
      StateClicked.Background.Gradient2.Point2YPercent = 100
      StateClicked.Background.Gradient2.Sinus = False
      StateClicked.Background.Gradient1EndPercent = 100
      StateClicked.Background.Style = bbsGradient
      StateClicked.Border.Color = clBlack
      StateClicked.Border.ColorOpacity = 255
      StateClicked.Border.LightColor = clWhite
      StateClicked.Border.LightOpacity = 255
      StateClicked.Border.LightWidth = 0
      StateClicked.Border.Style = bboNone
      StateClicked.Border.Width = 1
      StateClicked.FontEx.Color = 16770790
      StateClicked.FontEx.EndEllipsis = False
      StateClicked.FontEx.FontQuality = fqSystemClearType
      StateClicked.FontEx.Height = 0
      StateClicked.FontEx.SingleLine = True
      StateClicked.FontEx.Shadow = True
      StateClicked.FontEx.ShadowColor = clBlack
      StateClicked.FontEx.ShadowColorOpacity = 255
      StateClicked.FontEx.ShadowRadius = 2
      StateClicked.FontEx.ShadowOffsetX = 1
      StateClicked.FontEx.ShadowOffsetY = 1
      StateClicked.FontEx.Style = [fsBold]
      StateClicked.FontEx.TextAlignment = bcaCenter
      StateClicked.FontEx.WordBreak = False
      StateHover.Background.Color = clBlack
      StateHover.Background.ColorOpacity = 255
      StateHover.Background.Gradient1.StartColor = 16744448
      StateHover.Background.Gradient1.StartColorOpacity = 255
      StateHover.Background.Gradient1.DrawMode = dmSet
      StateHover.Background.Gradient1.EndColor = 8404992
      StateHover.Background.Gradient1.EndColorOpacity = 255
      StateHover.Background.Gradient1.ColorCorrection = True
      StateHover.Background.Gradient1.GradientType = gtRadial
      StateHover.Background.Gradient1.Point1XPercent = 50
      StateHover.Background.Gradient1.Point1YPercent = 100
      StateHover.Background.Gradient1.Point2XPercent = 0
      StateHover.Background.Gradient1.Point2YPercent = 0
      StateHover.Background.Gradient1.Sinus = False
      StateHover.Background.Gradient2.StartColor = clWhite
      StateHover.Background.Gradient2.StartColorOpacity = 255
      StateHover.Background.Gradient2.DrawMode = dmSet
      StateHover.Background.Gradient2.EndColor = clBlack
      StateHover.Background.Gradient2.EndColorOpacity = 255
      StateHover.Background.Gradient2.ColorCorrection = True
      StateHover.Background.Gradient2.GradientType = gtLinear
      StateHover.Background.Gradient2.Point1XPercent = 0
      StateHover.Background.Gradient2.Point1YPercent = 0
      StateHover.Background.Gradient2.Point2XPercent = 0
      StateHover.Background.Gradient2.Point2YPercent = 100
      StateHover.Background.Gradient2.Sinus = False
      StateHover.Background.Gradient1EndPercent = 100
      StateHover.Background.Style = bbsGradient
      StateHover.Border.Color = clBlack
      StateHover.Border.ColorOpacity = 255
      StateHover.Border.LightColor = clWhite
      StateHover.Border.LightOpacity = 255
      StateHover.Border.LightWidth = 0
      StateHover.Border.Style = bboNone
      StateHover.Border.Width = 1
      StateHover.FontEx.Color = clWhite
      StateHover.FontEx.EndEllipsis = False
      StateHover.FontEx.FontQuality = fqSystemClearType
      StateHover.FontEx.Height = 0
      StateHover.FontEx.SingleLine = True
      StateHover.FontEx.Shadow = True
      StateHover.FontEx.ShadowColor = clBlack
      StateHover.FontEx.ShadowColorOpacity = 255
      StateHover.FontEx.ShadowRadius = 2
      StateHover.FontEx.ShadowOffsetX = 1
      StateHover.FontEx.ShadowOffsetY = 1
      StateHover.FontEx.Style = [fsBold]
      StateHover.FontEx.TextAlignment = bcaCenter
      StateHover.FontEx.WordBreak = False
      StateNormal.Background.Color = clBlack
      StateNormal.Background.ColorOpacity = 255
      StateNormal.Background.Gradient1.StartColor = clHotLight
      StateNormal.Background.Gradient1.StartColorOpacity = 255
      StateNormal.Background.Gradient1.DrawMode = dmSet
      StateNormal.Background.Gradient1.EndColor = clHighlight
      StateNormal.Background.Gradient1.EndColorOpacity = 255
      StateNormal.Background.Gradient1.ColorCorrection = True
      StateNormal.Background.Gradient1.GradientType = gtLinear
      StateNormal.Background.Gradient1.Point1XPercent = 0
      StateNormal.Background.Gradient1.Point1YPercent = 0
      StateNormal.Background.Gradient1.Point2XPercent = 0
      StateNormal.Background.Gradient1.Point2YPercent = 100
      StateNormal.Background.Gradient1.Sinus = False
      StateNormal.Background.Gradient2.StartColor = clHotLight
      StateNormal.Background.Gradient2.StartColorOpacity = 255
      StateNormal.Background.Gradient2.DrawMode = dmSet
      StateNormal.Background.Gradient2.EndColor = clHighlight
      StateNormal.Background.Gradient2.EndColorOpacity = 255
      StateNormal.Background.Gradient2.ColorCorrection = True
      StateNormal.Background.Gradient2.GradientType = gtRadial
      StateNormal.Background.Gradient2.Point1XPercent = 50
      StateNormal.Background.Gradient2.Point1YPercent = 100
      StateNormal.Background.Gradient2.Point2XPercent = 0
      StateNormal.Background.Gradient2.Point2YPercent = 0
      StateNormal.Background.Gradient2.Sinus = False
      StateNormal.Background.Gradient1EndPercent = 60
      StateNormal.Background.Style = bbsGradient
      StateNormal.Border.Color = clBlack
      StateNormal.Border.ColorOpacity = 255
      StateNormal.Border.LightColor = clWhite
      StateNormal.Border.LightOpacity = 255
      StateNormal.Border.LightWidth = 0
      StateNormal.Border.Style = bboNone
      StateNormal.Border.Width = 1
      StateNormal.FontEx.Color = 16770790
      StateNormal.FontEx.EndEllipsis = False
      StateNormal.FontEx.FontQuality = fqSystemClearType
      StateNormal.FontEx.Height = 0
      StateNormal.FontEx.SingleLine = True
      StateNormal.FontEx.Shadow = True
      StateNormal.FontEx.ShadowColor = clBlack
      StateNormal.FontEx.ShadowColorOpacity = 255
      StateNormal.FontEx.ShadowRadius = 2
      StateNormal.FontEx.ShadowOffsetX = 1
      StateNormal.FontEx.ShadowOffsetY = 1
      StateNormal.FontEx.Style = [fsBold]
      StateNormal.FontEx.TextAlignment = bcaCenter
      StateNormal.FontEx.WordBreak = False
      Caption = '提交订单'
      Color = 16744448
      DropDownWidth = 16
      DropDownArrowSize = 8
      GlobalOpacity = 255
      InnerMargin = 0
      OnClick = BCButton1Click
      ParentColor = False
      Rounding.RoundX = 12
      Rounding.RoundY = 12
      Rounding.RoundOptions = []
      RoundingDropDown.RoundX = 1
      RoundingDropDown.RoundY = 1
      RoundingDropDown.RoundOptions = []
      TextApplyGlobalOpacity = True
      DropDownStyle = bdsCommon
      MemoryUsage = bmuLow
    end
    object Label9: TLabel
      Left = 280
      Height = 1
      Top = 112
      Width = 1
      Font.CharSet = ANSI_CHARSET
      Font.Height = -16
      Font.Name = 'Adobe Gurmukhi'
      Font.Pitch = fpVariable
      Font.Quality = fqDraft
      ParentColor = False
      ParentFont = False
    end
    object Label10: TLabel
      Left = 295
      Height = 1
      Top = 210
      Width = 1
      Font.CharSet = ANSI_CHARSET
      Font.Color = 1966318
      Font.Height = -16
      Font.Name = 'Adobe Gurmukhi'
      Font.Pitch = fpVariable
      Font.Quality = fqDraft
      ParentColor = False
      ParentFont = False
    end
    object Label5: TLabel
      Left = 24
      Height = 19
      Top = 58
      Width = 64
      Caption = '交易市场'
      Font.CharSet = ANSI_CHARSET
      Font.Height = -16
      Font.Name = 'Adobe Gurmukhi'
      Font.Pitch = fpVariable
      Font.Quality = fqDraft
      ParentColor = False
      ParentFont = False
    end
    object ComboBox1: TComboBox
      Left = 98
      Height = 25
      Top = 56
      Width = 108
      ItemHeight = 17
      Items.Strings = (
        '沪市'
        '深市'
      )
      ParentFont = False
      ParentShowHint = False
      Style = csDropDownList
      TabOrder = 5
    end
    object Label11: TLabel
      Left = 97
      Height = 1
      Top = 320
      Width = 1
      Font.CharSet = ANSI_CHARSET
      Font.Color = 1966318
      Font.Height = -16
      Font.Name = 'Adobe Gurmukhi'
      Font.Pitch = fpVariable
      Font.Quality = fqDraft
      ParentColor = False
      ParentFont = False
    end
    object RadioButton1: TRadioButton
      Left = 216
      Height = 21
      Top = 164
      Width = 34
      Caption = '买'
      TabOrder = 6
      Visible = False
    end
    object RadioButton2: TRadioButton
      Left = 256
      Height = 21
      Top = 164
      Width = 34
      Caption = '卖'
      TabOrder = 7
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 384
    Height = 475
    Top = 0
    Width = 250
    Align = alClient
    ClientHeight = 475
    ClientWidth = 250
    TabOrder = 1
    object plGradient1: TplGradient
      Left = 1
      Height = 16
      Top = 1
      Width = 248
      Align = alTop
      BevelWidth = 1
      BevelStyle = bvNone
      Buffered = True
      Direction = gdDownRight
      ColorStart = clHotLight
      ColorEnd = clWhite
      StepWidth = 1
      Style = gsVertical
    end
    object box: TPaintBox32
      Left = 1
      Height = 457
      Top = 17
      Width = 248
      Align = alClient
      TabOrder = 0
    end
  end
end
