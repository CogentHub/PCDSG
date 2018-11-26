

#include <File.au3>
#include <Array.au3>
#include <string.au3>
#include <date.au3>


$config_ini = (@ScriptDir & "\" & "config.ini")
$install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
Global $System_Dir = $install_dir & "system\"
Global $Data_Dir = $install_dir & "data\"

$status_json = @ScriptDir & "\status.json"
$members_json = @ScriptDir & "\members.json"
$participants_json = @ScriptDir & "\participants.json"
$LOG_Data_json = @ScriptDir & "\Server_LOG.json"
$Server_Data_INI = @ScriptDir & "\" & "Server_Data.ini"
$Members_Data_INI = @ScriptDir & "\" & "Members_Data.ini"
$Participants_Data_INI = @ScriptDir & "\" & "Participants_Data.ini"
$UserHistory_ini = ($install_dir & "system\UserHistory.ini")
$LOG_Data_INI = @ScriptDir & "\Server_LOG.ini"
Global $PCDSG_LOG_ini = $System_Dir & "PCDSG_LOG.ini"

Global $Wert_Track_ID_search

$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")

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


$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/status?attributes"
$URL_members = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/status?attributes&members"
$URL_participants = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/status?attributes&participants"
$URL_LOG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/log/range?offset=-20&count=20"


;FileDelete($status_json)
;FileDelete($members_json)
$download = InetGet($URL, $status_json, 16, 0)
;MsgBox(0, "", $download, 5)

If $download <> "0" Then
	$download_members = InetGet($URL_members, $members_json, 16, 0)
	$download_participants = InetGet($URL_participants, $participants_json, 16, 0)
	$download_LOG = InetGet($URL_LOG, $LOG_Data_json, 16, 0)
EndIf


If $PC_Server_Status <> "PC_Server_beendet" Then
	If Not FileExists($status_json) Then
		;MsgBox(4144, "Status.json", "Status.json File could not be created." & @CRLF & @CRLF & "Data Update was not possible > Forced to EXIT" & @CRLF & @CRLF & "This message disappears in 3 seconds...", 3)
		Exit
	EndIf
EndIf

;Sleep(100)

Global $hOpen, $asRead, $asRead2, $asRead3, $asRead4, $asTemp, $iCount, $iCount_2, $iCount_3, $iCount_4, $asSplit, $iSec, $Wert, $Schleifen_Durchgang, $Schleifen_Wert_NR

_FileReadToArray($status_json, $asRead)
_FileReadToArray($LOG_Data_json, $asRead2)
$Anzahl_Zeilen = UBound($asRead) - 1
$Anzahl_Zeilen_status_json = UBound($asRead) - 1
$Anzahl_Zeilen_LOG_Data_json = UBound($asRead2) - 1


If Not IsArray($asRead) Then
	Sleep(100)
	_FileReadToArray($status_json, $asRead)
	;_ArrayDisplay($asRead)
EndIf


If Not IsArray($asRead) Then
	MsgBox(4144, "status.json", "Status.json File don't have any content." & @CRLF & @CRLF & "Data Update was not possible > Forced to EXIT")
	Exit
EndIf

Sleep(100)

;MsgBox(0, "", IniRead($config_ini, "PC_Server", "Checkbox_Update_5", ""))

;MsgBox(0, "", $download)

If IniRead($config_ini, "PC_Server", "Checkbox_Update_1", "") = "true" Then _Server_Daten_Update()

$Check_DS_State = IniRead($Server_Data_INI, "DATA", "state", "")

If $Check_DS_State <> "Idle" Then
	;If IniRead($config_ini, "PC_Server", "Checkbox_Update_1", "") = "true" Then _Server_Daten_Update()
	If IniRead($config_ini, "PC_Server", "Checkbox_Update_5", "") = "true" Then _Members_Daten_Update()
	If IniRead($config_ini, "PC_Server", "Checkbox_Update_3", "") = "true" Then _Participants_Daten_Update()
	If IniRead($config_ini, "PC_Server", "Checkbox_Update_4", "") = "true" Then _LOG_Daten_Update()
	If IniRead($config_ini, "PC_Server", "Checkbox_Update_2", "") = "true" Then _UserHistory_Daten_Update()
EndIf



Func _Server_Daten_Update()

$Anzahl_Zeilen = UBound($asRead) - 1
;MsgBox(0, "", $Anzahl_Zeilen, 5)

$Check_Inhalt_json = FileRead($status_json)

If $Anzahl_Zeilen > 55 Then

	For $iCount_1 = 4 To $Anzahl_Zeilen ; 74

			$Wert_Zeile = FileReadLine($status_json, $iCount_1)
			$Wert_Zeile = StringSplit(StringTrimLeft($Wert_Zeile, 1), ":")

			$Name = ""
			$Wert = ""

		;MsgBox(0, "", UBound($Wert_Zeile - 1))
		If UBound($Wert_Zeile - 1) = 3 Then
		;If IsArray($Wert_Zeile) Then
			$Name = $Wert_Zeile[1]
			$Name = StringReplace($Name, " ", "")
			$Name = StringReplace($Name, " ", "")
			$Name = StringReplace($Name, " ", "")
			$Name = StringTrimLeft($Name, 1)
			$Name = StringTrimRight($Name, 1)

			$Wert = StringTrimLeft($Wert_Zeile[2], 1)

			$Wert = StringTrimLeft($Wert_Zeile[2], 1)
			$Wert = StringTrimRight($Wert, 1)
			$Wert = StringReplace($Wert, '"', '')
		EndIf


	If $Name = "SessionTimeElapsed" Then
	$iSec = $Wert
	_SessionTime_Update()
	EndIf

	If $Name = "SessionTimeDuration" Then
	$iSession = IniRead($Server_Data_INI, "DATA", "Value_42", "")
	If $iSession = "Training1" Then $Wert = IniRead($Server_Data_INI, "DATA", "Practice1Length", "") & ":00"
	If $iSession = "Training2" Then $Wert = IniRead($Server_Data_INI, "DATA", "Practice2Length", "") & ":00"
	If $iSession = "Qualifying" Then $Wert = IniRead($Server_Data_INI, "DATA", "QualifyLength", "") & ":00"
	EndIf

	If $Name <> "attributes" Then
		If $Name <> "" Then
			IniWrite($Server_Data_INI, "DATA", $Name, $Wert)
			;MsgBox(0, "", $Name)
			If $Name = "TrackId" Then
				IniWrite($config_ini, "TEMP", "Check_Trackid", $Wert)
				_TRACK_NAME_Grid_from_ID()
				$TrackName_from_ID = IniRead($config_ini, "TEMP", "Check_TrackName", "")
				$Gridsize_from_ID = IniRead($config_ini, "TEMP", "Check_Gridsize", "")
				IniWrite($Server_Data_INI, "DATA", "TrackName", $TrackName_from_ID)
				IniWrite($Server_Data_INI, "DATA", "TrackGridsize", $Gridsize_from_ID)
				IniWrite($config_ini, "Server_Einstellungen", "CurrentTrackID", $Wert)
				IniWrite($config_ini, "Server_Einstellungen", "CurrentTrackName", $TrackName_from_ID)
				IniWrite($config_ini, "Server_Einstellungen", "CurrentGridsize", $Gridsize_from_ID)
			EndIf

		EndIf
	EndIf

	Next

EndIf

$Server_State = IniRead($Server_Data_INI, "DATA", "state", "")
IniWrite($config_ini, "PC_Server", "Server_State", $Server_State)

$SessionStage_Check = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
IniWrite($config_ini, "PC_Server", "Session_Stage", $SessionStage_Check)

EndFunc

Func _Members_Daten_Update()

Global $iCount_2, $Ende_Schleife_iCount_2, $NumParticipantsValid

If FileExists($Members_Data_INI) Then
	$EmptyFile = FileOpen($Members_Data_INI, 2)
	FileWrite($EmptyFile, "")
	FileClose($EmptyFile)
EndIf


$Ende_Zeile_NR = _FileCountLines($members_json) - 1

	$members_name = ""
	$members_name_bea = ""
	$Name = ""
	$Wert = ""

For $iCount_2 = 77 To $Ende_Zeile_NR ;$Ende_Schleife_iCount_2

	$Wert_Zeile = FileReadLine($members_json, $iCount_2)
	;MsgBox(0, "", $Wert_Zeile)
	$Wert_Zeile = StringReplace($Wert_Zeile, "}", "")
	$Wert_Zeile = StringReplace($Wert_Zeile, "{", "")
	$Wert_Zeile = StringSplit(StringTrimLeft($Wert_Zeile, 1), ":")
	$Name = $Wert_Zeile[1]
	$Name = StringReplace($Name, " ", "")
	$Name = StringReplace($Name, " ", "")
	$Name = StringReplace($Name, " ", "")
	$Name = StringTrimLeft($Name, 1)
	$Name = StringTrimRight($Name, 1)
	;MsgBox(0, "", $Name)

		If $Name <> "" Then
			$Wert = StringTrimLeft($Wert_Zeile[2], 1)
			$Wert = StringTrimLeft($Wert_Zeile[2], 1)
			$Wert = StringTrimRight($Wert, 1)
			$Wert = StringReplace($Wert, '"', '')
			;MsgBox(0, "", $Wert)
		EndIf

$Wert_Name = ""
If $Name = "name" Then $Wert_Name = $Wert

If $Name = "index" Then $members_index = $Wert
If $Name = "refid" Then $members_refid = $Wert
If $Name = "steamid" Then $members_steamid = $Wert
If $Name = "state" Then $members_state = $Wert
If $Name = "name" Then $members_name = $Wert
If $Name = "jointime" Then $members_jointime = $Wert
If $Name = "host" Then $members_host = $Wert
If $Name = "VehicleId" Then $members_VehicleId = $Wert
If $Name = "LiveryId" Then $members_LiveryId = $Wert
If $Name = "LoadState" Then $members_LoadState = $Wert
If $Name = "RaceStatFlags" Then $members_RaceStatFlags = $Wert
If $Name = "Ping" Then $members_Ping = $Wert


If $members_name <> "" Then
	$members_name_bea = StringReplace($members_name, "[", "<")
	$members_name_bea = StringReplace($members_name_bea, "]", ">")
EndIf

If $members_name_bea = "" Then $members_name_bea = $members_name


If $Name = "Ping" Then
	IniWrite($Members_Data_INI, $members_refid, "index", $members_index)
	IniWrite($Members_Data_INI, $members_refid, "refid", $members_refid)
	IniWrite($Members_Data_INI, $members_refid, "steamid", $members_steamid)
	IniWrite($Members_Data_INI, $members_refid, "state", $members_state)
	IniWrite($Members_Data_INI, $members_refid, "name", $members_name)
	IniWrite($Members_Data_INI, $members_refid, "jointime", $members_jointime)
	IniWrite($Members_Data_INI, $members_refid, "host", $members_host)
	IniWrite($Members_Data_INI, $members_refid, "VehicleId", $members_VehicleId)
	IniWrite($Members_Data_INI, $members_refid, "LiveryId", $members_LiveryId)
	IniWrite($Members_Data_INI, $members_refid, "LoadState", $members_LoadState)
	IniWrite($Members_Data_INI, $members_refid, "RaceStatFlags", $members_RaceStatFlags)
	IniWrite($Members_Data_INI, $members_refid, "Ping", $members_Ping)
	FileWriteLine($Members_Data_INI, "")

	IniWrite($Members_Data_INI, $members_index, "index", $members_index)
	IniWrite($Members_Data_INI, $members_index, "refid", $members_refid)
	IniWrite($Members_Data_INI, $members_index, "steamid", $members_steamid)
	IniWrite($Members_Data_INI, $members_index, "state", $members_state)
	IniWrite($Members_Data_INI, $members_index, "name", $members_name)
	IniWrite($Members_Data_INI, $members_index, "jointime", $members_jointime)
	IniWrite($Members_Data_INI, $members_index, "host", $members_host)
	IniWrite($Members_Data_INI, $members_index, "VehicleId", $members_VehicleId)
	IniWrite($Members_Data_INI, $members_index, "LiveryId", $members_LiveryId)
	IniWrite($Members_Data_INI, $members_index, "LoadState", $members_LoadState)
	IniWrite($Members_Data_INI, $members_index, "RaceStatFlags", $members_RaceStatFlags)
	IniWrite($Members_Data_INI, $members_index, "Ping", $members_Ping)
	FileWriteLine($Members_Data_INI, "")

	IniWrite($Members_Data_INI, $members_name_bea, "index", $members_index)
	IniWrite($Members_Data_INI, $members_name_bea, "refid", $members_refid)
	IniWrite($Members_Data_INI, $members_name_bea, "steamid", $members_steamid)
	IniWrite($Members_Data_INI, $members_name_bea, "state", $members_state)
	IniWrite($Members_Data_INI, $members_name_bea, "name", $members_name)
	IniWrite($Members_Data_INI, $members_name_bea, "jointime", $members_jointime)
	IniWrite($Members_Data_INI, $members_name_bea, "host", $members_host)
	IniWrite($Members_Data_INI, $members_name_bea, "VehicleId", $members_VehicleId)
	IniWrite($Members_Data_INI, $members_name_bea, "LiveryId", $members_LiveryId)
	IniWrite($Members_Data_INI, $members_name_bea, "LoadState", $members_LoadState)
	IniWrite($Members_Data_INI, $members_name_bea, "RaceStatFlags", $members_RaceStatFlags)
	IniWrite($Members_Data_INI, $members_name_bea, "Ping", $members_Ping)
	FileWriteLine($Members_Data_INI, "")
EndIf

If $Name = "Ping" Then
	$Schleifen_Durchgang = $Schleifen_Durchgang + 1
	$Schleifen_Wert_NR = "-3"
EndIf

$Schleifen_Wert_NR = $Schleifen_Wert_NR + 1



Next


EndFunc

Func _Participants_Daten_Update()

$Ende_Zeile_NR = _FileCountLines($participants_json) - 1

	$participants_Name = ""
	$participants_Name_bea = ""
	$Name = ""
	$Wert = ""

If FileExists($Participants_Data_INI) Then
	$EmptyFile = FileOpen($Participants_Data_INI, 2)
	FileWrite($EmptyFile, "")
	FileClose($EmptyFile)
EndIf

For $iCount_3 = 77 To $Ende_Zeile_NR

	$Wert_Zeile = FileReadLine($participants_json, $iCount_3)
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

Global $participants_RefId, $participants_Name, $participants_IsPlayer, $participants_GridPosition, $participants_VehicleId, $participants_LiveryId
Global $participants_RacePosition, $participants_CurrentLap, $participants_CurrentSector, $participants_Sector1Time, $participants_Sector2Time, $participants_Sector3Time
Global $participants_FastestLapTime, $participants_State, $participants_HeadlightsOn, $participants_WipersOn, $participants_Speed
Global $participants_Gear, $participants_RPM, $participants_PositionX, $participants_PositionY, $participants_PositionZ, $participants_Orientation

If $Name = "RefId" Then $participants_RefId = $Wert
If $Name = "Name" Then $participants_Name = $Wert
If $Name = "IsPlayer" Then $participants_IsPlayer = $Wert
If $Name = "GridPosition" Then $participants_GridPosition = $Wert
If $Name = "VehicleId" Then $participants_VehicleId = $Wert
If $Name = "LiveryId" Then $participants_LiveryId = $Wert
If $Name = "RacePosition" Then $participants_RacePosition = $Wert
If $Name = "CurrentLap" Then $participants_CurrentLap = $Wert
If $Name = "CurrentSector" Then $participants_CurrentSector = $Wert
If $Name = "Sector1Time" Then $participants_Sector1Time = $Wert
If $Name = "Sector2Time" Then $participants_Sector2Time = $Wert
If $Name = "Sector3Time" Then $participants_Sector3Time = $Wert
If $Name = "LastLapTime" Then $participants_LastLapTime = $Wert
If $Name = "FastestLapTime" Then $participants_FastestLapTime = $Wert
If $Name = "State" Then $participants_State = $Wert
If $Name = "HeadlightsOn" Then $participants_HeadlightsOn = $Wert
If $Name = "WipersOn" Then $participants_WipersOn = $Wert
If $Name = "Speed" Then $participants_Speed = $Wert
If $Name = "Gear" Then $participants_Gear = $Wert
If $Name = "RPM" Then $participants_RPM = $Wert
If $Name = "PositionX" Then $participants_PositionX = $Wert
If $Name = "PositionY" Then $participants_PositionY = $Wert
If $Name = "PositionZ" Then $participants_PositionZ = $Wert
If $Name = "Orientation" Then $participants_Orientation = $Wert

If $participants_Name <> "" Then
	$participants_Name_bea = StringReplace($participants_Name, "[", "<")
	$participants_Name_bea = StringReplace($participants_Name_bea, "]", ">")
EndIf

If $participants_Name_bea = "" Then $participants_Name_bea = $participants_Name


If $Name = "Orientation" Then
	IniWrite($Participants_Data_INI, $participants_RefId, "RefId", $participants_RefId)
	IniWrite($Participants_Data_INI, $participants_RefId, "Name", $participants_Name)
	IniWrite($Participants_Data_INI, $participants_RefId, "IsPlayer", $participants_IsPlayer)
	IniWrite($Participants_Data_INI, $participants_RefId, "GridPosition", $participants_GridPosition)
	IniWrite($Participants_Data_INI, $participants_RefId, "VehicleId", $participants_VehicleId)
	IniWrite($Participants_Data_INI, $participants_RefId, "LiveryId", $participants_LiveryId)
	IniWrite($Participants_Data_INI, $participants_RefId, "RacePosition", $participants_RacePosition)
	IniWrite($Participants_Data_INI, $participants_RefId, "CurrentLap", $participants_CurrentLap)
	IniWrite($Participants_Data_INI, $participants_RefId, "CurrentSector", $participants_CurrentSector)
	IniWrite($Participants_Data_INI, $participants_RefId, "Sector1Time", $participants_Sector1Time)
	IniWrite($Participants_Data_INI, $participants_RefId, "Sector2Time", $participants_Sector2Time)
	IniWrite($Participants_Data_INI, $participants_RefId, "Sector3Time", $participants_Sector3Time)
	IniWrite($Participants_Data_INI, $participants_RefId, "LastLapTime", $participants_LastLapTime)
	IniWrite($Participants_Data_INI, $participants_RefId, "FastestLapTime", $participants_FastestLapTime)
	IniWrite($Participants_Data_INI, $participants_RefId, "State", $participants_State)
	IniWrite($Participants_Data_INI, $participants_RefId, "HeadlightsOn", $participants_HeadlightsOn)
	IniWrite($Participants_Data_INI, $participants_RefId, "WipersOn", $participants_WipersOn)
	IniWrite($Participants_Data_INI, $participants_RefId, "Speed", $participants_Speed)
	IniWrite($Participants_Data_INI, $participants_RefId, "Gear", $participants_Gear)
	IniWrite($Participants_Data_INI, $participants_RefId, "RPM", $participants_RPM)
	IniWrite($Participants_Data_INI, $participants_RefId, "PositionX", $participants_PositionX)
	IniWrite($Participants_Data_INI, $participants_RefId, "PositionY", $participants_PositionY)
	IniWrite($Participants_Data_INI, $participants_RefId, "PositionZ", $participants_PositionZ)
	IniWrite($Participants_Data_INI, $participants_RefId, "Orientation", $participants_Orientation)
	FileWriteLine($Participants_Data_INI, "")

	IniWrite($Participants_Data_INI, $participants_RacePosition, "RefId", $participants_RefId)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "Name", $participants_Name)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "IsPlayer", $participants_IsPlayer)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "GridPosition", $participants_GridPosition)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "VehicleId", $participants_VehicleId)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "LiveryId", $participants_LiveryId)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "RacePosition", $participants_RacePosition)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "CurrentLap", $participants_CurrentLap)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "CurrentSector", $participants_CurrentSector)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "Sector1Time", $participants_Sector1Time)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "Sector2Time", $participants_Sector2Time)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "Sector3Time", $participants_Sector3Time)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "LastLapTime", $participants_LastLapTime)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "FastestLapTime", $participants_FastestLapTime)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "State", $participants_State)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "HeadlightsOn", $participants_HeadlightsOn)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "WipersOn", $participants_WipersOn)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "Speed", $participants_Speed)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "Gear", $participants_Gear)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "RPM", $participants_RPM)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "PositionX", $participants_PositionX)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "PositionY", $participants_PositionY)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "PositionZ", $participants_PositionZ)
	IniWrite($Participants_Data_INI, $participants_RacePosition, "Orientation", $participants_Orientation)
	FileWriteLine($Participants_Data_INI, "")

	IniWrite($Participants_Data_INI, $participants_Name_bea, "RefId", $participants_RefId)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "Name", $participants_Name)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "IsPlayer", $participants_IsPlayer)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "GridPosition", $participants_GridPosition)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "VehicleId", $participants_VehicleId)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "LiveryId", $participants_LiveryId)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "RacePosition", $participants_RacePosition)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "CurrentLap", $participants_CurrentLap)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "CurrentSector", $participants_CurrentSector)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "Sector1Time", $participants_Sector1Time)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "Sector2Time", $participants_Sector2Time)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "Sector3Time", $participants_Sector3Time)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "LastLapTime", $participants_LastLapTime)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "FastestLapTime", $participants_FastestLapTime)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "State", $participants_State)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "HeadlightsOn", $participants_HeadlightsOn)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "WipersOn", $participants_WipersOn)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "Speed", $participants_Speed)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "Gear", $participants_Gear)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "RPM", $participants_RPM)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "PositionX", $participants_PositionX)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "PositionY", $participants_PositionY)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "PositionZ", $participants_PositionZ)
	IniWrite($Participants_Data_INI, $participants_Name_bea, "Orientation", $participants_Orientation)
	FileWriteLine($Participants_Data_INI, "")
