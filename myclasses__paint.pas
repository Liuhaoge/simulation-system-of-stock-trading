unit myclasses__Paint;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLIntf, LCLType, Graphics, LMessages, Math, TypInfo, variants,
  DateUtils, GR32, GR32_Image, GR32_Polygons,  myutils, contnrs, DOM, XMLWrite,XMLRead;       //
                                                      //gateconst,
type
  {所有绘图原件积累}

  { TMyChartItemBase }
                                     //重要！！！重要！！！重要！！！重要！！！
  TMyChartItemBase = class(TComponent)
  private
    FBackground: TPicture;
    FBackgroundCenter: boolean;
    FBackgroundLeft: integer;
    FBackgroundStretch: boolean;
    FBackgroundTop: integer;
    FBitmap: TBitmap32;
    FChartName: string;
    FEndColor: TColor;
    FFromColor: TColor;
    FGradient: boolean;
    FGradientSteps: integer;
    FHeight: integer;
    FLeft: integer;
    FTop: integer;
    FTransparent: boolean;
    FVerticalGradient: boolean;
    FVisible: boolean;
    FWidth: integer;
  protected
    procedure DrawBackground;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Paint;virtual;
    procedure PaintEx(ABaseLeft,ABaseTop:integer);virtual;
    property Bitmap:TBitmap32 read FBitmap write FBitmap; //绘图板对象
  published
    property Transparent:boolean read FTransparent write FTransparent;//是否透明，控制绘制背景色
    property Background:TPicture read FBackground write FBackground;//背景图片
    property BackgroundTop:integer read FBackgroundTop write FBackgroundTop;//背景图片绘制的TOP
    property BackgroundLeft:integer read FBackgroundLeft write FBackgroundLeft;//背景图片绘制的LEFT
    property BackgroundStretch:boolean  read FBackgroundStretch write FBackgroundStretch;//背景图是否拉伸
    property BackgroundCenter:boolean read FBackgroundCenter write FBackgroundCenter;//背景图是否居中
    property Gradient:boolean read FGradient write FGradient;//是否绘制渐变色背景
    property GradientSteps:integer read FGradientSteps write FGradientSteps;//渐变色步数
    property VerticalGradient:boolean read FVerticalGradient write FVerticalGradient;//是否垂直渐变，否则水平渐变
    property FromColor:TColor read FFromColor write FFromColor;//渐变起始颜色，如果不使用渐变色就是背景色
    property EndColor:TColor read FEndColor write FEndColor;//渐变色结束颜色
    property Top:integer read FTop write FTop;
    property Left:integer read FLeft write FLeft;
    property Width:integer read FWidth write FWidth;
    property Height:integer read FHeight write FHeight;
    property Visible:boolean read FVisible write FVisible;
    property ChartName:string read FChartName write FChartName;
  end;

  {文字标签元件}

  { TMyChartLabel }                    //重要！！！重要！！！重要！！！重要！！！

  TMyChartLabel = class(TMyChartItemBase)
  private
    FCaption: string;
    FFont: TFont;
    procedure SetFont(AValue: TFont);
  public
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;
    procedure PaintEx(ABaseLeft,ABaseTop:integer);override;
  published
    property Caption:string read FCaption write FCaption;//标签文本
    property Font:TFont read FFont write SetFont;
  end;

  {矩形框元件}

  { TMyChartBox }                   //重要！！！重要！！！重要！！！重要！！！

  TMyChartBox = class(TMyChartItemBase)
  private
    FBorderColor: TColor;
    FBorderVisible: boolean;
    FBorderWidth: integer;
    FCaption: string;
    FFont: TFont;
    procedure SetFont(AValue: TFont);
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure PaintEx(ABaseLeft,ABaseTop:integer);override;
  published
    property BorderVisible:boolean read FBorderVisible write FBorderVisible;//是否显示边框
    property BorderWidth:integer read FBorderWidth write FBorderWidth;//边框宽度
    property BorderColor:TColor read FBorderColor write FBorderColor;//边框颜色
    property Caption:string read FCaption write FCaption;//盒子文字
    property Font:TFont read FFont write SetFont;//盒子字体
  end;

  { OHLC横条，显示现价，最高最低，前收今开， }

  { TMyChartOHLCBanner }                 //重要！！！重要！！！重要！！！重要！！！

  TMyChartOHLCBanner = class(TMyChartBox)
  private
    FCaptionFontColor: TColor;
    FCloseCaption: string;
    FCloseValue: double;
    FCloseValueFontSize: integer;
    FDateString: string;
    FDecimalCount: integer;
    FHighCaption: string;
    FHighValue: double;
    FIncreaseCaption: string;
    FIncreaseRateCaption: string;
    FIncreaseRateValue: double;
    FIncreaseValue: double;
    FLastCloseCaption: string;
    FLastCloseValue: double;
    FLowCaption: string;
    FLowValue: double;
    FNormalFontSize: integer;
    FOpenCaption: string;
    FOpenValue: double;
    FSpacing: integer;
    FValueFontColor: TColor;
    FBackgroundColor:TColor;
  public
    constructor Create(AOwner:TComponent);override;
    procedure PaintEx(ABaseLeft,ABaseTop:integer);override;
  published
    property BackgroundColor:TColor read FBackgroundColor write FBackgroundColor;
    property DecimalCount:integer read FDecimalCount write FDecimalCount;//涨跌数值的小数位数
    property CloseValueFontSize:integer read FCloseValueFontSize write FCloseValueFontSize;//现价字体大小
    property NormalFontSize:integer read FNormalFontSize write FNormalFontSize;//正常字体大小
    property Spacing:integer read FSpacing write FSpacing;//间隔空格数
    property DateString:string read FDateString write FDateString;//日期文本
    property LastCloseCaption:string read FLastCloseCaption write FLastCloseCaption;//前收盘文本
    property LastCloseValue:double read FLastCloseValue write FLastCloseValue;//前收盘数值
    property OpenCaption:string read FOpenCaption write FOpenCaption;//开盘价文本
    property OpenValue:double read FOpenValue write FOpenValue;//开盘价数值
    property HighCaption:string read FHighCaption write FHighCaption;//最高价文本
    property HighValue:double read FHighValue write FHighValue;//最高价数值
    property LowCaption:string read FLowCaption write FLowCaption;//最低价文本
    property LowValue:double read FLowValue write FLowValue;//最低价数值
    property CloseCaption:string read FCloseCaption write FCloseCaption;//收盘价文本
    property CloseValue:double read FCloseValue write FCloseValue;//收盘价数值
    property IncreaseCaption:string read FIncreaseCaption write FIncreaseCaption;//涨跌文本
    property IncreaseValue:double read FIncreaseValue write FIncreaseValue;//涨跌数值
    property IncreaseRateCaption:string read FIncreaseRateCaption write FIncreaseRateCaption;//涨跌幅文本
    property IncreaseRateValue:double read FIncreaseRateValue write FIncreaseRateValue;//涨跌幅数值
    property CaptionFontColor:TColor read FCaptionFontColor write FCaptionFontColor;//文本字体颜色
    property ValueFontColor:TColor read FValueFontColor write FValueFontColor;//数值字体颜色
  end;

  { OHLCV横条，显示现价，最高最低，前收今开， 成交量}

  { TMyChartOHLCVBanner }                  //重要！！！重要！！！重要！！！重要！！！

  TMyChartOHLCVBanner = class(TMyChartOHLCBanner)
  private
    FAmountCaption: string;
    FAmountValue: double;
    FVolumeCaption: string;
    FVolumeValue: integer;
  public
    constructor Create(AOwner:TComponent);override;
    procedure PaintEx(ABaseLeft,ABaseTop:integer);override;
  published
    property VolumeCaption:string read FVolumeCaption write FVolumeCaption;//成交量文本
    property VolumeValue:integer read FVolumeValue write FVolumeValue;//成交量数值
    property AmountCaption:string read FAmountCaption write FAmountCaption;//成交额文本
    property AmountValue:double read FAmountValue write FAmountValue;//成交额数值
  end;

  {网格元件}

  { TMyChartGrid }
                              //重要！！！重要！！！重要！！！重要！！！
  TMyChartGrid = class(TMyChartBox)
  private
    FColCount: integer;
    FDisplayMiddleLine: boolean;
    FEveryCol: integer;
    FFixRowHeight: integer;
    FHGridColor: TColor;
    FHGridTransparent: integer;
    FHGridVisible: boolean;
    FMiddleLineColor: TColor;
    FMiddleLineTransparent: integer;
    FVGridColor: TColor;
    FVGridTransparent: integer;
    FVGridVisible: boolean;
    function GetRowCount: integer;
  public
    constructor Create(AOwner:TComponent);override;
    procedure PaintEx(ABaseLeft,ABaseTop:integer);override;
    property RowCount:integer read GetRowCount;//行数
  published
    property VGridVisible:boolean read FVGridVisible write FVGridVisible;//是否显示竖线
    property VGridColor:TColor read FVGridColor write FVGridColor;//竖线颜色
    property VGridTransparent:integer read FVGridTransparent write FVGridTransparent;//竖线透明度
    property HGridVisible:boolean read FHGridVisible write FHGridVisible;//是否显示横线
    property HGridColor:TColor read FHGridColor write FHGridColor;//横线颜色
    property HGridTransparent:integer read FHGridTransparent write FHGridTransparent;//横线透明度
    property FixRowHeight:integer read FFixRowHeight write FFixRowHeight;//固定行高
    property ColCount:integer read FColCount write FColCount;//列数
    property EveryCol:integer read FEveryCol write FEveryCol;//每行
    property DisplayMiddleLine:boolean read FDisplayMiddleLine write FDisplayMiddleLine;//是否显示中线
    property MiddleLineColor:TColor read FMiddleLineColor write FMiddleLineColor;//中线颜色
    property MiddleLineTransparent:integer read FMiddleLineTransparent write FMiddleLineTransparent;//中线透明度
  end;

  {Y坐标轴}

  { TMyChartAxisY }               //重要！！！重要！！！重要！！！重要！！！

  TMyChartAxisY = class(TMyChartItemBase)
  private
    FFixedRowHeight: integer;
    FFont: TFont;
    FLabelFollowString: string;
    FLabelLeadString: string;
    FMaxValue: double;
    FMinValue: double;
    FSmartLabelDecCount: integer;
    FTickColor: TColor;
    FTickLength: integer;
    FTickTransparent: integer;
    FTickVisible: boolean;
    FUseSmartLabel: boolean;
    FVLineColor: TColor;
    FVLineTransparent: integer;
    FVLineVisible: boolean;
    function GetRowCount: integer;
    procedure SetFont(AValue: TFont);
  public
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;
    procedure PaintEx(ABaseLeft,ABaseTop:integer);override;
    property RowCount:integer read GetRowCount;//Y轴的行数
  published
    property Font:TFont read FFont write SetFont;
    property MinValue:double read FMinValue write FMinValue;
    property MaxValue:double read FMaxValue write FMaxValue;
    property FixedRowHeight:integer read FFixedRowHeight write FFixedRowHeight;//固定的Y轴行高
    property VLineVisible:boolean read FVLineVisible write FVLineVisible;
    property VLineColor:TColor read FVLineColor write FVLineColor;
    property VLineTransparent:integer read FVLineTransparent write FVLineTransparent;
    property TickVisible:boolean read FTickVisible write FTickVisible;
    property TickColor:TColor read FTickColor write FTickColor;
    property TickTransparent:integer read FTickTransparent write FTickTransparent;
    property TickLength:integer read FTickLength write FTickLength;
    property UseSmartLabel:boolean read FUseSmartLabel write FUseSmartLabel;
    property LabelDecCount:integer read FSmartLabelDecCount write FSmartLabelDecCount;
    property LabelLeadString:string read FLabelLeadString write FLabelLeadString;
    property LabelFollowString:string read FLabelFollowString write FLabelFollowString;
  end;

  {买卖盘量比显示元件}

  { TMyChartBidAsk }                //重要！！！重要！！！重要！！！重要！！！

  TMyChartBidAsk = class(TMyChartBox)
  private
    FBarHeight: integer;
    FBuyColor: TColor;
    FBuyTotal: integer;
    FLineHeight: integer;
    FSellColor: TColor;
    FSellTotal: integer;
    FShortNumber: boolean;
    FTitle: string;
    FTitleFontSize: integer;
  public
    constructor Create(AOwner:TComponent);override;
    procedure PaintEx(ABaseLeft,ABaseTop:integer);override;
  published
    property Title:string read FTitle write FTitle;
    property TitleFontSize:integer read FTitleFontSize write FTitleFontSize;//标题字体大小
    property BuyTotal:integer read FBuyTotal write FBuyTotal;//总买量
    property SellTotal:integer read FSellTotal write FSellTotal;//总卖量
    property BuyColor:TColor read FBuyColor write FBuyColor;//买颜色
    property SellColor:TColor read FSellColor write FSellColor;//卖颜色
    property LineHeight:integer read FLineHeight write FLineHeight;//行高
    property BarHeight:integer read FBarHeight write FBarHeight;//条高
    property ShortNumber:boolean read FShortNumber write FShortNumber;//是否使用短数字，即千为单位
  end;

  {十档行情报价元件}
                                       //重要！！！重要！！！重要！！！重要！！！
  { TMyChartPriceBoard }

  TMyChartPriceBoard = class(TMyChartBox)
  private
    FBuyCaption_1: string;
    FBuyCaption_10: string;
    FBuyCaption_2: string;
    FBuyCaption_3: string;
    FBuyCaption_4: string;
    FBuyCaption_5: string;
    FBuyCaption_6: string;
    FBuyCaption_7: string;
    FBuyCaption_8: string;
    FBuyCaption_9: string;
    FBuy_10Price: double;
    FBuy_10Qty: integer;
    FBuy_1Price: double;
    FBuy_1Qty: integer;
    FBuy_2Price: double;
    FBuy_2Qty: integer;
    FBuy_3Price: double;
    FBuy_3Qty: integer;
    FBuy_4Price: double;
    FBuy_4Qty: integer;
    FBuy_5Price: double;
    FBuy_5Qty: integer;
    FBuy_6Price: double;
    FBuy_6Qty: integer;
    FBuy_7Price: double;
    FBuy_7Qty: integer;
    FBuy_8Price: double;
    FBuy_8Qty: integer;
    FBuy_9Price: double;
    FBuy_9Qty: integer;
    FCaptionFontColor: TColor;
    FCaptionFontName: ShortString;
    FCaptionFontSize: integer;
    FColWidth_1: integer;
    FColWidth_2: integer;
    FColWidth_3: integer;
    FDownValueFontColor: TColor;
    FEqualValueFontColor: TColor;
    FGridColor: TColor;
    FGridTransparent: integer;
    FLastClose: double;
    FRowHeight: integer;
    FSaleCaption_1: string;
    FSaleCaption_10: string;
    FSaleCaption_2: string;
    FSaleCaption_3: string;
    FSaleCaption_4: string;
    FSaleCaption_5: string;
    FSaleCaption_6: string;
    FSaleCaption_7: string;
    FSaleCaption_8: string;
    FSaleCaption_9: string;
    FSale_10Price: double;
    FSale_10Qty: integer;
    FSale_1Price: double;
    FSale_1Qty: integer;
    FSale_2Price: double;
    FSale_2Qty: integer;
    FSale_3Price: double;
    FSale_3Qty: integer;
    FSale_4Price: double;
    FSale_4Qty: integer;
    FSale_5Price: double;
    FSale_5Qty: integer;
    FSale_6Price: double;
    FSale_6Qty: integer;
    FSale_7Price: double;
    FSale_7Qty: integer;
    FSale_8Price: double;
    FSale_8Qty: integer;
    FSale_9Price: double;
    FSale_9Qty: integer;
    FUpValueFontColor: TColor;
    FValueFontName: ShortString;
    FValueFontSize: integer;
    function GetBuyTotal: integer;      // 计算买卖总量，计算量比
    function GetSellTotal: integer;
  public
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;
    procedure PaintEx(ABaseLeft,ABaseTop:integer);override;
    property BuyTotal:integer read GetBuyTotal;
    property SellTotal:integer read GetSellTotal;
  published
    property BuyPrice_1:double read FBuy_1Price write FBuy_1Price;
    property BuyQty_1:integer read FBuy_1Qty write FBuy_1Qty;
    property BuyPrice_2:double read FBuy_2Price write FBuy_2Price;
    property BuyQty_2:integer read FBuy_2Qty write FBuy_2Qty;
    property BuyPrice_3:double read FBuy_3Price write FBuy_3Price;
    property BuyQty_3:integer read FBuy_3Qty write FBuy_3Qty;
    property BuyPrice_4:double read FBuy_4Price write FBuy_4Price;
    property BuyQty_4:integer read FBuy_4Qty write FBuy_4Qty;
    property BuyPrice_5:double read FBuy_5Price write FBuy_5Price;
    property BuyQty_5:integer read FBuy_5Qty write FBuy_5Qty;
    property BuyPrice_6:double read FBuy_6Price write FBuy_6Price;
    property BuyQty_6:integer read FBuy_6Qty write FBuy_6Qty;
    property BuyPrice_7:double read FBuy_7Price write FBuy_7Price;
    property BuyQty_7:integer read FBuy_7Qty write FBuy_7Qty;
    property BuyPrice_8:double read FBuy_8Price write FBuy_8Price;
    property BuyQty_8:integer read FBuy_8Qty write FBuy_8Qty;
    property BuyPrice_9:double read FBuy_9Price write FBuy_9Price;
    property BuyQty_9:integer read FBuy_9Qty write FBuy_9Qty;
    property BuyPrice_10:double read FBuy_10Price write FBuy_10Price;
    property BuyQty_10:integer read FBuy_10Qty write FBuy_10Qty;
    property SalePrice_1:double read FSale_1Price write FSale_1Price;
    property SaleQty_1:integer read FSale_1Qty write FSale_1Qty;
    property SalePrice_2:double read FSale_2Price write FSale_2Price;
    property SaleQty_2:integer read FSale_2Qty write FSale_2Qty;
    property SalePrice_3:double read FSale_3Price write FSale_3Price;
    property SaleQty_3:integer read FSale_3Qty write FSale_3Qty;
    property SalePrice_4:double read FSale_4Price write FSale_4Price;
    property SaleQty_4:integer read FSale_4Qty write FSale_4Qty;
    property SalePrice_5:double read FSale_5Price write FSale_5Price;
    property SaleQty_5:integer read FSale_5Qty write FSale_5Qty;
    property SalePrice_6:double read FSale_6Price write FSale_6Price;
    property SaleQty_6:integer read FSale_6Qty write FSale_6Qty;
    property SalePrice_7:double read FSale_7Price write FSale_7Price;
    property SaleQty_7:integer read FSale_7Qty write FSale_7Qty;
    property SalePrice_8:double read FSale_8Price write FSale_8Price;
    property SaleQty_8:integer read FSale_8Qty write FSale_8Qty;
    property SalePrice_9:double read FSale_9Price write FSale_9Price;
    property SaleQty_9:integer read FSale_9Qty write FSale_9Qty;
    property SalePrice_10:double read FSale_10Price write FSale_10Price;
    property SaleQty_10:integer read FSale_10Qty write FSale_10Qty;
    property LastClose:double read FLastClose write FLastClose;
    property BuyCaption_1:string read FBuyCaption_1 write FBuyCaption_1;
    property BuyCaption_2:string read FBuyCaption_2 write FBuyCaption_2;
    property BuyCaption_3:string read FBuyCaption_3 write FBuyCaption_3;
    property BuyCaption_4:string read FBuyCaption_4 write FBuyCaption_4;
    property BuyCaption_5:string read FBuyCaption_5 write FBuyCaption_5;
    property BuyCaption_6:string read FBuyCaption_6 write FBuyCaption_6;
    property BuyCaption_7:string read FBuyCaption_7 write FBuyCaption_7;
    property BuyCaption_8:string read FBuyCaption_8 write FBuyCaption_8;
    property BuyCaption_9:string read FBuyCaption_9 write FBuyCaption_9;
    property BuyCaption_10:string read FBuyCaption_10 write FBuyCaption_10;
    property SaleCaption_1:string read FSaleCaption_1 write FSaleCaption_1;
    property SaleCaption_2:string read FSaleCaption_2 write FSaleCaption_2;
    property SaleCaption_3:string read FSaleCaption_3 write FSaleCaption_3;
    property SaleCaption_4:string read FSaleCaption_4 write FSaleCaption_4;
    property SaleCaption_5:string read FSaleCaption_5 write FSaleCaption_5;
    property SaleCaption_6:string read FSaleCaption_6 write FSaleCaption_6;
    property SaleCaption_7:string read FSaleCaption_7 write FSaleCaption_7;
    property SaleCaption_8:string read FSaleCaption_8 write FSaleCaption_8;
    property SaleCaption_9:string read FSaleCaption_9 write FSaleCaption_9;
    property SaleCaption_10:string read FSaleCaption_10 write FSaleCaption_10;
    property ColWidth_1:integer read FColWidth_1 write FColWidth_1;
    property ColWidth_2:integer read FColWidth_2 write FColWidth_2;
    property ColWidth_3:integer read FColWidth_3 write FColWidth_3;
    property RowHeight:integer read FRowHeight write FRowHeight;
    property GridColor:TColor read FGridColor write FGridColor;
    property GridTransparent:integer read FGridTransparent write FGridTransparent;
    property CaptionFontName:ShortString read FCaptionFontName write FCaptionFontName;
    property CaptionFontSize:integer read FCaptionFontSize write FCaptionFontSize;
    property CaptionFontColor:TColor read FCaptionFontColor write FCaptionFontColor;
    property ValueFontName:ShortString read FValueFontName write FValueFontName;
    property ValueFontSize:integer read FValueFontSize write FValueFontSize;
    property UpValueFontColor:TColor read FUpValueFontColor write FUpValueFontColor;
    property DownValueFontColor:TColor read FDownValueFontColor write FDownValueFontColor;
    property EqualValueFontColor:TColor read FEqualValueFontColor write FEqualValueFontColor;
  end;

