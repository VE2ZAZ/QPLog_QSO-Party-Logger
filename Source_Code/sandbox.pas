unit SandBox;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Main_Window;

type

  { TSoapBox_Form }

  TSoapBox_Form = class(TForm)
    Continue_Button: TButton;
    SoapBox_Buttons_Panel: TPanel;
    SoapBox_Memo: TMemo;
    procedure Continue_ButtonClick(Sender: TObject);
    procedure SoapBox_MemoChange(Sender: TObject);
    procedure SoapBox_Memo_OnClick(Sender: TObject);
    procedure SoapBox_Memo_OnKeyPressed(Sender: TObject; var Key: char);
  private

  public

  end;

var
  SoapBox_Form: TSoapBox_Form;

implementation

{$R *.lfm}

{ TSoapBox_Form }

procedure TSoapBox_Form.SoapBox_MemoChange(Sender: TObject);
begin
  if (SoapBox_Memo.Font.Color = clInactiveCaption) then
  begin
    SoapBox_Memo.Font.Color := clDefault;
    SoapBox_Memo.Lines.Clear;
  end;
end;

procedure TSoapBox_Form.SoapBox_Memo_OnClick(Sender: TObject);
begin
  if (SoapBox_Memo.Font.Color = clInactiveCaption) then
  begin
    SoapBox_Memo.Font.Color := clDefault;
    SoapBox_Memo.Lines.Clear;
  end;
end;

procedure TSoapBox_Form.SoapBox_Memo_OnKeyPressed(Sender: TObject; var Key: char
  );
begin
    if ((Length(SoapBox_Memo.Lines.Text) >= 400) and (Key <> #8)) then Key := #0;      // Delete character if string has longer than 400 characters.
end;

procedure TSoapBox_Form.Continue_ButtonClick(Sender: TObject);
begin
   SoapBox_Form.Close;

end;

end.

