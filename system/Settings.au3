#include <GuiConstantsEx.au3>
#include <GuiComboBox.au3>
#include <GuiButton.au3>
#include <WindowsConstants.au3>
#include <Date.au3>
#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>

_Settings()

Func _Settings()
	Global $config_ini = (@ScriptDir & "\config.ini")
	Global $install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
	Global $DS_install_dir = IniRead($config_ini, "Einstellungen", "Dedi_Installations_Verzeichnis", "")
	Global $System_Dir = $install_dir & "system\"
	Global $Data_Dir = $install_dir & "data\"
	Global $Sprachdatei = IniRead($config_ini, "Einstellungen", "Sprachdatei", "")
	Global $Sprachdatei_folder = $install_dir & "system\language\"
	Global $PCDSG_Stats_path = IniRead($config_ini, "Einstellungen", "PCDSG_Stats_path", "")
	Global $PCDSG_LOG_ini = $System_Dir & "PCDSG_LOG.ini"

	If $Sprachdatei = "" Then
		$Sprachdatei = $install_dir & "system\language\EN - English.ini"
		IniWrite($config_ini, "Einstellungen", "Sprachdatei", $Sprachdatei)
	EndIf

	Global $Results_copy_2_folder = IniRead($config_ini, "Einstellungen", "PCDSG_Stats_path", "")

	$Wert_Eingabe_Pfad_Dedi = IniRead($config_ini,"Einstellungen", "Dedi_Installations_Verzeichnis", "")
	$Wert_Eingabe_Pfad_HTML = IniRead($config_ini,"Einstellungen", "HTML_local_Verzeichnis", "")
	$Wert_Eingabe_Pfad_HTML_File = IniRead($config_ini,"Einstellungen", "HTML_File_Verzeichnis", "")
	$Wert_Eingabe_Pfad_HTML_web = IniRead($config_ini,"Einstellungen", "HTML_web_Verzeichnis", "")
	$Wert_Eingabe_Pfad_HTML_web_page = IniRead($config_ini,"Einstellungen", "HTML_Status_web_page", "")
	$Wert_Eingabe_Pfad_FTP_DS_Path = IniRead($config_ini,"FTP", "FTP_DS_Path", "")
	$Wert_Eingabe_Pfad_FTP_LUA_Config_Folder = IniRead($config_ini,"FTP", "FTP_LUA_Config_Folder", "")
	;$Wert_Eingabe_Pfad_FTP_Stats_Results_Folder = IniRead($config_ini,"FTP", "FTP_Stats_Results_Folder", "")

	Global $NowDate_Value = _NowDate()
	Global $NowDate = StringReplace($NowDate_Value, "/", ".")
	Global $NowTime_Value = _NowTime()
	Global $NowTime_orig = $NowTime_Value
	Global $NowTime = StringReplace($NowTime_Value, ":", "-")

	#Region Sprachdatei Variablen
	If Not FileExists($Sprachdatei) Then $Sprachdatei = $Sprachdatei_folder & "EN - English.ini"

	$GUI_Label_Einstellungen = IniRead($Sprachdatei,"Language", "Einstellungen", "")

	$Label_GUI_Group_1 = IniRead($Sprachdatei,"Language", "Label_E_GUI_Group_1", "PCDSG Language File")
	$Label_GUI_Group_2 = IniRead($Sprachdatei,"Language", "Label_E_GUI_Group_2", "PCDSG folders")
	$Label_GUI_Group_3 = IniRead($Sprachdatei,"Language", "Label_E_GUI_Group_3", "Empty")
	$Label_GUI_Group_4 = IniRead($Sprachdatei,"Language", "Label_E_GUI_Group_4", "FTP")
	$Label_GUI_Group_5 = IniRead($Sprachdatei,"Language", "Label_E_GUI_Group_5", "PCDSG Settings")

	$Group_1_Label_1 = IniRead($Sprachdatei,"Language", "Group_E_Label_1", "")
	$Group_1_Label_2 = IniRead($Sprachdatei,"Language", "Group_E_Label_2", "")
	$Group_1_Label_3 = IniRead($Sprachdatei,"Language", "Group_E_Label_3", "")
	$Group_1_Label_4 = IniRead($Sprachdatei,"Language", "Group_E_Label_4", "")
	$Group_1_Label_5 = IniRead($Sprachdatei,"Language", "Group_E_Label_5", "")
	$Group_1_Label_6 = IniRead($Sprachdatei,"Language", "Group_E_Label_6", "")
	$Group_1_Label_7 = IniRead($Sprachdatei,"Language", "Group_E_Label_7", "")
	$Group_1_Label_8 = IniRead($Sprachdatei,"Language", "Group_E_Label_8", "")
	$Group_1_Label_9 = IniRead($Sprachdatei,"Language", "Group_E_Label_9", "")
	$Group_1_Label_10 = IniRead($Sprachdatei,"Language", "Group_E_Label_10", "")
	$Group_1_Label_11 = IniRead($Sprachdatei,"Language", "Group_E_Label_11", "")
	$Group_1_Label_12 = IniRead($Sprachdatei,"Language", "Group_E_Label_12", "")
	$Group_1_Label_13 = IniRead($Sprachdatei,"Language", "Group_E_Label_13", "")
	$Group_1_Label_14 = IniRead($Sprachdatei,"Language", "Group_E_Label_14", "")
	$Group_1_Label_15 = IniRead($Sprachdatei,"Language", "Group_E_Label_15", "")
	$Group_1_Label_16 = IniRead($Sprachdatei,"Language", "Group_E_Label_16", "")

	$Group_3_Label_1 = IniRead($Sprachdatei,"Language", "Group_3_Label_1", "")
	$Group_3_Label_2 = IniRead($Sprachdatei,"Language", "Group_3_Label_2", "")
	$Group_3_Label_3 = IniRead($Sprachdatei,"Language", "Group_3_Label_3", "")
	$Group_3_Label_4 = IniRead($Sprachdatei,"Language", "Group_3_Label_4", "")
	$Group_3_Label_5 = IniRead($Sprachdatei,"Language", "Group_3_Label_5", "")
	$Group_3_Label_6 = IniRead($Sprachdatei,"Language", "Group_3_Label_6", "")
	$Group_3_Label_7 = IniRead($Sprachdatei,"Language", "Group_3_Label_7", "")
	$Group_3_Label_8 = IniRead($Sprachdatei,"Language", "Group_3_Label_8", "")
	$Group_3_Label_9 = IniRead($Sprachdatei,"Language", "Group_3_Label_9", "")
	$Group_3_Label_10 = IniRead($Sprachdatei,"Language", "Group_3_Label_10", "")

	$Group_3_DropDown_1_1 = IniRead($Sprachdatei,"Language", "Group_3_DropDown_1_1", "")
	$Group_3_DropDown_1_2 = IniRead($Sprachdatei,"Language", "Group_3_DropDown_1_2", "")
	$Group_3_DropDown_1_3 = IniRead($Sprachdatei,"Language", "Group_3_DropDown_1_3", "")
	$Group_3_DropDown_1_4 = IniRead($Sprachdatei,"Language", "Group_3_DropDown_1_4", "")
	$Group_3_DropDown_1_5 = IniRead($Sprachdatei,"Language", "Group_3_DropDown_1_5", "")

	$Label_Button_1 = IniRead($Sprachdatei,"Language", "Label_Button_1", "")
	$Label_Button_2 = IniRead($Sprachdatei,"Language", "Label_Button_2", "")
	$Label_Button_3 = IniRead($Sprachdatei,"Language", "Label_Button_3", "")
	$Label_Button_4 = IniRead($Sprachdatei,"Language", "Label_Button_4", "")
	$Label_Button_5 = IniRead($Sprachdatei,"Language", "Label_Button_5", "")
	$Label_Button_6 = IniRead($Sprachdatei,"Language", "Label_Button_6", "")
	$Label_Button_7 = IniRead($Sprachdatei,"Language", "Label_Button_7", "")

	$Label_Pfad = IniRead($Sprachdatei,"Language", "Pfad", "")
	$Label_Download = IniRead($Sprachdatei,"Language", "Download", "")
	$Label_Name = IniRead($Sprachdatei,"Language", "Name", "")

	$Label_Update_pruefen = IniRead($Sprachdatei,"Language", "Update_pruefen", "")

	$Text_settings_1 = IniRead($Sprachdatei,"Language", "settings_1", "Autom. auf Update prüfen aktiviert")
	$Text_settings_2 = IniRead($Sprachdatei,"Language", "settings_2", "Autom. auf Update prüfen deaktiviert")
	$Text_settings_3 = IniRead($Sprachdatei,"Language", "settings_3", "Autom. auf Update prüfen aktivieren")
	$Text_settings_4 = IniRead($Sprachdatei,"Language", "settings_4", "Autom. auf Update prüfen deaktivieren")
	$Text_settings_5 = IniRead($Sprachdatei,"Language", "settings_5", "Verzeichnis auswählen")
	$Text_settings_6 = IniRead($Sprachdatei,"Language", "settings_6", "Verzeichnis Datei auswählen")
	#endregion

	$font_arial = "arial"

	GUICreate($GUI_Label_Einstellungen, 756, 295, -1, -1)

	#Region GROUP Left
	GUICtrlCreateGroup($Label_GUI_Group_1, 5, 5, 230, 50)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 11, 400, 6, $font_arial)

	GUICtrlCreateLabel($Group_1_Label_3, 10, 28, 120, 20)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)

	$Wert_Auswahl_Sprachdatei = IniRead($config_ini, "Einstellungen", "Sprachdatei", "")
	$Dateiname_Sprachdatei = StringMid($Wert_Auswahl_Sprachdatei, StringInStr($Wert_Auswahl_Sprachdatei, '\', 2, -1) + 1)
	$Dateiname_Sprachdatei = StringTrimRight($Dateiname_Sprachdatei, 4 )
	$Auswahl_Sprachdatei = GUICtrlCreateCombo("", 130, 25, 100, 25, $CBS_DROPDOWNLIST)

	Local $aFileList = _FileListToArray($Sprachdatei_folder, "*")
	Local $iRows = UBound($aFileList, $UBOUND_ROWS) - 1

	$Sprachdatei_data = ""

	For $language_loop = 1 To $iRows
		$Language_Name = StringReplace($aFileList[$language_loop], ".ini", "")
		$Sprachdatei_data = $Sprachdatei_data & $Language_Name & "|"
	Next

	GUICtrlSetData(-1, $Sprachdatei_data, $Dateiname_Sprachdatei)
	GUISetState()

	GUICtrlCreateGroup("", -99, -99, 1, 1)


	GUICtrlCreateGroup($Label_GUI_Group_2, 5, 60, 230, 105)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 11, 400, 6, $font_arial)

	GUICtrlCreateLabel("'PCDSG Install path:", 10, 78, 200, 20) ;
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Eingabe_PCDSG_Install_path = GUICtrlCreateInput($install_dir, 10, 95, 190, 20)
	$Button_PCDSG_Install_path = GUICtrlCreateButton("...", 205, 94, 25, 22, 0)

	GUICtrlCreateLabel("'PCars DS Install path:", 10, 118, 200, 20) ;
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Eingabe_DS_Install_path = GUICtrlCreateInput($DS_install_dir, 10, 135, 190, 20)
	$Button_DS_Install_path = GUICtrlCreateButton("...", 205, 134, 25, 22, 0)

	GUICtrlCreateGroup("", -99, -99, 1, 1)


	GUICtrlCreateGroup("Results File [automatic created]", 5, 170, 230, 90)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 11, 400, 6, $font_arial)

	GUICtrlCreateLabel("Activate copy path:", 30, 188, 200, 20) ;
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Checkbox_PCDSG_Stats_path = GUICtrlCreateCheckbox("", 10, 205, 20, 20)
	If IniRead($config_ini,"Einstellungen", "Checkbox_PCDSG_Stats_path", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	$Eingabe_PCDSG_Stats_path = GUICtrlCreateInput($PCDSG_Stats_path, 30, 205, 170, 20)
	$Button_PCDSG_Stats_path = GUICtrlCreateButton("...", 205, 204, 25, 22, 0) ;


	$Status_Checkbox_Results_File_Format_TXT = IniRead($config_ini, "PC_Server", "Checkbox_Results_FileFormat_TXT", "")
	$Status_Checkbox_Results_File_Format_INI = IniRead($config_ini, "PC_Server", "Checkbox_Results_FileFormat_INI", "")
	$Status_Checkbox_Results_File_Format_XLS = IniRead($config_ini, "PC_Server", "Checkbox_Results_FileFormat_XLS", "")
	$Status_Checkbox_Results_File_Format_HTM = IniRead($config_ini, "PC_Server", "Checkbox_Results_FileFormat_HTM", "")

	$Checkbox_Results_File_Format_TXT = GUICtrlCreateCheckbox(".TXT", 10, 235, 45, 20)
	If $Status_Checkbox_Results_File_Format_TXT = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	$Checkbox_Results_File_Format_INI = GUICtrlCreateCheckbox(".INI", 68, 235, 45, 20)
	If $Status_Checkbox_Results_File_Format_INI = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	$Checkbox_Results_File_Format_XLS = GUICtrlCreateCheckbox(".XLS", 126, 235, 45, 20)
	If $Status_Checkbox_Results_File_Format_XLS = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	$Checkbox_Results_File_Format_HTM = GUICtrlCreateCheckbox(".HTM", 184, 235, 45, 20)
	If $Status_Checkbox_Results_File_Format_HTM = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	GUICtrlCreateGroup("", -99, -99, 1, 1)
	#endregion

	#Region GROUP center
	GUICtrlCreateGroup($Label_GUI_Group_3, 260, 5, 230, 100)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 11, 400, 6, $font_arial)

	$Status_Checkbox_settings_Misc_1 = IniRead($config_ini,"Einstellungen", "Force_Excel_ProcessClose", "")
	$Checkbox_settings_Misc_1 = GUICtrlCreateCheckbox(" Force MS Excel process to close", 265, 26, 220, 20)
	If $Status_Checkbox_settings_Misc_1 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	GUICtrlCreateGroup("", -99, -99, 1, 1)


	GUICtrlCreateGroup($Label_GUI_Group_4, 260, 115, 230, 145)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 11, 400, 6, $font_arial)


	$Label_Group_1_Label_10_1 = GUICtrlCreateLabel("'Dedicated Server' Folder Path:", 285, 135, 200, 20) ;
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Checkbox_FTP_DS_Path = GUICtrlCreateCheckbox("", 265, 150, 20, 20)
	If IniRead($config_ini,"FTP", "FTP_Upload_DS_Path", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	$Eingabe_Pfad_DS_Path = GUICtrlCreateInput($Wert_Eingabe_Pfad_FTP_DS_Path, 285, 150, 200, 20)


	$Label_Group_1_Label_10 = GUICtrlCreateLabel("'Lua_config' Folder Path:", 285, 173, 200, 20) ;
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Checkbox_FTP_LUA_Config_Folder = GUICtrlCreateCheckbox("", 265, 190, 20, 20)
	If IniRead($config_ini,"FTP", "FTP_Upload_FTP_LUA_Config_Folder", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	$Eingabe_Pfad_FTP_LUA_Config_Folder = GUICtrlCreateInput($Wert_Eingabe_Pfad_FTP_LUA_Config_Folder, 285, 190, 200, 20)


	;$Label_Group_1_Label_11 = GUICtrlCreateLabel("'Result Files' Folder Path:", 285, 215, 200, 20) ;
	;GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	;$Checkbox_FTP_Stats_Results_Folder = GUICtrlCreateCheckbox("", 265, 230, 20, 20)
	;If IniRead($config_ini,"PC_Server", "FTP_Upload_Stats_Results", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	;$Eingabe_Pfad_FTP_Stats_Results_Folder = GUICtrlCreateInput($Wert_Eingabe_Pfad_FTP_Stats_Results_Folder, 285, 230, 200, 20)

	GUICtrlCreateGroup("", -99, -99, 1, 1)
	#endregion

	#Region GROUP right
	GUICtrlCreateGroup($Label_GUI_Group_5, 520, 5, 230, 255)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 11, 400, 6, $font_arial)

	$Status_Checkbox_PCDSG_settings_1 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_1", "")
	$Checkbox_PCDSG_settings_1 = GUICtrlCreateCheckbox(" Autostart / Connect to DS on PCDSG start", 526, 26, 220, 20)
	If $Status_Checkbox_PCDSG_settings_1 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	$Status_Checkbox_PCDSG_settings_2 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_2", "")
	$Checkbox_PCDSG_settings_2 = GUICtrlCreateCheckbox(" Autostart PCarsDSOverview on StartUp", 526, 46, 220, 20)
	If $Status_Checkbox_PCDSG_settings_2 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	$Status_Checkbox_PCDSG_settings_3 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_3", "")
	$Checkbox_PCDSG_settings_3 = GUICtrlCreateCheckbox(" Autostart Race Control on StartUp", 526, 66, 220, 20)
	If $Status_Checkbox_PCDSG_settings_3 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	$Status_Checkbox_PCDSG_settings_4 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_4", "")
	$Checkbox_PCDSG_settings_4 = GUICtrlCreateCheckbox(" Autostart User History on StartUp", 526, 86, 220, 20)
	If $Status_Checkbox_PCDSG_settings_4 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	$Status_Checkbox_PCDSG_settings_5 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_5", "")
	$Checkbox_PCDSG_settings_5 = GUICtrlCreateCheckbox(" Show 'First Start' Guide on next start", 526, 237, 220, 20)
	If $Status_Checkbox_PCDSG_settings_5 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	$Status_Checkbox_PCDSG_settings_6 = IniRead($config_ini,"Einstellungen", "Auto_Change_BC", "")
	$Checkbox_PCDSG_settings_6 = GUICtrlCreateCheckbox(" Automatically change Background color", 526, 136, 220, 20)
	If $Status_Checkbox_PCDSG_settings_6 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	$Status_Checkbox_PCDSG_settings_7 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_7", "")
	$Checkbox_PCDSG_settings_7 = GUICtrlCreateCheckbox(" Launch 'StartPCarsDS.exe' on DS Start", 526, 116, 220, 20)
	If $Status_Checkbox_PCDSG_settings_7 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	$Status_Checkbox_PCDSG_settings_8 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_8", "")
	$Checkbox_PCDSG_settings_8 = GUICtrlCreateCheckbox(" Write Local Network IP to server.cfg", 526, 186, 220, 20)
	If $Status_Checkbox_PCDSG_settings_8 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	$Status_Checkbox_PCDSG_settings_9 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_9", "")
	$Checkbox_PCDSG_settings_9 = GUICtrlCreateCheckbox(" Write Public Network IP to server.cfg", 526, 206, 220, 20)
	If $Status_Checkbox_PCDSG_settings_9 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	$Status_Checkbox_PCDSG_settings_10 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_10", "")
	$Checkbox_PCDSG_settings_10 = GUICtrlCreateCheckbox(" Update 'Track and VehicleList' on StartUp", 526, 156, 220, 20)
	If $Status_Checkbox_PCDSG_settings_10 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	GUICtrlCreateGroup("", -99, -99, 1, 1)
	#endregion


	$Button_SyncFiles = GUICtrlCreateButton(" Synchronize Files", 5, 265, 230, 25, 0)
	_GUICtrlButton_SetImage($Button_SyncFiles, "shell32.dll", 238, False)
	$Button_Speichern_beenden = GUICtrlCreateButton(" " & $Group_1_Label_5, 520, 265, 230, 25, 0)
	_GUICtrlButton_SetImage($Button_Speichern_beenden, "shell32.dll", 258, False)



	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				ExitLoop

			Case $Auswahl_Sprachdatei
				$Auswahl_Einstellung_Sprachdatei = GUICtrlRead($Auswahl_Sprachdatei)
				$Auswahl_Einstellung_Sprachdatei = @ScriptDir & "\language\" & $Auswahl_Einstellung_Sprachdatei & ".ini"
				;MsgBox(0, "$Auswahl_Einstellung_Sprachdatei", $Auswahl_Einstellung_Sprachdatei)
				IniWrite($config_ini, "Einstellungen", "Sprachdatei", $Auswahl_Einstellung_Sprachdatei)

			Case $Checkbox_PCDSG_Stats_path
				$Data_Checkbox_PCDSG_Stats_path = GUICtrlRead($Checkbox_PCDSG_Stats_path)
				If $Data_Checkbox_PCDSG_Stats_path = "1" Then $Data_Checkbox_PCDSG_Stats_path = "true"
				If $Data_Checkbox_PCDSG_Stats_path = "4" Then $Data_Checkbox_PCDSG_Stats_path = "false"
				IniWrite($config_ini, "Einstellungen", "Checkbox_PCDSG_Stats_path", $Data_Checkbox_PCDSG_Stats_path)

			Case $Button_PCDSG_Install_path
				$Auswahl_Verzeichnis = FileSelectFolder($Text_settings_5, "")
				If $Auswahl_Verzeichnis <> "" Then
					GUICtrlSetData($Eingabe_PCDSG_Install_path, $Auswahl_Verzeichnis & "\")
					IniWrite($config_ini, "Einstellungen", "Installations_Verzeichnis", $Auswahl_Verzeichnis & "\")
				EndIf

			Case $Button_DS_Install_path
				$Auswahl_Verzeichnis = FileSelectFolder($Text_settings_5, "")
				If $Auswahl_Verzeichnis <> "" Then
					GUICtrlSetData($Eingabe_DS_Install_path, $Auswahl_Verzeichnis & "\")
					IniWrite($config_ini, "Einstellungen", "Dedi_Installations_Verzeichnis", $Auswahl_Verzeichnis & "\")
				EndIf

			Case $Button_PCDSG_Stats_path
				$Auswahl_Verzeichnis = FileSelectFolder($Text_settings_5, "")
				If $Auswahl_Verzeichnis <> "" Then
					GUICtrlSetData($Eingabe_PCDSG_Stats_path, $Auswahl_Verzeichnis & "\")
					IniWrite($config_ini, "Einstellungen", "PCDSG_Stats_path", $Auswahl_Verzeichnis & "\")
				EndIf

			Case $Checkbox_Results_File_Format_TXT
				$Data_Checkbox = GUICtrlRead($Checkbox_Results_File_Format_TXT)
				If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
				If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
				IniWrite($config_ini, "PC_Server", "Checkbox_Results_FileFormat_TXT", $Data_Checkbox)

			Case $Checkbox_Results_File_Format_INI
				$Data_Checkbox = GUICtrlRead($Checkbox_Results_File_Format_INI)
				If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
				If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
				IniWrite($config_ini, "PC_Server", "Checkbox_Results_FileFormat_INI", $Data_Checkbox)

			Case $Checkbox_Results_File_Format_XLS
				$Data_Checkbox = GUICtrlRead($Checkbox_Results_File_Format_XLS)
				If $Data_Checkbox = "1" Then
					$Exce_2003_Exist = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Excel\', "ExcelName")
					$Exce_2007_Exist = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Excel\', "ExcelName")
					$Exce_2010_Exist = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Excel\', "ExcelName")
					$Exce_2013_Exist = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Excel\', "ExcelName")
					$Exce_2016_Exist = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\', "ExcelName")

					$Installierte_Excel_Version = ""

					If $Exce_2003_Exist <> "" Then $Installierte_Excel_Version = "Excel 2003"
					If $Exce_2007_Exist <> "" Then $Installierte_Excel_Version = "Excel 2007"
					If $Exce_2010_Exist <> "" Then $Installierte_Excel_Version = "Excel 2010"
					If $Exce_2013_Exist <> "" Then $Installierte_Excel_Version = "Excel 2013"
					If $Exce_2016_Exist <> "" Then $Installierte_Excel_Version = "Excel 2016"
					If $Installierte_Excel_Version = "" Then MsgBox(4144, "", "Could not found MS Excel Installation." & @CRLF & @CRLF & "Because of that the functions of the program are limited.")

					IniWrite($config_ini, "Einstellungen", "Excel_version", $Installierte_Excel_Version)

					If $Installierte_Excel_Version <> "" Then $Data_Checkbox = "true"
					If $Installierte_Excel_Version = "" Then $Data_Checkbox = "false"
					If $Installierte_Excel_Version = "" Then GUICtrlSetState($Checkbox_Results_File_Format_XLS, "4")
					If $Installierte_Excel_Version = "" Then MsgBox(4144, "", "Could not found MS Excel Installation." & @CRLF & @CRLF & "MS Excel needs to be installed to be able to use this function.")
				EndIf

				If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
				IniWrite($config_ini, "PC_Server", "Checkbox_Results_FileFormat_XLS", $Data_Checkbox)

			Case $Checkbox_Results_File_Format_HTM
				$Data_Checkbox = GUICtrlRead($Checkbox_Results_File_Format_HTM)
				If $Data_Checkbox = "1" Then
					$Exce_2003_Exist = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Excel\', "ExcelName")
					$Exce_2007_Exist = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Excel\', "ExcelName")
					$Exce_2010_Exist = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Excel\', "ExcelName")
					$Exce_2013_Exist = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Excel\', "ExcelName")
					$Exce_2016_Exist = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\', "ExcelName")

					$Installierte_Excel_Version = ""

					If $Exce_2003_Exist <> "" Then $Installierte_Excel_Version = "Excel 2003"
					If $Exce_2007_Exist <> "" Then $Installierte_Excel_Version = "Excel 2007"
					If $Exce_2010_Exist <> "" Then $Installierte_Excel_Version = "Excel 2010"
					If $Exce_2013_Exist <> "" Then $Installierte_Excel_Version = "Excel 2013"
					If $Exce_2016_Exist <> "" Then $Installierte_Excel_Version = "Excel 2016"
					;If $Installierte_Excel_Version = "" Then MsgBox(4144, "", "Could not found MS Excel Installation." & @CRLF & @CRLF & "Because of that the functions of the program are limited.")

					IniWrite($config_ini, "Einstellungen", "Excel_version", $Installierte_Excel_Version)

					If $Installierte_Excel_Version <> "" Then
						$Data_Checkbox = "true"

						$Abfrage = MsgBox($MB_YESNO + $MB_ICONINFORMATION, "MS Excel Installation available", "Do you prefer MS Excel for the HTM File creation?")

						If $Abfrage = 6 Then
							IniWrite($config_ini, "PC_Server", "Results_Prefer_Excel_HTM_File", "true")
						Else
							IniWrite($config_ini, "PC_Server", "Results_Prefer_Excel_HTM_File", "false")
						EndIf
					Else
						$Data_Checkbox = "true"
						;MsgBox(4144, "", "Could not found MS Excel Installation." & @CRLF & @CRLF & "MS Excel needs to be installed to be able to use this function.")
					EndIf
				EndIf
				If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
				IniWrite($config_ini, "PC_Server", "Checkbox_Results_FileFormat_HTM", $Data_Checkbox)

			Case $Checkbox_settings_Misc_1
				$Data_Checkbox = GUICtrlRead($Checkbox_settings_Misc_1)
				If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
				If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
				IniWrite($config_ini, "Einstellungen", "Force_Excel_ProcessClose", $Data_Checkbox)

			Case $Checkbox_FTP_DS_Path
				$Data_Checkbox_FTP_DS_Path = GUICtrlRead($Checkbox_FTP_DS_Path)
				If $Data_Checkbox_FTP_DS_Path = "1" Then
					$Data_Checkbox_FTP_DS_Path = "true"
					IniWrite($config_ini, "FTP", "FTP_Upload_DS_Path", $Data_Checkbox_FTP_DS_Path)
				Else
					$Data_Checkbox_FTP_DS_Path = "false"
					IniWrite($config_ini, "FTP", "FTP_Upload_DS_Path", $Data_Checkbox_FTP_DS_Path)
				EndIf

			Case $Checkbox_FTP_LUA_Config_Folder
				$Data_Checkbox_FTP_LUA_Config_Folder = GUICtrlRead($Checkbox_FTP_LUA_Config_Folder )
				If $Data_Checkbox_FTP_LUA_Config_Folder  = "1" Then
					$Data_Checkbox_FTP_LUA_Config_Folder  = "true"
					IniWrite($config_ini, "FTP", "FTP_Upload_FTP_LUA_Config_Folder", $Data_Checkbox_FTP_LUA_Config_Folder)
				Else
					$Data_Checkbox_FTP_LUA_Config_Folder  = "false"
					IniWrite($config_ini, "FTP", "FTP_Upload_FTP_LUA_Config_Folder", $Data_Checkbox_FTP_LUA_Config_Folder)
				EndIf

			;Case $Checkbox_FTP_Stats_Results_Folder
				;$Data_Checkbox_FTP_Stats_Results_Folder = GUICtrlRead($Eingabe_Pfad_FTP_Stats_Results_Folder)
				;If $Data_Checkbox_FTP_Stats_Results_Folder = "1" Then $Data_Checkbox_FTP_Stats_Results_Folder = "true"
				;If $Data_Checkbox_FTP_Stats_Results_Folder = "4" Then $Data_Checkbox_FTP_Stats_Results_Folder = "false"
				;IniWrite($config_ini, "FTP", "FTP_Upload_Stats_Results", $Data_Checkbox_FTP_Stats_Results_Folder)

			Case $Checkbox_PCDSG_settings_1
				$Data_Checkbox_1 = GUICtrlRead($Checkbox_PCDSG_settings_1)
				If $Data_Checkbox_1 = "1" Then $Data_Checkbox_1 = "true"
				If $Data_Checkbox_1 = "4" Then $Data_Checkbox_1 = "false"
				IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_1", $Data_Checkbox_1)

			Case $Checkbox_PCDSG_settings_2
				$Data_Checkbox_2 = GUICtrlRead($Checkbox_PCDSG_settings_2)
				If $Data_Checkbox_2 = "1" Then $Data_Checkbox_2 = "true"
				If $Data_Checkbox_2 = "4" Then $Data_Checkbox_2 = "false"
				IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_2", $Data_Checkbox_2)

			Case $Checkbox_PCDSG_settings_3
				$Data_Checkbox_3 = GUICtrlRead($Checkbox_PCDSG_settings_3)
				If $Data_Checkbox_3 = "1" Then $Data_Checkbox_3 = "true"
				If $Data_Checkbox_3 = "4" Then $Data_Checkbox_3 = "false"
				IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_3", $Data_Checkbox_3)

			Case $Checkbox_PCDSG_settings_4
				$Data_Checkbox_4 = GUICtrlRead($Checkbox_PCDSG_settings_4)
				If $Data_Checkbox_4 = "1" Then $Data_Checkbox_4 = "true"
				If $Data_Checkbox_4 = "4" Then $Data_Checkbox_4 = "false"
				IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_4", $Data_Checkbox_4)

			Case $Checkbox_PCDSG_settings_5
				$Data_Checkbox_5 = GUICtrlRead($Checkbox_PCDSG_settings_5)
				If $Data_Checkbox_5 = "1" Then $Data_Checkbox_5 = "true"
				If $Data_Checkbox_5 = "4" Then $Data_Checkbox_5 = "false"
				IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_5", $Data_Checkbox_5)

			Case $Checkbox_PCDSG_settings_6
				$Data_Checkbox_6 = GUICtrlRead($Checkbox_PCDSG_settings_6)
				If $Data_Checkbox_6 = "1" Then $Data_Checkbox_6 = "true"
				If $Data_Checkbox_6 = "4" Then $Data_Checkbox_6 = "false"
				IniWrite($config_ini, "Einstellungen", "Auto_Change_BC", $Data_Checkbox_6)
				IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_6", $Data_Checkbox_6)

			Case $Checkbox_PCDSG_settings_7
				$Data_Checkbox_7 = GUICtrlRead($Checkbox_PCDSG_settings_7)
				If $Data_Checkbox_7 = "1" Then $Data_Checkbox_7 = "true"
				If $Data_Checkbox_7 = "4" Then $Data_Checkbox_7 = "false"
				IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_7", $Data_Checkbox_7)

			Case $Checkbox_PCDSG_settings_8
				$Data_Checkbox_8 = GUICtrlRead($Checkbox_PCDSG_settings_8)
				If $Data_Checkbox_8 = "1" Then $Data_Checkbox_8 = "true"
				If $Data_Checkbox_8 = "4" Then $Data_Checkbox_8 = "false"
				IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_8", $Data_Checkbox_8)
				If $Data_Checkbox_8 = "true" Then GUICtrlSetState ($Checkbox_PCDSG_settings_9, "4")
				If $Data_Checkbox_8 = "true" Then IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_9", "false")

			Case $Checkbox_PCDSG_settings_9
				$Data_Checkbox_9 = GUICtrlRead($Checkbox_PCDSG_settings_9)
				If $Data_Checkbox_9 = "1" Then $Data_Checkbox_9 = "true"
				If $Data_Checkbox_9 = "4" Then $Data_Checkbox_9 = "false"
				IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_9", $Data_Checkbox_9)
				If $Data_Checkbox_9 = "true" Then GUICtrlSetState ($Checkbox_PCDSG_settings_8, "4")
				If $Data_Checkbox_9 = "true" Then IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_8", "false")

			Case $Checkbox_PCDSG_settings_10
				$Data_Checkbox_10 = GUICtrlRead($Checkbox_PCDSG_settings_10)
				If $Data_Checkbox_10 = "1" Then $Data_Checkbox_10 = "true"
				If $Data_Checkbox_10 = "4" Then $Data_Checkbox_10 = "false"
				IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_10", $Data_Checkbox_10)

			Case $Button_SyncFiles
				MsgBox(0, "Synchronization", "Synchronization started...Please wait...", 3)
				$Auswahl_Einstellung_PCDSG_STATS_path = GUICtrlRead($Eingabe_PCDSG_Stats_path)
				If $Auswahl_Einstellung_PCDSG_STATS_path <> "" Then
					IniWrite($config_ini, "TEMP", "Results_saved_TrackName", "SyncFiles function")
					If FileExists($System_Dir & "SyncFiles.exe") Then
						ShellExecuteWait($System_Dir & "SyncFiles.exe")
					Else
						ShellExecuteWait($System_Dir & "SyncFiles.au3")
					EndIf

					If $Results_copy_2_folder <> "" Then
						DirCopy($Data_Dir & "Results", $Results_copy_2_folder & "PCDSG - Results", $FC_OVERWRITE)
					Else
						MsgBox(0, "Folder", "No Folder found." & @CRLF & "Please Check the settings and activate the copy path in 'Results File' section.")
					EndIf

					IniWrite($config_ini, "TEMP", "Results_saved_TrackName", "")
					MsgBox(0, "Synchronization", "Synchronization ended.", 3)
				Else
					MsgBox(0, "No path found", "PCDSG cannot Synchronize the Files." & @CRLF & "There is no path for the Stats and Results folder set.", 3)
				EndIf

			Case $Button_Speichern_beenden
				$Auswahl_Einstellung_Sprachdatei = GUICtrlRead($Auswahl_Sprachdatei)
					$Auswahl_Einstellung_Sprachdatei = @ScriptDir & "\language\" & $Auswahl_Einstellung_Sprachdatei & ".ini"

				$Auswahl_Einstellung_PCDSG_folder = GUICtrlRead($Eingabe_PCDSG_Install_path)
				$Auswahl_Einstellung_DS_folder = GUICtrlRead($Eingabe_DS_Install_path)
				$Auswahl_Einstellung_PCDSG_STATS_path = GUICtrlRead($Eingabe_PCDSG_Stats_path)

				$Auswahl_Path_FTP_DS_Path = GUICtrlRead($Eingabe_Pfad_DS_Path)
					$String_Check_2 = StringRight($Auswahl_Path_FTP_DS_Path, 1)
					If StringRight($String_Check_2, 1 ) <> "/" Then $Auswahl_Path_FTP_DS_Path = $Auswahl_Path_FTP_DS_Path & "/"
				$Auswahl_Path_FTP_LUA_Config_Folder = GUICtrlRead($Eingabe_Pfad_FTP_LUA_Config_Folder)
					$String_Check_2 = StringRight($Auswahl_Path_FTP_LUA_Config_Folder, 1)
					If StringRight($String_Check_2, 1 ) <> "/" Then $Auswahl_Path_FTP_LUA_Config_Folder = $Auswahl_Path_FTP_LUA_Config_Folder & "/"
				;$Auswahl_Path_FTP_Stats_Results_Folder = GUICtrlRead($Eingabe_Pfad_FTP_Stats_Results_Folder)
					;$String_Check_2 = StringRight($Auswahl_Path_FTP_Stats_Results_Folder, 1)
					;If StringRight($String_Check_2, 1 ) <> "/" Then $Auswahl_Path_FTP_Stats_Results_Folder = $Auswahl_Path_FTP_Stats_Results_Folder & "/"

				IniWrite($config_ini, "Einstellungen", "Installations_Verzeichnis", $Auswahl_Einstellung_PCDSG_folder)
				IniWrite($config_ini, "Einstellungen", "Dedi_Installations_Verzeichnis", $Auswahl_Einstellung_DS_folder)
				IniWrite($config_ini, "Einstellungen", "PCDSG_Stats_path", $Auswahl_Einstellung_PCDSG_STATS_path)
				IniWrite($config_ini, "Einstellungen", "Sprachdatei", $Auswahl_Einstellung_Sprachdatei)

				IniWrite($config_ini, "FTP", "FTP_DS_Path", $Auswahl_Path_FTP_DS_Path)
				IniWrite($config_ini, "FTP", "FTP_LUA_Config_Folder", $Auswahl_Path_FTP_LUA_Config_Folder)
				;IniWrite($config_ini, "FTP", "FTP_Stats_Results_Folder", $Auswahl_Path_FTP_Stats_Results_Folder)

				MsgBox(0, "Save", "Save complete.", 1)
				FileWriteLine($PCDSG_LOG_ini, "PCDSG_Settings_saved" & $NowTime & "=" & "PCDSG settings from settings menu" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
				Exit
		EndSwitch
	WEnd
EndFunc
