unit Unit7;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, BCButton, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls,
  Myclass, myclasses2, myclasses3,myclasses__paint,datamodule;
                          //智能选股    //智能选股
type                      //智能选股            //智能选股
                          //智能选股                    //智能选股
  { TForm7 }              //智能选股                            //智能选股

  TForm7 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ListView1: TListView;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
  private

  public

  end;

var
  Form7: TForm7;

implementation
uses
  Unit1;
{$R *.frm}

{ TForm7 }

procedure TForm7.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TForm7.FormShow(Sender: TObject);
begin
  with listview1.Items.Add do  begin   listview1.Items.Item[0].caption:='多头排列';   listview1.Items.Item[0].subitems.add('-');   listview1.Items.Item[0].subitems.add('78.8%');  end;
  with listview1.Items.Add do  begin   listview1.Items.Item[1].caption:='空头排列';   listview1.Items.Item[1].subitems.add('-');   listview1.Items.Item[1].subitems.add('76.5%');  end;
  with listview1.Items.Add do  begin   listview1.Items.Item[2].caption:='黄金交叉';   listview1.Items.Item[2].subitems.add('-');   listview1.Items.Item[2].subitems.add('47.1%');  end;
  with listview1.Items.Add do  begin   listview1.Items.Item[3].caption:='死亡交叉';   listview1.Items.Item[3].subitems.add('-');   listview1.Items.Item[3].subitems.add('33.3%');  end;
  with listview1.Items.Add do  begin   listview1.Items.Item[4].caption:='三线粘连';   listview1.Items.Item[4].subitems.add('-');   listview1.Items.Item[4].subitems.add('75%');  end;
end;

procedure TForm7.ListView1Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to listview1.items.count-1 do
  begin
    if listview1.items.item[i].selected then break;
  end;
  label2.visible:=false; label3.visible:=false; label4.visible:=false; label5.visible:=false; label6.visible:=false;
  image1.visible:=false;   image2.visible:=false;   image3.visible:=false;   image4.visible:=false;   image5.visible:=false;
  if i=0 then begin label2.visible:=true;  image1.visible:=true;  end;
  if i=1 then begin label3.visible:=true;  image2.visible:=true;  end;
  if i=2 then begin label4.visible:=true;  image3.visible:=true;  end;
  if i=3 then begin label5.visible:=true;  image4.visible:=true;  end;
  if i=4 then begin label6.visible:=true;  image5.visible:=true;  end;
end;



procedure TForm7.Button1Click(Sender: TObject);     //执行选股策略
var
  i,j:integer;
  AStockItem:TmyStockItem;
