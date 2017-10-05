#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\ICONS\DataUpdate.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****


#include <InetConstants.au3>
#include <MsgBoxConstants.au3>

#include <WinAPIFiles.au3>
#include <File.au3>
#include <Date.au3>

#include <SQLite.au3>
#include <SQLite.dll.au3>

#include <Excel.au3>

#Region Declare Variables/Const
Global $config_ini = @ScriptDir & "\config.ini"
Global $install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
Global $System_Dir = $install_dir & "system\"
Global $Data_Dir = $install_dir & "data\"
Global $PCDSG_LOG_ini = $System_Dir & "PCDSG_LOG.ini"
Global $DS_Status_ini = $System_Dir & "temp\DS_Status.ini"

Global $Server_Data_INI = $System_Dir & "Server_Data.ini"
Global $Members_Data_INI = $System_Dir & "Members_Data.ini"
Global $Participants_Data_INI = $System_Dir & "Participants_Data.ini"
Global $Participants_Data_INI_TEMP = $System_Dir & "temp\Participants_Data.ini"
Global $Participants_Data_INI_TEMP_Check_1 = $System_Dir & "temp\Participants_Data_Check_1.ini"
Global $Participants_Data_INI_TEMP_Check_2 = $System_Dir & "temp\Participants_Data_Check_2.ini"
Global $Participants_Data_INI_CR_1 = $System_Dir & "temp\Participants_Data_Check_Rules_1.ini"
Global $Participants_Data_INI_CR_2 = $System_Dir & "temp\Participants_Data_Check_Rules_2.ini"
Global $LOG_Data_INI = $System_Dir & "Server_LOG.ini"
Global $Points_ini = $System_Dir & "Points.ini"
Global $Info_PitStops_ini = $System_Dir & "PitStops.ini"
Global $CutTrack_ini = $System_Dir & "CutTrack.ini"
Global $Impact_ini = $System_Dir & "Impact.ini"
Global $KICK_BAN_TXT = $System_Dir & "KICK_BAN.txt"
Global $Results_INI = $System_Dir & "temp\Results.ini"
Global $Results_2_INI = $System_Dir & "temp\Results_2.ini"
Global $PitStops_INI = $System_Dir & "PitStops.ini"
Global $Stats_INI = $System_Dir & "Stats.ini"
Global $ServerBest_INI = $System_Dir & "ServerBest.ini"
Global $Refid_INI = $System_Dir & "Refid.ini"
Global $LapByLap_File = $System_Dir & "temp\LapByLap.ini"
Global $Check_refid, $Wert_Check_refid, $Check_Host, $Check_refid_members, $refid_log

Global $RaceControl_folder = $System_Dir & "RaceControl\"
Global $RaceControl_NextEventInfo_INI = $RaceControl_folder & "NextEventInfo.ini"
Global $RaceControl_WebPageInfo_INI = $RaceControl_folder & "WebPageInfo.ini"
Global $RaceControl_FairPlay_INI = $RaceControl_folder & "FairPlay.ini"
Global $DB_path = $System_Dir & "Database.sqlite"
Global $DB_path_Server = IniRead($config_ini, "Einstellungen", "DB_path_Server", "") & "Database.sqlite"
Global $DB_path_FTP = IniRead($config_ini, "Einstellungen", "DB_path_FTP", "") & "Database.sqlite"

Global $EP_MAX_Points = IniRead($config_ini, "Race_Control", "Value_Checkbox_ExperiencePoints_1", "8000")
Global $EP_Variant_Divider = IniRead($config_ini, "Race_Control", "Value_Checkbox_ExperiencePoints_2", "4")
Global $EP_NR_Groups = IniRead($config_ini, "Race_Control", "Value_Checkbox_ExperiencePoints_3", "5")

;Server http settings lesen
Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

If $Lesen_Auswahl_httpApiInterface = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"

Global $Wert_Track_ID, $Wert_Car, $Wert_Tack, $Wert_Wert
Local $hQuery, $aRow, $aNames, $iRows, $iCols

Global $NowDate_Value = _NowDate()
Global $NowDate = StringReplace($NowDate_Value, "/", ".")
Global $NowTime_Value = _NowTime()
Global $NowTime_orig = $NowTime_Value
Global $NowTime = StringReplace($NowTime_Value, ":", "-")
#endregion Declare Variables/Const

#Region Auto Lobby check
Local $Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")

$Last_Index_ID = IniRead($Server_Data_INI, "DATA", "NR", "")
$LOG_Current_Index_NR = IniRead($config_ini, "TEMP", "Log_Index_NR", "")

If $LOG_Current_Index_NR < $Last_Index_ID - 25 Then
	IniWrite($config_ini, "TEMP", "Log_Index_NR", "")
EndIf

If $Auto_LobbyCheck = "Lobby" Then
	IniWrite($config_ini, "PC_Server", "Session_Stage", "Lobby")
	FileDelete($LOG_Data_INI)
	;_Auto_LobbyAction()
EndIf
#EndRegion

_Server_Events_LOG()

#Region Start Server Events Check

Func _Server_Events_LOG()

	;Global $Farbe_State_LOG, $Farbe_Standard

	;Global $asRead3

	$Anzahl_Werte_LOG = 20
	$Anzahl_Zeilen_ListView_LOG = 20

	Global $Wert_LA_1_ALT = IniRead($config_ini, "TEMP", "Log_Index_NR", "")
	Global $Last_Index_ID = IniRead($LOG_Data_INI, "DATA", "NR", "")

	;MsgBox(0,"$Wert_LA_1_ALT" , $Wert_LA_1_ALT & " - " & $Last_Index_ID)

	$Schleifen_NR = 0

	For $Schleife_ListView_aktualisieren = $Wert_LA_1_ALT To $Last_Index_ID

		Global $NowDate_Value = _NowDate()
		Global $NowDate = StringReplace($NowDate_Value, "/", ".")
		Global $NowTime_Value = _NowTime()
		Global $NowTime_orig = $NowTime_Value
		Global $NowTime = StringReplace($NowTime_Value, ":", "-")


		$Schleifen_NR = $Schleifen_NR + 1

		;MsgBox(0,"Schleife" , $Wert_LA_1_ALT & " - " & $Last_Index_ID)

		$LOG_Index_Check = $Wert_LA_1_ALT + $Schleifen_NR

		Global $Wert_LA_1 = IniRead($LOG_Data_INI, $LOG_Index_Check, "index", "") ; index
		Global $Wert_LA_2 = IniRead($LOG_Data_INI, $LOG_Index_Check, "time", "") ; time
		Global $Wert_LA_3 = IniRead($LOG_Data_INI, $LOG_Index_Check, "name", "") ; name ; --> SessionDestroyed

		;MsgBox(0,$Wert_LA_1_ALT , $Wert_LA_1 & @CRLF & $Wert_LA_2 & @CRLF & $Wert_LA_3)


#Region Read LOG_attribute
		Global $LOG_Sector_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
		Global $LOG_Sector_attribute_attribute_participantid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_participantid", "") ; attribute_participantid
		Global $LOG_Sector_attribute_attribute_Lap = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Lap", "") ; attribute_Lap
		Global $LOG_Sector_attribute_attribute_Sector = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Sector", "") ; attribute_Sector
		Global $LOG_Sector_attribute_attribute_SectorTime = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_SectorTime", "") ; attribute_SectorTime
		Global $LOG_Sector_attribute_attribute_TotalTime = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_TotalTime", "") ; attribute_TotalTime
		Global $LOG_Sector_attribute_attribute_CountThisLap = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_CountThisLap", "") ; attribute_CountThisLap
		Global $LOG_Sector_attribute_attribute_CountThisLapTimes = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_CountThisLapTimes", "") ; attribute_CountThisLapTimes

		Global $LOG_Lap_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
		Global $LOG_Lap_attribute_participantid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_participantid", "") ; attribute_participantid
		Global $LOG_Lap_attribute_Lap = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Lap", "") ; attribute_Lap
		Global $LOG_Lap_attribute_LapTime = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_LapTime", "") ; attribute_LapTime
		Global $LOG_Lap_attribute_Sector1Time = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Sector1Time", "") ; attribute_Sector1Time
		Global $LOG_Lap_attribute_Sector2Time = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Sector2Time", "") ; attribute_Sector2Time
		Global $LOG_Lap_attribute_Sector3Time = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Sector3Time", "") ; attribute_Sector3Time
		Global $LOG_Lap_attribute_RacePosition = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_RacePosition", "") ; attribute_RacePosition
		Global $LOG_Lap_attribute_DistanceTravelled = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_DistanceTravelled", "") ; attribute_DistanceTravelled
		Global $LOG_Lap_attribute_CountThisLapTimes = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_CountThisLapTimes", "") ; attribute_CountThisLapTimes

		Global $LOG_State_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
		Global $LOG_State_attribute_participantid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_participantid", "") ; attribute_participantid
		Global $LOG_State_attribute_PreviousState = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_PreviousState", "") ; attribute_PreviousState
		Global $LOG_State_attribute_NewState = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_NewState", "") ; attribute_NewState

		Global $LOG_CutTrackStart_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
		Global $LOG_CutTrackStart_attribute_participantid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_participantid", "") ; attribute_participantid
		Global $LOG_CutTrackStart_attribute_Lap = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Lap", "") ; attribute_Lap
		Global $LOG_CutTrackStart_attribute_RacePosition = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_RacePosition", "") ; attribute_RacePosition
		Global $LOG_CutTrackStart_attribute_IsMainBranch = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_IsMainBranch", "") ; attribute_IsMainBranch
		Global $LOG_CutTrackStart_attribute_LapTime = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_LapTime", "") ; attribute_LapTime

		Global $LOG_CutTrackEnd_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
		Global $LOG_CutTrackEnd_attribute_participantid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_participantid", "") ; attribute_participantid
		Global $LOG_CutTrackEnd_attribute_ElapsedTime = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_ElapsedTime", "") ; attribute_ElapsedTime
		Global $LOG_CutTrackEnd_attribute_SkippedTime = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_SkippedTime", "") ; attribute_SkippedTime
		Global $LOG_CutTrackEnd_attribute_PlaceGain = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_PlaceGain", "") ; attribute_PlaceGain
		Global $LOG_CutTrackEnd_attribute_PenaltyValue = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_PenaltyValue", "") ; attribute_PenaltyValue
		Global $LOG_CutTrackEnd_attribute_PenaltyThreshold = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_PenaltyThreshold", "") ; attribute_PenaltyThreshold

		Global $LOG_Impact_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
		Global $LOG_Impact_attribute_participantid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_participantid", "") ; attribute_participantid
		Global $LOG_Impact_attribute_OtherParticipantId = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_OtherParticipantId", "") ; attribute_OtherParticipantId
		Global $LOG_Impact_attribute_CollisionMagnitude = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_CollisionMagnitude", "") ; attribute_CollisionMagnitude

		Global $LOG_Authenticated_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid

		Global $LOG_SessionSetup_attribute_GridSize = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_GridSize", "") ; attribute_GridSize
		Global $LOG_SessionSetup_attribute_MaxPlayers = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_MaxPlayers", "") ; attribute_MaxPlayers
		Global $LOG_SessionSetup_attribute_Practice1Length = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Practice1Length", "") ; attribute_Practice1Length
		Global $LOG_SessionSetup_attribute_Practice2Length = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Practice2Length", "") ; attribute_Practice2Length
		Global $LOG_SessionSetup_attribute_QualifyLength = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_QualifyLength", "") ; attribute_QualifyLength
		Global $LOG_SessionSetup_attribute_WarmupLength = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_WarmupLength", "") ; attribute_WarmupLength
		Global $LOG_SessionSetup_attribute_Race1Length = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Race1Length", "") ; attribute_Race1Length
		Global $LOG_SessionSetup_attribute_Race2Length = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Race2Length", "") ; attribute_Race2Length
		Global $LOG_SessionSetup_attribute_Flags = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Flags", "") ; attribute_Flags
		Global $LOG_SessionSetup_attribute_TrackId = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_TrackId", "") ; attribute_TrackId
		Global $LOG_SessionSetup_attribute_GameMode = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_GameMode", "") ; attribute_GameMode

		Global $LOG_PlayerLeft_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
		Global $LOG_PlayerLeft_attribute_Reason = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Reason", "") ; attribute_Reason
		Global $LOG_PlayerLeft_attribute_GameReasonId = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_GameReasonId", "") ; attribute_GameReasonId

		Global $LOG_StateChanged_attribute_PreviousStage = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_PreviousStage", "") ; attribute_PreviousStage
		Global $LOG_StateChanged_attribute_attribute_NewStage = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_NewStage", "") ; attribute_NewStage

		Global $LOG_StageChanged_attribute_PreviousStage = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_PreviousStage", "") ; attribute_PreviousStage
		Global $LOG_StageChanged_attribute_attribute_NewStage = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_NewStage", "") ; attribute_NewStage
		Global $LOG_StageChanged_attribute_attribute_Length = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Length", "") ; attribute_Length

		Global $LOG_PlayerChat_attribute_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
		Global $LOG_PlayerChat_attribute_attribute_Message = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Message", "") ; attribute_Message

		Global $LOG_Results_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
		Global $LOG_Results_attribute_participantid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_participantid", "") ; attribute_participantid
		Global $LOG_Results_attribute_RacePosition = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_RacePosition", "") ; attribute_RacePosition
		Global $LOG_Results_attribute_Lap = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Lap", "") ; attribute_Lap
		Global $LOG_Results_attribute_VehicleId = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_VehicleId", "") ; attribute_VehicleId
		Global $LOG_Results_attribute_State = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_State", "") ; attribute_State
		Global $LOG_Results_attribute_TotalTime = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_TotalTime", "") ; attribute_TotalTime
		Global $LOG_Results_attribute_FastestLapTime = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_FastestLapTime", "") ; attribute_FastestLapTime

		Global $LOG_PlayerJoined_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
		Global $LOG_PlayerJoined_attribute_name = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_name", "") ; attribute_name
		Global $LOG_PlayerJoined_attribute_attribute_steamID = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_steamID", "") ; attribute_steamID
#EndRegion

		Global $Last_Index_ID = IniRead($config_ini, "TEMP", "Log_Index_NR", "")

		$Wert_Index_Check_LOG = Int($Wert_LA_1)
		$Wert_Index_Check_LOG_alt = $Last_Index_ID

		;MsgBox(0,"INDEX LOG Ckeck" , $Wert_Index_Check_LOG & " : " & $Wert_Index_Check_LOG_alt & @CRLF & $Last_Index_ID)


		;MsgBox(0, "", $Wert_Index_Check_LOG & " : " &  $Wert_Index_Check_LOG_alt)

		;If $Wert_Index_Check_LOG > $Wert_Index_Check_LOG_alt Then
			;MsgBox(0, "", $Wert_Index_Check_LOG & " : " &  $Wert_Index_Check_LOG_alt, 3)
			$Seconds_to_Time = $Wert_LA_2
			_EPOCH_decrypt($Seconds_to_Time)
			$Wert_LA_2 = IniRead($config_ini, "TEMP", "Seconds_to_Time", "")
			$Wert_LA_2_NEU_NR = StringInStr($Wert_LA_2, "-")
			$Wert_LA_2_NEU = StringMid($Wert_LA_2, $Wert_LA_2_NEU_NR + 2, 8)
			;MsgBox(0, "Time", $Wert_LA_2_NEU)

			; LOG Check and Events ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

			Global $LOG_Event_Check_Points_TrackCut = IniRead($config_ini, "Race_Control", "Checkbox_Rules_3", "")
			Global $LOG_Event_Check_Points_Impact = IniRead($config_ini, "Race_Control", "Checkbox_Rules_4", "")
			Global $LOG_Event_Check_Points_System = IniRead($config_ini, "Race_Control", "Checkbox_Rules_5", "")
			Global $LOG_Event_Check_auto_MSG = IniRead($config_ini, "Race_Control", "Checkbox_Rules_6", "")
			;MsgBox(0, "$LOG_Event_Check_auto_MSG", $LOG_Event_Check_auto_MSG)


			;MsgBox(0, "LOG_Event_Check", $LOG_Event_Check_Points_TrackCut & @CRLF & $LOG_Event_Check_Points_Impact & @CRLF & $LOG_Event_Check_Points_System & @CRLF & $LOG_Event_Check_auto_MSG)


