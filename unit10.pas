unit Unit10;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TplGradientUnit, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Spin;

type

  { TForm10 }

  TForm10 = class(TForm)
    Button1: TButton;
    Edit15: TEdit;
    FloatSpinEdit1: TFloatSpinEdit;
    FloatSpinEdit10: TFloatSpinEdit;
    FloatSpinEdit2: TFloatSpinEdit;
    FloatSpinEdit3: TFloatSpinEdit;
    FloatSpinEdit4: TFloatSpinEdit;
    FloatSpinEdit5: TFloatSpinEdit;
    FloatSpinEdit6: TFloatSpinEdit;
    FloatSpinEdit7: TFloatSpinEdit;
    FloatSpinEdit8: TFloatSpinEdit;
    FloatSpinEdit9: TFloatSpinEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    plGradient1: TplGradient;
    plGradient2: TplGradient;
    plGradient3: TplGradient;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit5: TSpinEdit;
    SpinEdit7: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  Form10: TForm10;

implementation
uses
  Unit8;
{$R *.frm}

{ TForm10 }

procedure TForm10.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TForm10.Button1Click(Sender: TObject);
begin

end;

end.

