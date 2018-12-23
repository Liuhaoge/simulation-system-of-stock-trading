unit Unit8;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls,
  Myclass, myclasses2, myclasses3,myclasses__paint;
                          //策略管理     //策略管理
type                      //策略管理               //策略管理
                          //策略管理                         //策略管理
  { TForm8 }              //策略管理                                   //策略管理

  TForm8 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Image1: TImage;
    Image7: TImage;
    ListView2: TListView;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel2: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form8: TForm8;

implementation
uses
  Unit10;
{$R *.frm}

{ TForm8 }

procedure TForm8.Button1Click(Sender: TObject);
begin
  Form10:=TForm10.Create(Application);
  Form10.show;
end;

procedure TForm8.Button2Click(Sender: TObject);
begin
  Form10:=TForm10.Create(Application);
  Form10.show;
end;

procedure TForm8.Button3Click(Sender: TObject);
begin

end;

procedure TForm8.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TForm8.FormShow(Sender: TObject);
begin
  with listview2.Items.Add do  begin   listview2.Items.Item[0].caption:='区间突破';    listview2.Items.Item[0].subitems.add('盘中');   listview2.Items.Item[0].subitems.add('循环运行');   listview2.Items.Item[0].subitems.add('今日收盘价+N*昨日振幅');    listview2.Items.Item[0].subitems.add('今日收盘价-N*昨日振幅');    listview2.Items.Item[0].subitems.add('是');  end;
  with listview2.Items.Add do  begin   listview2.Items.Item[1].caption:='菲阿里四价';    listview2.Items.Item[1].subitems.add('盘中');  listview2.Items.Item[1].subitems.add('循环运行');    listview2.Items.Item[1].subitems.add('昨日高点');     listview2.Items.Item[1].subitems.add('昨日低点');    listview2.Items.Item[1].subitems.add('否');  end;
  with listview2.Items.Add do  begin   listview2.Items.Item[2].caption:='转向交易';     listview2.Items.Item[2].subitems.add('盘中');  listview2.Items.Item[2].subitems.add('循环运行');   listview2.Items.Item[2].subitems.add('今日开盘价+今日开盘价*0.01');     listview2.Items.Item[2].subitems.add('今日开盘价-今日开盘价*0.01');    listview2.Items.Item[2].subitems.add('否');  end;
  with listview2.Items.Add do  begin   listview2.Items.Item[3].caption:='HANS123算法';   listview2.Items.Item[3].subitems.add('盘中');  listview2.Items.Item[3].subitems.add('循环运行');    listview2.Items.Item[3].subitems.add('开盘后30分钟高点');    listview2.Items.Item[3].subitems.add('开盘后30分钟低点');    listview2.Items.Item[3].subitems.add('是');  end;
  with listview2.Items.Add do  begin   listview2.Items.Item[4].caption:='日均ATR突破';   listview2.Items.Item[4].subitems.add('盘中');  listview2.Items.Item[4].subitems.add('循环运行');    listview2.Items.Item[4].subitems.add('今日开盘价+N个交易日平均ATR*M');    listview2.Items.Item[4].subitems.add('今日开盘价-N个交易日平均ATR*M');   listview2.Items.Item[4].subitems.add('否');  end;
  with listview2.Items.Add do  begin   listview2.Items.Item[5].caption:='ORB突破';   listview2.Items.Item[5].subitems.add('盘中');  listview2.Items.Item[5].subitems.add('循环运行');    listview2.Items.Item[5].subitems.add('今日开盘价+N天ORB*M');    listview2.Items.Item[5].subitems.add('今日开盘价-N天ORB*M');     listview2.Items.Item[5].subitems.add('否');  end;

  //设置一个判断变量增加策略
end;

end.

