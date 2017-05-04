#include <FileConstants.au3>
#include <Date.au3>
#include <File.au3>

#Region Declare Variables/Const
Global $config_ini = @ScriptDir & "\config.ini"
Global $install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
Global $System_Dir = $install_dir & "system\"
Global $gfx = $System_Dir & "gfx\"
Global $Data_Dir = $install_dir & "data\"
Global $DB_path = $System_Dir & "Database.sqlite"
Global $Sprachdatei = IniRead($config_ini,"Einstellungen", "Sprachdatei", "")
Global $PCDSG_Status_File = $System_Dir & "PCDSG_Status.txt"
Global $PCDSG_Status = IniRead($config_ini,"PC_Server", "Status", "")
Global $PCDSG_LOG_ini = $System_Dir & "PCDSG_LOG.ini"

; Quelle
Global $PCDSG_Status_picture_online = $gfx & "PCDSG_online.jpg"
Global $PCDSG_Status_picture_offline = $gfx & "PCDSG_offline.jpg"

Global $Server_Data_INI = $System_Dir & "Server_Data.ini"
Global $Members_Data_INI = $System_Dir & "Members_Data.ini"
Global $Participants_Data_INI = $System_Dir & "Participants_Data.ini"
Global $LOG_Data_INI = @ScriptDir & "\Server_LOG.ini"
Global $UserHistory_Data_INI = $System_Dir & "UserHistory.ini"
Global $Points_ini = $System_Dir & "Points.ini"
Global $PitStops_ini = $System_Dir & "PitStops.ini"
Global $CutTrack_ini = $System_Dir & "CutTrack.ini"
Global $Impact_ini = $System_Dir & "Impact.ini"
Global $Stats_ini = $System_Dir & "Stats.ini"
Global $ServerBest_INI = $System_Dir & "ServerBest.ini"
Global $Results_ini = $System_Dir & "Results.ini"

Global $TrackList_TXT = $System_Dir & "TrackList.txt"
Global $VehicleList_TXT = $System_Dir & "VehicleList.txt"

Global $TrackMap_JPG = $System_Dir & "TrackMap\TrackMap.jpg"

; Ziel
Global $Stats_copy_2_folder = IniRead($config_ini, "Einstellungen", "PCDSG_Stats_path", "")
Global $Results_copy_2_folder = IniRead($config_ini, "Einstellungen", "PCDSG_Stats_path", "")

Global $PCDSG_Status_picture_online_copy_2_folder = $Stats_copy_2_folder & "PCDSG - Images\" & "PCDSG_Status.jpg"
Global $PCDSG_Status_picture_offline_copy_2_folder = $Stats_copy_2_folder & "PCDSG - Images\" & "PCDSG_Status.jpg"

Global $DB_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "Database.sqlite"
Global $Server_Data_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "Server_Data.ini"
Global $Members_Data_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "Members_Data.ini"
Global $Participants_Data_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "Participants_Data.ini"
Global $UserHistory_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "UserHistory.ini"
Global $Stats_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "Stats.ini"
Global $ServerBest_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "ServerBest.ini"
Global $Server_LOG_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "Server_LOG.ini"
Global $PitStops_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "PitStops.ini"
Global $TrackList_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "TrackList.ini"
Global $VehicleList_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "VehicleList.ini"
Global $Points_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "Points.ini"
Global $CutTrack_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "CutTrack.ini"
Global $Impact_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "Impact.ini"
Global $Results_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "Results.ini"
Global $PCDSG_Status_File_copy_2 = $Stats_copy_2_folder & "PCDSG - Stats\" & "PCDSG_Status.txt"
Global $TrackMap_JPG_copy_2 = $Stats_copy_2_folder & "PCDSG - Images\" & "TrackMap.jpg"
Global $TrackMap_2_JPG_copy_2 = "W:\PCDSGwiki\data\media\pictures\" & "trackmap.jpg"

