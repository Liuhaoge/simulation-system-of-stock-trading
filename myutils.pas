unit myutils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLIntf, GR32, GR32_Image, Graphics;


{绘制渐变色，全局背景}
procedure MyGradientBackground(AStart,AEnd:TColor;ABitmap:TBitmap32;AHeight,AWidth:integer;ASteps:integer=100);//绘制垂直渐变色
procedure MyGradientBackGroundH(AStart,AEnd:TColor;ABitmap:TBitmap32;AHeight,AWidth:integer;ASteps:integer=100);//绘制水平渐变色
{部分区域背景}
procedure MyGradientArea(AStart,AEnd:TColor;ABitmap:TBitmap32;ATop,ALeft,AHeight,AWidth:integer;ASteps:integer=100);//绘制垂直渐变色
procedure MyGradientAreaH(AStart,AEnd:TColor;ABitmap:TBitmap32;ATop,ALeft,AHeight,AWidth:integer;ASteps:integer=100);//绘制垂直渐变色
{处理坐标轴标签}
function SmartLabel(AValue:Extended;ADec:integer):string;overload;
function SmartLabel(AValue:int64):string;overload;
function GetFormatStr(ADec:integer):string;
{整数值转换为时分字符串}
function IntTimeToStr(AValue:integer):string;
procedure DrawString(ABitmap:TBitmap32;AX,AY:integer;AString:string;AFontName:ShortString;AFontColor:TColor;AFontStyle:TFontStyles;AFontSize:integer;AlignLeft:boolean=True);

implementation

procedure DrawString(ABitmap:TBitmap32;AX,AY:integer;AString:string;AFontName:ShortString;AFontColor:TColor;AFontStyle:TFontStyles;AFontSize:integer;AlignLeft:boolean=True);
begin
  ABitmap.Font.Name:=AFontName;
  ABitmap.Font.Style:=AFontStyle;
  ABitmap.Font.Size:=AFontSize;
  ABitmap.Font.Color:=AFontColor;
  if AlignLeft then
    ABitmap.Textout(AX,AY,AString)
  else
    ABitmap.Textout(AX-ABitmap.TextWidth(AString),AY,AString);
end;

procedure MyGradientBackground(AStart, AEnd: TColor; ABitmap: TBitmap32;AHeight,AWidth:integer;ASteps:integer=100);
var
  i:integer;
  J,K:Real;
  Deltas: array [0..2] of Real;
  R:TRect;
  LStartRGB, lEndRGB:TColor;
  LSteps:Word;
  BufferWidth,BufferHeight:integer;
begin
  LSteps:=ASteps;
  LStartRGB:=ColorToRGB(AStart);
  LEndRGB:=ColorToRGB(AEnd);
  BufferWidth:=AWidth;
  BufferHeight:=AHeight;
  if LSteps>BufferHeight then
    LSteps:=BufferHeight;
  if LSteps<1 then
    LSteps:=1;
  Deltas[0]:=(GetRValue(LEndRGB)-GetRValue(LStartRGB))/LSteps;
  Deltas[1]:=(GetGValue(LEndRGB)-GetGValue(LStartRGB))/LSteps;
  Deltas[2]:=(GetBValue(LEndRGB)-GetBValue(LStartRGB))/LSteps;
  ABitmap.Canvas.Brush.Style:=bsSolid;
  J:=BufferHeight/LSteps;
  for i:=0 to LSteps do
  begin
    R.Left:=BufferWidth;
    R.Right:=0;
    R.Top:=Round(I*J);
    R.Bottom:=Round((i+1)*j);
    ABitmap.Canvas.Brush.Color:=RGB(
      Round(GetRValue(LStartRGB)+i*Deltas[0]),
      Round(GetGValue(LStartRGB)+i*Deltas[1]),
      Round(GetBValue(LStartRGB)+i*Deltas[2])
    );
    ABitmap.Canvas.FillRect(R);
  end;
end;

procedure MyGradientBackGroundH(AStart, AEnd: TColor; ABitmap: TBitmap32;
  AHeight, AWidth: integer; ASteps: integer);
var
  i:integer;
  J,K:Real;
  Deltas: array [0..2] of Real;
  R:TRect;
  LStartRGB, lEndRGB:TColor;
  LSteps:Word;
  BufferWidth,BufferHeight:integer;
begin
  LSteps:=ASteps;
  LStartRGB:=ColorToRGB(AStart);
  LEndRGB:=ColorToRGB(AEnd);
  BufferWidth:=AWidth;
  BufferHeight:=AHeight;
  if LSteps>BufferWidth then
    LSteps:=BufferWidth;
  if LSteps<1 then
    LSteps:=1;
  Deltas[0]:=(GetRValue(LEndRGB)-GetRValue(LStartRGB))/LSteps;
  Deltas[1]:=(GetGValue(LEndRGB)-GetGValue(LStartRGB))/LSteps;
  Deltas[2]:=(GetBValue(LEndRGB)-GetBValue(LStartRGB))/LSteps;
  ABitmap.Canvas.Brush.Style:=bsSolid;
  J:=BufferWidth/LSteps;
  for i:=0 to LSteps do
  begin
    R.Left:=Round(i*j);
    R.Right:=Round((i+1)*j);
    R.Top:=0;
    R.Bottom:=BufferHeight;
    ABitmap.Canvas.Brush.Color:=RGB(
      Round(GetRValue(LStartRGB)+i*Deltas[0]),
      Round(GetGValue(LStartRGB)+i*Deltas[1]),
      Round(GetBValue(LStartRGB)+i*Deltas[2])
    );
    ABitmap.Canvas.FillRect(R);
  end;