#Region Check = PlayerChat
			$admin_commands_Status = IniRead($config_ini, "Race_Control", "Checkbox_Rules_8", "")

			If $admin_commands_Status = "true" Then

				If $Wert_LA_3 = "PlayerChat" Then

					Global $LOG_PlayerChat_attribute_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
					Global $LOG_PlayerChat_attribute_attribute_Message = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Message", "") ; attribute_Message


					Global $refid_log = $LOG_PlayerChat_attribute_attribute_refid
					$PlayerChat_Message = $LOG_PlayerChat_attribute_attribute_Message
					;$Admin_MSG_1 = IniRead($config_ini, "Race_Control", "Admin_MSG_1", "")
					;$Admin_MSG_2 = IniRead($config_ini, "Race_Control", "Admin_MSG_2", "")
					$Admin_MSG_3 = IniRead($config_ini, "Race_Control", "Admin_MSG_3", "")
					$Admin_MSG_4 = IniRead($config_ini, "Race_Control", "Admin_MSG_4", "")
					$Admin_MSG_5 = IniRead($config_ini, "Race_Control", "Admin_MSG_5", "")
					$Admin_MSG_6 = IniRead($config_ini, "Race_Control", "Admin_MSG_6", "")
					$Admin_MSG_7 = IniRead($config_ini, "Race_Control", "Admin_MSG_7", "")

					$Admin_APP_1 = IniRead($config_ini, "Race_Control", "Admin_APP_1", "")
					$Admin_APP_2 = IniRead($config_ini, "Race_Control", "Admin_APP_2", "")
					$Admin_APP_3 = IniRead($config_ini, "Race_Control", "Admin_APP_3", "")
					$Admin_APP_4 = IniRead($config_ini, "Race_Control", "Admin_APP_4", "")
					$Admin_APP_5 = IniRead($config_ini, "Race_Control", "Admin_APP_5", "")

					$MSG_SB = ">SB"
					$MSG_PB = ">PB"
					$MSG_SG = ">SG"
					$MSG_EP = ">EP"
					$MSG_PP = ">PP"
					;$Wert_Check_refid = $refid_log

					;_Name_from_refid()

					;If $LOG_Name_from_refid = "" Then $LOG_Name_from_refid = $refid_log

					$PlayerChat_Message = $LOG_PlayerChat_attribute_attribute_Message

					$LOG_Check_Host_Value = "false"

					;_Host_Check_from_refid()
					$Name_from_members = IniRead($Members_Data_INI, $refid_log, "name", "")
					$Check_Admin_from_members = IniRead($Members_Data_INI, $refid_log, "host", "")
					If $Check_Admin_from_members = "true" Then $LOG_Check_Host_Value = "true"

					If $LOG_Check_Host_Value = "" Then $LOG_Check_Host_Value = "false"

					;$PlayerChat_Message_Check = StringTrimRight($PlayerChat_Message, StringLen($PlayerChat_Message) - 3)
					$PlayerChat_Message_Check = $PlayerChat_Message
					FileWriteLine($PCDSG_LOG_ini, "PlayerChat_Message_" & $NowTime & "=" & $PlayerChat_Message_Check)


					;MsgBox(0, "", $PlayerChat_Message_Check, 3)

					If $PlayerChat_Message_Check = $MSG_SB Then ; SB Chat MSG

						Global $Wert_Track, $SB_Car, $Wert_Vehicle, $CarName, $Track_Car_Kombo, $RefID_user_name
						Global $RefID_user = $refid_log
						Global $Current_TrackID = IniRead($Server_Data_INI, "DATA", "TrackId", "")
						Global $RefID_user_name = IniRead($Members_Data_INI, $refid_log, "name", "")

						IniWrite($config_ini, "TEMP", "Wert_Check_Refid", $RefID_user)
						IniWrite($config_ini, "TEMP", "Check_Trackid", $Current_TrackID)

						;_Car_from_RefID()
						$Current_Car_ID = IniRead($Members_Data_INI, $refid_log, "VehicleId", "")
						IniWrite($config_ini, "TEMP", "Check_Carid", $Current_Car_ID)

						_CAR_NAME_from_ID()
						;_TRACK_NAME_from_ID()

						;$Wert_Track = IniRead($config_ini, "TEMP", "Check_TrackName", "")
						$Wert_Track = IniRead($Server_Data_INI, "DATA", "TrackName", "")
						$Wert_Vehicle = IniRead($config_ini, "TEMP", "Check_CarName", "")

						$Track_Car_Kombo = $Wert_Track & "_" & $Wert_Vehicle

						$SB_Name = IniRead($ServerBest_INI, $Track_Car_Kombo, "Name", "")
						$SB_LapTime = IniRead($ServerBest_INI, $Track_Car_Kombo, "LapTime", "")

						;MsgBox(0, "", $RefID_user_name & @CRLF & $Wert_Track &@CRLF & $Wert_Vehicle & @CRLF & $Track_Car_Kombo & @CRLF & @CRLF & $SB_LapTime)

						If $SB_LapTime <> "" Then
							$Nachricht_SB_1 = "     "
							$Nachricht_SB_2 = "SB for: "
							$Nachricht_SB_3 = $Wert_Track
							$Nachricht_SB_4 = $Wert_Vehicle
							$Nachricht_SB_5 = $SB_LapTime & " By: " & $SB_Name

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_1
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(500)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_2
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_3
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_4
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_5
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(1000)
						Else
							$Nachricht_SB_1 = "     "
							$Nachricht_SB_2 = "No SB Laptime Found"
							$Nachricht_SB_3 = "     "
							$Nachricht_SB_4 = "Be the first one driving the SB"

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_1
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_2
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_3
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_4
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(1000)
						EndIf


					EndIf

					If $PlayerChat_Message_Check = $MSG_PB Then ; PB Chat MSG

						Global $Wert_Track, $SB_Car, $Wert_Vehicle, $CarName, $Track_Car_Kombo, $RefID_user_name
						Global $RefID_user = $refid_log
						Global $Current_TrackID = IniRead($Server_Data_INI, "DATA", "TrackId", "")
						Global $RefID_user_name = IniRead($Members_Data_INI, $RefID_user, "name", "")

						IniWrite($config_ini, "TEMP", "Wert_Check_Refid", $RefID_user)
						IniWrite($config_ini, "TEMP", "Check_Trackid", $Current_TrackID)

						;_Car_from_RefID()
						$Current_Car_ID = IniRead($Members_Data_INI, $RefID_user, "VehicleId", "")
						IniWrite($config_ini, "TEMP", "Check_Carid", $Current_Car_ID)

						_CAR_NAME_from_ID()
						;_TRACK_NAME_from_ID()

						;$Wert_Track = IniRead($config_ini, "TEMP", "Check_TrackName", "")
						$Wert_Track = IniRead($Server_Data_INI, "DATA", "TrackName", "")
						$Wert_Vehicle = IniRead($config_ini, "TEMP", "Check_CarName", "")

						$Track_Car_Kombo = $Wert_Track & "_" & $Wert_Vehicle

						$Check_Name_Value_bea = $RefID_user_name
						$String_Check = StringMid($Check_Name_Value_bea, 1, 1)

						If $Check_Name_Value_bea <> "" Then
							$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "[", "<")
							$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "]", ">")
						EndIf

						If $Check_Name_Value_bea = "" Then $Check_Name_Value_bea = $RefID_user_name

						$PB_LapTime = IniRead($Stats_INI, $Check_Name_Value_bea, $Track_Car_Kombo, "")
						$SB_LapTime = IniRead($ServerBest_INI, $Track_Car_Kombo, "LapTime", "")

						;MsgBox(0, "", $RefID_user_name & @CRLF & $Wert_Track &@CRLF & $Wert_Vehicle & @CRLF & $Track_Car_Kombo & @CRLF & @CRLF & $PB_LapTime)

						If $PB_LapTime <> "" Then

							IniWrite($config_ini, "TEMP", "LapTime_GAP_1", $SB_LapTime)
							IniWrite($config_ini, "TEMP", "LapTime_GAP_2", $PB_LapTime)

							_LapTime_GAP()

							$Laptime_GAP = IniRead($config_ini, "TEMP", "LapTime_GAP_3", "")

							$Nachricht_PB_1 = "     "
							$Nachricht_PB_2 = "PB for: "
							$Nachricht_PB_3 = $Wert_Track
							$Nachricht_PB_4 = $Wert_Vehicle
							$Nachricht_PB_5 = $PB_LapTime & "     GAP to SB --> " & "[" & $Laptime_GAP & "]"

							$URL_PB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_PB_1
							$download = InetGet($URL_PB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(500)

							$URL_PB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_PB_2
							$download = InetGet($URL_PB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_PB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_PB_3
							$download = InetGet($URL_PB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_PB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_PB_4
							$download = InetGet($URL_PB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_PB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_PB_5
							$download = InetGet($URL_PB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(1000)
						Else
							$Nachricht_PB_1 = "     "
							$Nachricht_PB_2 = "No PB Laptime Found"
							$Nachricht_PB_3 = "     "
							$Nachricht_PB_4 = "Drive now your first Lap Time"

							$URL_PB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_PB_1
							$download = InetGet($URL_PB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_PB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_PB_2
							$download = InetGet($URL_PB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_PB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_PB_3
							$download = InetGet($URL_PB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_PB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_PB_4
							$download = InetGet($URL_PB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(1000)
						EndIf

					EndIf

					If $PlayerChat_Message_Check = $MSG_SG Then ; SG Chat MSG

						Global $RefID_user = $refid_log
						Global $RefID_user_name = IniRead($Members_Data_INI, $RefID_user, "name", "")

						$Check_Name_Value_bea = $RefID_user_name
						;$String_Check = StringMid($Check_Name_Value_bea, 1, 1)

						If $Check_Name_Value_bea <> "" Then
							$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "[", "<")
							$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "]", ">")
						EndIf

						If $Check_Name_Value_bea = "" Then $Check_Name_Value_bea = $RefID_user_name

						Global $Check_SafetyGroup_Stats = IniRead($Stats_INI, $Check_Name_Value_bea, "SafetyGroup", "")

						If $Check_SafetyGroup_Stats <> "" Then
							$Nachricht_SB_1 = "     "
							$Nachricht_SB_2 = "Safety Group Ranking: "
							$Nachricht_SB_3 = "SG: " & $Check_SafetyGroup_Stats

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_1
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(500)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_2
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_3
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(1000)
						Else
							$Nachricht_SB_1 = "     "
							$Nachricht_SB_2 = "Safety Group Ranking: "
							$Nachricht_SB_3 = "     "
							$Nachricht_SB_4 = "No Ranking for user " & $RefID_user_name & " available."

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_1
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(500)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_2
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_3
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_4
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(1000)
						EndIf

					EndIf

					If $PlayerChat_Message_Check = $MSG_EP Then ; EP Chat MSG

						Global $RefID_user = $refid_log
						Global $RefID_user_name = IniRead($Members_Data_INI, $RefID_user, "name", "")

						$Check_Name_Value_bea = $RefID_user_name
						;$String_Check = StringMid($Check_Name_Value_bea, 1, 1)

						If $Check_Name_Value_bea <> "" Then
							$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "[", "<")
							$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "]", ">")
						EndIf

						If $Check_Name_Value_bea = "" Then $Check_Name_Value_bea = $RefID_user_name

						Global $Check_ExperiencePoints_Stats = IniRead($Stats_INI, $Check_Name_Value_bea, "ExperiencePoints", "")

						If $Check_ExperiencePoints_Stats <> "" Then
							$Nachricht_SB_1 = "     "
							$Nachricht_SB_2 = "Experience Points: "
							$Nachricht_SB_3 = "EP: " & $Check_ExperiencePoints_Stats

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_1
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(500)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_2
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_3
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(1000)
						Else
							$Nachricht_SB_1 = "     "
							$Nachricht_SB_2 = "Experience Points: "
							$Nachricht_SB_3 = "     "
							$Nachricht_SB_4 = "No Experience Points for user " & $RefID_user_name & " available."

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_1
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(500)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_2
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_3
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_4
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(1000)
						EndIf

					EndIf

					If $PlayerChat_Message_Check = $MSG_PP Then ; PP Chat MSG

						Global $RefID_user = $refid_log
						Global $RefID_user_name = IniRead($Members_Data_INI, $RefID_user, "name", "")

						$Check_Name_Value_bea = $RefID_user_name
						;$String_Check = StringMid($Check_Name_Value_bea, 1, 1)

						If $Check_Name_Value_bea <> "" Then
							$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "[", "<")
							$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "]", ">")
						EndIf

						If $Check_Name_Value_bea = "" Then $Check_Name_Value_bea = $RefID_user_name

						Global $Check_PenaltyPoints_Stats = IniRead($Points_ini, $Check_Name_Value_bea, "PenaltyPoints", "")

						If $Check_PenaltyPoints_Stats <> "" Then
							$Nachricht_SB_1 = "     "
							$Nachricht_SB_2 = "Penalty Points: "
							$Nachricht_SB_3 = "PP: " & $Check_PenaltyPoints_Stats

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_1
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(500)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_2
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_3
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(1000)
						Else
							$Nachricht_SB_1 = "     "
							$Nachricht_SB_2 = "Penalty Points:"
							$Nachricht_SB_3 = "     "
							$Nachricht_SB_4 = "No Penalty Points: for user " & $Check_Name_Value_bea & " available."

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_1
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(500)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_2
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_3
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)

							$URL_SB = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $Nachricht_SB_4
							$download = InetGet($URL_SB, @ScriptDir & "\Message.txt", 16, 0)
							Sleep(1000)
						EndIf

					EndIf


					If $LOG_Check_Host_Value = "true" Then

						$PlayerChat_Message_AM_Check_KU = StringTrimRight($PlayerChat_Message, StringLen($PlayerChat_Message) - 4)
						$PlayerChat_Message_AM_Check_BU = StringTrimRight($PlayerChat_Message, StringLen($PlayerChat_Message) - 4)
						$PlayerChat_Message_AM_Check = $PlayerChat_Message

						;MsgBox(0, "Chat Message", $PlayerChat_Message_AM_Check, 3)

						If $PlayerChat_Message_AM_Check_KU = ">KU>" Then ; Kick User
							$Value_Name_AM1_MSG = StringReplace($PlayerChat_Message, ">KU>", "")

							IniWrite($config_ini, "TEMP", "KICK_User", $Value_Name_AM1_MSG)

							;Server http settings lesen
							Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
							Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

							If $Lesen_Auswahl_httpApiInterface = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
							If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"

							$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "     "
							$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
							$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN >>>"
							$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
							$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "User " & $Value_Name_AM1_MSG & " will be KICKED in 3 seconds >>>"
							$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
							$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "     "
							$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)

							Sleep(3000)

							_KICK_USER_universal()

						EndIf

						If $PlayerChat_Message_AM_Check_BU = ">BU>" Then ; Ban user
							$Value_Name_AM1_MSG = StringReplace($PlayerChat_Message, ">BU>>", "")

							IniWrite($config_ini, "TEMP", "BAN_User", $Value_Name_AM1_MSG)

							;Server http settings lesen
							Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
							Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

							If $Lesen_Auswahl_httpApiInterface = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
							If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"

							$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "     "
							$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
							$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN >>>"
							$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
							$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "User " & $Value_Name_AM1_MSG & " will be BANNED in 3 seconds >>>"
							$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
							$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "     "
							$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)

							Sleep(3000)

							_BAN_USER_universal()

						EndIf

						If $PlayerChat_Message_AM_Check = $Admin_MSG_3 Then ; Automatic remove parking cars on/off
							$Wert_Checkbox_Rules_1 = IniRead($config_ini, "Race_Control", "Checkbox_Rules_1", "")
							If $Wert_Checkbox_Rules_1 = "false" Then
								IniWrite($config_ini, "Race_Control", "Checkbox_Rules_1", "true")

								$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: Automatic Kick of Parking Cars is enabled >>>"
								$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
								;MsgBox(0, "PCDSG Event Message", "PCDSG: " & " <<< ADMIN: Automatic Kick of Parking Cars is enabled >>>", 15)
							EndIf

							If $Wert_Checkbox_Rules_1 = "true" Then
								IniWrite($config_ini, "Race_Control", "Checkbox_Rules_1", "false")

								$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: Automatic Kick of Parking Cars is disabled >>>"
								$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
								;MsgBox(0, "PCDSG Event Message", "PCDSG: " & " <<< ADMIN: Automatic Kick of Parking Cars is disabled >>>", 15)
							EndIf
						EndIf

						If $PlayerChat_Message_AM_Check = $Admin_MSG_4 Then ; Penalty Limit Kick on/off
							$Wert_Checkbox_Server_Penalties_2 = IniRead($config_ini, "Race_Control", "Checkbox_Server_Penalties_2", "")
							If $Wert_Checkbox_Server_Penalties_2 = "false" Then
								IniWrite($config_ini, "Race_Control", "Checkbox_Server_Penalties_2", "true")

								$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: Penalty Points Kick is enabled >>>"
								$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
								;MsgBox(0, "PCDSG Event Message", "PCDSG: " & " <<< ADMIN: Penalty Points Kick is enabled >>>", 15)
							EndIf

							If $Wert_Checkbox_Server_Penalties_2 = "true" Then
								IniWrite($config_ini, "Race_Control", "Checkbox_Server_Penalties_2", "false")

								$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: Penalty Points Kick is disabled >>>"
								$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
								;MsgBox(0, "PCDSG Event Message", "PCDSG: " & " <<< ADMIN: Penalty Points Kick is disabled >>>", 15)
							EndIf
						EndIf

						If $PlayerChat_Message_AM_Check = $Admin_MSG_5 Then ; Ping Limit Kick on/off
							$Wert_Checkbox_PCDSG_settings_7 = IniRead($config_ini, "Race_Control", "Checkbox_Rules_7", "")
							If $Wert_Checkbox_PCDSG_settings_7 = "false" Then
								IniWrite($config_ini, "Race_Control", "Checkbox_Rules_7", "true")

								$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: Ping Limit is enabled >>>"
								$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
								;MsgBox(0, "PCDSG Event Message", "PCDSG: " & " <<< ADMIN: Ping Limit is enabled >>>", 15)
							EndIf

							If $Wert_Checkbox_PCDSG_settings_7 = "true" Then
								IniWrite($config_ini, "Race_Control", "Checkbox_Rules_7", "false")

								$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: Ping Limit is disabled >>>"
								$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
								;MsgBox(0, "PCDSG Event Message", "PCDSG: " & " <<< ADMIN: Ping Limit is disabled >>>", 15)
							EndIf

						EndIf

						If $PlayerChat_Message_AM_Check = $Admin_MSG_6 Then ; Start Replay Recording
							IniWrite($config_ini, "TEMP", "AM_Command", ">StartRR")
							_StartRR_command()
						EndIf

						If $PlayerChat_Message_AM_Check = $Admin_MSG_7 Then ; Stop Replay Recording
							IniWrite($config_ini, "TEMP", "AM_Command", ">StopRR")
						EndIf


						;$PlayerChat_Message_AM_Check_new = StringTrimRight($PlayerChat_Message, StringLen($PlayerChat_Message) - 6)
						$PlayerChat_Message_AM_Check_new = $PlayerChat_Message

						If $PlayerChat_Message_AM_Check_new = $Admin_APP_1 Then ;
							_Path_APP_1_execute()
							;MsgBox(0, "PCDSG Event Message", "PCDSG: " & " <<< ADMIN: APP 1 started >>>", 15)
						EndIf

						If $PlayerChat_Message_AM_Check_new = $Admin_APP_2 Then ;
							_Path_APP_2_execute()
							;MsgBox(0, "PCDSG Event Message", "PCDSG: " & " <<< ADMIN: APP 2 started >>>", 15)
						EndIf

						If $PlayerChat_Message_AM_Check_new = $Admin_APP_3 Then ;
							_Path_APP_3_execute()
							;MsgBox(0, "PCDSG Event Message", "PCDSG: " & " <<< ADMIN: APP 3 started >>>", 15)
						EndIf

						If $PlayerChat_Message_AM_Check_new = $Admin_APP_4 Then ;
							_Path_APP_4_execute()
							;MsgBox(0, "PCDSG Event Message", "PCDSG: " & " <<< ADMIN: APP 4 started >>>", 15)
						EndIf

						If $PlayerChat_Message_AM_Check_new = $Admin_APP_5 Then ;
							_Path_APP_5_execute()
							;MsgBox(0, "PCDSG Event Message", "PCDSG: " & " <<< ADMIN: APP 5 started >>>", 15)
						EndIf

					EndIf

				EndIf

			EndIf
#EndRegion

#Region Check = SessionSetup
			If $Wert_LA_3 = "SessionSetup" Then

				Global $LOG_SessionSetup_attribute_GridSize = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_GridSize", "") ; attribute_GridSize
				Global $LOG_SessionSetup_attribute_MaxPlayers = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_MaxPlayers", "") ; attribute_MaxPlayers
				Global $LOG_SessionSetup_attribute_Practice1Length = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Practice1Length", "") ; attribute_Practice1Length
				Global $LOG_SessionSetup_attribute_Practice2Length = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Practice2Length", "") ; attribute_Practice2Length
				Global $LOG_SessionSetup_attribute_QualifyLength = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_QualifyLength", "") ; attribute_QualifyLength
				Global $LOG_SessionSetup_attribute_WarmupLength = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_WarmupLength", "") ; attribute_WarmupLength
				Global $LOG_SessionSetup_attribute_Race1Length = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Race1Length", "") ; attribute_Race1Length
				Global $LOG_SessionSetup_attribute_Race2Length = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Race2Length", "") ; attribute_Race2Length
				Global $LOG_SessionSetup_attribute_Flags = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Flags", "") ; attribute_Flags
				Global $LOG_SessionSetup_attribute_TrackId = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_TrackId", "") ; attribute_TrackId
				Global $LOG_SessionSetup_attribute_GameMode = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_GameMode", "") ; attribute_GameMode

				_Empy_Temp_1()
				IniWrite($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
				FileWriteLine($PCDSG_LOG_ini, "SessionSetup_" & $NowTime & "=" & "TrackID: " & $LOG_SessionSetup_attribute_TrackId & " | " & "GameMode: " & $LOG_SessionSetup_attribute_GameMode)

				;If $LOG_Event_Check_auto_MSG = "true" Then
					;$Message_1 = " "
					;$Message_2 = "Clean driving"
					;$Message_3 = "Be fair and drive safely!"
					;$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_1
					;$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
					;$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_2
					;$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
					;$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_3
					;$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
					;MsgBox(0, "PCDSG Event Message", "New Player <" & $LOG_value_Name & "> Joined. " & @TAB & @TAB & "ExperiencePoints: <" & $Wert_EP_Points & "> Wellcome to PCDSG Server", 15)
				;EndIf

			EndIf
#EndRegion

#Region Check = State & = EnteringPits
			If $Wert_LA_3 = "State" Then

				;MsgBox(0, "State", "State Detected", 3)

				Global $LOG_State_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
				Global $LOG_State_attribute_participantid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_participantid", "") ; attribute_participantid
				Global $LOG_State_attribute_PreviousState = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_PreviousState", "") ; attribute_PreviousState
				Global $LOG_State_attribute_NewState = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_NewState", "") ; attribute_NewState

				_Empy_Temp_1()
				FileWriteLine($PCDSG_LOG_ini, "State_" & $NowTime & "=" & "PreviousState: " & $LOG_State_attribute_PreviousState & " | " & "NewState: " & $LOG_State_attribute_NewState)

				Global $Wert_Check_State_InPits = $LOG_State_attribute_NewState

				If $Wert_Check_State_InPits = "EnteringPits" Then ; InPits

					;MsgBox(0, "EnteringPits", "EnteringPits Detected", 3)

					Global $Wert_Check_refid = $LOG_State_attribute_refid
					Global $LOG_Name_Label_4 = ""
					Global $LOG_Name_value_4 = ""

					IniWrite($config_ini, "TEMP", "Wert_Check_Refid", $Wert_Check_refid)
					IniWrite($config_ini, "TEMP", "Wert_Check_Name", "")

					;_Name_from_refid()
					$Wert_Check_Refid_Name = IniRead($Members_Data_INI, $Wert_Check_refid, "name", "")

					;$Wert_Check_Refid_Name = IniRead($config_ini, "TEMP", "Wert_Check_Name", "")
					$LOG_Name_value_4 = $Wert_Check_Refid_Name

					If $Wert_Check_Refid_Name = "" Then $LOG_Name_value_4 = IniRead($Refid_INI, $refid_log, "Name", "unknown")

					$Check_Name_PS = ""
					$Wert_PitStops = ""

					$Check_Name_Value_bea = $LOG_Name_value_4
					;$String_Check = StringMid($Check_Name_Value_bea, 1, 1)

					If $Check_Name_Value_bea <> "" Then
						$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "[", "<")
						$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "]", ">")
					EndIf

					If $Check_Name_Value_bea = "" Then $Check_Name_Value_bea = $LOG_Name_value_4

					$Check_Name_PS = IniRead($PitStops_INI, $Check_Name_Value_bea, "Name", "")
					$Check_PitStops_PS = IniRead($PitStops_INI, $Check_Name_Value_bea, "PitStops", "")
					$Check_Time_PS = IniRead($PitStops_INI, $Check_Name_Value_bea, "Time_PS_1", "")
					$Check_Lap_PS = IniRead($PitStops_INI, $Check_Name_Value_bea, "Lap_PS_1", "")

					If $Check_PitStops_PS = "" Then $Check_PitStops_PS = 0

					$Anzahl_Participants_Eintraege = IniRead($Participants_Data_INI, "PitStops", "NR", "")
					$Check_Name_Participants = $LOG_Name_value_4
					$Wert_CurrentLap = ""

					$Wert_CurrentLap = IniRead($Participants_Data_INI, $Check_Name_Participants, "CurrentLap", "")

					;If $Check_Name_PS = "" Then
						IniWrite($PitStops_INI, $LOG_Name_value_4, "Name", $LOG_Name_value_4)
						IniWrite($PitStops_INI, $LOG_Name_value_4, "PitStops", $Check_PitStops_PS + 1)
						IniWrite($PitStops_INI, $LOG_Name_value_4, "Time_PS_" & $Check_PitStops_PS, $Wert_LA_2)
						IniWrite($PitStops_INI, $LOG_Name_value_4, "Lap_PS_" & $Check_PitStops_PS, $Wert_CurrentLap)
						;IniWrite(@ScriptDir & "\PitStops.ini", "PitStops", "NR", $Anzahl_PS_Eintraege + 1)
					;EndIf

					FileWriteLine($PCDSG_LOG_ini, "PitStop_detected_" & $NowTime & "=" & "PitStop detected" & " | " & "Name: " & $LOG_Name_value_4 & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)

					;Server http settings lesen
					Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
					Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

					If $Lesen_Auswahl_httpApiInterface = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
					If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"

					If $LOG_Event_Check_auto_MSG = "true" Then
						$URL_PS_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & $LOG_Name_value_4 & " makes a Pit Stop." & " NR PitStops = " & $Check_PitStops_PS + 1
						$download = InetGet($URL_PS_MSG, @ScriptDir & "\Message.txt", 16, 0)
					EndIf


				EndIf

			EndIf
#EndRegion

