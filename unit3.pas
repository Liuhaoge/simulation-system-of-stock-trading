unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, BCButton, BGRACustomDrawn, GR32_Image,
  TplGradientUnit, TplImageButtonUnit, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Spin, CustomDrawnControls, ComCtrls, GR32,
  Myclass, myclasses2, myclasses3,myclasses__paint;
                      //人工交易     //人工交易
type                  //人工交易               //人工交易
                      //人工交易                         //人工交易
  { TForm3 }          //人工交易                                   //人工交易

  TForm3 = class(TForm)
    BCButton1: TBCButton;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    FloatSpinEdit1: TFloatSpinEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    box: TPaintBox32;
    Panel1: TPanel;
    Panel2: TPanel;
    plGradient1: TplGradient;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SpinEdit1: TSpinEdit;
    procedure BCButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure FloatSpinEdit1EditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinEdit1EditingDone(Sender: TObject);
  private

  public
    BidAsk:TMyChartBidAsk;
    PriceBoard:TMyChartPriceBoard;
    procedure ShowDwInfo;
  end;

var
  Form3: TForm3;
  AvailableNumber:integer;      // 可交易的股票数量， 买的时候根据价格和现金，
implementation                  //                    卖的时候根据持仓股票的数量
uses
  unit4, datamodule;
{$R *.frm}

{ TForm3 }


procedure TForm3.FormCreate(Sender: TObject);
begin
  BidAsk:=TMyChartBidAsk.Create(Self);
  PriceBoard:=TMyChartPriceBoard.Create(self);
end;

procedure TForm3.ShowDwInfo;    // 画出股票信息
begin
  box.Buffer.Clear(Color32(clWhite));

  BidASk.Bitmap:=box.Buffer;          // 量比
  BidASk.Top:=0;   BidAsk.Left:=15;   BidAsk.Width:=210;   BidAsk.Height:=420;
  BidAsk.PaintEx(BidAsk.Left,BidAsk.Top);

  PriceBoard.Bitmap:=Box.Buffer;         // 盘口
  PriceBoard.Top:=BidASk.Top+35;   PriceBoard.Left:=BidAsk.Left+5;   PriceBoard.Width:=120;   PriceBoard.Height:=250;
  PriceBoard.PaintEx(PriceBoard.Left,PriceBoard.Top);

  box.Invalidate;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  box.Buffer.Clear(Color32(clWhite));
end;

procedure TForm3.Edit1EditingDone(Sender: TObject);  // 输入股代码，显示股名称
var
  Aindex:integer;
  AMarket:string[2];
  Acode:string[6];
  AStockItem:TMyStockItem;
//  ASnap:TL2SnapItem;
  ADw:TL2SnapDWItem;
