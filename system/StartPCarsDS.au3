#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\ICONS\PC_Server_starten.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <File.au3>
#include <FTPEx.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <Date.au3>
#include <MsgBoxConstants.au3>
#include <Misc.au3>
#include <GuiStatusBar.au3>
#include <GUIConstantsEx.au3>
#include <GuiButton.au3>
#include <GuiTreeView.au3>
#include <Misc.au3>

#include <Date.au3>


Opt("GUIOnEventMode", 1)

#Region Declare Variables/Const
Global $config_ini = @ScriptDir & "\config.ini"
Global $install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
Global $System_Dir = $install_dir & "system\"
Global $DS_folder = IniRead($config_ini, "Einstellungen", "Dedi_Installations_Verzeichnis", "")
Global $gfx = $System_Dir & "gfx\"
Global $Sprachdatei = IniRead($config_ini,"Einstellungen", "Sprachdatei", "")
Global $Aktuelle_Version = IniRead($config_ini, "Einstellungen", "Version", "")
Global $PCDSG_LOG_ini = $System_Dir & "PCDSG_LOG.ini"

Global $PCDSG_Status_File = $System_Dir & "PCDSG_Status.txt"

Global $status_json = $System_Dir & "status.json"
Global $LOG_Data_json = $System_Dir & "Server_LOG.json"
Global $members_json = $System_Dir & "members.json"
Global $participants_json = $System_Dir & "participants.json"
Global $TrackMap_participants_json = $System_Dir & "TrackMap_participants.json"

Global $Server_Data_INI = $System_Dir & "Server_Data.ini"
Global $Members_Data_INI = $System_Dir & "Members_Data.ini"
Global $Participants_Data_INI = $System_Dir & "Participants_Data.ini"
Global $Participants_Data_INI_TEMP = $System_Dir & "temp\Participants_Data.ini"
Global $Participants_Data_INI_CR_1 = $System_Dir & "temp\Participants_Data_Check_Rules_1.ini"
Global $Participants_Data_INI_CR_2 = $System_Dir & "temp\Participants_Data_Check_Rules_2.ini"
Global $Participants_Data_INI_TEMP_Check_1 = $System_Dir & "temp\Participants_Data_Check_1.ini"
Global $Participants_Data_INI_TEMP_Check_2 = $System_Dir & "temp\Participants_Data_Check_2.ini"
Global $UserHistory_Data_INI = $System_Dir & "UserHistory.ini"
Global $LOG_Data_INI = $System_Dir & "Server_LOG.ini"
Global $TrackMap_participants_Data_INI = $System_Dir & "TrackMap_participants_Data.ini"

Global $RaceControl_folder = $System_Dir & "RaceControl\"
Global $RaceControl_NextEventInfo_INI = $RaceControl_folder & "NextEventInfo.ini"
Global $RaceControl_WebPageInfo_INI = $RaceControl_folder & "WebPageInfo.ini"
Global $RaceControl_FairPlay_INI = $RaceControl_folder & "FairPlay.ini"

Global $Points_ini = $System_Dir & "Points.ini"
Global $Info_PitStops_ini = $System_Dir & "PitStops.ini"

Global $CutTrack_ini = $System_Dir & "CutTrack.ini"
Global $Impact_ini = $System_Dir & "Impact.ini"

Global $Stats_ini = $System_Dir & "Stats.ini"
Global $Results_INI = $System_Dir & "Results.ini"

Global $LapByLap_File = $System_Dir & "LapByLap.ini"

Global $KICK_BAN_TXT = ($System_Dir & "KICK_BAN.txt")

Global $GUI_msg_1 = IniRead($Sprachdatei,"Language", "GUI_msg_1", "will be started... ")
Global $GUI_msg_2 = IniRead($Sprachdatei,"Language", "GUI_msg_2", "please wait...")

Global $Dedi_Installations_Verzeichnis = IniRead($config_ini, "Einstellungen", "Dedi_Installations_Verzeichnis", "")

Global $Server_Name = IniRead($config_ini, "Server_Einstellungen", "name", "")

Global $DB_path = $System_Dir & "Database.sqlite"
Global $DB_path_Server = IniRead($config_ini, "Einstellungen", "DB_path_Server", "") & "Database.sqlite"
Global $DB_path_FTP = IniRead($config_ini, "Einstellungen", "DB_path_FTP", "") & "Database.sqlite"

Global $Check_Checkbox_PCDSG_Stats_path = IniRead($config_ini, "Einstellungen", "Checkbox_PCDSG_Stats_path", "")

Global $LOOP_NR, $LOOP_NR_old
#endregion Declare Variables/Const

#region GUI Erstellen
Global $font = "Comic Sans MS"
Global $font_2 = "Arial"
Global $font_arial = "arial"

Global $NowDate_Value = _NowDate()
Global $NowDate = StringReplace($NowDate_Value, "/", ".")
Global $NowTime_Value = _NowTime()
Global $NowTime_orig = $NowTime_Value
Global $NowTime = StringReplace($NowTime_Value, ":", "-")


Global $StartTimer = TimerInit()
Global $Date_started = _NowDate()

Global $Time_HOUR_started = @HOUR
Global $Time_MIN_started = @MIN

Global $Time_started = _NowTime()

Global $TimeDiff = TimerDiff($StartTimer)

_Time_Update($TimeDiff)

Global $Runtime = $TimeDiff

Global $Date, $LOOP_NR_send, $Next_LOOP_NR_send

$LOOP_NR = 0

$RACE_NR = 0
$RACE_NR_count = "false"

$Check_TaskBarPos = IniRead($config_ini, "TEMP", "TaskBarPos", "")
$GUI_Y_POS = 0
If $Check_TaskBarPos = "A" Then $GUI_Y_POS = 40
If $Check_TaskBarPos = "B" Then $GUI_Y_POS = 1
If $Check_TaskBarPos = "" Then $GUI_Y_POS = 1
$Return_1 = GUICreate("PCDSG " & $Aktuelle_Version, 4, 398, 1, $GUI_Y_POS, 200)

; PROGRESS BAR
$Anzeige_Fortschrittbalken = GUICtrlCreateProgress(0, 325, 130, 5)


$DS_State = "running"

If FileExists($Server_Data_INI) Then
	$DS_State = IniRead($Server_Data_INI, "DATA", "SessionState", "Idle")
Else
	$DS_State = IniRead($config_ini, "PC_Server", "Server_State", "Idle")
EndIf

If $DS_State = "" then $DS_State = "Idle"


$COLOR_State = $COLOR_BLACK

If $DS_State = "Idle" Then $COLOR_State = $COLOR_RED
If $DS_State = "Lobby" Then $COLOR_State = $COLOR_BLUE
If $DS_State = "Race" Then $COLOR_State = $COLOR_GREEN

If $DS_State = "Idle" Then
	$RACE_NR_count = "false"
EndIf

If $DS_State = "Lobby" Then
	$RACE_NR_count = "false"
EndIf

If $DS_State = "Race" Then
	If $RACE_NR_count = "false" Then
		$RACE_NR = $RACE_NR + 1
		$RACE_NR_count = "true"
	EndIf
EndIf


GUICtrlCreateLabel("DS Status: ", 5, 5, 70, 20)
GUICtrlSetFont(-1, 11, 400, 4, $font_arial)

$DS_State_Label_Value = GUICtrlCreateLabel($DS_State, 5, 20, 100, 20)
GUICtrlSetFont(-1, 11, 400, 1, $font_arial)
GUICtrlSetColor($DS_State_Label_Value, $COLOR_State)



GUICtrlCreateLabel("Info: ", 5, 40, 110, 20)
GUICtrlSetFont(-1, 11, 400, 4, $font_arial)

GUICtrlCreateLabel("Date - Time: ", 5, 55, 110, 20)
GUICtrlSetFont(-1, 8, 400, 1, $font_arial)

$DS_Info_Label_Value_1 = GUICtrlCreateLabel($Date_started, 70, 55, 100, 15)
GUICtrlSetFont(-1, 8, 400, 1, $font_arial)
$DS_Info_Label_Value_2 = GUICtrlCreateLabel($Time_started, 70, 66, 100, 15)
GUICtrlSetFont(-1, 9, 400, 1, $font_arial)
GUICtrlSetColor($DS_State_Label_Value, $COLOR_State)


GUICtrlCreateLabel("Runtime: ", 5, 82, 110, 20)
GUICtrlSetFont(-1, 9, 400, 1, $font_arial)

$DS_Info_Label_Value_3 = GUICtrlCreateLabel($Runtime, 70, 82, 100, 15)
GUICtrlSetFont(-1, 9, 400, 1, $font_arial)


GUICtrlCreateLabel("NR: ", 5, 95, 110, 20)
GUICtrlSetFont(-1, 9, 400, 1, $font_arial)

$DS_Info_Label_Value_4 = GUICtrlCreateLabel($LOOP_NR, 70, 95, 100, 15)
GUICtrlSetFont(-1, 9, 400, 1, $font_arial)


GUICtrlCreateLabel("Race NR: ", 5, 107, 110, 20)
GUICtrlSetFont(-1, 9, 400, 1, $font_arial)

$DS_Info_Label_Value_5 = GUICtrlCreateLabel($LOOP_NR, 70, 107, 100, 15)
GUICtrlSetFont(-1, 9, 400, 1, $font_arial)


GUICtrlCreateLabel("Update Interval: ", 5, 125, 110, 20)
GUICtrlSetFont(-1, 11, 400, 4, $font_arial)

$Wert_UpDown_1 = IniRead($config_ini,"PC_Server", "Infos_pb_Update_Intervall", "")
$Wert_UpDown_1 = StringTrimRight($Wert_UpDown_1, 3)
$Wert_UpDown_1 = $Wert_UpDown_1
$Auswahl_Update_Intervall = GUICtrlCreateInput($Wert_UpDown_1, 4, 143, 40, 20)
GUICtrlSetOnEvent($Auswahl_Update_Intervall, "_Update_Intervall")
GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)
GUICtrlCreateUpdown($Auswahl_Update_Intervall)


GUICtrlCreateLabel("Update Content: ", 5, 168, 110, 20)
GUICtrlSetFont(-1, 11, 400, 4, $font_arial)