#Region Check = CutTrackStart & Impact & Points
			If $LOG_Event_Check_Points_System = "true" Then
				If $LOG_Event_Check_Points_TrackCut = "true" Then

					If $Wert_LA_3 = "CutTrackStart" Then

						FileWriteLine($PCDSG_LOG_ini, "CutTrack_" & $NowTime & "=" & "CutTrackStart")

						Global $LOG_CutTrackStart_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
						Global $LOG_CutTrackStart_attribute_participantid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_participantid", "") ; attribute_participantid
						Global $LOG_CutTrackStart_attribute_Lap = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Lap", "") ; attribute_Lap
						Global $LOG_CutTrackStart_attribute_RacePosition = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_RacePosition", "") ; attribute_RacePosition
						Global $LOG_CutTrackStart_attribute_IsMainBranch = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_IsMainBranch", "") ; attribute_IsMainBranch
						Global $LOG_CutTrackStart_attribute_LapTime = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_LapTime", "") ; attribute_LapTime

						$Date = @YEAR & "-" & @MON & "-" & @MDAY & "_" & @HOUR & "-" & @MIN

						;MsgBox(0, "CutTrackStart", "CutTrackStart Detected", 3)

						$LOG_value_4 = $LOG_CutTrackStart_attribute_refid ; refid
						$LOG_value_5 = $LOG_CutTrackStart_attribute_Lap ;Lap
						$LOG_value_RacePosition = $LOG_CutTrackStart_attribute_RacePosition ; RacePosition
						$LOG_value_PenaltyThreshold = $LOG_CutTrackStart_attribute_IsMainBranch ; PenaltyThreshold

						Global $Wert_Check_refid = $LOG_value_4
						Global $LOG_Name_Label_4 = ""
						Global $LOG_Name_value_4 = ""


						IniWrite($config_ini, "TEMP", "Wert_Check_Refid", $Wert_Check_refid)
						IniWrite($config_ini, "TEMP", "Wert_Check_Name", "")

						;_Name_from_refid()
						$Wert_Check_Refid_Name = IniRead($Members_Data_INI, $Wert_Check_refid, "name", "")

						;$Wert_Check_Refid_Name = IniRead($config_ini, "TEMP", "Wert_Check_Name", "")
						$LOG_Name_value_4 = $Wert_Check_Refid_Name

						If $Wert_Check_Refid_Name = "" Then $LOG_Name_value_4 = IniRead($Refid_INI, $refid_log, "Name", "unknown")

						$Check_Name_Value_bea = $Wert_Check_Refid_Name
						;$String_Check = StringMid($Check_Name_Value_bea, 1, 1)

						If $Check_Name_Value_bea <> "" Then
							$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "[", "<")
							$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "]", ">")
						EndIf

						If $Check_Name_Value_bea = "" Then $Check_Name_Value_bea = $Wert_Check_Refid_Name

						$NR_TrackCut = IniRead($CutTrack_ini, $Check_Name_Value_bea, "NR_TrackCut", "")
						$Time_TC = $Date

						IniWrite($CutTrack_ini, $Check_Name_Value_bea, "NR_TrackCut", $NR_TrackCut + 1)
						IniWrite($CutTrack_ini, $Check_Name_Value_bea, "Value_TC" & $NR_TrackCut + 1, $LOG_value_PenaltyThreshold)
						IniWrite($CutTrack_ini, $Check_Name_Value_bea, "Lap_TC" & $NR_TrackCut + 1, $LOG_value_5)
						IniWrite($CutTrack_ini, $Check_Name_Value_bea, "Pos_TC" & $NR_TrackCut + 1, $LOG_value_RacePosition)
						IniWrite($CutTrack_ini, $Check_Name_Value_bea, "Time_TC" & $NR_TrackCut + 1, $Time_TC)

						$Wert_ExpiriencePoints = ""
						$Check_Name_Points = ""
						$Check_PenaltyPoints_Points = ""
						;$Check_ExperiencePoints_Points = ""
						$Check_Classification_Points = ""

						$Check_Name_Points = IniRead($Points_ini, $Check_Name_Value_bea, "Name", "")
						$Check_PenaltyPoints_Points = IniRead($Points_ini, $Check_Name_Value_bea, "PenaltyPoints", "")
						;$Check_ExperiencePoints_Points = IniRead($Points_ini, $LOG_Name_value_4, "ExperiencePoints", "")
						$Check_ExperiencePoints_Stats = IniRead($Stats_INI, $Check_Name_Value_bea, "ExperiencePoints", "")
						$Check_Classification_Points = IniRead($Points_ini, $Check_Name_Value_bea, "Classification", "")


						;MsgBox(0, "", $Check_ExperiencePoints_Points & " - " & $Check_ExperiencePoints_Stats)


						;If $Check_ExperiencePoints_Points < $Check_ExperiencePoints_Stats Then
							$Wert_ExpiriencePoints = $Check_ExperiencePoints_Stats ; + $Check_ExperiencePoints_Points
						;EndIf



						$Penalty_TrackCut_Value = IniRead($config_ini, "Race_Control", "Value_Points_TrackCut", "")

						$Wert_Points = $Check_PenaltyPoints_Points

						;If $Check_Name_Points <> "" Then
							IniWrite($Points_ini, $Check_Name_Value_bea, "PenaltyPoints", $Check_PenaltyPoints_Points + $Penalty_TrackCut_Value)
							;IniWrite($Points_ini, $LOG_Name_value_4, "ExperiencePoints", $Wert_ExpiriencePoints - $Penalty_TrackCut_Value - $Penalty_TrackCut_Value)
							IniWrite($Stats_INI, $Check_Name_Value_bea, "ExperiencePoints", $Wert_ExpiriencePoints - $Penalty_TrackCut_Value - $Penalty_TrackCut_Value)
						;EndIf


						;Server http settings lesen
						Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
						Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

						If $Lesen_Auswahl_httpApiInterface = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
						If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"


						If $Wert_Check_Refid_Name <> "" Then
							$Wert_Check_Refid_Name = StringReplace($Wert_Check_Refid_Name, "<", "[")
							$Wert_Check_Refid_Name = StringReplace($Wert_Check_Refid_Name, ">", "]")
						EndIf

						If $LOG_Event_Check_auto_MSG = "true" Then

							$RefID_user = $Wert_Check_refid

							$PP_Message_0 = "     "
							$PP_Message_1 = "PCDSG: " & " <<< Penalty Points  >>>"
							$PP_Message_2 = "User: " & $Wert_Check_Refid_Name
							$PP_Message_3 = "PenaltyPoints: " & $Wert_Points + $Penalty_TrackCut_Value & " @: " & $Date

							$URL_PP_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $PP_Message_0
							$download = InetGet($URL_PP_MSG, @ScriptDir & "\Message.txt", 16, 0)

							$URL_PP_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $PP_Message_1
							$download = InetGet($URL_PP_MSG, @ScriptDir & "\Message.txt", 16, 0)

							$URL_PP_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $PP_Message_2
							$download = InetGet($URL_PP_MSG, @ScriptDir & "\Message.txt", 16, 0)

							$URL_PP_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $PP_Message_3
							$download = InetGet($URL_PP_MSG, @ScriptDir & "\Message.txt", 16, 0)

						EndIf

						_SG_Calculation()
						IniWrite($config_ini, "TEMP", "Wert_Check_Name", $Wert_Check_Refid_Name)
						_Auto_KICK_Points()
						IniWrite($config_ini, "TEMP", "Wert_Check_Name", "")

					EndIf

				EndIf



				If $LOG_Event_Check_Points_Impact = "true" Then

					If $Wert_LA_3 = "Impact" Then
						FileWriteLine($PCDSG_LOG_ini, "Impact_" & $NowTime & "=" & "Impact")

						Global $LOG_Index_Check_other = $LOG_Index_Check + 1

						Global $LOG_Impact_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
						Global $LOG_Impact_attribute_participantid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_participantid", "") ; attribute_participantid
						Global $LOG_Impact_attribute_OtherParticipantId = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_OtherParticipantId", "") ; attribute_OtherParticipantId
						Global $LOG_Impact_attribute_CollisionMagnitude = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_CollisionMagnitude", "") ; attribute_CollisionMagnitude
						Global $LOG_Impact_attribute_CollisionMagnitude_other = IniRead($LOG_Data_INI, $LOG_Index_Check_other, "attribute_CollisionMagnitude", "")
						Global $LOG_Impact_attribute_refid_other = IniRead($Members_Data_INI, $LOG_Impact_attribute_OtherParticipantId, "refid", "")

						$Date = @YEAR & "-" & @MON & "-" & @MDAY & "_" & @HOUR & "-" & @MIN

						;MsgBox(0, "Impact", "Impact Detected", 3)

						$LOG_value_4 = $LOG_Impact_attribute_refid ; Value refid
						$LOG_value_5 = $LOG_Impact_attribute_participantid ; Value participantid
						$LOG_Label_6 = "OtherParticipantId" ; Label OtherParticipantId
						$LOG_value_6 = $LOG_Impact_attribute_OtherParticipantId ; Value Other ParticipantId
						$LOG_value_7 = $LOG_Impact_attribute_CollisionMagnitude ; Value CollisionMagnitude

						$Check_SessionStage = IniRead($Server_Data_INI, "DATA", "SessionStage", "2")

						If $Check_SessionStage = "Race1" Then

							$Check_Race_Position_1 = IniRead($Participants_Data_INI, $LOG_Impact_attribute_refid, "RacePosition", "2") ; own / eigene
							$Check_Race_Position_2_refid = IniRead($Members_Data_INI, $LOG_Impact_attribute_OtherParticipantId, "refid", "")
							$Check_Race_Position_2 = IniRead($Participants_Data_INI, $Check_Race_Position_2_refid, "RacePosition", "1") ; other / anderer

							;MsgBox(0, "", $Check_Race_Position_1 & " > " & $Check_Race_Position_2, 5)

							If $Check_Race_Position_1 > $Check_Race_Position_2 Then

								;MsgBox(0, "", $Check_Race_Position_1 & " > " & $Check_Race_Position_2, 5)

								If $LOG_Label_6 = "OtherParticipantId" Then
									If $LOG_value_6 <> "-1" Then
										Global $Wert_Check_refid = $LOG_value_4
										Global $LOG_Name_Label_4 = ""
										Global $LOG_Name_value_4 = ""

										IniWrite($config_ini, "TEMP", "Wert_Check_Refid", $Wert_Check_refid)
										IniWrite($config_ini, "TEMP", "Wert_Check_Name", "")

										;_Name_from_refid()
										$Wert_Check_Refid_Name = IniRead($Members_Data_INI, $Wert_Check_refid, "name", "")

										;$Wert_Check_Refid_Name = IniRead($config_ini, "TEMP", "Wert_Check_Name", "")
										$LOG_Name_value_4 = $Wert_Check_Refid_Name

										;$LOG_Name_value_4 = IniRead($config_ini, "TEMP", "Wert_Check_Name", "unknown")

										$NR_Impact = IniRead($Impact_ini, $LOG_Name_value_4, "NR_Impact", "")

										$Check_Name_Value_bea = $LOG_Name_value_4
										;$String_Check = StringMid($Check_Name_Value_bea, 1, 1)

										If $Check_Name_Value_bea <> "" Then
											$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "[", "<")
											$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "]", ">")
										EndIf

										If $Check_Name_Value_bea = "" Then $Check_Name_Value_bea = $LOG_Name_value_4

										IniWrite($Impact_ini, $Check_Name_Value_bea, "NR_Impact", $NR_Impact + 1)
										IniWrite($Impact_ini, $Check_Name_Value_bea, "Value_IP_" & $NR_Impact + 1, $LOG_value_4)
										IniWrite($Impact_ini, $Check_Name_Value_bea, "Time_IP_" & $NR_Impact + 1, $LOG_value_5)

										$Wert_ExpiriencePoints = ""
										$Wert_Points = ""
										$Check_Name_Points = ""
										$Check_PenaltyPoints_Points = ""
										;$Check_ExperiencePoints_Points = ""
										$Check_Classification_Points = ""

										$Wert_ExpiriencePoints = IniRead($Points_ini, $Check_Name_Value_bea, "ExperiencePoints", "")
										$Check_Name_Points = IniRead($Points_ini, $Check_Name_Value_bea, "Name", "")
										$Check_PenaltyPoints_Points = IniRead($Points_ini, $Check_Name_Value_bea, "PenaltyPoints", "")
										;$Check_ExperiencePoints_Points = IniRead($Points_ini, $LOG_Name_value_4, "ExperiencePoints", "")
										$Check_ExperiencePoints_Stats = IniRead($Stats_INI, $Check_Name_Value_bea, "ExperiencePoints", "")
										$Check_Classification_Points = IniRead($Stats_INI, $Check_Name_Value_bea, "SafetyGroup", "")


										;MsgBox(0, "", $Check_ExperiencePoints_Points & " - " & $Check_ExperiencePoints_Stats)

										;If $Check_ExperiencePoints_Points < $Check_ExperiencePoints_Stats Then
											$Wert_ExpiriencePoints = $Check_ExperiencePoints_Stats ; + $Check_ExperiencePoints_Points
										;EndIf

										$Penalty_Impact_Value = IniRead($config_ini, "Race_Control", "Value_Points_Impact", "")

										$Wert_Points = $Check_PenaltyPoints_Points

										;If $Check_Name_Points <> "" Then
											IniWrite($Points_ini, $Check_Name_Value_bea, "PenaltyPoints", $Check_PenaltyPoints_Points + $Penalty_Impact_Value)
											;IniWrite($Points_ini, $LOG_Name_value_4, "ExperiencePoints", $Wert_ExpiriencePoints - $Penalty_Impact_Value - $Penalty_Impact_Value)
											IniWrite($Stats_INI, $Check_Name_Value_bea, "ExperiencePoints", $Wert_ExpiriencePoints - $Penalty_Impact_Value - $Penalty_Impact_Value)
										;EndIf


										;Server http settings lesen
										Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
										Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

										If $Lesen_Auswahl_httpApiInterface = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
										If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"

										If $Wert_Check_Refid_Name <> "" Then
											$Wert_Check_Refid_Name = StringReplace($Wert_Check_Refid_Name, "<", "[")
											$Wert_Check_Refid_Name = StringReplace($Wert_Check_Refid_Name, ">", "]")
										EndIf

										If $LOG_Event_Check_auto_MSG = "true" Then

											$RefID_user = $Wert_Check_refid

											$PP_Message_0 = "     "
											$PP_Message_1 = "PCDSG: " & " <<< Penalty Points  >>>"
											$PP_Message_2 = "User: " & $Wert_Check_Refid_Name
											;$PP_Message_3 = $Wert_Points + $Penalty_Impact_Value & " @: " & $Date
											$PP_Message_3 = "PenaltyPoints: " & $Wert_Points + $Penalty_Impact_Value & " @: " & $Date

											$URL_PP_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $PP_Message_0
											$download = InetGet($URL_PP_MSG, @ScriptDir & "\Message.txt", 16, 0)

											$URL_PP_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $PP_Message_1
											$download = InetGet($URL_PP_MSG, @ScriptDir & "\Message.txt", 16, 0)

											$URL_PP_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $PP_Message_2
											$download = InetGet($URL_PP_MSG, @ScriptDir & "\Message.txt", 16, 0)

											$URL_PP_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $PP_Message_3
											$download = InetGet($URL_PP_MSG, @ScriptDir & "\Message.txt", 16, 0)

										EndIf

										_SG_Calculation()
										IniWrite($config_ini, "TEMP", "Wert_Check_Name", $Wert_Check_Refid_Name)
										_Auto_KICK_Points()

									EndIf

								EndIf

							EndIf

						Else

							Global $Wert_Check_refid = $LOG_value_4

							If 	$LOG_Impact_attribute_CollisionMagnitude > $LOG_Impact_attribute_CollisionMagnitude_other Then $Wert_Check_refid = $LOG_Impact_attribute_refid
							If 	$LOG_Impact_attribute_CollisionMagnitude < $LOG_Impact_attribute_CollisionMagnitude_other Then $Wert_Check_refid = $LOG_Impact_attribute_refid_other


							If $LOG_Label_6 = "OtherParticipantId" Then
								If $LOG_value_6 <> "-1" Then
									;Global $Wert_Check_refid = $LOG_value_4
									Global $LOG_Name_Label_4 = ""
									Global $LOG_Name_value_4 = ""

									IniWrite($config_ini, "TEMP", "Wert_Check_Refid", $Wert_Check_refid)
									IniWrite($config_ini, "TEMP", "Wert_Check_Name", "")

									;_Name_from_refid()
									$Wert_Check_Refid_Name = IniRead($Members_Data_INI, $Wert_Check_refid, "name", "")

									;$Wert_Check_Refid_Name = IniRead($config_ini, "TEMP", "Wert_Check_Name", "")
									$LOG_Name_value_4 = $Wert_Check_Refid_Name

									;$LOG_Name_value_4 = IniRead($config_ini, "TEMP", "Wert_Check_Name", "unknown")

									$NR_Impact = IniRead($Impact_ini, $LOG_Name_value_4, "NR_Impact", "")

									$Check_Name_Value_bea = $LOG_Name_value_4
									;$String_Check = StringMid($Check_Name_Value_bea, 1, 1)

									If $Check_Name_Value_bea <> "" Then
										$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "[", "<")
										$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "]", ">")
									EndIf

									If $Check_Name_Value_bea = "" Then $Check_Name_Value_bea = $LOG_Name_value_4

									IniWrite($Impact_ini, $Check_Name_Value_bea, "NR_Impact", $NR_Impact + 1)
									IniWrite($Impact_ini, $Check_Name_Value_bea, "Value_IP_" & $NR_Impact + 1, $LOG_value_4)
									IniWrite($Impact_ini, $Check_Name_Value_bea, "Time_IP_" & $NR_Impact + 1, $LOG_value_5)

									$Wert_ExpiriencePoints = ""
									$Wert_Points = ""
									$Check_Name_Points = ""
									$Check_PenaltyPoints_Points = ""
									;$Check_ExperiencePoints_Points = ""
									$Check_Classification_Points = ""

									$Wert_ExpiriencePoints = IniRead($Points_ini, $Check_Name_Value_bea, "ExperiencePoints", "")
									$Check_Name_Points = IniRead($Points_ini, $Check_Name_Value_bea, "Name", "")
									$Check_PenaltyPoints_Points = IniRead($Points_ini, $Check_Name_Value_bea, "PenaltyPoints", "")
									;$Check_ExperiencePoints_Points = IniRead($Points_ini, $LOG_Name_value_4, "ExperiencePoints", "")
									$Check_ExperiencePoints_Stats = IniRead($Stats_INI, $Check_Name_Value_bea, "ExperiencePoints", "")
									$Check_Classification_Points = IniRead($Stats_INI, $Check_Name_Value_bea, "SafetyGroup", "")


									;MsgBox(0, "", $Check_ExperiencePoints_Points & " - " & $Check_ExperiencePoints_Stats)

									;If $Check_ExperiencePoints_Points < $Check_ExperiencePoints_Stats Then
										$Wert_ExpiriencePoints = $Check_ExperiencePoints_Stats ; + $Check_ExperiencePoints_Points
									;EndIf

									$Penalty_Impact_Value = IniRead($config_ini, "Race_Control", "Value_Points_Impact", "")

									$Wert_Points = $Check_PenaltyPoints_Points

									;If $Check_Name_Points <> "" Then
										IniWrite($Points_ini, $Check_Name_Value_bea, "PenaltyPoints", $Check_PenaltyPoints_Points + $Penalty_Impact_Value)
										;IniWrite($Points_ini, $LOG_Name_value_4, "ExperiencePoints", $Wert_ExpiriencePoints - $Penalty_Impact_Value - $Penalty_Impact_Value)
										IniWrite($Stats_INI, $Check_Name_Value_bea, "ExperiencePoints", $Wert_ExpiriencePoints - $Penalty_Impact_Value - $Penalty_Impact_Value)
									;EndIf


									;Server http settings lesen
									Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
									Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

									If $Lesen_Auswahl_httpApiInterface = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
									If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"

									If $Wert_Check_Refid_Name <> "" Then
										$Wert_Check_Refid_Name = StringReplace($Wert_Check_Refid_Name, "<", "[")
										$Wert_Check_Refid_Name = StringReplace($Wert_Check_Refid_Name, ">", "]")
									EndIf

									If $LOG_Event_Check_auto_MSG = "true" Then

										$RefID_user = $Wert_Check_refid

										$PP_Message_0 = "     "
										$PP_Message_1 = "PCDSG: " & " <<< Penalty Points  >>>"
										$PP_Message_2 = "User: " & $Wert_Check_Refid_Name
										;$PP_Message_3 = $Wert_Points + $Penalty_Impact_Value & " @: " & $Date
										$PP_Message_3 = "PenaltyPoints: " & $Wert_Points + $Penalty_Impact_Value & " @: " & $Date

										$URL_PP_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $PP_Message_0
										$download = InetGet($URL_PP_MSG, @ScriptDir & "\Message.txt", 16, 0)

										$URL_PP_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $PP_Message_1
										$download = InetGet($URL_PP_MSG, @ScriptDir & "\Message.txt", 16, 0)

										$URL_PP_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $PP_Message_2
										$download = InetGet($URL_PP_MSG, @ScriptDir & "\Message.txt", 16, 0)

										$URL_PP_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefID_user & "?message=" & $PP_Message_3
										$download = InetGet($URL_PP_MSG, @ScriptDir & "\Message.txt", 16, 0)

									EndIf

									_SG_Calculation()
									IniWrite($config_ini, "TEMP", "Wert_Check_Name", $Wert_Check_Refid_Name)
									_Auto_KICK_Points()

								EndIf

							EndIf

						EndIf

					EndIf

				EndIf

			EndIf
#EndRegion Check

