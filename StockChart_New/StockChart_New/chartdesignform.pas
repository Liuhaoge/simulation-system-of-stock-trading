unit chartdesignform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SpkToolbar, spkt_Tab, spkt_Pane, spkt_Buttons,
  BGRACustomDrawn, RTTIGrids, GR32_Image, Forms, Controls, variants, Graphics,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons, Spin, stockcharts, typinfo,
  gateconst;

type

  { TfrmChartDesign }

  TfrmChartDesign = class(TForm)
    BCDButton1: TBCDButton;
    BCDButton10: TBCDButton;
    BCDButton11: TBCDButton;
    BCDButton12: TBCDButton;
    BCDButton13: TBCDButton;
    BCDButton14: TBCDButton;
    BCDButton15: TBCDButton;
    BCDButton16: TBCDButton;
    BCDButton17: TBCDButton;
    BCDButton18: TBCDButton;
    BCDButton2: TBCDButton;
    BCDButton3: TBCDButton;
    BCDButton4: TBCDButton;
    BCDButton5: TBCDButton;
    BCDButton6: TBCDButton;
    BCDButton7: TBCDButton;
    BCDButton8: TBCDButton;
    BCDButton9: TBCDButton;
    box: TPaintBox32;
    Grid: TTIPropertyGrid;
    Image1: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    SaveDialog1: TSaveDialog;
    ScrollBox1: TScrollBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpkLargeButton1: TSpkLargeButton;
    SpkLargeButton10: TSpkLargeButton;
    SpkLargeButton11: TSpkLargeButton;
    SpkLargeButton12: TSpkLargeButton;
    SpkLargeButton13: TSpkLargeButton;
    SpkLargeButton14: TSpkLargeButton;
    SpkLargeButton15: TSpkLargeButton;
    SpkLargeButton16: TSpkLargeButton;
    SpkLargeButton17: TSpkLargeButton;
    SpkLargeButton18: TSpkLargeButton;
    SpkLargeButton2: TSpkLargeButton;
    SpkLargeButton3: TSpkLargeButton;
    SpkLargeButton4: TSpkLargeButton;
    SpkLargeButton5: TSpkLargeButton;
    SpkLargeButton6: TSpkLargeButton;
    SpkLargeButton7: TSpkLargeButton;
    SpkLargeButton8: TSpkLargeButton;
    SpkLargeButton9: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkPane2: TSpkPane;
    SpkPane3: TSpkPane;
    SpkPane4: TSpkPane;
    SpkTab1: TSpkTab;
    SpkToolbar1: TSpkToolbar;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Tree: TTreeView;
    procedure BCDButton14Click(Sender: TObject);
    procedure BCDButton15Click(Sender: TObject);
    procedure BCDButton16Click(Sender: TObject);
    procedure BCDButton17Click(Sender: TObject);
    procedure BCDButton18Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridModified(Sender: TObject);
    procedure Panel4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel4MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Panel4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel6MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Panel6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure TreeSelectionChanged(Sender: TObject);
  private
    Moving:boolean;
    XPos,YPos:integer;
    FResizing:boolean;
    WPos,HPos:integer;
  public
    ChartMan:TMyChartManager;
    procedure BoxRepaint;
  end;

var
  frmChartDesign: TfrmChartDesign;

implementation

{$R *.frm}

{ TfrmChartDesign }

procedure TfrmChartDesign.FormCreate(Sender: TObject);
begin
  ChartMan:=TMyChartManager.Create(Self);
  ChartMan.Bitmap:=Box.Buffer;
end;

procedure TfrmChartDesign.FormShow(Sender: TObject);
begin
  SpinEdit1.Value:=Box.Buffer.Width;
  SpinEdit2.Value:=Box.Buffer.Height;
end;

procedure TfrmChartDesign.GridModified(Sender: TObject);
begin
  if Tree.Selected<>nil then
    Tree.Selected.Text:=TMyChartItemBase(Tree.Selected.Data).ChartName;
  BoxRepaint;
end;

