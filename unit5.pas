unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls, Math,
  Myclass, myclasses2, myclasses3, datamodule;
                   //用户资产  //用户资产
type               //用户资产            //用户资产
                   //用户资产                      //用户资产
  { TForm5 }       //用户资产                               //用户资产
                   //用户资产                                          //用户资产
  TForm5 = class(TForm)
    Image4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ListView2: TListView;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    TabSheet1: TTabSheet;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  Form5: TForm5;
                           // Frozen, price, profit和profitRatio是变化的
                           // 设定计时器，每秒钟update
implementation

{$R *.frm}

{ TForm5 }


procedure TForm5.FormActivate(Sender: TObject);
{ 1. 循环每一只propertyItem，先根据股代码和系统时间load得到当前的snap，将snap的价格赋值给ApropertyItem.price
     并计算出profit和profitRate
  2. with listview2.Items.Add do    将每只ApropertyItem赋值到listview的一列     }
var
  i:integer;
  ApropertyItem:TPropertyItem;
  ASnapItem:TL2SnapItem;
  TotalValue,TotalProfit:double;
begin
  listview2.Clear;
  TotalValue:=0; TotalProfit:=0;
  for i:=0 to PropertyList.Count-1 do
  begin
    ApropertyItem:=PropertyList.Item(i);
    snap_Property_Paint.LoadFromFile('HistoryData\'+inttostr(system_date)+'\'+inttostr(system_Date)+'\'+
                                                                              ApropertyItem.Code+'.snap');
    ASnapItem:= snap_Property_Paint.Item(snap_Property_Paint.CalcFrameIndex(system_time))^;

    ApropertyItem.price:=ASnapItem.close;
    ApropertyItem.profit:= (ApropertyItem.price - ApropertyItem.cost)*ApropertyItem.quantity;
    ApropertyItem.profitRatio:= (ApropertyItem.profit/(ApropertyItem.price*ApropertyItem.quantity))*100;
    TotalValue:=TotalValue+ApropertyItem.price*ApropertyItem.quantity;
    TotalProfit:=TotalProfit+ApropertyItem.profit;

    with listview2.Items.Add do
    begin
      Caption:=ApropertyItem.Market;
      subitems.add(ApropertyItem.Code);
      subitems.add(ApropertyItem.StockName);
      subitems.add(floattostr(ApropertyItem.quantity));
      subitems.add(floattostr(ApropertyItem.cost));
      subitems.add(floattostr(ApropertyItem.price));
      subitems.add(floattostr(RoundTo(ApropertyItem.profit,-2)));
      subitems.add(floattostr(RoundTo(ApropertyItem.ProfitRatio,-2))+'%');
    end;
  end;
  Label3.caption:=floattostr(Cash.Available+PropertyLIst.Frozen);
  Label5.caption:=floattostr(Cash.Available);
  Label6.Caption:=floattostr(RoundTo(TotalProfit,-2));
  Label8.Caption:=floattostr(Cash.Available+TotalValue-200000);
end;

procedure TForm5.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;


end.

