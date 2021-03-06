unit mainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, GR32_Image, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, Spin, myutils, stockcharts;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    box: TPaintBox32;
    Button1: TButton;
    Button10: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    ColorButton1: TColorButton;
    ColorButton2: TColorButton;
    ColorButton3: TColorButton;
    Label1: TLabel;
    PageControl1: TPageControl;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SpinEdit1: TSpinEdit;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    Chart1:TMyChartItemBase;
    Chart2:TMyChartBox;
    Chart3:TMyChartGrid;
    Chart4:TMyChartAxisY;
    Chart5:TMyChartLabel;
    Chart6:TMyChartAxisX;
    Chart7:TMyChartLine;
    Chart8:TMyChartVolume;
  public
    procedure AppIdle(Sender: TObject; var Done: Boolean);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.frm}

{ TfrmMain }

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  Box.Buffer.Clear;
  MyGradientArea(clRed,clBlue,Box.Buffer,100,100,100,100);
  Box.Invalidate;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  Box.Buffer.Clear;
  MyGradientAreaH(clRed,clBlue,Box.Buffer,10,10,100,100);
  Box.Invalidate;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  Box.Buffer.Clear;
  if not Assigned(Chart1) then
  begin
    Chart1:=TMyChartItemBase.Create(Self);
    Chart1.Bitmap:=Box.Buffer;
    Chart1.Top:=100;
    Chart1.Left:=100;
    Chart1.Width:=Box.ClientWidth-200;
    Chart1.Height:=100;
    Chart1.FromColor:=clRed;
    Chart1.EndColor:=clBlue;
    Chart1.Transparent:=False;
  end;
  Chart1.Gradient:=CheckBox1.Checked;
  Chart1.VerticalGradient:=RadioButton1.Checked;
  Chart1.BackgroundStretch:=CheckBox2.Checked;
  Chart1.BackgroundCenter:=CheckBox3.Checked;
  Chart1.FromColor:=ColorButton1.ButtonColor;
  Chart1.EndColor:=ColorButton2.ButtonColor;
  if CheckBox4.Checked then
    Chart1.GradientSteps:=20
  else
    Chart1.GradientSteps:=100;
  Chart1.PaintEx(Chart1.Left,Chart1.Top);
  Box.Invalidate;
end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
  //加背景图
  if Assigned(Chart1) then
    Chart1.Background.LoadFromFile(ExtractFilepath(Application.ExeName)+'bg.png');
end;

procedure TfrmMain.Button5Click(Sender: TObject);
begin
  if Assigned(Chart1) then
    Chart1.Background.Clear;
end;

procedure TfrmMain.Button6Click(Sender: TObject);
begin
  if not Assigned(Chart2) then
  begin
    Chart2:=TMyChartBox.Create(Self);
    Chart2.Bitmap:=Box.Buffer;
    Chart2.Top:=100;
    Chart2.Left:=100;
    Chart2.Width:=Box.ClientWidth-200;
    Chart2.Height:=Box.ClientHeight-200;
    Chart2.Font.Name:='微软雅黑';
    Chart2.Font.Style:=[fsBold];
    Chart2.Font.Size:=16;
    Chart2.Font.Color:=clYellow;
  end;
  Chart2.Caption:='这是一个盒子';
  Chart2.Transparent:=False;
  Chart2.Gradient:=True;
  Chart2.BorderColor:=clYellow;
  Chart2.BorderWidth:=1;
  Chart2.BorderVisible:=True;
  Box.Buffer.Clear;
  Chart2.PaintEx(Chart2.Left,Chart2.Top);
  Box.Invalidate;
end;

procedure TfrmMain.Button7Click(Sender: TObject);
var
  i:integer;
  m:double;
