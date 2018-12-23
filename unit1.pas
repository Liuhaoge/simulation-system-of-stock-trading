unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, BCButton, SpkToolbar, spkt_Tab, spkt_Pane,
  spkt_Buttons, GR32_Image, TplGradientUnit, TplColorPanelUnit, Dateutils,
  TplCheckListBoxUnit, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  ActnList, StdCtrls, GR32,Myclass,myclasses2,myclasses3,myclasses__paint;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    HeaderControl1: THeaderControl;
    HeaderControl3: THeaderControl;
    Image1: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    ImageList1: TImageList;
    box: TPaintBox32;
    ListView1: TListView;
    Panel1: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    plGradient1: TplGradient;
    plGradient2: TplGradient;
    SpkLargeButton1: TSpkLargeButton;
    SpkLargeButton2: TSpkLargeButton;
    SpkLargeButton3: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkTab1: TSpkTab;
    StaticText1: TStaticText;
    Timer1: TTimer;
    procedure boxResize(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image12Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public
    Word1,Word2,Word3:TMyChartLabel;
    OHLCV:TMyChartOHLCVBanner;
    Grid,Grid_K:TMyChartGrid;
    BidAsk:TMyChartBidAsk;
    mX,mX_K:TMyChartAxisX;
    mY,mY_K,mYCol:TMyChartAxisY;
    PriceBoard:TMyChartPriceBoard;
    Line,Line_K_1,Line_K_3,Line_K_5:TMyChartLine;
    Colume:TMyChartVolume;          ColumeJudge:boolean;
    K_Array:array[0..50] of double;

    procedure ShowStockInfo;
    procedure IntoHistory;
//    procedure MakeDeal;
  end;

var
  Form1: TForm1;

implementation
uses
  unit2,unit3,Unit4,Unit5,unit6,Unit7,Unit8,Unit9,datamodule;
{$R *.frm}

{ TForm1 }
procedure TForm1.FormCreate(Sender: TObject);     //初始化各个变量
begin                                                //将每只股票都有的静态信息设定
  box.Buffer.Clear(Color32(clWhite));
  word1:=TMyChartLabel.Create(Self);           //股票名称和代码
  word1.Bitmap:=box.Buffer;
  word1.Font.Size:=24;   word1.Font.Color:=clBlack;   word1.Top:=15;   word1.Left:=15;

  OHLCV:=TMyChartOHLCVBanner.Create(Self);
  OHLCV.Bitmap:=box.Buffer;              //行情: 今开今收涨跌涨幅成交
  OHLCV.Top:=18;  OHLCV.Left:=380;  OHLCV.Width:=250;  OHLCV.Height:=420;
  OHLCV.BackgroundColor:=clWhite;

  Grid:=TMyChartGrid.Create(Self);     Grid_K:=TMyChartGrid.Create(Self);
  Grid_K.Bitmap:=box.Buffer;           // K线的网格和底板
  Grid_K.Top:=75;   Grid_K.Left:=15;   Grid_K.Width:=700;   Grid_K.Height:=150;
  Grid_K.Transparent:=False;   Grid_K.Gradient:=True;     Grid_K.EndColor:=$00FE7B78;

  Grid.Bitmap:=box.Buffer;           // 分时线和柱图的网格和底板
  Grid.Top:=253;   Grid.Left:=15;   Grid.Width:=700;   Grid.Height:=300;
  Grid.Transparent:=False;   Grid.Gradient:=True;   Grid.FromColor:=$00E5E5E5;

  BidAsk:=TMyChartBidAsk.Create(Self);      //量比&盘口
  BidASk.Bitmap:=box.Buffer;          // 量比
  BidASk.Top:=85;   BidAsk.Left:=785;   BidAsk.Width:=210;   BidAsk.Height:=420;

  PriceBoard:=TMyChartPriceBoard.Create(self);
  PriceBoard.Bitmap:=Box.Buffer;         // 盘口
  PriceBoard.Top:=135;   PriceBoard.Left:=790;   PriceBoard.Width:=120;   PriceBoard.Height:=420;

  mX_K:=TMyChartAxisX.Create(self);      mY_K:=TMyChartAxisY.Create(self);
        mX_K.Bitmap:=box.Buffer;           // K线的X轴
        mX_K.Top:=225;   mX_K.Left:=3;  mX_K.Width:=767;
        mX_K.IsDayTick:=true;
        mX_K.EveryCol:=2;
    //    mX_K.Data.Append(102);   mX_K.Data.Append(103);   mX_K.Data.Append(106);   mX_K.Data.Append(107);   mX_K.Data.Append(108);   mX_K.Data.Append(109);   mX_K.Data.Append(110);   mX_K.Data.Append(113);   mX_K.Data.Append(114);   mX_K.Data.Append(115);
        mX_K.Data.Append(116);   mX_K.Data.Append(117);   mX_K.Data.Append(120);   mX_K.Data.Append(121);   mX_K.Data.Append(122);   mX_K.Data.Append(123);   mX_K.Data.Append(124);   mX_K.Data.Append(127);   mX_K.Data.Append(128);   mX_K.Data.Append(129);
        mX_K.Data.Append(130);   mX_K.Data.Append(207);   mX_K.Data.Append(220);   mX_K.Data.Append(221);   mX_K.Data.Append(224);   mX_K.Data.Append(225);   mX_K.Data.Append(226);   mX_K.Data.Append(227);   mX_K.Data.Append(228);   mX_K.Data.Append(303);
        mX_K.Data.Append(304);   mX_K.Data.Append(305);   mX_K.Data.Append(306);   mX_K.Data.Append(307);   mX_K.Data.Append(310);   mX_K.Data.Append(311);   mX_K.Data.Append(312);   mX_K.Data.Append(313);   mX_K.Data.Append(314);   mX_K.Data.Append(317);   mX_K.Data.Append(318);   mX_K.Data.Append(319);   mX_K.Data.Append(320);   mX_K.Data.Append(321);
        mX_K.ColCount:=34;
        mY_K.Bitmap:=box.Buffer;
        mY_K.Top:=75;   mY_K.Left:=715;   mY_K.Height:=150;

  Line_K_1:=TMyChartLine.Create(self);
        Line_K_1.Bitmap:=Box.Buffer;    //1日K线
        Line_K_1.Top:=75;  Line_K_1.Left:=5;  Line_K_1.Width:=700;  Line_K_1.Height:=150;
        Line_K_1.LineWidth:=3;      Line_K_1.LineColor:=$0048493F;
        Line_K_1.AutoRange:=True;
        Line_K_1.ColCount:=34;      Line_K_1.DisplayCount:=34;
  Line_K_3:=TMyChartLine.Create(self);
        Line_K_3.Bitmap:=Box.Buffer;    //3日K线
        Line_K_3.Top:=75;  Line_K_3.Left:=5;  Line_K_3.Width:=700;  Line_K_3.Height:=150;
        Line_K_3.LineWidth:=3;      Line_K_3.LineColor:=$0062952F;
        Line_K_3.AutoRange:=True;
        Line_K_3.ColCount:=34;      Line_K_3.DisplayCount:=34;
  Line_K_5:=TMyChartLine.Create(self);
        Line_K_5.Bitmap:=Box.Buffer;    //5日K线
        Line_K_5.Top:=75;  Line_K_5.Left:=5;  Line_K_5.Width:=700;  Line_K_5.Height:=150;
        Line_K_5.LineWidth:=3;      Line_K_5.LineColor:=$0048AEA7;
        Line_K_5.AutoRange:=True;
        Line_K_5.ColCount:=34;      Line_K_5.DisplayCount:=34;

  mX:=TMyChartAxisX.Create(self);      mY:=TMyChartAxisY.Create(self);    mYCol:=TMyChartAxisY.Create(self);
        mX.Bitmap:=box.Buffer;           // 分时线和柱图的X轴
        mX.Top:=553;   mX.Left:=53;  mX.Width:=627;
        mX.InitMinuteTick;

        mY.Bitmap:=box.Buffer;          // 分时线的Y轴
        mY.Top:=253;   mY.Left:=715;   mY.Height:=200;

        mYCol.Bitmap:=box.Buffer;          // 柱图的Y轴
        mYCol.Top:=470;   mYCol.Left:=715;   mYCol.Height:=85;

  Line:=TMyChartLine.Create(self);
        Line.Bitmap:=Box.Buffer;    //分时线
        Line.Top:=253;  Line.Left:=15;  Line.Width:=700;  Line.Height:=200;
        Line.AutoRange:=True;
        Line.ColCount:=5119;      Line.DisplayCount:=640;

  Colume:=TMyChartVolume.Create(Self);
        Colume.Bitmap:=Box.Buffer;    // 柱图
        Colume.Top:=468;  Colume.Left:=15;  Colume.Width:=700;  Colume.Height:=85;
        Colume.AutoRange:=True;
        Colume.ColCount:=5119;      Colume.DisplayCount:=640;
        ColumeJudge:=False;
end;

procedure TForm1.ShowStockInfo;  //画出该股票的行情信息，只负责画图   （完成）
begin
  box.Buffer.Clear(Color32(clWhite));

  word1.PaintEx(word1.Left,word1.Top);

  OHLCV.PaintEx(OHLCV.Left,OHLCV.Top);

  Grid_K.PaintEx(Grid_K.Left,Grid_K.Top);

  mX_K.PaintEx(mX_K.Left,mX_K.Top);

  mY_K.PaintEx(mY_K.Left,mY_K.Top);

  Line_K_1.PaintEx(Line_K_1.Left,Line_K_1.Top);
  Line_K_3.PaintEx(Line_K_3.Left,Line_K_3.Top);
  Line_K_5.PaintEx(Line_K_5.Left,Line_K_5.Top);

  Grid.PaintEx(Grid.Left,Grid.Top);

  mX.PaintEx(mX.Left,mX.Top);

  mY.PaintEx(mY.Left,mY.Top);

  Line.PaintEx(Line.Left,Line.Top);

  mYCol.PaintEx(mYCol.Left,mYCol.Top);

  Colume.PaintEx(Colume.Left,Colume.Top);

  BidAsk.PaintEx(BidAsk.Left,BidAsk.Top);

  PriceBoard.PaintEx(PriceBoard.Left,PriceBoard.Top);

  box.Invalidate;
end;

procedure TForm1.Image3Click(Sender: TObject);       //股票列表按钮（完成） +++++++++++++++++++++++++++++++++
  // 用对象stocklist将股票列表导下来，将stocklist每一条item赋值给m，
  // 再用m填写到listview的每一条上
var
  i:integer;
  AStockItem:TmyStockItem;
begin
  // 赋值至listview
  listview1.Clear;
  for i:=0 to stocklist.count-1 do
  begin
    AStockItem:=stocklist.Item(i);
    with listview1.Items.Add do
    begin
      Caption:=AStockItem.code;     //将分解的信息赋给Listview
      subitems.add(AStockItem.caption);
      subitems.add(AStockItem.Market);
    end;
  end;
end;

procedure TForm1.ListView1DblClick(Sender: TObject);  //双击列表上股票, 显示单支股票行情信息
{  循环找到选中的股票，后执行：
    1. 所有x、y轴、K线的绘制，分时线、柱线的初始化
    2. OHLCV、盘口，动态数据的文件LoadFromFile
    3. showStockInfo绘制界面
    4. Timer=true                 }
var
  i,j,k:integer;
  ASnapItem,AnOtherSnapItem:TL2SnapItem;
  CloseTmp,VolumeTmp:double;
  mKlist:TFileStream;
begin
try
  for i:=0 to listview1.items.count-1 do
  begin
    if listview1.items.item[i].selected then
    begin
      //股代码&行情
      word1.Caption:=listview1.items.item[i].caption+'  '+listview1.items.item[i].SubItems.Strings[0];

      snap_Paint.LoadFromFile('HistoryData\'+inttostr(system_date)+'\'+inttostr(system_Date)+'\'+
                                                    listview1.items.item[i].caption+'.snap');
      Dw_Paint.LoadFromFile('HistoryData\'+inttostr(system_date)+'\'+inttostr(system_Date)+'\'+
                                                    listview1.items.item[i].caption+'.dw');

      //三条K线
      Line_K_1.Data.Clear;    Line_K_3.Data.Clear;    Line_K_5.Data.Clear;
      mKlist:=TFileStream.Create('HistoryData\K'+'\'+listview1.items.item[i].caption+'.snap',fmOpenRead);
      for j:=0 to 33 do
      begin
        mKlist.Seek(j*sizeof(CloseTmp),soBeginning);
        mKlist.read(CloseTmp,sizeof(CloseTmp));

        K_Array[j]:=CloseTmp;
        if K_Array[j]=0 then K_Array[j]:= K_Array[j-1];
      end;
      mKlist.Free;

      for j:=0 to 33 do //  现在的数据太少，画出来的线太棱次分明，之后可在3.21后再加数据，用同样方式处理
      begin
        Line_K_1.Data.Append(K_Array[j]);
        if j>=2 then Line_K_3.Data.Append((K_Array[j]+K_Array[j-1]+K_Array[j-2])/3) else Line_K_3.Data.Append(K_Array[j]);
        if j>=4 then Line_K_5.Data.Append((K_Array[j]+K_Array[j-1]+K_Array[j-2]+K_Array[j-3]+K_Array[j-4])/5) else Line_K_5.Data.Append(K_Array[j]);
      end;

      // K线的Y轴
      Line_K_1.DoAutoRange;
      mY_K.MinValue:=Line_K_1.Minvalue;   mY_K.MaxValue:=Line_K_1.Maxvalue;

      Line.Data.Clear;        // 分时线
      for j:=0 to snap_Paint.Count-1 do
      begin
        ASnapItem:=snap_Paint.Item(j)^;
        CloseTmp:=ASnapItem.Close;
        if CloseTmp=0 then CloseTmp:=AsnapItem.last_close;
        Line.Data.Append(CloseTmp);
      end;

      Line.DoAutoRange;     // 分时线的Y轴
      mY.MinValue:=Line.Minvalue;   mY.MaxValue:=Line.Maxvalue;

      Colume.Data.Clear;    VolumeTmp:=0;    //柱图
      for j:=0 to snap_Paint.Count-1 do          //trunc((snap_Paint.Count)/10) do
      begin
        ASnapItem:=snap_Paint.Item(j)^;
        if j>=1 then
        begin
          AnOtherSnapItem:=snap_Paint.Item(j-1)^;
          VolumeTmp:=ASnapItem.volume-AnOtherSnapItem.volume ;
        end
        else VolumeTmp:=ASnapItem.volume;

    //    if VolumeTmp>=500000 then VolumeTmp:=VolumeTmp+5500000;

        Colume.Data.Append(VolumeTmp);
      end;

      Colume.DoAutoRange;   //柱图的Y轴            if j mod 10 =0 then
      mYCol.MinValue:=0;   mYCol.MaxValue:=Colume.Maxvalue;
    end;
  end;
  // 3.
  ShowStockInfo;      //显示静态信息
  // 4.
  timer1.Enabled:=true;    //触动每秒刷新数据开关

except
  showmessage('暂无此股指数');
end;

end;


procedure TForm1.Edit1EditingDone(Sender: TObject);//输入名称或代码查询股票，显示单支股票行情信息 （完成）
var                                             // 1. 检索stocklist，找到后将该股selected、Focused
  i:integer;                                    // 2. 执行 DblClick 事件
  AStockItem:TmyStockItem;
  chooseOne:boolean;  //标识是否有查到股票
begin
  // 股票列表load
  chooseOne:=False;

  if Edit1.text<>'' then
  begin
    for i:=0 to stocklist.Count-1 do
    begin
      AStockItem:=StockList.Item(i);       //若有匹配
      if (Edit1.text=AStockItem.Code) or (Edit1.text=AStockItem.Caption) then
      begin
        Listview1.Items.Item[i].Selected:=true;
        Listview1.Items.Item[i].Focused:=true;//选中匹配项
        chooseOne:=True;
        listview1.SetFocus;
        break;
      end;
    end;
    if chooseOne=true then
    begin
      ListView1DblClick(self);   // 2.
      Edit1.clear;
    end
    else showmessage('No Such Stock.');
  end;
end;

procedure TForm1.boxResize(Sender: TObject);   // 调整窗口大小重新画图========================
begin
  box.Buffer.Clear(Color32(clWhite));

  if Listview1.Selected<>nil then
     ShowStockInfo;
end;

//-------------------------------------作为主页面的其他功能-------------------------------------------
procedure TForm1.Timer1Timer(Sender: TObject);   // 每秒更新数据，刷新股票信息===============
var
  Hour, Minute, Second, MilliSecond: word;
  AHour, AMinute, ASecond, OneTime: integer;
  ASnap:TL2SnapItem;
  ADw:TL2SnapDWItem;
  i:integer;
  AnOrder:TOrderItem;
  Orig_PropertyItem:TPropertyItem;    //卖订单时找到相应的资产Item
  PropertyItem:TPropertyItem;
begin
  Self.OHLCV.DateString:=Formatdatetime('hh:mm:ss',ATime);
  ATime:=IncSecond(ATime,5);
  DecodeTime(ATime,hour,minute,Second,MilliSecond);
  Ahour:=integer(Hour);  AMinute:=integer(Minute);  ASecond:=integer(Second);
  System_Time:= (ASecond+AMinute*100+Ahour*10000);
{  在Unit1的作用：
   (1) 时间、日期、价格、行情、盘口都读入新的一行。 柱、线的display+1。
   (2) ShowStockInfo     }
  ASnap:= snap_Paint.Item(snap_Paint.CalcFrameIndex(system_time))^;
  ADw:= Dw_Paint.Item(Dw_Paint.CalcFrameIndex(system_time))^;
  {******************************************
  样式
  -------------------------------------------
  | 今收价 | 时间 | 今开 | 最高价 | 最低价 |
  |        |      | 前收 | 涨跌   | 涨跌幅 |
  *******************************************}
  OHLCV.CloseValue:=ASnap.close;
  OHLCV.HighValue:=ASnap.High;      OHLCV.LowValue:=ASnap.Low;
  OHLCV.OpenValue:=ASnap.Open;      OHLCV.LastCloseValue:=ASnap.Last_close;
  OHLCV.VolumeValue:=ASnap.volume;           OHLCV.AmountValue:=ASnap.Amount/100;
  OHLCV.IncreaseValue:=Asnap.close-Asnap.Last_close;           OHLCV.IncreaseRateValue:=(OHLCV.IncreaseValue/Asnap.close)*100;

  PriceBoard.LastClose:= Asnap.Last_close;
  PriceBoard.SalePrice_1:=Adw.sell_1;    PriceBoard.SalePrice_2:=Adw.sell_2;    PriceBoard.SalePrice_3:=Adw.sell_3;    PriceBoard.SalePrice_4:=Adw.sell_4;    PriceBoard.SalePrice_5:=Adw.sell_5;    PriceBoard.SalePrice_6:=Adw.sell_6;    PriceBoard.SalePrice_7:=Adw.sell_7;    PriceBoard.SalePrice_8:=Adw.sell_8;    PriceBoard.SalePrice_9:=Adw.sell_9;    PriceBoard.SalePrice_10:=Adw.sell_10;
  PriceBoard.SaleQty_1:=Adw.sell_1_vol;    PriceBoard.SaleQty_2:=Adw.sell_2_vol;    PriceBoard.SaleQty_3:=Adw.sell_3_vol;    PriceBoard.SaleQty_4:=Adw.sell_4_vol;    PriceBoard.SaleQty_5:=Adw.sell_5_vol;    PriceBoard.SaleQty_6:=Adw.sell_6_vol;    PriceBoard.SaleQty_7:=Adw.sell_7_vol;    PriceBoard.SaleQty_8:=Adw.sell_8_vol;    PriceBoard.SaleQty_9:=Adw.sell_9_vol;    PriceBoard.SaleQty_10:=Adw.sell_10_vol;
  PriceBoard.BuyPrice_1:=Adw.Buy_1;    PriceBoard.BuyPrice_2:=Adw.Buy_2;    PriceBoard.BuyPrice_3:=Adw.Buy_3;    PriceBoard.BuyPrice_4:=Adw.Buy_4;    PriceBoard.BuyPrice_5:=Adw.Buy_5;    PriceBoard.BuyPrice_6:=Adw.Buy_6;    PriceBoard.BuyPrice_7:=Adw.Buy_7;    PriceBoard.BuyPrice_8:=Adw.Buy_8;    PriceBoard.BuyPrice_9:=Adw.Buy_9;    PriceBoard.BuyPrice_10:=Adw.Buy_10;
  PriceBoard.BuyQty_1:=Adw.Buy_1_vol;    PriceBoard.BuyQty_2:=Adw.Buy_2_vol;    PriceBoard.BuyQty_3:=Adw.Buy_3_vol;    PriceBoard.BuyQty_4:=Adw.Buy_4_vol;    PriceBoard.BuyQty_5:=Adw.Buy_5_vol;    PriceBoard.BuyQty_6:=Adw.Buy_6_vol;    PriceBoard.BuyQty_7:=Adw.Buy_7_vol;    PriceBoard.BuyQty_8:=Adw.Buy_8_vol;    PriceBoard.BuyQty_9:=Adw.Buy_9_vol;    PriceBoard.BuyQty_10:=Adw.Buy_10_vol;

  BidAsk.BuyTotal := PriceBoard.BuyTotal;     BidAsk.SellTotal := PriceBoard.SellTotal;

  Line.DisplayCount:=Line.DisplayCount+7;      //分时线一秒加十条数据
//  ColumeJudge:= Not ColumeJudge;   if ColumeJudge=true then
  Colume.DisplayCount:=Colume.DisplayCount+7;       //柱图一秒加十条数据

  showStockInfo;

{在Unit4的作用：
  (1)currentlist中的每一条状态为false的Order进行循环：DownLoad股代码的文件、根据系统时间找到当前买一卖一价，进行比较
  (2)符合交易条件即刻进行交易,修改订单状态，加入持仓股票   }

  for i:=0 to CurrentList.Count-1 do
  begin
    AnOrder:=CurrentList.Item(i);
    if AnOrder.status=false then
    begin

      Dw_Order_Current.LoadFromFile('HistoryData\'+inttostr(system_date)+'\'+inttostr(system_Date)+'\'+
                                                      AnOrder.Code+'.dw');
      ADw:= Dw_Order_Current.Item(Dw_Order_Current.CalcFrameIndex(system_time))^;

      // 1. 买订单 大于等于卖一价，照卖一价成交
      if (AnOrder.Direct=true) and (AnOrder.Orig_price>=Adw.sell_1 ) then
      begin
        // (1) 修改该订单状态为已成交，设定成交价和成交时间
        AnOrder.status:= true;  AnOrder.Deal_Price:=Adw.sell_1;  AnOrder.Date:=system_date;
        AnOrder.Amount:=AnOrder.Deal_Price*AnOrder.quantity;
        CurrentList.Delete(i);   CurrentList.Add(AnOrder);
        // (2) 将该订单变为资产Item，add进入propertylist
        PropertyItem.Market:=AnOrder.Market;           PropertyItem.code:=AnOrder.code;
        PropertyItem.StockName:=AnOrder.StockName;     PropertyItem.quantity:=AnOrder.quantity;
        PropertyItem.cost:=AnOrder.Deal_price;         PropertyItem.price:=AnOrder.Deal_price;
        PropertyItem.profit:=0;                        PropertyItem.profitRatio:=0;
        propertyList.Add(propertyItem);
        // (3) 根据购买该持仓股的钱，修改Cash.Available
        Cash.Available:=Cash.Available-AnOrder.Deal_price * AnOrder.Quantity
      end;

      // 2. 卖订单 小于等于买一价，照买一价成交
      if (AnOrder.Direct=false) and (AnOrder.Orig_price<=Adw.Buy_1 ) then
      begin
        // (1) 修改该订单状态为已成交，设定成交价和成交时间
        AnOrder.status:= true;  AnOrder.Deal_Price:=Adw.Buy_1;  AnOrder.Date:=system_date;
        AnOrder.Amount:=AnOrder.Deal_Price*AnOrder.quantity;
        CurrentList.Delete(i);   CurrentList.Add(AnOrder);        // 修改该订单状态为已成交     status:= true
        // (2) 修改资产，减少订单对应PropertyItem的数目，如果数目等于零，则delete该股
        Orig_PropertyItem:=PropertyList.Item(PropertyList.IndexOf(AnOrder.Code,AnOrder.Market));
        if AnOrder.Quantity=Orig_PropertyItem.quantity then
        begin
          PropertyList.delete(PropertyList.IndexOf(AnOrder.Code,AnOrder.Market));
        end
        else
        begin
          PropertyItem.Market:=Orig_PropertyItem.Market;           PropertyItem.code:=Orig_PropertyItem.code;
          PropertyItem.StockName:=Orig_PropertyItem.StockName;     PropertyItem.quantity:=(Orig_PropertyItem.quantity-AnOrder.quantity);
          PropertyItem.cost:=Orig_PropertyItem.cost;               PropertyItem.price:=Orig_PropertyItem.cost;
          PropertyItem.profit:=0;                                  PropertyItem.profitRatio:=0;
          propertyList.UpDate(PropertyList.IndexOf(AnOrder.Code,AnOrder.Market),PropertyItem);
        end;
        // (3) 根据购买该持仓股的钱，修改Cash.Available
        Cash.Available:=Cash.Available+AnOrder.Deal_price * AnOrder.Quantity;
      end;    end;
  end;
end;

{procedure TForm1.MakeDeal();        // 订单成交
var
  i:integer;
  AnOrder:TOrderItem;
  Orig_PropertyItem:TPropertyItem;    //卖订单时找到相应的资产Item
  PropertyItem:TPropertyItem;
  ADw:TL2SnapDWItem;
begin                            // 发生时间: 未成交订单的价格与该股票盘口相匹配
 {  点击停止按钮把全部订单成交  }
  for i:=0 to CurrentList.Count-1 do
  begin
    AnOrder:=CurrentList.Item(i);
    Dw_Order_Current.LoadFromFile('HistoryData\'+inttostr(system_date)+'\'+inttostr(system_Date)+'\'+
                                                    AnOrder.Code+'.dw');
    ADw:= Dw_Order_Current.Item(Dw_Order_Current.CalcFrameIndex(system_time))^;
    // 1. 买订单 大于等于卖一价，照卖一价成交
    if (AnOrder.Direct=true) then
    begin
      // (1) 修改该订单状态为已成交，设定成交价和成交时间
      AnOrder.status:= true;  AnOrder.Deal_Price:=Adw.sell_1;  AnOrder.Date:=system_date;
      AnOrder.Amount:=AnOrder.Deal_Price*AnOrder.quantity;
      CurrentList.Delete(i);   CurrentList.Add(AnOrder);
      // (2) 将该订单变为资产Item，add进入propertylist
      PropertyItem.Market:=AnOrder.Market;           PropertyItem.code:=AnOrder.code;
      PropertyItem.StockName:=AnOrder.StockName;     PropertyItem.quantity:=AnOrder.quantity;
      PropertyItem.cost:=AnOrder.Deal_price;         PropertyItem.price:=AnOrder.Deal_price;
      PropertyItem.profit:=0;                        PropertyItem.profitRatio:=0;
      propertyList.Add(propertyItem);
      // (3) 根据购买该持仓股的钱，修改Cash.Available
      Cash.Available:=Cash.Available-AnOrder.Deal_price * AnOrder.Quantity
    end;

    // 2. 卖订单 小于等于买一价，照买一价成交
    if (AnOrder.Direct=false) then
    begin
      // (1) 修改该订单状态为已成交，设定成交价和成交时间
      AnOrder.status:= true;  AnOrder.Deal_Price:=Adw.Buy_1;  AnOrder.Date:=system_date;
      CurrentList.Delete(i);   CurrentList.Add(AnOrder);        // 修改该订单状态为已成交     status:= true
      AnOrder.Amount:=AnOrder.Deal_Price*AnOrder.quantity;
      // (2) 修改资产，减少订单对应PropertyItem的数目，如果数目等于零，则delete该股
      Orig_PropertyItem:=PropertyList.Item(PropertyList.IndexOf(AnOrder.Code,AnOrder.Market));
      if AnOrder.Quantity=Orig_PropertyItem.quantity then
      begin
        PropertyList.delete(PropertyList.IndexOf(AnOrder.Code,AnOrder.Market));
      end
      else
      begin
        PropertyItem.Market:=Orig_PropertyItem.Market;           PropertyItem.code:=Orig_PropertyItem.code;
        PropertyItem.StockName:=Orig_PropertyItem.StockName;     PropertyItem.quantity:=(Orig_PropertyItem.quantity-AnOrder.quantity);
        PropertyItem.cost:=Orig_PropertyItem.cost;               PropertyItem.price:=Orig_PropertyItem.cost;
        PropertyItem.profit:=0;                                  PropertyItem.profitRatio:=0;

        propertyList.UpDate(PropertyList.IndexOf(AnOrder.Code,AnOrder.Market),PropertyItem);
      end;

      // (3) 根据购买该持仓股的钱，修改Cash.Available
      Cash.Available:=Cash.Available+AnOrder.Deal_price * AnOrder.Quantity;
    end;
  end;
end;   }

procedure TForm1.IntoHistory;        // 将已交易的订单add入历史订单，再将所有订单清除
var                                  // 此函数发生时间，日期更换
  i:integer;
  AnOrder:TOrderItem;
begin
  for i:=0 to CurrentList.Count-1 do
  begin
    AnOrder:=CurrentList.Item(i);
    if AnOrder.status=true then      //判断是否成交,成交订单复制进历史订单
    begin
      HistoryList.add(AnOrder);
    end;
  end;
  currentList.clear;                // 当日订单清零
end;


//+++++++++++++++++++++++++++++++++打开其他的窗口+++++++++++++++++++++++++++++++++++++++++++

procedure TForm1.Image11Click(Sender: TObject);     //开始 按钮
begin
  timer1.Enabled:=true;    //触动每秒刷新数据开关

//[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[试验区域: 下单功能初始化]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]
{  Currentlist.Clear;
  HistoryList.clear;
  propertylist.Clear;
  Cash.Available:=200000;   }
end;

procedure TForm1.Image12Click(Sender: TObject);     //停止 按钮
begin
  timer1.Enabled:=false;    //触动每秒刷新数据开关

//【【【【【【【【【【【【【【【【【【【【【【测试】】】】】】】】】】】】】】】】】】】】

{  MakeDeal;     }
end;

procedure TForm1.Image4Click(Sender: TObject);       //用户资产 按钮
begin
  Form5:=TForm5.Create(Application);
  Form5.show;
end;

procedure TForm1.Image5Click(Sender: TObject);        //订单队列 按钮
begin
  Form4:=TForm4.Create(Application);
  Form4.show;
end;

procedure TForm1.Image6Click(Sender: TObject);         //人工交易
begin
  Form3:=TForm3.Create(Application);
  Form3.show;
end;

procedure TForm1.Image7Click(Sender: TObject);          //算法交易
begin
  Form6:=TForm6.Create(Application);
  Form6.show;
end;

procedure TForm1.Image8Click(Sender: TObject);          //智能选股
begin
  Form7:=TForm7.Create(Application);
  Form7.show;
end;

procedure TForm1.Image9Click(Sender: TObject);          //策略管理
begin
  Form8:=TForm8.Create(Application);
  Form8.show;
end;

procedure TForm1.Image10Click(Sender: TObject);     //交易评估
begin
//   Currentlist.Clear;
  Form9:=TForm9.Create(Application);
  Form9.show;
end;

end.

