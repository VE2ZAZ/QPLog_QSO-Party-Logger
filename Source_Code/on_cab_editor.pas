unit on_cab_editor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  Main_Window, cabrillo_file_editor_frame, StrUtils;

type

  { TON_Cab_Edit_Form }

  TON_Cab_Edit_Form = class(TForm)
    ON_Cabrillo_File_Editor_Frame: TCabrillo_File_Editor_Frame;
    procedure Cabrillo_Close_ButtonClick(Sender: TObject);
    procedure Cabrillo_Save_Changes_ButtonClick(Sender: TObject);
    procedure ON_Cab_Edit_Form_OnShow(Sender: TObject);
  private

  public

  end;

var
  ON_Cab_Edit_Form: TON_Cab_Edit_Form;

implementation

{$R *.lfm}

{ TON_Cab_Edit_Form }

procedure TON_Cab_Edit_Form.ON_Cab_Edit_Form_OnShow(Sender: TObject);
begin
  ON_Cabrillo_File_Editor_Frame.Cab_Edit_Form_Memo.Lines.LoadFromFile(on_cab_file_name);
  ON_Cab_Edit_Form.Caption := 'ONTARIO QSO PARTY CABRILLO';
  ON_Cab_Edit_Form.Left := Main_Form.Left + 50;
  ON_Cab_Edit_Form.Top := Main_Form.Top + 50;
end;

procedure TON_Cab_Edit_Form.Cabrillo_Close_ButtonClick(Sender: TObject);
begin
  if (ON_Cabrillo_File_Editor_Frame.Cab_Edit_Form_Memo.Modified) and (MessageDlg(PChar(IfThen(french_lang,'Sauvegarde du Cabrillo', 'Cabrillo Save')), PChar(IfThen(french_lang,'Des modifications non-sauvegardées ont été apportées au fichier Cabrillo. Voulez-vous sauvegarder ces changements?',
                       'Unsaved changes were made to this Cabrillo file. Do you want to save them?')), mtConfirmation, [mbYes, mbNo],1) = mrYes) then
      ON_Cabrillo_File_Editor_Frame.Cab_Edit_Form_Memo.Lines.SaveToFile(qc_cab_file_name);
  ON_Cab_Edit_Form.Visible := False;
end;

procedure TON_Cab_Edit_Form.Cabrillo_Save_Changes_ButtonClick(Sender: TObject);
begin
  ON_Cabrillo_File_Editor_Frame.Cab_Edit_Form_Memo.Lines.SaveToFile(on_cab_file_name);
  ON_Cabrillo_File_Editor_Frame.Cab_Edit_Form_Memo.Modified := False;
end;

end.