; Checkboxen
$Checkbox_1 = GUICtrlCreateCheckbox(" Server Data", 5, 185, 125, 15)
	If IniRead($config_ini, "PC_Server", "Checkbox_Update_1", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetOnEvent($Checkbox_1, "_Checkbox_1")
$Checkbox_2 = GUICtrlCreateCheckbox(" User History Data", 5, 201, 201, 15)
	If IniRead($config_ini, "PC_Server", "Checkbox_Update_2", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetOnEvent($Checkbox_2, "_Checkbox_2")
$Checkbox_3 = GUICtrlCreateCheckbox(" Participant Data", 5, 217, 125, 15)
	If IniRead($config_ini, "PC_Server", "Checkbox_Update_3", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetOnEvent($Checkbox_3, "_Checkbox_3")
$Checkbox_4 = GUICtrlCreateCheckbox(" LOG Data", 5, 233, 125, 15)
	If IniRead($config_ini, "PC_Server", "Checkbox_Update_4", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetOnEvent($Checkbox_4, "_Checkbox_4")
$Checkbox_5 = GUICtrlCreateCheckbox(" Members Data", 5, 249, 125, 15)
	If IniRead($config_ini, "PC_Server", "Checkbox_Update_5", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetOnEvent($Checkbox_5, "_Checkbox_5")

GUICtrlCreateLabel("Appearance: ", 5, 270, 110, 20)
GUICtrlSetFont(-1, 11, 400, 4, $font_arial)

$Checkbox_6 = GUICtrlCreateCheckbox(" Change Background", 5, 287, 125, 15)
	If IniRead($config_ini, "Einstellungen", "Auto_Change_BC", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetOnEvent($Checkbox_6, "_Checkbox_6")

$Checkbox_7 = GUICtrlCreateCheckbox(" Run in Background", 5, 303, 125, 15)
	If IniRead($config_ini, "Einstellungen", "Run_in_Background", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetOnEvent($Checkbox_7, "_Checkbox_7")


$Button_Restart = GUICtrlCreateButton("Restart", 0, 337, 55, 29, 0)
GUICtrlSetFont(-1, 6, $FW_NORMAL, "", $font_2)
GUICtrlSetOnEvent($Button_Restart, "_Restart")
GuiCtrlSetTip(-1, "Restarts StartPCarsDS.exe and emptys some temporary Files.")

$Button_Close = GUICtrlCreateButton("Exit", 70, 337, 55, 29, 0)
GUICtrlSetFont(-1, 6, $FW_NORMAL, "", $font_2)
_GUICtrlButton_SetImage($Button_Close, "shell32.dll", 215, true)
GUICtrlSetOnEvent($Button_Close, "_Close")
GuiCtrlSetTip(-1, "Closes StartPCarsDS.exe and if chosen also the running DS. ")

GUISetState(@SW_SHOW)
GUISetState()


GUICtrlSetData($Anzeige_Fortschrittbalken, 100)
Sleep(700)
GUICtrlSetData($Anzeige_Fortschrittbalken, 00)
#endregion End GUI

#region Set Globals
Global $hQuery, $aRow, $aNames
Global $iRows, $iCols
Global $Wert_Reihenfolge_1, $Wert_Reihenfolge_2, $Wert_Reihenfolge_3, $Wert_Reihenfolge_4, $Wert_Reihenfolge_5, $Wert_Reihenfolge_6, $Wert_Reihenfolge_7
Global $Wert_Reihenfolge_8, $Wert_Reihenfolge_9, $Wert_Reihenfolge_10, $Wert_Reihenfolge_11, $Wert_Reihenfolge_12, $Wert_Reihenfolge_13, $Wert_Reihenfolge_14
Global $Wert_Reihenfolge_15, $Wert_Reihenfolge_16, $Wert_Reihenfolge_17, $Wert_Reihenfolge_18, $Wert_Reihenfolge_19, $Wert_Reihenfolge_20, $Wert_Reihenfolge_21
Global $Wert_Reihenfolge_22, $Wert_Reihenfolge_23, $Wert_Reihenfolge_24, $Wert_Reihenfolge_25, $Wert_Reihenfolge_26, $Wert_Reihenfolge_27, $Wert_Reihenfolge_28
Global $Wert_Reihenfolge_29, $Wert_Reihenfolge_30, $Wert_Reihenfolge_31, $Wert_Reihenfolge_32, $Wert_Track_ID, $Wert_Car, $Wert_Tack, $Wert_Wert
Global $Wert_Points, $Wert_PP_Points, $Wert_Experience_Points, $Wert_Experience_Points_NEW, $Wert_Check_refid, $LOG_Name_from_refid, $Schleife_MFR

$Status_Checkbox_PCDSG_settings_6 = IniRead($config_ini,"Einstellungen", "Auto_Change_BC", "") ; Background Color Check

If $Status_Checkbox_PCDSG_settings_6 = "true" Then
	GUISetBkColor(Random(0, 32767, 1), $Return_1)
EndIf

;Server http settings
Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

If $Lesen_Auswahl_httpApiInterface = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"
#endregion End Set Globals

#region Start _Restart Check
Global $Restart_Check = IniRead($config_ini, "TEMP", "RestartCheck", "")
Global $Database_Check_Status = IniRead($config_ini, "PC_Server", "Checkbox_PCDSG_SQLite3_settings_1", "")

If $Database_Check_Status = "true" Then
	If $Restart_Check = "false" Then
		IniWrite($config_ini, "TEMP", "RestartCheck", "true")
		_Restart()
	EndIf

EndIf
#endregion End _Restart Check

IniWrite($config_ini, "PC_Server", "Status", "PC_Server_gestartet")

#Region Check = Do LOOP
Do

$NowDate_Value = _NowDate()
$NowDate = StringReplace($NowDate_Value, "/", ".")
$NowTime_Value = _NowTime()
$NowTime_orig = $NowTime_Value
$NowTime = StringReplace($NowTime_Value, ":", "-")

GUICtrlSetData($Anzeige_Fortschrittbalken, 5)

$CurrentTrackName = IniRead($Server_Data_INI, "DATA", "TrackName", "")
$Update_Intervall = IniRead($config_ini, "PC_Server", "Infos_pb_Update_Intervall", "")

If $CurrentTrackName = "" Then
	$Wert_Track_ID_search = IniRead($Server_Data_INI, "DATA", "TrackId", "")
	IniWrite($config_ini, "TEMP", "Check_Trackid", $Wert_Track_ID_search)
	_TRACK_NAME_from_ID()
	$CurrentTrackName = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
	FileWriteLine($PCDSG_LOG_ini, "Track_" & $NowTime & "=" & "TrackName" & $CurrentTrackName & " | " & "TrackID:" & $Wert_Track_ID_search)
EndIf


$AutoStat = IniRead($config_ini, "PC_Server", "AutoStat", "")

Local $PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
Local $AutoStat_save_auto_Status = IniRead($config_ini, "PC_Server", "AutoStat_save_auto_Status", "")
Local $PingLimit_Status = IniRead($config_ini, "Race_Control", "Checkbox_Rules_7", "")
Local $AutoKICKRules_Status = IniRead($config_ini, "Race_Control", "Checkbox_Rules_1", "") ; Kick parking cars
Local $AutoKICKList_Status = IniRead($config_ini, "Race_Control", "Checkbox_Rules_2", "")
Global $Database_Check_Status = IniRead($config_ini, "PC_Server", "Checkbox_PCDSG_SQLite3_settings_1", "")
Local $Auto_DataCheck = IniRead($config_ini, "PC_Server", "Checkbox_PCDSG_settings_8", "")
Local $Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")
Local $Auto_IDLECheck = IniRead($Server_Data_INI, "DATA", "state", "")

Global $Automatic_ServerMSG_Status = IniRead($config_ini, "Race_Control", "Checkbox_Rules_6", "")

$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
If $PC_Server_Status = "PC_Server_beendet" Then _Close()

GUICtrlSetData($Anzeige_Fortschrittbalken, 10)

If $Auto_LobbyCheck = "Lobby" Then
	$Check_Checkbox_SET_Lobby_1 = IniRead($config_ini, "Race_Control", "Checkbox_SET_Lobby1", "")
	$Check_Checkbox_SET_Lobby_2 = IniRead($config_ini, "Race_Control", "Checkbox_SET_Lobby2", "")
	$Check_Checkbox_SET_Lobby_3 = IniRead($config_ini, "Race_Control", "Checkbox_SET_Lobby3", "")
	$Check_Checkbox_SET_Lobby_4 = IniRead($config_ini, "Race_Control", "Checkbox_SET_Lobby4", "")
	$Check_Checkbox_SET_Lobby_5 = IniRead($config_ini, "Race_Control", "Checkbox_SET_Lobby5", "")

	$Check_AutoLobbyMessage_1 = IniRead($config_ini, "TEMP", "AutoLobbyMessage_1", "")
	$Check_AutoLobbyMessage_2 = IniRead($config_ini, "TEMP", "AutoLobbyMessage_2", "")
	$Check_AutoLobbyMessage_3 = IniRead($config_ini, "TEMP", "AutoLobbyMessage_3", "")

Global $LOOP_NR_Action_1_send, $Next_LOOP_NR_Action_1_send, $LOOP_NR_Action_2_send, $Next_LOOP_NR_Action_2_send, $LOOP_NR_Action_3_send, $Next_LOOP_NR_Action_3_send

	If $Check_Checkbox_SET_Lobby_1 = "true" Then
		If $Check_AutoLobbyMessage_1 <> "true" Then
			_AutoLobbyAction_1()
		Global $LOOP_NR_Action_1_send = $LOOP_NR
		Global $Next_LOOP_NR_Action_1_send = $LOOP_NR_Action_1_send + 10
		EndIf

		If $Next_LOOP_NR_Action_1_send = $LOOP_NR Then
			IniWrite($config_ini, "TEMP", "AutoLobbyMessage_1", "")
		EndIf
	EndIf

	If $Check_Checkbox_SET_Lobby_4 = "true" Then
		If $Check_AutoLobbyMessage_2 <> "true" Then
			_AutoLobbyAction_2()
		Global $LOOP_NR_Action_2_send = $LOOP_NR
		Global $Next_LOOP_NR_Action_2_send = $LOOP_NR_Action_2_send + 5
		EndIf

		If $Next_LOOP_NR_Action_2_send = $LOOP_NR Then
			IniWrite($config_ini, "TEMP", "AutoLobbyMessage_2", "")
		EndIf
	EndIf

	If $Check_Checkbox_SET_Lobby_5 = "true" Then
		If $Check_AutoLobbyMessage_3 <> "true" Then
			_AutoLobbyAction_3()
		Global $LOOP_NR_Action_3_send = $LOOP_NR
		Global $Next_LOOP_NR_Action_3_send = $LOOP_NR_Action_3_send + 6
		EndIf

		If $Next_LOOP_NR_Action_3_send = $LOOP_NR Then
			IniWrite($config_ini, "TEMP", "AutoLobbyMessage_3", "")
		EndIf
	EndIf


	If $Check_Checkbox_SET_Lobby_2 = "true" Then
		_Random_Car()
	EndIf

	If $Check_Checkbox_SET_Lobby_3 = "true" Then
		_Random_Track()
	EndIf

	Sleep(1000)
EndIf

GUICtrlSetData($Anzeige_Fortschrittbalken, 15)


$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
If $PC_Server_Status = "PC_Server_beendet" Then _Close()


If $Auto_IDLECheck = "Idle" Then
	IniWrite($config_ini, "TEMP", "Seconds_to_Time", "")
	IniWrite($config_ini, "TEMP", "Ping", "")
	IniWrite($config_ini, "TEMP", "KICK_User", "")
	IniWrite($config_ini, "TEMP", "AM_Command", "")
	IniWrite($config_ini, "TEMP", "Wert_Check_Refid", "")
	IniWrite($config_ini, "TEMP", "Wert_Check_Name", "")
	IniWrite($config_ini, "TEMP", "Log_Index_NR", "")
	IniWrite($config_ini, "TEMP", "Check_Trackid", "")
	IniWrite($config_ini, "TEMP", "Check_TrackName", "")
	IniWrite($config_ini, "Server_Einstellungen", "CurrentTrackName", "")

	IniWrite($config_ini, "PC_Server", "Session_Stage", "Idle")

	FileDelete($Server_Data_INI)
	FileDelete($Members_Data_INI)
	FileDelete($Participants_Data_INI)
	FileDelete($Participants_Data_INI_CR_1)
	FileDelete($Participants_Data_INI_CR_2)
	FileDelete($TrackMap_participants_Data_INI)
	FileDelete($LOG_Data_INI)
	FileDelete($status_json)
	FileDelete($members_json)
	FileDelete($participants_json)
	FileDelete($LOG_Data_json)
	FileDelete($TrackMap_participants_json)
	Sleep(2000)
EndIf

GUICtrlSetData($Anzeige_Fortschrittbalken, 20)

$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
If $PC_Server_Status = "PC_Server_beendet" Then _Close()

$PCDSG_DS_Mode = IniRead($config_ini,"PC_Server", "DS_Mode", "")

If $PCDSG_DS_Mode = "local" Then
	If WinExists("Project Cars - Dedicated Server GUI") Then
		If NOT WinExists($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe") Then
			$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
			If $PC_Server_Status <> "PC_Server_beendet" Then
				If $AutoStat = "true" Then ShellExecute($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe", "", "", "")
				If $AutoStat = "false" Then ShellExecute($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe", "", "", "")
			EndIf
		EndIf
	EndIf
EndIf

GUICtrlSetData($Anzeige_Fortschrittbalken, 30)

If $PC_Server_Status <> "PC_Server_beendet" Then
	If FileExists($System_Dir & "UpdateServerData.exe") Then
		ShellExecuteWait($System_Dir & "UpdateServerData.exe")
	Else
		ShellExecuteWait($System_Dir & "UpdateServerData.au3")
	EndIf

	If Not FileExists($Participants_Data_INI_TEMP_Check_1) Then
		FileCopy($Participants_Data_INI, $Participants_Data_INI_TEMP_Check_1, $FC_OVERWRITE)
	Else
		FileCopy($Participants_Data_INI_TEMP_Check_1, $Participants_Data_INI_TEMP_Check_2, $FC_OVERWRITE)
		FileDelete($Participants_Data_INI_TEMP_Check_1)
	EndIf

	If $Auto_LobbyCheck <> "Lobby" and $Auto_IDLECheck <> "Idle" Then
		FileCopy($Participants_Data_INI, $Participants_Data_INI_TEMP, $FC_OVERWRITE)
	EndIf
EndIf

GUICtrlSetData($Anzeige_Fortschrittbalken, 40)

Sleep(100)

$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
If $PC_Server_Status = "PC_Server_beendet" Then _Close()

GUICtrlSetData($Anzeige_Fortschrittbalken, 50)

$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
If $PC_Server_Status = "PC_Server_beendet" Then _Close()

If $Auto_IDLECheck <> "Idle" Then
	_Start_ServerEvents_Check()
EndIf

GUICtrlSetData($Anzeige_Fortschrittbalken, 60)

$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
If $PC_Server_Status = "PC_Server_beendet" Then _Close()

GUICtrlSetData($Anzeige_Fortschrittbalken, 70)

$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
If $PC_Server_Status = "PC_Server_beendet" Then _Close()

If FileExists($System_Dir & "ADD-ON1.exe") Then _ADDON1()
If FileExists($System_Dir & "ADD-ON1.au3") Then _ADDON1()

If FileExists($System_Dir & "ADD-ON2.exe") Then _ADDON2()
If FileExists($System_Dir & "ADD-ON2.au3") Then _ADDON2()

If FileExists($System_Dir & "ADD-ON3.exe") Then _ADDON3()
If FileExists($System_Dir & "ADD-ON3.au3") Then _ADDON3()

If FileExists($System_Dir & "ADD-ON4.exe") Then _ADDON4()
If FileExists($System_Dir & "ADD-ON4.au3") Then _ADDON4()

If FileExists($System_Dir & "ADD-ON5.exe") Then _ADDON5()
If FileExists($System_Dir & "ADD-ON5.au3") Then _ADDON5()

GUICtrlSetData($Anzeige_Fortschrittbalken, 80)

$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
If $PC_Server_Status = "PC_Server_beendet" Then _Close()


$FTP_Upload_sqlite = IniRead($config_ini, "PC_Server", "FTP_Upload_sqlite", "")
$FTP_Upload_CFG = IniRead($config_ini, "PC_Server", "FTP_Upload_CFG", "")
$FTP_Upload_Stats_Results = IniRead($config_ini, "PC_Server", "FTP_Upload_Stats_Results", "")

If $PingLimit_Status = "true" Then _Auto_KICK_PingLimit()

Global $ParkingDetectionAccuracy = IniRead($config_ini, "Race_Control", "ParkingDetectionAccuracy", "")
If $ParkingDetectionAccuracy = "" Then $ParkingDetectionAccuracy = 3

If $AutoKICKRules_Status = "true" Then
	If $LOOP_NR > $LOOP_NR_old + $ParkingDetectionAccuracy Then
		_Auto_KICK_Rules()
	EndIf
EndIf



If $AutoKICKList_Status = "true" Then _Auto_KICK_List()

If $FTP_Upload_sqlite = "true" Then
	_CFG_FTP_Upload()
EndIf

GUICtrlSetData($Anzeige_Fortschrittbalken, 90)

$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
If $PC_Server_Status = "PC_Server_beendet" Then _Close()


If $FTP_Upload_CFG = "true" Then
	_Database_FTP_Upload()
EndIf


If $FTP_Upload_Stats_Results = "true" Then
	_FTP_Upload_Stats_Results()
EndIf


GUICtrlSetData($Anzeige_Fortschrittbalken, 95)


$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
If $PC_Server_Status = "PC_Server_beendet" Then _Close()


$DS_State = "running"

If FileExists($Server_Data_INI) Then
	$DS_State = IniRead($Server_Data_INI, "DATA", "SessionState", "Idle")
Else
	$DS_State = IniRead($config_ini, "PC_Server", "state", "Idle")
EndIf

If $DS_State = "" then $DS_State = "Idle"

$COLOR_State = $COLOR_BLACK

If $DS_State = "Idle" Then $COLOR_State = $COLOR_RED
If $DS_State = "Lobby" Then $COLOR_State = $COLOR_BLUE
If $DS_State = "Race" Then $COLOR_State = $COLOR_GREEN

GUICtrlSetData($DS_State_Label_Value, $DS_State)
GUICtrlSetColor($DS_State_Label_Value, $COLOR_State)


$Status_Checkbox_PCDSG_settings_6 = IniRead($config_ini,"Einstellungen", "Auto_Change_BC", "") ; Background Color Check

If $Status_Checkbox_PCDSG_settings_6 = "true" Then
	GUISetBkColor(Random(0, 32767, 1), $Return_1)
EndIf


$Time_HOUR_current = @HOUR
$Time_MIN_current = @MIN

$Diff_HOUR = $Time_HOUR_current - $Time_HOUR_started
$Diff_MIN = $Time_MIN_current - $Time_MIN_started

$Time_current = $Time_HOUR_current & ":" & $Time_MIN_current

$Runtime = $Diff_HOUR & ":" & $Diff_MIN

$TimeDiff = TimerDiff($StartTimer)

_Time_Update($TimeDiff)

$Runtime = $TimeDiff


$LOOP_NR = $LOOP_NR + 1
IniWrite($config_ini, "TEMP", "LOOP_NR", $LOOP_NR)


$Date_current = _NowDate()

$Time_HOUR_current = @HOUR
$Time_MIN_current = @MIN

$Time_current = _NowTime()

GUICtrlSetData($Anzeige_Fortschrittbalken, 95)

$DS_State = "running"

If FileExists($Server_Data_INI) Then
	$DS_State = IniRead($Server_Data_INI, "DATA", "SessionState", "Idle")
Else
	$DS_State = IniRead($config_ini, "PC_Server", "Server_State", "Idle")
EndIf

If $DS_State = "" then $DS_State = "Idle"


$COLOR_State = $COLOR_BLACK

If $DS_State = "Idle" Then $COLOR_State = $COLOR_RED
If $DS_State = "Lobby" Then $COLOR_State = $COLOR_BLUE
If $DS_State = "Race" Then $COLOR_State = $COLOR_GREEN

If $DS_State = "Idle" Then
	$RACE_NR_count = "false"
EndIf

If $DS_State = "Lobby" Then
	$RACE_NR_count = "false"
EndIf

If $DS_State = "Race" Then
	If $RACE_NR_count = "false" Then
		$RACE_NR = $RACE_NR + 1
		$RACE_NR_count = "true"
	EndIf
EndIf

GUISetState(@SW_SHOW)

GUISetState()

$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
If $PC_Server_Status = "PC_Server_beendet" Then _Close()

Sleep(200)

GUICtrlSetData($Anzeige_Fortschrittbalken, 100)

Global $Check_Checkbox_PCDSG_Stats_path = IniRead($config_ini, "Einstellungen", "Checkbox_PCDSG_Stats_path", "")
If $Check_Checkbox_PCDSG_Stats_path = "true" Then
	_SyncFiles_Start()
	Sleep(1000)
EndIf

$SessionStage_Check = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
$SessionTimeElapsed = IniRead($Server_Data_INI, "DATA", "SessionTimeElapsed", "")
$SessionTimeElapsed_minutes = StringTrimRight($SessionTimeElapsed, 3)
$SessionTimeElapsed_seconds = StringTrimLeft($SessionTimeElapsed, 3)

If $SessionTimeElapsed_minutes = "00" Then
		If $SessionTimeElapsed_seconds > 30 Then
		IniWrite($config_ini, "PC_Server", "Session_Stage", $SessionStage_Check)
		_Delete_LapByLap_INI()
	EndIf
Else
	IniWrite($config_ini, "PC_Server", "Session_Stage", $SessionStage_Check)
EndIf


GUICtrlSetData($DS_State_Label_Value, $DS_State)
GUICtrlSetColor($DS_State_Label_Value, $COLOR_State)

GUICtrlSetData($DS_Info_Label_Value_1, $Date_current)
GUICtrlSetData($DS_Info_Label_Value_2, $Time_current)
GUICtrlSetData($DS_Info_Label_Value_3, $Runtime)
GUICtrlSetData($DS_Info_Label_Value_4, $LOOP_NR)
GUICtrlSetData($DS_Info_Label_Value_5, $RACE_NR)

If $Check_Checkbox_PCDSG_Stats_path = "true" Then
	If $Update_Intervall = "0000" Then Sleep(200)
Else
	If $Update_Intervall = "0000" Then Sleep(600)
EndIf

Sleep($Update_Intervall)


GUICtrlSetData($Anzeige_Fortschrittbalken, 00)

Until $PC_Server_Status = "PC_Server_beendet"
#EndRegion



Func _Update_Intervall()
	$Data_UpDown_1 = GUICtrlRead($Auswahl_Update_Intervall)

	If $Data_UpDown_1 < 0 Then GUICtrlSetData($Auswahl_Update_Intervall, "0")
	If $Data_UpDown_1 > 59 Then GUICtrlSetData($Auswahl_Update_Intervall, "59")

	$Data_UpDown_1 = GUICtrlRead($Auswahl_Update_Intervall)

	IniWrite($config_ini, "PC_Server", "Infos_pb_Update_Intervall", $Data_UpDown_1 & "000")
EndFunc

Func _CheckBox_1()
	$Data_Checkbox = GUICtrlRead($Checkbox_1)
	If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
	If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
	IniWrite($config_ini, "PC_Server", "Checkbox_Update_1", $Data_Checkbox)
EndFunc

Func _CheckBox_2()
	$Data_Checkbox = GUICtrlRead($Checkbox_2)
	If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
	If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
	IniWrite($config_ini, "PC_Server", "Checkbox_Update_2", $Data_Checkbox)
EndFunc

Func _CheckBox_3()
	$Data_Checkbox = GUICtrlRead($Checkbox_3)
	If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
	If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
	IniWrite($config_ini, "PC_Server", "Checkbox_Update_3", $Data_Checkbox)
EndFunc

Func _CheckBox_4()
	$Data_Checkbox = GUICtrlRead($Checkbox_4)
	If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
	If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
	IniWrite($config_ini, "PC_Server", "Checkbox_Update_4", $Data_Checkbox)
EndFunc

Func _CheckBox_5()
	$Data_Checkbox = GUICtrlRead($Checkbox_5)
	If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
	If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
	IniWrite($config_ini, "PC_Server", "Checkbox_Update_5", $Data_Checkbox)
EndFunc

Func _Checkbox_6()
	$Data_Checkbox = GUICtrlRead($Checkbox_6)
	If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
	If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
	IniWrite($config_ini, "Einstellungen", "Auto_Change_BC", $Data_Checkbox)
EndFunc

Func _Checkbox_7()
	$Data_Checkbox = GUICtrlRead($Checkbox_7)
	If $Data_Checkbox = "1" Then
		WinSetState("Project Cars - Dedicated Server GUI", "", @SW_MINIMIZE)
		WinSetState("Einstellungen", "", @SW_MINIMIZE)
		WinSetState("Race Control", "", @SW_MINIMIZE)
		WinSetState("PCars DS User History", "", @SW_MINIMIZE)
		WinSetState("PCars: Dedicated Server Overview", "", @SW_MINIMIZE)
		WinSetState("PCDSG " & $Aktuelle_Version, "", @SW_HIDE)
		WinSetState($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe", "", @SW_HIDE)
		GUICtrlSetState($Checkbox_7, $GUI_UNCHECKED)
		Sleep(500)
		IniWrite($config_ini, "Einstellungen", "Run_in_Background", "false")
	EndIf

	If $Data_Checkbox = "4" Then
		$Data_Checkbox = "false"
		IniWrite($config_ini, "Einstellungen", "Run_in_Background", $Data_Checkbox)
	EndIf
EndFunc


Func _Auto_KICK_Rules()
	$Anzahl_Werte_Participants = IniRead($Participants_Data_INI, "DATA", "NR", "")

	If FileExists($Participants_Data_INI_CR_2) Then

	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$KICK_USER_NR = 0

	For $Schleife_AutiKickRules = 1 To 32
		$Check_POS_State = IniRead($Participants_Data_INI, $Schleife_AutiKickRules, "State","")
		$Check_Name_Kick = IniRead($Participants_Data_INI, $Schleife_AutiKickRules, "Name","")
		$Check_RefId_Kick = IniRead($Participants_Data_INI, $Schleife_AutiKickRules, "RefId","")

		If FileExists($Participants_Data_INI_CR_2) Then
			If $Check_POS_State <> "" Then
				If $Check_POS_State <> "InGarage" Then
					If $Check_POS_State <> "InPits" Then
						$NR_Left = 3
						$Wert_POS_X_OLD = IniRead($Participants_Data_INI_CR_2, $Check_Name_Kick, "PositionX", "")
						$Wert_POS_X_OLD = StringReplace($Wert_POS_X_OLD, "-", "")
							$Wert_POS_X_OLD = StringTrimRight($Wert_POS_X_OLD, 2)

						$Wert_POS_Z_OLD = IniRead($Participants_Data_INI_CR_2, $Check_Name_Kick, "PositionZ", "")
						$Wert_POS_Z_OLD = StringReplace($Wert_POS_Z_OLD, "-", "")
						$Wert_POS_Z_OLD = StringTrimRight($Wert_POS_Z_OLD, 2)

						$Wert_POS_X = IniRead($Participants_Data_INI, $Check_Name_Kick, "PositionX","")
						$Wert_POS_X = StringReplace($Wert_POS_X, "-", "")
						$Wert_POS_X = StringTrimRight($Wert_POS_X, 2)

						$Wert_POS_Z = IniRead($Participants_Data_INI, $Check_Name_Kick, "PositionZ","")
						$Wert_POS_Z = StringReplace($Wert_POS_Z, "-", "")
						$Wert_POS_Z = StringTrimRight($Wert_POS_Z, 2)


						If $Wert_POS_X_OLD <> "" and $Wert_POS_Z_OLD <> "" and $Wert_POS_X <> "" and $Wert_POS_Z <> "" Then
							If $Wert_POS_X = $Wert_POS_X_OLD and $Wert_POS_Z = $Wert_POS_Z_OLD Then
								$refid = $Check_RefId_Kick
								If $refid <> "" Then
									$Message_0 = "     "
									$Message_1 = "PCDSG: " & " <<< Rules KICK  >>>"
									$Message_2 = "User: " & $Check_Name_Kick & "  [" & $refid & "]"
									$Message_3 = "KICKED because of 'parking' on the Track" & " @: " & $Date

									$URL_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $refid & "?message=" & $Message_0
									$download = InetGet($URL_MSG, @ScriptDir & "\Message.txt", 16, 0)
									$URL_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $refid & "?message=" & $Message_1
									$download = InetGet($URL_MSG, @ScriptDir & "\Message.txt", 16, 0)
									$URL_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $refid & "?message=" & $Message_2
									$download = InetGet($URL_MSG, @ScriptDir & "\Message.txt", 16, 0)
									$URL_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $refid & "?message=" & $Message_3
									$download = InetGet($URL_MSG, @ScriptDir & "\Message.txt", 16, 0)

									$URL_KICK = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid ; & "&redirect=status"
									$download = InetGet($URL_KICK, $KICK_BAN_TXT, 16, 0)
									$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)
									FileWriteLine($PCDSG_LOG_ini, "KICK_Rules_Parking" & $NowTime & "=" & "RefID" & $refid & " | " & "Reason: " & "Parking Car detected")
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	Next
	$LOOP_NR_old = $LOOP_NR
	EndIf

	If $AutoKICKRules_Status = "true" Then
		FileCopy($Participants_Data_INI, $Participants_Data_INI_CR_2, $FC_OVERWRITE)
	EndIf
EndFunc

Func _Auto_KICK_List()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$KICK_USER_NR = 0

	For $Kick_Schleife_1 = 1 To _FileCountLines($System_Dir & "KICK_LIST.txt")
		$refid = FileReadLine($System_Dir & "KICK_LIST.txt", $Kick_Schleife_1)

		If $refid <> "" Then
			$URL_KICK = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid
			$download = InetGet($URL_KICK, $KICK_BAN_TXT, 16, 0)
			$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)
			FileWriteLine($PCDSG_LOG_ini, "KICK_List" & $NowTime & "=" & "RefID" & $refid & " | " & "Reason: " & "User on KickList")
		EndIf
	Next
EndFunc

Func _Auto_KICK_PingLimit()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$PingLimit = IniRead($config_ini, "Race_Control", "PingLimit", "")
	$PingLimit = Int($PingLimit)

	For $PingLimit_KICK_loop_1 = 0 To 32
		$refid = IniRead($Members_Data_INI, $PingLimit_KICK_loop_1, "refid", "")

		If $refid <> "" Then
			$Ping = IniRead($Members_Data_INI, $PingLimit_KICK_loop_1, "Ping", "")
			$Ping = Int($Ping)

			$PingLimit_prozent_WarnLimit = IniRead($config_ini, "Race_Control", "PingLimit_%_WarnLimit", "")
			If $PingLimit_prozent_WarnLimit = "" Then IniWrite($config_ini, "Race_Control", "PingLimit_%_WarnLimit", "85")

			$PingLimit_warn_value = $PingLimit / 100 * $PingLimit_prozent_WarnLimit

			If $Ping > $PingLimit_warn_value Then
				$Nachricht_1 = "PCDSG: " & " <<< PING: Warning, Ping is too high! >>>"
				$Nachricht_2 = "PCDSG: " & "refid = " & $refid
				$Nachricht_3 = "PCDSG: " & $Ping & "--> PingLimit = " & $PingLimit

				If $Automatic_ServerMSG_Status = "true" Then
					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
					$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)
					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
					$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)
					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
					$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)
					Sleep(500)
				EndIf

			EndIf

			If $Ping > $PingLimit Then
				$Nachricht_1 = "PCDSG: " & " <<< ADMIN: User will be KICKED because of Ping Limit! >>>"
				$Nachricht_2 = "PCDSG: " & "refid = " & $refid & " --> KICK in 3 seconds"
				$Nachricht_3 = "PCDSG: " & $Ping & "--> PingLimit = " & $PingLimit

				If $Automatic_ServerMSG_Status = "true" Then
					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_1
					$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)
					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_2
					$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)
					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht_3
					$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)
					Sleep(3000)
				EndIf

				$URL_KICK = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid
				$download = InetGet($URL_KICK, $System_Dir & "PingLimit_KICK.txt", 16, 0)
				$Check_KICK = FileReadLine($System_Dir & "PingLimit_KICK.txt", 2)
				FileWriteLine($PCDSG_LOG_ini, "KICK_Rules_PingLimit" & $NowTime & "=" & "RefID" & $refid & " | " & "Reason: " & "User Ping is lower then Ping Limit value")

				If $Check_KICK = '  "result" : "ok"' Then
					$Nachricht = "PCDSG: " & " <<< ADMIN: User KICKED because of Ping Limit >>>"
					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht
					$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)
				EndIf
			EndIf
		EndIf
	Next
EndFunc

Func _Auto_DataCheck()
	If FileExists($System_Dir & "DataCheck.exe") Then
		ShellExecuteWait($System_Dir & "DataCheck.exe")
	Else
		ShellExecuteWait($System_Dir & "DataCheck.au3")
	EndIf
EndFunc

Func _ADDON1()
	If FileExists($System_Dir & "ADD-ON1.exe") Then
		ShellExecute($System_Dir & "ADD-ON1.exe")
	Else
		If FileExists($System_Dir & "ADD-ON1.au3") Then
			ShellExecute($System_Dir & "ADD-ON1.au3")
		EndIf
	EndIf
EndFunc

Func _ADDON2()
	If FileExists($System_Dir & "ADD-ON2.exe") Then
		ShellExecute($System_Dir & "ADD-ON2.exe")
	Else
		If FileExists($System_Dir & "ADD-ON2.au3") Then
			ShellExecute($System_Dir & "ADD-ON2.au3")
		EndIf
	EndIf
EndFunc

Func _ADDON3()
	If FileExists($System_Dir & "ADD-ON3.exe") Then
		ShellExecute($System_Dir & "ADD-ON3.exe")
	Else
		If FileExists($System_Dir & "ADD-ON3.au3") Then
			ShellExecute($System_Dir & "ADD-ON3.au3")
		EndIf
	EndIf
EndFunc

Func _ADDON4()
	If FileExists($System_Dir & "ADD-ON4.exe") Then
		ShellExecute($System_Dir & "ADD-ON4.exe")
	Else
		If FileExists($System_Dir & "ADD-ON4.au3") Then
			ShellExecute($System_Dir & "ADD-ON4.au3")
		EndIf
	EndIf
EndFunc

Func _ADDON5()
	If FileExists($System_Dir & "ADD-ON5.exe") Then
		ShellExecute($System_Dir & "ADD-ON5.exe")
	Else
		If FileExists($System_Dir & "ADD-ON5.au3") Then
			ShellExecute($System_Dir & "ADD-ON5.au3")
		EndIf
	EndIf
EndFunc

Func _CFG_FTP_Upload()
	$FTP_Upload = IniRead($config_ini, "PC_Server", "FTP_Upload_CFG", "")

	$FTP_Username = IniRead($config_ini, "FTP", "FTP_Username", "")
	$FTP_Passwort = IniRead($config_ini, "FTP", "FTP_Password", "")
	$FTP_Server_Name_IP = IniRead($config_ini, "FTP", "FTP_Server_Name_IP", "")
	$FTP_Port = IniRead($config_ini, "FTP", "FTP_Port", "")
	$FTP_folder= IniRead($config_ini, "FTP", "FTP_CFG_folder", "")
	$FTP_Passive= IniRead($config_ini, "FTP", "FTP_Passive", "")

	Sleep(100)

	Local $Datum = @YEAR & "-" & @MON & "-" & @MDAY


	Local $s_ServerName = $FTP_Server_Name_IP
	Local $s_Username = $FTP_Username
	Local $Eingabe_FTP_Password

	If $FTP_Passwort = "" Then $Eingabe_FTP_Password = InputBox ( "Enter FTP Password", "Enter FTP Password to confirm FTP File Upload.")
	If $FTP_Passwort <> "" Then $Eingabe_FTP_Password = $FTP_Passwort

	Local $s_Password = $Eingabe_FTP_Password

	Local $s_LocalFolder = $Dedi_Installations_Verzeichnis
	Local $Zielordner = $FTP_folder

	Local $i_Passive = $FTP_Passive
	Local $l_InternetSession, $l_FTPSession, $errOpen, $errFTP

	Local $FileList = _FileListToArray($s_LocalFolder , "*.cfg" , 1)
	$l_InternetSession = _FTP_Open('AuoItZilla')
	$errOpen = @error

	$l_FTPSession = _FTP_Connect($l_InternetSession, $s_ServerName, $s_Username, $s_Password, $i_Passive)
	_FTP_DirSetCurrent($l_FTPSession, $Zielordner)


	If $FileList <> "" Then
		For $NR = 1 To $FileList[0]
			Local $s_RemoteFile = $Zielordner & $FileList[$NR]

			If Not @error Then
					$l_FTPSession = _FTP_Connect($l_InternetSession, $s_ServerName, $s_Username, $s_Password, $i_Passive)
					$errFTP = @error
					If Not @error Then
						If $FileList[$NR] = "server.cfg" Then
							If _FTP_FilePut($l_FTPSession, $s_LocalFolder & $FileList[$NR], $s_RemoteFile) Then
								;ConsoleWrite("Upload: erfolgreich" & @CRLF)
								;MsgBox(0, "FTP Upload finished", "server.cfg Upload: successfully", 2)
							Else
								;ConsoleWrite("Upload: fehlgeschlagen " & " " & $s_LocalFolder & $FileList[$NR] & " " & @error & @CRLF)
								;MsgBox(0, "FTP Upload finished", "server.cfg Upload: Failed", 5)
							EndIf
						EndIf


						If $FileList[$NR] = "blackList.cfg" Then
							If _FTP_FilePut($l_FTPSession, $s_LocalFolder & $FileList[$NR], $s_RemoteFile) Then
								;ConsoleWrite("Upload: erfolgreich" & @CRLF)
								;MsgBox(0, "FTP Upload finished", "blackList.cfg Upload: successfully", 2)
							Else
								;ConsoleWrite("Upload: fehlgeschlagen " & " " & $s_LocalFolder & $FileList[$NR] & " " & @error & @CRLF)
								;MsgBox(0, "FTP Upload finished", "blackList.cfg Upload: Failed", 5)
							EndIf
						EndIf


						If $FileList[$NR] = "whiteList.cfg" Then
							If _FTP_FilePut($l_FTPSession, $s_LocalFolder & $FileList[$NR], $s_RemoteFile) Then
								;ConsoleWrite("Upload: erfolgreich" & @CRLF)
								;MsgBox(0, "FTP Upload finished", "whiteList.cfg Upload: successfully", 2)
							Else
								;ConsoleWrite("Upload: fehlgeschlagen " & " " & $s_LocalFolder & $FileList[$NR] & " " & @error & @CRLF)
								;MsgBox(0, "FTP Upload finished", "whiteList.cfg Upload: Failed", 5)
							EndIf
						EndIf
					Else
						MsgBox(0, "Connect", "Failed", 3)
						;ConsoleWrite("Connect: " & " " & $errFTP & @CRLF)
					EndIf
			Else
				MsgBox(0, "Open", "Failed", 3)
				;ConsoleWrite("Open " & " " & $errOpen & @CRLF)
			EndIf
		Next
	EndIf

	If $FileList = "" Then MsgBox(0, "", ".cfg Files not found...", 3)

    _FTP_Close($l_InternetSession)
EndFunc

Func _Database_FTP_Upload()
	$FTP_Username = IniRead($config_ini, "FTP", "FTP_Username", "")
	$FTP_Passwort = IniRead($config_ini, "FTP", "FTP_Password", "")
	$FTP_Server_Name_IP = IniRead($config_ini, "FTP", "FTP_Server_Name_IP", "")
	$FTP_Port = IniRead($config_ini, "FTP", "FTP_Port", "")
	$FTP_folder= IniRead($config_ini, "FTP", "FTP_sqlite_folder", "")
	$FTP_Passive= IniRead($config_ini, "FTP", "FTP_Passive", "")

	$Session_Save_Verzeichnisname = IniRead($config_ini, "PC_Server", "Session_Save_Verzeichnisname", "")

	Sleep(100)

	Local $Datum = @YEAR & "-" & @MON & "-" & @MDAY


	Local $s_ServerName = $FTP_Server_Name_IP
	Local $s_Username = $FTP_Username
	Local $Eingabe_FTP_Password

	If $FTP_Passwort = "" Then $Eingabe_FTP_Password = InputBox ( "Enter FTP Password", "Enter FTP Password to confirm FTP File Upload.")
	If $FTP_Passwort <> "" Then $Eingabe_FTP_Password = $FTP_Passwort

	Local $s_Password = $Eingabe_FTP_Password

	Local $s_LocalFolder = $System_Dir
	Local $Zielordner = $FTP_folder

	Local $i_Passive = $FTP_Passive
	Local $l_InternetSession, $l_FTPSession, $errOpen, $errFTP

	Local $FileList = _FileListToArray($s_LocalFolder , "*.sqlite" , 1)
	$l_InternetSession = _FTP_Open('AuoItZilla')
	$errOpen = @error

	$l_FTPSession = _FTP_Connect($l_InternetSession, $s_ServerName, $s_Username, $s_Password, $i_Passive)
	_FTP_DirSetCurrent($l_FTPSession, $Zielordner)


	If $FileList <> "" Then
		For $NR = 1 To $FileList[0]
			Local $s_RemoteFile = $Zielordner & $FileList[$NR]

			If Not @error Then
					$l_FTPSession = _FTP_Connect($l_InternetSession, $s_ServerName, $s_Username, $s_Password, $i_Passive)
					$errFTP = @error
					If Not @error Then
						If $FileList[$NR] = "Database.sqlite" Then
							;MsgBox(0, "FTP_FilePut", $s_LocalFolder & $FileList[$NR] & @CRLF & $s_RemoteFile)
							If _FTP_FilePut($l_FTPSession, $s_LocalFolder & $FileList[$NR], $s_RemoteFile) Then
								;ConsoleWrite("Upload: erfolgreich" & @CRLF)
								;MsgBox(0, "FTP Upload finished", "HTM Files Upload: successfully", 3)
							Else
								;ConsoleWrite("Upload: fehlgeschlagen " & " " & $s_LocalFolder & $FileList[$NR] & " " & @error & @CRLF)
								;MsgBox(0, "FTP Upload finished", "Database Upload: Failed", 3)
							EndIf
						EndIf
					Else
						MsgBox(0, "Connect", "Failed", 3)
						;ConsoleWrite("Connect: " & " " & $errFTP & @CRLF)
					EndIf
			Else
				MsgBox(0, "Open", "Failed", 3)
				;ConsoleWrite("Open " & " " & $errOpen & @CRLF)
			EndIf
		Next
	EndIf
	If $FileList = "" Then MsgBox(0, "", "Database Files not found...", 3)
	_FTP_Close($l_InternetSession)
EndFunc

Func _FTP_Upload_Stats_Results()
	$FTP_Username = IniRead($config_ini, "FTP", "FTP_Username", "")
	$FTP_Passwort = IniRead($config_ini, "FTP", "FTP_Password", "")
	$FTP_Server_Name_IP = IniRead($config_ini, "FTP", "FTP_Server_Name_IP", "")
	$FTP_Port = IniRead($config_ini, "FTP", "FTP_Port", "")
	$FTP_folder= IniRead($config_ini, "FTP", "FTP_Stats_Results_folder", "")
	$FTP_Passive= IniRead($config_ini, "FTP", "FTP_Passive", "")

	Sleep(100)

	Local $Datum = @YEAR & "-" & @MON & "-" & @MDAY

	Local $s_ServerName = $FTP_Server_Name_IP
	Local $s_Username = $FTP_Username
	Local $Eingabe_FTP_Password

	If $FTP_Passwort = "" Then $Eingabe_FTP_Password = InputBox ( "Enter FTP Password", "Enter FTP Password to confirm FTP File Upload.")
	If $FTP_Passwort <> "" Then $Eingabe_FTP_Password = $FTP_Passwort

	Local $s_Password = $Eingabe_FTP_Password

	Local $s_LocalFolder = $System_Dir
	Local $Zielordner = $FTP_folder

	Local $i_Passive = $FTP_Passive
	Local $l_InternetSession, $l_FTPSession, $errOpen, $errFTP

	Local $FileList = _FileListToArray($s_LocalFolder , "*.ini" , 1)
	$l_InternetSession = _FTP_Open('AuoItZilla')
	$errOpen = @error

	$l_FTPSession = _FTP_Connect($l_InternetSession, $s_ServerName, $s_Username, $s_Password, $i_Passive)
	_FTP_DirSetCurrent($l_FTPSession, $Zielordner)


	If $FileList <> "" Then
		For $NR = 1 To $FileList[0]
			Local $s_RemoteFile = $Zielordner & $FileList[$NR]

			If Not @error Then
					$l_FTPSession = _FTP_Connect($l_InternetSession, $s_ServerName, $s_Username, $s_Password, $i_Passive)
					$errFTP = @error
					If Not @error Then

						If $FileList[$NR] = "Stats.ini" Then
							If _FTP_FilePut($l_FTPSession, $s_LocalFolder & $FileList[$NR], $s_RemoteFile) Then
								;ConsoleWrite("Upload: erfolgreich" & @CRLF)
								;MsgBox(0, "FTP Upload finished", "server.cfg Upload: successfully", 2)
							Else
								;ConsoleWrite("Upload: fehlgeschlagen " & " " & $s_LocalFolder & $FileList[$NR] & " " & @error & @CRLF)
								;MsgBox(0, "FTP Upload finished", "server.cfg Upload: Failed", 5)
							EndIf
						EndIf


						If $FileList[$NR] = "Results_Datei.ini" Then
							If _FTP_FilePut($l_FTPSession, $s_LocalFolder & $FileList[$NR], $s_RemoteFile) Then
								;ConsoleWrite("Upload: erfolgreich" & @CRLF)
								;MsgBox(0, "FTP Upload finished", "blackList.cfg Upload: successfully", 2)
							Else
								;ConsoleWrite("Upload: fehlgeschlagen " & " " & $s_LocalFolder & $FileList[$NR] & " " & @error & @CRLF)
								;MsgBox(0, "FTP Upload finished", "blackList.cfg Upload: Failed", 5)
							EndIf
						EndIf


						If $FileList[$NR] = "Points.ini" Then
							If _FTP_FilePut($l_FTPSession, $s_LocalFolder & $FileList[$NR], $s_RemoteFile) Then
								;ConsoleWrite("Upload: erfolgreich" & @CRLF)
								;MsgBox(0, "FTP Upload finished", "whiteList.cfg Upload: successfully", 2)
							Else
								;ConsoleWrite("Upload: fehlgeschlagen " & " " & $s_LocalFolder & $FileList[$NR] & " " & @error & @CRLF)
								;MsgBox(0, "FTP Upload finished", "whiteList.cfg Upload: Failed", 5)
							EndIf
						EndIf

						If $FileList[$NR] = "UserHistory.ini" Then
							If _FTP_FilePut($l_FTPSession, $s_LocalFolder & $FileList[$NR], $s_RemoteFile) Then
								;ConsoleWrite("Upload: erfolgreich" & @CRLF)
								;MsgBox(0, "FTP Upload finished", "whiteList.cfg Upload: successfully", 2)
							Else
								;ConsoleWrite("Upload: fehlgeschlagen " & " " & $s_LocalFolder & $FileList[$NR] & " " & @error & @CRLF)
								;MsgBox(0, "FTP Upload finished", "whiteList.cfg Upload: Failed", 5)
							EndIf
						EndIf
					Else
						MsgBox(0, "Connect", "Failed", 3)
						;ConsoleWrite("Connect: " & " " & $errFTP & @CRLF)
					EndIf
			Else
				MsgBox(0, "Open", "Failed", 3)
				;ConsoleWrite("Open " & " " & $errOpen & @CRLF)
			EndIf

		Next
	EndIf
	If $FileList = "" Then MsgBox(0, "", ".ini Files not found...", 3)
    _FTP_Close($l_InternetSession) ;schliesst die FTP-Sitzng
EndFunc


Func _AutoLobbyAction_1()
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
	$Message_Lobby_16 = "SG1: " & "> " & $Value_SG1_min_read
	$Message_Lobby_17 = "SG2: " & "> " & $Value_SG2_min_read & " - " & "< " & $Value_SG2_max_read & " EP"
	$Message_Lobby_18 = "SG3: " & "> " & $Value_SG3_min_read & " - " & "< " & $Value_SG3_max_read & " EP"
	$Message_Lobby_19 = "SG4: " & "> " & $Value_SG4_min_read & " - " & "< " & $Value_SG4_max_read & " EP"
	$Message_Lobby_20 = "SG5: " & "> " & $Value_SG5_min_read & " - " & "< " & $Value_SG5_max_read & " EP"
	$Message_Lobby_21 = "------------------------"
	$Message_Lobby_22 = "                        "
	$Message_Lobby_23 = "ServerOverview.html with TrackMap, Statistics and Results:"
	$Message_Lobby_24 = "http://www.cogent.myds.me/PCDSGwiki/PCDSG_DATA/DATA/ServerOverview.html"
	$Message_Lobby_25 = "                        "
	$Message_Lobby_26 = "------------------------"

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_empty
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_0
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_1
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_2
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_3
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_4
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_5
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_6
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_7
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_8
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_9
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_10
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_11
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_12
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_13
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_14
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_15
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_16
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_17
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_18
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_19
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_20
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_21
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_22
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_23
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_24
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_25
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_26
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)


	IniWrite($config_ini, "TEMP", "AutoLobbyMessage_1", "true")
	Sleep(1000)
EndFunc

Func _AutoLobbyAction_2()
	$Message_Lobby_0 = "------------------------"
	$Message_Lobby_1 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_1", "")
	$Message_Lobby_2 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_2", "")
	$Message_Lobby_3 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_3", "")
	$Message_Lobby_4 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_4", "")
	$Message_Lobby_5 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_5", "")
	$Message_Lobby_6 = "------------------------"

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_0
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_1
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_2
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_3
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_4
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_5
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_6
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	IniWrite($config_ini, "TEMP", "AutoLobbyMessage_2", "true")

	Sleep(1000)
EndFunc

Func _AutoLobbyAction_3()
	$Message_Lobby_0 = "------------------------"
	$Message_Lobby_1 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "Name", "")
	$Message_Lobby_2 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "Track", "")
	$Message_Lobby_3 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "Session", "")
	$Message_Lobby_4 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "Date_Time", "")
	$Message_Lobby_5 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "Misc", "")
	$Message_Lobby_6 = "------------------------"

	$Message_Lobby_1 = "" & $Message_Lobby_1
	$Message_Lobby_2 = "Track: " & "          " & $Message_Lobby_2
	$Message_Lobby_3 = "Session: " & "       " & $Message_Lobby_3
	$Message_Lobby_4 = "Date_Time: " & "  " &  $Message_Lobby_4
	$Message_Lobby_5 = "Misc: " & "            " &  $Message_Lobby_5

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_0
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_1
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_2
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_3
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_4
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_5
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_6
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	IniWrite($config_ini, "TEMP", "AutoLobbyMessage_3", "true")

	Sleep(1000)