{  {持仓信息板块元件}

  { TMyChartPosition }

  TMyChartPosition = class(TMyChartBox)
  private
    FAmountCaption: string;
    FCost: double;
    FCostCaption: string;
    FCurrentPrice: double;
    FDownColor: TColor;
    FEarnCaption: string;
    FEarnRate: double;
    FEqualColor: TColor;
    FLineHeight: integer;
    FQty: integer;
    FQtyCaption: string;
    FSellFeeRate: double;
    FUpColor: TColor;
  public
    constructor Create(AOwner:TComponent);override;
    procedure PaintEx(ABaseLft,ABaseTop:integer);override;
  published
    property Qty:integer read FQty write FQty;//持仓数量
    property Cost:double read FCost write FCost;//持仓成本
    property CurrentPrice:double read FCurrentPrice write FCurrentPrice;//当前价格
    property UpColor:TColor read FUpColor write FUpColor;//盈利颜色
    property DownColor:TColor read FDownColor write FDownColor;//亏损颜色
    property EqualColor:TColor read FEqualColor write FEqualColor;//平本颜色
    property SellFeeRate:double read FSellFeeRate write FSellFeeRate;//卖出费率
    property QtyCaption:string read FQtyCaption write FQtyCaption;//持仓数量文本
    property CostCaption:string read FCostCaption write FCostCaption;//持仓成本文本
    property AmountCaption:string read FAmountCaption write FAmountCaption;//持仓市值文本
    property EarnCaption:string read FEarnCaption write FEarnCaption;//盈利比率文本
    property LimitEarnRate:double read FEarnRate write FEarnRate;//显示条形图时上下控制比率
    property LineHeight:integer read FLineHeight write FLineHeight;//行高
  end;
}

  {数据集对象整数类}

  { TMyChartDataInteger }

  TMyChartDataInteger = class(TComponent)
  private
    FList:TList;
    FPosition: integer;
    function GetCount: integer;
  public
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;
    procedure Clear;
    function  Append(AValue:integer):integer;//追加
    procedure Insert(AIndex:integer;AValue:integer);//插入
    function  Update(AIndex:integer;AValue:integer):boolean;//更新
    function  Item(AIndex:integer):Integer;//返回指定的值
    procedure SaveToStream(AStream:TStream);//保存到流
    procedure LoadFromStream(AStream:TStream);//从流中读取
    property Count:integer read GetCount;//数据项个数
    property Position:integer read FPosition write FPosition;//当前位置
  end;

  {数据集对象浮点数类}

  { TMyChartDataFloat }

  TMyChartDataFloat = class(TComponent)
  private
    FList:TList;
    FPosition: integer;
    function GetCount: integer;
  public
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;
    procedure Clear;
    function  Append(AValue:double):integer;//追加
    procedure Insert(AIndex:integer;AValue:double);//插入
    function  Update(AIndex:integer;AValue:double):boolean;//更新
    function  Item(AIndex:integer):double;//返回指定的值
    procedure SaveToStream(AStream:TStream);//保存到流
    procedure LoadFromStream(AStream:TStream);//从流中读取
    procedure AutoRange(AFromIndex,AEndIndex:integer;var AMax,AMin:double);//查找指定下标范围内的最大和最小值
    property Count:integer read GetCount;//数据项个数
    property Position:integer read FPosition write FPosition;//当前位置
  end;

  {X坐标轴}

  { TMyChartAxisX }                 //重要！！！重要！！！重要！！！重要！！！

  TMyChartAxisX = class(TMyChartItemBase)
  private
    FColCount: integer;
    FEveryCol: integer;
    FFont: TFont;
    FHLineColor: TColor;
    FHLineTransparent: integer;
    FHLineVisible: boolean;
    FIsDayTick: boolean;
    FLabelFollowString: string;
    FLabelLeadString: string;
    FSmartLabelDecCount: integer;
    FTickColor: TColor;
    FTickLength: integer;
    FTickTransparent: integer;
    FTickVisible: boolean;
    FUseSmartLabel: boolean;
    procedure SetFont(AValue: TFont);
  public
    Data:TMyChartDataInteger;
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;
    procedure InitMinuteTick;//初始化成分钟刻度
    procedure PaintEx(ABaseLeft,ABaseTop:integer);override;
  published
    property IsDayTick:boolean read FIsDayTick write FIsDayTick;//是否显示成日期刻度
    property ColCount:integer read FColCount write FColCount;
    property TickVisible:boolean read FTickVisible write FTickVisible;
    property TickColor:TColor read FTickColor write FTickColor;
    property TickTransparent:integer read FTickTransparent write FTickTransparent;
    property TickLength:integer read FTickLength write FTickLength;
    property HLineVisible:boolean read FHLineVisible write FHLineVisible;
    property HLineColor:TColor read FHLineColor write FHLineColor;
    property HLineTransparent:integer read FHLineTransparent write FHLineTransparent;
    property UseSmartLabel:boolean read FUseSmartLabel write FUseSmartLabel;
    property LabelDecCount:integer read FSmartLabelDecCount write FSmartLabelDecCount;
    property LabelLeadString:string read FLabelLeadString write FLabelLeadString;
    property LabelFollowString:string read FLabelFollowString write FLabelFollowString;
    property EveryCol:integer read FEveryCol write FEveryCol;
    property Font:TFont read FFont write SetFont;
  end;

  {线图序列}

  { TMyChartLine }
                                         //重要！！！重要！！！重要！！！重要！！！
  TMyChartLine = class(TMyChartItemBase)
  private
    FAutoRange: boolean;
    FColCount: integer;
    FDisplayCount: integer;
    FLineColor: TColor;
    FLineWidth: integer;
    FMaxValue: double;
    FMinValue: double;
  public
    Data:TMyChartDataFloat;
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;
    procedure PaintEx(ABaseLeft,ABaseTop:integer);override;
    procedure DoAutoRange;
  published
    property LineColor:TColor read FLineColor write FLineColor;//线条颜色
    property LineWidth:integer read FLineWidth write FLineWidth;//线条宽度
    property DisplayCount:integer read FDisplayCount write FDisplayCount;//显示的周期数
    property ColCount:integer read FColCount write FColCount;
    property AutoRange:boolean read FAutoRange write FAutoRange;//是否自动调整绘制Y最大最小值
    property MinValue:double read FMinValue write FMinValue;//绘制Y最小值
    property MaxValue:double read FMaxValue write FMaxValue;//绘制Y最大值
  end;

  {柱图序列}

  { TMyChartVolume }
                                     //重要！！！重要！！！重要！！！重要！！！
  TMyChartVolume = class(TMyChartItemBase)
  private
    FAutoRange: boolean;
    FBarColor: TColor;
    FColCount: integer;
    FDisplayCount: integer;
    FIsBar: boolean;
    FLineColor: TColor;
    FLineVisible: boolean;
    FLineWidth: integer;
    FMaxValue: double;
    FMinValue: double;
  public
    Data:TMyChartDataFloat;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure PaintEx(ABaseLeft,ABaseTop:integer);override;
    procedure DoAutoRange;
  published
    property IsBar:boolean read FIsBar write FIsBar;//是否显示成Bar状态，否则显示成填充区域
    property LineColor:TColor read FLineColor write FLineColor;//线条颜色
    property LineWidth:integer read FLineWidth write FLineWidth;//线条宽度
    property LineVisible:boolean read FLineVisible write FLineVisible;//是否显示边框线
    property BarColor:TColor read FBarColor write FBarColor;//填充颜色
    property DisplayCount:integer read FDisplayCount write FDisplayCount;//显示的周期数
    property ColCount:integer read FColCount write FColCount;
    property AutoRange:boolean read FAutoRange write FAutoRange;//是否自动调整绘制Y最大最小值
    property MinValue:double read FMinValue write FMinValue;//绘制Y最小值
    property MaxValue:double read FMaxValue write FMaxValue;//绘制Y最大值
  end;

