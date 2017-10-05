#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\ICONS\AutoDataUpdate.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiButton.au3>
#include <StaticConstants.au3>
#include <GuiListView.au3>
#include <GuiTab.au3>
#include <EventLog.au3>
#include <File.au3>
#include <GuiStatusBar.au3>
#include <Excel.au3>
#include <GuiTreeView.au3>
#include <Misc.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

#include <Date.au3>

Opt("GUIOnEventMode", 1)
Opt("GUIDataSeparatorChar", "|") ;"|" is the default

Global $GUI, $Statusbar, $Server_Status, $Status_TrackMapReplay, $timestamp

#Region Declare Variables / Const
;VARIABLEN SETZEN
Global $config_ini = (@ScriptDir & "\" & "config.ini")
Global $install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
Global $System_Dir = $install_dir & "system\"
Global $Data_Dir = $install_dir & "data\"
Global $Server_Data_INI = $System_Dir  & "Server_Data.ini"
Global $LOG_Data_INI = $System_Dir & "Server_LOG.ini"
Global $PitStops_ini = $System_Dir & "PitStops.ini"
Global $Points_ini = $System_Dir & "Points.ini"
Global $Stats_INI = $System_Dir & "Stats.ini"
Global $CutTrack_INI = $System_Dir & "CutTrack.ini"
Global $Impact_INI = $System_Dir & "Impact.ini"

Global $Sprachdatei = IniRead($config_ini,"Einstellungen", "Sprachdatei", "")

;GFX (Grafik) Verzeichnis
$gfx = (@ScriptDir & "\" & "system\gfx\")

Global $Members_Data_INI = $System_Dir & "Members_Data.ini"

Global $TrackMapReplay_folder = $System_Dir & "TrackMap\"

Global $TrackMapReplay_INI = $System_Dir & "TrackMap\TrackMapReplay.ini"
Global $TrackMapReplay_participants_json = $System_Dir & "TrackMap\TrackMapReplay_participants.json"
Global $TrackMapReplay_participants_Data_INI = $System_Dir & "TrackMap\TrackMapReplay_participants_Data.ini"

$Results_Folder = $Data_Dir & "Results\"

Global $Server_Status = IniRead($Server_Data_INI, "DATA", "state", "")
If $Server_Status = "" Then $Server_Status = "OFFLINE"
Global $Check_Lobby = IniRead($Server_Data_INI, "DATA", "SessionState", "")
If $Check_Lobby = "Lobby" Then $Server_Status = "Lobby"

Global $Status_TrackMapReplay = IniRead($config_ini, "TEMP", "Status_TrackMapReplay", "")

Global $SessionStage = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
If $SessionStage = "" Then $SessionStage = "-"

Global $TrackMapReplay_LOOP_NR = IniRead($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", "")
If $TrackMapReplay_LOOP_NR = "" Then $TrackMapReplay_LOOP_NR = "0"

$msgbox_30 = IniRead($Sprachdatei,"Language", "msgbox_30", "Save LOG File")
$msgbox_31 = IniRead($Sprachdatei,"Language", "msgbox_31", "Do you really want to save the complete list?")
$msgbox_36 = IniRead($Sprachdatei,"Language", "msgbox_36", "It will save the Results from the Log between the following Index Numbers:")


;Server http settings lesen
Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

If $Lesen_Auswahl_httpApiInterface = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"


Global $participants_RefId, $participants_Name, $participants_IsPlayer, $participants_GridPosition, $participants_VehicleId, $participants_LiveryId
Global $participants_RacePosition, $participants_CurrentLap, $participants_CurrentSector, $participants_Sector1Time, $participants_Sector2Time, $participants_Sector3Time
Global $participants_FastestLapTime, $participants_State, $participants_HeadlightsOn, $participants_WipersOn, $participants_Speed
Global $participants_Gear, $participants_RPM, $participants_PositionX, $participants_PositionY, $participants_PositionZ, $participants_Orientation
Global $Wert, $Replay_Array

Global $font = "Comic Sans MS"
Global $font_2 = "Arial"
Global $font_arial = "arial"

#endregion Declare Variables/Const

Global $TEMP_AM_Command = IniRead($config_ini, "TEMP", "AM_Command", "")
Global $Check_AM_Command = IniRead($config_ini, "TEMP", "AM_Command", "")

If $TEMP_AM_Command <> ">StartRR" Then

#Region Create GUI

 Local $GUI = GUICreate("PCDSG TrackMap Replay", 400, 300, -1, -1, $WS_EX_TOPMOST)

; PROGRESS
$Anzeige_Fortschrittbalken = GUICtrlCreateProgress(0, 245, 1080, 5)

;Status Bar $Anzeige_Fortschrittbalken
$Statusbar = _GUICtrlStatusBar_Create($GUI)
_GUICtrlStatusBar_SetSimple($Statusbar, True)

GUISetState()

GUICtrlSetData($Anzeige_Fortschrittbalken, 25)
GUICtrlSetData($Anzeige_Fortschrittbalken, 50)
;Sleep(700)
GUICtrlSetData($Anzeige_Fortschrittbalken, 75)
;Sleep(700)
GUICtrlSetData($Anzeige_Fortschrittbalken, 100)
;Sleep(700)
GUICtrlSetData($Anzeige_Fortschrittbalken, 00)

#endregion  Create GUI

#Region Create Group
GUICtrlCreateGroup("Status:", 3, 50, 388, 110)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
GUICtrlSetColor(-1, "0x0000FF")
GUICtrlSetFont(-1, 13, 400, 6, $font_arial)
#endregion  Create Group

#Region Create Label

GUICtrlCreateLabel("PCars DS Server Status:", 7, 70, 170, 23)
GUICtrlSetFont(-1, 11, 400, 3, $font) ; will display underlined characters
$TrackMapReplay_Status_Value = GUICtrlCreateLabel($Server_Status, 180, 72, 170, 20)
GUICtrlSetFont($TrackMapReplay_Status_Value, 11, 400, 3, $font_arial) ; will display underlined characters
If $Server_Status = "Offline" Then GUICtrlSetColor($TrackMapReplay_Status_Value, $COLOR_RED)
If $Server_Status = "Running" Then GUICtrlSetColor($TrackMapReplay_Status_Value, $COLOR_GREEN)

GUICtrlCreateLabel("TrackMap Replay Status:", 7, 90, 170, 23)
GUICtrlSetFont(-1, 11, 400, 3, $font) ; will display underlined characters
$TrackMapReplay_Status_Value = GUICtrlCreateLabel($Status_TrackMapReplay, 180, 92, 170, 20)
GUICtrlSetFont($TrackMapReplay_Status_Value, 11, 400, 3, $font_arial) ; will display underlined characters
GUICtrlSetColor($TrackMapReplay_Status_Value, $COLOR_RED)
If $Status_TrackMapReplay = "Recording stopped" Then GUICtrlSetColor($TrackMapReplay_Status_Value, $COLOR_BLUE)
If $Status_TrackMapReplay = "Replay stopped" Then GUICtrlSetColor($TrackMapReplay_Status_Value, $COLOR_BLUE)

GUICtrlCreateLabel("Session Stage:", 7, 110, 190, 23)
GUICtrlSetFont(-1, 11, 400, 3, $font) ; will display underlined characters
$SessionStage_Value = GUICtrlCreateLabel($SessionStage, 180, 112, 170, 20)
GUICtrlSetFont($SessionStage_Value, 11, 400, 3, $font_arial) ; will display underlined characters
GUICtrlSetColor(-1, $COLOR_BLUE)
If $SessionStage = "OFFLINE" Then GUICtrlSetColor(-1, $COLOR_RED)

GUICtrlCreateLabel("Number of Records:", 7, 130, 180, 23)
GUICtrlSetFont(-1, 11, 400, 3, $font) ; will display underlined characters
$Number_of_Records_Value = GUICtrlCreateLabel($TrackMapReplay_LOOP_NR, 180, 132, 170, 20)
GUICtrlSetFont($Number_of_Records_Value, 11, 400, 3, $font_arial) ; will display underlined characters
GUICtrlSetColor($Number_of_Records_Value, $COLOR_RED)
If $TrackMapReplay_LOOP_NR = "0" Then GUICtrlSetColor($Number_of_Records_Value, $COLOR_BLUE)

Global $TMR_Record_Start_Time = IniRead($config_ini, "TEMP", "TMR_Record_Start_Time", "")
GUICtrlCreateLabel("[", 221, 133, 5, 23)
GUICtrlCreateLabel("Start:", 225, 132, 45, 23)
GUICtrlSetFont(-1, 9, 400, 3, $font) ; will display underlined characters
$TrackMapReplay_Start_Time = GUICtrlCreateLabel($TMR_Record_Start_Time, 265, 132, 50, 20)
GUICtrlSetFont($TrackMapReplay_Start_Time, 9, 400, 4, $font) ; will display underlined characters

Global $TMR_Record_End_Time = IniRead($config_ini, "TEMP", "TMR_Record_End_Time", "")
GUICtrlCreateLabel("End:", 315, 132, 45, 23)
GUICtrlSetFont(-1, 9, 400, 3, $font) ; will display underlined characters
$TrackMapReplay_End_Time = GUICtrlCreateLabel($TMR_Record_End_Time, 342, 132, 35, 20)
GUICtrlSetFont($TrackMapReplay_End_Time, 9, 400, 4, $font) ; will display underlined characters
GUICtrlCreateLabel("]", 376, 133, 5, 23)

#endregion  Create Label

#Region Create GUI Checkbox

$Status_Checkbox_SET_Start_detection = IniRead($config_ini, "TrackMap", "Checkbox_Start_detection", "")
$Status_Checkbox_SET_End_detection = IniRead($config_ini, "TrackMap", "Checkbox_End_detection", "")
$Status_Checkbox_AutoSave = IniRead($config_ini, "TrackMap", "Checkbox_AutoSave", "")
$Status_Checkbox_SaveLOG = IniRead($config_ini, "TrackMap", "Checkbox_SaveLOG", "")

Global $Checkbox_AutoSave = GUICtrlCreateCheckbox(" Save File after end of Replay", 7, 164, 160, 15)
	If $Status_Checkbox_AutoSave = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent($Checkbox_AutoSave, "_Checkbox_AutoSave")

Global $Checkbox_SaveLOG = GUICtrlCreateCheckbox(" Save Log File with Replay", 7, 181, 160, 15) ; Read and Evaluate Log File?
	If $Status_Checkbox_SaveLOG = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent($Checkbox_SaveLOG, "_Checkbox_SaveLOG")

;Global $Checkbox_SET_Start_detection = GUICtrlCreateCheckbox(" Automatic Start detection", 170, 164, 150, 15)
	;If $Status_Checkbox_SET_Start_detection = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
;GUICtrlSetOnEvent($Checkbox_SET_Start_detection, "_Checkbox_SET_Start_detection")

;Global $Checkbox_SET_End_detection = GUICtrlCreateCheckbox(" Automatic End detection", 170, 181, 150, 15)
	;If $Status_Checkbox_SET_End_detection = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
;GUICtrlSetOnEvent($Checkbox_SET_End_detection, "_Checkbox_SET_End_detection")

#endregion Create GUI Checkbox

#Region Create GUI Buttons

Local $Button_Start_Recording = GUICtrlCreateButton("Start Replay Recording ", 5, 5, 384, 42) ; 190
GUICtrlSetFont(-1, 17, $FW_NORMAL, "", $font_2)
_GUICtrlButton_SetImage($Button_Start_Recording, "ActionCenterCPL.dll", 3, true)
GUICtrlSetOnEvent($Button_Start_Recording, "_Button_Start_Recording")

;Local $Button_Stop_Recording = GUICtrlCreateButton(" " & "Stop Recording Replay", 200, 5, 190, 42)
;GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)
;_GUICtrlButton_SetImage($Button_Stop_Recording, "wmploc.DLL", 155, true)
;GUICtrlSetOnEvent($Button_Stop_Recording, "_Button_Stop_Recording")


;Local $Button_Test = GUICtrlCreateButton(" " & "Log save", 5, 165, 190, 30)
;GUICtrlSetOnEvent($Button_Test, "_Add_LOG_2_Replay")

Local $Button_Save = GUICtrlCreateButton(" " & "Save", 5, 200, 190, 42)
GUICtrlSetFont(-1, 12, $FW_NORMAL, "", $font_2)
_GUICtrlButton_SetImage($Button_Save, "imageres.dll", 23, true)
GUICtrlSetOnEvent($Button_Save, "_Button_Save")

Local $Button_Exit_Close = GUICtrlCreateButton("Exit | Close", 200, 200, 190, 42)
GUICtrlSetFont(-1, 12, $FW_NORMAL, "", $font_2)
_GUICtrlButton_SetImage($Button_Exit_Close, "shell32.dll", 215, true)
GUICtrlSetOnEvent($Button_Exit_Close, "_Exit_Close")


#endregion  Create GUI Buttons

EndIf

$timestamp = _NowDate() & " - " & _NowTime()

_GUICtrlStatusBar_SetText($Statusbar, $Server_Status & " - " & $Status_TrackMapReplay & @TAB & @TAB & "Timestamp: " & $timestamp)


; Display the GUI.
GUISetState(@SW_SHOW, $GUI)

IniWrite($config_ini, "TEMP", "Admin_MSG_6", "")
FileDelete($TrackMapReplay_INI)
FileDelete($TrackMapReplay_participants_json)
FileDelete($TrackMapReplay_participants_Data_INI)

#region LOOP without GUI

If $TEMP_AM_Command = ">StartRR" Then
	;IniWrite($config_ini, "TEMP", "AM_Command", "")
	_Button_Start_Recording()
EndIf

#EndRegion LOOP without GUI


#region While 1
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			;Exit
	EndSwitch
   Sleep(100)
WEnd
#EndRegion GUI - While 1

#Region Funktionen


Func _DO_LOOP()
Do

$Status_TrackMapReplay = IniRead($config_ini, "TEMP", "Status_TrackMapReplay", "")
$Status_Race_Finished = IniRead($config_ini, "TEMP", "Race_Finished", "")

_Download()
_TrackMap_Participants_Daten_Update()

Global $Check_AM_Command = IniRead($config_ini, "TEMP", "AM_Command", "")

$TrackMapReplay_LOOP_NR = IniRead($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", "0")
If $Check_AM_Command <> ">StartRR" and $Check_AM_Command <> ">StopRR" Then GUICtrlSetData($Number_of_Records_Value, $TrackMapReplay_LOOP_NR)

$SessionStage = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
If $Check_AM_Command <> ">StartRR" and $Check_AM_Command <> ">StopRR" Then GUICtrlSetData($SessionStage_Value, $SessionStage)

If $Check_AM_Command = ">StopRR" Then
	$Status_TrackMapReplay = "Recording stopped"
	IniWrite($config_ini, "TEMP", "Status_TrackMapReplay", "Recording stopped")
	;_Button_Stop_Recording()
EndIf

If $Status_Race_Finished = "true" Then
	$Status_TrackMapReplay = "Recording stopped"
	IniWrite($config_ini, "TEMP", "Status_TrackMapReplay", "Recording stopped")
	IniWrite($config_ini, "TEMP", "AM_Command", ">StopRR")
	;_Button_Stop_Recording()
EndIf

Until $Status_TrackMapReplay <> "Recording"

If $Check_AM_Command = ">StopRR" Then
	IniWrite($config_ini, "TEMP", "Status_TrackMapReplay", "Recording stopped")
	_Button_Stop_Recording()
	IniWrite($config_ini, "TEMP", "AM_Command", "")
	_Exit_Close()
EndIf

EndFunc

Func _Download()
$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

$URL_participants = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/status?attributes&participants"

$download = InetGet($URL_participants, $TrackMapReplay_participants_json, 16, 0)
EndFunc

Func _Download_LOG()

	$Replay_LOG_json = $TrackMapReplay_folder & "Replay_Log.json"

	Global $LOG_Index_Start = IniRead($TrackMapReplay_INI, "TrackMapReplay", "LOG_Index_Start", "")
	$LOG_Index_Start = Int($LOG_Index_Start)
	Global $LOG_Index_End = IniRead($TrackMapReplay_INI, "TrackMapReplay", "LOG_Index_End", "")
	$LOG_Index_End = Int($LOG_Index_End)

	$Value_LOG_Start = -1000
	$Value_LOG_End = 1000

	If $LOG_Index_Start <> "" Then $Value_LOG_Start = $LOG_Index_Start
	If $LOG_Index_End <> ""  Then $Value_LOG_End = $LOG_Index_End


	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$URL_LOG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/log/range?offset=" & $Value_LOG_Start & "&count=" & $Value_LOG_End
	$download_LOG = InetGet($URL_LOG, $Replay_LOG_json, 16, 0)

EndFunc

Func _TrackMap_Participants_Daten_Update()

$Ende_Zeile_NR = _FileCountLines($TrackMapReplay_participants_json) - 1

	$participants_Name = ""
	$participants_Name_bea = ""
	$Name = ""
	$Wert = ""

;If FileExists($TrackMapReplay_participants_Data_INI) Then
	;$EmptyFile = FileOpen($TrackMapReplay_participants_Data_INI, 2)
	;FileWrite($EmptyFile, "")
	;FileClose($EmptyFile)
;EndIf

;$LOOP_NR = 0
$TrackMapReplay_LOOP_NR = 0

For $iCount_3 = 77 To $Ende_Zeile_NR

	$TrackMapReplay_LOOP_NR = IniRead($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", "0")
	;$LOOP_NR = $LOOP_NR + 1
	$TrackMapReplay_LOOP_NR = $TrackMapReplay_LOOP_NR + 1

	$Wert_Zeile = FileReadLine($TrackMapReplay_participants_json, $iCount_3)
	$Wert_Zeile = StringReplace($Wert_Zeile, "}", "")
	$Wert_Zeile = StringReplace($Wert_Zeile, "{", "")
	$Wert_Zeile = StringSplit(StringTrimLeft($Wert_Zeile, 1), ":")

	$Name = ""
	$Wert = ""

	If UBound($Wert_Zeile - 1) = 3 Then
	$Name = $Wert_Zeile[1]
	$Name = StringTrimLeft($Name, 10)
	$Name = StringTrimRight($Name, 2)
	$Name = StringReplace($Name, " ", "")
	$Name = StringReplace($Name, " ", "")
	$Name = StringReplace($Name, " ", "")

		If $Name <> "" Then
			$Wert = StringTrimLeft($Wert_Zeile[2], 1)
			$Wert = StringTrimRight($Wert, 1)
			$Wert = StringReplace($Wert, '"', '')

		If $Name = "Sector1Time" Then _Time_Update()
		If $Name = "Sector2Time" Then _Time_Update()
		If $Name = "Sector3Time" Then _Time_Update()
		If $Name = "LastLapTime" Then _Time_Update()
		If $Name = "FastestLapTime" Then _Time_Update()

		EndIf
	EndIf


If $Name = "RefId" Then $participants_RefId = $Wert
If $Name = "Name" Then $participants_Name = $Wert
;If $Name = "IsPlayer" Then $participants_IsPlayer = $Wert
If $Name = "GridPosition" Then $participants_GridPosition = $Wert
If $Name = "VehicleId" Then $participants_VehicleId = $Wert
;If $Name = "LiveryId" Then $participants_LiveryId = $Wert
If $Name = "RacePosition" Then $participants_RacePosition = $Wert
If $Name = "CurrentLap" Then $participants_CurrentLap = $Wert
If $Name = "CurrentSector" Then $participants_CurrentSector = $Wert
If $Name = "Sector1Time" Then $participants_Sector1Time = $Wert
If $Name = "Sector2Time" Then $participants_Sector2Time = $Wert
If $Name = "Sector3Time" Then $participants_Sector3Time = $Wert
If $Name = "LastLapTime" Then $participants_LastLapTime = $Wert
If $Name = "FastestLapTime" Then $participants_FastestLapTime = $Wert
If $Name = "State" Then $participants_State = $Wert
;If $Name = "HeadlightsOn" Then $participants_HeadlightsOn = $Wert
;If $Name = "WipersOn" Then $participants_WipersOn = $Wert
If $Name = "Speed" Then $participants_Speed = $Wert
If $Name = "Gear" Then $participants_Gear = $Wert
If $Name = "RPM" Then $participants_RPM = $Wert
If $Name = "PositionX" Then $participants_PositionX = $Wert
If $Name = "PositionY" Then $participants_PositionY = $Wert
If $Name = "PositionZ" Then $participants_PositionZ = $Wert
If $Name = "Orientation" Then $participants_Orientation = $Wert


;MsgBox(0, "", $participants_RefId)

If $participants_Name <> "" Then
	$participants_Name_bea = StringReplace($participants_Name, "[", "<")
	$participants_Name_bea = StringReplace($participants_Name_bea, "]", ">")
EndIf

If $participants_Name_bea = "" Then $participants_Name_bea = $participants_Name


If $Name = "Orientation" Then

	$Check_TrackName = IniRead($Server_Data_INI, "DATA", "TrackName", "")
	$Check_SessionStage = IniRead($TrackMapReplay_INI, "TrackMapReplay", "SessionStage", "")
	$Check_NR_Participants = IniRead($Server_Data_INI, "DATA", "NumParticipantsValid", "")
	$SessionStage = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
	$Check_TrackMapReplay_LOOP_NR = IniRead($TrackMapReplay_INI, "TrackMapReplay", "NR_Records", "")
	$Check_Member_Index_NR = IniRead($Members_Data_INI, $participants_RefId, "index", "")

	$Check_StartTime = IniRead($config_ini, "TEMP", "TMR_Record_Start_Time", "")
	$Check_EndTime = IniRead($config_ini, "TEMP", "TMR_Record_End_Time", "")
	$Check_StartTime_Replay = IniRead($TrackMapReplay_INI, "TrackMapReplay", "Replay_StartTime", "")
	$Check_EndTime_Replay = IniRead($TrackMapReplay_INI, "TrackMapReplay", "Replay_EndTime", "")

	$Check_Log_Start_IndexNR = IniRead($config_ini, "TEMP", "Log_Index_NR", "")

	$Check_PitStops = IniRead($PitStops_ini, $participants_Name_bea, "PitStops","")
	$Check_PenaltyPoints_PP = IniRead($Points_ini, $participants_Name_bea, "PenaltyPoints","")
	$Check_ExperiencePoints_PP = IniRead($Stats_INI, $participants_Name_bea, "ExperiencePoints", "")
	;$Check_PersonalBest_PB = IniRead($Stats_INI, $participants_Name_bea, $CuttentTack & "_" & $Wert_LA_3_Car, "")
	$Check_TrackCuts = IniRead($CutTrack_INI, $participants_Name_bea, "NR_TrackCut", "")
	$Check_Impacts = IniRead($Impact_INI, $participants_Name_bea, "NR_Impact", "")


	If $Check_SessionStage = "" and $Check_TrackMapReplay_LOOP_NR = "" Then
		IniWrite($TrackMapReplay_INI, "TrackMapReplay", "TrackName", $Check_TrackName)
		IniWrite($TrackMapReplay_INI, "TrackMapReplay", "SessionStage", $SessionStage)
		IniWrite($TrackMapReplay_INI, "TrackMapReplay", "NR_Participants", $Check_NR_Participants)
		IniWrite($TrackMapReplay_INI, "TrackMapReplay", "NR_Records", $TrackMapReplay_LOOP_NR)
		IniWrite($TrackMapReplay_INI, "TrackMapReplay", "Index_Start_Line", "")
		IniWrite($TrackMapReplay_INI, "TrackMapReplay", "Log_Index_Start", $Check_Log_Start_IndexNR)
		IniWrite($TrackMapReplay_INI, "TrackMapReplay", "Log_Index_End", "")
		IniWrite($TrackMapReplay_INI, "TrackMapReplay", "Replay_StartTime", $Check_StartTime)
		IniWrite($TrackMapReplay_INI, "TrackMapReplay", "Replay_EndTime", $Check_EndTime)
		FileWriteLine($TrackMapReplay_INI, "")
	EndIf

	If $Check_TrackMapReplay_LOOP_NR = "" Then IniWrite($TrackMapReplay_INI, "TrackMapReplay", "NR_Records", $TrackMapReplay_LOOP_NR)
	If $TrackMapReplay_LOOP_NR <> "" Then IniWrite($TrackMapReplay_INI, "TrackMapReplay", "NR_Records", $TrackMapReplay_LOOP_NR)
	If $Check_StartTime_Replay = "" Then IniWrite($TrackMapReplay_INI, "TrackMapReplay", "Replay_StartTime", $Check_StartTime)
	If $Check_EndTime_Replay = "" Then IniWrite($TrackMapReplay_INI, "TrackMapReplay", "Replay_EndTime", $Check_EndTime)

	IniWrite($TrackMapReplay_INI, "TrackMapReplay", "NR_Participants", $Check_NR_Participants)

	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_RefId", $participants_RefId)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_Name", $participants_Name)
	;IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_IsPlayer", $participants_IsPlayer)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_GridPosition", $participants_GridPosition)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_VehicleId", $participants_VehicleId)
	;IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_LiveryId", $participants_LiveryId)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_RacePosition", $participants_RacePosition)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_CurrentLap", $participants_CurrentLap)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_CurrentSector", $participants_CurrentSector)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_Sector1Time", $participants_Sector1Time)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_Sector2Time", $participants_Sector2Time)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_Sector3Time", $participants_Sector3Time)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_LastLapTime", $participants_LastLapTime)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_FastestLapTime", $participants_FastestLapTime)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_State", $participants_State)
	;IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, "HeadlightsOn", $participants_HeadlightsOn)
	;IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, "WipersOn", $participants_WipersOn)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_Speed", $participants_Speed)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_Gear", $participants_Gear)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_RPM", $participants_RPM)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_PositionX", $participants_PositionX)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_PositionY", $participants_PositionY)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_PositionZ", $participants_PositionZ)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_Orientation", $participants_Orientation)

	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_PitStops", $Check_PitStops)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_PenaltyPoints", $Check_PenaltyPoints_PP)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_ExperiencePoints", $Check_ExperiencePoints_PP)
	;IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_PersonalBest", $Check_PersonalBest_PB)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_TrackCuts", $Check_TrackCuts)
	IniWrite($TrackMapReplay_INI, $Check_Member_Index_NR, $TrackMapReplay_LOOP_NR & "_Impacts", $Check_Impacts)

	;FileWriteLine($TrackMapReplay_INI, "")
	;If $participants_RacePosition = 11 Then $iCount_3 = $Ende_Zeile_NR ; --> Loop Exit after Position 11
