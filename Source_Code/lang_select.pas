unit lang_select;

{$mode ObjFPC}{$H+}

interface


uses
  Classes, SysUtils, Main_Window;

const
    // Main Form (QSO List)
    sMain_Form_Caption : array of String = ('QPLog - Liste des QSOs:  ', 'QPLog - QSO List:  ');
    sReuse_Button : array of String = ('Ré-utiliser QSO','Re-use QSO');
    sEdit_QSO_Button : array of String = ('Éditer QSO','Edit QSO');
    sErase_QSO_Button : array of String = ('Effacer QSO','Erase QSO');
    sErase_All_Button : array of String = ('Effacer Tous QSOs','Erase All QSOs');
    sWorked_Zones_Button : array of String = ('Liste Zones','Zone List');
    sStats_Button : array of String = ('Statistiques','Statistics');
    sLoad_Log_Button : array of String = ('Charger Log','Load Log');
    sNew_Log_Button : array of String = ('Nouveau Log','New Log');
    sConfig_Log_Button : array of String = ('Config Log','Config Log');
    sCopy_Log_Button : array of String =  ('Copier Log','Copy Log');
    sCabrillo_Button : array of String = ('Fich. Cabrillo ','Cabrillo File');
    sLanguage_Button : array of String = ('English','Français');
    sHelp_Button : array of String = ('Aide','Help');
    sAbout_Button : array of String = ('À Propos','About');
    sQSO_List_StringGrid_Date : array of String = ('Date_Heure','Date_Time');
    sQSO_List_StringGrid_ZoneRx : array of String = ('Zone RX','RX Zone');
    sQSO_List_StringGrid_ZoneTx : array of String = ('Zone TX','TX Zone');
    sLog_Create_SaveDialogTitle : array of String = ('Nouveau Fichier de Log', 'New Log File');
    sLog_Load_OpenDialogTitle : array of String = ('Charger Un Log Existant', 'Open An Existing Log');
    sLog_Rename_SaveDialog : array of String = ('Sauvegarder le Log sous...', 'Save Log as..');
    sReuseQSO_MenuItem : array of String = ('Ré-Utiliser le QSO', 'Re-use QSO');
    sEdit_QSO_MenuItem : array of String = ('Éditer le QSO', 'Edit QSO');
    sEraseQSO_MenuItem : array of String = ('Effacer le QSO', 'Erase QSO');
    sEraseAllQSOs_MenuItem : array of String = ('Effacer tous les QSO', 'Erase all QSOs');

    // QSO Entry Form
    sQSO_Entry_Form_Caption : array of String = ('QPLog - Saisie des QSOs:  ', 'QPLog - QSO Entry:  ');
    sTime_Label : array of String = ('Heure', 'Time');
    sCallsign_Label : array of String = ('Indicatif', 'Callsign');
    sQSO_Edit_Label : array of String = ('Saisie d''un QSO', 'QSO Entry');
    sQSO_QSO_Edit_Label : array of String = ('Édition d''un QSO', 'QSO Edit');
    sCancel_Entry_Button : array of String = ('Effacer', 'Erase');
    sSave_Entry_Button : array of String = ('Sauvegarder', 'Save');
    sModify_Entry_Button : array of String = ('Modifier', 'Modify');
    sModify_Cancel_Entry_Button : array of String = ('Annuler', 'Cancel');

    // Worked_Zones_Form
    sWorked_Zones_Form_Caption : array of String = ('Zones et Stations Commanditaires Contactées', 'Contacted Zones and Sponsor Stations');
    sInProvince_Label : array of String = ('En-Province', 'In-Province');
    sOutOfProvince_Label : array of String = ('Hors-Province', 'Out-of-Province');
    sBonus_Label : array of String = ('Commanditaire', 'Sponsoring');
    sNot_Counted_Label : array of String = ('Non-Comptée', 'Not-Counted');

    // Statistics_Form
    sStatistics_Form_Caption : array of String = ('Statistiques et Scores', 'Statistics and Scores');
    sStats_StringGrid_0 : array of String = (' Nombre de QSOs - SSB/FM', ' Number of QSOs - SSB/FM');
    sStats_StringGrid_1 : array of String = (' Nombre de QSOs - CW', ' Number of QSOs - CW');
    sStats_StringGrid_2 : array of String = ('Nombre de QSOs - TOTAL', 'Number of QSOs - TOTAL');
    sStats_StringGrid_3 : array of String = (' Nombre de QSOs doublons - SSB/FM', ' Number of dupe QSOs - SSB/FM');
    sStats_StringGrid_4 : array of String = (' Nombre de QSOs doublons - CW', ' Number of dupe QSOs - CW');
    sStats_StringGrid_5 : array of String = (' Nombre de QSOs doublons - TOTAL', ' Number of dupe QSOs - TOTAL');
    sStats_StringGrid_6 : array of String = ('Nombre de Zones visitées', 'Number of visited Zones');
    sStats_StringGrid_7 : array of String = ('Nombre de Zones activées en Mobile', 'Number of Zones activated as Mobile');
    sStats_StringGrid_8 : array of String = ('Nombre de Stations Commanditaires', 'Number of Sponsoring Stations');
    sStats_StringGrid_9 : array of String = ('Nombre de Multiplicateurs', 'Number of Multipliers');
    sStats_StringGrid_10 : array of String = ('Pointage des QSOs', 'QSO Score');
    sStats_StringGrid_11 : array of String = ('Pointage Bonus', 'Bonus Score');
    sStats_StringGrid_12 : array of String = ('POINTAGE TOTAL', 'TOTAL SCORE');

    // QC_Cab_Edit_Form
    sCabrillo_Save_Changes_Button : array of String = ('Sauvegarder Changements', 'Save Changes');
    sCabrillo_Close_Button : array of String = ('Fermer', 'Close');

    //Soapbox_Form
    sSoapBox_Form_SoapBox_Memo_Lines_Text : array of String = ('Ici, vous pouvez ajouter des commentaires au fichier Cabrillo de ce QSO Party, par exemple votre appréciation '
                                              + 'du contest ou votre évaluation de la propagation en présence. Ces commentaires seront lus par les organisateurs '
                                              + 'et pourraient être publié sur le site web du QSO Party. Un maximum de 400 caractères est permis.',
                                              'Here, you can add comments to the Cabrillo file of this QSO Party, for example, your feedback on the contest or '
                                              + 'your evaluation of the propagation conditions during the event. These comments will be read by the organizers '
                                              + 'and may be published on the QSO Party website. A maximum of 400 characters is allowed.');

    //Log_Setup_Form
    sLog_Setup_Form_Caption : array of String = ('Configuration du Log du QSO Party', 'QSO Party Log Configuration');
    sParty_Select_RadioGroup : array of String = ('Sélection du QSO Party', 'QSO Party Selection');
    sStation_GroupBox : array of String = ('Votre station', 'Your Station');
    sStation_Callsign_LabeledEdit : array of String = ('Indicatif', 'Callsign');
    sZone_Label : array of String = ('Zone Provinciale', 'Provincial Zone');
    sLocation_Label : array of String = ('Emplacement', 'Location');
    sOps_Callsign_LabeledEdit : array of String = ('MULTI - Indicatifs des Opérateurs', 'MULTI - Operators'' Callsigns');
    sOpName_LabeledEdit : array of String = ('Nom Complet', 'Full Name');
    sEmail_LabeledEdit : array of String = ('Courriel', 'Email');
    sClub_LabeledEdit : array of String = ('Club Affilié (Optionnel)', 'Affiliated Club (Optional)');
    sCategory_GroupBox : array of String = ('Catégorie', 'Category');
    sCat_Type_Label : array of String = ('Type d''Opération', 'Type of Operation');
    sCat_Power_Label : array of String = ('Puissance Tx', 'Tx Power');
    sCat_Num_Xmit_Label : array of String = ('Nb. d''Émetteurs', 'Num. Transmitters');
    sCat_Mode_Label : array of String = ('Mode', 'Mode');
    sCat_Station_Type_Label : array of String = ('Type de Station', 'Station Type');
    sSetup_Close_Button : array of String = ('Fermer', 'Close');
    sParty_Select_RadioGroup_Hint : array of String = ('QC: Participation au Québec QSO Party seulement.' + sLineBreak +
                                                       'Les QSOs avec les stations ontariennes peuvent être saisis avec la Zone "ON"' + sLineBreak +
                                                       'ou avec les comtés ontariens à trois lettres.' + sLineBreak +
                                                       ' ' + sLineBreak +
                                                       'ON: Participation au Ontario QSO Party seulement.' + sLineBreak +
                                                       'Les QSOs avec les stations québécoises peuvent être saisis avec la Zone "QC"' + sLineBreak +
                                                       'ou avec les régions administratives québécoises à trois lettres.' + sLineBreak +
                                                       ' ' + sLineBreak +
                                                       'QC+ON: Participation simultanée au Québec QSO Party et au Ontario QSO Party.' + sLineBreak +
                                                       'Les QSOs de stations québécoises et ontariennes doivent être saisis avec leur' + sLineBreak +
                                                       'région administrative ou comté à trois lettres. Tout QSO saisi avec la zone "QC"' + sLineBreak +
                                                       'ou "ON" sera exclu du score du Party correspondant.',
                                                       'QC: Participation in the Québec QSO Party only.' + sLineBreak +
                                                       'QSOs with stations in Ontario can be logged with the "ON" Zone ' + sLineBreak +
                                                       'or with the three-letter Ontario counties.' + sLineBreak +
                                                       ' ' + sLineBreak +
                                                       'ON: Participation in the Ontario QSO Party only.' + sLineBreak +
                                                       'QSOs with stations in Québec can be logged with the "QC" Zone' + sLineBreak +
                                                       'or with the three-letter administrative regions of Québec.' + sLineBreak +
                                                       ' ' + sLineBreak +
                                                       'QC+ON: Simultaneous participation in both the Québec QSO Party and the Ontario QSO Party.' + sLineBreak +
                                                       'QSOs with stations from Québec and Ontario must be logged with their respective' + sLineBreak +
                                                       'administrative regions or counties in three letters. Any QSO logged with the "QC"' + sLineBreak +
                                                       'or "ON" zone will be excluded from the score of the corresponding Party.');

    // Splashscreen
    sContribList :  array of String = ('Auteur: Bertrand Zauhar, VE2ZAZ - VA2IW' + sLineBreak +
                                       'Coordonateur: Georges-André Chaudron, VE2VAB' + sLineBreak + ' ' + sLineBreak +   // Space required otherwise two line breaks do not work.
                                       'Testeurs Béta:' + sLineBreak +
                                       'Jean-Pierre Boulanger, VE2ITY' + sLineBreak +
                                       'Ante Laurijssen, VA2BBW' + sLineBreak +
                                       'Jonathan Lévesque, VA2LOJ' + sLineBreak +
                                       'Georges-André Chaudron, VE2VAB',
                                       'Author: Bertrand Zauhar, VE2ZAZ - VA2IW' + sLineBreak +
                                       'Coordinator: Georges-André Chaudron, VE2VAB' + sLineBreak + ' ' + sLineBreak +   // Space required otherwise two line breaks do not work.
                                       'Beta Testers:' + sLineBreak +
                                       'Jean-Pierre Boulanger, VE2ITY' + sLineBreak +
                                       'Ante Laurijssen, VA2BBW' + sLineBreak +
                                       'Jonathan Lévesque, VA2LOJ' + sLineBreak +
                                       'Georges-André Chaudron, VE2VAB');
    sClose_SplashScreen_Button : array of String = ('Fermer', 'Close');


    procedure Switch_Lang(Sender: TObject);

