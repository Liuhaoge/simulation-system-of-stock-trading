unit myclasses2;
{
  行情数据！     行情数据！      行情数据！
  行情数据！     行情数据！      行情数据！
  行情数据！     行情数据！      行情数据！
}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, TplZlibUnit;
type
  //股票列表记录
  TMyStockItem = packed record
    Code:string[6];
    Caption:string[20];
    Market:string[2];
  end;
  PMyStockItem = ^TMyStockItem;

  //股票列表管理对象
  { TMyStocks }

  TMyStocks = class(TComponent)
  private
    FList:TList;
    function GetCount: integer;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure Clear; //清除所有数据
    procedure LoadFromFile(Afilename:String);//从文件读数据
    procedure SaveToFile(AFilename:string);//保存数据到文件
    function Add(AValue:TMyStockItem):integer;//增加
    function IndexOf(ACode,AMarket:string):integer;//查找
    function Item(AIndex:integer):TMyStockItem;//返回数据
    procedure Update(AIndex:integer;AValue:TMyStockItem); //更新数据
    property Count:integer read GetCount;//记录条数
  end;

  //文件记录对象基类
  { TL2DataFile }

  TL2DataFile = class(TComponent)
  private
    FCompress: boolean;
    FDataType: string;
    FFilename: string;
    FFrameInterval: integer;
    FList:TList;//记录对象
    FMarket: string;
    FSecirityType: string;
    FSecutityCode: string;
    function GetCount: integer;
  public
    FFrameMap:array of String;//存储Frame目录，数组下标为Frame索引，数组内容为逗号间隔的数据项FList下标
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

    procedure Clear;//清除全部对象
    function Add(AValue:Pointer):integer;//增加记录
    function Item(AIndex:integer):Pointer;//返回指定下标的对象指针
    procedure SaveToStream(AStream:TStream);virtual;//写入流
    procedure LoadFromStream(AStream:TStream);virtual;//从流中读入
    procedure SaveToFile(AFilename:string);//写入文件
    procedure LoadFromFile(AFilename:string);//从文件读入

    procedure InitFrameMap;//初始化FFrameMap数据
    function  CalcFrameIndex(ATime:int32):integer;//根据输入的时间，计算应该属于的FrameMap下标
    procedure ReadFrame(AFrameIndex:integer;AStream:TStream);virtual;//按照FrameMap的下标读取帧数据，写入流

    property FrameInterval:integer read FFrameInterval write FFrameInterval;//帧间隔时间，单位为秒
    property Count:integer read GetCount;//对象个数
    property SecutityCode:string read FSecutityCode write FSecutityCode;//股票代码
    property SecirityType:string read FSecirityType write FSecirityType;//股票类型（股票、指数）
    property Market:string read FMarket write FMarket;//所属市场
    property DataType:string read FDataType write FDataType;//数据类型 行情快照 盘口 逐笔成交
    property Filename:string read FFilename write FFilename;//数据文件名
    property Compress:boolean read FCompress write FCompress;//是否使用压缩
  end;

  //指数记录
  TL2IndexItem = packed record
    date:integer;//日期
    publish_time:integer;//发布时间
    code:string[6];//代码
    last_close:double;//前收盘
    open:double;//今开盘
    high:double;//最高价
    low:double;//最低价
    close:double;//收盘价 最新价 现价
    amount:double;//成交额（暂时没用）
    volume:int64;//成交量（暂时没用）
  end;
  PL2IndexItem = ^TL2IndexItem;
  TL2IndexItemArray = array of TL2IndexItem;

  //指数记录文件对象
  { TL2IndexDataFile }

  TL2IndexDataFile = class(TL2DataFile)
  public
    function Add(AValue:TL2IndexItem):integer;overload;
    function Item(AIndex:integer):PL2IndexItem;overload;
    procedure SaveToStream(AStream:TStream);override;
    procedure LoadFromStream(AStream:TStream);override;
    procedure ReadFrame(AFrameIndex:integer;AStream:TStream);override;//按照FrameMap的下标读取帧数据，写入流
    procedure ReadFrameToArray(AFrameIndex:integer;var AArray:TL2IndexItemArray);
  end;

  //快照记录
  TL2SnapItem = packed record
    date:int32;//日期
    publish_time:integer;//发布时间
    code:string[6];//代码
    last_close:double;//前收盘
    open:double;//今开
    high:double;//最高
    low:double;//最低
    close:double;//收盘
    volume:int64;//成交量
    amount:double;//成交额
  end;
  PL2SnapItem = ^TL2SnapItem;
  TL2SnapItemArray = array of TL2SnapItem;

  //快照记录文件
  { TL2SnapDataFile }

  TL2SnapDataFile = class(TL2DataFile)
  public
    function Add(AValue:TL2SnapItem):integer;overload;
    function Item(AIndex:integer):PL2SnapItem;overload;
    procedure SaveToStream(AStream:TStream);override;
    procedure LoadFromStream(AStream:TStream);override;
    procedure ReadFrame(AFrameIndex:integer;AStream:TStream);override;//按照FrameMap的下标读取帧数据，写入流
    procedure ReadFrameToArray(AFrameIndex:integer;var AArray:TL2SnapItemArray);
  end;

  //盘口报价记录
  TL2SnapDWItem = packed record
    date:integer;//日期
    publish_time:integer;//发布时间
    code:string[6];//代码
    sell_1:double;//卖1价格
    sell_2:double;//卖2价格
    sell_3:double;//卖3价格
    sell_4:double;//卖4价格
    sell_5:double;//卖5价格
    sell_6:double;//卖6价格
    sell_7:double;//卖7价格
    sell_8:double;//卖8价格
    sell_9:double;//卖9价格
    sell_10:double;//卖10价格
    buy_1:double;//买1价格
    buy_2:double;//买2价格
    buy_3:double;//买3价格
    buy_4:double;//买4价格
    buy_5:double;//买5价格
    buy_6:double;//买6价格
    buy_7:double;//买7价格
    buy_8:double;//买8价格
    buy_9:double;//买9价格
    buy_10:double;//买10价格
    sell_1_vol:integer;//卖1量
    sell_2_vol:integer;//卖1量
    sell_3_vol:integer;//卖1量
    sell_4_vol:integer;//卖1量
    sell_5_vol:integer;//卖1量
    sell_6_vol:integer;//卖1量
    sell_7_vol:integer;//卖1量
    sell_8_vol:integer;//卖1量
    sell_9_vol:integer;//卖1量
    sell_10_vol:integer;//卖1量
    buy_1_vol:integer;//买1量
    buy_2_vol:integer;//买2量
    buy_3_vol:integer;//买3量
    buy_4_vol:integer;//买4量
    buy_5_vol:integer;//买5量
    buy_6_vol:integer;//买6量
    buy_7_vol:integer;//买7量
    buy_8_vol:integer;//买8量
    buy_9_vol:integer;//买9量
    buy_10_vol:integer;//买10量
  end;
  PL2SnapDWItem = ^TL2SnapDWItem;
  TL2SnapDWItemArray = array of TL2SnapDWItem;

  //盘口报价记录文件
  { TL2SnapDWDataFile }
  TL2SnapDWDataFile = class(TL2DataFile)
  public
    function Add(AValue:TL2SnapDWItem):integer;overload;
    function Item(AIndex:integer):PL2SnapDWItem;overload;
    procedure SaveToStream(AStream:TStream);override;
    procedure LoadFromStream(AStream:TStream);override;
    procedure ReadFrame(AFrameIndex:integer;AStream:TStream);override;//按照FrameMap的下标读取帧数据，写入流
    procedure ReadFrameToArray(AFrameIndex:integer;var AArray:TL2SnapDWItemArray);
  end;

