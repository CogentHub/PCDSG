#Region Includes
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiButton.au3>
#include <StaticConstants.au3>
#include <GuiListView.au3>
#include <File.au3>
#include <GuiStatusBar.au3>
#include <Excel.au3>
#include <TabConstants.au3>
#include <GuiComboBox.au3>
#include <IE.au3>
#include <FTPEx.au3>
#Include <string.au3>
#include <Inet.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <Date.au3>
#include <MsgBoxConstants.au3>
#include <Process.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
#Include <WinAPIEx.au3>
#include <ColorConstants.au3>
#EndRegion Includes

#Region Declare Globals
Global $config_ini, $install_dir, $Dedi_configCFG_sample
Global $ListView, $ListView_Produktinformationen, $iMemo_unten, $idTreeView, $Statusbar, $GUI, $id_Projekt, $iwParam
Global $Func_Neuen_Ordner_erstellen_ausgefuert, $Verzeichnisse_aktualisieren_ausgefuert, $Verzeichnis_Produkte, $Aufnahme_lauft_icon
Global $ZM_LabelGZ2, $ZM_LabelGZ3, $ZM_LabelGZ4, $ZM_LabelGZ5, $ZM_LabelGZ6, $ZM_LabelGZ7, $ZM_LabelGZ8, $ZM_LabelGZ9, $ZM_LabelGZ10, $ZM_LabelGZ11, $ZM_LabelGZ12, $ZM_LabelGZ13, $ZM_LabelG14, $ZM_LabelGZ15
Global $Wert_logLevel, $Wert_eventsLogSize, $Wert_name, $Wert_secure, $Wert_password, $Wert_maxPlayerCount, $Wert_GridSize, $Wert_steamPort, $Wert_hostPort, $Wert_queryPort, $Wert_sleepWaiting, $Wert_sleepActive, $Wert_enableHttpApi, $Wert_httpApiLogLevel, $Wert_httpApiInterface, $Wert_httpApiPort, $Wert_allowEmptyJoin, $Wert_controlGameSetup
Global $Dedi_config_cfg, $Dedi_Installations_Verzeichnis, $Dedi_Verzeichnis
Global $Lesen_Auswahl_loglevel, $Lesen_Auswahl_eventsLogSize, $Lesen_Auswahl_name, $Lesen_Auswahl_secure, $Lesen_Auswahl_password, $Lesen_Auswahl_maxPlayerCount
Global $Lesen_Auswahl_bindIP, $Lesen_Auswahl_steamPort, $Lesen_Auswahl_hostPort, $Lesen_Auswahl_queryPort, $Lesen_Auswahl_sleepWaiting, $Lesen_Auswahl_sleepActive
Global $Lesen_Auswahl_enableHttpApi, $Lesen_Auswahl_httpApiLogLevel, $Lesen_Auswahl_httpApiInterface, $Lesen_Auswahl_httpApiPort, $Lesen_Auswahl_whitelist
Global $Lesen_Auswahl_blacklist, $Lesen_Auswahl_allowEmptyJoin, $Lesen_Auswahl_controlGameSetup
Global $Wert_ServerControlsTrack, $Wert_ServerControlsVehicleClass, $Wert_ServerControlsVehicle, $GUI, $GUI_Users
Global $InputPCDSG_USERName, $Combo_httpApiAccessLevel, $Combo_status, $Combo_Public_rules
Global $Input_Name_1, $Input_Name_2, $Input_Name_3, $Input_Name_4, $Input_Name_5
Global $Input_password_Name_1, $Input_password_Name_2, $Input_password_Name_3, $Input_password_Name_4, $Input_password_Name_5
Global $Combo_Group_Private_1, $Combo_Group_Private_2, $Combo_Group_Private_3, $Combo_Group_Private_4, $Combo_Group_Private_5
Global $Combo_Group_Admin_1, $Combo_Group_Admin_2, $Combo_Group_Admin_3, $Combo_Group_Admin_4, $Combo_Group_Admin_5
Global $TAB_6_Button1, $TAB_6_Button2, $TAB_6_Button3, $TAB_6_Button4
Global $Check_Line_plus_1_1, $Check_Line_plus_2_1, $Check_Line_plus_3_1, $Check_Line_plus_4_1, $Check_Line_plus_5_1
Global $Check_Line_plus_1_2, $Check_Line_plus_2_2, $Check_Line_plus_3_2, $Check_Line_plus_4_2, $Check_Line_plus_5_2
Global $Value_httpApiAccessLevels, $Value_httpApi_status, $Value_httpApiAccessFilters
Global $Value_httpApiUser_1_Name, $Value_httpApiUser_1_Password, $Value_httpApiUser_2_Name, $Value_httpApiUser_2_Password, $Value_httpApiUser_3_Name, $Value_httpApiUser_3_Password
Global $Value_httpApiUser_4_Name, $Value_httpApiUser_4_Password, $Value_httpApiUser_5_Name, $Value_httpApiUser_5_Password
Global $Value_httpApi_GroupAdminUser_Name_1, $Value_httpApi_GroupAdminUser_Name_2, $Value_httpApi_GroupAdminUser_Name_3, $Value_httpApi_GroupAdminUser_Name_4, $Value_httpApi_GroupAdminUser_Name_5
Global $Value_httpApi_GroupUser_Name_1, $Check_User_1, $Value_httpApi_GroupUser_Name_2, $Check_User_2, $Value_httpApi_GroupUser_Name_3, $Check_User_3
Global $Value_httpApi_GroupUser_Name_4, $Check_User_4, $Value_httpApi_GroupUser_Name_5, $Check_User_5
Global $Check_Status_1, $Check_httpApiAccessLevels_1, $Check_Public_rules_1
Global $Check_Checkbox_User_1, $Check_Checkbox_User_2, $Check_Checkbox_User_3, $Check_Checkbox_User_4, $Check_Checkbox_User_5
Global $Read_Checkbox_Activate_HTTPUsers, $Read_Activate_httpApiAccessLevel, $Read_Combo_httpApiAccessLevel, $Read_Checkbox_Activate_status
Global $Checkbox_Activate_HTTPUsers, $Checkbox_Activate_httpApiAccessLevel, $Combo_httpApiAccessLevel, $Checkbox_Activate_status
Global $Checkbox_User_1, $Checkbox_User_2, $Checkbox_User_3, $Checkbox_User_4, $Checkbox_User_5
Global $Check_Line_1, $Check_Line_2, $Check_Line_3, $Check_Line_4, $Check_Line_5
Global $Tab3_Button_1,$Tab3_Button_2, $Tab3_Button_3, $Tab3_Button_4, $Tab3_Button_5
Global $Tab3_Pfad_Button_1, $Tab3_Pfad_Button_2, $Tab3_Pfad_Button_3, $Tab3_Pfad_Button_4, $Tab3_Pfad_Button_5
Global $Check_AdminUser_, $Check_AdminUser_2, $Check_AdminUser_3, $Check_AdminUser_4, $Check_AdminUser_5
Global $GUI_Loading
#EndRegion Declare Globals

Opt("GUIOnEventMode", 1)
Opt("GUIDataSeparatorChar", "|")

$ListViewSeperator = "|"

#Region Declare Globals
Global $oIE, $oIE_GUI
#EndRegion Declare Globals

#Region Declare Variables
Global $config_ini = @ScriptDir & "\system\" & "config.ini"
Global $install_dir = IniRead($config_ini,"Einstellungen", "Installations_Verzeichnis", "")
Global $Backup_dir = $install_dir & "Backup\"
Global $System_Dir = $install_dir & "system\"
Global $Sprachdatei = IniRead($config_ini,"Einstellungen", "Sprachdatei", "")
Global $Sprachdatei_folder = $System_Dir & "language\"
Global $Dedi_Installations_Verzeichnis = IniRead($config_ini, "Einstellungen", "Dedi_Installations_Verzeichnis", "")
Global $Dedi_Verzeichnis = $Dedi_Installations_Verzeichnis
Global $Dedi_configCFG_sample = $install_dir & "Templates\config\server.cfg"
Global $PCDSG_LOG_ini = $System_Dir & "PCDSG_LOG.ini"
Global $DB_path = $System_Dir & "Database.sqlite"
Global $PCDSG_Network_Card_IP= IniRead($config_ini, "Einstellungen", "Network_Card_IP", "")
Global $NowDate_Value = _NowDate()
Global $NowDate = StringReplace($NowDate_Value, "/", ".")
Global $NowTime_Value = _NowTime()
Global $NowTime_orig = $NowTime_Value
Global $NowTime = StringReplace($NowTime_Value, ":", "-")

Global $PCDSG_DS_Mode = IniRead($config_ini,"PC_Server", "DS_Mode", "")
Global $DS_PublicIP = IniRead($config_ini,"PC_Server", "DS_PublicIP", "")
Global $DS_API_Port = IniRead($config_ini,"PC_Server", "DS_API_Port", "")

Global $Dedi_config_cfg = $Dedi_Installations_Verzeichnis & "server.cfg"

Global $sms_rotate_config_json_File = $Dedi_Installations_Verzeichnis & "lua_config\sms_rotate_config.json"


$Status_Checkbox_PCDSG_settings_8 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_8", "")
$Status_Checkbox_PCDSG_settings_9 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_9", "")


;Server http settings lesen
Global $Name_User = ""
Global $Name_Password = ""
If IniRead($config_ini, "Server_Einstellungen", "Group_Admin_1", "") <> "" Then
	Local $Name_User = IniRead($config_ini, "Server_Einstellungen", "Group_Admin_1", "")
	Local $Password_User = IniRead($config_ini, "Server_Einstellungen", "password_User_1", "")
	$Name_Password = $Name_User & ":" & $Password_User & "@"
EndIf

Local $DS_Mode_Temp = IniRead($config_ini, "PC_Server", "DS_Mode", "local")
If $DS_Mode_Temp = "local" Then
	If $Name_User <> "" And $Password_User <> "" Then
		Global $Lesen_Auswahl_httpApiInterface = $Name_Password & IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
		Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

		If IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "") = "" Then Global $Lesen_Auswahl_httpApiInterface = $Name_Password & "localhost" ; "127.0.0.1"
		If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"
		;MsgBox(0, "$Lesen_Auswahl_httpApiInterface", $Lesen_Auswahl_httpApiInterface)
	Else
		Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
		Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

		If IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "") = "" Then Global $Lesen_Auswahl_httpApiInterface = "localhost" ; "127.0.0.1"
		If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"
	EndIf
EndIf
If $DS_Mode_Temp = "remote" Then
	If $Name_User <> "" And $Password_User <> "" Then
		Global $Lesen_Auswahl_httpApiInterface = $Name_Password & IniRead($config_ini, "Server_Einstellungen", "DS_Domain_or_IP", "")
		Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

		;If IniRead($config_ini, "Server_Einstellungen", "DS_Domain_or_IP", "") = "" Then Global $Lesen_Auswahl_httpApiInterface = $Name_Password & "localhost" ; "127.0.0.1"
		If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"
	Else
		Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "DS_Domain_or_IP", "")
		Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

		;If IniRead($config_ini, "Server_Einstellungen", "DS_Domain_or_IP", "") = "" Then Global $Lesen_Auswahl_httpApiInterface = "localhost" ; "127.0.0.1"
		If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"
	EndIf
EndIf
#EndRegion Declare Variables


If $Dedi_Installations_Verzeichnis = "" Then
	StartUp_settings()
	IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_5", "false")
EndIf

