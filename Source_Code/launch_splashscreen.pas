unit Launch_Splashscreen;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Main_Window,
  QSO_Entry, LCLIntf, StdCtrls, Worked_Zones, stats_form, lang_select;

type

  { TLaunch_Splash_Form }

  TLaunch_Splash_Form = class(TForm)
    Close_SplashScreen_Button: TButton;
    Credentials_Label: TLabel;
    QPLog_Logo: TImage;
    Splashscreen_Timer: TTimer;
    procedure Close_SplashScreen_ButtonClick(Sender: TObject);
    procedure Launch_Splash_Onclick(Sender: TObject);
    procedure Splashscreen_OnCreate(Sender: TObject);
    procedure Splashscreen_Onshow(Sender: TObject);
    procedure Splashscreen_Title_StaticTextClick(Sender: TObject);
    procedure Splashscreen_Timer_OnTimer(Sender: TObject);
    procedure Splashscreen_Details_StaticTextClick(Sender: TObject);
  private

  public

  end;

var
  Launch_Splash_Form: TLaunch_Splash_Form;

implementation

{$R *.lfm}

{ TLaunch_Splash_Form }

procedure TLaunch_Splash_Form.Splashscreen_Onshow(Sender: TObject);
begin
     Main_Form.Enabled := False;
     if not (QSO_Entry_Form = nil) then QSO_Entry_Form.Enabled := False;
     if not (Worked_Zones_Form = nil) then Worked_Zones_Form.Enabled := False;
     if not (Statistics_Form = nil) then Statistics_Form.Enabled := False;
     Credentials_Label.Caption := sLineBreak + VERSION_NUMBER + sLineBreak + sContribList[language];
     Close_SplashScreen_Button.Caption := sClose_SplashScreen_Button[language];
     Launch_Splash_Form.Top := Main_Form.Top + Round(Main_Form.Height / 2) - Round(Launch_Splash_Form.Height / 2);
     Launch_Splash_Form.Left := Main_Form.Left + Round(Main_Form.Width / 2) - Round(Launch_Splash_Form.Width / 2);
     Launch_Splash_Form.Visible := True;
     Launch_Splash_Form.SetFocus;
end;

procedure TLaunch_Splash_Form.Launch_Splash_Onclick(Sender: TObject);
begin
end;

procedure TLaunch_Splash_Form.Close_SplashScreen_ButtonClick(Sender: TObject);
begin
     Launch_Splash_Form.Hide;
     Main_Form.Enabled := True;
     if ((not(QSO_Entry_Form = nil)) and (fileExists(contest_long_filename))) then QSO_Entry_Form.Enabled := True;
     if not (Worked_Zones_Form = nil) then Worked_Zones_Form.Enabled := True;
     if not (Statistics_Form = nil) then Statistics_Form.Enabled := True;
     Main_Form.SetFocus;
end;

procedure TLaunch_Splash_Form.Splashscreen_OnCreate(Sender: TObject);
begin
//     Credentials_Label.Caption := sLineBreak + VERSION_NUMBER + sLineBreak + sContribList[language];
     Close_SplashScreen_Button.Visible := False;    // After launch splashscreen is shown, close button will be visible.
     Launch_Splash_Form.Show;
     Launch_Splash_Form.SetFocus;
     Splashscreen_Timer.Enabled := True;
end;

procedure TLaunch_Splash_Form.Splashscreen_Title_StaticTextClick(Sender: TObject);
begin
end;

procedure TLaunch_Splash_Form.Splashscreen_Timer_OnTimer(Sender: TObject);
begin
     Splashscreen_Timer.Enabled := False;
     Launch_Splash_Form.Close;
     Close_SplashScreen_Button.Visible := True;    // After launch splashscreen is shown, close button will be visible.
     Main_Form.Enabled := True;
     if ((not(QSO_Entry_Form = nil)) and (fileExists(contest_long_filename))) then QSO_Entry_Form.Enabled := True;
     if not (Worked_Zones_Form = nil) then Worked_Zones_Form.Enabled := True;
     if not (Statistics_Form = nil) then Statistics_Form.Enabled := True;
end;

procedure TLaunch_Splash_Form.Splashscreen_Details_StaticTextClick(Sender: TObject);
begin
end;

end.
//     OpenURL('https://ve2zaz.net');