begin
  if not Assigned(Chart3) then
  begin
    Chart3:=TMyChartGrid.Create(Self);
    Chart3.Bitmap:=Box.Buffer;
    Chart3.Top:=80;
    Chart3.Left:=100;
    Chart3.Font.Name:='微软雅黑';
    Chart3.Font.Style:=[fsBold];
    Chart3.Font.Size:=16;
    Chart3.Font.Color:=clSilver;
    Chart3.VGridVisible:=False;
    Chart3.HGridVisible:=False;
    Chart3.Gradient:=False;
  end;
  Chart3.Width:=Box.ClientWidth-200;
  Chart3.Height:=Box.ClientHeight-200;
  if not Assigned(Chart4) then
  begin
    Chart4:=TMyChartAxisY.Create(Self);
    Chart4.Bitmap:=Box.Buffer;
    Chart4.MaxValue:=100;
    Chart4.MinValue:=10;
    Chart4.Font.Name:='微软雅黑';
    Chart4.Font.Style:=[];
    Chart4.Font.Size:=8;
    Chart4.Font.Color:=clYellow;
  end;
  Chart4.Top:=Chart3.Top;
  Chart4.Left:=Chart3.Left+Chart3.Width;
  Chart4.Height:=Chart3.Height;
  Chart4.Width:=50;
  if not Assigned(Chart5) then
  begin
    Chart5:=TMyChartLabel.Create(Self);
    Chart5.Bitmap:=Box.Buffer;
    Chart5.Font.Color:=clWhite;
    Chart5.Font.Size:=16;
    Chart5.Caption:='WELCOME TO OCSDAQ';
  end;
  Chart5.Top:=25;
  Chart5.Left:=100;
  if not Assigned(Chart6) then
  begin
    Chart6:=TMyChartAxisX.Create(Self);
    Chart6.Bitmap:=Box.Buffer;
    Chart6.Font.Color:=clYellow;
    Chart6.Font.Size:=9;
    Chart6.InitMinuteTick;
    Chart6.IsDayTick:=True;//显示成日期格式
    Chart6.TickVisible:=True;
    Chart6.TickColor:=clYellow;
    Chart6.TickLength:=5;
    Chart6.TickTransparent:=128;
    Chart6.HLineVisible:=True;
    Chart6.HLineColor:=clGray;
    Chart6.HLineTransparent:=128;
    Chart6.EveryCol:=30;
  end;
  Chart6.Left:=Chart3.Left+5;
  Chart6.Top:=Chart3.Top+Chart3.Height;
  Chart6.Width:=Chart3.Width-5;
  Chart6.Height:=Chart3.Height;
  Chart3.ColCount:=Chart6.ColCount;
  if not Assigned(Chart7) then
  begin
    Chart7:=TMyChartLine.Create(Self);
    Chart7.Bitmap:=Box.Buffer;
    Chart7.AutoRange:=True;
    Chart7.DisplayCount:=Chart6.Data.Count-50;
    Chart7.ColCount:=Chart6.Data.Count;
    //初始化数据集
    for i:=0 to Chart7.ColCount-1 do
    begin
      Chart7.Data.Append(Random(100));
    end;
  end;
  Chart7.LineColor:=ColorButton3.ButtonColor;
  Chart7.LineWidth:=SpinEdit1.Value;
  Chart7.Left:=Chart3.Left+5;
  Chart7.Top:=Chart3.Top;
  Chart7.Width:=Chart3.Width-5;
  Chart7.Height:=Chart3.Height;
  if not Assigned(Chart8) then
  begin
    Chart8:=TMyChartVolume.Create(Self);
    Chart8.Bitmap:=Box.Buffer;
    Chart8.DisplayCount:=Chart7.DisplayCount;
    Chart8.ColCount:=Chart7.ColCount;
    Chart8.AutoRange:=True;
    //初始化数据集
    for i:=0 to Chart8.ColCount-1 do
    begin
      Chart8.Data.Append(Random(100));
    end;
  end;
  Chart8.Top:=Chart3.Top+Chart3.Height div 2;
  Chart8.Left:=Chart3.Left;
  Chart8.Width:=Chart3.Width;
  Chart8.Height:=Chart3.Height div 2;
  Chart8.LineWidth:=2;
  Chart8.LineColor:=clWhite;
  Chart8.BarColor:=$800000;
  Chart8.IsBar:=False;

  Chart3.Caption:='';
  //Chart3.Background.LoadFromFile(ExtractFilepath(Application.ExeName)+'bg.png');
  Chart3.BackgroundCenter:=True;
  Chart3.BackgroundTop:=Chart3.Height-Chart3.Background.Height;
  Chart3.BackgroundLeft:=Chart3.Width-Chart3.Background.Width;
  Chart3.BackgroundStretch:=False;
  Chart3.Transparent:=False;
  Chart3.Gradient:=True;
  Chart3.FromColor:=clBlack;
  Chart3.EndColor:=clBlue;
  Chart3.VerticalGradient:=True;
  Chart3.BorderColor:=clGray;
  Chart3.BorderWidth:=1;
  Chart3.BorderVisible:=True;
  Chart3.ColCount:=10;
  Chart3.FixRowHeight:=30;
  Chart3.VGridTransparent:=255;
  Chart3.HGridTransparent:=255;
  Chart4.FixedRowHeight:=Chart3.FixRowHeight;
  Box.Buffer.Clear;
  Chart3.PaintEx(Chart3.Left,Chart3.Top);
  Chart5.PaintEx(Chart5.Left,Chart5.Top);
  Chart6.PaintEx(Chart6.Left,Chart6.Top);
  Chart8.PaintEx(Chart8.Left,Chart8.Top);
  Chart7.PaintEx(Chart7.Left,Chart7.Top);

  Chart4.MaxValue:=Chart7.MaxValue;
  Chart4.MinValue:=Chart7.MinValue;
  Chart4.PaintEx(Chart4.Left,Chart4.Top);
  Box.Invalidate;
end;

procedure TfrmMain.Button8Click(Sender: TObject);
var
  m:integer;
  mFPS:double;
  n,i:integer;
begin
  n:=0;
  for i:=0 to 99 do
  begin
    m:=GetTickCount;
    Button7.Click;
    Application.ProcessMessages;
    n:=n+GetTickCount-m;
  end;
  //n=100次运行的毫秒数
  mFPS:=1000/(n/100);
  ShowMessage('FPS:'+FloatToStr(mFPS));
end;

procedure TfrmMain.Button9Click(Sender: TObject);
var
  i:integer;
  mFile:TStrings;
begin
  //把X坐标输出到文件
  mFile:=TStringList.Create;
  for i:=0 to Chart6.Data.Count-1 do
  begin
    mFile.Add(inttostr(i)+','+inttostr(Chart6.Data.Item(i)));
  end;
  mFile.SaveToFile(ExtractFilepath(Application.ExeName)+'x.txt');
  mFile.Free;
  ShowMessage('OK');
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  //Application.OnIdle:=@AppIdle;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
end;

procedure TfrmMain.AppIdle(Sender: TObject; var Done: Boolean);
begin
  Box.Buffer.Clear;
  if Assigned(Chart3) then
  begin
    Chart3.BackgroundLeft:=Chart3.BackgroundLeft+1;
    if Chart3.BackgroundLeft>Chart3.Width then
      Chart3.BackgroundLeft:=0;
    Chart3.PaintEx(Chart3.Left,Chart3.Top);
  end;
  if Assigned(Chart4) then
  begin
    Chart4.PaintEx(Chart4.Left,Chart4.Top);
  end;
  Box.Invalidate;
end;

end.