If $PCDSG_DS_Mode = "local" Then
	If Not FileExists($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe") Then
		MsgBox(0, "Steam DS folder", "DedicatedServerCmd.exe was not found DS folder " & "'" & $Dedi_Installations_Verzeichnis & "'" & @CRLF & "Choose the local folder where the Steam DS app is installed.")
		StartUp_settings()
		IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_5", "false")
	EndIf
EndIf

$Checkbox_PCDSG_settings_5 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_5", "")
If $Checkbox_PCDSG_settings_5 = "true" Then
	StartUp_settings()
EndIf

_Loading_GUI()

$PCDSG_DS_Mode = IniRead($config_ini,"PC_Server", "DS_Mode", "")
$DS_PublicIP = IniRead($config_ini,"PC_Server", "DS_PublicIP", "")
$DS_API_Port = IniRead($config_ini,"PC_Server", "DS_API_Port", "")

Global $DS_Domain_or_IP = IniRead($config_ini, "PC_Server", "DS_Domain_or_IP", "")

If $PCDSG_DS_Mode = "" Then
	IniWrite($config_ini, "PC_Server", "DS_Mode", "local")
	$PCDSG_DS_Mode = IniRead($config_ini,"PC_Server", "DS_Mode", "")
EndIf

If $Sprachdatei = "" Then
	$Sprachdatei = $install_dir & "system\language\EN - English.ini"
	IniWrite($config_ini, "Einstellungen", "Sprachdatei", $Sprachdatei)
EndIf

If Not FileExists($Sprachdatei) Then
	$Sprachdatei = $install_dir & "system\language\EN - English.ini"
	IniWrite($config_ini, "Einstellungen", "Sprachdatei", $Sprachdatei)
EndIf

IniWrite($config_ini, "Einstellungen", "Installations_Verzeichnis", @ScriptDir & "\")
IniWrite($config_ini, "Einstellungen", "Version", "1.5 (beta)")

$install_dir = IniRead($config_ini,"Einstellungen", "Installations_Verzeichnis", "")
$Aktuelle_Version = IniRead($config_ini, "Einstellungen", "Version", "")
$System_Dir = $install_dir & "system\"
$Data_Dir = $install_dir & "data\"
$Auto_Update = IniRead($config_ini,"Einstellungen", "Auto_Update", "")
$Info_drivers_AT_ini = ($install_dir & "system\PCDSG_Info_drivers_AT.ini")

$LOG_Data_INI = $System_Dir & "Server_LOG.ini"

$Whitelist_File = $install_dir & "whitelist.cfg"
$Blacklist_File = $install_dir & "blacklist.cfg"

$status_json = $System_Dir & "status.json"

$Web_Page = IniRead($config_ini,"Einstellungen", "WebPage", "")


#Region Check Excel Exists
; Check Excel Exists
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

If $Installierte_Excel_Version = "" Then
	IniWrite($config_ini, "PC_Server", "Checkbox_Results_FileFormat_XLS", "false")
	IniWrite($config_ini, "PC_Server", "Checkbox_Results_FileFormat_HTM", "false")
EndIf

IniWrite($config_ini, "Einstellungen", "Excel_version", $Installierte_Excel_Version)

#endregion Check Excel/IE Exists

#Region Check IE Exists
; Check IE Exists
$IE_Exist = ""
$IE_Exist = RegRead('HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\', "Version")
If $IE_Exist = "" Then MsgBox(4144, "", "Could not found MS Internet Explorer Installation." & @CRLF & @CRLF & "Because of that the functions of the program are limited.", 3)
IniWrite($config_ini, "Einstellungen", "IE_version", $IE_Exist)
#endregion Check Excel/IE Exists

#Region Check TaskBarPos
_Check_TaskBarPos()
#endregion Check TaskBarPos

#Region Declare Variables/Const
$Programm_Verzeichnis = $install_dir & "\system\"
$Sprachdatei = IniRead($config_ini,"Einstellungen", "Sprachdatei", "")
	If Not FileExists($Sprachdatei) Then $Sprachdatei = $install_dir & "system\language\EN - English.ini"
Global $GUI_Name = "Project Cars - Dedicated Server GUI"

$gfx = (@ScriptDir & "\" & "system\gfx\")

$Label_GUI_Button0 = IniRead($Sprachdatei,"Language", "Label_GUI_Button0", "Start Server")
$Label_GUI_Button1 = IniRead($Sprachdatei,"Language", "Label_GUI_Button1", "Connect to Srver")
$Label_GUI_Button2 = IniRead($Sprachdatei,"Language", "Label_GUI_Button2", "Web page")
$Label_GUI_Button3 = IniRead($Sprachdatei,"Language", "Label_GUI_Button3", "Close Server")
$Label_GUI_Button4 = IniRead($Sprachdatei,"Language", "Label_GUI_Button4", "")
$Label_GUI_Button5 = IniRead($Sprachdatei,"Language", "Label_GUI_Button5", "")


$Info_GUI_Button1_1 = IniRead($Sprachdatei,"Language", "Info_GUI_Button1_1", "")
$Info_GUI_Button1_2 = IniRead($Sprachdatei,"Language", "Info_GUI_Button1_2", "")
$Info_GUI_Button1_3 = IniRead($Sprachdatei,"Language", "Info_GUI_Button1_3", "")
$Info_GUI_Button1_4 = IniRead($Sprachdatei,"Language", "Info_GUI_Button1_4", "")
$Info_GUI_Button1_5 = IniRead($Sprachdatei,"Language", "Info_GUI_Button1_5", "")

$Info_GUI_Button2_1 = IniRead($Sprachdatei,"Language", "Info_GUI_Button2_1", "")
$Info_GUI_Button2_2 = IniRead($Sprachdatei,"Language", "Info_GUI_Button2_2", "")
$Info_GUI_Button2_3 = IniRead($Sprachdatei,"Language", "Info_GUI_Button2_3", "")
$Info_GUI_Button2_4 = IniRead($Sprachdatei,"Language", "Info_GUI_Button2_4", "")

$Info_GUI_Button3_1 = IniRead($Sprachdatei,"Language", "Info_GUI_Button3_1", "")
$Info_GUI_Button3_2 = IniRead($Sprachdatei,"Language", "Info_GUI_Button3_2", "")

$Info_GUI_Button4 = IniRead($Sprachdatei,"Language", "Info_GUI_Button4", "")
$Info_GUI_Button5 = IniRead($Sprachdatei,"Language", "Info_GUI_Button5", "")
$Info_GUI_Button0 = IniRead($Sprachdatei,"Language", "Info_GUI_Button0", "")

$Info_Statusbar_1 = IniRead($Sprachdatei,"Language", "Info_Statusbar_1", "")
$Info_Statusbar_2 = IniRead($Sprachdatei,"Language", "Info_Statusbar_2", "")
$Info_Statusbar_3 = IniRead($Sprachdatei,"Language", "Info_Statusbar_3", "")
$Info_Statusbar_4 = IniRead($Sprachdatei,"Language", "Info_Statusbar_4", "")
$Info_Statusbar_5 = IniRead($Sprachdatei,"Language", "Info_Statusbar_5", "")
$Info_Statusbar_6 = IniRead($Sprachdatei,"Language", "Info_Statusbar_6", "")
$Info_Statusbar_7 = IniRead($Sprachdatei,"Language", "Info_Statusbar_7", "")
$Info_Statusbar_8 = IniRead($Sprachdatei,"Language", "Info_Statusbar_8", "")
$Info_Statusbar_9 = IniRead($Sprachdatei,"Language", "Info_Statusbar_9", "")

$Label_TAB_1 = IniRead($Sprachdatei,"Language", "Label_TAB_1", "")
$Label_TAB_2 = IniRead($Sprachdatei,"Language", "Label_TAB_2", "")
$Label_TAB_3 = IniRead($Sprachdatei,"Language", "Label_TAB_3", "")
$Label_TAB_4 = IniRead($Sprachdatei,"Language", "Label_TAB_4", "")
$Label_TAB_5 = IniRead($Sprachdatei,"Language", "Label_TAB_5", "")

$Info_TAB_1_Button1 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button1", "Updates / Refresh the Project Cars Server Status page")
$Info_TAB_1_Button2 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button2", "Open the Project Cars Server Status page with your standard Internet Browser")
$Info_TAB_1_Button3 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button3", "Save and open the current PCars Server Save page as .XLS Excel file with MS Excel. You need to have MS Excel installed to be able to use this.")
$Info_TAB_1_Button4 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button4", "Creates a table with current status overview and shows it in a separate window.")
$Info_TAB_1_Button5 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button5", "Starts saving of the Results and Timetable .HTM files. The location can be selected in the settings menu.")
$Info_TAB_1_Button6 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button6", "Stops Saving of the Results and Timetable .HTM files")
$Info_TAB_1_Button7 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button7", "Open created .HTM page with your standard Internet Browser")
$Info_TAB_1_Button8 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button8", "Open 'Event records - File Browser' Window.")
$Info_TAB_1_Button9_1 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button9_1", "Opens 'User History Window' with Informations to all users. On start it will update the data.")
$Info_TAB_1_Button9_2 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button9_2", "After start and with open Window use the update Button to update and save new drivers durring running session.")
$Info_TAB_1_Button10 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button10", "")
$Info_TAB_1_Button11 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button11", "")
$Info_TAB_1_Button12 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button12", "")
$Info_TAB_1_Button13 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button13", "")
$Info_TAB_1_Button14 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button14", "")
$Info_TAB_1_Button15 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button15", "")
$Info_TAB_1_Button0 = IniRead($Sprachdatei,"Language", "Info_TAB_1_Button0", "")

$Info_TAB_2_Button1 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button1", "")
$Info_TAB_2_Button2 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button2", "")
$Info_TAB_2_Button3 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button3", "")
$Info_TAB_2_Button4 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button4", "")
$Info_TAB_2_Button5 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button5", "")
$Info_TAB_2_Button6 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button6", "")
$Info_TAB_2_Button7 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button7", "")
$Info_TAB_2_Button8 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button8", "")
$Info_TAB_2_Button9 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button9", "")
$Info_TAB_2_Button10 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button10", "")
$Info_TAB_2_Button11 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button11", "")
$Info_TAB_2_Button12 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button12", "")
$Info_TAB_2_Button13 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button13", "")
$Info_TAB_2_Button14 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button14", "")
$Info_TAB_2_Button15 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button15", "")
$Info_TAB_2_Button0 = IniRead($Sprachdatei,"Language", "Info_TAB_2_Button0", "")

$Info_TAB_3_Button1 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button1", "")
$Info_TAB_3_Button2 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button2", "")
$Info_TAB_3_Button3 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button3", "")
$Info_TAB_3_Button4 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button4", "")
$Info_TAB_3_Button5 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button5", "")
$Info_TAB_3_Button6 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button6", "")
$Info_TAB_3_Button7 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button7", "")
$Info_TAB_3_Button8 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button8", "")
$Info_TAB_3_Button9 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button9", "")
$Info_TAB_3_Button10 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button10", "")
$Info_TAB_3_Button11 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button11", "")
$Info_TAB_3_Button12 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button12", "")
$Info_TAB_3_Button13 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button13", "")
$Info_TAB_3_Button14 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button14", "")
$Info_TAB_3_Button15 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button15", "")
$Info_TAB_3_Button0 = IniRead($Sprachdatei,"Language", "Info_TAB_3_Button0", "")

$Info_TAB_4_Button1 = IniRead($Sprachdatei,"Language", "Info_TAB_4_Button1", "Refresh Whitelist")
$Info_TAB_4_Button2 = IniRead($Sprachdatei,"Language", "Info_TAB_4_Button2", "Add user to the Whitelist")
$Info_TAB_4_Button9 = IniRead($Sprachdatei,"Language", "Info_TAB_4_Button9", "Remove user from the Whitelist")

$Info_TAB_5_Button1 = IniRead($Sprachdatei,"Language", "Info_TAB_5_Button1", "Refresh Blacklist")
$Info_TAB_5_Button2 = IniRead($Sprachdatei,"Language", "Info_TAB_5_Button2", "Add user to the Blacklist")
$Info_TAB_5_Button9 = IniRead($Sprachdatei,"Language", "Info_TAB_5_Button9", "Remove user from the Blacklist")

$Einstellungen = IniRead($Sprachdatei,"Language", "Einstellungen", "")

$Label_GUI_Group_1 = IniRead($Sprachdatei,"Language", "Label_GUI_Group_1", "")
$Label_GUI_Group_2 = IniRead($Sprachdatei,"Language", "Label_GUI_Group_2", "")
$Label_GUI_Group_3 = IniRead($Sprachdatei,"Language", "Label_GUI_Group_3", "")

$Group_1_Label_1 = IniRead($Sprachdatei,"Language", "Group_1_Label_1", "")
$Group_1_Label_2 = IniRead($Sprachdatei,"Language", "Group_1_Label_2", "")
$Group_1_Label_3 = IniRead($Sprachdatei,"Language", "Group_1_Label_3", "")
$Group_1_Label_4 = IniRead($Sprachdatei,"Language", "Group_1_Label_4", "")
$Group_1_Label_5 = IniRead($Sprachdatei,"Language", "Group_1_Label_5", "")
$Group_1_Label_6 = IniRead($Sprachdatei,"Language", "Group_1_Label_6", "")
$Group_1_Label_7 = IniRead($Sprachdatei,"Language", "Group_1_Label_7", "")
$Group_1_Label_8 = IniRead($Sprachdatei,"Language", "Group_1_Label_8", "")
$Group_1_Label_9 = IniRead($Sprachdatei,"Language", "Group_1_Label_9", "")
$Group_1_Label_10 = IniRead($Sprachdatei,"Language", "Group_1_Label_10", "")
$Group_1_Label_11 = IniRead($Sprachdatei,"Language", "Group_1_Label_11", "")
$Group_1_Label_12 = IniRead($Sprachdatei,"Language", "Group_1_Label_12", "")
$Group_1_Label_13 = IniRead($Sprachdatei,"Language", "Group_1_Label_13", "")
$Group_1_Label_14 = IniRead($Sprachdatei,"Language", "Group_1_Label_14", "")
$Group_1_Label_15 = IniRead($Sprachdatei,"Language", "Group_1_Label_15", "")
$Group_1_Label_16 = IniRead($Sprachdatei,"Language", "Group_1_Label_16", "")
$Group_1_Label_17 = IniRead($Sprachdatei,"Language", "Group_1_Label_17", "")
$Group_1_Label_18 = IniRead($Sprachdatei,"Language", "Group_1_Label_18", "")
$Group_1_Label_19 = IniRead($Sprachdatei,"Language", "Group_1_Label_19", "")
$Group_1_Label_20 = IniRead($Sprachdatei,"Language", "Group_1_Label_20", "")
$Group_1_Label_21 = IniRead($Sprachdatei,"Language", "Group_1_Label_21", "")
$Group_1_Label_22 = IniRead($Sprachdatei,"Language", "Group_1_Label_22", "")
$Group_1_Label_23 = IniRead($Sprachdatei,"Language", "Group_1_Label_23", "")

$Statusbar_welcome_msg_1 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_1", "")
$Statusbar_welcome_msg_2 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_2", "")
$Statusbar_welcome_msg_3 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_3", "")
$Statusbar_welcome_msg_4 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_4", "")
$Statusbar_welcome_msg_5 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_5", "")
$Statusbar_welcome_msg_6 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_6", "")
$Statusbar_welcome_msg_7 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_7", "")
$Statusbar_welcome_msg_8 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_8", "")
$Statusbar_welcome_msg_9 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_9", "")
$Statusbar_welcome_msg_10 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_10", "")
$Statusbar_welcome_msg_11 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_11", "")
$Statusbar_welcome_msg_12 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_12", "")
$Statusbar_welcome_msg_13 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_13", "")
$Statusbar_welcome_msg_14 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_14", "")
$Statusbar_welcome_msg_15 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_15", "")
$Statusbar_welcome_msg_16 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_16", "")
$Statusbar_welcome_msg_17 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_17", "")
$Statusbar_welcome_msg_18 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_18", "")

$Statusbar_welcome_msg_19 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_19", "")
$Statusbar_welcome_msg_20 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_20", "")
$Statusbar_welcome_msg_21 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_21", "")
$Statusbar_welcome_msg_22 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_22", "")
$Statusbar_welcome_msg_23 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_23", "")
$Statusbar_welcome_msg_24 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_24", "")
$Statusbar_welcome_msg_25 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_25", "")
$Statusbar_welcome_msg_26 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_26", "")
$Statusbar_welcome_msg_27 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_27", "")
$Statusbar_welcome_msg_28 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_28", "")
$Statusbar_welcome_msg_29 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_29", "")
$Statusbar_welcome_msg_30 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_30", "")
$Statusbar_welcome_msg_31 = IniRead($Sprachdatei,"Language", "Statusbar_welcome_msg_31", "")

$msgbox_1 = IniRead($Sprachdatei,"Language", "msgbox_1", "Das Installations Verzeichnis konnte nicht gefunden werden.")
$msgbox_2 = IniRead($Sprachdatei,"Language", "msgbox_2", "Wählen Sie unter folgenden Optionen:")
$msgbox_3 = IniRead($Sprachdatei,"Language", "msgbox_3", "Ja = Dedicated Server downloaden und installlieren")
$msgbox_4 = IniRead($Sprachdatei,"Language", "msgbox_4", "Nein = Verzeichnis auswählen")
$msgbox_5 = IniRead($Sprachdatei,"Language", "msgbox_5", "Das Installations Verzeichnis konnte nicht gefunden werden.")
$msgbox_6 = IniRead($Sprachdatei,"Language", "msgbox_6", "Beenden Sie zuerst den aktuell noch laufenden Project Cars GAME Server bevor Sie einen neuen Server starten.")

$msgbox_7 = IniRead($Sprachdatei,"Language", "msgbox_7", "Der GAME Server ist nicht Sichtbar, erst nachdem ein host beigetreten ist können weitere Spieler das Spiel sehen und beitreten.")
$msgbox_8 = IniRead($Sprachdatei,"Language", "msgbox_8", "Um sich als HOST einzuwählen starten Sie Project Cars mit folgenden Startparametern:")
$msgbox_9 = IniRead($Sprachdatei,"Language", "msgbox_9", "Wählen Sie anschliessend im Spiel den Menüpunkt Spiel erstellen aus. Project Cars wird den Dedicated Server automatisch finden, kurz anzeigen und verbinden.")
$msgbox_10 = IniRead($Sprachdatei,"Language", "msgbox_10", "Aktuell ohne Funktion")
$msgbox_11 = IniRead($Sprachdatei,"Language", "msgbox_11", "Starten Sie den Project Cars GAME Server.")
$msgbox_12 = IniRead($Sprachdatei,"Language", "msgbox_12", "Einstellungen wurden gespeichert")

$msgbox_13 = IniRead($Sprachdatei,"Language", "msgbox_13", "Automatisches speichern der HTML web page wird beendet.")
$msgbox_14 = IniRead($Sprachdatei,"Language", "msgbox_14", "Dies kann bis zu 15 sekunden dauern.")
$msgbox_15 = IniRead($Sprachdatei,"Language", "msgbox_15", "Automatisches speichern der HTML web page wurde beendet.")

$msgbox_16 = IniRead($Sprachdatei,"Language", "msgbox_16", "Do you realy want to add this Steam ID")
$msgbox_17 = IniRead($Sprachdatei,"Language", "msgbox_17", "to the Whietelist?")
$msgbox_18 = IniRead($Sprachdatei,"Language", "msgbox_18", "Do you realy want to add this Steam ID")
$msgbox_19 = IniRead($Sprachdatei,"Language", "msgbox_19", "to the Blacklist?")

$msgbox_20 = IniRead($Sprachdatei,"Language", "msgbox_20", "Do you realy want to remove this")
$msgbox_21 = IniRead($Sprachdatei,"Language", "msgbox_21", "user frim the Whistelist?")
$msgbox_22 = IniRead($Sprachdatei,"Language", "msgbox_22", "Do you realy want to remove this")
$msgbox_23 = IniRead($Sprachdatei,"Language", "msgbox_23", "user frim the Blacklist?")
#endregion Declare Variables/Const


#Region Check IP
Local $PCDSG_IP = @IPAddress1

If $Status_Checkbox_PCDSG_settings_8 = "true" Then
	$PCDSG_IP = @IPAddress1
	If $PCDSG_IP = "0.0.0.0" Then $PCDSG_IP = @IPAddress2
	If $PCDSG_IP = "0.0.0.0" Then $PCDSG_IP = @IPAddress3
	If $PCDSG_IP = "0.0.0.0" Then $PCDSG_IP = @IPAddress4
	If $PCDSG_Network_Card_IP <> "" Then
		If $PCDSG_Network_Card_IP = "1" Then $PCDSG_IP = @IPAddress1
		If $PCDSG_Network_Card_IP = "2" Then $PCDSG_IP = @IPAddress2
		If $PCDSG_Network_Card_IP = "3" Then $PCDSG_IP = @IPAddress3
		If $PCDSG_Network_Card_IP = "4" Then $PCDSG_IP = @IPAddress4
		If $PCDSG_Network_Card_IP = "" Then $PCDSG_IP = @IPAddress1
	EndIf
EndIf



If $Status_Checkbox_PCDSG_settings_9 = "true" Then
		$PCDSG_IP = _GetIP()
EndIf
#endregion Check IP

#region GUI Erstellen
Local $hGUI, $hGraphic, $hPen
Local $GUI, $aSize, $aStrings[5]
Local $btn, $chk, $rdo, $Msg
Local $GUI_List_Auswahl, $tu_Button0, $to_button1, $to_button2, $to_button3, $to_button4
Local $Wow64 = ""
If @AutoItX64 Then $Wow64 = "\Wow6432Node"
Local $sPath = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $Wow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\Examples\GUI\Advanced\Images"

$Check_TaskBarPos = IniRead($config_ini, "TEMP", "TaskBarPos", "")
$GUI_Y_POS = 5
$width = 643
$height = 460

If $Check_TaskBarPos = "A" Then $GUI_Y_POS = 40
If $Check_TaskBarPos = "B" Then $GUI_Y_POS = 5
If $Check_TaskBarPos = "" Then $GUI_Y_POS = 5
$GUI = GUICreate($GUI_Name, $width, $height, -1, $GUI_Y_POS, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_EX_CLIENTEDGE, $WS_EX_TOOLWINDOW))

$Anzeige_Fortschrittbalken = GUICtrlCreateProgress(0, 433, 644, 5)
$Statusbar = _GUICtrlStatusBar_Create($GUI)
$Statusbar_simple = _GUICtrlStatusBar_SetSimple($Statusbar, True)

GUISetState()

$Linie_oben = GUICtrlCreatePic($gfx & "Hintergrund.jpg", 0, 41, 650, 2, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
$Linie_unten = GUICtrlCreatePic($gfx & "Hintergrund.jpg", 0, 427, 650, 2, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))

#region GUI Toolbar Buttons oben
$GUI_Button0 = GUICtrlCreateButton($Label_GUI_Button0, 5, 3, 100, 35, $BS_DEFPUSHBUTTON)
GUICtrlSetStyle(-1, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetBkColor(-1, 0xB0C4DE)
GUICtrlSetColor(-1, 0x00008B)
GuiCtrlSetTip(-1, $Info_GUI_Button1_1 & @CRLF & @CRLF & $Info_GUI_Button1_2 & @CRLF & $Info_GUI_Button1_3 & @CRLF & @CRLF & $Info_GUI_Button1_4 & @CRLF & $Info_GUI_Button1_5)

$GUI_Button1 = GUICtrlCreateButton($Label_GUI_Button1, 110, 3, 100, 35, $BS_DEFPUSHBUTTON)
GUICtrlSetStyle(-1, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetBkColor(-1, 0xB0C4DE)
GUICtrlSetColor(-1, 0x00008B)
GuiCtrlSetTip(-1, $Info_GUI_Button1_1 & @CRLF & @CRLF & $Info_GUI_Button1_2 & @CRLF & $Info_GUI_Button1_3 & @CRLF & @CRLF & $Info_GUI_Button1_4 & @CRLF & $Info_GUI_Button1_5)

$GUI_Button2 = GUICtrlCreateButton($Label_GUI_Button2, 215, 3, 100, 35, $BS_MULTILINE)
GUICtrlSetStyle(-1, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetBkColor(-1, 0xB0C4DE)
GUICtrlSetColor(-1, 0x00008B)
GuiCtrlSetTip(-1, $Info_GUI_Button2_1  & @CRLF & @CRLF & $Info_GUI_Button2_2 & @CRLF & $Info_GUI_Button2_3& @CRLF & $Info_GUI_Button2_4)

$GUI_Button3 = GUICtrlCreateButton($Label_GUI_Button3, 320, 3, 100, 35, "", $BS_MULTILINE)
GUICtrlSetStyle(-1, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetBkColor(-1, 0xB0C4DE)
GUICtrlSetColor(-1, 0x00008B)
GuiCtrlSetTip(-1, $Info_GUI_Button3_1 & @CRLF & $Info_GUI_Button3_2)

;$GUI_Button6 = GUICtrlCreateButton("Hide Windows", 430, 3, 85, 17, $BS_BITMAP)
;GuiCtrlSetTip(-1, "Hides all current opened Windows.")

;$GUI_Button7 = GUICtrlCreateButton("Show Windows", 430, 21, 85, 17, $BS_BITMAP)
;GuiCtrlSetTip(-1, "Shows all current opened Windows.")

$GUI_Button6 = GUICtrlCreateButton("Hide Windows", 424, 3, 95, 35, 0 + $BS_DEFPUSHBUTTON)
_GUICtrlButton_SetImage($GUI_Button6, "shell32.dll", 247, False)
;GUICtrlSetStyle(-1, $GUI_SS_DEFAULT_BUTTON)
;GUICtrlSetBkColor(-1, 0xB0C4DE)
;GUICtrlSetColor(-1, 0x00008B)
;_GUICtrlButton_SetImage($GUI_Button6, $gfx & "Info.bmp")
GuiCtrlSetTip(-1, "Hides all current opened Windows.")



$GUI_Button8 = GUICtrlCreateButton($Label_GUI_Button4, 562, 3, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($GUI_Button8, $gfx & "Info.bmp")
GuiCtrlSetTip(-1, "Infos")

$GUI_Button9 = GUICtrlCreateButton($Label_GUI_Button5, 522, 3, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($GUI_Button9, "imageres.dll", 109, True)
GuiCtrlSetTip(-1, $Info_GUI_Button5)

Global $GUI_Button_Exit = GUICtrlCreateButton($Label_GUI_Button0, 602, 3, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($GUI_Button_Exit, $gfx & "Beenden.bmp")
GuiCtrlSetTip(-1, $Info_GUI_Button0)
#endregion GUI Toolbar Buttons oben


#region GUI TAB 1
$Use_Whitelist = IniRead($config_ini,"Server_Einstellungen", "Whitelist", "")
$Use_Blacklist = IniRead($config_ini,"Server_Einstellungen", "Blacklist", "")

$width_hTab = 1095
$height_hTab = 575 ;150 ;355
$posx_hTab = 2
$posy_hTab = 50
$hTab = GUICtrlCreateTab($posx_hTab, $posy_hTab, $width_hTab, $height_hTab, BitOR($TCS_BUTTONS, $TCS_FLATBUTTONS))
GUICtrlSetOnEvent($hTab, "_Tab")
GUISetState()

GUICtrlCreateTab(70, 105, 420, 380)
$TAB_1 = GUICtrlCreateTabItem($Label_TAB_1)


;$oIE = ObjCreate("Shell.Explorer.2")
;$oIE_GUI = GUICtrlCreateObj($oIE, 10000, 10000, 637, 100)

$TAB_1_Button1 = GUICtrlCreateButton("", 5, 10000, 36, 36, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_1_Button1, $gfx & "Aktualisieren_Browser.bmp") ;
GuiCtrlSetTip(-1, $Info_TAB_1_Button1)

$TAB_1_Button2 = GUICtrlCreateButton("", 55, 10000, 36, 36, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_1_Button2, $gfx & "WebInterface.bmp") ;
GuiCtrlSetTip(-1, $Info_TAB_1_Button2)

;$TAB_1_Button3 = GUICtrlCreateButton("", 95, 10000, 36, 36, $BS_BITMAP)
;_GUICtrlButton_SetImage($TAB_1_Button3, $gfx & "STAT_xls.bmp") ;
;GuiCtrlSetTip(-1, $Info_TAB_1_Button3)

$TAB_1_Button4 = GUICtrlCreateButton("", 95, 10000, 36, 36, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_1_Button4, $gfx & "STAT_table.bmp") ;
GuiCtrlSetTip(-1, $Info_TAB_1_Button4)

$TAB_1_Button5 = GUICtrlCreateButton("", 135, 387, 36, 36, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_1_Button5, $gfx & "TrackMap.bmp") ;
GuiCtrlSetTip(-1, $Info_TAB_1_Button5)

$TAB_1_Button8 = GUICtrlCreateButton("", 445, 387, 36, 36, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_1_Button8, $gfx & "Browser.bmp") ;
GuiCtrlSetTip(-1, $Info_TAB_1_Button8)

$TAB_1_Button9 = GUICtrlCreateButton("", 485, 387, 36, 36, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_1_Button9, $gfx & "UserHistory.bmp")
GuiCtrlSetTip(-1, $Info_TAB_1_Button9_1 & @CRLF & $Info_TAB_1_Button9_2)

$TAB_1_Button10 = GUICtrlCreateButton("", 525, 387, 113, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_1_Button10, $gfx & "Race_Control.bmp")
GuiCtrlSetTip(-1, $Info_TAB_1_Button10)
#endregion GUI TAB 1

#region GUI TAB 2
$TAB_2 = GUICtrlCreateTabItem($Label_TAB_2)

GUICtrlCreateGroup("", 5, 75, 634, 350)

_Werte_Server_CFG_Read()

$font_arial = "arial"


; Label name
GUICtrlCreateLabel($Group_1_Label_3, 10, 90, 140, 20) ; name
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Eingabe_name = GUICtrlCreateInput($Wert_name, 150, 88, 150, 25)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)



; Label enableHttpApi
GUICtrlCreateLabel($Group_1_Label_13, 10, 120, 140, 20) ; enableHttpApi
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Auswahl_enableHttpApi = GUICtrlCreateCombo("", 150, 117, 150, 25, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, "true" & $ListViewSeperator & "false", $Wert_enableHttpApi)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUISetState()


; Label eventsLogSize
GUICtrlCreateLabel($Group_1_Label_2, 10, 150, 140, 20) ; eventsLogSize
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Auswaehlen_eventsLogSize = GUICtrlCreateInput($Wert_eventsLogSize, 150, 145, 150, 25)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUICtrlCreateUpdown(-1)
GUISetState(@SW_SHOW)




; Label secure
GUICtrlCreateLabel($Group_1_Label_4, 10, 180, 140, 20) ; secure
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Auswahl_secure = GUICtrlCreateCombo("", 150, 175, 150, 25, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, "true" & $ListViewSeperator & "false", $Wert_secure)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUISetState()


; Label password
GUICtrlCreateLabel($Group_1_Label_5, 10, 210, 140, 20) ; password
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Eingabe_password = GUICtrlCreateInput($Wert_password, 150, 205, 150, 25)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)


; Label maxPlayerCount
GUICtrlCreateLabel($Group_1_Label_6, 10, 240, 140, 20) ; maxPlayerCount
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Auswaehlen_maxPlayerCount = GUICtrlCreateInput($Wert_maxPlayerCount, 150, 235, 150, 25)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUICtrlCreateUpdown(-1)
GUISetState(@SW_SHOW)


; Label GridSize
GUICtrlCreateLabel("GridSize", 10, 270, 140, 20) ; GridSize
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Auswaehlen_GridSize = GUICtrlCreateInput($Wert_GridSize, 150, 265, 150, 25)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUICtrlCreateUpdown(-1)


; Label steamPort
GUICtrlCreateLabel($Group_1_Label_8, 10, 300, 140, 20) ; steamPort
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Auswaehlen_steamPort = GUICtrlCreateInput($Wert_steamPort, 150, 295, 150, 25)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUICtrlCreateUpdown(-1)
GUISetState(@SW_SHOW)


; Label hostPort
GUICtrlCreateLabel($Group_1_Label_9, 10, 330, 140, 20) ; hostPort
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Auswaehlen_hostPort = GUICtrlCreateInput($Wert_hostPort, 150, 325, 150, 25)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUICtrlCreateUpdown(-1)
GUISetState(@SW_SHOW)


; Label queryPort
GUICtrlCreateLabel($Group_1_Label_10, 10, 360, 140, 20) ; queryPort
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Auswaehlen_queryPort = GUICtrlCreateInput($Wert_queryPort, 150, 355, 150, 25)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUICtrlCreateUpdown(-1)
GUISetState(@SW_SHOW)






; Label DS Domain or IP
GUICtrlCreateLabel("DS Domain or IP:", 340, 90, 140, 20) ; DS_Domain_or_IP
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Eingabe_DS_Domain_or_IP = GUICtrlCreateInput($DS_Domain_or_IP, 480, 88, 150, 25)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)

; Label httpApiInterface
GUICtrlCreateLabel($Group_1_Label_15, 340, 120, 140, 20) ; httpApiInterface
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
; Input httpApiInterface
;If $PCDSG_DS_Mode = "local" Then $Eingabe_httpApiInterface = GUICtrlCreateInput($Wert_httpApiInterface, 480, 117, 150, 25)
;If $PCDSG_DS_Mode = "remote" Then $Eingabe_httpApiInterface = GUICtrlCreateInput($DS_PublicIP, 480, 117, 150, 25)
$Eingabe_httpApiInterface = GUICtrlCreateInput($Wert_httpApiInterface, 480, 117, 150, 25)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)


; Label httpApiPort
GUICtrlCreateLabel($Group_1_Label_16, 340, 150, 140, 20) ; httpApiPort
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
;If $PCDSG_DS_Mode = "local" Then $Auswaehlen_httpApiPort = GUICtrlCreateInput($Wert_httpApiPort, 480, 148, 150, 25)
;If $PCDSG_DS_Mode = "remote" Then $Auswaehlen_httpApiPort = GUICtrlCreateInput($DS_API_Port, 480, 148, 150, 25)
$Auswaehlen_httpApiPort = GUICtrlCreateInput($Wert_httpApiPort, 480, 148, 150, 25)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUICtrlCreateUpdown(-1)
GUISetState(@SW_SHOW)


; Label enableHttpApi
GUICtrlCreateLabel($Group_1_Label_17, 340, 180, 140, 20) ; Whitelist
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Wert_Auswahl_Whitelist = IniRead($config_ini, "Server_Einstellungen", "Whitelist", "")
$Auswahl_Whitelist = GUICtrlCreateCombo("", 480, 178, 150, 25, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, "true" & $ListViewSeperator & "false", $Wert_Auswahl_Whitelist)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUISetState()


; Label enableHttpApi
GUICtrlCreateLabel($Group_1_Label_18, 340, 210, 140, 20) ; Blacklist
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Wert_Auswahl_Blacklist = IniRead($config_ini, "Server_Einstellungen", "Blacklist", "")
$Auswahl_Blacklist = GUICtrlCreateCombo("", 480, 208, 150, 25, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, "true" & $ListViewSeperator & "false", $Wert_Auswahl_Blacklist)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUISetState()


; Label allowEmptyJoin
GUICtrlCreateLabel($Group_1_Label_19, 340, 240, 140, 20)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Auswahl_allowEmptyJoin = GUICtrlCreateCombo("", 480, 238, 150, 25, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, "true" & $ListViewSeperator & "false", $Wert_allowEmptyJoin)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUISetState()


; Label controlGameSetup
GUICtrlCreateLabel($Group_1_Label_20, 340, 270, 140, 20)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
$Auswahl_controlGameSetup = GUICtrlCreateCombo("", 480, 268, 150, 25, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, "true" & $ListViewSeperator & "false", $Wert_controlGameSetup)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUISetState()

; Label ServerControlsTrack
GUICtrlCreateLabel($Group_1_Label_21, 340, 300, 140, 20)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
If $Wert_ServerControlsTrack = "1" Then $Wert_ServerControlsTrack = "true"
If $Wert_ServerControlsTrack = "0" Then $Wert_ServerControlsTrack = "false"
$Auswahl_ServerControlsTrack = GUICtrlCreateCombo("", 480, 298, 150, 25, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, "true" & $ListViewSeperator & "false", $Wert_ServerControlsTrack)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUISetState()

; Label ServerControlsVehicleClass
GUICtrlCreateLabel($Group_1_Label_22, 340, 330, 140, 20)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
If $Wert_ServerControlsVehicleClass = "1" Then $Wert_ServerControlsVehicleClass = "true"
If $Wert_ServerControlsVehicleClass = "0" Then $Wert_ServerControlsVehicleClass = "false"
$Auswahl_ServerControlsVehicleClass = GUICtrlCreateCombo("", 480, 327, 150, 25, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, "true" & $ListViewSeperator & "false", $Wert_ServerControlsVehicleClass)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUISetState()

; Label ServerControlsVehicle
GUICtrlCreateLabel($Group_1_Label_23, 340, 360, 140, 20)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
If $Wert_ServerControlsVehicle = "1" Then $Wert_ServerControlsVehicle = "true"
If $Wert_ServerControlsVehicle = "0" Then $Wert_ServerControlsVehicle = "false"
$Auswahl_ServerControlsVehicle = GUICtrlCreateCombo("", 480, 357, 150, 25, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, "true" & $ListViewSeperator & "false", $Wert_ServerControlsVehicle)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUISetState()



Global $TAB_2_Button_Race_Control = GUICtrlCreateButton("", 10, 387, 113, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_2_Button_Race_Control, $gfx & "Race_Control.bmp")
GuiCtrlSetTip(-1, $Info_TAB_1_Button10)



Global $TAB_2_Button1 = GUICtrlCreateButton("server.cfg", 128, 387, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_2_Button1, $gfx & "Server_cfg.bmp")
GuiCtrlSetTip(-1, "Open 'Server.cfg' File")

Global $TAB_2_Button4 = GUICtrlCreateButton("sms_rotate_config.json", 166, 387, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_2_Button4, $gfx & "LUA_Settings.bmp")
GuiCtrlSetTip(-1, "Open 'sms_rotate_config.json' File")


Global $TAB_2_Button5 = GUICtrlCreateButton("Restart_DS", 520, 387, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_2_Button5, $gfx & "Restart_DS.bmp")
GuiCtrlSetTip(-1, "Restart DS - Restarts Dedicated Server.")

Global $TAB_2_Button2 = GUICtrlCreateButton("FTP_Upload", 560, 387, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_2_Button2, $gfx & "FTP_Upload.bmp")
GuiCtrlSetTip(-1, "FTP Upload - Uploads the config Files depending on the settings to the defined Folder.")

Global $TAB_2_Button3 = GUICtrlCreateButton("Speichern", 600, 387, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_2_Button3, $gfx & "Speichern.bmp")
GuiCtrlSetTip(-1, $Info_TAB_2_Button3)



;GUICtrlCreateTabItem("")
#endregion GUI TAB 2

#region GUI TAB 3
$TAB_3 = GUICtrlCreateTabItem($Label_TAB_3)

;GUICtrlCreateGroup("", 3, 75, 424, 138)

$Tab3_NR_Buttons = IniRead($config_ini, "APPS", "NR", "")

$Tab3_Label_APP_1 = IniRead($config_ini, "APPS", "APP_1_name", "")
$Tab3_Label_APP_2 = IniRead($config_ini, "APPS", "APP_2_name", "")
$Tab3_Label_APP_3 = IniRead($config_ini, "APPS", "APP_3_name", "")
$Tab3_Label_APP_4 = IniRead($config_ini, "APPS", "APP_4_name", "")
$Tab3_Label_APP_5 = IniRead($config_ini, "APPS", "APP_5_name", "")

$Tab3_path_APP_1 = IniRead($config_ini, "APPS", "APP_1_path", "")
$Tab3_path_APP_2 = IniRead($config_ini, "APPS", "APP_2_path", "")
$Tab3_path_APP_3 = IniRead($config_ini, "APPS", "APP_3_path", "")
$Tab3_path_APP_4 = IniRead($config_ini, "APPS", "APP_4_path", "")
$Tab3_path_APP_5 = IniRead($config_ini, "APPS", "APP_5_path", "")

; APPS
GUICtrlCreateLabel("APPS:", 7, 90, 40, 20) ; loglevel
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)

$DropDown_NR_APPS = GUICtrlCreateCombo("", 55, 86, 40, 25, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, "1" & $ListViewSeperator & "2" & $ListViewSeperator & "3" & $ListViewSeperator & "4" & $ListViewSeperator & "5", $Tab3_NR_Buttons)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUISetState()

If $Tab3_Label_APP_1 <> "" Then
	$Tab3_Label_1 = GUICtrlCreateLabel($Tab3_Label_APP_1, 7, 120, 75, 20) ;
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Tab3_Button_1 = GUICtrlCreateButton("TAB3 Button 1", 5, 135, 76, 55, $BS_BITMAP)
	_GUICtrlButton_SetImage($Tab3_Button_1, $gfx & "APP1.bmp")
	$Tab3_Pfad_Button_1 = GUICtrlCreateButton(".....................", 5, 189, 76, 18, 0)
EndIf

If $Tab3_Label_APP_2 <> "" Then
	$Tab3_Label_2 = GUICtrlCreateLabel($Tab3_Label_APP_2, 92, 120, 75, 20) ;
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Tab3_Button_2 = GUICtrlCreateButton("TAB3 Button 2", 90, 135, 76, 55, $BS_BITMAP)
	_GUICtrlButton_SetImage($Tab3_Button_2, $gfx & "APP2.bmp")
	$Tab3_Pfad_Button_2 = GUICtrlCreateButton(".....................", 90, 189, 76, 18, 0)
EndIf

If $Tab3_Label_APP_3 <> "" Then
	$Tab3_Label_3 = GUICtrlCreateLabel($Tab3_Label_APP_3, 177, 120, 75, 20) ;
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Tab3_Button_3 = GUICtrlCreateButton("TAB3 Button 3", 175, 135, 76, 55, $BS_BITMAP)
	_GUICtrlButton_SetImage($Tab3_Button_3, $gfx & "APP3.bmp")
	$Tab3_Pfad_Button_3 = GUICtrlCreateButton(".....................", 175, 189, 76, 18, 0)
EndIf

If $Tab3_Label_APP_4 <> "" Then
	$Tab3_Label_4 = GUICtrlCreateLabel($Tab3_Label_APP_4, 262, 120, 75, 20) ;
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Tab3_Button_4 = GUICtrlCreateButton("TAB3 Button 4", 260, 135, 76, 55, $BS_BITMAP)
	_GUICtrlButton_SetImage($Tab3_Button_4, $gfx & "APP4.bmp")
	$Tab3_Pfad_Button_4 = GUICtrlCreateButton(".....................", 260, 189, 76, 18, 0)
EndIf

If $Tab3_Label_APP_5 <> "" Then
	$Tab3_Label_5 = GUICtrlCreateLabel($Tab3_Label_APP_5, 347, 120, 75 , 20) ;
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Tab3_Button_5 = GUICtrlCreateButton("TAB3 Button 5", 345, 135, 76, 55, $BS_BITMAP)
	_GUICtrlButton_SetImage($Tab3_Button_5, $gfx & "APP5.bmp")
	$Tab3_Pfad_Button_5 = GUICtrlCreateButton(".....................", 347, 189, 76, 18, 0)
EndIf
#endregion GUI TAB 3

#region GUI TAB 4
If $Use_Whitelist <> "false" Then

$TAB_4 = GUICtrlCreateTabItem($Label_TAB_4)

Local 	  $listview_whitelist = GUICtrlCreateListView("", 0, 85, 642, 295, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))

_GUICtrlListView_SetExtendedListViewStyle($listview_whitelist, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_DOUBLEBUFFER))
_GUICtrlStatusBar_SetSimple($Statusbar, True)
GUISetState()

; Add columns
_GUICtrlListView_AddColumn($listview_whitelist, "Steam ID", 200)
_GUICtrlListView_AddColumn($listview_whitelist, "Name", 120)
_GUICtrlListView_AddColumn($listview_whitelist, "Added at", 120)
_GUICtrlListView_AddColumn($listview_whitelist, "Remark / Comment", 179)


For $AW = 1 To _FileCountLines($Whitelist_File) Step 1
	$Zeile_whitelist = $AW + 1
	$Ebene_temp = $AW - 1

	$Wert_Wert = FileReadLine($Whitelist_File, $Zeile_whitelist)
	If $Wert_Wert = "]" Then $Wert_Wert = ""
	If $Wert_Wert = "[" Then $Wert_Wert = ""

	If $Wert_Wert <> "" Then

	EndIf
Next

$TAB_4_Button1 = GUICtrlCreateButton("", 5, 387, 36, 36, $BS_BITMAP) ;Status Aktualisieren
_GUICtrlButton_SetImage($TAB_4_Button1, $gfx & "Aktualisieren_Browser.bmp") ;
GuiCtrlSetTip($TAB_4_Button1, $Info_TAB_4_Button1)

$TAB_4_Button2 = GUICtrlCreateButton("", 55, 387, 36, 36, $BS_BITMAP) ;Stat Seite anzeigen
_GUICtrlButton_SetImage($TAB_4_Button2, $gfx & "ADD_2_Whitelist.bmp") ;
GuiCtrlSetTip($TAB_4_Button2, $Info_TAB_4_Button2)


$TAB_4_Button9 = GUICtrlCreateButton("Delete", 602, 387, 36, 36, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_4_Button9, $gfx & "Delete.bmp")
GuiCtrlSetTip($TAB_4_Button9, $Info_TAB_4_Button9)

$listview_blacklist = ""

EndIf
#endregion GUI TAB 4

#region GUI TAB 5
If $Use_Blacklist <> "false" Then

$TAB_5 = GUICtrlCreateTabItem($Label_TAB_5)

Local 	  $listview_blacklist = GUICtrlCreateListView("", 0, 85, 642, 295, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))

_GUICtrlListView_SetExtendedListViewStyle($listview_blacklist, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_DOUBLEBUFFER))
_GUICtrlStatusBar_SetSimple($Statusbar, True)
GUISetState()

; Add columns
_GUICtrlListView_AddColumn($listview_blacklist, "Steam ID", 200)
_GUICtrlListView_AddColumn($listview_blacklist, "Name", 120)
_GUICtrlListView_AddColumn($listview_blacklist, "Added at", 120)
_GUICtrlListView_AddColumn($listview_blacklist, "Remark / Comment", 179)


For $AW = 1 To _FileCountLines($Blacklist_File) Step 1
	$Zeile_blacklist = $AW + 1
	$Ebene_temp = $AW - 1

	$Wert_Wert = FileReadLine($Blacklist_File, $Zeile_blacklist)
	If $Wert_Wert = "]" Then $Wert_Wert = ""
	If $Wert_Wert = "[" Then $Wert_Wert = ""

	If $Wert_Wert <> "" Then

	EndIf
Next

$TAB_5_Button1 = GUICtrlCreateButton("", 5, 387, 36, 36, $BS_BITMAP) ;Status Aktualisieren
_GUICtrlButton_SetImage($TAB_5_Button1, $gfx & "Aktualisieren_Browser.bmp") ;
GuiCtrlSetTip($TAB_5_Button1, $Info_TAB_5_Button1)

$TAB_5_Button2 = GUICtrlCreateButton("", 55, 387, 36, 36, $BS_BITMAP) ;Stat Seite anzeigen
_GUICtrlButton_SetImage($TAB_5_Button2, $gfx & "ADD_2_Blacklist.bmp") ;
GuiCtrlSetTip($TAB_5_Button2, $Info_TAB_5_Button2)

$TAB_5_Button3 = GUICtrlCreateButton("", 105, 387, 36, 36, $BS_BITMAP) ;Stat Seite anzeigen
_GUICtrlButton_SetImage($TAB_5_Button3, $gfx & "Download.bmp") ;
GuiCtrlSetTip($TAB_5_Button3, "Download Blacklist with already reported / known, problematic and disturbing users.")

$TAB_5_Button4 = GUICtrlCreateButton("", 145, 387, 36, 36, $BS_BITMAP) ;Stat Seite anzeigen
_GUICtrlButton_SetImage($TAB_5_Button4, $gfx & "Report_user_2_Blacklist.bmp") ;
GuiCtrlSetTip($TAB_5_Button4, "Report user for adding to the Blacklist. Explain why user should be added and if available add an link to Forum post, pictures or videos.")

$TAB_5_Button9 = GUICtrlCreateButton("Delete", 602, 387, 36, 36, $BS_BITMAP)
_GUICtrlButton_SetImage($TAB_5_Button9, $gfx & "Delete.bmp")
GuiCtrlSetTip($TAB_5_Button9, $Info_TAB_5_Button9)

$listview_whitelist = ""

EndIf
;GUICtrlCreateTabItem("")
#endregion GUI TAB 5

_GUI_Button_Users()

Local $TAB_Restart = IniRead($config_ini, "TEMP", "TAB_Restart", "TAB_2")

If $TAB_Restart <> "" Then
	If $TAB_Restart = "TAB_1" Then GUICtrlSetState($TAB_1, $GUI_SHOW)
	If $TAB_Restart = "TAB_2" Then GUICtrlSetState($TAB_2, $GUI_SHOW)
	If $TAB_Restart = "TAB_3" Then GUICtrlSetState($TAB_3, $GUI_SHOW)
	If $TAB_Restart = "TAB_4" Then GUICtrlSetState($TAB_4, $GUI_SHOW)
	If $TAB_Restart = "TAB_5" Then GUICtrlSetState($TAB_5, $GUI_SHOW)
Else
	;GUICtrlSetState($TAB_1,$GUI_SHOW)
	GUICtrlSetState($TAB_2, $GUI_SHOW)
	;GUICtrlSetState($TAB_3,$GUI_SHOW)
EndIf

IniWrite($config_ini, "TEMP", "TAB_Restart", "")

Sleep(500)
_StartUp_Autostart_Check()
Sleep(500)
#endregion GUI Erstellen


#Region Funktionen Verküpfen
GUISetOnEvent($GUI_EVENT_CLOSE, "_Beenden")

GUICtrlSetOnEvent($GUI_Button0, "_PC_Server_starten")
GUICtrlSetOnEvent($GUI_Button1, "_PC_Server_Connect_DS")
GUICtrlSetOnEvent($GUI_Button2, "_PC_Server_web_page")
GUICtrlSetOnEvent($GUI_Button3, "_PC_Server_beenden")

GUICtrlSetOnEvent($GUI_Button6, "_Button_Hide_Windows")
;GUICtrlSetOnEvent($GUI_Button7, "_Show_Windows")
GUICtrlSetOnEvent($GUI_Button8, "_Info")
GUICtrlSetOnEvent($GUI_Button9, "_PCDSG_Programm_Einstellungen")
GUICtrlSetOnEvent($GUI_Button_Exit, "_Beenden")

GUICtrlSetOnEvent($TAB_1_Button1, "_TAB_1_Button1")
GUICtrlSetOnEvent($TAB_1_Button2, "_TAB_1_Button2")
;GUICtrlSetOnEvent($TAB_1_Button3, "_TAB_1_Button3")
GUICtrlSetOnEvent($TAB_1_Button4, "_TAB_1_Button4")
GUICtrlSetOnEvent($TAB_1_Button5, "_TAB_1_Button5")
GUICtrlSetOnEvent($TAB_1_Button8, "_TAB_1_Button8")
GUICtrlSetOnEvent($TAB_1_Button9, "_TAB_1_Button9")
GUICtrlSetOnEvent($TAB_1_Button10, "_TAB_1_Button10")

GUICtrlSetOnEvent($TAB_2_Button_Race_Control, "_TAB_1_Button10")
GUICtrlSetOnEvent($TAB_2_Button1, "_TAB_2_Button1")
GUICtrlSetOnEvent($TAB_2_Button2, "_FTP_Upload")
GUICtrlSetOnEvent($TAB_2_Button3, "_TAB_2_Button3")
GUICtrlSetOnEvent($TAB_2_Button4, "_TAB_2_Button4")
GUICtrlSetOnEvent($TAB_2_Button5, "_Restart_DS_Remote")



GUICtrlSetOnEvent($DropDown_NR_APPS, "_Tab3_APPS_NR")

GUICtrlSetOnEvent($Tab3_Pfad_Button_1, "_Tab3_Pfad_Button_1")
GUICtrlSetOnEvent($Tab3_Pfad_Button_2, "_Tab3_Pfad_Button_2")
GUICtrlSetOnEvent($Tab3_Pfad_Button_3, "_Tab3_Pfad_Button_3")
GUICtrlSetOnEvent($Tab3_Pfad_Button_4, "_Tab3_Pfad_Button_4")
GUICtrlSetOnEvent($Tab3_Pfad_Button_5, "_Tab3_Pfad_Button_5")

GUICtrlSetOnEvent($Tab3_Button_1, "_Tab3_Pfad_Button_1_Aktion")
GUICtrlSetOnEvent($Tab3_Button_2, "_Tab3_Pfad_Button_2_Aktion")
GUICtrlSetOnEvent($Tab3_Button_3, "_Tab3_Pfad_Button_3_Aktion")
GUICtrlSetOnEvent($Tab3_Button_4, "_Tab3_Pfad_Button_4_Aktion")
GUICtrlSetOnEvent($Tab3_Button_5, "_Tab3_Pfad_Button_5_Aktion")

If $Use_Whitelist <> "false" Then
	GUICtrlSetOnEvent($TAB_4_Button1, "_TAB_4_Button1")
	GUICtrlSetOnEvent($TAB_4_Button2, "_TAB_4_Button2")
	GUICtrlSetOnEvent($TAB_4_Button9, "_TAB_4_Button9")
EndIf

If $Use_Blacklist <> "false" Then
	GUICtrlSetOnEvent($TAB_5_Button1, "_TAB_5_Button1")
	GUICtrlSetOnEvent($TAB_5_Button2, "_TAB_5_Button2")
	GUICtrlSetOnEvent($TAB_5_Button3, "_TAB_5_Button3")
	GUICtrlSetOnEvent($TAB_5_Button4, "_TAB_5_Button4")
	GUICtrlSetOnEvent($TAB_5_Button9, "_TAB_5_Button9")
EndIf

GUICtrlSetOnEvent($Auswahl_Whitelist, "_Whitelist_Dowpdown")
GUICtrlSetOnEvent($Auswahl_Blacklist, "_Blacklist_Dowpdown")

#endregion Funktionen Verküpfen


GUIDelete($GUI_Loading)

_Check_for_Backups()

$PCDSG_DS_Mode = IniRead($config_ini,"PC_Server", "DS_Mode", "")
_GUICtrlStatusBar_SetText($Statusbar, "IP: " & $PCDSG_IP & @TAB & @TAB & $Statusbar_welcome_msg_2 & " " & $Aktuelle_Version & "' " & '[' & $PCDSG_DS_Mode & " Mode]")
GUISetState(@SW_SHOW)


While 1
   Sleep(100)
 WEnd


#Region Start Funktionen

Func _Server_Status_anzeigen()
	Local $oIE, $GUI_Button_Back, $GUI_Button_Forward
	Local $GUI_Button_Home, $GUI_Button_Stop, $msg

	Local $regValue = "0x2AF8"

	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION", _ProcessGetName(@AutoItPID), "REG_DWORD", $regValue)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BROWSER_EMULATION", _ProcessGetName(@AutoItPID), "REG_DWORD", $regValue)
	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION", @ScriptName, "REG_DWORD", $regValue)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BROWSER_EMULATION",@ScriptName, "REG_DWORD", $regValue)

	$oIE = ObjCreate("Shell.Explorer.2")

	$oIE_GUI = GUICtrlCreateObj($oIE, 00, 75, 637, 306)
	GUISetState()

	Local $DS_Mode_Temp = IniRead($config_ini, "PC_Server", "DS_Mode", "local")
	If $DS_Mode_Temp = "local" Then
		$Lesen_Auswahl_httpApiInterface = GUICtrlRead($Eingabe_httpApiInterface)
		$Lesen_Auswahl_httpApiPort = GUICtrlRead($Auswaehlen_httpApiPort)

		If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "localhost" ; "127.0.0.1"
		If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

		$IE_Adresse = $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort

		If $Value_httpApiUser_1_Name <> "" And $Value_httpApiUser_1_Password <> "" Then
			$oIE.navigate("http://" & $Value_httpApiUser_1_Name & ":" & $Value_httpApiUser_1_Password & "@" & $IE_Adresse)
		Else
			$oIE.navigate("http://" & $IE_Adresse)
		EndIf
	EndIf

	If $DS_Mode_Temp = "remote" Then
		$Lesen_Auswahl_httpApiInterface = GUICtrlRead($Eingabe_DS_Domain_or_IP)
		$Lesen_Auswahl_httpApiPort = GUICtrlRead($Auswaehlen_httpApiPort)

		;If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "localhost" ; "127.0.0.1"
		If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

		$IE_Adresse = $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort

		If $Value_httpApiUser_1_Name <> "" And $Value_httpApiUser_1_Password <> "" Then
			$oIE.navigate("http://" & $Value_httpApiUser_1_Name & ":" & $Value_httpApiUser_1_Password & "@" & $IE_Adresse)
		Else
			$oIE.navigate("http://" & $IE_Adresse)
		EndIf
	EndIf