#Region Check = PlayerJoined
			If $Wert_LA_3 = "PlayerJoined" Then

				Global $LOG_PlayerJoined_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
				Global $LOG_PlayerJoined_attribute_name = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_name", "") ; attribute_name
				Global $LOG_PlayerJoined_attribute_attribute_steamID = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_steamID", "") ; attribute_steamID

				_Empy_Temp_1()
				FileWriteLine($PCDSG_LOG_ini, "PlayerJoined_" & $NowTime & "=" & "PlayerJoined" & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)

				;MsgBox(0, "PlayerJoined", "PlayerJoined Detected", 3)

				$LOG_value_4 = $LOG_PlayerJoined_attribute_refid ; refid
				$LOG_value_Name = $LOG_PlayerJoined_attribute_name ; name
				$LOG_value_5 = $LOG_PlayerJoined_attribute_attribute_steamID ; Steam ID

				Global $Wert_Check_refid = $LOG_value_4

				$LOG_Name_value_4 = $LOG_value_Name

				IniWrite($config_ini, "TEMP", "Wert_Check_Refid", $Wert_Check_refid)
				IniWrite($config_ini, "TEMP", "Wert_Check_Name", "")

				;_Name_from_refid()
				;$Wert_Check_Refid_Name = IniRead($Members_Data_INI, $Wert_Check_refid, "name", "")
				$Wert_Check_Refid_Name = $LOG_value_Name
				$Wert_Check_Refid_Name_bea = $Wert_Check_Refid_Name

				If $Wert_Check_Refid_Name_bea <> "" Then
					$Wert_Check_Refid_Name_bea = StringReplace($Wert_Check_Refid_Name_bea, "[", "<")
					$Wert_Check_Refid_Name_bea = StringReplace($Wert_Check_Refid_Name_bea, "]", ">")
				EndIf

				If $Wert_Check_Refid_Name_bea = "" Then $Wert_Check_Refid_Name_bea = $Wert_Check_Refid_Name

				;$Wert_Check_Refid_Name = IniRead($config_ini, "TEMP", "Wert_Check_Name", "")
				$LOG_value_Name = $Wert_Check_Refid_Name

				;If $Wert_Check_Refid_Name = "" Then $LOG_value_Name = IniRead($Refid_INI, $refid_log, "Name", "unknown")

				;$LOG_Name_value_4 = IniRead($config_ini, "TEMP", "Wert_Check_Name", "unknown")

				;If $LOG_Name_Label_4 = "" Then $LOG_Name_Label_4 = "Name"
				;If $LOG_Name_value_4 = "" Then $LOG_Name_value_4 = "unknown"


				$Check_Name_Points = IniRead($Points_ini, $Wert_Check_Refid_Name_bea, "Name", "")
				$Check_PenaltyPoints_Points = IniRead($Points_ini, $Wert_Check_Refid_Name_bea, "PenaltyPoints", "")
				;$Check_ExperiencePoints_Points = IniRead($Points_ini, $Wert_Check_Refid_Name_bea, "ExperiencePoints", "")
				$Check_ExperiencePoints_Stats = IniRead($Stats_INI, $Wert_Check_Refid_Name_bea, "ExperiencePoints", "")
				$Check_SafetyGroup = IniRead($Stats_INI, $Wert_Check_Refid_Name_bea, "SafetyGroup", "")


				$Check_ExperiencePoints_Points = $Check_ExperiencePoints_Stats ; + $Check_ExperiencePoints_Points


				$Wert_PP_Points = $Check_PenaltyPoints_Points
				$Wert_EP_Points = $Check_ExperiencePoints_Points
				;If $LOG_Name_value_4 = "unknown" Then $Wert_EP_Points = "0"

				;MsgBox(0, "PlayerJoined", "New Player Joined. Wellcome to PCDSG Server", 3)

				;Server http settings lesen
				Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
				Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

				If $Lesen_Auswahl_httpApiInterface = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
				If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"


				If $Wert_Check_Refid_Name_bea <> "" Then
					$Wert_Check_Refid_Name_bea = StringReplace($Wert_Check_Refid_Name_bea, "<", "[")
					$Wert_Check_Refid_Name_bea = StringReplace($Wert_Check_Refid_Name_bea, ">", "]")
				EndIf



				;MsgBox(0, "", "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "New Player <" & $LOG_value_Name & "> Joined. " & @TAB & @TAB & "ExperiencePoints: <" & $Wert_EP_Points & "> Wellcome to PCDSG Server")
				;If $LOG_Event_Check_auto_MSG = "true" Then
					$NP_Message_0 = "     "
					$NP_Message_1 = "New Player <" & $Wert_Check_Refid_Name_bea & "> Joined. "
					$NP_Message_2 = "ExperiencePoints: <" & $Wert_EP_Points & ">"
					$NP_Message_3 = "SafetyGroup: <" & $Check_SafetyGroup & ">"

					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $NP_Message_0
					$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $NP_Message_1
					$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $NP_Message_2
					$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $NP_Message_3
					$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
				;EndIf

				IniWrite($Refid_INI, $LOG_value_4, "Name", $LOG_value_Name)


			EndIf
#EndRegion

#Region Check = Lap
			;If $LOG_Event_Check_auto_MSG <> "false" Then

			If $Wert_LA_3 = "Lap" Then

				Global $CurrentSessionStage = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
				If $CurrentSessionStage = "" Then $CurrentSessionStage = IniRead($config_ini, "PC_Server", "SessionStage", "")

				Global $LOG_Lap_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
				Global $LOG_Lap_attribute_participantid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_participantid", "") ; attribute_participantid
				Global $LOG_Lap_attribute_Lap = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Lap", "") ; attribute_Lap
				Global $LOG_Lap_attribute_LapTime = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_LapTime", "") ; attribute_LapTime
				Global $LOG_Lap_attribute_Sector1Time = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Sector1Time", "") ; attribute_Sector1Time
				Global $LOG_Lap_attribute_Sector2Time = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Sector2Time", "") ; attribute_Sector2Time
				Global $LOG_Lap_attribute_Sector3Time = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Sector3Time", "") ; attribute_Sector3Time
				Global $LOG_Lap_attribute_RacePosition = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_RacePosition", "") ; attribute_RacePosition
				Global $LOG_Lap_attribute_DistanceTravelled = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_DistanceTravelled", "") ; attribute_DistanceTravelled
				Global $LOG_Lap_attribute_CountThisLapTimes = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_CountThisLapTimes", "") ; attribute_CountThisLapTimes


				_Empy_Temp_1()
				FileWriteLine($PCDSG_LOG_ini, "Lap_" & $NowTime & "=" & "RefID: " & $LOG_Lap_attribute_refid & " | " & "Lap: " & $LOG_Lap_attribute_Lap)

				;MsgBox(0, "Lap", "Lap Detected", 3)

				$LOG_value_4 = $LOG_Lap_attribute_refid ; refid

				Global $Wert_Check_refid = $LOG_value_4
				;Global $Wert_Check_refid = $Wert_refid
				Global $LOG_Name_Label_4 = ""
				Global $LOG_Name_value_4 = ""

				IniWrite($config_ini, "TEMP", "Wert_Check_Refid", $Wert_Check_refid)
				IniWrite($config_ini, "TEMP", "Wert_Check_Name", "")

				;_Name_from_refid()
				$Wert_Check_Refid_Name = IniRead($Members_Data_INI, $Wert_Check_refid, "name", "")

				$Wert_Check_Refid_Name_bea = $Wert_Check_Refid_Name

				If $Wert_Check_Refid_Name_bea <> "" Then
					$Wert_Check_Refid_Name_bea = StringReplace($Wert_Check_Refid_Name_bea, "[", "<")
					$Wert_Check_Refid_Name_bea = StringReplace($Wert_Check_Refid_Name_bea, "]", ">")
				EndIf

				If $Wert_Check_Refid_Name_bea = "" Then $Wert_Check_Refid_Name_bea = $Wert_Check_Refid_Name

				;$Wert_Check_Refid_Name = IniRead($config_ini, "TEMP", "Wert_Check_Name", "")
				$LOG_Name_value_4 = $Wert_Check_Refid_Name

				If $Wert_Check_Refid_Name = "" Then $LOG_Name_value_4 = IniRead($Refid_INI, $refid_log, "Name", "unknown")

				Global $Wert_PenaltyPoints = IniRead($Points_ini, $Wert_Check_Refid_Name_bea, "PenaltyPoints", "")
				;Global $Wert_ExpiriencePoints = IniRead($Points_ini, $LOG_Name_value_4, "ExperiencePoints", "")
				Global $Check_ExperiencePoints_Stats = IniRead($Stats_INI, $Wert_Check_Refid_Name_bea, "ExperiencePoints", "")
				Global $Check_DistanceTravelled_value = IniRead($Stats_INI, $Wert_Check_Refid_Name_bea, "DistanceTravelled", "")



				;If $Wert_ExpiriencePoints < $Check_ExperiencePoints_Stats Then
					Global $Wert_ExpiriencePoints = $Check_ExperiencePoints_Stats
				;EndIf


				$LOG_index_value = $Wert_LA_1 ; index
				$LOG_time_value = $Wert_LA_2 ; time
				$LOG_name_value = $Wert_LA_3 ; name
				$LOG_refid_value = $LOG_Lap_attribute_refid ; refid
					$RefIF_send = $LOG_refid_value
				$LOG_participantid_value = $LOG_Lap_attribute_participantid ; participantid
				$LOG_Lap_value = $LOG_Lap_attribute_Lap ; Lap
				Global $LOG_LapTime_value = $LOG_Lap_attribute_LapTime ; LapTime
				$LOG_Sector1Time_value = $LOG_Lap_attribute_Sector1Time ; Sector1Time
				$LOG_Sector2Time_value = $LOG_Lap_attribute_Sector2Time ; Sector2Time
				$LOG_Sector3Time_value = $LOG_Lap_attribute_Sector3Time ; Sector3Time
				$LOG_RacePosition_value = $LOG_Lap_attribute_RacePosition ; RacePosition
				$LOG_DistanceTravelled_value = $LOG_Lap_attribute_DistanceTravelled ; DistanceTravelled
				$LOG_CountThisLapTimes_value = $LOG_Lap_attribute_CountThisLapTimes ; CountThisLapTimes


				If $LOG_LapTime_value = "" Then $LOG_LapTime_value = 99999999

				$Current_TrackID = IniRead($Server_Data_INI, "DATA", "TrackId", "")
				IniWrite($config_ini, "TEMP", "Check_Trackid", $Current_TrackID)

				;_TRACK_NAME_from_ID()
				_CAR_NAME_from_ID()

				$Value_CAR_NAME = IniRead($config_ini, "TEMP", "Check_CarName", "")

				;$Current_TrackName = IniRead($config_ini, "TEMP", "Check_TrackName", "")
				$Current_TrackName = IniRead($Server_Data_INI, "DATA", "TrackName", "")
				$Check_Track_Laptime = IniRead($Stats_INI, $Wert_Check_Refid_Name_bea, $Current_TrackName & "_" & $Value_CAR_NAME, "")
				If $Check_Track_Laptime = "" Then $Check_Track_Laptime = 9999999999

				$Wert_DistanceTravelled = $LOG_DistanceTravelled_value / $EP_Variant_Divider ; $EP_Variant_Divider = 4 (standard)
				$Wert_ExpiriencePoints_write = $Wert_ExpiriencePoints + $Wert_DistanceTravelled
				$Wert_ExpiriencePoints_write = Round($Wert_ExpiriencePoints_write, 0)

				Global $DistanceTravelled_write = $Check_DistanceTravelled_value + $LOG_DistanceTravelled_value

				IniWrite($Stats_INI, $Wert_Check_Refid_Name_bea, "Name", $LOG_Name_value_4)
				;IniWrite($Points_ini, $LOG_Name_value_4, "ExperiencePoints", $Wert_ExpiriencePoints_write)
				IniWrite($Stats_INI, $Wert_Check_Refid_Name_bea, "ExperiencePoints", $Wert_ExpiriencePoints_write)
				IniWrite($Stats_INI, $Wert_Check_Refid_Name_bea, "DistanceTravelled", $DistanceTravelled_write)


				$Value_SG1_min_read = IniRead($config_ini, "Race_Control", "Value_SG1_min", "")
				$Value_SG2_min_read = IniRead($config_ini, "Race_Control", "Value_SG2_min", "")
				$Value_SG2_max_read = IniRead($config_ini, "Race_Control", "Value_SG2_max", "")
				$Value_SG3_min_read = IniRead($config_ini, "Race_Control", "Value_SG3_min", "")
				$Value_SG3_max_read = IniRead($config_ini, "Race_Control", "Value_SG3_max", "")
				$Value_SG4_min_read = IniRead($config_ini, "Race_Control", "Value_SG4_min", "")
				$Value_SG4_max_read = IniRead($config_ini, "Race_Control", "Value_SG4_max", "")
				$Value_SG5_min_read = IniRead($config_ini, "Race_Control", "Value_SG5_min", "")
				$Value_SG5_max_read = IniRead($config_ini, "Race_Control", "Value_SG5_max", "")


				$EP_Group = "6"

				If $Wert_ExpiriencePoints_write >= $Value_SG5_min_read And $Wert_ExpiriencePoints_write <= $Value_SG5_max_read Then
					$EP_Group = "5"
				EndIf

				If $Wert_ExpiriencePoints_write >= $Value_SG4_min_read And $Wert_ExpiriencePoints_write <= $Value_SG4_max_read Then
					$EP_Group = "4"
				EndIf

				If $Wert_ExpiriencePoints_write >= $Value_SG3_min_read And $Wert_ExpiriencePoints_write <= $Value_SG3_max_read Then
					$EP_Group = "3"
				EndIf

				If $Wert_ExpiriencePoints_write >= $Value_SG2_min_read And $Wert_ExpiriencePoints_write <= $Value_SG2_max_read Then
					$EP_Group = "2"
				EndIf

				If $Wert_ExpiriencePoints_write > $Value_SG1_min_read Then
					$EP_Group = "1"
				EndIf



				If $EP_Group = "" Then $EP_Group = "6"

				IniWrite($Stats_INI, $Wert_Check_Refid_Name_bea, "SafetyGroup", $EP_Group)


				; LapTime umwandeln
				_Time_Update()

				;MsgBox(0, "", $LOG_LapTime_value & " - : - " & $Check_Track_Laptime)



				$Check_ServerBest_LapTime = IniRead($ServerBest_INI, $Current_TrackName & "_" & $Value_CAR_NAME, "LapTime", "")
				If $Check_ServerBest_LapTime = "" Then $Check_ServerBest_LapTime = 9999999999


				If $LOG_LapTime_value < $Check_ServerBest_LapTime Then

					Global $Wert_ExpiriencePoints_for_SB = IniRead($config_ini, "Race_Control", "ExpiriencePoints_for_SB", "")

					If $Wert_ExpiriencePoints_for_SB = "" Then
						$Wert_ExpiriencePoints_for_SB = 999
						IniWrite($config_ini, "Race_Control", "ExpiriencePoints_for_SB", $Wert_ExpiriencePoints_for_SB)
					EndIf

					$Wert_ExpiriencePoints_write = $Wert_ExpiriencePoints_write + $Wert_ExpiriencePoints_for_SB

					$Message_SB_0 = "                               "
					$Message_SB_1 = "PCDSG: " & " <<< NEW Server BEST LAP >>>"
					$Message_SB_2 = "By: " & $LOG_Name_value_4 & " --> " & $LOG_LapTime_value
					$Message_SB_3 = "Experience Points: --> " & $Wert_ExpiriencePoints_write
					$Message_SB_4 = "Safety Group: --> " & $EP_Group
					;$Message_PB_5 = "Personal Best: --> " & $LOG_LapTime_value

					IniWrite($ServerBest_INI, $Current_TrackName & "_" & $Value_CAR_NAME, "Track", $Current_TrackName)
					IniWrite($ServerBest_INI, $Current_TrackName & "_" & $Value_CAR_NAME, "Car", $Value_CAR_NAME)
					IniWrite($ServerBest_INI, $Current_TrackName & "_" & $Value_CAR_NAME, "Name", $LOG_Name_value_4)
					IniWrite($ServerBest_INI, $Current_TrackName & "_" & $Value_CAR_NAME, "LapTime", $LOG_LapTime_value)
					IniWrite($ServerBest_INI, $Current_TrackName & "_" & $Value_CAR_NAME, "Date", _Now())

					FileWriteLine($PCDSG_LOG_ini, "NEW_SB_" & $NowTime & "=" & "Track" & $Current_TrackName & " | " & "LapTime: " & $LOG_LapTime_value & " | " & "Name: " & $LOG_Name_value_4 & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)

					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_SB_0
					$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_SB_1
					$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_SB_2
					$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
					Sleep(500)
					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_SB_3
					$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

					$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_SB_4
					$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
					Sleep(1000)

					_SG_Calculation()
				EndIf


				If $LOG_LapTime_value < $Check_Track_Laptime Then

				;_Name_from_refid()
				$Wert_Check_Refid_Name = IniRead($Members_Data_INI, $LOG_Lap_attribute_refid, "name", "")

				$Wert_Check_Refid_Name_bea = $Wert_Check_Refid_Name

				If $Wert_Check_Refid_Name_bea <> "" Then
					$Wert_Check_Refid_Name_bea = StringReplace($Wert_Check_Refid_Name_bea, "[", "<")
					$Wert_Check_Refid_Name_bea = StringReplace($Wert_Check_Refid_Name_bea, "]", ">")
				EndIf

				If $Wert_Check_Refid_Name_bea = "" Then $Wert_Check_Refid_Name_bea = $Wert_Check_Refid_Name

					Global $Wert_ExpiriencePoints_for_PB = IniRead($config_ini, "Race_Control", "ExpiriencePoints_for_PB", "")

					If $Wert_ExpiriencePoints_for_PB = "" Then
						$Wert_ExpiriencePoints_for_PB = 500
						IniWrite($config_ini, "Race_Control", "ExpiriencePoints_for_PB", $Wert_ExpiriencePoints_for_PB)
					EndIf

					$Wert_ExpiriencePoints_write = $Wert_ExpiriencePoints_write + $Wert_ExpiriencePoints_for_PB

					$Message_PB_0 = "                               "
					$Message_PB_1 = "PCDSG: " & " <<< NEW BEST PERSONAL LAP >>>"
					$Message_PB_2 = "By: " & $LOG_Name_value_4 & " --> " & $LOG_LapTime_value
					$Message_PB_3 = "Experience Points: --> " & $Wert_ExpiriencePoints_write
					$Message_PB_4 = "Safety Group: --> " & $EP_Group
					;$Message_PB_5 = "Personal Best: --> " & $LOG_LapTime_value

					IniWrite($Stats_INI, $Wert_Check_Refid_Name_bea, $Current_TrackName & "_" & $Value_CAR_NAME, $LOG_LapTime_value)
					FileWriteLine($PCDSG_LOG_ini, "NEW_PB_" & $NowTime & "=" & "Track" & $Current_TrackName & " | " & "LapTime: " & $LOG_LapTime_value & " | " & "Name: " & $LOG_Name_value_4 & " | " & "Date - Time: " & $NowDate & " - " & $NowTime)

					;MsgBox(0, "$RefIF_send", $RefIF_send)

					If $LOG_Event_Check_auto_MSG = "true" Then
						$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Message_PB_0
						$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

						$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Message_PB_1
						$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

						$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Message_PB_2
						$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

						$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Message_PB_3
						$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

						$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Message_PB_4
						$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
					EndIf

					_SG_Calculation()
				Else

					$PB = IniRead($Stats_INI, $LOG_Name_value_4, $Current_TrackName, "")

					If $PB = 99999999 Then
						$PB = "No recorded lap time available"
					EndIf

					If $PB = 9999999999 Then
						$PB = "No recorded lap time available"
					EndIf

					;Server http settings lesen
					Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
					Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

					If $Lesen_Auswahl_httpApiInterface = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
					If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"


					If $LOG_Name_value_4 <> "" Then
						$LOG_Name_value_4 = StringReplace($LOG_Name_value_4, "<", "[")
						$LOG_Name_value_4 = StringReplace($LOG_Name_value_4, ">", "]")
					EndIf

					$Message_LAP_0 = "                               "
					$Message_LAP_1 = "PCDSG: " & $LOG_Name_value_4 & " <<< ExperiencePoints >>>"
					$Message_LAP_2 = "Experience Points: --> " & $Wert_ExpiriencePoints_write
					$Message_LAP_3 = "Safety Group: --> " & $EP_Group
					$Message_LAP_4 = "Personal Best: --> " & $PB

					If $LOG_Event_Check_auto_MSG = "true" Then
						$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Message_LAP_0
						$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

						$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Message_LAP_1
						$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

						$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Message_LAP_2
						$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

						$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Message_LAP_3
						$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

						$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?" & $RefIF_send & "?message=" & $Message_LAP_4
						$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
					EndIf

					_SG_Calculation()

				EndIf

				$StatusCheck_Write_2_DB = IniRead($config_ini,"PC_Server", "Checkbox_PCDSG_SQLite3_settings_1", "")


#Region Check = Lap (write LapByLap)

				$Status_Checkbox_Results_LapByLap = IniRead($config_ini,"PC_Server", "Checkbox_Results_LapByLap", "")

				If $Status_Checkbox_Results_LapByLap = "true" Then

					Global $LapByLap_File = $System_Dir & "temp\LapByLap.ini"

					$Value_LapByLap_Name = $LOG_Name_value_4

					$Value_LapByLap_Name_bea = $Value_LapByLap_Name

					If $Value_LapByLap_Name_bea <> "" Then
						$Value_LapByLap_Name_bea = StringReplace($Value_LapByLap_Name_bea, "[", "<")
						$Value_LapByLap_Name_bea = StringReplace($Value_LapByLap_Name_bea, "]", ">")
					EndIf

					If $Value_LapByLap_Name_bea = "" Then $Value_LapByLap_Name_bea = $Value_LapByLap_Name


					Global $LOG_Lap_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
					Global $LOG_Lap_attribute_participantid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_participantid", "") ; attribute_participantid
					Global $LOG_Lap_attribute_Lap = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Lap", "") ; attribute_Lap
					Global $LOG_Lap_attribute_LapTime = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_LapTime", "") ; attribute_LapTime
					Global $LOG_Lap_attribute_Sector1Time = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Sector1Time", "") ; attribute_Sector1Time
					Global $LOG_Lap_attribute_Sector2Time = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Sector2Time", "") ; attribute_Sector2Time
					Global $LOG_Lap_attribute_Sector3Time = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Sector3Time", "") ; attribute_Sector3Time
					Global $LOG_Lap_attribute_RacePosition = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_RacePosition", "") ; attribute_RacePosition
					Global $LOG_Lap_attribute_DistanceTravelled = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_DistanceTravelled", "") ; attribute_DistanceTravelled
					Global $LOG_Lap_attribute_CountThisLapTimes = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_CountThisLapTimes", "") ; attribute_CountThisLapTimes

					$Value_LapByLap_RacePosition = $LOG_RacePosition_value
					$Value_LapByLap_Lap = $LOG_Lap_value
					$Value_LapByLap_LapTime = $LOG_LapTime_value
					$Value_LapByLap_Sector1Time = $LOG_Sector1Time_value
					$Value_LapByLap_Sector2Time = $LOG_Sector2Time_value
					$Value_LapByLap_Sector3Time = $LOG_Sector3Time_value
					$Value_LapByLap_DistanceTravelled = $LOG_DistanceTravelled_value
					$Value_LapByLap_CountThisLapTimes = $LOG_CountThisLapTimes_value
					$Value_LapByLap_PS = IniRead($Info_PitStops_ini, $Value_LapByLap_Name_bea, "PitStops","")
					$Value_LapByLap_PP = IniRead($Points_ini, $Value_LapByLap_Name_bea, "PenaltyPoints","")
					$Value_LapByLap_EP = IniRead($Stats_INI, $Value_LapByLap_Name_bea, "ExperiencePoints", "")
					Global $Value_LapByLap_Time = $LOG_time_value

					;$iEpochTime = $Value_LapByLap_Time
					;IniWrite($config_ini, "TEMP", "Seconds_to_Time", $Value_LapByLap_Time)
					;_EPOCH_decrypt($iEpochTime)
					;_Lap_Time_convert()
					;$Value_LapByLap_Time = IniRead($config_ini, "TEMP", "Seconds_to_Time", "")
					If $Value_LapByLap_Time = "" Then $Value_LapByLap_Time = $LOG_time_value

					If $Value_LapByLap_Name <> "" Then
						$Value_LapByLap_Name_bea = StringReplace($Value_LapByLap_Name, "[", "<")
						$Value_LapByLap_Name_bea = StringReplace($Value_LapByLap_Name_bea, "]", ">")
					EndIf

					If $Value_LapByLap_Name_bea = "" Then $Value_LapByLap_Name_bea = $Value_LapByLap_Name

					$Check_INI_Name_Exist = IniRead($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "Name", "")

					If $Check_INI_Name_Exist = "" Then
						FileWriteLine($LapByLap_File, " ")
						IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "Name", $Value_LapByLap_Name)
					EndIf


					$Now_Date_Time = _Now()

					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "Name", $Value_LapByLap_Name)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "Index", $Wert_Index_Check_LOG)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "Time", $Now_Date_Time)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "RefID", $LOG_Lap_attribute_refid)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "ParticipantID", $LOG_Lap_attribute_participantid)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "RacePosition", $LOG_Lap_attribute_RacePosition)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "Laps", $LOG_Lap_attribute_Lap)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "PitStops", $Value_LapByLap_PS)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "PenaltyPoints", $Value_LapByLap_PP)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "ExperiencePoints", $Value_LapByLap_EP)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "LAP_" & $Value_LapByLap_Lap & "_LapTime", $Value_LapByLap_LapTime)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "LAP_" & $Value_LapByLap_Lap & "_Sector1Time", $LOG_Lap_attribute_Sector1Time)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "LAP_" & $Value_LapByLap_Lap & "_Sector2Time", $LOG_Lap_attribute_Sector2Time)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "LAP_" & $Value_LapByLap_Lap & "_Sector3Time", $LOG_Lap_attribute_Sector3Time)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "LAP_" & $Value_LapByLap_Lap & "_RacePosition", $LOG_Lap_attribute_RacePosition)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "LAP_" & $Value_LapByLap_Lap & "_DistanceTravelled", $LOG_Lap_attribute_DistanceTravelled)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_Name_" & $Value_LapByLap_Name_bea, "LAP_" & $Value_LapByLap_Lap & "_CountThisLapTimes", $LOG_Lap_attribute_CountThisLapTimes)

					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "Name", $Value_LapByLap_Name)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "Index", $Wert_Index_Check_LOG)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "Time", $Now_Date_Time)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "RefID", $LOG_Lap_attribute_refid)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "ParticipantID", $LOG_Lap_attribute_participantid)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "RacePosition", $LOG_Lap_attribute_RacePosition)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "Laps", $LOG_Lap_attribute_Lap)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "PitStops", $Value_LapByLap_PS)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "PenaltyPoints", $Value_LapByLap_PP)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "ExperiencePoints", $Value_LapByLap_EP)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "LAP_" & $Value_LapByLap_Lap & "_LapTime", $Value_LapByLap_Time)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "LAP_" & $Value_LapByLap_Lap & "_Sector1Time", $LOG_Lap_attribute_Sector1Time)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "LAP_" & $Value_LapByLap_Lap & "_Sector2Time", $LOG_Lap_attribute_Sector2Time)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "LAP_" & $Value_LapByLap_Lap & "_Sector3Time", $LOG_Lap_attribute_Sector3Time)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "LAP_" & $Value_LapByLap_Lap & "_RacePosition", $LOG_Lap_attribute_RacePosition)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "LAP_" & $Value_LapByLap_Lap & "_DistanceTravelled", $LOG_Lap_attribute_DistanceTravelled)
					IniWrite($LapByLap_File, $CurrentSessionStage & "_RefID_" & $LOG_Lap_attribute_refid, "LAP_" & $Value_LapByLap_Lap & "_CountThisLapTimes", $LOG_Lap_attribute_CountThisLapTimes)

				EndIf
#EndRegion Check = Lap (write LapByLap)

				$LOG_LapTime_value = ""

			EndIf

#EndRegion

