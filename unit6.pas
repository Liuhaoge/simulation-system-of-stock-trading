unit Unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, BCButton, TplGradientUnit, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, ComCtrls, Spin, Myclass, myclasses2,
  myclasses3, myclasses__paint;
                            //算法交易      //算法交易
type                       //算法交易                 //算法交易
                          //算法交易                            //算法交易
  { TForm6 }             //算法交易                                       //算法交易

  TForm6 = class(TForm)
    BCButton1: TBCButton;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ListView1: TListView;
    ListView3: TListView;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    plGradient1: TplGradient;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SpinEdit1: TSpinEdit;
    procedure BCButton1Click(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    counter:integer;
  public

  end;

var
  Form6: TForm6;

implementation
uses
  datamodule;
{$R *.frm}

{ TForm6 }

procedure TForm6.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TForm6.Edit1EditingDone(Sender: TObject);
var
  Aindex:integer;
  AMarket:string[2];
  Acode:string[6];
  AStockItem:TMyStockItem;
begin
  if (ComboBox1.text<>'') and (Edit1.text<>'') then
  begin
    if ComboBox1.text='深市' then AMarket:='sz' else AMarket:='sh';
    Acode:=Edit1.text;
    AIndex:=StockList.Indexof(ACode,AMarket);     //根据market和code检索到股票条目
    if Aindex <> -1 then
    begin
      AStockItem:=StockList.Item(AIndex);
      label7.Caption:=AStockItem.Caption;        //显示股票名称
    end;
  end;
end;

procedure TForm6.BCButton1Click(Sender: TObject);
var                                        //点击执行策略，增加一条待提交订单
  i:integer;
begin
  for i:=0 to Listview1.Items.count do
  begin
    if listview1.Items.Item[i].selected=true then break;
  end;

  if counter=0 then
  begin
    with listview3.Items.Add do  begin  listview3.Items.Item[0].caption:='sz';   listview3.Items.Item[0].subitems.add(Edit1.text);   listview3.Items.Item[0].subitems.add(label7.caption);   listview3.Items.Item[0].subitems.add('卖出');  listview3.Items.Item[0].subitems.add(spinEdit1.text);  listview3.Items.Item[0].subitems.add( listview1.Items.Item[i].caption); end;
    counter:=counter+1;
  end

  else if counter=1 then
  begin
    with listview3.Items.Add do  begin  listview3.Items.Item[1].caption:='sz';   listview3.Items.Item[1].subitems.add(Edit1.text);   listview3.Items.Item[1].subitems.add(label7.caption);   listview3.Items.Item[1].subitems.add('买入');  listview3.Items.Item[1].subitems.add(spinEdit1.text);  listview3.Items.Item[1].subitems.add( listview1.Items.Item[i].caption); end;
    counter:=counter+1;
  end

  else if counter=2 then
  begin
    with listview3.Items.Add do  begin  listview3.Items.Item[2].caption:='sz';   listview3.Items.Item[2].subitems.add(Edit1.text);   listview3.Items.Item[2].subitems.add(label7.caption);   listview3.Items.Item[2].subitems.add('买入');  listview3.Items.Item[2].subitems.add(spinEdit1.text);  listview3.Items.Item[2].subitems.add( listview1.Items.Item[i].caption); end;
  end;

  combobox1.Text:='';  Edit1.Text:='';  label7.Caption:='';  spinEdit1.Text:='';
end;

procedure TForm6.FormShow(Sender: TObject);
begin
  counter:=0;
  with listview1.Items.Add do  begin   listview1.Items.Item[0].caption:='区间突破';   end;
  with listview1.Items.Add do  begin   listview1.Items.Item[1].caption:='菲阿里四价';   end;
  with listview1.Items.Add do  begin   listview1.Items.Item[2].caption:='转向交易';   end;
  with listview1.Items.Add do  begin   listview1.Items.Item[3].caption:='HANS123算法';   end;
  with listview1.Items.Add do  begin   listview1.Items.Item[4].caption:='日均ATR突破';   end;
  with listview1.Items.Add do  begin   listview1.Items.Item[5].caption:='ORB突破';   end;
end;

end.