EndFunc

Func _Tab()
	$Tab3_Name = GUICtrlRead($hTab)

	If $Tab3_Name = "0" Then

		$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
		If $PC_Server_Status = "PC_Server_gestartet" Then $PC_Server_Status = "Online"
		If $PC_Server_Status = "PC_Server_beendet" Then $PC_Server_Status = "Offline"

		If $PC_Server_Status = "Online" Then
			_GUICtrlStatusBar_SetText($Statusbar, "")

			$posx_hTab = 2
			$posy_hTab = 49
			$width_hTab = 1095
			$height_hTab = 460

			$pos = WinGetPos($GUI_Name)

			;GUICtrlSetPos($hTab, $posx_hTab, $posy_hTab, $width_hTab, $height_hTab)
			;GUICtrlSetPos($GUI_Button1, 5, 2)
			;GUICtrlSetPos($GUI_Button2, 140, 2)
			;GUICtrlSetPos($GUI_Button3, 275, 2)
			;GUICtrlSetPos($GUI_Button9, 562, 2)
			;GUICtrlSetPos($GUI_Button0, 602, 2)

			GUICtrlSetPos($TAB_1_Button1, 5, 387)
			GUICtrlSetPos($TAB_1_Button2, 55, 387)
			;GUICtrlSetPos($TAB_1_Button3, 95, 387)
			GUICtrlSetPos($TAB_1_Button4, 95, 387)

			GUICtrlSetPos($Linie_oben, 0, 41)
			GUICtrlSetPos($Linie_unten, 0, 427)

			_GUICtrlStatusBar_Destroy($Statusbar)

			$Statusbar = _GUICtrlStatusBar_Create($GUI)
			_GUICtrlStatusBar_SetSimple($Statusbar, False)

			_GUICtrlStatusBar_SetText($Statusbar, $Info_Statusbar_1 & @TAB & "'" & $Info_Statusbar_2 & "'" & @TAB & $Info_Statusbar_3 & " " & $Aktuelle_Version)

			_Server_Status_anzeigen()

		Else
			_GUICtrlStatusBar_SetText($Statusbar, $Info_Statusbar_1 & @TAB & "'" & $Info_Statusbar_4 & "'" & @TAB & $Info_Statusbar_5)
		EndIf

	EndIf

	If $Tab3_Name = "1" Then
		$posx_hTab = 2
		$posy_hTab = 50
		$width_hTab = 1095
		$height_hTab = 575

		GUICtrlDelete($oIE_GUI)
		;GUIDelete($oIE_GUI)

		$pos = WinGetPos($GUI_Name)
		WinMove($GUI_Name, "", $pos[0], $pos[1], $width, $height + 28)

		;GUICtrlSetPos($hTab, $posx_hTab, $posy_hTab, $width_hTab, $height_hTab)
		;GUICtrlSetPos($GUI_Button1, 5, 3)
		;GUICtrlSetPos($GUI_Button2, 140, 3)
		;GUICtrlSetPos($GUI_Button3, 275, 3)
		;GUICtrlSetPos($GUI_Button9, 562, 3)
		;GUICtrlSetPos($GUI_Button0, 602, 3)

		GUICtrlSetPos($Linie_oben, 0, 41)
		GUICtrlSetPos($Linie_unten, 0, 427)

		_GUICtrlStatusBar_Destroy($Statusbar)

		$Statusbar = _GUICtrlStatusBar_Create($GUI)
		_GUICtrlStatusBar_SetSimple($Statusbar, False)

		_GUICtrlStatusBar_SetText($Statusbar, $Info_Statusbar_6 & @TAB & @TAB & $Info_Statusbar_7)
	EndIf

	If $Tab3_Name = "2" Then
		$posx_hTab = 2
		$posy_hTab = 50
		$width_hTab = 1095
		$height_hTab = 575

	GUICtrlDelete($oIE_GUI)

		$pos = WinGetPos($GUI_Name)
		WinMove($GUI_Name, "", $pos[0], $pos[1], $width, $height + 28)

		;GUICtrlSetPos($hTab, $posx_hTab, $posy_hTab, $width_hTab, $height_hTab)
		;GUICtrlSetPos($GUI_Button1, 5, 3)
		;GUICtrlSetPos($GUI_Button2, 140, 3)
		;GUICtrlSetPos($GUI_Button3, 275, 3)
		;GUICtrlSetPos($GUI_Button9, 562, 3)
		;GUICtrlSetPos($GUI_Button0, 602, 3)

		GUICtrlSetPos($Linie_oben, 0, 41)
		GUICtrlSetPos($Linie_unten, 0, 427)

		_GUICtrlStatusBar_Destroy($Statusbar)

		$Statusbar = _GUICtrlStatusBar_Create($GUI)
		_GUICtrlStatusBar_SetSimple($Statusbar, False)

		_GUICtrlStatusBar_SetText($Statusbar, "")
	EndIf

	If $Tab3_Name = "3" Then
		GUICtrlDelete($oIE_GUI)

		$Use_Whitelist = IniRead($config_ini,"Server_Einstellungen", "Whitelist", "")
		$Use_Blacklist = IniRead($config_ini,"Server_Einstellungen", "Blacklist", "")

		If $Use_Whitelist <> "false" Then _TAB_4_Button1()
		If $Use_Blacklist <> "false" Then _TAB_5_Button1()
	EndIf

	If $Tab3_Name = "4" Then
		GUICtrlDelete($oIE_GUI)
	EndIf
EndFunc

Func _PC_Server_starten()
	_Delete_DS_StartUp_Files()
	IniWrite($config_ini, "PC_Server", "DS_Mode", "local")

	$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")

	If $PC_Server_Status = "PC_Server_gestartet" Then
		IniWrite($config_ini, "PC_Server", "Status", "PC_Server_beendet")
		IniWrite($config_ini, "TEMP", "RestartCheck", "false")
		_PC_Server_starten()
	Else

		_config_cfg_erstellen()
		;_LUA_erstellen()

		Sleep(500)

		_GUICtrlStatusBar_SetText($Statusbar, $Statusbar_welcome_msg_3)
		IniWrite($config_ini, "PC_Server", "Status", "PC_Server_gestartet")

		$Launch_StartPCarsDS_on_StartUp_Check = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_7", "")

		If $Launch_StartPCarsDS_on_StartUp_Check = "true" Then
			_Start_DS_EXE()
			_Start_PCDSG_Lapper()
		Else
			_Start_DS_EXE()

			$Abfrage = MsgBox(4, "PCDSG Event Lapper", "You need to start the File 'StartPCarsDS.exe' manually from inside 'PCDSG\system\' folder or enable the 'Launch StartPCarsDS.exe on DS Start' option in settings menu." & @CRLF & @CRLF & _
														"'...\PCDSG\system\StartPCarsDS.exe'" & @CRLF & @CRLF & _
														"Do you want to open Windows Explorer in PCDSG system folder?", 10)

			If $Abfrage = 6 Then
				ShellExecute($System_Dir)
			EndIf
		EndIf

		Sleep(5000)
		_GUICtrlStatusBar_SetText($Statusbar, $Statusbar_welcome_msg_4 & @TAB & @TAB & $Statusbar_welcome_msg_5)
		Sleep(2000)
		GUICtrlSetState($TAB_1, $GUI_SHOW)

		$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")

		If $PC_Server_Status = "PC_Server_gestartet" Then $PC_Server_Status = "Online"
		If $PC_Server_Status = "PC_Server_beendet" Then $PC_Server_Status = "Offline"

		Sleep(1000)

		GUICtrlSetState($TAB_1,$GUI_SHOW)

		_Tab()

		$Server_Name = IniRead($config_ini, "Server_Einstellungen", "name", "")
	EndIf
	$Update_TrackList_VehicleList = IniRead($config_ini, "PC_Server", "Checkbox_PCDSG_settings_10", "")

	If $Update_TrackList_VehicleList = "true" Then
		Sleep(1000)
		_get_tracks_from_DS()
		Sleep(500)
		_get_cars_from_DS()
	EndIf
	FileWriteLine($PCDSG_LOG_ini, "PCDSG_Server_started_connected_" & $NowTime & "=" & "PCDSG Server started /  connected" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
EndFunc

Func _PC_Server_Connect_DS()
	;_Delete_DS_StartUp_Files()

	;$DS_Domain_or_IP = IniRead($config_ini, "PC_Server", "DS_Domain_or_IP", "")
	$DS_Domain_or_IP = GUICtrlRead($Eingabe_DS_Domain_or_IP)

	If $DS_Domain_or_IP <> "" Then
		IniWrite($config_ini, "PC_Server", "DS_Mode", "remote")

		$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")

		If $PC_Server_Status = "PC_Server_gestartet" Then
			IniWrite($config_ini, "PC_Server", "Status", "PC_Server_beendet")
			IniWrite($config_ini, "TEMP", "RestartCheck", "false")
		EndIf

		_GUICtrlStatusBar_SetText($Statusbar, $Statusbar_welcome_msg_3)
		IniWrite($config_ini, "PC_Server", "Status", "PC_Server_gestartet")

		Sleep(2000)
		_GUICtrlStatusBar_SetText($Statusbar, $Statusbar_welcome_msg_4 & @TAB & @TAB & $Statusbar_welcome_msg_5)
		Sleep(2000)
		GUICtrlSetState($TAB_1, $GUI_SHOW)

		$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
		If $PC_Server_Status = "PC_Server_gestartet" Then $PC_Server_Status = "Online"
		If $PC_Server_Status = "PC_Server_beendet" Then $PC_Server_Status = "Offline"

		Sleep(1000)

		GUICtrlSetState($TAB_1,$GUI_SHOW)

		_Start_PCDSG_Lapper()
		Sleep(500)
		_Tab()

		$Update_TrackList_VehicleList = IniRead($config_ini, "PC_Server", "Checkbox_PCDSG_settings_10", "")
		If $Update_TrackList_VehicleList = "true" Then
			Sleep(1000)
			_get_tracks_from_DS()
			Sleep(500)
			_get_cars_from_DS()
		EndIf
		FileWriteLine($PCDSG_LOG_ini, "PCDSG_Server_started_connected_" & $NowTime & "=" & "PCDSG Server started /  connected" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
	Else
		FileWriteLine($PCDSG_LOG_ini, "PCDSG_Server_started_connected_" & $NowTime & "=" & "$DS_Domain_or_IP is empty, Enter $DS_Domain_or_IP first." & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
		MsgBox($MB_OK + $MB_ICONWARNING,"DS Domain or Public IP empty", "DS Domain or Public IP is empty." & @CRLF & "Enter Domain name or Public IP first.")

		$Eingabe_PublicIP = InputBox ( "Public IP", "Enter domain name or public IP.")
		If $Eingabe_PublicIP <> "" Then
			IniWrite($config_ini, "PC_Server", "DS_Domain_or_IP", $Eingabe_PublicIP)
			IniWrite($config_ini,"PC_Server", "DS_PublicIP", $Eingabe_PublicIP)
			MsgBox($MB_OK + $MB_ICONINFORMATION,"Domain name or Public IP saved", "Domain name or Public IP was saved." & @CRLF & "You can now Connect to the DS Server.")
		Else
			IniWrite($config_ini, "PC_Server", "DS_Domain_or_IP", "")
			IniWrite($config_ini,"PC_Server", "DS_PublicIP", "")
			MsgBox($MB_OK + $MB_ICONWARNING,"Domain name or Public IP empty", "Domain name or Public IP was NOT saved." & @CRLF & "You cannot Connect to the DS Server without Domain name or Public IP.")
		EndIf
	EndIf
EndFunc

; www.annonymous-chiller.de
Func _PC_Server_web_page()
	ShellExecute($Web_Page)
EndFunc

Func _PC_Server_beenden()
	$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")

	If $PC_Server_Status = "PC_Server_beendet" Then
		MsgBox(0,"", $msgbox_11, 5)
	Else

	IniWrite($config_ini, "PC_Server", "Status", "PC_Server_beendet")
	IniWrite($config_ini, "PC_Server", "Server_State", "")
	IniWrite($config_ini, "PC_Server", "Session_Stage", "")

	Sleep(2000)

	_GUICtrlStatusBar_SetText($Statusbar, $Statusbar_welcome_msg_8 & @TAB & @TAB & $Statusbar_welcome_msg_9)

	GUICtrlSetState($TAB_2,$GUI_SHOW)

	FileDelete($System_Dir & "KICK_LIST.txt")
	FileWrite($System_Dir & "KICK_LIST.txt", "")

	EndIf

	FileWriteLine($PCDSG_LOG_ini, "PCDSG_Server_closed_" & $NowTime & "=" & "PCDSG Server will closed in few seconds" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
	_Tab()
	$PCDSG_DS_Mode = IniRead($config_ini,"PC_Server", "DS_Mode", "")
	_GUICtrlStatusBar_SetText($Statusbar, "IP: " & $PCDSG_IP & @TAB & @TAB & $Statusbar_welcome_msg_2 & " " & $Aktuelle_Version & "' " & '[' & $PCDSG_DS_Mode & " Mode]")
	GUISetState(@SW_SHOW)
EndFunc

Func _PCDSG_Programm_Einstellungen()
	_GUICtrlStatusBar_SetText($Statusbar, $Einstellungen)

	If FileExists($Programm_Verzeichnis & "Settings.exe") Then
		ShellExecuteWait($Programm_Verzeichnis & "Settings.exe")
	Else
		ShellExecuteWait($Programm_Verzeichnis & "Settings.au3")
	EndIf

	Sleep(100)
	_GUICtrlStatusBar_SetText($Statusbar, "")
EndFunc


Func _get_tracks_from_DS()
	$TrackList_txt = $System_Dir & "TrackList.txt"
	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/list/tracks"
	$download = InetGet($URL, $TrackList_txt, 16, 0)
	FileWriteLine($PCDSG_LOG_ini, "TrackList_dowloaded_" & $NowTime & "=" & "New Track List downloaded and saved to: " &  $TrackList_txt & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
EndFunc

Func _get_cars_from_DS()
	$VehicleList_txt = $System_Dir & "VehicleList.txt"
	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/list/vehicles"
	$download = InetGet($URL, $VehicleList_txt, 16, 0)
	FileWriteLine($PCDSG_LOG_ini, "VehicleList_dowloaded_" & $NowTime & "=" & "New VehicleList List downloaded and saved to: " &  $VehicleList_txt & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
EndFunc


Func _TAB_1_Button1()
	$Server_Status = IniRead($config_ini,"PC_Server", "Status", "")

	If $Server_Status = "PC_Server_gestartet" Then
		GUICtrlDelete($oIE_GUI)
		_Server_Status_anzeigen()
	 EndIf
EndFunc

Func _TAB_1_Button2()
	If FileExists($System_Dir & "WebInterface.exe") Then
		ShellExecute($System_Dir & "WebInterface.exe")
	Else
		ShellExecute($System_Dir & "WebInterface.au3")
	EndIf
EndFunc

Func _TAB_1_Button3()

EndFunc

Func _TAB_1_Button4()
	If FileExists($System_Dir & "PCarsDSOverview.exe") Then
		ShellExecute($System_Dir & "PCarsDSOverview.exe")
	Else
		ShellExecute($System_Dir & "PCarsDSOverview.au3")
	EndIf

	sleep(100)
EndFunc


Func _TAB_1_Button5()
	If FileExists($System_Dir & "TrackMap.exe") Then
		ShellExecute($System_Dir & "TrackMap.exe")
	Else
		ShellExecute($System_Dir & "TrackMap.au3")
	EndIf
	sleep(100)
EndFunc

Func _TAB_1_Button8()
	If FileExists($System_Dir & "Browser.exe") Then
		ShellExecute($System_Dir & "Browser.exe")
	Else
		ShellExecute($System_Dir & "Browser.au3")
	EndIf
	sleep(100)
EndFunc

Func _TAB_1_Button9()
	If FileExists($System_Dir & "UserHistory.exe") Then
		ShellExecute($System_Dir & "UserHistory.exe")
	Else
		ShellExecute($System_Dir & "UserHistory.au3")
	EndIf
EndFunc

Func _TAB_1_Button10()
	If FileExists($System_Dir & "RaceControl.exe") Then
		ShellExecute($System_Dir & "RaceControl.exe")
	Else
		ShellExecute($System_Dir & "RaceControl.au3")
	EndIf
EndFunc


Func _TAB_2_Button1()
	If FileExists($Dedi_Installations_Verzeichnis & "server.cfg") Then
		ShellExecute($Dedi_Installations_Verzeichnis & "server.cfg")
	EndIf
EndFunc

Func _TAB_2_Button2()
	MsgBox(0, "", $msgbox_10)
EndFunc

Func _TAB_2_Button3()
	$NR_Lines_config_cfg = _FileCountLines($Dedi_config_cfg) - 1

	;Global $Lesen_Auswahl_loglevel = GUICtrlRead($Auswahl_Sprachdatei)
	Global $Lesen_Auswahl_eventsLogSize = GUICtrlRead($Auswaehlen_eventsLogSize)
	Global $Lesen_Auswahl_name = GUICtrlRead($Eingabe_name)
	Global $Lesen_Auswahl_secure = GUICtrlRead($Auswahl_secure)
	Global $Lesen_Auswahl_password = GUICtrlRead($Eingabe_password)
	Global $Lesen_Auswahl_maxPlayerCount = GUICtrlRead($Auswaehlen_maxPlayerCount)
	Global $Lesen_Auswahl_GridSize = GUICtrlRead($Auswaehlen_GridSize)
	Global $Lesen_Auswahl_steamPort = GUICtrlRead($Auswaehlen_steamPort)
	Global $Lesen_Auswahl_hostPort = GUICtrlRead($Auswaehlen_hostPort)
	Global $Lesen_Auswahl_queryPort = GUICtrlRead($Auswaehlen_queryPort)
	Global $Lesen_Auswahl_enableHttpApi = GUICtrlRead($Auswahl_enableHttpApi)
	;Global $Lesen_Auswahl_httpApiLogLevel = GUICtrlRead($Auswahl_httpApiLogLevel)
	Global $Lesen_Auswahl_httpApiInterface = GUICtrlRead($Eingabe_httpApiInterface)
	Global $Lesen_Auswahl_httpApiPort = GUICtrlRead($Auswaehlen_httpApiPort)
	Global $Lesen_Auswahl_whitelist = GUICtrlRead($Auswahl_Whitelist)
	Global $Lesen_Auswahl_blacklist = GUICtrlRead($Auswahl_Blacklist)

	Global $Lesen_Auswahl_allowEmptyJoin = GUICtrlRead($Auswahl_allowEmptyJoin)
	Global $Lesen_Auswahl_controlGameSetup = GUICtrlRead($Auswahl_controlGameSetup)

	Global $Lesen_Auswahl_ServerControlsTrack = GUICtrlRead($Auswahl_ServerControlsTrack)
		If $Lesen_Auswahl_ServerControlsTrack = "true" Then $Lesen_Auswahl_ServerControlsTrack = "1"
		If $Lesen_Auswahl_ServerControlsTrack = "false" Then $Lesen_Auswahl_ServerControlsTrack = "0"
	Global $Lesen_Auswahl_ServerControlsVehicleClass = GUICtrlRead($Auswahl_ServerControlsVehicleClass)
		If $Lesen_Auswahl_ServerControlsVehicleClass = "true" Then $Lesen_Auswahl_ServerControlsVehicleClass = "1"
		If $Lesen_Auswahl_ServerControlsVehicleClass = "false" Then $Lesen_Auswahl_ServerControlsVehicleClass = "0"

	IniWrite($config_ini, "Server_Einstellungen", "loglevel", $Lesen_Auswahl_loglevel)
	IniWrite($config_ini, "Server_Einstellungen", "eventsLogSize", $Lesen_Auswahl_eventsLogSize)
	IniWrite($config_ini, "Server_Einstellungen", "name", $Lesen_Auswahl_name)
	IniWrite($config_ini, "Server_Einstellungen", "secure", $Lesen_Auswahl_secure)
	IniWrite($config_ini, "Server_Einstellungen", "password", $Lesen_Auswahl_password)
	IniWrite($config_ini, "Server_Einstellungen", "maxPlayerCount", $Lesen_Auswahl_maxPlayerCount)
	IniWrite($config_ini, "Server_Einstellungen", "bindIP", $Lesen_Auswahl_bindIP)
	IniWrite($config_ini, "Server_Einstellungen", "steamPort", $Lesen_Auswahl_steamPort)
	IniWrite($config_ini, "Server_Einstellungen", "hostPort", $Lesen_Auswahl_hostPort)
	IniWrite($config_ini, "Server_Einstellungen", "queryPort", $Lesen_Auswahl_queryPort)
	IniWrite($config_ini, "Server_Einstellungen", "sleepWaiting", $Lesen_Auswahl_sleepWaiting)
	IniWrite($config_ini, "Server_Einstellungen", "sleepActive", $Lesen_Auswahl_sleepActive)
	IniWrite($config_ini, "Server_Einstellungen", "enableHttpApi", $Lesen_Auswahl_enableHttpApi)
	IniWrite($config_ini, "Server_Einstellungen", "httpApiLogLevel", $Lesen_Auswahl_httpApiLogLevel)
	IniWrite($config_ini, "Server_Einstellungen", "httpApiInterface", $Lesen_Auswahl_httpApiInterface)
	IniWrite($config_ini, "Server_Einstellungen", "httpApiPort", $Lesen_Auswahl_httpApiPort)
	IniWrite($config_ini, "Server_Einstellungen", "whitelist", $Lesen_Auswahl_whitelist)
	IniWrite($config_ini, "Server_Einstellungen", "blacklist", $Lesen_Auswahl_blacklist)

	IniWrite($config_ini, "Server_Einstellungen", "allowEmptyJoin", $Lesen_Auswahl_allowEmptyJoin)
	IniWrite($config_ini, "Server_Einstellungen", "controlGameSetup", $Lesen_Auswahl_controlGameSetup)
	IniWrite($config_ini, "Server_Einstellungen", "ServerControlsTrack", $Lesen_Auswahl_ServerControlsTrack)
	IniWrite($config_ini, "Server_Einstellungen", "ServerControlsVehicleClass", $Lesen_Auswahl_ServerControlsVehicleClass)


	_config_cfg_erstellen()


	MsgBox(0,"", $msgbox_12, 3)

	If FileExists($install_dir & "PCDSG.exe") Then
		ShellExecute($install_dir & "PCDSG.exe")
	Else
		ShellExecute($install_dir & "PCDSG.au3")
	EndIf

	_Beenden()
EndFunc

Func _TAB_2_Button4()
	If FileExists($sms_rotate_config_json_File) Then
		Run("notepad.exe " & $sms_rotate_config_json_File, "")
	EndIf
EndFunc

Func _GUI_Button_Users()
	$TAB_6 = GUICtrlCreateTabItem("DS API User settings")

	;_Werte_Server_CFG_Read()

	GUICtrlCreateLabel("PCDSG User Name:", 10, 92, 155, 20)
	GUICtrlSetFont(-1, 12, 400, 1, $font_arial)
	$InputPCDSG_USERName = GUICtrlCreateInput("Default", 165, 89, 140, 25)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)

	$Status_Checkbox_Activate_HTTPUsers = IniRead($config_ini, "Server_Einstellungen", "Activate_HTTPUsers", "")
	$Checkbox_Activate_HTTPUsers = GUICtrlCreateCheckbox("Activate HTTPUsers", 10, 125, 165, 20)
		GUICtrlSetFont(-1, 12, 400, 1, $font_arial)
		If $Status_Checkbox_Activate_HTTPUsers = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	GUICtrlCreateGroup("httpApiAccess - Level, Status and Filters", 5, 160, 305, 120)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 11, 400, 6, $font_arial)

	; Label httpApiAccessLevel
	$Checkbox_Activate_httpApiAccessLevel = GUICtrlCreateCheckbox("httpApiAccessLevel", 10, 195, 140, 20)
	If $Check_httpApiAccessLevels_1 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Combo_httpApiAccessLevel = GUICtrlCreateCombo("", 160, 190, 140, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, "public" & $ListViewSeperator & "private" & $ListViewSeperator, $Value_httpApiAccessLevels)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	GUISetState()

	; Label status
	$Value_Combo_status = IniRead($config_ini, "Server_Einstellungen", "httpApistatus", "")
	$Checkbox_Activate_status = GUICtrlCreateCheckbox("status", 10, 222, 140, 20)
	If $Check_Status_1 <> "false" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Combo_status = GUICtrlCreateCombo($Value_Combo_status, 160, 217, 140, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, "public" & $ListViewSeperator & "private" & $ListViewSeperator, $Value_httpApi_status)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	GUISetState(@SW_SHOW)

	; Label Public rules
	GUICtrlCreateLabel("Public rules", 28, 249, 140, 20)
	If $Check_Public_rules_1 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Combo_Public_rules = GUICtrlCreateCombo("", 160, 244, 140, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, "accept" & $ListViewSeperator & "reject" & $ListViewSeperator & "reject-password" & $ListViewSeperator & "ip-accept" & $ListViewSeperator & "ip-reject" & $ListViewSeperator & "user" & $ListViewSeperator & "group", $Value_httpApiAccessFilters)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)


	GUICtrlCreateGroup("httpApiUsers", 335, 75, 303, 205)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 11, 400, 6, $font_arial)

	GUICtrlCreateLabel("Name", 410, 95, 155, 15)
	GUICtrlSetFont(-1, 11, 400, 2, $font_arial)
	GUICtrlCreateLabel(":", 497, 90, 5, 20)
	GUICtrlSetFont(-1, 16, 400, 1, $font_arial)
	GUICtrlCreateLabel("Password", 545, 95, 155, 15)
	GUICtrlSetFont(-1, 11, 400, 2, $font_arial)

	; Label User 1
	$Checkbox_User_1 = GUICtrlCreateCheckbox("1", 340, 118, 30, 20)
	If $Check_Checkbox_User_1 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Input_Name_1= GUICtrlCreateInput($Value_httpApiUser_1_Name, 370, 115, 120, 25)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	GUICtrlCreateLabel(":", 497, 113, 5, 20)
	GUICtrlSetFont(-1, 16, 400, 1, $font_arial)
	$Input_password_Name_1 = GUICtrlCreateInput($Value_httpApiUser_1_Password, 510, 115, 120, 25)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)

	$Checkbox_User_2 = GUICtrlCreateCheckbox("2", 340, 148, 30, 20)
	If $Check_Checkbox_User_2 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Input_Name_2= GUICtrlCreateInput($Value_httpApiUser_2_Name, 370, 145, 120, 25)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	GUICtrlCreateLabel(":", 497, 143, 5, 20)
	GUICtrlSetFont(-1, 16, 400, 1, $font_arial)
	$Input_password_Name_2 = GUICtrlCreateInput($Value_httpApiUser_2_Password, 510, 145, 120, 25)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)

	$Checkbox_User_3 = GUICtrlCreateCheckbox("3", 340, 178, 30, 20)
	If $Check_Checkbox_User_3 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Input_Name_3= GUICtrlCreateInput($Value_httpApiUser_3_Name, 370, 175, 120, 25)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	GUICtrlCreateLabel(":", 497, 173, 5, 20)
	GUICtrlSetFont(-1, 16, 400, 1, $font_arial)
	$Input_password_Name_3 = GUICtrlCreateInput($Value_httpApiUser_3_Password, 510, 175, 120, 25)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)

	$Checkbox_User_4 = GUICtrlCreateCheckbox("4", 340, 208, 30, 20)
	If $Check_Checkbox_User_4 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	; Input password User 1
	$Input_Name_4= GUICtrlCreateInput($Value_httpApiUser_4_Name, 370, 205, 120, 25)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	GUICtrlCreateLabel(":", 497, 203, 5, 20)
	GUICtrlSetFont(-1, 16, 400, 1, $font_arial)
	$Input_password_Name_4 = GUICtrlCreateInput($Value_httpApiUser_4_Password, 510, 205, 120, 25)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)

	$Checkbox_User_5 = GUICtrlCreateCheckbox("5", 340, 238, 30, 20)
	If $Check_Checkbox_User_5 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Input_Name_5= GUICtrlCreateInput($Value_httpApiUser_5_Name, 370, 235, 120, 25)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	GUICtrlCreateLabel(":", 497, 233, 5, 20)
	GUICtrlSetFont(-1, 16, 400, 1, $font_arial)
	$Input_password_Name_5 = GUICtrlCreateInput($Value_httpApiUser_5_Password, 510, 235, 120, 25)
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)

	GUICtrlCreateGroup("httpApiGroups", 5, 285, 633, 85)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 11, 400, 6, $font_arial)

	; Label
	GUICtrlCreateLabel("Private:", 10, 312, 50, 20) ; bindIP
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Combo_Group_Private_1 = GUICtrlCreateCombo("", 70, 310, 105, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, $Value_httpApiUser_1_Name & $ListViewSeperator & $Value_httpApiUser_2_Name & $ListViewSeperator & $Value_httpApiUser_3_Name & $ListViewSeperator & $Value_httpApiUser_4_Name & $ListViewSeperator & $Value_httpApiUser_5_Name & $ListViewSeperator & "" & $ListViewSeperator, $Value_httpApi_GroupUser_Name_1)
	$Combo_Group_Private_2 = GUICtrlCreateCombo("", 184, 310, 105, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, $Value_httpApiUser_1_Name & $ListViewSeperator & $Value_httpApiUser_2_Name & $ListViewSeperator & $Value_httpApiUser_3_Name & $ListViewSeperator & $Value_httpApiUser_4_Name & $ListViewSeperator & $Value_httpApiUser_5_Name & $ListViewSeperator & "" & $ListViewSeperator, $Value_httpApi_GroupUser_Name_2)
	$Combo_Group_Private_3 = GUICtrlCreateCombo("", 298, 310, 105, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, $Value_httpApiUser_1_Name & $ListViewSeperator & $Value_httpApiUser_2_Name & $ListViewSeperator & $Value_httpApiUser_3_Name & $ListViewSeperator & $Value_httpApiUser_4_Name & $ListViewSeperator & $Value_httpApiUser_5_Name & $ListViewSeperator & "" & $ListViewSeperator, $Value_httpApi_GroupUser_Name_3)
	$Combo_Group_Private_4 = GUICtrlCreateCombo("", 412, 310, 105, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, $Value_httpApiUser_1_Name & $ListViewSeperator & $Value_httpApiUser_2_Name & $ListViewSeperator & $Value_httpApiUser_3_Name & $ListViewSeperator & $Value_httpApiUser_4_Name & $ListViewSeperator & $Value_httpApiUser_5_Name & $ListViewSeperator & "" & $ListViewSeperator, $Value_httpApi_GroupUser_Name_4)
	$Combo_Group_Private_5 = GUICtrlCreateCombo("", 526, 310, 105, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, $Value_httpApiUser_1_Name & $ListViewSeperator & $Value_httpApiUser_2_Name & $ListViewSeperator & $Value_httpApiUser_3_Name & $ListViewSeperator & $Value_httpApiUser_4_Name & $ListViewSeperator & $Value_httpApiUser_5_Name & $ListViewSeperator & "" & $ListViewSeperator, $Value_httpApi_GroupUser_Name_5)

	; Label
	GUICtrlCreateLabel("Admin:", 10, 338, 50, 20) ; steamPort
	GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
	$Combo_Group_Admin_1 = GUICtrlCreateCombo("", 70, 335, 105, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, $Value_httpApiUser_1_Name & $ListViewSeperator & $Value_httpApiUser_2_Name & $ListViewSeperator & $Value_httpApiUser_3_Name & $ListViewSeperator & $Value_httpApiUser_4_Name & $ListViewSeperator & $Value_httpApiUser_5_Name & $ListViewSeperator & "" & $ListViewSeperator, $Value_httpApi_GroupAdminUser_Name_1)
	$Combo_Group_Admin_2 = GUICtrlCreateCombo("", 184, 335, 105, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, $Value_httpApiUser_1_Name & $ListViewSeperator & $Value_httpApiUser_2_Name & $ListViewSeperator & $Value_httpApiUser_3_Name & $ListViewSeperator & $Value_httpApiUser_4_Name & $ListViewSeperator & $Value_httpApiUser_5_Name & $ListViewSeperator & "" & $ListViewSeperator, $Value_httpApi_GroupAdminUser_Name_2)
	$Combo_Group_Admin_3 = GUICtrlCreateCombo("", 298, 335, 105, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, $Value_httpApiUser_1_Name & $ListViewSeperator & $Value_httpApiUser_2_Name & $ListViewSeperator & $Value_httpApiUser_3_Name & $ListViewSeperator & $Value_httpApiUser_4_Name & $ListViewSeperator & $Value_httpApiUser_5_Name & $ListViewSeperator & "" & $ListViewSeperator, $Value_httpApi_GroupAdminUser_Name_3)
	$Combo_Group_Admin_4 = GUICtrlCreateCombo("", 412, 335, 105, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, $Value_httpApiUser_1_Name & $ListViewSeperator & $Value_httpApiUser_2_Name & $ListViewSeperator & $Value_httpApiUser_3_Name & $ListViewSeperator & $Value_httpApiUser_4_Name & $ListViewSeperator & $Value_httpApiUser_5_Name & $ListViewSeperator & "" & $ListViewSeperator, $Value_httpApi_GroupAdminUser_Name_4)
	$Combo_Group_Admin_5 = GUICtrlCreateCombo("", 526, 335, 105, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, $Value_httpApiUser_1_Name & $ListViewSeperator & $Value_httpApiUser_2_Name & $ListViewSeperator & $Value_httpApiUser_3_Name & $ListViewSeperator & $Value_httpApiUser_4_Name & $ListViewSeperator & $Value_httpApiUser_5_Name & $ListViewSeperator & "" & $ListViewSeperator, $Value_httpApi_GroupAdminUser_Name_5)
	GUISetState(@SW_SHOW)

	Global $TAB_6_Button1 = GUICtrlCreateButton("server.cfg", 10, 386, 35, 35, $BS_BITMAP)
	_GUICtrlButton_SetImage($TAB_6_Button1, $gfx & "Server_cfg.bmp")
	GuiCtrlSetTip($TAB_6_Button1, "Open Server.cfg File")
	GUICtrlSetOnEvent($TAB_6_Button1, "_TAB_6_Button1")

	;Global $TAB_6_Button2 = GUICtrlCreateButton("Test 1", 50, 386, 65, 35, $BS_BITMAP)
	;GUICtrlSetOnEvent($TAB_6_Button2, "_TAB_6_Button2")

	;Global $TAB_6_Button3 = GUICtrlCreateButton("Test 2", 120, 386, 65, 35, $BS_BITMAP)
	;GUICtrlSetOnEvent($TAB_6_Button3, "_TAB_6_Button3")

	Global $TAB_6_Button4 = GUICtrlCreateButton("Speichern", 600, 386, 35, 35, $BS_BITMAP)
	_GUICtrlButton_SetImage($TAB_6_Button4, $gfx & "Speichern.bmp")
	GuiCtrlSetTip(-1, "Save User HTTP API settings")
	GUICtrlSetOnEvent($TAB_6_Button4, "_TAB_6_Button4")

	GUICtrlCreateTabItem("")
