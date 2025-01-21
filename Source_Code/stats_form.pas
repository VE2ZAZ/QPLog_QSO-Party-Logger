unit stats_form;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Grids, Main_Window;

type

  { TStats_Form }

  TStats_Form = class(TForm)
    Stats_StringGrid: TStringGrid;
    Timer1: TTimer;
    procedure Stats_Form_OnShow(Sender: TObject);
    procedure Stats_StringGrid_OnPrepareCanvas(Sender: TObject; aCol,
      aRow: Integer; aState: TGridDrawState);
    procedure Timer1_OnTimer(Sender: TObject);
  private

  public

  end;

var
  Statistics_Form: TStats_Form;

implementation

{$R *.lfm}

{ TStats_Form }

procedure TStats_Form.Stats_Form_OnShow(Sender: TObject);
begin
  Main_Form.CompileStats(Nil);
end;

procedure TStats_Form.Stats_StringGrid_OnPrepareCanvas(Sender: TObject; aCol,
  aRow: Integer; aState: TGridDrawState);
begin
  Stats_StringGrid.ColWidths[0] := 300;          // Adjusts the column header width to fit text
end;

procedure TStats_Form.Timer1_OnTimer(Sender: TObject);
begin
     Main_Form.CompileStats(Nil);
end;

end.