#Region Check = StateChanged 1

			If $Wert_LA_3 = "StateChanged" Then
				Global $LOG_StateChanged_attribute_PreviousState = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_PreviousState", "") ; attribute_PreviousState
				Global $LOG_StateChanged_attribute_attribute_NewState = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_NewState", "") ; attribute_NewState
				;_Empy_Temp_1()
				IniWrite($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
				FileWriteLine($PCDSG_LOG_ini, "StateChanged_" & $NowTime & "=" & "PreviousState: " & $LOG_StateChanged_attribute_PreviousState & " | " & "NewState: " & $LOG_StateChanged_attribute_attribute_NewState)

				If $LOG_StateChanged_attribute_PreviousState = "Lobby" and $LOG_StateChanged_attribute_attribute_NewState = "Loading" Then
					_Delete_PP()
					_Delete_PitStops()
					_Delete_CutTrack()
					_Delete_Impact()
					_Delete_LapByLap_INI()
					_Delete_Results_INI()
					_Empy_Temp_2()
				EndIf

			EndIf

			FileCopy($Participants_Data_INI, $Participants_Data_INI_TEMP)
#EndRegion

#Region Check = Results 1
			If $Wert_LA_3 = "Results" Then

				Global $LOG_Results_attribute_refid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_refid", "") ; attribute_refid
				Global $LOG_Results_attribute_participantid = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_participantid", "") ; attribute_participantid
				Global $LOG_Results_attribute_RacePosition = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_RacePosition", "") ; attribute_RacePosition
				Global $LOG_Results_attribute_Lap = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Lap", "") ; attribute_Lap
				Global $LOG_Results_attribute_VehicleId = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_VehicleId", "") ; attribute_VehicleId
				Global $LOG_Results_attribute_State = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_State", "") ; attribute_State
				Global $LOG_Results_attribute_TotalTime = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_TotalTime", "") ; attribute_TotalTime
				Global $LOG_Results_attribute_FastestLapTime = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_FastestLapTime", "") ; attribute_FastestLapTime

				Global $LOG_LapTime_value = $LOG_Results_attribute_FastestLapTime
				_Time_Update()
				$LOG_Results_attribute_FastestLapTime = $LOG_LapTime_value

				Global $LOG_LapTime_value = $LOG_Results_attribute_TotalTime
				_Time_Update()
				$LOG_Results_attribute_TotalTime = $LOG_LapTime_value

				$LOG_Name_from_ID = IniRead($Participants_Data_INI, $LOG_Results_attribute_refid, "Name", "")
				If $LOG_Name_from_ID = "" Then $LOG_Name_from_ID = IniRead($Members_Data_INI, $LOG_Results_attribute_refid, "name", "")

				IniWrite($Results_INI, $LOG_Results_attribute_refid, "attribute_name", $LOG_Name_from_ID)
				IniWrite($Results_INI, $LOG_Results_attribute_refid, "attribute_refid", $LOG_Results_attribute_refid)
				IniWrite($Results_INI, $LOG_Results_attribute_refid, "attribute_participantid", $LOG_Results_attribute_participantid)
				IniWrite($Results_INI, $LOG_Results_attribute_refid, "attribute_RacePosition", $LOG_Results_attribute_RacePosition)
				IniWrite($Results_INI, $LOG_Results_attribute_refid, "attribute_Lap", $LOG_Results_attribute_Lap)
				IniWrite($Results_INI, $LOG_Results_attribute_refid, "attribute_VehicleId", $LOG_Results_attribute_VehicleId)
				IniWrite($Results_INI, $LOG_Results_attribute_refid, "attribute_State", $LOG_Results_attribute_State)
				IniWrite($Results_INI, $LOG_Results_attribute_refid, "attribute_TotalTime", $LOG_Results_attribute_TotalTime)
				IniWrite($Results_INI, $LOG_Results_attribute_refid, "attribute_FastestLapTime", $LOG_Results_attribute_FastestLapTime)

				IniWrite($Results_INI, $LOG_Results_attribute_RacePosition, "attribute_name", $LOG_Name_from_ID)
				IniWrite($Results_INI, $LOG_Results_attribute_RacePosition, "attribute_refid", $LOG_Results_attribute_refid)
				IniWrite($Results_INI, $LOG_Results_attribute_RacePosition, "attribute_participantid", $LOG_Results_attribute_participantid)
				IniWrite($Results_INI, $LOG_Results_attribute_RacePosition, "attribute_RacePosition", $LOG_Results_attribute_RacePosition)
				IniWrite($Results_INI, $LOG_Results_attribute_RacePosition, "attribute_Lap", $LOG_Results_attribute_Lap)
				IniWrite($Results_INI, $LOG_Results_attribute_RacePosition, "attribute_VehicleId", $LOG_Results_attribute_VehicleId)
				IniWrite($Results_INI, $LOG_Results_attribute_RacePosition, "attribute_State", $LOG_Results_attribute_State)
				IniWrite($Results_INI, $LOG_Results_attribute_RacePosition, "attribute_TotalTime", $LOG_Results_attribute_TotalTime)
				IniWrite($Results_INI, $LOG_Results_attribute_RacePosition, "attribute_FastestLapTime", $LOG_Results_attribute_FastestLapTime)

				IniWrite($config_ini, "TEMP", "ResultsSaved", "true")
				IniWrite($config_ini, "TEMP", "ResultsIndexNR", $Wert_LA_1)

				;Global $Wert_LA_1_NEXT = IniRead($LOG_Data_INI, $Wert_LA_1 + 1, "index", "") ; index
				;Global $Wert_LA_2_NEXT = IniRead($LOG_Data_INI, $Wert_LA_1 + 1, "time", "") ; time
				Global $Wert_LA_3_NEXT = IniRead($LOG_Data_INI, $Wert_LA_1 + 1, "name", "") ; name ; --> SessionDestroyed

				Global $ResultsSaved = IniRead($config_ini, "TEMP", "ResultsSaved", "")
				Global $ResultsIndexNR = IniRead($config_ini, "TEMP", "ResultsIndexNR", "")

				$SessionStage = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
				$TrackName = IniRead($Server_Data_INI, "DATA", "TrackName", "")

				IniWrite($config_ini, "TEMP", "Results_saved_SessionStage", $SessionStage)
				IniWrite($config_ini, "TEMP", "Results_saved_TrackName", $TrackName)


				If $Wert_LA_3_NEXT <> "Results" and $ResultsSaved = "true" Then

					IniWrite($config_ini, "TEMP", "Race_Finished", "true")

					$Check_Excel_Version = IniRead($config_ini, "Einstellungen", "Excel_version", "")

					;If $Check_Excel_Version <> "" Then

					$Status_Checkbox_Results_File_Format_TXT = IniRead($config_ini, "PC_Server", "Checkbox_Results_FileFormat_TXT", "")
					$Status_Checkbox_Results_File_Format_INI = IniRead($config_ini, "PC_Server", "Checkbox_Results_FileFormat_INI", "")
					$Status_Checkbox_Results_File_Format_XLS = IniRead($config_ini, "PC_Server", "Checkbox_Results_FileFormat_XLS", "")
					$Status_Checkbox_Results_File_Format_HTM = IniRead($config_ini, "PC_Server", "Checkbox_Results_FileFormat_HTM", "")

					$Check_TrackId_Value = IniRead($Server_Data_INI, "DATA", "TrackId", "")
					IniWrite($config_ini, "TEMP", "Check_Trackid", $Check_TrackId_Value)
					;_TRACK_NAME_from_ID()
					;$Check_TrackName_Value = IniRead($config_ini, "TEMP", "Check_TrackName", "")
					$Check_TrackName_Value = IniRead($Server_Data_INI, "DATA", "TrackName", "")
					IniWrite($config_ini, "TEMP", "Results_saved_TrackName", $Check_TrackName_Value)

					$SessionStage_Check = IniRead($config_ini, "PC_Server", "Session_Stage", "")
					;$SessionStage_Check = $LOG_Results_attribute_PreviousStage
					IniWrite($config_ini, "TEMP", "Results_saved_SessionStage", $SessionStage_Check)


					If $Status_Checkbox_Results_File_Format_TXT = "true" Then _Write_Results_File_TXT()
					Sleep(200)

					If $Status_Checkbox_Results_File_Format_INI = "true" Then _Write_Results_File_INI()
					Sleep(200)


					If $Check_Excel_Version <> "" Then

						If $Status_Checkbox_Results_File_Format_XLS = "true" Or $Status_Checkbox_Results_File_Format_HTM = "true" Then _Write_Results_File_XLS_HTM()
						Sleep(200)

						Sleep(200)

						Global $Check_Checkbox_PCDSG_Stats_path = IniRead($config_ini, "Einstellungen", "Checkbox_PCDSG_Stats_path", "")

						If $Check_Checkbox_PCDSG_Stats_path = "true" Then
							_SyncFiles_Start()
							IniWrite($config_ini, "TEMP", "Results_saved_TrackName", "")
							Sleep(200)
						EndIf

					Else
						;_Excel_Exists_Check()
					EndIf

					FileWriteLine($PCDSG_LOG_ini, "Results_saved_" & $NowTime & "=" & "Date: " & $NowDate & " | " & "Time: " & $NowTime)

				EndIf

				IniWrite($config_ini, "TEMP", "ResultsSaved", "")
				IniWrite($config_ini, "TEMP", "ResultsIndexNR", "")

			EndIf
#EndRegion

#Region Check = StageChanged ; Results 2
			If $Wert_LA_3 = "StageChanged" Then

				IniWrite($config_ini, "TEMP", "Race_Finished", "")

				Global $LOG_Results_attribute_PreviousStage = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_PreviousStage", "") ; attribute_PreviousStage
				Global $LOG_Results_attribute_NewStage = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_NewStage", "") ; attribute_NewStage
				Global $LOG_Results_attribute_Length = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_Length", "") ; attribute_Length

				;MsgBox(0, "StageChanged", $LOG_Results_attribute_PreviousStage & @CRLF & $LOG_Results_attribute_NewStage & @CRLF & $LOG_Results_attribute_Length, 10)

				Global $SessionStage_Check = IniRead($config_ini, "PC_Server", "Session_Stage", "")
				Global $Value_SG_entry_Limit = IniRead($config_ini, "Race_Control", "Value_SG_entry_Limit", "")

				If $Value_SG_entry_Limit = "" Then
					$Value_SG_entry_Limit = "ALL"
					IniWrite($config_ini, "Race_Control", "Value_SG_entry_Limit", $Value_SG_entry_Limit)
				EndIf

				If $Value_SG_entry_Limit <> "ALL" Then

					If $SessionStage_Check <> "Practice1" Then

						If $SessionStage_Check <> "Practice2" Then

							Global $Value_SG_entry_Limit = IniRead($config_ini, "Race_Control", "Value_SG_entry_Limit", "")
							Global $Value_SG_entry_Limit_min = IniRead($config_ini, "Race_Control", "Value_" & $Value_SG_entry_Limit & "_min", "")

							For $Schleife_Members_Check = 0 To 32

								$Name_Member = IniRead($Members_Data_INI, $Schleife_Members_Check, "name", "")

								If $Name_Member <> "" Then
									$ExperiencePoints_Check = IniRead($Stats_INI, $Name_Member, "ExperiencePoints", "1")

									If $ExperiencePoints_Check < $Value_SG_entry_Limit_min Then
										$KICK_User = IniWrite($config_ini, "TEMP", "KICK_User", $Name_Member)
										_KICK_USER_universal()
									EndIf
								EndIf
								If $Name_Member = "" Then $Schleife_Members_Check = 32
							Next
						EndIf

					EndIf

				EndIf

			EndIf

#EndRegion

#Region Check = StateChanged 2

			If $Wert_LA_3 = "StateChanged" Then

				Global $LOG_StateChanged_attribute_PreviousState = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_PreviousState", "") ; attribute_PreviousState
				Global $LOG_StateChanged_attribute_attribute_NewState = IniRead($LOG_Data_INI, $LOG_Index_Check, "attribute_NewState", "") ; attribute_NewState

				If $LOG_StateChanged_attribute_PreviousState = "PostRace" and $LOG_StateChanged_attribute_attribute_NewState = "Returning" Then

				EndIf
			EndIf

#EndRegion

#Region Check = Auto Game Messages

		Local $Auto_LobbyCheck = IniRead($Server_Data_INI, "DATA", "SessionState", "")

		$Last_Index_ID = IniRead($Server_Data_INI, "DATA", "NR", "")
		$LOG_Current_Index_NR = IniRead($config_ini, "TEMP", "Log_Index_NR", "")

		If $Auto_LobbyCheck <> "Lobby" Then
			;MsgBox(0, "", "Auto Game Messages")
			$Check_Checkbox_SET_Lobby_1 = IniRead($config_ini, "Race_Control", "Checkbox_SET_GameAction_1", "")
			$Check_Checkbox_SET_Lobby_2 = IniRead($config_ini, "Race_Control", "Checkbox_SET_GameAction_2", "")
			$Check_Checkbox_SET_Lobby_3 = IniRead($config_ini, "Race_Control", "Checkbox_SET_GameAction_3", "")
			$Check_Checkbox_SET_Lobby_4 = IniRead($config_ini, "Race_Control", "Checkbox_SET_GameAction_4", "")

			$Check_AutoGameMessage_1 = IniRead($config_ini, "TEMP", "AutoGameMessage_1", "")
			$Check_AutoGameMessage_2 = IniRead($config_ini, "TEMP", "AutoGameMessage_2", "")
			$Check_AutoGameMessage_3 = IniRead($config_ini, "TEMP", "AutoGameMessage_3", "")
			$Check_AutoGameMessage_4 = IniRead($config_ini, "TEMP", "AutoGameMessage_4", "")

			Global $LOOP_NR, $LOOP_NR_Action_1_send, $Next_LOOP_NR_Action_1_send, $LOOP_NR_Action_2_send, $Next_LOOP_NR_Action_2_send, $LOOP_NR_Action_3_send, $Next_LOOP_NR_Action_3_send

			Global $LOOP_NR = IniRead($config_ini, "TEMP", "LOOP_NR", "")

			$Next_LOOP_NR_Action_1_send = IniRead($config_ini, "TEMP", "Next_LOOP_NR_Action_1_send", "")
			$Next_LOOP_NR_Action_2_send = IniRead($config_ini, "TEMP", "Next_LOOP_NR_Action_2_send", "")
			$Next_LOOP_NR_Action_3_send = IniRead($config_ini, "TEMP", "Next_LOOP_NR_Action_3_send", "")
			$Next_LOOP_NR_Action_4_send = IniRead($config_ini, "TEMP", "Next_LOOP_NR_Action_4_send", "")

			If $Next_LOOP_NR_Action_1_send = "" Then IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_1_send", $LOOP_NR + 1)
			If $Next_LOOP_NR_Action_2_send = "" Then IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_2_send", $LOOP_NR + 2)
			If $Next_LOOP_NR_Action_3_send = "" Then IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_3_send", $LOOP_NR + 3)
			If $Next_LOOP_NR_Action_4_send = "" Then IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_4_send", $LOOP_NR + 4)

			If $Next_LOOP_NR_Action_1_send <= $LOOP_NR - 100 Then IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_1_send", $LOOP_NR + 1)
			If $Next_LOOP_NR_Action_2_send <= $LOOP_NR - 100 Then IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_2_send", $LOOP_NR + 3)
			If $Next_LOOP_NR_Action_3_send <= $LOOP_NR - 100 Then IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_3_send", $LOOP_NR + 5)
			If $Next_LOOP_NR_Action_4_send <= $LOOP_NR - 100 Then IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_4_send", $LOOP_NR + 7)

			If $Next_LOOP_NR_Action_1_send >= $LOOP_NR + 100 Then IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_1_send", $LOOP_NR + 1)
			If $Next_LOOP_NR_Action_2_send >= $LOOP_NR + 100 Then IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_2_send", $LOOP_NR + 3)
			If $Next_LOOP_NR_Action_3_send >= $LOOP_NR + 100 Then IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_3_send", $LOOP_NR + 5)
			If $Next_LOOP_NR_Action_4_send >= $LOOP_NR + 100 Then IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_4_send", $LOOP_NR + 7)

			$Next_LOOP_NR_Action_1_send = IniRead($config_ini, "TEMP", "Next_LOOP_NR_Action_1_send", "")
			$Next_LOOP_NR_Action_2_send = IniRead($config_ini, "TEMP", "Next_LOOP_NR_Action_2_send", "")
			$Next_LOOP_NR_Action_3_send = IniRead($config_ini, "TEMP", "Next_LOOP_NR_Action_3_send", "")
			$Next_LOOP_NR_Action_4_send = IniRead($config_ini, "TEMP", "Next_LOOP_NR_Action_4_send", "")

			If $Check_Checkbox_SET_Lobby_1 = "true" Then
				If $Check_AutoGameMessage_1 <> "true" Then
					_AutoGameAction_1()
				Global $LOOP_NR_Action_1_send = $LOOP_NR
				Global $Next_LOOP_NR_Action_1_send = $LOOP_NR + 80
				IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_1_send", $Next_LOOP_NR_Action_1_send)
				EndIf

				If $Next_LOOP_NR_Action_1_send = $LOOP_NR Then
					IniWrite($config_ini, "TEMP", "AutoGameMessage_1", "")
				EndIf
			EndIf

			If $Check_Checkbox_SET_Lobby_2 = "true" Then
				If $Check_AutoGameMessage_2 <> "true" Then
					_AutoGameAction_2()
				Global $LOOP_NR_Action_2_send = $LOOP_NR
				Global $Next_LOOP_NR_Action_2_send = $LOOP_NR + 90
				IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_2_send", $Next_LOOP_NR_Action_2_send)
				EndIf

				If $Next_LOOP_NR_Action_2_send = $LOOP_NR Then
					IniWrite($config_ini, "TEMP", "AutoGameMessage_2", "")
				EndIf
			EndIf

			If $Check_Checkbox_SET_Lobby_3 = "true" Then
				If $Check_AutoGameMessage_3 <> "true" Then
					_AutoGameAction_3()
				Global $LOOP_NR_Action_3_send = $LOOP_NR
				Global $Next_LOOP_NR_Action_3_send = $LOOP_NR + 70
				IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_3_send", $Next_LOOP_NR_Action_3_send)
				EndIf

				If $Next_LOOP_NR_Action_3_send = $LOOP_NR Then
					IniWrite($config_ini, "TEMP", "AutoGameMessage_3", "")
				EndIf
			EndIf

			If $Check_Checkbox_SET_Lobby_4 = "true" Then
				If $Check_AutoGameMessage_4 <> "true" Then
					_AutoGameAction_4()
				;Global $LOOP_NR_Action_4_send = $LOOP_NR
				;Global $Next_LOOP_NR_Action_4_send = $LOOP_NR + 15
				;IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_4_send", $Next_LOOP_NR_Action_4_send)
				EndIf

				If $Next_LOOP_NR_Action_4_send = $LOOP_NR Then
					IniWrite($config_ini, "TEMP", "AutoGameMessage_4", "")
				EndIf
			EndIf

		EndIf
#EndRegion

		;EndIf

		If $Wert_LA_1 > $Wert_Index_Check_LOG_alt - 1 Then
			;MsgBox(0, "Write Last log Index NR", $Wert_LA_1 & " > " & $Wert_Index_Check_LOG_alt - 1)
			If $Wert_LA_1 <> "" Then IniWrite($config_ini, "TEMP", "Log_Index_NR", $Wert_LA_1)
		EndIf

	Next

EndFunc   ;==>_Server_Events_LOG

#endregion Start Server Events Check


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



Func _Auto_KICK_Points()
; Check PP WARN and KICK action
$Status_Checkbox_Server_Penalties_1 = IniRead($config_ini, "Race_Control", "Checkbox_Server_Penalties_1","")
$Status_Checkbox_Server_Penalties_2 = IniRead($config_ini, "Race_Control", "Checkbox_Server_Penalties_2","")
$PP_WARN_limit = IniRead($config_ini, "Race_Control", "Value_Checkbox_Server_Penalties_1","")
$PP_KICK_limit = IniRead($config_ini, "Race_Control", "Value_Checkbox_Server_Penalties_2","")

$PP_Check_Name = IniRead($config_ini, "TEMP", "Wert_Check_Name", "")

$PP_Points = IniRead($Points_ini, $PP_Check_Name, "PenaltyPoints", "")
$PP_WARN_limit = Int($PP_WARN_limit)
$PP_KICK_limit = Int($PP_KICK_limit)
;$PP_WARN_limit = $PP_WARN_limit
;$PP_KICK_limit = $PP_KICK_limit

If $Status_Checkbox_Server_Penalties_1 = "true" Then

	If $PP_Points > $PP_WARN_limit Then
		$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
		$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

		If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
		If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

		$Nachricht = IniRead($config_ini, "Race_Control", "PP_WARN_limit_MSG", "")

		If $PP_Check_Name <> "" Then
			$PP_Check_Name = StringReplace($PP_Check_Name, "<", "[")
			$PP_Check_Name = StringReplace($PP_Check_Name, ">", "]")
		EndIf

		$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht & " " & $PP_Check_Name
		$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

		If $PP_Check_Name <> "" Then
			$PP_Check_Name = StringReplace($PP_Check_Name, "[", "<")
			$PP_Check_Name = StringReplace($PP_Check_Name, "]", ">")
		EndIf

		;_KICK_USER_universal()

	EndIf

EndIf

If $Status_Checkbox_Server_Penalties_2 = "true" Then

	If $PP_Points > $PP_KICK_limit Then ; $PP_KICK_limit
		$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
		$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

		If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
		If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

		$Nachricht = IniRead($config_ini, "Race_Control", "PP_KICK_MSG", "")

		If $PP_Check_Name <> "" Then
			$PP_Check_Name = StringReplace($PP_Check_Name, "<", "[")
			$PP_Check_Name = StringReplace($PP_Check_Name, ">", "]")
		EndIf

		$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht & " user" & $PP_Check_Name & "in 3 seconds"
		$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)

		Sleep(3000)

		If $PP_Check_Name <> "" Then
			$PP_Check_Name = StringReplace($PP_Check_Name, "[", "<")
			$PP_Check_Name = StringReplace($PP_Check_Name, "]", ">")
		EndIf

		IniWrite($config_ini, "TEMP", "KICK_User", $PP_Check_Name)

		_KICK_USER_universal()

	EndIf

EndIf

EndFunc

Func _KICK_USER_universal() ; Kick User universal

	$KICK_User = IniRead($config_ini, "TEMP", "KICK_User", "")

	If $KICK_User <> "" Then
		$KICK_User = StringReplace($KICK_User, "<", "[")
		$KICK_User = StringReplace($KICK_User, ">", "]")
	EndIf

	$Name_Check = IniRead($Members_Data_INI, $KICK_User, "name", "")
	$refid = IniRead($Members_Data_INI, $KICK_User, "refid", "")

	If $refid <> "" Then

		;URL erstellen
		$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
		$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

		If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
		If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

		$URL_KICK = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid

		$download = InetGet($URL_KICK, $KICK_BAN_TXT, 16, 0)

		$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)

		If $Check_KICK_BAN = '  "result" : "ok"' Then
			$Nachricht = "PCDSG Action: " & "User " & $KICK_User & " was KICKED by PCDSG"

			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
		EndIf

		IniWrite($config_ini, "TEMP", "KICK_User", "")
		FileWriteLine($PCDSG_LOG_ini, "KICK_User_" & $NowTime & "=" & "User: " & $KICK_User & " | " & "RefID: " & $refid)

	EndIf

EndFunc   ;==>_KICK_USER_universal

Func _BAN_USER_universal() ; Ban User universal

	$KICK_User = IniRead($config_ini, "TEMP", "BAN_User", "")

	$index = IniRead($Members_Data_INI, $KICK_User, "index", "")
	$refid = IniRead($Members_Data_INI, $KICK_User, "refid", "")
	$steamid = IniRead($Members_Data_INI, $KICK_User, "steamid", "")

	;URL erstellen
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$URL_KICK = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid & "&ban=864000"
	$download = InetGet($URL_KICK, $KICK_BAN_TXT, 16, 0)
	FileWriteLine($PCDSG_LOG_ini, "BAN_User_" & $NowTime & "=" & "User: " & $KICK_User & " | " & "RefID: " & $refid)

	$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)

	If $Check_KICK_BAN = '  "result" : "ok"' Then
		$Nachricht = "PCDSG Action: " & "User " & $KICK_User & " was BANNED by PCDSG"

		$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Nachricht
		$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
	EndIf

EndFunc   ;==>_BAN_USER_universal

Func _TRACK_NAME_from_ID()

IniWrite($config_ini, "TEMP", "Check_TrackName", "")

$Wert_Track_ID_search = IniRead($config_ini, "TEMP", "Check_Trackid", "")

$Anzahl_Zeilen_TrackList = _FileCountLines(@ScriptDir & "\TrackList.txt")

;$Wert_Track = ""
;$Wert_Track_ID = ""
$Check_Line = ""

For $Schleife_TRACK_ID_DropDown = 7 To $Anzahl_Zeilen_TrackList Step 5

$Wert_Track_ID = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_ID_DropDown)
$Wert_Track_ID = StringReplace($Wert_Track_ID, '        "id" : ', '')
$Wert_Track_ID = StringReplace($Wert_Track_ID, '"', '')
$Wert_Track_ID = StringReplace($Wert_Track_ID, ',', '')

;MsgBox(0, "", $Wert_Track_ID & " : " & $Wert)

If $Wert_Track_ID = $Wert_Track_ID_search Then
	;MsgBox(0, "Wert_Tack", $Wert_Track)
	$Wert_Track = FileReadLine(@ScriptDir & "\TrackList.txt", $Schleife_TRACK_ID_DropDown + 1)
	$Wert_Track = StringReplace($Wert_Track, '        "name" : "', '')
	$Wert_Track = StringReplace($Wert_Track, ',', '')
	$Wert_Track = StringReplace($Wert_Track, '"', '')
	IniWrite($config_ini, "TEMP", "Check_TrackName", $Wert_Track)
	FileWriteLine($PCDSG_LOG_ini, "Track_detection_" & $NowTime & "=" & "Track: " & $Wert_Track & " | " & "TrackID: " & $Wert_Track_ID)
	$Schleife_TRACK_ID_DropDown = $Anzahl_Zeilen_TrackList
EndIf

Next

EndFunc

Func _CAR_NAME_from_ID()

IniWrite($config_ini, "TEMP", "Check_CarName", "")

;$Wert_CAR_ID_search = $Wert_Car
$Wert_CAR_ID_search = IniRead($config_ini, "TEMP", "Check_Carid", "")

$Anzahl_Zeilen_VehicleList = _FileCountLines(@ScriptDir & "\VehicleList.txt")

$Wert_Car = ""
$Werte_Car = ""
$Wert_Car_ID = ""
$Check_Line = ""

For $Schleife_CAR_DropDown = 7 To $Anzahl_Zeilen_VehicleList Step 5

$Durchgang_NR = $Schleife_CAR_DropDown - 5

$Wert_Car_ID = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown)
$Wert_Car_ID = StringReplace($Wert_Car_ID, '        "id" : ', '')
$Wert_Car_ID = StringReplace($Wert_Car_ID, ',', '')


If $Wert_CAR_ID_search = $Wert_Car_ID Then
	$Wert_Car = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown + 1)
	$Wert_Car = StringReplace($Wert_Car, '        "name" : "', '')
	$Wert_Car = StringReplace($Wert_Car, '",', '')
	IniWrite($config_ini, "TEMP", "Check_CarName", $Wert_Car)
	$Schleife_CAR_DropDown = $Anzahl_Zeilen_VehicleList
EndIf

Next

EndFunc

Func _Car_ermitteln()

$Wert_CAR_ID_ListView = $Wert_Car

$Anzahl_Zeilen_VehicleList = _FileCountLines(@ScriptDir & "\VehicleList.txt")

$Wert_Car = ""
$Werte_Car = ""
$Wert_Car_ID = ""
$Check_Line = ""

For $Schleife_CAR_DropDown = 7 To $Anzahl_Zeilen_VehicleList Step 5

$Wert_Car_ID = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown)
$Wert_Car_ID = StringReplace($Wert_Car_ID, '      "id" : ', '')
$Wert_Car_ID = StringReplace($Wert_Car_ID, ',', '')


If $Wert_CAR_ID_ListView = $Wert_Car_ID Then
	$Wert_Car = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown + 1)
	$Wert_Car = StringReplace($Wert_Car, '      "name" : "', '')
	$Wert_Car = StringReplace($Wert_Car, '",', '')
	IniWrite($config_ini, "TEMP", "Check_CarName", $Wert_Car)
	$Schleife_CAR_DropDown = $Anzahl_Zeilen_VehicleList
EndIf

Next

EndFunc

Func _Car_from_RefID()

	$RefID_user = IniRead($config_ini, "TEMP", "Wert_Check_Refid", "")

	For $Schleife_MFR = 1 To 32
		$Check_refid_Label = IniRead($Members_Data_INI, "DATA", "Label_" & $Schleife_MFR & "_2", "")

		If $Check_refid_Label = "refid" Then
			$Check_refid = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_2", "")
		Else
			$Check_refid = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_3", "")
		EndIf


	If $Check_refid = $RefID_user Then
		$Check_refid_Label = IniRead($Members_Data_INI, "DATA", "Label_" & $Schleife_MFR & "_2", "")

		If $Check_refid_Label = "refid" Then
			$CarID = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_9", "")
			IniWrite($config_ini, "TEMP", "Check_Carid", $CarID)
		Else
			$CarID = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_10", "")
			IniWrite($config_ini, "TEMP", "Check_Carid", $CarID)
		EndIf

		$Schleife_MFR = 32
	EndIf

	Next

EndFunc

Func _Path_APP_1_execute()

	$APP_path = IniRead($config_ini, "APPS", "APP_1_path", "")

	If $APP_path <> "" Then

		If FileExists($APP_path) Then
			ShellExecute($APP_path)

			$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: PCDSG - APP started >>>"
			$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
		Else
			MsgBox(0, "Path Error", "File path does not exist.")
		EndIf

	EndIf

EndFunc   ;==>_Path_APP_1_execute

Func _Path_APP_2_execute()

	$APP_path = IniRead($config_ini, "APPS", "APP_2_path", "")

	If $APP_path <> "" Then

		If FileExists($APP_path) Then
			ShellExecute($APP_path)
			$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: PCDSG - APP started >>>"
			$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
		Else
			MsgBox(0, "Path Error", "File path does not exist.")
		EndIf

	EndIf

EndFunc   ;==>_Path_APP_2_execute

Func _Path_APP_3_execute()

	$APP_path = IniRead($config_ini, "APPS", "APP_3_path", "")

	If $APP_path <> "" Then

		If FileExists($APP_path) Then
			ShellExecute($APP_path)
			$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: PCDSG - APP started >>>"
			$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
		Else
			MsgBox(0, "Path Error", "File path does not exist.")
		EndIf

	EndIf

EndFunc   ;==>_Path_APP_3_execute

Func _Path_APP_4_execute()

	$APP_path = IniRead($config_ini, "APPS", "APP_4_path", "")

	If $APP_path <> "" Then

		If FileExists($APP_path) Then
			ShellExecute($APP_path)
			$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: PCDSG - APP started >>>"
			$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
		Else
			MsgBox(0, "Path Error", "File path does not exist.")
		EndIf

	EndIf

EndFunc   ;==>_Path_APP_4_execute

Func _Path_APP_5_execute()

	$APP_path = IniRead($config_ini, "APPS", "APP_5_path", "")

	If $APP_path <> "" Then

		If FileExists($APP_path) Then
			ShellExecute($APP_path)
			$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN: PCDSG - APP started >>>"
			$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
		Else
			MsgBox(0, "Path Error", "File path does not exist.")
		EndIf

	EndIf

EndFunc   ;==>_Path_APP_5_execute

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
	;Return StringFormat("%.2d/%.2d/%.2d %.2d:%.2d:%.2d", $aDatePart[0], $aDatePart[1], $aDatePart[2], $aTimePart[0], $aTimePart[1], $aTimePart[2])
	$Seconds_to_Time = StringFormat("%.2d/%.2d/%.2d" & " - " & "%.2d:%.2d:%.2d", $aDatePart[0], $aDatePart[1], $aDatePart[2], $aTimePart[0] + $TimeZone_Correction, $aTimePart[1], $aTimePart[2])
	;MsgBox(0, "$Seconds_to_Time", $Seconds_to_Time)
	IniWrite($config_ini, "TEMP", "Seconds_to_Time", $Seconds_to_Time)
EndFunc   ;==>_EPOCH_decrypt

Func _Auto_LobbyAction()

$LOG_Event_Check_auto_MSG  = IniRead($config_ini, "Race_Control", "Checkbox_Rules_6", "")

$Point_System_Value = IniRead($config_ini, "Race_Control", "Checkbox_Rules_5", "")
$Panalty_Warning_Value = IniRead($config_ini, "Race_Control", "Value_Checkbox_Server_Penalties_1", "")
$Panalty_Kick_Value = IniRead($config_ini, "Race_Control", "Value_Checkbox_Server_Penalties_2", "")
$Penalize_TrackCut_Value = IniRead($config_ini, "Race_Control", "Checkbox_Rules_3", "")
$Penalize_Impact_Value = IniRead($config_ini, "Race_Control", "Checkbox_Rules_4", "")
$PingLimit_Value = IniRead($config_ini, "Race_Control", "PingLimit", "")
$Admin_Chat_Message_Value = "true"
$Auto_Kick_Parking_Value = IniRead($config_ini, "Race_Control", "Checkbox_Rules_1", "")


If $LOG_Event_Check_auto_MSG = "true" Then

	$Message_Lobby_1 = "Welcome to PCDSG Server"
	$Message_Lobby_2 = "------------------------"
	$Message_Lobby_3 = "Server Rules:"
	$Message_Lobby_4 = "------------------------"
	$Message_Lobby_5 = "- Points System: " & $Point_System_Value
	$Message_Lobby_6 = "- Penalty Points [Warning]:" & $Panalty_Warning_Value & " Points"
	$Message_Lobby_7 = "- Penalty Points [Kick]:" & $Panalty_Kick_Value & " Points"
	$Message_Lobby_8 = "- Penalize Track Cut:" & $Penalize_TrackCut_Value
	$Message_Lobby_9 = "- Penalize Impact:" & $Penalize_Impact_Value
	$Message_Lobby_10 = "Ping Limit: " & $PingLimit_Value
	$Message_Lobby_11 = "- Admin Commands:" & $Admin_Chat_Message_Value
	$Message_Lobby_12 = "- Autom. Kick parking cars:" & $Auto_Kick_Parking_Value


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

EndIf

FileWriteLine($PCDSG_LOG_ini, "Lobby_message_send_" & $NowTime & "=" & "" & $Message_Lobby_1 & " | " & "" & $Message_Lobby_3)

Sleep(10000)

EndFunc

Func _Time_Update()
; Last Lap Time formatieren

	$iMs = $LOG_LapTime_value
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
	$LOG_LapTime_value = $LastLapTime_Wert

EndFunc

Func _LapTime_GAP()

$GAP_1 = IniRead($config_ini, "TEMP", "LapTime_GAP_1", "")
$GAP_2 = IniRead($config_ini, "TEMP", "LapTime_GAP_2", "")

$Vorzeichen = ""
$GAP_3_1 = ""
$GAP_3_2 =" "
$GAP_3_3 = ""
$Laptime_GAP_Value = ""