Global $NowDate_Value = _NowDate()
Global $NowDate = StringReplace($NowDate_Value, "/", ".")
Global $NowTime_Value = _NowTime()
Global $NowTime_orig = $NowTime_Value
Global $NowTime = StringReplace($NowTime_Value, ":", "-")

Global $Check_TrackName_Value = IniRead($config_ini, "TEMP", "Results_saved_TrackName", "")
#endregion Declare Variables/Const

If $Stats_copy_2_folder <> "" Then
	_Start_File_Sync()
EndIf


Func _Start_File_Sync()
	_Copy_Pictures()
	_Create_PCDSG_Status_Info()
	_Copy_Stats_Files()
	_Copy_Results_Folders()
EndFunc


Func _Copy_Pictures()
	Global $PCDSG_Status = IniRead($config_ini,"PC_Server", "Status", "")
	If $PCDSG_Status <> "PC_Server_beendet" Then
		FileCopy($PCDSG_Status_picture_online, $PCDSG_Status_picture_online_copy_2_folder, $FC_OVERWRITE + $FC_CREATEPATH)
		FileCopy($TrackMap_JPG, $TrackMap_JPG_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
		FileCopy($TrackMap_JPG, $TrackMap_2_JPG_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	Else
		FileCopy($PCDSG_Status_picture_offline, $PCDSG_Status_picture_offline_copy_2_folder, $FC_OVERWRITE + $FC_CREATEPATH)
	EndIf
EndFunc

Func _Create_PCDSG_Status_Info()
	Global $PCDSG_Server_State = IniRead($config_ini,"PC_Server", "Server_State", "")
	Global $PCDSG_DS_Server_Name = IniRead($Server_Data_INI,"DATA", "name", "")
	Global $PCDSG_SessionState = IniRead($Server_Data_INI,"DATA", "SessionState", "")
	Global $PCDSG_SessionStage = IniRead($Server_Data_INI,"DATA", "SessionStage", "")
	Global $PCDSG_SessionTimeElapsed = IniRead($Server_Data_INI,"DATA", "SessionTimeElapsed", "")

	If FileExists($PCDSG_Status_File) Then
		$EmptyFile = FileOpen($PCDSG_Status_File, 2)
		FileWrite($PCDSG_Status_File, "")
		FileClose($PCDSG_Status_File)
	EndIf

	If $PCDSG_Status = "PC_Server_beendet" Then $PCDSG_Status = "PCDSG offline"

	FileWriteLine($PCDSG_Status_File, "Server Status:" & @TAB & $PCDSG_Server_State)
	FileWriteLine($PCDSG_Status_File, "DS Server Name:" & @TAB & $PCDSG_DS_Server_Name)
	FileWriteLine($PCDSG_Status_File, "Session State:" & @TAB & $PCDSG_SessionState)
	FileWriteLine($PCDSG_Status_File, "Session Stage:" & @TAB & $PCDSG_SessionStage)
	FileWriteLine($PCDSG_Status_File, "Time Elapsed:" & @TAB & $PCDSG_SessionTimeElapsed)
EndFunc

Func _Copy_Stats_Files()
	FileCopy($DB_path, $DB_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($Server_Data_INI, $Server_Data_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($LOG_Data_INI, $Server_LOG_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($Members_Data_INI, $Members_Data_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($Participants_Data_INI, $Participants_Data_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($UserHistory_Data_INI, $UserHistory_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($Stats_ini, $Stats_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($ServerBest_INI, $ServerBest_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($PitStops_ini, $PitStops_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($TrackList_TXT, $TrackList_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($VehicleList_TXT, $VehicleList_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($Points_ini, $Points_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($CutTrack_ini, $CutTrack_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($Impact_ini, $Impact_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($Results_ini, $Results_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
	FileCopy($PCDSG_Status_File, $PCDSG_Status_File_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
EndFunc

Func _Copy_Results_Folders()

EndFunc

Exit