EndFunc


Func _Delete_PP()
	FileDelete($Points_ini)
	FileWriteLine($Points_ini, "[DATA]")
	FileWriteLine($Points_ini, "NR=0")
EndFunc

Func _Delete_PitStops()
	FileDelete($Info_PitStops_ini)
	FileWriteLine($Info_PitStops_ini, "[PitStops]")
	FileWriteLine($Info_PitStops_ini, "NR=0")
EndFunc

Func _Delete_CutTrack()
	FileDelete($CutTrack_ini)
	FileWriteLine($Points_ini, "[DATA]")
	FileWriteLine($Points_ini, "NR=0")
EndFunc

Func _Delete_Impact()
	FileDelete($Impact_ini)
	FileWriteLine($Points_ini, "[DATA]")
	FileWriteLine($Points_ini, "NR=0")
EndFunc

Func _Delete_LapByLap_INI()
	FileDelete($LapByLap_File)
	FileWrite($LapByLap_File, "")
EndFunc

Func _Delete_Results_INI()
	FileDelete($Results_INI)
	FileWrite($Results_INI, "")
	FileWriteLine($PCDSG_LOG_ini, "Delete_Results_INI_" & $NowTime & "=" & "Delete_Results_INI")
EndFunc


Func _TRACK_NAME_from_ID()
	IniWrite($config_ini, "TEMP", "Check_TrackName", "")

	$Wert_Track_ID_search = IniRead($config_ini, "TEMP", "Check_Trackid", "")

	$Anzahl_Zeilen_TrackList = _FileCountLines(@ScriptDir & "\TrackList.txt")

	$Check_Line = ""

	For $Schleife_TRACK_ID_DropDown = 7 To $Anzahl_Zeilen_TrackList Step 5
		$Wert_Track_ID = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_ID_DropDown)
		$Wert_Track_ID = StringReplace($Wert_Track_ID, '        "id" : ', '')
		$Wert_Track_ID = StringReplace($Wert_Track_ID, '"', '')
		$Wert_Track_ID = StringReplace($Wert_Track_ID, ',', '')

		If $Wert_Track_ID = $Wert_Track_ID_search Then
			$Wert_Track = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_ID_DropDown + 1)
			$Wert_Track = StringReplace($Wert_Track, '        "name" : "', '')
			$Wert_Track = StringReplace($Wert_Track, ',', '')
			$Wert_Track = StringReplace($Wert_Track, '"', '')
			IniWrite($config_ini, "Server_Einstellungen", "CurrentTrackName", $Wert_Track)
			IniWrite($config_ini, "TEMP", "Check_TrackName", $Wert_Track)
			$Schleife_TRACK_ID_DropDown = $Anzahl_Zeilen_TrackList
		EndIf
	Next