procedure TfrmChartDesign.Panel4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if WindowState=wsMaximized then
    Exit;
  if mbLeft = Button then
  begin
    Self.Moving:=True;
    Self.YPos := Y;
    Self.XPos := X;
  end;
end;

procedure TfrmChartDesign.Panel4MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if WindowState=wsMaximized then
    Exit;
  if Self.Moving then
  begin
    Self.Top:=Self.Top+Y-Self.YPos;
    Self.Left:=Self.Left+X-Self.XPos;
    if Self.Top<0 then
      Self.Top:=0;
  end;
end;

procedure TfrmChartDesign.Panel4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if WindowState=wsMaximized then
    Exit;
  Moving:=False;
end;

procedure TfrmChartDesign.Panel6MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if WindowState=wsMaximized then
    Exit;
  if mbLeft = Button then
  begin
    Self.FResizing:=True;
    Self.WPos:=X;
    Self.HPos:=Y;
  end;
end;

procedure TfrmChartDesign.Panel6MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  mW,mH:integer;
begin
  if WindowState=wsMaximized then
    Exit;
  if Self.FResizing then
  begin
    mH:=Self.Height+Y-Self.HPos;
    if mH<200 then
      mH:=200;
    mW:=Self.Width+X-Self.WPos;
    if (Self.Top+mH+Self.Panel4.Height)>Screen.DesktopHeight then
    begin
      Self.Height:=Screen.DesktopHeight-Self.Top-Self.Panel4.Height;
    end
    else
      Self.Height:=mH;
  end;
end;

procedure TfrmChartDesign.Panel6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if WindowState=wsMaximized then
    Exit;
  Self.FResizing:=False;
end;

procedure TfrmChartDesign.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmChartDesign.SpeedButton2Click(Sender: TObject);
begin
  if Self.WindowState=wsNormal then
  begin
    Self.WindowState:=wsMaximized;
    Top:=Screen.WorkAreaTop;
    Left:=Screen.WorkAreaLeft;
    Height:=Screen.WorkAreaHeight;
    Width:=Screen.WorkAreaWidth;
    SpeedButton2.Hint:='恢复';
  end
  else
  begin
    Self.WindowState:=wsNormal;
    SpeedButton2.Hint:='最大化';
  end;
end;