implementation

//股票列表
{ TMyStocks }

function TMyStocks.GetCount: integer;
begin
  Result:=FList.Count;
end;

constructor TMyStocks.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList:=TList.Create;
end;

destructor TMyStocks.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TMyStocks.Clear;
var
  i:integer;
begin
  for i:=0 to FList.Count-1 do
  begin
    Dispose(PMyStockItem(FList.Items[i]));
  end;
  FList.Clear;
end;

procedure TMyStocks.LoadFromFile(Afilename: String);
var
  mcount:integer;
  mFile:TFileStream;
  i:integer;
  mItem:TMyStockItem;
begin
  mFile:=TFileStream.Create(AFilename,fmOpenRead);
  Clear;
  mFile.Seek(0,soBeginning);
  mFile.Read(mcount,sizeof(mcount));
  for i:=0 to mCount-1 do
  begin
    mFile.Read(mItem,sizeof(mItem));
    if strtoint(mItem.Code)<2705 then  Add(mItem);  //只导入证券，不导入指数
  end;
  mFile.Free;
end;

procedure TMyStocks.SaveToFile(AFilename: string);
var
  mcount:integer;
  mFile:TFileStream;
  i:integer;
  mItem:TMyStockItem;
begin
  mFile:=TFileStream.Create(AFilename,fmCreate);
  mCount:=FList.Count;
  mFile.Seek(0,soBeginning);
  mFile.Write(mcount,sizeof(mCount));
  for i:=0 to mcount-1 do
  begin
    mItem:=Self.Item(i);
    mFile.Write(mItem,sizeof(mItem));
  end;
  mFile.Free;
end;

function TMyStocks.Add(AValue: TMyStockItem): integer;
var
  m:PMyStockItem;
begin
  new(m);
  m^.Caption:=AValue.Caption;
  m^.Code:=AValue.Code;
  m^.Market:=AValue.Market;
  Result:=FList.Add(m);
end;

function TMyStocks.IndexOf(ACode, AMarket: string): integer;
var
  i:integer;
  mItem:TMyStockItem;
begin
  Result:=-1;
  for i:=0 to FList.Count-1 do
  begin
    mItem:=Self.Item(i);
    if (mItem.Code=ACode) and (mItem.Market=AMarket) then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

function TMyStocks.Item(AIndex: integer): TMyStockItem;
var
  m:PMyStockItem;
begin
  m:=PMyStockItem(FList.Items[AIndex]);
  Result.Code:=m^.Code;
  Result.Caption:=m^.Caption;
  Result.Market:=m^.Market;
end;

procedure TMyStocks.Update(AIndex: integer; AValue: TMyStockItem);
var
  m:PMyStockItem;
begin
  if Aindex < Flist.count then
  begin
    m:=PMyStockItem(FList.Items[AIndex]);
    m^.code:=AValue.code;
    m^.caption:=AValue.caption;
    m^.market:=AValue.Market;
  end;
end;


{ TL2SnapDWDataFile }

function TL2SnapDWDataFile.Add(AValue: TL2SnapDWItem): integer;
var
  m:PL2SnapDWItem;
begin
  new(m);
  with m^ do
  begin
    date:=AValue.date;//日期
    publish_time:=AValue.publish_time;//发布时间
    code:=AValue.code;//代码
    sell_1:=AValue.sell_1;//卖1价格
    sell_2:=AValue.sell_2;//卖2价格
    sell_3:=AValue.sell_3;//卖3价格
    sell_4:=AValue.sell_4;//卖4价格
    sell_5:=AValue.sell_5;//卖5价格
    sell_6:=AValue.sell_6;//卖6价格
    sell_7:=AValue.sell_7;//卖7价格
    sell_8:=AValue.sell_8;//卖8价格
    sell_9:=AValue.sell_9;//卖9价格
    sell_10:=AValue.sell_10;//卖10价格
    buy_1:=AValue.buy_1;//买1价格
    buy_2:=AValue.buy_2;//买2价格
    buy_3:=AValue.buy_3;//买3价格
    buy_4:=AValue.buy_4;//买4价格
    buy_5:=AValue.buy_5;//买5价格
    buy_6:=AValue.buy_6;//买6价格
    buy_7:=AValue.buy_7;//买7价格
    buy_8:=AValue.buy_8;//买8价格
    buy_9:=AValue.buy_9;//买9价格
    buy_10:=AValue.buy_10;//买10价格
    sell_1_vol:=AValue.sell_1_vol;//卖1量
    sell_2_vol:=AValue.sell_2_vol;//卖1量
    sell_3_vol:=AValue.sell_3_vol;//卖1量
    sell_4_vol:=AValue.sell_4_vol;//卖1量
    sell_5_vol:=AValue.sell_5_vol;//卖1量
    sell_6_vol:=AValue.sell_6_vol;//卖1量
    sell_7_vol:=AValue.sell_7_vol;//卖1量
    sell_8_vol:=AValue.sell_8_vol;//卖1量
    sell_9_vol:=AValue.sell_9_vol;//卖1量
    sell_10_vol:=AValue.sell_10_vol;//卖1量
    buy_1_vol:=AValue.buy_1_vol;//买1量
    buy_2_vol:=AValue.buy_2_vol;//买2量
    buy_3_vol:=AValue.buy_3_vol;//买3量
    buy_4_vol:=AValue.buy_4_vol;//买4量
    buy_5_vol:=AValue.buy_5_vol;//买5量
    buy_6_vol:=AValue.buy_6_vol;//买6量
    buy_7_vol:=AValue.buy_7_vol;//买7量
    buy_8_vol:=AValue.buy_8_vol;//买8量
    buy_9_vol:=AValue.buy_9_vol;//买9量
    buy_10_vol:=AValue.buy_10_vol;//买10量
  end;
  Result:=FList.Add(m);
end;

function TL2SnapDWDataFile.Item(AIndex: integer): PL2SnapDWItem;
begin
  Result:=nil;
  if AIndex<Flist.Count then
    Result:=PL2SnapDWItem(FList.Items[AIndex]);
end;

procedure TL2SnapDWDataFile.SaveToStream(AStream: TStream);
var
  i:integer;
  m:PL2SnapDWItem;
begin
  AStream.Seek(0,soBeginning);
  for i:=0 to FList.Count-1 do
  begin
    m:=Self.Item(i);
    AStream.Write(m^,Sizeof(m^));
  end;