end;

procedure MyGradientArea(AStart, AEnd: TColor; ABitmap: TBitmap32; ATop, ALeft,
  AHeight, AWidth: integer; ASteps: integer);
var
  i:integer;
  J,K:Real;
  Deltas: array [0..2] of Real;
  R:TRect;
  LStartRGB, lEndRGB:TColor;
  LSteps:Word;
  BufferWidth,BufferHeight:integer;
begin
  LSteps:=ASteps;
  LStartRGB:=ColorToRGB(AStart);
  LEndRGB:=ColorToRGB(AEnd);
  BufferWidth:=AWidth;
  BufferHeight:=AHeight;
  if LSteps>BufferHeight then
    LSteps:=BufferHeight;
  if LSteps<1 then
    LSteps:=1;
  Deltas[0]:=(GetRValue(LEndRGB)-GetRValue(LStartRGB))/LSteps;
  Deltas[1]:=(GetGValue(LEndRGB)-GetGValue(LStartRGB))/LSteps;
  Deltas[2]:=(GetBValue(LEndRGB)-GetBValue(LStartRGB))/LSteps;
  ABitmap.Canvas.Brush.Style:=bsSolid;
  J:=BufferHeight/LSteps;
  for i:=0 to LSteps do
  begin
    R.Left:=ALeft+BufferWidth;
    R.Right:=ALeft;
    R.Top:=ATop+Round(I*J);
    R.Bottom:=ATop+Round((i+1)*j);
    ABitmap.Canvas.Brush.Color:=RGB(
      Round(GetRValue(LStartRGB)+i*Deltas[0]),
      Round(GetGValue(LStartRGB)+i*Deltas[1]),
      Round(GetBValue(LStartRGB)+i*Deltas[2])
    );
    ABitmap.Canvas.FillRect(R);
  end;
end;

procedure MyGradientAreaH(AStart, AEnd: TColor; ABitmap: TBitmap32; ATop,
  ALeft, AHeight, AWidth: integer; ASteps: integer);
var
  i:integer;
  J,K:Real;
  Deltas: array [0..2] of Real;
  R:TRect;
  LStartRGB, lEndRGB:TColor;
  LSteps:Word;
  BufferWidth,BufferHeight:integer;
begin
  LSteps:=ASteps;
  LStartRGB:=ColorToRGB(AStart);
  LEndRGB:=ColorToRGB(AEnd);
  BufferWidth:=AWidth;
  BufferHeight:=AHeight;
  if LSteps>BufferWidth then
    LSteps:=BufferWidth;
  if LSteps<1 then
    LSteps:=1;
  Deltas[0]:=(GetRValue(LEndRGB)-GetRValue(LStartRGB))/LSteps;
  Deltas[1]:=(GetGValue(LEndRGB)-GetGValue(LStartRGB))/LSteps;
  Deltas[2]:=(GetBValue(LEndRGB)-GetBValue(LStartRGB))/LSteps;
  ABitmap.Canvas.Brush.Style:=bsSolid;
  J:=BufferWidth/LSteps;
  for i:=0 to LSteps-1 do
  begin
    R.Left:=ALeft+Round(i*j);
    R.Right:=ALeft+Round((i+1)*j);
    R.Top:=ATop;
    R.Bottom:=ATop+BufferHeight;
    ABitmap.Canvas.Brush.Color:=RGB(
      Round(GetRValue(LStartRGB)+i*Deltas[0]),
      Round(GetGValue(LStartRGB)+i*Deltas[1]),
      Round(GetBValue(LStartRGB)+i*Deltas[2])
    );
    ABitmap.Canvas.FillRect(R);
  end;
end;

function SmartLabel(AValue:Extended;ADec:integer):string;
var
  mValue:Extended;
  mFix:string;
begin
  if AValue>=1000000 then
  begin
    mValue:=AValue/1000000;
    mFix:='M';
  end
  else
  if AValue>=1000 then
  begin
    mValue:=AValue/1000;
    mFix:='K';
  end
  else
  begin
    mValue:=AValue;
    mFix:='';
  end;
  result:=FormatFloat(GetFormatStr(ADec),mValue)+mFix;
end;

function SmartLabel(AValue:int64):string;
begin
  if AValue>=1000 then
    result:=SmartLabel(AValue,0)
  else
    result:=inttostr(AValue);
end;

function GetFormatStr(ADec:integer):string;
var
  i:integer;
begin
  result:='#0.';
  for i:=1 to ADec do
  begin
    result:=result+'0';
  end;
end;

function IntTimeToStr(AValue: integer): string;
var
  mH,mM,mS:integer;
begin
  mH:=AValue div 10000;
  mM:=(AValue mod 10000) div 100;
  mS:=(AValue mod 10000) mod 100;
  Result:=inttostr(mH)+':'+Format('%.2d:%.2d',[mM,mS]);
end;

end.