EndFunc

Func _Car_ermitteln()
	$Wert_CAR_ID_ListView = $Wert_Car

	$Anzahl_Zeilen_VehicleList = _FileCountLines($System_Dir & "VehicleList.txt")

	$Wert_Car = ""
	$Werte_Car = ""
	$Wert_Car_ID = ""
	$Check_Line = ""

	For $Schleife_CAR_DropDown = 7 To $Anzahl_Zeilen_VehicleList Step 5
		$Durchgang_NR = $Schleife_CAR_DropDown - 5

		$Wert_Car_ID = FileReadLine($System_Dir & "VehicleList.txt", $Schleife_CAR_DropDown)
		$Wert_Car_ID = StringReplace($Wert_Car_ID, '        "id" : ', '')
		$Wert_Car_ID = StringReplace($Wert_Car_ID, ',', '')


		If $Wert_CAR_ID_ListView = $Wert_Car_ID Then
			$Wert_Car = FileReadLine($System_Dir & "VehicleList.txt", $Schleife_CAR_DropDown + 1)
			$Wert_Car = StringReplace($Wert_Car, '        "name" : "', '')
			$Wert_Car = StringReplace($Wert_Car, '",', '')
			$Schleife_CAR_DropDown = $Anzahl_Zeilen_VehicleList
		EndIf
	Next