implementation
uses QSO_Entry, Worked_Zones, stats_form, qc_cab_editor, on_cab_editor, Log_Setup, Launch_Splashscreen;

procedure Switch_Lang(Sender: TObject);
begin
    // Main Form (QSO List)
    with Main_Form do
    begin
         Caption := sMain_Form_Caption[language] + contest_filename;
         Reuse_Button.Caption := sReuse_Button[language];
         Edit_QSO_Button.Caption := sEdit_QSO_Button[language];
         Erase_QSO_Button.Caption := sErase_QSO_Button[language];
         Erase_All_Button.Caption := sErase_All_Button[language];
         Worked_Zones_Button.Caption := sWorked_Zones_Button[language];
         Stats_Button.Caption := sStats_Button[language];
         Load_Log_Button.Caption := sLoad_Log_Button[language];
         New_Log_Button.Caption := sNew_Log_Button[language];
         Config_Log_Button.Caption := sConfig_Log_Button[language];
         Copy_Log_Button.Caption := sCopy_Log_Button[language];
         Cabrillo_Button.Caption := sCabrillo_Button[language];
         Language_Button.Caption := sLanguage_Button[language];
         Help_Button.Caption := sHelp_Button[language];
         About_Button.Caption := sAbout_Button[language];
         QSO_List_StringGrid.Columns.Items[0].Title.Caption := sQSO_List_StringGrid_Date[language];
         QSO_List_StringGrid.Columns.Items[5].Title.Caption := sQSO_List_StringGrid_ZoneRx[language];
         QSO_List_StringGrid.Columns.Items[7].Title.Caption := sQSO_List_StringGrid_ZoneTx[language];
         ReuseQSO_MenuItem.Caption := sReuseQSO_MenuItem[language];
         Edit_QSO_MenuItem.Caption := sEdit_QSO_MenuItem[language];
         EraseQSO_MenuItem.Caption := sEraseQSO_MenuItem[language];
         EraseAllQSOs_MenuItem.Caption := sEraseAllQSOs_MenuItem[language];
    end;
    with QSO_Entry_Form do
    begin
         Caption := sQSO_Entry_Form_Caption[language];
         Time_Label.Caption := sTime_Label[language];
         Callsign_Label.Caption := sCallsign_Label[language];
         Cancel_Entry_Button.Caption := sCancel_Entry_Button[language];
         Save_Entry_Button.Caption := sSave_Entry_Button[language];
         if not(qso_in_edit_flag) then QSO_Entry_Form.QSO_Edit_Label.Caption := sQSO_Edit_Label[language] else QSO_Entry_Form.QSO_Edit_Label.Caption := sQSO_QSO_Edit_Label[language];

    end;
    with Worked_Zones_Form do
    begin
         Caption := sWorked_Zones_Form_Caption[language];
         InProvince_Label.Caption := sInProvince_Label[language];
         OutOfProvince_Label.Caption := sOutOfProvince_Label[language];
         Bonus_Label.Caption := sBonus_Label[language];
         Not_Counted_Label.Caption := sNot_Counted_Label[language];
    end;
    with Statistics_Form do
    begin
         Caption := sStatistics_Form_Caption[language];
         Stats_StringGrid.Cells[0,1] := sStats_StringGrid_0[language];
         Stats_StringGrid.Cells[0,2] := sStats_StringGrid_1[language];
         Stats_StringGrid.Cells[0,3] := sStats_StringGrid_2[language];
         Stats_StringGrid.Cells[0,4] := sStats_StringGrid_3[language];
         Stats_StringGrid.Cells[0,5] := sStats_StringGrid_4[language];
         Stats_StringGrid.Cells[0,6] := sStats_StringGrid_5[language];
         Stats_StringGrid.Cells[0,7] := sStats_StringGrid_6[language];
         Stats_StringGrid.Cells[0,8] := sStats_StringGrid_7[language];
         Stats_StringGrid.Cells[0,9] := sStats_StringGrid_8[language];
         Stats_StringGrid.Cells[0,10] := sStats_StringGrid_9[language];
         Stats_StringGrid.Cells[0,11] := sStats_StringGrid_10[language];
         Stats_StringGrid.Cells[0,12] := sStats_StringGrid_11[language];
         Stats_StringGrid.Cells[0,13] := sStats_StringGrid_12[language];
    end;
    with QC_Cab_Edit_Form.QC_Cabrillo_File_Editor_Frame do
    begin
         Cabrillo_Save_Changes_Button.Caption := sCabrillo_Save_Changes_Button[language];
         Cabrillo_Close_Button.Caption := sCabrillo_Close_Button[language];
    end;
    with ON_Cab_Edit_Form.ON_Cabrillo_File_Editor_Frame do
    begin
         Cabrillo_Save_Changes_Button.Caption := sCabrillo_Save_Changes_Button[language];
         Cabrillo_Close_Button.Caption := sCabrillo_Close_Button[language];
    end;
        with Log_Setup_Form do
    begin
         Log_Setup_Form.Caption := sLog_Setup_Form_Caption[language];
         Party_Select_RadioGroup.Caption := sParty_Select_RadioGroup[language];
         Station_GroupBox.Caption := sStation_GroupBox[language];
         Station_Callsign_LabeledEdit.EditLabel.Caption := sStation_Callsign_LabeledEdit[language];
         Zone_Label.Caption := sZone_LAbel[language];
         Location_Label.Caption := sLocation_Label[language];
         Ops_Callsign_LabeledEdit.EditLabel.Caption := sOps_Callsign_LabeledEdit[language];
         OpName_LabeledEdit.EditLabel.Caption := sOpName_LabeledEdit[language];
         Email_LabeledEdit.EditLabel.Caption := sEmail_LabeledEdit[language];
         Club_LabeledEdit.EditLabel.Caption := sClub_LabeledEdit[language];
         Category_GroupBox.Caption := sCategory_GroupBox[language];
         Cat_Type_Label.Caption := sCat_Type_Label[language];
         Cat_Power_Label.Caption := sCat_Power_Label[language];
         Cat_Num_Xmit_Label.Caption := sCat_Num_Xmit_Label[language];
         Cat_Mode_Label.Caption := sCat_Mode_Label[language];
         Cat_Station_Type_Label.Caption := sCat_Station_Type_Label[language];
         Setup_Close_Button.Caption := sSetup_Close_Button[language];
         Setup_Help_Button.Caption := sHelp_Button[language];
         Party_Select_RadioGroup.Hint := sParty_Select_RadioGroup_Hint[language];
    end;
end;

end.