end;

procedure TL2SnapDWDataFile.LoadFromStream(AStream: TStream);
var
  i,mCount:integer;
  m:TL2SnapDWItem;
  mIndex,mFrameIndex:integer;
begin
  Self.Clear;
  mCount:= AStream.Size div sizeof(m);
  AStream.Seek(0,soBeginning);
  for i:=0 to mCount-1 do
  begin
    AStream.Read(m,sizeof(m));
    mIndex:=Self.Add(m);
    if Length(FFrameMap)>0 then
    begin
      //如果Framemap已经初始化，则填充FrampMap数组
      mFrameIndex:=Self.CalcFrameIndex(m.publish_time);
      if (mFrameIndex<Length(FFrameMap)) and (mFrameIndex<>-1) then
         FFrameMap[mFrameIndex]:=FFrameMap[mFrameIndex]+inttostr(mIndex)+',';
    end;
  end;
end;

procedure TL2SnapDWDataFile.ReadFrame(AFrameIndex: integer; AStream: TStream);
var
  mTmp:TStrings;
  mLine:string;
  mCount:int32;
  i,mIndex:integer;
  mItem:PL2SnapDWItem;
begin
  mLine:=FFrameMap[AFrameIndex];
  mTmp:=TStringList.Create;
  ExtractStrings([','],[],PAnsiChar(mLine),mTmp);
  if mTmp.Count>1 then
  begin
    //清除空行
    for i:=mTmp.Count-1 downto 0 do
    begin
      if Trim(mTmp.Strings[i])='' then
         mTmp.Delete(i);
    end;
  end;
  mCount:=mTmp.Count;
  AStream.Write(mCount,sizeof(mCount));
  if mCount>0 then
  begin
    for i:=0 to mTmp.Count-1 do
    begin
      mIndex:=strtoint(mTmp.Strings[i]);
      mItem:=Item(mIndex);
      AStream.Write(mItem^,sizeof(mItem^));
    end;
  end;
  mTmp.Free;
end;

procedure TL2SnapDWDataFile.ReadFrameToArray(AFrameIndex: integer;
  var AArray: TL2SnapDWItemArray);
var
  mTmp:TStrings;
  mLine:string;
  mCount:int32;
  i,mIndex:integer;
  mItem:PL2SnapDWItem;
begin
  mLine:=FFrameMap[AFrameIndex];
  mTmp:=TStringList.Create;
  ExtractStrings([','],[],PAnsiChar(mLine),mTmp);
  if mTmp.Count>1 then
  begin
    //清除空行
    for i:=mTmp.Count-1 downto 0 do
    begin
      if Trim(mTmp.Strings[i])='' then
         mTmp.Delete(i);
    end;
  end;
  mCount:=mTmp.Count;
  SetLength(AArray,mCount);
  if mCount>0 then
  begin
    for i:=0 to mTmp.Count-1 do
    begin
      mIndex:=strtoint(mTmp.Strings[i]);
      mItem:=Item(mIndex);
      AArray[i].code:=mItem^.code;
      AArray[i].date:=mItem^.date;
      AArray[i].publish_time:=mItem^.publish_time;
      AArray[i].buy_1:=mItem^.buy_1;
      AArray[i].buy_1_vol:=mItem^.buy_1_vol;
      AArray[i].buy_2:=mItem^.buy_2;
      AArray[i].buy_2_vol:=mItem^.buy_2_vol;
      AArray[i].buy_3:=mItem^.buy_3;
      AArray[i].buy_3_vol:=mItem^.buy_3_vol;
      AArray[i].buy_4:=mItem^.buy_4;
      AArray[i].buy_4_vol:=mItem^.buy_4_vol;
      AArray[i].buy_5:=mItem^.buy_5;
      AArray[i].buy_5_vol:=mItem^.buy_5_vol;
      AArray[i].buy_6:=mItem^.buy_6;
      AArray[i].buy_6_vol:=mItem^.buy_6_vol;
      AArray[i].buy_7:=mItem^.buy_7;
      AArray[i].buy_7_vol:=mItem^.buy_7_vol;
      AArray[i].buy_8:=mItem^.buy_8;
      AArray[i].buy_8_vol:=mItem^.buy_8_vol;
      AArray[i].buy_9:=mItem^.buy_9;
      AArray[i].buy_9_vol:=mItem^.buy_9_vol;
      AArray[i].buy_10:=mItem^.buy_10;
      AArray[i].buy_10_vol:=mItem^.buy_10_vol;
      AArray[i].sell_1:=mItem^.sell_1;
      AArray[i].sell_1_vol:=mItem^.sell_1_vol;
      AArray[i].sell_2:=mItem^.sell_2;
      AArray[i].sell_2_vol:=mItem^.sell_2_vol;
      AArray[i].sell_3:=mItem^.sell_3;
      AArray[i].sell_3_vol:=mItem^.sell_3_vol;
      AArray[i].sell_4:=mItem^.sell_4;
      AArray[i].sell_4_vol:=mItem^.sell_4_vol;
      AArray[i].sell_5:=mItem^.sell_5;
      AArray[i].sell_5_vol:=mItem^.sell_5_vol;
      AArray[i].sell_6:=mItem^.sell_6;
      AArray[i].sell_6_vol:=mItem^.sell_6_vol;
      AArray[i].sell_7:=mItem^.sell_7;
      AArray[i].sell_7_vol:=mItem^.sell_7_vol;
      AArray[i].sell_8:=mItem^.sell_8;
      AArray[i].sell_8_vol:=mItem^.sell_8_vol;
      AArray[i].sell_9:=mItem^.sell_9;
      AArray[i].sell_9_vol:=mItem^.sell_9_vol;
      AArray[i].sell_10:=mItem^.sell_10;
      AArray[i].sell_10_vol:=mItem^.sell_10_vol;
    end;
  end;
  mTmp.Free;
end;


{ TL2SnapDataFile }

function TL2SnapDataFile.Add(AValue: TL2SnapItem): integer;
var
  m:PL2SnapItem;
begin
  new(m);
  with m^ do
  begin
    date:=AValue.date;//日期
    publish_time:=AValue.publish_time;//发布时间
    code:=AValue.code;//代码
    last_close:=AValue.last_close;//前收盘
    open:=AValue.open;//今开
    high:=AValue.high;//最高
    low:=AValue.low;//最低
    close:=AValue.close;//收盘
    volume:=AValue.volume;//成交量
    amount:=AValue.amount;//成交额
  end;
  Result:=FList.Add(m);
end;

function TL2SnapDataFile.Item(AIndex: integer): PL2SnapItem;
begin
  Result:=nil;
  if AIndex < FList.Count then
    Result:= PL2SnapItem(FList.Items[AIndex]);
end;

procedure TL2SnapDataFile.SaveToStream(AStream: TStream);
var
  i:integer;
  m:PL2SnapItem;