EndIf

Next

EndFunc

Func _LOG_Daten_Update()

Global $Index_LOG, $Last_Index_LOG, $Index_LOG_old

$Last_Index_LOG = IniRead($LOG_Data_INI, "DATA", "NR", "")

$Anzahl_Zeilen_LOG = UBound($asRead2)

;MsgBox(0, "$Last_Index_LOG", $Last_Index_LOG)

For $iCount_4 = 9 To $Anzahl_Zeilen_LOG

	$Wert_Zeile = FileReadLine($LOG_Data_json, $iCount_4)
	$Wert_Zeile = StringSplit(StringTrimLeft($Wert_Zeile, 1), ":")
	$Name = $Wert_Zeile[1]
	$Name = StringReplace($Name, " ", "")
	$Name = StringReplace($Name, " ", "")
	$Name = StringReplace($Name, " ", "")
	$Name = StringTrimLeft($Name, 1)
	$Name = StringTrimRight($Name, 1)

	If $Name <> "" Then
		$Wert = StringTrimLeft($Wert_Zeile[2], 1)
		$Wert = StringTrimLeft($Wert_Zeile[2], 1)
		$Wert = StringReplace($Wert, ',', '')
		$Wert = StringReplace($Wert, '"', '')


		If $Name = "index" Then
			$Index_LOG = $Wert
			;IniWrite($config_ini, "TEMP", "Log_Index_NR", $Index_LOG)
			IniWrite($LOG_Data_INI, "DATA", "NR", "")
			;If $Wert > IniWrite($LOG_Data_INI, "DATA", "NR", $Index_LOG) Then FileWriteLine($LOG_Data_INI, "")
			IniWrite($LOG_Data_INI, $Index_LOG, "index", $Wert)
		EndIf

		If $Index_LOG >= $Last_Index_LOG Then

			If $Name = "index" Then
				$Index_LOG = $Wert
				;IniWrite($config_ini, "TEMP", "Log_Index_NR", $Index_LOG)
				IniWrite($LOG_Data_INI, "DATA", "NR", $Index_LOG)
			EndIf

			If $Name = "time" Then
				IniWrite($LOG_Data_INI, $Index_LOG, "time", $Wert)
				EndIf

			If $Name = "name" Then
				IniWrite($LOG_Data_INI, $Index_LOG, "name", $Wert)
			EndIf

			If $Name <> "attributes" Then

				If $Name <> "index" And $Name <> "time" And $Name <> "name" Then

					If $Index_LOG <> "" Then
						IniWrite($LOG_Data_INI, $Index_LOG, "attribute_" & $Name, $Wert)
					EndIf

				EndIf

			EndIf
		EndIf


	EndIf