implementation

{ TMyChartOHLCVBanner }

constructor TMyChartOHLCVBanner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAmountCaption:='成交量:';
  FAmountValue:=0;
  FVolumeCaption:='成交额:';
  FVolumeValue:=0;
end;

procedure TMyChartOHLCVBanner.PaintEx(ABaseLeft, ABaseTop:integer);
var
  mx,my:integer;
begin
  inherited PaintEx(ABaseLeft, ABaseTop);
  mx:=FLeft;
  my:=FTop;
  mx:=mx+FSpacing;  mx:=mX+FSpacing;  mx:=mx+FSpacing;  mx:=mx+FSpacing;  mx:=mx+FSpacing+5;
  //绘制成交量
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FCaptionFontColor;
  FBitmap.Canvas.TextOut(mx,my,FVolumeCaption);
  //绘制成交量数值
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FValueFontColor;
  FBitmap.Canvas.TextOut(mx+FBitmap.Canvas.TextWidth(FVolumeCaption)+5,my,intTostr(FVolumeValue));

  mx:=FLeft+2*FSpacing;
  my:=FTop+FBitmap.Canvas.TextHeight(FVolumeCaption)+5;

  mx:=mx+FSpacing;  mx:=mx+FSpacing;  mx:=mx+FSpacing+5;
  //绘制成交额文本
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FCaptionFontColor;
  FBitmap.Canvas.TextOut(mx,my,FAmountCaption);
  //绘制成交额数值
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FValueFontColor;
  FBitmap.Canvas.TextOut(mx+FBitmap.Canvas.TextWidth(FAmountCaption)+5,my,FormatFloat('#0.00',FAmountValue));