begin
  AStream.Seek(0,soBeginning);
  for i:=0 to FList.Count-1 do
  begin
    m:=Self.Item(i);
    AStream.Write(m^,Sizeof(m^));
  end;
end;

procedure TL2SnapDataFile.LoadFromStream(AStream: TStream);
var
  i,mCount:integer;
  m:TL2SnapItem;
  mIndex:integer;
  mFrameIndex:integer;
begin
  Self.Clear;
  mCount:= AStream.Size div sizeof(m);
  AStream.Seek(0,soBeginning);
  for i:=0 to mCount-1 do
  begin
    AStream.Read(m,sizeof(m));
    mIndex:=Self.Add(m);
    if Length(FFrameMap)>0 then
    begin
      //如果Framemap已经初始化，则填充FrampMap数组
      mFrameIndex:=Self.CalcFrameIndex(m.publish_time);
      if (mFrameIndex<Length(FFrameMap)) and (mFrameIndex<>-1) then
         FFrameMap[mFrameIndex]:=FFrameMap[mFrameIndex]+inttostr(mIndex)+',';
    end;
  end;
end;

procedure TL2SnapDataFile.ReadFrame(AFrameIndex: integer; AStream: TStream);
var
  mTmp:TStrings;
  mLine:string;
  mCount:int32;
  i,mIndex:integer;
  mItem:PL2SnapItem;
begin
  mLine:=FFrameMap[AFrameIndex];
  mTmp:=TStringList.Create;
  ExtractStrings([','],[],PAnsiChar(mLine),mTmp);
  if mTmp.Count>1 then
  begin
    //清除空行
    for i:=mTmp.Count-1 downto 0 do
    begin
      if Trim(mTmp.Strings[i])='' then
         mTmp.Delete(i);
    end;
  end;
  mCount:=mTmp.Count;
  AStream.Write(mCount,sizeof(mCount));
  if mCount>0 then
  begin
    for i:=0 to mTmp.Count-1 do
    begin
      mIndex:=strtoint(mTmp.Strings[i]);
      mItem:=Item(mIndex);
      AStream.Write(mItem^,sizeof(mItem^));
    end;
  end;
  mTmp.Free;
end;

procedure TL2SnapDataFile.ReadFrameToArray(AFrameIndex: integer;
  var AArray: TL2SnapItemArray);
var
  mTmp:TStrings;
  mLine:string;
  mCount:int32;
  i,mIndex:integer;
  mItem:PL2SnapItem;
begin
  mLine:=FFrameMap[AFrameIndex];
  mTmp:=TStringList.Create;
  ExtractStrings([','],[],PAnsiChar(mLine),mTmp);
  if mTmp.Count>1 then
  begin
    //清除空行
    for i:=mTmp.Count-1 downto 0 do
    begin
      if Trim(mTmp.Strings[i])='' then
         mTmp.Delete(i);
    end;
  end;
  mCount:=mTmp.Count;
  SetLength(AArray,mCount);
  if mCount>0 then
  begin
    for i:=0 to mTmp.Count-1 do
    begin
      mIndex:=strtoint(mTmp.Strings[i]);
      mItem:=Item(mIndex);
      AArray[i].volume:=mItem^.volume;
      AArray[i].publish_time:=mItem^.publish_time;
      AArray[i].open:=mItem^.open;
      AArray[i].low:=mItem^.low;
      AArray[i].last_close:=mItem^.last_close;
      AArray[i].high:=mItem^.high;
      AArray[i].date:=mItem^.date;
      AArray[i].code:=mItem^.code;
      AArray[i].close:=mItem^.close;
      AArray[i].amount:=mItem^.amount;
    end;
  end;
  mTmp.Free;
end;


{ TL2IndexDataFile }

function TL2IndexDataFile.Add(AValue: TL2IndexItem): integer;
var
  m:PL2IndexItem;
begin
  new(m);
  with m^ do
  begin
    date:=AValue.date;//日期
    publish_time:=AValue.publish_time;//发布时间
    code:=AValue.code;//代码
    last_close:=AValue.last_close;//前收盘
    open:=AValue.open;//今开盘
    high:=AValue.high;//最高价
    low:=AValue.low;//最低价
    close:=AValue.close;//收盘价 最新价 现价
    amount:=AValue.amount;//成交额（暂时没用）
    volume:=AValue.volume;//成交量（暂时没用）
  end;
  Result:=FList.Add(m);
end;

function TL2IndexDataFile.Item(AIndex: integer): PL2IndexItem;
begin
  Result:=nil;
  if AIndex < FList.Count then
    Result:= PL2IndexItem(FList.Items[AIndex]);
end;

procedure TL2IndexDataFile.SaveToStream(AStream: TStream);
var
  i:integer;
  m:PL2IndexItem;
begin
  AStream.Seek(0,soBeginning);
  for i:=0 to FList.Count-1 do
  begin
    m:=Self.Item(i);
    AStream.Write(m^,Sizeof(m^));
  end;
end;

procedure TL2IndexDataFile.LoadFromStream(AStream: TStream);
var
  i,mCount:integer;
  m:TL2IndexItem;
  mIndex:integer;
  mFrameIndex:integer;
begin
  Self.Clear;
  mCount:= AStream.Size div sizeof(m);
  AStream.Seek(0,soBeginning);
  for i:=0 to mCount-1 do
  begin
    AStream.Read(m,sizeof(m));
    mIndex:=Self.Add(m);
    if Length(FFrameMap)>0 then
    begin
      //如果Framemap已经初始化，则填充FrampMap数组
      mFrameIndex:=Self.CalcFrameIndex(m.publish_time);
      if (mFrameIndex<Length(FFrameMap)) and (mFrameIndex<>-1) then
         FFrameMap[mFrameIndex]:=FFrameMap[mFrameIndex]+inttostr(mIndex)+',';
    end;
  end;
end;

procedure TL2IndexDataFile.ReadFrame(AFrameIndex: integer; AStream: TStream);
var
  mTmp:TStrings;
  mLine:string;
  mCount:int32;
  i,mIndex:integer;
  mItem:PL2IndexItem;
begin
  mLine:=FFrameMap[AFrameIndex];
  mTmp:=TStringList.Create;
  ExtractStrings([','],[],PAnsiChar(mLine),mTmp);
  if mTmp.Count>1 then
  begin
    //清除空行
    for i:=mTmp.Count-1 downto 0 do
    begin
      if Trim(mTmp.Strings[i])='' then
         mTmp.Delete(i);
    end;
  end;
  mCount:=mTmp.Count;
  AStream.Write(mCount,sizeof(mCount));
  if mCount>0 then
  begin
    for i:=0 to mTmp.Count-1 do
    begin
      mIndex:=strtoint(mTmp.Strings[i]);
      mItem:=Item(mIndex);
      AStream.Write(mItem^,sizeof(mItem^));
    end;
  end;
  mTmp.Free;
  mCount:=AStream.Size;
end;

procedure TL2IndexDataFile.ReadFrameToArray(AFrameIndex: integer;
  var AArray: TL2IndexItemArray);
