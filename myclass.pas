unit Myclass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, forms;

type

{
  订单数据！      订单数据！      订单数据！
  订单数据！      订单数据！      订单数据！
  订单数据！      订单数据！      订单数据！
}
  {TOrderItem 订单结构}
  TOrderItem = packed record
    Number:string[10]; //订单号
    Date:integer;     //成交日
    Code:string[6];  //股代码
    StockName:string[20];
    Market:string[2];
    quantity:integer; //数量
    Orig_price:double; //下单时单价
    Deal_Price:double; //成交价
    Amount:double;  //总金额
    direct:boolean;  //交易方向     true为买
    status:boolean; //成交状态      true为已成交
  end;
  POrderItem = ^TOrderItem;

  {THistoryOrder  历史订单列表}
  THistoryOrder = class(Tcomponent)
  private
    Flist:Tlist;
    function GetCount: integer;
  public
    constructor Create(AOwner:TComponent);  override;
    destructor Destroy; override;
    procedure Clear;

    function Add(Avalue:TOrderItem):integer;  //过了今天的成交订单移入
    procedure LoadFromFile(AFilename:String);  //分时读取更新
    procedure SaveToFile(AFilename:String);  //将更新后的订单存到文件
    function Item(AIndex:integer):TOrderItem;
    property Count:integer read GetCount;
  end;

  {TCurrentOrder  当日订单列表}
  TCurrentOrder = class(Tcomponent)
  private
    Flist:Tlist;
    function GetCount: integer;
  public
    constructor Create(AOwner:TComponent);  override;
    destructor  Destroy; override;
    procedure Clear;

    function Add(AValue:TorderItem):integer;   //下订单
    function Delete(AIndex:integer):boolean;  //过了今天的成交订单移入
    function Item(AIndex:integer):TOrderItem;
    procedure LoadFromFile(AFilename:String);  //分时读取更新
    procedure SaveToFile(AFilename:String); //将更新后的订单存到文件
    property Count:integer read GetCount;
  end;

implementation


//订单
{ THistoryOrder }

function THistoryOrder.GetCount: integer;
begin
  Result:=FList.Count;
end;

constructor THistoryOrder.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Flist:=Tlist.Create;
end;

destructor THistoryOrder.Destroy;
begin
  Clear;
  Flist.Free;
  inherited Destroy;
end;

procedure THistoryOrder.Clear;
var
  i:integer;
begin
  for i:=0 to FList.Count-1 do
  begin
    Dispose(POrderItem(FList.Items[i]));
  end;
  FList.Clear;
end;

function THistoryOrder.Add(Avalue: TOrderItem): integer;
var
  m:POrderItem;
begin
  new(m);
  m^.Number:=AValue.Number;
  m^.Date:=AValue.Date;
  m^.Code:=AValue.Code;
  m^.StockName:=AValue.StockName;
  m^.Market:=AValue.Market;
  m^.quantity:=AValue.quantity;
  m^.Orig_price:=AValue.Orig_price;
  m^.Deal_price:=AValue.Deal_price;
  m^.Amount:=AValue.AMount;
  m^.direct:=AValue.direct;
  m^.Status:=AValue.Status;

  Result:=Flist.Add(m);
end;

procedure THistoryOrder.LoadFromFile(AFilename:String);
var
  mcount:integer;
  mFile:TFileStream;
  i:integer;
  mItem:TOrderItem;
begin
  mFile:=TFileStream.Create(AFilename,fmOpenRead);
  Clear;
  mFile.Seek(0,soBeginning);
  mFile.Read(mcount,sizeof(mcount));
  Clear;
  for i:=0 to mCount-1 do
  begin
    mFile.Read(mItem,sizeof(mitem));
    Add(mItem);
  end;
  mFile.Free;
end;

procedure THistoryOrder.SaveToFile(AFilename:String);
var
  mcount:integer;
  mFile:TFileStream;
  i:integer;
  mItem:TOrderItem;
begin
  mFile:=TFileStream.Create(AFilename,fmCreate);
  mcount:=FList.Count;
  mFile.Seek(0,soBeginning);
  mFile.Write(mcount,sizeof(mcount));
  for i:=0 to FList.Count-1 do
  begin
    mItem:=Self.Item(i);
    mFile.Write(mItem,sizeof(mitem));
  end;
  mFile.Free;
end;

function THistoryOrder.Item(AIndex: integer): TOrderItem;
var
  m:POrderItem;
begin
  m:=POrderItem(Flist.Items[AIndex]);
  Result.Number:=m^.Number;
  Result.Date:=m^.Date;
  Result.Code:=m^.Code;
  Result.StockName:=m^.StockName;
  Result.Market:=m^.Market;
  Result.quantity:=m^.quantity;
  Result.Orig_price:=m^.Orig_price;
  Result.Deal_price:=m^.Deal_price;
  Result.Amount:=m^.Amount;
  Result.direct:=m^.direct;
  Result.status:=m^.status;
end;

{ TCurrentOrder }

function TCurrentOrder.GetCount: integer;
begin
  Result:=FList.Count;
end;

constructor TCurrentOrder.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList:=TList.Create;
end;

destructor TCurrentOrder.Destroy;
begin
  Clear;
  Flist.Free;
  inherited Destroy;
end;

procedure TCurrentOrder.Clear;
var
  i:integer;
begin
  for i:=0 to FList.Count-1 do
  begin
    Dispose(POrderItem(FList.Items[i]));
  end;
  FList.Clear;
end;

function TCurrentOrder.Add(AValue: TorderItem): integer;
var
  m:POrderItem;
begin
  new(m);
  m^.Number:=AValue.Number;
  m^.Date:=AValue.Date;
  m^.Code:=AValue.Code;
  m^.StockName:=AValue.StockName;
  m^.Market:=AValue.Market;
  m^.quantity:=AValue.quantity;
  m^.Orig_price:=AValue.Orig_price;
  m^.Deal_price:=AValue.Deal_price;
  m^.Amount:=AValue.AMount;
  m^.direct:=AValue.direct;
  m^.Status:=AValue.Status;

  Result:=Flist.Add(m);
end;

function TCurrentOrder.Delete(AIndex: integer): boolean;
begin
  try
    Flist.Delete(AIndex);
    result:=true;
  except
    result:=False;
  end;
end;

function TCurrentOrder.Item(AIndex: integer): TOrderItem;
var
  m:POrderItem;
begin
  m:=POrderItem(Flist.Items[AIndex]);
  Result.Number:=m^.Number;
  Result.Date:=m^.Date;
  Result.Code:=m^.Code;
  Result.StockName:=m^.StockName;
  Result.Market:=m^.Market;
  Result.quantity:=m^.quantity;
  Result.Orig_price:=m^.Orig_price;
  Result.Deal_price:=m^.Deal_price;
  Result.Amount:=m^.Amount;
  Result.direct:=m^.direct;
  Result.status:=m^.status;
end;

procedure TCurrentOrder.LoadFromFile(AFilename:String);
var
  mcount:integer;
  mFile:TFileStream;
  i:integer;
  mItem:TOrderItem;
begin
  mFile:=TFileStream.Create(AFilename,fmOpenRead);
  Clear;
  mFile.Seek(0,soBeginning);
  mFile.Read(mcount,sizeof(mcount));
  for i:=0 to mCount-1 do
  begin
    mFile.Read(mItem,sizeof(mItem));
    Add(mItem);
  end;
  mFile.Free;
end;

procedure TCurrentOrder.SaveToFile(AFilename:String);
var
  mcount:integer;
  mFile:TFileStream;
  i:integer;
  mItem:TOrderItem;
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

end.