Next

EndFunc

Func _UserHistory_Daten_Update()

For $iCount_2 = 0 To 32

;$NameExist_UserHistory_Check = "false"
$NR_UserHistory = IniRead($UserHistory_ini, "DATA", "NR", "")
If $NR_UserHistory = "" Then $NR_UserHistory = 0

$Name_Member = ""
$Name_UserHistory_Check = ""
$NameExist_UserHistory_Check = "false"

$Name_Member = IniRead($Members_Data_INI, $iCount_2, "name", "")
$Steamid_Member = IniRead($Members_Data_INI, $iCount_2, "steamid", "")
$Jointime_Member = IniRead($Members_Data_INI, $iCount_2, "jointime", "")
$Ping_Member = IniRead($Members_Data_INI, $iCount_2, "Ping", "")

$Name_Member_bea = $Name_Member

If $Name_Member_bea <> "" Then
	$Name_Member_bea = StringReplace($Name_Member_bea, "[", "<")
	$Name_Member_bea = StringReplace($Name_Member_bea, "]", ">")
EndIf

If $Name_Member_bea = "" Then $Name_Member_bea = $Name_Member

$Name_UserHistory_Check = IniRead($UserHistory_ini, $Name_Member_bea, "name", "")
If $Name_Member = $Name_UserHistory_Check Then $NameExist_UserHistory_Check = "true"