EndFunc

Func _Tab3_APPS_NR()
	$Lesen_NR_APPS = GUICtrlRead($DropDown_NR_APPS)

	If $Lesen_NR_APPS <> "" Then
		IniWrite($config_ini, "APPS", "NR", $Lesen_NR_APPS)

		If $Lesen_NR_APPS = 1 Then
			IniWrite($config_ini, "APPS", "APP_2_name", "")
			IniWrite($config_ini, "APPS", "APP_2_path", "")
			IniWrite($config_ini, "APPS", "APP_3_name", "")
			IniWrite($config_ini, "APPS", "APP_3_path", "")
			IniWrite($config_ini, "APPS", "APP_4_name", "")
			IniWrite($config_ini, "APPS", "APP_4_path", "")
			IniWrite($config_ini, "APPS", "APP_5_name", "")
			IniWrite($config_ini, "APPS", "APP_5_path", "")

			IniWrite($config_ini, "APPS", "APP_1_name", "APP 1")
		EndIf

		If $Lesen_NR_APPS = 2 Then
			IniWrite($config_ini, "APPS", "APP_3_name", "")
			IniWrite($config_ini, "APPS", "APP_3_path", "")
			IniWrite($config_ini, "APPS", "APP_4_name", "")
			IniWrite($config_ini, "APPS", "APP_4_path", "")
			IniWrite($config_ini, "APPS", "APP_5_name", "")
			IniWrite($config_ini, "APPS", "APP_5_path", "")

			If IniRead($config_ini, "APPS", "APP_1_name", "") = "" Then IniWrite($config_ini, "APPS", "APP_1_name", "APP 1")
			If IniRead($config_ini, "APPS", "APP_2_name", "") = "" Then IniWrite($config_ini, "APPS", "APP_2_name", "APP 2")
		EndIf

		If $Lesen_NR_APPS = 3 Then
			IniWrite($config_ini, "APPS", "APP_4_name", "")
			IniWrite($config_ini, "APPS", "APP_4_path", "")
			IniWrite($config_ini, "APPS", "APP_5_name", "")
			IniWrite($config_ini, "APPS", "APP_5_path", "")

			If IniRead($config_ini, "APPS", "APP_1_name", "") = "" Then IniWrite($config_ini, "APPS", "APP_1_name", "APP 1")
			If IniRead($config_ini, "APPS", "APP_2_name", "") = "" Then IniWrite($config_ini, "APPS", "APP_2_name", "APP 2")
			If IniRead($config_ini, "APPS", "APP_3_name", "") = "" Then IniWrite($config_ini, "APPS", "APP_3_name", "APP 3")
		EndIf

		If $Lesen_NR_APPS = 4 Then
			IniWrite($config_ini, "APPS", "APP_5_name", "")
			IniWrite($config_ini, "APPS", "APP_5_path", "")

			If IniRead($config_ini, "APPS", "APP_1_name", "") = "" Then IniWrite($config_ini, "APPS", "APP_1_name", "APP 1")
			If IniRead($config_ini, "APPS", "APP_2_name", "") = "" Then IniWrite($config_ini, "APPS", "APP_2_name", "APP 2")
			If IniRead($config_ini, "APPS", "APP_3_name", "") = "" Then IniWrite($config_ini, "APPS", "APP_3_name", "APP 3")
			If IniRead($config_ini, "APPS", "APP_4_name", "") = "" Then IniWrite($config_ini, "APPS", "APP_4_name", "APP 4")
		EndIf

		If $Lesen_NR_APPS = 5 Then
			If IniRead($config_ini, "APPS", "APP_1_name", "") = "" Then IniWrite($config_ini, "APPS", "APP_1_name", "APP 1")
			If IniRead($config_ini, "APPS", "APP_2_name", "") = "" Then IniWrite($config_ini, "APPS", "APP_2_name", "APP 2")
			If IniRead($config_ini, "APPS", "APP_3_name", "") = "" Then IniWrite($config_ini, "APPS", "APP_3_name", "APP 3")
			If IniRead($config_ini, "APPS", "APP_4_name", "") = "" Then IniWrite($config_ini, "APPS", "APP_4_name", "APP 4")
			IniWrite($config_ini, "APPS", "APP_5_name", "APP 5")
		EndIf

		$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
		If $PC_Server_Status <> "PC_Server_gestartet" Then
			IniWrite($config_ini, "TEMP", "TAB_Restart", "TAB_3")
			MsgBox($MB_OK + $MB_ICONINFORMATION, "Settings saved", "Settings will be taken over after a restart.")
			_Restart_PCDSG()
		Else
			MsgBox($MB_OK + $MB_ICONINFORMATION, "Settings saved", "Settings will be taken over after a restart.")
		EndIf
	EndIf
EndFunc