EndFunc


Func _EPOCH_decrypt($iEpochTime)
	$TimeZone_Correction = "2"

    Local $iDayToAdd = Int($iEpochTime / 86400)
    Local $iTimeVal = Mod($iEpochTime, 86400)
    If $iTimeVal < 0 Then
        $iDayToAdd -= 1
        $iTimeVal += 86400
    EndIf
    Local $i_wFactor = Int((573371.75 + $iDayToAdd) / 36524.25)
    Local $i_xFactor = Int($i_wFactor / 4)
    Local $i_bFactor = 2442113 + $iDayToAdd + $i_wFactor - $i_xFactor
    Local $i_cFactor = Int(($i_bFactor - 122.1) / 365.25)
    Local $i_dFactor = Int(365.25 * $i_cFactor)
    Local $i_eFactor = Int(($i_bFactor - $i_dFactor) / 30.6001)
    Local $aDatePart[3]
    $aDatePart[2] = $i_bFactor - $i_dFactor - Int(30.6001 * $i_eFactor)
    $aDatePart[1] = $i_eFactor - 1 - 12 * ($i_eFactor - 2 > 11)
    $aDatePart[0] = $i_cFactor - 4716 + ($aDatePart[1] < 3)
    Local $aTimePart[3]
    $aTimePart[0] = Int($iTimeVal / 3600)
    $iTimeVal = Mod($iTimeVal, 3600)
    $aTimePart[1] = Int($iTimeVal / 60)
    $aTimePart[2] = Mod($iTimeVal, 60)
	$Seconds_to_Time = StringFormat("%.2d/%.2d/%.2d" & " - " & "%.2d:%.2d:%.2d", $aDatePart[0], $aDatePart[1], $aDatePart[2], $aTimePart[0] + $TimeZone_Correction, $aTimePart[1], $aTimePart[2])