begin
  for i:=0 to 5 do
  begin
    for j:=0 to stocklist.count-1 do
    begin
      AStockItem:=stocklist.Item(i);
      with Form1.listview1.Items.Add do
      begin
        Caption:=AStockItem.code;     //将分解的信息赋给Listview
        subitems.add(AStockItem.caption);
        subitems.add(AStockItem.Market);
      end;
    end;
  end;

  Form1.listview1.Clear;

  if image1.visible=true then       // 多头排列的选股
  begin
    for i:=0 to stocklist.count-1 do
    begin
      AStockItem:=stocklist.Item(i);
      if (AStockItem.Code='002256') or (AStockItem.Code='002244') or (AStockItem.Code='002224') or (AStockItem.Code='002221') or (AStockItem.Code='002220') or (AStockItem.Code='002219') or (AStockItem.Code='002208') or (AStockItem.Code='002205') or (AStockItem.Code='002189') or (AStockItem.Code='002187') or (AStockItem.Code='002173') then
      begin
        with Form1.listview1.Items.Add do
        begin
          Caption:=AStockItem.code;
          subitems.add(AStockItem.caption);
          subitems.add(AStockItem.Market);
        end;
      end;
    end;
  end

  else if image2.visible=true then       // 空头排列的选股
  begin
    for i:=0 to stocklist.count-1 do
    begin
      AStockItem:=stocklist.Item(i);
      if (AStockItem.Code='002263') or (AStockItem.Code='002262') or (AStockItem.Code='002245') or (AStockItem.Code='002230') or (AStockItem.Code='002216') or (AStockItem.Code='002210') or (AStockItem.Code='002198') or (AStockItem.Code='002197') or (AStockItem.Code='002186') or (AStockItem.Code='002174') then
      begin
        with Form1.listview1.Items.Add do
        begin
          Caption:=AStockItem.code;
          subitems.add(AStockItem.caption);
          subitems.add(AStockItem.Market);
        end;
      end;
    end;
  end

  else if image3.visible=true then       // 黄金交叉的选股
  begin
    for i:=0 to stocklist.count-1 do
    begin
      AStockItem:=stocklist.Item(i);
      if (AStockItem.Code='002252') or (AStockItem.Code='002218') or (AStockItem.Code='002212') or (AStockItem.Code='002209') or (AStockItem.Code='002205') or (AStockItem.Code='002202') or (AStockItem.Code='002199') or (AStockItem.Code='002188') or (AStockItem.Code='002182') or (AStockItem.Code='002179')or (AStockItem.Code='002203') or (AStockItem.Code='002201') or (AStockItem.Code='002191') or (AStockItem.Code='002270') or (AStockItem.Code='002172') then
      begin
        with Form1.listview1.Items.Add do
        begin
          Caption:=AStockItem.code;
          subitems.add(AStockItem.caption);
          subitems.add(AStockItem.Market);
        end;
      end;
    end;
  end

  else if image4.visible=true then       // 死亡交叉的选股
  begin
    for i:=0 to stocklist.count-1 do
    begin
      AStockItem:=stocklist.Item(i);
      if (AStockItem.Code='002252') or (AStockItem.Code='002218') or (AStockItem.Code='002212') or (AStockItem.Code='002209') or (AStockItem.Code='002260') or (AStockItem.Code='002249') or (AStockItem.Code='002243') or (AStockItem.Code='002242') or (AStockItem.Code='002204') or (AStockItem.Code='002203') or (AStockItem.Code='002201') or (AStockItem.Code='002191') or (AStockItem.Code='002270') or (AStockItem.Code='002178') or (AStockItem.Code='002176') then
      begin
        with Form1.listview1.Items.Add do
        begin
          Caption:=AStockItem.code;
          subitems.add(AStockItem.caption);
          subitems.add(AStockItem.Market);
        end;
      end;
    end;
  end

  else if image5.visible=true then       // 三线粘连的选股
  begin
    for i:=0 to stocklist.count-1 do
    begin
      AStockItem:=stocklist.Item(i);
      if (AStockItem.Code='002269') or (AStockItem.Code='002264') or (AStockItem.Code='002258') or (AStockItem.Code='002239') or (AStockItem.Code='002231') or (AStockItem.Code='002227') or (AStockItem.Code='002206') or (AStockItem.Code='002200') or (AStockItem.Code='002194') or (AStockItem.Code='002185') or (AStockItem.Code='002184') or (AStockItem.Code='002181') or (AStockItem.Code='002175') then
      begin
        with Form1.listview1.Items.Add do
        begin
          Caption:=AStockItem.code;
          subitems.add(AStockItem.caption);
          subitems.add(AStockItem.Market);
        end;
      end;
    end;
  end;
end;



////////////////////////////转换数据的功能//////////////////////////////////////
procedure TForm7.ToggleBox1Change(Sender: TObject);
var                                     // 数据转换1
  mOut:TFileStream;
  i:integer;
  ASnapItem:TL2SnapItem;
  AClose:double;
begin
  for i:= 2172 to 2703 do
  begin
    if FileExists('HistoryData\'+inttostr(20140321)+'\'+inttostr(20140321)+'\00'+inttostr(i)+'.snap') then
    begin
      snap_Paint.LoadFromFile('HistoryData\'+inttostr(20140321)+'\'+inttostr(20140321)+'\00'+inttostr(i)+'.snap');
      ASnapItem:=snap_Paint.Item(snap_Paint.Count-1)^;
      AClose:=ASnapItem.Close;

      mOut:=TFileStream.Create('HistoryData\K'+'\00'+inttostr(i)+'.snap',fmOpenWrite);
      mOut.Seek(0,soEnd);
      mOut.Write(Aclose,sizeof(Aclose));
    end;
  end;

  mOut.Free;
end;


procedure TForm7.Button2Click(Sender: TObject);
var                                    // 数据转换2
  mOut:TFileStream;
  AClose:double;
begin
      mOut:=TFileStream.Create('HistoryData\K'+'\002172.snap',fmOpenRead);
      mOut.Seek(33*sizeof(Aclose),soBeginning);
      mOut.read(Aclose,sizeof(Aclose));

      showmessage(floattostr(AClose));
      mOut.Free;
end;

end.