Func _Tab3_Pfad_Button_1()
	$Auswahl_file = FileOpenDialog("Choose File", @ScriptDir & "\", "All Files (*)", $FD_FILEMUSTEXIST + $FD_MULTISELECT)

	If $Auswahl_file <> "" Then
		IniWrite($config_ini, "APPS", "APP_1_path", $Auswahl_file)
		$Auswahl_file_name = InputBox ( "Enter APP Name", "Enter the Name of the APP.")
		IniWrite($config_ini, "APPS", "APP_1_name", $Auswahl_file_name)
		GUICtrlSetData($Tab3_Label_1, $Auswahl_file_name)
	EndIf
EndFunc

Func _Tab3_Pfad_Button_2()
	$Auswahl_file = FileOpenDialog("Choose File", @ScriptDir & "\", "All Files (*)", $FD_FILEMUSTEXIST + $FD_MULTISELECT)

	If $Auswahl_file <> "" Then
		IniWrite($config_ini, "APPS", "APP_2_path", $Auswahl_file)
		$Auswahl_file_name = InputBox ( "Enter APP Name", "Enter the Name of the APP.")
		IniWrite($config_ini, "APPS", "APP_2_name", $Auswahl_file_name)
		GUICtrlSetData($Tab3_Label_2, $Auswahl_file_name)
	EndIf
EndFunc

Func _Tab3_Pfad_Button_3()
	$Auswahl_file = FileOpenDialog("Choose File", @ScriptDir & "\", "All Files (*)", $FD_FILEMUSTEXIST + $FD_MULTISELECT)

	If $Auswahl_file <> "" Then
		IniWrite($config_ini, "APPS", "APP_3_path", $Auswahl_file)
		$Auswahl_file_name = InputBox ( "Enter APP Name", "Enter the Name of the APP.")
		IniWrite($config_ini, "APPS", "APP_3_name", $Auswahl_file_name)
		GUICtrlSetData($Tab3_Label_3, $Auswahl_file_name)
	EndIf
EndFunc

Func _Tab3_Pfad_Button_4()
	$Auswahl_file = FileOpenDialog("Choose File", @ScriptDir & "\", "All Files (*)", $FD_FILEMUSTEXIST + $FD_MULTISELECT)

	If $Auswahl_file <> "" Then
		IniWrite($config_ini, "APPS", "APP_4_path", $Auswahl_file)
		$Auswahl_file_name = InputBox ( "Enter APP Name", "Enter the Name of the APP.")
		IniWrite($config_ini, "APPS", "APP_4_name", $Auswahl_file_name)
		GUICtrlSetData($Tab3_Label_4, $Auswahl_file_name)
	EndIf
EndFunc

Func _Tab3_Pfad_Button_5()
	$Auswahl_file = FileOpenDialog("Choose File", @ScriptDir & "\", "All Files (*)", $FD_FILEMUSTEXIST + $FD_MULTISELECT)

	If $Auswahl_file <> "" Then
		IniWrite($config_ini, "APPS", "APP_5_path", $Auswahl_file)
		$Auswahl_file_name = InputBox ( "Enter APP Name", "Enter the Name of the APP.")
		IniWrite($config_ini, "APPS", "APP_5_name", $Auswahl_file_name)
		GUICtrlSetData($Tab3_Label_5, $Auswahl_file_name)
	EndIf
EndFunc


Func _Tab3_Pfad_Button_1_Aktion()
	$APP_path = IniRead($config_ini, "APPS", "APP_1_path", "")

	If $APP_path <> "" Then
		If FileExists($APP_path) Then
			ShellExecute($APP_path)
		Else
			MsgBox(0, "Path Error", "File path does not exist.")
		EndIf
	EndIf
EndFunc

Func _Tab3_Pfad_Button_2_Aktion()
	$APP_path = IniRead($config_ini, "APPS", "APP_2_path", "")

	If $APP_path <> "" Then
		If FileExists($APP_path) Then
			ShellExecute($APP_path)
		Else
			MsgBox(0, "Path Error", "File path does not exist.")
		EndIf
	EndIf
EndFunc

Func _Tab3_Pfad_Button_3_Aktion()
	$APP_path = IniRead($config_ini, "APPS", "APP_3_path", "")

	If $APP_path <> "" Then
		If FileExists($APP_path) Then
			ShellExecute($APP_path)
		Else
			MsgBox(0, "Path Error", "File path does not exist.")
		EndIf
	EndIf
EndFunc

Func _Tab3_Pfad_Button_4_Aktion()
	$APP_path = IniRead($config_ini, "APPS", "APP_4_path", "")

	If $APP_path <> "" Then
		If FileExists($APP_path) Then
			ShellExecute($APP_path)
		Else
			MsgBox(0, "Path Error", "File path does not exist.")
		EndIf
	EndIf
EndFunc

Func _Tab3_Pfad_Button_5_Aktion()
	$APP_path = IniRead($config_ini, "APPS", "APP_5_path", "")

	If $APP_path <> "" Then
		If FileExists($APP_path) Then
			ShellExecute($APP_path)
		Else
			MsgBox(0, "Path Error", "File path does not exist.")
		EndIf
	EndIf
EndFunc


Func _TAB_4_Button1()
	$Anzahl_Zeilen = _FileCountLines ( $Whitelist_File )
	$Anzahl_Zeilen_Werte =  $Anzahl_Zeilen
	$Anzahl_Werte = $Anzahl_Zeilen_Werte + 1

	If FileExists($Whitelist_File) Then
		_GUICtrlListView_DeleteAllItems($listview_whitelist)
		For $Schleife_ListView_aktualisieren = 2 To $Anzahl_Werte - 1
			$Wert_LA_1 = FileReadLine($Whitelist_File, $Schleife_ListView_aktualisieren)
			If $Wert_LA_1 = "{" Then $Wert_LA_1 = ""
			If $Wert_LA_1 = "}" Then $Wert_LA_1 = ""

			$Wert_Wert = $Wert_LA_1

			If $Wert_Wert <> "" Then
				$Wert_Wert = StringReplace($Wert_Wert, '"', '')
				$Wert_Wert = StringReplace($Wert_Wert, "<", "")
				$Wert_Spalte_Array = StringSplit($Wert_Wert, ">")
				$Wert_Wert = StringReplace($Wert_Spalte_Array[4], '"', '')

				$Wert_Spalte_1 = $Wert_Spalte_Array[4]
					$Wert_Spalte_1 = StringTrimLeft($Wert_Spalte_1, 1)
				$Wert_Spalte_2 = $Wert_Spalte_Array[1]
				$Wert_Spalte_3 = $Wert_Spalte_Array[3]
				$Wert_Spalte_4 = $Wert_Spalte_Array[2]

				GUICtrlCreateListViewItem($Wert_Spalte_1 & $ListViewSeperator & $Wert_Spalte_2 & $ListViewSeperator & $Wert_Spalte_3 & $ListViewSeperator & $Wert_Spalte_4, $listview_whitelist)
			EndIf
		Next
	EndIf
EndFunc

Func _TAB_4_Button2()
	$Input_Date = _NowDate() & " - " & _NowTime()

	$Input_whitelist_1 = InputBox("Whitelist", "Enter Steam ID.", "Steam ID is needed")
	$Input_whitelist_2 = InputBox("Whitelist", "Enter Name.", "")
	$Input_whitelist_3 = $Input_Date
	$Input_whitelist_4 = InputBox("Whitelist", "Remarks and comments.", "")

	$NEW_MSG_Input_whitelist = "Driver Name: " & @TAB & $Input_whitelist_1 & @CRLF & "Driver SteamID: " & @TAB & $Input_whitelist_2 & @CRLF & "Added at: " & @TAB & @TAB & $Input_whitelist_3 & @CRLF & "Comments: " & @TAB & $Input_whitelist_4 & @CRLF

	$Abfrage = MsgBox(4, "Dedicated Server", $msgbox_16 & @CRLF & @CRLF & $NEW_MSG_Input_whitelist & @CRLF & @CRLF & $msgbox_17 & @CRLF)

	If $Abfrage = 6 Then
		$Wert_letzte_Zeile = _FileCountLines($Whitelist_File)

		Global $asRead, $iUbound

		_FileReadToArray($Whitelist_File, $asRead)

		For $AW = 1 To _FileCountLines($Whitelist_File) - 1
			$Text_letzte_Zeile = $asRead[$AW]
			If $Text_letzte_Zeile = "}" Then $Text_letzte_Zeile = ""
			If $Text_letzte_Zeile <> "" Then FileWriteLine(@ScriptDir & "\Whitelist_2.cfg", $Text_letzte_Zeile)
		Next

		$NEW_Input_whitelist = '"<' & $Input_whitelist_2 & '> <' & $Input_whitelist_4 & '> <' & $Input_whitelist_3 & '>" ' & $Input_whitelist_1

		FileWriteLine(@ScriptDir & "\Whitelist_2.cfg", $NEW_Input_whitelist)
		FileWriteLine(@ScriptDir & "\Whitelist_2.cfg", "}")
		FileDelete($Whitelist_File)
		FileCopy(@ScriptDir & "\Whitelist_2.cfg", $Whitelist_File)
		FileDelete(@ScriptDir & "\Whitelist_2.cfg")
	EndIf

	_TAB_4_Button1()
EndFunc

Func _TAB_4_Button9()
	$Auswahl_ListView = _GUICtrlListView_GetSelectedIndices($listview_whitelist)
	$Auswahl_ListView = $Auswahl_ListView
	$Auswahl_ListView_steamID = _GUICtrlListView_GetItemText($listview_whitelist, $Auswahl_ListView + 0)
	$Auswahl_ListView_Driver_steamID = _GUICtrlListView_GetItemText($listview_whitelist, $Auswahl_ListView + 0)
	$Auswahl_ListView_Driver_Name = _GUICtrlListView_GetItemText ( $listview_whitelist, $Auswahl_ListView + 0 , 1)
	$Auswahl_ListView_Driver_add_date_time = _GUICtrlListView_GetItemText ( $listview_whitelist, $Auswahl_ListView + 0 , 2)
	$Auswahl_ListView_Driver_remarks = _GUICtrlListView_GetItemText ( $listview_whitelist, $Auswahl_ListView + 0 , 3)

	$Auswahl_ListView_steamID = $Auswahl_ListView_steamID & ' : "' & $Auswahl_ListView_Driver_Name & '" : "' & $Auswahl_ListView_Driver_add_date_time & '" : "' & $Auswahl_ListView_Driver_remarks & '"'

	$NEW_MSG_Input_whitelist = "Driver Name: " & @TAB & $Auswahl_ListView_Driver_Name & @CRLF & "Driver SteamID: " & @TAB & $Auswahl_ListView_Driver_steamID & @CRLF & "Added at: " & @TAB & @TAB & $Auswahl_ListView_Driver_add_date_time & @CRLF & "Comments: " & @TAB & $Auswahl_ListView_Driver_remarks & @CRLF

	$Abfrage = MsgBox(4, "Dedicated Server", $msgbox_20 & @CRLF & @CRLF & $NEW_MSG_Input_whitelist & @CRLF & @CRLF & $msgbox_21 & @CRLF)

	If $Abfrage = 6 Then
		$Wert_letzte_Zeile = _FileCountLines($Whitelist_File)

		Global $asRead, $iUbound

		_FileReadToArray($Whitelist_File, $asRead)

		For $AW = 1 To _FileCountLines($Whitelist_File) - 1
			$Text_letzte_Zeile = $asRead[$AW - 1]
			If $AW = 1 Then FileWriteLine(@ScriptDir & "\whitelist_2.cfg", "[")

			If $AW > 1 Then
			$Check_Steam_ID = FileReadLine($Whitelist_File, $AW)
			If $Text_letzte_Zeile = "]" Then $Text_letzte_Zeile = ""
			If $Text_letzte_Zeile = "[" Then $Text_letzte_Zeile = ""

			If $Check_Steam_ID <> $Auswahl_ListView_steamID Then FileWriteLine(@ScriptDir & "\whitelist_2.cfg", $Check_Steam_ID)

			EndIf
		Next

		FileWriteLine(@ScriptDir & "\whitelist_2.cfg", "}")
		FileDelete($Whitelist_File)
		FileCopy(@ScriptDir & "\whitelist_2.cfg", $Whitelist_File)
		FileDelete(@ScriptDir & "\whitelist_2.cfg")
	EndIf

	_TAB_4_Button1()
EndFunc


Func _TAB_5_Button1()
	$Anzahl_Zeilen = _FileCountLines ( $Blacklist_File )
	$Anzahl_Zeilen_Werte =  $Anzahl_Zeilen
	$Anzahl_Werte = $Anzahl_Zeilen_Werte + 1

	If FileExists($Blacklist_File) Then

		_GUICtrlListView_DeleteAllItems($listview_blacklist)
		For $Schleife_ListView_aktualisieren = 2 To $Anzahl_Werte - 1
			$Wert_LA_1 = FileReadLine($Blacklist_File, $Schleife_ListView_aktualisieren)
			If $Wert_LA_1 = "{" Then $Wert_LA_1 = ""
			If $Wert_LA_1 = "}" Then $Wert_LA_1 = ""

			$Wert_Wert = $Wert_LA_1

			If $Wert_Wert <> "" Then
				$Wert_Wert = StringReplace($Wert_Wert, '"', '')
				$Wert_Wert = StringReplace($Wert_Wert, "<", "")
				$Wert_Spalte_Array = StringSplit($Wert_Wert, ">")
				$Wert_Wert = StringReplace($Wert_Spalte_Array[4], '"', '')

				$Wert_Spalte_1 = $Wert_Spalte_Array[4]
					$Wert_Spalte_1 = StringTrimLeft($Wert_Spalte_1, 1)
				$Wert_Spalte_2 = $Wert_Spalte_Array[1]
				$Wert_Spalte_3 = $Wert_Spalte_Array[3]
				$Wert_Spalte_4 = $Wert_Spalte_Array[2]

				GUICtrlCreateListViewItem($Wert_Spalte_1 & $ListViewSeperator & $Wert_Spalte_2 & $ListViewSeperator & $Wert_Spalte_3 & $ListViewSeperator & $Wert_Spalte_4, $listview_blacklist)
			EndIf
		Next
	EndIf
EndFunc

Func _TAB_5_Button2()
	$Input_Date = _NowDate() & " - " & _NowTime()

	$Input_blacklist_1 = InputBox("Blacklist", "Enter Steam ID.", "Steam ID is needed")
	$Input_blacklist_2 = InputBox("Blacklist", "Enter Name.", "")
	$Input_blacklist_3 = $Input_Date
	$Input_blacklist_4 = InputBox("Blacklist", "Remarks and comments.", "")

	$NEW_MSG_Input_blacklist = "Driver Name: " & @TAB & $Input_blacklist_1 & @CRLF & "Driver SteamID: " & @TAB & $Input_blacklist_2 & @CRLF & "Added at: " & @TAB & @TAB & $Input_blacklist_3 & @CRLF & "Comments: " & @TAB & $Input_blacklist_4 & @CRLF

	$Abfrage = MsgBox(4, "Dedicated Server", $msgbox_18 & @CRLF & @CRLF & $NEW_MSG_Input_blacklist & @CRLF & @CRLF & $msgbox_19 & @CRLF)

	If $Abfrage = 6 Then
		$Wert_letzte_Zeile = _FileCountLines($Blacklist_File)

		Global $asRead, $iUbound

		_FileReadToArray($Blacklist_File, $asRead)

		For $AW = 1 To _FileCountLines($Blacklist_File) - 1
			$Text_letzte_Zeile = $asRead[$AW]
			If $Text_letzte_Zeile = "}" Then $Text_letzte_Zeile = ""
			If $Text_letzte_Zeile <> "" Then FileWriteLine(@ScriptDir & "\Blacklist_2.cfg", $Text_letzte_Zeile)
		Next

		$NEW_Input_blacklist = '"<' & $Input_blacklist_2 & '> <' & $Input_blacklist_4 & '> <' & $Input_blacklist_3 & '>" ' & $Input_blacklist_1

		FileWriteLine(@ScriptDir & "\Blacklist_2.cfg", $NEW_Input_blacklist)
		FileWriteLine(@ScriptDir & "\Blacklist_2.cfg", "}")
		FileDelete($Blacklist_File)
		FileCopy(@ScriptDir & "\Blacklist_2.cfg", $Blacklist_File)
		FileDelete(@ScriptDir & "\Blacklist_2.cfg")
	EndIf

	_TAB_5_Button1()
EndFunc

Func _TAB_5_Button3()
	Local $Download_URL = "http://www.cogent.myds.me/PCDSG/Downloads/blacklist.cfg"
	Local $Download_FilePath = $System_Dir & "temp\blacklist.cfg"
	If FileExists($Download_FilePath) Then FileDelete($Download_FilePath)
	$Abfrage = MsgBox($MB_OK + $MB_ICONQUESTION, "Blacklist.cfg Download", "Do you realy want to Donwload 'Blacklist.cfg' File?" & @CRLF & @CRLF & "File already contains known problematic users" & @CRLF & @CRLF & "Note that this will exclude users from your DS without that you have own experiences or confirmation with or for them." & @CRLF)

	If $Abfrage = 6 Then
		If FileExists($install_dir & "blacklist.cfg") Then FileCopy($install_dir & "blacklist.cfg", $install_dir & "blacklist.bak")
		$download = InetGet($Download_URL, $System_Dir & "temp\blacklist.cfg", 1, 1)

		For $Loop = 1 To 5
			If Not FileExists($Download_FilePath) Then Sleep(500)
		Next

		If FileExists($Download_FilePath) Then
			MsgBox($MB_OK + $MB_ICONINFORMATION, "Download Successfully", "Blacklist.cfg File successfully downloaded." & @CRLF & "OLD Blacklist.cfd File was saved as Backup 'Blacklist.bak'")
		Else
			MsgBox($MB_OK + $MB_ICONWARNING, "Download Failed", "Blacklist.cfg File downloaded failed.")
		EndIf
	EndIf
	_Tab()
EndFunc

Func _TAB_5_Button4()
	ShellExecute("mailto:PCDSG@web.de?subject=PCDSG_Blacklist.cfg")
EndFunc

Func _TAB_5_Button9()
	$Auswahl_ListView = _GUICtrlListView_GetSelectedIndices($listview_blacklist)
	$Auswahl_ListView = $Auswahl_ListView
	$Auswahl_ListView_steamID = _GUICtrlListView_GetItemText($listview_blacklist, $Auswahl_ListView + 0)
	$Auswahl_ListView_Driver_steamID = _GUICtrlListView_GetItemText($listview_blacklist, $Auswahl_ListView + 0)
	$Auswahl_ListView_Driver_Name = _GUICtrlListView_GetItemText ( $listview_blacklist, $Auswahl_ListView + 0 , 1)
	$Auswahl_ListView_Driver_add_date_time = _GUICtrlListView_GetItemText ( $listview_blacklist, $Auswahl_ListView + 0 , 2)
	$Auswahl_ListView_Driver_remarks = _GUICtrlListView_GetItemText ( $listview_blacklist, $Auswahl_ListView + 0 , 3)

	$Auswahl_ListView_steamID = $Auswahl_ListView_steamID & ' | "' & $Auswahl_ListView_Driver_Name & '" | "' & $Auswahl_ListView_Driver_add_date_time & '" | "' & $Auswahl_ListView_Driver_remarks & '"'

	$NEW_MSG_Input_blacklist = "Driver Name: " & @TAB & $Auswahl_ListView_Driver_Name & @CRLF & "Driver SteamID: " & @TAB & $Auswahl_ListView_Driver_steamID & @CRLF & "Added at: " & @TAB & @TAB & $Auswahl_ListView_Driver_add_date_time & @CRLF & "Comments: " & @TAB & $Auswahl_ListView_Driver_remarks & @CRLF

	$Abfrage = MsgBox(4, "Dedicated Server", $msgbox_22 & @CRLF & @CRLF & $NEW_MSG_Input_blacklist & @CRLF & @CRLF & $msgbox_23 & @CRLF)

	If $Abfrage = 6 Then
		$Wert_letzte_Zeile = _FileCountLines($Blacklist_File)

		Global $asRead, $iUbound

		_FileReadToArray($Blacklist_File, $asRead)

		For $AW = 1 To _FileCountLines($Blacklist_File) - 1
			$Text_letzte_Zeile = $asRead[$AW - 1]
			If $AW = 1 Then FileWriteLine(@ScriptDir & "\blacklist_2.cfg", "[")

			If $AW > 1 Then
			$Check_Steam_ID = FileReadLine($Blacklist_File, $AW)
			If $Text_letzte_Zeile = "]" Then $Text_letzte_Zeile = ""
			If $Text_letzte_Zeile = "[" Then $Text_letzte_Zeile = ""

			If $Check_Steam_ID <> $Auswahl_ListView_steamID Then FileWriteLine(@ScriptDir & "\blacklist_2.cfg", $Check_Steam_ID)

			EndIf
		Next

		FileWriteLine(@ScriptDir & "\blacklist_2.cfg", "}")
		FileDelete($Blacklist_File)
		FileCopy(@ScriptDir & "\blacklist_2.cfg", $Blacklist_File)
		FileDelete(@ScriptDir & "\blacklist_2.cfg")
	EndIf

	_TAB_5_Button1()
EndFunc


Func _TAB_6_Button1()
	If FileExists($Dedi_Installations_Verzeichnis & "server.cfg") Then
		ShellExecute($Dedi_Installations_Verzeichnis & "server.cfg")
	EndIf
EndFunc

Func _TAB_6_Button2()
	Global $Read_Input_Name_1 = GUICtrlRead($Input_Name_1)
	Global $Read_Input_password_Name_1 = GUICtrlRead($Input_password_Name_1)

	;$Encrypt_Name_1 = _Base64Encode($Read_Input_Name_1)
	;$Decrypt_Name_1 = _Base64Decode($Encrypt_Name_1)
	;$BinaryToString_Name_1 = BinaryToString($Decrypt_Name_1)

	;$Encrypt_password_Name_1 = _Base64Encode($Read_Input_password_Name_1)
	;$Decrypt_password_Name_1 = _Base64Decode($Encrypt_password_Name_1)
	;$BinaryToString_password_Name_1 = BinaryToString($Decrypt_password_Name_1)

	;MsgBox(0, "Test 1", "User: " & $Read_Input_Name_1 & @CRLF & "Password: " & $Read_Input_password_Name_1 & @CRLF & @CRLF & _
							;"User Encrypt: " & $Encrypt_Name_1 & @CRLF & "Password Encrypt: " & $Encrypt_password_Name_1 & @CRLF & @CRLF & _
							;"User Decrypt: " & $Decrypt_Name_1 & @CRLF & "Password Decrypt: " & $Decrypt_password_Name_1)


	;IniWrite(@ScriptDir & "\" & "base64.ini", "Base64", "Encode User", $Encrypt_Name_1)
	;IniWrite(@ScriptDir & "\" & "base64.ini", "Base64", "Decode User", $Decrypt_Name_1)
	;IniWrite(@ScriptDir & "\" & "base64.ini", "Base64", "BinaryToString User", $BinaryToString_Name_1)
	;IniWrite(@ScriptDir & "\" & "base64.ini", "Base64", "Encode Password", $Encrypt_password_Name_1)
	;IniWrite(@ScriptDir & "\" & "base64.ini", "Base64", "Decode Password", $Decrypt_password_Name_1)
	;IniWrite(@ScriptDir & "\" & "base64.ini", "Base64", "BinaryToString Password", $BinaryToString_password_Name_1)
EndFunc

Func _TAB_6_Button3()

EndFunc

Func _TAB_6_Button4()
	Global $FirstLine_Check
	Global $Write_FirstLine = "false"

	If FileExists($Dedi_config_cfg) Then
		$Server_CFG_Array = FileReadToArray($Dedi_config_cfg)
		Global $NR_Lines_config_cfg = _FileCountLines($Dedi_config_cfg) - 1
		$FirstLine_Check = FileReadLine($Dedi_config_cfg, 1)
		If $FirstLine_Check = "eventsLogSize : 10000" Then $Write_FirstLine = "true"
	EndIf

	$NR_Lines_config_cfg = _FileCountLines($Dedi_config_cfg) - 1

	Global $Read_InputPCDSG_USERName = GUICtrlRead($InputPCDSG_USERName)
	Global $Read_Checkbox_Activate_HTTPUsers = GUICtrlRead($Checkbox_Activate_HTTPUsers)
		If $Read_Checkbox_Activate_HTTPUsers = "1" Then $Read_Checkbox_Activate_HTTPUsers = "true"
		If $Read_Checkbox_Activate_HTTPUsers = "4" Then $Read_Checkbox_Activate_HTTPUsers = "false"
	Global $Read_Activate_httpApiAccessLevel = GUICtrlRead($Checkbox_Activate_httpApiAccessLevel)
		If $Read_Activate_httpApiAccessLevel = "1" Then $Read_Activate_httpApiAccessLevel = "true"
		If $Read_Activate_httpApiAccessLevel = "4" Then $Read_Activate_httpApiAccessLevel = "false"
	Global $Read_Combo_httpApiAccessLevel = GUICtrlRead($Combo_httpApiAccessLevel)
	Global $Read_Checkbox_Activate_status = GUICtrlRead($Checkbox_Activate_status)
		If $Read_Checkbox_Activate_status = "1" Then $Read_Checkbox_Activate_status = "true"
		If $Read_Checkbox_Activate_status = "4" Then $Read_Checkbox_Activate_status = "false"
	Global $Read_Combo_status = GUICtrlRead($Combo_status)
	Global $Read_Combo_Public_rules = GUICtrlRead($Combo_Public_rules)

	Global $Read_Checkbox_User_1 = GUICtrlRead($Checkbox_User_1)
		If $Read_Checkbox_User_1 = "1" Then $Read_Checkbox_User_1 = "true"
		If $Read_Checkbox_User_1 = "4" Then $Read_Checkbox_User_1 = "false"
	Global $Read_Checkbox_User_2 = GUICtrlRead($Checkbox_User_2)
		If $Read_Checkbox_User_2 = "1" Then $Read_Checkbox_User_2 = "true"
		If $Read_Checkbox_User_2 = "4" Then $Read_Checkbox_User_2 = "false"
	Global $Read_Checkbox_User_3 = GUICtrlRead($Checkbox_User_3)
		If $Read_Checkbox_User_3 = "1" Then $Read_Checkbox_User_3 = "true"
		If $Read_Checkbox_User_3 = "4" Then $Read_Checkbox_User_3 = "false"
	Global $Read_Checkbox_User_4 = GUICtrlRead($Checkbox_User_4)
		If $Read_Checkbox_User_4 = "1" Then $Read_Checkbox_User_4 = "true"
		If $Read_Checkbox_User_4 = "4" Then $Read_Checkbox_User_4 = "false"
	Global $Read_Checkbox_User_5 = GUICtrlRead($Checkbox_User_5)
		If $Read_Checkbox_User_5 = "1" Then $Read_Checkbox_User_5 = "true"
		If $Read_Checkbox_User_5 = "4" Then $Read_Checkbox_User_5 = "false"

	Global $Read_Input_Name_1 = GUICtrlRead($Input_Name_1)
	Global $Read_Input_Name_2 = GUICtrlRead($Input_Name_2)
	Global $Read_Input_Name_3 = GUICtrlRead($Input_Name_3)
	Global $Read_Input_Name_4 = GUICtrlRead($Input_Name_4)
	Global $Read_Input_Name_5 = GUICtrlRead($Input_Name_5)

	Global $Read_Input_password_Name_1 = GUICtrlRead($Input_password_Name_1)
	Global $Read_Input_password_Name_2 = GUICtrlRead($Input_password_Name_2)
	Global $Read_Input_password_Name_3 = GUICtrlRead($Input_password_Name_3)
	Global $Read_Input_password_Name_4 = GUICtrlRead($Input_password_Name_4)
	Global $Read_Input_password_Name_5 = GUICtrlRead($Input_password_Name_5)

	Global $Read_Combo_Group_Private_1 = GUICtrlRead($Combo_Group_Private_1)
	Global $Read_Combo_Group_Private_2 = GUICtrlRead($Combo_Group_Private_2)
	Global $Read_Combo_Group_Private_3 = GUICtrlRead($Combo_Group_Private_3)
	Global $Read_Combo_Group_Private_4 = GUICtrlRead($Combo_Group_Private_4)
	Global $Read_Combo_Group_Private_5 = GUICtrlRead($Combo_Group_Private_5)

	Global $Read_Combo_Group_Admin_1 = GUICtrlRead($Combo_Group_Admin_1)
	Global $Read_Combo_Group_Admin_2 = GUICtrlRead($Combo_Group_Admin_2)
	Global $Read_Combo_Group_Admin_3 = GUICtrlRead($Combo_Group_Admin_3)
	Global $Read_Combo_Group_Admin_4 = GUICtrlRead($Combo_Group_Admin_4)
	Global $Read_Combo_Group_Admin_5 = GUICtrlRead($Combo_Group_Admin_5)

	IniWrite($config_ini, "Server_Einstellungen", "PCDSG_UserName", $Read_InputPCDSG_USERName)
	IniWrite($config_ini, "Server_Einstellungen", "Activate_HTTPUsers", $Read_Checkbox_Activate_HTTPUsers)
	IniWrite($config_ini, "Server_Einstellungen", "Activate_httpApiAccessLevel", $Read_Activate_httpApiAccessLevel)
	IniWrite($config_ini, "Server_Einstellungen", "httpApiAccessLevel", $Read_Combo_httpApiAccessLevel)
	IniWrite($config_ini, "Server_Einstellungen", "Activate_status", $Read_Checkbox_Activate_status)
	IniWrite($config_ini, "Server_Einstellungen", "status", $Read_Combo_status)
	IniWrite($config_ini, "Server_Einstellungen", "Public_rules", $Read_Combo_Public_rules)

	IniWrite($config_ini, "Server_Einstellungen", "Activate_User_1", $Read_Checkbox_User_1)
	IniWrite($config_ini, "Server_Einstellungen", "Activate_User_2", $Read_Checkbox_User_2)
	IniWrite($config_ini, "Server_Einstellungen", "Activate_User_3", $Read_Checkbox_User_3)
	IniWrite($config_ini, "Server_Einstellungen", "Activate_User_4", $Read_Checkbox_User_4)
	IniWrite($config_ini, "Server_Einstellungen", "Activate_User_5", $Read_Checkbox_User_5)
	IniWrite($config_ini, "Server_Einstellungen", "Name_User_1", $Read_Input_Name_1)
	IniWrite($config_ini, "Server_Einstellungen", "Name_User_2", $Read_Input_Name_2)
	IniWrite($config_ini, "Server_Einstellungen", "Name_User_3", $Read_Input_Name_3)
	IniWrite($config_ini, "Server_Einstellungen", "Name_User_4", $Read_Input_Name_4)
	IniWrite($config_ini, "Server_Einstellungen", "Name_User_5", $Read_Input_Name_5)
	IniWrite($config_ini, "Server_Einstellungen", "password_User_1", $Read_Input_password_Name_1)
	IniWrite($config_ini, "Server_Einstellungen", "password_User_2", $Read_Input_password_Name_2)
	IniWrite($config_ini, "Server_Einstellungen", "password_User_3", $Read_Input_password_Name_3)
	IniWrite($config_ini, "Server_Einstellungen", "password_User_4", $Read_Input_password_Name_4)
	IniWrite($config_ini, "Server_Einstellungen", "password_User_5", $Read_Input_password_Name_5)

	IniWrite($config_ini, "Server_Einstellungen", "Group_Private_1", $Read_Combo_Group_Private_1)
	IniWrite($config_ini, "Server_Einstellungen", "Group_Private_2", $Read_Combo_Group_Private_2)
	IniWrite($config_ini, "Server_Einstellungen", "Group_Private_3", $Read_Combo_Group_Private_3)
	IniWrite($config_ini, "Server_Einstellungen", "Group_Private_4", $Read_Combo_Group_Private_4)
	IniWrite($config_ini, "Server_Einstellungen", "Group_Private_5", $Read_Combo_Group_Private_5)

	IniWrite($config_ini, "Server_Einstellungen", "Group_Admin_1", $Read_Combo_Group_Admin_1)
	IniWrite($config_ini, "Server_Einstellungen", "Group_Admin_2", $Read_Combo_Group_Admin_2)
	IniWrite($config_ini, "Server_Einstellungen", "Group_Admin_3", $Read_Combo_Group_Admin_3)
	IniWrite($config_ini, "Server_Einstellungen", "Group_Admin_4", $Read_Combo_Group_Admin_4)
	IniWrite($config_ini, "Server_Einstellungen", "Group_Admin_5", $Read_Combo_Group_Admin_5)

	$Dedi_config_cfg_test_new = $Dedi_config_cfg

	If FileExists($Dedi_config_cfg_test_new) Then
		$EmptyFile = FileOpen($Dedi_config_cfg_test_new, 2)
		FileWrite($EmptyFile, "")
		FileClose($EmptyFile)
	EndIf


	If $Write_FirstLine = "true" Then
		FileWriteLine($Dedi_config_cfg_test_new, "// : You can use dummy entries like this to write comments into the config. " & '"rem"' & ' and ' & '"#"' & " are also supported as comment entries.")
		FileWriteLine($Dedi_config_cfg_test_new, "// But in recent version of the server, standard C++ like one-liner comments are supported as well.")
		FileWriteLine($Dedi_config_cfg_test_new, " ")
		FileWriteLine($Dedi_config_cfg_test_new, "//////////////////////////")
		FileWriteLine($Dedi_config_cfg_test_new, "// Basic server options //")
		FileWriteLine($Dedi_config_cfg_test_new, "//////////////////////////")
		FileWriteLine($Dedi_config_cfg_test_new, " ")
		FileWriteLine($Dedi_config_cfg_test_new, "// Logging level of the server. Messages of this severity and more important will be logged. Can be any of debug/info/warning/error.")
		FileWriteLine($Dedi_config_cfg_test_new, 'logLevel : "info"')
		FileWriteLine($Dedi_config_cfg_test_new, " ")
		FileWriteLine($Dedi_config_cfg_test_new, "// Number of gameplay events stored on the server. Oldest ones will be discarded once the game logs more.")
	EndIf

	For $Schleife_2 = 0 To $NR_Lines_config_cfg
		$Wert_Line = $Server_CFG_Array[$Schleife_2]
		$Check_Line = StringSplit($Wert_Line, ':', $Server_CFG_Array[$Schleife_2])
		If IsArray($Check_Line) Then $Check_Line_1 = $Check_Line[1]

		$Value_Line_1 = " "
		$Value_Line_2 = " "
		$Value_Line_3 = " "
		$Value_Line_4 = " "
		$Value_Line_5 = " "
		$Value_Line_6 = " "
		$Value_Line_7 = " "
		$Value_Line_8 = " "
		$Value_Line_9 = " "

		If $Check_Line_1 = 'httpApiAccessLevels ' Then
			$Value_Line_1 = 'httpApiAccessLevels : {'
			$Value_Line_2 = '    // The default is empty, using defaults as defined by the endpoints themselves.'
			$Value_Line_3 = ' '
			$Value_Line_4 = '    // But you could for example use this to change all access levels to public (not recommended!)'
			If $Read_Combo_httpApiAccessLevel = "public" Then $Value_Line_5 = '    "*" : ' & '"' & $Read_Combo_httpApiAccessLevel & '"'
			If $Read_Combo_httpApiAccessLevel = "private" Then $Value_Line_5 = '    "*" : ' & '"' & $Read_Combo_httpApiAccessLevel & '"'
			If $Read_Activate_httpApiAccessLevel = "false" Then $Value_Line_5 = '    // "*" : ' & '"' & $Read_Combo_httpApiAccessLevel & '"'
			$Value_Line_6 = ' '
			$Value_Line_7 = '    // Or this to hide the status from public'
			$Value_Line_8 = '    // "" : "public"'
			$Value_Line_9 = '    "status" : ' & '"' & $Read_Combo_status & '"'
			If $Read_Checkbox_Activate_status = "false" Then $Value_Line_9 = '    // "status" : ' & '"' & $Read_Combo_status & '"'
			$Value_Line = $Value_Line_1 & @CRLF & $Value_Line_2 & @CRLF & $Value_Line_3 & @CRLF & $Value_Line_4 & @CRLF & $Value_Line_5 & @CRLF & $Value_Line_6 & @CRLF & $Value_Line_7 & @CRLF & $Value_Line_8 & @CRLF & $Value_Line_9
			FileWriteLine($Dedi_config_cfg_test_new, $Value_Line)
			$Schleife_2 = $Schleife_2 + 8
		EndIf

		If $Check_Line_1 = 'httpApiAccessFilters ' Then
			$Value_Line_1 = 'httpApiAccessFilters : {'
			$Value_Line_2 = ' '
			$Value_Line_3 = '    // Public rules. The default is to accept everything.'
			$Value_Line_4 = '    "public" : ['
			$Value_Line_5 = '        { "type" : ' & '"' & $Read_Combo_Public_rules & '" }'
			$Value_Line = $Value_Line_1 & @CRLF & $Value_Line_2 & @CRLF & $Value_Line_3 & @CRLF & $Value_Line_4 & @CRLF & $Value_Line_5
			FileWriteLine($Dedi_config_cfg_test_new, $Value_Line)
			$Schleife_2 = $Schleife_2 + 4
		EndIf

		If $Check_Line_1 = 'httpApiUsers ' Then
			$Value_NR_Users = 5
			$Value_Line_1 = 'httpApiUsers : {'

			If $Read_Checkbox_User_1 = "true" Then
				$Value_Line_2 = '    "' & $Read_Input_Name_1 & '" : "' &  $Read_Input_password_Name_1 & '",'
				$Value_NR_Users = 5
			EndIf

			If $Read_Checkbox_User_2 = "true" Then
				$Value_Line_3 = '    "' & $Read_Input_Name_2 & '" : "' &  $Read_Input_password_Name_2 & '",'
				$Value_NR_Users = 5
			EndIf

			If $Read_Checkbox_User_3 = "true" Then
				$Value_Line_4 = '    "' & $Read_Input_Name_3 & '" : "' &  $Read_Input_password_Name_3 & '",'
				$Value_NR_Users = 5
			EndIf

			If $Read_Checkbox_User_4 = "true" Then
				$Value_Line_5 = '    "' & $Read_Input_Name_4 & '" : "' &  $Read_Input_password_Name_4 & '",'
				$Value_NR_Users = 5
			EndIf

			If $Read_Checkbox_User_5 = "true" Then
				$Value_Line_6 = '    "' & $Read_Input_Name_5 & '" : "' &  $Read_Input_password_Name_5 & '",'
				$Value_NR_Users = 5
			EndIf

			$Value_Line = $Value_Line_1 & @CRLF & $Value_Line_2 & @CRLF & $Value_Line_3 & @CRLF & $Value_Line_4 & @CRLF & $Value_Line_5 & @CRLF & $Value_Line_6
			If StringRight($Value_Line, '1') <> "}" Then $Value_Line = $Value_Line & " }" & @CRLF
			FileWriteLine($Dedi_config_cfg_test_new, $Value_Line)
			$Schleife_2 = $Schleife_2 + $Value_NR_Users
		EndIf

		If $Check_Line_1 = 'httpApiGroups ' Then
			$Value_Line_1 = 'httpApiGroups : {'

			$Read_Combo_Group_Private = ''

			For $Loop_1 = 1 To 5
				If $Read_Combo_Group_Private_1 <> "" Then $Read_Combo_Group_Private = '    "private" : [ "' & $Read_Combo_Group_Private_1
				If $Read_Combo_Group_Private_2 <> "" Then $Read_Combo_Group_Private = $Read_Combo_Group_Private & '", "' &  $Read_Combo_Group_Private_2
				If $Read_Combo_Group_Private_3 <> "" Then $Read_Combo_Group_Private = $Read_Combo_Group_Private & '", "' &  $Read_Combo_Group_Private_3
				If $Read_Combo_Group_Private_4 <> "" Then $Read_Combo_Group_Private = $Read_Combo_Group_Private & '", "' &  $Read_Combo_Group_Private_4
				If $Read_Combo_Group_Private_5 <> "" Then $Read_Combo_Group_Private = $Read_Combo_Group_Private & '", "' &  $Read_Combo_Group_Private_5
			Next

			$Read_Combo_Group_Private = $Read_Combo_Group_Private & '" ],'

			$Value_Line_2 = $Read_Combo_Group_Private

			$Read_Combo_Group_admin = ''

			For $Loop_1 = 1 To 5
				If $Read_Combo_Group_admin_1 <> "" Then $Read_Combo_Group_admin = '    "admin" : [ "' & $Read_Combo_Group_Admin_1
				If $Read_Combo_Group_admin_2 <> "" Then $Read_Combo_Group_admin = $Read_Combo_Group_admin & '", "' &  $Read_Combo_Group_Admin_2
				If $Read_Combo_Group_admin_3 <> "" Then $Read_Combo_Group_admin = $Read_Combo_Group_admin & '", "' &  $Read_Combo_Group_Admin_3
				If $Read_Combo_Group_admin_4 <> "" Then $Read_Combo_Group_admin = $Read_Combo_Group_admin & '", "' &  $Read_Combo_Group_Admin_4
				If $Read_Combo_Group_admin_5 <> "" Then $Read_Combo_Group_admin = $Read_Combo_Group_admin & '", "' &  $Read_Combo_Group_Admin_5
			Next

			$Read_Combo_Group_admin = $Read_Combo_Group_admin & '" ],'

			$Value_Line_3 = $Read_Combo_Group_admin

			$Value_Line = $Value_Line_1 & @CRLF & $Value_Line_2 & @CRLF & $Value_Line_3
			FileWriteLine($Dedi_config_cfg_test_new, $Value_Line)
			$Schleife_2 = $Schleife_2 + 2
		EndIf

		If $Wert_Line <> "" Then

		EndIf

		If $Schleife_2 <> $NR_Lines_config_cfg - 1 Then
			If $Check_Line_1 <> 'httpApiAccessLevels ' and $Check_Line_1 <> 'httpApiAccessFilters ' and $Check_Line_1 <> 'httpApiUsers ' and $Check_Line_1 <> 'httpApiGroups ' Then FileWriteLine($Dedi_config_cfg_test_new, $Wert_Line)
		EndIf
	Next

	FileWriteLine($Dedi_config_cfg_test_new, "")

	MsgBox(0,"", $msgbox_12, 3)

	IniWrite($config_ini, "TEMP", "TAB_Restart", "TAB_6")

	_Restart_PCDSG()
EndFunc


Func _Whitelist_Dowpdown()
	$Lesen_Auswahl_whitelist = GUICtrlRead($Auswahl_Whitelist)
	If $Lesen_Auswahl_whitelist = "true" Then $Lesen_Auswahl_blacklist = "false"
	GUICtrlSetData($Auswahl_Blacklist, "false")
EndFunc

Func _Blacklist_Dowpdown()
	$Lesen_Auswahl_blacklist = GUICtrlRead($Auswahl_Blacklist)
	If $Lesen_Auswahl_blacklist = "true" Then $Lesen_Auswahl_whitelist = "false"
	GUICtrlSetData($Auswahl_Whitelist, "false")
EndFunc



Func _Werte_Server_CFG_Read__Backup()


	$Dedi_config_cfg = $Dedi_Installations_Verzeichnis & "server.cfg"
	$NR_Lines_config_cfg = _FileCountLines($Dedi_config_cfg) - 1

	$Check_AdminUser_1 = ""
	$Check_AdminUser_2 = ""
	$Check_AdminUser_3 = ""
	$Check_AdminUser_4 = ""
	$Check_AdminUser_5 = ""

	$Value_httpApiUser_1_Name = ""
	$Value_httpApiUser_2_Name = ""
	$Value_httpApiUser_3_Name = ""
	$Value_httpApiUser_4_Name = ""
	$Value_httpApiUser_5_Name = ""

	$Value_httpApiUser_1_Password = ""
	$Value_httpApiUser_2_Password = ""
	$Value_httpApiUser_3_Password = ""
	$Value_httpApiUser_4_Password = ""
	$Value_httpApiUser_5_Password = ""


	For $Schleife_Server_CFG_Read = 1 To $NR_Lines_config_cfg
		$CFG_Line = FileReadLine($Dedi_config_cfg, $Schleife_Server_CFG_Read)
		$Check_Line = StringSplit($CFG_Line, ':', $STR_ENTIRESPLIT)
		If IsArray($Check_Line) Then $Check_Line_1 = $Check_Line[1]
		If $Check_Line[0] > 1 Then $Check_Line_2 = StringReplace($Check_Line[2], ',', '')
		If StringLeft($Check_Line_2, 1) = " " Then $Check_Line_2 = StringTrimLeft($Check_Line_2, 1)
		If StringRight($Check_Line_2, 1) = " " Then $Check_Line_2 = StringTrimRight($Check_Line_2, 1)
		$Check_Line_2 = StringReplace($Check_Line_2, '"', '')

		If $Check_Line_1 = 'logLevel ' Then
			If $Check_Line_2 <> "" Then Global $Wert_logLevel = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "loglevel", $Wert_logLevel)
		EndIf

		If $Check_Line_1 = 'eventsLogSize ' Then
			If $Check_Line_2 <> "" Then Global $Wert_eventsLogSize = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "eventsLogSize", $Wert_logLevel)
		EndIf

		If $Check_Line_1 = 'name ' Then
			If $Check_Line_2 <> "" Then Global $Wert_name = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "name", $Wert_name)
		EndIf

		If $Check_Line_1 = 'secure ' Then
			If $Check_Line_2 <> "" Then Global $Wert_secure = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "secure", $Wert_secure)
		EndIf

		If $Check_Line_1 = 'password ' Then
			If $Check_Line_2 <> "" Then Global $Wert_password = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "password", $Wert_password)
		EndIf

		If $Check_Line_1 = 'maxPlayerCount ' Then
			If $Check_Line_2 <> "" Then Global $Wert_maxPlayerCount = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "maxPlayerCount", $Wert_maxPlayerCount)
		EndIf

		If $Check_Line_1 = 'bindIP ' Then
			If $Check_Line_2 <> "" Then Global $Wert_bindIP = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "bindIP", $Wert_bindIP)
		EndIf

		If $Check_Line_1 = 'steamPort ' Then
			If $Check_Line_2 <> "" Then Global $Wert_steamPort = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "steamPort", $Wert_steamPort)
		EndIf

		If $Check_Line_1 = 'hostPort ' Then
			If $Check_Line_2 <> "" Then Global $Wert_hostPort = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "hostPort", $Wert_hostPort)
		EndIf

		If $Check_Line_1 = 'queryPort ' Then
			If $Check_Line_2 <> "" Then Global $Wert_queryPort = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "queryPort", $Wert_queryPort)
		EndIf

		If $Check_Line_1 = 'sleepWaiting ' Then
			If $Check_Line_2 <> "" Then Global $Wert_sleepWaiting = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "sleepWaiting", $Wert_sleepWaiting)
		EndIf

		If $Check_Line_1 = 'sleepActive ' Then
			If $Check_Line_2 <> "" Then Global $Wert_sleepActive = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "sleepActive", $Wert_sleepActive)
		EndIf

		If $Check_Line_1 = 'enableHttpApi ' Then
			If $Check_Line_2 <> "" Then Global $Wert_enableHttpApi = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "enableHttpApi", $Wert_enableHttpApi)
		EndIf

		If $Check_Line_1 = 'httpApiLogLevel ' Then
			If $Check_Line_2 <> "" Then Global $Wert_httpApiLogLevel = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "httpApiLogLevel", $Wert_httpApiLogLevel)
		EndIf

		If $Check_Line_1 = 'httpApiInterface ' Then
			If $Check_Line_2 <> "" Then Global $Wert_httpApiInterface = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "httpApiInterface", $Wert_httpApiInterface)
		EndIf

		If $Check_Line_1 = 'httpApiPort ' Then
			If $Check_Line_2 <> "" Then Global $Wert_httpApiPort = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "httpApiPort", $Wert_httpApiPort)
		EndIf

		If $Check_Line_1 = 'httpApiAccessLevels ' Then
			$CFG_Line_plus_4 = FileReadLine($Dedi_config_cfg, $Schleife_Server_CFG_Read + 4)
			$Check_Line_plus_4 = StringSplit($CFG_Line_plus_4, ':', $STR_ENTIRESPLIT)
			$Check_Status_1 = StringReplace($Check_Line_plus_4[1], '"', '')
			$Check_Status_1 = StringReplace($Check_Status_1, '*', '')
			$Check_Status_1 = StringReplace($Check_Status_1, ' ', '')
			If $Check_Status_1 = "//" Then $Check_httpApiAccessLevels_1 = "false"
			If $Check_Status_1 <> "//" Then $Check_httpApiAccessLevels_1 = "true"
			If IsArray($Check_Line_plus_4) Then $Check_Line_plus_4_1 = $Check_Line_plus_4[1]
			If $Check_Line_plus_4[0] > 1 Then $Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4[2], ',', '')
			$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, ' ', '')
			$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, '"', '')
			If $Check_Line_plus_4_2 <> "" Then Global $Value_httpApiAccessLevels = $Check_Line_plus_4_2
			If $Check_Status_1 = "false" Then $Value_httpApiAccessLevels = " // " & $Check_Line_plus_4_2
			IniWrite($config_ini, "Server_Einstellungen", "httpApiAccessLevel", $Check_httpApiAccessLevels_1)
		EndIf

		If $Check_Line_1 = '    // "status" ' Then
			$Check_Status_1 = "false"
			$Check_Line_2 = $Check_Line_2
			Global $Value_httpApi_status = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "Activate_status", $Check_Status_1)
		EndIf

		If $Check_Line_1 = '    "status" ' Then
			$Check_Status_1 = "true"
			If $Check_Line_2 <> "" Then Global $Value_httpApi_status = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "Activate_status", $Check_Status_1)
		EndIf

		If $Check_Line_1 = 'httpApiAccessFilters ' Then
			$CFG_Line_plus_4 = FileReadLine($Dedi_config_cfg, $Schleife_Server_CFG_Read + 4)
			$Check_Line_plus_4 = StringSplit($CFG_Line_plus_4, ':', $STR_ENTIRESPLIT)
			If IsArray($Check_Line_plus_4) Then $Check_Line_plus_4_1 = $Check_Line_plus_4[1]
			If $Check_Line_plus_4[0] > 1 Then $Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4[2], ',', '')
			$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, ' ', '')
			$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, '"', '')
			$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, '}', '')
			If $Check_Line_plus_4_2 <> "" Then Global $Value_httpApiAccessFilters = $Check_Line_plus_4_2
			IniWrite($config_ini, "Server_Einstellungen", "httpApiAccessFilters", $Value_httpApiAccessFilters)
		EndIf

		If $Check_Line_1 = 'httpApiUsers ' Then
			$Check_Checkbox_User_1 = "false"
			$Check_Checkbox_User_2 = "false"
			$Check_Checkbox_User_3 = "false"
			$Check_Checkbox_User_4 = "false"
			$Check_Checkbox_User_5 = "false"

			$CFG_Line_plus_1 = FileReadLine($Dedi_config_cfg, $Schleife_Server_CFG_Read + 1)
			$Check_Line_plus_1 = StringSplit($CFG_Line_plus_1, ':', $STR_ENTIRESPLIT)
			If IsArray($Check_Line_plus_1) Then $Check_Line_plus_1_1 = $Check_Line_plus_1[1]
			If $Check_Line_plus_1[0] > 1 Then $Check_Line_plus_1_2 = StringReplace($Check_Line_plus_1[2], ',', '')
			$Check_Line_plus_1_1 = StringReplace($Check_Line_plus_1_1, ' ', '')
			$Check_Line_plus_1_1 = StringReplace($Check_Line_plus_1_1, '"', '')
			$Check_Line_plus_1_1 = StringReplace($Check_Line_plus_1_1, '//', '')
			$Check_Line_plus_1_2 = StringReplace($Check_Line_plus_1_2, ' ', '')
			$Check_Line_plus_1_2 = StringReplace($Check_Line_plus_1_2, '"', '')
			$Check_Line_plus_1_2 = StringReplace($Check_Line_plus_1_2, ',', '')
			If $Check_Line_plus_1_1 <> "" and $Check_Line_plus_1_1 <> "}" and $Check_Line_plus_1_1 <> "{type" and $Check_Line_plus_1_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_1_2 <> "accept" Then Global $Value_httpApiUser_1_Name = $Check_Line_plus_1_1
			If $Check_Line_plus_1_2 <> "" and $Check_Line_plus_1_1 <> "}" and $Check_Line_plus_1_1 <> "{type" and $Check_Line_plus_1_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_1_2 <> "accept" Then Global $Value_httpApiUser_1_Password = $Check_Line_plus_1_2
			If $Check_Line_plus_1_2 <> "" and $Check_Line_plus_1_1 <> "}" and $Check_Line_plus_1_1 <> "{type" and $Check_Line_plus_1_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_1_2 <> "accept" Then Global $Check_Checkbox_User_1 = "true"

			$CFG_Line_plus_2 = FileReadLine($Dedi_config_cfg, $Schleife_Server_CFG_Read + 2)
			$Check_Line_plus_2 = StringSplit($CFG_Line_plus_2, ':', $STR_ENTIRESPLIT)
			If IsArray($Check_Line_plus_1) Then $Check_Line_plus_2_1 = $Check_Line_plus_2[1]
			If $Check_Line_plus_2[0] > 1 Then $Check_Line_plus_2_2 = StringReplace($Check_Line_plus_2[2], ',', '')
			$Check_Line_plus_2_1 = StringReplace($Check_Line_plus_2_1, ' ', '')
			$Check_Line_plus_2_1 = StringReplace($Check_Line_plus_2_1, '"', '')
			$Check_Line_plus_2_1 = StringReplace($Check_Line_plus_2_1, '//', '')
			$Check_Line_plus_2_2 = StringReplace($Check_Line_plus_2_2, ' ', '')
			$Check_Line_plus_2_2 = StringReplace($Check_Line_plus_2_2, '"', '')
			$Check_Line_plus_2_2 = StringReplace($Check_Line_plus_2_2, ',', '')
			If $Check_Line_plus_2_1 <> "" and $Check_Line_plus_2_1 <> "}" and $Check_Line_plus_2_1 <> "{type" and $Check_Line_plus_2_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_2_2 <> "accept" Then Global $Value_httpApiUser_2_Name = $Check_Line_plus_2_1
			If $Check_Line_plus_2_2 <> "" and $Check_Line_plus_2_1 <> "}" and $Check_Line_plus_2_1 <> "{type" and $Check_Line_plus_2_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_2_2 <> "accept" Then Global $Value_httpApiUser_2_Password = $Check_Line_plus_2_2
			If $Check_Line_plus_2_2 <> "" and $Check_Line_plus_2_1 <> "}" and $Check_Line_plus_2_1 <> "{type" and $Check_Line_plus_2_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_2_2 <> "accept" Then Global $Check_Checkbox_User_2 = "true"

			$CFG_Line_plus_3 = FileReadLine($Dedi_config_cfg, $Schleife_Server_CFG_Read + 3)
			$Check_Line_plus_3 = StringSplit($CFG_Line_plus_3, ':', $STR_ENTIRESPLIT)
			If IsArray($Check_Line_plus_3) Then $Check_Line_plus_3_1 = $Check_Line_plus_3[1]
			If $Check_Line_plus_3[0] > 1 Then $Check_Line_plus_3_2 = StringReplace($Check_Line_plus_3[2], ',', '')
			$Check_Line_plus_3_1 = StringReplace($Check_Line_plus_3_1, ' ', '')
			$Check_Line_plus_3_1 = StringReplace($Check_Line_plus_3_1, '"', '')
			$Check_Line_plus_3_1 = StringReplace($Check_Line_plus_3_1, '//', '')
			$Check_Line_plus_3_2 = StringReplace($Check_Line_plus_3_2, ' ', '')
			$Check_Line_plus_3_2 = StringReplace($Check_Line_plus_3_2, '"', '')
			$Check_Line_plus_3_2 = StringReplace($Check_Line_plus_3_2, ',', '')
			If $Check_Line_plus_3_1 <> "" and $Check_Line_plus_3_1 <> "}" and $Check_Line_plus_3_1 <> "{type" and $Check_Line_plus_3_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_3_2 <> "accept" Then Global $Value_httpApiUser_3_Name = $Check_Line_plus_3_1
			If $Check_Line_plus_3_2 <> "" and $Check_Line_plus_3_1 <> "}" and $Check_Line_plus_3_1 <> "{type" and $Check_Line_plus_3_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_3_2 <> "accept" Then Global $Value_httpApiUser_3_Password = $Check_Line_plus_3_2
			If $Check_Line_plus_3_2 <> "" and $Check_Line_plus_3_1 <> "}" and $Check_Line_plus_3_1 <> "{type" and $Check_Line_plus_3_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_3_2 <> "accept" Then Global $Check_Checkbox_User_3 = "true"

			$CFG_Line_plus_4 = FileReadLine($Dedi_config_cfg, $Schleife_Server_CFG_Read + 4)
			$Check_Line_plus_4 = StringSplit($CFG_Line_plus_4, ':', $STR_ENTIRESPLIT)
			If IsArray($Check_Line_plus_4) Then $Check_Line_plus_4_1 = $Check_Line_plus_4[1]
			If $Check_Line_plus_4[0] > 1 Then $Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4[2], ',', '')
			$Check_Line_plus_4_1 = StringReplace($Check_Line_plus_4_1, ' ', '')
			$Check_Line_plus_4_1 = StringReplace($Check_Line_plus_4_1, '"', '')
			$Check_Line_plus_4_1 = StringReplace($Check_Line_plus_4_1, '//', '')
			$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, ' ', '')
			$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, '"', '')
			$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, ',', '')
			If $Check_Line_plus_4_1 <> "" and $Check_Line_plus_4_1 <> "}" and $Check_Line_plus_4_1 <> "{type" and $Check_Line_plus_4_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_4_2 <> "accept" Then Global $Value_httpApiUser_4_Name = $Check_Line_plus_4_1
			If $Check_Line_plus_4_2 <> "" and $Check_Line_plus_4_1 <> "}" and $Check_Line_plus_4_1 <> "{type" and $Check_Line_plus_4_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_4_2 <> "accept" Then Global $Value_httpApiUser_4_Password = $Check_Line_plus_4_2
			If $Check_Line_plus_4_2 <> "" and $Check_Line_plus_4_1 <> "}" and $Check_Line_plus_4_1 <> "{type" and $Check_Line_plus_4_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_4_2 <> "accept" Then Global $Check_Checkbox_User_4 = "true"

			$CFG_Line_plus_5 = FileReadLine($Dedi_config_cfg, $Schleife_Server_CFG_Read + 5)
			$Check_Line_plus_5 = StringSplit($CFG_Line_plus_5, ':', $STR_ENTIRESPLIT)
			If IsArray($Check_Line_plus_5) Then $Check_Line_plus_5_1 = $Check_Line_plus_5[1]
			If $Check_Line_plus_5[0] > 1 Then $Check_Line_plus_5_2 = StringReplace($Check_Line_plus_5[2], ',', '')
			$Check_Line_plus_5_1 = StringReplace($Check_Line_plus_5_1, ' ', '')
			$Check_Line_plus_5_1 = StringReplace($Check_Line_plus_5_1, '"', '')
			$Check_Line_plus_5_1 = StringReplace($Check_Line_plus_5_1, '//', '')
			$Check_Line_plus_5_2 = StringReplace($Check_Line_plus_5_2, ' ', '')
			$Check_Line_plus_5_2 = StringReplace($Check_Line_plus_5_2, '"', '')
			$Check_Line_plus_5_2 = StringReplace($Check_Line_plus_5_2, ',', '')
			If $Check_Line_plus_5_1 <> "" and $Check_Line_plus_5_1 <> "}" and $Check_Line_plus_5_1 <> "{type" and $Check_Line_plus_5_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_5_2 <> "accept" Then Global $Value_httpApiUser_5_Name = $Check_Line_plus_5_1
			If $Check_Line_plus_5_2 <> "" and $Check_Line_plus_5_1 <> "}" and $Check_Line_plus_5_1 <> "{type" and $Check_Line_plus_5_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_5_2 <> "accept" Then Global $Value_httpApiUser_5_Password = $Check_Line_plus_5_2
			If $Check_Line_plus_5_2 <> "" and $Check_Line_plus_5_1 <> "}" and $Check_Line_plus_5_1 <> "{type" and $Check_Line_plus_5_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_5_2 <> "accept" Then Global $Check_Checkbox_User_5 = "true"
		EndIf

		If $Check_Line_1 = 'httpApiGroups ' Then
			$CFG_Line_plus_1 = FileReadLine($Dedi_config_cfg, $Schleife_Server_CFG_Read + 1)
			$Check_Line_plus_1 = StringSplit($CFG_Line_plus_1, ':', $STR_ENTIRESPLIT)
			If IsArray($Check_Line_plus_1) Then $Check_Line_plus_1_1 = $Check_Line_plus_1[1]
			If $Check_Line_plus_1[0] > 1 Then $Check_Users = StringSplit($Check_Line_plus_1[2], ',', $STR_ENTIRESPLIT)
			If $Check_Users[0] > 1 Then $Check_User_1 = $Check_Users[1]
			If $Check_Users[0] > 2 Then $Check_User_2 = $Check_Users[2]
			If $Check_Users[0] > 3 Then $Check_User_3 = $Check_Users[3]
			If $Check_Users[0] > 4 Then $Check_User_4 = $Check_Users[4]
			If $Check_Users[0] > 5 Then $Check_User_5 = $Check_Users[5]

			If $Check_Line_plus_1[0] > 1 Then
				$Check_User_1 = StringReplace($Check_User_1, '[', '')
				$Check_User_1 = StringReplace($Check_User_1, ']', '')
				$Check_User_1 = StringReplace($Check_User_1, '"', '')
				$Check_User_1 = StringReplace($Check_User_1, ' ', '')
				$Check_User_2 = StringReplace($Check_User_2, '[', '')
				$Check_User_2 = StringReplace($Check_User_2, ']', '')
				$Check_User_2 = StringReplace($Check_User_2, '"', '')
				$Check_User_2 = StringReplace($Check_User_2, ' ', '')
				$Check_User_3 = StringReplace($Check_User_3, '[', '')
				$Check_User_3 = StringReplace($Check_User_3, ']', '')
				$Check_User_3 = StringReplace($Check_User_3, '"', '')
				$Check_User_3 = StringReplace($Check_User_3, ' ', '')
				$Check_User_4 = StringReplace($Check_User_4, '[', '')
				$Check_User_4 = StringReplace($Check_User_4, ']', '')
				$Check_User_4 = StringReplace($Check_User_4, '"', '')
				$Check_User_4 = StringReplace($Check_User_4, ' ', '')
				$Check_User_5 = StringReplace($Check_User_5, '[', '')
				$Check_User_5 = StringReplace($Check_User_5, ']', '')
				$Check_User_5 = StringReplace($Check_User_5, '"', '')
				$Check_User_5 = StringReplace($Check_User_5, ' ', '')

				$Value_httpApi_GroupUser_Name_1 = $Check_User_1
				$Value_httpApi_GroupUser_Name_2 = $Check_User_2
				$Value_httpApi_GroupUser_Name_3 = $Check_User_3
				$Value_httpApi_GroupUser_Name_4 = $Check_User_4
				$Value_httpApi_GroupUser_Name_5 = $Check_User_5
			EndIf

			$CFG_Line_plus_2 = FileReadLine($Dedi_config_cfg, $Schleife_Server_CFG_Read + 2)
			$Check_Line_plus_2 = StringSplit($CFG_Line_plus_2, ':', $STR_ENTIRESPLIT)
			If IsArray($Check_Line_plus_2) Then $Check_Line_plus_2_1 = $Check_Line_plus_2[1]
			If $Check_Line_plus_2[0] > 1 Then $Check_AdminUsers = StringSplit($Check_Line_plus_2[2], ',', $STR_ENTIRESPLIT)

			If $Check_AdminUsers[0] > 1 Then $Check_AdminUser_1 = $Check_AdminUsers[1]
			If $Check_AdminUsers[0] > 2 Then $Check_AdminUser_2 = $Check_AdminUsers[2]
			If $Check_AdminUsers[0] > 3 Then $Check_AdminUser_3 = $Check_AdminUsers[3]
			If $Check_AdminUsers[0] > 4 Then $Check_AdminUser_4 = $Check_AdminUsers[4]
			If $Check_AdminUsers[0] > 5 Then $Check_AdminUser_5 = $Check_AdminUsers[5]

			If $Check_Line_plus_1[0] > 1 Then
				If $Check_AdminUsers[0] > 1 Then
					$Check_AdminUser_1 = StringReplace($Check_AdminUser_1, '[', '')
					$Check_AdminUser_1 = StringReplace($Check_AdminUser_1, ']', '')
					$Check_AdminUser_1 = StringReplace($Check_AdminUser_1, '"', '')
					$Check_AdminUser_1 = StringReplace($Check_AdminUser_1, ' ', '')
				EndIf

				If $Check_AdminUsers[0] > 2 Then
					$Check_AdminUser_2 = StringReplace($Check_AdminUser_2, '[', '')
					$Check_AdminUser_2 = StringReplace($Check_AdminUser_2, ']', '')
					$Check_AdminUser_2 = StringReplace($Check_AdminUser_2, '"', '')
					$Check_AdminUser_2 = StringReplace($Check_AdminUser_2, ' ', '')
				EndIf

				If $Check_AdminUsers[0] > 3 Then
					$Check_AdminUser_3 = StringReplace($Check_AdminUser_3, '[', '')
					$Check_AdminUser_3 = StringReplace($Check_AdminUser_3, ']', '')
					$Check_AdminUser_3 = StringReplace($Check_AdminUser_3, '"', '')
					$Check_AdminUser_3 = StringReplace($Check_AdminUser_3, ' ', '')
				EndIf

				If $Check_AdminUsers[0] > 4 Then
					$Check_AdminUser_4 = StringReplace($Check_AdminUser_4, '[', '')
					$Check_AdminUser_4 = StringReplace($Check_AdminUser_4, ']', '')
					$Check_AdminUser_4 = StringReplace($Check_AdminUser_4, '"', '')
					$Check_AdminUser_4 = StringReplace($Check_AdminUser_4, ' ', '')
				EndIf

				If $Check_AdminUsers[0] > 5 Then
					$Check_AdminUser_5 = StringReplace($Check_AdminUser_5, '[', '')
					$Check_AdminUser_5 = StringReplace($Check_AdminUser_5, ']', '')
					$Check_AdminUser_5 = StringReplace($Check_AdminUser_5, '"', '')
					$Check_AdminUser_5 = StringReplace($Check_AdminUser_5, ' ', '')
				EndIf

				$Value_httpApi_GroupAdminUser_Name_1 = $Check_AdminUser_1
				$Value_httpApi_GroupAdminUser_Name_2 = $Check_AdminUser_2
				$Value_httpApi_GroupAdminUser_Name_3 = $Check_AdminUser_3
				$Value_httpApi_GroupAdminUser_Name_4 = $Check_AdminUser_4
				$Value_httpApi_GroupAdminUser_Name_5 = $Check_AdminUser_5
			EndIf

		EndIf

		If $Check_Line_1 = 'allowEmptyJoin ' Then
			If $Check_Line_2 <> "" Then Global $Wert_allowEmptyJoin = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "allowEmptyJoin", $Wert_allowEmptyJoin)
		EndIf

		If $Check_Line_1 = 'controlGameSetup ' Then
			If $Check_Line_2 <> "" Then Global $Wert_controlGameSetup = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "controlGameSetup", $Wert_allowEmptyJoin)
		EndIf

		If $Check_Line_1 = '    "ServerControlsTrack" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_ServerControlsTrack = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "ServerControlsTrack", $Wert_ServerControlsTrack)
		EndIf

		If $Check_Line_1 = '    "ServerControlsVehicleClass" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_ServerControlsVehicleClass = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "ServerControlsVehicleClass", $Wert_ServerControlsVehicleClass)
		EndIf

		;MsgBox(0, "$Check_Line_1", $Check_Line_1)

		If $Check_Line_1 = '    // "sms_rotate",' Then
			;MsgBox(0, "// sms_rotate", "// sms_rotate")
			$Check_Status_1 = "false"
			$Check_Line_2 = $Check_Line_2
			Global $Value_httpApi_status = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "sms_rotate", $Check_Status_1)
		EndIf

		If $Check_Line_1 = '    "sms_rotate",' Then
			;MsgBox(0, "sms_rotate", "sms_rotate")
			$Check_Status_1 = "true"
			If $Check_Line_2 <> "" Then Global $Value_httpApi_status = $Check_Line_2
			IniWrite($config_ini, "Server_Einstellungen", "sms_rotate", $Check_Status_1)
		EndIf
	Next
