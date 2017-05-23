#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#include <StaticConstants.au3>
#include <GuiButton.au3>
#include <FontConstants.au3>
#include <File.au3>
#include <GuiStatusBar.au3>
#include <Date.au3>

#include <ColorConstants.au3>


Opt("GUIOnEventMode", 1)

_Main()

Func _Main()
	Global $config_ini = @ScriptDir & "\config.ini"
	Global $install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
	$System_Dir = $install_dir & "system\"
	$Data_Dir = $install_dir & "data\"
	$Sprachdatei = IniRead($config_ini,"Einstellungen", "Sprachdatei", "")
	Global $Members_Data_INI = $System_Dir & "Members_Data.ini"
	Global $Server_Data_INI = $System_Dir & "Server_Data.ini"
	$LFS_DCon_Fenster_Name = IniRead($config_ini, "Einstellungen", "LFS_DCon_Fenster_Name", "")

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


	Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"



	$font_arial = "arial"
	$gfx = (@ScriptDir & "\" & "gfx\")

	Global $GUI_3
	Global $Statusbar, $Statusbar_simple, $Anzeige_Fortschrittbalken
	Global $Combo_TRACK, $Combo_CAR, $config_ini, $GUI_1, $GUI_2, $Checkbox_Rules_1, $Checkbox_Rules_2, $Checkbox_Rules_3, $Checkbox_Rules_4, $CarList_Array, $TrackList_Array, $Anzahl_Zeilen_server_cfg
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

	$GUI_1 = GUICreate("Race Control", 690, 535, -1, -1) ; 525 & 690

	; PROGRESS
	$Anzeige_Fortschrittbalken = GUICtrlCreateProgress(0, 509, 690, 5)

	$Statusbar = _GUICtrlStatusBar_Create($GUI_1)
	$Statusbar_simple = _GUICtrlStatusBar_SetSimple($Statusbar, True)

	$font_2 = "Arial"


	; GROUP Nachrichten
	GUICtrlCreateGroup("Messages", 5, 5, 165, 245)

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


	GUICtrlCreateGroup("Game - Automatic actions", 5, 385, 165, 120)

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

	$Button_Set_AutomaticMessage_NR = GUICtrlCreateButton("Set / Save NR", 8, 483, 80, 18, $BS_BITMAP)
	$Button_Delete_AutomaticMessage_NR = GUICtrlCreateButton("Empty temp NR", 88, 483, 80, 18, $BS_BITMAP)

	GUICtrlCreateGroup("", -99, -99, 1, 1)


	; GROUP Server Rules
	GUICtrlCreateGroup("Server Rules", 180, 5, 165, 185)

	; Checkboxen
	Global $Checkbox_Rules_1 = GUICtrlCreateCheckbox(" Automatic kick parking cars", 185, 25, 153, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_1", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Checkbox_Rules_2 = GUICtrlCreateCheckbox(" Kick new Blacklisted users", 185, 45, 153, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_2", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Checkbox_Rules_3 = GUICtrlCreateCheckbox(" TrackCut Penalty", 185, 65, 105, 15) ; Penalize track cut
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_3", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Checkbox_Rules_4 = GUICtrlCreateCheckbox(" Impact Penalty", 185, 85, 105, 15) ; Penalize impact
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_4", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Checkbox_Rules_5 = GUICtrlCreateCheckbox(" Activate Points System", 185, 105, 153, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_5", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Checkbox_Rules_6 = GUICtrlCreateCheckbox(" Activate auto. Server MSG", 185, 125, 153, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_6", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Checkbox_Rules_7 = GUICtrlCreateCheckbox(" Activ. Ping Limit", 185, 145, 95, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Rules_7", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
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


	; GROUP Server Penalties / Punishment
	GUICtrlCreateGroup("Penalties / Experience Points", 180, 195, 165, 310)

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

	$Button_Set_SG_Groups = GUICtrlCreateButton("Set / Save", 248, 483, 93, 18, $BS_BITMAP)

	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group


	GUICtrlCreateGroup("Race Results Points", 355, 5, 330, 48)

	; Checkboxen
	Global $Checkbox_Race_Results_Points = GUICtrlCreateCheckbox(" Activate RR Points", 360, 19, 110, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Race_Results_Points", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Checkbox_Checkbox_RRP_Continuous_record = GUICtrlCreateCheckbox(" Continuous record", 360, 34, 110, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_RRP_Continuous_record", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	GUICtrlCreateLabel("NR Races", 490, 13, 60, 20)
	GUICtrlSetFont(-1, 9, $FW_NORMAL, "", $font_2)
	Global $Wert_Input_NR_Races = GUICtrlCreateInput("20", 490, 28, 58, 20)
	GUICtrlSetFont(-1, 9, $FW_NORMAL, "", $font_2)
	Global $Wert_UpDpwn_NR_Races = GUICtrlCreateUpdown($Wert_Input_NR_Races)

	GUICtrlCreateLabel("Current", 555, 13, 60, 20)
	GUICtrlSetFont(-1, 9, $FW_NORMAL, "", $font_2)
	GUICtrlCreateLabel("15", 570, 30, 50, 20)
	GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)


	GUICtrlCreateLabel("Points Table", 605, 13, 70, 20)
	GUICtrlSetFont(-1, 9, $FW_NORMAL, "", $font_2)

	$Button_Edit_PointsTable = GUICtrlCreateButton("Edit", 604, 30, 34, 18, $BS_BITMAP)
	GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)

	$Button_Edit_PointsTable = GUICtrlCreateButton("New", 641, 30, 34, 18, $BS_BITMAP)
	GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)

	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group


	; GROUP Server / Game Control
	GUICtrlCreateGroup("Game Control [1] (only in Lobby)", 355, 62, 165, 448)

	_Werte_Server_CFG_Read()

	$Combo_CAR = GUICtrlCreateCombo("", 360, 80, 155, 55)
	_CAR_DropDown()
	$Combo_TRACK = GUICtrlCreateCombo("", 360, 105, 155, 55)
	_TRACK_DropDown()

	Global $Checkbox_RC_Training_1 = GUICtrlCreateCheckbox(" Training 1", 360, 135, 70, 15)
		If $Wert_Practice1Length_Standard > 0 Then GUICtrlSetState(-1, $GUI_CHECKED)

	Global $Checkbox_RC_Training_2 = GUICtrlCreateCheckbox(" Training 2", 360, 160, 70, 15)
		If $Wert_Practice2Length_Standard > 0 Then GUICtrlSetState(-1, $GUI_CHECKED)

	Global $Checkbox_RC_Qualifying = GUICtrlCreateCheckbox(" Qualifying", 360, 186, 70, 15)
		If $Wert_QualifyLength_Standard > 0 Then GUICtrlSetState(-1, $GUI_CHECKED)

	Global $Checkbox_RC_WarmUp = GUICtrlCreateCheckbox(" WarmUp", 360, 212, 70, 15)
		;GUICtrlSetState(-1, $GUI_CHECKED)

	Global $Checkbox_RC_Race_1 = GUICtrlCreateCheckbox(" Race 1", 360, 238, 70, 15)
		If $Wert_Race1Length_Standard > 0 Then GUICtrlSetState(-1, $GUI_CHECKED)

	Global $Checkbox_RC_Race_2 = GUICtrlCreateCheckbox(" Race 2", 360, 264, 70, 15)
		;GUICtrlSetState(-1, $GUI_CHECKED)


	; DopDown Checkbox_RC_Training_1
	Global $Combo_Time_Training_1 = GUICtrlCreateCombo("", 445, 131, 70, 25, $CBS_DROPDOWNLIST) ; 77
	If $Wert_Practice1Length_Standard < 10 Then $Wert_Practice1Length_Standard = "0" & $Wert_Practice1Length_Standard
	GUICtrlSetData(-1, "---------------------" & "|" & "05 minutes|10 minutes|15 minutes|30 minutes|60 minutes|120 minutes", $Wert_Practice1Length_Standard & " minutes")
	GUISetState()

	; DopDown Checkbox_RC_Training_2
	Global $Combo_Time_Training_2 = GUICtrlCreateCombo("", 445, 157, 70, 25, $CBS_DROPDOWNLIST) ; 103
	If $Wert_Practice2Length_Standard < 10 Then $Wert_Practice2Length_Standard = "0" & $Wert_Practice2Length_Standard
	GUICtrlSetData(-1, "---------------------" & "|" & "05 minutes|10 minutes|15 minutes|30 minutes|60 minutes|120 minutes", $Wert_Practice2Length_Standard & " minutes")
	GUISetState()

	; DopDown Checkbox_RC_Qualifying
	Global $Combo_Time_Qualifying = GUICtrlCreateCombo("", 445, 183, 70, 25, $CBS_DROPDOWNLIST) ; 129
	If $Wert_QualifyLength_Standard < 10 Then $Wert_QualifyLength_Standard = "0" & $Wert_QualifyLength_Standard
	GUICtrlSetData(-1, "---------------------" & "|" & "05 minutes|10 minutes|15 minutes|30 minutes|60 minutes|120 minutes", $Wert_QualifyLength_Standard & " minutes")
	GUISetState()

	; DopDown Checkbox_RC_WarmUp
	Global $Combo_Time_WarmUp = GUICtrlCreateCombo("", 445, 209, 70, 25, $CBS_DROPDOWNLIST) ; 155
	GUICtrlSetData(-1, "---------------------" & "|" & "05 minute|10 minutes|15 minutes|30 minutes|60 minutes|120 minutes", "")
	GUISetState()

	; UPDOWN Race 1
	$Wert_UpDown_1 = 5
	Global $Wert_Race_1 = GUICtrlCreateInput($Wert_Race1Length_Standard, 445, 235, 70, 20) ; 181
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	$Wert_UpDpwn_Race1 = GUICtrlCreateUpdown($Wert_Race_1)

	; UPDOWN Race 2
	$Wert_UpDown_2 = 0
	Global $Wert_Race_2 = GUICtrlCreateInput($Wert_UpDown_2, 445, 261, 70, 20) ; 207
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	$Wert_UpDpwn_Race2 = GUICtrlCreateUpdown($Wert_Race_2)



	Global $Checkbox_Random_Car = GUICtrlCreateCheckbox(" Random Vehicle", 360, 415, 155, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Random_CAR", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

	Global $Checkbox_Random_Track = GUICtrlCreateCheckbox(" Random Track", 360, 435, 155, 15)
		If IniRead($config_ini, "Race_Control", "Checkbox_Random_TRACK", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)


	; Set Attributes Button
	$Button_Set_Current_Attributes_1 = GUICtrlCreateButton("Set Attributes", 360, 455, 77, 42, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Set_Current_Attributes_1, $gfx & "RC_Set_Current_Attributes.bmp")
	GUICtrlSetOnEvent(-1, "_Set_Current_Attributes_1")

	$Button_Set_Next_Attributes_1 = GUICtrlCreateButton("Set Attributes", 439, 455, 77, 42, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Set_Next_Attributes_1, $gfx & "RC_Set_Next_Attributes.bmp")
	GUICtrlSetOnEvent(-1, "_Set_Next_Attributes_1")

	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group


	GUICtrlCreateGroup("Game Control [2] (only in Lobby)", 519, 62, 166, 448)

	Global $Checkbox_RCS_ServerControlsTrack = GUICtrlCreateCheckbox(" ServerControlsTrack", 525, 79, 150, 15) ; 25
	Global $Checkbox_RCS_ServerControlsVehicle = GUICtrlCreateCheckbox(" ServerControlsVehicle", 525, 97, 150, 15) ; 43

	GUICtrlCreateLabel("GridSize", 525, 120, 100, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_Input_GridSize = GUICtrlCreateInput("20", 630, 117, 50, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_UpDpwn_GridSize = GUICtrlCreateUpdown($Wert_Input_GridSize)

	GUICtrlCreateLabel("MaxPlayers", 525, 143, 100, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_MaxPlayers = GUICtrlCreateInput("19", 630, 140, 50, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_UpDpwn_MaxPlayers = GUICtrlCreateUpdown($Wert_MaxPlayers)

	GUICtrlCreateLabel("Flags", 525, 166, 100, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_Input_Flags = GUICtrlCreateInput("656616", 630, 163, 50, 20)

	GUICtrlCreateLabel("DamageType", 525, 189, 100, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_DamageType = GUICtrlCreateInput("1", 630, 186, 50, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_UpDpwn_DamageType = GUICtrlCreateUpdown($Wert_DamageType)

	GUICtrlCreateLabel("TireWearType", 525, 212, 100, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_TireWearType = GUICtrlCreateInput("1", 630, 209, 50, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_UpDpwn_TireWearType = GUICtrlCreateUpdown($Wert_TireWearType)

	GUICtrlCreateLabel("FuelUsageType", 525, 235, 100, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_FuelUsageType = GUICtrlCreateInput("1", 630, 232, 50, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_UpDpwn_FuelUsageType = GUICtrlCreateUpdown($Wert_FuelUsageType)

	GUICtrlCreateLabel("PenaltiesType", 525, 258, 100, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_PenaltiesType = GUICtrlCreateInput("1", 630, 255, 50, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_UpDpwn_PenaltiesType = GUICtrlCreateUpdown($Wert_PenaltiesType)

	GUICtrlCreateLabel("AllowedViews", 525, 281, 100, 20) ; 525, 231, 100, 20
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_AllowedViews = GUICtrlCreateInput("1", 630, 278, 50, 20) ; 630, 228, 50, 20
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_UpDpwn_AllowedViews = GUICtrlCreateUpdown($Wert_AllowedViews)


	Global $Checkbox_RCS_DateProgression = GUICtrlCreateCheckbox(" DateProgression", 525, 301, 150, 15)
	Global $Checkbox_RCS_ForecastProgression = GUICtrlCreateCheckbox(" ForecastProgression", 525, 319, 150, 15)

	GUICtrlCreateLabel("WeatherSlots", 525, 340, 100, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_WeatherSlots = GUICtrlCreateInput("1", 615, 338, 65, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_UpDpwn_WeatherSlots = GUICtrlCreateUpdown($Wert_WeatherSlots)

	GUICtrlCreateLabel("WeatherSlot1", 525, 363, 100, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_Input_WeatherSlot1 = GUICtrlCreateInput("-934211870", 615, 361, 65, 20)

	GUICtrlCreateLabel("WeatherSlot2", 525, 386, 100, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_Input_WeatherSlot2 = GUICtrlCreateInput("-934211870", 615, 384, 65, 20)

	GUICtrlCreateLabel("WeatherSlot3", 525, 409, 100, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_Input_WeatherSlot3 = GUICtrlCreateInput("-934211870", 615, 407, 65, 20)

	GUICtrlCreateLabel("WeatherSlot4", 525, 432, 100, 20)
	GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
	Global $Wert_Input_WeatherSlot4 = GUICtrlCreateInput("-934211870", 615, 430, 65, 20)


	; Set Attributes Button
	$Button_Set_Current_Attributes_2 = GUICtrlCreateButton("Set Current Attributes", 525, 455, 77, 42, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Set_Current_Attributes_2, $gfx & "RC_Set_Current_Attributes.bmp")
	GUICtrlSetOnEvent(-1, "_Set_Current_Attributes_2")

	$Button_Set_Next_Attributes_2 = GUICtrlCreateButton("Set Next Attributes", 604, 455, 77, 42, $BS_BITMAP)
	_GUICtrlButton_SetImage($Button_Set_Next_Attributes_2, $gfx & "RC_Set_Next_Attributes.bmp")
	GUICtrlSetOnEvent(-1, "_Set_Next_Attributes_2")

	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group

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

	GUICtrlSetOnEvent($Checkbox_Race_Results_Points, "_Checkbox_Race_Results_Points")
	GUICtrlSetOnEvent($Checkbox_Checkbox_RRP_Continuous_record, "_Checkbox_Checkbox_RRP_Continuous_record")

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
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Nachricht = IniRead($RaceControl_Messages_INI, "Messages", "Wellcome", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht)
EndFunc

Func _Button_Email_Message()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Nachricht = IniRead($RaceControl_Messages_INI, "Messages", "Email", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht)
EndFunc

Func _Button_Problems_Message()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Nachricht = IniRead($RaceControl_Messages_INI, "Messages", "Problems", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht)
EndFunc

Func _Button_Admin_Message()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Nachricht_1 = IniRead($config_ini, "Race_Control", "Message_1", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_1)

	GUIDelete ($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_2()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Nachricht_2 = IniRead($config_ini, "Race_Control", "Message_2", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_2)

	GUIDelete ($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_3()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Nachricht_3 = IniRead($config_ini, "Race_Control", "Message_3", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_3)

	GUIDelete ($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_4()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Nachricht_4 = IniRead($config_ini, "Race_Control", "Message_4", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_4
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_4)

	GUIDelete ($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_5()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Nachricht_5 = IniRead($config_ini, "Race_Control", "Message_5", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_5
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_5)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_6()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Nachricht_6 = IniRead($config_ini, "Race_Control", "Message_6", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_6
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_6)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_7()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Nachricht_7 = IniRead($config_ini, "Race_Control", "Message_7", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_7
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_7)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_8()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Nachricht_8 = IniRead($config_ini, "Race_Control", "Message_8", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_8
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_8)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_9()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Nachricht_9 = IniRead($config_ini, "Race_Control", "Message_9", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_9
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_9)

	GUIDelete($GUI_2)
EndFunc

Func _Race_Control_SM_MenuItem_10()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Nachricht_10 = IniRead($config_ini, "Race_Control", "Message_10", "")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_10
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Nachricht_10)

	GUIDelete($GUI_2)
EndFunc


Func _Race_Control_PM_MenuItem_1()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$Eingabe_Nachricht = InputBox ( "Nachricht eingeben", "Geben Sie die Nachricht ein die Sie absenden möchten.")

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Eingabe_Nachricht
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "PCDSG sends: " & $Eingabe_Nachricht)

	GUIDelete($GUI_2)
EndFunc

Func _Write_Private_Message()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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
	If $Status_Checkbox = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_Race_Results_Points", "true")
	If $Status_Checkbox = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_Race_Results_Points", "false")
EndFunc

Func _Checkbox_Checkbox_RRP_Continuous_record()
	$Status_Checkbox = GUICtrlRead($Checkbox_Checkbox_RRP_Continuous_record)
	If $Status_Checkbox = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_RRP_Continuous_record", "true")
	If $Status_Checkbox = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_RRP_Continuous_record", "false")
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
	If $Status_Checkbox_Rules_3 = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_3", "true")
	If $Status_Checkbox_Rules_3 = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_3", "false")
EndFunc

Func _Checkbox_Rules_4()
	$Status_Checkbox_Rules_4 = GUICtrlRead($Checkbox_Rules_4)
	If $Status_Checkbox_Rules_4 = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_4", "true")
	If $Status_Checkbox_Rules_4 = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_4", "false")
EndFunc

Func _Checkbox_Rules_5()
	$Status_Checkbox_Rules_5 = GUICtrlRead($Checkbox_Rules_5)
	If $Status_Checkbox_Rules_5 = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_5", "true")
	If $Status_Checkbox_Rules_5 = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_5", "false")
EndFunc

Func _Checkbox_Rules_6()
	$Status_Checkbox_Rules_6 = GUICtrlRead($Checkbox_Rules_6)
	If $Status_Checkbox_Rules_6 = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_6", "true")
	If $Status_Checkbox_Rules_6 = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_6", "false")
EndFunc

Func _Checkbox_Rules_7()
	$Status_Checkbox_Rules_7 = GUICtrlRead($Checkbox_Rules_7)
	If $Status_Checkbox_Rules_7 = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_7", "true")
	If $Status_Checkbox_Rules_7 = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_7", "false")
EndFunc

Func _Checkbox_Rules_8()
	$Status_Checkbox_Rules_8 = GUICtrlRead($Checkbox_Rules_8)
	If $Status_Checkbox_Rules_8 = 1 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_8", "true")
	If $Status_Checkbox_Rules_8 = 4 Then IniWrite($config_ini, "Race_Control", "Checkbox_Rules_8", "false")
EndFunc


Func _Button_Server_Strafen_2()
	MsgBox(0, "", "Select the Name in PCarsDSOverview Window and use mouse right click menu.", 4)
EndFunc


Func _Checkbox_Server_Penalties_1()
	$Status_Checkbox_Server_Penalties_1 = GUICtrlRead($Checkbox_Server_Penalties_1)

	If $Status_Checkbox_Server_Penalties_1 = 1 Then
		IniWrite($config_ini, "Race_Control", "Checkbox_Server_Penalties_1", "true")
	EndIf

	If $Status_Checkbox_Server_Penalties_1 = 4 Then
		IniWrite($config_ini, "Race_Control", "Checkbox_Server_Penalties_1", "false")
	EndIf
	EndFunc

Func _Checkbox_Server_Penalties_2()
	$Status_Checkbox_Server_Penalties_2 = GUICtrlRead($Checkbox_Server_Penalties_2)

	If $Status_Checkbox_Server_Penalties_2 = 1 Then
		IniWrite($config_ini, "Race_Control", "Checkbox_Server_Penalties_2", "true")
	EndIf

	If $Status_Checkbox_Server_Penalties_2 = 4 Then
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


Func _Werte_Server_CFG_Read()
	$Anzahl_Zeilen_server_cfg = _FileCountLines($install_dir & "server.cfg")

	$Wert_Car = ""
	$Check_Line_1 = ""
	$Check_Line_2 = ""
	$Wert_TrackId_Standard = ""

	For $Schleife_Server_CFG_Read = 20 To $Anzahl_Zeilen_server_cfg
		$CFG_Line = FileReadLine($install_dir & "server.cfg", $Schleife_Server_CFG_Read)
		$Check_Line = StringSplit($CFG_Line, ':', $STR_ENTIRESPLIT)
		If IsArray($Check_Line) Then $Check_Line_1 = $Check_Line[1]
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

		If $Check_Line_1 = '    "Practice1Length" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_Practice1Length_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "Practice2Length" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_Practice2Length_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "QualifyLength" ' Then
			If $Check_Line_2 <> "" Then Global $Wert_QualifyLength_Standard = $Check_Line_2
		EndIf

		If $Check_Line_1 = '    "Race1Length" ' Then
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


Func _CAR_DropDown()
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
	GUICtrlSetData($Combo_CAR, "Choose CAR" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Car, $Wert_Car_Standard)
	GUISetState()
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

		$Werte_Tack = $Werte_Tack & "|" & $Wert_Track

		If $Wert_Track_ID = $Wert_TrackId_Standard Then $Wert_Track_Standard = $Wert_Track

		If $Durchgang_NR = 1 Then $Werte_Tack = $Wert_Track
	Next

	GUICtrlSetData($Combo_TRACK, "Choose TRACK" & "|" & "----------------------------------------------------------------------" & "|" & $Werte_Tack, $Wert_Track_Standard)
	GUISetState()
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


Func _Set_Current_Attributes_1()

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

			$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
			$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

			If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
			If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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

			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $RC_Attribute_1 & $RC_Attribute_2 & $RC_Attribute_3 & $RC_Attribute_4 & $RC_Attribute_5 & $RC_Attribute_7 & $RC_Attribute_8
			$download = InetGet($URL, @ScriptDir & "\Attributes.txt", 16, 0)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 80)

			$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
			$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

			If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
			If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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

			$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
			$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

			If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
			If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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

			; Server MSG SEt Atributes
			$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
			$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

			If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
			If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

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

			; Server MSG SEt Atributes
			$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
			$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

			If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
			If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

			GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

			$AS_value_1 = GUICtrlRead($Checkbox_RCS_ServerControlsTrack)
				If $AS_value_1 = 1 Then $AS_value_1 = "true"
				If $AS_value_1 = 4 Then $AS_value_1 = "false"
			$AS_value_2 = GUICtrlRead($Checkbox_RCS_ServerControlsVehicle)
				If $AS_value_2 = 1 Then $AS_value_2 = "true"
				If $AS_value_2 = 4 Then $AS_value_2 = "false"
			$AS_value_3 = GUICtrlRead($Wert_Input_GridSize)
			$AS_value_4 = GUICtrlRead($Wert_MaxPlayers)
			$AS_value_5 = GUICtrlRead($Wert_Input_Flags)
			$AS_value_6 = GUICtrlRead($Wert_DamageType)
			$AS_value_7 = GUICtrlRead($Wert_TireWearType)
			$AS_value_8 = GUICtrlRead($Wert_FuelUsageType)
			$AS_value_9 = GUICtrlRead($Wert_PenaltiesType)
			$AS_value_10 = GUICtrlRead($Wert_AllowedViews)
			$AS_value_11 = GUICtrlRead($Wert_Date)
			$AS_value_12 = GUICtrlRead($Wert_Time)
			$AS_value_13 = GUICtrlRead($Checkbox_RCS_DateProgression)
				If $AS_value_13 = 1 Then $AS_value_13 = "true"
				If $AS_value_13 = 4 Then $AS_value_13 = "false"
			$AS_value_14 = GUICtrlRead($Checkbox_RCS_ForecastProgression)
				If $AS_value_14 = 1 Then $AS_value_14 = "true"
				If $AS_value_14 = 4 Then $AS_value_14 = "false"
			$AS_value_15 = GUICtrlRead($Wert_WeatherSlots)
			$AS_value_16 = GUICtrlRead($Wert_Input_WeatherSlot1)
			$AS_value_17 = GUICtrlRead($Wert_Input_WeatherSlot2)
			$AS_value_18 = GUICtrlRead($Wert_Input_WeatherSlot3)
			$AS_value_19 = GUICtrlRead($Wert_Input_WeatherSlot4)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 40)

			$AS_RCS_value_1 = 'ServerControlsTrack=' & $AS_value_1 ;& '&'
			$AS_RCS_value_2 = 'ServerControlsVehicle=' & $AS_value_2 ;& '&'
			$AS_RCS_value_3 = 'GridSize=' & $AS_value_3 ;& '&'
			$AS_RCS_value_4 = 'MaxPlayers=' & $AS_value_4 ;& '&'
			$AS_RCS_value_5 = 'Flags=' & $AS_value_5 ;& '&'
			$AS_RCS_value_6 = 'DamageType=' & $AS_value_6 ;& '&'
			$AS_RCS_value_7 = 'TireWearType=' & $AS_value_7 ;& '&'
			$AS_RCS_value_8 = 'FuelUsageType=' & $AS_value_8 ;& '&'
			$AS_RCS_value_9 = 'PenaltiesType=' & $AS_value_9 ;& '&'
			$AS_RCS_value_10 = 'AllowedViews=' & $AS_value_10 ;& '&'
			$AS_RCS_value_11 = "" ; 'DateYear=' & $AS_value_11 & '&'
			$AS_RCS_value_12 = ""; 'DateHour=' & $AS_value_12 & '&'
			$AS_RCS_value_13 = 'DateProgression=' & $AS_value_13 ;& '&'
			$AS_RCS_value_14 = 'ForecastProgression=' & $AS_value_14 ;& '&'
			$AS_RCS_value_15 = 'WeatherSlots=' & $AS_value_15 ;& '&'
			$AS_RCS_value_16 = 'WeatherSlot1=' & $AS_value_16 ;& '&'
			$AS_RCS_value_17 = 'WeatherSlot2=' & $AS_value_17 ;& '&'
			$AS_RCS_value_18 = 'WeatherSlot3=' & $AS_value_18 ;& '&'
			$AS_RCS_value_19 = 'WeatherSlot4=' & $AS_value_19


			If FileExists(@ScriptDir & "\Attributes_Settings.txt") Then FileDelete(@ScriptDir & "\Attributes_Settings.txt")

			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_1
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_2
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_3
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_4
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_5
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_6
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_7
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_8
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_9
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_10
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_13
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_14
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $AS_RCS_value_15
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
				$Nachricht_4 = "GridSize: " & $AS_value_3
				$Nachricht_5 = "MaxPlayers: " & $AS_value_4
				$Nachricht_6 = "Flags: " & $AS_value_5
				$Nachricht_7 = "DamageType: " & $AS_value_6
				$Nachricht_8 = "TireWearType: " & $AS_value_7
				$Nachricht_9 = "FuelUsageType: " & $AS_value_8
				$Nachricht_10 = "PenaltiesType: " & $AS_value_9
				$Nachricht_11 = "AllowedViews: " & $AS_value_10
				$Nachricht_12 = "DateProgression: " & $AS_value_13
				$Nachricht_13 = "ForecastProgression: " & $AS_value_14
				$Nachricht_14 = "WeatherSlots: " & $AS_value_15
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

				$URL_5 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_4
				$download = InetGet($URL_5, @ScriptDir & "\Message.txt", 16, 0)

				$URL_6 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_5
				$download = InetGet($URL_6, @ScriptDir & "\Message.txt", 16, 0)

				$URL_7 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_6
				$download = InetGet($URL_7, @ScriptDir & "\Message.txt", 16, 0)

				$URL_8 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_7
				$download = InetGet($URL_8, @ScriptDir & "\Message.txt", 16, 0)

				$URL_9 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_8
				$download = InetGet($URL_9, @ScriptDir & "\Message.txt", 16, 0)

				$URL_10 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_9
				$download = InetGet($URL_10, @ScriptDir & "\Message.txt", 16, 0)

				$URL_11 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_10
				$download = InetGet($URL_11, @ScriptDir & "\Message.txt", 16, 0)

				$URL_12 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_11
				$download = InetGet($URL_12, @ScriptDir & "\Message.txt", 16, 0)

				$URL_13 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_12
				$download = InetGet($URL_13, @ScriptDir & "\Message.txt", 16, 0)

				$URL_14 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_13
				$download = InetGet($URL_14, @ScriptDir & "\Message.txt", 16, 0)

				$URL_15 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_14 & ' | ' & $Nachricht_15 & ' | ' & $Nachricht_16 & ' | ' & $Nachricht_17 & ' | ' & $Nachricht_18
				$download = InetGet($URL_15, @ScriptDir & "\Message.txt", 16, 0)


				GUICtrlSetData($Anzeige_Fortschrittbalken, 100)

				_GUICtrlStatusBar_SetText($Statusbar, "Attr. Settings: " & $AS_value_1 & "|" & _
														$AS_value_2 & "|" & $AS_value_3 & "|" & _
														$AS_value_4 & "|" & $AS_value_5 & "|" & _
														$AS_value_6 & "|" & $AS_value_7 & "|" & _
														$AS_value_8 & "|" & $AS_value_9& "|" & _
														$AS_value_10 & "|" & $AS_value_11 & "|" & _
														$AS_value_12 & "|" & $AS_value_13 & "|" & _
														$AS_value_14 & "|" & $AS_value_15 & "|" & _
														$AS_value_16 & "|" & $AS_value_17& "|" & _
														$AS_value_18 & "|" & $AS_value_19)


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

Func _Set_Next_Attributes_2()
	$Check_controlGameSetup = IniRead($config_ini, "Server_Einstellungen", "controlGameSetup", "")
	$Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")

	If $Check_controlGameSetup = "true" Then

		If $Auto_LobbyCheck = "Lobby" Then

			; Server MSG SEt Atributes
			$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
			$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

			If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
			If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

			GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

			$AS_value_1 = GUICtrlRead($Checkbox_RCS_ServerControlsTrack)
				If $AS_value_1 = 1 Then $AS_value_1 = "true"
				If $AS_value_1 = 4 Then $AS_value_1 = "false"
			$AS_value_2 = GUICtrlRead($Checkbox_RCS_ServerControlsVehicle)
				If $AS_value_2 = 1 Then $AS_value_2 = "true"
				If $AS_value_2 = 4 Then $AS_value_2 = "false"
			$AS_value_3 = GUICtrlRead($Wert_Input_GridSize)
			$AS_value_4 = GUICtrlRead($Wert_MaxPlayers)
			$AS_value_5 = GUICtrlRead($Wert_Input_Flags)
			$AS_value_6 = GUICtrlRead($Wert_DamageType)
			$AS_value_7 = GUICtrlRead($Wert_TireWearType)
			$AS_value_8 = GUICtrlRead($Wert_FuelUsageType)
			$AS_value_9 = GUICtrlRead($Wert_PenaltiesType)
			$AS_value_10 = GUICtrlRead($Wert_AllowedViews)
			$AS_value_11 = GUICtrlRead($Wert_Date)
			$AS_value_12 = GUICtrlRead($Wert_Time)
			$AS_value_13 = GUICtrlRead($Checkbox_RCS_DateProgression)
				If $AS_value_13 = 1 Then $AS_value_13 = "true"
				If $AS_value_13 = 4 Then $AS_value_13 = "false"
			$AS_value_14 = GUICtrlRead($Checkbox_RCS_ForecastProgression)
				If $AS_value_14 = 1 Then $AS_value_14 = "true"
				If $AS_value_14 = 4 Then $AS_value_14 = "false"
			$AS_value_15 = GUICtrlRead($Wert_WeatherSlots)
			$AS_value_16 = GUICtrlRead($Wert_Input_WeatherSlot1)
			$AS_value_17 = GUICtrlRead($Wert_Input_WeatherSlot2)
			$AS_value_18 = GUICtrlRead($Wert_Input_WeatherSlot3)
			$AS_value_19 = GUICtrlRead($Wert_Input_WeatherSlot4)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 40)

			$AS_RCS_value_1 = 'ServerControlsTrack=' & $AS_value_1 & '&'
			$AS_RCS_value_2 = 'ServerControlsVehicle=' & $AS_value_2 & '&'
			$AS_RCS_value_3 = 'GridSize=' & $AS_value_3 ;& '&'
			$AS_RCS_value_4 = 'MaxPlayers=' & $AS_value_4 ;& '&'
			$AS_RCS_value_5 = 'Flags=' & $AS_value_5 & '&'
			$AS_RCS_value_6 = 'DamageType=' & $AS_value_6 & '&'
			$AS_RCS_value_7 = 'TireWearType=' & $AS_value_7 & '&'
			$AS_RCS_value_8 = 'FuelUsageType=' & $AS_value_8 & '&'
			$AS_RCS_value_9 = 'PenaltiesType=' & $AS_value_9 & '&'
			$AS_RCS_value_10 = 'AllowedViews=' & $AS_value_10 & '&'
			$AS_RCS_value_11 = "" ; 'DateYear=' & $AS_value_11 & '&'
			$AS_RCS_value_12 = ""; 'DateHour=' & $AS_value_12 & '&'
			$AS_RCS_value_13 = 'DateProgression=' & $AS_value_13 & '&'
			$AS_RCS_value_14 = 'ForecastProgression=' & $AS_value_14 & '&'
			$AS_RCS_value_15 = 'WeatherSlots=' & $AS_value_15 & '&'
			$AS_RCS_value_16 = 'WeatherSlot1=' & $AS_value_16 & '&'
			$AS_RCS_value_17 = 'WeatherSlot2=' & $AS_value_17 & '&'
			$AS_RCS_value_18 = 'WeatherSlot3=' & $AS_value_18 & '&'
			$AS_RCS_value_19 = 'WeatherSlot4=' & $AS_value_19


			If FileExists(@ScriptDir & "\Attributes_Settings.txt") Then FileDelete(@ScriptDir & "\Attributes_Settings.txt")

			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_1
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_2
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_3
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_4
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_5
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_6
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_7
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_8
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_9
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_10
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_13
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_14
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_15
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_16
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_17
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_18
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)
			$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_next_attributes?' & $AS_RCS_value_19
			$download = InetGet($URL, @ScriptDir & "\Attributes_Settings.txt", 16, 0)

			GUICtrlSetData($Anzeige_Fortschrittbalken, 60)

			If FileExists(@ScriptDir & "\Attributes_Settings.txt") Then
				$Nachricht_0 = " "
				$Nachricht_1 = "PCDSG: NEXT Attributes Settings set"
				$Nachricht_2 = "ServerControlsTrack: " & $AS_value_1
				$Nachricht_3 = "ServerControlsVehicle: " & $AS_value_2
				$Nachricht_4 = "GridSize: " & $AS_value_3
				$Nachricht_5 = "MaxPlayers: " & $AS_value_4
				$Nachricht_6 = "Flags: " & $AS_value_5
				$Nachricht_7 = "DamageType: " & $AS_value_6
				$Nachricht_8 = "TireWearType: " & $AS_value_7
				$Nachricht_9 = "FuelUsageType: " & $AS_value_8
				$Nachricht_10 = "PenaltiesType: " & $AS_value_9
				$Nachricht_11 = "AllowedViews: " & $AS_value_10
				$Nachricht_12 = "DateProgression: " & $AS_value_13
				$Nachricht_13 = "ForecastProgression: " & $AS_value_14
				$Nachricht_14 = "WeatherSlots: " & $AS_value_15
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

				$URL_5 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_4
				$download = InetGet($URL_5, @ScriptDir & "\Message.txt", 16, 0)

				$URL_6 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_5
				$download = InetGet($URL_6, @ScriptDir & "\Message.txt", 16, 0)

				$URL_7 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_6
				$download = InetGet($URL_7, @ScriptDir & "\Message.txt", 16, 0)

				$URL_8 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_7
				$download = InetGet($URL_8, @ScriptDir & "\Message.txt", 16, 0)

				$URL_9 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_8
				$download = InetGet($URL_9, @ScriptDir & "\Message.txt", 16, 0)

				$URL_10 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_9
				$download = InetGet($URL_10, @ScriptDir & "\Message.txt", 16, 0)

				$URL_11 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_10
				$download = InetGet($URL_11, @ScriptDir & "\Message.txt", 16, 0)

				$URL_12 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_11
				$download = InetGet($URL_12, @ScriptDir & "\Message.txt", 16, 0)

				$URL_13 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_12
				$download = InetGet($URL_13, @ScriptDir & "\Message.txt", 16, 0)

				$URL_14 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_13
				$download = InetGet($URL_14, @ScriptDir & "\Message.txt", 16, 0)

				$URL_15 = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_14 & ' | ' & $Nachricht_15 & ' | ' & $Nachricht_16 & ' | ' & $Nachricht_17 & ' | ' & $Nachricht_18
				$download = InetGet($URL_15, @ScriptDir & "\Message.txt", 16, 0)

				GUICtrlSetData($Anzeige_Fortschrittbalken, 100)

				_GUICtrlStatusBar_SetText($Statusbar, "Attr. Settings: " & $AS_value_1 & "|" & _
														$AS_value_2 & "|" & $AS_value_3 & "|" & _
														$AS_value_4 & "|" & $AS_value_5 & "|" & _
														$AS_value_6 & "|" & $AS_value_7 & "|" & _
														$AS_value_8 & "|" & $AS_value_9& "|" & _
														$AS_value_10 & "|" & $AS_value_11 & "|" & _
														$AS_value_12 & "|" & $AS_value_13 & "|" & _
														$AS_value_14 & "|" & $AS_value_15 & "|" & _
														$AS_value_16 & "|" & $AS_value_17& "|" & _
														$AS_value_18 & "|" & $AS_value_19)


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

Func _GUI_EVENT_CLOSE()
	Exit
EndFunc