If $NameExist_UserHistory_Check <> "true" Then
	$Wert_jointime =  _NowDate() & " - " & _NowTime()
	IniWrite($UserHistory_ini, "DATA", "NR", $NR_UserHistory + 1)
	FileWriteLine($UserHistory_ini, " ")
	IniWrite($UserHistory_ini, $NR_UserHistory + 1, "NR", $NR_UserHistory + 1)
	IniWrite($UserHistory_ini, $NR_UserHistory + 1, "Name", $Name_Member)
	IniWrite($UserHistory_ini, $NR_UserHistory + 1, "Steamid", $Steamid_Member)
	IniWrite($UserHistory_ini, $NR_UserHistory + 1, "Ping", $Ping_Member)
	IniWrite($UserHistory_ini, $NR_UserHistory + 1, "Added", $Wert_jointime)
	FileWriteLine($UserHistory_ini, " ")
	IniWrite($UserHistory_ini, $Name_Member_bea, "NR", $NR_UserHistory + 1)
	IniWrite($UserHistory_ini, $Name_Member_bea, "Name", $Name_Member)
	IniWrite($UserHistory_ini, $Name_Member_bea, "Steamid", $Steamid_Member)
	IniWrite($UserHistory_ini, $Name_Member_bea, "Ping", $Ping_Member)
	IniWrite($UserHistory_ini, $Name_Member_bea, "Added", $Wert_jointime)
	;FileWriteLine($UserHistory_ini, " ")