end;

{ TMyChartBidAsk 量比}

constructor TMyChartBidAsk.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBuyColor:=clRed;
  FBuyTotal:=50;
  FSellColor:=clLime;
  FSellTotal:=50;
  FTitle:='ASK/BID';
  FTitleFontSize:=10;
  FLineHeight:=25;
  FBarHeight:=10;
  FFont.Color:=clBlack;
end;

procedure TMyChartBidAsk.PaintEx(ABaseLeft, ABaseTop: integer);
var
  mx,my,mx1,my1,mx2,my2:integer;
  mValue:string;
  mRate:double;
begin
  inherited PaintEx(ABaseLeft, ABaseTop);
  my:=FTop;
  mx:=FLeft;
  //绘制标题
  DrawString(FBitmap,mx,my,Ftitle,FFont.Name,FFont.Color,FFont.Style,FTitleFontSize,True);
  //绘制两个方框
  if (FBuyTotal+FSellTotal)=0 then
    Exit;
  //绘制数字
  if FSellTotal<>0 then
  begin
    if FShortNumber then
    begin
      mRate:=FBuyTotal/FSellTotal;
      mValue:=FormatFloat('#0.00',FBuyTotal/1000)+'/'+FormatFloat('#0.00',FSellTotal/1000)+'K='+FormatFloat('#0.00',mRate);
    end
    else
    begin
      mRate:=FBuyTotal/FSellTotal;
      mValue:=inttostr(FBuyTotal)+'/'+inttostr(FSellTotal)+' = '+FormatFloat('#0.00',mRate);
    end;
    DrawString(FBitmap,mx+FWidth,my,mValue,FFont.Name,FFont.Color,FFont.Style,FTitleFontSize,False);
  end
  else
  begin
    mValue:=inttostr(FBuyTotal)+'/'+inttostr(FSellTotal);
    DrawString(FBitmap,mx+FWidth,my,mValue,FFont.Name,FFont.Color,FFont.Style,FTitleFontSize,False);
  end;
  //绘制条
  mRate:=FBuyTotal/(FBuyTotal+FSellTotal);
  my:=FTop+FLineHeight;
  mx1:=FLeft+Round(mRate*FWidth);
  my1:=my+FBarHeight;
  FBitmap.Canvas.Pen.Color:=FBuyColor;
  FBitmap.Canvas.Brush.Color:=FBuyColor;
  FBitmap.Canvas.FillRect(Rect(mx,my,mx1,my1));
  mx2:=FLeft+FWidth;
  my2:=my1;
  FBitmap.Canvas.Pen.Color:=FSellColor;
  FBitmap.Canvas.Brush.Color:=FSellColor;
  FBitmap.Canvas.FillRect(Rect(mx1,my,mx2,my2));
end;

{ TMyChartPriceBoard }

function TMyChartPriceBoard.GetBuyTotal: integer;
begin
  Result:=FBuy_1Qty+
          FBuy_2Qty+
          FBuy_3Qty+
          FBuy_4Qty+
          FBuy_5Qty+
          FBuy_6Qty+
          FBuy_7Qty+
          FBuy_8Qty+
          FBuy_9Qty+
          FBuy_10Qty;
end;

function TMyChartPriceBoard.GetSellTotal: integer;
begin
  Result:=FSale_1Qty+
          FSale_2Qty+
          FSale_3Qty+
          FSale_4Qty+
          FSale_5Qty+
          FSale_6Qty+
          FSale_7Qty+
          FSale_8Qty+
          FSale_9Qty+
          FSale_10Qty;
end;

constructor TMyChartPriceBoard.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBuyCaption_1:='买 1';;
  FBuyCaption_10:='买 10';
  FBuyCaption_2:='买 2';
  FBuyCaption_3:='买 3';
  FBuyCaption_4:='买 4';
  FBuyCaption_5:='买 5';
  FBuyCaption_6:='买 6';
  FBuyCaption_7:='买 7';
  FBuyCaption_8:='买 8';
  FBuyCaption_9:='买 9';
  FCaptionFontColor:=clBlack;
  FCaptionFontName:='微软雅黑';
  FCaptionFontSize:=10;
  FColWidth_1:=40;
  FColWidth_2:=80;
  FColWidth_3:=80;
  FDownValueFontColor:=clGreen;
  FEqualValueFontColor:=clBlack;
  FGridColor:=clGray;
  FGridTransparent:=0;
  FRowHeight:=20;
  FSaleCaption_1:='卖 1';
  FSaleCaption_10:='卖 10';
  FSaleCaption_2:='卖 2';
  FSaleCaption_3:='卖 3';
  FSaleCaption_4:='卖 4';
  FSaleCaption_5:='卖 5';
  FSaleCaption_6:='卖 6';
  FSaleCaption_7:='卖 7';
  FSaleCaption_8:='卖 8';
  FSaleCaption_9:='卖 9';
  FUpValueFontColor:=clRed;
  FValueFontName:='微软雅黑';
  FValueFontSize:=10;
