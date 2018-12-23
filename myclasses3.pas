unit myclasses3;
{
  资产数据！     资产数据！      资产数据！
  资产数据！     资产数据！      资产数据！
  资产数据！     资产数据！      资产数据！
}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
type

  //资产数据
  {TCash 现金资产}
  TCash = class(Tcomponent)
  private
    FAvailable:double;  // 可取
  public
    constructor Create(AOwner:TComponent);  override;
    destructor Destroy;  override;
    procedure LoadFromFile(Filename:string);
    procedure SaveToFile(Filename:string);
    property Available:double read FAvailable write FAvailable;
  end;

  {TPropertyItem 持有股票}
  TPropertyItem = packed record
    Code:string[6];  //股代码
    StockName:string[20];
    Market:string[2];  //市场
    cost:double; //成本价
    quantity:integer; //数量
    price:double; //现价                  //
    Profit:double; //盈亏                   //  这三个怎么表示，反复用Update吗
    profitRatio:double;  //盈亏比             //
  end;
  PPropertyItem = ^TPropertyItem;

  {TProperty 持仓资产列表}
  TProperty = class(Tcomponent)
  private
    Flist:Tlist;
    function GetCount: integer;
  public
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy;override;
    procedure Clear;

    function Totalinterest:double;  //持仓总盈亏
    function Frozen:double;    // 总冻结资产
    function Add(AValue:TPropertyItem):integer; //增加新持有股票
    procedure Update(AIndex:integer; Avalue:TPropertyItem);//更新指定下标的数量
    function Delete(AIndex:integer):boolean;//删除指定下标的股票（全卖出）
    procedure LoadFromFile(Afilename:String);//从文件读数据
    procedure SaveToFile(AFilename:string);//保存数据到文件
    function IndexOf(ACode,AMarket:string):integer;//查找
    function Item(AIndex:integer):TPropertyItem;//返回数据
    property Count:integer read GetCount;
  end;

implementation

{ TCash }

constructor TCash.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCash.Destroy;
begin
  inherited Destroy;
end;


procedure TCash.LoadFromFile(Filename: string);
var
  Tmp,Tmp2:double;
  mFile:TFileStream;
begin
  mFile:=TFileStream.Create(FileName,fmOpenRead);
  mFile.Seek(0,soBeginning);               //从property.dat读取available的值
  mFile.Read(Tmp,sizeof(double));          FAvailable:=Tmp;

  mFile.free;
end;

procedure TCash.SaveToFile(Filename: string);
var
  mFile:TFileStream;
begin                                     //把available的值存入property.dat
  mFile:=TFileStream.Create(FileName,fmCreate);
  mFile.Seek(0,soBeginning);
  mFile.write(FAvailable,sizeof(double));
  mFile.free;
end;

{ TProperty }

function  TProperty.Totalinterest: double;
var
  i:integer;
  Tmp:double;
  mItem:TPropertyItem;
begin
  Tmp:=0;
  for i:=0 to Flist.Count-1 do
  begin
    mItem:=Self.Item(i);
    Tmp:=Tmp+mItem.Profit*mItem.quantity;
  end;
  Result:=Tmp;
end;

function  TProperty.Frozen: double;
var
  i:integer;
  Tmp:double;
  mItem:TPropertyItem;
begin
  Tmp:=0;
  for i:=0 to Flist.Count-1 do
  begin
    mItem:=Self.Item(i);
    Tmp:=Tmp+mItem.price*mItem.Quantity;
  end;
  Result:=Tmp;
end;

function TProperty.GetCount: integer;
begin
  Result:=FList.Count;
end;

constructor TProperty.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList:=TList.create;
end;

destructor TProperty.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TProperty.Clear;
var
  i:integer;
begin
  for i:=0 to FList.Count-1 do
  begin
    Dispose(PPropertyItem(FList.Items[i]));
  end;
  FList.Clear;
end;

function TProperty.Add(AValue: TPropertyItem): integer;
var
  m:PpropertyItem;
begin
  new(m);
  m^.Code:=AValue.Code;
  m^.StockName:=AValue.StockName;
  m^.Market:=AValue.Market;
  m^.cost:=AValue.cost;
  m^.quantity:=AValue.quantity;
  m^.price:=AValue.price;
  m^.Profit:=AValue.Profit;
  m^.profitRatio:=AValue.profitRatio;

  Result:=Flist.Add(m);
end;

function TProperty.Delete(AIndex: integer): boolean;
begin
  try
    Flist.Delete(AIndex);
    result:=true;
  except
    result:=False;
  end;
end;

procedure TProperty.Update(AIndex: integer; Avalue: TPropertyItem);
var
  m:PPropertyItem;
begin
  if AIndex < Flist.Count then
  begin
    m:=PPropertyItem(FList.Items[AIndex]);
    m^.Code:=AValue.Code;
    m^.StockName:=AValue.StockName;
    m^.Market:=AValue.Market;
    m^.cost:=AValue.cost;
    m^.quantity:=AValue.quantity;
    m^.price:=AValue.price;
    m^.Profit:=AValue.Profit;
    m^.profitRatio:=AValue.profitRatio;
  end;
end;

procedure TProperty.LoadFromFile(Afilename: String);
var
  mcount:integer;
  mFile:TFileStream;
  i:integer;
  mItem:TPropertyItem;
begin
  mFile:=TFileStream.Create(AFilename,fmOpenRead);
  mFile.Seek(0,soBeginning);
  mFile.Read(mcount,sizeof(mcount));
  Clear;
  for i:=0 to mCount-1 do
  begin
    mFile.Read(mItem,sizeof(mItem));
    Add(mItem);
  end;
  mFile.Free;
end;

procedure TProperty.SaveToFile(AFilename: string);
var
  mcount:integer;
  mFile:TFileStream;
  i:integer;
  mItem:TPropertyItem;
begin
  mFile:=TFileStream.Create(AFilename,fmCreate);
  mcount:=FList.Count;
  mFile.Seek(0,soBeginning);
  mFile.Write(mcount,sizeof(mcount));
  for i:=0 to FList.Count-1 do
  begin
    mItem:=Self.Item(i);
    mFile.Write(mItem,sizeof(mItem));
  end;
  mFile.Free;
end;

function TProperty.IndexOf(ACode, AMarket: string): integer;
var
  i:integer;
  mItem:TPropertyItem;
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

function TProperty.Item(AIndex: integer): TPropertyItem;
var
  m:PPropertyItem;
begin
  m:=PPropertyItem(FList.Items[AIndex]);
  Result.Code:=m^.Code;
  Result.StockName:=m^.StockName;
  Result.Market:=m^.Market;
  Result.cost:=m^.cost;
  Result.quantity:=m^.quantity;
  Result.price:=m^.price;
  Result.Profit:=m^.Profit;
  Result.ProfitRatio:=m^.ProfitRatio;
end;


end.