var
  mTmp:TStrings;
  mLine:string;
  mCount:int32;
  i,mIndex:integer;
  mItem:PL2IndexItem;
begin
  mLine:=FFrameMap[AFrameIndex];
  mTmp:=TStringList.Create;
  ExtractStrings([','],[],PAnsiChar(mLine),mTmp);
  if mTmp.Count>1 then
  begin
    //清除空行
    for i:=mTmp.Count-1 downto 0 do
    begin
      if Trim(mTmp.Strings[i])='' then
         mTmp.Delete(i);
    end;
  end;
  mCount:=mTmp.Count;
  SetLength(AArray,mCount);
  if mCount>0 then
  begin
    for i:=0 to mTmp.Count-1 do
    begin
      mIndex:=strtoint(mTmp.Strings[i]);
      mItem:=Item(mIndex);
      AArray[i].amount:=mItem^.amount;
      AArray[i].close:=mItem^.close;
      AArray[i].code:=mItem^.code;
      AArray[i].date:=mItem^.date;
      AArray[i].high:=mItem^.high;
      AArray[i].last_close:=mItem^.last_close;
      AArray[i].low:=mItem^.low;
      AArray[i].open:=mItem^.open;
      AArray[i].publish_time:=mItem^.publish_time;
      AArray[i].volume:=mItem^.volume;
    end;
  end;
  mTmp.Free;
end;

{ TL2DataFile }

function TL2DataFile.GetCount: integer;
begin
  Result:=FList.Count;
end;

constructor TL2DataFile.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList:=TList.Create;
  FFrameInterval:=3;
end;

destructor TL2DataFile.Destroy;
begin
  FList.Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TL2DataFile.Clear;
var
  i:integer;
begin
  FList.Clear;
  for i:=0 to Length(FFrameMap)-1 do
  begin
    FFrameMap[i]:='';
  end;
end;

function TL2DataFile.Add(AValue: Pointer): integer;
begin
  Result:=FList.Add(AValue);
end;

function TL2DataFile.Item(AIndex: integer): Pointer;
begin
  Result:=FList.Items[AIndex];
end;

procedure TL2DataFile.SaveToStream(AStream: TStream);
begin

end;

procedure TL2DataFile.LoadFromStream(AStream: TStream);
begin

end;

procedure TL2DataFile.SaveToFile(AFilename: string);
var
  mFile:TFileStream;
  mMemory:TMemoryStream;
begin
  if Self.Compress then
  begin
    //使用压缩
    mMemory:=TMemoryStream.Create;
    Self.SaveToStream(mMemory);
    mFile:=TFileStream.Create(AFilename,fmCreate);
    CompressStreamZLib(mMemory,mFile);
    mFile.Free;
    mMemory.Free;
  end
  else
  begin
    //不使用压缩
    mFile:=TFileStream.Create(AFilename,fmCreate);
    Self.SaveToStream(mFile);
    mFile.Free;
  end;
end;

procedure TL2DataFile.LoadFromFile(AFilename: string);
var
  mFile:TFileStream;
  mMemory:TMemoryStream;
begin
  if Self.Compress then
  begin
    //使用压缩
    mMemory:=TMemoryStream.Create;
    mFile:=TFileStream.Create(AFilename,fmOpenRead);
    ExtractStreamZLib(mFile,mMemory);
    Self.LoadFromStream(mMemory);
    mMemory.Free;
    mFile.Free;
  end
  else
  begin
    //不使用压缩
    mFile:=TFileStream.Create(AFilename,fmOpenRead);
    Self.LoadFromStream(mFile);
    mFile.Free;
  end;
end;

procedure TL2DataFile.InitFrameMap;
var
  m,i:integer;
begin
  if FFrameInterval=0 then
     FFrameInterval:=3;
  m:=15000 div FFrameInterval;//09:25-11:30 13:00-15:05
  Setlength(FFrameMap,m);
  for i:=0 to Length(FFrameMap)-1 do
  begin
    FFrameMap[i]:='';
  end;
end;

function TL2DataFile.CalcFrameIndex(ATime: int32): integer;
var
  m1,m2:TDatetime;
  mH,mM,mS:integer;
  mSeconds:integer;
begin
  mH:=ATime div 10000;
  mM:=(ATime - mH*10000) div 100;
  mS:=ATime - mH*10000 - mM*100;
  m2:=EncodeTime(mH,mM,mS,0);
  if ATime<=113000 then
  begin
    //上午交易时间
    m1:=EncodeTime(9,25,1,0);
    mSeconds:=SecondsBetween(m1,m2);
    Result:=mSeconds div FFrameInterval;
  end
  else
  if (ATime>113000) and (ATime<130000) then
  begin
    //中午休息时间，跳过
    Result:=-1;
  end
  else
  if (ATime>=130000) and (ATime<=150500) then
  begin
    //下午交易时间
    m1:=EncodeTime(13,0,0,0);

    mSeconds:=SecondsBetween(m1,m2);
    Result:=mSeconds div FFrameInterval + 7500 div FFrameInterval;
  end;
end;

procedure TL2DataFile.ReadFrame(AFrameIndex: integer; AStream: TStream);
begin
  //虚方法
end;