EndFunc

Func _Time_Update($iMs)
	$iMs = Int($iMs)

	Local $iSec, $iMin, $iStd, $sVor
	If $iMs < 0 Then
		$iMs = Abs($iMs)
		$sVor = '-'
	EndIf
	$string_millisekunden_laenge = StringLen($iMs)
	$Wert_millisekunden = StringTrimLeft($iMs, $string_millisekunden_laenge - 3)
	If $Wert_millisekunden = "0" Then $Wert_millisekunden = "000"
	$iSec = $iMs / 1000
	$iMin = $iSec / 60
	$iMin -= Int($iStd) * 60
	$iSec -= Int($iMin) * 60

	$LastLapTime_Wert = $sVor & StringRight('0' & Int($iMin), 2) & ':' & StringRight('0' & Int($iSec), 2); & '.' & $Wert_millisekunden
	If $LastLapTime_Wert = "00:00.000" Then $LastLapTime_Wert = ""
	$Wert = $LastLapTime_Wert
	$TimeDiff = $Wert
EndFunc

Func _KICK_USER_universal()
	$KICK_User = IniRead($config_ini, "TEMP", "KICK_User", "")

	$index = IniRead($Members_Data_INI, $KICK_User, "index", "")
	$refid = IniRead($Members_Data_INI, $KICK_User, "refid", "")
	$steamid = IniRead($Members_Data_INI, $KICK_User, "steamid", "")

	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$URL_KICK = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid

	$download = InetGet($URL_KICK, $KICK_BAN_TXT, 16, 0)
	FileWriteLine($PCDSG_LOG_ini, "KICK_" & $NowTime & "=" & "RefID" & $refid & " | " & "Reason: " & "User Kicked by PCDSG GUI")

	$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)