begin
  if (ComboBox1.text<>'') and (Edit1.text<>'') then
  begin
    if ComboBox1.text='深市' then AMarket:='sz' else AMarket:='sh';
    Acode:=Edit1.text;
    AIndex:=StockList.Indexof(ACode,AMarket);     //根据market和code检索到股票条目
    if Aindex <> -1 then
    begin
      AStockItem:=StockList.Item(AIndex);
      label9.Caption:=AStockItem.Caption;        //显示股票名称

      Dw_Order_Paint.LoadFromFile('HistoryData\'+inttostr(system_date)+'\'+inttostr(system_Date)+'\'+Edit1.text+'.dw');

      ADw:=Dw_Order_Paint.Item(Dw_Paint.CalcFrameIndex(system_time))^;

      PriceBoard.LastClose:= Adw.sell_2;
      PriceBoard.SalePrice_1:=Adw.sell_1;    PriceBoard.SalePrice_2:=Adw.sell_2;    PriceBoard.SalePrice_3:=Adw.sell_3;    PriceBoard.SalePrice_4:=Adw.sell_4;    PriceBoard.SalePrice_5:=Adw.sell_5;    PriceBoard.SalePrice_6:=Adw.sell_6;    PriceBoard.SalePrice_7:=Adw.sell_7;    PriceBoard.SalePrice_8:=Adw.sell_8;    PriceBoard.SalePrice_9:=Adw.sell_9;    PriceBoard.SalePrice_10:=Adw.sell_10;
      PriceBoard.SaleQty_1:=Adw.sell_1_vol;    PriceBoard.SaleQty_2:=Adw.sell_2_vol;    PriceBoard.SaleQty_3:=Adw.sell_3_vol;    PriceBoard.SaleQty_4:=Adw.sell_4_vol;    PriceBoard.SaleQty_5:=Adw.sell_5_vol;    PriceBoard.SaleQty_6:=Adw.sell_6_vol;    PriceBoard.SaleQty_7:=Adw.sell_7_vol;    PriceBoard.SaleQty_8:=Adw.sell_8_vol;    PriceBoard.SaleQty_9:=Adw.sell_9_vol;    PriceBoard.SaleQty_10:=Adw.sell_10_vol;
      PriceBoard.BuyPrice_1:=Adw.Buy_1;    PriceBoard.BuyPrice_2:=Adw.Buy_2;    PriceBoard.BuyPrice_3:=Adw.Buy_3;    PriceBoard.BuyPrice_4:=Adw.Buy_4;    PriceBoard.BuyPrice_5:=Adw.Buy_5;    PriceBoard.BuyPrice_6:=Adw.Buy_6;    PriceBoard.BuyPrice_7:=Adw.Buy_7;    PriceBoard.BuyPrice_8:=Adw.Buy_8;    PriceBoard.BuyPrice_9:=Adw.Buy_9;    PriceBoard.BuyPrice_10:=Adw.Buy_10;
      PriceBoard.BuyQty_1:=Adw.Buy_1_vol;    PriceBoard.BuyQty_2:=Adw.Buy_2_vol;    PriceBoard.BuyQty_3:=Adw.Buy_3_vol;    PriceBoard.BuyQty_4:=Adw.Buy_4_vol;    PriceBoard.BuyQty_5:=Adw.Buy_5_vol;    PriceBoard.BuyQty_6:=Adw.Buy_6_vol;    PriceBoard.BuyQty_7:=Adw.Buy_7_vol;    PriceBoard.BuyQty_8:=Adw.Buy_8_vol;    PriceBoard.BuyQty_9:=Adw.Buy_9_vol;    PriceBoard.BuyQty_10:=Adw.Buy_10_vol;

      BidAsk.BuyTotal := PriceBoard.BuyTotal;     BidAsk.SellTotal := PriceBoard.SellTotal;
    end;
    ShowDwInfo;
  end;
end;

procedure TForm3.FloatSpinEdit1EditingDone(Sender: TObject);
var                               // 对于买订单，输入价格后，根据持仓现金显示可买数量
  Tmp:double;                     // 卖订单不显示
begin
  if RadioButton1.Checked=true then
  begin
    Tmp:=Cash.Available;
    AvailableNumber:=Trunc(Tmp/FloatSpinEdit1.Value);
    Label7.Caption:='可交易：';
    Label10.Caption:=inttostr(AvailableNumber)+'股';
  end
  else
  begin
    Label7.Caption:='';
    Label10.Caption:='';
  end;
end;

procedure TForm3.SpinEdit1EditingDone(Sender:TObject);  // 对卖出单查看是否有足够的持仓
var                                                      // 根据价格和数量计算金额
  i,index:integer;
begin
  if RadioButton2.Checked=true then               // 卖订单来说，比较持仓数目是否满足下单数目
  begin                                           // 若满足，
    index:=PropertyList.IndexOf(Edit1.text,'sz');
    if index=-1 then Label11.Caption:='无该持仓股票'
    else if PropertyList.Item(index).quantity<SpinEdit1.value then Label11.Caption:='持仓数额不足'
    else Label11.Caption:=floattostr(spinEdit1.value*FloatSpinEdit1.Value);
  end
  else                                            // 买订单来说，比较可用现金是否满足下单所需金额
  begin                                           // 若满足，显示所支付金额
    if spinEdit1.Value<>0 then
    begin
      if spinEdit1.value>AvailableNumber then Label11.Caption:='余额不足'
      else Label11.Caption:=floattostr(spinEdit1.value*FloatSpinEdit1.Value);
    end;
  end;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  RadioButton1.Checked:=True;            // 买入
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  RadioButton2.Checked:=True;          //还是卖出
end;

procedure TForm3.BCButton1Click(Sender: TObject);     // 根据信息下订单
var
  AnOrder:TOrderItem;
begin
  // 设置订单信息
  AnOrder.Date:=0;       //成交时间初始值为零，在timer中，成交的时候设置为盘口1值
  AnOrder.Number:='SZ'+Formatdatetime('hhmmss',Now);   //订单号： 市场+下单时间+买or卖
  AnOrder.Code:=Edit1.Caption;       //代码
  if ComboBox1.text='深市' then AnOrder.Market:='sz' else AnOrder.Market:='sh';
  AnOrder.StockName:=label9.Caption;      // 股票名称
  AnOrder.Orig_price:=strtofloat(FloatSpinEdit1.Caption);   //原价
  AnOrder.Deal_price:=AnOrder.Orig_price;       //成交价，暂设为原价，成交时改价
  AnOrder.quantity:=strtoint(SpinEdit1.Caption);     //数量
  AnOrder.Amount:=strtoint(SpinEdit1.Caption)*strtofloat(FloatSpinEdit1.Caption);   //金额
  if RadioButton1.Checked=true then            //方向
     begin  AnOrder.direct:=true;    AnOrder.Number:=AnOrder.Number+'S';   end
  else
     begin  AnOrder.direct:=false;    AnOrder.Number:=AnOrder.Number+'B';   end;
  AnOrder.status:=False;         //未成交

  //添加到当前订单
  CurrentList.add(AnOrder);

  //显示订单队列界面
  close;
  Form4:=TForm4.Create(Application);
  Form4.show;
end;


procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;           //  Free~~~~~~
  historylist.clear;
end;


end.