EndFunc

Func _Werte_Server_CFG_Read()
	If FileExists($Dedi_config_cfg) Then
		$Server_CFG_Array = FileReadToArray($Dedi_config_cfg)
		$NR_Lines_config_cfg = _FileCountLines($Dedi_config_cfg) - 1

		For $Loop = 0 To $NR_Lines_config_cfg
			$Wert_Line = $Server_CFG_Array[$Loop]

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'logLevel : ')
			If $StringInStr_Check_1 <> 0 Then
				If StringLeft($Wert_Line, 1) = "L" Then
					$Wert_Line = StringReplace($Wert_Line, 'logLevel : ', '')
					$Wert_Line = StringReplace($Wert_Line, '"', '')
					$Wert_Line = StringReplace($Wert_Line, ',', '')
					$Wert_logLevel = $Wert_Line
					IniWrite($config_ini, "Server_Einstellungen", "logLevel", $Wert_Line)
				EndIf
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'eventsLogSize : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'eventsLogSize : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_eventsLogSize = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "eventsLogSize", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'name : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'name : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_name = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "name", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'secure : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'secure : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_secure = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "secure", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'password : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'password : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_password = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "password", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'maxPlayerCount : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'maxPlayerCount : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_maxPlayerCount = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "maxPlayerCount", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'bindIP : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'bindIP : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_bindIP = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "bindIP", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'steamPort : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'steamPort : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_steamPort = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "steamPort", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'hostPort : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'hostPort : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_hostPort = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "hostPort", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'queryPort : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'queryPort : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_queryPort = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "queryPort", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'sleepWaiting : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'sleepWaiting : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_sleepWaiting = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "sleepWaiting", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'sleepActive : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'sleepActive : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_sleepActive = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "sleepActive", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'sportsPlay : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'sportsPlay : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "sportsPlay", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'enableHttpApi : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'enableHttpApi : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_enableHttpApi = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "enableHttpApi", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'httpApiLogLevel : "')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'httpApiLogLevel : "', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				;$Wert_httpApiLogLevel = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "httpApiLogLevel", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'httpApiInterface : "')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'httpApiInterface : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_httpApiInterface = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "httpApiInterface", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'httpApiPort : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'httpApiPort : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_httpApiPort = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "httpApiPort", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "status" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = "true"
				$Value_httpApi_status  = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "Activate_status", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    // "status" ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = "false"
				$Value_httpApi_status = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "Activate_status", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'enableLuaApi : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'enableLuaApi : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "enableLuaApi", $Wert_Line)
			EndIf


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'luaAddonRoot : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'luaAddonRoot : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "luaAddonRoot", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "sms_rotate",')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = "true"
				;$Value_httpApi_status = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "SMS_Rotate", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    //"sms_rotate",')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = "false"
				;$Value_httpApi_status = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "SMS_Rotate", $Wert_Line)
			EndIf


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'httpApiAccessLevels : {')
			If $StringInStr_Check_1 <> 0 Then
				$CFG_Line_plus_4 = $Server_CFG_Array[$Loop + 4]
				$Check_Line_plus_4 = StringSplit($CFG_Line_plus_4, ':', $STR_ENTIRESPLIT)
				$Check_Status_1 = StringReplace($Check_Line_plus_4[1], '"', '')
				$Check_Status_1 = StringReplace($Check_Status_1, '*', '')
				$Check_Status_1 = StringReplace($Check_Status_1, ' ', '')
				If $Check_Status_1 = "//" Then $Check_httpApiAccessLevels_1 = "false"
				If $Check_Status_1 <> "//" Then $Check_httpApiAccessLevels_1 = "true"
				If IsArray($Check_Line_plus_4) Then $Check_Line_plus_4_1 = $Check_Line_plus_4[1]
				If $Check_Line_plus_4[0] > 1 Then $Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4[2], ',', '')
				$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, ' ', '')
				$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, '"', '')
				If $Check_Line_plus_4_2 <> "" Then Global $Value_httpApiAccessLevels = $Check_Line_plus_4_2
				If $Check_Status_1 = "false" Then $Value_httpApiAccessLevels = " //" & $Check_Line_plus_4_2
				IniWrite($config_ini, "Server_Einstellungen", "httpApiAccessLevel", $Check_httpApiAccessLevels_1)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    //"status" : "')
			If $StringInStr_Check_1 <> 0 Then
				$Check_Status_1 = "false"
				Global $Value_httpApi_status = $Check_Status_1
				IniWrite($config_ini, "Server_Einstellungen", "Activate_status", $Check_Status_1)
				$Wert_Line = StringReplace($Wert_Line, '    //"status" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "httpApistatus", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "status" : "')
			If $StringInStr_Check_1 <> 0 Then
				$Check_Status_1 = "true"
				Global $Value_httpApi_status = $Check_Status_1
				MsgBox(0, "", $Value_httpApi_status & @CRLF & $Check_Status_1)
				IniWrite($config_ini, "Server_Einstellungen", "Activate_status", $Check_Status_1)
				$Wert_Line = StringReplace($Wert_Line, '    "status" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "httpApistatus", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'httpApiAccessFilters : {')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = $Server_CFG_Array[$Loop + 4]
				$Check_Line_plus_4_2 = StringReplace($Wert_Line, '        { "type" : "', '')
				$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, '"', '')
				$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, ' ', '')
				$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, '}', '')
				If $Check_Line_plus_4_2 <> "" Then Global $Value_httpApiAccessFilters = $Check_Line_plus_4_2
				;MsgBox(0, "httpApiAccessFilters", $Check_Line_plus_4_2)
				IniWrite($config_ini, "Server_Einstellungen", "httpApiAccessFilters", $Value_httpApiAccessFilters)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'httpApiUsers : {')
			If $StringInStr_Check_1 <> 0 Then
				$Check_Checkbox_User_1 = "false"
				$Check_Checkbox_User_2 = "false"
				$Check_Checkbox_User_3 = "false"
				$Check_Checkbox_User_4 = "false"
				$Check_Checkbox_User_5 = "false"

				$CFG_Line_plus_1 = $Server_CFG_Array[$Loop + 1]

				$Check_Line_plus_1 = StringSplit($CFG_Line_plus_1, ':', $STR_ENTIRESPLIT)
				If IsArray($Check_Line_plus_1) Then $Check_Line_plus_1_1 = $Check_Line_plus_1[1]

				If $Check_Line_plus_1[0] > 1 Then $Check_Line_plus_1_2 = StringReplace($Check_Line_plus_1[2], ',', '')
				$Check_Line_plus_1_1 = StringReplace($Check_Line_plus_1_1, ' ', '')
				$Check_Line_plus_1_1 = StringReplace($Check_Line_plus_1_1, '"', '')
				$Check_Line_plus_1_1 = StringReplace($Check_Line_plus_1_1, '//', '')
				$Check_Line_plus_1_2 = StringReplace($Check_Line_plus_1_2, ' ', '')
				$Check_Line_plus_1_2 = StringReplace($Check_Line_plus_1_2, '"', '')
				$Check_Line_plus_1_2 = StringReplace($Check_Line_plus_1_2, ',', '')
				If $Check_Line_plus_1_1 <> "" and $Check_Line_plus_1_1 <> "}" and $Check_Line_plus_1_1 <> "{type" and $Check_Line_plus_1_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_1_2 <> "accept" Then Global $Value_httpApiUser_1_Name = $Check_Line_plus_1_1
				If $Check_Line_plus_1_2 <> "" and $Check_Line_plus_1_1 <> "}" and $Check_Line_plus_1_1 <> "{type" and $Check_Line_plus_1_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_1_2 <> "accept" Then Global $Value_httpApiUser_1_Password = $Check_Line_plus_1_2
				If $Check_Line_plus_1_2 <> "" and $Check_Line_plus_1_1 <> "}" and $Check_Line_plus_1_1 <> "{type" and $Check_Line_plus_1_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_1_2 <> "accept" Then Global $Check_Checkbox_User_1 = "true"
				If $Value_httpApiUser_1_Name <> "" Then
				IniWrite($config_ini, "Server_Einstellungen", "Name_User_1", $Value_httpApiUser_1_Name)
					IniWrite($config_ini, "Server_Einstellungen", "password_User_1", $Value_httpApiUser_1_Password)
					;MsgBox(0, "", $Value_httpApiUser_1_Name & @CRLF & @CRLF & $Value_httpApiUser_1_Password)
				EndIf

				$CFG_Line_plus_2 = $Server_CFG_Array[$Loop + 2]
				$Check_Line_plus_2 = StringSplit($CFG_Line_plus_2, ':', $STR_ENTIRESPLIT)
				If IsArray($Check_Line_plus_1) Then $Check_Line_plus_2_1 = $Check_Line_plus_2[1]
				If $Check_Line_plus_2[0] > 1 Then $Check_Line_plus_2_2 = StringReplace($Check_Line_plus_2[2], ',', '')
				$Check_Line_plus_2_1 = StringReplace($Check_Line_plus_2_1, ' ', '')
				$Check_Line_plus_2_1 = StringReplace($Check_Line_plus_2_1, '"', '')
				$Check_Line_plus_2_1 = StringReplace($Check_Line_plus_2_1, '//', '')
				$Check_Line_plus_2_2 = StringReplace($Check_Line_plus_2_2, ' ', '')
				$Check_Line_plus_2_2 = StringReplace($Check_Line_plus_2_2, '"', '')
				$Check_Line_plus_2_2 = StringReplace($Check_Line_plus_2_2, ',', '')
				If $Check_Line_plus_2_1 <> "" and $Check_Line_plus_2_1 <> "}" and $Check_Line_plus_2_1 <> "{type" and $Check_Line_plus_2_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_2_2 <> "accept" Then Global $Value_httpApiUser_2_Name = $Check_Line_plus_2_1
				If $Check_Line_plus_2_2 <> "" and $Check_Line_plus_2_1 <> "}" and $Check_Line_plus_2_1 <> "{type" and $Check_Line_plus_2_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_2_2 <> "accept" Then Global $Value_httpApiUser_2_Password = $Check_Line_plus_2_2
				If $Check_Line_plus_2_2 <> "" and $Check_Line_plus_2_1 <> "}" and $Check_Line_plus_2_1 <> "{type" and $Check_Line_plus_2_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_2_2 <> "accept" Then Global $Check_Checkbox_User_2 = "true"
				If $Value_httpApiUser_2_Name <> "" Then
					IniWrite($config_ini, "Server_Einstellungen", "Name_User_2", $Value_httpApiUser_2_Name)
					IniWrite($config_ini, "Server_Einstellungen", "password_User_2", $Value_httpApiUser_2_Password)
					;MsgBox(0, "", $Value_httpApiUser_2_Name & @CRLF & @CRLF & $Value_httpApiUser_2_Password)
				EndIf

				$CFG_Line_plus_3 = $Server_CFG_Array[$Loop + 3]
				$Check_Line_plus_3 = StringSplit($CFG_Line_plus_3, ':', $STR_ENTIRESPLIT)
				If IsArray($Check_Line_plus_3) Then $Check_Line_plus_3_1 = $Check_Line_plus_3[1]
				If $Check_Line_plus_3[0] > 1 Then $Check_Line_plus_3_2 = StringReplace($Check_Line_plus_3[2], ',', '')
				$Check_Line_plus_3_1 = StringReplace($Check_Line_plus_3_1, ' ', '')
				$Check_Line_plus_3_1 = StringReplace($Check_Line_plus_3_1, '"', '')
				$Check_Line_plus_3_1 = StringReplace($Check_Line_plus_3_1, '//', '')
				$Check_Line_plus_3_2 = StringReplace($Check_Line_plus_3_2, ' ', '')
				$Check_Line_plus_3_2 = StringReplace($Check_Line_plus_3_2, '"', '')
				$Check_Line_plus_3_2 = StringReplace($Check_Line_plus_3_2, ',', '')
				If $Check_Line_plus_3_1 <> "" and $Check_Line_plus_3_1 <> "}" and $Check_Line_plus_3_1 <> "{type" and $Check_Line_plus_3_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_3_2 <> "accept" Then Global $Value_httpApiUser_3_Name = $Check_Line_plus_3_1
				If $Check_Line_plus_3_2 <> "" and $Check_Line_plus_3_1 <> "}" and $Check_Line_plus_3_1 <> "{type" and $Check_Line_plus_3_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_3_2 <> "accept" Then Global $Value_httpApiUser_3_Password = $Check_Line_plus_3_2
				If $Check_Line_plus_3_2 <> "" and $Check_Line_plus_3_1 <> "}" and $Check_Line_plus_3_1 <> "{type" and $Check_Line_plus_3_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_3_2 <> "accept" Then Global $Check_Checkbox_User_3 = "true"
				If $Value_httpApiUser_3_Name <> "" Then
					IniWrite($config_ini, "Server_Einstellungen", "Name_User_3", $Value_httpApiUser_3_Name)
					IniWrite($config_ini, "Server_Einstellungen", "password_User_3", $Value_httpApiUser_3_Password)
					;MsgBox(0, "", $Value_httpApiUser_3_Name & @CRLF & @CRLF & $Value_httpApiUser_3_Password)
				EndIf

				$CFG_Line_plus_4 = $Server_CFG_Array[$Loop + 4]
				$Check_Line_plus_4 = StringSplit($CFG_Line_plus_4, ':', $STR_ENTIRESPLIT)
				If IsArray($Check_Line_plus_4) Then $Check_Line_plus_4_1 = $Check_Line_plus_4[1]
				If $Check_Line_plus_4[0] > 1 Then $Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4[2], ',', '')
				$Check_Line_plus_4_1 = StringReplace($Check_Line_plus_4_1, ' ', '')
				$Check_Line_plus_4_1 = StringReplace($Check_Line_plus_4_1, '"', '')
				$Check_Line_plus_4_1 = StringReplace($Check_Line_plus_4_1, '//', '')
				$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, ' ', '')
				$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, '"', '')
				$Check_Line_plus_4_2 = StringReplace($Check_Line_plus_4_2, ',', '')
				If $Check_Line_plus_4_1 <> "" and $Check_Line_plus_4_1 <> "}" and $Check_Line_plus_4_1 <> "{type" and $Check_Line_plus_4_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_4_2 <> "accept" Then Global $Value_httpApiUser_4_Name = $Check_Line_plus_4_1
				If $Check_Line_plus_4_2 <> "" and $Check_Line_plus_4_1 <> "}" and $Check_Line_plus_4_1 <> "{type" and $Check_Line_plus_4_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_4_2 <> "accept" Then Global $Value_httpApiUser_4_Password = $Check_Line_plus_4_2
				If $Check_Line_plus_4_2 <> "" and $Check_Line_plus_4_1 <> "}" and $Check_Line_plus_4_1 <> "{type" and $Check_Line_plus_4_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_4_2 <> "accept" Then Global $Check_Checkbox_User_4 = "true"
				If $Value_httpApiUser_4_Name <> "" Then
					IniWrite($config_ini, "Server_Einstellungen", "Name_User_4", $Value_httpApiUser_4_Name)
					IniWrite($config_ini, "Server_Einstellungen", "password_User_4", $Value_httpApiUser_4_Password)
					MsgBox(0, "", $Value_httpApiUser_4_Name & @CRLF & @CRLF & $Value_httpApiUser_4_Password)
				EndIf

				$CFG_Line_plus_5 = $Server_CFG_Array[$Loop + 5]
				$Check_Line_plus_5 = StringSplit($CFG_Line_plus_5, ':', $STR_ENTIRESPLIT)
				If IsArray($Check_Line_plus_5) Then $Check_Line_plus_5_1 = $Check_Line_plus_5[1]
				If $Check_Line_plus_5[0] > 1 Then $Check_Line_plus_5_2 = StringReplace($Check_Line_plus_5[2], ',', '')
				$Check_Line_plus_5_1 = StringReplace($Check_Line_plus_5_1, ' ', '')
				$Check_Line_plus_5_1 = StringReplace($Check_Line_plus_5_1, '"', '')
				$Check_Line_plus_5_1 = StringReplace($Check_Line_plus_5_1, '//', '')
				$Check_Line_plus_5_2 = StringReplace($Check_Line_plus_5_2, ' ', '')
				$Check_Line_plus_5_2 = StringReplace($Check_Line_plus_5_2, '"', '')
				$Check_Line_plus_5_2 = StringReplace($Check_Line_plus_5_2, ',', '')
				If $Check_Line_plus_5_1 <> "" and $Check_Line_plus_5_1 <> "}" and $Check_Line_plus_5_1 <> "{type" and $Check_Line_plus_5_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_5_2 <> "accept" Then Global $Value_httpApiUser_5_Name = $Check_Line_plus_5_1
				If $Check_Line_plus_5_2 <> "" and $Check_Line_plus_5_1 <> "}" and $Check_Line_plus_5_1 <> "{type" and $Check_Line_plus_5_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_5_2 <> "accept" Then Global $Value_httpApiUser_5_Password = $Check_Line_plus_5_2
				If $Check_Line_plus_5_2 <> "" and $Check_Line_plus_5_1 <> "}" and $Check_Line_plus_5_1 <> "{type" and $Check_Line_plus_5_1 <> "Usergroups.Mapfromgroupnamestolistsofusersinsaidgroups." and $Check_Line_plus_5_2 <> "accept" Then Global $Check_Checkbox_User_5 = "true"
				If $Value_httpApiUser_5_Name <> "" Then
					IniWrite($config_ini, "Server_Einstellungen", "Name_User_5", $Value_httpApiUser_5_Name)
					IniWrite($config_ini, "Server_Einstellungen", "password_User_5", $Value_httpApiUser_5_Password)
					;MsgBox(0, "", $Value_httpApiUser_5_Name & @CRLF & @CRLF & $Value_httpApiUser_5_Password)
				EndIf
			EndIf


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'httpApiGroups : {')
			If $StringInStr_Check_1 <> 0 Then
				$CFG_Line_plus_1 = $Server_CFG_Array[$Loop + 1]
				$Check_Line_plus_1 = StringSplit($CFG_Line_plus_1, ':', $STR_ENTIRESPLIT)
				If IsArray($Check_Line_plus_1) Then $Check_Line_plus_1_1 = $Check_Line_plus_1[1]
				If $Check_Line_plus_1[0] > 1 Then $Check_Users = StringSplit($Check_Line_plus_1[2], ',', $STR_ENTIRESPLIT)
				If $Check_Users[0] > 1 Then $Check_User_1 = $Check_Users[1]
				If $Check_Users[0] > 2 Then $Check_User_2 = $Check_Users[2]
				If $Check_Users[0] > 3 Then $Check_User_3 = $Check_Users[3]
				If $Check_Users[0] > 4 Then $Check_User_4 = $Check_Users[4]
				If $Check_Users[0] > 5 Then $Check_User_5 = $Check_Users[5]

				If $Check_Line_plus_1[0] > 1 Then
					$Check_User_1 = StringReplace($Check_User_1, '[', '')
					$Check_User_1 = StringReplace($Check_User_1, ']', '')
					$Check_User_1 = StringReplace($Check_User_1, '"', '')
					$Check_User_1 = StringReplace($Check_User_1, ' ', '')
					$Check_User_2 = StringReplace($Check_User_2, '[', '')
					$Check_User_2 = StringReplace($Check_User_2, ']', '')
					$Check_User_2 = StringReplace($Check_User_2, '"', '')
					$Check_User_2 = StringReplace($Check_User_2, ' ', '')
					$Check_User_3 = StringReplace($Check_User_3, '[', '')
					$Check_User_3 = StringReplace($Check_User_3, ']', '')
					$Check_User_3 = StringReplace($Check_User_3, '"', '')
					$Check_User_3 = StringReplace($Check_User_3, ' ', '')
					$Check_User_4 = StringReplace($Check_User_4, '[', '')
					$Check_User_4 = StringReplace($Check_User_4, ']', '')
					$Check_User_4 = StringReplace($Check_User_4, '"', '')
					$Check_User_4 = StringReplace($Check_User_4, ' ', '')
					$Check_User_5 = StringReplace($Check_User_5, '[', '')
					$Check_User_5 = StringReplace($Check_User_5, ']', '')
					$Check_User_5 = StringReplace($Check_User_5, '"', '')
					$Check_User_5 = StringReplace($Check_User_5, ' ', '')

					$Value_httpApi_GroupUser_Name_1 = $Check_User_1
					$Value_httpApi_GroupUser_Name_2 = $Check_User_2
					$Value_httpApi_GroupUser_Name_3 = $Check_User_3
					$Value_httpApi_GroupUser_Name_4 = $Check_User_4
					$Value_httpApi_GroupUser_Name_5 = $Check_User_5
					If $Value_httpApi_GroupUser_Name_1 <> "" Then IniWrite($config_ini, "Server_Einstellungen", "Group_Private_1", $Value_httpApi_GroupUser_Name_1)
					If $Value_httpApi_GroupUser_Name_2 <> "" Then IniWrite($config_ini, "Server_Einstellungen", "Group_Private_2", $Value_httpApi_GroupUser_Name_2)
					If $Value_httpApi_GroupUser_Name_3 <> "" Then IniWrite($config_ini, "Server_Einstellungen", "Group_Private_3", $Value_httpApi_GroupUser_Name_3)
					If $Value_httpApi_GroupUser_Name_4 <> "" Then IniWrite($config_ini, "Server_Einstellungen", "Group_Private_4", $Value_httpApi_GroupUser_Name_4)
					If $Value_httpApi_GroupUser_Name_5 <> "" Then IniWrite($config_ini, "Server_Einstellungen", "Group_Private_5", $Value_httpApi_GroupUser_Name_5)
				EndIf

				$CFG_Line_plus_2 = $Server_CFG_Array[$Loop + 2]
				$Check_Line_plus_2 = StringSplit($CFG_Line_plus_2, ':', $STR_ENTIRESPLIT)
				If IsArray($Check_Line_plus_2) Then $Check_Line_plus_2_1 = $Check_Line_plus_2[1]
				If $Check_Line_plus_2[0] > 1 Then $Check_AdminUsers = StringSplit($Check_Line_plus_2[2], ',', $STR_ENTIRESPLIT)

				If $Check_AdminUsers[0] > 1 Then $Check_AdminUser_1 = $Check_AdminUsers[1]
				If $Check_AdminUsers[0] > 2 Then $Check_AdminUser_2 = $Check_AdminUsers[2]
				If $Check_AdminUsers[0] > 3 Then $Check_AdminUser_3 = $Check_AdminUsers[3]
				If $Check_AdminUsers[0] > 4 Then $Check_AdminUser_4 = $Check_AdminUsers[4]
				If $Check_AdminUsers[0] > 5 Then $Check_AdminUser_5 = $Check_AdminUsers[5]

				If $Check_Line_plus_1[0] > 1 Then
					If $Check_AdminUsers[0] > 1 Then
						$Check_AdminUser_1 = StringReplace($Check_AdminUser_1, '[', '')
						$Check_AdminUser_1 = StringReplace($Check_AdminUser_1, ']', '')
						$Check_AdminUser_1 = StringReplace($Check_AdminUser_1, '"', '')
						$Check_AdminUser_1 = StringReplace($Check_AdminUser_1, ' ', '')
					EndIf

					If $Check_AdminUsers[0] > 2 Then
						$Check_AdminUser_2 = StringReplace($Check_AdminUser_2, '[', '')
						$Check_AdminUser_2 = StringReplace($Check_AdminUser_2, ']', '')
						$Check_AdminUser_2 = StringReplace($Check_AdminUser_2, '"', '')
						$Check_AdminUser_2 = StringReplace($Check_AdminUser_2, ' ', '')
					EndIf

					If $Check_AdminUsers[0] > 3 Then
						$Check_AdminUser_3 = StringReplace($Check_AdminUser_3, '[', '')
						$Check_AdminUser_3 = StringReplace($Check_AdminUser_3, ']', '')
						$Check_AdminUser_3 = StringReplace($Check_AdminUser_3, '"', '')
						$Check_AdminUser_3 = StringReplace($Check_AdminUser_3, ' ', '')
					EndIf

					If $Check_AdminUsers[0] > 4 Then
						$Check_AdminUser_4 = StringReplace($Check_AdminUser_4, '[', '')
						$Check_AdminUser_4 = StringReplace($Check_AdminUser_4, ']', '')
						$Check_AdminUser_4 = StringReplace($Check_AdminUser_4, '"', '')
						$Check_AdminUser_4 = StringReplace($Check_AdminUser_4, ' ', '')
					EndIf

					If $Check_AdminUsers[0] > 5 Then
						$Check_AdminUser_5 = StringReplace($Check_AdminUser_5, '[', '')
						$Check_AdminUser_5 = StringReplace($Check_AdminUser_5, ']', '')
						$Check_AdminUser_5 = StringReplace($Check_AdminUser_5, '"', '')
						$Check_AdminUser_5 = StringReplace($Check_AdminUser_5, ' ', '')
					EndIf

					$Value_httpApi_GroupAdminUser_Name_1 = $Check_AdminUser_1
					$Value_httpApi_GroupAdminUser_Name_2 = $Check_AdminUser_2
					$Value_httpApi_GroupAdminUser_Name_3 = $Check_AdminUser_3
					$Value_httpApi_GroupAdminUser_Name_4 = $Check_AdminUser_4
					$Value_httpApi_GroupAdminUser_Name_5 = $Check_AdminUser_5
					If $Value_httpApi_GroupAdminUser_Name_1 <> "" Then IniWrite($config_ini, "Server_Einstellungen", "Group_Admin_1", $Value_httpApi_GroupAdminUser_Name_1)
					If $Value_httpApi_GroupAdminUser_Name_2 <> "" Then IniWrite($config_ini, "Server_Einstellungen", "Group_Admin_2", $Value_httpApi_GroupAdminUser_Name_2)
					If $Value_httpApi_GroupAdminUser_Name_3 <> "" Then IniWrite($config_ini, "Server_Einstellungen", "Group_Admin_3", $Value_httpApi_GroupAdminUser_Name_3)
					If $Value_httpApi_GroupAdminUser_Name_4 <> "" Then IniWrite($config_ini, "Server_Einstellungen", "Group_Admin_4", $Value_httpApi_GroupAdminUser_Name_4)
					If $Value_httpApi_GroupAdminUser_Name_5 <> "" Then IniWrite($config_ini, "Server_Einstellungen", "Group_Admin_5", $Value_httpApi_GroupAdminUser_Name_5)
				EndIf

			EndIf


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'allowEmptyJoin : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'allowEmptyJoin : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_allowEmptyJoin = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "allowEmptyJoin", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'controlGameSetup : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, 'controlGameSetup : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_controlGameSetup = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "controlGameSetup", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsTrack" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "ServerControlsTrack" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_ServerControlsTrack = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "ServerControlsTrack", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsVehicleClass" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "ServerControlsVehicleClass" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_ServerControlsVehicleClass = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "ServerControlsVehicleClass", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsVehicle" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "ServerControlsVehicle" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_ServerControlsVehicle = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "ServerControlsVehicle", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "GridSize" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "GridSize" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				$Wert_GridSize = $Wert_Line
				IniWrite($config_ini, "Server_Einstellungen", "GridSize", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "MaxPlayers" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "MaxPlayers" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "MaxPlayers", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "Practice1Length" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "Practice1Length" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "Practice1Length", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "Practice2Length" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "Practice2Length" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "Practice2Length", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "QualifyLength" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "QualifyLength" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "QualifyLength", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "WarmupLength" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "WarmupLength" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "WarmupLength", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "Race1Length" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "Race1Length" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "Race1Length", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "Flags" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "Flags" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "Flags", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DamageType" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "DamageType" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "DamageType", $Wert_Line)
			EndIf


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "TireWearType" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "TireWearType" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "TireWearType", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "FuelUsageType" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "FuelUsageType" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "FuelUsageType", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "PenaltiesType" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "PenaltiesType" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "PenaltiesType", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "AllowedViews" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "AllowedViews" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "AllowedViews", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "TrackId" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "TrackId" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "TrackId", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "VehicleClassId" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "VehicleClassId" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "VehicleClassId", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "VehicleModelId" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "VehicleModelId" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "VehicleModelId", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DateYear" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "DateYear" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "DateYear", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DateMonth" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "DateMonth" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "DateMonth", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DateDay" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "DateDay" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "DateDay", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DateHour" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "DateHour" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "DateHour", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DateMinute" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "DateMinute" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "DateMinute", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DateProgression" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "DateProgression" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "DateProgression", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ForecastProgression" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "ForecastProgression" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "ForecastProgression", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "WeatherSlots" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "WeatherSlots" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "WeatherSlots", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "WeatherSlot1" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "WeatherSlot1" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "WeatherSlot1", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "WeatherSlot2" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "WeatherSlot2" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "WeatherSlot2", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "WeatherSlot3" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "WeatherSlot3" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "WeatherSlot3", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "WeatherSlot1" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = StringReplace($Wert_Line, '    "WeatherSlot1" : ', '')
				$Wert_Line = StringReplace($Wert_Line, '"', '')
				$Wert_Line = StringReplace($Wert_Line, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "WeatherSlot1", $Wert_Line)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'blackList : [ "blackList.cfg" ]')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = "true"
				IniWrite($config_ini, "Server_Einstellungen", "Blacklist", $Wert_Line)
				IniWrite($config_ini, "Server_Einstellungen", "Whitelist", "false")
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'whiteList : [ "whiteList.cfg" ]')
			If $StringInStr_Check_1 <> 0 Then
				$Wert_Line = "true"
				IniWrite($config_ini, "Server_Einstellungen", "whiteList", $Wert_Line)
				IniWrite($config_ini, "Server_Einstellungen", "Blacklist", "false")
			EndIf
		Next
	EndIf