EndFunc

Func _BAN_USER_universal()
	$KICK_User = IniRead($config_ini, "TEMP", "BAN_User", "")

	$index = IniRead($Members_Data_INI, $KICK_User, "index", "")
	$refid = IniRead($Members_Data_INI, $KICK_User, "refid", "")
	$steamid = IniRead($Members_Data_INI, $KICK_User, "steamid", "")

	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$URL_KICK = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid & "&ban=864000"

	$download = InetGet($URL_KICK, $KICK_BAN_TXT, 16, 0)
	FileWriteLine($PCDSG_LOG_ini, "BAN_" & $NowTime & "=" & "RefID" & $refid & " | " & "Reason: " & "User Baned by PCDSG GUI")

	$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)
EndFunc

Func _Tab3_Pfad_Button_1_Aktion()
	$APP_path = IniRead($config_ini, "APPS", "APP_1_path", "")

	If $APP_path <> "" Then
		If FileExists($APP_path) Then
			ShellExecute($APP_path)

			$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: PCDSG - APP started >>>"
			$download = InetGet($URL_Admin_MSG, $System_Dir & "Message.txt", 16, 0)
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
			$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: PCDSG - APP started >>>"
			$download = InetGet($URL_Admin_MSG, $System_Dir & "Message.txt", 16, 0)
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
			$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: PCDSG - APP started >>>"
			$download = InetGet($URL_Admin_MSG, $System_Dir & "Message.txt", 16, 0)
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
			$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: PCDSG - APP started >>>"
			$download = InetGet($URL_Admin_MSG, $System_Dir & "Message.txt", 16, 0)
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
			$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: PCDSG - APP started >>>"
			$download = InetGet($URL_Admin_MSG, $System_Dir & "Message.txt", 16, 0)
		Else
			MsgBox(0, "Path Error", "File path does not exist.")
		EndIf
	EndIf
EndFunc


Func _Start_ServerEvents_Check()
	If FileExists($System_Dir & "ServerEvents.exe") Then
		ShellExecuteWait($System_Dir & "ServerEvents.exe")
	Else
		ShellExecuteWait($System_Dir & "ServerEvents.au3")
	EndIf
EndFunc

Func _SyncFiles_Start()
	If FileExists($System_Dir & "SyncFiles.exe") Then
		ShellExecute($System_Dir & "SyncFiles.exe")
	Else
		ShellExecute($System_Dir & "SyncFiles.au3")
	EndIf
EndFunc


