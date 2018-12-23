unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;
                   //登录//登录
type               //登录      //登录
                   //登录            //登录
  { TForm2 }       //登录                  //登录
                   //登录                        //登录
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.frm}

{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);
begin

end;

procedure TForm2.Button2Click(Sender: TObject);
begin

end;

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

end.