EndFunc



Func _config_cfg_erstellen__Backup()
	$Dedi_config_whiteList_cfg = $Dedi_Verzeichnis & "\whiteList.cfg"
	$Dedi_config_blackList_cfg = $Dedi_Verzeichnis & "\blackList.cfg"

	;$Lesen_Auswahl_loglevel = GUICtrlRead($Auswahl_Sprachdatei)
	$Lesen_Auswahl_eventsLogSize = GUICtrlRead($Auswaehlen_eventsLogSize)
	$Lesen_Auswahl_name = GUICtrlRead($Eingabe_name)
	$Lesen_Auswahl_secure = GUICtrlRead($Auswahl_secure)
	$Lesen_Auswahl_password = GUICtrlRead($Eingabe_password)
	$Lesen_Auswahl_maxPlayerCount = GUICtrlRead($Auswaehlen_maxPlayerCount)
	;$Lesen_Auswahl_bindIP = GUICtrlRead($Eingabe_bindIP)
	$Lesen_Auswahl_steamPort = GUICtrlRead($Auswaehlen_steamPort)
	$Lesen_Auswahl_hostPort = GUICtrlRead($Auswaehlen_hostPort)
	$Lesen_Auswahl_queryPort = GUICtrlRead($Auswaehlen_queryPort)
	$Lesen_Auswahl_enableHttpApi = GUICtrlRead($Auswahl_enableHttpApi)
	;$Lesen_Auswahl_httpApiLogLevel = GUICtrlRead($Auswahl_httpApiLogLevel)
	$Lesen_Auswahl_httpApiInterface = GUICtrlRead($Eingabe_httpApiInterface)
	$Lesen_Auswahl_httpApiPort = GUICtrlRead($Auswaehlen_httpApiPort)
	$Lesen_Auswahl_whitelist = GUICtrlRead($Auswahl_Whitelist)
	$Lesen_Auswahl_blacklist = GUICtrlRead($Auswahl_Blacklist)

	$Lesen_Auswahl_allowEmptyJoin = GUICtrlRead($Auswahl_allowEmptyJoin)
	$Lesen_Auswahl_controlGameSetup = GUICtrlRead($Auswahl_controlGameSetup)

	$Lesen_Auswahl_ServerControlsTrack = GUICtrlRead($Auswahl_ServerControlsTrack)
		If $Lesen_Auswahl_ServerControlsTrack = "true" Then $Lesen_Auswahl_ServerControlsTrack = "1"
		If $Lesen_Auswahl_ServerControlsTrack <> "true" Then $Lesen_Auswahl_ServerControlsTrack = "0"
	$Lesen_Auswahl_ServerControlsVehicleClass = GUICtrlRead($Auswahl_ServerControlsVehicleClass)
		If $Lesen_Auswahl_ServerControlsVehicleClass = "true" Then $Lesen_Auswahl_ServerControlsVehicleClass = "1"
		If $Lesen_Auswahl_ServerControlsVehicleClass <> "true" Then $Lesen_Auswahl_ServerControlsVehicleClass = "0"

	Global $FirstLine_Check

	Global $Write_FirstLine = "false"

	If FileExists($Dedi_config_cfg) Then
		$Server_CFG_Array = FileReadToArray($Dedi_config_cfg)
		$NR_Lines_config_cfg = _FileCountLines($Dedi_config_cfg) - 1
		$FirstLine_Check = FileReadLine($Dedi_config_cfg, 1)
		If $FirstLine_Check = "eventsLogSize : 10000" Then $Write_FirstLine = "true"
	EndIf

	If FileExists($Dedi_config_cfg) Then
		$EmptyFile = FileOpen($Dedi_config_cfg, 2)
		FileWrite($EmptyFile, "")
		FileClose($EmptyFile)
	EndIf

	If $Write_FirstLine = "true" Then
		FileWriteLine($Dedi_config_cfg, "// : You can use dummy entries like this to write comments into the config. " & '"rem"' & ' and ' & '"#"' & " are also supported as comment entries.")
		FileWriteLine($Dedi_config_cfg, "// But in recent version of the server, standard C++ like one-liner comments are supported as well.")
		FileWriteLine($Dedi_config_cfg, " ")
		FileWriteLine($Dedi_config_cfg, "//////////////////////////")
		FileWriteLine($Dedi_config_cfg, "// Basic server options //")
		FileWriteLine($Dedi_config_cfg, "//////////////////////////")
		FileWriteLine($Dedi_config_cfg, " ")
		FileWriteLine($Dedi_config_cfg, "// Logging level of the server. Messages of this severity and more important will be logged. Can be any of debug/info/warning/error.")
		FileWriteLine($Dedi_config_cfg, 'logLevel : "info"')
		FileWriteLine($Dedi_config_cfg, " ")
		FileWriteLine($Dedi_config_cfg, "// Number of gameplay events stored on the server. Oldest ones will be discarded once the game logs more.")
	EndIf

	$Status_Checkbox_PCDSG_settings_8 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_8", "")
	$Status_Checkbox_PCDSG_settings_9 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_9", "")

	Local $PCDSG_IP = @IPAddress1

	If $Status_Checkbox_PCDSG_settings_8 = "true" Then
		$PCDSG_IP = @IPAddress1
		If $PCDSG_IP = "0.0.0.0" Then $PCDSG_IP = @IPAddress2
		If $PCDSG_IP = "0.0.0.0" Then $PCDSG_IP = @IPAddress3
		If $PCDSG_IP = "0.0.0.0" Then $PCDSG_IP = @IPAddress4

		If $PCDSG_Network_Card_IP <> "" Then
			If $PCDSG_Network_Card_IP = "1" Then $PCDSG_IP = @IPAddress1
			If $PCDSG_Network_Card_IP = "2" Then $PCDSG_IP = @IPAddress2
			If $PCDSG_Network_Card_IP = "3" Then $PCDSG_IP = @IPAddress3
			If $PCDSG_Network_Card_IP = "4" Then $PCDSG_IP = @IPAddress4
			If $PCDSG_Network_Card_IP = "" Then $PCDSG_IP = @IPAddress1
		EndIf
	EndIf

	If $Status_Checkbox_PCDSG_settings_9 = "true" Then
			$PCDSG_IP = _GetIP()
	EndIf

	For $Schleife_2 = 0 To $NR_Lines_config_cfg ; 55
		If $Server_CFG_Array[$Schleife_2] <> 'blackList : [ "blackList.cfg" ]' Then
			If $Server_CFG_Array[$Schleife_2] <> 'whiteList : [ "whitelist.cfg" ]' Then
				$Wert_Line = $Server_CFG_Array[$Schleife_2]
				$Check_Line = StringSplit($Wert_Line, ':', $Server_CFG_Array[$Schleife_2])
				If IsArray($Check_Line) Then $Check_Line_1 = $Check_Line[1]

				If $Check_Line_1 = 'logLevel ' Then $Wert_Line = 'logLevel : ' & '"' & $Lesen_Auswahl_loglevel & '"'
				If $Check_Line_1 = 'eventsLogSize ' Then $Wert_Line = 'eventsLogSize : ' & $Lesen_Auswahl_eventsLogSize
				If $Check_Line_1 = 'name ' Then $Wert_Line = 'name : ' & '"' & $Lesen_Auswahl_name & '"'
				If $Check_Line_1 = 'secure ' Then $Wert_Line = 'secure : ' & $Lesen_Auswahl_secure
				If $Check_Line_1 = 'password ' Then $Wert_Line = 'password : ' & '"' & $Lesen_Auswahl_password & '"'
				If $Check_Line_1 = 'maxPlayerCount ' Then $Wert_Line = 'maxPlayerCount : ' & $Lesen_Auswahl_maxPlayerCount
				If $Check_Line_1 = 'bindIP ' Then $Wert_Line = 'bindIP : ' & '"' & $Lesen_Auswahl_bindIP & '"'
				If $Check_Line_1 = 'steamPort ' Then $Wert_Line = 'steamPort : ' & $Lesen_Auswahl_steamPort
				If $Check_Line_1 = 'hostPort ' Then $Wert_Line = 'hostPort : ' & $Lesen_Auswahl_hostPort
				If $Check_Line_1 = 'queryPort ' Then $Wert_Line = 'queryPort : ' & $Lesen_Auswahl_queryPort
				If $Check_Line_1 = 'sleepWaiting ' Then $Wert_Line = 'sleepWaiting : ' & $Lesen_Auswahl_sleepWaiting
				If $Check_Line_1 = 'sleepWaiting ' Then $Wert_Line = 'sleepWaiting : ' & $Lesen_Auswahl_sleepWaiting
				If $Check_Line_1 = 'sleepActive ' Then $Wert_Line = 'sleepActive : ' & $Lesen_Auswahl_sleepActive
				If $Check_Line_1 = 'enableHttpApi ' Then $Wert_Line = 'enableHttpApi : ' & $Lesen_Auswahl_enableHttpApi
				If $Check_Line_1 = 'httpApiLogLevel ' Then $Wert_Line = 'httpApiLogLevel : ' & '"' & $Lesen_Auswahl_httpApiLogLevel & '"'
				If $Check_Line_1 = 'httpApiInterface ' Then $Wert_Line = 'httpApiInterface : ' & '"' & $Lesen_Auswahl_httpApiInterface & '"'
				If $Check_Line_1 = 'httpApiPort ' Then $Wert_Line = 'httpApiPort : ' & $Lesen_Auswahl_httpApiPort
				If $Check_Line_1 = 'allowEmptyJoin ' Then $Wert_Line = 'allowEmptyJoin : ' & $Lesen_Auswahl_allowEmptyJoin
				If $Check_Line_1 = 'controlGameSetup ' Then $Wert_Line = 'controlGameSetup : ' & $Lesen_Auswahl_controlGameSetup

				If $Check_Line_1 = '    "ServerControlsTrack" ' Then $Wert_Line = '    "ServerControlsTrack" : ' & $Lesen_Auswahl_ServerControlsTrack & ','
				If $Check_Line_1 = '    "ServerControlsVehicleClass" ' Then $Wert_Line = '    "ServerControlsVehicleClass" : ' & $Lesen_Auswahl_ServerControlsVehicleClass & ','

				If $Check_Line_1 = '        { "type" ' Then
					If $Check_Line[2] = ' "ip-accept", "ip" ' Then $Wert_Line = $Check_Line[1] & ':' & ' "ip-accept", "ip" : "' & $PCDSG_IP & '/32" ' & '}' & ','
				EndIf

				If $Schleife_2 <> $NR_Lines_config_cfg - 1 Then
					FileWriteLine($Dedi_config_cfg, $Wert_Line)
				EndIf
			EndIf
		EndIf
	Next

	FileWriteLine($Dedi_config_cfg, "")

	If $Lesen_Auswahl_whitelist = "true" Then FileWriteLine($Dedi_config_cfg, 'whiteList : [ "whiteList.cfg" ]')
	If $Lesen_Auswahl_blacklist = "true" Then FileWriteLine($Dedi_config_cfg, 'blackList : [ "blackList.cfg" ]')

	$Dedi_config_whiteList_cfg = @ScriptDir & "\whiteList.cfg"
	$Dedi_config_blackList_cfg = @ScriptDir & "\blackList.cfg"

	;FileCopy($Dedi_Installations_Verzeichnis & "server.cfg", $install_dir & "server.cfg", $FC_OVERWRITE)
	FileCopy($Dedi_config_whiteList_cfg, $Dedi_Verzeichnis & "whiteList.cfg", $FC_OVERWRITE)
	FileCopy($Dedi_config_blackList_cfg, $Dedi_Verzeichnis & "blackList.cfg", $FC_OVERWRITE)

	FileWriteLine($PCDSG_LOG_ini, "Server_cfg_created_" & $NowTime & "=" & "New Server.cfg File created and saved to: " & $Dedi_Installations_Verzeichnis & "server.cfg" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
	FileWriteLine($PCDSG_LOG_ini, "Server_cfg_copied_" & $NowTime & "=" & "Server.cfg File copied to: " & $install_dir & "server.cfg" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
	FileWriteLine($PCDSG_LOG_ini, "whiteList_copied_" & $NowTime & "=" & "WhiteList File copied to: " & $Dedi_Verzeichnis & "whiteList.cfg" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
	FileWriteLine($PCDSG_LOG_ini, "BlackList_cfg_copied_" & $NowTime & "=" & "BlackList File copied to: " & $Dedi_Verzeichnis & "blackList.cfg" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
EndFunc

Func _config_cfg_erstellen()
	_Preparing_Data_GUI()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 10)

	Local $Dedi_config_whiteList_cfg_Path = $Dedi_Verzeichnis & "\whiteList.cfg"
	Local $Dedi_config_blackList_cfg_Path = $Dedi_Verzeichnis & "\blackList.cfg"

	$Value_Read_eventsLogSize = GUICtrlRead($Auswaehlen_eventsLogSize)
	$Value_Read_name = GUICtrlRead($Eingabe_name)
	$Value_Read_secure = GUICtrlRead($Auswahl_secure)

	$Value_Read_password = GUICtrlRead($Eingabe_password)
	$Value_Read_maxPlayerCount = GUICtrlRead($Auswaehlen_maxPlayerCount)
	$Value_Read_steamPort = GUICtrlRead($Auswaehlen_steamPort)
	$Value_Read_hostPort = GUICtrlRead($Auswaehlen_hostPort)
	$Value_Read_queryPort = GUICtrlRead($Auswaehlen_queryPort)

	$Value_Read_enableHttpApi = GUICtrlRead($Auswahl_enableHttpApi)
	$Value_Read_httpApiInterface = GUICtrlRead($Eingabe_httpApiInterface)
	$Value_Read_httpApiPort = GUICtrlRead($Auswaehlen_httpApiPort)
	$Value_Read_allowEmptyJoin = GUICtrlRead($Auswahl_allowEmptyJoin)
	$Value_Read_controlGameSetup = GUICtrlRead($Auswahl_controlGameSetup)
	$Value_Read_ServerControlsTrack = GUICtrlRead($Auswahl_ServerControlsTrack)
		If $Value_Read_ServerControlsTrack = "true" Then $Value_Read_ServerControlsTrack = "1"
		If $Value_Read_ServerControlsTrack <> "true" Then $Value_Read_ServerControlsTrack = "0"
	$Value_Read_ServerControlsVehicleClass = GUICtrlRead($Auswahl_ServerControlsVehicleClass)
		If $Value_Read_ServerControlsVehicleClass = "true" Then $Value_Read_ServerControlsVehicleClass = "1"
		If $Value_Read_ServerControlsVehicleClass <> "true" Then $Value_Read_ServerControlsVehicleClass = "0"
	$Value_Read_ServerControlsVehicle = GUICtrlRead($Auswahl_ServerControlsVehicle)
		If $Value_Read_ServerControlsVehicle = "true" Then $Value_Read_ServerControlsVehicle = "1"
		If $Value_Read_ServerControlsVehicle <> "true" Then $Value_Read_ServerControlsVehicle = "0"

	$Value_Read_GridSize = GUICtrlRead($Auswaehlen_GridSize)

	$Value_Read_DS_Domain_IP = GUICtrlRead($Eingabe_DS_Domain_or_IP)

	$Value_Read_whitelist = GUICtrlRead($Auswahl_Whitelist)
	$Value_Read_blacklist = GUICtrlRead($Auswahl_Blacklist)


	If FileExists($Dedi_config_cfg) Then
		$Server_CFG_Array = FileReadToArray($Dedi_config_cfg)
		$NR_Lines_config_cfg = _FileCountLines($Dedi_config_cfg) - 1

		$EmptyFile = FileOpen($Dedi_config_cfg, 2)
		FileWrite($EmptyFile, "")
		FileClose($EmptyFile)

		For $Schleife_2 = 0 To $NR_Lines_config_cfg
			Local $Value_ProgressBar = $Schleife_2 * 100 / $NR_Lines_config_cfg
			GUICtrlSetData($Anzeige_Fortschrittbalken, $Value_ProgressBar)
			GUICtrlSetData($Anzeige_Fortschrittbalken, $Value_ProgressBar)
			$Wert_Line = $Server_CFG_Array[$Schleife_2]

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'eventsLogSize : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'eventsLogSize : ' & $Value_Read_eventsLogSize & ''

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'name : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'name : "' & $Value_Read_name & '"'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'secure : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'secure : ' & $Value_Read_secure & ''

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'password : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'password : "' & $Value_Read_password & '"'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'maxPlayerCount : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'maxPlayerCount : ' & $Value_Read_maxPlayerCount & ''

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'steamPort : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'steamPort : ' & $Value_Read_steamPort & ''

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'hostPort : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'hostPort : ' & $Value_Read_hostPort & ''

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'queryPort : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'queryPort : ' & $Value_Read_queryPort & ''

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'enableHttpApi : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'enableHttpApi : ' & $Value_Read_enableHttpApi & ''

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'httpApiInterface : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'httpApiInterface : "' & $Value_Read_httpApiInterface & '"'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'httpApiPort : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'httpApiPort : ' & $Value_Read_httpApiPort & ''

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'allowEmptyJoin : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'allowEmptyJoin : ' & $Value_Read_allowEmptyJoin & ''

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'controlGameSetup : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'controlGameSetup : ' & $Value_Read_controlGameSetup & ''

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsTrack" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "ServerControlsTrack" : ' & $Value_Read_ServerControlsTrack & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsVehicleClass" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "ServerControlsVehicleClass" : ' & $Value_Read_ServerControlsVehicleClass & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsVehicle" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "ServerControlsVehicle" : ' & $Value_Read_ServerControlsVehicle & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "GridSize" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "GridSize" : ' & $Value_Read_GridSize & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "MaxPlayers" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "MaxPlayers" : ' & $Value_Read_maxPlayerCount & ','


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'blackList : [ "blackList.cfg" ]')
			If $StringInStr_Check_1 <> 0 Then
				If $Value_Read_whitelist = "true" Then
					$Wert_Line = 'whiteList : [ "whiteList.cfg" ]'
				Else
					If $Value_Read_blacklist = "true" Then
						$Wert_Line = 'blackList : [ "blackList.cfg" ]'
					Else
						$Wert_Line = '// blackList : [ "blackList.cfg" ]'
					EndIf
				EndIf
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'whiteList : [ "whiteList.cfg" ]')
			If $StringInStr_Check_1 <> 0 Then
				If $Value_Read_whitelist = "true" Then
					$Wert_Line = 'whiteList : [ "whiteList.cfg" ]'
				Else
					If $Value_Read_blacklist = "true" Then
						$Wert_Line = 'blackList : [ "blackList.cfg" ]'
					Else
						$Wert_Line = '// blackList : [ "blackList.cfg" ]'
					EndIf
				EndIf
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '// blackList : [ "blackList.cfg" ]')
			If $StringInStr_Check_1 <> 0 Then
				If $Value_Read_whitelist = "true" Then
					$Wert_Line = 'whiteList : [ "whiteList.cfg" ]'
				Else
					If $Value_Read_blacklist = "true" Then
						$Wert_Line = 'blackList : [ "blackList.cfg" ]'
					Else
						$Wert_Line = '// blackList : [ "blackList.cfg" ]'
					EndIf
				EndIf
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '// whiteList : [ "whiteList.cfg" ]')
			If $StringInStr_Check_1 <> 0 Then
				If $Value_Read_whitelist = "true" Then
					$Wert_Line = 'whiteList : [ "whiteList.cfg" ]'
				Else
					If $Value_Read_blacklist = "true" Then
						$Wert_Line = 'blackList : [ "blackList.cfg" ]'
					Else
						$Wert_Line = '// blackList : [ "blackList.cfg" ]'
					EndIf
				EndIf
			EndIf

			FileWriteLine($Dedi_config_cfg, $Wert_Line)
		Next
	EndIf

	Sleep(700)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
	GUIDelete($GUI_Loading)
EndFunc