{  //股票行情数据
  TMyQuoteItem = packed record
    ADate:integer;
    ATime:integer;
    Open:double;
    High:double;
    Low:double;
    Close:double;
    Vol:integer;
  end;
  PMyQuoteItem=^TMyQuoteItem;

  //单个股票行情管理对象

  { TMyQuote }

  TMyQuote = class(TComponent)
  private
    FCaption: string;
    FCode: string;
    FList: TList;
    FMarket: string;
    function GetCount: integer;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Clear;
    procedure LoadFromFile(AFilename:string);
    procedure SaveToFile(AFilename:String);
    function Add(AValue:TMyQuoteItem):integer;
    function IndexOf(ADate,Atime:integer):integer;
    function Item(AIndex:integer):TMyQuoteItem;
    property Count:integer read GetCount;
    property Code:string read FCode write FCode;
    property Market:string read FMarket write FMarket;
    property Caption:string read FCaption write FCaption;
  end;

  //多个股票的行情总表对象

  { TMyQuotes }

  TMyQuotes = class(TComponent)
  private
    FList:TObjectList;     //管理对象为TMyQuote的列表
    function GetCount: integer;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Clear;
    function Add(ACode,ACaption,AMarket:string):integer;
    function IndexOf(ACode,AMarket:string):integer;
    function Item(AIndex:integer):TMyQuote;
    procedure SaveListToFile(AFilename:string);//保存列表到文件
    procedure LoadListFromFile(AFilename:String);//读取列表文件
    procedure SaveDataToFile(ADir:string);//保存所有数据到各自的文件
    procedure LoadDataFromFile(ADir:string);//所有对象读取各自的数据文件
    property Count:integer read GetCount;
  end;


  //股票盘口数据
  {TMyHandicapItem}
  TMyHAndicapItem = packed record
    ADate:integer;
    ATime:integer;

    ratio:double; //量比
    //卖盘
    sealprice1:double;    //卖一价
    sealvolume1:integer;   //卖一成交量
    sealprice2:double;		sealvolume2:integer;
    sealprice3:double;		sealvolume3:integer;
    sealprice4:double;		sealvolume4:integer;
    sealprice5:double;		sealvolume5:integer;
    sealprice6:double;		sealvolume6:integer;
    sealprice7:double;		sealvolume7:integer;
    sealprice8:double;		sealvolume8:integer;
    sealprice9:double;		sealvolume9:integer;
    sealprice10:double;		sealvolume10:integer;
    //买盘
    buyprice1:double;    //买一价
    buyvolume1:integer;   //买一成交量
    buyprice2:double;		buyvolume2:integer;
    buyprice3:double;		buyvolume3:integer;
    buyprice4:double;		buyvolume4:integer;
    buyprice5:double;		buyvolume5:integer;
    buyprice6:double;		buyvolume6:integer;
    buyprice7:double;		buyvolume7:integer;
    buyprice8:double;		buyvolume8:integer;
    buyprice9:double;		buyvolume9:integer;
    buyprice10:double;		buyvolume10:integer;
  end;
  PMyHAndicapItem=^TMyHAndicapItem;

//单个股票盘口管理对象
{ TMyHandicap }

  TMyHandicap = class(TComponent)
  private
    FCaption: string;
    FCode: string;
    FList:TList;
    FMarket: string;
    function GetCount: integer;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Clear;
    procedure LoadFromFile(AFilename:string);
    procedure SaveToFile(AFilename:String);
    function Add(AValue:TMyHandicapItem):integer;
    function IndexOf(ADate,Atime:integer):integer;
    function Item(AIndex:integer):TMyHandicapItem;
    property Count:integer read GetCount;
    property Code:string read FCode write FCode;
    property Market:string read FMarket write FMarket;
    property Caption:string read FCaption write FCaption;
  end;

//多个股票的盘口总表对象
{ TMyHandicaps }

  TMyHandicaps = class(TComponent)
  private
    FList:TObjectList;     //管理对象为TMyHandicap的列表
    function GetCount: integer;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Clear;
    function Add(ACode,ACaption,AMarket:string):integer;
    function IndexOf(ACode,AMarket:string):integer;
    function Item(AIndex:integer):TMyHandicap;
    procedure SaveListToFile(AFilename:string);//保存列表到文件
    procedure LoadListFromFile(AFilename:String);//读取列表文件
    procedure SaveDataToFile(ADir:string);//保存所有数据到各自的文件
    procedure LoadDataFromFile(ADir:string);//所有对象读取各自的数据文件
    property Count:integer read GetCount;
  end;

implementation

//股票行情
{ TMyQuote }

function TMyQuote.GetCount: integer;
begin
  Result:=FList.Count;
end;

constructor TMyQuote.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList:=TList.Create;
end;

destructor TMyQuote.Destroy;
begin
  clear;
  Flist.Free;
  inherited Destroy;
end;

procedure TMyQuote.Clear;
begin
  Flist.clear;
end;

procedure TMyQuote.LoadFromFile(AFilename: string);
var
  m:TMyStockItem;
  mFile:TFileStream;
  mCount,i:integer;
  mItem:TMyQuoteItem;
begin
  mFile:=TFileStream.Create(AFilename,fmOpenRead);   //将文件中的单股行情，导入mFile
  Clear;
  mFile.Seek(0,soBeginning);
  mFile.Read(m,sizeof(m));    // 读出股票的代码、名称，作为表头信息
  FCode:=m.Code;
  FCaption:=m.Caption;
  FMarket:=m.Market;
  mFile.Read(mCount,sizeof(mCount));    //读出一共多少条行情记录
  for i:=0 to mCount-1 do
  begin                             //循环读出每条行情记录，add到Flist中
    mFile.Read(mItem,sizeof(mItem));
    Add(mItem);
  end;
  mFile.Free;
end;

procedure TMyQuote.SaveToFile(AFilename: String);
var
  m:TMyStockItem;
  mFile:TFileStream;
  mCount,i:integer;
  mItem:TMyQuoteItem;
begin
  mFile:=TFileStream.Create(AFilename,fmCreate);    //创建文件流
  mFile.Seek(0,soBeginning);
  m.Caption:=FCaption;
  m.Code:=FCode;
  m.Market:=FMarket;
  mFile.Write(m,sizeof(m));    //存入股票代码、名称
  mCount:=FList.Count;       // 存入count
  mFile.Write(mCount,sizeof(mCount));
  for i:=0 to FList.Count-1 do           //循环Item函数，将返回的每条QuoteItem写入文件
  begin
    mItem:=Item(i);
    mFile.Write(mItem,sizeof(mItem));
  end;
  mFile.Free;
end;

function TMyQuote.Add(AValue: TMyQuoteItem): integer;
var
  m:PMyQuoteItem;
begin
  new(m);                  //创建新指针m，将Avalue信息依次付给m，最后Flist.add(m)
  m^.ADate:=AValue.ADate;
  m^.ATime:=AValue.ATime;
  m^.Open:=AValue.Open;
  m^.High:=AValue.High;
  m^.Low:=AValue.Low;
  m^.Close:=AValue.Close;
  m^.Vol:=AValue.vol;
  Result:=Flist.Add(m);
end;

function TMyQuote.IndexOf(ADate, Atime: integer): integer;
var
  i:integer;
  mItem:TMyQuoteItem;
begin
  Result:=-1;
  for i:=0 to Flist.Count-1 do
  begin
    mItem:=self.Item(i);     //将循环的每一条QuoteItem赋值给mItem
    if (mItem.ADate=Adate) and (mItem.ATime=ATime) then    //再将mItem和AValue比较
    begin
      result:=i;
      break;
    end;
  end;
end;

function TMyQuote.Item(AIndex: integer): TMyQuoteItem;
var
  m:PMyQuoteItem;
begin
  m:=PMyQuoteItem(Flist.Items[AIndex]);
  result.Adate:=m^.ADate;
  result.ATime:=m^.ATime;
  result.Open:=m^.Open;
  result.High:=m^.High;
  result.Low:=m^.Low;
  result.Close:=m^.Close;
  result.Vol:=m^.Vol;
end;


{ TMyQuotes }

function TMyQuotes.GetCount: integer;
begin
  Result:=Flist.Count;
end;

constructor TMyQuotes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList:=TObjectList.Create(True);
end;

destructor TMyQuotes.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TMyQuotes.Clear;
begin
  FList.Clear;
end;

function TMyQuotes.Add(ACode, ACaption, AMarket: string): integer;
var                                //增加一只新股票
  m:TMyQuote;
begin
  m:=TMyQuote.Create(Self);
  m.Code:=ACode;
  m.Caption:=ACaption;
  m.Market:=AMarket;
  Result:=FList.Add(m);
end;

function TMyQuotes.IndexOf(ACode, AMarket: string): integer;
var                      //索引一只股票
  i:integer;
  m:TMyQuote;
begin
  Result:=-1;
  for i:=0 to FList.Count-1 do
  begin
    if ((FList.Items[i] as TMyQuote).Code=ACode) and ((FList.Items[i] as TMyQuote).Market=AMarket) then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

function TMyQuotes.Item(AIndex: integer): TMyQuote;
begin
  Result:=FList.Items[AIndex] as TMyQuote;   //等同于强制转换:TMyQuote(FList.Items[AIndex])
end;

procedure TMyQuotes.SaveListToFile(AFilename:string);
var
  i:integer;
  mHeader:TMyStockItem;
  m:TMyQuote;
  mFile:TFileStream;
  mCount:integer;
begin
  mFile:=TFileStream.Create(AFilename,fmCreate);
  mFile.Seek(0,soBeginning);
  mCount:=Flist.Count;
  mFile.Write(mCount,sizeof(mCount));       //保存count
  for i:=0 to FList.Count-1 do
  begin
    m:=Self.Item(i);                //依次提取出TMyQuote对象
    mHeader.Code:=m.Code;
    mHeader.Market:=m.Market;     //将每个对象的代码、市场和名称作为stockItem结构写入文件
    mHeader.Caption:=m.Caption;
    mFile.Write(mHeader,sizeof(mHeader));
  end;
  mFile.Free;
end;

procedure TMyQuotes.LoadListFromFile(AFilename: String);
var
  i:integer;
  mHeader:TMyStockItem;
  m:TMyQuote;
  mFile:TFileStream;
  mCount:integer;
begin
  Clear;
  mFile:=TFileStream.Create(AFilename,fmOpenRead);
  mFile.Seek(0,soBeginning);
  mFile.Read(mCount,sizeof(mCount));
  for i:=0 to mCount-1 do
  begin                                     //依次读取每个StockItem结构
    mFile.Read(mHeader,sizeof(mHeader));
    Self.Add(mHeader.Code,mHeader.Caption,mHeader.Market);
  end;                 //将每个StockItem中的代码、名称作为TMyQuote对象add到Flist中
  mFile.Free;
end;

procedure TMyQuotes.SaveDataToFile(ADir:string);
var
  i:integer;
  mFilename:string;
  mItem:TMyQuote;
begin
  for i:=0 to FList.Count-1 do
  begin                           //对于list中的每一个TMyQuote对象
    mItem:=Item(i);              // 自动调用SaveToFile函数，保存到各自的目录下
    mFilename:=Adir+'\'+mItem.Market+mItem.Code+'.dat';
    mItem.SaveToFile(mFilename);
  end;
end;

procedure TMyQuotes.LoadDataFromFile(ADir:string);
var
  i:integer;
  mFilename:string;
  mItem:TMyQuote;
begin
  for i:=0 to FList.Count-1 do
  begin                          // 每一个TMyQuote对象自动从各自的目录Load
    mFilename:=Adir+'\'+mItem.Market+mItem.Code+'.dat';
    mItem:=Item(i);
    mItem.LoadFromFile(mFilename);
  end;
end;

//盘口
{ TMyHandicap }

function TMyHandicap.GetCount: integer;
begin
  Result:=Flist.Count;
end;

constructor TMyHandicap.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Flist:=TList.Create;
end;

destructor TMyHandicap.Destroy;
begin
  clear;
  Flist.Free;
  inherited Destroy;
end;

procedure TMyHandicap.Clear;
begin
  Flist.Clear;
end;

procedure TMyHandicap.LoadFromFile(AFilename: string);
var
  m:TMyStockItem;
  mFile:TFileStream;
  mCount,i:integer;
  mItem:TMyHandicapItem;
begin
  mFile:=TFileStream.Create(AFilename,fmOpenRead);
  Clear;
  mFile.seek(0,soBeginning);
  mFile.Read(m,sizeof(m));
  FCode:=m.Code;
  FCaption:=m.Caption;
  FMarket:=m.Market;
  mFile.Read(mCount,sizeof(mCount));    //读出一共多少条行情记录
  for i:=0 to mCount-1 do
  begin
    mFile.Read(mItem,sizeof(mItem));
    Add(mItem);
  end;
  mFile.free;
end;

procedure TMyHandicap.SaveToFile(AFilename: String);
var
  m:TMyStockItem;
  mFile:TFileStream;
  mCount,i:integer;
  mItem:TMyHandicapItem;
begin
  mFile:=TFileStream.Create(AFilename,fmCreate);
  mFile.seek(0,soBeginning);
  m.Code:=FCode;
  m.Caption:=FCaption;
  m.Market:=FMarket;
  mFile.Write(m,sizeof(m));
  mCount:=Flist.Count;
  mFile.Write(mCount,sizeof(mCount));    //读出一共多少条行情记录
  for i:=0 to mCount-1 do
  begin
    mItem:=Item(i);
    mFile.Write(mItem,sizeof(mItem));
  end;
  mFile.free;
end;

function TMyHandicap.Add(AValue: TMyHandicapItem): integer;
var
  m:PMyHandicapItem;
begin
  new(m);
  m^.ADate:=AValue.ADate;
  m^.ATime:=AValue.ATime;
  m^.sealprice1:=AValue.sealprice1;		m^.sealvolume1:=AValue.sealvolume1;
  m^.sealprice2:=AValue.sealprice1;		m^.sealvolume2:=AValue.sealvolume1;
  m^.sealprice3:=AValue.sealprice1;		m^.sealvolume3:=AValue.sealvolume1;
  m^.sealprice4:=AValue.sealprice1;		m^.sealvolume4:=AValue.sealvolume1;
  m^.sealprice5:=AValue.sealprice1;		m^.sealvolume5:=AValue.sealvolume1;
  m^.sealprice6:=AValue.sealprice1;		m^.sealvolume6:=AValue.sealvolume1;
  m^.sealprice7:=AValue.sealprice1;		m^.sealvolume7:=AValue.sealvolume1;
  m^.sealprice8:=AValue.sealprice1;		m^.sealvolume8:=AValue.sealvolume1;
  m^.sealprice9:=AValue.sealprice1;		m^.sealvolume9:=AValue.sealvolume1;
  m^.sealprice10:=AValue.sealprice1;	m^.sealvolume10:=AValue.sealvolume1;
  m^.buyprice1:=AValue.buyprice1;		m^.buyvolume1:=AValue.buyvolume1;
  m^.buyprice2:=AValue.buyprice1;		m^.buyvolume2:=AValue.buyvolume1;
  m^.buyprice3:=AValue.buyprice1;		m^.buyvolume3:=AValue.buyvolume1;
  m^.buyprice4:=AValue.buyprice1;		m^.buyvolume4:=AValue.buyvolume1;
  m^.buyprice5:=AValue.buyprice1;		m^.buyvolume5:=AValue.buyvolume1;
  m^.buyprice6:=AValue.buyprice1;		m^.buyvolume6:=AValue.buyvolume1;
  m^.buyprice7:=AValue.buyprice1;		m^.buyvolume7:=AValue.buyvolume1;
  m^.buyprice8:=AValue.buyprice1;		m^.buyvolume8:=AValue.buyvolume1;
  m^.buyprice9:=AValue.buyprice1;		m^.buyvolume9:=AValue.buyvolume1;
  m^.buyprice10:=AValue.buyprice1;		m^.buyvolume10:=AValue.buyvolume1;
  Result:=Flist.Add(m);
end;

function TMyHandicap.IndexOf(ADate, Atime: integer): integer;
var
  i:integer;
  mItem:TMyHandicapItem;
begin
  Result:=-1;
  for i:=0 to Flist.Count-1 do
  begin
    mItem:=Self.Item(i);
    if (mItem.ADate=ADate) and (mItem.ATime=ATime) then
    begin
      result:=i;
      break;
    end;
  end;
end;

function TMyHandicap.Item(AIndex: integer): TMyHandicapItem;
var
  m:PMyHandicapItem;
begin
  m:=PMyHandicapItem(Flist.Items[AIndex]);
  result.Adate:=m^.ADate;
  result.ATime:=m^.ATime;
  result.sealprice1:=m^.sealprice1;		result.sealvolume1:=m^.sealvolume1;
  result.sealprice2:=m^.sealprice1;		result.sealvolume2:=m^.sealvolume1;
  result.sealprice3:=m^.sealprice1;		result.sealvolume3:=m^.sealvolume1;
  result.sealprice4:=m^.sealprice1;		result.sealvolume4:=m^.sealvolume1;
  result.sealprice5:=m^.sealprice1;		result.sealvolume5:=m^.sealvolume1;
  result.sealprice6:=m^.sealprice1;		result.sealvolume6:=m^.sealvolume1;
  result.sealprice7:=m^.sealprice1;		result.sealvolume7:=m^.sealvolume1;
  result.sealprice8:=m^.sealprice1;		result.sealvolume8:=m^.sealvolume1;
  result.sealprice9:=m^.sealprice1;		result.sealvolume9:=m^.sealvolume1;
  result.sealprice10:=m^.sealprice1;	result.sealvolume10:=m^.sealvolume1;
  result.buyprice1:=m^.buyprice1;		result.buyvolume1:=m^.buyvolume1;
  result.buyprice2:=m^.buyprice1;		result.buyvolume2:=m^.buyvolume1;
  result.buyprice3:=m^.buyprice1;		result.buyvolume3:=m^.buyvolume1;
  result.buyprice4:=m^.buyprice1;		result.buyvolume4:=m^.buyvolume1;
  result.buyprice5:=m^.buyprice1;		result.buyvolume5:=m^.buyvolume1;
  result.buyprice6:=m^.buyprice1;		result.buyvolume6:=m^.buyvolume1;
  result.buyprice7:=m^.buyprice1;		result.buyvolume7:=m^.buyvolume1;
  result.buyprice8:=m^.buyprice1;		result.buyvolume8:=m^.buyvolume1;
  result.buyprice9:=m^.buyprice1;		result.buyvolume9:=m^.buyvolume1;
  result.buyprice10:=m^.buyprice1;		result.buyvolume10:=m^.buyvolume1;
end;


{ TMyHandicaps }

function TMyHandicaps.GetCount: integer;
begin
  Result:=Flist.Count;
end;

constructor TMyHandicaps.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList:=TObjectList.Create(True);
end;

destructor TMyHandicaps.Destroy;
begin
  Clear;
  Flist.Free;
  inherited Destroy;
end;

procedure TMyHandicaps.Clear;
begin
  Flist.Clear;
end;

function TMyHandicaps.Add(ACode, ACaption, AMarket: string): integer;
var
  m:TMyHandicap;
begin
  m:=TMyHandicap.Create(self);
  m.Code:=ACode;
  m.Caption:=ACaption;
  m.Market:=AMarket;
  Result:=FList.Add(m);
end;

function TMyHandicaps.IndexOf(ACode, AMarket: string): integer;
var                      //索引一只股票
  i:integer;
  m:TMyHandicap;
begin
  Result:=-1;
  for i:=0 to FList.Count-1 do
  begin
    if ((FList.Items[i] as TMyHandicap).Code=ACode) and ((FList.Items[i] as TMyHandicap).Market=AMarket) then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

function TMyHandicaps.Item(AIndex: integer): TMyHandicap;
begin
  Result:=Flist.Items[Aindex] as TMyHandicap;
end;

procedure TMyHandicaps.SaveListToFile(AFilename: string);
var
  i:integer;
  mHeader:TMyStockItem;
  m:TMyHandicap;
  mFile:TFileStream;
  mCount:integer;
begin
  mFile:=TFileStream.Create(AFilename,fmCreate);
  mFile.Seek(0,soBeginning);
  mCount:=Flist.Count;
  mFile.Write(mCount,sizeof(mCount));       //保存count
  for i:=0 to FList.Count-1 do
  begin
    m:=Self.Item(i);                //依次提取出TMyQuote对象
    mHeader.Code:=m.Code;
    mHeader.Market:=m.Market;     //将每个对象的代码、市场和名称作为stockItem结构写入文件
    mHeader.Caption:=m.Caption;
    mFile.Write(mHeader,sizeof(mHeader));
  end;
  mFile.Free;
end;

procedure TMyHandicaps.LoadListFromFile(AFilename: String);
var
  i:integer;
  mHeader:TMyStockItem;
  m:TMyHandicap;
  mFile:TFileStream;
  mCount:integer;
begin
  Clear;
  mFile:=TFileStream.Create(AFilename,fmOpenRead);
  mFile.Seek(0,soBeginning);
  mFile.Read(mCount,sizeof(mCount));
  for i:=0 to mCount-1 do
  begin                                     //依次读取每个StockItem结构
    mFile.Read(mHeader,sizeof(mHeader));
    Self.Add(mHeader.Code,mHeader.Caption,mHeader.Market);
  end;                 //将每个StockItem中的代码、名称作为TMyQuote对象add到Flist中
  mFile.Free;
end;

procedure TMyHandicaps.SaveDataToFile(ADir: string);
var
  i:integer;
  mFilename:string;
  mItem:TMyHandicap;
begin
  for i:=0 to FList.Count-1 do
  begin                           //对于list中的每一个TMyQuote对象
    mItem:=Item(i);              // 自动调用SaveToFile函数，保存到各自的目录下
    mFilename:=Adir+'\'+mItem.Market+mItem.Code+'.dat';
    mItem.SaveToFile(mFilename);
  end;
end;

procedure TMyHandicaps.LoadDataFromFile(ADir: string);
var
  i:integer;
  mFilename:string;
  mItem:TMyHandicap;
begin
  for i:=0 to FList.Count-1 do
  begin                          // 每一个TMyQuote对象自动从各自的目录Load
    mFilename:=Adir+'\'+mItem.Market+mItem.Code+'.dat';
    mItem:=Item(i);
    mItem.LoadFromFile(mFilename);
  end;
end;
}
end.