EndIf

If $Name_Member = "" Then $iCount_2 = 32

Next

EndFunc

Func _SessionTime_Update()

		Local $iRetH = 0, $iRetM = 0, $iRetS = 0
		If $iSec / 3600 >= 1 then
			$iRetH = Floor($iSec / 3600)
			$iSec = Mod($iSec,3600)
		EndIf
		If $iSec / 60 >= 1 Then
			$iRetM = Floor($iSec / 60)
			$iSec = Mod($iSec,60)
		EndIf
		$iRetS = $iSec
		$Wert_Time = StringFormat("%.2d:%.2d",$iRetM,$iRetS)
		$Wert = $Wert_Time

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

Func _TRACK_NAME_Grid_from_ID()

IniWrite($config_ini, "TEMP", "Check_TrackName", "")

$Wert_Track_ID_search = IniRead($config_ini, "TEMP", "Check_Trackid", "")

$Anzahl_Zeilen_TrackList = _FileCountLines(@ScriptDir & "\TrackList.txt")


For $Schleife_TRACK_ID = 7 To $Anzahl_Zeilen_TrackList Step 5

$Wert_Track_ID = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_ID)
$Wert_Track_ID = StringReplace($Wert_Track_ID, '        "id" : ', '')
$Wert_Track_ID = StringReplace($Wert_Track_ID, '"', '')
$Wert_Track_ID = StringReplace($Wert_Track_ID, ',', '')