end;

destructor TMyChartPriceBoard.Destroy;
begin
  inherited Destroy;
end;

procedure TMyChartPriceBoard.PaintEx(ABaseLeft, ABaseTop: integer);
var
  mLeft,mTop:integer;
  i,mY:integer;
  mValue,mValue2:string;
begin
  inherited PaintEx(ABaseLeft, ABaseTop);
  mLeft:=ABaseLeft;//+Left;
  mTop:=ABaseTop;//+Top;
  for i:=1 to 21 do
  begin
    mY:=mTop+RowHeight*(i-1);
    case i of
      1:
      begin
        DrawString(FBitmap,mLeft,mY,SaleCaption_10,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',SalePrice_10);
        mValue2:=FormatFloat('#0.',SaleQty_10);
        if SalePrice_10>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if SalePrice_10=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      2:
      begin
        DrawString(FBitmap,mLeft,mY,SaleCaption_9,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',SalePrice_9);
        mValue2:=FormatFloat('#0.',SaleQty_9);
        if SalePrice_9>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if SalePrice_9=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      3:
      begin
        DrawString(FBitmap,mLeft,mY,SaleCaption_8,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',SalePrice_8);
        mValue2:=FormatFloat('#0.',SaleQty_8);
        if SalePrice_8>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if SalePrice_8=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      4:
      begin
        DrawString(FBitmap,mLeft,mY,SaleCaption_7,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',SalePrice_7);
        mValue2:=FormatFloat('#0.',SaleQty_7);
        if SalePrice_7>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if SalePrice_7=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      5:
      begin
        DrawString(FBitmap,mLeft,mY,SaleCaption_6,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',SalePrice_6);
        mValue2:=FormatFloat('#0.',SaleQty_6);
        if SalePrice_6>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if SalePrice_6=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      6:
      begin
        DrawString(FBitmap,mLeft,mY,SaleCaption_5,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',SalePrice_5);
        mValue2:=FormatFloat('#0.',SaleQty_5);
        if SalePrice_5>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if SalePrice_5=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      7:
      begin
        DrawString(FBitmap,mLeft,mY,SaleCaption_4,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',SalePrice_4);
        mValue2:=FormatFloat('#0.',SaleQty_4);
        if SalePrice_4>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if SalePrice_4=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      8:
      begin
        DrawString(FBitmap,mLeft,mY,SaleCaption_3,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',SalePrice_3);
        mValue2:=FormatFloat('#0.',SaleQty_3);
        if SalePrice_3>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if SalePrice_3=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      9:
      begin
        DrawString(FBitmap,mLeft,mY,SaleCaption_2,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',SalePrice_2);
        mValue2:=FormatFloat('#0.',SaleQty_2);
        if SalePrice_2>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if SalePrice_2=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      10:
      begin
        DrawString(FBitmap,mLeft,mY,SaleCaption_1,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',SalePrice_1);
        mValue2:=FormatFloat('#0.',SaleQty_1);
        if SalePrice_1>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if SalePrice_1=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      11:
      begin
        FBitmap.LineS(mLeft,mY+Round(RowHeight/2),mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY+Round(RowHeight/2),SetAlpha(Color32(GridColor),GridTransparent),True);
      end;
      12:
      begin
        DrawString(FBitmap,mLeft,mY,BuyCaption_1,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',BuyPrice_1);
        mValue2:=FormatFloat('#0.',BuyQty_1);
        if BuyPrice_1>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if BuyPrice_1=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      13:
      begin
        DrawString(FBitmap,mLeft,mY,BuyCaption_2,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',BuyPrice_2);
        mValue2:=FormatFloat('#0.',BuyQty_2);
        if BuyPrice_2>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if BuyPrice_2=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      14:
      begin
        DrawString(FBitmap,mLeft,mY,BuyCaption_3,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',BuyPrice_3);
        mValue2:=FormatFloat('#0.',BuyQty_3);
        if BuyPrice_3>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if BuyPrice_3=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      15:
      begin
        DrawString(FBitmap,mLeft,mY,BuyCaption_4,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',BuyPrice_4);
        mValue2:=FormatFloat('#0.',BuyQty_4);
        if BuyPrice_4>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if BuyPrice_4=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      16:
      begin
        DrawString(FBitmap,mLeft,mY,BuyCaption_5,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',BuyPrice_5);
        mValue2:=FormatFloat('#0.',BuyQty_5);
        if BuyPrice_5>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if BuyPrice_5=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      17:
      begin
        DrawString(FBitmap,mLeft,mY,BuyCaption_6,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',BuyPrice_6);
        mValue2:=FormatFloat('#0.',BuyQty_6);
        if BuyPrice_6>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if BuyPrice_6=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      18:
      begin
        DrawString(FBitmap,mLeft,mY,BuyCaption_7,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',BuyPrice_7);
        mValue2:=FormatFloat('#0.',BuyQty_7);
        if BuyPrice_7>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if BuyPrice_7=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      19:
      begin
        DrawString(FBitmap,mLeft,mY,BuyCaption_8,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',BuyPrice_8);
        mValue2:=FormatFloat('#0.',BuyQty_8);
        if BuyPrice_8>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if BuyPrice_8=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      20:
      begin
        DrawString(FBitmap,mLeft,mY,BuyCaption_9,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',BuyPrice_9);
        mValue2:=FormatFloat('#0.',BuyQty_9);
        if BuyPrice_9>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if BuyPrice_9=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
      21:
      begin
        DrawString(FBitmap,mLeft,mY,BuyCaption_10,CaptionFontName,CaptionFontColor,FFont.Style,CaptionFontSize);
        mValue:=FormatFloat('#0.00',BuyPrice_10);
        mValue2:=FormatFloat('#0.',BuyQty_10);
        if BuyPrice_10>LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,UpValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        if BuyPrice_10=LastClose then
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,EqualValueFontColor,FFont.Style,ValueFontSize,False);
        end
        else
        begin
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2,mY,mValue,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
          DrawString(FBitmap,mLeft+ColWidth_1+ColWidth_2+ColWidth_3,mY,mValue2,ValueFontName,DownValueFontColor,FFont.Style,ValueFontSize,False);
        end;
      end;
    end;
  end;
end;


{ TMyChartOHLCBanner }

constructor TMyChartOHLCBanner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSpacing:=100;
  FCaptionFontColor:=clBlack;
  FValueFontColor:=clBlack;
  FCloseValueFontSize:=22;
  FNormalFontSize:=12;
  FFont.Color:=clBlack;
  FDecimalCount:=2;
  FDateString:='00:00:00';
  FOpenCaption:='今开:';
  FHighCaption:='最高:';
  FLowCaption:='最低:';
  FLastCloseCaption:='前收:';
  FIncreaseCaption:='涨跌:';
  FIncreaseRateCaption:='涨幅:';
end;

procedure TMyChartOHLCBanner.PaintEx(ABaseLeft, ABaseTop: integer);
var
  mx,my:integer;
begin
  {******************************************
  样式
  -------------------------------------------
  | 当前价 | 时间 | 今开 | 最高价 | 最低价 |
  | 大字   |      | 前收 | 涨跌   | 涨跌幅 |
  *******************************************}
  inherited PaintEx(ABaseLeft, ABaseTop);
  FBitmap.Font.Assign(FFont);
  //绘制当前价格文本
  mx:=FLeft;
  my:=FTop;
  FBitmap.Canvas.Brush.Color:=FBackgroundColor;//clBlack;
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FCaptionFontColor;
  FBitmap.Canvas.TextOut(mx,my,FCloseCaption);
  //绘制当前价格
  FBitmap.Canvas.Font.Size:=FCloseValueFontSize;
  FBitmap.Canvas.Font.Color:=FValueFontColor;
  FBitmap.Canvas.TextOut(mx+FBitmap.Canvas.TextWidth(FCloseCaption)+5,my,Floattostr(FCloseValue));
  mx:=mx+FSpacing;
  //绘制当前时间
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FCaptionFontColor;
  FBitmap.Canvas.TextOut(mx+(FSpacing div 4),my+(FBitmap.Canvas.TextHeight(FDateString)+5) div 2,FDateString);
  mx:=mX+FSpacing;
  //绘制今开文本
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FCaptionFontColor;
  FBitmap.Canvas.TextOut(mx,my,FOpenCaption);
  //绘制今开数值
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FValueFontColor;
  FBitmap.Canvas.TextOut(mx+FBitmap.Canvas.TextWidth(FOpenCaption)+5,my,FloatTostr(FOpenValue));
  mx:=mx+FSpacing;
  //绘制最高价文本
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FCaptionFontColor;
  FBitmap.Canvas.TextOut(mx,my,FHighCaption);
  //绘制最高价数值
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FValueFontColor;
  FBitmap.Canvas.TextOut(mx+FBitmap.Canvas.TextWidth(FHighCaption)+5,my,FloatTostr(FHighValue));
  mx:=mx+FSpacing;
  //绘制最低价文本
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FCaptionFontColor;
  FBitmap.Canvas.TextOut(mx,my,FLowCaption);
  //绘制最低价数值
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FValueFontColor;
  FBitmap.Canvas.TextOut(mx+FBitmap.Canvas.TextWidth(FLowCaption)+5,my,FloatTostr(FLowValue));
  mx:=mx+FSpacing;
  //绘制前收盘文本
  mx:=FLeft+2*FSpacing;
  my:=FTop+FBitmap.Canvas.TextHeight(FLastCloseCaption)+5;

  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FCaptionFontColor;
  FBitmap.Canvas.TextOut(mx,my,FLastCloseCaption);
  //绘制今开数值
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FValueFontColor;
  FBitmap.Canvas.TextOut(mx+FBitmap.Canvas.TextWidth(FLastCloseCaption)+5,my,FloatTostr(FLastCloseValue));
  mx:=mx+FSpacing;
  //绘制涨跌文本
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FCaptionFontColor;
  FBitmap.Canvas.TextOut(mx,my,FIncreaseCaption);
  //绘制涨跌数值
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  if IncreaseValue>0 then FBitmap.Canvas.Font.Color:=clRed
  else if IncreaseValue<0 then FBitmap.Canvas.Font.Color:=clGreen
  else FBitmap.Canvas.Font.Color:=FValueFontColor;
  FBitmap.Canvas.TextOut(mx+FBitmap.Canvas.TextWidth(FIncreaseCaption)+5,my,Format('%0.'+inttostr(FDecimalCount)+'f',[FIncreaseValue]));
  mx:=mx+FSpacing;
  //绘制涨跌幅文本
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  FBitmap.Canvas.Font.Color:=FCaptionFontColor;
  FBitmap.Canvas.TextOut(mx,my,FIncreaseRateCaption);
  //绘制涨跌幅数值
  FBitmap.Canvas.Font.Size:=FNormalFontSize;
  if IncreaseRateValue>0 then FBitmap.Canvas.Font.Color:=clRed
  else if IncreaseRateValue<0 then FBitmap.Canvas.Font.Color:=clGreen
  else FBitmap.Canvas.Font.Color:=FValueFontColor;
  FBitmap.Canvas.TextOut(mx+FBitmap.Canvas.TextWidth(FIncreaseRateCaption)+5,my,Format('%0.'+inttostr(FDecimalCount)+'f',[FIncreaseRateValue])+'%');
  mx:=mx+FSpacing;
end;

{ TMyChartVolume }

constructor TMyChartVolume.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Data:=TmyChartDataFloat.Create(Self);
  FIsBar:=True;
  FLineColor:=clWhite;
  FLineWidth:=1;
  FLineVisible:=True;
  FBarColor:=clWhite;
end;

destructor TMyChartVolume.Destroy;
begin
  Data.Clear;
  Data.Free;
  inherited Destroy;
end;

procedure TMyChartVolume.PaintEx(ABaseLeft, ABaseTop: integer);
var
  mLeft,mTop:integer;
  mMinValue,mMaxValue:Extended;
  mYStep:Extended;
  mXStep:double;
  mValue:Extended;
  i:integer;
  mX,mY:integer;
  mPenColor,mBrushColor:TColor;
  mSize:integer;
  mHeight:integer;
  mX1,mX2,mY1,mY2:integer;
  mPoints:TArrayOfFloatPoint;
  mT:double;
begin
  inherited PaintEx(ABaseLeft, ABaseTop);
  mLeft:=ABaseLeft;
  mTop:=ABaseTop;
  if AutoRange then
  begin
    //自动调整绘制时Y的最大和最小
    Data.AutoRange(0,Self.DisplayCount-1,mMaxValue,mMinValue);
    MinValue:=mMinValue;
    MaxValue:=mMaxValue;
  end
  else
  begin
    mMinValue:=MinValue;
    mMaxValue:=MaxValue;
  end;
  if (mMaxValue-mMinValue)<=0 then
    exit
  else
    mYStep:=Height/(mMaxValue-mMinValue);
  if ColCount=0 then
    exit
  else
    mXStep:=Width/(ColCount+1);
  if not FIsBar then
    SetLength(mPoints,FDisplayCount+1);
  mPenColor:=Color32(FLineColor);
  mBrushColor:=Color32(FBarColor);
  for i:=0 to FDisplayCount-1 do
  begin
    mValue:=Data.Item(i);
    mX:=mLeft+Round(mXStep*(i))+Round(mXStep/2);
    mY:=mTop+Height;

    mSize:=Round(mXStep);
    mHeight:=Round(mYStep*(mValue-mMinValue));
    mX1:=mX-Trunc(mSize/2);
    mY1:=mY-mHeight;
    mX2:=mX+Trunc(mSize/2);
    mY2:=mY;
    if FIsBar then
    begin
      //画柱图
      if FLineWidth=1 then
      begin
        FBitmap.FillRectS(mX1,mY1,mX2,mY2,mBrushColor);
        if FLineVisible then
        begin
          FBitmap.LineS(mX1,mY1,mX2,mY1,mPenColor,True);
          FBitmap.LineS(mX2,mY1,mX2,mY2,mPenColor,True);
          FBitmap.LineS(mX2,mY2,mX1,mY2,mPenColor,True);
          FBitmap.LineS(mX1,mY1,mX1,mY2,mPenColor,True);
        end;
      end
      else
      begin
        //Polyline方式绘制
        SetLength(mPoints,4);
        mPoints[0].X:=mX1; mPoints[0].Y:=mY1;
        mPoints[1].X:=mX1; mPoints[1].Y:=mY2;
        mPoints[2].X:=mX2; mPoints[2].Y:=mY2;
        mPoints[3].X:=mX2; mPoints[3].Y:=mY1;
        PolygonFS(FBitmap,mPoints,mBrushColor);
      end;
    end
    else
    begin
      //画区域图
      mPoints[i].X:=mX;
      mPoints[i].Y:=mY1;
    end;
  end;
  if not FIsBar then
  begin
    mPoints[0].Y:=FTop+FHeight;
    mPoints[0].X:=mPoints[1].X;
    mPoints[Length(mPoints)-1].Y:=FTop+FHeight;
    mPoints[Length(mPoints)-1].X:=mPoints[Length(mPoints)-2].X;
    PolygonFS(FBitmap,mPoints,mBrushColor);
  end;
end;

procedure TMyChartVolume.DoAutoRange;
var
  mMaxValue,mMinValue:double;
begin
  //自动调整绘制时Y的最大和最小
  Data.AutoRange(0,Self.DisplayCount-1,mMaxValue,mMinValue);
  MinValue:=mMinValue;
  MaxValue:=mMaxValue;
end;


{ TMyChartLine }

constructor TMyChartLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Data:=TMyChartDataFloat.Create(Self);
  FLineColor:=clBlack;
  FLineWidth:=1;
end;

destructor TMyChartLine.Destroy;
begin
  Data.Free;
  inherited Destroy;
end;

procedure TMyChartLine.PaintEx(ABaseLeft, ABaseTop: integer);
var
  mColor:TColor32;
  mLeft,mTop:integer;
  mMinValue,mMaxValue:double;
  mYStep:double;
  mXStep:double;
  i:integer;
  mValue:double;
  mOldX,mOldY,mX,mY:integer;
  mCount:integer;
  mPoints:TArrayOfFloatPoint;
begin
  inherited PaintEx(ABaseLeft, ABaseTop);
  mLeft:=ABaseLeft;
  mTop:=ABaseTop;
  mColor:=Color32(Self.LineColor);
  if DisplayCount>Data.Count then
    mCount:=Data.Count
  else
    mCount:=DisplayCount;
  if AutoRange then
  begin
    //自动调整绘制时Y的最大和最小
    Data.AutoRange(0,mCount-1,mMaxValue,mMinValue);
    MinValue:=mMinValue;
    MaxValue:=mMaxValue;
  end
  else
  begin
    mMinValue:=MinValue;
    mMaxValue:=MaxValue;
  end;
  if mMaxValue-mMinValue<=0 then
    exit
  else
    mYStep:=Height/(mMaxValue-mMinValue);
  if ColCount=0 then
    exit
  else
    mXStep:=Width/(ColCount+1);
  if DisplayCount>Data.Count then
    mCount:=Data.Count
  else
    mCount:=DisplayCount;
  FBitmap.Canvas.Pen.Color:=FLineColor;
  FBitmap.Canvas.Pen.Width:=FLineWidth;
  if FLineWidth>1 then
    SetLength(mPoints,mCount);
  for i:=0 to mCount-1 do
  begin
    mValue:=Data.Item(i);
    mX:=mLeft+Round(mXStep*(i-0))+Round(mXStep/2);
    mY:=mTop+Height-Round(mYStep*(mValue-mMinValue));
    if FLineWidth>1 then
    begin
      mPoints[i].X:=mX;
      mPoints[i].Y:=mY;
    end
    else
    begin
      if i=0 then
      begin
        FBitmap.Canvas.Pen.Color:=FLineColor;
        FBitmap.Canvas.Brush.Color:=FLineColor;//FBitmap.Canvas.Pen.Color;
        FBitmap.Canvas.Rectangle(mX-2,mY-2,mX+2,mY+2);
        FBitmap.Canvas.MoveTo(mX,mY);
      end
      else
      begin
//        FBitmap.Canvas.Line(mOldX,mOldY,mX,mY);
        FBitmap.Canvas.Pen.Color:=FLineColor;
        FBitmap.LineS(mOldX,mOldY,mX,mY,mColor,True)
      end;
      mOldX:=mX;
      mOldY:=mY;
    end;
  end;
  if FLineWidth>1 then
    PolylineFS(Fbitmap,mPoints,mColor,False,FLineWidth);
end;

procedure TMyChartLine.DoAutoRange;
var
  mMaxValue,mMinValue:double;
begin
  //自动调整绘制时Y的最大和最小
  Data.AutoRange(0,Self.DisplayCount-1,mMaxValue,mMinValue);
  MinValue:=mMinValue;
  MaxValue:=mMaxValue;
end;

{ TMyChartDataFloat }

function TMyChartDataFloat.GetCount: integer;
begin
  Result:=FList.Count;
end;

constructor TMyChartDataFloat.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList:=TList.Create;
end;

destructor TMyChartDataFloat.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TMyChartDataFloat.Clear;
var
  i:integer;
begin
  for i:=0 to FList.Count-1 do
  begin
    Dispose(PFloat(FList.Items[i]));
  end;
  FList.Clear;
end;

function TMyChartDataFloat.Append(AValue: double): integer;
var
  p:PFloat;
begin
  new(p);
  p^:=AValue;
  Result:=FList.Add(p);
end;

procedure TMyChartDataFloat.Insert(AIndex: integer; AValue: double);
var
  p:PFloat;
begin
  new(p);
  p^:=AValue;
  FList.Insert(AIndex,p);
end;

function TMyChartDataFloat.Update(AIndex: integer; AValue: double): boolean;
begin
  //try
    PFloat(FList.Items[AIndex])^:=AValue;
    Result:=True;
  //except
  //  Result:=False;
  //end;
end;

function TMyChartDataFloat.Item(AIndex: integer): double;
begin
  Result:=PFloat(FList.Items[AIndex])^;
end;

procedure TMyChartDataFloat.SaveToStream(AStream: TStream);
var
  i:integer;
  mCount:int32;
  m:double;
begin
  mCount:=FList.Count;
  AStream.Write(mCount,sizeof(mCount));
  for i:=0 to FList.Count-1 do
  begin
    m:=Item(i);
    AStream.Write(m,sizeof(m));
  end;
end;

procedure TMyChartDataFloat.LoadFromStream(AStream: TStream);
var
  mCount:int32;
  m:double;
  i:integer;
begin
  Clear;
  AStream.Read(mCount,sizeof(mCount));
  for i:=0 to mCount-1 do
  begin
    AStream.Read(m,sizeof(m));
    Self.Append(m);
  end;
end;

procedure TMyChartDataFloat.AutoRange(AFromIndex, AEndIndex: integer; var AMax,
  AMin: double);
var
  m,mMax,mMin:double;
  i:integer;
begin
  if AEndIndex<AFromIndex then
     Exit;
  if AEndIndex>=FList.Count then
     Exit;
  for i:=AFromIndex to AEndIndex do
  begin
    m:=Item(i);
    if i=AFromIndex then
    begin
      mMax:=m;
      mMin:=m;
    end
    else
    begin
      if m>mMax then mMax:=m;
      if m<mMin then mMin:=m;
    end;
  end;
  AMax:=mMax;
  AMin:=mMin;
end;

{ TMyChartAxisX }

procedure TMyChartAxisX.SetFont(AValue: TFont);
begin
  FFont.Assign(AValue);
end;

constructor TMyChartAxisX.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Data:=TMyChartDataInteger.Create(Self);
  FFont:=TFont.Create;
  FFont.Size:=10;
  FFont.Color:=clBlack;
  FTickVisible:=True;
  FTickLength:=5;
  FTickColor:=clBlack;
  FEveryCol:=30;
end;

destructor TMyChartAxisX.Destroy;
begin
  FFont.Free;
  Data.Free;
  inherited Destroy;
end;

procedure TMyChartAxisX.InitMinuteTick;
var
  mStart,mEnd,mTmp:TTime;
  mCount:integer;
  i:integer;
begin
  Data.Clear;
  //初始化FDATA为分钟线刻度
  mStart:=EncodeTime(9,30,0,0);
  mEnd:=EncodeTime(15,01,0,0);
  mCount:=MinutesBetween(mEnd,mStart);
  for i:=0 to mCount-1 do
  begin
    mTmp:=IncMinute(mStart,i);
    if (mTmp>=EncodeTime(11,30,0,0)) and (mTmp<=EncodeTime(13,0,0,0)) then
      continue
    else
    begin
      Data.Append(strtoint(FormatDatetime('hhmm',mTmp)));
    end;
  end;
end;

procedure TMyChartAxisX.PaintEx(ABaseLeft, ABaseTop: integer);
var
  mColor:TColor32;
  mLeft,mTop:integer;
  mStep:double;
  i,mX:integer;
  mLabel:string;
  mValue:integer;
begin
  inherited PaintEx(ABaseLeft, ABaseTop);
  FColCount:=Data.Count;
  mLeft:=ABaseLeft;
  mTop:=ABaseTop;
  if Self.HLineVisible then
  begin
    mColor:=SetAlpha(Color32(Self.HLineColor),Self.HLineTransparent);
    FBitmap.LineS(mLeft,mTop,mLeft+Width,mTop,mColor,True);
  end;
  mStep:=Width/(ColCount+1);
  for i:=0 to ColCount-1 do
  begin
    if EveryCol=0 then
      EveryCol:=1;
    if i mod EveryCol<>0 then
      continue;
    mX:=mLeft+Round(mStep*i)+Round(mStep/2);
    if Self.TickVisible then
    begin
      mColor:=SetAlpha(Color32(Self.TickColor),Self.TickTransparent);
      FBitmap.LineS(mX,mTop+1,mX,mTop+Self.TickLength,mColor,True);
    end;
    if Self.HLineVisible then
    begin
      mColor:=SetAlpha(Color32(Self.HLineColor),Self.HLineTransparent);
      FBitmap.LineS(mX,mTop,mX,mTop-Self.Height,mColor,True);
    end;
    mValue:=Data.Item(i);
    if FIsDayTick then
      mLabel:=FormatFloat('#0.00',mValue/100)//日期刻度
    else
      mLabel:=FormatFloat('#0:00',mValue);//分钟刻度

    FBitmap.Font.Assign(FFont);
    mX:=mX-Round(FBitmap.TextWidth(mLabel)/2);
    FBitmap.Textout(mX,mTop+TickLength+1,mLabel);
  end;
end;

{ TMyChartDataBase }

function TMyChartDataInteger.GetCount: integer;
begin
  Result:=FList.Count;
end;

constructor TMyChartDataInteger.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList:=TList.Create;
end;

destructor TMyChartDataInteger.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TMyChartDataInteger.Clear;
var
  i:integer;
begin
  for i:=0 to FList.Count-1 do
  begin
    Dispose(Pinteger(FList.Items[i]));
  end;
  FList.Clear;
end;

function TMyChartDataInteger.Append(AValue: integer): integer;
var
  p:PInteger;
begin
  new(p);
  p^:=AValue;
  Result:=FList.Add(p);
end;

procedure TMyChartDataInteger.Insert(AIndex: integer; AValue: integer);
var
  p:PInteger;
begin
  new(p);
  p^:=AValue;
  FList.Insert(AIndex,p);
end;

function TMyChartDataInteger.Update(AIndex: integer; AValue: integer): boolean;
begin
  try
    PInteger(FList.Items[AIndex])^:=AValue;
    Result:=True;
  except
    Result:=False;
  end;
end;

function TMyChartDataInteger.Item(AIndex: integer): Integer;
begin
  Result:=PInteger(FList.Items[AIndex])^;
end;

procedure TMyChartDataInteger.SaveToStream(AStream: TStream);
var
  i:integer;
  mCount,mValue:int32;
begin
  mCount:=FList.Count;
  AStream.Write(mCount,sizeof(mCount));
  for i:=0 to FList.Count-1 do
  begin
    mValue:=Item(i);
    AStream.Write(mValue,sizeof(mValue));
  end;
end;

procedure TMyChartDataInteger.LoadFromStream(AStream: TStream);
var
  i:integer;
  mCount,mValue:int32;
begin
  Clear;
  AStream.Read(mCount,sizeof(mCount));
  for i:=0 to mCount-1 do
  begin
    AStream.Read(mValue,sizeof(mValue));
    Append(mValue);
  end;
end;

{ TMyChartLable }

procedure TMyChartLabel.SetFont(AValue: TFont);
begin
  FFont.Assign(AValue);
end;

constructor TMyChartLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFont:=TFont.Create;
end;

destructor TMyChartLabel.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

procedure TMyChartLabel.PaintEx(ABaseLeft, ABaseTop: integer);
begin
  if Trim(FCaption)='' then
    Exit;
  inherited PaintEx(ABaseLeft, ABaseTop);
  FBitmap.Font.Assign(FFont);
  FBitmap.Textout(FLeft,FTop,FCaption);
  FWidth:=FBitmap.TextWidth(FCaption);
  FHeight:=FBitmap.TextHeight(FCaption);
end;

{ TMyChartAxisY }

function TMyChartAxisY.GetRowCount: integer;
begin
  //计算RowCount行数
  if (Height mod FixedRowHeight)>0 then
    result:=Height div FixedRowHeight + 1
  else
    result:=Height div FixedRowHeight;
end;

procedure TMyChartAxisY.SetFont(AValue: TFont);
begin
  FFont.Assign(AValue);
end;

constructor TMyChartAxisY.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFixedRowHeight:=10;
  FLabelFollowString:='';
  FLabelLeadString:='';
  FMaxValue:=100;
  FMinValue:=0;
  FSmartLabelDecCount:=2;
  FTickColor:=clBlack;
  FTickLength:=5;
  FTickTransparent:=128;
  FTickVisible:=True;
  FUseSmartLabel:=True;
  FVLineColor:=clBlack;
  FVLineVisible:=True;
  FFont:=TFont.Create;
  FFont.Size:=10;
  FFont.Color:=clBlack;
  FFixedRowHeight:=33;
end;

destructor TMyChartAxisY.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

procedure TMyChartAxisY.PaintEx(ABaseLeft, ABaseTop: integer);
var
  mColor:TColor32;
  mRowCount,mLeft,mTop:integer;
  i,mY:integer;
  mStep:double;
  mLabel:string;
  mValueStep:Extended;
begin
  inherited PaintEx(ABaseLeft, ABaseTop);
  mRowCount:=RowCount;
  mLeft:=ABaseLeft;
  mTop:=ABaseTop;
  if Self.VLineVisible then
  begin
    mColor:=SetAlpha(Color32(VLineColor),VLineTransparent);
    FBitmap.LineS(mLeft,mTop,mLeft,mTop+Height,mColor,True);
  end;
  if mRowCount>=2 then
  begin
    mStep:=Height/mRowCount;
    mColor:=SetAlpha(Color32(TickColor),TickTransparent);
    mValueStep:=(MaxValue-MinValue)/mRowCount;
    for i:=0 to mRowCount do
    begin
      mY:=round(mTop+Height-mStep*i);
      if TickVisible then
        FBitmap.LineS(mLeft+1,mY,mLeft+FtickLength,mY,mColor,True);
      if UseSmartLabel then
        mLabel:=SmartLabel(MinValue+i*mValueStep,LabelDecCount)
      else
        mLabel:=FormatFloat(GetFormatStr(LabelDecCount),MinValue+i*mValueStep);
      mLabel:=LabelLeadString+mLabel+LabelFollowString;
      FBitmap.Font.Assign(FFont);
      mY:=mY-Round(FBitmap.TextHeight(mLabel)/2);
      if TickVisible then
        FBitmap.Textout(mLeft+FTickLength+1,mY,mLabel)
      else
        FBitmap.Textout(mLeft+1,mY,mLabel);
    end;
  end;
end;

{ TMyChartGrid }

function TMyChartGrid.GetRowCount: integer;
begin
  //计算RowCount行数
  if (Height mod FixRowHeight)>0 then
    Result:=Height div FixRowHeight + 1
  else
    Result:=Height div FixRowHeight;
end;

constructor TMyChartGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FColCount:=8;
  FDisplayMiddleLine:=False;
  FEveryCol:=1;
  FFixRowHeight:=10;
  FHGridColor:=clGray;
  FHGridTransparent:=128;
  FHGridVisible:=True;
  FMiddleLineColor:=clGray;
  FMiddleLineTransparent:=128;
  FVGridColor:=clGray;
  FVGridTransparent:=128;
  FVGridVisible:=True;
end;

procedure TMyChartGrid.PaintEx(ABaseLeft, ABaseTop: integer);
var
  mColor:TColor32;
  mLeft,mTop:integer;
  i:integer;
  mRowCount:integer;
  mX,mY:integer;
  mStep:double;
begin
  if not Visible then Exit;
  inherited PaintEx(ABaseLeft, ABaseTop);
  mLeft:=ABaseLeft;
  mTop:=ABaseTop;
  if Self.HGridVisible then
  begin
    mColor:=SetAlpha(Color32(Self.HGridColor),Self.HGridTransparent);
    mRowCount:=RowCount;
    mStep:=Height/mRowCount;
    for i:=0 to mRowCount do
    begin
      mY:=round(mTop+Height-mStep*i);
      FBitmap.LineS(mLeft,mY,mLeft+Width,mY,mColor,True);
    end;
  end;
  if Self.VGridVisible then
  begin
    mColor:=SetAlpha(Color32(Self.VGridColor),Self.VGridTransparent);
    mStep:=Width/(ColCount+1);
    for i:=0 to ColCount do
    begin
      if EveryCol=0 then
        EveryCol:=1;
      if (i mod EveryCol<>0) and (i<>0) then
        Continue;
      mX:=mLeft+Round(i*mStep)+Round(mStep/2);
      FBitmap.LineS(mX,mTop,mX,mTop+Height,mColor,True);
    end;
  end;
  if Self.DisplayMiddleLine then
  begin
    mColor:=SetAlpha(Color32(Self.MiddleLineColor),Self.MiddleLineTransparent);
    mY:=mTop+Round(Height/2);
    FBitmap.LineS(mLeft,mY,mLeft+Width,mY,mColor,True);
  end;
end;

{ TMyChartBox }

procedure TMyChartBox.SetFont(AValue: TFont);
begin
  FFont.Assign(AValue);
end;

constructor TMyChartBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBorderVisible:=False;
  FBorderWidth:=1;
  FBorderColor:=clWhite;
  FFont:=TFont.Create;
end;

destructor TMyChartBox.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

procedure TMyChartBox.PaintEx(ABaseLeft, ABaseTop: integer);
var
  mx,my:integer;
begin
  inherited PaintEx(ABaseLeft, ABaseTop);
  //绘制边框
  if FBorderVisible then
  begin
    FBitmap.Canvas.Pen.Color:=FBorderColor;
    FBitmap.Canvas.Pen.Width:=FBorderWidth;
    FBitmap.Canvas.Line(FLeft,FTop,FLeft+FWidth,FTop);
    FBitmap.Canvas.LineTo(FLeft+FWidth,FTop+FHeight);
    FBitmap.Canvas.LineTo(FLeft,FTop+FHeight);
    FBitmap.Canvas.LineTo(FLeft,FTop);
  end;
  //绘制文字
  if Trim(FCaption)<>'' then
  begin
    FBitmap.Font.Assign(FFont);
    mx:=(FWidth - FBitmap.TextWidth(FCaption)) div 2;
    my:=(FHeight - FBitmap.TextHeight(FCaption)) div 2;
    FBitmap.Textout(FLeft+mx,FTop+my,Trim(FCaption));
  end;
end;

{ TMyChartBase }

procedure TMyChartItemBase.DrawBackground;
var
  mx,my:integer;
begin
  if not FTransparent then
  begin
    //需要绘制背景色
    if FGradient then
    begin
      //绘制渐变背景色
      if not FVerticalGradient then
      begin
        //水平渐变
        MyGradientAreaH(FFromColor,FEndColor,FBitmap,FTop,FLeft,FHeight,FWidth,FGradientSteps);
      end
      else
      begin
        //垂直渐变
        MyGradientArea(FFromColor,FEndColor,FBitmap,FTop,FLeft,FHeight,FWidth,FGradientSteps);
      end;
    end
    else
    begin
      //绘制单色背景
      if FFromColor<>clBlack then
        FBitmap.FillRectS(Rect(FLeft,FTop,FLeft+FWidth,FTop+FHeight),Color32(FFromColor));
    end;
    if Assigned(FBackground.Graphic) then
    begin
      //绘制背景图片
      if FBackgroundStretch then
      begin
        //拉伸绘制
        FBitmap.Canvas.StretchDraw(Rect(FLeft,FTop,FLeft+FWidth,FTop+FHeight),FBackground.Graphic);
      end
      else
      begin
        //不拉伸
        if FBackgroundCenter then
        begin
          //居中
          my:=(FHeight-FBackground.Graphic.Height) div 2;
          mx:=(FWidth-FBackground.Graphic.Width) div 2;
          FBitmap.Canvas.Draw(FLeft+mx,FTop+my,FBackground.Graphic);
        end
        else
        begin
          //不居中
          FBitmap.Canvas.Draw(FLeft+FBackgroundLeft,FTop+FBackgroundTop,FBackground.Graphic);
        end;
      end;
    end;
  end;
end;

constructor TMyChartItemBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGradient:=False;
  FVerticalGradient:=True;
  FFromColor:=clWhite;
  FEndColor:=clBlue;
  FVisible:=True;
  FTransparent:=True;
  FBackgroundCenter:=True;
  FGradientSteps:=100;
  FBackground:=TPicture.Create;
end;

destructor TMyChartItemBase.Destroy;
begin
  FBackground.Free;
  inherited Destroy;
end;

procedure TMyChartItemBase.Paint;
begin
  if FVisible then
  begin
    PaintEx(FLeft,FTop);
  end;
end;

procedure TMyChartItemBase.PaintEx(ABaseLeft, ABaseTop: integer);
begin
  //绘制背景
  DrawBackground;
end;

end.


