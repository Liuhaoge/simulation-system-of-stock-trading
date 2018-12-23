object Form4: TForm4
  Left = 326
  Height = 378
  Top = 108
  Width = 705
  Caption = '订单队列'
  ClientHeight = 378
  ClientWidth = 705
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
  OnActivate = FormActivate
  OnClose = FormClose
  LCLVersion = '6.3'
  object PageControl1: TPageControl
    Tag = 2
    Left = 0
    Height = 378
    Top = 0
    Width = 705
    ActivePage = TabSheet2
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = '已成交'
      ClientHeight = 348
      ClientWidth = 697
      object ListView1: TListView
        Left = 0
        Height = 348
        Top = 0
        Width = 697
        Align = alClient
        Columns = <        
          item
            Alignment = taCenter
            Caption = '订单号'
            MaxWidth = 500
            Width = 100
          end        
          item
            Alignment = taCenter
            Caption = '成交时间'
            Width = 80
          end        
          item
            Alignment = taCenter
            Caption = '市场'
          end        
          item
            Alignment = taCenter
            Caption = '股票代码'
            Width = 80
          end        
          item
            Alignment = taCenter
            Caption = '股票名称'
            Width = 100
          end        
          item
            Alignment = taCenter
            Caption = '价格'
            Width = 70
          end        
          item
            Alignment = taCenter
            Caption = '数量'
            Width = 60
          end        
          item
            Alignment = taCenter
            Caption = '交易方向'
            Width = 70
          end        
          item
            Alignment = taCenter
            Caption = '交易金额'
            Width = 80
          end>
        GridLines = True
        ReadOnly = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TabSheet2: TTabSheet
      Caption = '未成交'
      ClientHeight = 348
      ClientWidth = 697
      object ListView2: TListView
        Left = 0
        Height = 348
        Top = 0
        Width = 697
        Align = alClient
        Columns = <        
          item
            Alignment = taCenter
            Caption = '订单号'
            MaxWidth = 500
            Width = 100
          end        
          item
            Alignment = taCenter
            Caption = '市场'
          end        
          item
            Alignment = taCenter
            Caption = '股票代码'
            Width = 80
          end        
          item
            Alignment = taCenter
            Caption = '股票名称'
            Width = 100
          end        
          item
            Alignment = taCenter
            Caption = '价格'
            Width = 70
          end        
          item
            Alignment = taCenter
            Caption = '数量'
            Width = 60
          end        
          item
            Alignment = taCenter
            Caption = '交易方向'
            Width = 70
          end        
          item
            Alignment = taCenter
            Caption = '交易金额'
            Width = 80
          end>
        GridLines = True
        ReadOnly = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TabSheet3: TTabSheet
      Caption = '历史记录'
      ClientHeight = 348
      ClientWidth = 697
      object ListView3: TListView
        Left = 0
        Height = 348
        Top = 0
        Width = 697
        Align = alClient
        Columns = <        
          item
            Alignment = taCenter
            Caption = '订单号'
            MaxWidth = 500
            Width = 100
          end        
          item
            Alignment = taCenter
            Caption = '成交时间'
            Width = 80
          end        
          item
            Alignment = taCenter
            Caption = '市场'
          end        
          item
            Alignment = taCenter
            Caption = '股票代码'
            Width = 80
          end        
          item
            Alignment = taCenter
            Caption = '股票名称'
            Width = 100
          end        
          item
            Alignment = taCenter
            Caption = '价格'
            Width = 70
          end        
          item
            Alignment = taCenter
            Caption = '数量'
            Width = 60
          end        
          item
            Alignment = taCenter
            Caption = '交易方向'
            Width = 70
          end        
          item
            Alignment = taCenter
            Caption = '交易金额'
            Width = 80
          end>
        GridLines = True
        ReadOnly = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
  end
end