procedure TfrmChartDesign.SpeedButton3Click(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TfrmChartDesign.SpinEdit1Change(Sender: TObject);
begin
  Box.Width:=SpinEdit1.Value;
  BoxRepaint;
end;

procedure TfrmChartDesign.SpinEdit2Change(Sender: TObject);
begin
  Box.Height:=SpinEdit2.Value;
  BoxRepaint;
end;

procedure TfrmChartDesign.TreeSelectionChanged(Sender: TObject);
begin
  if Tree.Selected<>nil then
    Grid.TIObject:=TMyChartItemBase(Tree.Selected.Data);
end;

procedure TfrmChartDesign.BoxRepaint;
begin
  Box.Buffer.Clear;
  ChartMan.Paint;
  Box.Invalidate;
end;

procedure TfrmChartDesign.Button1Click(Sender: TObject);
var                            //重要！！！重要！！！重要！！！重要！！！
  m:TMyChartLabel;
begin
  m:=TMyChartLabel.Create(Self);
  m.Caption:='这是文本对象';
  m.Font.Size:=9;
  m.Font.Color:=clWhite;
  m.Top:=0;
  m.Left:=0;
  m.ChartName:='文本'+inttostr(ChartMan.Count+1);
  //添加到树形
  Tree.Items.Add(nil,m.ChartName).Data:=m;
  ChartMan.Add(m);
  BoxRepaint;
end;

procedure TfrmChartDesign.Button10Click(Sender: TObject);
var
  mIndex,mIndex2:integer;
  mNode:TTreeNode;
begin
  //上移
  if Tree.Selected.GetPrev<>nil then
  begin
    mNode:=Tree.Items.Insert(Tree.Selected.GetPrev,Tree.Selected.Text);
    mNode.Data:=Tree.Selected.Data;
    Tree.Items.Delete(Tree.Selected);
    mNode.Selected:=True;
    mIndex2:=ChartMan.IndexByObject(TMyChartItemBase(mNode.Data));
    if mIndex2<>-1 then
    begin
      ChartMan.MoveUp(mIndex2);
    end;
    BoxRepaint;
  end;
end;

procedure TfrmChartDesign.BCDButton14Click(Sender: TObject);
var
  m:TMyChartPriceBoard;             //重要！！！重要！！！重要！！！重要！！！
begin                                   //(盘口)
  m:=TMyChartPriceBoard.Create(Self);
  m.Top:=0;
  m.Left:=0;
  m.Width:=260;
  m.Height:=420;
  m.ChartName:='报价板'+inttostr(ChartMan.Count+1);
  //添加到树形
  Tree.Items.Add(nil,m.ChartName).Data:=m;
  ChartMan.Add(m);
  BoxRepaint;
end;

procedure TfrmChartDesign.BCDButton15Click(Sender: TObject);
var                                 //重要！！！重要！！！重要！！！重要！！！
  m:TMyChartBidAsk;
begin
  m:=TMyChartBidAsk.Create(Self);
  m.Top:=0;
  m.Left:=0;
  m.Width:=260;
  m.Height:=420;
  m.ChartName:='量比'+inttostr(ChartMan.Count+1);
  //添加到树形
  Tree.Items.Add(nil,m.ChartName).Data:=m;
  ChartMan.Add(m);
  BoxRepaint;
end;

procedure TfrmChartDesign.BCDButton16Click(Sender: TObject);
var
  m:TMyChartOHLCVBanner;           //重要！！！重要！！！重要！！！重要！！！
begin
  m:=TMyChartOHLCVBanner.Create(Self);
  m.Top:=0;
  m.Left:=0;
  m.Width:=260;
  m.Height:=420;
  m.ChartName:='OHLCV'+inttostr(ChartMan.Count+1);
  //添加到树形
  Tree.Items.Add(nil,m.ChartName).Data:=m;
  ChartMan.Add(m);
  BoxRepaint;
end;

procedure TfrmChartDesign.BCDButton17Click(Sender: TObject);
var
  m:TMyChartPosition;
begin
  m:=TMyChartPosition.Create(Self);
  m.Top:=0;
  m.Left:=0;
  m.Width:=260;
  m.Height:=420;
  m.ChartName:='持仓'+inttostr(ChartMan.Count+1);
  //添加到树形
  Tree.Items.Add(nil,m.ChartName).Data:=m;
  ChartMan.Add(m);
  BoxRepaint;
end;

procedure TfrmChartDesign.BCDButton18Click(Sender: TObject);
var
  m:TMyChartAccount;
  n:TMyStockHolding;
  i:integer;
begin
  m:=TMyChartAccount.Create(Self);
  m.Top:=0;
  m.Left:=0;
  m.Width:=260;
  m.Height:=420;
  m.ChartName:='资产'+inttostr(ChartMan.Count+1);
  //添加演示数据
  for i:=0 to 8 do
  begin
    n.Code:='00000'+inttostr(i+1);
    n.Caption:='股票名称';
    n.Cost:=10.01;
    n.Earn:=0.00;
    n.Qty:=10;
    m.Data.Append(n);
  end;
  //添加到树形
  Tree.Items.Add(nil,m.ChartName).Data:=m;
  ChartMan.Add(m);
  BoxRepaint;
end;

procedure TfrmChartDesign.Button11Click(Sender: TObject);
var
  mIndex2:integer;
  mNode:TTreeNode;
begin
  //下移
  if Tree.Selected.GetNext<>nil then
  begin
    mNode:=Tree.Items.InsertBehind(Tree.Selected.GetNext,Tree.Selected.Text);
    mNode.Data:=Tree.Selected.Data;
    Tree.Items.Delete(Tree.Selected);
    mNode.Selected:=True;
    mIndex2:=ChartMan.IndexByObject(TMyChartItemBase(mNode.Data));
    if mIndex2<>-1 then
    begin
      ChartMan.MoveDown(mIndex2);
    end;
    BoxRepaint;
  end;
end;

procedure TfrmChartDesign.Button12Click(Sender: TObject);
var
  PP:PProplist;
  f:PPropInfo;
  s:string;
  m:TStrings;
  a:string;
  mCount,i:integer;

  mF:TFileStream;
  mLabel:TMyChartLabel;

  mFont:TObject;
begin
  if SaveDialog1.Execute then
  begin
    mF:=TFileStream.Create(SaveDialog1.FileName,fmCreate);
    ChartMan.BaseHeight:=Box.Height;
    ChartMan.BaseWidth:=Box.Width;
    ChartMan.SaveToStream(mF);
    mF.Free;
    ShowMessage('保存完毕。');
  end;

{  mLabel:=TMyChartLabel.Create(Self);
  m:=TStringList.Create;
//  new(PP);
  mCount:=GetPropList(mLabel,PP);
  ShowMessage(inttostr(mCount));
  for i:=0 to mCount-1 do //Length(PP^)-3 do
  begin
    f:=pp^[i];
    a:=f^.Name;
    if UpperCase(a)='FONT' then
    begin
      //专门处理字体
      mFont:=GetObjectProp(mLabel,'Font');
      Showmessage(TFont(mFont).Name);
    end
    else
    if f^.PropType^.Kind in [tkInteger,tkChar,tkEnumeration,tkFloat,
              tkSet,tkMethod,tkSString,tkLString,tkAString, tkClass,
              tkWString,tkWChar,tkBool,tkInt64,tkQWord,tkUString,tkUChar] then
    begin
      s:=vartostr(GetPropValue(mLabel,f));
      m.Add(a+'='+s);
    end;
  end;
  m.SaveToFile(ExtractFilepath(Application.ExeName)+'ftt.txt');
  m.Free;  }
end;

procedure TfrmChartDesign.Button13Click(Sender: TObject);
var
  m:TFileStream;
  i:integer;
begin
  if OpenDialog1.Execute then
  begin
    Tree.Items.Clear;
    m:=TFileStream.Create(OpenDialog1.FileName,fmOpenRead);
    ChartMan.LoadFromStream(m);
    m.Free;
    //重新生成树形
    for i:=0 to ChartMan.Count-1 do
    begin
      Tree.Items.Add(nil,ChartMan.Item(i).ChartName).Data:=ChartMan.Item(i);
    end;
    Box.Width:=ChartMan.BaseWidth;
    Box.Height:=ChartMan.BaseHeight;
    SpinEdit1.Value:=Box.Width;
    SpinEdit2.Value:=Box.Height;
    BoxRepaint;
  end;
end;


procedure TfrmChartDesign.Button2Click(Sender: TObject);
var
  m:TMyChartBox;                       //重要！！！重要！！！重要！！！重要！！！
begin
  m:=TMyChartBox.Create(Self);
  m.Width:=200;
  m.Height:=100;
  m.Transparent:=False;
  m.Gradient:=True;
  m.Caption:='这是面板对象';
  m.Font.Size:=9;
  m.Font.Color:=clWhite;
  m.Top:=0;
  m.Left:=0;
  m.ChartName:='面板'+inttostr(ChartMan.Count+1);
  //添加到树形
  Tree.Items.Add(nil,m.ChartName).Data:=m;
  ChartMan.Add(m);
  BoxRepaint;
end;

procedure TfrmChartDesign.Button3Click(Sender: TObject);
var
  m:TMyChartGrid;                      //重要！！！重要！！！重要！！！重要！！！
begin
  //添加网格
  m:=TMyChartGrid.Create(Self);
  m.ChartName:='网格'+inttostr(ChartMan.Count+1);
  m.Top:=0;
  m.Left:=0;
  m.Width:=400;
  m.Height:=300;
  m.Transparent:=False;
  m.Gradient:=True;
  //添加到树形
  Tree.Items.Add(nil,m.ChartName).Data:=m;
  ChartMan.Add(m);
  BoxRepaint;
end;

procedure TfrmChartDesign.Button4Click(Sender: TObject);
var
  m:TMyChartAxisX;                   //重要！！！重要！！！重要！！！重要！！！
begin
  m:=TMyChartAxisX.Create(Self);
  m.Top:=100;
  m.Left:=100;
  m.Width:=400;
  m.ChartName:='X轴'+inttostr(ChartMan.Count+1);
  m.InitMinuteTick;
  //添加到树形
  Tree.Items.Add(nil,m.ChartName).Data:=m;
  ChartMan.Add(m);
  BoxRepaint;
end;

procedure TfrmChartDesign.Button5Click(Sender: TObject);
var                              //重要！！！重要！！！重要！！！重要！！！
  m:TMyChartAxisY;
begin
  m:=TMyChartAxisY.Create(Self);
  m.ChartName:='Y轴'+inttostr(ChartMan.Count+1);
  m.Top:=10;
  m.Left:=10;
  m.Height:=300;
  //添加到树形
  Tree.Items.Add(nil,m.ChartName).Data:=m;
  ChartMan.Add(m);
  BoxRepaint;
end;

procedure TfrmChartDesign.Button6Click(Sender: TObject);
var
  m:TMyChartLine;                //重要！！！重要！！！重要！！！重要！！！
  i:integer;
begin
  m:=TMyChartLine.Create(Self);
  m.ChartName:='线'+inttostr(ChartMan.Count+1);
  m.Top:=10;
  m.Left:=10;
  m.Width:=400;
  m.Height:=300;
  m.AutoRange:=True;
  for i:=0 to 99 do
  begin
    m.Data.Append(Random(100));
  end;
  m.ColCount:=m.Data.Count;
  m.DisplayCount:=m.ColCount;
  //添加到树形
  Tree.Items.Add(nil,m.ChartName).Data:=m;
  ChartMan.Add(m);
  BoxRepaint;
end;

procedure TfrmChartDesign.Button7Click(Sender: TObject);
var                              //重要！！！重要！！！重要！！！重要！！！
  m:TMyChartVolume;
  i:integer;
begin
  //增加柱图
  m:=TMyChartVolume.Create(Self);
  m.ChartName:='柱'+inttostr(ChartMan.Count+1);
  m.Top:=10;
  m.Left:=10;
  m.Width:=400;
  m.Height:=300;
  m.AutoRange:=True;
  for i:=0 to 99 do
  begin
    m.Data.Append(Random(100));
  end;
  m.ColCount:=m.Data.Count;
  m.DisplayCount:=m.ColCount;
  //添加到树形
  Tree.Items.Add(nil,m.ChartName).Data:=m;
  ChartMan.Add(m);
  BoxRepaint;
end;

procedure TfrmChartDesign.Button8Click(Sender: TObject);
var                              //重要！！！重要！！！重要！！！重要！！！
  m:TMyChartOHLCBanner;
begin
  m:=TMyChartOHLCBanner.Create(Self);
  m.ChartName:='OHLC块'+inttostr(ChartMan.Count+1);
  m.Top:=10;
  m.Left:=10;
  //添加到树形
  Tree.Items.Add(nil,m.ChartName).Data:=m;
  ChartMan.Add(m);
  BoxRepaint;

end;

procedure TfrmChartDesign.Button9Click(Sender: TObject);
var
  mIndex:integer;
begin
  if Tree.Selected<>nil then
  begin
    mIndex:=ChartMan.IndexByChartName(Tree.Selected.Text);
    if mIndex<>-1 then
    begin
      Grid.TIObject:=nil;
      ChartMan.Delete(mIndex);
      Tree.Items.Delete(Tree.Selected);
    end;
    BoxRepaint;
  end;
end;

procedure TfrmChartDesign.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Grid.TIObject:=nil;
  ChartMan.Clear;
  ChartMan.Free;
end;

end.

