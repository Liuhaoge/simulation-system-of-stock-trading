unit datamodule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil,Myclass,myclasses2,myclasses3,myclasses__paint, forms;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public

  end;
{  29号待完成任务：
          0.  按时间填数据再说，先做完下单过程和property的update的过程，再反过头来看unit1
          1.  为什么unit1中的stocklist必须创建和声明在函数里面，不能在datamodule或unit1的public变量里
               为什么unit3就可以
          2.  订单号和下单时间怎么弄
          3.  按照流程设置对象并做完下单过程              和 property的update的过程       }


{ 生成人工订单过程：
   1. Unit3中点击按钮，根据填写的信息下一个OrderItem
   2. 将它add进currentlist，Unit4中未成交的listview加一条
   3. Unit4中未成交的listview中的Order：
      满足成交条件，修改status，从listview的未成交改为已成交：
          买订单：盘口卖一价 <= Orig_Price时，订单全部成交，Deal_Price为卖一价
          卖订单：盘口买一价 >= Orig_Price时，订单全部成交，Deal_Price为买一价
   4. 订单成交时：Cash.Available:=Cash.Available-Order.price*Order.Amount;
                  Property 增加一条  Frozen重新计算
   5. 日期+1时：将status为已成交的订单add到HistoryList中，并显示到listview历史订单
               Currentlist清空
}
var
  DataModule1:TDataModule1;
  StockList:TMystocks;
  CurrentList:TCurrentOrder;
  HistoryList:THistoryOrder;
  Cash:TCash;
  PropertyList:TProperty;

  Index:TL2IndexDataFile;     // 深证成指的行情指数 专用于399001

  snap_Paint:TL2SnapDatafile;     // 股票OHLCV记录  Unit1的paint
  snap_Property_Paint:TL2SnapDatafile;     // 持仓股票 Unit5的listview在Active时显示当时的价格和利润

  Dw_Paint:Tl2SnapDwDataFile;    // 盘口记录  unit1
  Dw_Order_Paint:Tl2SnapDwDataFile;     //  unit3 中输入股票名称，显示盘口
  Dw_Order_Current:Tl2SnapDwDataFile;     // CurrentList Unit4的listview实时查看是否可交易

  system_date:integer;//日期
  System_time:integer;//发布时间
  Atime:TTime;
implementation

{$R *.frm}

{ TDataModule1 }

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  // 股票列表load
  stocklist:=TmyStocks.Create(self);
  stocklist.LoadFromFile('StockList.dat');
  // 流通中订单
  CurrentList:=TCurrentOrder.Create(self);
  CurrentList.LoadFromFile('CurrentList.dat');
  // 历史订单
  HistoryList:=THistoryOrder.Create(self);
  HistoryList.LoadFromFile('HistoryList.dat');
  // 现金数目导入
  Cash:=TCash.Create(self);
  Cash.LoadFromFile('Cash.dat');
  //持仓股票
  PropertyList:=TProperty.Create(self);
  PropertyList.LoadFromFile('PropertyList.dat');

  // 深证成指的行情指数 专用于399001   ;
  Index:=TL2IndexDataFile.Create(self);
  Index.Compress:=true;
   // 股票OHLCV记录
  snap_Paint:=TL2SnapDatafile.Create(self);
  snap_Paint.Compress:=true;
  snap_Property_Paint:=TL2SnapDatafile.Create(self);
  snap_Property_Paint.Compress:=true;
   // 盘口记录
  Dw_Paint:=Tl2SnapDwDataFile.Create(self);
  Dw_Paint.Compress:=true;
  Dw_Order_Paint:=Tl2SnapDwDataFile.Create(self);
  Dw_Order_Paint.Compress:=true;
  Dw_Order_Current:=Tl2SnapDwDataFile.Create(self);
  Dw_Order_Current.Compress:=true;

  system_date:=20140115;
  system_Time:=093000;
  ATime:=EncodeTime(9,30,0,0);
end;

procedure TDataModule1.DataModuleDestroy(Sender: TObject);
begin
  StockList.Free;

  CurrentList.SaveToFile('CurrentList.dat');
  CurrentList.Free;

  HistoryList.SaveToFile('HistoryList.dat');
  HistoryList.Free;

  Cash.SaveToFile('Cash.dat');
  Cash.Free;

  PropertyList.SaveToFile('PropertyList.dat');
  PropertyList.Free;

  Index.Free;    // 深证成指的行情指数 专用于399001
  snap_Paint.Free;     // 股票OHLCV记录
  snap_Property_Paint.Free;     // 持仓股票 Unit5的listview在Active时显示当时的价格和利润
  Dw_Paint.Free;    // 盘口记录
  Dw_Order_Paint.Free;     //  unit3 中输入股票名称，显示盘口
  Dw_Order_Current.Free;     // CurrentList Unit4的listview实时查看是否可交易
end;

end.

