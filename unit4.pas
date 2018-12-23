unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  Myclass, myclasses2, myclasses3, datamodule;
                      //订单队列  //订单队列
type                  //订单队列            //订单队列
                      //订单队列                      //订单队列
  { TForm4 }          //订单队列                                //订单队列
                      //订单队列                                          //订单队列
  TForm4 = class(TForm)
    ListView1: TListView;
    ListView2: TListView;
    ListView3: TListView;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  Form4: TForm4;

implementation

{$R *.frm}

{ TForm4 }

procedure TForm4.FormActivate(Sender: TObject);
var
  i:integer;
  AnOrder,AnOldOrder:TOrderItem;
begin
  listview1.Clear;      listview2.Clear;      listview3.Clear;
  for i:=0 to CurrentList.Count-1 do
  begin
    AnOrder:=CurrentList.Item(i);
    if AnOrder.status=true then                //判断是否成交
    begin
      with listview1.Items.Add do
      begin
        Caption:=AnOrder.Number;     //已成交的Listview
        subitems.add(inttostr(AnOrder.Date));
        subitems.add(AnOrder.Market);
        subitems.add(AnOrder.Code);
        subitems.add(AnOrder.StockName);
        subitems.add(floattostr(AnOrder.Deal_price));
        subitems.add(inttostr(AnOrder.quantity));
        if Anorder.direct=true then subitems.add('买入') else subitems.add('卖出');
        subitems.add(floattostr(AnOrder.Amount));
      end;
    end
    else
    begin
      with listview2.Items.Add do
      begin
        Caption:=AnOrder.Number;     //未成交Listview
        subitems.add(AnOrder.Market);
        subitems.add(AnOrder.Code);
        subitems.add(AnOrder.StockName);
        subitems.add(floattostr(AnOrder.Deal_price));
        subitems.add(inttostr(AnOrder.quantity));
        if Anorder.direct=true then subitems.add('买入') else subitems.add('卖出');
        subitems.add(floattostr(AnOrder.Amount));
      end;
    end;
  end;

  for i:=0 to HistoryList.Count-1 do
  begin
    AnOldOrder:=HistoryList.Item(i);
    with listview3.Items.Add do
    begin
      Caption:=AnOldOrder.Number;     //历史订单的Listview
      subitems.add(inttostr(AnOldOrder.Date));
      subitems.add(AnOldOrder.Market);
      subitems.add(AnOldOrder.Code);
      subitems.add(AnOldOrder.StockName);
      subitems.add(floattostr(AnOldOrder.Deal_price));
      subitems.add(inttostr(AnOldOrder.quantity));
      if AnOldOrder.direct=true then subitems.add('买入') else subitems.add('卖出');
      subitems.add(floattostr(AnOldOrder.Amount));
    end;
  end
end;

procedure TForm4.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

end.