If $GAP_1 <> "" Then
	If $GAP_2 <> "" Then

		$GAP_1_1 = StringSplit($GAP_1, ":")
		$GAP_1_1_Minuten = $GAP_1_1[1]

		$GAP_1_2 = StringSplit($GAP_1_1[2], ".")
		$GAP_1_2_Sekunden = $GAP_1_2[1]

		$GAP_1_2_mSekunden = $GAP_1_2[2]


		;MsgBox(0, "1", $GAP_1_1_Minuten & @CRLF & $GAP_1_2_Sekunden & @CRLF & $GAP_1_2_mSekunden)


		$GAP_2_1 = StringSplit($GAP_2, ":")
		$GAP_2_1_Minuten = $GAP_2_1[1]

		$GAP_2_2 = StringSplit($GAP_2_1[2], ".")
		$GAP_2_2_Sekunden = $GAP_2_2[1]

		$GAP_2_2_mSekunden = $GAP_2_2[2]

		;MsgBox(0, "2", $GAP_2_1_Minuten & @CRLF & $GAP_2_2_Sekunden & @CRLF & $GAP_2_2_mSekunden)

		$Vorzeichen = ""
		$GAP_3_1 = ""
		$GAP_3_2 = ""
		$GAP_3_3 = ""

		If $GAP_1_1_Minuten = $GAP_2_1_Minuten Then
			$GAP_3_1 = "0"
		Else
			If $GAP_1_1_Minuten > $GAP_2_1_Minuten Then
				$GAP_3_1 = $GAP_1_1_Minuten - $GAP_2_1_Minuten
				;$GAP_3_1 = "0"
				$Vorzeichen = "-"
			Else
				If $GAP_1_1_Minuten < $GAP_2_1_Minuten Then
					$GAP_3_1 = $GAP_2_1_Minuten - $GAP_1_1_Minuten
					;$GAP_3_1 = "0"
					$Vorzeichen = "+"
				EndIf
			EndIf
		EndIf


		If $GAP_1_2_Sekunden = $GAP_2_2_Sekunden Then
			$GAP_3_2 = "0"
		Else
			If $GAP_1_2_Sekunden > $GAP_2_2_Sekunden Then
				$Vorzeichen = "-"
				If $GAP_1_1_Minuten < $GAP_2_1_Minuten Then
					$GAP_3_1 = $GAP_2_1_Minuten - $GAP_1_1_Minuten
					$Vorzeichen = "+"
				EndIf

				$GAP_3_2 = $GAP_1_2_Sekunden - $GAP_2_2_Sekunden

				If $GAP_1_1_Minuten <> $GAP_2_1_Minuten Then
					$GAP_3_2 = $GAP_1_2_Sekunden - ($GAP_1_2_Sekunden - $GAP_2_2_Sekunden)
				EndIf

			Else
				If $GAP_1_2_Sekunden < $GAP_2_2_Sekunden Then
					$GAP_3_2 = $GAP_2_2_Sekunden - $GAP_1_2_Sekunden
					$Vorzeichen = "+"
				EndIf
			EndIf
		EndIf


		If $GAP_1_2_mSekunden = $GAP_2_2_mSekunden Then
			$GAP_3_3 = "0"
		Else
			If $GAP_2_2_mSekunden > $GAP_1_2_mSekunden Then
				$GAP_3_3 = $GAP_2_2_mSekunden - $GAP_1_2_mSekunden
					If $GAP_1_2_Sekunden = $GAP_2_2_Sekunden Then
						If $GAP_1_1_Minuten = $GAP_2_1_Minuten Then
							$Vorzeichen = "+"
						EndIf
					EndIf
			Else
				If $GAP_2_2_mSekunden < $GAP_1_2_mSekunden Then
					$GAP_3_3 = $GAP_1_2_mSekunden - $GAP_2_2_mSekunden
					If $GAP_1_2_Sekunden = $GAP_2_2_Sekunden Then
						If $GAP_1_1_Minuten = $GAP_2_1_Minuten Then
							$Vorzeichen = "-"
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf



		$GAP_3_1_Minuten_Check = $GAP_3_1

		$GAP_3_1_L = Stringlen($GAP_3_1)
		$GAP_3_2_L = Stringlen($GAP_3_2)
		$GAP_3_3_L = Stringlen($GAP_3_3)


		If $GAP_3_1_L = "1" Then
			$GAP_3_1 = "0" & $GAP_3_1
		EndIf

		If $GAP_3_1_L = "2" Then
			$GAP_3_1 = "" & $GAP_3_1
		EndIf

		If $GAP_3_1_L = "0" Then
			$GAP_3_1 = "00" & $GAP_3_1
		EndIf

		If $GAP_3_1_L = "" Then
			$GAP_3_1 = "00" & $GAP_3_1
		EndIf


		If $GAP_3_2_L = "1" Then
			$GAP_3_2 = "0" & $GAP_3_2
		EndIf

		If $GAP_3_2_L = "2" Then
			$GAP_3_2 = "" & $GAP_3_2
		EndIf

		If $GAP_3_2_L = "0" Then
			$GAP_3_2 = "00" & $GAP_3_2
		EndIf

		If $GAP_3_2_L = "" Then
			$GAP_3_2 = "00" & $GAP_3_2
		EndIf


		If $GAP_3_3_L = "1" Then
			$GAP_3_3 = "00" & $GAP_3_3
		EndIf

		If $GAP_3_3_L = "2" Then
			$GAP_3_3 = "0" & $GAP_3_3
		EndIf

		If $GAP_3_3_L = "0" Then
			$GAP_3_3 = "000" & $GAP_3_3
		EndIf

		If $GAP_3_3_L = "" Then
			$GAP_3_3 = "000" & $GAP_3_3
		EndIf

	EndIf
EndIf



If $GAP_3_1 = "01" Then
	$GAP_3_1 = "00"
EndIf

If $GAP_3_1 = "02" Then
	$GAP_3_1 = "01"
EndIf

If $GAP_3_1 = "03" Then
	$GAP_3_1 = "02"
EndIf

If $GAP_3_1 = "04" Then
	$GAP_3_1 = "03"
EndIf


;MsgBox(0, "3", $Vorzeichen & @CRLF & $GAP_3_1 & @CRLF & $GAP_3_2 & @CRLF & $GAP_3_3)
;MsgBox(0, "4", $Vorzeichen & " " & $GAP_3_1 & ":" & $GAP_3_2 & "." & $GAP_3_3)

$Laptime_GAP_Value = $Vorzeichen & " " & $GAP_3_1 & ":" & $GAP_3_2 & "." & $GAP_3_3

If $GAP_3_1_Minuten_Check > "4" Then
	$Laptime_GAP_Value = "TOO SLOW"
EndIf

IniWrite($config_ini, "TEMP", "LapTime_GAP_3", $Laptime_GAP_Value)

EndFunc

Func _SG_Calculation()

Global $Name_User = IniRead($config_ini, "TEMP", "Wert_Check_Name", "")
Global $Check_ExperiencePoints_Stats = IniRead($Stats_INI, "cogent", "ExperiencePoints", "")
Global $Wert_ExpiriencePoints = $Check_ExperiencePoints_Stats

Global $Wert_ExpiriencePoints_write = $Wert_ExpiriencePoints

If $Name_User <> "" Then

	$Value_SG1_min_read = IniRead($config_ini, "Race_Control", "Value_SG1_min", "")
	$Value_SG2_min_read = IniRead($config_ini, "Race_Control", "Value_SG2_min", "")
	$Value_SG2_max_read = IniRead($config_ini, "Race_Control", "Value_SG2_max", "")
	$Value_SG3_min_read = IniRead($config_ini, "Race_Control", "Value_SG3_min", "")
	$Value_SG3_max_read = IniRead($config_ini, "Race_Control", "Value_SG3_max", "")
	$Value_SG4_min_read = IniRead($config_ini, "Race_Control", "Value_SG4_min", "")
	$Value_SG4_max_read = IniRead($config_ini, "Race_Control", "Value_SG4_max", "")
	$Value_SG5_min_read = IniRead($config_ini, "Race_Control", "Value_SG5_min", "")
	$Value_SG5_max_read = IniRead($config_ini, "Race_Control", "Value_SG5_max", "")


	$EP_Group = "6"

	If $Wert_ExpiriencePoints_write >= $Value_SG5_min_read And $Wert_ExpiriencePoints_write <= $Value_SG5_max_read Then
		$EP_Group = "5"
	EndIf

	If $Wert_ExpiriencePoints_write >= $Value_SG4_min_read And $Wert_ExpiriencePoints_write <= $Value_SG4_max_read Then
		$EP_Group = "4"
	EndIf

	If $Wert_ExpiriencePoints_write >= $Value_SG3_min_read And $Wert_ExpiriencePoints_write <= $Value_SG3_max_read Then
		$EP_Group = "3"
	EndIf

	If $Wert_ExpiriencePoints_write >= $Value_SG2_min_read And $Wert_ExpiriencePoints_write <= $Value_SG2_max_read Then
		$EP_Group = "2"
	EndIf

	If $Wert_ExpiriencePoints_write > $Value_SG1_min_read Then
		$EP_Group = "1"
	EndIf


	If $EP_Group = "" Then $EP_Group = "6"

	IniWrite($Stats_INI, $Name_User, "SafetyGroup", $EP_Group)
	IniWrite($config_ini, "TEMP", "Wert_Check_Name", "")
	FileWriteLine($PCDSG_LOG_ini, "SG_Calculation_" & $NowTime & "=" & "Name" & $Name_User & " | " & "SG:" & $EP_Group)

EndIf

EndFunc

Func _Entry_Limit_Check()

Global $Value_SG_entry_Limit = IniRead($config_ini, "Race_Control", "Value_SG_entry_Limit", "")
Global $Value_SG_entry_Limit_min = IniRead($config_ini, "Race_Control", "Value_" & $Value_SG_entry_Limit & "_min", "")

For $Schleife_Members_Check = 0 To 32

	$Name_Member = IniRead($Members_Data_INI, $Schleife_Members_Check, "name", "")

	If $Name_Member <> "" Then
		$ExperiencePoints_Check = IniRead($Stats_INI, $Name_Member, "ExperiencePoints", "")

		If $ExperiencePoints_Check < $Value_SG_entry_Limit_min Then
			$KICK_User = IniWrite($config_ini, "TEMP", "KICK_User", $Name_Member)
			MsgBox(0, "", "User " & $Name_Member & " will be removed because of SG Limit", 5)
			_KICK_USER_universal()
		EndIf
	EndIf

Next

EndFunc


Func _Write_Results_File_TXT()

$ServerName = IniRead($Server_Data_INI, "DATA", "name", "")

$SessionStage_Check = IniRead($config_ini, "TEMP", "Results_saved_SessionStage", "")
$Check_TrackName_Value = IniRead($config_ini, "TEMP", "Results_saved_TrackName", "")

$NowDate_Value = _NowDate()
$NowDate = StringReplace($NowDate_Value, "/", ".")
$NowTime_Value = _NowTime()
$NowTime_orig = $NowTime_Value
$NowTime = StringReplace($NowTime_Value, ":", "-")

$NowTime_saved_1 = StringTrimRight($NowTime, 3)
$NowTime_saved_2 = StringTrimLeft($NowTime_saved_1, 3)
$NowTime_saved_3 = StringTrimRight($NowTime, 5)


$SessionStage_Check = IniRead($config_ini, "TEMP", "Results_saved_SessionStage", "")
If $SessionStage_Check = "" Then $SessionStage_Check = IniRead($Server_Data_INI, "DATA", "SessionStage", "")


If Not FileExists($Data_Dir & "Results\" & $NowDate) Then
	DirCreate($Data_Dir & "Results\" & $NowDate)
EndIf

$Results_File_1 = $Data_Dir & "Results\" & $NowDate & "\" & $SessionStage_Check & "_" & $NowTime & ".txt"

FileWriteLine($Results_File_1,  "[--- RESULTS ---]" & $SessionStage_Check & " - " & $Check_TrackName_Value & " - " & $NowDate & " - " & $NowTime_orig)

Global $ROW_1, $ROW_2, $ROW_3, $ROW_4, $ROW_5, $ROW_6, $ROW_7, $ROW_8, $ROW_9, $ROW_10, $ROW_11, $ROW_12, $ROW_13, $ROW_14, $ROW_15
Global $ROW_16, $ROW_17, $ROW_18, $ROW_19, $ROW_20, $ROW_21, $ROW_22, $ROW_23, $ROW_24, $ROW_25, $ROW_26, $ROW_27, $ROW_28, $ROW_29
Global $ROW_30, $ROW_31, $ROW_32


For $Schleife_Results_1 = 1 To 32

	$Check_refid_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "refid", "") ; refid
	$Check_Name_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "name", "") ; Name
		If $Check_Name_Value = "" Then
			$Check_Name_Value = IniRead($Members_Data_INI, $Check_refid_Value, "name", "")
		EndIf

		$Check_Name_Value_bea = $Check_Name_Value

		If $Check_Name_Value_bea <> "" Then
			$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "[", "<")
			$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "]", ">")
		EndIf

		If $Check_Name_Value_bea = "" Then $Check_Name_Value_bea = $Check_Name_Value

		;MsgBox(0, "", $Check_Name_Value & @CRLF & $Check_Name_Value_bea, 10)

	If $Check_Name_Value <> "" Then
		$Check_IsPlayer_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "IsPlayer", "") ; IsPlayer
		$Check_GridPosition_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "GridPosition", "-") ; GridPosition
		$Check_VehicleId_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "VehicleId", "") ; VehicleId
			IniWrite($config_ini, "TEMP", "Check_Carid", $Check_VehicleId_Value)
			_CAR_NAME_from_ID()
			$Check_VehicleIName_Value = IniRead($config_ini, "TEMP", "Check_CarName", "")
			If $Check_VehicleIName_Value = "" Then $Check_VehicleIName_Value = $Check_VehicleId_Value
		$Check_LiveryId_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "LiveryId", "") ; LiveryId
		$Check_RacePosition_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "RacePosition", "") ; RacePosition
		$Check_CurrentLap_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "CurrentLap", "-") ; CurrentLap
		$Check_CurrentSector_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "CurrentSector", "-") ; CurrentSector
		$Check_Sector1Time_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "Sector1Time", "-") ; Sector1Time
		$Check_Sector2Time_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "Sector2Time", "-") ; Sector2Time
		$Check_Sector3Time_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "Sector3Time", "-") ; Sector3Time
		$Check_LastLapTime_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "LastLapTime", "-") ; LastLapTime
		$Check_FastestLapTime_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "FastestLapTime", "-") ; FastestLapTime
		$Check_State_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "State", "") ; State
		$Check_HeadlightsOn_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "HeadlightsOn", "") ; HeadlightsOn
		$Check_WipersOn_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "WipersOn", "") ; WipersOn
		$Check_Speed_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "Speed", "") ; Speed
		$Check_Gear_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "Gear", "") ; Gear
		$Check_RPM_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "RPM", "") ; RPM
		$Check_PositionX_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "PositionX", "") ; PositionX
		$Check_PositionY_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "PositionY", "") ; PositionY
		$Check_PositionZ_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "PositionZ", "") ; PositionZ
		$Check_Orientation_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "Orientation", "") ; Orientation

		$Check_PitStops_Value = IniRead($PitStops_INI, $Check_Name_Value_bea, "PitStops", "") ; PitStops
		$Check_PenaltyPoints_Value = IniRead($Points_ini, $Check_Name_Value_bea, "PenaltyPoints", "") ; PenaltyPoints
		$Check_ExperiencePoints_Value = IniRead($Stats_INI, $Check_Name_Value_bea, "ExperiencePoints", "") ; ExperiencePoints
		$Check_DistanceTravelled_Value = IniRead($Stats_INI, $Check_Name_Value_bea, "DistanceTravelled", "") ; DistanceTravelled
		$Check_SafetyGroup_Value = IniRead($Stats_INI, $Check_Name_Value_bea, "SafetyGroup", "") ; SafetyGroup


		If $Check_RacePosition_Value = "1" Then
			$ROW_1 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "2" Then
			$ROW_2 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "3" Then
			$ROW_3 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "4" Then
			$ROW_4 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "5" Then
			$ROW_5 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "6" Then
			$ROW_6 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "7" Then
			$ROW_7 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "8" Then
			$ROW_8 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "9" Then
			$ROW_9 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "10" Then
			$ROW_10 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "11" Then
			$ROW_11 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "12" Then
			$ROW_12 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "13" Then
			$ROW_13 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "14" Then
			$ROW_14 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "15" Then
			$ROW_15 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "16" Then
			$ROW_16 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "17" Then
			$ROW_17 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "18" Then
			$ROW_18 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "19" Then
			$ROW_19 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "20" Then
			$ROW_20 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "21" Then
			$ROW_21 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "22" Then
			$ROW_22 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "23" Then
			$ROW_23 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "24" Then
			$ROW_24 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "25" Then
			$ROW_25 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "26" Then
			$ROW_26 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "27" Then
			$ROW_27 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "28" Then
			$ROW_28 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "29" Then
			$ROW_29 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "30" Then
			$ROW_30 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "31" Then
			$ROW_31 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

		If $Check_RacePosition_Value = "32" Then
			$ROW_32 = $Check_Name_Value & " | " & $Check_GridPosition_Value & " | " & $Check_VehicleIName_Value & " | " & $Check_RacePosition_Value & " | " & $Check_CurrentLap_Value & " | " & $Check_CurrentSector_Value & _
						" | " & $Check_Sector1Time_Value & " | " & $Check_Sector2Time_Value & " | " & $Check_Sector3Time_Value & " | " & $Check_LastLapTime_Value & " | " & $Check_FastestLapTime_Value & _
						" | " & $Check_State_Value & " | " & $Check_PitStops_Value & " | " & $Check_PenaltyPoints_Value & " | " & $Check_ExperiencePoints_Value & " | " & $Check_SafetyGroup_Value & " | " & $Check_DistanceTravelled_Value
		EndIf

	Else
		$Schleife_Results_1 = 32
	EndIf

Next

FileWriteLine($Results_File_1, "-----" & @CRLF)
If $ROW_1 <> "" Then FileWriteLine($Results_File_1, $ROW_1)
If $ROW_2 <> "" Then FileWriteLine($Results_File_1, $ROW_2)
If $ROW_3 <> "" Then FileWriteLine($Results_File_1, $ROW_3)
If $ROW_4 <> "" Then FileWriteLine($Results_File_1, $ROW_4)
If $ROW_5 <> "" Then FileWriteLine($Results_File_1, $ROW_5)
If $ROW_6 <> "" Then FileWriteLine($Results_File_1, $ROW_6)
If $ROW_7 <> "" Then FileWriteLine($Results_File_1, $ROW_7)
If $ROW_8 <> "" Then FileWriteLine($Results_File_1, $ROW_8)
If $ROW_9 <> "" Then FileWriteLine($Results_File_1, $ROW_9)
If $ROW_10 <> "" Then FileWriteLine($Results_File_1, $ROW_10)
If $ROW_11 <> "" Then FileWriteLine($Results_File_1, $ROW_11)
If $ROW_12 <> "" Then FileWriteLine($Results_File_1, $ROW_12)
If $ROW_13 <> "" Then FileWriteLine($Results_File_1, $ROW_13)
If $ROW_14 <> "" Then FileWriteLine($Results_File_1, $ROW_14)
If $ROW_15 <> "" Then FileWriteLine($Results_File_1, $ROW_15)
If $ROW_16 <> "" Then FileWriteLine($Results_File_1, $ROW_16)
If $ROW_17 <> "" Then FileWriteLine($Results_File_1, $ROW_17)
If $ROW_18 <> "" Then FileWriteLine($Results_File_1, $ROW_18)
If $ROW_19 <> "" Then FileWriteLine($Results_File_1, $ROW_19)
If $ROW_20 <> "" Then FileWriteLine($Results_File_1, $ROW_20)
If $ROW_21 <> "" Then FileWriteLine($Results_File_1, $ROW_21)
If $ROW_22 <> "" Then FileWriteLine($Results_File_1, $ROW_22)
If $ROW_23 <> "" Then FileWriteLine($Results_File_1, $ROW_23)
If $ROW_24 <> "" Then FileWriteLine($Results_File_1, $ROW_24)
If $ROW_25 <> "" Then FileWriteLine($Results_File_1, $ROW_25)
If $ROW_26 <> "" Then FileWriteLine($Results_File_1, $ROW_26)
If $ROW_27 <> "" Then FileWriteLine($Results_File_1, $ROW_27)
If $ROW_28 <> "" Then FileWriteLine($Results_File_1, $ROW_28)
If $ROW_29 <> "" Then FileWriteLine($Results_File_1, $ROW_29)
If $ROW_30 <> "" Then FileWriteLine($Results_File_1, $ROW_30)
If $ROW_31 <> "" Then FileWriteLine($Results_File_1, $ROW_31)
If $ROW_32 <> "" Then FileWriteLine($Results_File_1, $ROW_32)
FileWriteLine($Results_File_1, "[-----]" & " - " & $SessionStage_Check & " - " & $Check_TrackName_Value & " - " & $NowDate & " - " & $NowTime_orig)


If $LOG_Event_Check_auto_MSG = "true" Then
	$Message_1 = "Event Finished"
	$Message_2 = "Results saved to:"
	$Message_3 = $NowDate & "\" & $SessionStage_Check & "_" & $NowTime & ".txt"
	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_1
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_2
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_3
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
EndIf

Global $Results_copy_2_folder = IniRead($config_ini, "Einstellungen", "PCDSG_Stats_path", "")
Global $Results_File_1_HTM_copy_2 = $Results_copy_2_folder & "PCDSG - Results\"
Global $Results_NowDate_Folder = $Data_Dir & "Results\" & $NowDate
DirCopy($Results_NowDate_Folder & "\", $Results_File_1_HTM_copy_2 & $NowDate & "\", $FC_OVERWRITE)

EndFunc

Func _Write_Results_File_INI()

$Check_TrackName_Value = IniRead($config_ini, "TEMP", "Results_saved_TrackName", "")

$NowDate_Value = _NowDate()
$NowDate = StringReplace($NowDate_Value, "/", ".")
$NowTime_Value = _NowTime()
$NowTime_orig = $NowTime_Value
$NowTime = StringReplace($NowTime_Value, ":", "-")

$NowTime_saved_1 = StringTrimRight($NowTime, 3)
$NowTime_saved_2 = StringTrimLeft($NowTime_saved_1, 3)
$NowTime_saved_3 = StringTrimRight($NowTime, 5)


$SessionStage_Check = IniRead($config_ini, "TEMP", "Results_saved_SessionStage", "")
If $SessionStage_Check = "" tHen $SessionStage_Check = IniRead($Server_Data_INI, "DATA", "SessionStage", "")

If Not FileExists($Data_Dir & "Results\" & $NowDate) Then
	DirCreate($Data_Dir & "Results\" & $NowDate)
EndIf

$Results_File_1 = $Data_Dir & "Results\" & $NowDate & "\" & $SessionStage_Check & "_" & $NowTime & ".ini"

FileWriteLine($Results_File_1,  "[--- RESULTS ---]" & $SessionStage_Check & " - " & $Check_TrackName_Value & " - " & $NowDate & " - " & $NowTime_orig)

Global $ROW_1, $ROW_2, $ROW_3, $ROW_4, $ROW_5, $ROW_6, $ROW_7, $ROW_8, $ROW_9, $ROW_10, $ROW_11, $ROW_12, $ROW_13, $ROW_14, $ROW_15
Global $ROW_16, $ROW_17, $ROW_18, $ROW_19, $ROW_20, $ROW_21, $ROW_22, $ROW_23, $ROW_24, $ROW_25, $ROW_26, $ROW_27, $ROW_28, $ROW_29
Global $ROW_30, $ROW_31, $ROW_32


For $Schleife_Results_1 = 1 To 32

	$Check_refid_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "refid", "") ; refid
	$Check_Name_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "name", "") ; Name
		If $Check_Name_Value = "" Then
			$Check_Name_Value = IniRead($Members_Data_INI, $Check_refid_Value, "name", "")
		EndIf

		$Check_Name_Value_bea = $Check_Name_Value

		If $Check_Name_Value_bea <> "" Then
			$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "[", "<")
			$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "]", ">")
		EndIf

		If $Check_Name_Value_bea = "" Then $Check_Name_Value_bea = $Check_Name_Value

		;MsgBox(0, "", $Check_Name_Value & @CRLF & $Check_Name_Value_bea, 10)

	If $Check_Name_Value <> "" Then
		$Check_IsPlayer_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "IsPlayer", "") ; IsPlayer
		$Check_GridPosition_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "GridPosition", "-") ; GridPosition
		$Check_VehicleId_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "VehicleId", "") ; VehicleId
			IniWrite($config_ini, "TEMP", "Check_Carid", $Check_VehicleId_Value)
			_CAR_NAME_from_ID()
			$Check_VehicleIName_Value = IniRead($config_ini, "TEMP", "Check_CarName", "")
			If $Check_VehicleIName_Value = "" Then $Check_VehicleIName_Value = $Check_VehicleId_Value
		$Check_LiveryId_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "LiveryId", "") ; LiveryId
		$Check_RacePosition_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "RacePosition", "") ; RacePosition
		$Check_RacePosition_Value_bea = $Check_RacePosition_Value
			If $Check_RacePosition_Value = "" Then $Check_RacePosition_Value_bea = 1
		$Check_CurrentLap_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "CurrentLap", "-") ; CurrentLap
		$Check_CurrentSector_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "CurrentSector", "-") ; CurrentSector
		$Check_Sector1Time_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "Sector1Time", "-") ; Sector1Time
		$Check_Sector2Time_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "Sector2Time", "-") ; Sector2Time
		$Check_Sector3Time_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "Sector3Time", "-") ; Sector3Time
		$Check_LastLapTime_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "LastLapTime", "-") ; LastLapTime
		$Check_FastestLapTime_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "FastestLapTime", "-") ; FastestLapTime
		$Check_State_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "State", "") ; State
		$Check_HeadlightsOn_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "HeadlightsOn", "") ; HeadlightsOn
		$Check_WipersOn_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "WipersOn", "") ; WipersOn
		$Check_Speed_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "Speed", "") ; Speed
		$Check_Gear_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "Gear", "") ; Gear
		$Check_RPM_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "RPM", "") ; RPM
		$Check_PositionX_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "PositionX", "") ; PositionX
		$Check_PositionY_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "PositionY", "") ; PositionY
		$Check_PositionZ_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "PositionZ", "") ; PositionZ
		$Check_Orientation_Value = IniRead($Participants_Data_INI, $Schleife_Results_1, "Orientation", "") ; Orientation

		$Check_PitStops_Value = IniRead($PitStops_INI, $Check_Name_Value_bea, "PitStops", "") ; PitStops
		$Check_PenaltyPoints_Value = IniRead($Points_ini, $Check_Name_Value_bea, "PenaltyPoints", "") ; PenaltyPoints
		$Check_ExperiencePoints_Value = IniRead($Stats_INI, $Check_Name_Value_bea, "ExperiencePoints", "") ; ExperiencePoints
		$Check_DistanceTravelled_Value = IniRead($Stats_INI, $Check_Name_Value_bea, "DistanceTravelled", "") ; DistanceTravelled
		$Check_SafetyGroup_Value = IniRead($Stats_INI, $Check_Name_Value_bea, "SafetyGroup", "") ; SafetyGroup

		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "Name", $Check_Name_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "GridPosition", $Check_GridPosition_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "Vehicle", $Check_VehicleIName_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "RacePosition", $Check_RacePosition_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "CurrentLap", $Check_CurrentLap_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "CurrentSector", $Check_CurrentSector_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "Sector1Time", $Check_Sector1Time_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "Sector2Time", $Check_Sector2Time_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "Sector3Time", $Check_Sector3Time_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "LastLapTime", $Check_LastLapTime_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "FastestLapTime", $Check_FastestLapTime_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "State", $Check_State_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "PitStops_", $Check_PitStops_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "PenaltyPoints", $Check_PenaltyPoints_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "ExperiencePoints", $Check_ExperiencePoints_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "SafetyGroup", $Check_SafetyGroup_Value)
		IniWrite($Results_File_1, $Check_RacePosition_Value & ".Pos__" & $Check_Name_Value_bea, "DistanceTravelled", $Check_DistanceTravelled_Value)
		FileWriteLine($Results_File_1, " " & @CRLF)

	Else
		$Schleife_Results_1 = 32
	EndIf

