unit Unit9;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, Math,
  ExtCtrls,datamodule, Myclass, myclasses2, myclasses3,myclasses__paint;


type

  { TForm9 }

  TForm9 = class(TForm)
    Image10: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form9: TForm9;

implementation

{$R *.frm}

{ TForm9 }

procedure TForm9.FormShow(Sender: TObject);
var
  ApropertyItem:TPropertyItem;
  i:integer;
  TotalValue:double;
begin
  TotalValue:=0;
  for i:=0 to PropertyList.Count-1 do
  begin
    ApropertyItem:=PropertyList.Item(i);
    TotalValue:=TotalValue+ApropertyItem.price*ApropertyItem.quantity;
  end;

  Label2.caption:=floattostr(Cash.Available);
  Label3.caption:=floattostr(Cash.Available+TotalValue-200000);
  Label4.caption:=floattostr((Cash.Available+TotalValue-200000)/2000)+'%';
  Label5.caption:=floattostr(RoundTo((Cash.Available+TotalValue-200000)/78,-2));
end;

end.