EndIf

$Status_TrackMapReplay = IniRead($config_ini, "TEMP", "Status_TrackMapReplay", "")

If $Status_TrackMapReplay <> "Recording" Then
	_Button_Stop_Recording()
	ExitLoop
EndIf


Next

IniWrite($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", $TrackMapReplay_LOOP_NR)

EndFunc

Func _Checkbox_AutoSave()
	$Status_Checkbox = GUICtrlRead($Checkbox_AutoSave)
	If $Status_Checkbox = 1 Then IniWrite($config_ini, "TrackMap", "Checkbox_AutoSave", "true")
	If $Status_Checkbox = 4 Then IniWrite($config_ini, "TrackMap", "Checkbox_AutoSave", "false")
EndFunc

Func _Checkbox_SaveLOG()
	$Status_Checkbox = GUICtrlRead($Checkbox_SaveLOG)
	If $Status_Checkbox = 1 Then IniWrite($config_ini, "TrackMap", "Checkbox_ReadLOG", "true")
	If $Status_Checkbox = 4 Then IniWrite($config_ini, "TrackMap", "Checkbox_ReadLOG", "false")
EndFunc

Func _Checkbox_SET_Start_detection()
;$Status_Checkbox_SET_Start_detection = GUICtrlRead($Checkbox_SET_Start_detection)
;If $Status_Checkbox_SET_Start_detection = 1 Then IniWrite($config_ini, "TrackMap", "Checkbox_Start_detection", "true")
;If $Status_Checkbox_SET_Start_detection = 4 Then IniWrite($config_ini, "TrackMap", "Checkbox_Start_detection", "false")
EndFunc

Func _Checkbox_SET_End_detection()
;$Status_Checkbox_SET_End_detection = GUICtrlRead($Checkbox_SET_End_detection)
;If $Status_Checkbox_SET_End_detection = 1 Then IniWrite($config_ini, "TrackMap", "Checkbox_End_detection", "true")
;If $Status_Checkbox_SET_End_detection = 4 Then IniWrite($config_ini, "TrackMap", "Checkbox_End_detection", "false")
EndFunc

Func _Button_Start_Recording()

	IniWrite($config_ini, "TEMP", "Race_Finished", "")
	IniWrite($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", "")

	$SessionStage = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
	$Start_Time = @HOUR & ":" & @MIN
	$LOG_Index_Start = IniRead($LOG_Data_INI, "DATA", "NR", "")

	IniWrite($config_ini, "TEMP", "TMR_Record_Start_Time", $Start_Time)
	IniWrite($config_ini, "TEMP", "TMR_Record_End_Time", "")
	IniWrite($config_ini, "TEMP", "Status_TrackMapReplay", "Recording")

	IniWrite($TrackMapReplay_INI, "TrackMapReplay", "TrackName", "")
	IniWrite($TrackMapReplay_INI, "TrackMapReplay", "SessionStage", "")
	IniWrite($TrackMapReplay_INI, "TrackMapReplay", "NR_Participants", "")
	IniWrite($TrackMapReplay_INI, "TrackMapReplay", "NR_Records", "")
	IniWrite($TrackMapReplay_INI, "TrackMapReplay", "Index_Start_Line", "")
	IniWrite($TrackMapReplay_INI, "TrackMapReplay", "LOG_Index_Start", $LOG_Index_Start)
	IniWrite($TrackMapReplay_INI, "TrackMapReplay", "LOG_Index_End", "")
	IniWrite($TrackMapReplay_INI, "TrackMapReplay", "Replay_StartTime", "")
	IniWrite($TrackMapReplay_INI, "TrackMapReplay", "Replay_EndTime", "")

	If $TEMP_AM_Command <> ">StartRR" Then
		GUICtrlSetData($SessionStage_Value, $SessionStage)
		GUICtrlSetData($TrackMapReplay_Start_Time, $Start_Time)
		GUICtrlSetData($TrackMapReplay_End_Time, "")
		GUICtrlSetData($TrackMapReplay_Status_Value, "Recording")
		GUICtrlSetColor($TrackMapReplay_Status_Value, $COLOR_RED)
	EndIf

	_DO_LOOP()
EndFunc

Func _Button_Stop_Recording()

	$Status_Checkbox_AutoSave = IniRead($config_ini, "TrackMap", "Checkbox_AutoSave", "")
	$Status_Checkbox_SaveLOG = IniRead($config_ini, "TrackMap", "Checkbox_SaveLOG", "")

	Global $Check_SessionStage = IniRead($TrackMapReplay_INI, "TrackMapReplay", "SessionStage", "")
	Global $Time_Saved = @HOUR & "-" & @MIN
	Global $TrackMapReplay_INI_copy_2 = $Results_Folder & $Check_SessionStage & "_TrackMapReplay_" & $Time_Saved & ".ini"

	$Check_Log_End_IndexNR = IniRead($config_ini, "TEMP", "Log_Index_NR", "")
	IniWrite($TrackMapReplay_INI, "TrackMapReplay", "Log_Index_End", $Check_Log_End_IndexNR)

	$End_Time = @HOUR & ":" & @MIN
	IniWrite($config_ini, "TEMP", "TMR_Record_End_Time", $End_Time)
	IniWrite($TrackMapReplay_INI, "TrackMapReplay", "Replay_EndTime", $End_Time)
	IniWrite($config_ini, "TEMP", "Status_TrackMapReplay", "Recording stopped")
	If $Check_AM_Command <> ">StartRR" and $Check_AM_Command <> ">StopRR" Then GUICtrlSetData($TrackMapReplay_End_Time, $End_Time)

	If $Status_Checkbox_SaveLOG = "true" Then
		_Download_LOG()
		_Add_LOG_2_Replay()
		Sleep(200)
	EndIf

	If $Status_Checkbox_AutoSave = "true" Then
		If FileExists($TrackMapReplay_INI) Then
			FileCopy($TrackMapReplay_INI, $TrackMapReplay_INI_copy_2, $FC_OVERWRITE)
		EndIf

		If $Check_AM_Command <> ">StopRR" Then
			If FileExists($TrackMapReplay_INI_copy_2) Then
				MsgBox(0, "Stopped and Saved", "TrackMapReplay Recording stopped" & @CRLF & @CRLF & "Saved to:" & @CRLF & $TrackMapReplay_INI_copy_2, 3)
			Else
				MsgBox(0, "Attention", "TrackMapReplay File was not Saved!", 3)
			EndIf
		EndIf
	Else
		If $Check_AM_Command <> ">StopRR" Then MsgBox(0, "", "Recording stopped", 3)
	EndIf

	If $Check_AM_Command = ">StopRR" Then
		$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "     "
		$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
		$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN >>>"
		$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
		$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "Replay recording stopped"
		$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
		$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "     "
		$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
		IniWrite($config_ini, "TEMP", "AM_Command", "")
	EndIf
EndFunc

Func _Button_Save()
	Global $Check_SessionStage = IniRead($TrackMapReplay_INI, "TrackMapReplay", "SessionStage", "")
	Global $Time_Saved = @HOUR & "-" & @MIN
	Global $TrackMapReplay_INI_copy_2 = $Results_Folder & $Check_SessionStage & "_TrackMapReplay_" & $Time_Saved & ".ini"

	If FileExists($TrackMapReplay_INI) Then
		Sleep(200)
		FileCopy($TrackMapReplay_INI, $TrackMapReplay_INI_copy_2, $FC_OVERWRITE)
	EndIf

	If FileExists($TrackMapReplay_INI_copy_2) Then
		MsgBox(0, "Saved", "TrackMapReplay Saved:" & @CRLF & @CRLF & $TrackMapReplay_INI_copy_2, 5)
	Else
		MsgBox(0, "Attention", "TrackMapReplay File was not Saved!")
	EndIf

EndFunc

Func _Add_LOG_2_Replay()

	$Replay_LOG_json = $TrackMapReplay_folder & "Replay_Log.json"
	$Last_Line_NR =_FileCountLines($Replay_LOG_json)
	;$Replay_INI = $Results_Folder & "Race1_TrackMapReplay_14-34.ini"
	$Replay_INI = $TrackMapReplay_INI

	IniWrite($Replay_INI, "TrackMapReplay", "Index_Start_Line", $Last_Line_NR + 3)

	FileWriteLine($Replay_INI, "")
	FileWriteLine($Replay_INI, "")
	FileWriteLine($Replay_INI, "----- LOG -----")

	$Replay_INI_open = FileOpen($Replay_INI, $FO_APPEND)

	_FileReadToArray($Replay_LOG_json, $Replay_Array)
	_FileWriteFromArray($Replay_INI_open, $Replay_Array, 1)

	FileClose($Replay_INI_open)

EndFunc


Func _Time_Update()
; Last Lap Time formatieren
	$iMs = $Wert
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

	$LastLapTime_Wert = $sVor & StringRight('0' & Int($iMin), 2) & ':' & StringRight('0' & Int($iSec), 2) & '.' & $Wert_millisekunden
	If $LastLapTime_Wert = "00:00.000" Then $LastLapTime_Wert = ""
	$Wert = $LastLapTime_Wert
EndFunc

Func _Exit_Close() ; Beenden / Exit
Exit
EndFunc

Exit

#endregion Funktionen