;MsgBox(0, "", $Wert_Track_ID & " : " & $Wert)

If $Wert_Track_ID = $Wert_Track_ID_search Then
	;MsgBox(0, "Wert_Tack", $Wert_Track)
	$Wert_Track = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_ID + 1)
	$Wert_Track = StringReplace($Wert_Track, '        "name" : "', '')
	$Wert_Track = StringReplace($Wert_Track, ',', '')
	$Wert_Track = StringReplace($Wert_Track, '"', '')
	IniWrite($config_ini, "TEMP", "Check_TrackName", $Wert_Track)
	;FileWriteLine($PCDSG_LOG_ini, "Track_detection_" & $NowTime & "=" & "Track: " & $Wert_Track & " | " & "TrackID: " & "")
	;$Schleife_TRACK_ID = $Anzahl_Zeilen_TrackList

	$Wert_gridsize = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_ID + 2)
	$Wert_gridsize = StringReplace($Wert_gridsize, '        "gridsize" : ', '')
	$Wert_gridsize = StringReplace($Wert_gridsize, ',', '')
	$Wert_gridsize = StringReplace($Wert_gridsize, '"', '')
	If $Wert_Track = "" Then $Wert_gridsize = ""
	IniWrite($config_ini, "TEMP", "Check_Gridsize", $Wert_gridsize)
	;FileWriteLine($PCDSG_LOG_ini, "Track_detection_" & $NowTime & "=" & "Gridsize: " & $Wert_gridsize & " | " & "TrackID: " & "")
	$Schleife_TRACK_ID = $Anzahl_Zeilen_TrackList
EndIf

Next

EndFunc

Exit