Next


FileWriteLine($Results_File_1, "[-----]" & " - " & $SessionStage_Check & " - " & $Check_TrackName_Value & " - " & $NowDate & " - " & $NowTime_orig)


If $LOG_Event_Check_auto_MSG = "true" Then
	$Message_1 = "Event Finished"
	$Message_2 = "Results saved to:"
	$Message_3 = $NowDate & "\" & $SessionStage_Check & "_" & $NowTime & ".ini"
	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_1
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_2
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
	$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_3
	$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
EndIf


Global $Results_copy_2_folder = IniRead($config_ini, "Einstellungen", "PCDSG_Stats_path", "")
Global $Results_File_1_HTM_copy_2 = $Results_copy_2_folder & "PCDSG - Results\"
Global $Results_NowDate_Folder = $Data_Dir & "Results\" & $NowDate
DirCopy($Results_NowDate_Folder & "\", $Results_File_1_HTM_copy_2 & $NowDate & "\", $FC_OVERWRITE)

EndFunc

Func _Write_Results_File_XLS_HTM()

$ServerName = IniRead($Server_Data_INI, "DATA", "name", "")

$SessionStage_Check = IniRead($config_ini, "TEMP", "Results_saved_SessionStage", "")
$Check_TrackName_Value = IniRead($config_ini, "TEMP", "Results_saved_TrackName", "")

$NowDate_Value = _NowDate()
$NowDate = StringReplace($NowDate_Value, "/", ".")
$NowTime_Value = _NowTime()
$NowTime_orig = $NowTime_Value
$NowTime = StringReplace($NowTime_Value, ":", "-")

$NowTime_saved_1 = StringTrimRight($NowTime, 3)
$NowTime_saved_2 = StringTrimLeft($NowTime_saved_1, 3)
$NowTime_saved_3 = StringTrimRight($NowTime, 5)

$Results_NowDate_Folder = $Data_Dir & "Results\" & $NowDate
$Results_File_1_HTM = $Results_NowDate_Folder & "\" & $SessionStage_Check & "_" & $NowTime_saved_1 & ".htm" ; $NowTime
$Check_Results_File_1_HTM = $SessionStage_Check & "_" & $NowTime_saved_1 & ".htm" ; $NowTime


;If $Check_Server_State_1 <> "Idle" Then

	Global $SessionStage_Check = IniRead($config_ini, "TEMP", "Results_saved_SessionStage", "")
	If $SessionStage_Check = "" Then $SessionStage_Check = IniRead($Server_Data_INI, "DATA", "SessionStage", "")

	Global $Session_Duration = ""

	If $SessionStage_Check = "Practice1" Then $Session_Duration = IniRead($Server_Data_INI, "DATA", "Practice1Length", "")
	If $SessionStage_Check = "Practice2" Then $Session_Duration = IniRead($Server_Data_INI, "DATA", "Practice2Length", "")
	If $SessionStage_Check = "Qualifying" Then $Session_Duration = IniRead($Server_Data_INI, "DATA", "QualifyLength", "")
	If $SessionStage_Check = "Warmup" Then $Session_Duration = IniRead($Server_Data_INI, "DATA", "WarmupLength", "")
	If $SessionStage_Check = "Race1" Then $Session_Duration = IniRead($Server_Data_INI, "DATA", "Race1Length", "")
	If $SessionStage_Check = "Race1" Then $Session_Duration = IniRead($Server_Data_INI, "DATA", "Race2Length", "")


	If Not FileExists($Data_Dir & "Results\" & $NowDate) Then
		DirCreate($Data_Dir & "Results\" & $NowDate)
	EndIf

	$Results_File_Template = $System_Dir & "ServerEvents\Template.xlsm"
	$Results_File_ServerEvents_XLS = $System_Dir & "ServerEvents\Results.xls"
	$Results_File_ServerEvents_HTM = $System_Dir & "ServerEvents\Results.htm"
	$Results_File_1 = $Data_Dir & "Results\" & $NowDate & "\" & $SessionStage_Check & "_" & $NowTime_saved_1 & ".xls" ; $NowTime
	$Results_File_1_HTM = $Data_Dir & "Results\" & $NowDate & "\" & $SessionStage_Check & "_" & $NowTime_saved_1 & ".htm" ; $NowTime
	$Results_File_Dateien_HTM = $Data_Dir & "Results\" & $NowDate & "\" & $SessionStage_Check & "_" & $NowTime_saved_1 & "-Dateien\"
	$Results_File_Files_HTM = $Data_Dir & "Results\" & $NowDate & "\" & $SessionStage_Check & "_" & $NowTime_saved_1 & "-Files\"
	$Results_File_Fichiers_HTM = $Data_Dir & "Results\" & $NowDate & "\" & $SessionStage_Check & "_" & $NowTime_saved_1 & "-Fichiers\"

	; Create application object and create a new workbook
	Local $oExcel = _Excel_Open($Results_File_1, false, false)
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeWrite Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	Local $oWorkbook = _Excel_BookNew($oExcel)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeWrite Example", "Error creating the new workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
		_Excel_Close($oExcel, True)
		Exit
	EndIf

	$oWorkbook.Sheets(1).Name = "Results"

	_Excel_SheetAdd($oWorkbook, -1, False, 1, "LapByLap") ; "LapByLap|Test2"
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetAdd Example 2", "Error adding sheet." & @CRLF & "@error = " & @error & ", @extended = " & @extended, 5)
	;MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetAdd Example 2", "Sheet added before sheet 2.")

	$oWorkbook.Sheets(2).Name = "LapByLap"
	;$oWorkbook.Sheets("LapByLap").Select
	$oWorkbook.Sheets("Results").Select

	$oExcel.Columns("A:A" ).ColumnWidth = 16 ; RacePosition
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("B:B" ).ColumnWidth = 19 ; Name
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("C:C" ).ColumnWidth = 12 ; GridPosition
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("D:D" ).ColumnWidth = 14 ; FastestLapTime
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("E:E" ).ColumnWidth = 16 ; State
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("F:F" ).ColumnWidth = 8 ; PitStops
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("G:G" ).ColumnWidth = 14 ; PenaltyPoints
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("H:H" ).ColumnWidth = 16 ; ExperiencePoints
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("I:I" ).ColumnWidth = 17 ; DistanceTravelled
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("J:J" ).ColumnWidth = 12 ; SafetyGroup
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("K:K" ).ColumnWidth = 35 ; Vehicle
	$oExcel.Selection.RowHeight = 15

	; Insert Picture
	Local $sPicture = $System_Dir & "gfx\Logo.jpg"
	If FileExists($sPicture) Then
		;_Excel_PictureAdd($oWorkbook, Default, $sPicture, "N1:Q3")
		_Excel_PictureAdd($oWorkbook, Default, $sPicture, "J1", Default, 260, 50)
	EndIf

	$var_excel_open = $oWorkbook

	$oExcel.Range("A1").Select
	$oExcel.Selection.Font.Bold = True
	$oExcel.Range("A2").Select
	$oExcel.Selection.Font.Bold = True
	$oExcel.Range("A3").Select
	$oExcel.Selection.Font.Bold = True

	$oExcel.Range("D1").Select
	$oExcel.Selection.Font.Bold = True
	$oExcel.Range("D2").Select
	$oExcel.Selection.Font.Bold = True
	$oExcel.Range("D3").Select
	$oExcel.Selection.Font.Bold = True

	$oExcel.Range("G1").Select
	$oExcel.Selection.Font.Bold = True
	$oExcel.Range("G2").Select
	$oExcel.Selection.Font.Bold = True
	$oExcel.Range("G3").Select
	$oExcel.Selection.Font.Bold = True

	$oExcel.Range("5:5").Select
	$oExcel.Selection.Font.Bold = True

	_Excel_RangeWrite($var_excel_open, "Results", "Session Name:", "A1", true)
	_Excel_RangeWrite($var_excel_open, "Results", "Session Stage:", "A2", true)
	_Excel_RangeWrite($var_excel_open, "Results", "Session Duration:", "A3", true)
	_Excel_RangeWrite($var_excel_open, "Results", $ServerName, "B1", true)
	_Excel_RangeWrite($var_excel_open, "Results", $SessionStage_Check, "B2", true)
	_Excel_RangeWrite($var_excel_open, "Results", $Session_Duration, "B3", true)
	_Excel_RangeWrite($var_excel_open, "Results", "Track:", "D1", true)
	_Excel_RangeWrite($var_excel_open, "Results", "Date:", "D2", true)
	_Excel_RangeWrite($var_excel_open, "Results", "Time:", "D3", true)
	_Excel_RangeWrite($var_excel_open, "Results", $Check_TrackName_Value, "E1", true)
	_Excel_RangeWrite($var_excel_open, "Results", $NowDate, "E2", true)
	_Excel_RangeWrite($var_excel_open, "Results", $NowTime_orig, "E3", true)
	_Excel_RangeWrite($var_excel_open, "Results", "Fastest Lap:", "G1", true)
	_Excel_RangeWrite($var_excel_open, "Results", "Server Best:", "G2", true)
	_Excel_RangeWrite($var_excel_open, "Results", "Server Best By:", "G3", true)

	_Excel_RangeWrite($var_excel_open, "Results", "RacePosition", "A5", true)
	_Excel_RangeWrite($var_excel_open, "Results", "Name", "B5", true)
	_Excel_RangeWrite($var_excel_open, "Results", "TotalTime", "C5", true)
	_Excel_RangeWrite($var_excel_open, "Results", "FastestLapTime", "D5", true)
	_Excel_RangeWrite($var_excel_open, "Results", "State", "E5", true)
	_Excel_RangeWrite($var_excel_open, "Results", "PitStops", "F5", true)
	_Excel_RangeWrite($var_excel_open, "Results", "PenaltyPoints", "G5", true)
	_Excel_RangeWrite($var_excel_open, "Results", "ExperiencePoints", "H5", true)
	_Excel_RangeWrite($var_excel_open, "Results", "DistanceTravelled", "I5", true)
	_Excel_RangeWrite($var_excel_open, "Results", "SafetyGroup", "J5", true)
	_Excel_RangeWrite($var_excel_open, "Results", "Vehicle", "K5", true)


	Global $CurrentSessionStage = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
	If $CurrentSessionStage = "" Then $CurrentSessionStage = IniRead($config_ini, "PC_Server", "SessionStage", "")

	For $Schleife_Results_1 = 1 To 32

		$Check_attribute_name_Value = IniRead($Results_INI, $Schleife_Results_1, "attribute_name", "")
		$Check_attribute_refid_Value = IniRead($Results_INI, $Schleife_Results_1, "attribute_refid", "")
		$Check_attribute_participantid_Value = IniRead($Results_INI, $Schleife_Results_1, "attribute_participantid", "")
		$Check_attribute_RacePosition_Value = IniRead($Results_INI, $Schleife_Results_1, "attribute_RacePosition", "")
		$Check_attribute_Lap_Value = IniRead($Results_INI, $Schleife_Results_1, "attribute_Lap", "")
		$Check_attribute_VehicleId_Value = IniRead($Results_INI, $Schleife_Results_1, "attribute_VehicleId", "")
		$Check_attribute_State_Value = IniRead($Results_INI, $Schleife_Results_1, "attribute_State", "")
		$Check_attribute_TotalTime_Value = IniRead($Results_INI, $Schleife_Results_1, "attribute_TotalTime", "")
		$Check_attribute_FastestLapTime_Value = IniRead($Results_INI, $Schleife_Results_1, "attribute_FastestLapTime", "")


		$Check_refid_Value = $Check_attribute_refid_Value ; refid

		;If $Check_refid_Value = "" Then
			;$Participants_Data_INI_TEMP = $Participants_Data_INI_TEMP_Check_1
			;$Check_refid_Value = IniRead($Participants_Data_INI_TEMP, $Schleife_Results_1, "refid", "")
		;EndIf

		;If $Check_refid_Value = "" Then
			;$Participants_Data_INI_TEMP = $Participants_Data_INI_TEMP_Check_2
			;$Check_refid_Value = IniRead($Participants_Data_INI_TEMP, $Schleife_Results_1, "refid", "")
		;EndIf

		$Check_Name_Value = $Check_attribute_name_Value ; Name
			If $Check_Name_Value = "" Then $Check_Name_Value = IniRead($Members_Data_INI, $Check_refid_Value, "name", "")
			;If $Check_Name_Value = "" Then $Check_Name_Value = IniRead($Participants_Data_INI_TEMP, $Check_refid_Value, "Name", "")

			$Check_Name_Value_bea = $Check_Name_Value

			If $Check_Name_Value_bea <> "" Then
				$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "[", "<")
				$Check_Name_Value_bea = StringReplace($Check_Name_Value_bea, "]", ">")
			EndIf

			If $Check_Name_Value_bea = "" Then $Check_Name_Value_bea = $Check_Name_Value


		If $Check_Name_Value_bea <> "" Then

			$Check_GridPosition_Value = IniRead($Participants_Data_INI_TEMP, $Schleife_Results_1, "GridPosition", "-") ; GridPosition
			$Check_VehicleId_Value = $Check_attribute_VehicleId_Value ; VehicleId
				IniWrite($config_ini, "TEMP", "Check_Carid", $Check_VehicleId_Value)
				_CAR_NAME_from_ID()
				$Check_VehicleIName_Value = IniRead($config_ini, "TEMP", "Check_CarName", "")
			$Check_RacePosition_Value = $Check_attribute_RacePosition_Value
			$Check_RacePosition_Value_bea = $Check_attribute_RacePosition_Value
			$Check_CurrentLap_Value = $Check_attribute_Lap_Value
			$Check_FastestLapTime_Value = $Check_attribute_FastestLapTime_Value
			$Check_State_Value = $Check_attribute_State_Value
			$Check_TotalTime_Value = $Check_attribute_TotalTime_Value
			If $Check_TotalTime_Value = "" Then $Check_TotalTime_Value = $Check_CurrentLap_Value & " Laps"

			$Check_PitStops_Value = IniRead($PitStops_INI, $Check_Name_Value_bea, "PitStops", "") ; PitStops
			$Check_PenaltyPoints_Value = IniRead($Points_ini, $Check_Name_Value_bea, "PenaltyPoints", "") ; PenaltyPoints
			$Check_ExperiencePoints_Value = IniRead($Stats_INI, $Check_Name_Value_bea, "ExperiencePoints", "") ; ExperiencePoints
			$Check_DistanceTravelled_Value = IniRead($Stats_INI, $Check_Name_Value_bea, "DistanceTravelled", "") ; DistanceTravelled
			$Check_SafetyGroup_Value = IniRead($Stats_INI, $Check_Name_Value_bea, "SafetyGroup", "") ; SafetyGroup

			_Excel_RangeWrite($var_excel_open, "Results", $Check_RacePosition_Value & " [" & $Check_GridPosition_Value & "]", "A" & $Check_RacePosition_Value + 5, true)
			_Excel_RangeWrite($var_excel_open, "Results", $Check_Name_Value, "B" & $Check_RacePosition_Value + 5, true)
			_Excel_RangeWrite($var_excel_open, "Results", $Check_TotalTime_Value, "C" & $Check_RacePosition_Value + 5, true)
			_Excel_RangeWrite($var_excel_open, "Results", $Check_FastestLapTime_Value, "D" & $Check_RacePosition_Value + 5, true)
			_Excel_RangeWrite($var_excel_open, "Results", $Check_State_Value, "E" & $Check_RacePosition_Value + 5, true)
			_Excel_RangeWrite($var_excel_open, "Results", $Check_PitStops_Value, "F" & $Check_RacePosition_Value + 5, true)
			_Excel_RangeWrite($var_excel_open, "Results", $Check_PenaltyPoints_Value, "G" & $Check_RacePosition_Value + 5, true)
			_Excel_RangeWrite($var_excel_open, "Results", $Check_ExperiencePoints_Value, "H" & $Check_RacePosition_Value + 5, true)
			_Excel_RangeWrite($var_excel_open, "Results", $Check_DistanceTravelled_Value, "I" & $Check_RacePosition_Value + 5, true)
			_Excel_RangeWrite($var_excel_open, "Results", $Check_SafetyGroup_Value, "J" & $Check_RacePosition_Value + 5, true)
			_Excel_RangeWrite($var_excel_open, "Results", $Check_VehicleIName_Value, "K" & $Check_RacePosition_Value + 5, true)

		Else
			$Schleife_Results_1 = 32
		EndIf

	Next

	;_Excel_SheetAdd($oWorkbook, -1, False, 1, "LapByLap") ; "LapByLap|Test2"
	;If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetAdd Example 2", "Error adding sheet." & @CRLF & "@error = " & @error & ", @extended = " & @extended, 5)
	;MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetAdd Example 2", "Sheet added before sheet 2.")

	;$oWorkbook.Sheets("LapByLap").Select

	$oExcel.Range("A1").Select
	$oExcel.Selection.Font.Bold = True
	$oExcel.Range("A2").Select
	$oExcel.Selection.Font.Bold = True
	$oExcel.Range("A3").Select
	$oExcel.Selection.Font.Bold = True

	$oExcel.Range("D1").Select
	$oExcel.Selection.Font.Bold = True
	$oExcel.Range("D2").Select
	$oExcel.Selection.Font.Bold = True
	$oExcel.Range("D3").Select
	$oExcel.Selection.Font.Bold = True

	$oExcel.Range("G1").Select
	$oExcel.Selection.Font.Bold = True
	$oExcel.Range("G2").Select
	$oExcel.Selection.Font.Bold = True
	$oExcel.Range("G3").Select
	$oExcel.Selection.Font.Bold = True

	$oExcel.Range("5:5").Select
	$oExcel.Selection.Font.Bold = True

	$oExcel.Columns("A:A").ColumnWidth = 19 ; Name
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("B:B").ColumnWidth = 22 ; RacePosition LAP
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("C:C").ColumnWidth = 22 ; LapTime LAP
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("D:D").ColumnWidth = 22 ; PitStops LAP
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("E:E").ColumnWidth = 22 ; PenaltyPoints LAP
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("F:F").ColumnWidth = 22 ; ExperiencePoints LAP
	$oExcel.Selection.RowHeight = 15
	$oExcel.Columns("G:G").ColumnWidth = 22 ; Time LAP
	$oExcel.Selection.RowHeight = 15


	_Excel_RangeWrite($var_excel_open, "LapByLap", "Session Name:", "A1", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", "Session State:", "A2", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", "Session Duration:", "A3", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", $ServerName, "B1", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", $SessionStage_Check, "B2", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", $Session_Duration, "B3", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", "Track:", "D1", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", "Date:", "D2", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", "Time:", "D3", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", $Check_TrackName_Value, "E1", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", $NowDate, "E2", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", $NowTime_orig, "E3", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", "Fastest Lap:", "G1", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", "Server Best:", "G2", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", "Server Best By:", "G3", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", $Check_TrackName_Value, "E1", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", $NowDate, "E2", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", $NowTime_orig, "E3", true)

	_Excel_RangeWrite($var_excel_open, "LapByLap", "Lap \ Name", "A5", true)


	$column_Letter = 2

	_Excel_RangeWrite($var_excel_open, "LapByLap", "Positions", "A5", true)
	_Excel_RangeWrite($var_excel_open, "LapByLap", "Lap Times", "A25", true)

	For $Schleife_Excel_1 = 6 To 38

		$Content_Ax = _Excel_RangeRead($var_excel_open, "Results", "B" & $Schleife_Excel_1)

		$Content_Ax_bea = $Content_Ax

		If $Content_Ax <> "" Then
			$Content_Ax_bea = StringReplace($Content_Ax_bea, "[", "<")
			$Content_Ax_bea = StringReplace($Content_Ax_bea, "]", ">")
		EndIf

		If $Content_Ax_bea = "" Then $Content_Ax_bea = $Content_Ax

		If $Content_Ax <> "" Then

			$column_Letter_from_number_1 = _Excel_ColumnToLetter($column_Letter)
			_Excel_RangeWrite($var_excel_open, "LapByLap", $Content_Ax, $column_Letter_from_number_1 & "6", true)
			_Excel_RangeWrite($var_excel_open, "LapByLap", $Content_Ax, $column_Letter_from_number_1 & "26", true)

			$NR_of_Laps = IniRead($LapByLap_File, $SessionStage_Check & "_" & $Content_Ax_bea, "Laps", "10")
			If $NR_of_Laps = "" Then $NR_of_Laps = 10

			$NR_of_Laps = 15

			For $Schleife_Excel_2 = 0 To $NR_of_Laps
				;$column_Letter = $Schleife_Excel_2 + 1

				$RacePosition_LapByLap = IniRead($LapByLap_File, $SessionStage_Check & "_Name_" & $Content_Ax_bea, "LAP_" & $Schleife_Excel_2 & "_RacePosition", "")
				$LapTime_LapByLap = IniRead($LapByLap_File, $SessionStage_Check & "_Name_" & $Content_Ax_bea, "LAP_" & $Schleife_Excel_2 & "_LapTime", "")
				$PitStops_LapByLap = IniRead($LapByLap_File, $SessionStage_Check & "_Name_" & $Content_Ax_bea, "LAP_" & $Schleife_Excel_2 & "_PitStops", "")
				$PenaltyPoints_LapByLap = IniRead($LapByLap_File, $SessionStage_Check & "_Name_" & $Content_Ax_bea, "LAP_" & $Schleife_Excel_2 & "_PenaltyPoints", "")
				$ExperiencePoints_LapByLap = IniRead($LapByLap_File, $SessionStage_Check & "_Name_" & $Content_Ax_bea, "LAP_" & $Schleife_Excel_2 & "_ExperiencePoints", "")
				$Time_LapByLap = IniRead($LapByLap_File, $SessionStage_Check & "_Name_" & $Content_Ax_bea, "LAP_" & $Schleife_Excel_2 & "_Time", "")

				If $RacePosition_LapByLap = "" Then $RacePosition_LapByLap = "-"
				;If $RacePosition_LapByLap = "" Then ExitLoop

				$column_Letter_from_number_1 = _Excel_ColumnToLetter($column_Letter)


				$oExcel.Columns($column_Letter_from_number_1 & ":" & $column_Letter_from_number_1).ColumnWidth = 22 ;
				$oExcel.Selection.RowHeight = 15

				_Excel_RangeWrite($var_excel_open, "LapByLap", "LAP " & $Schleife_Excel_2, "A" & $Schleife_Excel_2 + 7, true)
				_Excel_RangeWrite($var_excel_open, "LapByLap", $RacePosition_LapByLap, $column_Letter_from_number_1 & $Schleife_Excel_2 + 7, true)

				;_Excel_RangeWrite($var_excel_open, "LapByLap", $RacePosition_LapByLap, $column_Letter_from_number_1 & $Schleife_Excel_1, true)

				;If $RacePosition_LapByLap = "" Then $Schleife_Excel_2 = 50

			Next


			$NR_of_Laps = 15

			For $Schleife_Excel_2 = 0 To $NR_of_Laps
				;$column_Letter = $Schleife_Excel_2 + 1

				$RacePosition_LapByLap = IniRead($LapByLap_File, $SessionStage_Check & "_Name_" & $Content_Ax_bea, "LAP_" & $Schleife_Excel_2 & "_RacePosition", "")
				$LapTime_LapByLap = IniRead($LapByLap_File, $SessionStage_Check & "_Name_" & $Content_Ax_bea, "LAP_" & $Schleife_Excel_2 & "_LapTime", "")
				$PitStops_LapByLap = IniRead($LapByLap_File, $SessionStage_Check & "_Name_" & $Content_Ax_bea, "LAP_" & $Schleife_Excel_2 & "_PitStops", "")
				$PenaltyPoints_LapByLap = IniRead($LapByLap_File, $SessionStage_Check & "_Name_" & $Content_Ax_bea, "LAP_" & $Schleife_Excel_2 & "_PenaltyPoints", "")
				$ExperiencePoints_LapByLap = IniRead($LapByLap_File, $SessionStage_Check & "_Name_" & $Content_Ax_bea, "LAP_" & $Schleife_Excel_2 & "_ExperiencePoints", "")
				$Time_LapByLap = IniRead($LapByLap_File, $SessionStage_Check & "_Name_" & $Content_Ax_bea, "LAP_" & $Schleife_Excel_2 & "_Time", "")

				If $LapTime_LapByLap = "" Then $LapTime_LapByLap = "-"
				;If $RacePosition_LapByLap = "" Then ExitLoop

				$column_Letter_from_number_1 = _Excel_ColumnToLetter($column_Letter)


				$oExcel.Columns($column_Letter_from_number_1 & ":" & $column_Letter_from_number_1).ColumnWidth = 22 ;
				$oExcel.Selection.RowHeight = 15

				_Excel_RangeWrite($var_excel_open, "LapByLap", "LAP " & $Schleife_Excel_2, "A" & $Schleife_Excel_2 + 27, true)
				_Excel_RangeWrite($var_excel_open, "LapByLap", $LapTime_LapByLap, $column_Letter_from_number_1 & $Schleife_Excel_2 + 27, true)

				;_Excel_RangeWrite($var_excel_open, "LapByLap", $RacePosition_LapByLap, $column_Letter_from_number_1 & $Schleife_Excel_1, true)

				;If $RacePosition_LapByLap = "" Then $Schleife_Excel_2 = 50

			Next

			$column_Letter = $column_Letter + 1

		Else
			$Schleife_Excel_1 = 38
			ExitLoop
		EndIf

	Next

	#Region Cell Borders and Cell Content Alignment and AutoFit


If IsObj($oExcel) Then
	If IsObj($oWorkbook) Then

		$oWorkbook.Sheets("Results").Select
		; Variablen
		$Anzahl_Zeile_Results = $oExcel.Worksheets("Results").UsedRange.Rows.Count
		$Anzahl_Spalten_Results = $oExcel.Worksheets("Results").UsedRange.Columns.Count
		$Letzte_Zeilen_NR_Results = $Anzahl_Zeile_Results
		$Letzter_Spalten_Buchstabe_Results = _Excel_ColumnToLetter($Anzahl_Spalten_Results)

		$oWorkbook.Sheets("LapByLap").Select
		$Anzahl_Zeile_LapByLap = $oExcel.Worksheets("LapByLap").UsedRange.Rows.Count
		$Anzahl_Spalten_LapByLap = $oExcel.Worksheets("LapByLap").UsedRange.Columns.Count
		$Letzte_Zeilen_NR_LapByLap = $Anzahl_Zeile_LapByLap
		$Letzter_Spalten_Buchstabe_LapByLap = _Excel_ColumnToLetter($Anzahl_Spalten_LapByLap)

		; Cell Content Alignment
		$xlVAlignCenter = -4108

		$oWorkbook.Sheets("Results").Select
		With $oWorkbook.Sheets("Results").Range("A5:" & "A" & $Letzte_Zeilen_NR_Results)
		   .HorizontalAlignment = $xlVAlignCenter
		EndWith

		With $oWorkbook.Sheets("Results").Range("C5:" & $Letzter_Spalten_Buchstabe_Results & $Letzte_Zeilen_NR_Results)
		   .HorizontalAlignment = $xlVAlignCenter
		EndWith

		$oWorkbook.Sheets("LapByLap").Select
		With $oWorkbook.Sheets("LapByLap").Range("B6:" & $Letzter_Spalten_Buchstabe_LapByLap & 22)
		   .HorizontalAlignment = $xlVAlignCenter
		EndWith

		$oWorkbook.Sheets("LapByLap").Select
		With $oWorkbook.Sheets("LapByLap").Range("B26:" & $Letzter_Spalten_Buchstabe_LapByLap & $Letzte_Zeilen_NR_LapByLap)
		   .HorizontalAlignment = $xlVAlignCenter
		EndWith

		; Cell Borders
		Global $xlEdgeBottom = 9 ; XlBordersIndex enumeration. Border at the bottom of the range.
		Global $xlEdgeTop = 3; 3 ; XlBordersIndex enumeration. Border at the bottom of the range.
		Global $xlEdgeRight = 2 ; XlBordersIndex enumeration. Border at the bottom of the range.
		Global $xlEdgeLeft = 1; 1 ; XlBordersIndex enumeration. Border at the bottom of the range.
		Global $xlContinuous = 1 ; XlLineStyle Enumeration. Continuous line.
		Global $xlThin = 3 ; XlBorderWeight Enumeration. Continuous line. Thin line.

		;$oWorkbook.Sheets("Results").Select
		With $oWorkbook.Sheets("Results").Range("A5:" & $Letzter_Spalten_Buchstabe_Results & $Letzte_Zeilen_NR_Results).Borders($xlEdgeBottom)
			.LineStyle = $xlContinuous
			.Weight = $xlThin
			.ColorIndex = 1 ; Index value into the current color palette, or as one of the XlColorIndex constants.
		EndWith

		With $oWorkbook.Sheets("Results").Range("A5:" & $Letzter_Spalten_Buchstabe_Results & $Letzte_Zeilen_NR_Results).Borders($xlEdgeTop)
			.LineStyle = $xlContinuous
			.Weight = $xlThin
			.ColorIndex = 1 ; Index value into the current color palette, or as one of the XlColorIndex constants.
		EndWith

		With $oWorkbook.Sheets("Results").Range("A5:" & $Letzter_Spalten_Buchstabe_Results & $Letzte_Zeilen_NR_Results).Borders($xlEdgeRight)
			.LineStyle = $xlContinuous
			.Weight = $xlThin
			.ColorIndex = 1 ; Index value into the current color palette, or as one of the XlColorIndex constants.
		EndWith

		With $oWorkbook.Sheets("Results").Range("A5:" & $Letzter_Spalten_Buchstabe_Results & $Letzte_Zeilen_NR_Results).Borders($xlEdgeLeft)
			.LineStyle = $xlContinuous
			.Weight = $xlThin
			.ColorIndex = 1 ; Index value into the current color palette, or as one of the XlColorIndex constants.
		EndWith

		$oWorkbook.Sheets("LapByLap").Select
		With $oWorkbook.Sheets("LapByLap").Range("A6:" & $Letzter_Spalten_Buchstabe_LapByLap & 22).Borders($xlEdgeBottom)
			.LineStyle = $xlContinuous
			.Weight = $xlThin
			.ColorIndex = 1 ; Index value into the current color palette, or as one of the XlColorIndex constants.
		EndWith

		With $oWorkbook.Sheets("LapByLap").Range("A6:" & $Letzter_Spalten_Buchstabe_LapByLap & 22).Borders($xlEdgeTop)
			.LineStyle = $xlContinuous
			.Weight = $xlThin
			.ColorIndex = 1 ; Index value into the current color palette, or as one of the XlColorIndex constants.
		EndWith

		With $oWorkbook.Sheets("LapByLap").Range("A6:" & $Letzter_Spalten_Buchstabe_LapByLap & 22).Borders($xlEdgeRight)
			.LineStyle = $xlContinuous
			.Weight = $xlThin
			.ColorIndex = 1 ; Index value into the current color palette, or as one of the XlColorIndex constants.
		EndWith

		With $oWorkbook.Sheets("LapByLap").Range("A6:" & $Letzter_Spalten_Buchstabe_LapByLap & 22).Borders($xlEdgeLeft)
			.LineStyle = $xlContinuous
			.Weight = $xlThin
			.ColorIndex = 1 ; Index value into the current color palette, or as one of the XlColorIndex constants.
		EndWith


		With $oWorkbook.Sheets("LapByLap").Range("A26:" & $Letzter_Spalten_Buchstabe_LapByLap & $Letzte_Zeilen_NR_LapByLap).Borders($xlEdgeBottom)
			.LineStyle = $xlContinuous
			.Weight = $xlThin
			.ColorIndex = 1 ; Index value into the current color palette, or as one of the XlColorIndex constants.
		EndWith

		With $oWorkbook.Sheets("LapByLap").Range("A26:" & $Letzter_Spalten_Buchstabe_LapByLap & $Letzte_Zeilen_NR_LapByLap).Borders($xlEdgeTop)
			.LineStyle = $xlContinuous
			.Weight = $xlThin
			.ColorIndex = 1 ; Index value into the current color palette, or as one of the XlColorIndex constants.
		EndWith

		With $oWorkbook.Sheets("LapByLap").Range("A26:" & $Letzter_Spalten_Buchstabe_LapByLap & $Letzte_Zeilen_NR_LapByLap).Borders($xlEdgeRight)
			.LineStyle = $xlContinuous
			.Weight = $xlThin
			.ColorIndex = 1 ; Index value into the current color palette, or as one of the XlColorIndex constants.
		EndWith

		With $oWorkbook.Sheets("LapByLap").Range("A26:" & $Letzter_Spalten_Buchstabe_LapByLap & $Letzte_Zeilen_NR_LapByLap).Borders($xlEdgeLeft)
			.LineStyle = $xlContinuous
			.Weight = $xlThin
			.ColorIndex = 1 ; Index value into the current color palette, or as one of the XlColorIndex constants.
		EndWith


	; AutoFit Width
	$oWorkbook.Sheets("LapByLap").Range("B6:" & $Letzter_Spalten_Buchstabe_LapByLap & $Letzte_Zeilen_NR_LapByLap).Columns.AutoFit

	EndIf
EndIf

	#EndRegion Borders and Cell Content Alignment and AutoFit

	#Region Save XLS/HTML
	;$oExcel.Sheets("Results").Select
	$oWorkbook.Sheets("Results").Select

	$Status_Checkbox_Results_File_Format_XLS = IniRead($config_ini, "PC_Server", "Checkbox_Results_FileFormat_XLS", "")
	$Status_Checkbox_Results_File_Format_HTM = IniRead($config_ini, "PC_Server", "Checkbox_Results_FileFormat_HTM", "")

	Global $Results_copy_2_folder = IniRead($config_ini, "Einstellungen", "PCDSG_Stats_path", "")
	Global $Results_File_1_HTM_copy_2 = $Results_copy_2_folder & "PCDSG - Results\"

	If $Status_Checkbox_Results_File_Format_XLS = "true" Then
		If $LOG_Event_Check_auto_MSG = "true" Then
			$Message_1 = "Event Finished"
			$Message_2 = "Results saved to:"
			$Message_3 = $NowDate & "\" & $SessionStage_Check & "_" & $NowTime & ".xls"
			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_1
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_2
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_3
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
		EndIf
		;_Excel_BookSaveAs($oWorkbook, $Results_File_ServerEvents_XLS, $xlAddIn8, True)
		_Excel_BookSaveAs($oWorkbook, $Results_File_1, $xlAddIn8, True)
		$NowTime_saved = StringTrimRight( $NowTime, 3)
		FileCopy($Results_File_1, $Results_File_1_HTM_copy_2 & $SessionStage_Check & "_" & $NowTime_saved_1 & ".xls", $FC_OVERWRITE)
	EndIf

	If $Status_Checkbox_Results_File_Format_HTM = "true" Then
		If $LOG_Event_Check_auto_MSG = "true" Then
			$Message_1 = "Event Finished"
			$Message_2 = "Results saved to:"
			$Message_3 = $NowDate & "\" & $SessionStage_Check & "_" & $NowTime & ".htm"
			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_1
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_2
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
			$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_3
			$download = InetGet($URL, @ScriptDir & "\Message.txt", 16, 0)
		EndIf

		;_Excel_BookSaveAs($oWorkbook, $Results_File_ServerEvents_HTM, $xlAddIn8, True)
		_Excel_BookSaveAs($oWorkbook, $Results_File_1_HTM, $xlHtml, True)
		$NowTime_saved = StringTrimRight( $NowTime, 3)
		FileWriteLine($PCDSG_LOG_ini, "Results_saved_XLS_HTM" & "=" & $SessionStage_Check & "_" & $NowTime_saved_1 & ".htm")
		;FileCopy($Results_File_1_HTM, $Results_File_1_HTM_copy_2 & $NowDate & "\" & $SessionStage_Check & "_" & $NowTime_saved_1 & ".htm", $FC_OVERWRITE)
		;FileCopy($Results_File_Dateien_HTM, $Results_File_1_HTM_copy_2 & $NowDate & "\" & $SessionStage_Check & "_" & $NowTime_saved_1 & "-Dateien", $FC_OVERWRITE)
		;FileCopy($Results_File_Files_HTM, $Results_File_1_HTM_copy_2 & $NowDate & "\" & $SessionStage_Check & "_" & $NowTime_saved_1 & "-Files", $FC_OVERWRITE)
		;FileCopy($Results_File_Fichiers_HTM, $Results_File_1_HTM_copy_2 & $NowDate & "\" & $SessionStage_Check & "_" & $NowTime_saved_1 & "-Fichiers", $FC_OVERWRITE)

		DirCopy($Results_NowDate_Folder & "\", $Results_File_1_HTM_copy_2 & $NowDate & "\", $FC_OVERWRITE)
	EndIf

	_Excel_BookClose($oWorkbook, True)

	$Status_Checkbox_ProcessClose = IniRead($config_ini,"Einstellungen", "Force_Excel_ProcessClose", "")

	If $Status_Checkbox_ProcessClose = "true" Then
		ProcessClose("EXCEL.EXE")
	EndIf

;EndIf

#EndRegion Save XLS/HTML

EndFunc

Func _SyncFiles_Start()
If FileExists($System_Dir & "SyncFiles.exe") Then
	ShellExecute($System_Dir & "SyncFiles.exe")
Else
	ShellExecute($System_Dir & "SyncFiles.au3")
EndIf
EndFunc


Func _AutoGameAction_1()

; FairPlay MSG

$Message_Lobby_0 = "------------------------"
$Message_Lobby_1 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_1", "")
$Message_Lobby_2 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_2", "")
$Message_Lobby_3 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_3", "")
$Message_Lobby_4 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_4", "")
$Message_Lobby_5 = IniRead($RaceControl_FairPlay_INI, "FairPlayMSG", "ROW_4", "")

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

IniWrite($config_ini, "TEMP", "AutoGameMessage_1", "true")

Sleep(1000)

EndFunc

Func _AutoGameAction_2()

; Web Page Info MSG

$Message_Lobby_0 = "------------------------"
$Message_Lobby_1 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_1", "")
$Message_Lobby_2 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_2", "")
;$Message_Lobby_3 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_3", "")
$Message_Lobby_4 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_4", "")
$Message_Lobby_5 = IniRead($RaceControl_WebPageInfo_INI, "WebPageInfoMSG", "ROW_5", "")
$Message_Lobby_6 = "------------------------"

$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_0
$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_1
$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_2
$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

;$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_3
;$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_4
$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_5
$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

;$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_6
;$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

IniWrite($config_ini, "TEMP", "AutoGameMessage_2", "true")

Sleep(1000)

EndFunc

Func _AutoGameAction_3()

; Next Event Info MSG

$Message_Lobby_0 = "------------------------"
$Message_Lobby_1 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "Name", "")
$Message_Lobby_2 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "Track", "")
$Message_Lobby_3 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "Session", "")
$Message_Lobby_4 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "Date_Time", "")
;$Message_Lobby_5 = IniRead($RaceControl_NextEventInfo_INI, "NextEventInfoMSG", "Misc", "")
;$Message_Lobby_6 = "------------------------"

$Message_Lobby_1 = "" & $Message_Lobby_1
$Message_Lobby_2 = "Track: " & "          " & $Message_Lobby_2
$Message_Lobby_3 = "Session: " & "       " & $Message_Lobby_3
$Message_Lobby_4 = "Date_Time: " & "  " &  $Message_Lobby_4
;$Message_Lobby_5 = "Misc: " & "            " &  $Message_Lobby_5

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

;$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_5
;$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

;$URL = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & $Message_Lobby_6
;$download = InetGet($URL, $System_Dir & "Message.txt", 16, 0)

IniWrite($config_ini, "TEMP", "AutoGameMessage_3", "true")

Sleep(1000)

EndFunc

Func _AutoGameAction_4()

; Server Best Lap Time MSG

$Current_TrackName = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
If $Current_TrackName = "" Then $Current_TrackName = IniRead($config_ini, "TEMP", "Check_TrackName", "")

If $Current_TrackName = "" Then
	$Current_TrackID = IniRead($Server_Data_INI, "DATA", "TrackId", "")
	IniWrite($config_ini, "TEMP", "Check_Trackid", $Current_TrackID)
	;_TRACK_NAME_from_ID()
	;$Current_TrackName = IniRead($config_ini, "TEMP", "Check_TrackName", "")
	$Current_TrackName = IniRead($Server_Data_INI, "DATA", "TrackName", "")
EndIf

$NumParticipantsValid = IniRead($Server_Data_INI, "DATA", "NumParticipantsValid", "")

$Check_ServerBest_LapTime = ""
$Message_SB_1 = ""
$Message_SB_2 = ""
$Message_SB_3 = ""

$Value_CAR_NAME_Checked = ""

For $LOOP_Vehicle = 1 To $NumParticipantsValid
	$Participant_Vehicle_ID = IniRead($Participants_Data_INI, $LOOP_Vehicle, "VehicleId", "")

	IniWrite($config_ini, "TEMP", "Check_Carid", $Participant_Vehicle_ID)
	_CAR_NAME_from_ID()
	$Value_CAR_NAME = IniRead($config_ini, "TEMP", "Check_CarName", "")

	$Value_ServerBest_Name = IniRead($ServerBest_INI, $Current_TrackName & "_" & $Value_CAR_NAME, "Name", "")
	$Check_ServerBest_LapTime = IniRead($ServerBest_INI, $Current_TrackName & "_" & $Value_CAR_NAME, "LapTime", "")

	If $Value_CAR_NAME <> $Value_CAR_NAME_Checked Then
		If $Check_ServerBest_LapTime <> "" Then
			If $LOOP_Vehicle = 1 Then $Message_SB_1 = $Value_CAR_NAME & ": " & $Check_ServerBest_LapTime & " - " & "By: " & $Value_ServerBest_Name
			If $LOOP_Vehicle = 2 Then $Message_SB_2 = $Value_CAR_NAME & ": " & $Check_ServerBest_LapTime & " - " & "By: " & $Value_ServerBest_Name
			If $LOOP_Vehicle = 3 Then $Message_SB_3 = $Value_CAR_NAME & ": " & $Check_ServerBest_LapTime & " - " & "By: " & $Value_ServerBest_Name
		EndIf
	EndIf

	$Value_CAR_NAME_Checked = $Value_CAR_NAME

Next

If $Check_ServerBest_LapTime <> "" Then
	$Message_Lobby_0 = "------------------------"
	$Message_Lobby_1 = "Server Best Lap Time: " & $Current_TrackName
	$Message_Lobby_2 = $Message_SB_1
	$Message_Lobby_3 = $Message_SB_2
	$Message_Lobby_4 = $Message_SB_3

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
Else
	$Message_Lobby_0 = "------------------------"
	$Message_Lobby_1 = "No Server Best Lap Time driven"
	$Message_Lobby_2 = " "
	$Message_Lobby_3 = "Be the first one driving a new"
	$Message_Lobby_4 = "Server Best Lap Time"

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
EndIf

IniWrite($config_ini, "TEMP", "AutoGameMessage_4", "true")
Global $Next_LOOP_NR_Action_4_send = $LOOP_NR + 60
IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_4_send", $Next_LOOP_NR_Action_4_send)

Sleep(1000)

EndFunc


Func _StartRR_command()
	If Not WinExists("PCDSG TrackMap Replay") Then
		If FileExists($System_Dir & "TrackMapReplay.exe") Then
			ShellExecute($System_Dir & "TrackMapReplay.exe")
		Else
			If FileExists($System_Dir & "TrackMapReplay.au3") Then
				ShellExecute($System_Dir & "TrackMapReplay.au3")
			EndIf
		EndIf
		$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "     "
		$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
		$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "PCDSG: " & " <<< ADMIN >>>"
		$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
		$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "Replay recording started"
		$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
		$URL_Admin_MSG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/send_chat?message=" & "     "
		$download = InetGet($URL_Admin_MSG, @ScriptDir & "\Message.txt", 16, 0)
	EndIf
EndFunc


Func _Delete_PP()
	FileDelete($Points_ini)
	FileWriteLine($Points_ini, "[DATA]")
	FileWriteLine($Points_ini, "NR=0")
	FileWriteLine($PCDSG_LOG_ini, "Delete_PP_" & $NowTime & "=" & "Delete_PP")
EndFunc

Func _Delete_PitStops()
	FileDelete($Info_PitStops_ini)
	FileWriteLine($Info_PitStops_ini, "[PitStops]")
	FileWriteLine($Info_PitStops_ini, "NR=0")
	FileWriteLine($PCDSG_LOG_ini, "Delete_PitStops_" & $NowTime & "=" & "Delete_PitStops")
EndFunc

Func _Delete_CutTrack()
	FileDelete($CutTrack_ini)
	FileWriteLine($Points_ini, "[DATA]")
	FileWriteLine($Points_ini, "NR=0")
	FileWriteLine($PCDSG_LOG_ini, "Delete_CutTrack_" & $NowTime & "=" & "Delete_CutTrack")
EndFunc

Func _Delete_Impact()
	FileDelete($Impact_ini)
	FileWriteLine($Points_ini, "[DATA]")
	FileWriteLine($Points_ini, "NR=0")
	FileWriteLine($PCDSG_LOG_ini, "Delete_Impact_" & $NowTime & "=" & "Delete_Impact")
EndFunc

Func _Delete_LapByLap_INI()
	FileDelete($LapByLap_File)
	FileWrite($LapByLap_File, "")
	FileWriteLine($PCDSG_LOG_ini, "Delete_LapByLap_INI_" & $NowTime & "=" & "Delete_LapByLap_INI")
EndFunc

Func _Delete_Results_INI()
	FileDelete($Results_INI)
	FileWrite($Results_INI, "")
	FileWriteLine($PCDSG_LOG_ini, "Delete_Results_INI_" & $NowTime & "=" & "Delete_Results_INI")
EndFunc

Func _Empy_Temp_1()
IniWrite($config_ini, "TEMP", "Results_saved_TrackName", "")
IniWrite($config_ini, "TEMP", "Results_saved_SessionStage", "")
IniWrite($config_ini, "TEMP", "AutoLobbyMessage_1", "")
IniWrite($config_ini, "TEMP", "AutoLobbyMessage_2", "")
IniWrite($config_ini, "TEMP", "AutoLobbyMessage_3", "")
EndFunc

Func _Empy_Temp_2()
IniWrite($config_ini, "TEMP", "Results_saved_TrackName", "")
IniWrite($config_ini, "TEMP", "Results_saved_SessionStage", "")
IniWrite($config_ini, "TEMP", "AutoLobbyMessage_1", "")
IniWrite($config_ini, "TEMP", "AutoLobbyMessage_2", "")
IniWrite($config_ini, "TEMP", "AutoLobbyMessage_3", "")
IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_1_send", "")
IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_2_send", "")
IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_3_send", "")
IniWrite($config_ini, "TEMP", "Next_LOOP_NR_Action_4_send", "")

IniWrite($config_ini, "TEMP", "Seconds_to_Time", "")
IniWrite($config_ini, "TEMP", "Ping", "")
IniWrite($config_ini, "TEMP", "KICK_User", "")
IniWrite($config_ini, "TEMP", "AM_Command", "")
IniWrite($config_ini, "TEMP", "Wert_Check_Refid", "")
IniWrite($config_ini, "TEMP", "Wert_Check_Name", "")
IniWrite($config_ini, "TEMP", "Check_Trackid", "")
IniWrite($config_ini, "TEMP", "Check_TrackName", "")
IniWrite($config_ini, "TEMP", "Log_Index_NR", "")
IniWrite($config_ini, "PC_Server", "Session_Stage", "Lobby")
IniWrite($config_ini, "Server_Einstellungen", "CurrentTrackName", "")

IniWrite($DS_Status_ini, "Log_Session_Status", "Practice1_LogIndex_Start", "")
IniWrite($DS_Status_ini, "Log_Session_Status", "Practice1_LogIndex_End", "")
IniWrite($DS_Status_ini, "Log_Session_Status", "Practice2_LogIndex_Start", "")
IniWrite($DS_Status_ini, "Log_Session_Status", "Practice2_LogIndex_End", "")
IniWrite($DS_Status_ini, "Log_Session_Status", "Qualifying_LogIndex_Start", "")
IniWrite($DS_Status_ini, "Log_Session_Status", "Qualifying_LogIndex_End", "")
IniWrite($DS_Status_ini, "Log_Session_Status", "Warmup_LogIndex_Start", "")
IniWrite($DS_Status_ini, "Log_Session_Status", "Warmup_LogIndex_End", "")
IniWrite($DS_Status_ini, "Log_Session_Status", "Race1_LogIndex_Start", "")
IniWrite($DS_Status_ini, "Log_Session_Status", "Race1_LogIndex_End", "")

FileDelete($LapByLap_File)
FileDelete($Results_INI)

FileDelete($Members_Data_INI)
FileDelete($Participants_Data_INI)
FileDelete($Participants_Data_INI_TEMP)
FileDelete($Participants_Data_INI_TEMP_Check_1)
FileDelete($Participants_Data_INI_TEMP_Check_2)
FileDelete($Participants_Data_INI_CR_1)
FileDelete($Participants_Data_INI_CR_2)
EndFunc

Func _Excel_Exists_Check()

$Check_Excel_Version = IniRead($config_ini, "Einstellungen", "Excel_version", "")

If $Check_Excel_Version = "" Then
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

	If $Installierte_Excel_Version = "" Then MsgBox(4144, "", "Could not found MS Excel Installation." & @CRLF & @CRLF & _
																"MS Excel needs to be installed to be able to use XLS or HTML File creation function." & @CRLF & @CRLF & _
																"Use TXT or INI File instead of XLS and HTML if you don't have MS Excel.")

	IniWrite($config_ini, "Einstellungen", "Excel_version", $Installierte_Excel_Version)
	;Exit
EndIf
EndFunc

Func _Lap_Time_convert()
; Last Lap Time formatieren
	$iMs = $Value_LapByLap_Time
	If $iMs = "" Then $Value_LapByLap_Time = IniRead($config_ini, "TEMP", "Seconds_to_Time", "")
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
	$Value_LapByLap_Time = $LastLapTime_Wert
	IniWrite($config_ini, "TEMP", "Seconds_to_Time", $Value_LapByLap_Time)
EndFunc


Exit
