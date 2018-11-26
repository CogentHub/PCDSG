

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

;GFX (Grafik) Verzeichnis
$gfx = (@ScriptDir & "\" & "system\gfx\")

Global $Members_Data_INI = $System_Dir & "Members_Data.ini"

Global $TrackMapReplay_INI = $System_Dir & "TrackMap\TrackMapReplay.ini"
Global $TrackMapReplay_participants_json = $System_Dir & "TrackMap\TrackMapReplay_participants.json"
Global $TrackMapReplay_participants_Data_INI = $System_Dir & "TrackMap\TrackMapReplay_participants_Data.ini"

$Results_Folder = $Data_Dir & "Results\"

Global $Replay_File = IniRead($config_ini, "TrackMap", "Replay_File", "")

If $Replay_File <> "" Then
	Global $TrackMapReplay_INI = $Replay_File
Else
	$TrackMapReplay_INI = $System_Dir & "TrackMap\TrackMapReplay.ini"
EndIf


Global $Server_Status = IniRead($Server_Data_INI, "DATA", "state", "")
If $Server_Status = "" Then $Server_Status = "OFFLINE"
Global $Check_Lobby = IniRead($Server_Data_INI, "DATA", "SessionState", "")
If $Check_Lobby = "Lobby" Then $Server_Status = "Lobby"

Global $Status_TrackMapReplay = IniRead($config_ini, "TEMP", "Status_TrackMapReplay", "")

Global $SessionStage = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
If $SessionStage = "" Then $SessionStage = "-"

Global $TrackMapReplay_LOOP_NR = IniRead($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", "")
If $TrackMapReplay_LOOP_NR = "" Then $TrackMapReplay_LOOP_NR = "0"


Global $TrackName_Replay = IniRead($TrackMapReplay_INI, "TrackMapReplay", "TrackName", "")
Global $SessionStage_Replay = IniRead($TrackMapReplay_INI, "TrackMapReplay", "SessionStage", "")
Global $NR_Participants_Replay = IniRead($TrackMapReplay_INI, "TrackMapReplay", "NR_Participants", "")
Global $NR_Records_Replay = IniRead($TrackMapReplay_INI, "TrackMapReplay", "NR_Records", "")
Global $StartTime_Replay = IniRead($TrackMapReplay_INI, "TrackMapReplay", "StartTime", "")
Global $EndTime_Replay = IniRead($TrackMapReplay_INI, "TrackMapReplay", "EndTime", "")

Global $participants_RefId, $participants_Name, $participants_IsPlayer, $participants_GridPosition, $participants_VehicleId, $participants_LiveryId
Global $participants_RacePosition, $participants_CurrentLap, $participants_CurrentSector, $participants_Sector1Time, $participants_Sector2Time, $participants_Sector3Time
Global $participants_FastestLapTime, $participants_State, $participants_HeadlightsOn, $participants_WipersOn, $participants_Speed
Global $participants_Gear, $participants_RPM, $participants_PositionX, $participants_PositionY, $participants_PositionZ, $participants_Orientation
Global $Wert

Global $font = "Comic Sans MS"
Global $font_2 = "Arial"
Global $font_arial = "arial"

;Server http settings lesen
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


#endregion Declare Variables/Const

#Region Create GUI

 Local $GUI = GUICreate("PCDSG TrackMap Replay - Play Menu", 400, 300, -1, -1, $WS_EX_TOPMOST)

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
GUICtrlCreateGroup("Replay Info:", 3, 50, 388, 110)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
GUICtrlSetColor(-1, "0x0000FF")
GUICtrlSetFont(-1, 13, 400, 6, $font_arial)
#endregion  Create Group

#Region Create Label

GUICtrlCreateLabel("Track Name:", 7, 70, 170, 23)
GUICtrlSetFont(-1, 11, 400, 3, $font) ; will display underlined characters
$TrackMapReplay_Status_Value = GUICtrlCreateLabel($TrackName_Replay, 180, 72, 205, 20)
GUICtrlSetFont($TrackMapReplay_Status_Value, 11, 400, 3, $font_arial) ; will display underlined characters


GUICtrlCreateLabel("Session Stage:", 7, 90, 190, 23)
GUICtrlSetFont(-1, 11, 400, 3, $font) ; will display underlined characters
$SessionStage_Value = GUICtrlCreateLabel($SessionStage_Replay, 180, 92, 170, 20)
GUICtrlSetFont($SessionStage_Value, 11, 400, 3, $font_arial) ; will display underlined characters
GUICtrlSetColor(-1, $COLOR_BLUE)
If $SessionStage = "OFFLINE" Then GUICtrlSetColor(-1, $COLOR_RED)

GUICtrlCreateLabel("Number of Participants:", 7, 110, 170, 23)
GUICtrlSetFont(-1, 11, 400, 3, $font) ; will display underlined characters
$TrackMapReplay_Status_Value = GUICtrlCreateLabel($NR_Participants_Replay, 180, 112, 170, 20)
GUICtrlSetFont($TrackMapReplay_Status_Value, 11, 400, 3, $font_arial) ; will display underlined characters
GUICtrlSetColor($TrackMapReplay_Status_Value, $COLOR_RED)
If $Status_TrackMapReplay = "Recording stopped" Then GUICtrlSetColor($TrackMapReplay_Status_Value, $COLOR_BLUE)
If $Status_TrackMapReplay = "Replay stopped" Then GUICtrlSetColor($TrackMapReplay_Status_Value, $COLOR_BLUE)

GUICtrlCreateLabel("Number of Records:", 7, 130, 180, 23)
GUICtrlSetFont(-1, 11, 400, 3, $font) ; will display underlined characters
$Number_of_Records_Value = GUICtrlCreateLabel($NR_Records_Replay, 180, 132, 170, 20)
GUICtrlSetFont($Number_of_Records_Value, 11, 400, 3, $font_arial) ; will display underlined characters
GUICtrlSetColor($Number_of_Records_Value, $COLOR_RED)
If $TrackMapReplay_LOOP_NR = "0" Then GUICtrlSetColor($Number_of_Records_Value, $COLOR_BLUE)

Global $TMR_Record_Start_Time = IniRead($config_ini, "TEMP", "TMR_Record_Start_Time", "")
GUICtrlCreateLabel("[", 221, 133, 5, 23)
GUICtrlCreateLabel("Start:", 225, 132, 45, 23)
GUICtrlSetFont(-1, 9, 400, 3, $font) ; will display underlined characters
$TrackMapReplay_Start_Time = GUICtrlCreateLabel($StartTime_Replay, 265, 132, 50, 20)
GUICtrlSetFont($TrackMapReplay_Start_Time, 9, 400, 4, $font) ; will display underlined characters

Global $TMR_Record_End_Time = IniRead($config_ini, "TEMP", "TMR_Record_End_Time", "")
GUICtrlCreateLabel("End:", 315, 132, 45, 23)
GUICtrlSetFont(-1, 9, 400, 3, $font) ; will display underlined characters
$TrackMapReplay_End_Time = GUICtrlCreateLabel($EndTime_Replay, 342, 132, 35, 20)
GUICtrlSetFont($TrackMapReplay_End_Time, 9, 400, 4, $font) ; will display underlined characters
GUICtrlCreateLabel("]", 376, 133, 5, 23)

#endregion  Create Label

#Region Create GUI Checkbox

$Status_Checkbox_SET_Start_detection = IniRead($config_ini, "TrackMap", "Checkbox_Start_detection", "")
$Status_Checkbox_SET_End_detection = IniRead($config_ini, "TrackMap", "Checkbox_End_detection", "")

;Global $Checkbox_SET_Start_detection = GUICtrlCreateCheckbox(" Automatic Start detection", 7, 164, 150, 15)
	;If $Status_Checkbox_SET_Start_detection = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
;GUICtrlSetOnEvent($Checkbox_SET_Start_detection, "_Checkbox_SET_Start_detection")

;Global $Checkbox_SET_End_detection = GUICtrlCreateCheckbox(" Automatic End detection", 7, 181, 150, 15)
	;If $Status_Checkbox_SET_End_detection = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
;GUICtrlSetOnEvent($Checkbox_SET_End_detection, "_Checkbox_SET_End_detection")

#endregion Create GUI Checkbox


#Region Create GUI UPDOWN

;Label
GUICtrlCreateLabel("Replay - Time speed:", 10, 165, 100, 20)

; UPDOWN Play Speed
Global $Value_Replay_PlaySpeed = IniRead($config_ini, "TrackMap", "Replay_PlaySpeed", "")
Global $Input_Replay_PlaySpeed = GUICtrlCreateInput($Value_Replay_PlaySpeed, 115, 162, 42, 19)
GUICtrlSetFont(-1, 11, $FW_NORMAL, "", $font_2)
Global $UpDown_Replay_PlaySpeed = GUICtrlCreateUpdown($Input_Replay_PlaySpeed)
GUICtrlSetOnEvent($UpDown_Replay_PlaySpeed, "_UPDOWN_PlaySpeed")

#endregion Create GUI UPDOWN

#Region Create GUI Buttons

Local $Button_Stop_Playing = GUICtrlCreateButton(" Stop Playing Replay ", 5, 5, 384, 42) ; 190
GUICtrlSetFont(-1, 17, $FW_NORMAL, "", $font_2)
_GUICtrlButton_SetImage($Button_Stop_Playing, "wmploc.DLL", 155, true)
GUICtrlSetOnEvent($Button_Stop_Playing, "_Button_Stop_Playing")

Local $Button_Save = GUICtrlCreateButton(" " & "Save Results from Replay", 5, 200, 190, 42)
GUICtrlSetFont(-1, 9, $FW_NORMAL, "", $font_2)
_GUICtrlButton_SetImage($Button_Save, "imageres.dll", 23, true)
GUICtrlSetOnEvent($Button_Save, "_Button_Save")

Local $Button_Exit_Close = GUICtrlCreateButton("Exit | Close", 200, 200, 190, 42)
GUICtrlSetFont(-1, 12, $FW_NORMAL, "", $font_2)
_GUICtrlButton_SetImage($Button_Exit_Close, "shell32.dll", 215, true)
GUICtrlSetOnEvent($Button_Exit_Close, "_Exit_Close")


#endregion  Create GUI Buttons

$timestamp = _NowDate() & " - " & _NowTime()

_GUICtrlStatusBar_SetText($Statusbar, $Server_Status & " - " & $Status_TrackMapReplay & @TAB & @TAB & "Timestamp: " & $timestamp)


; Display the GUI.
GUISetState(@SW_SHOW, $GUI)

;IniWrite($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", "")
;FileDelete($TrackMapReplay_INI)
;FileDelete($TrackMapReplay_participants_json)
;FileDelete($TrackMapReplay_participants_Data_INI)

#region LOOP

;_DO_LOOP()

#EndRegion


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


Func _Download()
$URL_participants = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/status?attributes&participants"

$download = InetGet($URL_participants, $TrackMapReplay_participants_json, 16, 0)
EndFunc

Func _Button_Stop_Playing()
	IniWrite($config_ini, "TEMP", "Status_TrackMapReplay", "Replay stopped")
	IniWrite($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", "")
EndFunc

Func _Button_Save()

	$Abfrage = MsgBox(4, "Save Results from Replay", "Function not finished...working on it.", 5)

	If $Abfrage = 6 Then ;Ja - Auswahl = JA
		Global $Index_LOG, $Last_Index_LOG, $Index_LOG_old, $Log_LOOP_NR

		$Log_Start_Line = IniRead($TrackMapReplay_INI, "TrackMapReplay", "Index_Start_Line", "")
		$Anzahl_Zeilen_LOG = _FileCountLines($TrackMapReplay_INI)

		MsgBox(0, "Save Results from Replay", $Log_Start_Line & " - " & $Anzahl_Zeilen_LOG)

		;Exit

		For $Log_LOOP_NR = $Log_Start_Line To $Anzahl_Zeilen_LOG

			$Wert_Zeile = FileReadLine($TrackMapReplay_INI, $Log_LOOP_NR)
			$Wert_Zeile = StringSplit(StringTrimLeft($Wert_Zeile, 1), ":")
			$Name = $Wert_Zeile[1]
			$Name = StringReplace($Name, " ", "")
			$Name = StringReplace($Name, " ", "")
			$Name = StringReplace($Name, " ", "")
			$Name = StringTrimLeft($Name, 1)
			$Name = StringTrimRight($Name, 1)

			If $Wert_Zeile[0] = 2 Then
				$Wert = StringTrimLeft($Wert_Zeile[2], 1)
				$Wert = StringTrimLeft($Wert_Zeile[2], 1)
				$Wert = StringReplace($Wert, ',', '')
				$Wert = StringReplace($Wert, '"', '')


				If $Name = "index" Then
					$LOG_Index_NR = $Wert
				EndIf

				If $Name = "name" Then
					If $Wert = "Lap" Then
						$LOG_name_Value = $Wert

						$Wert_time = FileReadLine($TrackMapReplay_INI, $Log_LOOP_NR - 1)
						$Wert_time = StringReplace($Wert_time, '        "time" : ', '')
						$Wert_time = StringReplace($Wert_time, ',', '')

						$Wert_name = FileReadLine($TrackMapReplay_INI, $Log_LOOP_NR)
						$Wert_name = StringReplace($Wert_name, '        "name" : "', '')
						$Wert_name = StringReplace($Wert_name, ',', '')

						$Wert_refid = ""
						$Wert_refid = FileReadLine($TrackMapReplay_INI, $Log_LOOP_NR + 1)
						$Wert_refid = StringReplace($Wert_refid, '        "refid" : ', '')
						$Wert_refid = StringReplace($Wert_refid, ',', '')

						$Wert_participantid = FileReadLine($TrackMapReplay_INI, $Log_LOOP_NR + 2)
						$Wert_participantid = StringReplace($Wert_participantid, '        "participantid" : ', '')
						$Wert_participantid = StringReplace($Wert_participantid, ',', '')

						$Wert_Lap = FileReadLine($TrackMapReplay_INI, $Log_LOOP_NR + 4)
						$Wert_Lap = StringReplace($Wert_Lap, '          "Lap" : ', '')
						$Wert_Lap = StringReplace($Wert_Lap, ',', '')
						$Wert_Lap = StringReplace($Wert_Lap, '"', '')

						$Wert_LapTime = FileReadLine($TrackMapReplay_INI, $Log_LOOP_NR + 5)
						$Wert_LapTime = StringReplace($Wert_LapTime, '          "LapTime" : ', '')
						$Wert_LapTime = StringReplace($Wert_LapTime, ',', '')
						$Wert = $Wert_LapTime
						_Time_Update()
						$Wert_LapTime = $Wert

						$Wert_Sector1Time = FileReadLine($TrackMapReplay_INI, $Log_LOOP_NR + 6)
						$Wert_Sector1Time = StringReplace($Wert_Sector1Time, '          "Sector1Time" : ', '')
						$Wert_Sector1Time = StringReplace($Wert_Sector1Time, ',', '')
						$Wert = $Wert_Sector1Time
						_Time_Update()
						$Wert_Sector1Time = $Wert

						$Wert_Sector2Time = FileReadLine($TrackMapReplay_INI, $Log_LOOP_NR + 7)
						$Wert_Sector2Time = StringReplace($Wert_Sector2Time, '          "Sector2Time" : ', '')
						$Wert_Sector2Time = StringReplace($Wert_Sector2Time, ',', '')
						$Wert = $Wert_Sector2Time
						_Time_Update()
						$Wert_Sector2Time = $Wert

						$Wert_Sector3Time = FileReadLine($TrackMapReplay_INI, $Log_LOOP_NR + 8)
						$Wert_Sector3Time = StringReplace($Wert_Sector3Time, '          "Sector3Time" : ', '')
						$Wert_Sector3Time = StringReplace($Wert_Sector3Time, ',', '')
						$Wert = $Wert_Sector3Time
						_Time_Update()
						$Wert_Sector3Time = $Wert

						$Wert_RacePosition = FileReadLine($TrackMapReplay_INI, $Log_LOOP_NR + 9)
						$Wert_RacePosition = StringReplace($Wert_RacePosition, '          "RacePosition" : ', '')
						$Wert_RacePosition = StringReplace($Wert_RacePosition, ',', '')

						$Wert_DistanceTravelled = FileReadLine($TrackMapReplay_INI, $Log_LOOP_NR + 10)
						$Wert_DistanceTravelled = StringReplace($Wert_DistanceTravelled, '          "DistanceTravelled" : ', '')
						$Wert_DistanceTravelled = StringReplace($Wert_DistanceTravelled, ',', '')

						$Wert_CountThisLapTimes = FileReadLine($TrackMapReplay_INI, $Log_LOOP_NR + 11)
						$Wert_CountThisLapTimes = StringReplace($Wert_CountThisLapTimes, '          "CountThisLapTimes" : ', '')

						MsgBox(0, "", "time: " & $Wert_time & @CRLF & _
										"name: " & $Wert_name & @CRLF & _
										"refid: " & $Wert_refid & @CRLF & _
										"participantid: " & $Wert_participantid & @CRLF & _
										"Lap: " & $Wert_Lap & @CRLF & _
										"LapTime: " & $Wert_LapTime & @CRLF & _
										"Sector1Time: " & $Wert_Sector1Time & @CRLF & _
										"Sector2Time: " & $Wert_Sector1Time & @CRLF & _
										"Sector3Time: " & $Wert_Sector1Time & @CRLF & _
										"RacePosition: " & $Wert_RacePosition & @CRLF & _
										"DistanceTravelled: " & $Wert_DistanceTravelled & @CRLF & _
										"CountThisLapTimes: " & $Wert_CountThisLapTimes)

					EndIf


				EndIf


			EndIf

		Next

	EndIf

EndFunc

Func _UPDOWN_PlaySpeed()
	$UPDOWN_Read_PlaySpeed = GUICtrlRead($Input_Replay_PlaySpeed)

	If $UPDOWN_Read_PlaySpeed = "" Then	$UPDOWN_Read_PlaySpeed = 1
	If $UPDOWN_Read_PlaySpeed < 1 Then $UPDOWN_Read_PlaySpeed = 1
	If $UPDOWN_Read_PlaySpeed > 9 Then $UPDOWN_Read_PlaySpeed = 9

	GUICtrlSetData ($Input_Replay_PlaySpeed, $UPDOWN_Read_PlaySpeed)
	IniWrite($config_ini, "TrackMap", "Replay_PlaySpeed", $UPDOWN_Read_PlaySpeed)
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
