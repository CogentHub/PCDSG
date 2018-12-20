#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#include <StaticConstants.au3>
#include <GuiButton.au3>
#include <FontConstants.au3>
#include <File.au3>
#include <GuiStatusBar.au3>
#include <Date.au3>
#include <MsgBoxConstants.au3>
#include <ColorConstants.au3>

#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIMenu.au3>


#Region Declare Globals
Global $Array, $Wert_VehicleModelId_Standard, $Lua_Track_Name
Global $Wert_persist_index, $Wert_Flags, $Wert_Input_Flags, $Wert_DamageType, $Wert_TireWearType, $Wert_FuelUsageType, $Wert_PenaltiesType, $Wert_OpponentDifficulty
Global $Wert_AllowedViews, $Wert_ManualPitStops, $Wert_ManualRollingStarts, $Wert_MinimumOnlineRank, $Wert_MinimumOnlineStrength, $Wert_PracticeLength
Global $Wert_QualifyLength, $Wert_RaceLength, $Wert_RaceRollingStart, $Wert_RaceFormationLap, $Wert_RaceMandatoryPitStops, $Wert_PracticeDateHour
Global $Wert_PracticeDateProgression, $Wert_PracticeWeatherProgression, $Wert_QualifyDateHour, $Wert_QualifyDateProgression, $Wert_QualifyWeatherProgression
Global $Wert_RaceDateYear, $Wert_RaceDateMonth, $Wert_RaceDateDay, $Wert_RaceDateHour, $Wert_RaceDateProgression, $Wert_RaceWeatherProgression
Global $Wert_PracticeWeatherSlots, $Wert_PracticeWeatherSlot1, $Wert_PracticeWeatherSlot2, $Wert_PracticeWeatherSlot3, $Wert_PracticeWeatherSlot4
Global $Wert_QualifyWeatherSlots, $Wert_QualifyWeatherSlot1, $Wert_QualifyWeatherSlot2, $Wert_QualifyWeatherSlot3, $Wert_QualifyWeatherSlot4
Global $Wert_RaceWeatherSlots, $Wert_RaceWeatherSlot1, $Wert_RaceWeatherSlot2, $Wert_RaceWeatherSlot3, $Wert_RaceWeatherSlot4
Global $ProgressBar_2, $Button_ServerControl_MoreSettings, $Combo_VehicleClassId_Slot_1, $Combo_VehicleClassId_Slot_2, $Combo_VehicleClassId_Slot_3
Global $Button_ServerControl_LUA_MoreSettings
Global $LUA_Label_Track, $LUA_Combo_ABS_ALLOWED, $LUA_Combo_TCS_ALLOWED, $LUA_Combo_ManualRollingStarts, $LUA_Combo_RaceRollingStart, $LUA_Combo_RaceFormationLap
Global $LUA_Combo_PracticeLength, $LUA_Combo_PracticeDateHour, $LUA_Combo_QualifyLength, $LUA_Combo_QualifyDateHour, $LUA_Combo_RaceLength
Global $LUA_Combo_RaceDateYear, $LUA_Combo_RaceDateMonth, $LUA_Combo_RaceDateDay, $LUA_Combo_RaceDateHour
Global $LUA_PracticeWeatherSlots, $LUA_UpDpwn_PracticeWeatherSlots, $LUA_PracticeWeatherSlot1, $LUA_PracticeWeatherSlot2, $LUA_PracticeWeatherSlot3, $LUA_PracticeWeatherSlot4
Global $LUA_QualifyWeatherSlots, $LUA_UpDpwn_QualifyWeatherSlots, $LUA_QualifyWeatherSlot1, $LUA_QualifyWeatherSlot2, $LUA_QualifyWeatherSlot3, $LUA_QualifyWeatherSlot4
Global $LUA_RaceWeatherSlots, $LUA_UpDpwn_RaceWeatherSlots, $LUA_RaceWeatherSlot1, $LUA_RaceWeatherSlot2, $LUA_RaceWeatherSlot3, $LUA_RaceWeatherSlot4
Global $GUI_Loading, $Wert_PracticeLength_Standard, $Wert_QualifyLength_Standard, $Wert_RaceLength_Standard, $PracticeLength, $QualifyLength, $RaceLength
Global $ServerControl_LUA_MoreSettings_GUI
#EndRegion Declare Globals


Opt("GUIOnEventMode", 1)


Global $font_arial = "arial"
Global $Array_Cars[1], $Array_Tracks[1], $Array_VehicleClassesList[1]

Global $config_ini = @ScriptDir & "\config.ini"
Global $install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
Global $System_Dir = $install_dir & "system\"
Global $Data_Dir = $install_dir & "data\"
Global $Backup_dir = $install_dir & "Backup\"
Global $Sprachdatei = IniRead($config_ini,"Einstellungen", "Sprachdatei", "")
Global $Members_Data_INI = $System_Dir & "Members_Data.ini"
Global $Server_Data_INI = $System_Dir & "Server_Data.ini"
Global $LFS_DCon_Fenster_Name = IniRead($config_ini, "Einstellungen", "LFS_DCon_Fenster_Name", "")

Global $DS_Domain_or_IP = IniRead($config_ini, "PC_Server", "DS_Domain_or_IP", "")

Global $Dedi_Installations_Verzeichnis = IniRead($config_ini, "Einstellungen", "Dedi_Installations_Verzeichnis", "")
Global $Dedi_config_cfg = $Dedi_Installations_Verzeichnis & "server.cfg"

Global $Value_Checkbox_RCS_Lua_Track_Rotation = IniRead($config_ini,"Server_Einstellungen", "SMS_Rotate", "")
Global $Value_Checkbox_RCS_ControlGameSetup = IniRead($config_ini,"Server_Einstellungen", "controlGameSetup", "")
Global $Value_Checkbox_RCS_ServerControlsTrack = IniRead($config_ini,"Server_Einstellungen", "ServerControlsTrack", "")
Global $Value_Checkbox_RCS_ServerControlsVehicleClass = IniRead($config_ini,"Server_Einstellungen", "ServerControlsVehicleClass", "")
Global $Value_Checkbox_RCS_ServerControlsVehicle = IniRead($config_ini,"Server_Einstellungen", "ServerControlsVehicle", "")


Global $Value_Checkbox_RCS_Activate_MultiClass = IniRead($config_ini,"Server_Einstellungen", "Activate_MultiClass", "")


Global $sms_rotate_config_json_File = $Dedi_Installations_Verzeichnis & "lua_config\sms_rotate_config.json"
Global $sms_rotate_config_json_Template_1 = $install_dir & "Templates\lua_config\sms_rotate_config_1.json"
Global $sms_rotate_config_json_Template_2 = $install_dir & "Templates\lua_config\sms_rotate_config_2.json"

Global $sms_rotate_config_json_File = $Dedi_Installations_Verzeichnis & "lua_config\sms_rotate_config.json"

Global $RC_LUA_Settings_ini_File = $System_Dir & "RaceControl\RC_LUA_Settings.ini"

Global $VehicleClassesList_TXT = $System_Dir & "VehicleClassesList.txt"


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


_Check_for_Backups()


_Main()



Func _Main()
	Global $ServerBest_INI = $System_Dir & "ServerBest.ini"

	Global $RaceControl_folder = $System_Dir & "RaceControl\"
	Global $RaceControl_NextEventInfo_INI = $RaceControl_folder & "NextEventInfo.ini"
	Global $RaceControl_WebPageInfo_INI = $RaceControl_folder & "WebPageInfo.ini"
	Global $RaceControl_FairPlay_INI = $RaceControl_folder & "FairPlay.ini"
	Global $RaceControl_Messages_INI = $RaceControl_folder & "Messages.ini"

	$Wert_Scantiefe_Anzahl_Werte = IniRead($config_ini, "Einstellungen", "Scantiefe", "")
	$Benutzername = IniRead($config_ini, "Einstellungen", "Benutzername", "")
	$LFS_Pubstat = IniRead($config_ini, "Einstellungen", "LFS_Pubstat", "")
	$LFS_Host_Port_1 = IniRead($config_ini, "Einstellungen", "LFS_Host_Port_1", "")
	$LFS_Host_Port_2 = IniRead($config_ini, "Einstellungen", "LFS_Host_Port_2", "")
	$LFS_ImSim_Port = IniRead($config_ini, "Einstellungen", "LFS_ImSim_Port", "")
	$FTP_Web_Upload = IniRead($config_ini, "Einstellungen", "FTP_Web_Upload", "")
	$FTP_Username = IniRead($config_ini, "Einstellungen", "FTP_Username", "")
	$FTP_Passwort = IniRead($config_ini, "Einstellungen", "FTP_Passwort", "")
	$FTP_Server_Name_IP = IniRead($config_ini, "Einstellungen", "FTP_Server_Name_IP", "")

	$LFS_Host_Name = IniRead($config_ini, "Einstellungen", "LFS_Host_Name", "")
	$LFS_Host_Passwort = IniRead($config_ini, "Einstellungen", "LFS_Host_Passwort", "")
	$LFS_User_Name = IniRead($config_ini, "Einstellungen", "LFS_User_Name", "")


	$Value_SG1_min_read = IniRead($config_ini, "Race_Control", "Value_SG1_min", "")
	$Value_SG2_min_read = IniRead($config_ini, "Race_Control", "Value_SG2_min", "")
	$Value_SG2_max_read = IniRead($config_ini, "Race_Control", "Value_SG2_max", "")
	$Value_SG3_min_read = IniRead($config_ini, "Race_Control", "Value_SG3_min", "")
	$Value_SG3_max_read = IniRead($config_ini, "Race_Control", "Value_SG3_max", "")
	$Value_SG4_min_read = IniRead($config_ini, "Race_Control", "Value_SG4_min", "")
	$Value_SG4_max_read = IniRead($config_ini, "Race_Control", "Value_SG4_max", "")
	$Value_SG5_min_read = IniRead($config_ini, "Race_Control", "Value_SG5_min", "")
	$Value_SG5_max_read = IniRead($config_ini, "Race_Control", "Value_SG5_max", "")

	$font_arial = "arial"
	$gfx = (@ScriptDir & "\" & "gfx\")

	Global $GUI_3
	Global $Statusbar, $Statusbar_simple, $Anzeige_Fortschrittbalken
	Global $Combo_TRACK, $Combo_CAR, $config_ini, $GUI_1, $GUI_2, $Checkbox_Rules_1, $Checkbox_Rules_2, $Checkbox_Rules_3, $Checkbox_Rules_4, $CarList_Array
	Global $Combo_TRACK_2, $TrackList_Array, $Anzahl_Zeilen_server_cfg
	Global $Wert_TrackId_Standard, $Wert_Track_Standard, $Wert_CarId_Standard, $Wert_Car_Standard, $Wert_Track, $Wert_Car
	Global $Wert_Car_ID, $Wert_Track_ID, $Wert_Track_NAME_Random
	Global $Checkbox_RCS_ServerControlsTrack
	Global $Checkbox_RCS_ServerControlsVehicle
	Global $Wert_UpDpwn_GridSize
	Global $Wert_UpDpwn_MaxPlayers
	Global $Wert_Input_Flags
	Global $Wert_UpDpwn_DamageType
	Global $Wert_UpDpwn_TireWearType
	Global $Wert_UpDpwn_FuelUsageType
	Global $Wert_UpDpwn_PenaltiesType
	Global $Wert_UpDpwn_AllowedViews
	Global $Wert_Date
	Global $Wert_Time
	Global $Checkbox_RCS_DateProgression
	Global $Checkbox_RCS_ForecastProgression
	Global $Wert_UpDpwn_WeatherSlots
	Global $Wert_Input_WeatherSlot1
	Global $Wert_Input_WeatherSlot2
	Global $Wert_Input_WeatherSlot3
	Global $Wert_Input_WeatherSlot4
	Global $Wert_Practice1Length_Standard, $Wert_Practice2Length_Standard, $Wert_QualifyLength_Standard, $Wert_Race1Length_Standard, $Wert_UpDpwn_Race1
	Global $SB_Combo_CAR, $SB_Combo_TRACK

	$GUI_1 = GUICreate("Race Control", 890, 535, -1, -1)

	; PROGRESS
	$Anzeige_Fortschrittbalken = GUICtrlCreateProgress(0, 512, 889, 5)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 0)

	$Statusbar = _GUICtrlStatusBar_Create($GUI_1)
	$Statusbar_simple = _GUICtrlStatusBar_SetSimple($Statusbar, True)

	Global $font_2 = "Arial"


	; GROUP Nachrichten
	GUICtrlCreateGroup("Messages", 5, 5, 165, 245)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 9, 400, 6, $font_arial)

	$Button_Nachrichten_1 = GUICtrlCreateButton("", 10, 25, 76, 55, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Nachrichten_1, $gfx & "RC_send_Server_message.bmp")

	$Button_Nachrichten_2 = GUICtrlCreateButton("", 88, 25, 76, 55, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Nachrichten_2, $gfx & "RC_send_Private_message.bmp")

	$Button_Nachrichten_5 = GUICtrlCreateButton("", 10, 80, 76, 55, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Nachrichten_5, $gfx & "RC_welcome_message.bmp")

	$Button_Nachrichten_6 = GUICtrlCreateButton("", 88, 80, 76, 55, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Nachrichten_6, $gfx & "RC_email_message.bmp")

	$Button_Nachrichten_7 = GUICtrlCreateButton("", 10, 135, 76, 55, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Nachrichten_7, $gfx & "RC_problems_message.bmp")

	$Button_Nachrichten_8 = GUICtrlCreateButton("", 88, 135, 76, 55, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Nachrichten_8, $gfx & "RC_abreak_message.bmp")

	$Button_Nachrichten_3 = GUICtrlCreateButton("", 10, 188, 76, 55, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Nachrichten_3, $gfx & "RC_Server_Rules_message.bmp")

	$Button_Nachrichten_4 = GUICtrlCreateButton("", 88, 188, 76, 55, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Nachrichten_4, $gfx & "RC_Server_SB_message.bmp")

	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group


	; GROUP
	GUICtrlCreateGroup("LOBBY - Automatic actions", 5, 260, 165, 120)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 9, 400, 6, $font_arial)

	Global $Check_controlGameSetup = IniRead($config_ini, "Server_Einstellungen", "controlGameSetup", "")

	Global $Check_Checkbox_SET_Lobby_1 = IniRead($config_ini, "Race_Control", "Checkbox_SET_Lobby1", "")
	Global $Check_Checkbox_SET_Lobby_2 = IniRead($config_ini, "Race_Control", "Checkbox_SET_Lobby2", "")
	Global $Check_Checkbox_SET_Lobby_3 = IniRead($config_ini, "Race_Control", "Checkbox_SET_Lobby3", "")
	Global $Check_Checkbox_SET_Lobby_4 = IniRead($config_ini, "Race_Control", "Checkbox_SET_Lobby4", "")
	Global $Check_Checkbox_SET_Lobby_5 = IniRead($config_ini, "Race_Control", "Checkbox_SET_Lobby5", "")

	Global $Checkbox_SET_Lobby_1 = GUICtrlCreateCheckbox(" Send Server Rules msg", 10, 280, 155, 15)
		If $Check_Checkbox_SET_Lobby_1 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	$X_value = 10
	Global $Checkbox_SET_Lobby_2 = GUICtrlCreateCheckbox(" Set random Car", $X_value, 300, 95, 15)
		If $Check_Checkbox_SET_Lobby_2 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	$X_value = 10
	Global $Checkbox_SET_Lobby_3 = GUICtrlCreateCheckbox(" Set random Track", $X_value, 320, 105, 15)
		If $Check_Checkbox_SET_Lobby_3 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	Global $Checkbox_SET_Lobby_4 = GUICtrlCreateCheckbox(" Send Web Page Info msg", 10, 340, 144, 15)
		If $Check_Checkbox_SET_Lobby_4 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Button_Checkbox_SET_Lobby_4 = GUICtrlCreateButton("#", 154, 342, 13, 13, $BS_BITMAP)

	Global $Checkbox_SET_Lobby_5 = GUICtrlCreateCheckbox(" Send Next Event Info msg", 10, 360, 144, 15)
		If $Check_Checkbox_SET_Lobby_5 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Button_Checkbox_SET_Lobby_5 = GUICtrlCreateButton("#", 154, 362, 13, 13, $BS_BITMAP)

	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group


	GUICtrlCreateGroup("Game - Automatic actions", 5, 385, 165, 123)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 9, 400, 6, $font_arial)

	Global $Check_Checkbox_SET_GameAction_1 = IniRead($config_ini, "Race_Control", "Checkbox_SET_GameAction_1", "")
	Global $Check_Checkbox_SET_GameAction_2 = IniRead($config_ini, "Race_Control", "Checkbox_SET_GameAction_2", "")
	Global $Check_Checkbox_SET_GameAction_3 = IniRead($config_ini, "Race_Control", "Checkbox_SET_GameAction_3", "")
	Global $Check_Checkbox_SET_GameAction_4 = IniRead($config_ini, "Race_Control", "Checkbox_SET_GameAction_4", "")

	Global $Checkbox_SET_GameAction_1 = GUICtrlCreateCheckbox(" Send FairPlay msg", 10, 405, 144, 15)
		If $Check_Checkbox_SET_GameAction_1 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Button_Checkbox_SET_GameAction_1 = GUICtrlCreateButton("#", 154, 407, 13, 13, $BS_BITMAP)

	Global $Checkbox_SET_GameAction_2 = GUICtrlCreateCheckbox(" Send Web Page Info msg", 10, 425, 144, 15)
		If $Check_Checkbox_SET_GameAction_2 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Button_Checkbox_SET_GameAction_2 = GUICtrlCreateButton("#", 154, 427, 13, 13, $BS_BITMAP)

	Global $Checkbox_SET_GameAction_3 = GUICtrlCreateCheckbox(" Send Next Event Info msg", 10, 445, 144, 15)
		If $Check_Checkbox_SET_GameAction_3 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Button_Checkbox_SET_GameAction_3 = GUICtrlCreateButton("#", 154, 447, 13, 13, $BS_BITMAP)

	Global $Checkbox_SET_GameAction_4 = GUICtrlCreateCheckbox(" Send Server Best Lap msg", 10, 465, 144, 15)
		If $Check_Checkbox_SET_GameAction_4 = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	Global $Button_Set_AutomaticMessage_NR = GUICtrlCreateButton("Set / Save NR", 8, 483, 80, 18, $BS_BITMAP)
	Global $Button_Delete_AutomaticMessage_NR = GUICtrlCreateButton("Empty temp NR", 88, 483, 80, 18, $BS_BITMAP)

	GUICtrlCreateGroup("", -99, -99, 1, 1)


	; GROUP Server Rules
	GUICtrlCreateGroup("Server Rules", 180, 5, 165, 185)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 9, 400, 6, $font_arial)

	; Checkboxen
	Global $Checkbox_Rules_1 = GUICtrlCreateCheckbox(" Automatic kick parking cars", 185, 25, 153, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_1", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Checkbox_Rules_2 = GUICtrlCreateCheckbox(" Kick new Blacklisted users", 185, 45, 153, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_2", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Checkbox_Rules_3 = GUICtrlCreateCheckbox(" TrackCut Penalty", 185, 65, 105, 15) ; Penalize track cut
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_3", "") = "true" Then
			GUICtrlSetState(-1, $GUI_CHECKED)
		EndIf
	Global $Checkbox_Rules_4 = GUICtrlCreateCheckbox(" Impact Penalty", 185, 85, 105, 15) ; Penalize impact
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_4", "") = "true" Then
			GUICtrlSetState(-1, $GUI_CHECKED)
		EndIf
	Global $Checkbox_Rules_5 = GUICtrlCreateCheckbox(" Activate Points System", 185, 105, 153, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_5", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Checkbox_Rules_6 = GUICtrlCreateCheckbox(" Activate auto. Server MSG", 185, 125, 153, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_6", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Checkbox_Rules_7 = GUICtrlCreateCheckbox(" Activ. Ping Limit", 185, 145, 95, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_7", "") = "true" Then
			GUICtrlSetState(-1, $GUI_CHECKED)
		EndIf
	Global $Checkbox_Rules_8 = GUICtrlCreateCheckbox(" Activate admin commands", 185, 165, 153, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_8", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	; UPDOWN Penalize track cut
	Global $Value_Value_Points_TrackCut = IniRead($config_ini, "Race_Control", "Value_Points_TrackCut", "")
	Global $Input_Value_Points_TrackCut = GUICtrlCreateInput($Value_Value_Points_TrackCut, 290, 62, 50, 19)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Points_TrackCut_UpDown = GUICtrlCreateUpdown($Input_Value_Points_TrackCut)

	; UPDOWN Penalize impact
	Global $Value_Value_Points_Impact = IniRead($config_ini, "Race_Control", "Value_Points_Impact", "")
	Global $Input_Value_Points_Impact = GUICtrlCreateInput($Value_Value_Points_Impact, 290, 83, 50, 19)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Points_Impact_UpDown = GUICtrlCreateUpdown($Input_Value_Points_Impact)

	; UPDOWN Ping Limit
	Global $Value_Ping_Limit_UpDown_1 = IniRead($config_ini, "Race_Control", "PingLimit", "")
	Global $Wert_Ping_Limit_UpDown_1 = GUICtrlCreateInput($Value_Ping_Limit_UpDown_1, 285, 143, 55, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Ping_Limit_UpDown_1 = GUICtrlCreateUpdown($Wert_Ping_Limit_UpDown_1)


	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group


	If IniRead($config_ini, "Race_Control", "Checkbox_Rules_3", "") = "true" Then
		GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetState($Input_Value_Points_TrackCut, $GUI_ENABLE)
	Else
		GUICtrlSetState($Input_Value_Points_TrackCut, $GUI_DISABLE)
	EndIf

	If IniRead($config_ini, "Race_Control", "Checkbox_Rules_4", "") = "true" Then
		GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetState($Input_Value_Points_Impact, $GUI_ENABLE)
	Else
		GUICtrlSetState($Input_Value_Points_Impact, $GUI_DISABLE)
	EndIf

	If IniRead($config_ini, "Race_Control", "Checkbox_Rules_7", "") = "true" Then
		GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetState($Wert_Ping_Limit_UpDown_1, $GUI_ENABLE)
	Else
		GUICtrlSetState($Wert_Ping_Limit_UpDown_1, $GUI_DISABLE)
	EndIf


	; GROUP Server Penalties / Punishment
	GUICtrlCreateGroup("Penalties / Experience Points", 180, 195, 165, 313)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 9, 400, 6, $font_arial)

	GUICtrlCreateLabel("Penalty Points:", 185, 215, 100, 20)

	Global $Checkbox_Server_Penalties_1 = GUICtrlCreateCheckbox(" WARN IF", 185, 235, 65, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Server_Penalties_1", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	; UPDOWN Server_Penalties_1
	Global $Value_PP_UpDown_1 = IniRead($config_ini, "Race_Control", "Value_Checkbox_Server_Penalties_1", "")
	Global $Wert_PP_UpDown_1 = GUICtrlCreateInput($Value_PP_UpDown_1, 255, 232, 55, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $PP_UpDown_1 = GUICtrlCreateUpdown($Wert_PP_UpDown_1)
	GUICtrlCreateLabel("PP", 318, 233, 25, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)

	Global $Checkbox_Server_Penalties_2 = GUICtrlCreateCheckbox(" KICK IF", 185, 260, 65, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Server_Penalties_2", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	; UPDOWN Server_Penalties_2
	Global $Value_PP_UpDown_2 = IniRead($config_ini, "Race_Control", "Value_Checkbox_Server_Penalties_2", "")
	Global $Wert_PP_UpDown_2 = GUICtrlCreateInput($Value_PP_UpDown_2, 255, 257, 55, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $PP_UpDown_2 = GUICtrlCreateUpdown($Wert_PP_UpDown_2)
	GUICtrlCreateLabel("PP", 318, 258, 25, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)



	GUICtrlCreateLabel("Experience Points:", 185, 290, 100, 20)

	GUICtrlCreateLabel("PB:", 185, 310, 25, 20)

	; UPDOWN
	Global $Value_EP_UpDown_for_PB = IniRead($config_ini, "Race_Control", "ExpiriencePoints_for_PB", "")
	Global $Wert_EP_for_PB = GUICtrlCreateInput($Value_EP_UpDown_for_PB, 205, 307, 50, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $EP_UpDown_1 = GUICtrlCreateUpdown($Wert_EP_for_PB)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)


	GUICtrlCreateLabel("SB:", 270, 310, 25, 20)

	; UPDOWN
	Global $Value_EP_UpDown_for_SB = IniRead($config_ini, "Race_Control", "ExpiriencePoints_for_SB", "")
	Global $Wert_EP_for_SB = GUICtrlCreateInput($Value_EP_UpDown_for_SB, 290, 307, 50, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $EP_UpDown_1 = GUICtrlCreateUpdown($Wert_EP_for_SB)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)



	Global $Checkbox_Server_ExperiencePoints_2 = GUICtrlCreateCheckbox(" VARIANT", 185, 335, 65, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Server_ExperiencePoints_2", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	; UPDOWN
	Global $Value_EP_UpDown_2 = IniRead($config_ini, "Race_Control", "Value_Checkbox_ExperiencePoints_2", "")
	Global $Wert_EP_UpDown_2 = GUICtrlCreateInput($Value_EP_UpDown_2, 255, 332, 85, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $EP_UpDown_2 = GUICtrlCreateUpdown($Wert_EP_UpDown_2)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)


	Global $Checkbox_Server_SafetyGroups = GUICtrlCreateCheckbox(" GROUPS", 185, 360, 65, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_SafetyGroups", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)


	Global $Value_SG_entry_Limit = IniRead($config_ini, "Race_Control", "Value_SG_entry_Limit", "")

	If $Value_SG_entry_Limit = "" Then
		$Value_SG_entry_Limit = "ALL"
		IniWrite($config_ini, "Race_Control", "Value_SG_entry_Limit", $Value_SG_entry_Limit)

	EndIf


	Global $idRadioSG1 = GUICtrlCreateRadio("", 185, 382, 15, 20)
	If $Value_SG_entry_Limit = "SG1" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateLabel("SG 1:", 205, 385, 30, 20)
	GUICtrlCreateLabel(">", 238, 385, 10, 20)
	Global $Value_Input_SG1_min = GUICtrlCreateInput($Value_SG1_min_read, 248, 383, 37, 17)

	Global $idRadioSG2 = GUICtrlCreateRadio("", 185, 402, 15, 20)
	If $Value_SG_entry_Limit = "SG2" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateLabel("SG 2: ", 205, 405, 30, 20)
	GUICtrlCreateLabel(">", 238, 405, 10, 20)
	Global $Value_Input_SG2_min = GUICtrlCreateInput($Value_SG2_min_read, 248, 403, 37, 17)
	GUICtrlCreateLabel("<", 293, 405, 10, 20)
	Global $Value_Input_SG2_max = GUICtrlCreateInput($Value_SG2_max_read, 303, 403, 37, 17)

	Global $idRadioSG3 = GUICtrlCreateRadio("", 185, 422, 15, 20)
	If $Value_SG_entry_Limit = "SG3" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateLabel("SG 3: ", 205, 425, 30, 20)
	GUICtrlCreateLabel(">", 238, 425, 10, 20)
	Global $Value_Input_SG3_min = GUICtrlCreateInput($Value_SG3_min_read, 248, 423, 37, 17)
	GUICtrlCreateLabel("<", 293, 425, 10, 20)
	Global $Value_Input_SG3_max = GUICtrlCreateInput($Value_SG3_max_read, 303, 423, 37, 17)

	Global $idRadioSG4 = GUICtrlCreateRadio("", 185, 442, 15, 20)
	If $Value_SG_entry_Limit = "SG4" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateLabel("SG 4: ", 205, 445, 30, 20)
	GUICtrlCreateLabel(">", 238, 445, 10, 20)
	Global $Value_Input_SG4_min = GUICtrlCreateInput($Value_SG4_min_read, 248, 443, 37, 17)
	GUICtrlCreateLabel("<", 293, 445, 10, 20)
	Global $Value_Input_SG4_max = GUICtrlCreateInput($Value_SG4_max_read, 303, 443, 37, 17)

	Global $idRadioSG5 = GUICtrlCreateRadio("", 185, 462, 15, 20)
	If $Value_SG_entry_Limit = "SG5" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateLabel("SG 5: ", 205, 465, 30, 20)
	GUICtrlCreateLabel(">", 238, 465, 10, 20)
	Global $Value_Input_SG5_min = GUICtrlCreateInput($Value_SG5_min_read, 248, 463, 37, 17)
	GUICtrlCreateLabel("<", 293, 465, 10, 20)
	Global $Value_Input_SG5_max = GUICtrlCreateInput($Value_SG5_max_read, 303, 463, 37, 17)

	Global $idRadioSG6 = GUICtrlCreateRadio("ALL", 185, 482, 35, 20)
	If $Value_SG_entry_Limit = "ALL" Then GUICtrlSetState(-1, $GUI_CHECKED)

	Global $Button_Set_SG_Groups = GUICtrlCreateButton("Set / Save", 248, 483, 93, 18, $BS_BITMAP)

	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group


	GUICtrlCreateGroup("Race Result Points", 355, 5, 530, 53)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 9, 400, 6, $font_arial)

	; Checkboxen
	Global $Checkbox_Race_Results_Points = GUICtrlCreateCheckbox(" Activate RR Points", 360, 24, 110, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Race_Results_Points", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Checkbox_Checkbox_RRP_Continuous_record = GUICtrlCreateCheckbox(" Continuous record", 360, 39, 110, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_RRP_Continuous_record", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	GUICtrlCreateLabel("NR Races", 490, 17, 60, 20)
	GUICtrlSetFont(-1, 9, $FW_NORMAL, "", $font_2)
	Global $Wert_Input_NR_Races = GUICtrlCreateInput("", 555, 17, 45, 19)
	GUICtrlSetFont(-1, 9, $FW_NORMAL, "", $font_2)
	Global $Wert_UpDpwn_NR_Races = GUICtrlCreateUpdown($Wert_Input_NR_Races)

	GUICtrlCreateLabel("Current", 490, 37, 60, 15)
	GUICtrlSetFont(-1, 9, $FW_NORMAL, "", $font_2)
	Global $Wert_Current_NR_Races = GUICtrlCreateLabel("", 570, 37, 50, 15)
	GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)


	Global $Button_Edit_PointsTable = GUICtrlCreateButton("Edit Points Table", 614, 20, 130, 30, $BS_BITMAP)
	GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)

	Global $Button_New_PointsTable = GUICtrlCreateButton("New Points Table", 750, 20, 130, 30, $BS_BITMAP)
	GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)

	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group


	If IniRead($config_ini, "Race_Control", "Checkbox_RRP_Continuous_record", "") = "true" Then
		_Disable_RRP_Objects_Continuous_record()
	Else
		_Enable_RRP_Objects_Continuous_record()
	EndIf

	If IniRead($config_ini, "Race_Control", "Checkbox_Race_Results_Points", "") = "true" Then
		_Enable_RRP_Objects()
	Else
		_Disable_RRP_Objects()
	EndIf

	_Set_RRP_Objects()


	; GROUP Server / Game Control
	Global $X_3 = 360
	Global $X_4 = 555


	GUICtrlCreateGroup("Game Control (only in Lobby)", $X_3 - 5, 62, 190, 446)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 9, 400, 6, $font_arial)

	_Werte_Server_CFG_Read()
	_Werte_Config_INI_Read()


	$Combo_CAR = GUICtrlCreateCombo("", $X_3, 80, 155, 55)
	_CAR_DropDown()
	Global $Button_Set_Car_Attribute = GUICtrlCreateButton("", $X_3 + 160, 80, 20, 20, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Set_Car_Attribute, $gfx & "Set_Attribute.bmp")
	GUICtrlSetOnEvent(-1, "_Set_Car_Attribute")

	Global $Combo_TRACK = GUICtrlCreateCombo("", $X_3, 105, 155, 55)
	_TRACK_DropDown()
	Global $Button_Set_Track_Attribute = GUICtrlCreateButton("", $X_3 + 160, 105, 20, 20, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Set_Track_Attribute, $gfx & "Set_Attribute.bmp")
	GUICtrlSetOnEvent(-1, "_Set_Track_Attribute")

	Global $Checkbox_RC_Training_1 = GUICtrlCreateCheckbox(" Training", $X_3, 135, 70, 15)
		If $Wert_PracticeLength_Standard > 0 Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Button_Set_Training_1_Attribute = GUICtrlCreateButton("", $X_3 + 160, 131, 20, 20, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Set_Training_1_Attribute, $gfx & "Set_Attribute.bmp")
	GUICtrlSetOnEvent(-1, "_Set_Training_1_Attribute")

	;Global $Checkbox_RC_Training_2 = GUICtrlCreateCheckbox(" Training 2", $X_3, 160, 70, 15)
		;If $Wert_Practice2Length_Standard > 0 Then GUICtrlSetState(-1, $GUI_CHECKED)
	;$Button_Set_Training_2_Attribute = GUICtrlCreateButton("", $X_3 + 160, 156, 20, 20, $BS_BITMAP)
	;_GUICtrlButton_SetImage($Button_Set_Training_2_Attribute, $gfx & "Set_Attribute.bmp")
	;GUICtrlSetOnEvent(-1, "_Set_Training_2_Attribute")
	;GUICtrlSetState($Checkbox_RC_Training_2, $GUI_DISABLE)
	;GUICtrlSetState($Button_Set_Training_2_Attribute, $GUI_DISABLE)

	Global $Checkbox_RC_Qualifying = GUICtrlCreateCheckbox(" Qualifying", $X_3, 160, 70, 15)
		If $Wert_QualifyLength_Standard > 0 Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Button_Set_Qualifying_Attribute = GUICtrlCreateButton("", $X_3 + 160, 156, 20, 20, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Set_Qualifying_Attribute, $gfx & "Set_Attribute.bmp")
	GUICtrlSetOnEvent(-1, "_Set_Qualifying_Attribute")

	;Global $Checkbox_RC_WarmUp = GUICtrlCreateCheckbox(" WarmUp", $X_3, 212, 70, 15)
		;GUICtrlSetState(-1, $GUI_CHECKED)
	;$Button_Set_WarmUp_Attribute = GUICtrlCreateButton("", $X_3 + 160, 208, 20, 20, $BS_BITMAP)
	;_GUICtrlButton_SetImage($Button_Set_WarmUp_Attribute, $gfx & "Set_Attribute.bmp")
	;GUICtrlSetOnEvent(-1, "_Set_WarmUp_Attribute")
	;GUICtrlSetState($Checkbox_RC_WarmUp, $GUI_DISABLE)
	;GUICtrlSetState($Button_Set_WarmUp_Attribute, $GUI_DISABLE)

	Global $Checkbox_RC_Race_1 = GUICtrlCreateCheckbox(" Race", $X_3, 186, 70, 15)
		If $Wert_RaceLength_Standard > 0 Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Button_Set_Race_1_Attribute = GUICtrlCreateButton("", $X_3 + 160, 182, 20, 20, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Set_Race_1_Attribute, $gfx & "Set_Attribute.bmp")
	GUICtrlSetOnEvent(-1, "_Set_Race_1_Attribute")

	;Global $Checkbox_RC_Race_2 = GUICtrlCreateCheckbox(" Race 2", $X_3, 264, 70, 15)
		;GUICtrlSetState(-1, $GUI_CHECKED)
	;$Button_Set_Race_2_Attribute = GUICtrlCreateButton("", $X_3 + 160, 261, 20, 20, $BS_BITMAP)
	;_GUICtrlButton_SetImage($Button_Set_Race_2_Attribute, $gfx & "Set_Attribute.bmp")
	;GUICtrlSetOnEvent(-1, "_Set_Race_2_Attribute")
	;GUICtrlSetState($Checkbox_RC_Race_2, $GUI_DISABLE)
	;GUICtrlSetState($Button_Set_Race_2_Attribute, $GUI_DISABLE)


	; DopDown Checkbox_RC_Training_1
	Global $Combo_Time_Training_1 = GUICtrlCreateCombo("", $X_3 + 72, 131, 83, 25) ; 77
	If $Wert_PracticeLength_Standard < 10 Then $Wert_PracticeLength_Standard = "0" & $Wert_PracticeLength_Standard
	GUICtrlSetData(-1, "---------------------" & "|" & "00 minutes|05 minutes|10 minutes|15 minutes|30 minutes|60 minutes|120 minutes", $Wert_PracticeLength_Standard & " minutes")
	GUICtrlSetOnEvent(-1, "_Combo_Time_Training_1")
	GUISetState()

	; DopDown Checkbox_RC_Training_2
	;Global $Combo_Time_Training_2 = GUICtrlCreateCombo("", $X_3 + 85, 157, 70, 25, $CBS_DROPDOWNLIST) ; 103
	;If $Wert_Practice2Length_Standard < 10 Then $Wert_Practice2Length_Standard = "0" & $Wert_Practice2Length_Standard
	;GUICtrlSetData(-1, "---------------------" & "|" & "05 minutes|10 minutes|15 minutes|30 minutes|60 minutes|120 minutes", $Wert_Practice2Length_Standard & " minutes")
	;GUICtrlSetState($Combo_Time_Training_2, $GUI_DISABLE)

	; DopDown Checkbox_RC_Qualifying
	Global $Combo_Time_Qualifying = GUICtrlCreateCombo("", $X_3 + 72, 157, 83, 25) ; 129
	If $Wert_QualifyLength_Standard < 10 Then $Wert_QualifyLength_Standard = "0" & $Wert_QualifyLength_Standard
	GUICtrlSetData(-1, "---------------------" & "|" & "00 minutes|05 minutes|10 minutes|15 minutes|30 minutes|60 minutes|120 minutes", $Wert_QualifyLength_Standard & " minutes")
	GUICtrlSetOnEvent(-1, "_Combo_Time_Qualifying")
	GUISetState()

	; DopDown Checkbox_RC_WarmUp
	;Global $Combo_Time_WarmUp = GUICtrlCreateCombo("", $X_3 + 85, 209, 70, 25, $CBS_DROPDOWNLIST) ; 155
	;GUICtrlSetData(-1, "---------------------" & "|" & "05 minute|10 minutes|15 minutes|30 minutes|60 minutes|120 minutes", "")
	;GUISetState()
	;GUICtrlSetState($Combo_Time_WarmUp, $GUI_DISABLE)

	; UPDOWN Race 1
	$Wert_UpDown_1 = 5
	Global $Wert_Race_1 = GUICtrlCreateInput($Wert_RaceLength_Standard, $X_3 + 72, 183, 83, 20) ; 181
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	$Wert_UpDpwn_Race1 = GUICtrlCreateUpdown($Wert_Race_1)
	GUICtrlSetOnEvent(-1, "_Wert_UpDpwn_Race1")

	; UPDOWN Race 2
	;$Wert_UpDown_2 = 0
	;Global $Wert_Race_2 = GUICtrlCreateInput($Wert_UpDown_2, $X_3 + 85, 261, 70, 20) ; 207
	;GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	;$Wert_UpDpwn_Race2 = GUICtrlCreateUpdown($Wert_Race_2)
	;GUICtrlSetState($Wert_Race_2, $GUI_DISABLE)
	;GUICtrlSetState($Wert_UpDpwn_Race2, $GUI_DISABLE)




	Global $Checkbox_Random_Car = GUICtrlCreateCheckbox(" Random Vehicle", $X_3, 290, 155, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Random_CAR", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	Global $Checkbox_Random_Track = GUICtrlCreateCheckbox(" Random Track", $X_3, 310, 155, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Random_TRACK", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)


	; Set Attributes Button
	Global $Button_Set_Current_Attributes_1 = GUICtrlCreateButton("Set Attributes", $X_3, 330, 180, 23, $BS_MULTILINE)
	GUICtrlSetStyle(-1, $GUI_SS_DEFAULT_BUTTON)
	GUICtrlSetBkColor(-1, 0x90EE90)
	GUICtrlSetColor(-1, 0x00008B)
	GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)
	GUICtrlSetOnEvent(-1, "_Set_Current_Attributes_1")

	Global $Button_Set_Next_Attributes_1 = GUICtrlCreateButton("Set Next Attributes", $X_3, 355, 180, 23, $BS_MULTILINE)
	GUICtrlSetStyle(-1, $GUI_SS_DEFAULT_BUTTON)
	GUICtrlSetBkColor(-1, 0x90EE90)
	GUICtrlSetColor(-1, 0x00008B)
	GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)
	GUICtrlSetOnEvent(-1, "_Set_Next_Attributes_1")



; Global $Farbe_LightSlateGray = 0x778899

	GUICtrlCreateLabel("Open PCars Web Interface for more options.", $X_3 + 5, 400, 170, 30)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)

	Global $Button_Open_WebInterface_PCDSG = GUICtrlCreateButton("Web Interface [PCDSG]", $X_3, 435, 180, 32, $BS_BITMAP)
	GUICtrlSetOnEvent(-1, "_Button_Open_WebInterface_PCDSG")
	Global $Button_Open_WebInterface_IBrowser = GUICtrlCreateButton("Web Interface [Web Browser]", $X_3, 470, 180, 32, $BS_BITMAP)
	GUICtrlSetOnEvent(-1, "_Button_Open_WebInterface_IBrowser")

	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group



	GUICtrlCreateGroup("Server Control", $X_4, 62, 330, 446)
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 9, 400, 6, $font_arial)


	Global $Checkbox_RCS_ControlGameSetup = GUICtrlCreateCheckbox(" Control Game Setup", $X_4 + 5, 79, 115, 15)
	Global $Checkbox_RCS_Lua_Track_Rotation = GUICtrlCreateCheckbox(" Lua Track Rotation", $X_4 + 5, 97, 115, 15)
	Global $Checkbox_RCS_ServerControlsTrack = GUICtrlCreateCheckbox(" Server Controls Track", $X_4 + 166, 79, 125, 15 )
	Global $Checkbox_RCS_ServerControlsVehicleClass = GUICtrlCreateCheckbox(" Server Controls Vehicle Class", $X_4 + 166, 97, 160, 15)
	Global $Checkbox_RCS_ServerControlsVehicle = GUICtrlCreateCheckbox(" Server Controls Vehicle", $X_4 + 166, 115, 130, 15)

	If $Value_Checkbox_RCS_Lua_Track_Rotation = "true" Then GUICtrlSetState($Checkbox_RCS_Lua_Track_Rotation, $GUI_CHECKED)
	If $Value_Checkbox_RCS_ControlGameSetup = "true" Then GUICtrlSetState($Checkbox_RCS_ControlGameSetup, $GUI_CHECKED)
	If $Value_Checkbox_RCS_ServerControlsTrack = "1" Then GUICtrlSetState($Checkbox_RCS_ServerControlsTrack, $GUI_CHECKED)
	If $Value_Checkbox_RCS_ServerControlsVehicleClass = "1" Then GUICtrlSetState($Checkbox_RCS_ServerControlsVehicleClass, $GUI_CHECKED)
	If $Value_Checkbox_RCS_ServerControlsVehicle = "1" Then GUICtrlSetState($Checkbox_RCS_ServerControlsVehicle, $GUI_CHECKED)

	GUICtrlSetOnEvent($Checkbox_RCS_Lua_Track_Rotation, "_Checkbox_RCS_Lua_Track_Rotation")
	GUICtrlSetOnEvent($Checkbox_RCS_ControlGameSetup, "_Checkbox_RCS_ControlGameSetup")
	GUICtrlSetOnEvent($Checkbox_RCS_ServerControlsTrack, "_Checkbox_RCS_ServerControlsTrack")
	GUICtrlSetOnEvent($Checkbox_RCS_ServerControlsVehicleClass, "_Checkbox_RCS_ServerControlsVehicleClass")
	GUICtrlSetOnEvent($Checkbox_RCS_ServerControlsVehicle, "_Checkbox_RCS_ServerControlsVehicle")


	Global $Checkbox_Flag_FILL_SESSION_WITH_AI = GUICtrlCreateCheckbox(" Fill Session with AI", $X_4 + 5, 115, 110, 15)
	GUICtrlSetOnEvent(-1, "_Checkbox_Flag_FILL_SESSION_WITH_AI")

	GUICtrlCreateLabel("Opponent Difficulty:", $X_4 + 5, 136, 115, 20) ; 525, 231, 100, 20
	GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)
	Global $Wert_Opponent_Difficulty = GUICtrlCreateInput("", $X_4 + 125, 135, 35, 20) ; 630, 228, 50, 20
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	GUICtrlSetOnEvent(-1, "_Wert_Opponent_Difficulty")


	$Button_ServerControl_MoreSettings = GUICtrlCreateButton("More Settings", $X_4 + 166, 135, 158, 20, $BS_BITMAP)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_MoreSettings")

	$Button_ServerControl_Save_1 = GUICtrlCreateButton("Apply", $X_4 + 5, 160, 60, 32, $BS_BITMAP)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_Save_1")

	$Button_ServerControl_Set_Defaults_1 = GUICtrlCreateButton("Set Defaults", $X_4 + 70, 160, 60, 32, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_Set_Defaults_1")

	$Button_ServerControl_Restore_1 = GUICtrlCreateButton("Restore Backup", $X_4 + 135, 160, 60, 32, $BS_MULTILINE)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_Restore_1")

	$Button_ServerControl_Restart_DS_1 = GUICtrlCreateButton("Apply and Restart DS", $X_4 + 200, 160, 125, 32, $BS_BITMAP)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_Restart_DS_1")












	GUICtrlCreateLabel("Lua Track Rotation Settings:", $X_4 + 5, 198, 250, 20)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)

	Global $Checkbox_RCS_Activate_MultiClass = GUICtrlCreateCheckbox(" Activate MultiClass", $X_4 + 5, 221, 130, 15)
	GUICtrlSetOnEvent(-1, "_Checkbox_RCS_Activate_MultiClass")

	$Button_ServerControl_LUA_MoreSettings = GUICtrlCreateButton("More Settings", $X_4 + 166, 218, 158, 20, $BS_BITMAP)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_LUA_MoreSettings")

	GUICtrlCreateLabel("Number of Tracks for Lua Track Rotation", $X_4 + 5, 245, 270, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_Input_NR_Of_Tracks_TrackRotation = GUICtrlCreateInput("", $X_4 + 275, 242, 50, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_UpDpwn_NR_Of_Tracks_TrackRotation")
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_UpDpwn_NR_Of_Tracks_TrackRotation = GUICtrlCreateUpdown($Wert_Input_NR_Of_Tracks_TrackRotation)
	GUICtrlSetOnEvent(-1, "_Wert_UpDpwn_NR_Of_Tracks_TrackRotation")



	GUICtrlCreateLabel("Track Nr.", $X_4 + 5, 270, 60, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_Track_Nr = GUICtrlCreateInput("", $X_4 + 70, 267, 50, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_UpDpwn_Track_Nr")
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_UpDpwn_Track_Nr = GUICtrlCreateUpdown($Wert_Track_Nr)
	GUICtrlSetOnEvent(-1, "_Wert_UpDpwn_Track_Nr")


	Global $Combo_TRACK_2 = GUICtrlCreateCombo("", $X_4 + 130, 267, 195, 20)
	;GUICtrlSetBkColor(-1, 0x5F9EA0)
	GUICtrlSetOnEvent(-1, "_Combo_TRACK_2")
	_TRACK_DropDown_2()
	;GUICtrlSetOnEvent(-1, "_Set_Track_Attribute")


	GUICtrlCreateLabel("VehicleClassId", $X_4 + 5, 298, 135, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Combo_VehicleClassId = GUICtrlCreateCombo("", $X_4 + 150, 295, 175, 20)
	GUICtrlSetOnEvent(-1, "_Combo_VehicleClassId")

	GUICtrlCreateLabel("NR of MultiClassSlots", $X_4 + 5, 323, 135, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_NR_MultiClassSlots = GUICtrlCreateInput("", $X_4 + 150, 320, 175, 20)
	Global $Wert_UpDpwn_NR_MultiClassSlots = GUICtrlCreateUpdown($Wert_NR_MultiClassSlots)
	GUICtrlSetOnEvent(-1, "_UpDpwn_NR_of_MultiClassSlots")



	GUICtrlCreateLabel("VehicleClassId Slot 1", $X_4 + 5, 346, 135, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Combo_VehicleClassId_Slot_1 = GUICtrlCreateCombo("", $X_4 + 150, 343, 175, 20)
	GUICtrlSetOnEvent(-1, "_Combo_VehicleClassId_Slot_1")

	GUICtrlCreateLabel("VehicleClassId Slot 2", $X_4 + 5, 371, 135, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Combo_VehicleClassId_Slot_2 = GUICtrlCreateCombo("", $X_4 + 150, 367, 175, 20)
	GUICtrlSetOnEvent(-1, "_Combo_VehicleClassId_Slot_2")

	GUICtrlCreateLabel("VehicleClassId Slot 3", $X_4 + 5, 395, 135, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Combo_VehicleClassId_Slot_3 = GUICtrlCreateCombo("", $X_4 + 150, 391, 175, 20)
	GUICtrlSetOnEvent(-1, "_Combo_VehicleClassId_Slot_3")



	_DropDown_VehicleClassId()



	GUICtrlCreateLabel("Training:", $X_4 + 5, 420, 90, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_Input_Training_1 = GUICtrlCreateInput("", $X_4 + 99, 417, 60, 20)
	;GUICtrlSetBkColor(-1, 0x5F9EA0) ; 0x778899 0x5F9EA0 0x708090
	GUICtrlSetOnEvent(-1, "_Wert_Input_Training_1")

	GUICtrlCreateLabel("Qualifying:", $X_4 + 175, 420, 90, 20) ; 421, 100, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_Input_Qualifying = GUICtrlCreateInput("", $X_4 + 265, 417, 60, 20) ; 120, 418, 50, 20)
	;GUICtrlSetBkColor(-1, 0x5F9EA0)
	GUICtrlSetOnEvent(-1, "_Wert_Input_Qualifying")


	GUICtrlCreateLabel("Race:", $X_4 + 5, 443, 90, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_Input_Race_1 = GUICtrlCreateInput("", $X_4 + 99, 440, 60, 20)
	;GUICtrlSetBkColor(-1, 0x5F9EA0)
	GUICtrlSetOnEvent(-1, "_Wert_Input_Race_1")


	GUICtrlCreateLabel("Roling Start:", $X_4 + 175, 443, 80, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_Input_Roling_Start = GUICtrlCreateCombo("", $X_4 + 265, 440, 60, 20)
	;GUICtrlSetBkColor(-1, 0x5F9EA0)
	GUICtrlSetOnEvent(-1, "_Wert_Input_Roling_Start")



	Global $Button_ServerControl_Save_2 = GUICtrlCreateButton("Apply", $X_4 + 5, 470, 60, 32, $BS_MULTILINE)
	GUICtrlSetStyle(-1, $GUI_SS_DEFAULT_BUTTON)
	GUICtrlSetBkColor(-1, 0x90EE90)
	GUICtrlSetColor(-1, 0x00008B)
	GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_Save_2")



	Global $Button_ServerControl_Set_Defaults_2 = GUICtrlCreateButton("Set Defaults", $X_4 + 70, 470, 60, 32, $BS_MULTILINE)
	;GUICtrlSetStyle(-1, $GUI_SS_DEFAULT_BUTTON)
	;GUICtrlSetBkColor(-1, 0x90EE90)
	;GUICtrlSetColor(-1, 0x00008B)
	GUICtrlSetFont(-1, 9, $FW_NORMAL, "", $font_2)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_Set_Defaults_2")


	Global $Button_ServerControl_Restore_Backup_2 = GUICtrlCreateButton("Restore Backup", $X_4 + 135, 470, 60, 32, $BS_MULTILINE)
	;GUICtrlSetStyle(-1, $GUI_SS_DEFAULT_BUTTON)
	;GUICtrlSetBkColor(-1, 0x90EE90)
	;GUICtrlSetColor(-1, 0x00008B)
	GUICtrlSetFont(-1, 9, $FW_NORMAL, "", $font_2)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_Restore_Backup_2")





	Global $Button_ServerControl_Restart_DS_2 = GUICtrlCreateButton("Apply and Restart DS", $X_4 + 200, 470, 125, 32, $BS_MULTILINE)
	GUICtrlSetStyle(-1, $GUI_SS_DEFAULT_BUTTON)
	GUICtrlSetBkColor(-1, 0x90EE90)
	GUICtrlSetColor(-1, 0x00008B)
	GUICtrlSetFont(-1, 9, $FW_NORMAL, "", $font_2)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_Restart_DS_4")







	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group



	If IniRead($config_ini, "Race_Control", "Checkbox_Rules_5", "") = "true" Then
		_Enable_PP_EP_Objects()
	Else
		_Disable_PP_EP_Objects()
	EndIf

	If IniRead($config_ini, "Race_Control", "Checkbox_Rules_6", "") = "true" Then
		_Enable_Server_MSG_Objects()
	Else
		_Disable_Server_MSG_Objects()
	EndIf

	If $Value_Checkbox_RCS_Lua_Track_Rotation = "false" Then
		_Disable_ServerControl_Controls()
	Else
		_Enable_ServerControl_Controls()
	EndIf

	If $Value_Checkbox_RCS_Activate_MultiClass = "false" Then
		_Disable_ServerControl_Controls_MultiClass()
	EndIf

	If FileExists($sms_rotate_config_json_File) Then
		If $Value_Checkbox_RCS_Lua_Track_Rotation = "true" Then
			_Read_sms_rotate_config_json()
		Else
			GUICtrlSetData($Anzeige_Fortschrittbalken, 100)
			Sleep(500)
		EndIf
	Else

	EndIf

	_Set_ServerControl_Objects()
	_Set_ServerControl_Objects_1()


	If IniRead($config_ini, "Server_Einstellungen", "enableHttpApi", "") = "true" Then
		_Enable_API_GameControl_Objects()
	Else
		GUICtrlCreateLabel("Set 'enableHttpApi' to 'true' to be able to use these functions.", $X_3 + 5, 225, 170, 50)
		GUICtrlSetColor(-1, "0xFF4500")
		GUICtrlSetFont(-1, 10, $FW_THIN, $GUI_FONTITALIC, $font_2)
		_Disable_API_GameControl_Objects()
	EndIf


	If $Value_Checkbox_RCS_Lua_Track_Rotation = "false" Then
		_Disable_ServerControl_Controls()
	Else
		_Enable_ServerControl_Controls()
	EndIf

	_StartUp_Update_All_Objects()

	GUISetState(@SW_SHOW)

	GUISetOnEvent($GUI_EVENT_CLOSE, "_GUI_EVENT_CLOSE")

	GUICtrlSetOnEvent($Button_Nachrichten_1, "_Button_Send_Server_Message")
	GUICtrlSetOnEvent($Button_Nachrichten_2, "_Button_Send_Private_Message")
	GUICtrlSetOnEvent($Button_Nachrichten_5, "_Button_Send_Welcome_Message")
	GUICtrlSetOnEvent($Button_Nachrichten_6, "_Button_Email_Message")
	GUICtrlSetOnEvent($Button_Nachrichten_7, "_Button_Problems_Message")
	GUICtrlSetOnEvent($Button_Nachrichten_8, "_Button_Admin_Message")
	GUICtrlSetOnEvent($Button_Nachrichten_3, "_Button_Server_Rules_Message")
	GUICtrlSetOnEvent($Button_Nachrichten_4, "_Button_ServerBest_message")

	GUICtrlSetOnEvent($Checkbox_SET_Lobby_1, "_Checkbox_SET_Lobby_1")
	GUICtrlSetOnEvent($Checkbox_SET_Lobby_2, "_Checkbox_SET_Lobby_2")
	GUICtrlSetOnEvent($Checkbox_SET_Lobby_3, "_Checkbox_SET_Lobby_3")
	GUICtrlSetOnEvent($Checkbox_SET_Lobby_4, "_Checkbox_SET_Lobby_4")
	GUICtrlSetOnEvent($Checkbox_SET_Lobby_5, "_Checkbox_SET_Lobby_5")

	GUICtrlSetOnEvent($Button_Checkbox_SET_Lobby_4, "_Button_Checkbox_SET_Lobby_4")
	GUICtrlSetOnEvent($Button_Checkbox_SET_Lobby_5, "_Button_Checkbox_SET_Lobby_5")

	GUICtrlSetOnEvent($Checkbox_SET_GameAction_1, "_Checkbox_SET_GameAction_1")
	GUICtrlSetOnEvent($Checkbox_SET_GameAction_2, "_Checkbox_SET_GameAction_2")
	GUICtrlSetOnEvent($Checkbox_SET_GameAction_3, "_Checkbox_SET_GameAction_3")
	GUICtrlSetOnEvent($Checkbox_SET_GameAction_4, "_Checkbox_SET_GameAction_4")

	GUICtrlSetOnEvent($Button_Checkbox_SET_GameAction_1, "_Button_Checkbox_SET_GameAction_1")
	GUICtrlSetOnEvent($Button_Checkbox_SET_GameAction_2, "_Button_Checkbox_SET_Lobby_4")
	GUICtrlSetOnEvent($Button_Checkbox_SET_GameAction_3, "_Button_Checkbox_SET_Lobby_5")

	GUICtrlSetOnEvent($Button_Set_AutomaticMessage_NR, "_Button_Set_AutomaticMessage_NR")
	GUICtrlSetOnEvent($Button_Delete_AutomaticMessage_NR, "_Button_Delete_AutomaticMessage_NR")


	GUICtrlSetOnEvent($Checkbox_Rules_1, "_Checkbox_Rules_1")
	GUICtrlSetOnEvent($Checkbox_Rules_2, "_Checkbox_Rules_2")
	GUICtrlSetOnEvent($Checkbox_Rules_3, "_Checkbox_Rules_3")
	GUICtrlSetOnEvent($Checkbox_Rules_4, "_Checkbox_Rules_4")
	GUICtrlSetOnEvent($Checkbox_Rules_5, "_Checkbox_Rules_5")
	GUICtrlSetOnEvent($Checkbox_Rules_6, "_Checkbox_Rules_6")
	GUICtrlSetOnEvent($Checkbox_Rules_7, "_Checkbox_Rules_7")
	GUICtrlSetOnEvent($Checkbox_Rules_8, "_Checkbox_Rules_8")

	GUICtrlSetOnEvent($Points_TrackCut_UpDown, "_UpDown_Points_TrackCut")
	GUICtrlSetOnEvent($Points_Impact_UpDown, "_UpDown_Points_Impact")

	GUICtrlSetOnEvent($Checkbox_Server_Penalties_1, "_Checkbox_Server_Penalties_1")
	GUICtrlSetOnEvent($Checkbox_Server_Penalties_2, "_Checkbox_Server_Penalties_2")

	;GUICtrlSetOnEvent($Checkbox_Server_ExperiencePoints_1, "_Checkbox_Server_ExperiencePoints_1")
	GUICtrlSetOnEvent($Checkbox_Server_ExperiencePoints_2, "_Checkbox_Server_ExperiencePoints_2")
	GUICtrlSetOnEvent($Checkbox_Server_SafetyGroups, "_Checkbox_Server_SafetyGroups")


	GUICtrlSetOnEvent($Wert_EP_for_PB, "_EP_for_PB")
	GUICtrlSetOnEvent($Wert_EP_for_SB, "_EP_for_SB")
	GUICtrlSetOnEvent($EP_UpDown_2, "_EP_UpDown_2")

	GUICtrlSetOnEvent($idRadioSG1, "_idRadioSG1")
	GUICtrlSetOnEvent($idRadioSG2, "_idRadioSG2")
	GUICtrlSetOnEvent($idRadioSG3, "_idRadioSG3")
	GUICtrlSetOnEvent($idRadioSG4, "_idRadioSG4")
	GUICtrlSetOnEvent($idRadioSG5, "_idRadioSG5")
	GUICtrlSetOnEvent($idRadioSG6, "_idRadioSG6")


	GUICtrlSetOnEvent($Button_Set_SG_Groups, "Set_Save_SG_settings")

	GUICtrlSetOnEvent($Ping_Limit_UpDown_1, "_UpDown_Checkbox_Rules_7")
	GUICtrlSetOnEvent($PP_UpDown_1, "_UpDown_Checkbox_Server_Penalties_1")
	GUICtrlSetOnEvent($PP_UpDown_2, "_UpDown_Checkbox_Server_Penalties_2")

	GUICtrlSetOnEvent($Combo_CAR, "_Car_ID_DropDown")
	GUICtrlSetOnEvent($Combo_TRACK, "_Track_ID_DropDown")

	GUICtrlSetOnEvent($Checkbox_Random_Car, "_Checkbox_Random_Car")
	GUICtrlSetOnEvent($Checkbox_Random_Track, "_Checkbox_Random_Track")

	GUICtrlSetOnEvent($Checkbox_Race_Results_Points, "_Checkbox_Race_Results_Points")
	GUICtrlSetOnEvent($Checkbox_Checkbox_RRP_Continuous_record, "_Checkbox_Checkbox_RRP_Continuous_record")
	GUICtrlSetOnEvent($Wert_UpDpwn_NR_Races, "_RRP_Wert_UpDpwn_NR_Races")
	GUICtrlSetOnEvent($Button_Edit_PointsTable, "_Button_Edit_PointsTable")
	GUICtrlSetOnEvent($Button_New_PointsTable, "_Button_New_PointsTable")


	GUICtrlSetData($Anzeige_Fortschrittbalken, 0)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

EndFunc


Func _Button_Send_Server_Message()
	$config_ini = @ScriptDir & "\config.ini"

	$GUI_2 = GUICreate("", 135, 45, 192, 124)
	GUISetIcon(@AutoItExe, -2, $GUI_2)
	$MenuItem1 = GUICtrlCreateMenu("      Choose Message     ")

	For $Schleife_1 = 1 To 10
	$Nachricht = IniRead($RaceControl_Messages_INI, "Messages", "MSG_" & $Schleife_1, "")
	If $Nachricht <> "" Then $Anzahl_Nachrichten = $Schleife_1
	Next

	$Nachricht_1 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_1", "")
	$Nachricht_2 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_2", "")
	$Nachricht_3 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_3", "")
	$Nachricht_4 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_4", "")
	$Nachricht_5 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_5", "")
	$Nachricht_6 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_6", "")
	$Nachricht_7 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_7", "")
	$Nachricht_8 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_8", "")
	$Nachricht_9 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_9", "")
	$Nachricht_10 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_10", "")

	If $Nachricht_1 <> "" Then $MenuItem1_1 = GUICtrlCreateMenuItem($Nachricht_1, $MenuItem1)
	If $Nachricht_1 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_SM_MenuItem_1")
	If $Nachricht_2 <> "" Then $MenuItem1_2 = GUICtrlCreateMenuItem($Nachricht_2, $MenuItem1)
	If $Nachricht_2 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_SM_MenuItem_2")
	If $Nachricht_3 <> "" Then $MenuItem1_3 = GUICtrlCreateMenuItem($Nachricht_3, $MenuItem1)
	If $Nachricht_3 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_SM_MenuItem_3")
	If $Nachricht_4 <> "" Then $MenuItem1_4 = GUICtrlCreateMenuItem($Nachricht_4, $MenuItem1)
	If $Nachricht_4 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_SM_MenuItem_4")
	If $Nachricht_5 <> "" Then $MenuItem1_5 = GUICtrlCreateMenuItem($Nachricht_5, $MenuItem1)
	If $Nachricht_5 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_SM_MenuItem_5")
	If $Nachricht_6 <> "" Then $MenuItem1_6 = GUICtrlCreateMenuItem($Nachricht_6, $MenuItem1)
	If $Nachricht_6 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_SM_MenuItem_6")
	If $Nachricht_7 <> "" Then $MenuItem1_7 = GUICtrlCreateMenuItem($Nachricht_7, $MenuItem1)
	If $Nachricht_7 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_SM_MenuItem_7")
	If $Nachricht_8 <> "" Then $MenuItem1_8 = GUICtrlCreateMenuItem($Nachricht_8, $MenuItem1)
	If $Nachricht_8 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_SM_MenuItem_8")
	If $Nachricht_9 <> "" Then $MenuItem1_9 = GUICtrlCreateMenuItem($Nachricht_9, $MenuItem1)
	If $Nachricht_9 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_SM_MenuItem_9")
	If $Nachricht_10 <> "" Then $MenuItem1_10 = GUICtrlCreateMenuItem($Nachricht_10, $MenuItem1)
	If $Nachricht_10 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_SM_MenuItem_10")

	$Button_Enter_Message = GUICtrlCreateButton("Write Message", 00, 0, 135, 25, $WS_GROUP)
	GUICtrlSetOnEvent(-1, "_Write_Message")
	BitOR($SS_NOTIFY,$WS_GROUP,$WS_CLIPSIBLINGS)

	GUISetState(@SW_SHOW)
EndFunc

Func _Button_Send_Private_Message()
	$config_ini = @ScriptDir & "\config.ini"

	$GUI_2 = GUICreate("", 135, 85, 192, 124)
	GUISetIcon(@AutoItExe, -2, $GUI_2)
	$MenuItem1 = GUICtrlCreateMenu("      Choose Message     ")

	$Name_Array = ""

	For $Schleife_1 = 1 To 32
		$Name_from_members = IniRead($Members_Data_INI, $Schleife_1 , "name", "")
		$RefID_from_members = IniRead($Members_Data_INI, $Schleife_1, "refid", "")

		If $Name_from_members <> "" Then
			$Name_Array = $Name_Array & "|" & $Name_from_members & "_:_" & $RefID_from_members
			If $Schleife_1 = 1 Then $Name_Array = $Name_from_members & "_:_" & $RefID_from_members
			If $Name_from_members = "" Then $Schleife_1 = 32
		EndIf
	Next

	; DopDown Checkbox_RC_Training_1
	Global $Combo_Name = GUICtrlCreateCombo("", 1, 1, 135, 25, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, "Choose Name FIRST" & "|" & $Name_Array, "Choose Name FIRST")
	GUISetState()


	$Name_Array = StringSplit($Name_Array, "|")

	For $Schleife_1 = 1 To 10
		$Nachricht = IniRead($RaceControl_Messages_INI, "Messages", "MSG_" & $Schleife_1, "")
		If $Nachricht <> "" Then $Anzahl_Nachrichten = $Schleife_1
	Next

	$Nachricht_1 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_1", "")
	$Nachricht_2 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_2", "")
	$Nachricht_3 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_3", "")
	$Nachricht_4 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_4", "")
	$Nachricht_5 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_5", "")
	$Nachricht_6 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_6", "")
	$Nachricht_7 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_7", "")
	$Nachricht_8 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_8", "")
	$Nachricht_9 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_9", "")
	$Nachricht_10 = IniRead($RaceControl_Messages_INI, "Messages", "MSG_10", "")

	If $Nachricht_1 <> "" Then $MenuItem1_1 = GUICtrlCreateMenuItem($Nachricht_1, $MenuItem1)
	If $Nachricht_1 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_PM_MenuItem_1")
	If $Nachricht_2 <> "" Then $MenuItem1_2 = GUICtrlCreateMenuItem($Nachricht_2, $MenuItem1)
	If $Nachricht_2 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_PM_MenuItem_2")
	If $Nachricht_3 <> "" Then $MenuItem1_3 = GUICtrlCreateMenuItem($Nachricht_3, $MenuItem1)
	If $Nachricht_3 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_PM_MenuItem_3")
	If $Nachricht_4 <> "" Then $MenuItem1_4 = GUICtrlCreateMenuItem($Nachricht_4, $MenuItem1)
	If $Nachricht_4 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_PM_MenuItem_4")
	If $Nachricht_5 <> "" Then $MenuItem1_5 = GUICtrlCreateMenuItem($Nachricht_5, $MenuItem1)
	If $Nachricht_5 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_PM_MenuItem_5")
	If $Nachricht_6 <> "" Then $MenuItem1_6 = GUICtrlCreateMenuItem($Nachricht_6, $MenuItem1)
	If $Nachricht_6 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_PM_MenuItem_6")
	If $Nachricht_7 <> "" Then $MenuItem1_7 = GUICtrlCreateMenuItem($Nachricht_7, $MenuItem1)
	If $Nachricht_7 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_PM_MenuItem_7")
	If $Nachricht_8 <> "" Then $MenuItem1_8 = GUICtrlCreateMenuItem($Nachricht_8, $MenuItem1)
	If $Nachricht_8 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_PM_MenuItem_8")
	If $Nachricht_9 <> "" Then $MenuItem1_9 = GUICtrlCreateMenuItem($Nachricht_9, $MenuItem1)
	If $Nachricht_9 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_PM_MenuItem_9")
	If $Nachricht_10 <> "" Then $MenuItem1_10 = GUICtrlCreateMenuItem($Nachricht_10, $MenuItem1)
	If $Nachricht_10 <> "" Then GUICtrlSetOnEvent(-1, "_Race_Control_PM_MenuItem_10")

	$Button_Enter_Message = GUICtrlCreateButton("Write Message", 00, 30, 135, 25, $WS_GROUP)
	GUICtrlSetOnEvent(-1, "_Write_Private_Message")
	BitOR($SS_NOTIFY,$WS_GROUP,$WS_CLIPSIBLINGS)

	GUISetState(@SW_SHOW)
EndFunc

Func _Button_Send_Welcome_Message()
	$Nachricht = IniRead($RaceControl_Messages_INI, "Messages", "Wellcome", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht)
EndFunc

Func _Button_Email_Message()
	$Nachricht = IniRead($RaceControl_Messages_INI, "Messages", "Email", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht)
EndFunc

Func _Button_Problems_Message()
	$Nachricht = IniRead($RaceControl_Messages_INI, "Messages", "Problems", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht)
EndFunc

Func _Button_Admin_Message()
	$Nachricht = IniRead($RaceControl_Messages_INI, "Messages", "Admin", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht)
EndFunc

Func _Button_Server_Rules_Message()
	$LOG_Event_Check_auto_MSG  = IniRead($config_ini, "Race_Control", "Checkbox_Rules_6", "")

	$Point_System_Value = IniRead($config_ini, "Race_Control", "Checkbox_Rules_5", "")
	$Panalty_Warning_Value = IniRead($config_ini, "Race_Control", "Value_Checkbox_Server_Penalties_1", "")
	$Panalty_Kick_Value = IniRead($config_ini, "Race_Control", "Value_Checkbox_Server_Penalties_2", "")
	$Penalize_TrackCut_Value = IniRead($config_ini, "Race_Control", "Checkbox_Rules_3", "")
	$Points_for_TrackCut_Value = IniRead($config_ini, "Race_Control", "Value_Points_TrackCut", "")
	$Penalize_Impact_Value = IniRead($config_ini, "Race_Control", "Checkbox_Rules_4", "")
	$Points_for_Impact_Value = IniRead($config_ini, "Race_Control", "Value_Points_Impact", "")
	$Experience_Points_max_Value = IniRead($config_ini, "Race_Control", "Value_Checkbox_ExperiencePoints_1", "")
	$PingLimit_Value = IniRead($config_ini, "Race_Control", "PingLimit", "")
	$Admin_Chat_Message_Value = "true"
	$Auto_Kick_Parking_Value = IniRead($config_ini, "Race_Control", "Checkbox_Rules_1", "")

	$Value_SG1_min_read = IniRead($config_ini, "Race_Control", "Value_SG1_min", "")
	$Value_SG2_min_read = IniRead($config_ini, "Race_Control", "Value_SG2_min", "")
	$Value_SG2_max_read = IniRead($config_ini, "Race_Control", "Value_SG2_max", "")
	$Value_SG3_min_read = IniRead($config_ini, "Race_Control", "Value_SG3_min", "")
	$Value_SG3_max_read = IniRead($config_ini, "Race_Control", "Value_SG3_max", "")
	$Value_SG4_min_read = IniRead($config_ini, "Race_Control", "Value_SG4_min", "")
	$Value_SG4_max_read = IniRead($config_ini, "Race_Control", "Value_SG4_max", "")
	$Value_SG5_min_read = IniRead($config_ini, "Race_Control", "Value_SG5_min", "")
	$Value_SG5_max_read = IniRead($config_ini, "Race_Control", "Value_SG5_max", "")

	$Auto_IDLECheck = IniRead($Server_Data_INI, "DATA", "state", "")

	If $LOG_Event_Check_auto_MSG = "true" Then
		$Message_Lobby_empty = "                        "
		$Message_Lobby_0 = "------------------------"
		$Message_Lobby_1 = "Welcome to PCDSG Server"
		$Message_Lobby_2 = "------------------------"
		$Message_Lobby_3 = "Server Rules:"
		$Message_Lobby_4 = "------------------------"
		$Message_Lobby_5 = "- Points System: --> " & $Point_System_Value
		$Message_Lobby_6 = "- Penalty Points [Warning]: --> " & $Panalty_Warning_Value & " Points"
		$Message_Lobby_7 = "- Penalty Points [Kick]: --> " & $Panalty_Kick_Value & " Points"
		$Message_Lobby_8 = "- Penalize Track Cut: --> " & $Penalize_TrackCut_Value & " - " & $Points_for_TrackCut_Value & " Points"
		$Message_Lobby_9 = "- Penalize Impact: --> " & $Penalize_Impact_Value & " - " & $Points_for_Impact_Value & " Points"
		$Message_Lobby_10 = "- Experience Points max.: --> " & $Experience_Points_max_Value
		$Message_Lobby_11 = "- Ping Limit: --> " & $PingLimit_Value
		$Message_Lobby_12 = "- Admin Commands: --> " & $Admin_Chat_Message_Value
		$Message_Lobby_13 = "- Autom. Kick parking cars: --> " & $Auto_Kick_Parking_Value
		$Message_Lobby_14 = "                        "
		$Message_Lobby_15 = "- Safety Groups:"
		$Message_Lobby_16 = "SG1: " & ">" & $Value_SG1_min_read
		$Message_Lobby_17 = "SG2: " & "> " & $Value_SG2_min_read & " - " & "< " & $Value_SG2_max_read & " EP"
		$Message_Lobby_18 = "SG3: " & "> " & $Value_SG3_min_read & " - " & "< " & $Value_SG3_max_read & " EP"
		$Message_Lobby_19 = "SG4: " & "> " & $Value_SG4_min_read & " - " & "< " & $Value_SG4_max_read & " EP"
		$Message_Lobby_20 = "SG5: " & "> " & $Value_SG5_min_read & " - " & "< " & $Value_SG5_max_read & " EP"
		$Message_Lobby_21 = "------------------------"
		$Message_Lobby_22 = "                        "

		If $Auto_IDLECheck <> "Idle" Then

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_empty
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_0
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_1
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_2
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_3
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_4
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_5
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_6
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_7
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_8
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_9
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_10
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_11
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_12
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_13
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_14
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_15
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_16
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_17
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_18
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_19
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_20
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_21
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_22
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
		EndIf
	EndIf
	Sleep(100)
EndFunc

Func _Button_ServerBest_message()
	$GUI_3 = GUICreate("", 165, 105, 350, 250)
	GUISetIcon(@AutoItExe, -2, $GUI_3)

	$font_arial = "arial"

	GUICtrlCreateLabel("Choose Car and Track", 8, 5, 165, 15) ; PCDSG folders
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
	GUICtrlSetColor(-1, "0x0000FF")
	GUICtrlSetFont(-1, 11, 400, 6, $font_arial)

	$SB_Combo_CAR = GUICtrlCreateCombo("", 5, 25, 155, 55)
	_CAR_DropDown_SB()
	$SB_Combo_TRACK = GUICtrlCreateCombo("", 5, 50, 155, 55)
	_TRACK_DropDown_SB()

	$Button_Send_Message = GUICtrlCreateButton("Send Message", 00, 75, 165, 25, $WS_GROUP)
	GUICtrlSetOnEvent(-1, "_Read_ServerBest_LapTime")
	BitOR($SS_NOTIFY,$WS_GROUP,$WS_CLIPSIBLINGS)

	GUISetState(@SW_SHOW)
EndFunc

Func _Button_Send_message_temp()
	MsgBox(0, "No Function", "Without function...placeholder...working on it." & @CRLF & @CRLF & "Cogent", 5)
EndFunc

Func _Read_ServerBest_LapTime()
	$SB_Check_Car = GUICtrlRead($SB_Combo_CAR)
	$SB_Check_Track = GUICtrlRead($SB_Combo_TRACK)

	$Check_ServerBest_Name = IniRead($ServerBest_INI, $SB_Check_Track & "_" & $SB_Check_Car, "Name", "")
	$Check_ServerBest_LapTime = IniRead($ServerBest_INI, $SB_Check_Track & "_" & $SB_Check_Car, "LapTime", "")
	$Check_ServerBest_Date = IniRead($ServerBest_INI, $SB_Check_Track & "_" & $SB_Check_Car, "Date", "")

	If $Check_ServerBest_LapTime <> "" Then
		$SB_Nachricht_0 = "     "
		$SB_Nachricht_1 = "Server Best Lap Time:"
		$SB_Nachricht_2 = "Track: " & $SB_Check_Track
		$SB_Nachricht_3 = "Car: " & $SB_Check_Car
		$SB_Nachricht_4 = "Name: " & $Check_ServerBest_Name
		$SB_Nachricht_5 = "Lap Time: " & $Check_ServerBest_LapTime
		$SB_Nachricht_6 = "Date: " & $Check_ServerBest_Date

		$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $SB_Nachricht_0
		$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
		$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $SB_Nachricht_1
		$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
		$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $SB_Nachricht_2
		$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
		$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $SB_Nachricht_3
		$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
		$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $SB_Nachricht_4
		$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
		$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $SB_Nachricht_5
		$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
		$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $SB_Nachricht_6
		$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

		_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Check_ServerBest_LapTime & " - " & "By: " & $Check_ServerBest_Name & " - " & "Date: " & $Check_ServerBest_Date)
	Else
		MsgBox(0, "SB not available", "Server Best Lap Time not available for this Track/Car combination.", 5)
	EndIf
	GUIDelete($GUI_3)
EndFunc



Func _Race_Control_SM_MenuItem_1()
	$Nachricht_1 = IniRead($config_ini, "Race_Control", "Message_1", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_1)

	GUIDelete ($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_2()
	$Nachricht_2 = IniRead($config_ini, "Race_Control", "Message_2", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_2)

	GUIDelete ($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_3()
	$Nachricht_3 = IniRead($config_ini, "Race_Control", "Message_3", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_3)

	GUIDelete ($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_4()
	$Nachricht_4 = IniRead($config_ini, "Race_Control", "Message_4", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_4
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_4)

	GUIDelete ($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_5()
	$Nachricht_5 = IniRead($config_ini, "Race_Control", "Message_5", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_5
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_5)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_6()
	$Nachricht_6 = IniRead($config_ini, "Race_Control", "Message_6", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_6
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_6)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_7()
	$Nachricht_7 = IniRead($config_ini, "Race_Control", "Message_7", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_7
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_7)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_8()
	$Nachricht_8 = IniRead($config_ini, "Race_Control", "Message_8", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_8
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_8)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_9()
	$Nachricht_9 = IniRead($config_ini, "Race_Control", "Message_9", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_9
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_9)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_10()
	$Nachricht_10 = IniRead($config_ini, "Race_Control", "Message_10", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_10
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_10)

	GUIDelete($GUI_2)
EndFunc


Func _Race_Control_PM_MenuItem_1()
	$Nachricht_1 = IniRead($config_ini, "Race_Control", "Message_1", "")

	$RefIF_send = GUICtrlRead($Combo_Name)
	If $RefIF_send = "Choose Name FIRST" Then $RefIF_send = ""

	If $RefIF_send <> "" Then
		$RefIF_send = StringSplit($RefIF_send, ":")
		$RefIF_send = StringSplit($RefIF_send[2], "_")
		$RefIF_send = $RefIF_send[2]
	EndIf

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Nachricht_1
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_1)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_PM_MenuItem_2()
	$Nachricht_2 = IniRead($config_ini, "Race_Control", "Message_2", "")

	$RefIF_send = GUICtrlRead($Combo_Name)
	If $RefIF_send = "Choose Name FIRST" Then $RefIF_send = ""

	If $RefIF_send <> "" Then
		$RefIF_send = StringSplit($RefIF_send, ":")
		$RefIF_send = StringSplit($RefIF_send[2], "_")
		$RefIF_send = $RefIF_send[2]
	EndIf

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Nachricht_2
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_2)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_PM_MenuItem_3()
	$Nachricht_3 = IniRead($config_ini, "Race_Control", "Message_3", "")

	$RefIF_send = GUICtrlRead($Combo_Name)
	If $RefIF_send = "Choose Name FIRST" Then $RefIF_send = ""

	If $RefIF_send <> "" Then
		$RefIF_send = StringSplit($RefIF_send, ":")
		$RefIF_send = StringSplit($RefIF_send[2], "_")
		$RefIF_send = $RefIF_send[2]
	EndIf

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Nachricht_3
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_3)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_PM_MenuItem_4()
	$Nachricht_4 = IniRead($config_ini, "Race_Control", "Message_4", "")

	$RefIF_send = GUICtrlRead($Combo_Name)
	If $RefIF_send = "Choose Name FIRST" Then $RefIF_send = ""

	If $RefIF_send <> "" Then
		$RefIF_send = StringSplit($RefIF_send, ":")
		$RefIF_send = StringSplit($RefIF_send[2], "_")
		$RefIF_send = $RefIF_send[2]
	EndIf

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Nachricht_4
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_4)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_PM_MenuItem_5()
	$Nachricht_5 = IniRead($config_ini, "Race_Control", "Message_5", "")

	$RefIF_send = GUICtrlRead($Combo_Name)
	If $RefIF_send = "Choose Name FIRST" Then $RefIF_send = ""

	If $RefIF_send <> "" Then
		$RefIF_send = StringSplit($RefIF_send, ":")
		$RefIF_send = StringSplit($RefIF_send[2], "_")
		$RefIF_send = $RefIF_send[2]
	EndIf

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Nachricht_5
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_5)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_PM_MenuItem_6()
	$Nachricht_6 = IniRead($config_ini, "Race_Control", "Message_6", "")

	$RefIF_send = GUICtrlRead($Combo_Name)
	If $RefIF_send = "Choose Name FIRST" Then $RefIF_send = ""

	If $RefIF_send <> "" Then
		$RefIF_send = StringSplit($RefIF_send, ":")
		$RefIF_send = StringSplit($RefIF_send[2], "_")
		$RefIF_send = $RefIF_send[2]
	EndIf

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Nachricht_6
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_6)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_PM_MenuItem_7()
	$Nachricht_7 = IniRead($config_ini, "Race_Control", "Message_7", "")

	$RefIF_send = GUICtrlRead($Combo_Name)
	If $RefIF_send = "Choose Name FIRST" Then $RefIF_send = ""

	If $RefIF_send <> "" Then
		$RefIF_send = StringSplit($RefIF_send, ":")
		$RefIF_send = StringSplit($RefIF_send[2], "_")
		$RefIF_send = $RefIF_send[2]
	EndIf

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Nachricht_7
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_7)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_PM_MenuItem_8()
	$Nachricht_8 = IniRead($config_ini, "Race_Control", "Message_8", "")

	$RefIF_send = GUICtrlRead($Combo_Name)
	If $RefIF_send = "Choose Name FIRST" Then $RefIF_send = ""

	If $RefIF_send <> "" Then
		$RefIF_send = StringSplit($RefIF_send, ":")
		$RefIF_send = StringSplit($RefIF_send[2], "_")
		$RefIF_send = $RefIF_send[2]
	EndIf

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Nachricht_8
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_8)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_PM_MenuItem_9()
	$Nachricht_9 = IniRead($config_ini, "Race_Control", "Message_9", "")

	$RefIF_send = GUICtrlRead($Combo_Name)
	If $RefIF_send = "Choose Name FIRST" Then $RefIF_send = ""

	If $RefIF_send <> "" Then
		$RefIF_send = StringSplit($RefIF_send, ":")
		$RefIF_send = StringSplit($RefIF_send[2], "_")
		$RefIF_send = $RefIF_send[2]
	EndIf

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Nachricht_9
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_9)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_PM_MenuItem_10()
	$Nachricht_10 = IniRead($config_ini, "Race_Control", "Message_10", "")

	$RefIF_send = GUICtrlRead($Combo_Name)
	If $RefIF_send = "Choose Name FIRST" Then $RefIF_send = ""

	If $RefIF_send <> "" Then
		$RefIF_send = StringSplit($RefIF_send, ":")
		$RefIF_send = StringSplit($RefIF_send[2], "_")
		$RefIF_send = $RefIF_send[2]
	EndIf

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Nachricht_10
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_10)

	GUIDelete($GUI_2)
EndFunc

Func _Write_Message()
	$Eingabe_Nachricht = InputBox ( "Nachricht eingeben", "Geben Sie die Nachricht ein die Sie absenden möchten.")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Eingabe_Nachricht
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Eingabe_Nachricht)

	GUIDelete($GUI_2)
EndFunc

Func _Write_Private_Message()
	$Eingabe_Nachricht = InputBox ( "Nachricht eingeben", "Geben Sie die Nachricht ein die Sie absenden möchten.")

	$RefIF_send = GUICtrlRead($Combo_Name)
	$RefIF_send = StringSplit($RefIF_send, ":")
	$RefIF_send = StringSplit($RefIF_send[2], "_")
	$RefIF_send = $RefIF_send[2]

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Eingabe_Nachricht
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $RefIF_send & ": " & $Eingabe_Nachricht)

	GUIDelete($GUI_2)
EndFunc

Func _Car_ID_DropDown()
	$Wert_Combo_CAR = GUICtrlRead($Combo_CAR)

	$Anzahl_Zeilen_VehicleList = _FileCountLines(@ScriptDir & "\VehicleList.txt")

	$Wert_Car = ""
	$Werte_Car = ""
	$Wert_Car_ID = ""
	$Check_Line = ""

	For $Schleife_CAR_DropDown = 7 To $Anzahl_Zeilen_VehicleList Step 5
		$Durchgang_NR = $Schleife_CAR_DropDown - 5

		$Wert_Car = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown + 1)
		$Wert_Car = StringReplace($Wert_Car, '        "name" : "', '')
		$Wert_Car = StringReplace($Wert_Car, '",', '')

		If $Wert_Combo_CAR = $Wert_Car Then
			$Wert_Car_ID = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown)
			$Wert_Car_ID = StringReplace($Wert_Car_ID, '        "id" : ', '')
			$Wert_Car_ID = StringReplace($Wert_Car_ID, ',', '')
			$Schleife_CAR_DropDown = $Anzahl_Zeilen_VehicleList
		EndIf
	Next

	_FileReadToArray($install_dir & "server.cfg", $CarList_Array)

	If FileExists($install_dir & "server.cfg") Then
		$EmptyFile = FileOpen($install_dir & "server.cfg", 2)
		FileWrite($EmptyFile, "")
		FileClose($EmptyFile)
	EndIf


	For $Schleife_CAR_ID_Write = 1 To $CarList_Array[0]
		$CFG_Line = $CarList_Array[$Schleife_CAR_ID_Write]
		$Check_Line = StringLeft($CFG_Line, 23)

		If $Check_Line = '    "VehicleModelId" : ' Then
			$CFG_Line = '    "VehicleModelId" : ' & $Wert_Car_ID & ','
		EndIf

		FileWriteLine($install_dir & "server.cfg", $CFG_Line)
	Next
EndFunc

Func _Track_ID_DropDown()
	$Wert_Combo_TRACK = GUICtrlRead($Combo_TRACK)

	$Anzahl_Zeilen_TrackList = _FileCountLines(@ScriptDir & "\TrackList.txt")

	$Wert_Track = ""
	$Wert_Track_ID = ""
	$Check_Line = ""

	For $Schleife_TRACK_ID_DropDown = 7 To $Anzahl_Zeilen_TrackList Step 5
		$Wert_Track = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_ID_DropDown + 1)
		$Wert_Track = StringReplace($Wert_Track, '        "name" : "', '')
		$Wert_Track = StringReplace($Wert_Track, '"', '')

		If $Wert_Combo_TRACK = $Wert_Track Then
			$Wert_Track_ID = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_ID_DropDown)
			$Wert_Track_ID = StringReplace($Wert_Track_ID, '        "id" : ', '')
			$Wert_Track_ID = StringReplace($Wert_Track_ID, ',', '')
			$Schleife_TRACK_ID_DropDown = $Anzahl_Zeilen_TrackList
		EndIf
	Next

	_FileReadToArray($install_dir & "server.cfg", $TrackList_Array)

	If FileExists($install_dir & "server.cfg") Then
		$EmptyFile = FileOpen($install_dir & "server.cfg", 2)
		FileWrite($EmptyFile, "")
		FileClose($EmptyFile)
	EndIf

	For $Schleife_TRACK_ID_Write = 1 To $TrackList_Array[0]
		$CFG_Line = $TrackList_Array[$Schleife_TRACK_ID_Write]
		$Check_Line = StringLeft($CFG_Line, 16)

		If $Check_Line = '    "TrackId" : ' Then
			$CFG_Line = '    "TrackId" : ' & $Wert_Track_ID & ','
		EndIf

		FileWriteLine($install_dir & "server.cfg", $CFG_Line)
	Next
EndFunc



Func _TRACK_ID_from_NAME()
	$Wert_Combo_TRACK = GUICtrlRead($Combo_TRACK)

	$Anzahl_Zeilen_TrackList = _FileCountLines(@ScriptDir & "\TrackList.txt")

	$Wert_Track = ""
	$Wert_Track_ID = ""
	$Check_Line = ""

	For $Schleife_TRACK_ID_DropDown = 7 To $Anzahl_Zeilen_TrackList Step 5
		$Wert_Track = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_ID_DropDown + 1)
		$Wert_Track = StringReplace($Wert_Track, '        "name" : "', '')
		$Wert_Track = StringReplace($Wert_Track, '"', '')
		$Wert_Track = StringReplace($Wert_Track, ',', '')
		$Wert_Track = StringReplace($Wert_Track, '}', '')

		If $Wert_Combo_TRACK = $Wert_Track Then
			$Wert_Track_ID = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_ID_DropDown)
			$Wert_Track_ID = StringReplace($Wert_Track_ID, '        "id" : ', '')
			$Wert_Track_ID = StringReplace($Wert_Track_ID, ',', '')
			IniWrite($config_ini, "Race_Control", "NextTrackID", $Wert_Track_ID)
			$Schleife_TRACK_ID_DropDown = $Anzahl_Zeilen_TrackList
		EndIf
	Next
EndFunc

Func _CAR_ID_from_NAME()
	$Wert_Combo_CAR = GUICtrlRead($Combo_CAR)

	$Anzahl_Zeilen_VehicleList = _FileCountLines(@ScriptDir & "\VehicleList.txt")

	$Wert_Car = ""
	$Wert_Car_ID = ""
	$Check_Line = ""

	For $Schleife_CAR_ID_DropDown = 7 To $Anzahl_Zeilen_VehicleList Step 5
		$Wert_Car = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_ID_DropDown + 1)
		$Wert_Car = StringReplace($Wert_Car, '        "name" : "', '')
		$Wert_Car = StringReplace($Wert_Car, '"', '')
		$Wert_Car = StringReplace($Wert_Car, ',', '')

		If $Wert_Combo_CAR = $Wert_Car Then
			$Wert_Car_ID = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_ID_DropDown)
			$Wert_Car_ID = StringReplace($Wert_Car_ID, '        "id" : ', '')
			$Wert_Car_ID = StringReplace($Wert_Car_ID, ',', '')
			IniWrite($config_ini, "Race_Control", "NextCarID", $Wert_Car_ID)
			$Schleife_CAR_ID_DropDown = $Anzahl_Zeilen_VehicleList
		EndIf
	Next
EndFunc


Func _Checkbox_Race_Results_Points()
	$Status_Checkbox = GUICtrlRead($Checkbox_Race_Results_Points)
	If $Status_Checkbox = 1 Then
		_Enable_RRP_Objects()
		_Set_RRP_Objects()
		IniWrite($config_ini, "Race_Control", "Checkbox_Race_Results_Points", "true")
	Else
		_Disable_RRP_Objects()
		_Set_RRP_Objects()
		IniWrite($config_ini, "Race_Control", "Checkbox_Race_Results_Points", "false")
	EndIf
EndFunc

Func _Checkbox_Checkbox_RRP_Continuous_record()
	$Status_Checkbox = GUICtrlRead($Checkbox_Checkbox_RRP_Continuous_record)
	If $Status_Checkbox = 1 Then
		_Disable_RRP_Objects_Continuous_record()
		_Set_RRP_Objects()
		IniWrite($config_ini, "Race_Control", "Checkbox_RRP_Continuous_record", "true")
	Else
		_Enable_RRP_Objects_Continuous_record()
		_Set_RRP_Objects()
		IniWrite($config_ini, "Race_Control", "Checkbox_RRP_Continuous_record", "false")
	EndIf
EndFunc


Func _RRP_Wert_UpDpwn_NR_Races()
	$Value_Temp = GUICtrlRead($Wert_Input_NR_Races)
	IniWrite($config_ini, "Race_Control", "RRP_Input_NR_Races", $Value_Temp)
EndFunc

Func _Button_Edit_PointsTable()
	Local $PointsTable_INI = $System_Dir & "RaceControl\RaceResultsPoints\" & "PointsTable.ini"
	If FileExists($PointsTable_INI) Then
		ShellExecute($PointsTable_INI)
	Else
		_Button_New_PointsTable()
		Sleep(200)
		ShellExecute($PointsTable_INI)
	EndIf

EndFunc

Func _Button_New_PointsTable()
	Local $PointsTable_INI = $System_Dir & "RaceControl\RaceResultsPoints\" & "PointsTable.ini"
	FileDelete($System_Dir & "RaceControl\RaceResultsPoints\" & "PointsTable.ini")
	FileCopy($install_dir & "Templates\config\" & "PointsTable.ini", $PointsTable_INI)
EndFunc


Func _Enable_RRP_Objects()
	GUICtrlSetState($Checkbox_Checkbox_RRP_Continuous_record, $GUI_ENABLE)
	GUICtrlSetState($Wert_Input_NR_Races, $GUI_ENABLE)
	GUICtrlSetState($Wert_UpDpwn_NR_Races, $GUI_ENABLE)
	GUICtrlSetState($Wert_Current_NR_Races, $GUI_ENABLE)
	GUICtrlSetState($Button_Edit_PointsTable, $GUI_ENABLE)
	GUICtrlSetState($Button_New_PointsTable, $GUI_ENABLE)
EndFunc


Func _Disable_RRP_Objects()
	GUICtrlSetState($Checkbox_Checkbox_RRP_Continuous_record, $GUI_DISABLE)
	GUICtrlSetState($Wert_Input_NR_Races, $GUI_DISABLE)
	GUICtrlSetState($Wert_UpDpwn_NR_Races, $GUI_DISABLE)
	GUICtrlSetState($Wert_Current_NR_Races, $GUI_DISABLE)
	GUICtrlSetState($Button_Edit_PointsTable, $GUI_DISABLE)
	GUICtrlSetState($Button_New_PointsTable, $GUI_DISABLE)
EndFunc

Func _Enable_RRP_Objects_Continuous_record()
	GUICtrlSetState($Wert_Input_NR_Races, $GUI_ENABLE)
	GUICtrlSetState($Wert_UpDpwn_NR_Races, $GUI_ENABLE)
	GUICtrlSetState($Wert_Current_NR_Races, $GUI_ENABLE)
	GUICtrlSetState($Button_Edit_PointsTable, $GUI_ENABLE)
	GUICtrlSetState($Button_New_PointsTable, $GUI_ENABLE)
EndFunc

Func _Disable_RRP_Objects_Continuous_record()
	GUICtrlSetState($Wert_Input_NR_Races, $GUI_DISABLE)
	GUICtrlSetState($Wert_UpDpwn_NR_Races, $GUI_DISABLE)
	;GUICtrlSetState($Button_Edit_PointsTable, $GUI_DISABLE)
	;GUICtrlSetState($Button_New_PointsTable, $GUI_DISABLE)
EndFunc

Func _Set_RRP_Objects()
	Local $Value_Input_NR_Races = IniRead($config_ini, "Race_Control", "RRP_Input_NR_Races", "")
	Local $Value_Current_NR_Races = IniRead($config_ini, "Race_Control", "RRP_Current_NR_Races", "")
	If $Value_Current_NR_Races = "" Then $Value_Current_NR_Races = "0"

	GUICtrlSetData($Wert_Input_NR_Races, $Value_Input_NR_Races)
	GUICtrlSetData($Wert_Current_NR_Races, $Value_Current_NR_Races)
EndFunc

Func _Enable_PP_EP_Objects()
	GUICtrlSetState($Checkbox_Server_Penalties_1, $GUI_ENABLE)
	GUICtrlSetState($Wert_PP_UpDown_1, $GUI_ENABLE)
	GUICtrlSetState($PP_UpDown_1, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_Server_Penalties_2, $GUI_ENABLE)
	GUICtrlSetState($Wert_PP_UpDown_2, $GUI_ENABLE)
	GUICtrlSetState($PP_UpDown_2, $GUI_ENABLE)
	GUICtrlSetState($Wert_EP_for_PB, $GUI_ENABLE)
	GUICtrlSetState($EP_UpDown_1, $GUI_ENABLE)
	GUICtrlSetState($Wert_EP_for_SB, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_Server_ExperiencePoints_2, $GUI_ENABLE)
	GUICtrlSetState($Wert_EP_UpDown_2, $GUI_ENABLE)
	GUICtrlSetState($EP_UpDown_2, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_Server_SafetyGroups, $GUI_ENABLE)

	GUICtrlSetState($idRadioSG1, $GUI_ENABLE)
	GUICtrlSetState($Value_Input_SG1_min, $GUI_ENABLE)

	GUICtrlSetState($idRadioSG2, $GUI_ENABLE)
	GUICtrlSetState($Value_Input_SG2_min, $GUI_ENABLE)
	GUICtrlSetState($Value_Input_SG2_min, $GUI_ENABLE)

	GUICtrlSetState($idRadioSG3, $GUI_ENABLE)
	GUICtrlSetState($Value_Input_SG3_min, $GUI_ENABLE)
	GUICtrlSetState($Value_Input_SG3_max, $GUI_ENABLE)

	GUICtrlSetState($idRadioSG4, $GUI_ENABLE)
	GUICtrlSetState($Value_Input_SG4_min, $GUI_ENABLE)
	GUICtrlSetState($Value_Input_SG4_max, $GUI_ENABLE)

	GUICtrlSetState($idRadioSG5, $GUI_ENABLE)
	GUICtrlSetState($Value_Input_SG5_min, $GUI_ENABLE)
	GUICtrlSetState($Value_Input_SG5_max, $GUI_ENABLE)

	GUICtrlSetState($idRadioSG6, $GUI_ENABLE)

	GUICtrlSetState($Button_Set_SG_Groups, $GUI_ENABLE)
EndFunc

Func _Disable_PP_EP_Objects()
	GUICtrlSetState($Checkbox_Server_Penalties_1, $GUI_DISABLE)
	GUICtrlSetState($Wert_PP_UpDown_1, $GUI_DISABLE)
	GUICtrlSetState($PP_UpDown_1, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_Server_Penalties_2, $GUI_DISABLE)
	GUICtrlSetState($Wert_PP_UpDown_2, $GUI_DISABLE)
	GUICtrlSetState($PP_UpDown_2, $GUI_DISABLE)
	GUICtrlSetState($Wert_EP_for_PB, $GUI_DISABLE)
	GUICtrlSetState($EP_UpDown_1, $GUI_DISABLE)
	GUICtrlSetState($Wert_EP_for_SB, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_Server_ExperiencePoints_2, $GUI_DISABLE)

	GUICtrlSetState($Wert_EP_UpDown_2, $GUI_DISABLE)
	GUICtrlSetState($EP_UpDown_2, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_Server_SafetyGroups, $GUI_DISABLE)

	GUICtrlSetState($idRadioSG1, $GUI_DISABLE)
	GUICtrlSetState($Value_Input_SG1_min, $GUI_DISABLE)

	GUICtrlSetState($idRadioSG2, $GUI_DISABLE)
	GUICtrlSetState($Value_Input_SG2_min, $GUI_DISABLE)
	GUICtrlSetState($Value_Input_SG2_max, $GUI_DISABLE)

	GUICtrlSetState($idRadioSG3, $GUI_DISABLE)
	GUICtrlSetState($Value_Input_SG3_min, $GUI_DISABLE)
	GUICtrlSetState($Value_Input_SG3_max, $GUI_DISABLE)

	GUICtrlSetState($idRadioSG4, $GUI_DISABLE)
	GUICtrlSetState($Value_Input_SG4_min, $GUI_DISABLE)
	GUICtrlSetState($Value_Input_SG4_max, $GUI_DISABLE)

	GUICtrlSetState($idRadioSG5, $GUI_DISABLE)
	GUICtrlSetState($Value_Input_SG5_min, $GUI_DISABLE)
	GUICtrlSetState($Value_Input_SG5_max, $GUI_DISABLE)

	GUICtrlSetState($idRadioSG6, $GUI_DISABLE)

	GUICtrlSetState($Button_Set_SG_Groups, $GUI_DISABLE)
EndFunc



Func _StartUp_Update_All_Objects()
	$Status_Checkbox_RRP_Continuous_record = IniRead($config_ini, "Race_Control", "Checkbox_RRP_Continuous_record", "")
	If $Status_Checkbox_RRP_Continuous_record = "true" Then
		_Disable_RRP_Objects_Continuous_record()
		_Set_RRP_Objects()
		IniWrite($config_ini, "Race_Control", "Checkbox_RRP_Continuous_record", "true")
	Else
		_Enable_RRP_Objects_Continuous_record()
		_Set_RRP_Objects()
		IniWrite($config_ini, "Race_Control", "Checkbox_RRP_Continuous_record", "false")
	EndIf
EndFunc




Func _Combo_Time_Training_1()
	$Value_Temp = GUICtrlRead($Combo_Time_Training_1)
	If $Value_Temp = "00 minutes" Then
		GUICtrlSetState($Checkbox_RC_Training_1, $GUI_UNCHECKED)
	Else
		GUICtrlSetState($Checkbox_RC_Training_1, $GUI_CHECKED)
	EndIf
EndFunc


Func _Combo_Time_Qualifying()
	$Value_Temp = GUICtrlRead($Combo_Time_Qualifying)
	If $Value_Temp = "00 minutes" Then
		GUICtrlSetState($Checkbox_RC_Qualifying, $GUI_UNCHECKED)
	Else
		GUICtrlSetState($Checkbox_RC_Qualifying, $GUI_CHECKED)
	EndIf
EndFunc

Func _Wert_UpDpwn_Race1()
	$Value_Temp = GUICtrlRead($Wert_Race_1)
	If $Value_Temp < 0 Or $Value_Temp = 0 Then
		GUICtrlSetState($Checkbox_RC_Race_1, $GUI_UNCHECKED)
		GUICtrlSetData($Wert_Race_1, 0)
	Else
		GUICtrlSetState($Checkbox_RC_Race_1, $GUI_CHECKED)
	EndIf
EndFunc




Func _Checkbox_Rules_1()
	$Status_Checkbox_Rules_1 = GUICtrlRead($Checkbox_Rules_1)
	If $Status_Checkbox_Rules_1 = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_1", "true")
	If $Status_Checkbox_Rules_1 = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_1", "false")
EndFunc

Func _Checkbox_Rules_2()
	$Status_Checkbox_Rules_2 = GUICtrlRead($Checkbox_Rules_2)
	If $Status_Checkbox_Rules_2 = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_2", "true")
	If $Status_Checkbox_Rules_2 = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_2", "false")
EndFunc

Func _Checkbox_Rules_3()
	$Status_Checkbox_Rules_3 = GUICtrlRead($Checkbox_Rules_3)
	If $Status_Checkbox_Rules_3 = 1 Then
		GUICtrlSetState($Input_Value_Points_TrackCut, $GUI_ENABLE)
		IniWrite($config_ini, "Race_Control", "Checkbox_Rules_3", "true")
	Else
		GUICtrlSetState($Input_Value_Points_TrackCut, $GUI_DISABLE)
		IniWrite($config_ini, "Race_Control", "Checkbox_Rules_3", "false")
	EndIf
EndFunc

Func _Checkbox_Rules_4()
	$Status_Checkbox_Rules_4 = GUICtrlRead($Checkbox_Rules_4)
	If $Status_Checkbox_Rules_4 = 1 Then
		GUICtrlSetState($Input_Value_Points_Impact, $GUI_ENABLE)
		IniWrite($config_ini, "Race_Control", "Checkbox_Rules_4", "true")
	Else
		GUICtrlSetState($Input_Value_Points_Impact, $GUI_DISABLE)
		IniWrite($config_ini, "Race_Control", "Checkbox_Rules_4", "false")
	EndIf
EndFunc

Func _Checkbox_Rules_5()
	$Status_Checkbox_Rules_5 = GUICtrlRead($Checkbox_Rules_5)
	If $Status_Checkbox_Rules_5 = 1 Then
		_Enable_PP_EP_Objects()
		IniWrite($config_ini, "Race_Control", "Checkbox_Rules_5", "true")
	Else
		_Disable_PP_EP_Objects()
		IniWrite($config_ini, "Race_Control", "Checkbox_Rules_5", "false")
	EndIf

EndFunc

Func _Checkbox_Rules_6()
	$Status_Checkbox_Rules_6 = GUICtrlRead($Checkbox_Rules_6)
	If $Status_Checkbox_Rules_6 = 1 Then
		_Enable_Server_MSG_Objects()
		IniWrite($config_ini, "Race_Control", "Checkbox_Rules_6", "true")
	Else
		_Disable_Server_MSG_Objects()
		IniWrite($config_ini, "Race_Control", "Checkbox_Rules_6", "false")
	EndIf

EndFunc

Func _Checkbox_Rules_7()
	$Status_Checkbox_Rules_7 = GUICtrlRead($Checkbox_Rules_7)
	If $Status_Checkbox_Rules_7 = 1 Then
		GUICtrlSetState($Wert_Ping_Limit_UpDown_1, $GUI_ENABLE)
		IniWrite($config_ini, "Race_Control", "Checkbox_Rules_7", "true")
	Else
		GUICtrlSetState($Wert_Ping_Limit_UpDown_1, $GUI_DISABLE)
		IniWrite($config_ini, "Race_Control", "Checkbox_Rules_7", "false")
	EndIf
EndFunc

Func _Checkbox_Rules_8()
	$Status_Checkbox_Rules_8 = GUICtrlRead($Checkbox_Rules_8)
	If $Status_Checkbox_Rules_8 = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_8", "true")
	If $Status_Checkbox_Rules_8 = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_8", "false")
EndFunc




Func _Enable_Server_MSG_Objects()
	GUICtrlSetState($Checkbox_SET_Lobby_1, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_SET_Lobby_2, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_SET_Lobby_3, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_SET_Lobby_4, $GUI_ENABLE)
	GUICtrlSetState($Button_Checkbox_SET_Lobby_4, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_SET_Lobby_5, $GUI_ENABLE)
	GUICtrlSetState($Button_Checkbox_SET_Lobby_5, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_SET_GameAction_1, $GUI_ENABLE)
	GUICtrlSetState($Button_Checkbox_SET_GameAction_1, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_SET_GameAction_2, $GUI_ENABLE)
	GUICtrlSetState($Button_Checkbox_SET_GameAction_2, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_SET_GameAction_3, $GUI_ENABLE)
	GUICtrlSetState($Button_Checkbox_SET_GameAction_3, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_SET_GameAction_4, $GUI_ENABLE)
	GUICtrlSetState($Check_Checkbox_SET_GameAction_4, $GUI_ENABLE)
	GUICtrlSetState($Button_Set_AutomaticMessage_NR, $GUI_ENABLE)
	GUICtrlSetState($Button_Delete_AutomaticMessage_NR, $GUI_ENABLE)
EndFunc

Func _Disable_Server_MSG_Objects()
	GUICtrlSetState($Checkbox_SET_Lobby_1, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_SET_Lobby_2, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_SET_Lobby_3, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_SET_Lobby_4, $GUI_DISABLE)
	GUICtrlSetState($Button_Checkbox_SET_Lobby_4, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_SET_Lobby_5, $GUI_DISABLE)
	GUICtrlSetState($Button_Checkbox_SET_Lobby_5, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_SET_GameAction_1, $GUI_DISABLE)
	GUICtrlSetState($Button_Checkbox_SET_GameAction_1, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_SET_GameAction_2, $GUI_DISABLE)
	GUICtrlSetState($Button_Checkbox_SET_GameAction_2, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_SET_GameAction_3, $GUI_DISABLE)
	GUICtrlSetState($Button_Checkbox_SET_GameAction_3, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_SET_GameAction_4, $GUI_DISABLE)
	GUICtrlSetState($Check_Checkbox_SET_GameAction_4, $GUI_DISABLE)
	GUICtrlSetState($Button_Set_AutomaticMessage_NR, $GUI_DISABLE)
	GUICtrlSetState($Button_Delete_AutomaticMessage_NR, $GUI_DISABLE)
EndFunc

Func _Button_Server_Strafen_2()
	MsgBox(0, "", "Select the Name in PCarsDSOverview Window and use mouse right click menu.", 4)
EndFunc


Func _Checkbox_Server_Penalties_1()
	$Status_Checkbox_Server_Penalties_1 = GUICtrlRead($Checkbox_Server_Penalties_1)

	If $Status_Checkbox_Server_Penalties_1 = 1 Then
		;MsgBox(0, "", "")
		GUICtrlSetState($PP_UpDown_1, $GUI_ENABLE)
		IniWrite($config_ini, "Race_Control", "Checkbox_Server_Penalties_1", "true")
	Else
		;MsgBox(0, "", "$GUI_UNCHECKED")
		GUICtrlSetState($PP_UpDown_1, $GUI_UNCHECKED)
		IniWrite($config_ini, "Race_Control", "Checkbox_Server_Penalties_1", "false")
	EndIf
EndFunc

Func _Checkbox_Server_Penalties_2()
	$Status_Checkbox_Server_Penalties_2 = GUICtrlRead($Checkbox_Server_Penalties_2)

	If $Status_Checkbox_Server_Penalties_2 = 1 Then
		GUICtrlSetState($Wert_PP_UpDown_2, $GUI_ENABLE)
		IniWrite($config_ini, "Race_Control", "Checkbox_Server_Penalties_2", "true")
	Else
		GUICtrlSetState($Wert_PP_UpDown_2, $GUI_UNCHECKED)
		IniWrite($config_ini, "Race_Control", "Checkbox_Server_Penalties_2", "false")
	EndIf
EndFunc

Func _UpDown_Checkbox_Rules_7()
	$Value_UpDown_Checkbox_Rules_7 = GUICtrlRead($Wert_Ping_Limit_UpDown_1)
	IniWrite($config_ini, "Race_Control", "PingLimit", $Value_UpDown_Checkbox_Rules_7)
EndFunc


Func _UpDown_Points_TrackCut()
	$Value_Points_TrackCut = GUICtrlRead($Input_Value_Points_TrackCut)
	IniWrite($config_ini, "Race_Control", "Value_Points_TrackCut", $Value_Points_TrackCut)
EndFunc

Func _UpDown_Points_Impact()
	$Value_Points_Impact = GUICtrlRead($Input_Value_Points_Impact)
	IniWrite($config_ini, "Race_Control", "Value_Points_Impact", $Value_Points_Impact)
EndFunc


Func _UpDown_Checkbox_Server_Penalties_1()
	$Value_UpDown_Checkbox_Server_Penalties_1 = GUICtrlRead($Wert_PP_UpDown_1)
	IniWrite($config_ini, "Race_Control", "Value_Checkbox_Server_Penalties_1", $Value_UpDown_Checkbox_Server_Penalties_1)
EndFunc

Func _UpDown_Checkbox_Server_Penalties_2()
	$Value_UpDown_Checkbox_Server_Penalties_2 = GUICtrlRead($Wert_PP_UpDown_2)
	IniWrite($config_ini, "Race_Control", "Value_Checkbox_Server_Penalties_2", $Value_UpDown_Checkbox_Server_Penalties_2)
EndFunc


Func _Checkbox_Server_ExperiencePoints_1()
	;$Data_Checkbox = GUICtrlRead($Checkbox_Server_ExperiencePoints_1)
	;If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
	;If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
	;IniWrite($config_ini, "Race_Control", "Checkbox_Server_ExperiencePoints_1", $Data_Checkbox)
EndFunc

Func _Checkbox_Server_ExperiencePoints_2()
	$Data_Checkbox = GUICtrlRead($Checkbox_Server_ExperiencePoints_2)
	If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
	If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
	IniWrite($config_ini, "Race_Control", "Checkbox_Server_ExperiencePoints_2", $Data_Checkbox)
EndFunc

Func _Checkbox_Server_SafetyGroups()
	$Data_Checkbox = GUICtrlRead($Checkbox_Server_SafetyGroups)
	If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
	If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
	IniWrite($config_ini, "Race_Control", "Checkbox_SafetyGroups", $Data_Checkbox)
EndFunc


Func _EP_for_PB()
	$Data_UpDown = GUICtrlRead($Wert_EP_for_PB)
	IniWrite($config_ini, "Race_Control", "ExpiriencePoints_for_PB", $Data_UpDown)
EndFunc

Func _EP_for_SB()
	$Data_UpDown = GUICtrlRead($Wert_EP_for_SB)
	IniWrite($config_ini, "Race_Control", "ExpiriencePoints_for_SB", $Data_UpDown)
EndFunc

Func _EP_UpDown_2()
	$Data_UpDown = GUICtrlRead($Wert_EP_UpDown_2)
	IniWrite($config_ini, "Race_Control", "Value_Checkbox_ExperiencePoints_2", $Data_UpDown)
EndFunc



Func _idRadioSG1()
	IniWrite($config_ini, "Race_Control", "Value_SG_entry_Limit", "SG1")
EndFunc

Func _idRadioSG2()
	IniWrite($config_ini, "Race_Control", "Value_SG_entry_Limit", "SG2")
EndFunc

Func _idRadioSG3()
	IniWrite($config_ini, "Race_Control", "Value_SG_entry_Limit", "SG3")
EndFunc

Func _idRadioSG4()
	IniWrite($config_ini, "Race_Control", "Value_SG_entry_Limit", "SG4")
EndFunc

Func _idRadioSG5()
	IniWrite($config_ini, "Race_Control", "Value_SG_entry_Limit", "SG5")
EndFunc

Func _idRadioSG6()
	IniWrite($config_ini, "Race_Control", "Value_SG_entry_Limit", "ALL")
EndFunc


Func Set_Save_SG_settings()
	$Data_SG1_min = GUICtrlRead($Value_Input_SG1_min)
	$Data_SG2_min = GUICtrlRead($Value_Input_SG2_min)
	$Data_SG2_max = GUICtrlRead($Value_Input_SG2_max)
	$Data_SG3_min = GUICtrlRead($Value_Input_SG3_min)
	$Data_SG3_max = GUICtrlRead($Value_Input_SG3_max)
	$Data_SG4_min = GUICtrlRead($Value_Input_SG4_min)
	$Data_SG4_max = GUICtrlRead($Value_Input_SG4_max)
	$Data_SG5_min = GUICtrlRead($Value_Input_SG5_min)
	$Data_SG5_max = GUICtrlRead($Value_Input_SG5_max)

	IniWrite($config_ini, "Race_Control", "Value_SG1_min", $Data_SG1_min)
	IniWrite($config_ini, "Race_Control", "Value_SG2_min", $Data_SG2_min)
	IniWrite($config_ini, "Race_Control", "Value_SG2_max", $Data_SG2_max)
	IniWrite($config_ini, "Race_Control", "Value_SG3_min", $Data_SG3_min)
	IniWrite($config_ini, "Race_Control", "Value_SG3_max", $Data_SG3_max)
	IniWrite($config_ini, "Race_Control", "Value_SG4_min", $Data_SG4_min)
	IniWrite($config_ini, "Race_Control", "Value_SG4_max", $Data_SG4_max)
	IniWrite($config_ini, "Race_Control", "Value_SG5_min", $Data_SG5_min)
	IniWrite($config_ini, "Race_Control", "Value_SG5_max", $Data_SG5_max)

	MsgBox(0, "", "SG1: " & $Data_SG1_min & @CRLF & _
					"SG2: " & $Data_SG2_min & " " & $Data_SG2_max & @CRLF & _
					"SG3: " & $Data_SG3_min & " " & $Data_SG3_max & @CRLF & _
					"SG4: " & $Data_SG4_min & " " & $Data_SG4_max & @CRLF & _
					"SG5: " & $Data_SG5_min & " " & $Data_SG5_max, 3)
EndFunc


Func _Werte_Server_CFG_Read__Backup()
	$Anzahl_Zeilen_server_cfg = _FileCountLines($install_dir & "server.cfg")

	$Wert_Car = ""
	$Check_Line_1 = ""
	$Check_Line_2 = ""
	$Wert_TrackId_Standard = ""

	For $Schleife_Server_CFG_Read = 20 To $Anzahl_Zeilen_server_cfg
		$CFG_Line = FileReadLine($install_dir & "server.cfg", $Schleife_Server_CFG_Read)
		$Check_Line = StringSplit($CFG_Line, ':', $STR_ENTIRESPLIT)
		If IsArray($Check_Line) Then $Check_Line_1 = $Check_Line[1]

		;MsgBox(0, "PracticeLength", $Check_Line_1)

		If $Check_Line[0] > 1 Then $Check_Line_2 = StringReplace($Check_Line[2], ',', '')
		$Check_Line_2 = StringReplace($Check_Line_2, ' ', '')

		If $Check_Line_1 = 'allowEmptyJoin ' Then
			If $Check_Line_2 <> "" Then Global $Wert_allowEmptyJoin_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = 'controlGameSetup ' Then
			If $Check_Line_2 <> "" Then Global $Wert_controlGameSetup_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = 'sessionAttributes ' Then
			If $Check_Line_2 <> "" Then Global $Wert_sessionAttributes_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "ServerControlsTrack" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_ServerControlsTrack_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "    "ServerControlsVehicle" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_ServerControlsVehicle_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "    "GridSize" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_GridSize_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "MaxPlayers" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_MaxPlayers_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "PracticeLength" ' Then
			MsgBox(0, "PracticeLength", $Check_Line_2)
			If $Check_Line_2 <> "" Then Global $Wert_Practice1Length_Standard = $Check_Line_2
		EndIf

		;If $Check_Line_1 = '    "Practice2Length" ' Then
			;If $Check_Line_2 <> "" Then Global $Wert_Practice2Length_Standard = $Check_Line_2
		;EndIf

		If $Check_Line_1 = '    "QualifyLength" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_QualifyLength_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "RaceLength" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_Race1Length_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "Flags" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_Flags_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "DamageType" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_DamageType_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "TireWearType" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_TireWearType_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "FuelUsageType" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_FuelUsageType_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "PenaltiesType" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_PenaltiesType_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "AllowedViews" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_AllowedViews_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "TrackId" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_TrackId_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "VehicleClassId" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_VehicleClassId_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "VehicleModelId" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_VehicleModelId_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "DateYear" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_DateYear_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "DateMonth" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_DateMonth_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "DateDay" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_DateDay_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "DateHour" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_DateHour_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "DateMinute" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_DateMinute_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "DateProgression" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_DateProgression_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "ForecastProgression" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_ForecastProgression_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "WeatherSlots" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_WeatherSlots_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "WeatherSlot1" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_WeatherSlot1_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "WeatherSlot2" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_WeatherSlot2_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "WeatherSlot3" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_WeatherSlot3_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "WeatherSlot4" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_WeatherSlot3_Standard = $Check_Line_2
		EndIf
	Next
EndFunc

Func _Werte_Server_CFG_Read()
	$Array = FileReadToArray($Dedi_config_cfg)
	$NR_Lines_config_cfg = _FileCountLines($Dedi_config_cfg) - 1

	$Wert_Car = ""
	$Check_Line_1 = ""
	$Check_Line_2 = ""
	$Wert_TrackId_Standard = ""

	For $Schleife_Server_CFG_Read = 0 To $NR_Lines_config_cfg
		Local $Wert_Line = $Array[$Schleife_Server_CFG_Read]

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'logLevel : "')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'logLevel : "', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "logLevel", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'eventsLogSize : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'eventsLogSize : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "eventsLogSize", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'name : "')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'name : "', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "name", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'secure : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'secure : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "secure", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'password : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'password : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "password", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'maxPlayerCount : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'maxPlayerCount : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "maxPlayerCount", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'bindIP : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'bindIP : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "bindIP", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'steamPort : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'steamPort : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "steamPort", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'hostPort : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'hostPort : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "hostPort", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'queryPort : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'queryPort : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "queryPort", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'sleepWaiting : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'sleepWaiting : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "sleepWaiting", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'sleepActive : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'sleepActive : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "sleepActive", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'sportsPlay : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'sportsPlay : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "sportsPlay", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'enableHttpApi : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'enableHttpApi : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "enableHttpApi", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'httpApiLogLevel : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'httpApiLogLevel : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "httpApiLogLevel", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'httpApiInterface : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'httpApiInterface : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "httpApiInterface", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'httpApiPort : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'httpApiPort : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "httpApiPort", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'staticWebFiles : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'staticWebFiles : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "staticWebFiles", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'enableLuaApi : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'enableLuaApi : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "enableLuaApi", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'luaAddonRoot : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'luaAddonRoot : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "luaAddonRoot", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'luaConfigRoot: "')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'luaConfigRoot: "', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "luaConfigRoot", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'luaOutputRoot: "')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'luaOutputRoot: "', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "luaOutputRoot", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'allowEmptyJoin : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'allowEmptyJoin : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "allowEmptyJoin", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'controlGameSetup : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, 'controlGameSetup : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "controlGameSetup", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsTrack" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "ServerControlsTrack" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "ServerControlsTrack", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsVehicleClass" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "ServerControlsVehicleClass" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "ServerControlsVehicleClass", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsVehicle" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "ServerControlsVehicle" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "ServerControlsVehicle", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "GridSize" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "GridSize" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "GridSize", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "MaxPlayers" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "MaxPlayers" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "MaxPlayers", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "PracticeLength" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "PracticeLength" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "PracticeLength", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "QualifyLength" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "QualifyLength" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "QualifyLength", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "RaceLength" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "RaceLength" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "RaceLength", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "Flags" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "Flags" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "Flags", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DamageType" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "DamageType" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "DamageType", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "TireWearType" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "TireWearType" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "TireWearType", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "FuelUsageType" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "FuelUsageType" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "FuelUsageType", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "PenaltiesType" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "PenaltiesType" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "PenaltiesType", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "AllowedViews" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "AllowedViews" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "AllowedViews", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "TrackId" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "TrackId" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "TrackId", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "VehicleClassId" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "VehicleClassId" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "VehicleClassId", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "VehicleModelId" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "VehicleModelId" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "VehicleModelId", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DateYear" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "DateYear" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "DateYear", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DateMonth" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "DateMonth" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "DateMonth", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DateDay" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "DateDay" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "DateDay", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DateHour" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "DateHour" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "DateHour", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DateMinute" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "DateMinute" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "DateMinute", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "DateProgression" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "DateProgression" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "DateProgression", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ForecastProgression" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "ForecastProgression" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "ForecastProgression", $Value_Line)
		EndIf


		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "WeatherSlots" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "WeatherSlots" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "WeatherSlots", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "WeatherSlot1" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "WeatherSlot1" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "WeatherSlot1", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "WeatherSlot2" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "WeatherSlot2" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "WeatherSlot2", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "WeatherSlot3" : ')
		If $StringInStr_Check_1 <> 0 Then
			$Value_Line = StringReplace($Wert_Line, '    "WeatherSlot3" : ', '')
			$Value_Line = StringReplace($Value_Line, '"', '')
			$Value_Line = StringReplace($Value_Line, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "WeatherSlot3", $Value_Line)
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'blackList : [ "blackList.cfg" ]')
		If $StringInStr_Check_1 <> 0 Then
			IniWrite($config_ini, "Server_Einstellungen", "Blacklist", "true")
		Else
			IniWrite($config_ini, "Server_Einstellungen", "Blacklist", "false")
		EndIf

		Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'whiteList : [ "whiteList.cfg" ]')
		If $StringInStr_Check_1 <> 0 Then
			IniWrite($config_ini, "Server_Einstellungen", "Whitelist", "true")
		Else
			IniWrite($config_ini, "Server_Einstellungen", "Whitelist", "false")
		EndIf
	Next
EndFunc

Func _Werte_Config_INI_Read()
	Global $Wert_allowEmptyJoin_Standard = IniRead($config_ini, "Server_Einstellungen", "allowEmptyJoin", "")
	Global $Wert_controlGameSetup_Standard = IniRead($config_ini, "Server_Einstellungen", "controlGameSetup", "")
	Global $Wert_sessionAttributes_Standard = ""
	Global $Wert_ServerControlsTrack_Standard = IniRead($config_ini, "Server_Einstellungen", "ServerControlsTrack", "")
	Global $Wert_ServerControlsVehicle_Standard = IniRead($config_ini, "Server_Einstellungen", "ServerControlsVehicle", "")
	Global $Wert_GridSize_Standard = IniRead($config_ini, "Server_Einstellungen", "GridSize", "")
	Global $Wert_MaxPlayers_Standard = IniRead($config_ini, "Server_Einstellungen", "maxPlayerCount", "")
	Global $Wert_PracticeLength_Standard = IniRead($config_ini, "Server_Einstellungen", "PracticeLength", "")
	Global $Wert_QualifyLength_Standard = IniRead($config_ini, "Server_Einstellungen", "QualifyLength", "")
	Global $Wert_RaceLength_Standard = IniRead($config_ini, "Server_Einstellungen", "RaceLength", "")
	Global $Wert_Flags_Standard = IniRead($config_ini, "Server_Einstellungen", "Flags", "")
	Global $Wert_DamageType_Standard = IniRead($config_ini, "Server_Einstellungen", "DamageType", "")
	Global $Wert_TireWearType_Standard = IniRead($config_ini, "Server_Einstellungen", "TireWearType", "")
	Global $Wert_FuelUsageType_Standard = IniRead($config_ini, "Server_Einstellungen", "FuelUsageType", "")
	Global $Wert_PenaltiesType_Standard = IniRead($config_ini, "Server_Einstellungen", "PenaltiesType", "")
	Global $Wert_AllowedViews_Standard = IniRead($config_ini, "Server_Einstellungen", "AllowedViews", "")
	Global $Wert_TrackId_Standard = IniRead($config_ini, "Server_Einstellungen", "TrackId", "")
	Global $Wert_VehicleClassId_Standard = IniRead($config_ini, "Server_Einstellungen", "VehicleClassId", "")
	Global $Wert_VehicleModelId_Standard = IniRead($config_ini, "Server_Einstellungen", "VehicleModelId", "")
	Global $Wert_DateYear_Standard = IniRead($config_ini, "Server_Einstellungen", "DateYear", "")
	Global $Wert_DateMonth_Standard = IniRead($config_ini, "Server_Einstellungen", "DateMonth", "")
	Global $Wert_DateDay_Standard = IniRead($config_ini, "Server_Einstellungen", "DateDay", "")
	Global $Wert_DateHour_Standard = IniRead($config_ini, "Server_Einstellungen", "DateHour", "")
	Global $Wert_DateMinute_Standard = IniRead($config_ini, "Server_Einstellungen", "DateMinute", "")
	Global $Wert_DateProgression_Standard = IniRead($config_ini, "Server_Einstellungen", "DateProgression", "")
	Global $Wert_ForecastProgression_Standard = IniRead($config_ini, "Server_Einstellungen", "ForecastProgression", "")
	Global $Wert_WeatherSlots_Standard = IniRead($config_ini, "Server_Einstellungen", "WeatherSlots", "")
	Global $Wert_WeatherSlot1_Standard = IniRead($config_ini, "Server_Einstellungen", "WeatherSlot1", "")
	Global $Wert_WeatherSlot2_Standard = IniRead($config_ini, "Server_Einstellungen", "WeatherSlot2", "")
	Global $Wert_WeatherSlot3_Standard = IniRead($config_ini, "Server_Einstellungen", "WeatherSlot3", "")
	Global $Wert_WeatherSlot3_Standard = IniRead($config_ini, "Server_Einstellungen", "WeatherSlot4", "")
EndFunc


Func _CAR_DropDown()
	$Anzahl_Zeilen_VehicleList = _FileCountLines(@ScriptDir & "\VehicleList.txt")
	$Anzahl_Zeilen_server_cfg = _FileCountLines($install_dir & "server.cfg")

	Global $Wert_Car = ""
	$Werte_Car = ""
	$Wert_Car_ID = ""
	$Check_Line = ""
	$Wert_Car_Standard = "Choose CAR"

	For $Schleife_CAR_DropDown = 7 To $Anzahl_Zeilen_VehicleList Step 5
		$Durchgang_NR = $Schleife_CAR_DropDown - 5

		$Wert_Car = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown + 1)
		$Wert_Car = StringReplace($Wert_Car, '        "name" : "', '')
		$Wert_Car = StringReplace($Wert_Car, '",', '')
		$Wert_Car = StringReplace($Wert_Car, '}', '')

		$Wert_Car_ID = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown)
		$Wert_Car_ID = StringReplace($Wert_Car_ID, '        "id" : ', '')
		$Wert_Car_ID = StringReplace($Wert_Car_ID, ',', '')

		;$Werte_Car = $Werte_Car & "|" & $Wert_Car
		If $Wert_Car <> "" Then _ArrayAdd($Array_Cars, $Wert_Car)

		;If $Wert_Car_ID = $Wert_VehicleModelId_Standard Then $Wert_Car_Standard = $Wert_Car

		;If $Durchgang_NR = 1 Then $Werte_Car = $Wert_Car
	Next

	;_ArrayDisplay($Array_Cars)
	_ArraySort($Array_Cars, 0, 1, 0, 0)

	For $Loop = 1 To UBound($Array_Cars) - 1
		$Werte_Car = $Werte_Car & "|" & $Array_Cars[$Loop]
		If $Loop = 1 Then $Werte_Car = $Array_Cars[$Loop]
	Next

	GUICtrlSetData($Combo_CAR, "Choose CAR" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Car, $Wert_Car_Standard)
	GUISetState()
	;_ArrayDisplay($Array_Cars)
EndFunc

Func _TRACK_DropDown()
	$Anzahl_Zeilen_TrackList = _FileCountLines(@ScriptDir & "\TrackList.txt")
	$Anzahl_Zeilen_server_cfg = _FileCountLines($install_dir & "server.cfg")

	$Wert_Track = ""
	$Werte_Tack = ""
	$Wert_Track_ID = ""
	$Check_Line = ""
	$Wert_Track_Standard = "Choose TRACK"

	For $Schleife_TRACK_DropDown = 7 To $Anzahl_Zeilen_TrackList Step 5
		$Durchgang_NR = $Schleife_TRACK_DropDown - 5

		$Wert_Track = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown + 1)
		$Wert_Track = StringReplace($Wert_Track, '        "name" : "', '')
		$Wert_Track = StringReplace($Wert_Track, '"', '')
		$Wert_Track = StringReplace($Wert_Track, ',', '')
		$Wert_Track = StringReplace($Wert_Track, '}', '')

		$Wert_Track_ID = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown)
		$Wert_Track_ID = StringReplace($Wert_Track_ID, '        "id" : ', '')
		$Wert_Track_ID = StringReplace($Wert_Track_ID, ',', '')

		;$Werte_Tack = $Werte_Tack & "|" & $Wert_Track
		If $Wert_Track <> "" Then _ArrayAdd($Array_Tracks, $Wert_Track)

		;If $Wert_Track_ID = $Wert_TrackId_Standard Then $Wert_Track_Standard = $Wert_Track

		;If $Durchgang_NR = 1 Then $Werte_Tack = $Wert_Track
	Next

	;_ArrayDisplay($Array_Tracks)
	_ArraySort($Array_Tracks, 0, 1, 0, 0)

	For $Loop = 1 To UBound($Array_Tracks) - 1
		$Werte_Tack = $Werte_Tack & "|" & $Array_Tracks[$Loop]
		If $Loop = 1 Then $Werte_Tack = $Array_Tracks[$Loop]
	Next

	GUICtrlSetData($Combo_TRACK, "Choose TRACK" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Tack, $Wert_Track_Standard)
	GUISetState()
	;_ArrayDisplay($Array_Tracks)
EndFunc

Func _TRACK_DropDown_2()
	$Anzahl_Zeilen_TrackList = _FileCountLines(@ScriptDir & "\TrackList.txt")
	$Anzahl_Zeilen_server_cfg = _FileCountLines($install_dir & "server.cfg")

	$Wert_Track = ""
	$Werte_Tack = ""
	$Wert_Track_ID = ""
	$Check_Line = ""
	$Wert_Track_Standard = "Choose TRACK"

	For $Schleife_TRACK_DropDown = 7 To $Anzahl_Zeilen_TrackList Step 5
		$Durchgang_NR = $Schleife_TRACK_DropDown - 5

		$Wert_Track = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown + 1)
		$Wert_Track = StringReplace($Wert_Track, '        "name" : "', '')
		$Wert_Track = StringReplace($Wert_Track, '"', '')
		$Wert_Track = StringReplace($Wert_Track, ',', '')
		$Wert_Track = StringReplace($Wert_Track, '}', '')

		$Wert_Track_ID = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown)
		$Wert_Track_ID = StringReplace($Wert_Track_ID, '        "id" : ', '')
		$Wert_Track_ID = StringReplace($Wert_Track_ID, ',', '')

		;$Werte_Tack = $Werte_Tack & "|" & $Wert_Track
		If $Wert_Track <> "" Then _ArrayAdd($Array_Tracks, $Wert_Track)

		;If $Wert_Track_ID = $Wert_TrackId_Standard Then $Wert_Track_Standard = $Wert_Track

		;If $Durchgang_NR = 1 Then $Werte_Tack = $Wert_Track
	Next

	;_ArrayDisplay($Array_Tracks)
	_ArraySort($Array_Tracks, 0, 1, 0, 0)

	For $Loop = 1 To UBound($Array_Tracks) - 1
		$Werte_Tack = $Werte_Tack & "|" & $Array_Tracks[$Loop]
		If $Loop = 1 Then $Werte_Tack = $Array_Tracks[$Loop]
	Next

	GUICtrlSetData($Combo_TRACK_2, "Choose TRACK" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Tack, $Wert_Track_Standard)
	GUISetState()
	;_ArrayDisplay($Array_Tracks)
EndFunc

Func _TRACK_DropDown_3()
	$Anzahl_Zeilen_TrackList = _FileCountLines(@ScriptDir & "\TrackList.txt")
	$Anzahl_Zeilen_server_cfg = _FileCountLines($install_dir & "server.cfg")

	$Wert_Track = ""
	$Werte_Tack = ""
	$Wert_Track_ID = ""
	$Check_Line = ""
	$Wert_Track_Standard = $Lua_Track_Name

	For $Schleife_TRACK_DropDown = 7 To $Anzahl_Zeilen_TrackList Step 5
		$Durchgang_NR = $Schleife_TRACK_DropDown - 5

		$Wert_Track = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown + 1)
		$Wert_Track = StringReplace($Wert_Track, '        "name" : "', '')
		$Wert_Track = StringReplace($Wert_Track, '"', '')
		$Wert_Track = StringReplace($Wert_Track, ',', '')
		$Wert_Track = StringReplace($Wert_Track, '}', '')

		$Wert_Track_ID = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown)
		$Wert_Track_ID = StringReplace($Wert_Track_ID, '        "id" : ', '')
		$Wert_Track_ID = StringReplace($Wert_Track_ID, ',', '')

		;$Werte_Tack = $Werte_Tack & "|" & $Wert_Track
		If $Wert_Track <> "" Then _ArrayAdd($Array_Tracks, $Wert_Track)

		;If $Wert_Track_ID = $Wert_TrackId_Standard Then $Wert_Track_Standard = $Wert_Track

		;If $Durchgang_NR = 1 Then $Werte_Tack = $Wert_Track
	Next

	;_ArrayDisplay($Array_Tracks)
	_ArraySort($Array_Tracks, 0, 1, 0, 0)

	For $Loop = 1 To UBound($Array_Tracks) - 1
		$Werte_Tack = $Werte_Tack & "|" & $Array_Tracks[$Loop]
		If $Loop = 1 Then $Werte_Tack = $Array_Tracks[$Loop]
	Next

	Local $Num_Check = StringIsDigit(StringRight($Lua_Track_Name, 1))
	If $Num_Check = 1 Then
		GUICtrlSetData($Combo_TRACK_2, $Wert_Track_Standard & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Tack, $Wert_Track_Standard)
	Else
		GUICtrlSetData($Combo_TRACK_2, "Choose TRACK" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Tack, $Wert_Track_Standard)
	EndIf

	GUISetState()
	;_ArrayDisplay($Array_Tracks)
EndFunc


Func _CAR_DropDown_SB()
	$Anzahl_Zeilen_VehicleList = _FileCountLines(@ScriptDir & "\VehicleList.txt")
	$Anzahl_Zeilen_server_cfg = _FileCountLines($install_dir & "server.cfg")

	$Wert_Car = ""
	$Werte_Car = ""
	$Wert_Car_ID = ""
	$Check_Line = ""
	$Wert_Car_Standard = "Choose CAR"

	For $Schleife_CAR_DropDown = 7 To $Anzahl_Zeilen_VehicleList Step 5
		$Durchgang_NR = $Schleife_CAR_DropDown - 5

		$Wert_Car = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown + 1)
		$Wert_Car = StringReplace($Wert_Car, '        "name" : "', '')
		$Wert_Car = StringReplace($Wert_Car, '",', '')
		$Wert_Car = StringReplace($Wert_Car, '}', '')

		$Wert_Car_ID = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown)
		$Wert_Car_ID = StringReplace($Wert_Car_ID, '        "id" : ', '')
		$Wert_Car_ID = StringReplace($Wert_Car_ID, ',', '')

		$Werte_Car = $Werte_Car & "|" & $Wert_Car

		If $Wert_Car_ID = $Wert_VehicleModelId_Standard Then $Wert_Car_Standard = $Wert_Car

		If $Durchgang_NR = 1 Then $Werte_Car = $Wert_Car
	Next

	GUICtrlSetData($SB_Combo_CAR, "Choose CAR" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Car, $Wert_Car_Standard)
	GUISetState()
EndFunc

Func _TRACK_DropDown_SB()
	$Anzahl_Zeilen_TrackList = _FileCountLines(@ScriptDir & "\TrackList.txt")
	$Anzahl_Zeilen_server_cfg = _FileCountLines($install_dir & "server.cfg")

	$Wert_Track = ""
	$Werte_Tack = ""
	$Wert_Track_ID = ""
	$Check_Line = ""
	$Wert_Track_Standard = "Choose TRACK"

	For $Schleife_TRACK_DropDown = 7 To $Anzahl_Zeilen_TrackList Step 5
		$Durchgang_NR = $Schleife_TRACK_DropDown - 5

		$Wert_Track = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown + 1)
		$Wert_Track = StringReplace($Wert_Track, '        "name" : "', '')
		$Wert_Track = StringReplace($Wert_Track, '"', '')
		$Wert_Track = StringReplace($Wert_Track, ',', '')
		$Wert_Track = StringReplace($Wert_Track, '}', '')

		$Wert_Track_ID = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown)
		$Wert_Track_ID = StringReplace($Wert_Track_ID, '        "id" : ', '')
		$Wert_Track_ID = StringReplace($Wert_Track_ID, ',', '')

		$Werte_Tack = $Werte_Tack & "|" & $Wert_Track

		If $Wert_Track_ID = $Wert_TrackId_Standard Then $Wert_Track_Standard = $Wert_Track

		If $Durchgang_NR = 1 Then $Werte_Tack = $Wert_Track
	Next
	GUICtrlSetData($SB_Combo_TRACK, "Choose TRACK" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Tack, $Wert_Track_Standard)
	GUISetState()
EndFunc


Func _Random_Car()
	$Anzahl_Zeilen_VehicleList = _FileCountLines(@ScriptDir & "\VehicleList.txt")
	$Start_Zeilen_VehicleList = Random(7, $Anzahl_Zeilen_VehicleList, 1)

	For $Schleife_VehicleList_DropDown = $Start_Zeilen_VehicleList To $Start_Zeilen_VehicleList + 5
		$Check_VehicleList_Name = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_VehicleList_DropDown)
		$Check_VehicleList_Name = StringSplit($Check_VehicleList_Name, ':', $STR_ENTIRESPLIT)

		If $Check_VehicleList_Name[1] = '        "name" ' Then
			$Wert_VehicleList = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_VehicleList_DropDown)
			$Wert_VehicleList = StringReplace($Wert_VehicleList, '        "name" : "', '')
			$Wert_VehicleList_NAME_Random = StringReplace($Wert_VehicleList, '"', '')
			$Wert_VehicleList_NAME_Random = StringReplace($Wert_VehicleList_NAME_Random, ',', '')
		EndIf
			$Wert_VehicleList_ID = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_VehicleList_DropDown - 1)
			$Wert_VehicleList_ID = StringReplace($Wert_VehicleList_ID, '        "id" : ', '')
			$Wert_VehicleList_ID = StringReplace($Wert_VehicleList_ID, ',', '')
	Next

	$Anzahl_Zeilen_VehicleList = _FileCountLines(@ScriptDir & "\VehicleList.txt")
	$Anzahl_Zeilen_server_cfg = _FileCountLines($install_dir & "server.cfg")

	$Wert_VehicleList = ""
	$Werte_VehicleList = ""
	;$Wert_Track_ID = ""
	$Check_Line = ""
	$Wert_VehicleListId_Standard = "Choose Car"

	For $Schleife_VehicleList_DropDown = 8 To $Anzahl_Zeilen_VehicleList Step 5
		$Durchgang_NR = $Schleife_VehicleList_DropDown - 6

		$Wert_VehicleList = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_VehicleList_DropDown)
		$Wert_VehicleList = StringReplace($Wert_VehicleList, '        "name" : "', '')
		$Wert_VehicleList = StringReplace($Wert_VehicleList, '"', '')
		$Wert_VehicleList = StringReplace($Wert_VehicleList, ',', '')
		$Wert_VehicleList = StringReplace($Wert_VehicleList, '}', '')

		$Werte_VehicleList= $Werte_VehicleList & "|" & $Wert_VehicleList

		If $Wert_VehicleList_ID = $Wert_VehicleListId_Standard Then $Wert_VehicleListId_Standard = $Wert_VehicleList

		If $Durchgang_NR = 1 Then $Werte_VehicleList = $Wert_VehicleList
	Next

	GUICtrlSetData($Combo_CAR, "", "")
	GUISetState()

	GUICtrlSetData($Combo_CAR, "Choose CAR" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_VehicleList, $Wert_VehicleList_NAME_Random)
	GUISetState()
EndFunc

Func _Random_Track()
	$Anzahl_Zeilen_TrackList = _FileCountLines(@ScriptDir & "\TrackList.txt")
	$Start_Zeilen_TrackList = Random(7, $Anzahl_Zeilen_TrackList, 1)

	For $Schleife_TRACK_DropDown = $Start_Zeilen_TrackList To $Start_Zeilen_TrackList + 5

		$Check_Track_Name = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown)
		$Check_Track_Name = StringSplit($Check_Track_Name, ':', $STR_ENTIRESPLIT)

		If $Check_Track_Name[1] = '        "name" ' Then
			$Wert_Track = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown)
			$Wert_Track = StringReplace($Wert_Track, '        "name" : "', '')
			$Wert_Track_NAME_Random = StringReplace($Wert_Track, '"', '')
			$Wert_Track_NAME_Random = StringReplace($Wert_Track_NAME_Random, ',', '')
		EndIf
		$Check_ID_Name = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown)
		$Check_ID_Name = StringSplit($Check_ID_Name, ':', $STR_ENTIRESPLIT)

		If $Check_ID_Name[1] = '        "id" ' Then ; ändern in -->        "id"
			$Wert_Track_ID = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown - 1)
			$Wert_Track_ID = StringReplace($Wert_Track_ID, '        "id" : ', '')
			$Wert_Track_ID = StringReplace($Wert_Track_ID, ',', '')
		EndIf
	Next

	$Anzahl_Zeilen_TrackList = _FileCountLines(@ScriptDir & "\TrackList.txt")
	$Anzahl_Zeilen_server_cfg = _FileCountLines($install_dir & "server.cfg")

	$Wert_Track = ""
	$Werte_Tack = ""
	$Check_Line = ""
	$Wert_Track_Standard = "Choose TRACK"

	For $Schleife_TRACK_DropDown = 8 To $Anzahl_Zeilen_TrackList Step 5

	$Durchgang_NR = $Schleife_TRACK_DropDown - 5

	$Wert_Track = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown)
	$Wert_Track = StringReplace($Wert_Track, '        "name" : "', '')
	$Wert_Track = StringReplace($Wert_Track, '"', '')
	$Wert_Track = StringReplace($Wert_Track, ',', '')
	$Wert_Track = StringReplace($Wert_Track, '}', '')

	$Werte_Tack = $Werte_Tack & "|" & $Wert_Track

	If $Wert_Track_ID = $Wert_TrackId_Standard Then $Wert_Track_Standard = $Wert_Track

	If $Durchgang_NR = 1 Then $Werte_Tack = $Wert_Track

	Next

	GUICtrlSetData($Combo_TRACK, "", "")
	GUISetState()

	GUICtrlSetData($Combo_TRACK, "Choose TRACK" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Tack, $Wert_Track_NAME_Random)
	GUISetState()
EndFunc


Func _Checkbox_Random_Car()
	$Status_Checkbox_Random_Car = GUICtrlRead($Checkbox_Random_Car)
	If $Status_Checkbox_Random_Car = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_Random_CAR", "true")
	If $Status_Checkbox_Random_Car = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_Random_CAR", "false")
EndFunc

Func _Checkbox_Random_Track()
	$Status_Checkbox_Random_Track = GUICtrlRead($Checkbox_Random_Track)
	If $Status_Checkbox_Random_Track = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_Random_TRACK", "true")
	If $Status_Checkbox_Random_Track = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_Random_TRACK", "false")
EndFunc


Func _Checkbox_SET_Lobby_1()
	$Status_Checkbox_SET_Lobby = GUICtrlRead($Checkbox_SET_Lobby_1)
	If $Status_Checkbox_SET_Lobby = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_Lobby1", "true")
	If $Status_Checkbox_SET_Lobby = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_Lobby1", "false")
EndFunc

Func _Checkbox_SET_Lobby_2()
	$Status_Checkbox_SET_Lobby = GUICtrlRead($Checkbox_SET_Lobby_2)
	If $Status_Checkbox_SET_Lobby = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_Lobby2", "true")
	If $Status_Checkbox_SET_Lobby = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_Lobby2", "false")
EndFunc

Func _Checkbox_SET_Lobby_3()
	$Status_Checkbox_SET_Lobby = GUICtrlRead($Checkbox_SET_Lobby_3)
	If $Status_Checkbox_SET_Lobby = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_Lobby3", "true")
	If $Status_Checkbox_SET_Lobby = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_Lobby3", "false")
EndFunc

Func _Checkbox_SET_Lobby_4()
	$Status_Checkbox_SET_Lobby = GUICtrlRead($Checkbox_SET_Lobby_4)
	If $Status_Checkbox_SET_Lobby = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_Lobby4", "true")
	If $Status_Checkbox_SET_Lobby = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_Lobby4", "false")
EndFunc

Func _Checkbox_SET_Lobby_5()
	$Status_Checkbox_SET_Lobby = GUICtrlRead($Checkbox_SET_Lobby_5)
	If $Status_Checkbox_SET_Lobby = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_Lobby5", "true")
	If $Status_Checkbox_SET_Lobby = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_Lobby5", "false")
EndFunc

Func _Button_Checkbox_SET_Lobby_4()
	$Input_Row_1 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_1", "")
	$Input_Row_2 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_2", "")
	$Input_Row_3 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_3", "")
	$Input_Row_4 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_4", "")
	$Input_Row_5 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_5", "")
	$Input_Row_6 = "Click 'OK' to continue."
	$Input_Row_7 = "Let it empty if you don't want to change it."

	$Abfrage = MsgBox(4, "LOBBY - Send Web Page Info message", "Current Message:" & @CRLF & @CRLF & "ROW 1 = " & $Input_Row_1 & @CRLF & "ROW 2 = " & $Input_Row_2 & @CRLF & "ROW 3 = " & $Input_Row_3 & @CRLF & "ROW 4 = " & $Input_Row_4 & @CRLF & "ROW 5 = " & $Input_Row_5& @CRLF & @CRLF & "Do you want to change it?")

	If $Abfrage = 6 Then
		For $Loop = 1 To 5
			$Input_Row_1 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_1", "")
			$Input_Row_2 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_2", "")
			$Input_Row_3 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_3", "")
			$Input_Row_4 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_4", "")
			$Input_Row_5 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_5", "")
			$Input = InputBox ( "ROW " & $Loop, "Enter message for Row " & $Loop & @CRLF & @CRLF & "ROW 1 = " & $Input_Row_1 & @CRLF & "ROW 2 = " & $Input_Row_2 & @CRLF & "ROW 3 = " & $Input_Row_3 & @CRLF & "ROW 4 = " & $Input_Row_4 & @CRLF & "ROW 5 = " & $Input_Row_5 & @CRLF & @CRLF & $Input_Row_6 & @CRLF & $Input_Row_7, "", "", -1, 310)
			If $Input <> "" Then IniWrite($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_" & $Loop, $Input)
		Next
	EndIf
EndFunc

Func _Button_Checkbox_SET_Lobby_5()
	$Input_Row_1 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "ROW_1", "")
	$Input_Row_2 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "ROW_2", "")
	$Input_Row_3 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "ROW_3", "")
	$Input_Row_4 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "ROW_4", "")
	$Input_Row_5 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "ROW_5", "")
	$Input_Row_6 = "Click 'OK' to continue."
	$Input_Row_7 = "Let it empty if you don't want to change it."

	$Abfrage = MsgBox(4, "LOBBY - Send Next Event Info message", "Current Message:" & @CRLF & @CRLF & "ROW 1 = " & $Input_Row_1 & @CRLF & "ROW 2 = " & $Input_Row_2 & @CRLF & "ROW 3 = " & $Input_Row_3 & @CRLF & "ROW 4 = " & $Input_Row_4 & @CRLF & "ROW 5 = " & $Input_Row_5& @CRLF & @CRLF & "Do you want to change it?")

	If $Abfrage = 6 Then
		For $Loop = 1 To 5
			$Input_Row_1 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "ROW_1", "")
			$Input_Row_2 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "ROW_2", "")
			$Input_Row_3 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "ROW_3", "")
			$Input_Row_4 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "ROW_4", "")
			$Input_Row_5 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "ROW_5", "")
			$Input = InputBox ( "ROW " & $Loop, "Enter message for Row " & $Loop & @CRLF & @CRLF & "ROW 1 = " & $Input_Row_1 & @CRLF & "ROW 2 = " & $Input_Row_2 & @CRLF & "ROW 3 = " & $Input_Row_3 & @CRLF & "ROW 4 = " & $Input_Row_4 & @CRLF & "ROW 5 = " & $Input_Row_5 & @CRLF & @CRLF & $Input_Row_6 & @CRLF & $Input_Row_7, "", "", -1, 270)
			If $Input <> "" Then IniWrite($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "ROW_" & $Loop, $Input)
		Next
	EndIf
EndFunc

Func _Checkbox_SET_GameAction_1()
	$Status_Checkbox_SET_GameAction = GUICtrlRead($Checkbox_SET_GameAction_1)
	If $Status_Checkbox_SET_GameAction = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_GameAction_1", "true")
	If $Status_Checkbox_SET_GameAction = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_GameAction_1", "false")
EndFunc

Func _Checkbox_SET_GameAction_2()
	$Status_Checkbox_SET_GameAction = GUICtrlRead($Checkbox_SET_GameAction_2)
	If $Status_Checkbox_SET_GameAction = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_GameAction_2", "true")
	If $Status_Checkbox_SET_GameAction = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_GameAction_2", "false")
EndFunc

Func _Checkbox_SET_GameAction_3()
	$Status_Checkbox_SET_GameAction = GUICtrlRead($Checkbox_SET_GameAction_3)
	If $Status_Checkbox_SET_GameAction = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_GameAction_3", "true")
	If $Status_Checkbox_SET_GameAction = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_GameAction_3", "false")
EndFunc

Func _Checkbox_SET_GameAction_4()
	$Status_Checkbox_SET_GameAction = GUICtrlRead($Checkbox_SET_GameAction_4)
	If $Status_Checkbox_SET_GameAction = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_GameAction_4", "true")
	If $Status_Checkbox_SET_GameAction = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_SET_GameAction_4", "false")
EndFunc

Func _Button_Checkbox_SET_GameAction_1()
	$Input_Row_1 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_1", "")
	$Input_Row_2 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_2", "")
	$Input_Row_3 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_3", "")
	$Input_Row_4 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_4", "")
	$Input_Row_5 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_5", "")
	$Input_Row_6 = "Click 'OK' to continue."
	$Input_Row_7 = "Let it empty if you don't want to change it."

	$Abfrage = MsgBox(4, "Game - Send Fair Play message", "Current Message:" & @CRLF & @CRLF & "ROW 1 = " & $Input_Row_1 & @CRLF & "ROW 2 = " & $Input_Row_2 & @CRLF & "ROW 3 = " & $Input_Row_3 & @CRLF & "ROW 4 = " & $Input_Row_4 & @CRLF & "ROW 5 = " & $Input_Row_5& @CRLF & @CRLF & "Do you want to change it?")

	If $Abfrage = 6 Then
		For $Loop = 1 To 5
			$Input_Row_1 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_1", "")
			$Input_Row_2 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_2", "")
			$Input_Row_3 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_3", "")
			$Input_Row_4 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_4", "")
			$Input_Row_5 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_5", "")
			$Input = InputBox ( "ROW " & $Loop, "Enter message for Row " & $Loop & @CRLF & @CRLF & "ROW 1 = " & $Input_Row_1 & @CRLF & "ROW 2 = " & $Input_Row_2 & @CRLF & "ROW 3 = " & $Input_Row_3 & @CRLF & "ROW 4 = " & $Input_Row_4 & @CRLF & "ROW 5 = " & $Input_Row_5 & @CRLF & @CRLF & $Input_Row_6 & @CRLF & $Input_Row_7, "", "", -1, 290)
			If $Input <> "" Then IniWrite($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_" & $Loop, $Input)
		Next
	EndIf
EndFunc


Func _Button_Set_AutomaticMessage_NR()
	MsgBox(0, "Set / Save", "Not in use, working on it...")
EndFunc


Func _Button_Delete_AutomaticMessage_NR()
	IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_1_send", "")
	IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_2_send", "")
	IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_3_send", "")
	IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_4_send", "")
EndFunc



Func _Set_Car_Attribute()

	$Check_controlGameSetup = IniRead($config_ini, "Server_Einstellungen", "controlGameSetup", "")
	$Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")

	If $Check_controlGameSetup = "true" Then

		If $Auto_LobbyCheck = "Lobby" Then
			GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

			$Status_Checkbox_Random_Car = GUICtrlRead($Checkbox_Random_Car)
			$Status_Checkbox_Random_Car_Track = GUICtrlRead($Checkbox_Random_Track)

			If $Status_Checkbox_Random_Car = 1 Then
				_Random_Car()
			EndIf

			$Check_CAR = ""
			$Check_CAR = GUICtrlRead($Combo_CAR)

			$NextCarName = $Check_CAR

			GUICtrlSetData($Anzeige_Fortschrittbalken, 40)

			_CAR_ID_from_NAME()

			$NextCarID = IniRead($config_ini, "Race_Control", "NextCarID", "")

			;MsgBox(0, "$NextCarID", $NextCarID)

			If $Check_CAR <> "" Then $RC_Attribute = 'session_VehicleModelId=' & $NextCarID

			IniWrite($config_ini, "Race_Control", "NextCarName", $NextCarName)
			IniWrite($config_ini, "Race_Control", "NextCarID", $NextCarID)

			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $RC_Attribute
			$download = InetGet($URL, @ScriptDir & "\Attributes.txt", 16, 0)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 80)

			$Nachricht_0 = " "
			$Nachricht_1 = "PCDSG: New Attribute set"
			$Nachricht_2 = "Vehicle Name: " & $NextCarName
			$Nachricht_3 = "Vehicle ID" & $Wert_Car_ID


			If FileExists(@ScriptDir & "\Message.txt") Then FileDelete(@ScriptDir & "\Message.txt")

			$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_0
			$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

			If FileExists(@ScriptDir & "\Message.txt") Then
				$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
				$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

				$URL_3 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
				$download = InetGet($URL_3, @ScriptDir & "\Message.txt", 16, 0)

				$URL_4 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
				$download = InetGet($URL_4, @ScriptDir & "\Message.txt", 16, 0)

				GUICtrlSetData($Anzeige_Fortschrittbalken, 100)

				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & $Nachricht_2 & "|" & $Nachricht_3)
			Else
				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & "Error ..." & "Not able to set Attrributes ..." & "Maybe Server or Internet Connection OFFLINE?")
			EndIf
			Sleep(1000)
			GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
		Else
			MsgBox(0, "Wrong DS Session State", "This function can only be used in the Lobby.", 5)
		EndIf
	Else
		MsgBox(0, "controlGameSetup", "ControlGameSetup needs to be activated to be able to use this controls." & @CRLF & @CRLF & _
										"Change the controlGameSetup option in 'Server Settings' TAB of PCDSG"  & @CRLF & _
										"or change it manually in your 'server.cfg' File." & @CRLF & @CRLF & _
										"controlGameSetup : true")
	EndIf
EndFunc

Func _Set_Track_Attribute()

	$Check_controlGameSetup = IniRead($config_ini, "Server_Einstellungen", "controlGameSetup", "")
	$Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")

	If $Check_controlGameSetup = "true" Then

		If $Auto_LobbyCheck = "Lobby" Then
			GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

			$Status_Checkbox_Random_Car = GUICtrlRead($Checkbox_Random_Car)
			$Status_Checkbox_Random_Car_Track = GUICtrlRead($Checkbox_Random_Track)

			If $Status_Checkbox_Random_Car_Track = 1 Then
				_Random_Track()
			EndIf

			$Check_TRACK = ""
			$Check_TRACK = GUICtrlRead($Combo_TRACK)

			$NextTrackName = $Check_TRACK

			GUICtrlSetData($Anzeige_Fortschrittbalken, 40)

			_TRACK_ID_from_NAME()

			$NextTrackID = IniRead($config_ini, "Race_Control", "NextTrackID", "")
			If $Check_TRACK <> "" Then $RC_Attribute = 'session_TrackId=' & $NextTrackID

			IniWrite($config_ini, "Race_Control", "NextTrackID", $NextTrackID)

			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $RC_Attribute
			$download = InetGet($URL, @ScriptDir & "\Attributes.txt", 16, 0)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 80)

			$Nachricht_0 = " "
			$Nachricht_1 = "PCDSG: New Attribute set"
			$Nachricht_2 = "Track Name: " & $NextTrackName
			$Nachricht_3 = "Track ID: " & $Wert_Track_ID


			If FileExists(@ScriptDir & "\Message.txt") Then FileDelete(@ScriptDir & "\Message.txt")

			$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_0
			$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

			If FileExists(@ScriptDir & "\Message.txt") Then
				$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
				$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

				$URL_3 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
				$download = InetGet($URL_3, @ScriptDir & "\Message.txt", 16, 0)

				$URL_4 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
				$download = InetGet($URL_4, @ScriptDir & "\Message.txt", 16, 0)

				GUICtrlSetData($Anzeige_Fortschrittbalken, 100)

				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & $Nachricht_2 & "|" & $Nachricht_3)
			Else
				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & "Error ..." & "Not able to set Attrributes ..." & "Maybe Server or Internet Connection OFFLINE?")
			EndIf
			Sleep(1000)
			GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
		Else
			MsgBox(0, "Wrong DS Session State", "This function can only be used in the Lobby.", 5)
		EndIf
	Else
		MsgBox(0, "controlGameSetup", "ControlGameSetup needs to be activated to be able to use this controls." & @CRLF & @CRLF & _
										"Change the controlGameSetup option in 'Server Settings' TAB of PCDSG"  & @CRLF & _
										"or change it manually in your 'server.cfg' File." & @CRLF & @CRLF & _
										"controlGameSetup : true")
	EndIf
EndFunc


Func _Set_Training_1_Attribute()
	$Check_controlGameSetup = IniRead($config_ini, "Server_Einstellungen", "controlGameSetup", "")
	$Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")

	If $Check_controlGameSetup = "true" Then
		If $Auto_LobbyCheck = "Lobby" Then
			GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 40)

			$Check_Training_1 = GUICtrlRead($Checkbox_RC_Training_1)
			If $Check_Training_1 = "1" Then $Check_Training_1 = StringLeft(GUICtrlRead($Combo_Time_Training_1), 2)
			If $Check_Training_1 = "4" Then $Check_Training_1 = ""
			$iLength = StringLen(GUICtrlRead($Combo_Time_Training_1))
			If $iLength = "11" Then $Check_Training_1 = "120"

			If $Check_Training_1 <> "" Then
				$RC_Attribute = 'session_PracticeLength=' & $Check_Training_1

				$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $RC_Attribute
				$download = InetGet($URL, @ScriptDir & "\Attributes.txt", 16, 0)

				GUICtrlSetData($Anzeige_Fortschrittbalken, 80)

				$Nachricht_0 = " "
				$Nachricht_1 = "PCDSG: New Attribute set"
				$Nachricht_2 = "Training length: " & $Check_Training_1 & " Min."
				$Nachricht_3 = " "

				If FileExists(@ScriptDir & "\Message.txt") Then FileDelete(@ScriptDir & "\Message.txt")

				$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_0
				$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

				If FileExists(@ScriptDir & "\Message.txt") Then
					$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
					$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

					$URL_3 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
					$download = InetGet($URL_3, @ScriptDir & "\Message.txt", 16, 0)

					$URL_4 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
					$download = InetGet($URL_4, @ScriptDir & "\Message.txt", 16, 0)

					GUICtrlSetData($Anzeige_Fortschrittbalken, 100)

					_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & $Nachricht_2 & "|" & $Nachricht_3)
				Else
					_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & "Error ..." & "Not able to set Attrributes ..." & "Maybe Server or Internet Connection OFFLINE?")
				EndIf
				Sleep(1000)
				GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
			EndIf
			GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
		Else
			MsgBox(0, "Wrong DS Session State", "This function can only be used in the Lobby.", 5)
		EndIf
	Else
		MsgBox(0, "controlGameSetup", "ControlGameSetup needs to be activated to be able to use this controls." & @CRLF & @CRLF & _
										"Change the controlGameSetup option in 'Server Settings' TAB of PCDSG"  & @CRLF & _
										"or change it manually in your 'server.cfg' File." & @CRLF & @CRLF & _
										"controlGameSetup : true")
	EndIf
EndFunc

Func _Set_Training_2_Attribute()
	Local $Checkbox_RC_Training_2, $Combo_Time_Training_2
	$Check_controlGameSetup = IniRead($config_ini, "Server_Einstellungen", "controlGameSetup", "")
	$Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")

	If $Check_controlGameSetup = "true" Then
		If $Auto_LobbyCheck = "Lobby" Then
			GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 40)

			$Check_Training_2 = GUICtrlRead($Checkbox_RC_Training_2)
			If $Check_Training_2 = "1" Then $Check_Training_2 = StringLeft(GUICtrlRead($Combo_Time_Training_2), 2)
			If $Check_Training_2 = "4" Then $Check_Training_2 = ""
			$iLength = StringLen(GUICtrlRead($Combo_Time_Training_2))
			If $iLength = "11" Then $Check_Training_2 = "120"

			If $Check_Training_2 <> "" Then $RC_Attribute = 'session_Practice2Length=' & $Check_Training_2

			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $RC_Attribute
			$download = InetGet($URL, @ScriptDir & "\Attributes.txt", 16, 0)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 80)

			$Nachricht_0 = " "
			$Nachricht_1 = "PCDSG: New Attribute set"
			$Nachricht_2 = "Training length: " & $Check_Training_2 & " Min."
			$Nachricht_3 = " "

			If FileExists(@ScriptDir & "\Message.txt") Then FileDelete(@ScriptDir & "\Message.txt")

			$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_0
			$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

			If FileExists(@ScriptDir & "\Message.txt") Then
				$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
				$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

				$URL_3 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
				$download = InetGet($URL_3, @ScriptDir & "\Message.txt", 16, 0)

				$URL_4 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
				$download = InetGet($URL_4, @ScriptDir & "\Message.txt", 16, 0)

				GUICtrlSetData($Anzeige_Fortschrittbalken, 100)

				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & $Nachricht_2 & "|" & $Nachricht_3)
			Else
				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & "Error ..." & "Not able to set Attrributes ..." & "Maybe Server or Internet Connection OFFLINE?")
			EndIf
			Sleep(1000)
			GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
		Else
			MsgBox(0, "Wrong DS Session State", "This function can only be used in the Lobby.", 5)
		EndIf
	Else
		MsgBox(0, "controlGameSetup", "ControlGameSetup needs to be activated to be able to use this controls." & @CRLF & @CRLF & _
										"Change the controlGameSetup option in 'Server Settings' TAB of PCDSG"  & @CRLF & _
										"or change it manually in your 'server.cfg' File." & @CRLF & @CRLF & _
										"controlGameSetup : true")
	EndIf
EndFunc

Func _Set_Qualifying_Attribute()
	$Check_controlGameSetup = IniRead($config_ini, "Server_Einstellungen", "controlGameSetup", "")
	$Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")

	If $Check_controlGameSetup = "true" Then
		If $Auto_LobbyCheck = "Lobby" Then
			GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 40)

			$Check_Qualifying = GUICtrlRead($Checkbox_RC_Qualifying)
			If $Check_Qualifying = "1" Then $Check_Qualifying = StringLeft(GUICtrlRead($Combo_Time_Qualifying), 2)
			If $Check_Qualifying = "4" Then $Check_Qualifying = ""
			$iLength = StringLen(GUICtrlRead($Combo_Time_Qualifying))
			If $iLength = "11" Then $Check_Qualifying = "120"

			If $Check_Qualifying <> "" Then $RC_Attribute = 'session_QualifyLength=' & $Check_Qualifying

			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $RC_Attribute
			$download = InetGet($URL, @ScriptDir & "\Attributes.txt", 16, 0)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 80)

			$Nachricht_0 = " "
			$Nachricht_1 = "PCDSG: New Attribute set"
			$Nachricht_2 = "Qualifying length: " & $Check_Qualifying & " Min."
			$Nachricht_3 = " "

			If FileExists(@ScriptDir & "\Message.txt") Then FileDelete(@ScriptDir & "\Message.txt")

			$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_0
			$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

			If FileExists(@ScriptDir & "\Message.txt") Then
				$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
				$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

				$URL_3 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
				$download = InetGet($URL_3, @ScriptDir & "\Message.txt", 16, 0)

				$URL_4 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
				$download = InetGet($URL_4, @ScriptDir & "\Message.txt", 16, 0)

				GUICtrlSetData($Anzeige_Fortschrittbalken, 100)

				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & $Nachricht_2 & "|" & $Nachricht_3)
			Else
				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & "Error ..." & "Not able to set Attrributes ..." & "Maybe Server or Internet Connection OFFLINE?")
			EndIf
			Sleep(1000)
			GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
		Else
			MsgBox(0, "Wrong DS Session State", "This function can only be used in the Lobby.", 5)
		EndIf
	Else
		MsgBox(0, "controlGameSetup", "ControlGameSetup needs to be activated to be able to use this controls." & @CRLF & @CRLF & _
										"Change the controlGameSetup option in 'Server Settings' TAB of PCDSG"  & @CRLF & _
										"or change it manually in your 'server.cfg' File." & @CRLF & @CRLF & _
										"controlGameSetup : true")
	EndIf
EndFunc

Func _Set_WarmUp_Attribute()
	Local $Checkbox_RC_WarmUp, $Combo_Time_WarmUp
	$Check_controlGameSetup = IniRead($config_ini, "Server_Einstellungen", "controlGameSetup", "")
	$Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")

	If $Check_controlGameSetup = "true" Then
		If $Auto_LobbyCheck = "Lobby" Then
			GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 40)

			$Check_WarmUp = GUICtrlRead($Checkbox_RC_WarmUp)
			If $Check_WarmUp = "1" Then $Check_WarmUp = StringLeft(GUICtrlRead($Combo_Time_WarmUp), 2)
			If $Check_WarmUp = "4" Then $Check_WarmUp = ""
			$iLength = StringLen(GUICtrlRead($Combo_Time_WarmUp))
			If $iLength = "11" Then $Check_WarmUp = "120"

			If $Check_WarmUp <> "" Then $RC_Attribute = 'session_WarmupLength=' & $Check_WarmUp

			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $RC_Attribute
			$download = InetGet($URL, @ScriptDir & "\Attributes.txt", 16, 0)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 80)

			$Nachricht_0 = " "
			$Nachricht_1 = "PCDSG: New Attribute set"
			$Nachricht_2 = "Warmup length: " & $Check_WarmUp & " Min."
			$Nachricht_3 = " "

			If FileExists(@ScriptDir & "\Message.txt") Then FileDelete(@ScriptDir & "\Message.txt")

			$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_0
			$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

			If FileExists(@ScriptDir & "\Message.txt") Then
				$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
				$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

				$URL_3 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
				$download = InetGet($URL_3, @ScriptDir & "\Message.txt", 16, 0)

				$URL_4 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
				$download = InetGet($URL_4, @ScriptDir & "\Message.txt", 16, 0)

				GUICtrlSetData($Anzeige_Fortschrittbalken, 100)

				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & $Nachricht_2 & "|" & $Nachricht_3)
			Else
				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & "Error ..." & "Not able to set Attrributes ..." & "Maybe Server or Internet Connection OFFLINE?")
			EndIf
			Sleep(1000)
			GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
		Else
			MsgBox(0, "Wrong DS Session State", "This function can only be used in the Lobby.", 5)
		EndIf
	Else
		MsgBox(0, "controlGameSetup", "ControlGameSetup needs to be activated to be able to use this controls." & @CRLF & @CRLF & _
										"Change the controlGameSetup option in 'Server Settings' TAB of PCDSG"  & @CRLF & _
										"or change it manually in your 'server.cfg' File." & @CRLF & @CRLF & _
										"controlGameSetup : true")
	EndIf
EndFunc

Func _Set_Race_1_Attribute()
	$Check_controlGameSetup = IniRead($config_ini, "Server_Einstellungen", "controlGameSetup", "")
	$Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")

	If $Check_controlGameSetup = "true" Then
		If $Auto_LobbyCheck = "Lobby" Then
			GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 40)

			$Check_Race_1 = GUICtrlRead($Wert_Race_1)
			If $Check_Race_1 = "1" Then $Check_Race_1 = GUICtrlRead($Wert_UpDpwn_Race1)
			If $Check_Race_1 = "4" Then $Check_Race_1 = ""

			If $Check_Race_1 <> "" Then $RC_Attribute = 'session_RaceLength=' & $Check_Race_1

			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $RC_Attribute
			$download = InetGet($URL, @ScriptDir & "\Attributes.txt", 16, 0)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 80)

			$Nachricht_0 = " "
			$Nachricht_1 = "PCDSG: New Attribute set"
			$Nachricht_2 = "Race length: " & $Check_Race_1 & " Min."
			$Nachricht_3 = " "

			If FileExists(@ScriptDir & "\Message.txt") Then FileDelete(@ScriptDir & "\Message.txt")

			$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_0
			$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

			If FileExists(@ScriptDir & "\Message.txt") Then
				$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
				$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

				$URL_3 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
				$download = InetGet($URL_3, @ScriptDir & "\Message.txt", 16, 0)

				$URL_4 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
				$download = InetGet($URL_4, @ScriptDir & "\Message.txt", 16, 0)

				GUICtrlSetData($Anzeige_Fortschrittbalken, 100)

				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & $Nachricht_2 & "|" & $Nachricht_3)
			Else
				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & "Error ..." & "Not able to set Attrributes ..." & "Maybe Server or Internet Connection OFFLINE?")
			EndIf
			Sleep(1000)
			GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
		Else
			MsgBox(0, "Wrong DS Session State", "This function can only be used in the Lobby.", 5)
		EndIf
	Else
		MsgBox(0, "controlGameSetup", "ControlGameSetup needs to be activated to be able to use this controls." & @CRLF & @CRLF & _
										"Change the controlGameSetup option in 'Server Settings' TAB of PCDSG"  & @CRLF & _
										"or change it manually in your 'server.cfg' File." & @CRLF & @CRLF & _
										"controlGameSetup : true")
	EndIf
EndFunc






Func _Set_Current_Attributes_1()
	Local $Checkbox_RC_Training_2, $Checkbox_RC_WarmUp, $Combo_Time_Training_2, $Combo_Time_WarmUp
	$Check_controlGameSetup = IniRead($config_ini, "Server_Einstellungen", "controlGameSetup", "")
	$Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")

	If $Check_controlGameSetup = "true" Then

		If $Auto_LobbyCheck = "Lobby" Then
			GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

			$Status_Checkbox_Random_Car = GUICtrlRead($Checkbox_Random_Car)
			$Status_Checkbox_Random_Car_Track = GUICtrlRead($Checkbox_Random_Track)

			If $Status_Checkbox_Random_Car = 1 Then
				_Random_Car()
			EndIf

			If $Status_Checkbox_Random_Car_Track = 1 Then
				_Random_Track()
			EndIf

			$Check_CAR = ""
			$Check_TRACK = ""
			$Check_Training_1 = ""
			$Check_Training_1 = ""
			$Check_Qualifying = ""
			$Check_WarmUp = ""
			$Check_Race_1 = ""
			$Check_Race_2 = ""
			$RC_Attribute_1 = ""
			$RC_Attribute_2 = ""
			$RC_Attribute_3 = ""
			$RC_Attribute_4 = ""
			$RC_Attribute_5 = ""
			$RC_Attribute_6 = ""
			$RC_Attribute_7 = ""
			$RC_Attribute_8 = ""

			$Check_CAR = GUICtrlRead($Combo_CAR)
			$Check_TRACK = GUICtrlRead($Combo_TRACK)
			$NextCarName = $Check_CAR
			$NextTrackName = $Check_TRACK

			$Check_Training_1 = GUICtrlRead($Checkbox_RC_Training_1)
			If $Check_Training_1 = "1" Then $Check_Training_1 = StringLeft(GUICtrlRead($Combo_Time_Training_1), 2)
			If $Check_Training_1 = "4" Then $Check_Training_1 = ""
			$iLength = StringLen(GUICtrlRead($Combo_Time_Training_1))
			If $iLength = "11" Then $Check_Training_1 = "120"

			$Check_Training_2 = GUICtrlRead($Checkbox_RC_Training_2)
			If $Check_Training_2 = "1" Then $Check_Training_2 = StringLeft(GUICtrlRead($Combo_Time_Training_2), 2)
			If $Check_Training_2 = "4" Then $Check_Training_2 = ""
			$iLength = StringLen(GUICtrlRead($Combo_Time_Training_2))
			If $iLength = "11" Then $Check_Training_2 = "120"

			$Check_Qualifying = GUICtrlRead($Checkbox_RC_Qualifying)
			If $Check_Qualifying = "1" Then $Check_Qualifying = StringLeft(GUICtrlRead($Combo_Time_Qualifying), 2)
			If $Check_Qualifying = "4" Then $Check_Qualifying = ""
			$iLength = StringLen(GUICtrlRead($Combo_Time_Qualifying))
			If $iLength = "11" Then $Check_Qualifying = "120"

			$Check_WarmUp = GUICtrlRead($Checkbox_RC_WarmUp)
			If $Check_WarmUp = "1" Then $Check_WarmUp = StringLeft(GUICtrlRead($Combo_Time_WarmUp), 2)
			If $Check_WarmUp = "4" Then $Check_WarmUp = ""
			$iLength = StringLen(GUICtrlRead($Combo_Time_WarmUp))
			If $iLength = "11" Then $Check_WarmUp = "120"

			$Check_Race_1 = GUICtrlRead($Wert_Race_1)
			If $Check_Race_1 = "1" Then $Check_Race_1 = GUICtrlRead($Wert_UpDpwn_Race1)
			If $Check_Race_1 = "4" Then $Check_Race_1 = ""

			If $Check_Training_1 <> "" Then $RC_Attribute_1 = 'session_PracticeLength=' & $Check_Training_1 & '&'
			If $Check_Training_2 <> "" Then $RC_Attribute_2 = 'session_Practice2Length=' & $Check_Training_2  & '&'
			If $Check_Qualifying <> "" Then $RC_Attribute_3 = 'session_QualifyLength=' & $Check_Qualifying  & '&'
			If $Check_WarmUp <> "" Then $RC_Attribute_4 = 'session_WarmupLength=' & $Check_WarmUp & '&'
			If $Check_Race_1 <> "" Then $RC_Attribute_5 = 'session_Race1Length=' & $Check_Race_1 & '&'

			GUICtrlSetData($Anzeige_Fortschrittbalken, 40)

			_CAR_ID_from_NAME()

			GUICtrlSetData($Anzeige_Fortschrittbalken, 60)

			_TRACK_ID_from_NAME()

			$NextCarID = IniRead($config_ini, "Race_Control", "NextCarID", "")
			$NextTrackID = IniRead($config_ini, "Race_Control", "NextTrackID", "")

			If $Check_CAR <> "" Then $RC_Attribute_7 = 'session_VehicleModelId=' & $NextCarID & '&'
			If $Check_TRACK <> "" Then $RC_Attribute_8 = 'session_TrackId=' & $NextTrackID

			IniWrite($config_ini, "Race_Control", "NextCarName", $NextCarName)
			IniWrite($config_ini, "Race_Control", "NextCarID", $NextCarID)

			IniWrite($config_ini, "Race_Control", "NextTrackName", $NextTrackName)
			IniWrite($config_ini, "Race_Control", "NextTrackID", $NextTrackID)

			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $RC_Attribute_1 & $RC_Attribute_2 & $RC_Attribute_3 & $RC_Attribute_4 & $RC_Attribute_5 & $RC_Attribute_7 & $RC_Attribute_8
			$download = InetGet($URL, @ScriptDir & "\Attributes.txt", 16, 0)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 80)

			$Nachricht_0 = " "
			$Nachricht_1 = "PCDSG: New Attributes set"
			$Nachricht_2 = "Training 1: " & $Check_Training_1
			$Nachricht_3 = "Training 2: " & $Check_Training_2
			$Nachricht_4 = "Qualifying: " & $Check_Qualifying
			$Nachricht_5 = "WarmUp: " & $Check_WarmUp
			$Nachricht_6 = "Race1: " & $Check_Race_1
			$Nachricht_7_1 = "Car: " & $NextCarName
			$Nachricht_7_2 = "" & $Wert_Car_ID
			$Nachricht_8_1 = "Track: " & $NextTrackName
			$Nachricht_8_2 = "" & $Wert_Track_ID

			If FileExists(@ScriptDir & "\Message.txt") Then FileDelete(@ScriptDir & "\Message.txt")

			$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_0
			MsgBox(0, "", $URL_2)
			$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

			If FileExists(@ScriptDir & "\Message.txt") Then
				$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
				$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

				$URL_3 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
				$download = InetGet($URL_3, @ScriptDir & "\Message.txt", 16, 0)

				$URL_4 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
				$download = InetGet($URL_4, @ScriptDir & "\Message.txt", 16, 0)

				$URL_5 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_4
				$download = InetGet($URL_5, @ScriptDir & "\Message.txt", 16, 0)

				$URL_6 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_5
				$download = InetGet($URL_6, @ScriptDir & "\Message.txt", 16, 0)

				$URL_7 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_6
				$download = InetGet($URL_7, @ScriptDir & "\Message.txt", 16, 0)

				$URL_8 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_7_1 & " - " & $Nachricht_7_2
				$download = InetGet($URL_8, @ScriptDir & "\Message.txt", 16, 0)

				$URL_9 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_8_1 & " - " & $Nachricht_8_2
				$download = InetGet($URL_9, @ScriptDir & "\Message.txt", 16, 0)

				GUICtrlSetData($Anzeige_Fortschrittbalken, 100)

				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & $Nachricht_2 & "|" & $Nachricht_3 & "|" & $Nachricht_4 & "|" & $Nachricht_5 & "|" & $Nachricht_6 & "|" & $Nachricht_7_1 & "|" & $Nachricht_8_1)
			Else
				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & "Error ..." & "Not able to set Attrributes ..." & "Maybe Server or Internet Connection OFFLINE?")
			EndIf
			Sleep(1000)
			GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
		Else
			MsgBox(0, "Wrong DS Session State", "This function can only be used in the Lobby.", 5)
		EndIf
	Else
		MsgBox(0, "controlGameSetup", "ControlGameSetup needs to be activated to be able to use this controls." & @CRLF & @CRLF & _
										"Change the controlGameSetup option in 'Server Settings' TAB of PCDSG"  & @CRLF & _
										"or change it manually in your 'server.cfg' File." & @CRLF & @CRLF & _
										"controlGameSetup : true")
	EndIf
EndFunc

Func _Set_Next_Attributes_1()
	Local $Checkbox_RC_Training_2, $Checkbox_RC_WarmUp, $Combo_Time_Training_2, $Combo_Time_WarmUp
	$Check_controlGameSetup = IniRead($config_ini, "Server_Einstellungen", "controlGameSetup", "")
	$Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")

	If $Check_controlGameSetup = "true" Then

		If $Auto_LobbyCheck = "Lobby" Then

			GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

			$Status_Checkbox_Random_Car = GUICtrlRead($Checkbox_Random_Car)
			$Status_Checkbox_Random_Car_Track = GUICtrlRead($Checkbox_Random_Track)

			If $Status_Checkbox_Random_Car = 1 Then
				_Random_Car()
			EndIf

			If $Status_Checkbox_Random_Car_Track = 1 Then
				_Random_Track()
			EndIf

			$Check_CAR = ""
			$Check_TRACK = ""
			$Check_Training_1 = ""
			$Check_Training_1 = ""
			$Check_Qualifying = ""
			$Check_WarmUp = ""
			$Check_Race_1 = ""
			$Check_Race_2 = ""
			$RC_Attribute_1 = ""
			$RC_Attribute_2 = ""
			$RC_Attribute_3 = ""
			$RC_Attribute_4 = ""
			$RC_Attribute_5 = ""
			$RC_Attribute_6 = ""
			$RC_Attribute_7 = ""
			$RC_Attribute_8 = ""


			$Check_CAR = GUICtrlRead($Combo_CAR)
			$Check_TRACK = GUICtrlRead($Combo_TRACK)
			$NextCarName = $Check_CAR
			$NextTrackName = $Check_TRACK

			$Check_Training_1 = GUICtrlRead($Checkbox_RC_Training_1)
			If $Check_Training_1 = "1" Then $Check_Training_1 = StringLeft(GUICtrlRead($Combo_Time_Training_1), 2)
			If $Check_Training_1 = "4" Then $Check_Training_1 = ""
			$iLength = StringLen(GUICtrlRead($Combo_Time_Training_1))
			If $iLength = "11" Then $Check_Training_1 = "120"

			$Check_Training_2 = GUICtrlRead($Checkbox_RC_Training_2)
			If $Check_Training_2 = "1" Then $Check_Training_2 = StringLeft(GUICtrlRead($Combo_Time_Training_2), 2)
			If $Check_Training_2 = "4" Then $Check_Training_2 = ""
			$iLength = StringLen(GUICtrlRead($Combo_Time_Training_2))
			If $iLength = "11" Then $Check_Training_2 = "120"

			$Check_Qualifying = GUICtrlRead($Checkbox_RC_Qualifying)
			If $Check_Qualifying = "1" Then $Check_Qualifying = StringLeft(GUICtrlRead($Combo_Time_Qualifying), 2)
			If $Check_Qualifying = "4" Then $Check_Qualifying = ""
			$iLength = StringLen(GUICtrlRead($Combo_Time_Qualifying))
			If $iLength = "11" Then $Check_Qualifying = "120"

			$Check_WarmUp = GUICtrlRead($Checkbox_RC_WarmUp)
			If $Check_WarmUp = "1" Then $Check_WarmUp = StringLeft(GUICtrlRead($Combo_Time_WarmUp), 2)
			If $Check_WarmUp = "4" Then $Check_WarmUp = ""
			$iLength = StringLen(GUICtrlRead($Combo_Time_WarmUp))
			If $iLength = "11" Then $Check_WarmUp = "120"

			$Check_Race_1 = GUICtrlRead($Wert_Race_1)
			If $Check_Race_1 = "1" Then $Check_Race_1 = GUICtrlRead($Wert_UpDpwn_Race1)
			If $Check_Race_1 = "4" Then $Check_Race_1 = ""

			If $Check_Training_1 <> "" Then $RC_Attribute_1 = 'session_Practice1Length=' & $Check_Training_1 & '&'
			If $Check_Training_2 <> "" Then $RC_Attribute_2 = 'session_Practice2Length=' & $Check_Training_2  & '&'
			If $Check_Qualifying <> "" Then $RC_Attribute_3 = 'session_QualifyLength=' & $Check_Qualifying  & '&'
			If $Check_WarmUp <> "" Then $RC_Attribute_4 = 'session_WarmupLength=' & $Check_WarmUp & '&'
			If $Check_Race_1 <> "" Then $RC_Attribute_5 = 'session_Race1Length=' & $Check_Race_1 & '&'

			GUICtrlSetData($Anzeige_Fortschrittbalken, 40)

			_CAR_ID_from_NAME()

			GUICtrlSetData($Anzeige_Fortschrittbalken, 60)

			_TRACK_ID_from_NAME()

			$NextCarID = IniRead($config_ini, "Race_Control", "NextCarID", "")
			$NextTrackID = IniRead($config_ini, "Race_Control", "NextTrackID", "")

			If $Check_CAR <> "" Then $RC_Attribute_7 = 'session_VehicleModelId=' & $NextCarID & '&'
			If $Check_TRACK <> "" Then $RC_Attribute_8 = 'session_TrackId=' & $NextTrackID

			IniWrite($config_ini, "Race_Control", "NextCarName", $NextCarName)
			IniWrite($config_ini, "Race_Control", "NextCarID", $NextCarID)

			IniWrite($config_ini, "Race_Control", "NextTrackName", $NextTrackName)
			IniWrite($config_ini, "Race_Control", "NextTrackID", $NextTrackID)

			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $RC_Attribute_1 & $RC_Attribute_2 & $RC_Attribute_3 & $RC_Attribute_4 & $RC_Attribute_5 & $RC_Attribute_7 & $RC_Attribute_8
			$download = InetGet($URL, @ScriptDir & "\Attributes.txt", 16, 0)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 80)

			$Nachricht_0 = " "
			$Nachricht_1 = "PCDSG: NEXT Attributes set"
			$Nachricht_2 = "Training 1: " & $Check_Training_1
			$Nachricht_3 = "Training 2: " & $Check_Training_2
			$Nachricht_4 = "Qualifying: " & $Check_Qualifying
			$Nachricht_5 = "WarmUp: " & $Check_WarmUp
			$Nachricht_6 = "Race1: " & $Check_Race_1
			$Nachricht_7_1 = "Car: " & $NextCarName
			$Nachricht_7_2 = "" & $Wert_Car_ID
			$Nachricht_8_1 = "Track: " & $NextTrackName
			$Nachricht_8_2 = "" & $Wert_Track_ID

			If FileExists(@ScriptDir & "\Message.txt") Then FileDelete(@ScriptDir & "\Message.txt")

			$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_0
			$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

			If FileExists(@ScriptDir & "\Message.txt") Then
				$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
				$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

				$URL_3 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
				$download = InetGet($URL_3, @ScriptDir & "\Message.txt", 16, 0)

				$URL_4 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
				$download = InetGet($URL_4, @ScriptDir & "\Message.txt", 16, 0)

				$URL_5 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_4
				$download = InetGet($URL_5, @ScriptDir & "\Message.txt", 16, 0)

				$URL_6 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_5
				$download = InetGet($URL_6, @ScriptDir & "\Message.txt", 16, 0)

				$URL_7 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_6
				$download = InetGet($URL_7, @ScriptDir & "\Message.txt", 16, 0)

				$URL_8 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_7_1 & " - " & $Nachricht_7_2
				$download = InetGet($URL_8, @ScriptDir & "\Message.txt", 16, 0)

				$URL_9 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_8_1 & " - " & $Nachricht_8_2
				$download = InetGet($URL_9, @ScriptDir & "\Message.txt", 16, 0)

				GUICtrlSetData($Anzeige_Fortschrittbalken, 100)

				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & $Nachricht_2 & "|" & $Nachricht_3 & "|" & $Nachricht_4 & "|" & $Nachricht_5 & "|" & $Nachricht_6 & "|" & $Nachricht_7_1 & "|" & $Nachricht_8_1)
			Else
				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & "Error ..." & "Not able to set Attributes ..." & "Maybe Server or Internet Connection OFFLINE?")
			EndIf
			Sleep(1000)
			GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
		Else
			MsgBox(0, "Wrong DS Session State", "This function can only be used in the Lobby.", 5)
		EndIf

	Else
		MsgBox(0, "controlGameSetup", "ControlGameSetup needs to be activated to be able to use this controls." & @CRLF & @CRLF & _
										"Change the controlGameSetup option in 'Server Settings' TAB of PCDSG"  & @CRLF & _
										"or change it manually in your 'server.cfg' File." & @CRLF & @CRLF & _
										"controlGameSetup : true")
	EndIf

EndFunc

Func _Set_Current_Attributes_2()
	$Check_controlGameSetup = IniRead($config_ini, "Server_Einstellungen", "controlGameSetup", "")
	$Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")

	If $Check_controlGameSetup = "true" Then

		If $Auto_LobbyCheck = "Lobby" Then
			GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

			$AS_value_1 = GUICtrlRead($Checkbox_RCS_ServerControlsTrack)
				If $AS_value_1 = 1 Then $AS_value_1 = "true"
				If $AS_value_1 = 4 Then $AS_value_1 = "false"
			$AS_value_2 = GUICtrlRead($Checkbox_RCS_ServerControlsVehicle)
				If $AS_value_2 = 1 Then $AS_value_2 = "true"
				If $AS_value_2 = 4 Then $AS_value_2 = "false"
			;$AS_value_3 = GUICtrlRead($Wert_Input_GridSize)
			;$AS_value_4 = GUICtrlRead($Wert_MaxPlayers)
			;$AS_value_5 = GUICtrlRead($Wert_Input_Flags)
			;$AS_value_6 = GUICtrlRead($Wert_DamageType)
			;$AS_value_7 = GUICtrlRead($Wert_TireWearType)
			;$AS_value_8 = GUICtrlRead($Wert_FuelUsageType)
			;$AS_value_9 = GUICtrlRead($Wert_PenaltiesType)
			;$AS_value_10 = GUICtrlRead($Wert_AllowedViews)
			$AS_value_11 = GUICtrlRead($Wert_Date)
			$AS_value_12 = GUICtrlRead($Wert_Time)
			$AS_value_13 = GUICtrlRead($Checkbox_RCS_DateProgression)
				If $AS_value_13 = 1 Then $AS_value_13 = "true"
				If $AS_value_13 = 4 Then $AS_value_13 = "false"
			$AS_value_14 = GUICtrlRead($Checkbox_RCS_ForecastProgression)
				If $AS_value_14 = 1 Then $AS_value_14 = "true"
				If $AS_value_14 = 4 Then $AS_value_14 = "false"
			;$AS_value_15 = GUICtrlRead($Wert_WeatherSlots)
			$AS_value_16 = GUICtrlRead($Wert_Input_WeatherSlot1)
			$AS_value_17 = GUICtrlRead($Wert_Input_WeatherSlot2)
			$AS_value_18 = GUICtrlRead($Wert_Input_WeatherSlot3)
			$AS_value_19 = GUICtrlRead($Wert_Input_WeatherSlot4)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 40)

			$AS_RCS_value_1 = 'ServerControlsTrack=' & $AS_value_1 ;& '&'
			$AS_RCS_value_2 = 'ServerControlsVehicle=' & $AS_value_2 ;& '&'
			;$AS_RCS_value_3 = 'GridSize=' & $AS_value_3 ;& '&'
			;$AS_RCS_value_4 = 'MaxPlayers=' & $AS_value_4 ;& '&'
			;$AS_RCS_value_5 = 'Flags=' & $AS_value_5 ;& '&'
			;$AS_RCS_value_6 = 'DamageType=' & $AS_value_6 ;& '&'
			;$AS_RCS_value_7 = 'TireWearType=' & $AS_value_7 ;& '&'
			;$AS_RCS_value_8 = 'FuelUsageType=' & $AS_value_8 ;& '&'
			;$AS_RCS_value_9 = 'PenaltiesType=' & $AS_value_9 ;& '&'
			;$AS_RCS_value_10 = 'AllowedViews=' & $AS_value_10 ;& '&'
			$AS_RCS_value_11 = "" ; 'DateYear=' & $AS_value_11 & '&'
			$AS_RCS_value_12 = ""; 'DateHour=' & $AS_value_12 & '&'
			$AS_RCS_value_13 = 'DateProgression=' & $AS_value_13 ;& '&'
			$AS_RCS_value_14 = 'ForecastProgression=' & $AS_value_14 ;& '&'
			;$AS_RCS_value_15 = 'WeatherSlots=' & $AS_value_15 ;& '&'
			$AS_RCS_value_16 = 'WeatherSlot1=' & $AS_value_16 ;& '&'
			$AS_RCS_value_17 = 'WeatherSlot2=' & $AS_value_17 ;& '&'
			$AS_RCS_value_18 = 'WeatherSlot3=' & $AS_value_18 ;& '&'
			$AS_RCS_value_19 = 'WeatherSlot4=' & $AS_value_19


			If FileExists(@ScriptDir & "\Attributes_Settings.txt") Then FileDelete(@ScriptDir & "\Attributes_Settings.txt")

			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_1
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_2
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			;$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_3
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			;$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_4
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			;$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_5
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			;$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_6
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			;$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_7
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			;$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_8
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			;$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_9
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			;$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_10
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_13
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_14
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			;$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_15
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_16
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_17
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_18
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_19
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 60)

			If FileExists(@ScriptDir & "\Attributes_Settings.txt") Then
				$Nachricht_0 = " "
				$Nachricht_1 = "PCDSG: New Attributes Settings set"
				$Nachricht_2 = "ServerControlsTrack: " & $AS_value_1
				$Nachricht_3 = "ServerControlsVehicle: " & $AS_value_2
				;$Nachricht_4 = "GridSize: " & $AS_value_3
				;$Nachricht_5 = "MaxPlayers: " & $AS_value_4
				;$Nachricht_6 = "Flags: " & $AS_value_5
				;$Nachricht_7 = "DamageType: " & $AS_value_6
				;$Nachricht_8 = "TireWearType: " & $AS_value_7
				;$Nachricht_9 = "FuelUsageType: " & $AS_value_8
				;$Nachricht_10 = "PenaltiesType: " & $AS_value_9
				;$Nachricht_11 = "AllowedViews: " & $AS_value_10
				$Nachricht_12 = "DateProgression: " & $AS_value_13
				$Nachricht_13 = "ForecastProgression: " & $AS_value_14
				;$Nachricht_14 = "WeatherSlots: " & $AS_value_15
				$Nachricht_15 = "WeatherSlot1: " & $AS_value_16
				$Nachricht_16 = "WeatherSlot2: " & $AS_value_17
				$Nachricht_17 = "WeatherSlot3: " & $AS_value_18
				$Nachricht_18 = "WeatherSlot5: " & $AS_value_19

				GUICtrlSetData($Anzeige_Fortschrittbalken, 80)

				$URL_0 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_0
				$download = InetGet($URL_0, @ScriptDir & "\Message.txt", 16, 0)

				$URL_2 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
				$download = InetGet($URL_2, @ScriptDir & "\Message.txt", 16, 0)

				$URL_3 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
				$download = InetGet($URL_3, @ScriptDir & "\Message.txt", 16, 0)

				$URL_4 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
				$download = InetGet($URL_4, @ScriptDir & "\Message.txt", 16, 0)

				;$URL_5 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_4
				;$download = InetGet($URL_5, @ScriptDir & "\Message.txt", 16, 0)

				;$URL_6 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_5
				;$download = InetGet($URL_6, @ScriptDir & "\Message.txt", 16, 0)

				;$URL_7 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_6
				;$download = InetGet($URL_7, @ScriptDir & "\Message.txt", 16, 0)

				;$URL_8 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_7
				;$download = InetGet($URL_8, @ScriptDir & "\Message.txt", 16, 0)

				;$URL_9 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_8
				;$download = InetGet($URL_9, @ScriptDir & "\Message.txt", 16, 0)

				;$URL_10 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_9
				;$download = InetGet($URL_10, @ScriptDir & "\Message.txt", 16, 0)

				;$URL_11 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_10
				;$download = InetGet($URL_11, @ScriptDir & "\Message.txt", 16, 0)

				;$URL_12 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_11
				;$download = InetGet($URL_12, @ScriptDir & "\Message.txt", 16, 0)

				$URL_13 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_12
				$download = InetGet($URL_13, @ScriptDir & "\Message.txt", 16, 0)

				$URL_14 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_13
				$download = InetGet($URL_14, @ScriptDir & "\Message.txt", 16, 0)

				;$URL_15 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_14 & ' | ' & $Nachricht_15 & ' | ' & $Nachricht_16 & ' | ' & $Nachricht_17 & ' | ' & $Nachricht_18
				;$download = InetGet($URL_15, @ScriptDir & "\Message.txt", 16, 0)


				GUICtrlSetData($Anzeige_Fortschrittbalken, 100)

				;_GUICtrlStatusBar_SetText($Statusbar, "Attr. Settings: " & $AS_value_1 & "|" & _
														;$AS_value_2 & "|" & $AS_value_3 & "|" & _
														;$AS_value_4 & "|" & $AS_value_5 & "|" & _
														;$AS_value_6 & "|" & $AS_value_7 & "|" & _
														;$AS_value_8 & "|" & $AS_value_9& "|" & _
														;$AS_value_10 & "|" & $AS_value_11 & "|" & _
														;$AS_value_12 & "|" & $AS_value_13 & "|" & _
														;$AS_value_14 & "|" & $AS_value_15 & "|" & _
														;$AS_value_16 & "|" & $AS_value_17& "|" & _
														;$AS_value_18 & "|" & $AS_value_19)


			Else
				_GUICtrlStatusBar_SetText($Statusbar, "Attributes: " & "Error ..." & "Not able to set Attrributes ..." & "Maybe Server or Internet Connection OFFLINE?")
			EndIf
			Sleep(1000)
			GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
		Else
			MsgBox(0, "Wrong DS Session State", "This function can only be used in the Lobby.", 5)
		EndIf

	Else
		MsgBox(0, "controlGameSetup", "ControlGameSetup needs to be activated to be able to use this controls." & @CRLF & @CRLF & _
										"Change the controlGameSetup option in 'Server Settings' TAB of PCDSG"  & @CRLF & _
										"or change it manually in your 'server.cfg' File." & @CRLF & @CRLF & _
										"controlGameSetup : true")
	EndIf
EndFunc


Func _Button_Open_WebInterface_PCDSG()
	If FileExists($System_Dir & "WebInterface.exe") Then
		ShellExecute($System_Dir & "WebInterface.exe")
	Else
		ShellExecute($System_Dir & "WebInterface.au3")
	EndIf
EndFunc

Func _Button_Open_WebInterface_IBrowser()
	If $DS_Mode_Temp = "local" Then ShellExecute("http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort)
	If $DS_Mode_Temp = "remote" Then ShellExecute("http://" & $Name_Password & $DS_Domain_or_IP & ":" & $Lesen_Auswahl_httpApiPort)
EndFunc



Func _Read_sms_rotate_config_json()
	_Loading_GUI()
	Local $Track_NR_Temp = ""
	$sms_rotate_config_json_File_Array = FileReadToArray($sms_rotate_config_json_File)
	$NR_Lines_sms_rotate_config_json_File = _FileCountLines($sms_rotate_config_json_File) - 1

	$EmptyFile = FileOpen($RC_LUA_Settings_ini_File, 2)
	FileWrite($RC_LUA_Settings_ini_File, "")
	FileClose($RC_LUA_Settings_ini_File)


	IniWrite($RC_LUA_Settings_ini_File, "Settings", "FILL_SESSION_WITH_AI", "false")
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "OpponentDifficulty", "")

	Local $RC_TEMP_1 = IniRead($config_ini, "TEMP", "RC_TEMP_1", "50")
	Local $RC_TEMP_2 = IniRead($config_ini, "TEMP", "RC_TEMP_2", "223")

	For $Loop = 0 To $NR_Lines_sms_rotate_config_json_File
		GUICtrlSetData($Anzeige_Fortschrittbalken, 50 + ($Loop * 100 / $NR_Lines_sms_rotate_config_json_File))

		$Wert_Line = $sms_rotate_config_json_File_Array[$Loop]

		If $Loop < $RC_TEMP_2 Then
			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '	"persist_index" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '	"persist_index" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "persist_index", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"VehicleClassId" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"VehicleClassId" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$StringInStr_Check_2 = StringInStr($Value_Temp, '//')
				If $StringInStr_Check_2 = StringInStr($Value_Temp, '//') <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2)
				If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "VehicleClassId", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "VehicleClassId" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		// "VehicleClassId" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$StringInStr_Check_2 = StringInStr($Value_Temp, '//')
				If $StringInStr_Check_2 <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2 - 1)
				If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "VehicleClassId", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"MultiClassSlots" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"MultiClassSlots" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlots", $Value_Temp)
				IniWrite($config_ini, "TEMP", "RC_TEMP_1", $Loop + 5)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlots" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		// "MultiClassSlots" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlots", $Value_Temp)
				IniWrite($config_ini, "TEMP", "RC_TEMP_1", $Loop + 5)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"MultiClassSlot1" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"MultiClassSlot1" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$StringInStr_Check_2 = StringInStr($Wert_Line, '/')
				If $StringInStr_Check_2 <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2)
				If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot1", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot1" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		// "MultiClassSlot1" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$StringInStr_Check_2 = StringInStr($Wert_Line, '/')
				If $StringInStr_Check_2 <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2)
				If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot1", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"MultiClassSlot2" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"MultiClassSlot2" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$StringInStr_Check_2 = StringInStr($Wert_Line, '/')
				If $StringInStr_Check_2 <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2)
				If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot2", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot2" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		// "MultiClassSlot2" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$StringInStr_Check_2 = StringInStr($Wert_Line, '/')
				If $StringInStr_Check_2 <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2)
				If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot2", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"MultiClassSlot3" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"MultiClassSlot3" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$StringInStr_Check_2 = StringInStr($Wert_Line, '/')
				If $StringInStr_Check_2 <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2)
				If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot3", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot3" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		// "MultiClassSlot3" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$StringInStr_Check_2 = StringInStr($Wert_Line, '/')
				If $StringInStr_Check_2 <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2)
				If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot3", $Value_Temp)
			EndIf


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"Flags" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"Flags" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				Local $End_Check = StringInStr($Value_Temp, '//')
				If $End_Check <> 0 Then $Value_Temp = StringLeft($Value_Temp, $End_Check - 3)
				If StringRight($Value_Temp, 1) = "," Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "Flags", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, ',FILL_SESSION_WITH_AI",')
			If $StringInStr_Check_1 <> 0 Then
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "FILL_SESSION_WITH_AI", "true")
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"OpponentDifficulty" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"OpponentDifficulty" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "OpponentDifficulty", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		//"OpponentDifficulty" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		//"OpponentDifficulty" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "OpponentDifficulty", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"DamageType" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"DamageType" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "DamageType", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"TireWearType" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"TireWearType" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "TireWearType", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"FuelUsageType" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"FuelUsageType" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "FuelUsageType", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PenaltiesType" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"PenaltiesType" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "PenaltiesType", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"AllowablePenaltyTime" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"AllowablePenaltyTime" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "AllowablePenaltyTime", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PitWhiteLinePenalty" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"PitWhiteLinePenalty" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "PitWhiteLinePenalty", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"DriveThroughPenalty" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"DriveThroughPenalty" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "DriveThroughPenalty", $Value_Temp)
			EndIf


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"AllowedViews" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"AllowedViews" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "AllowedViews", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"ManualPitStops" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"ManualPitStops" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "ManualPitStops", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"ManualRollingStarts" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"ManualRollingStarts" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "ManualRollingStarts", $Value_Temp)
			EndIf


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"MinimumOnlineRank" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"MinimumOnlineRank" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "MinimumOnlineRank", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"MinimumOnlineStrength" : ')
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"MinimumOnlineStrength" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "MinimumOnlineStrength", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeLength" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"PracticeLength" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeLength", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyLength" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"QualifyLength" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyLength", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceLength" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceLength" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceLength", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceRollingStart" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceRollingStart" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceRollingStart", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceFormationLap" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceFormationLap" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceFormationLap", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceMandatoryPitStops" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceMandatoryPitStops" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceMandatoryPitStops", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		 "PracticeDateHour" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		 "PracticeDateHour" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeDateHour", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeDateProgression" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"PracticeDateProgression" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeDateProgression", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeWeatherProgression" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"PracticeWeatherProgression" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherProgression", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyDateHour" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"QualifyDateHour" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyDateHour", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyDateProgression" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"QualifyDateProgression" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyDateProgression", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyWeatherProgression" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"QualifyWeatherProgression" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherProgression", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceDateYear" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceDateYear" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceDateYear", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceDateMonth" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceDateMonth" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceDateMonth", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceDateDay" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceDateDay" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceDateDay", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceDateHour" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceDateHour" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceDateHour", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceDateProgression" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceDateProgression" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceDateProgression", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceWeatherProgression" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceWeatherProgression" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherProgression", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeWeatherSlots" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"PracticeWeatherSlots" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlots", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeWeatherSlot1" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"PracticeWeatherSlot1" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlot1", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeWeatherSlot2" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"PracticeWeatherSlot2" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlot2", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeWeatherSlot3" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"PracticeWeatherSlot3" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlot3", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeWeatherSlot4" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"PracticeWeatherSlot4" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlot4", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyWeatherSlots" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"QualifyWeatherSlots" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlots", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyWeatherSlot1" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"QualifyWeatherSlot1" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlot1", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyWeatherSlot2" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"QualifyWeatherSlot2" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlot2", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyWeatherSlot3" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"QualifyWeatherSlot3" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlot3", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyWeatherSlot4" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"QualifyWeatherSlot4" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlot4", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceWeatherSlots" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceWeatherSlots" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlots", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceWeatherSlot1" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceWeatherSlot1" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlot1", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceWeatherSlot2" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceWeatherSlot2" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlot2", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceWeatherSlot3" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceWeatherSlot3" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlot3", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceWeatherSlot4" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '		"RaceWeatherSlot4" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$Value_Temp = StringReplace($Value_Temp, ' ', '')
				;MsgBox(0, "$Value_Temp", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlot4", $Value_Temp)
			EndIf
		EndIf



		Local $StringInStr_Check_1 = StringInStr($Wert_Line, '	"rotation" : [')
		If $StringInStr_Check_1 <> 0 Then IniWrite($config_ini, "TEMP", "RC_TEMP_2", $Loop)


		$RC_TEMP_1 = IniRead($config_ini, "TEMP", "RC_TEMP_1", "50")
		$RC_TEMP_2 = IniRead($config_ini, "TEMP", "RC_TEMP_2", "223")

		If $Loop > $RC_TEMP_2 Then
			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"TrackId" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"TrackId" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				Local $Track_Name_ID = $Value_Temp
				;MsgBox(0, "TrackId", $Value_Temp)
				If $Track_NR_Temp <> "" Then $Track_NR_Temp = $Track_NR_Temp + 1
				If $Track_NR_Temp = "" Then $Track_NR_Temp = 1
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "NR_Tracks", $Track_NR_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Settings", "NR_Of_Tracks_TrackRotation", $Track_NR_Temp)
				FileWriteLine($RC_LUA_Settings_ini_File, "" & @CRLF)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "TrackId", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "TrackId", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"VehicleClassId" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"VehicleClassId" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "State_VehicleClassId", "true")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "State_VehicleClassId", "true")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "VehicleClassId", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "VehicleClassId", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "VehicleClassId" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			// "VehicleClassId" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "State_VehicleClassId", "false")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "State_VehicleClassId", "false")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "VehicleClassId", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "VehicleClassId", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"MultiClassSlots" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"MultiClassSlots" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "State_MultiClassSlots", "true")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "State_MultiClassSlots", "true")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "MultiClassSlots", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "MultiClassSlots", $Value_Temp)
				IniWrite($config_ini, "Server_Einstellungen", "Activate_MultiClass", "true")
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlots" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			// "MultiClassSlots" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "State_MultiClassSlots", "false")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "State_MultiClassSlots", "false")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "MultiClassSlots", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "MultiClassSlots", $Value_Temp)
				IniWrite($config_ini, "Server_Einstellungen", "Activate_MultiClass", "false")
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"MultiClassSlot1" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"MultiClassSlot1" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$StringInStr_Check_2 = StringInStr($Wert_Line, '/')
				If $StringInStr_Check_2 <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2)
				If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "State_MultiClassSlot1", "true")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "State_MultiClassSlot1", "true")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "MultiClassSlot1", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "MultiClassSlot1", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot1" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			// "MultiClassSlot1" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;$StringInStr_Check_2 = StringInStr($Wert_Line, '/')
				;If $StringInStr_Check_2 <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2)
				;If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "State_MultiClassSlot1", "false")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "State_MultiClassSlot1", "false")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "MultiClassSlot1", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "MultiClassSlot1", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"MultiClassSlot2" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"MultiClassSlot2" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$StringInStr_Check_2 = StringInStr($Wert_Line, '/')
				If $StringInStr_Check_2 <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2)
				If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "State_MultiClassSlot2", "true")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "State_MultiClassSlot2", "true")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "MultiClassSlot2", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "MultiClassSlot2", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot2" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			// "MultiClassSlot2" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;$StringInStr_Check_2 = StringInStr($Wert_Line, '/')
				;If $StringInStr_Check_2 <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2)
				;If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "State_MultiClassSlot2", "false")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "State_MultiClassSlot2", "false")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "MultiClassSlot2", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "MultiClassSlot2", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"MultiClassSlot3" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"MultiClassSlot3" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				$StringInStr_Check_2 = StringInStr($Wert_Line, '/')
				If $StringInStr_Check_2 <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2)
				If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "State_MultiClassSlot3", "true")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "State_MultiClassSlot3", "true")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "MultiClassSlot3", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "MultiClassSlot3", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot3" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			// "MultiClassSlot3" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;$StringInStr_Check_2 = StringInStr($Wert_Line, '/')
				;If $StringInStr_Check_2 <> 0 Then $Value_Temp = StringLeft($Value_Temp, $StringInStr_Check_2)
				;If StringRight($Value_Temp, 1) = " " Then $Value_Temp = StringTrimRight($Value_Temp, 1)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "State_MultiClassSlot3", "false")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "State_MultiClassSlot3", "false")
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "MultiClassSlot3", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "MultiClassSlot3", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"Flags" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"Flags" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "Flags", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "Flags", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RemoveFlags" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RemoveFlags" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RemoveFlags", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RemoveFlags", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"ManualRollingStarts" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"ManualRollingStarts" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "ManualRollingStarts", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "ManualRollingStarts", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceRollingStart" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RaceRollingStart" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RaceRollingStart", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceRollingStart" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RaceRollingStart" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RaceRollingStart", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceFormationLap" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RaceFormationLap" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceRollingStart", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RaceFormationLap", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RaceFormationLap", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeLength" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"PracticeLength" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "PracticeLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "PracticeLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "PracticeLength", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeDateHour" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"PracticeDateHour" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "PracticeLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "PracticeDateHour", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "PracticeDateHour", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeWeatherSlots" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"PracticeWeatherSlots" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "PracticeLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "PracticeWeatherSlots", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "PracticeWeatherSlots", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeWeatherSlot1" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"PracticeWeatherSlot1" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "PracticeLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "PracticeWeatherSlot1", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "PracticeWeatherSlot1", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeWeatherSlot2" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"PracticeWeatherSlot2" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "PracticeLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "PracticeWeatherSlot2", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "PracticeWeatherSlot2", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeWeatherSlot3" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"PracticeWeatherSlot3" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "PracticeLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "PracticeWeatherSlot3", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "PracticeWeatherSlot3", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeWeatherSlot4" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"PracticeWeatherSlot4" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "PracticeLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "PracticeWeatherSlot4", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "PracticeWeatherSlot4", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyLength" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"QualifyLength" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "QualifyLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "QualifyLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "QualifyLength", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyDateHour" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"QualifyDateHour" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "QualifyLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "QualifyDateHour", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "QualifyDateHour", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyWeatherSlots" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"QualifyWeatherSlots" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "QualifyLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "QualifyWeatherSlots", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "QualifyWeatherSlots", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyWeatherSlot1" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"QualifyWeatherSlot1" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "QualifyLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "QualifyWeatherSlot1", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "QualifyWeatherSlot1", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyWeatherSlot2" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"QualifyWeatherSlot2" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "QualifyLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "QualifyWeatherSlot2", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "QualifyWeatherSlot2", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyWeatherSlot3" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"QualifyWeatherSlot3" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "QualifyWeatherSlot3", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "QualifyWeatherSlot3", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "QualifyWeatherSlot3", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyWeatherSlot4" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"QualifyWeatherSlot4" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "QualifyWeatherSlot4", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "QualifyWeatherSlot4", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "QualifyWeatherSlot4", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceLength" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RaceLength" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RaceLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RaceLength", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceDateYear" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RaceDateYear" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RaceDateYear", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RaceDateYear", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceDateMonth" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RaceDateMonth" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RaceDateMonth", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RaceDateMonth", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceDateDay" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RaceDateDay" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RaceDateDay", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RaceDateDay", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceDateHour" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RaceDateHour" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RaceDateHour", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RaceDateHour", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceWeatherSlots" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RaceWeatherSlots" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RaceWeatherSlots", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RaceWeatherSlots", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceWeatherSlot1" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RaceWeatherSlot1" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RaceWeatherSlot1", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RaceWeatherSlot1", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceWeatherSlot2" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RaceWeatherSlot2" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RaceWeatherSlot2", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RaceWeatherSlot2", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceWeatherSlot3" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RaceWeatherSlot3" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RaceWeatherSlot3", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RaceWeatherSlot3", $Value_Temp)
			EndIf

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceWeatherSlot4" : ')
			;If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
			If $StringInStr_Check_1 <> 0 Then
				$Value_Temp = StringReplace($Wert_Line, '			"RaceWeatherSlot4" : ', '')
				$Value_Temp = StringReplace($Value_Temp, '"', '')
				$Value_Temp = StringReplace($Value_Temp, ',', '')
				;MsgBox(0, "RaceLength", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_NR_Temp, "RaceWeatherSlot4", $Value_Temp)
				IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Track_Name_ID, "RaceWeatherSlot4", $Value_Temp)
			EndIf
		EndIf
	Next
	GUIDelete($GUI_Loading)
EndFunc


Func _Set_ServerControl_Objects()
	Local $Value_Activate_MultiClass = IniRead($config_ini, "Server_Einstellungen", "Activate_MultiClass", "")

	Local $Value_NR_Tracks = IniRead($RC_LUA_Settings_ini_File, "Settings", "NR_Tracks", "")
	Local $Value_NR_Of_Tracks_TrackRotation = IniRead($RC_LUA_Settings_ini_File, "Settings", "NR_Of_Tracks_TrackRotation", "")

	Local $Value_VehicleClassId = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "VehicleClassId", "")
	Local $Value_MultiClassSlots = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "MultiClassSlots", "")
	Local $Value_MultiClassSlot1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "MultiClassSlot1", "")
	Local $Value_MultiClassSlot2 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "MultiClassSlot2", "")
	Local $Value_MultiClassSlot3 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "MultiClassSlot3", "")



	;MsgBox($MB_SYSTEMMODAL, "", $Value_MultiClassSlot1 & @CRLF & @CRLF & StringTrimLeft($Value_VehicleClassId, 1))

	If StringIsDigit(StringTrimLeft($Value_VehicleClassId, 1)) Then
		IniWrite($config_ini, "TEMP", "Check_VehicleClassID", $Value_VehicleClassId)
		;MsgBox($MB_SYSTEMMODAL, "", "The variable is a number")
		_Get_Name_from_VehicleClassesList_TXT()
		$Value_VehicleClassId = IniRead($config_ini, "TEMP", "Check_VehicleClassName", "")
	EndIf

	If StringIsDigit(StringTrimLeft($Value_MultiClassSlot1, 1)) Then
		IniWrite($config_ini, "TEMP", "Check_VehicleClassID", $Value_MultiClassSlot1)
		;MsgBox($MB_SYSTEMMODAL, "", "The variable is a number")
		_Get_Name_from_VehicleClassesList_TXT()
		$Value_MultiClassSlot1 = IniRead($config_ini, "TEMP", "Check_VehicleClassName", "")
	EndIf

	If StringIsDigit(StringTrimLeft($Value_MultiClassSlot2, 1)) Then
		IniWrite($config_ini, "TEMP", "Check_VehicleClassID", $Value_MultiClassSlot2)
		;MsgBox($MB_SYSTEMMODAL, "", "The variable is a number")
		_Get_Name_from_VehicleClassesList_TXT()
		$Value_MultiClassSlot2 = IniRead($config_ini, "TEMP", "Check_VehicleClassName", "")
	EndIf

	If StringIsDigit(StringTrimLeft($Value_MultiClassSlot3, 1)) Then
		IniWrite($config_ini, "TEMP", "Check_VehicleClassID", $Value_MultiClassSlot3)
		;MsgBox($MB_SYSTEMMODAL, "", "The variable is a number")
		_Get_Name_from_VehicleClassesList_TXT()
		$Value_MultiClassSlot3 = IniRead($config_ini, "TEMP", "Check_VehicleClassName", "")
	EndIf


	Local $Value_Training_1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "PracticeLength", "")
	Local $Value_Qualify = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "QualifyLength", "")
	Local $Value_Race = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "RaceLength", "")
	Local $Value_RaceRollingStart = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "RaceRollingStart", "")
	If $Value_RaceRollingStart <> "0" Then
		$Value_RaceRollingStart = "true"
	Else
		$Value_RaceRollingStart = "false"
	EndIf

	GUICtrlSetData($Wert_Track_Nr, $Value_NR_Tracks)
	If $Value_Activate_MultiClass = "true" Then GUICtrlSetState($Checkbox_RCS_Activate_MultiClass, $GUI_CHECKED)
	If $Value_Activate_MultiClass <> "true" Then GUICtrlSetState($Checkbox_RCS_Activate_MultiClass, $GUI_UNCHECKED)
	GUICtrlSetData($Wert_Input_NR_Of_Tracks_TrackRotation, $Value_NR_Of_Tracks_TrackRotation)
	GUICtrlSetData($Combo_VehicleClassId, $Value_VehicleClassId)
	GUICtrlSetData($Wert_NR_MultiClassSlots, $Value_MultiClassSlots)


	GUICtrlSetData($Combo_VehicleClassId_Slot_1, $Value_MultiClassSlot1, $Value_MultiClassSlot1)
	GUICtrlSetData($Combo_VehicleClassId_Slot_2, $Value_MultiClassSlot2, $Value_MultiClassSlot2)
	GUICtrlSetData($Combo_VehicleClassId_Slot_3, $Value_MultiClassSlot3, $Value_MultiClassSlot3)

	;GUICtrlSetData($Combo_VehicleClassId_Slot_1, $Value_MultiClassSlot1)
	;GUICtrlSetData($Combo_VehicleClassId_Slot_2, $Value_MultiClassSlot2)
	;GUICtrlSetData($Combo_VehicleClassId_Slot_3, $Value_MultiClassSlot3)

	$Lua_Track_Name = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "TrackId", "")
	_TRACK_DropDown_3()

	Local $Value_FILL_SESSION_WITH_AI = IniRead($RC_LUA_Settings_ini_File, "Settings", "FILL_SESSION_WITH_AI", "")
	;IniWrite($config_ini, "Server_Einstellungen", "FILL_SESSION_WITH_AI", "true")
	Local $Value_OpponentDifficulty = IniRead($RC_LUA_Settings_ini_File, "Settings", "OpponentDifficulty", "")


	GUICtrlSetData($Wert_Input_Training_1, $Value_Training_1)
	GUICtrlSetData($Wert_Input_Qualifying, $Value_Qualify)
	GUICtrlSetData($Wert_Input_Race_1, $Value_Race)

	GUICtrlSetData($Wert_Input_Roling_Start, "true|false", $Value_RaceRollingStart)

	If $Value_FILL_SESSION_WITH_AI = "true" Then GUICtrlSetState($Checkbox_Flag_FILL_SESSION_WITH_AI, $GUI_CHECKED)
	If $Value_FILL_SESSION_WITH_AI <> "true" Then GUICtrlSetState($Checkbox_Flag_FILL_SESSION_WITH_AI, $GUI_UNCHECKED)

	If $Value_FILL_SESSION_WITH_AI = "true" Then GUICtrlSetState($Wert_Opponent_Difficulty, $GUI_ENABLE)
	If $Value_FILL_SESSION_WITH_AI <> "true" Then GUICtrlSetState($Wert_Opponent_Difficulty, $GUI_DISABLE)

	GUICtrlSetData($Wert_Opponent_Difficulty, $Value_OpponentDifficulty)

	If Not FileExists($sms_rotate_config_json_File) Then
		GUICtrlSetState($Checkbox_RCS_Lua_Track_Rotation, $GUI_UNCHECKED)
		GUICtrlSetState($Checkbox_RCS_Lua_Track_Rotation, $GUI_DISABLE)
		GUICtrlSetState($Checkbox_Flag_FILL_SESSION_WITH_AI, $GUI_DISABLE)
		GUICtrlSetState($Button_ServerControl_MoreSettings, $GUI_DISABLE)
		GUICtrlSetState($Checkbox_RCS_Activate_MultiClass, $GUI_DISABLE)
		_Disable_ServerControl_Controls()
		_Disable_ServerControl_Controls_MultiClass()
		GUICtrlSetState($Button_ServerControl_LUA_MoreSettings, $GUI_DISABLE)
	Else
		GUICtrlSetState($Checkbox_RCS_Lua_Track_Rotation, $GUI_ENABLE)
		GUICtrlSetState($Checkbox_Flag_FILL_SESSION_WITH_AI, $GUI_ENABLE)
		GUICtrlSetState($Button_ServerControl_MoreSettings, $GUI_ENABLE)
		;GUICtrlSetState($Checkbox_RCS_Activate_MultiClass, $GUI_ENABLE)
	EndIf
EndFunc


Func _Set_ServerControl_Objects_1()
	Local $Value_persist_index = IniRead($RC_LUA_Settings_ini_File, "Settings", "persist_index", "")
	Local $Value_Flags = IniRead($RC_LUA_Settings_ini_File, "Settings", "Flags", "")
	Local $Value_OpponentDifficulty = IniRead($RC_LUA_Settings_ini_File, "Settings", "OpponentDifficulty", "")
	Local $Value_DamageType = IniRead($RC_LUA_Settings_ini_File, "Settings", "DamageType", "")
	Local $Value_TireWearType = IniRead($RC_LUA_Settings_ini_File, "Settings", "TireWearType", "")
	Local $Value_FuelUsageType = IniRead($RC_LUA_Settings_ini_File, "Settings", "FuelUsageType", "")
	Local $Value_PenaltiesType = IniRead($RC_LUA_Settings_ini_File, "Settings", "PenaltiesType", "")
	Local $Value_AllowablePenaltyTime = IniRead($config_ini, "Server_Einstellungen", "AllowablePenaltyTime", "")
	Local $Value_PitWhiteLinePenalty = IniRead($config_ini, "Server_Einstellungen", "PitWhiteLinePenalty", "")
	Local $Value_DriveThroughPenalty = IniRead($RC_LUA_Settings_ini_File, "Settings", "DriveThroughPenalty", "")
	Local $Value_AllowedViews = IniRead($RC_LUA_Settings_ini_File, "Settings", "AllowedViews", "")
	Local $Value_ManualPitStops = IniRead($RC_LUA_Settings_ini_File, "Settings", "ManualPitStops", "")
		If $Value_ManualPitStops = 0 Then $Value_ManualPitStops = "Enable"
		If $Value_ManualPitStops = 1 Then $Value_ManualPitStops = "Disable"
	Local $Value_ManualRollingStarts = IniRead($RC_LUA_Settings_ini_File, "Settings", "ManualRollingStarts", "")
		If $Value_ManualRollingStarts = 0 Then $Value_ManualRollingStarts = "Disable"
		If $Value_ManualRollingStarts = 1 Then $Value_ManualRollingStarts = "Enable"
	Local $Value_MinimumOnlineRank = IniRead($RC_LUA_Settings_ini_File, "Settings", "MinimumOnlineRank", "")
	Local $Value_MinimumOnlineStrength = IniRead($RC_LUA_Settings_ini_File, "Settings", "MinimumOnlineStrength", "")

	Local $Value_PracticeLength = IniRead($RC_LUA_Settings_ini_File, "Settings", "PracticeLength", "")
	Local $Value_QualifyLength = IniRead($RC_LUA_Settings_ini_File, "Settings", "QualifyLength", "")
	Local $Value_RaceLength = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceLength", "")
	Local $Value_RaceRollingStart = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceRollingStart", "")
	If $Value_RaceRollingStart <> "0" Then
		$Value_RaceRollingStart = "Rolling"
	Else
		$Value_RaceRollingStart = "Standing"
	EndIf

	Local $Value_RaceFormationLap = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceFormationLap", "")
		If $Value_RaceFormationLap = 0 Then $Value_RaceFormationLap = "Disable"
		If $Value_RaceFormationLap = 1 Then $Value_RaceFormationLap = "Enable"
	Local $Value_RaceMandatoryPitStops = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceMandatoryPitStops", "")
		If $Value_RaceMandatoryPitStops = 0 Then $Value_RaceMandatoryPitStops = "Disable"
		If $Value_RaceMandatoryPitStops = 1 Then $Value_RaceMandatoryPitStops = "Enable"
	Local $Value_PracticeDateHour = IniRead($RC_LUA_Settings_ini_File, "Settings", "PracticeDateHour", "")
	Local $Value_PracticeDateProgression = IniRead($RC_LUA_Settings_ini_File, "Settings", "PracticeDateProgression", "")
		If $Value_PracticeDateProgression = 0 Then $Value_PracticeDateProgression = "OFF"
		If $Value_PracticeDateProgression = 1 Then $Value_PracticeDateProgression = "Real Time"
		If $Value_PracticeDateProgression <> 0 And $Value_PracticeDateProgression <> 1 Then $Value_PracticeDateProgression = $Value_PracticeDateProgression & "x"
	Local $Value_PracticeWeatherProgression = IniRead($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherProgression", "")
		If $Value_PracticeWeatherProgression = 0 Then $Value_PracticeWeatherProgression = "OFF"
		If $Value_PracticeWeatherProgression = 1 Then $Value_PracticeWeatherProgression = "Sync to Race"
		If $Value_PracticeWeatherProgression <> 0 And $Value_PracticeWeatherProgression <> 1 Then $Value_PracticeDateProgression = $Value_PracticeDateProgression & "x"

	Local $Value_QualifyDateHour = IniRead($RC_LUA_Settings_ini_File, "Settings", "QualifyDateHour", "")
	Local $Value_QualifyDateProgression = IniRead($RC_LUA_Settings_ini_File, "Settings", "QualifyDateProgression", "")
		If $Value_QualifyDateProgression = 0 Then $Value_QualifyDateProgression = "OFF"
		If $Value_QualifyDateProgression = 1 Then $Value_QualifyDateProgression = "Real Time"
		If $Value_QualifyDateProgression <> 0 And $Value_QualifyDateProgression <> 1 Then $Value_QualifyDateProgression = $Value_QualifyDateProgression & "x"
	Local $Value_QualifyWeatherProgression = IniRead($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherProgression", "")
		If $Value_QualifyWeatherProgression = 0 Then $Value_QualifyWeatherProgression = "OFF"
		If $Value_QualifyWeatherProgression = 1 Then $Value_QualifyWeatherProgression = "Sync to Race"
		If $Value_QualifyWeatherProgression <> 0 And $Value_QualifyWeatherProgression <> 1 Then $Value_QualifyWeatherProgression = $Value_QualifyWeatherProgression & "x"
	Local $Value_RaceDateYear = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceDateYear", "")
	Local $Value_RaceDateMonth = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceDateMonth", "")
	Local $Value_RaceDateDay = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceDateDay", "")
	Local $Value_RaceDateHour = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceDateHour", "")
	Local $Value_RaceDateProgression = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceDateProgression", "")
		If $Value_RaceDateProgression = 0 Then $Value_RaceDateProgression = "OFF"
		If $Value_RaceDateProgression = 1 Then $Value_RaceDateProgression = "Real Time"
		If $Value_RaceDateProgression <> 0 And $Value_RaceDateProgression <> 1 Then $Value_RaceDateProgression = $Value_RaceDateProgression & "x"
	Local $Value_RaceWeatherProgression = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherProgression", "")
		If $Value_RaceWeatherProgression = 0 Then $Value_RaceWeatherProgression = "OFF"
		If $Value_RaceWeatherProgression = 1 Then $Value_RaceWeatherProgression = "Sync to Race"
		If $Value_RaceWeatherProgression <> 0 And $Value_RaceWeatherProgression <> 1 Then $Value_RaceWeatherProgression = $Value_RaceWeatherProgression & "x"

	Local $Value_PracticeWeatherSlots = IniRead($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlots", "")
	Local $Value_PracticeWeatherSlot1 = IniRead($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlot1", "")
	Local $Value_PracticeWeatherSlot2 = IniRead($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlot2", "")
	Local $Value_PracticeWeatherSlot3 = IniRead($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlot3", "")
	Local $Value_PracticeWeatherSlot4 = IniRead($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlot4", "")

	Local $Value_QualifyWeatherSlots = IniRead($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlots", "")
	Local $Value_QualifyWeatherSlot1 = IniRead($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlot1", "")
	Local $Value_QualifyWeatherSlot2 = IniRead($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlot2", "")
	Local $Value_QualifyWeatherSlot3 = IniRead($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlot3", "")
	Local $Value_QualifyWeatherSlot4 = IniRead($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlot4", "")


	Local $Value_RaceWeatherSlots = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlots", "")
	Local $Value_RaceWeatherSlot1 = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlot1", "")
	Local $Value_RaceWeatherSlot2 = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlot2", "")
	Local $Value_RaceWeatherSlot3 = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlot3", "")
	Local $Value_RaceWeatherSlot4 = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlot4", "")








	GUICtrlSetData($Wert_persist_index, "true|false", $Value_persist_index)
	GUICtrlSetData($Wert_Flags, $Value_Flags)
	GUICtrlSetData($Wert_OpponentDifficulty, $Value_OpponentDifficulty)

	GUICtrlSetData($Wert_DamageType, "OFF|VISUAL_ONLY|PERFORMANCEIMPACTING|FULL", $Value_DamageType)
	GUICtrlSetData($Wert_TireWearType, "OFF|SLOW|STANDARD|X2|X3|X4|X5|X6|X7", $Value_TireWearType)
	GUICtrlSetData($Wert_FuelUsageType, "STANDARD|SLOW|OFF", $Value_FuelUsageType)
	GUICtrlSetData($Wert_PenaltiesType, "NONE|FULL", $Value_PenaltiesType)
	GUICtrlSetData($Wert_AllowedViews, "Any|CockpitHelmet", $Value_AllowedViews)
	GUICtrlSetData($Wert_ManualPitStops, "Enable|Disable", $Value_ManualPitStops)
	GUICtrlSetData($Wert_ManualRollingStarts, "Disable|Enable", $Value_ManualRollingStarts)
	GUICtrlSetData($Wert_MinimumOnlineRank, "U|F|E|D|C|B|A|S", $Value_MinimumOnlineRank)
	GUICtrlSetData($Wert_MinimumOnlineStrength, "100|500|1000|1500|2000|2500|3000|3500|4000|4500|5000", $Value_MinimumOnlineStrength)

	GUICtrlSetData($Wert_PracticeLength, $Value_PracticeLength)
	GUICtrlSetData($Wert_QualifyLength, $Value_QualifyLength)
	GUICtrlSetData($Wert_RaceLength, $Value_RaceLength)
	GUICtrlSetData($Wert_RaceRollingStart, "Standing|Rolling", $Value_RaceRollingStart)
	GUICtrlSetData($Wert_RaceFormationLap, "Disable|Enable", $Value_RaceFormationLap)
	GUICtrlSetData($Wert_RaceMandatoryPitStops, "Disable|Enable", $Value_RaceMandatoryPitStops)

	GUICtrlSetData($Wert_PracticeDateHour, $Value_PracticeDateHour)
	GUICtrlSetData($Wert_PracticeDateProgression, "OFF|Real Time|2x|5x|10x|15x|20x|25x|30x|40x|50x|60x", $Value_PracticeDateProgression)
	GUICtrlSetData($Wert_PracticeWeatherProgression, "OFF|Sync to Race|2x|5x|10x|15x|20x|25x|30x|40x|50x|60x", $Value_PracticeWeatherProgression)

	GUICtrlSetData($Wert_QualifyDateHour, $Value_QualifyDateHour)
	GUICtrlSetData($Wert_QualifyDateProgression, "OFF|Real Time|2x|5x|10x|15x|20x|25x|30x|40x|50x|60x", $Value_QualifyDateProgression)
	GUICtrlSetData($Wert_QualifyWeatherProgression, "OFF|Sync to Race|2x|5x|10x|15x|20x|25x|30x|40x|50x|60x", $Value_QualifyWeatherProgression)

	GUICtrlSetData($Wert_RaceDateYear, $Value_RaceDateYear)
	GUICtrlSetData($Wert_RaceDateMonth, $Value_RaceDateMonth)
	GUICtrlSetData($Wert_RaceDateDay, $Value_RaceDateDay)

	GUICtrlSetData($Wert_RaceDateHour, $Value_RaceDateHour)
	GUICtrlSetData($Wert_RaceDateProgression, "OFF|Real Time|2x|5x|10x|15x|20x|25x|30x|40x|50x|60x", $Value_RaceDateProgression)
	GUICtrlSetData($Wert_RaceWeatherProgression, "OFF|Sync to Race|2x|5x|10x|15x|20x|25x|30x|40x|50x|60x", $Value_RaceWeatherProgression)

	GUICtrlSetData($Wert_PracticeWeatherSlots, $Value_PracticeWeatherSlots)
	GUICtrlSetData($Wert_PracticeWeatherSlot1, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_PracticeWeatherSlot1)
	GUICtrlSetData($Wert_PracticeWeatherSlot2, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_PracticeWeatherSlot2)
	GUICtrlSetData($Wert_PracticeWeatherSlot3, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_PracticeWeatherSlot3)
	GUICtrlSetData($Wert_PracticeWeatherSlot4, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_PracticeWeatherSlot4)

	GUICtrlSetData($Wert_QualifyWeatherSlots, $Value_QualifyWeatherSlots)
	GUICtrlSetData($Wert_QualifyWeatherSlot1, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_QualifyWeatherSlot1)
	GUICtrlSetData($Wert_QualifyWeatherSlot2, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_QualifyWeatherSlot2)
	GUICtrlSetData($Wert_QualifyWeatherSlot3, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_QualifyWeatherSlot3)
	GUICtrlSetData($Wert_QualifyWeatherSlot4, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_QualifyWeatherSlot4)

	GUICtrlSetData($Wert_RaceWeatherSlots, $Value_RaceWeatherSlots)
	GUICtrlSetData($Wert_RaceWeatherSlot1, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_RaceWeatherSlot1)
	GUICtrlSetData($Wert_RaceWeatherSlot2, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_RaceWeatherSlot2)
	GUICtrlSetData($Wert_RaceWeatherSlot3, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_RaceWeatherSlot3)
	GUICtrlSetData($Wert_RaceWeatherSlot4, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_RaceWeatherSlot4)

	;GUICtrlSetData($Wert_DamageType, "100|500|1000|1500|2000|2500|3000|3500|4000|4500|5000", $Value_DamageType)

	Local $Value_FILL_SESSION_WITH_AI = IniRead($RC_LUA_Settings_ini_File, "Settings", "FILL_SESSION_WITH_AI", "")
	Local $Value_OpponentDifficulty = IniRead($RC_LUA_Settings_ini_File, "Settings", "OpponentDifficulty", "")

	If $Value_FILL_SESSION_WITH_AI = "true" Then GUICtrlSetState($Checkbox_Flag_FILL_SESSION_WITH_AI, $GUI_CHECKED)
	If $Value_FILL_SESSION_WITH_AI <> "true" Then GUICtrlSetState($Checkbox_Flag_FILL_SESSION_WITH_AI, $GUI_UNCHECKED)

	GUICtrlSetData($Wert_Opponent_Difficulty, $Value_OpponentDifficulty)

EndFunc


Func _Set_ServerControl_Objects_2()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)

	Local $Value_TrackId = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "TrackId", "")
		If StringLen($Value_TrackId) > 25 Then $Value_TrackId = StringLeft($Value_TrackId, 24) & "."
	Local $Value_ABS_ALLOWED = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "Flags", "")
		If $Value_ABS_ALLOWED = "ABS_ALLOWED" Then $Value_ABS_ALLOWED = "true"
		If $Value_ABS_ALLOWED <> "ABS_ALLOWED" And $Value_ABS_ALLOWED <> "true" Then $Value_ABS_ALLOWED = "false"
	Local $Value_TCS_ALLOWED = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RemoveFlags", "")
		If $Value_TCS_ALLOWED = "TCS_ALLOWED" Then $Value_TCS_ALLOWED = "true"
		If $Value_TCS_ALLOWED <> "TCS_ALLOWED" And  $Value_TCS_ALLOWED <> "true" Then $Value_TCS_ALLOWED = "false"
	Local $Value_ManualRollingStarts = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "ManualRollingStarts", "")
		If $Value_ManualRollingStarts = 1 Then $Value_ManualRollingStarts = "true"
		If $Value_ManualRollingStarts = 0 Then $Value_ManualRollingStarts = "false"
	Local $Value_RaceRollingStart = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceRollingStart", "")
		If $Value_RaceRollingStart = 1 Then $Value_RaceRollingStart = "true"
		If $Value_RaceRollingStart = 0 Then $Value_RaceRollingStart = "false"
	Local $Value_RaceFormationLap = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceFormationLap", "")
		If $Value_RaceFormationLap = 1 Then $Value_RaceFormationLap = "true"
		If $Value_RaceFormationLap = 0 Then $Value_RaceFormationLap = "false"
	Local $Value_PracticeLength = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeLength", "")
	Local $Value_PracticeDateHour = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeDateHour", "")
	Local $Value_QualifyLength = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyLength", "")
	Local $Value_QualifyDateHour = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyDateHour", "")
	Local $Value_RaceLength = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceLength", "")
	Local $Value_RaceDateYear = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceDateYear", "")
	Local $Value_RaceDateMonth = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceDateMonth", "")
	Local $Value_RaceDateDay = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceDateDay", "")
	Local $Value_RaceDateHour = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceDateHour", "")

	Local $Value_PracticeWeatherSlots = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeWeatherSlots", "")
	Local $Value_PracticeWeatherSlot1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeWeatherSlot1", "")
	Local $Value_PracticeWeatherSlot2 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeWeatherSlot2", "")
	Local $Value_PracticeWeatherSlot3 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeWeatherSlot3", "")
	Local $Value_PracticeWeatherSlot4 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeWeatherSlot4", "")

	Local $Value_QualifyWeatherSlots = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyWeatherSlots", "")
	Local $Value_QualifyWeatherSlot1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyWeatherSlot1", "")
	Local $Value_QualifyWeatherSlot2 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyWeatherSlot2", "")
	Local $Value_QualifyWeatherSlot3 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyWeatherSlot3", "")
	Local $Value_QualifyWeatherSlot4 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyWeatherSlot4", "")

	Local $Value_RaceWeatherSlots = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceWeatherSlots", "")
	Local $Value_RaceWeatherSlot1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceWeatherSlot1", "")
	Local $Value_RaceWeatherSlot2 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceWeatherSlot2", "")
	Local $Value_RaceWeatherSlot3 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceWeatherSlot3", "")
	Local $Value_RaceWeatherSlot4 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceWeatherSlot4", "")


	GUICtrlSetData($LUA_Label_Track, $Value_TrackId)

	GUICtrlSetData($LUA_Combo_ABS_ALLOWED, "true|false", $Value_ABS_ALLOWED)
	GUICtrlSetData($LUA_Combo_TCS_ALLOWED, "true|false", $Value_TCS_ALLOWED)
	GUICtrlSetData($LUA_Combo_ManualRollingStarts, "true|false", $Value_ManualRollingStarts)
	GUICtrlSetData($LUA_Combo_RaceRollingStart, "true|false", $Value_RaceRollingStart)
	GUICtrlSetData($LUA_Combo_RaceFormationLap, "true|false", $Value_RaceFormationLap)
	GUICtrlSetData($LUA_Combo_PracticeLength, $Value_PracticeLength)
	GUICtrlSetData($LUA_Combo_PracticeDateHour, $Value_PracticeDateHour)
	GUICtrlSetData($LUA_Combo_QualifyLength, $Value_QualifyLength)
	GUICtrlSetData($LUA_Combo_QualifyDateHour, $Value_QualifyDateHour)
	GUICtrlSetData($LUA_Combo_RaceLength, $Value_RaceLength)
	GUICtrlSetData($LUA_Combo_RaceDateYear, $Value_RaceDateYear)
	GUICtrlSetData($LUA_Combo_RaceDateMonth, $Value_RaceDateMonth)
	GUICtrlSetData($LUA_Combo_RaceDateDay, $Value_RaceDateDay)
	GUICtrlSetData($LUA_Combo_RaceDateHour, $Value_RaceDateHour)

	GUICtrlSetData($LUA_PracticeWeatherSlots, $Value_PracticeWeatherSlots)
	GUICtrlSetData($LUA_PracticeWeatherSlot1, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_PracticeWeatherSlot1)
	GUICtrlSetData($LUA_PracticeWeatherSlot2, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_PracticeWeatherSlot2)
	GUICtrlSetData($LUA_PracticeWeatherSlot3, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_PracticeWeatherSlot3)
	GUICtrlSetData($LUA_PracticeWeatherSlot4, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_PracticeWeatherSlot4)

	GUICtrlSetData($LUA_QualifyWeatherSlots, $Value_QualifyWeatherSlots)
	GUICtrlSetData($LUA_QualifyWeatherSlot1, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_QualifyWeatherSlot1)
	GUICtrlSetData($LUA_QualifyWeatherSlot2, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_QualifyWeatherSlot2)
	GUICtrlSetData($LUA_QualifyWeatherSlot3, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_QualifyWeatherSlot3)
	GUICtrlSetData($LUA_QualifyWeatherSlot4, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_QualifyWeatherSlot4)

	GUICtrlSetData($LUA_RaceWeatherSlots, $Value_RaceWeatherSlots)
	GUICtrlSetData($LUA_RaceWeatherSlot1, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_RaceWeatherSlot1)
	GUICtrlSetData($LUA_RaceWeatherSlot2, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_RaceWeatherSlot2)
	GUICtrlSetData($LUA_RaceWeatherSlot3, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_RaceWeatherSlot3)
	GUICtrlSetData($LUA_RaceWeatherSlot4, "Clear|LightCloud|MediumCloud|HeavyCloud|Overcast|Foggy|HeavyFog|Hazy|Storm|ThunderStorm|Rain|LightRain|snow|heavysnow|blizzard|HeavyFog|HeavyFogWithRain|random", $Value_RaceWeatherSlot4)


EndFunc





Func _DropDown_VehicleClassId()
	$Anzahl_Zeilen_TrackList = _FileCountLines($VehicleClassesList_TXT)

	$Wert_Track = ""
	$Werte_Tack = ""
	$Wert_Track_ID = ""
	$Check_Line = ""
	$Wert_Track_Standard = ""

	For $Schleife_TRACK_DropDown = 5 To $Anzahl_Zeilen_TrackList Step 4
		$Durchgang_NR = $Schleife_TRACK_DropDown - 4

		$Wert_Track = FileReadLine($VehicleClassesList_TXT, $Schleife_TRACK_DropDown + 1)
		$Wert_Track = StringReplace($Wert_Track, '      "name" : "', '')
		$Wert_Track = StringReplace($Wert_Track, '"', '')
		$Wert_Track = StringReplace($Wert_Track, ',', '')
		$Wert_Track = StringReplace($Wert_Track, '}', '')
		;MsgBox(0, "$Wert_Track", $Wert_Track)

		;$Werte_Tack = $Werte_Tack & "|" & $Wert_Track
		If $Wert_Track <> "" Then _ArrayAdd($Array_VehicleClassesList, $Wert_Track)

		;If $Wert_Track_ID = $Wert_TrackId_Standard Then $Wert_Track_Standard = $Wert_Track

		;If $Durchgang_NR = 1 Then $Werte_Tack = $Wert_Track
	Next

	;_ArrayDisplay($Array_VehicleClassesList)
	_ArraySort($Array_VehicleClassesList, 0, 1, 0, 0)

	For $Loop = 1 To UBound($Array_VehicleClassesList) - 1
		$Werte_Tack = $Werte_Tack & "|" & $Array_VehicleClassesList[$Loop]
		If $Loop = 1 Then $Werte_Tack = $Array_VehicleClassesList[$Loop]
	Next

	GUICtrlSetData($Combo_VehicleClassId, "Choose VehicleClass" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Tack, $Wert_Track_Standard)
	GUICtrlSetData($Combo_VehicleClassId_Slot_1, "Choose VehicleClass" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Tack, $Wert_Track_Standard)
	GUICtrlSetData($Combo_VehicleClassId_Slot_2, "Choose VehicleClass" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Tack, $Wert_Track_Standard)
	GUICtrlSetData($Combo_VehicleClassId_Slot_3, "Choose VehicleClass" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Tack, $Wert_Track_Standard)
	GUISetState()
	;_ArrayDisplay($Array_VehicleClassesList)
EndFunc


Func _Checkbox_RCS_Lua_Track_Rotation()
	If FileExists($sms_rotate_config_json_File) Then
		Local $Value_Temp = GUICtrlRead($Checkbox_RCS_Lua_Track_Rotation)
		If $Value_Temp = "1" Then
			$Value_Temp = "true"
			_Enable_ServerControl_Controls()
			_Enable_ServerControl_Controls_MultiClass()
			_Read_sms_rotate_config_json()
			GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
		Else
			$Value_Temp = "false"
			_Disable_ServerControl_Controls()
			_Disable_ServerControl_Controls_MultiClass()
			GUICtrlSetState($Button_ServerControl_LUA_MoreSettings, $GUI_DISABLE)
		EndIf
		IniWrite($config_ini, "Server_Einstellungen", "SMS_Rotate", $Value_Temp)
	Else
		MsgBox($MB_OK + $MB_ICONINFORMATION, "Missing 'sms_rotate_config.json' File", "Missing 'sms_rotate_config.json' File.")
		_Disable_ServerControl_Controls()
		_Disable_ServerControl_Controls_MultiClass()
		GUICtrlSetState($Button_ServerControl_LUA_MoreSettings, $GUI_DISABLE)
	EndIf
EndFunc

Func _Checkbox_RCS_ControlGameSetup()
	Local $Value_Temp = GUICtrlRead($Checkbox_RCS_ControlGameSetup)
	If $Value_Temp = "1" Then
		$Value_Temp = "true"
		GUICtrlSetState($Checkbox_RCS_Lua_Track_Rotation, $GUI_ENABLE)
		GUICtrlSetState($Checkbox_RCS_ServerControlsTrack, $GUI_ENABLE)
		GUICtrlSetState($Checkbox_RCS_ServerControlsVehicleClass, $GUI_ENABLE)
		GUICtrlSetState($Checkbox_RCS_ServerControlsVehicle, $GUI_ENABLE)
		_Enable_ServerControl_Controls()
	Else
		$Value_Temp = "false"
		GUICtrlSetState($Checkbox_RCS_Lua_Track_Rotation, $GUI_DISABLE)
		GUICtrlSetState($Checkbox_RCS_ServerControlsTrack, $GUI_DISABLE)
		GUICtrlSetState($Checkbox_RCS_ServerControlsVehicleClass, $GUI_DISABLE)
		GUICtrlSetState($Checkbox_RCS_ServerControlsVehicle, $GUI_DISABLE)
		_Disable_ServerControl_Controls()
	EndIf
	IniWrite($config_ini, "Server_Einstellungen", "controlGameSetup", $Value_Temp)
EndFunc

Func _Checkbox_RCS_ServerControlsTrack()
	Local $Value_Temp = GUICtrlRead($Checkbox_RCS_ServerControlsTrack)
	If $Value_Temp = "1" Then
		$Value_Temp = "1"
	Else
		$Value_Temp = "0"
	EndIf
	IniWrite($config_ini, "Server_Einstellungen", "ServerControlsTrack", $Value_Temp)
EndFunc

Func _Checkbox_RCS_ServerControlsVehicleClass()
	Local $Value_Temp = GUICtrlRead($Checkbox_RCS_ServerControlsVehicleClass)
	If $Value_Temp = "1" Then
		$Value_Temp = "1"
	Else
		$Value_Temp = "0"
	EndIf
	IniWrite($config_ini, "Server_Einstellungen", "ServerControlsVehicleClass", $Value_Temp)
EndFunc

Func _Checkbox_RCS_ServerControlsVehicle()
	Local $Value_Temp = GUICtrlRead($Checkbox_RCS_ServerControlsVehicle)
	If $Value_Temp = "1" Then
		$Value_Temp = "1"
	Else
		$Value_Temp = "0"
	EndIf
	IniWrite($config_ini, "Server_Einstellungen", "ServerControlsVehicle", $Value_Temp)
EndFunc



Func _Wert_UpDpwn_Track_Nr()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 100)
	Local $Value_NR_Of_Tracks_TrackRotation = IniRead($RC_LUA_Settings_ini_File, "Settings", "NR_Of_Tracks_TrackRotation", "")
	Local $Value_NR_Tracks = GUICtrlRead($Wert_Track_Nr)
	If $Value_NR_Tracks < 0 Then
		$Value_NR_Tracks = 0
		GUICtrlSetData($Wert_Track_Nr, 0)
	EndIf

	If Int($Value_NR_Tracks) > Int($Value_NR_Of_Tracks_TrackRotation) Then
		$Value_NR_Tracks = $Value_NR_Of_Tracks_TrackRotation
		GUICtrlSetData($Wert_Track_Nr, $Value_NR_Of_Tracks_TrackRotation)
	EndIf

	Local $Value_Temp = GUICtrlRead($Checkbox_RCS_Lua_Track_Rotation)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "NR_Tracks", $Value_Temp)

	$Lua_Track_Name = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "TrackId", "")
	_TRACK_DropDown_3()


	Local $Value_Activate_MultiClass = IniRead($RC_LUA_Settings_ini_File, "Settings", "Activate_MultiClass", "")
	Local $Value_NR_Of_Tracks_TrackRotation = IniRead($RC_LUA_Settings_ini_File, "Settings", "NR_Of_Tracks_TrackRotation", "")
	Local $Value_VehicleClassId = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "VehicleClassId", "")
	Local $Value_MultiClassSlots = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "MultiClassSlots", "")
	Local $Value_MultiClassSlot1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "MultiClassSlot1", "")
	Local $Value_MultiClassSlot2 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "MultiClassSlot2", "")
	Local $Value_MultiClassSlot3 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "MultiClassSlot3", "")

	Local $Value_Training_1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "PracticeLength", "")
	Local $Value_Qualify = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "QualifyLength", "")
	Local $Value_Race = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "RaceLength", "")
	Local $Value_RaceRollingStart = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_NR_Tracks, "RaceRollingStart", "")
	If $Value_RaceRollingStart = "1" Then
		$Value_RaceRollingStart = "true"
	Else
		$Value_RaceRollingStart = "false"
	EndIf



	If $Value_NR_Tracks = 0 Then
		$Value_VehicleClassId = IniRead($RC_LUA_Settings_ini_File, "Settings", "VehicleClassId", "")
		$Value_MultiClassSlots = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlots", "")
		$Value_MultiClassSlot1 = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot1", "")
		$Value_MultiClassSlot2 = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot2", "")
		$Value_MultiClassSlot3 = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot3", "")
		$Value_Training_1 = IniRead($RC_LUA_Settings_ini_File, "Settings", "PracticeLength", "")
		$Value_Qualify = IniRead($RC_LUA_Settings_ini_File, "Settings", "QualifyLength", "")
		$Value_Race = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceLength", "")
		$Value_RaceRollingStart = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceRollingStart", "")
		If $Value_RaceRollingStart = "1" Then
			$Value_RaceRollingStart = "true"
		Else
			$Value_RaceRollingStart = "false"
		EndIf
	EndIf


	If StringIsDigit(StringTrimLeft($Value_VehicleClassId, 1)) Then
		IniWrite($config_ini, "TEMP", "Check_VehicleClassID", $Value_VehicleClassId)
		;MsgBox($MB_SYSTEMMODAL, "", "The variable is a number")
		_Get_Name_from_VehicleClassesList_TXT()
		$Value_VehicleClassId = IniRead($config_ini, "TEMP", "Check_VehicleClassName", "")
	EndIf

	If StringIsDigit(StringTrimLeft($Value_MultiClassSlot1, 1)) Then
		IniWrite($config_ini, "TEMP", "Check_VehicleClassID", $Value_MultiClassSlot1)
		;MsgBox($MB_SYSTEMMODAL, "", "The variable is a number")
		_Get_Name_from_VehicleClassesList_TXT()
		$Value_MultiClassSlot1 = IniRead($config_ini, "TEMP", "Check_VehicleClassName", "")
	EndIf

	If StringIsDigit(StringTrimLeft($Value_MultiClassSlot2, 1)) Then
		IniWrite($config_ini, "TEMP", "Check_VehicleClassID", $Value_MultiClassSlot2)
		;MsgBox($MB_SYSTEMMODAL, "", "The variable is a number")
		_Get_Name_from_VehicleClassesList_TXT()
		$Value_MultiClassSlot2 = IniRead($config_ini, "TEMP", "Check_VehicleClassName", "")
	EndIf

	If StringIsDigit(StringTrimLeft($Value_MultiClassSlot3, 1)) Then
		IniWrite($config_ini, "TEMP", "Check_VehicleClassID", $Value_MultiClassSlot3)
		;MsgBox($MB_SYSTEMMODAL, "", "The variable is a number")
		_Get_Name_from_VehicleClassesList_TXT()
		$Value_MultiClassSlot3 = IniRead($config_ini, "TEMP", "Check_VehicleClassName", "")
	EndIf


	GUICtrlSetData($Wert_Input_NR_Of_Tracks_TrackRotation, $Value_NR_Of_Tracks_TrackRotation)
	GUICtrlSetData($Combo_VehicleClassId, $Value_VehicleClassId)
	GUICtrlSetData($Wert_NR_MultiClassSlots, $Value_MultiClassSlots)
	GUICtrlSetData($Combo_VehicleClassId_Slot_1, $Value_MultiClassSlot1, $Value_MultiClassSlot1)
	GUICtrlSetData($Combo_VehicleClassId_Slot_2, $Value_MultiClassSlot2, $Value_MultiClassSlot2)
	GUICtrlSetData($Combo_VehicleClassId_Slot_3, $Value_MultiClassSlot3, $Value_MultiClassSlot3)

	GUICtrlSetData($Wert_Input_Training_1, $Value_Training_1)
	GUICtrlSetData($Wert_Input_Qualifying, $Value_Qualify)
	GUICtrlSetData($Wert_Input_Race_1, $Value_Race)

	GUICtrlSetData($Wert_Input_Roling_Start, "", $Value_RaceRollingStart)
	GUICtrlSetData($Wert_Input_Roling_Start, "true|false", $Value_RaceRollingStart)

	If WinExists("LUA - More Settings") Then
		_Set_ServerControl_Objects_2()
	EndIf

	Sleep(500)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
EndFunc



Func _Wert_UpDpwn_NR_Of_Tracks_TrackRotation()
	Local $Value_Temp = GUICtrlRead($Wert_Input_NR_Of_Tracks_TrackRotation)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "NR_Of_Tracks_TrackRotation", $Value_Temp)
EndFunc

Func _Combo_TRACK_2()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp_Name_old = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "TrackId", "")

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "TrackId", $Value_Temp_Name)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "TrackId", $Value_Temp_Name)
	;IniDelete($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "TrackId")
EndFunc



Func _Wert_Input_Training_1()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($Wert_Input_Training_1)

	If $Value_Temp_Nr = 0 Then
		IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeLength", $Value_Temp)
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeLength", $Value_Temp)
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "PracticeLength", $Value_Temp)
	EndIf
EndFunc

Func _Wert_Input_Qualifying()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($Wert_Input_Qualifying)

	If $Value_Temp_Nr = 0 Then
		IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyLength", $Value_Temp)
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyLength", $Value_Temp)
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "QualifyLength", $Value_Temp)
	EndIf
EndFunc

Func _Wert_Input_Race_1()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($Wert_Input_Race_1)

	If $Value_Temp_Nr = 0 Then
		IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceLength", $Value_Temp)
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceLength", $Value_Temp)
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceLength", $Value_Temp)
	EndIf
EndFunc

Func _Wert_Input_Roling_Start()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($Wert_Input_Roling_Start)

	If $Value_Temp_Nr = 0 Then
		IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceRollingStart", $Value_Temp)
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceRollingStart", $Value_Temp)
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceRollingStart", $Value_Temp)
	EndIf
EndFunc

Func _Wert_Opponent_Difficulty()
	Local $Value_Temp = GUICtrlRead($Wert_Opponent_Difficulty)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "OpponentDifficulty", $Value_Temp)
EndFunc


Func _Checkbox_Flag_FILL_SESSION_WITH_AI()
	Local $Value_GridSize = IniRead($config_ini, "Server_Einstellungen", "GridSize", "")
	Local $Value_maxPlayerCount = IniRead($config_ini, "Server_Einstellungen", "maxPlayerCount", "")
	Local $Value_NR_AI = $Value_maxPlayerCount - $Value_GridSize

	Local $Value_NR_Tracks = GUICtrlRead($Checkbox_Flag_FILL_SESSION_WITH_AI)

	If $Value_NR_Tracks = 1 Then
		MsgBox($MB_OK + $MB_ICONINFORMATION, "Fill Session With AI", "Number of AI with current Settings:" & @CRLF & _
																			$Value_NR_AI & @CRLF & @CRLF & _
																			"Attention: " & @CRLF & "Maximum number of players must be less than the grid size." & @CRLF & _
																			"The result between grid size and max. amount of allowed" & @CRLF & _
																			"players will the the number of AI vehicles." & @CRLF & @CRLF)
		IniWrite($RC_LUA_Settings_ini_File, "Settings", "FILL_SESSION_WITH_AI", "true")
		GUICtrlSetState($Wert_Opponent_Difficulty, $GUI_ENABLE)
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Settings", "FILL_SESSION_WITH_AI", "false")
		GUICtrlSetState($Wert_Opponent_Difficulty, $GUI_DISABLE)
	EndIf
EndFunc

Func _Checkbox_RCS_Activate_MultiClass()
	$Value_Temp = GUICtrlRead($Checkbox_RCS_Activate_MultiClass)
	If $Value_Temp = 1 Then
		_Enable_ServerControl_Controls_MultiClass()
		IniWrite($config_ini, "Server_Einstellungen", "Activate_MultiClass", "true")
	Else
		_Disable_ServerControl_Controls_MultiClass()
		IniWrite($config_ini, "Server_Einstellungen", "Activate_MultiClass", "false")
	EndIf
EndFunc


Func _Enable_ServerControl_Controls()
	GUICtrlSetState($Checkbox_RCS_Activate_MultiClass, $GUI_ENABLE)
	GUICtrlSetState($Button_ServerControl_LUA_MoreSettings, $GUI_ENABLE)
	GUICtrlSetState($Button_ServerControl_Save_2, $GUI_ENABLE)
	GUICtrlSetState($Button_ServerControl_Restart_DS_2, $GUI_ENABLE)

	GUICtrlSetState($Wert_Input_NR_Of_Tracks_TrackRotation, $GUI_ENABLE)
	GUICtrlSetState($Wert_Track_Nr, $GUI_ENABLE)
	GUICtrlSetState($Combo_TRACK_2, $GUI_ENABLE)
	GUICtrlSetState($Combo_VehicleClassId, $GUI_ENABLE)
	GUICtrlSetState($Wert_NR_MultiClassSlots, $GUI_ENABLE)
	GUICtrlSetState($Combo_VehicleClassId_Slot_1, $GUI_ENABLE)
	GUICtrlSetState($Combo_VehicleClassId_Slot_2, $GUI_ENABLE)
	GUICtrlSetState($Combo_VehicleClassId_Slot_3, $GUI_ENABLE)
	GUICtrlSetState($Wert_Input_Training_1, $GUI_ENABLE)
	GUICtrlSetState($Wert_Input_Qualifying, $GUI_ENABLE)
	GUICtrlSetState($Wert_Input_Race_1, $GUI_ENABLE)
	GUICtrlSetState($Wert_Input_Roling_Start, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_RCS_Lua_Track_Rotation, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_Flag_FILL_SESSION_WITH_AI, $GUI_ENABLE)
	GUICtrlSetState($Button_ServerControl_MoreSettings, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_RCS_Activate_MultiClass, $GUI_ENABLE)
	GUICtrlSetState($Wert_Opponent_Difficulty, $GUI_ENABLE)
EndFunc

Func _Disable_ServerControl_Controls()
	GUICtrlSetState($Checkbox_RCS_Activate_MultiClass, $GUI_DISABLE)
	GUICtrlSetState($Button_ServerControl_LUA_MoreSettings, $GUI_DISABLE)
	GUICtrlSetState($Button_ServerControl_Save_2, $GUI_DISABLE)
	GUICtrlSetState($Button_ServerControl_Restart_DS_2, $GUI_DISABLE)

	GUICtrlSetState($Wert_Input_NR_Of_Tracks_TrackRotation, $GUI_DISABLE)
	GUICtrlSetState($Wert_Track_Nr, $GUI_DISABLE)
	GUICtrlSetState($Combo_TRACK_2, $GUI_DISABLE)

	GUICtrlSetState($Combo_VehicleClassId, $GUI_DISABLE)
	GUICtrlSetState($Wert_NR_MultiClassSlots, $GUI_DISABLE)
	GUICtrlSetState($Combo_VehicleClassId_Slot_1, $GUI_DISABLE)
	GUICtrlSetState($Combo_VehicleClassId_Slot_2, $GUI_DISABLE)
	GUICtrlSetState($Combo_VehicleClassId_Slot_3, $GUI_DISABLE)

	GUICtrlSetState($Wert_Input_Training_1, $GUI_DISABLE)
	GUICtrlSetState($Wert_Input_Qualifying, $GUI_DISABLE)
	GUICtrlSetState($Wert_Input_Race_1, $GUI_DISABLE)
	GUICtrlSetState($Wert_Input_Roling_Start, $GUI_DISABLE)

	GUICtrlSetState($Checkbox_Flag_FILL_SESSION_WITH_AI, $GUI_DISABLE)
	GUICtrlSetState($Button_ServerControl_MoreSettings, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_RCS_Activate_MultiClass, $GUI_DISABLE)
	GUICtrlSetState($Wert_Opponent_Difficulty, $GUI_DISABLE)
EndFunc

Func _Enable_ServerControl_Controls_MultiClass()
	GUICtrlSetState($Button_ServerControl_LUA_MoreSettings, $GUI_ENABLE)
	GUICtrlSetState($Combo_VehicleClassId, $GUI_ENABLE)
	GUICtrlSetState($Wert_NR_MultiClassSlots, $GUI_ENABLE)
	GUICtrlSetState($Combo_VehicleClassId_Slot_1, $GUI_ENABLE)
	GUICtrlSetState($Combo_VehicleClassId_Slot_2, $GUI_ENABLE)
	GUICtrlSetState($Combo_VehicleClassId_Slot_3, $GUI_ENABLE)
EndFunc

Func _Disable_ServerControl_Controls_MultiClass()
	GUICtrlSetState($Combo_VehicleClassId, $GUI_DISABLE)
	GUICtrlSetState($Wert_NR_MultiClassSlots, $GUI_DISABLE)
	GUICtrlSetState($Combo_VehicleClassId_Slot_1, $GUI_DISABLE)
	GUICtrlSetState($Combo_VehicleClassId_Slot_2, $GUI_DISABLE)
	GUICtrlSetState($Combo_VehicleClassId_Slot_3, $GUI_DISABLE)
EndFunc



Func _Enable_API_GameControl_Objects()
	GUICtrlSetState($Combo_CAR, $GUI_ENABLE)
	GUICtrlSetState($Button_Set_Car_Attribute, $GUI_ENABLE)
	GUICtrlSetState($Combo_TRACK, $GUI_ENABLE)
	GUICtrlSetState($Button_Set_Track_Attribute, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_RC_Training_1, $GUI_ENABLE)
	GUICtrlSetState($Button_Set_Training_1_Attribute, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_RC_Qualifying, $GUI_ENABLE)
	GUICtrlSetState($Combo_Time_Qualifying, $GUI_ENABLE)
	GUICtrlSetState($Button_Set_Qualifying_Attribute, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_RC_Race_1, $GUI_ENABLE)
	GUICtrlSetState($Wert_Race_1, $GUI_ENABLE)
	GUICtrlSetState($Wert_UpDpwn_Race1, $GUI_ENABLE)
	GUICtrlSetState($Button_Set_Race_1_Attribute, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_Random_Car, $GUI_ENABLE)
	GUICtrlSetState($Checkbox_Random_Track, $GUI_ENABLE)
	GUICtrlSetState($Button_Set_Current_Attributes_1, $GUI_ENABLE)
	GUICtrlSetState($Button_Set_Next_Attributes_1, $GUI_ENABLE)
	GUICtrlSetState($Button_Open_WebInterface_PCDSG, $GUI_ENABLE)
	GUICtrlSetState($Button_Open_WebInterface_IBrowser, $GUI_ENABLE)
EndFunc

Func _Disable_API_GameControl_Objects()
	GUICtrlSetState($Combo_CAR, $GUI_DISABLE)
	GUICtrlSetState($Button_Set_Car_Attribute, $GUI_DISABLE)
	GUICtrlSetState($Combo_TRACK, $GUI_DISABLE)
	GUICtrlSetState($Button_Set_Track_Attribute, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_RC_Training_1, $GUI_DISABLE)
	GUICtrlSetState($Button_Set_Training_1_Attribute, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_RC_Qualifying, $GUI_DISABLE)
	GUICtrlSetState($Combo_Time_Qualifying, $GUI_DISABLE)
	GUICtrlSetState($Button_Set_Qualifying_Attribute, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_RC_Race_1, $GUI_DISABLE)
	GUICtrlSetState($Wert_Race_1, $GUI_DISABLE)
	GUICtrlSetState($Wert_UpDpwn_Race1, $GUI_DISABLE)
	GUICtrlSetState($Button_Set_Race_1_Attribute, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_Random_Car, $GUI_DISABLE)
	GUICtrlSetState($Checkbox_Random_Track, $GUI_DISABLE)
	GUICtrlSetState($Button_Set_Current_Attributes_1, $GUI_DISABLE)
	GUICtrlSetState($Button_Set_Next_Attributes_1, $GUI_DISABLE)
	GUICtrlSetState($Button_Open_WebInterface_PCDSG, $GUI_DISABLE)
	GUICtrlSetState($Button_Open_WebInterface_IBrowser, $GUI_DISABLE)
EndFunc



Func _Button_ServerControl_Save_1()
	_Preparing_Data_GUI()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 10)

	If FileExists($Dedi_config_cfg) Then
		$Server_CFG_Array = FileReadToArray($Dedi_config_cfg)
		$NR_Lines_config_cfg = _FileCountLines($Dedi_config_cfg) - 1

		$EmptyFile = FileOpen($Dedi_config_cfg, 2)
		FileWrite($EmptyFile, "")
		FileClose($EmptyFile)

		$Lesen_Checkbox_RCS_Lua_Track_Rotation = GUICtrlRead($Checkbox_RCS_Lua_Track_Rotation)
		If $Lesen_Checkbox_RCS_Lua_Track_Rotation = "1" Then $Lesen_Checkbox_RCS_Lua_Track_Rotation = "true"
		If $Lesen_Checkbox_RCS_Lua_Track_Rotation <> "true" Then $Lesen_Checkbox_RCS_Lua_Track_Rotation = "false"

		$Lesen_Checkbox_RCS_ControlGameSetup = GUICtrlRead($Checkbox_RCS_ControlGameSetup)
		If $Lesen_Checkbox_RCS_ControlGameSetup = "1" Then $Lesen_Checkbox_RCS_ControlGameSetup = "true"
		If $Lesen_Checkbox_RCS_ControlGameSetup <> "true" Then $Lesen_Checkbox_RCS_ControlGameSetup = "false"

		$Lesen_Checkbox_RCS_ServerControlsTrack = GUICtrlRead($Checkbox_RCS_ServerControlsTrack)
		If $Lesen_Checkbox_RCS_ServerControlsTrack = "1" Then $Lesen_Checkbox_RCS_ServerControlsTrack = "true"
		If $Lesen_Checkbox_RCS_ServerControlsTrack <> "true" Then $Lesen_Checkbox_RCS_ServerControlsTrack = "false"

		$Lesen_Checkbox_RCS_ServerControlsVehicleClass  = GUICtrlRead($Checkbox_RCS_ServerControlsVehicleClass)
		If $Lesen_Checkbox_RCS_ServerControlsVehicleClass = "1" Then $Lesen_Checkbox_RCS_ServerControlsVehicleClass = "true"
		If $Lesen_Checkbox_RCS_ServerControlsVehicleClass <> "true" Then $Lesen_Checkbox_RCS_ServerControlsVehicleClass = "false"

		$Lesen_Checkbox_RCS_ServerControlsVehicle = GUICtrlRead($Checkbox_RCS_ServerControlsVehicle)
		If $Lesen_Checkbox_RCS_ServerControlsVehicle = "1" Then $Lesen_Checkbox_RCS_ServerControlsVehicle = "true"
		If $Lesen_Checkbox_RCS_ServerControlsVehicle <> "true" Then $Lesen_Checkbox_RCS_ServerControlsVehicle = "false"

		;MsgBox(0, "", $Lesen_Checkbox_RCS_Lua_Track_Rotation & @CRLF & _
		;				$Lesen_Checkbox_RCS_ControlGameSetup & @CRLF & _
		;				$Lesen_Checkbox_RCS_ServerControlsTrack & @CRLF & _
		;				$Lesen_Checkbox_RCS_ServerControlsVehicleClass & @CRLF & _
		;				$Lesen_Checkbox_RCS_ServerControlsVehicle & @CRLF)

		For $Schleife_2 = 0 To $NR_Lines_config_cfg
			$Wert_Line = $Server_CFG_Array[$Schleife_2]

			If $Lesen_Checkbox_RCS_Lua_Track_Rotation = "true" Then
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    //"sms_rotate",')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "sms_rotate",'
				;If $StringInStr_Check_1 <> 0 Then MsgBox(0, "sms_rotate", "true")
				Local $StringInStr_Check_2 = StringInStr($Wert_Line, 'controlGameSetup : ')
				If $StringInStr_Check_2 <> 0 Then $Wert_Line = 'controlGameSetup : true'
				IniWrite($config_ini, "Server_Einstellungen", "SMS_Rotate", "true")
			Else
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "sms_rotate",')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    //"sms_rotate",'
				IniWrite($config_ini, "Server_Einstellungen", "SMS_Rotate", "false")
			EndIf

			If $Lesen_Checkbox_RCS_ControlGameSetup = "true" Then
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'controlGameSetup : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'controlGameSetup : true'
				IniWrite($config_ini, "Server_Einstellungen", "controlGameSetup", "true")
				;If $StringInStr_Check_1 <> 0 Then MsgBox(0, "controlGameSetup", "true")
			Else
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, 'controlGameSetup : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = 'controlGameSetup : false'
				IniWrite($config_ini, "Server_Einstellungen", "controlGameSetup", "false")
			EndIf

			If $Lesen_Checkbox_RCS_ServerControlsTrack = "true" Then
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsTrack" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "ServerControlsTrack" : 1,'
				IniWrite($config_ini, "Server_Einstellungen", "ServerControlsTrack", "1")
				;If $StringInStr_Check_1 <> 0 Then MsgBox(0, "ServerControlsTrack", "true 1")
			Else
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsTrack" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "ServerControlsTrack" : 0,'
				IniWrite($config_ini, "Server_Einstellungen", "ServerControlsTrack", "0")
			EndIf

			If $Lesen_Checkbox_RCS_ServerControlsVehicleClass = "true" Then
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsVehicleClass" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "ServerControlsVehicleClass" : 1,'
				IniWrite($config_ini, "Server_Einstellungen", "ServerControlsVehicleClass", "1")
				;If $StringInStr_Check_1 <> 0 Then MsgBox(0, "ServerControlsVehicleClass", "true 1")
			Else
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsVehicleClass" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "ServerControlsVehicleClass" : 0,'
				IniWrite($config_ini, "Server_Einstellungen", "ServerControlsVehicleClass", "0")
			EndIf

			If $Lesen_Checkbox_RCS_ServerControlsVehicle = "true" Then
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsVehicle" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "ServerControlsVehicle" : 1,'
				IniWrite($config_ini, "Server_Einstellungen", "ServerControlsVehicle", "1")
				;If $StringInStr_Check_1 <> 0 Then MsgBox(0, "ServerControlsVehicle", "true 1")
			Else
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '    "ServerControlsVehicle" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '    "ServerControlsVehicle" : 0,'
				IniWrite($config_ini, "Server_Einstellungen", "ServerControlsVehicle", "0")
			EndIf

			FileWriteLine($Dedi_config_cfg, $Wert_Line)
		Next
	EndIf

	GUICtrlSetData($Anzeige_Fortschrittbalken, 50)

	If FileExists($sms_rotate_config_json_File) Then
		$Array = FileReadToArray($sms_rotate_config_json_File)
		$NR_Lines_sms_rotate_config_json_File = _FileCountLines($sms_rotate_config_json_File) - 1

		$EmptyFile = FileOpen($sms_rotate_config_json_File, 2)
		FileWrite($EmptyFile, "")
		FileClose($EmptyFile)

		Local $Lesen_Checkbox_RCS_Lua_Track_Rotation = IniRead($config_ini, "Server_Einstellungen", "SMS_Rotate", "")

		Local $Value_FILL_SESSION_WITH_AI = IniRead($RC_LUA_Settings_ini_File, "Settings", "FILL_SESSION_WITH_AI", "")
		Local $Value_OpponentDifficulty = IniRead($RC_LUA_Settings_ini_File, "Settings", "OpponentDifficulty", "")
		Local $Value_DamageType = IniRead($RC_LUA_Settings_ini_File, "Settings", "DamageType", "")
		Local $Value_TireWearType = IniRead($RC_LUA_Settings_ini_File, "Settings", "TireWearType", "")
		Local $Value_FuelUsageType = IniRead($RC_LUA_Settings_ini_File, "Settings", "FuelUsageType", "")
		Local $Value_PenaltiesType = IniRead($RC_LUA_Settings_ini_File, "Settings", "PenaltiesType", "")
		Local $Value_AllowedViews = IniRead($RC_LUA_Settings_ini_File, "Settings", "AllowedViews", "")
		Local $Value_PracticeLength = IniRead($RC_LUA_Settings_ini_File, "Settings", "PracticeLength", "")
		Local $Value_QualifyLength = IniRead($RC_LUA_Settings_ini_File, "Settings", "QualifyLength", "")
		Local $Value_RaceLength = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceLength", "")
		Local $Value_RaceRollingStart = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceRollingStart", "")
		Local $Value_NR_Tracks = IniRead($RC_LUA_Settings_ini_File, "Settings", "NR_Tracks", "")
		Local $Value_NR_Of_Tracks_TrackRotation = IniRead($RC_LUA_Settings_ini_File, "Settings", "NR_Of_Tracks_TrackRotation", "")

		For $Schleife_2 = 0 To $NR_Lines_sms_rotate_config_json_File
			$Wert_Line = $Array[$Schleife_2]

			If $Schleife_2 < 223 Then
				If $Lesen_Checkbox_RCS_Lua_Track_Rotation = "true" Then
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"Flags" : ')
					If $StringInStr_Check_1 <> 0 Then
						If $Value_FILL_SESSION_WITH_AI = "true" Then
							If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"Flags" : "ALLOW_CUSTOM_VEHICLE_SETUP,AUTO_START_ENGINE,ONLINE_REPUTATION_ENABLED,WAIT_FOR_RACE_READY_INPUT,ANTI_GRIEFING_COLLISIONS,FILL_SESSION_WITH_AI", // TIMED_RACE,GHOST_GRIEFERS,MECHANICAL_FAILURES,FILL_SESSION_WITH_AI'
						Else
							$Wert_Line = '		"Flags" : "ALLOW_CUSTOM_VEHICLE_SETUP,AUTO_START_ENGINE,ONLINE_REPUTATION_ENABLED,WAIT_FOR_RACE_READY_INPUT,ANTI_GRIEFING_COLLISIONS", // TIMED_RACE,GHOST_GRIEFERS,MECHANICAL_FAILURES,FILL_SESSION_WITH_AI'
						EndIf
					EndIf
				EndIf

				If $Value_FILL_SESSION_WITH_AI = "true" Then
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		//"OpponentDifficulty" : ')
					If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"OpponentDifficulty" : ' & $Value_OpponentDifficulty & ','
				Else
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"OpponentDifficulty" : ')
					If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		//"OpponentDifficulty" : ' & $Value_OpponentDifficulty & ','
				EndIf

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"DamageType" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"DamageType" : "' & $Value_DamageType & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"TireWearType" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"TireWearType" : "' & $Value_TireWearType & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"FuelUsageType" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"FuelUsageType" : "' & $Value_FuelUsageType & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PenaltiesType" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PenaltiesType" : "' & $Value_PenaltiesType & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"AllowedViews" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"AllowedViews" : "' & $Value_AllowedViews & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeLength" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PracticeLength" : ' & $Value_PracticeLength & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyLength" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"QualifyLength" : ' & $Value_QualifyLength & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceLength" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceLength" : ' & $Value_RaceLength & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceRollingStart" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceRollingStart" : ' & $Value_RaceRollingStart & ','
			EndIf
			FileWriteLine($sms_rotate_config_json_File, $Wert_Line)
		Next
	EndIf
	GUICtrlSetData($Anzeige_Fortschrittbalken, 100)
	Sleep(700)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
	GUIDelete($GUI_Loading)
EndFunc

Func _Button_ServerControl_Restart_DS_1()
	_Button_ServerControl_Save_1()
	Local $DS_Mode_Temp = IniRead($config_ini, "PC_Server", "DS_Mode", "local")
	If $DS_Mode_Temp = "local" Then _Restart_DS()
	If $DS_Mode_Temp = "remote" Then _Restart_DS_Remote()
EndFunc

Func _Button_ServerControl_Save_2()
	_Button_ServerControl_Save_1()
	_Preparing_Data_GUI()
	If FileExists($sms_rotate_config_json_File) Then
		$Array = FileReadToArray($sms_rotate_config_json_File)
		$NR_Lines_config_cfg = _FileCountLines($sms_rotate_config_json_File) - 1

		$EmptyFile = FileOpen($sms_rotate_config_json_File, 2)
		FileWrite($EmptyFile, "")
		FileClose($EmptyFile)

		Local $Value_VehicleClassId_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "VehicleClassId", "")
		Local $Value_MultiClassSlots_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlots", "")
		Local $Value_MultiClassSlot1_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot1", "")
		Local $Value_MultiClassSlot2_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot2", "")
		Local $Value_MultiClassSlot3_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot3", "")

		Local $Lesen_Checkbox_RCS_Lua_Track_Rotation = IniRead($config_ini, "Server_Einstellungen", "SMS_Rotate", "")

		Local $Value_FILL_SESSION_WITH_AI = IniRead($RC_LUA_Settings_ini_File, "Settings", "FILL_SESSION_WITH_AI", "")
		Local $Value_OpponentDifficulty = IniRead($RC_LUA_Settings_ini_File, "Settings", "OpponentDifficulty", "")
		Local $Value_DamageType = IniRead($RC_LUA_Settings_ini_File, "Settings", "DamageType", "")
		Local $Value_TireWearType = IniRead($RC_LUA_Settings_ini_File, "Settings", "TireWearType", "")
		Local $Value_FuelUsageType = IniRead($RC_LUA_Settings_ini_File, "Settings", "FuelUsageType", "")
		Local $Value_PenaltiesType = IniRead($RC_LUA_Settings_ini_File, "Settings", "PenaltiesType", "")
		Local $Value_AllowedViews = IniRead($RC_LUA_Settings_ini_File, "Settings", "AllowedViews", "")
		Local $Value_PracticeLength = IniRead($RC_LUA_Settings_ini_File, "Settings", "PracticeLength", "")
		Local $Value_QualifyLength = IniRead($RC_LUA_Settings_ini_File, "Settings", "QualifyLength", "")
		Local $Value_RaceLength = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceLength", "")
		Local $Value_RaceRollingStart = IniRead($RC_LUA_Settings_ini_File, "Settings", "RaceRollingStart", "")
		Local $Value_NR_Tracks = IniRead($RC_LUA_Settings_ini_File, "Settings", "NR_Tracks", "")
		Local $Value_NR_Of_Tracks_TrackRotation = IniRead($RC_LUA_Settings_ini_File, "Settings", "NR_Of_Tracks_TrackRotation", "")

		Local $Activate_MultiClass = IniRead($config_ini, "Server_Einstellungen", "Activate_MultiClass", "")

		GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

		For $Schleife_2 = 0 To 223
			$Wert_Line = $Array[$Schleife_2]

			If $Schleife_2 < 223 Then
				If $Activate_MultiClass = "true" Then
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "VehicleClassId" : "')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"VehicleClassId" : "')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "VehicleClassId" : "' & "" & '",'
				Else
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "VehicleClassId" : "')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"VehicleClassId" : "')
					If $StringInStr_Check_1 <> 0 Or  $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "VehicleClassId" : "' & "" & '",'
				EndIf


				If $Activate_MultiClass = "true" Then
					If $Value_MultiClassSlots_Default = "3" Then
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlots" : ')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlots" : ')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlots" : ' & $Value_MultiClassSlots_Default & ','
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot1" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot1" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot1" : "' & $Value_MultiClassSlot1_Default & '",'
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot2" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot2" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot2" : "' & $Value_MultiClassSlot2_Default & '",'
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot3" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot3" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot3" : "' & $Value_MultiClassSlot3_Default & '",'
					EndIf

					If $Value_MultiClassSlots_Default = "2" Then
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlots" : ')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlots" : ')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlots" : ' & $Value_MultiClassSlots_Default & ','
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot1" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot1" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot1" : "' & $Value_MultiClassSlot1_Default & '",'
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot2" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot2" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot2" : "' & $Value_MultiClassSlot2_Default & '",'
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot3" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot3" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot3" : "' & $Value_MultiClassSlot3_Default & '",'
					EndIf

					If $Value_MultiClassSlots_Default = "1" Then
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlots" : ')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlots" : ')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlots" : ' & $Value_MultiClassSlots_Default & ','
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot1" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot1" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot1" : "' & $Value_MultiClassSlot1_Default & '",'
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot2" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot2" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot2" : "' & $Value_MultiClassSlot2_Default & '",'
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot3" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot3" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot3" : "' & $Value_MultiClassSlot3_Default & '",'
					EndIf
				EndIf

				If $Activate_MultiClass <> "true" Then
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlots" : ')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlots" : ')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlots" : ' & $Value_MultiClassSlots_Default & ','
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot1" : "')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot1" : "')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot1" : "' & $Value_MultiClassSlot1_Default & '",'
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot2" : "')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot2" : "')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot2" : "' & $Value_MultiClassSlot2_Default & '",'
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot3" : "')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot3" : "')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot3" : "' & $Value_MultiClassSlot3_Default & '",'
				EndIf


				If $Lesen_Checkbox_RCS_Lua_Track_Rotation = "true" Then
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"Flags" : ')
					If $StringInStr_Check_1 <> 0 Then
						If $Value_FILL_SESSION_WITH_AI = "true" Then
							If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"Flags" : "ALLOW_CUSTOM_VEHICLE_SETUP,AUTO_START_ENGINE,ONLINE_REPUTATION_ENABLED,WAIT_FOR_RACE_READY_INPUT,ANTI_GRIEFING_COLLISIONS,FILL_SESSION_WITH_AI", // TIMED_RACE,GHOST_GRIEFERS,MECHANICAL_FAILURES,FILL_SESSION_WITH_AI'
						Else
							$Wert_Line = '		"Flags" : "ALLOW_CUSTOM_VEHICLE_SETUP,AUTO_START_ENGINE,ONLINE_REPUTATION_ENABLED,WAIT_FOR_RACE_READY_INPUT,ANTI_GRIEFING_COLLISIONS", // TIMED_RACE,GHOST_GRIEFERS,MECHANICAL_FAILURES,FILL_SESSION_WITH_AI'
						EndIf
					EndIf
				EndIf

				If $Value_FILL_SESSION_WITH_AI = "true" Then
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		//"OpponentDifficulty" : ')
					If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"OpponentDifficulty" : ' & $Value_OpponentDifficulty & ','
				Else
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"OpponentDifficulty" : ')
					If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		//"OpponentDifficulty" : ' & $Value_OpponentDifficulty & ','
				EndIf


				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"DamageType" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"DamageType" : "' & $Value_DamageType & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"TireWearType" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"TireWearType" : "' & $Value_TireWearType & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"FuelUsageType" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"FuelUsageType" : "' & $Value_FuelUsageType & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PenaltiesType" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PenaltiesType" : "' & $Value_PenaltiesType & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"AllowedViews" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"AllowedViews" : "' & $Value_AllowedViews & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeLength" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PracticeLength" : ' & $Value_PracticeLength & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyLength" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"QualifyLength" : ' & $Value_QualifyLength & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceLength" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceLength" : ' & $Value_RaceLength & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceRollingStart" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceRollingStart" : ' & $Value_RaceRollingStart & ','
			EndIf

			FileWriteLine($sms_rotate_config_json_File, $Wert_Line)
		Next

		GUICtrlSetData($Anzeige_Fortschrittbalken, 50)

		For $Schleife_3 = 1 To $Value_NR_Of_Tracks_TrackRotation

			$Rotation_TrackId = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "TrackId", "")
			$Rotation_RaceRollingStart = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceRollingStart", "")
			$Rotation_PracticeLength = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "PracticeLength", "")
			$Rotation_QualifyLength = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "QualifyLength", "")
			$Rotation_RaceLength = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceLength", "")

			Local $Komma_temp = ','
			If $Schleife_3 = $Value_NR_Of_Tracks_TrackRotation Then $Komma_temp = ''

			Local $Num_Check = StringIsDigit(StringRight($Rotation_TrackId, 1))
			If $Num_Check = 1 Then
				$Rotation_TrackId = '' & $Rotation_TrackId & ','
			Else
				$Rotation_TrackId = '"' & $Rotation_TrackId & '",'
			EndIf


			Local $Value_TrackId = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "TrackId", "")
			Local $Value_VehicleClassId = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "VehicleClassId", "")
			Local $Value_MultiClassSlots = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "MultiClassSlots", "")
			Local $Value_MultiClassSlot1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "MultiClassSlot1", "")
			Local $Value_MultiClassSlot2 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "MultiClassSlot2", "")
			Local $Value_MultiClassSlot3 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "MultiClassSlot3", "")


			Local $Known_Class_1 = "GT1"
			Local $Known_Class_2 = "GT3"
			Local $Known_Class_3 = "GT4"
			Local $Known_Class_4 = "GTE"
			Local $Known_Class_5 = "LMP1"
			Local $Known_Class_6 = "LMP2"
			Local $Known_Class_7 = "LMP3"
			Local $Known_Class_8 = "LMP900"
			Local $Known_Class_9 = "Touring Car"
			Local $Known_Class_10 = "TC1"
			Local $Known_Class_11 = "Group A"

			Local $Known_Class_Exists_1 = ""
			Local $Known_Class_Exists_2 = ""
			Local $Known_Class_Exists_3 = ""
			Local $Known_Class_Exists_4 = ""

			If $Value_VehicleClassId = $Known_Class_1 Then $Known_Class_Exists_1 = "true"
			If $Value_VehicleClassId = $Known_Class_2 Then $Known_Class_Exists_1 = "true"
			If $Value_VehicleClassId = $Known_Class_3 Then $Known_Class_Exists_1 = "true"
			If $Value_VehicleClassId = $Known_Class_4 Then $Known_Class_Exists_1 = "true"
			If $Value_VehicleClassId = $Known_Class_5 Then $Known_Class_Exists_1 = "true"
			If $Value_VehicleClassId = $Known_Class_6 Then $Known_Class_Exists_1 = "true"
			If $Value_VehicleClassId = $Known_Class_7 Then $Known_Class_Exists_1 = "true"
			If $Value_VehicleClassId = $Known_Class_8 Then $Known_Class_Exists_1 = "true"
			If $Value_VehicleClassId = $Known_Class_9 Then $Known_Class_Exists_1 = "true"
			If $Value_VehicleClassId = $Known_Class_10 Then $Known_Class_Exists_1 = "true"
			If $Value_VehicleClassId = $Known_Class_11 Then $Known_Class_Exists_1 = "true"

			If $Value_MultiClassSlot1 = $Known_Class_1 Then $Known_Class_Exists_2 = "true"
			If $Value_MultiClassSlot1 = $Known_Class_2 Then $Known_Class_Exists_2 = "true"
			If $Value_MultiClassSlot1 = $Known_Class_3 Then $Known_Class_Exists_2 = "true"
			If $Value_MultiClassSlot1 = $Known_Class_4 Then $Known_Class_Exists_2 = "true"
			If $Value_MultiClassSlot1 = $Known_Class_5 Then $Known_Class_Exists_2 = "true"
			If $Value_MultiClassSlot1 = $Known_Class_6 Then $Known_Class_Exists_2 = "true"
			If $Value_MultiClassSlot1 = $Known_Class_7 Then $Known_Class_Exists_2 = "true"
			If $Value_MultiClassSlot1 = $Known_Class_8 Then $Known_Class_Exists_2 = "true"
			If $Value_MultiClassSlot1 = $Known_Class_9 Then $Known_Class_Exists_2 = "true"
			If $Value_MultiClassSlot1 = $Known_Class_10 Then $Known_Class_Exists_2 = "true"
			If $Value_MultiClassSlot1 = $Known_Class_11 Then $Known_Class_Exists_2 = "true"


			If $Value_MultiClassSlot2 = $Known_Class_1 Then $Known_Class_Exists_3 = "true"
			If $Value_MultiClassSlot2 = $Known_Class_2 Then $Known_Class_Exists_3 = "true"
			If $Value_MultiClassSlot2 = $Known_Class_3 Then $Known_Class_Exists_3 = "true"
			If $Value_MultiClassSlot2 = $Known_Class_4 Then $Known_Class_Exists_3 = "true"
			If $Value_MultiClassSlot2 = $Known_Class_5 Then $Known_Class_Exists_3 = "true"
			If $Value_MultiClassSlot2 = $Known_Class_6 Then $Known_Class_Exists_3 = "true"
			If $Value_MultiClassSlot2 = $Known_Class_7 Then $Known_Class_Exists_3 = "true"
			If $Value_MultiClassSlot2 = $Known_Class_8 Then $Known_Class_Exists_3 = "true"
			If $Value_MultiClassSlot2 = $Known_Class_9 Then $Known_Class_Exists_3 = "true"
			If $Value_MultiClassSlot2 = $Known_Class_10 Then $Known_Class_Exists_3 = "true"
			If $Value_MultiClassSlot2 = $Known_Class_11 Then $Known_Class_Exists_3 = "true"

			If $Value_MultiClassSlot3 = $Known_Class_1 Then $Known_Class_Exists_4 = "true"
			If $Value_MultiClassSlot3 = $Known_Class_2 Then $Known_Class_Exists_4 = "true"
			If $Value_MultiClassSlot3 = $Known_Class_3 Then $Known_Class_Exists_4 = "true"
			If $Value_MultiClassSlot3 = $Known_Class_4 Then $Known_Class_Exists_4 = "true"
			If $Value_MultiClassSlot3 = $Known_Class_5 Then $Known_Class_Exists_4 = "true"
			If $Value_MultiClassSlot3 = $Known_Class_6 Then $Known_Class_Exists_4 = "true"
			If $Value_MultiClassSlot3 = $Known_Class_7 Then $Known_Class_Exists_4 = "true"
			If $Value_MultiClassSlot3 = $Known_Class_8 Then $Known_Class_Exists_4 = "true"
			If $Value_MultiClassSlot3 = $Known_Class_9 Then $Known_Class_Exists_4 = "true"
			If $Value_MultiClassSlot3 = $Known_Class_10 Then $Known_Class_Exists_4 = "true"
			If $Value_MultiClassSlot3 = $Known_Class_11 Then $Known_Class_Exists_4 = "true"


			;MsgBox(0, "0", $Value_VehicleClassId & @CRLF & @CRLF & $Known_Class_1 & @CRLF & $Known_Class_2 & @CRLF & $Known_Class_3 & @CRLF & $Known_Class_4)

			If Not StringIsDigit(StringTrimLeft($Value_VehicleClassId, 1)) Then
				If $Known_Class_Exists_1 <> "true" Then
					IniWrite($config_ini, "TEMP", "Check_VehicleClassName", $Value_VehicleClassId)
					_Get_ID_from_VehicleClassesList_TXT()
					$Value_VehicleClassId = IniRead($config_ini, "TEMP", "Check_VehicleClassID", "")
				EndIf
			EndIf

			If Not StringIsDigit(StringTrimLeft($Value_MultiClassSlot1, 1)) Then
				If $Known_Class_Exists_2 <> "true" Then
					IniWrite($config_ini, "TEMP", "Check_VehicleClassName", $Value_MultiClassSlot1)
					_Get_ID_from_VehicleClassesList_TXT()
					$Value_MultiClassSlot1 = IniRead($config_ini, "TEMP", "Check_VehicleClassID", "")
				EndIf
			EndIf

			If Not StringIsDigit(StringTrimLeft($Value_MultiClassSlot2, 1)) Then
				If $Known_Class_Exists_3 <> "true" Then
					IniWrite($config_ini, "TEMP", "Check_VehicleClassName", $Value_MultiClassSlot2)
					_Get_ID_from_VehicleClassesList_TXT()
					$Value_MultiClassSlot2 = IniRead($config_ini, "TEMP", "Check_VehicleClassID", "")
				EndIf
			EndIf

			If Not StringIsDigit(StringTrimLeft($Value_MultiClassSlot3, 1)) Then
				If $Known_Class_Exists_4 <> "true" Then
					IniWrite($config_ini, "TEMP", "Check_VehicleClassName", $Value_MultiClassSlot3)
					_Get_ID_from_VehicleClassesList_TXT()
					$Value_MultiClassSlot3 = IniRead($config_ini, "TEMP", "Check_VehicleClassID", "")
				EndIf
			EndIf

			Local $Value_Flags = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "Flags", "")
			Local $Value_RemoveFlags = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RemoveFlags", "")
			Local $Value_ManualRollingStarts = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "ManualRollingStarts", "")
			Local $Value_RaceRollingStart = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceRollingStart", "")
			Local $Value_RaceFormationLap = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceFormationLap", "")

			Local $Value_PracticeLength = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "PracticeLength", "")
			Local $Value_PracticeDateHour = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "PracticeDateHour", "")
			Local $Value_PracticeWeatherSlots = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "PracticeWeatherSlots", "")
			Local $Value_PracticeWeatherSlot1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "PracticeWeatherSlot1", "")
			Local $Value_PracticeWeatherSlot2 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "PracticeWeatherSlot2", "")
			Local $Value_PracticeWeatherSlot3 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "PracticeWeatherSlot3", "")
			Local $Value_PracticeWeatherSlot4 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "PracticeWeatherSlot4", "")

			Local $Value_QualifyLength = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "QualifyLength", "")
			Local $Value_QualifyDateHour = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "QualifyDateHour", "")
			Local $Value_QualifyWeatherSlots = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "QualifyWeatherSlots", "")
			Local $Value_QualifyWeatherSlot1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "QualifyWeatherSlot1", "")
			Local $Value_QualifyWeatherSlot2 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "QualifyWeatherSlot2", "")
			Local $Value_QualifyWeatherSlot3 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "QualifyWeatherSlot3", "")
			Local $Value_QualifyWeatherSlot4 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "QualifyWeatherSlot4", "")

			Local $Value_RaceLength = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceLength", "")
			Local $Value_RaceDateYear = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceDateYear", "")
			Local $Value_RaceDateMonth = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceDateMonth", "")
			Local $Value_RaceDateDay = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceDateDay", "")
			Local $Value_RaceDateHour = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceDateHour", "")
			Local $Value_RaceWeatherSlots = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceWeatherSlots", "")
			Local $Value_RaceWeatherSlot1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceWeatherSlot1", "")
			Local $Value_RaceWeatherSlot2 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceWeatherSlot2", "")
			Local $Value_RaceWeatherSlot3 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceWeatherSlot3", "")
			Local $Value_RaceWeatherSlot4 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RaceWeatherSlot4", "")

			Local $Value_ABS_ALLOWED = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "Flags", "")
				If $Value_ABS_ALLOWED = "true" Then $Value_ABS_ALLOWED = "ABS_ALLOWED"
			Local $Value_TCS_ALLOWED = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Schleife_3, "RemoveFlags", "")
				If $Value_TCS_ALLOWED = "true" Then $Value_ABS_ALLOWED = "TCS_ALLOWED"


			Local $Race_line = '		// Race ' & $Schleife_3 & ' - "' & $Value_TrackId & '"'
			Local $First_line = '		{'
			Local $TrackId_line = '			"TrackId" : ' & $Rotation_TrackId

			If $Activate_MultiClass = "true" Then
				If $Known_Class_Exists_1 = "true" Then Local $VehicleClassId_line = '			"VehicleClassId" : "' & $Value_VehicleClassId & '",'
				If $Known_Class_Exists_1 <> "true" Then Local $VehicleClassId_line = '			"VehicleClassId" : ' & $Value_VehicleClassId & ','
				Local $MultiClassSlots_line = '			"MultiClassSlots" : ' & $Value_MultiClassSlots & ','
				If $Known_Class_Exists_2 = "true" Then Local $MultiClassSlot1_line = '			"MultiClassSlot1" : "' & $Value_MultiClassSlot1 & '",'
				If $Known_Class_Exists_2 <> "true" Then Local $MultiClassSlot1_line = '			"MultiClassSlot1" : ' & $Value_MultiClassSlot1 & ','
				If $Known_Class_Exists_3 = "true" Then Local $MultiClassSlot2_line = '			"MultiClassSlot2" : "' & $Value_MultiClassSlot2 & '",'
				If $Known_Class_Exists_3 <> "true" Then Local $MultiClassSlot2_line = '			"MultiClassSlot2" : ' & $Value_MultiClassSlot2 & ','
				If $Known_Class_Exists_4 = "true" Then Local $MultiClassSlot3_line = '			"MultiClassSlot3" : "' & $Value_MultiClassSlot3 & '",'
				If $Known_Class_Exists_4 <> "true" Then Local $MultiClassSlot3_line = '			"MultiClassSlot3" : ' & $Value_MultiClassSlot3 & ','
			Else
				If $Known_Class_Exists_1 = "true" Then Local $VehicleClassId_line = '			// "VehicleClassId" : "' & $Value_VehicleClassId & '",'
				If $Known_Class_Exists_1 <> "true" Then Local $VehicleClassId_line = '			// "VehicleClassId" : ' & $Value_VehicleClassId & ','
				Local $MultiClassSlots_line = '			// "MultiClassSlots" : ' & $Value_MultiClassSlots & ','
				If $Known_Class_Exists_2 = "true" Then Local $MultiClassSlot1_line = '			// "MultiClassSlot1" : "' & $Value_MultiClassSlot1 & '",'
				If $Known_Class_Exists_2 <> "true" Then Local $MultiClassSlot1_line = '			// "MultiClassSlot1" : ' & $Value_MultiClassSlot1 & ','
				If $Known_Class_Exists_3 = "true" Then Local $MultiClassSlot2_line = '			// "MultiClassSlot2" : "' & $Value_MultiClassSlot2 & '",'
				If $Known_Class_Exists_3 <> "true" Then Local $MultiClassSlot2_line = '			// "MultiClassSlot2" : ' & $Value_MultiClassSlot2 & ','
				If $Known_Class_Exists_4 = "true" Then Local $MultiClassSlot3_line = '			// "MultiClassSlot3" : "' & $Value_MultiClassSlot3 & '",'
				If $Known_Class_Exists_4 <> "true" Then Local $MultiClassSlot3_line = '			// "MultiClassSlot3" : ' & $Value_MultiClassSlot3 & ','
			EndIf

			Local $Flags_line = '			"Flags" : "' & $Value_Flags & '",'
			Local $RemoveFlags_line = '			"RemoveFlags" : "' & $Value_RemoveFlags & '",'
			Local $ManualRollingStarts_line = '			"ManualRollingStarts" : ' & $Value_ManualRollingStarts & ','
			Local $RaceRollingStart_line = '			"RaceRollingStart" : ' & $Value_RaceRollingStart & ','
			Local $RaceFormationLap_line = '			"RaceFormationLap" : ' & $Value_RaceFormationLap & ','
			Local $PracticeLength_line = '			"PracticeLength" : ' & $Value_PracticeLength & ','
			Local $PracticeDateHour_line = '			"PracticeDateHour" : ' & $Value_PracticeDateHour & ','
			Local $PracticeWeatherSlots_line = '			"PracticeWeatherSlots" : ' & $Value_PracticeWeatherSlots & ','
			Local $PracticeWeatherSlot1_line = '			"PracticeWeatherSlot1" : "' & $Value_PracticeWeatherSlot1 & '",'
			Local $PracticeWeatherSlot2_line = '			"PracticeWeatherSlot2" : "' & $Value_PracticeWeatherSlot2 & '",'
			Local $PracticeWeatherSlot3_line = '			"PracticeWeatherSlot3" : "' & $Value_PracticeWeatherSlot3 & '",'
			Local $PracticeWeatherSlot4_line = '			"PracticeWeatherSlot4" : "' & $Value_PracticeWeatherSlot4 & '",'
			Local $QualifyLength_line = '			"QualifyLength" : ' & $Value_QualifyLength & ','
			Local $QualifyDateHour_line = '			"QualifyDateHour" : ' & $Value_QualifyDateHour & ','
			Local $QualifyWeatherSlots_line = '			"QualifyWeatherSlots" : ' & $Value_QualifyWeatherSlots & ','
			Local $QualifyWeatherSlot1_line = '			"QualifyWeatherSlot1" : "' & $Value_QualifyWeatherSlot1 & '",'
			Local $QualifyWeatherSlot2_line = '			"QualifyWeatherSlot2" : "' & $Value_QualifyWeatherSlot2 & '",'
			Local $QualifyWeatherSlot3_line = '			"QualifyWeatherSlot3" : "' & $Value_QualifyWeatherSlot3 & '",'
			Local $QualifyWeatherSlot4_line = '			"QualifyWeatherSlot4" : "' & $Value_QualifyWeatherSlot4 & '",'
			Local $RaceLength_line = '			"RaceLength" : ' & $Value_RaceLength & ','
			Local $RaceDateYear_line = '			"RaceDateYear" : ' & $Value_RaceDateYear & ','
			Local $RaceDateMonth_line = '			"RaceDateMonth" : ' & $Value_RaceDateMonth & ','
			Local $RaceDateDay_line = '			"RaceDateDay" : ' & $Value_RaceDateDay & ','
			Local $RaceDateHour_line = '			"RaceDateHour" : ' & $Value_RaceDateHour & ','
			Local $RaceWeatherSlots_line = '			"RaceWeatherSlots" : ' & $Value_RaceWeatherSlots & ','
			Local $RaceWeatherSlot1_line = '			"RaceWeatherSlot1" : "' & $Value_RaceWeatherSlot1 & '",'
			Local $RaceWeatherSlot2_line = '			"RaceWeatherSlot2" : "' & $Value_RaceWeatherSlot2 & '",'
			Local $RaceWeatherSlot3_line = '			"RaceWeatherSlot3" : "' & $Value_RaceWeatherSlot3 & '",'
			Local $RaceWeatherSlot4_line = '			"RaceWeatherSlot4" : "' & $Value_RaceWeatherSlot4 & '",'
			Local $Last_line = '		}' & $Komma_temp



			Local $TrackRotation_Content = $Race_line & @CRLF & _
											$First_line & @CRLF & _
											$TrackId_line & @CRLF & _
											$VehicleClassId_line & @CRLF & @CRLF & _
											$MultiClassSlots_line & @CRLF & _
											$MultiClassSlot1_line & @CRLF & _
											$MultiClassSlot2_line & @CRLF & _
											$MultiClassSlot3_line & @CRLF & @CRLF & _
											$Flags_line & @CRLF & _
											$RemoveFlags_line & @CRLF & @CRLF & _
											$ManualRollingStarts_line & @CRLF & @CRLF & _
											$RaceRollingStart_line & @CRLF & _
											$RaceFormationLap_line & @CRLF & @CRLF & _
											$PracticeLength_line & @CRLF & _
											$PracticeDateHour_line & @CRLF & @CRLF & _
											$PracticeWeatherSlots_line & @CRLF & _
											$PracticeWeatherSlot1_line & @CRLF & _
											$PracticeWeatherSlot2_line & @CRLF & _
											$PracticeWeatherSlot3_line & @CRLF & _
											$PracticeWeatherSlot4_line & @CRLF & @CRLF & _
											$QualifyLength_line & @CRLF & _
											$QualifyDateHour_line & @CRLF & @CRLF & _
											$QualifyWeatherSlots_line & @CRLF & _
											$QualifyWeatherSlot1_line & @CRLF & _
											$QualifyWeatherSlot2_line & @CRLF & _
											$QualifyWeatherSlot3_line & @CRLF & _
											$QualifyWeatherSlot4_line & @CRLF & @CRLF & _
											$RaceLength_line & @CRLF & @CRLF & _
											$RaceDateYear_line & @CRLF & _
											$RaceDateMonth_line & @CRLF & _
											$RaceDateDay_line & @CRLF & _
											$RaceDateHour_line & @CRLF & @CRLF & _
											$RaceWeatherSlots_line & @CRLF & _
											$RaceWeatherSlot1_line & @CRLF & _
											$RaceWeatherSlot2_line & @CRLF & _
											$RaceWeatherSlot3_line & @CRLF & _
											$RaceWeatherSlot4_line & @CRLF & _
											$Last_line


			If $Rotation_TrackId <> "" Then
				FileWriteLine($sms_rotate_config_json_File, $TrackRotation_Content)
			EndIf

			Local $Known_Class_Exists_1 = ""
			Local $Known_Class_Exists_2 = ""
			Local $Known_Class_Exists_3 = ""
			Local $Known_Class_Exists_4 = ""
		Next
		FileWriteLine($sms_rotate_config_json_File, '	]' & @CRLF)
		FileWriteLine($sms_rotate_config_json_File, '}')
	EndIf
	GUICtrlSetData($Anzeige_Fortschrittbalken, 100)
	Sleep(1000)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
	GUIDelete($GUI_Loading)
EndFunc

Func _Button_ServerControl_Restart_DS_2()
	_Button_ServerControl_Save_2()
	Local $DS_Mode_Temp = IniRead($config_ini, "PC_Server", "DS_Mode", "local")
	If $DS_Mode_Temp = "local" Then _Restart_DS()
	If $DS_Mode_Temp = "remote" Then _Restart_DS_Remote()
EndFunc


Func _Button_ServerControl_ALL_Save_INI()
	Local $Value_FILL_SESSION_WITH_AI = IniRead($RC_LUA_Settings_ini_File, "Settings", "FILL_SESSION_WITH_AI", "")

	Local $Value_persist_index = GUICtrlRead($Wert_persist_index)
	Local $Value_Flags = GUICtrlRead($Wert_Flags)
	Local $Value_OpponentDifficulty = GUICtrlRead($Wert_OpponentDifficulty)
	Local $Value_DamageType = GUICtrlRead($Wert_DamageType)
	Local $Value_TireWearType = GUICtrlRead($Wert_TireWearType)
	Local $Value_FuelUsageType = GUICtrlRead($Wert_FuelUsageType)
	Local $Value_PenaltiesType = GUICtrlRead($Wert_PenaltiesType)
	Local $Value_AllowedViews = GUICtrlRead($Wert_AllowedViews)
	Local $Value_ManualPitStops = GUICtrlRead($Wert_ManualPitStops)
		If $Value_ManualPitStops = "Enable" Then $Value_ManualPitStops = 0
		If $Value_ManualPitStops = "Disable" Then $Value_ManualPitStops = 1
	Local $Value_ManualRollingStarts = GUICtrlRead($Wert_PenaltiesType)
		If $Value_ManualRollingStarts = "Disable" Then $Value_ManualRollingStarts = 0
		If $Value_ManualRollingStarts = "Enable" Then $Value_ManualRollingStarts = 1
	Local $Value_MinimumOnlineRank = GUICtrlRead($Wert_MinimumOnlineRank)
	Local $Value_MinimumOnlineStrength = GUICtrlRead($Wert_MinimumOnlineStrength)

	Local $Value_PracticeLength = GUICtrlRead($Wert_PracticeLength)
	Local $Value_QualifyLength = GUICtrlRead($Wert_QualifyLength)
	Local $Value_RaceLength = GUICtrlRead($Wert_RaceLength)
	Local $Value_RaceRollingStart = GUICtrlRead($Wert_RaceRollingStart)
		If $Value_RaceRollingStart = "Standing" Then $Value_RaceRollingStart = 0
		If $Value_RaceRollingStart = "Rolling" Then $Value_RaceRollingStart = 1

	Local $Value_RaceFormationLap = GUICtrlRead($Wert_RaceFormationLap)
		If $Value_RaceFormationLap = "Disable" Then $Value_RaceFormationLap = 0
		If $Value_RaceFormationLap = "Enable" Then $Value_RaceFormationLap = 1
	Local $Value_RaceMandatoryPitStops = GUICtrlRead($Wert_RaceMandatoryPitStops)
		If $Value_RaceMandatoryPitStops = "Disable" Then $Value_RaceMandatoryPitStops = 0
		If $Value_RaceMandatoryPitStops = "Enable" Then $Value_RaceMandatoryPitStops = 1
	Local $Value_PracticeDateHour = GUICtrlRead($Wert_PracticeDateHour )
	Local $Value_PracticeDateProgression = GUICtrlRead($Wert_PracticeDateProgression)
		If $Value_PracticeDateProgression = "OFF" Then $Value_PracticeDateProgression = 0
		If $Value_PracticeDateProgression = "Real Time" Then $Value_PracticeDateProgression = 1
		If $Value_PracticeDateProgression <> 0 And $Value_PracticeDateProgression <> 1 Then $Value_PracticeDateProgression = StringTrimRight($Value_PracticeDateProgression, 1)
	Local $Value_PracticeWeatherProgression = GUICtrlRead($Wert_PracticeWeatherProgression)
		If $Value_PracticeWeatherProgression = "OFF" Then $Value_PracticeWeatherProgression = 0
		If $Value_PracticeWeatherProgression = "Sync to Race" Then $Value_PracticeWeatherProgression = 1
		If $Value_PracticeWeatherProgression <> 0 And $Value_PracticeWeatherProgression <> 1 Then $Value_PracticeWeatherProgression = StringTrimRight($Value_PracticeWeatherProgression, 1)

	Local $Value_QualifyDateHour = GUICtrlRead($Wert_QualifyDateHour)
	Local $Value_QualifyDateProgression = GUICtrlRead($Wert_QualifyDateProgression)
		If $Value_QualifyDateProgression = "OFF" Then $Value_QualifyDateProgression = 0
		If $Value_QualifyDateProgression = "Real Time" Then $Value_QualifyDateProgression = 1
		If $Value_QualifyDateProgression <> 0 And $Value_QualifyDateProgression <> 1 Then $Value_QualifyDateProgression = StringTrimRight($Value_QualifyDateProgression, 1)
	Local $Value_QualifyWeatherProgression = GUICtrlRead($Wert_QualifyWeatherProgression)
		If $Value_QualifyWeatherProgression = "OFF" Then $Value_QualifyWeatherProgression = 0
		If $Value_QualifyWeatherProgression = "Sync to Race" Then $Value_QualifyWeatherProgression = 1
		If $Value_QualifyWeatherProgression <> 0 And $Value_QualifyWeatherProgression <> 1 Then $Value_QualifyWeatherProgression = StringTrimRight($Value_QualifyWeatherProgression, 1)
	Local $Value_RaceDateYear = GUICtrlRead($Wert_RaceDateYear)
	Local $Value_RaceDateMonth = GUICtrlRead($Wert_RaceDateMonth)
	Local $Value_RaceDateDay = GUICtrlRead($Wert_RaceDateDay)
	Local $Value_RaceDateHour = GUICtrlRead($Wert_RaceDateHour)
	Local $Value_RaceDateProgression = GUICtrlRead($Wert_RaceDateProgression)
		If $Value_RaceDateProgression = "OFF" Then $Value_RaceDateProgression = 0
		If $Value_RaceDateProgression = "Real Time" Then $Value_RaceDateProgression = 1
		If $Value_RaceDateProgression <> 0 And $Value_RaceDateProgression <> 1 Then $Value_RaceDateProgression = StringTrimRight($Value_RaceDateProgression, 1)
	Local $Value_RaceWeatherProgression = GUICtrlRead($Wert_RaceWeatherProgression)
		If $Value_RaceWeatherProgression = "OFF" Then $Value_RaceWeatherProgression = 0
		If $Value_RaceWeatherProgression = "Sync to Race" Then $Value_RaceWeatherProgression = 1
		If $Value_RaceWeatherProgression <> 0 And $Value_RaceWeatherProgression <> 1 Then $Value_RaceWeatherProgression = StringTrimRight($Value_RaceWeatherProgression, 1)

	Local $Value_PracticeWeatherSlots = GUICtrlRead($Wert_PracticeWeatherSlots)
	Local $Value_PracticeWeatherSlot1 = GUICtrlRead($Wert_PracticeWeatherSlot1)
	Local $Value_PracticeWeatherSlot2 = GUICtrlRead($Wert_PracticeWeatherSlot2)
	Local $Value_PracticeWeatherSlot3 = GUICtrlRead($Wert_PracticeWeatherSlot3)
	Local $Value_PracticeWeatherSlot4 = GUICtrlRead($Wert_PracticeWeatherSlot4)

	Local $Value_QualifyWeatherSlots = GUICtrlRead($Wert_QualifyWeatherSlots)
	Local $Value_QualifyWeatherSlot1 = GUICtrlRead($Wert_QualifyWeatherSlot1)
	Local $Value_QualifyWeatherSlot2 = GUICtrlRead($Wert_QualifyWeatherSlot2)
	Local $Value_QualifyWeatherSlot3 = GUICtrlRead($Wert_QualifyWeatherSlot3)
	Local $Value_QualifyWeatherSlot4 = GUICtrlRead($Wert_QualifyWeatherSlot4)

	Local $Value_RaceWeatherSlots = GUICtrlRead($Wert_RaceWeatherSlots)
	Local $Value_RaceWeatherSlot1 = GUICtrlRead($Wert_RaceWeatherSlot1)
	Local $Value_RaceWeatherSlot2 = GUICtrlRead($Wert_RaceWeatherSlot2)
	Local $Value_RaceWeatherSlot3 = GUICtrlRead($Wert_RaceWeatherSlot3)
	Local $Value_RaceWeatherSlot4 = GUICtrlRead($Wert_RaceWeatherSlot4)

	IniWrite($RC_LUA_Settings_ini_File, "Settings", "persist_index", $Wert_persist_index)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "Flags", $Value_Flags)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "OpponentDifficulty", $Value_OpponentDifficulty)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "DamageType", $Value_DamageType)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "TireWearType", $Value_TireWearType)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "FuelUsageType", $Value_FuelUsageType)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "PenaltiesType", $Value_PenaltiesType)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "AllowedViews", $Value_AllowedViews)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "ManualPitStops", $Value_ManualPitStops)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "ManualRollingStarts", $Value_ManualRollingStarts)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "MinimumOnlineRank", $Value_MinimumOnlineRank)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "MinimumOnlineStrength", $Value_MinimumOnlineStrength)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeLength", $Value_PracticeLength)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyLength", $Value_QualifyLength)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceLength", $Value_RaceLength)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceRollingStart", $Value_RaceRollingStart)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceFormationLap", $Value_RaceFormationLap)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceMandatoryPitStops", $Value_RaceMandatoryPitStops)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeDateHour", $Value_PracticeDateHour)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeDateProgression", $Value_PracticeDateProgression)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherProgression", $Value_PracticeWeatherProgression)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyDateHour", $Value_QualifyDateHour)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyDateProgression", $Value_QualifyDateProgression)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherProgression", $Value_QualifyWeatherProgression)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceDateYear", $Value_RaceDateYear)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceDateMonth", $Value_RaceDateMonth)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceDateDay", $Value_RaceDateDay)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceDateHour", $Value_RaceDateHour)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceDateProgression", $Value_RaceDateProgression)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherProgression", $Value_RaceWeatherProgression)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlots", $Value_PracticeWeatherSlots)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlot1", $Value_PracticeWeatherSlot1)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlot2", $Value_PracticeWeatherSlot2)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlot3", $Value_PracticeWeatherSlot3)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "PracticeWeatherSlot4", $Value_PracticeWeatherSlot4)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlots", $Value_QualifyWeatherSlots)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlot1", $Value_QualifyWeatherSlot1)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlot2", $Value_QualifyWeatherSlot2)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlot3", $Value_QualifyWeatherSlot3)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "QualifyWeatherSlot4", $Value_QualifyWeatherSlot4)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlots", $Value_RaceWeatherSlots)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlot1", $Value_RaceWeatherSlot1)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlot2", $Value_RaceWeatherSlot2)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlot3", $Value_RaceWeatherSlot3)
	IniWrite($RC_LUA_Settings_ini_File, "Settings", "RaceWeatherSlot4", $Value_RaceWeatherSlot4)

	If FileExists($sms_rotate_config_json_File) Then
		$Array = FileReadToArray($sms_rotate_config_json_File)
		$NR_Lines_config_cfg = _FileCountLines($sms_rotate_config_json_File) - 1

		$EmptyFile = FileOpen($sms_rotate_config_json_File, 2)
		FileWrite($EmptyFile, "")
		FileClose($EmptyFile)

		For $Schleife_2 = 0 To $NR_Lines_config_cfg
			Local $Value_ProgressBar = $Schleife_2 * 100 / $NR_Lines_config_cfg
			GUICtrlSetData($ProgressBar_2, $Value_ProgressBar)
			$Wert_Line = $Array[$Schleife_2]
			If $Schleife_2 < 223 Then

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"persist_index" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"persist_index" : "' & $Value_persist_index & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"Flags" : ')
				If $StringInStr_Check_1 <> 0 Then
					If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"Flags" : "' & $Value_Flags & '",'
				EndIf

				If $Value_FILL_SESSION_WITH_AI = "true" Then
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		//"OpponentDifficulty" : ')
					If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"OpponentDifficulty" : ' & $Value_OpponentDifficulty & ','
				Else
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"OpponentDifficulty" : ')
					If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		//"OpponentDifficulty" : ' & $Value_OpponentDifficulty & ','
				EndIf

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"DamageType" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"DamageType" : "' & $Value_DamageType & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"TireWearType" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"TireWearType" : "' & $Value_TireWearType & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"FuelUsageType" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"FuelUsageType" : "' & $Value_FuelUsageType & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PenaltiesType" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PenaltiesType" : "' & $Value_PenaltiesType & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"AllowedViews" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"AllowedViews" : "' & $Value_AllowedViews & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"ManualPitStops" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"ManualPitStops" : "' & $Value_ManualPitStops & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"ManualRollingStarts" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"ManualRollingStarts" : "' & $Value_ManualRollingStarts & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"MinimumOnlineRank" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"MinimumOnlineRank" : "' & $Value_MinimumOnlineRank & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"MinimumOnlineStrength" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"MinimumOnlineStrength" : "' & $Value_MinimumOnlineStrength & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeLength" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PracticeLength" : ' & $Value_PracticeLength & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyLength" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"QualifyLength" : ' & $Value_QualifyLength & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceLength" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceLength" : ' & $Value_RaceLength & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceRollingStart" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceRollingStart" : ' & $Value_RaceRollingStart & ','



				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceFormationLap" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceFormationLap" : "' & $Value_RaceFormationLap & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceMandatoryPitStops" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceMandatoryPitStops" : "' & $Value_RaceMandatoryPitStops & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeDateHour" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PracticeDateHour" : "' & $Value_PracticeDateHour & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeDateProgression" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PracticeDateProgression" : "' & $Value_PracticeDateProgression & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeWeatherProgression" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PracticeWeatherProgression" : "' & $Value_PracticeWeatherProgression & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyDateHour" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"QualifyDateHour" : "' & $Value_QualifyDateHour & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyDateProgression" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"QualifyDateProgression" : "' & $Value_QualifyDateProgression & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyWeatherProgression" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"QualifyWeatherProgression" : "' & $Value_QualifyWeatherProgression & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceDateYear" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceDateYear" : ' & $Value_RaceDateYear& ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceDateMonth" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceDateMonth" : ' & $Value_RaceDateMonth & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceDateDay" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceDateDay" : ' & $Value_RaceDateDay & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceDateHour" : ')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceDateHour" : ' & $Value_RaceDateHour & ','




				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceDateProgression" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceDateProgression" : "' & $Value_RaceDateProgression & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceWeatherProgression" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceWeatherProgression" : "' & $Value_RaceWeatherProgression & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeWeatherSlots" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PracticeWeatherSlots" : "' & $Value_PracticeWeatherSlots & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeWeatherSlot1" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PracticeWeatherSlot1" : "' & $Value_PracticeWeatherSlot1 & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeWeatherSlot2" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PracticeWeatherSlot2" : "' & $Value_PracticeWeatherSlot2 & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeWeatherSlot3" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PracticeWeatherSlot3" : "' & $Value_PracticeWeatherSlot3 & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"PracticeWeatherSlot4" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"PracticeWeatherSlot4" : "' & $Value_PracticeWeatherSlot4 & '",'


				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyWeatherSlots" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"QualifyWeatherSlots" : "' & $Value_QualifyWeatherSlots & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyWeatherSlot1" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"QualifyWeatherSlot1" : "' & $Value_QualifyWeatherSlot1 & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyWeatherSlot2" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"QualifyWeatherSlot2" : "' & $Value_QualifyWeatherSlot2 & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyWeatherSlot3" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"QualifyWeatherSlot3" : "' & $Value_QualifyWeatherSlot3 & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"QualifyWeatherSlot4" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"QualifyWeatherSlot4" : "' & $Value_QualifyWeatherSlot4 & '",'


				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceWeatherSlots" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceWeatherSlots" : "' & $Value_RaceWeatherSlots & ','

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceWeatherSlot1" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceWeatherSlot1" : "' & $Value_RaceWeatherSlot1 & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceWeatherSlot2" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceWeatherSlot2" : "' & $Value_RaceWeatherSlot2 & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceWeatherSlot3" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceWeatherSlot3" : "' & $Value_RaceWeatherSlot3 & '",'

				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		"RaceWeatherSlot4" : "')
				If $StringInStr_Check_1 <> 0 Then $Wert_Line = '		"RaceWeatherSlot4" : "' & $Value_RaceWeatherSlot4 & '",'


			EndIf
			FileWriteLine($sms_rotate_config_json_File, $Wert_Line)
		Next
		Sleep(800)
		GUICtrlSetData($ProgressBar_2, 0)
	EndIf
EndFunc

Func _Button_ServerControl_Restart_DS_3()
	Local $DS_Mode_Temp = IniRead($config_ini, "PC_Server", "DS_Mode", "local")
	_Button_ServerControl_ALL_Save_INI()
	If $DS_Mode_Temp = "local" Then _Restart_DS()
	If $DS_Mode_Temp = "remote" Then _Restart_DS_Remote()
	Sleep(500)
	_Close_ServerControl_MoreSettings_GUI()
EndFunc


Func _Button_ServerControl_Track_Data()
	_Preparing_Data_GUI()
	_Button_ServerControl_Save_2()
	;MsgBox(0, "", "Exit _Button_ServerControl_Save_2")
	Local $RC_TEMP_1 = IniRead($config_ini, "TEMP", "RC_TEMP_1", "50")
	Local $RC_TEMP_2 = IniRead($config_ini, "TEMP", "RC_TEMP_2", "223")

	Local $Max_NR = IniRead($RC_LUA_Settings_ini_File, "Settings", "NR_Of_Tracks_TrackRotation", "")
	Local $Activate_MultiClass = IniRead($config_ini, "Server_Einstellungen", "Activate_MultiClass", "")

	Local $Value_VehicleClassId_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "VehicleClassId", "")
	Local $Value_MultiClassSlots_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlots", "")
	Local $Value_MultiClassSlot1_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot1", "")
	Local $Value_MultiClassSlot2_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot2", "")
	Local $Value_MultiClassSlot3_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot3", "")

	;MsgBox(0, "_Button_ServerControl_Track_Data", "$Max_NR = " & $Max_NR)

	If FileExists($sms_rotate_config_json_File) Then
		$Array = FileReadToArray($sms_rotate_config_json_File)
		$NR_Lines_config_cfg = _FileCountLines($sms_rotate_config_json_File) - 1

		$EmptyFile = FileOpen($sms_rotate_config_json_File, 2)
		FileWrite($EmptyFile, "")
		FileClose($EmptyFile)


		;MsgBox(0, "$Activate_MultiClass", $Activate_MultiClass & @CRLF & "$Value_MultiClassSlots = " & $Value_MultiClassSlots)


		For $Schleife_2 = 0 To $NR_Lines_config_cfg
			Local $Value_ProgressBar = $Schleife_2 * 100 / $NR_Lines_config_cfg
			GUICtrlSetData($ProgressBar_2, $Value_ProgressBar)
			GUICtrlSetData($Anzeige_Fortschrittbalken, $Value_ProgressBar)
			$Wert_Line = $Array[$Schleife_2]

			If $Activate_MultiClass = "true" Then
				If $Schleife_2 < $RC_TEMP_1 Then

					If $Activate_MultiClass = "true" Then
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "VehicleClassId" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"VehicleClassId" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"VehicleClassId" : "' & $Value_VehicleClassId_Default & '",'
					Else
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "VehicleClassId" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"VehicleClassId" : "')
						If $StringInStr_Check_1 <> 0 Or  $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "VehicleClassId" : "' & $Value_VehicleClassId_Default & '",'
					EndIf


					If $Activate_MultiClass = "true" Then
						If $Value_MultiClassSlots_Default = "3" Then
							$Wert_Cut = StringInStr($Wert_Line, ', //', 0, - 1)
							If $Wert_Cut <> 0 Then $Wert_Line = StringLeft($Wert_Line, $Wert_Cut)
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlots" : ')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlots" : ')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlots" : ' & $Value_MultiClassSlots_Default & ','
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot1" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot1" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot1" : "' & $Value_MultiClassSlot1_Default & '",'
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot2" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot2" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot2" : "' & $Value_MultiClassSlot2_Default & '",'
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot3" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot3" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot3" : "' & $Value_MultiClassSlot3_Default & '",'
						EndIf

						If $Value_MultiClassSlots_Default = "2" Then
							$Wert_Cut = StringInStr($Wert_Line, ', //')
							$Wert_Line = StringLeft($Wert_Line, $Wert_Cut)
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlots" : ')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlots" : ')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlots" : ' & $Value_MultiClassSlots_Default & ','
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot1" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot1" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot1" : "' & $Value_MultiClassSlot1_Default & '",'
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot2" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot2" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot2" : "' & $Value_MultiClassSlot2_Default & '",'
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot3" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot3" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot3" : "' & $Value_MultiClassSlot3_Default & '",'
						EndIf

						If $Value_MultiClassSlots_Default = "1" Then
							$Wert_Cut = StringInStr($Wert_Line, ', //')
							$Wert_Line = StringLeft($Wert_Line, $Wert_Cut)
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlots" : ')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlots" : ')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlots" : ' & $Value_MultiClassSlots_Default & ','
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot1" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot1" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot1" : "' & $Value_MultiClassSlot1_Default & '",'
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot2" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot2" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot2" : "' & $Value_MultiClassSlot2_Default & '",'
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot3" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot3" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot3" : "' & $Value_MultiClassSlot3_Default & '",'
						EndIf
					EndIf

					If $Activate_MultiClass <> "true" Then
						$Wert_Cut = StringInStr($Wert_Line, ', //', 0, - 1)
						If $Wert_Cut <> 0 Then $Wert_Line = StringLeft($Wert_Line, $Wert_Cut)
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlots" : ')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlots" : ')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlots" : ' & $Value_MultiClassSlots_Default & ','
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot1" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot1" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot1" : "' & $Value_MultiClassSlot1_Default & '",'
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot2" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot2" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot2" : "' & $Value_MultiClassSlot2_Default & '",'
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot3" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot3" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot3" : "' & $Value_MultiClassSlot3_Default & '",'
					EndIf
				EndIf
			EndIf

			FileWriteLine($sms_rotate_config_json_File, $Wert_Line)
		Next



	EndIf

	Sleep(800)
	GUICtrlSetData($ProgressBar_2, 0)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
	GUIDelete($GUI_Loading)
EndFunc

Func _Button_ServerControl_Track_Data_NEW()
	_Preparing_Data_GUI()
	;_Button_ServerControl_Save_2()
	Local $RC_TEMP_1 = IniRead($config_ini, "TEMP", "RC_TEMP_1", "50")
	Local $RC_TEMP_2 = IniRead($config_ini, "TEMP", "RC_TEMP_2", "223")

	Local $Max_NR = IniRead($RC_LUA_Settings_ini_File, "Settings", "NR_Of_Tracks_TrackRotation", "")
	Local $Activate_MultiClass = IniRead($config_ini, "Server_Einstellungen", "Activate_MultiClass", "")

	Local $Value_VehicleClassId_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "VehicleClassId", "")
	Local $Value_MultiClassSlots_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlots", "")
	Local $Value_MultiClassSlot1_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot1", "")
	Local $Value_MultiClassSlot2_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot2", "")
	Local $Value_MultiClassSlot3_Default = IniRead($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot3", "")

	;MsgBox(0, "_Button_ServerControl_Track_Data", "$Max_NR = " & $Max_NR)

	If FileExists($sms_rotate_config_json_File) Then
		$Array = FileReadToArray($sms_rotate_config_json_File)
		$NR_Lines_config_cfg = _FileCountLines($sms_rotate_config_json_File) - 1

		$EmptyFile = FileOpen($sms_rotate_config_json_File, 2)
		FileWrite($EmptyFile, "")
		FileClose($EmptyFile)


		;MsgBox(0, "$Activate_MultiClass", $Activate_MultiClass & @CRLF & "$Value_MultiClassSlots = " & $Value_MultiClassSlots)


		For $Schleife_2 = 0 To $NR_Lines_config_cfg
			Local $Value_ProgressBar = $Schleife_2 * 100 / $NR_Lines_config_cfg
			GUICtrlSetData($ProgressBar_2, $Value_ProgressBar)
			GUICtrlSetData($Anzeige_Fortschrittbalken, $Value_ProgressBar)
			$Wert_Line = $Array[$Schleife_2]

			If $Activate_MultiClass = "true" Then
				If $Schleife_2 < $RC_TEMP_1 Then

					If $Activate_MultiClass = "true" Then
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "VehicleClassId" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"VehicleClassId" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"VehicleClassId" : "' & $Value_VehicleClassId_Default & '",'
					Else
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "VehicleClassId" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"VehicleClassId" : "')
						If $StringInStr_Check_1 <> 0 Or  $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "VehicleClassId" : "' & $Value_VehicleClassId_Default & '",'
					EndIf


					If $Activate_MultiClass = "true" Then
						If $Value_MultiClassSlots_Default = "3" Then
							$Wert_Cut = StringInStr($Wert_Line, ', //', 0, - 1)
							If $Wert_Cut <> 0 Then $Wert_Line = StringLeft($Wert_Line, $Wert_Cut)
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlots" : ')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlots" : ')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlots" : ' & $Value_MultiClassSlots_Default & ','
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot1" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot1" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot1" : "' & $Value_MultiClassSlot1_Default & '",'
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot2" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot2" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot2" : "' & $Value_MultiClassSlot2_Default & '",'
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot3" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot3" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot3" : "' & $Value_MultiClassSlot3_Default & '",'
						EndIf

						If $Value_MultiClassSlots_Default = "2" Then
							$Wert_Cut = StringInStr($Wert_Line, ', //')
							$Wert_Line = StringLeft($Wert_Line, $Wert_Cut)
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlots" : ')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlots" : ')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlots" : ' & $Value_MultiClassSlots_Default & ','
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot1" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot1" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot1" : "' & $Value_MultiClassSlot1_Default & '",'
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot2" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot2" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot2" : "' & $Value_MultiClassSlot2_Default & '",'
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot3" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot3" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot3" : "' & $Value_MultiClassSlot3_Default & '",'
						EndIf

						If $Value_MultiClassSlots_Default = "1" Then
							$Wert_Cut = StringInStr($Wert_Line, ', //')
							$Wert_Line = StringLeft($Wert_Line, $Wert_Cut)
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlots" : ')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlots" : ')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlots" : ' & $Value_MultiClassSlots_Default & ','
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot1" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot1" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		"MultiClassSlot1" : "' & $Value_MultiClassSlot1_Default & '",'
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot2" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot2" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot2" : "' & $Value_MultiClassSlot2_Default & '",'
							Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot3" : "')
							Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot3" : "')
							If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot3" : "' & $Value_MultiClassSlot3_Default & '",'
						EndIf
					EndIf

					If $Activate_MultiClass <> "true" Then
						$Wert_Cut = StringInStr($Wert_Line, ', //', 0, - 1)
						If $Wert_Cut <> 0 Then $Wert_Line = StringLeft($Wert_Line, $Wert_Cut)
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlots" : ')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlots" : ')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlots" : ' & $Value_MultiClassSlots_Default & ','
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot1" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot1" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot1" : "' & $Value_MultiClassSlot1_Default & '",'
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot2" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot2" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot2" : "' & $Value_MultiClassSlot2_Default & '",'
						Local $StringInStr_Check_1 = StringInStr($Wert_Line, '		// "MultiClassSlot3" : "')
						Local $StringInStr_Check_2 = StringInStr($Wert_Line, '		"MultiClassSlot3" : "')
						If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '		// "MultiClassSlot3" : "' & $Value_MultiClassSlot3_Default & '",'
					EndIf
				EndIf
			EndIf

			FileWriteLine($sms_rotate_config_json_File, $Wert_Line)
		Next

		For $Loop = 1 To $Max_NR
			$Wert_Line = $Array[$Loop]
			;MsgBox(0, "", $Max_NR)
			;Local $Value_ProgressBar = $Loop * 100 / $Max_NR
			;GUICtrlSetData($ProgressBar_2, $Value_ProgressBar)
			;GUICtrlSetData($Anzeige_Fortschrittbalken, $Value_ProgressBar)

			Local $Value_TrackId = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "TrackId", "")
			Local $Value_VehicleClassId = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "VehicleClassId", "")
			Local $Value_MultiClassSlots = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "MultiClassSlots", "")
			Local $Value_MultiClassSlot1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "MultiClassSlot1", "")
			Local $Value_MultiClassSlot2 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "MultiClassSlot2", "")
			Local $Value_MultiClassSlot3 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "MultiClassSlot3", "")

			Local $Value_Flags = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "Flags", "")
			Local $Value_RemoveFlags = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RemoveFlags", "")
			Local $Value_ManualRollingStarts = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "ManualRollingStarts", "")
			Local $Value_RaceRollingStart = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RaceRollingStart", "")
			Local $Value_RaceFormationLap = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RaceFormationLap", "")

			Local $Value_PracticeLength = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "PracticeLength", "")
			Local $Value_PracticeDateHour = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "PracticeDateHour", "")
			Local $Value_PracticeWeatherSlots = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "PracticeWeatherSlots", "")
			Local $Value_PracticeWeatherSlot1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "PracticeWeatherSlot1", "")
			Local $Value_PracticeWeatherSlot2 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "PracticeWeatherSlot2", "")
			Local $Value_PracticeWeatherSlot3 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "PracticeWeatherSlot3", "")
			Local $Value_PracticeWeatherSlot4 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "PracticeWeatherSlot4", "")

			Local $Value_QualifyLength = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "QualifyLength", "")
			Local $Value_QualifyDateHour = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "QualifyDateHour", "")
			Local $Value_QualifyWeatherSlots = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "QualifyWeatherSlots", "")
			Local $Value_QualifyWeatherSlot1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "QualifyWeatherSlot1", "")
			Local $Value_QualifyWeatherSlot2 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "QualifyWeatherSlot2", "")
			Local $Value_QualifyWeatherSlot3 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "QualifyWeatherSlot3", "")
			Local $Value_QualifyWeatherSlot4 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "QualifyWeatherSlot4", "")

			Local $Value_RaceLength = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RaceLength", "")
			Local $Value_RaceDateYear = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RaceDateYear", "")
			Local $Value_RaceDateMonth = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RaceDateMonth", "")
			Local $Value_RaceDateDay = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RaceDateDay", "")
			Local $Value_RaceDateHour = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RaceDateHour", "")
			Local $Value_RaceWeatherSlots = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RaceWeatherSlots", "")
			Local $Value_RaceWeatherSlot1 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RaceWeatherSlot1", "")
			Local $Value_RaceWeatherSlot2 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RaceWeatherSlot2", "")
			Local $Value_RaceWeatherSlot3 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RaceWeatherSlot3", "")
			Local $Value_RaceWeatherSlot4 = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RaceWeatherSlot4", "")

			Local $Value_ABS_ALLOWED = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "Flags", "")
				If $Value_ABS_ALLOWED = "true" Then $Value_ABS_ALLOWED = "ABS_ALLOWED"
			Local $Value_TCS_ALLOWED = IniRead($RC_LUA_Settings_ini_File, "Track_" & $Loop, "RemoveFlags", "")
				If $Value_TCS_ALLOWED = "true" Then $Value_ABS_ALLOWED = "TCS_ALLOWED"

			;MsgBox(0, "", $Value_TrackId & @CRLF & _
			;				$Value_VehicleClassId)

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"TrackId" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"TrackId" : "' & $Value_TrackId & '",'

			If $Activate_MultiClass = "true" Then
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "VehicleClassId" : "')
				Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"VehicleClassId" : "')
				If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			"VehicleClassId" : "' & $Value_VehicleClassId & '",'
			EndIf

			If $Activate_MultiClass = "false" Then
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "VehicleClassId" : "')
				Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"VehicleClassId" : "')
				If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			// "VehicleClassId" : "' & $Value_VehicleClassId & '",'
			EndIf



			If $Activate_MultiClass = "true" Then
				If $Value_MultiClassSlots_Default = "3" Then
					$Wert_Cut = StringInStr($Wert_Line, ', //', 0, - 1)
					MsgBox(0, "$Wert_Cut", $Wert_Line & @CRLF & @CRLF & $Wert_Cut)
					If $Wert_Cut <> 0 Then $Wert_Line = StringLeft($Wert_Line, $Wert_Cut)
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlots" : ')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlots" : ')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			"MultiClassSlots" : ' & $Value_MultiClassSlots & ','
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot1" : ')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlot1" : ')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			"MultiClassSlot1" : "' & $Value_MultiClassSlot1 & '",'
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot2" : ')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlot2" : ')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			"MultiClassSlot2" : "' & $Value_MultiClassSlot2 & '",'
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot3" : ')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlot3" : ')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			"MultiClassSlot3" : "' & $Value_MultiClassSlot3 & '",'
				EndIf

				If $Value_MultiClassSlots_Default = "2" Then
					$Wert_Cut = StringInStr($Wert_Line, ', //')
					$Wert_Line = StringLeft($Wert_Line, $Wert_Cut)
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlots" : ')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlots" : ')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			"MultiClassSlots" : ' & $Value_MultiClassSlots & ','
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot1" : ')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlot1" : ')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			"MultiClassSlot1" : "' & $Value_MultiClassSlot1 & '",'
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot2" : ')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlot2" : ')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			"MultiClassSlot2" : "' & $Value_MultiClassSlot2 & '",'
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot3" : ')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlot3" : ')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			// "MultiClassSlot3" : "' & $Value_MultiClassSlot3 & '",'
				EndIf

				If $Value_MultiClassSlots_Default = "1" Then
					$Wert_Cut = StringInStr($Wert_Line, ', //')
					$Wert_Line = StringLeft($Wert_Line, $Wert_Cut)
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlots" : ')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlots" : ')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			"MultiClassSlots" : ' & $Value_MultiClassSlots & ','
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot1" : ')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlot1" : ')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			"MultiClassSlot1" : "' & $Value_MultiClassSlot1 & '",'
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot2" : ')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlot2" : ')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			// "MultiClassSlot2" : "' & $Value_MultiClassSlot2 & '",'
					Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot3" : ')
					Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlot3" : ')
					If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			// "MultiClassSlot3" : "' & $Value_MultiClassSlot3 & '",'
				EndIf
			Else
				$Wert_Cut = StringInStr($Wert_Line, ', //')
				$Wert_Line = StringLeft($Wert_Line, $Wert_Cut)
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlots" : ')
				Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlots" : ')
				If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			// "MultiClassSlots" : ' & $Value_MultiClassSlots & ','
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot1" : ')
				Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlot1" : ')
				If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			// "MultiClassSlot1" : "' & $Value_MultiClassSlot1 & '",'
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot2" : ')
				Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlot2" : ')
				If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			// "MultiClassSlot2" : "' & $Value_MultiClassSlot2 & '",'
				Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			// "MultiClassSlot3" : ')
				Local $StringInStr_Check_2 = StringInStr($Wert_Line, '			"MultiClassSlot3" : ')
				If $StringInStr_Check_1 <> 0 Or $StringInStr_Check_2 <> 0 Then $Wert_Line = '			// "MultiClassSlot3" : "' & $Value_MultiClassSlot3 & '",'
			EndIf





			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"Flags" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"Flags" : "' & $Value_Flags & '",'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RemoveFlags" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"RemoveFlags" : "' & $Value_RemoveFlags & '",'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"ManualRollingStarts" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"ManualRollingStarts" : ' & $Value_ManualRollingStarts & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceRollingStart" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"RaceRollingStart" : ' & $Value_RaceRollingStart & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceFormationLap" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"RaceFormationLap" : ' & $Value_RaceFormationLap & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeLength" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"PracticeLength" : ' & $Value_PracticeLength & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeDateHour" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"PracticeDateHour" : ' & $Value_PracticeDateHour & ','


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeWeatherSlots" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"PracticeWeatherSlots" : ' & $Value_PracticeWeatherSlots & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeWeatherSlot1" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"PracticeWeatherSlot1" : "' & $Value_PracticeWeatherSlot1 & '",'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeWeatherSlot2" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"PracticeWeatherSlot2" : "' & $Value_PracticeWeatherSlot2 & '",'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeWeatherSlot3" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"PracticeWeatherSlot3" : "' & $Value_PracticeWeatherSlot3 & '",'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"PracticeWeatherSlot4" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"PracticeWeatherSlot4" : "' & $Value_PracticeWeatherSlot4 & '",'


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyLength" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"QualifyLength" : ' & $Value_QualifyLength & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyDateHour" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"QualifyDateHour" : ' & $Value_QualifyDateHour & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyWeatherSlots" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"QualifyWeatherSlots" : ' & $Value_QualifyWeatherSlots & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyWeatherSlot1" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"QualifyWeatherSlot1" : "' & $Value_QualifyWeatherSlot1 & '",'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyWeatherSlot2" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"QualifyWeatherSlot2" : "' & $Value_QualifyWeatherSlot2 & '",'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyWeatherSlot3" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"QualifyWeatherSlot3" : "' & $Value_QualifyWeatherSlot3 & '",'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"QualifyWeatherSlot4" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"QualifyWeatherSlot4" : "' & $Value_QualifyWeatherSlot4 & '",'


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceLength" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"RaceLength" : ' & $Value_RaceLength & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceDateYear" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"RaceDateYear" : ' & $Value_RaceDateYear & ','


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceDateMonth" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"RaceDateMonth" : ' & $Value_RaceDateMonth & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceDateDay" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"RaceDateDay" : ' & $Value_RaceDateDay & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceDateHour" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"RaceDateHour" : ' & $Value_RaceDateHour & ','


			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceWeatherSlots" : ')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"RaceWeatherSlots" : ' & $Value_RaceWeatherSlots & ','

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceWeatherSlot1" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"RaceWeatherSlot1" : "' & $Value_RaceWeatherSlot1 & '",'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceWeatherSlot2" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"RaceWeatherSlot2" : "' & $Value_RaceWeatherSlot2 & '",'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceWeatherSlot3" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"RaceWeatherSlot3" : "' & $Value_RaceWeatherSlot3 & '",'

			Local $StringInStr_Check_1 = StringInStr($Wert_Line, '			"RaceWeatherSlot4" : "')
			If $StringInStr_Check_1 <> 0 Then $Wert_Line = '			"RaceWeatherSlot4" : "' & $Value_RaceWeatherSlot4 & '",'

			If $Wert_Line <> "" Then FileWriteLine($sms_rotate_config_json_File, $Wert_Line)
		Next

	EndIf

	Sleep(800)
	GUICtrlSetData($ProgressBar_2, 0)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
	GUIDelete($GUI_Loading)
EndFunc


Func _Button_ServerControl_Restart_DS_4()
	Local $DS_Mode_Temp = IniRead($config_ini, "PC_Server", "DS_Mode", "local")
	_Button_ServerControl_Save_2()
	If $DS_Mode_Temp = "local" Then _Restart_DS()
	If $DS_Mode_Temp = "remote" Then _Restart_DS_Remote()
	Sleep(500)
	_Close_ServerControl_LUA_MoreSettings_GUI()
EndFunc


Func _Button_ServerControl_MoreSettings()

	Local $Value_persist_index = IniRead($RC_LUA_Settings_ini_File, "Settings", "persist_index", "")
	Local $Value_Flags = IniRead($config_ini, "Server_Einstellungen", "Flags", "")

	Local $Value_TireWearType = IniRead($RC_LUA_Settings_ini_File, "Settings", "TireWearType", "")
	Local $Value_FuelUsageType = IniRead($RC_LUA_Settings_ini_File, "Settings", "FuelUsageType", "")
	Local $Value_DamageType = IniRead($RC_LUA_Settings_ini_File, "Settings", "DamageType", "")
	Local $Value_PenaltiesType = IniRead($RC_LUA_Settings_ini_File, "Settings", "PenaltiesType", "")
	Local $Value_AllowedViews = IniRead($RC_LUA_Settings_ini_File, "Settings", "AllowedViews", "")


	;Global $ServerControl_MoreSettings_GUI = GUICreate("More Settings", 1125, 400, -1, -1)
	Global $ServerControl_MoreSettings_GUI = GUICreate("More Settings", 1125, 400, -1, -1, BitOR($WS_BORDER, $WS_CAPTION, $WS_SYSMENU))
	Local $hMenu = _GUICtrlMenu_GetSystemMenu($ServerControl_MoreSettings_GUI)
	Local $iMenuItemCount = _GUICtrlMenu_GetItemCount($hMenu)
	_GUICtrlMenu_RemoveMenu($hMenu, $iMenuItemCount - 1, $MF_BYPOSITION)
	HotKeySet("{ESC}", "_Close_ServerControl_MoreSettings_GUI")

	$ProgressBar_2 = GUICtrlCreateProgress(0, 350, 1125, 5)

	Local $Pos_X_1 = 5
	Local $Pos_X_2= 380
	Local $Pos_X_3= 755
	Local $Pos_Y = 5

	#Region X 1
	GUICtrlCreateLabel("Persist index:", $Pos_X_1 + 5, $Pos_Y, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_persist_index = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y - 3, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_persist_index")

	GUICtrlCreateLabel("Flags:", $Pos_X_1 + 5, $Pos_Y + 23, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_Flags = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 20, 165, 20)

	GUICtrlCreateLabel("Opponent Difficulty:", $Pos_X_1 + 5, $Pos_Y + 46, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_OpponentDifficulty = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 43, 165, 20)

	GUICtrlCreateLabel("DamageType:", $Pos_X_1 + 5, $Pos_Y + 69, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_DamageType = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 66, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_DamageType")

	GUICtrlCreateLabel("Tire Wear Type:", $Pos_X_1 + 5, $Pos_Y + 92, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_TireWearType = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 89, 165, 55)
	;GUICtrlSetOnEvent(-1, "_Wert_TireWearType")

	GUICtrlCreateLabel("Fuel Usage Type:", $Pos_X_1 + 5, $Pos_Y + 115, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_FuelUsageType = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 112, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_FuelUsageType")

	GUICtrlCreateLabel("Penalties Type:", $Pos_X_1 + 5, $Pos_Y + 138, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_PenaltiesType = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 135, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_PenaltiesType")

	GUICtrlCreateLabel("Allowed Views:", $Pos_X_1 + 5, $Pos_Y + 161, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_AllowedViews = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 158, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("Manual Pit Stops:", $Pos_X_1 + 5, $Pos_Y + 184, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_ManualPitStops = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 181, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("Manual Rolling Starts:", $Pos_X_1 + 5, $Pos_Y + 207, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_ManualRollingStarts = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 204, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("Minimum Online Rank:", $Pos_X_1 + 5, $Pos_Y + 230, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_MinimumOnlineRank = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 227, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("Minimum Online Strength:", $Pos_X_1 + 5, $Pos_Y + 253, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_MinimumOnlineStrength = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 250, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("PracticeLength:", $Pos_X_1 + 5, $Pos_Y + 276, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_PracticeLength = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 274, 165, 20)
	;Global $Wert_PracticeLength = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 274, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("QualifyLength:", $Pos_X_1 + 5, $Pos_Y + 299, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_QualifyLength = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 296, 165, 20)
	;Global $Wert_QualifyLength = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 296, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("RaceLength:", $Pos_X_1 + 5, $Pos_Y + 322, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceLength = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 319, 165, 20)
	;Global $Wert_QualifyLength = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 296, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")
	#endregion


	#Region X 2
	GUICtrlCreateLabel("RaceRollingStart:", $Pos_X_2 + 5, $Pos_Y, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceRollingStart = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y - 3, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("RaceFormationLap:", $Pos_X_2 + 5, $Pos_Y + 23, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceFormationLap = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 20, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("RaceMandatoryPitStops:", $Pos_X_2 + 5, $Pos_Y + 46, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceMandatoryPitStops = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 43, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")


	GUICtrlCreateLabel("Practice Date Hour:", $Pos_X_2 + 5, $Pos_Y + 69, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_PracticeDateHour = GUICtrlCreateInput("", $Pos_X_2 + 200, $Pos_Y + 66, 165, 20)
	;Global $Wert_PracticeDateHour = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 66, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_persist_index")

	GUICtrlCreateLabel("Practice Date Progression:", $Pos_X_2 + 5, $Pos_Y + 92, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	;Global $Wert_PracticeDateProgression = GUICtrlCreateInput($Value_Flags, $Pos_X_2 + 200, $Pos_Y + 89, 165, 20)
	Global $Wert_PracticeDateProgression = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 89, 165, 20)

	GUICtrlCreateLabel("Practice Weather Progression:", $Pos_X_2 + 5, $Pos_Y + 115, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	;Global $Wert_PracticeWeatherProgression = GUICtrlCreateInput($Value_Flags, $Pos_X_2 + 200, $Pos_Y + 112, 165, 20)
	Global $Wert_PracticeWeatherProgression = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 112, 165, 20)

	GUICtrlCreateLabel("Qualify Date Hour:", $Pos_X_2 + 5, $Pos_Y + 138, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_QualifyDateHour = GUICtrlCreateInput("", $Pos_X_2 + 200, $Pos_Y + 135, 165, 20)
	;Global $Wert_QualifyDateHour = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 135, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_DamageType")

	GUICtrlCreateLabel("Qualify Date Progression:", $Pos_X_2 + 5, $Pos_Y + 161, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_QualifyDateProgression = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 158, 165, 55)
	;GUICtrlSetOnEvent(-1, "_Wert_TireWearType")

	GUICtrlCreateLabel("Qualify Weather Progression:", $Pos_X_2 + 5, $Pos_Y + 184, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_QualifyWeatherProgression = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 181, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_FuelUsageType")

	GUICtrlCreateLabel("Race Date Year:", $Pos_X_2 + 5, $Pos_Y + 207, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceDateYear = GUICtrlCreateInput("", $Pos_X_2 + 200, $Pos_Y + 204, 165, 20)
	;Global $Wert_RaceDateYear = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 204, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_PenaltiesType")

	GUICtrlCreateLabel("Race Date Month:", $Pos_X_2 + 5, $Pos_Y + 230, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceDateMonth = GUICtrlCreateInput("", $Pos_X_2 + 200, $Pos_Y + 227, 165, 20)
	;Global $Wert_RaceDateMonth = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 227, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("Race Date Day:", $Pos_X_2 + 5, $Pos_Y + 253, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceDateDay = GUICtrlCreateInput("", $Pos_X_2 + 200, $Pos_Y + 250, 165, 20)
	;Global $Wert_RaceDateDay = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 250, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("Race Date Hour:", $Pos_X_2 + 5, $Pos_Y + 276, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceDateHour = GUICtrlCreateInput("", $Pos_X_2 + 200, $Pos_Y + 274, 165, 20)
	;Global $Wert_RaceDateHour = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 274, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("Race Date Progression:", $Pos_X_2 + 5, $Pos_Y + 299, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceDateProgression = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 296, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("Race Weather Progression:", $Pos_X_2 + 5, $Pos_Y + 322, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceWeatherProgression = GUICtrlCreateCombo("", $Pos_X_2 + 200, $Pos_Y + 319, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")
	#endregion


	#Region X 3

	GUICtrlCreateLabel("PracticeWeatherSlots:", $Pos_X_3 + 5, $Pos_Y, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_PracticeWeatherSlots = GUICtrlCreateInput("", $Pos_X_3 + 200, $Pos_Y - 3, 165, 20)
	Global $Wert_UpDpwn_PracticeWeatherSlots = GUICtrlCreateUpdown($Wert_PracticeWeatherSlots)
	;Global $Wert_PracticeWeatherSlots = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y - 3, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("PracticeWeatherSlot1:", $Pos_X_3 + 5, $Pos_Y + 23, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_PracticeWeatherSlot1 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 20, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("PracticeWeatherSlot2:", $Pos_X_3 + 5, $Pos_Y + 46, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_PracticeWeatherSlot2 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 43, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("PracticeWeatherSlot3:", $Pos_X_3 + 5, $Pos_Y + 69, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_PracticeWeatherSlot3 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 66, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_persist_index")

	GUICtrlCreateLabel("PracticeWeatherSlot4:", $Pos_X_3 + 5, $Pos_Y + 92, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	;Global $Wert_PracticeWeatherSlot4 = GUICtrlCreateInput($Value_Flags, $Pos_X_3 + 200, $Pos_Y + 89, 165, 20)
	Global $Wert_PracticeWeatherSlot4 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 89, 165, 20)

	GUICtrlCreateLabel("QualifyWeatherSlots:", $Pos_X_3 + 5, $Pos_Y + 115, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_QualifyWeatherSlots = GUICtrlCreateInput("", $Pos_X_3 + 200, $Pos_Y + 112, 165, 20)
	Global $Wert_UpDpwn_QualifyWeatherSlots = GUICtrlCreateUpdown($Wert_QualifyWeatherSlots)

	GUICtrlCreateLabel("QualifyWeatherSlot1:", $Pos_X_3 + 5, $Pos_Y + 138, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_QualifyWeatherSlot1 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 135, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_DamageType")

	GUICtrlCreateLabel("QualifyWeatherSlot2:", $Pos_X_3 + 5, $Pos_Y + 161, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_QualifyWeatherSlot2 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 158, 165, 55)
	;GUICtrlSetOnEvent(-1, "_Wert_TireWearType")

	GUICtrlCreateLabel("QualifyWeatherSlot3:", $Pos_X_3 + 5, $Pos_Y + 184, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_QualifyWeatherSlot3 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 181, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_FuelUsageType")

	GUICtrlCreateLabel("QualifyWeatherSlot4", $Pos_X_3 + 5, $Pos_Y + 207, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_QualifyWeatherSlot4 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 204, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_PenaltiesType")

	GUICtrlCreateLabel("RaceWeatherSlots", $Pos_X_3 + 5, $Pos_Y + 230, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceWeatherSlots = GUICtrlCreateInput("", $Pos_X_3 + 200, $Pos_Y + 227, 165, 20)
	Global $Wert_UpDpwn_RaceWeatherSlots = GUICtrlCreateUpdown($Wert_RaceWeatherSlots)
	;Global $Wert_RaceWeatherSlots = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 227, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("RaceWeatherSlot1:", $Pos_X_3 + 5, $Pos_Y + 253, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceWeatherSlot1 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 250, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("RaceWeatherSlot2:", $Pos_X_3 + 5, $Pos_Y + 276, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceWeatherSlot2 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 274, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("RaceWeatherSlot3:", $Pos_X_3 + 5, $Pos_Y + 299, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceWeatherSlot3 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 296, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")

	GUICtrlCreateLabel("RaceWeatherSlot4:", $Pos_X_3 + 5, $Pos_Y + 322, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_RaceWeatherSlot4 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 319, 165, 20)
	;GUICtrlSetOnEvent(-1, "_Wert_AllowedViews")
	#endregion





	$Button_ServerControl_Save_3 = GUICtrlCreateButton("Save", $Pos_X_1, 360, 155, 32, $BS_BITMAP)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_ALL_Save_INI")
	$Button_ServerControl_Restart_DS_4 = GUICtrlCreateButton("Save and Restart DS", $Pos_X_1 + 165, 360, 155, 32, $BS_BITMAP)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_Restart_DS_3")
	$Button_ServerControl_Close = GUICtrlCreateButton("Close", $Pos_X_3 + 210, 360, 155, 32, $BS_BITMAP)
	GUICtrlSetOnEvent(-1, "_Close_ServerControl_MoreSettings_GUI")

	_Set_ServerControl_Objects_1()

	GUISetState(@SW_SHOW)

EndFunc

Func _Button_ServerControl_LUA_MoreSettings()
	Global $ServerControl_LUA_MoreSettings_GUI = GUICreate("LUA - More Settings", 755, 400, -1, -1, BitOR($WS_BORDER, $WS_CAPTION, $WS_SYSMENU))
	Local $hMenu = _GUICtrlMenu_GetSystemMenu($ServerControl_LUA_MoreSettings_GUI)
	Local $iMenuItemCount = _GUICtrlMenu_GetItemCount($hMenu)
	_GUICtrlMenu_RemoveMenu($hMenu, $iMenuItemCount - 1, $MF_BYPOSITION)
	HotKeySet("{ESC}", "_Close_ServerControl_MoreSettings_GUI")

	$ProgressBar_2 = GUICtrlCreateProgress(0, 350, 755, 5)

	Local $Pos_X_1 = 5
	Local $Pos_X_2= 380
	Local $Pos_X_3= 380 ; 755
	Local $Pos_Y = 5

	#Region X 1

	GUICtrlCreateLabel("Track:", $Pos_X_1 + 5, $Pos_Y, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Label_Track = GUICtrlCreateLabel("", $Pos_X_1 + 200, $Pos_Y - 3, 175, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	GUICtrlSetColor(-1, "0x0000FF")

	GUICtrlCreateLabel("ABS Allowed:", $Pos_X_1 + 5, $Pos_Y + 23, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_ABS_ALLOWED = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 20, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_ABS_ALLOWED")

	GUICtrlCreateLabel("TCS Allowed:", $Pos_X_1 + 5, $Pos_Y + 46, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_TCS_ALLOWED = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 43, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_TCS_ALLOWED")

	GUICtrlCreateLabel("ManualRollingStarts:", $Pos_X_1 + 5, $Pos_Y + 69, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_ManualRollingStarts = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 66, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_ManualRollingStarts")

	GUICtrlCreateLabel("RaceRollingStart:", $Pos_X_1 + 5, $Pos_Y + 92, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_RaceRollingStart = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 89, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_RaceRollingStart")

	GUICtrlCreateLabel("RaceFormationLap:", $Pos_X_1 + 5, $Pos_Y + 115, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_RaceFormationLap = GUICtrlCreateCombo("", $Pos_X_1 + 200, $Pos_Y + 112, 165, 55)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_RaceFormationLap")

	GUICtrlCreateLabel("PracticeLength:", $Pos_X_1 + 5, $Pos_Y + 138, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_PracticeLength = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 135, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_PracticeLength")

	GUICtrlCreateLabel("PracticeDateHour:", $Pos_X_1 + 5, $Pos_Y + 161, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_PracticeDateHour = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 158, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_PracticeDateHour")

	GUICtrlCreateLabel("QualifyLength:", $Pos_X_1 + 5, $Pos_Y + 184, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_QualifyLength = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 181, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_QualifyLength")

	GUICtrlCreateLabel("QualifyDateHour:", $Pos_X_1 + 5, $Pos_Y + 207, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_QualifyDateHour = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 204, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_QualifyDateHour")

	GUICtrlCreateLabel("RaceLength:", $Pos_X_1 + 5, $Pos_Y + 230, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_RaceLength = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 227, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_RaceLength")

	GUICtrlCreateLabel("RaceDateYear:", $Pos_X_1 + 5, $Pos_Y + 253, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_RaceDateYear = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 250, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_RaceDateYear")

	GUICtrlCreateLabel("RaceDateMonth:", $Pos_X_1 + 5, $Pos_Y + 276, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_RaceDateMonth = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 274, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_RaceDateMonth")

	GUICtrlCreateLabel("RaceDateDay:", $Pos_X_1 + 5, $Pos_Y + 299, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_RaceDateDay = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 296, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_RaceDateDay")

	GUICtrlCreateLabel("RaceDateHour:", $Pos_X_1 + 5, $Pos_Y + 322, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_Combo_RaceDateHour = GUICtrlCreateInput("", $Pos_X_1 + 200, $Pos_Y + 319, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_Combo_RaceDateHour")
	#endregion



	#Region X 3

	GUICtrlCreateLabel("PracticeWeatherSlots:", $Pos_X_3 + 5, $Pos_Y, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_PracticeWeatherSlots = GUICtrlCreateInput("", $Pos_X_3 + 200, $Pos_Y - 3, 165, 20)
	Global $LUA_UpDpwn_PracticeWeatherSlots = GUICtrlCreateUpdown($LUA_PracticeWeatherSlots)
	GUICtrlSetOnEvent(-1, "_LUA_UpDpwn_PracticeWeatherSlots")

	GUICtrlCreateLabel("PracticeWeatherSlot1:", $Pos_X_3 + 5, $Pos_Y + 23, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_PracticeWeatherSlot1 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 20, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_PracticeWeatherSlot1")

	GUICtrlCreateLabel("PracticeWeatherSlot2:", $Pos_X_3 + 5, $Pos_Y + 46, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_PracticeWeatherSlot2 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 43, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_PracticeWeatherSlot2")

	GUICtrlCreateLabel("PracticeWeatherSlot3:", $Pos_X_3 + 5, $Pos_Y + 69, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_PracticeWeatherSlot3 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 66, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_PracticeWeatherSlot3")

	GUICtrlCreateLabel("PracticeWeatherSlot4:", $Pos_X_3 + 5, $Pos_Y + 92, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_PracticeWeatherSlot4 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 89, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_PracticeWeatherSlot4")

	GUICtrlCreateLabel("QualifyWeatherSlots:", $Pos_X_3 + 5, $Pos_Y + 115, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_QualifyWeatherSlots = GUICtrlCreateInput("", $Pos_X_3 + 200, $Pos_Y + 112, 165, 20)
	Global $LUA_UpDpwn_QualifyWeatherSlots = GUICtrlCreateUpdown($LUA_QualifyWeatherSlots)
	GUICtrlSetOnEvent(-1, "_LUA_UpDpwn_QualifyWeatherSlots")

	GUICtrlCreateLabel("QualifyWeatherSlot1:", $Pos_X_3 + 5, $Pos_Y + 138, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_QualifyWeatherSlot1 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 135, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_QualifyWeatherSlot1")

	GUICtrlCreateLabel("QualifyWeatherSlot2:", $Pos_X_3 + 5, $Pos_Y + 161, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_QualifyWeatherSlot2 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 158, 165, 55)
	GUICtrlSetOnEvent(-1, "_LUA_QualifyWeatherSlot2")

	GUICtrlCreateLabel("QualifyWeatherSlot3:", $Pos_X_3 + 5, $Pos_Y + 184, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_QualifyWeatherSlot3 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 181, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_QualifyWeatherSlot3")

	GUICtrlCreateLabel("QualifyWeatherSlot4", $Pos_X_3 + 5, $Pos_Y + 207, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_QualifyWeatherSlot4 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 204, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_QualifyWeatherSlot4")

	GUICtrlCreateLabel("RaceWeatherSlots", $Pos_X_3 + 5, $Pos_Y + 230, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_RaceWeatherSlots = GUICtrlCreateInput("", $Pos_X_3 + 200, $Pos_Y + 227, 165, 20)
	Global $LUA_UpDpwn_RaceWeatherSlots = GUICtrlCreateUpdown($LUA_RaceWeatherSlots)
	GUICtrlSetOnEvent(-1, "_LUA_UpDpwn_RaceWeatherSlots")

	GUICtrlCreateLabel("RaceWeatherSlot1:", $Pos_X_3 + 5, $Pos_Y + 253, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_RaceWeatherSlot1 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 250, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_RaceWeatherSlot1")

	GUICtrlCreateLabel("RaceWeatherSlot2:", $Pos_X_3 + 5, $Pos_Y + 276, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_RaceWeatherSlot2 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 274, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_RaceWeatherSlot2")

	GUICtrlCreateLabel("RaceWeatherSlot3:", $Pos_X_3 + 5, $Pos_Y + 299, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_RaceWeatherSlot3 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 296, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_RaceWeatherSlot3")

	GUICtrlCreateLabel("RaceWeatherSlot4:", $Pos_X_3 + 5, $Pos_Y + 322, 195, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $LUA_RaceWeatherSlot4 = GUICtrlCreateCombo("", $Pos_X_3 + 200, $Pos_Y + 319, 165, 20)
	GUICtrlSetOnEvent(-1, "_LUA_RaceWeatherSlot4")
	#endregion





	$Button_ServerControl_Save_3 = GUICtrlCreateButton("Save", $Pos_X_1 + 5, 360, 155, 32, $BS_BITMAP)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_Save_2")
	$Button_ServerControl_Restart_DS_4 = GUICtrlCreateButton("Save and Restart DS", $Pos_X_1 + 170, 360, 155, 32, $BS_BITMAP)
	GUICtrlSetOnEvent(-1, "_Button_ServerControl_Restart_DS_4")
	$Button_ServerControl_Close = GUICtrlCreateButton("Close", $Pos_X_3 + 210, 360, 155, 32, $BS_BITMAP)
	GUICtrlSetOnEvent(-1, "_Close_ServerControl_LUA_MoreSettings_GUI")

	_Set_ServerControl_Objects_2()

	GUISetState(@SW_SHOW)

EndFunc


Func _Close_ServerControl_MoreSettings_GUI()
	GUIDelete($ServerControl_MoreSettings_GUI)
EndFunc

Func _Close_ServerControl_LUA_MoreSettings_GUI()
	GUIDelete($ServerControl_LUA_MoreSettings_GUI)
EndFunc


Func _Button_ServerControl_Set_Defaults_1()
	FileDelete($Dedi_Installations_Verzeichnis & "server.cfg")
	Local $Result = FileCopy($install_dir & "Templates\config\" & "server.cfg", $Dedi_Installations_Verzeichnis & "server.cfg", $FC_OVERWRITE)
	If $Result = 1 Then
		MsgBox(0 + $MB_ICONINFORMATION, "Successful", "Default values of config.ini File successfully restored.")
	Else
		MsgBox(0 + $MB_ICONWARNING, "Failure", "Failure." & @CRLF & "The default values of config.ini File were not restored.")
	EndIf
	_Restart_PCDSG_RaceControl()
EndFunc

Func _Button_ServerControl_Restore_1()
	FileDelete($Dedi_Installations_Verzeichnis & "server.cfg")
	Local $Result = FileCopy($Backup_dir & "server.cfg", $Dedi_Installations_Verzeichnis & "server.cfg", $FC_OVERWRITE)
	If $Result = 1 Then
		MsgBox(0 + $MB_ICONINFORMATION, "Successful", "Backup of config.ini File successfully restored.")
	Else
		MsgBox(0 + $MB_ICONWARNING, "Failure", "Failure." & @CRLF & "Backup of config.ini File was not restored.")
	EndIf
	_Restart_PCDSG_RaceControl()
EndFunc


Func _Button_ServerControl_Set_Defaults_2()
	DirRemove($Dedi_Installations_Verzeichnis & "\lua\", 1)
	DirRemove($Dedi_Installations_Verzeichnis & "\lua_config\", 1)
	Local $Result_1 = DirCopy($install_dir & "Templates\" & "lua\", $Dedi_Installations_Verzeichnis & "lua\", $FC_OVERWRITE)
	Local $Result_2 = DirCopy($install_dir & "Templates\" & "lua_config\", $Dedi_Installations_Verzeichnis & "lua_config\", $FC_OVERWRITE)
	If $Result_1 = 1 Or $Result_2 = 1 Then
		MsgBox(0 + $MB_ICONINFORMATION, "Successful", "Default values of the lua Files successfully restored.")
	Else
		MsgBox(0 + $MB_ICONWARNING, "Failure", "Failure." & @CRLF & "The default values of the lua Files were not restored.")
	EndIf
	_Restart_PCDSG_RaceControl()
EndFunc


Func _Button_ServerControl_Restore_Backup_2()
	FileDelete($Dedi_Installations_Verzeichnis & "lua_config\sms_rotate_config.json")
	Local $Result = FileCopy($Backup_dir & "lua_config\sms_rotate_config.json", $Dedi_Installations_Verzeichnis & "lua_config\sms_rotate_config.json", $FC_OVERWRITE)
	If $Result = 1 Then
		MsgBox(0 + $MB_ICONINFORMATION, "Successful", "Backup of sms_rotate_config.json File successfully restored.")
	Else
		MsgBox(0 + $MB_ICONWARNING, "Failure", "Failure." & @CRLF & "Backup of sms_rotate_config.json File was not restored.")
	EndIf
	_Restart_PCDSG_RaceControl()
EndFunc






Func _Combo_VehicleClassId()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($Combo_VehicleClassId)

	Local $Known_Class_1 = "GT1"
	Local $Known_Class_2 = "GT3"
	Local $Known_Class_3 = "GT4"
	Local $Known_Class_4 = "GTE"
	Local $Known_Class_5 = "LMP1"
	Local $Known_Class_6 = "LMP2"
	Local $Known_Class_7 = "LMP3"
	Local $Known_Class_8 = "LMP900"
	Local $Known_Class_9 = "Touring Car"
	Local $Known_Class_10 = "TC1"
	Local $Known_Class_11 = "Group A"

	Local $Known_Class_Exists_1 = ""

	If $Value_Temp = $Known_Class_1 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_2 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_3 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_4 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_5 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_6 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_7 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_8 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_9 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_10 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_11 Then $Known_Class_Exists_1 = "true"

	If $Known_Class_Exists_1 <> "true" Then
		IniWrite($config_ini, "TEMP", "Check_VehicleClassName", $Value_Temp)
		_Get_ID_from_VehicleClassesList_TXT()
		$Value_Temp = IniRead($config_ini, "TEMP", "Check_VehicleClassID", "")
	EndIf

	;MsgBox(0, "$Value_Temp", $Value_Temp)

	If $Value_Temp_Nr = 0 Then
		IniWrite($RC_LUA_Settings_ini_File, "Settings", "VehicleClassId", $Value_Temp)
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "VehicleClassId", $Value_Temp)
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "VehicleClassId", $Value_Temp)
	EndIf
EndFunc

Func _UpDpwn_NR_of_MultiClassSlots()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($Wert_NR_MultiClassSlots)


	If $Value_Temp_Nr = 0 Then
		IniWrite($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlots", $Value_Temp)
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "MultiClassSlots", $Value_Temp)
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "MultiClassSlots", $Value_Temp)
	EndIf
EndFunc

Func _Combo_VehicleClassId_Slot_1()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($Combo_VehicleClassId_Slot_1)

	Local $Known_Class_1 = "GT1"
	Local $Known_Class_2 = "GT3"
	Local $Known_Class_3 = "GT4"
	Local $Known_Class_4 = "GTE"
	Local $Known_Class_5 = "LMP1"
	Local $Known_Class_6 = "LMP2"
	Local $Known_Class_7 = "LMP3"
	Local $Known_Class_8 = "LMP900"
	Local $Known_Class_9 = "Touring Car"
	Local $Known_Class_10 = "TC1"
	Local $Known_Class_11 = "Group A"

	Local $Known_Class_Exists_1 = ""

	If $Value_Temp = $Known_Class_1 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_2 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_3 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_4 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_5 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_6 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_7 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_8 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_9 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_10 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_11 Then $Known_Class_Exists_1 = "true"

	If $Known_Class_Exists_1 <> "true" Then
		IniWrite($config_ini, "TEMP", "Check_VehicleClassName", $Value_Temp)
		_Get_ID_from_VehicleClassesList_TXT()
		$Value_Temp = IniRead($config_ini, "TEMP", "Check_VehicleClassID", "")
	EndIf

	If $Value_Temp_Nr = 0 Then
		IniWrite($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot1", $Value_Temp)
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "MultiClassSlot1", $Value_Temp)
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "MultiClassSlot1", $Value_Temp)
	EndIf
EndFunc

Func _Combo_VehicleClassId_Slot_2()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($Combo_VehicleClassId_Slot_2)

	Local $Known_Class_1 = "GT1"
	Local $Known_Class_2 = "GT3"
	Local $Known_Class_3 = "GT4"
	Local $Known_Class_4 = "GTE"
	Local $Known_Class_5 = "LMP1"
	Local $Known_Class_6 = "LMP2"
	Local $Known_Class_7 = "LMP3"
	Local $Known_Class_8 = "LMP900"
	Local $Known_Class_9 = "Touring Car"
	Local $Known_Class_10 = "TC1"
	Local $Known_Class_11 = "Group A"

	Local $Known_Class_Exists_1 = ""

	If $Value_Temp = $Known_Class_1 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_2 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_3 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_4 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_5 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_6 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_7 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_8 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_9 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_10 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_11 Then $Known_Class_Exists_1 = "true"

	If $Known_Class_Exists_1 <> "true" Then
		IniWrite($config_ini, "TEMP", "Check_VehicleClassName", $Value_Temp)
		_Get_ID_from_VehicleClassesList_TXT()
		$Value_Temp = IniRead($config_ini, "TEMP", "Check_VehicleClassID", "")
	EndIf

	If $Value_Temp_Nr = 0 Then
		IniWrite($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot2", $Value_Temp)
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "MultiClassSlot2", $Value_Temp)
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "MultiClassSlot2", $Value_Temp)
	EndIf
EndFunc

Func _Combo_VehicleClassId_Slot_3()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($Combo_VehicleClassId_Slot_3)

	Local $Known_Class_1 = "GT1"
	Local $Known_Class_2 = "GT3"
	Local $Known_Class_3 = "GT4"
	Local $Known_Class_4 = "GTE"
	Local $Known_Class_5 = "LMP1"
	Local $Known_Class_6 = "LMP2"
	Local $Known_Class_7 = "LMP3"
	Local $Known_Class_8 = "LMP900"
	Local $Known_Class_9 = "Touring Car"
	Local $Known_Class_10 = "TC1"
	Local $Known_Class_11 = "Group A"

	Local $Known_Class_Exists_1 = ""

	If $Value_Temp = $Known_Class_1 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_2 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_3 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_4 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_5 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_6 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_7 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_8 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_9 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_10 Then $Known_Class_Exists_1 = "true"
	If $Value_Temp = $Known_Class_11 Then $Known_Class_Exists_1 = "true"

	If $Known_Class_Exists_1 <> "true" Then
		IniWrite($config_ini, "TEMP", "Check_VehicleClassName", $Value_Temp)
		_Get_ID_from_VehicleClassesList_TXT()
		$Value_Temp = IniRead($config_ini, "TEMP", "Check_VehicleClassID", "")
	EndIf

	If $Value_Temp_Nr = 0 Then
		IniWrite($RC_LUA_Settings_ini_File, "Settings", "MultiClassSlot3", $Value_Temp)
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "MultiClassSlot3", $Value_Temp)
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "MultiClassSlot3", $Value_Temp)
	EndIf
EndFunc


#Region LUA_MoreSettings_GUI_Functions
Func _LUA_Combo_ABS_ALLOWED()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_ABS_ALLOWED)

	;MsgBox(0, "_LUA_Combo_ABS_ALLOWED", $Value_Temp)

	If $Value_Temp = "true" Then
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "Flags", "ABS_ALLOWED")
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "Flags", "ABS_ALLOWED")
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "Flags", "")
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "Flags", "")
	EndIf
EndFunc

Func _LUA_Combo_TCS_ALLOWED()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_TCS_ALLOWED)

	;MsgBox(0, "_LUA_Combo_TCS_ALLOWED", $Value_Temp)

	If $Value_Temp = "true" Then
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RemoveFlags", "TCS_ALLOWED")
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RemoveFlags", "TCS_ALLOWED")
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RemoveFlags", "")
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RemoveFlags", "")
	EndIf
EndFunc

Func _LUA_Combo_ManualRollingStarts()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_ManualRollingStarts)

	;MsgBox(0, "_LUA_Combo_ManualRollingStarts", $Value_Temp)

	If $Value_Temp = "true" Then
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "ManualRollingStarts", "1")
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "ManualRollingStarts", "1")
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "ManualRollingStarts", "0")
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "ManualRollingStarts", "0")
	EndIf
EndFunc

Func _LUA_Combo_RaceRollingStart()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_RaceRollingStart)

	;MsgBox(0, "_LUA_Combo_RaceRollingStart", $Value_Temp)

	If $Value_Temp = "true" Then
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceRollingStart", "1")
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceRollingStart", "1")
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceRollingStart", "0")
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceRollingStart", "0")
	EndIf
EndFunc

Func _LUA_Combo_RaceFormationLap()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_RaceFormationLap)

	;MsgBox(0, "_LUA_Combo_RaceFormationLap", $Value_Temp)

	If $Value_Temp = "true" Then
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceFormationLap", "1")
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceFormationLap", "1")
	Else
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceFormationLap", "0")
		IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceFormationLap", "0")
	EndIf
EndFunc

Func _LUA_Combo_PracticeLength()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_PracticeLength)

	;MsgBox(0, "_LUA_Combo_PracticeLength", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeLength", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "PracticeLength", $Value_Temp)
EndFunc

Func _LUA_Combo_PracticeDateHour()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_PracticeDateHour)

	;MsgBox(0, "_LUA_Combo_PracticeDateHour", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeDateHour", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "PracticeDateHour", $Value_Temp)
EndFunc

Func _LUA_Combo_QualifyLength()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_QualifyLength)

	;MsgBox(0, "_LUA_Combo_QualifyLength", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyLength", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "QualifyLength", $Value_Temp)
EndFunc

Func _LUA_Combo_QualifyDateHour()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_QualifyDateHour)

	;MsgBox(0, "_LUA_Combo_QualifyDateHour", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyDateHour", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "QualifyDateHour", $Value_Temp)
EndFunc

Func _LUA_Combo_RaceLength()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_RaceLength)

	;MsgBox(0, "_LUA_Combo_RaceLength", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceLength", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceLength", $Value_Temp)
EndFunc

Func _LUA_Combo_RaceDateYear()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_RaceDateYear)

	;MsgBox(0, "_LUA_Combo_RaceDateYear", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceDateYear", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceDateYear", $Value_Temp)
EndFunc

Func _LUA_Combo_RaceDateMonth()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_RaceDateMonth)

	;MsgBox(0, "_LUA_Combo_RaceDateMonth", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceDateMonth", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceDateMonth", $Value_Temp)
EndFunc

Func _LUA_Combo_RaceDateDay()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_RaceDateDay)

	;MsgBox(0, "_LUA_Combo_RaceDateDay", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceDateDay", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceDateDay", $Value_Temp)
EndFunc

Func _LUA_Combo_RaceDateHour()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_Combo_RaceDateHour)

	;MsgBox(0, "_LUA_Combo_RaceDateHour", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceDateHour", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceDateHour", $Value_Temp)
EndFunc

Func _LUA_UpDpwn_PracticeWeatherSlots()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_PracticeWeatherSlots)

	If $Value_Temp < 1 Then
		$Value_Temp = 1
		GUICtrlSetData($LUA_PracticeWeatherSlots, $Value_Temp)
	EndIf

	If Int($Value_Temp) > Int(4) Then
		$Value_Temp = 4
		GUICtrlSetData($LUA_PracticeWeatherSlots, $Value_Temp)
	EndIf

	;MsgBox(0, "_LUA_UpDpwn_PracticeWeatherSlots", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeWeatherSlots", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "PracticeWeatherSlots", $Value_Temp)
EndFunc

Func _LUA_PracticeWeatherSlot1()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_PracticeWeatherSlot1)

	;MsgBox(0, "_LUA_PracticeWeatherSlot1", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeWeatherSlot1", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "PracticeWeatherSlot1", $Value_Temp)
EndFunc

Func _LUA_PracticeWeatherSlot2()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_PracticeWeatherSlot2)

	;MsgBox(0, "_LUA_PracticeWeatherSlot2", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeWeatherSlot2", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "PracticeWeatherSlot2", $Value_Temp)
EndFunc

Func _LUA_PracticeWeatherSlot3()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_PracticeWeatherSlot3)

	;MsgBox(0, "_LUA_PracticeWeatherSlot3", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeWeatherSlot3", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "PracticeWeatherSlot3", $Value_Temp)
EndFunc

Func _LUA_PracticeWeatherSlot4()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_PracticeWeatherSlot4)

	;MsgBox(0, "_LUA_PracticeWeatherSlot4", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "PracticeWeatherSlot4", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "PracticeWeatherSlot4", $Value_Temp)
EndFunc

Func _LUA_UpDpwn_QualifyWeatherSlots()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_QualifyWeatherSlots)

	If $Value_Temp < 1 Then
		$Value_Temp = 1
		GUICtrlSetData($LUA_PracticeWeatherSlots, $Value_Temp)
	EndIf

	If Int($Value_Temp) > Int(4) Then
		$Value_Temp = 4
		GUICtrlSetData($LUA_PracticeWeatherSlots, $Value_Temp)
	EndIf

	;MsgBox(0, "_LUA_UpDpwn_QualifyWeatherSlots", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyWeatherSlots", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "QualifyWeatherSlots", $Value_Temp)
EndFunc

Func _LUA_QualifyWeatherSlot1()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_QualifyWeatherSlot1)

	;MsgBox(0, "_LUA_QualifyWeatherSlot1", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyWeatherSlot1", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "QualifyWeatherSlot1", $Value_Temp)
EndFunc

Func _LUA_QualifyWeatherSlot2()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_QualifyWeatherSlot2)

	;MsgBox(0, "_LUA_QualifyWeatherSlot2", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyWeatherSlot2", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "QualifyWeatherSlot2", $Value_Temp)
EndFunc

Func _LUA_QualifyWeatherSlot3()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_QualifyWeatherSlot3)

	;MsgBox(0, "_LUA_QualifyWeatherSlot3", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyWeatherSlot3", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "QualifyWeatherSlot3", $Value_Temp)
EndFunc

Func _LUA_QualifyWeatherSlot4()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_QualifyWeatherSlot4)

	;MsgBox(0, "_LUA_QualifyWeatherSlot4", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "QualifyWeatherSlot4", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "QualifyWeatherSlot4", $Value_Temp)
EndFunc

Func _LUA_UpDpwn_RaceWeatherSlots()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_RaceWeatherSlots)

	If $Value_Temp < 1 Then
		$Value_Temp = 1
		GUICtrlSetData($LUA_PracticeWeatherSlots, $Value_Temp)
	EndIf

	If Int($Value_Temp) > Int(4) Then
		$Value_Temp = 4
		GUICtrlSetData($LUA_PracticeWeatherSlots, $Value_Temp)
	EndIf

	;MsgBox(0, "_LUA_UpDpwn_RaceWeatherSlots", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceWeatherSlots", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceWeatherSlots", $Value_Temp)
EndFunc

Func _LUA_RaceWeatherSlot1()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_RaceWeatherSlot1)

	;MsgBox(0, "_LUA_RaceWeatherSlot1", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceWeatherSlot1", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceWeatherSlot1", $Value_Temp)
EndFunc

Func _LUA_RaceWeatherSlot2()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_RaceWeatherSlot2)

	;MsgBox(0, "_LUA_RaceWeatherSlot2", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceWeatherSlot2", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceWeatherSlot2", $Value_Temp)
EndFunc

Func _LUA_RaceWeatherSlot3()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_RaceWeatherSlot3)

	;MsgBox(0, "_LUA_RaceWeatherSlot3", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceWeatherSlot3", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceWeatherSlot3", $Value_Temp)
EndFunc

Func _LUA_RaceWeatherSlot4()
	Local $Value_Temp_Nr = GUICtrlRead($Wert_Track_Nr)
	Local $Value_Temp_Name = GUICtrlRead($Combo_TRACK_2)
	Local $Value_Temp = GUICtrlRead($LUA_RaceWeatherSlot4)

	;MsgBox(0, "_LUA_RaceWeatherSlot4", $Value_Temp)

	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Nr, "RaceWeatherSlot4", $Value_Temp)
	IniWrite($RC_LUA_Settings_ini_File, "Track_" & $Value_Temp_Name, "RaceWeatherSlot4", $Value_Temp)
EndFunc

#EndRegion LUA_MoreSettings_GUI_Functions



Func _Restart_DS() ; LOCAL
	WinClose($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe")
	ProcessClose("DedicatedServerCmd.exe")
	Sleep(3000)
	ShellExecute($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe", "", $Dedi_Installations_Verzeichnis, "")
EndFunc

Func _Restart_DS_Remote() ; REMOTE
	$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/restart'
	$download = InetGet($URL, @ScriptDir & "\Restart.txt", 16, 0)

	If FileExists(@ScriptDir & "\Restart.txt") Then
		Local $OK_Check = FileReadLine(@ScriptDir & "\Restart.txt", 2)
		If $OK_Check = '  "result" : "ok"' Then
			MsgBox(0 + $MB_ICONINFORMATION, "Restart", "Restart of Dedicated Server successful.")
			FileDelete(@ScriptDir & "\Restart.txt")
		Else
			MsgBox(0 + $MB_ICONWARNING, "Restart", "Restart of Dedicated Server failed.")
			FileDelete(@ScriptDir & "\Restart.txt")
		EndIf
	EndIf
	_Restart_PCDSG_RaceControl()
EndFunc

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


Func _NotDoneYet()
	MsgBox(0, "_NotDoneYet", "_NotDoneYet")
EndFunc


Func _Get_ID_from_VehicleClassesList_TXT()
	Local $Check_VehicleClassName = IniRead($config_ini, "TEMP", "Check_VehicleClassName", "")
	IniWrite($config_ini, "TEMP", "Check_VehicleClassID", "")

	If $Check_VehicleClassName <> "" Then
		Local $NR_Lines = _FileCountLines($VehicleClassesList_TXT)

		For $Loop = 6 To $NR_Lines Step 4
			$Value = FileReadLine($VehicleClassesList_TXT, $Loop)
			$Value = StringReplace($Value, '      "name" : "', '')
			$Value = StringReplace($Value, '"', '')
			$Value = StringReplace($Value, ',', '')
			$Value = StringReplace($Value, '}', '')
			;MsgBox(0, "1", $Value)

			If $Value = $Check_VehicleClassName Then
				$Value = FileReadLine($VehicleClassesList_TXT, $Loop - 1)
				$Value = StringReplace($Value, '      "value" : ', '')
				$Value = StringReplace($Value, '"', '')
				$Value = StringReplace($Value, ',', '')
				$Value = StringReplace($Value, '}', '')
				IniWrite($config_ini, "TEMP", "Check_VehicleClassID", $Value)
				IniWrite($config_ini, "TEMP", "Check_VehicleClassName", "")
				;MsgBox(0, "VehicleClass ID", $Value)
				ExitLoop
			EndIf
		Next
	EndIf
EndFunc

Func _Get_Name_from_VehicleClassesList_TXT()
	Local $Check_VehicleClassName = IniRead($config_ini, "TEMP", "Check_VehicleClassID", "")
	IniWrite($config_ini, "TEMP", "Check_VehicleClassName", "")

	If $Check_VehicleClassName <> "" Then
		Local $NR_Lines = _FileCountLines($VehicleClassesList_TXT)

		For $Loop = 5 To $NR_Lines Step 4
			$Value = FileReadLine($VehicleClassesList_TXT, $Loop)
			$Value = StringReplace($Value, '      "value" : ', '')
			$Value = StringReplace($Value, '"', '')
			$Value = StringReplace($Value, ',', '')
			$Value = StringReplace($Value, '}', '')
			;MsgBox(0, "1", $Value)

			If $Value = $Check_VehicleClassName Then
				$Value = FileReadLine($VehicleClassesList_TXT, $Loop + 1)
				$Value = StringReplace($Value, '      "name" : "', '')
				$Value = StringReplace($Value, '"', '')
				$Value = StringReplace($Value, ',', '')
				$Value = StringReplace($Value, '}', '')
				IniWrite($config_ini, "TEMP", "Check_VehicleClassName", $Value)
				IniWrite($config_ini, "TEMP", "Check_VehicleClassID", "")
				;MsgBox(0, "VehicleClass ID", $Value)
				ExitLoop
			EndIf
		Next
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

Func _GUI_EVENT_CLOSE()
	Exit
EndFunc

Func _Restart_PCDSG_RaceControl()
	If FileExists($System_Dir & "RaceControl.exe") Then
		ShellExecute($System_Dir & "RaceControl.exe")
	Else
		ShellExecute($System_Dir & "RaceControl.au3")
	EndIf
	Exit
EndFunc