Func _Random_Car()
	$Wert_VehicleList_NAME_Random = ""
	$Wert_VehicleList_ID = ""

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

			$Check_ID_Name = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_VehicleList_DropDown - 1)
			$Check_ID_Name = StringSplit($Check_ID_Name, ':', $STR_ENTIRESPLIT)

			If $Check_ID_Name[1] = '        "id" ' Then
			$Wert_VehicleList_ID = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_VehicleList_DropDown - 1)
			$Wert_VehicleList_ID = StringReplace($Wert_VehicleList_ID, '        "id" : ', '')
			$Wert_VehicleList_ID = StringReplace($Wert_VehicleList_ID, ',', '')
			IniWrite($config_ini, "Server_Einstellungen", "NextCarName", $Wert_VehicleList_NAME_Random)
			IniWrite($config_ini, "Server_Einstellungen", "NextCarID", $Wert_VehicleList_ID)
			EndIf
	Next

	$Random_Car_Attribute = ""
	$NextCarID = IniRead($config_ini, "Server_Einstellungen", "NextCarID", "")
	If $NextCarID <> "" Then $Random_Car_Attribute = 'session_VehicleModelId=' & $NextCarID ; $Check_CAR

	$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $Random_Car_Attribute
	$download = InetGet($URL, @ScriptDir & "\Attributes.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "     "
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)
	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "New Vehicle set by PCDSG:"
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)
	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Wert_VehicleList_NAME_Random & "   " & "[" & $NextCarID & "]"
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	IniWrite($config_ini, "Server_Einstellungen", "NextCarName", "")
	IniWrite($config_ini, "Server_Einstellungen", "NextCarID", "")
EndFunc

Func _Random_Track()
	$Wert_Track_NAME_Random = ""
	$Wert_Track_ID = ""

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
			IniWrite($config_ini, "Server_Einstellungen", "NextTrackName", $Wert_Track_NAME_Random)
		EndIf

			$Check_ID_Name = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown - 1)
			$Check_ID_Name = StringSplit($Check_ID_Name, ':', $STR_ENTIRESPLIT)

			If $Check_ID_Name[1] = '        "id" ' Then
				$Wert_Track_ID = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_DropDown - 1)
				$Wert_Track_ID = StringReplace($Wert_Track_ID, '        "id" : ', '')
				$Wert_Track_ID = StringReplace($Wert_Track_ID, ',', '')
				IniWrite($config_ini, "Server_Einstellungen", "NextTrackID", $Wert_Track_ID)
			EndIf
	Next

	$Random_Track_Attribute = ""

	$NextTrackID = IniRead($config_ini, "Server_Einstellungen", "NextTrackID", "")

	If $NextTrackID <> "" Then $Random_Track_Attribute = 'session_TrackId=' & $NextTrackID ; $Check_TRACK

	$URL = 'http://' & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & '/api/session/set_attributes?' & $Random_Track_Attribute
	$download = InetGet($URL, @ScriptDir & "\Attributes.txt", 16, 0)

	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "     "
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)
	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "New Track set by PCDSG:"
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)
	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Wert_Track_NAME_Random & "   " & "[" & $NextTrackID & "]"
	$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

	IniWrite($config_ini, "Server_Einstellungen", "NextTrackName", "")
	IniWrite($config_ini, "Server_Einstellungen", "NextTrackID", "")
EndFunc


Func _Restart()
	If FileExists($System_Dir & "StartPCarsDS.exe") Then
		ShellExecute($System_Dir & "StartPCarsDS.exe")
	Else
		ShellExecute($System_Dir & "StartPCarsDS.au3")
	EndIf

	FileWriteLine($PCDSG_LOG_ini, "Restart_StartPCarsDS_" & $NowTime & "=" & "Restart of StartPCarsDS" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
	Exit
EndFunc

Func _Start_DS()
	If FileExists($install_dir & "StartPCarsDS.au3") Then
		ShellExecute($install_dir & "StartPCarsDS.au3", "", "", "")
	EndIf

	FileWriteLine($PCDSG_LOG_ini, "Start_DedicatedServerCmd.exe_" & $NowTime & "=" & "Start of DedicatedServerCmd.exe" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
EndFunc

Func _Restart_DS()
	ShellExecute($DS_folder & "DedicatedServerCmd.exe", "", "", "")
EndFunc


Func _Close()
	$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")

	IniWrite($config_ini, "PC_Server", "Status", "PC_Server_beendet")

	Sleep(200)

	_Delete_PitStops()
	_Delete_CutTrack()
	_Delete_Impact()

	IniWrite($config_ini, "TEMP", "RestartCheck", "")
	IniWrite($config_ini, "TEMP", "Seconds_to_Time", "")
	IniWrite($config_ini, "TEMP", "Ping", "")
	IniWrite($config_ini, "TEMP", "KICK_User", "")
	IniWrite($config_ini, "TEMP", "Log_Index_NR", "")
	IniWrite($config_ini, "TEMP", "AM_Command", "")
	IniWrite($config_ini, "TEMP", "Wert_Check_Refid", "")
	IniWrite($config_ini, "TEMP", "Wert_Check_Name", "")
	IniWrite($config_ini, "TEMP", "Check_Trackid", "")
	IniWrite($config_ini, "TEMP", "Check_TrackName", "")
	IniWrite($config_ini, "TEMP", "Check_Gridsize", "")
	IniWrite($config_ini, "TEMP", "Check_Carid", "")
	IniWrite($config_ini, "TEMP", "Check_CarName", "")
	IniWrite($config_ini, "TEMP", "LapTime_GAP_1", "")
	IniWrite($config_ini, "TEMP", "LapTime_GAP_2", "")
	IniWrite($config_ini, "TEMP", "LapTime_GAP_3", "")
	IniWrite($config_ini, "TEMP", "Results_saved_TrackName", "")
	IniWrite($config_ini, "TEMP", "Results_saved_SessionStage", "")
	IniWrite($config_ini, "TEMP", "AutoLobbyMessage_1", "")
	IniWrite($config_ini, "TEMP", "AutoLobbyMessage_2", "")
	IniWrite($config_ini, "TEMP", "AutoLobbyMessage_3", "")
	IniWrite($config_ini, "TEMP", "AutoGameMessage_1", "")
	IniWrite($config_ini, "TEMP", "AutoGameMessage_2", "")
	IniWrite($config_ini, "TEMP", "AutoGameMessage_3", "")
	IniWrite($config_ini, "TEMP", "AutoGameMessage_4", "")
	IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_1_send", "")
	IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_2_send", "")
	IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_3_send", "")
	IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_4_send", "")
	IniWrite($config_ini, "TEMP", "LOOP_NR", "")
	IniWrite($config_ini, "TEMP", "OP_NR", "")
	IniWrite($config_ini, "TEMP", "NR", "")
	IniWrite($config_ini, "TEMP", "Race_Finished", "")
	IniWrite($config_ini, "TEMP", "ResultsSaved", "")
	IniWrite($config_ini, "TEMP", "ResultsIndexNR", "")
	IniWrite($config_ini, "TEMP", "Start_TrackMapReplay", "")
	IniWrite($config_ini, "TEMP", "Stop_TrackMapReplay", "")
	IniWrite($config_ini, "TEMP", "Status_TrackMapReplay", "")
	IniWrite($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", "")
	IniWrite($config_ini, "TEMP", "TMR_Record_Start_Time", "")
	IniWrite($config_ini, "TEMP", "TMR_Record_End_Time", "")
	IniWrite($config_ini, "TEMP", "Record_End_Time", "")

	IniWrite($config_ini, "PC_Server", "Server_State", "")
	IniWrite($config_ini, "PC_Server", "Session_Stage", "")

	$Log_Index_NR = IniRead($config_ini, "TEMP", "Log_Index_NR", "")
	$Log_Index_NR_Check_1 = $Log_Index_NR - 25
	$Log_Index_NR_Check_2 = IniRead($LOG_Data_INI, "DATA", "Value_1_1", "1")

	If $Log_Index_NR_Check_2 < $Log_Index_NR_Check_1 Then
		IniWrite($config_ini, "TEMP", "Log_Index_NR", "")
	EndIf

	FileDelete($Server_Data_INI)
	FileDelete($Members_Data_INI)
	FileDelete($Participants_Data_INI)
	FileDelete($Participants_Data_INI_CR_1)
	FileDelete($Participants_Data_INI_CR_2)
	FileDelete($TrackMap_participants_Data_INI)
	FileDelete($LOG_Data_INI)
	FileDelete($status_json)
	FileDelete($members_json)
	FileDelete($participants_json)
	FileDelete($LOG_Data_json)
	FileDelete($TrackMap_participants_json)

	Sleep(200)
	_Delete_PP()

	FileDelete($System_Dir & "KICK_LIST.txt")
	FileWrite($System_Dir & "KICK_LIST.txt", "")

	If FileExists($PCDSG_Status_File) Then
		$EmptyFile = FileOpen($PCDSG_Status_File, 2)
		FileWrite($PCDSG_Status_File, "")
		FileClose($PCDSG_Status_File)
	EndIf

	FileWriteLine($PCDSG_Status_File, "Server Status: " & "PCDSG offline")
	FileWriteLine($PCDSG_Status_File, "DS Server Name: " & "")
	FileWriteLine($PCDSG_Status_File, "SessionState: " & "")
	FileWriteLine($PCDSG_Status_File, "SessionStage: " & "")
	FileWriteLine($PCDSG_Status_File, "Time Elapsed: " & "")
	$PCDSG_Status_picture_offline = $gfx & "PCDSG_offline.jpg"
	$Stats_copy_2_folder = IniRead($config_ini, "Einstellungen", "PCDSG_Stats_path", "")
	$PCDSG_Status_File_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "PCDSG_Status.txt"
	$PCDSG_Status_picture_offline_copy_2 = $Stats_copy_2_folder & "PCDSG - Images\" & "PCDSG_Status.jpg"
	FileCopy($PCDSG_Status_File, $PCDSG_Status_File_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($PCDSG_Status_picture_offline, $PCDSG_Status_picture_offline_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)

	$Abfrage = MsgBox(4, "Dedicated Server", "Do you also want to close the dedicated server?" & @CRLF, 5)

	If $Abfrage = 6 Then
		WinClose($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe")
		FileWriteLine($PCDSG_LOG_ini, "Close_DedicatedServerCmd.exe_" & $NowTime & "=" & "Close DedicatedServerCmd.exe" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
		_Delete_PitStops()
		_Delete_CutTrack()
		_Delete_Impact()
		_Delete_LapByLap_INI()
		_Delete_Results_INI()
	EndIf

	_SQLite_Close($DB_path)
	_SQLite_Shutdown()

	FileWriteLine($PCDSG_LOG_ini, "Close_StartPCarsDS_" & $NowTime & "=" & "Close StartPCarsDS" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)
	Exit
EndFunc