Func _LUA_erstellen()
	;DirCopy($Dedi_Installations_Verzeichnis & "Templates\lua\", $install_dir & "lua\", $FC_OVERWRITE)
	;DirCopy($Dedi_Installations_Verzeichnis & "Templates\lua_config\", $install_dir & "lua_config\", $FC_OVERWRITE)
	DirCopy($install_dir & "Templates\lua\", $Dedi_Installations_Verzeichnis & "\lua\", $FC_OVERWRITE)
	DirCopy($install_dir & "Templates\lua_config\", $Dedi_Installations_Verzeichnis & "\lua_config\", $FC_OVERWRITE)
	FileWriteLine($PCDSG_LOG_ini, "LUA_copied_" & $NowTime & "=" & "LUA Files copied to: " & $install_dir & "lua\" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
	FileWriteLine($PCDSG_LOG_ini, "LUA_config_copied_" & $NowTime & "=" & "LUA config copied to: " & $install_dir & "lua_config\" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
EndFunc


Func _Delete_DS_StartUp_Files()
	If FileExists($LOG_Data_INI) Then
		FileDelete($LOG_Data_INI)
		FileWriteLine($Info_drivers_AT_ini, '[DATA]')
		FileWriteLine($Info_drivers_AT_ini, 'NR=0')
	EndIf
EndFunc


Func StartUp_settings()
	IniWrite($config_ini, "PC_Server", "Checkbox_PCDSG_settings_5", "false")

    Local $hGUI = GUICreate("PCDSG Startup settings", 400, 190, -1, -1, $WS_EX_TOPMOST)
	GUISetIcon(@AutoItExe, -2, $hGUI)
    GUISetState(@SW_SHOW, $hGUI)

	MsgBox($MB_OK + $MB_ICONINFORMATION, "Steam Dedicated Server folder", "Choose the local folder where the Steam Dedicated Server app is installed.")

	Global $font_StartUp_arial = "arial"

	GUICtrlCreateLabel("Choose Steam Dedicated Server folder.", 5, 5, 395, 20)
		GUICtrlSetFont(-1, 12, 600, 6, $font_StartUp_arial)

	_StartUp_Radio_1()

    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                ExitLoop
        EndSwitch
    WEnd

	Global $hChild

    GUIDelete($hGUI)
    GUIDelete($hChild)
EndFunc

Func _StartUp_Radio_1()
	$Auswahl_Verzeichnis = FileSelectFolder("Choose Steam DS folder:", "")

	If $Auswahl_Verzeichnis <> "" Then
		IniWrite($config_ini, "PC_Server", "DS_Mode", "local")
		IniWrite($config_ini, "Einstellungen", "Dedi_Installations_Verzeichnis", $Auswahl_Verzeichnis & "\")

		IniWrite($config_ini, "PC_Server", "DS_PublicIP", "")
		IniWrite($config_ini, "PC_Server", "DS_API_Port", "")

		IniWrite($config_ini, "Server_Einstellungen", "httpApiInterface", "localhost") ; 127.0.0.1
		IniWrite($config_ini, "Server_Einstellungen", "httpApiPort", "9000")

		GUICtrlCreateLabel($Auswahl_Verzeichnis & "\", 5, 25, 395, 40)
	EndIf

	Sleep(1000)
	_StartUp_Radio_2()
EndFunc

Func _StartUp_Radio_2()
	GUICtrlCreateLabel("Language File:", 5, 60, 160, 20)
	GUICtrlSetFont(-1, 12, 600, 6, $font_StartUp_arial)

	Local $Wert_Auswahl_Sprachdatei = $Sprachdatei_folder & "EN - English.ini"
	Local $Dateiname_Sprachdatei = StringMid($Wert_Auswahl_Sprachdatei, StringInStr($Wert_Auswahl_Sprachdatei, '\', 2, -1) + 1)
	$Dateiname_Sprachdatei = StringTrimRight($Dateiname_Sprachdatei, 4 )
	Global $Auswahl_Sprachdatei = GUICtrlCreateCombo("", 5, 85, 100, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetOnEvent($Auswahl_Sprachdatei, "_StartUp_Auswahl_Sprachdatei")

	Local $aFileList = _FileListToArray($Sprachdatei_folder, "*")
	Local $iRows = UBound($aFileList, $UBOUND_ROWS) - 1

	$Sprachdatei_data = ""

	For $language_loop = 1 To $iRows
		$Language_Name = StringReplace($aFileList[$language_loop], ".ini", "")
		$Sprachdatei_data = $Sprachdatei_data & $Language_Name & "|"
	Next

	GUICtrlSetData($Auswahl_Sprachdatei, $Sprachdatei_data, $Dateiname_Sprachdatei)
	Sleep(1000)
	_Complete_StartUp_Button()
EndFunc

Func _Complete_StartUp_Button()
	Local $StartUp_Next_Button = GUICtrlCreateButton("Complete StartUp, Start PCDSG", 5, 120, 385, 30)
	GUICtrlSetFont(-1, 12, 600, 2, $font_StartUp_arial)
	GUICtrlSetColor(-1, "0x006600")
	GUICtrlSetOnEvent($StartUp_Next_Button, "_StartUp_New_ServerCFG")
EndFunc

Func _StartUp_Auswahl_Sprachdatei()
	$Auswahl_Einstellung_Sprachdatei = GUICtrlRead($Auswahl_Sprachdatei)
	$Auswahl_Einstellung_Sprachdatei = $Sprachdatei_folder & $Auswahl_Einstellung_Sprachdatei & ".ini"
	IniWrite($config_ini, "Einstellungen", "Sprachdatei", $Auswahl_Einstellung_Sprachdatei)
EndFunc



Func _StartUp_New_ServerCFG()
	$Abfrage = MsgBox(4, "Server.cfg", "Do you want to use a NEW clean server.cfg File?" & @CRLF & @CRLF & "This will overwrite your existing File but avoid errors due to server.cfg values not been read or written correctly.")

	If $Abfrage = 6 Then
		$Dedi_Installations_Verzeichnis = IniRead($config_ini, "Einstellungen", "Dedi_Installations_Verzeichnis", "")
		$Dedi_configCFG_sample = $install_dir & "Templates\config\server.cfg"
		FileCopy($Dedi_configCFG_sample, $Dedi_Installations_Verzeichnis & "server.cfg", $FC_OVERWRITE)
		FileCopy($Dedi_configCFG_sample, $install_dir & "server.cfg", $FC_OVERWRITE)
	EndIf

	$Abfrage = MsgBox(4, "LUA config Files", "Do you want to use NEW and clean LUA config Files?" & @CRLF & @CRLF & "This will overwrite your existing Files but avoid errors due to LUA config Files values not been read or written correctly.")

	If $Abfrage = 6 Then
		_LUA_erstellen()
	EndIf

	_StartUp_Exit()
EndFunc

Func _StartUp_Autostart_Check()
	$Checkbox_PCDSG_settings_1 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_1", "")
	$Checkbox_PCDSG_settings_2 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_2", "")
	$Checkbox_PCDSG_settings_3 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_3", "")
	$Checkbox_PCDSG_settings_4 = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_settings_4", "")

	If $Checkbox_PCDSG_settings_1 = "true" Then
		_PC_Server_starten()
		;Sleep(3000)
		_Hide_Windows()
	EndIf

	If $Checkbox_PCDSG_settings_2 = "true" Then
		_TAB_1_Button4()
		Sleep(1000)
	EndIf

	If $Checkbox_PCDSG_settings_3 = "true" Then
		_TAB_1_Button10()
		Sleep(1000)
	EndIf

	If $Checkbox_PCDSG_settings_4 = "true" Then
		_TAB_1_Button9()
		Sleep(1000)
	EndIf
EndFunc

Func _StartUp_Exit()
	If FileExists($install_dir & "PCDSG.exe") Then
		ShellExecute($install_dir & "PCDSG.exe")
	Else
		ShellExecute($install_dir & "PCDSG.au3")
	EndIf

	Exit
EndFunc

Func _CFG_FTP_Upload()
	;Local $DS_Server_CFG = $Dedi_Installations_Verzeichnis & "server.cfg"

	Local $FTP_Username = IniRead($config_ini, "FTP", "FTP_Username", "")
	Local $FTP_Passwort = IniRead($config_ini, "FTP", "FTP_Password", "")
	Local $FTP_Server_Name_IP = IniRead($config_ini, "FTP", "FTP_Server_Name_IP", "")
	Local $FTP_Port = IniRead($config_ini, "FTP", "FTP_Port", "")
	Local $FTP_Passive= IniRead($config_ini, "FTP", "FTP_Passive", "")

	Local $FTP_Upload_DS_Path = IniRead($config_ini, "PC_Server", "FTP_Upload_DS_Path", "")
	Local $FTP_Upload_FTP_LUA_Config_Folder = IniRead($config_ini, "PC_Server", "FTP_Upload_FTP_LUA_Config_Folder", "")
	Local $FTP_Upload_Stats_Results = IniRead($config_ini, "PC_Server", "FTP_Upload_Stats_Results", "")

	Local $FTP_DS_Path= IniRead($config_ini, "FTP", "FTP_DS_Path", "")
	Local $FTP_LUA_Config_Folder= IniRead($config_ini, "FTP", "FTP_LUA_Config_Folder", "")
	;Local $FTP_Stats_Results_Folder= IniRead($config_ini, "FTP", "FTP_Stats_Results_Folder", "")

	Sleep(100)

	;Local $Datum = @YEAR & "-" & @MON & "-" & @MDAY

	If $FTP_Passwort = "" Then
		Local $FTP_Password = InputBox ( "Enter FTP Password", "Enter FTP Password to confirm FTP File Upload.")
	Else
		Local $FTP_Password = $FTP_Passwort
	EndIf






	Local $l_InternetSession = _FTP_Open('AuoItZilla')
	Local $errOpen = @error
	If Not @error Then
		Local $l_FTPSession = _FTP_Connect($l_InternetSession, $FTP_Server_Name_IP, $FTP_Username, $FTP_Password, $FTP_Passive)
		Local $errOpen = @error
		If Not @error Then
			For $Loop = 1 To 2
				If $Loop = 1 Then
					Local $LocalFolder = $Dedi_Installations_Verzeichnis
					Local $Zielordner = $FTP_DS_Path
					Local $TargetFile_1 = "server.cfg"
					Local $TargetFile_2 = "blackList.cfg"
					Local $TargetFile_3 = "whiteList.cfg"
				EndIf
				If $Loop = 2 Then
					Local $LocalFolder = $Dedi_Installations_Verzeichnis & "lua_config\"
					Local $Zielordner = $FTP_LUA_Config_Folder
					Local $TargetFile_1 = "sms_rotate_config.json"
					Local $TargetFile_2 = ""
					Local $TargetFile_3 = ""
				EndIf

				Local $FileList = _FileListToArray($LocalFolder , "*.cfg" , 1)
				_FTP_DirSetCurrent($l_FTPSession, $Zielordner)

				If $FileList <> "" Then
					For $NR = 1 To $FileList[0]
						Local $RemoteFile = $Zielordner & $FileList[$NR]

						$l_FTPSession = _FTP_Connect($l_InternetSession, $FTP_Server_Name_IP, $FTP_Username, $FTP_Password, $FTP_Passive)
						Local $errFTP = @error
						If Not @error Then
							If $TargetFile_1 <> "" Then
								If $FileList[$NR] = $TargetFile_1 Then
									If _FTP_FilePut($l_FTPSession, $LocalFolder & $FileList[$NR], $RemoteFile) Then
										MsgBox(0, "FTP Upload finished", "server.cfg Upload: successfully", 2)
									Else
										MsgBox(0, "FTP Upload finished", "server.cfg Upload: Failed", 5)
										ExitLoop
									EndIf
								EndIf
							EndIf
							If $TargetFile_2 <> "" Then
								If $FileList[$NR] = $TargetFile_2 Then
									If _FTP_FilePut($l_FTPSession, $LocalFolder & $FileList[$NR], $RemoteFile) Then
										MsgBox(0, "FTP Upload finished", "blackList.cfg Upload: successfully", 2)
									Else
										MsgBox(0, "FTP Upload finished", "blackList.cfg Upload: Failed", 5)
										ExitLoop
									EndIf
								EndIf
							EndIf
							If $TargetFile_3 <> "" Then
								If $FileList[$NR] = $TargetFile_3 Then
									If _FTP_FilePut($l_FTPSession, $LocalFolder & $FileList[$NR], $RemoteFile) Then
										MsgBox(0, "FTP Upload finished", "whiteList.cfg Upload: successfully", 2)
									Else
										MsgBox(0, "FTP Upload finished", "whiteList.cfg Upload: Failed", 5)
										ExitLoop
									EndIf
								EndIf
							EndIf
						Else
							MsgBox(0, "FTP 'Connect'", "Failed", 10)
							$Loop = 2
							ExitLoop
						EndIf
					Next
				Else
					If $FileList = "" Then MsgBox(0, "", "Files not found...", 5)
				EndIf
			Next
			_FTP_Close($l_InternetSession) ;schliesst die FTP-Sitzng
			Sleep(500)
		Else
			MsgBox(0, "FTP 'Connect'", "Failed", 10)
		EndIf
	Else
		MsgBox(0, "FTP 'Open'", "Failed", 10)
	EndIf
EndFunc

Func _FTP_Upload()
	;Local $DS_Server_CFG = $Dedi_Installations_Verzeichnis & "server.cfg"

	Local $FTP_Username = IniRead($config_ini, "FTP", "FTP_Username", "")
	Local $FTP_Passwort = IniRead($config_ini, "FTP", "FTP_Password", "")
	Local $FTP_Server_Name_IP = IniRead($config_ini, "FTP", "FTP_Server_Name_IP", "")
	Local $FTP_Port = IniRead($config_ini, "FTP", "FTP_Port", "")
	Local $FTP_Passive= IniRead($config_ini, "FTP", "FTP_Passive", "")

	Local $FTP_Upload_DS_Path = IniRead($config_ini, "PC_Server", "FTP_Upload_DS_Path", "")
	Local $FTP_Upload_FTP_LUA_Config_Folder = IniRead($config_ini, "PC_Server", "FTP_Upload_FTP_LUA_Config_Folder", "")
	Local $FTP_Upload_Stats_Results = IniRead($config_ini, "PC_Server", "FTP_Upload_Stats_Results", "")

	Local $FTP_DS_Path= IniRead($config_ini, "FTP", "FTP_DS_Path", "")
	Local $FTP_LUA_Config_Folder= IniRead($config_ini, "FTP", "FTP_LUA_Config_Folder", "")
	;Local $FTP_Stats_Results_Folder= IniRead($config_ini, "FTP", "FTP_Stats_Results_Folder", "")

	Sleep(100)

	;Local $Datum = @YEAR & "-" & @MON & "-" & @MDAY

	If $FTP_Passwort = "" Then
		Local $FTP_Password = InputBox ( "Enter FTP Password", "Enter FTP Password to confirm FTP File Upload.")
	Else
		Local $FTP_Password = $FTP_Passwort
	EndIf






	Local $l_InternetSession = _FTP_Open('AuoItZilla')
	Local $errOpen = @error
	If Not @error Then
		Local $l_FTPSession = _FTP_Connect($l_InternetSession, $FTP_Server_Name_IP, $FTP_Username, $FTP_Password, $FTP_Passive)
		Local $errOpen = @error
		If Not @error Then
			For $Loop = 1 To 2

				$Value_Progress = $Loop * 100 / 2
				GUICtrlSetData($Anzeige_Fortschrittbalken, $Value_Progress)

				If $Loop = 1 Then
					Local $LocalFolder = $Dedi_Installations_Verzeichnis
					Local $Zielordner = $FTP_DS_Path
					Local $TargetFile_1 = "server.cfg"
					Local $TargetFile_2 = "blackList.cfg"
					Local $TargetFile_3 = "whiteList.cfg"
				EndIf
				If $Loop = 2 Then
					Local $LocalFolder = $Dedi_Installations_Verzeichnis & "lua_config\"
					Local $Zielordner = $FTP_LUA_Config_Folder
					Local $TargetFile_1 = "sms_rotate_config.json"
					Local $TargetFile_2 = ""
					Local $TargetFile_3 = ""
				EndIf

				If $Loop = 1 Then Local $FileList = _FileListToArray($LocalFolder , "*.cfg" , 1)
				If $Loop = 2 Then Local $FileList = _FileListToArray($LocalFolder , "*.json" , 1)
				_FTP_DirSetCurrent($l_FTPSession, $Zielordner)

				If $FileList <> "" Then
					For $NR = 1 To $FileList[0]
						;MsgBox(0, "$FileList[$NR]", $FileList[$NR])
						Local $RemoteFile = $Zielordner & $FileList[$NR]

						$l_FTPSession = _FTP_Connect($l_InternetSession, $FTP_Server_Name_IP, $FTP_Username, $FTP_Password, $FTP_Passive)
						Local $errFTP = @error
						If Not @error Then
							If $TargetFile_1 <> "" Then
								If $FileList[$NR] = $TargetFile_1 Then
									If _FTP_FilePut($l_FTPSession, $LocalFolder & $FileList[$NR], $RemoteFile) Then
										If $Loop = 1 Then _GUICtrlStatusBar_SetText($Statusbar, "server.cfg Upload: successfully")
										If $Loop = 2 Then _GUICtrlStatusBar_SetText($Statusbar, "sms_rotate_config.json Upload: successfully")
										;If $Loop = 1 Then MsgBox(0, "FTP Upload finished", "server.cfg Upload: successfully", 2)
										;If $Loop = 2 Then MsgBox(0, "FTP Upload finished", "sms_rotate_config.json Upload: successfully", 2)
									Else
										If $Loop = 1 Then _GUICtrlStatusBar_SetText($Statusbar, "server.cfg Upload: Failed")
										If $Loop = 2 Then _GUICtrlStatusBar_SetText($Statusbar, "sms_rotate_config.json Upload: Failed")
										;If $Loop = 1 Then MsgBox(0, "FTP Upload finished", "server.cfg Upload: Failed", 5)
										;If $Loop = 2 Then MsgBox(0, "FTP Upload finished", "sms_rotate_config.json Upload: Failed", 5)
										ExitLoop
									EndIf
								EndIf
							EndIf
							Sleep(200)
							If $TargetFile_2 <> "" Then
								If $FileList[$NR] = $TargetFile_2 Then
									If _FTP_FilePut($l_FTPSession, $LocalFolder & $FileList[$NR], $RemoteFile) Then
										If $Loop = 1 Then _GUICtrlStatusBar_SetText($Statusbar, "blackList.cfg Upload: successfully")
										;MsgBox(0, "FTP Upload finished", "blackList.cfg Upload: successfully", 2)
									Else
										If $Loop = 1 Then _GUICtrlStatusBar_SetText($Statusbar, "blackList.cfg Upload: Failed")
										;MsgBox(0, "FTP Upload finished", "blackList.cfg Upload: Failed", 5)
										ExitLoop
									EndIf
								EndIf
							EndIf
							Sleep(200)
							If $TargetFile_3 <> "" Then
								If $FileList[$NR] = $TargetFile_3 Then
									If _FTP_FilePut($l_FTPSession, $LocalFolder & $FileList[$NR], $RemoteFile) Then
										If $Loop = 1 Then _GUICtrlStatusBar_SetText($Statusbar, "whiteList.cfg Upload: successfully")
										;MsgBox(0, "FTP Upload finished", "whiteList.cfg Upload: successfully", 2)
									Else
										If $Loop = 1 Then _GUICtrlStatusBar_SetText($Statusbar, "whiteList.cfg Upload: Failed")
										;MsgBox(0, "FTP Upload finished", "whiteList.cfg Upload: Failed", 5)
										ExitLoop
									EndIf
								EndIf
							EndIf
							Sleep(200)
						Else
							_GUICtrlStatusBar_SetText($Statusbar, "FTP 'Connect' - Failed")
							MsgBox(0, "FTP 'Connect'", "Failed", 10)
							$Loop = 2
							ExitLoop
						EndIf
					Next
				Else
					If $FileList = "" Then MsgBox(0, "", "Files not found...", 5)
					If $FileList = "" Then _GUICtrlStatusBar_SetText($Statusbar, "Files not found...")
				EndIf
			Next
			_FTP_Close($l_InternetSession) ;schliesst die FTP-Sitzng
			_GUICtrlStatusBar_SetText($Statusbar, "FTP Upload finished" & @TAB & _NowDate( ) & @TAB & $Aktuelle_Version & "' " & '[' & $PCDSG_DS_Mode & " Mode]")
			Sleep(600)
		Else
			_GUICtrlStatusBar_SetText($Statusbar, "FTP 'Connect' - Failed")
			MsgBox(0, "FTP 'Connect'", "Failed", 10)
		EndIf
		Else
		_GUICtrlStatusBar_SetText($Statusbar, "FTP 'Open' - Failed")
		MsgBox(0, "FTP 'Open'", "Failed", 10)
	EndIf
	Sleep(600)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 0)

	Local $DS_Mode_Temp = IniRead($config_ini, "PC_Server", "DS_Mode", "local")
	Local $PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")

	If $DS_Mode_Temp = "remote" Then
		If $PC_Server_Status = "PC_Server_gestartet" Then
			$Abfrage = MsgBox(4, "Restart Dedicated Server", "You will need to restart the Dedicated Server for the settings to apply." & @CRLF & @CRLF & _
														"Do you want to Restart the Dedicated Server?")

			If $Abfrage = 6 Then
				_Restart_DS_Remote()
			EndIf
		EndIf
	Else
		Sleep(200)
	EndIf

	_GUICtrlStatusBar_SetText($Statusbar, "IP: " & $PCDSG_IP & @TAB & @TAB & $Statusbar_welcome_msg_2 & " " & $Aktuelle_Version & "' " & '[' & $PCDSG_DS_Mode & " Mode]")
EndFunc


Func _Check_TaskBarPos()
	Opt('WINTITLEMATCHMODE', 4)

	$pos = ControlGetPos("classname=Shell_TrayWnd", "", "ToolbarWindow322")
	$Taskbar_pos = $pos[1]

	If $Taskbar_pos = 0 Then
		IniWrite($config_ini, "TEMP", "TaskBarPos", "A")
	EndIf

	If $Taskbar_pos > 1 Then
		IniWrite($config_ini, "TEMP", "TaskBarPos", "B")
	EndIf
EndFunc

Func _Info()
	If FileExists($install_dir & "PCDSG StartUp Guide.pdf") Then
		ShellExecute($install_dir & "PCDSG StartUp Guide.pdf")
	Else
		ShellExecute("https://github.com/CogentHub/PCDSG/blob/master/PCDSG%20StartUp%20Guide.pdf")
	EndIf

	Sleep(1000)

	$Abfrage = MsgBox(4, "INFO", "PCDSG made by cogent (alias Atlan)" & @CRLF & @CRLF & _
						"Visit PCDSGwiki page for more information: " & @CRLF & _
						"http://www.cogent.myds.me/PCDSGwiki/doku.php" & @CRLF & @CRLF & _
						"English Forum Thread:" & @CRLF & _
						"http://forum.projectcarsgame.com/showthread.php?31634-Project-Cars-Dedicated-Server-GUI-Launcher-with-%93live-timing%93-(results-timetable-)" & @CRLF & @CRLF & _
						"27.08.2016" & @CRLF & @CRLF & @CRLF & _
						"Do you want to open the Forum Thread in your Internet Explorer?" & @CRLF & @CRLF & @CRLF, 20)

	If $Abfrage = 6 Then
		;ShellExecute($install_dir & "PCDSG StartUp Guide.pdf")
		ShellExecute("http://forum.projectcarsgame.com/showthread.php?31634-Project-Cars-Dedicated-Server-GUI-Launcher-with-%93live-timing%93-(results-timetable-)")
	EndIf

	If $Abfrage = 7 Then
		;ShellExecute($install_dir & "PCDSG StartUp Guide.pdf")
	EndIf
EndFunc

Func _Hide_Windows()
	WinSetState("Project Cars - Dedicated Server GUI", "", @SW_MINIMIZE)
	WinSetState("Einstellungen", "", @SW_MINIMIZE)
	WinSetState("Race Control", "", @SW_MINIMIZE)
	WinSetState("PCars DS User History", "", @SW_MINIMIZE)
	WinSetState("PCars: Dedicated Server Overview", "", @SW_MINIMIZE)
	WinSetState("PCDSG " & $Aktuelle_Version, "", @SW_HIDE)
	WinSetState($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe", "", @SW_HIDE)
EndFunc

Func _Button_Hide_Windows()
	If FileExists($System_Dir & "Hide_Show.exe") Then
		ShellExecute($System_Dir & "Hide_Show.exe")
	Else
		ShellExecute($System_Dir & "Hide_Show.au3")
	EndIf
EndFunc

Func _Show_Windows()
	WinSetState("Project Cars - Dedicated Server GUI", "", @SW_SHOW)
	WinSetState("Einstellungen", "", @SW_SHOW)
	WinSetState("Race Control", "", @SW_SHOW)
	WinSetState("PCars DS User History", "", @SW_SHOW)
	WinSetState("PCars: Dedicated Server Overview", "", @SW_SHOW)
	WinSetState("PCDSG " & $Aktuelle_Version, "", @SW_SHOW)
	WinSetState($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe", "", @SW_SHOW)
EndFunc


Func _Start_DS_EXE()
	$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
	$PCDSG_DS_Mode = IniRead($config_ini,"PC_Server", "DS_Mode", "")

	FileCopy($Dedi_config_cfg, $install_dir & "server.cfg", $FC_OVERWRITE + $FC_CREATEPATH)
	DirCopy($Dedi_Installations_Verzeichnis & "lua", $install_dir & "lua\", $FC_OVERWRITE)
	DirCopy($Dedi_Installations_Verzeichnis & "lua_config", $install_dir & "lua_config\", $FC_OVERWRITE)

	Sleep(250)

	If $PCDSG_DS_Mode = "local" Then
		If WinExists("Project Cars - Dedicated Server GUI") Then
			If NOT WinExists($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe") Then
				$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
				If $PC_Server_Status <> "PC_Server_beendet" Then
					ShellExecute($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe", "", $Dedi_Installations_Verzeichnis, "")
				EndIf
			EndIf
		EndIf
	EndIf
EndFunc

Func _Start_PCDSG_Lapper()
	If FileExists($Programm_Verzeichnis & "StartPCarsDS.exe") Then
		ShellExecute($Programm_Verzeichnis & "StartPCarsDS.exe")
	Else
		ShellExecute($Programm_Verzeichnis & "StartPCarsDS.au3")
	EndIf
EndFunc


Func _Loading_GUI()
	Local Const $PG_WS_POPUP = 0x80000000
	Local Const $PG_WS_DLGFRAME = 0x00400000
	Local $DesktopWidth = @DesktopWidth
	Local $DesktopHeight = @DesktopHeight ; - 75
	Local $POS_X_GUI = 4

	Local $POS_X_Loading_GUI = ($DesktopWidth / 2) - 152

	$GUI_Loading = GUICreate("Loading...please wait...", 250, 65, $POS_X_Loading_GUI, -1, BitOR($PG_WS_DLGFRAME, $PG_WS_POPUP))
	GUISetIcon(@AutoItExe, -2, $GUI_Loading)
	GUISetBkColor("0x00BFFF")

	$font = "arial"
	GUICtrlCreateLabel("...Loading...", 66, 5, 160, 25)
	GUICtrlSetFont(-1, 17, 800, 1, $font)
	GUICtrlSetColor(-1, $COLOR_RED)
	GUICtrlCreateLabel("...Please wait...", 49, 32, 160, 25)
	GUICtrlSetFont(-1, 17, 800, 1, $font)
	GUICtrlSetColor(-1, $COLOR_RED)

	GUISetState(@SW_SHOW, $GUI_Loading)
	WinSetOnTop("Loading...please wait...", "", $WINDOWS_ONTOP)
EndFunc   ;==>_Loading_GUI

Func _Preparing_Data_GUI()
	Local Const $PG_WS_POPUP = 0x80000000
	Local Const $PG_WS_DLGFRAME = 0x00400000
	Local $DesktopWidth = @DesktopWidth
	Local $DesktopHeight = @DesktopHeight ; - 75
	Local $POS_X_GUI = 4

	Local $POS_X_Loading_GUI = ($DesktopWidth / 2) - 152

	$GUI_Loading = GUICreate("Preparing data...Please wait...", 250, 65, $POS_X_Loading_GUI, -1, BitOR($PG_WS_DLGFRAME, $PG_WS_POPUP))
	GUISetIcon(@AutoItExe, -2, $GUI_Loading)
	GUISetBkColor("0x00BFFF")

	$font = "arial"
	GUICtrlCreateLabel("...Preparing Data...", 31, 5, 200, 25)
	GUICtrlSetFont(-1, 17, 800, 1, $font)
	GUICtrlSetColor(-1, $COLOR_RED)
	GUICtrlCreateLabel("...Please Wait...", 49, 32, 160, 25)
	GUICtrlSetFont(-1, 17, 800, 1, $font)
	GUICtrlSetColor(-1, $COLOR_RED)

	GUISetState(@SW_SHOW, $GUI_Loading)
	WinSetOnTop("Loading...please wait...", "", $WINDOWS_ONTOP)
EndFunc   ;==>_Loading_GUI

Func _Check_for_Backups()
	If Not FileExists($Backup_dir & "server.cfg") Then
		Local $Result = FileCopy($Dedi_Installations_Verzeichnis & "server.cfg", $Backup_dir & "server.cfg", $FC_OVERWRITE)
		FileCopy($Dedi_Installations_Verzeichnis & "server.cfg", $Dedi_Installations_Verzeichnis & "server.cfg" & ".bak", $FC_OVERWRITE)
		If $Result = 1 Then
			MsgBox(0 + $MB_ICONINFORMATION, "Backup Successful" & " [1 / 4]", "Backup of config.ini File successfully created." & @CRLF & @CRLF & $Backup_dir & "server.cfg")
		Else
			MsgBox(0 + $MB_ICONWARNING, "Backup Failure" & " [1 / 4]", "Failure." & @CRLF & "Backup of the config.ini File could not be created.")
		EndIf
	EndIf

	If Not FileExists($Backup_dir & "lua\") Then
		Local $Result = DirCopy($Dedi_Installations_Verzeichnis & "lua\", $Backup_dir & "lua\", $FC_OVERWRITE)
		If $Result = 1 Then
			MsgBox(0 + $MB_ICONINFORMATION, "Backup Successful" & " [2 / 4]", "Backup of config.ini File successfully created." & @CRLF & @CRLF & $Backup_dir & "lua\")
		Else
			MsgBox(0 + $MB_ICONWARNING, "Backup Failure" & " [2 / 4]", "Failure." & @CRLF & "Backup of the config.ini File could not be created.")
		EndIf
	EndIf

	If Not FileExists($Backup_dir & "lua_config\") Then
		Local $Result = DirCopy($Dedi_Installations_Verzeichnis & "lua_config\", $Backup_dir & "lua_config\", $FC_OVERWRITE)
		If $Result = 1 Then
			MsgBox(0 + $MB_ICONINFORMATION, "Backup Successful" & " [3 / 4]", "Backup of config.ini File successfully created." & @CRLF & @CRLF & $Backup_dir & "lua_config\")
		Else
			MsgBox(0 + $MB_ICONWARNING, "Backup Failure" & " [3 / 4]", "Failure." & @CRLF & "Backup of the config.ini File could not be created.")
		EndIf
	EndIf

	If Not FileExists($Dedi_Installations_Verzeichnis & "lua_config\sms_rotate_config.json.bak") Then
		Local $Result = FileCopy($Dedi_Installations_Verzeichnis & "lua_config\sms_rotate_config.json", $Dedi_Installations_Verzeichnis & "lua_config\sms_rotate_config.json.bak", $FC_OVERWRITE)
		If $Result = 1 Then
			MsgBox(0 + $MB_ICONINFORMATION, "Backup Successful" & " [4 / 4]", "Backup of sms_rotate_config.json File successfully created." & @CRLF & @CRLF & $Backup_dir & "sms_rotate_config.json")
		Else
			MsgBox(0 + $MB_ICONWARNING, "Backup Failure" & " [4 / 4]", "Failure." & @CRLF & "Backup of the sms_rotate_config.json File could not be created.")
		EndIf
	EndIf
EndFunc

Func _Restart_DS_Remote() ; REMOTE
	$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/restart'
	$download = InetGet($URL, $System_Dir & "Restart.txt", 16, 0)

	If FileExists($System_Dir & "Restart.txt") Then
		Local $OK_Check = FileReadLine($System_Dir & "Restart.txt", 2)
		If $OK_Check = '  "result" : "ok"' Then
			MsgBox(0 + $MB_ICONINFORMATION, "Restart", "Restart of Dedicated Server successful.", 3)
			FileDelete($System_Dir & "Restart.txt")
		Else
			MsgBox(0 + $MB_ICONWARNING, "Restart", "Restart of Dedicated Server failed.")
			FileDelete($System_Dir & "Restart.txt")
		EndIf
	EndIf
EndFunc

Func _Restart_PCDSG()
	If FileExists($install_dir & "PCDSG.exe") Then
		ShellExecute($install_dir & "PCDSG.exe")
	Else
		ShellExecute($install_dir & "PCDSG.au3")
	EndIf
	Exit
EndFunc

Func _Beenden()
	_GUICtrlStatusBar_SetText($Statusbar, $Statusbar_welcome_msg_30)
	$PC_Server_Status =  IniRead($config_ini,"PC_Server", "Status", "")

	If $PC_Server_Status = "PC_Server_gestartet" Then
		Exit
	Else
		_GUICtrlStatusBar_SetText($Statusbar, $Statusbar_welcome_msg_31)
	EndIf

	FileWriteLine($PCDSG_LOG_ini, "PCDSG_Exit_GUI_" & $NowTime & "=" & "Exit PCDSG GUI:" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)

	Exit
EndFunc

#endregion Start Funktionen
