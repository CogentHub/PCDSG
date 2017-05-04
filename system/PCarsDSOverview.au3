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

Global $ListView, $ListView_Produktinformationen, $iMemo_unten, $idTreeView, $Statusbar, $GUI, $id_Projekt, $iwParam
Global $Func_Neuen_Ordner_erstellen_ausgefuert, $Verzeichnisse_aktualisieren_ausgefuert, $Verzeichnis_Produkte, $Aufnahme_lauft_icon
Global $status_json, $LOG_Data_json, $Server_Data_INI, $Members_Data_INI, $Participants_Data_INI, $Info_drivers_AT_ini, $LOG_Data_INI
Global $Anzahl_Werte_LOG, $Schleife_ListView_aktualisieren, $Seconds_to_Time, $iRetH, $iRetM, $iRetS, $iSec, $Wert_Time
Global $Wert_Track_ID, $Wert_Car, $Wert_Tack, $Wert_Wert
Global $Wert_Points, $Wert_PP_Points, $Wert_Experience_Points, $Wert_Experience_Points_NEW
Global $Wert_Check_refid, $LOG_Name_from_refid
Global $asRead, $asRead2

Opt("GUIOnEventMode", 1)
Opt("GUIDataSeparatorChar", "|")

$ListViewSeperator = "|"

#Region Declare Variables/Const
Global $config_ini = (@ScriptDir & "\" & "config.ini")
Global $install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
Global $System_Dir = $install_dir & "system\"
Global $Data_Dir = $install_dir & "data\"
Global $PCarsDSOverview_Dir = $install_dir & "system\PCarsDSOverview\"
Global $PCarsDSOverview_participants_json = $PCarsDSOverview_Dir & "PCarsDSOverview_participants_Data.json"
Global $PCarsDSOverview_participants_INI = $PCarsDSOverview_Dir & "PCarsDSOverview_participants_Data.ini"
Global $PCarsDSOverview_Server_LOG_json = $PCarsDSOverview_Dir & "Server_LOG.json"
Global $PCarsDSOverview_Server_LOG_INI = $PCarsDSOverview_Dir & "Server_LOG.ini"
Global $PCarsDSOverview_INI = $PCarsDSOverview_Dir & "PCarsDSOverview.ini"

Global $RaceControl_folder = $System_Dir & "RaceControl\"
Global $RaceControl_NextEventInfo_INI = $RaceControl_folder & "NextEventInfo.ini"
Global $RaceControl_WebPageInfo_INI = $RaceControl_folder & "WebPageInfo.ini"
Global $RaceControl_FairPlay_INI = $RaceControl_folder & "FairPlay.ini"
Global $Info_PitStops_ini = $install_dir & "system\PitStops.ini"
Global $Points_ini = $install_dir & "system\Points.ini"
Global $Stats_INI = $System_Dir & "Stats.ini"
Global $KICK_BAN_TXT = $install_dir & "system\KICK_BAN.txt"
Global $Sprachdatei = IniRead($config_ini,"Einstellungen", "Sprachdatei", "")

Global $Whitelist_File = $install_dir & "whitelist.cfg"
Global $Blacklist_File = $install_dir & "blacklist.cfg"

Global $status_json = @ScriptDir & "\status.json"
Global $LOG_Data_json = @ScriptDir & "\Server_LOG.json"
Global $Server_Data_INI = @ScriptDir & "\" & "Server_Data.ini"
Global $Members_Data_INI = @ScriptDir & "\" & "Members_Data.ini"
Global $Participants_Data_INI = @ScriptDir & "\" & "Participants_Data.ini"
Global $UserHistory_ini = @ScriptDir & "\" & "UserHistory.ini"
Global $LOG_Data_INI = @ScriptDir & "\Server_LOG.ini"

$gfx = (@ScriptDir & "\" & "gfx\")


$ListView_RM_1 = IniRead($Sprachdatei,"Language", "ListView_RM_1", "Open Steam Profile")
$ListView_RM_2 = IniRead($Sprachdatei,"Language", "ListView_RM_2", "Show info for this drivers")
$ListView_RM_3 = ""
$ListView_RM_4 = IniRead($Sprachdatei,"Language", "ListView_RM_4", "KICK")
$ListView_RM_5 = IniRead($Sprachdatei,"Language", "ListView_RM_5", "BAN [10 minutes]")
$ListView_RM_6 = IniRead($Sprachdatei,"Language", "ListView_RM_6", "BAN [1 hour]")
$ListView_RM_7 = IniRead($Sprachdatei,"Language", "ListView_RM_7", "BAN [24 hour]")
$ListView_RM_8 = IniRead($Sprachdatei,"Language", "ListView_RM_8", "BAN [48 hour]")

$Infos_view_pb_Label_Column_1 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_1", "Name")
$Infos_view_pb_Label_Column_2 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_2", "Grid Pos.")
$Infos_view_pb_Label_Column_3 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_3", "Car")
$Infos_view_pb_Label_Column_4 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_4", "Pos.")
$Infos_view_pb_Label_Column_5 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_5", "In LAP")
$Infos_view_pb_Label_Column_6 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_6", "In Sector")
$Infos_view_pb_Label_Column_7 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_7", "Sector 1")
$Infos_view_pb_Label_Column_8 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_8", "Sector 2")
$Infos_view_pb_Label_Column_9 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_9", "Sector 3")
$Infos_view_pb_Label_Column_10 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_10", "Last Lap")
$Infos_view_pb_Label_Column_11 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_11", "Fastest Lap")
$Infos_view_pb_Label_Column_12 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_12", "State")
$Infos_view_pb_Label_Column_13 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_13", "Pit")
$Infos_view_pb_Label_Column_14 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_14", "Poi")
$Infos_view_pb_Label_Column_15 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_15", "War")

$Infos_view_pb_Button_1 = IniRead($Sprachdatei,"Language", "Info_view_PB_Button_1", "")
$Infos_view_pb_Button_2 = IniRead($Sprachdatei,"Language", "Info_view_PB_Button_2", "")

$Infos_view_pb_Button_9 = IniRead($Sprachdatei,"Language", "Info_view_PB_Button_9", "")

$Infos_view_pb_Radio_1 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Radio_1", "")
$Infos_view_pb_Radio_2 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Radio_2", "")

$msgbox_26 = IniRead($Sprachdatei,"Language", "msgbox_26", "Automatic saving and updating of the Auto STAT Date will be stopped.")
$msgbox_27 = IniRead($Sprachdatei,"Language", "msgbox_27", "This may take up to 15 seconds.")


$Infos_view_drivers_AT_Label_1 = IniRead($Sprachdatei,"Language", "Infos_view_drivers_AT_Label_1", "")
$Infos_view_drivers_AT_Label_2 = IniRead($Sprachdatei,"Language", "Infos_view_drivers_AT_Label_2", "")
$Infos_view_drivers_AT_Label_3 = IniRead($Sprachdatei,"Language", "Infos_view_drivers_AT_Label_3", "")

$Info_Drivers_AT_Button_1 = IniRead($Sprachdatei,"Language", "Info_Drivers_AT_Button_1", "")
$Info_Drivers_AT_Button_2 = IniRead($Sprachdatei,"Language", "Info_Drivers_AT_Button_2", "")
$Info_Drivers_AT_Button_3 = IniRead($Sprachdatei,"Language", "Info_Drivers_AT_Button_3", "")
$Info_Drivers_AT_Button_9 = IniRead($Sprachdatei,"Language", "Info_Drivers_AT_Button_9", "")

$msgbox_16 = IniRead($Sprachdatei,"Language", "msgbox_16", "Do you realy want to add this Steam ID")
$msgbox_17 = IniRead($Sprachdatei,"Language", "msgbox_17", "to the Whietelist")
$msgbox_18 = IniRead($Sprachdatei,"Language", "msgbox_18", "Do you realy want to add this Steam ID")
$msgbox_19 = IniRead($Sprachdatei,"Language", "msgbox_19", "to the Blacklist")
$msgbox_24 = IniRead($Sprachdatei,"Language", "msgbox_24", "Delete Drivers AT list")
$msgbox_25 = IniRead($Sprachdatei,"Language", "msgbox_25", "Do you really want to delete the complete list?")
$msgbox_26 = IniRead($Sprachdatei,"Language", "msgbox_26", "Automatic saving and updating of the Auto STAT Date will be stopped.")
$msgbox_27 = IniRead($Sprachdatei,"Language", "msgbox_27", "This may take up to 15 seconds.")
$msgbox_28 = IniRead($Sprachdatei,"Language", "msgbox_28", "Delete LOG File")
$msgbox_29 = IniRead($Sprachdatei,"Language", "msgbox_29", "Do you really want to delete the complete File?")
$msgbox_30 = IniRead($Sprachdatei,"Language", "msgbox_30", "Save LOG File")
$msgbox_31 = IniRead($Sprachdatei,"Language", "msgbox_31", "Do you really want to save the complete list?")
$msgbox_32 = IniRead($Sprachdatei,"Language", "msgbox_32", "Delete Pit Stop File")
$msgbox_33 = IniRead($Sprachdatei,"Language", "msgbox_33", "Do you really want to delete the Pit Stop File?")
$msgbox_34 = IniRead($Sprachdatei,"Language", "msgbox_34", "Delete PP and EP Points")
$msgbox_35 = IniRead($Sprachdatei,"Language", "msgbox_35", "Do you really want to delete Penalty and Expirience Points File?")
$msgbox_36 = IniRead($Sprachdatei,"Language", "msgbox_36", "It will save the Results from the Log between the following Index Numbers:")
#endregion Declare Variables/Const

#region GUI Erstellen
	Local $hGUI, $hGraphic, $hPen
	Local $GUI, $aSize, $aStrings[5]
	Local $btn, $chk, $rdo, $Msg
	Local $GUI_List_Auswahl, $tu_Button0, $to_button1, $to_button2, $to_button3, $to_button4
	Local $Wow64 = ""
	If @AutoItX64 Then $Wow64 = "\Wow6432Node"
	Local $sPath = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $Wow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\Examples\GUI\Advanced\Images"

	$Check_TaskBarPos = IniRead($config_ini, "TEMP", "TaskBarPos", "")
	$GUI_Y_POS = 0
	If $Check_TaskBarPos = "A" Then $GUI_Y_POS = 40
	If $Check_TaskBarPos = "B" Then $GUI_Y_POS = 0
	If $Check_TaskBarPos = "" Then $GUI_Y_POS = 0

	$GUI = GUICreate("PCars: Dedicated Server Overview", 1080, 1010, -1, $GUI_Y_POS)
	$Anzeige_Fortschrittbalken = GUICtrlCreateProgress(0, 984, 1080, 5)
	$Statusbar = _GUICtrlStatusBar_Create($GUI)
	_GUICtrlStatusBar_SetSimple($Statusbar, True)

	GUISetState()

$Linie_oben = GUICtrlCreatePic($gfx & "Hintergrund.jpg", 0, 178, 1080, 2, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
$Linie_mitte = GUICtrlCreatePic($gfx & "Hintergrund.jpg", 0, 632, 1080, 2, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))

Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

If $Lesen_Auswahl_httpApiInterface = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"

$font = "Comic Sans MS"
$font_2 = "Arial"

GUICtrlCreateGroup("Server Status", 3, 35, 1073, 50)
	GUICtrlSetFont(-1, 13, 400, 1, $font_2)
GUICtrlCreateGroup("Event Settings", 3, 97, 530, 75)
	GUICtrlSetFont(-1, 13, 400, 1, $font_2)
GUICtrlCreateGroup("Server Infos", 546, 97, 530, 75)
	GUICtrlSetFont(-1, 13, 400, 1, $font_2)
GUICtrlCreateGroup("User History", 3, 649, 435, 301)
	GUICtrlSetFont(-1, 13, 400, 1, $font_2)
GUICtrlCreateGroup("Server LOG", 446, 649, 630, 301)
	GUICtrlSetFont(-1, 13, 400, 1, $font_2)


GUICtrlCreateLabel("Name:", 205, 3, 55, 23)
GUICtrlSetFont(-1, 14, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "name", "")
$Server_Name = $Wert
$Label_Wert_Server_Name = GUICtrlCreateLabel($Wert, 265, 5, 315, 23)
GUICtrlSetFont(-1, 14, 400, 1, $font_2)
GUICtrlSetColor(-1, $COLOR_BLUE)

GUICtrlCreateLabel("State:", 10, 53, 45, 23)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "state", "")
$Server_Status = $Wert
If $Server_Status = "" Then $Server_Status = "OFFLINE"
$Check_Lobby = IniRead($Server_Data_INI, "DATA", "SessionState", "")
If $Check_Lobby = "Lobby" Then $Server_Status = "Lobby"
$Label_Wert_Server_State = GUICtrlCreateLabel($Server_Status, 65, 58, 120, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)
If $Check_Lobby = "Lobby" Then GUICtrlSetColor($Label_Wert_Server_State, $COLOR_GREEN)

GUICtrlCreateLabel("Track:", 695, 3, 55, 30)
GUICtrlSetFont(-1, 14, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "TrackId", "")
$Wert_Tack = $Wert
$Wert_Track = IniRead($Server_Data_INI, "DATA", "TrackName", "")
$Label_Wert_Track = GUICtrlCreateLabel("", 755, 5, 315, 23)
GUICtrlSetFont(-1, 14, 400, 1, $font_2)
GUICtrlSetColor(-1, $COLOR_BLUE)

GUICtrlCreateLabel("Players:", 215, 53, 60, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert_1 = IniRead($Server_Data_INI, "DATA", "NumParticipantsValid", "")
$Wert_2 = IniRead($Server_Data_INI, "DATA", "max_member_count", "")
If $Wert_1 < 10 Then $Wert_1 = "0" & $Wert_1
If $Wert_2 < 10 Then $Wert_1 = "0" & $Wert_2
$Wert = $Wert_1 & "/" & $Wert_2
If $Wert = "0/" Then $Wert = ""
If $Wert = "00/0" Then $Wert = ""
$Label_Wert_NR_Players = GUICtrlCreateLabel($Wert, 280, 58, 120, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel("Session:", 415, 53, 60, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
$Wert_Session = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
$Label_Wert_Session = GUICtrlCreateLabel($Wert, 485, 58, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel("Time:", 635, 53, 55, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert_1 = IniRead($Server_Data_INI, "DATA", "SessionTimeElapsed", "")
If $Wert_Session = "Practice1" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "Practice1Length", "")
If $Wert_Session = "Practice2" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "Practice2Length", "")
If $Wert_Session = "Qualifying" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "QualifyLength", "")
If $Wert_Session = "Warmup" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "WarmupLength", "")
If $Wert_Session = "Race1" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "Race1Length", "")
If $Wert_Session = "Race2" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "Race2Length", "")

$Wert_Duration = IniRead($Server_Data_INI, "DATA", "SessionTimeDuration", "")

$Wert = $Wert_1 & "/" & $Wert_2

If $Wert = " / " Then $Wert = ""
If $Wert = "0/0" Then $Wert = ""
If $Wert = "0/" Then $Wert = ""
If $Wert = "/0" Then $Wert = ""

If $Wert = " / " Then $Wert = ""
If $Wert = "00:00 / 00:00" Then $Wert = ""
If $Wert = "00:00 / 0:00" Then $Wert = ""
If $Wert = "00:00/0" Then $Wert = ""

$Label_Wert_Time = GUICtrlCreateLabel($Wert, 685, 58, 120, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel("Practice1:", 10, 115, 75, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "Practice1Length", "")
If $Wert = "0" Then $Wert = ""
If $Wert <> "" Then $Wert = $Wert & " min"
$Label_Wert_Practice1 = GUICtrlCreateLabel($Wert, 90, 120, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel("Practice2:", 10, 138, 75, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "Practice2Length", "")
If $Wert = "0" Then $Wert = ""
If $Wert <> "" Then $Wert = $Wert & " min"
$Label_Wert_Practice2 = GUICtrlCreateLabel($Wert, 90, 143, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel("Qualifying:", 195, 115, 85, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "QualifyLength", "")
If $Wert = "0" Then $Wert = ""
If $Wert <> "" Then $Wert = $Wert & " min"
$Label_Wert_Qualifying = GUICtrlCreateLabel($Wert, 285, 120, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel("Warm Up:", 195, 138, 75, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "WarmupLength", "")
If $Wert = "0" Then $Wert = ""
If $Wert <> "" Then $Wert = $Wert & " Laps"
$Label_Wert_WarmUp = GUICtrlCreateLabel($Wert, 285, 143, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel("Race 1:", 380, 115, 55, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "Race1Length", "")
If $Wert = "0" Then $Wert = ""
If $Wert <> "" Then $Wert = $Wert & " Laps"
$Label_Wert__Race1 = GUICtrlCreateLabel($Wert, 440, 120, 80, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel("Race 2:", 380, 138, 55, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "Race2Length", "")
If $Wert = "0" Then $Wert = ""
If $Wert <> "" Then $Wert = $Wert & " Laps"
$Label_Wert__Race2 = GUICtrlCreateLabel($Wert, 440, 143, 80, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

$Wert_Timestamp = IniRead($Server_Data_INI, "DATA", "now", "")
$timestamp = _NowDate() & " - " & _NowTime()

; Server Infos Group
GUICtrlCreateLabel("Session Phase:", 553, 115, 110, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "SessionPhase", "")
	If $Wert = "0" Then $Wert = ""
$Label_Wert_SessionPhase = GUICtrlCreateLabel($Wert, 670, 120, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel("#Racers Valid:", 553, 138, 110, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "NumParticipantsValid", "")
	If $Wert = "0" Then $Wert = ""
$Label_Wert_Racers_Valid = GUICtrlCreateLabel($Wert, 670, 143, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel("#Racers Disqual.:", 725, 115, 150, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "NumParticipantsDisqualified", "")
	If $Wert = "0" Then $Wert = ""
$Label_Wert_Racers_Disqual = GUICtrlCreateLabel($Wert, 860, 120, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel("#Racers Retired:", 725, 138, 150, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "NumParticipantsRetired", "")
	If $Wert = "0" Then $Wert = ""
$Label_Wert_Racers_Retired = GUICtrlCreateLabel($Wert, 860, 143, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel("#Racers DNF:", 910, 115, 150, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "NumParticipantsDNF", "")
	If $Wert = "0" Then $Wert = ""
$Label_Wert_Racers_DNF = GUICtrlCreateLabel($Wert, 1047, 120, 25, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel("#Racers Finished:", 910, 138, 150, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($Server_Data_INI, "DATA", "NumParticipantsFinished", "")
	If $Wert = "0" Then $Wert = ""
$Label_Wert_Racers_Finished = GUICtrlCreateLabel($Wert, 1047, 143, 25, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)


Global $Button6 = GUICtrlCreateButton("Save Stat Results XLS", 2, 593, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($Button6, $gfx & "Save_XLS.bmp")
GuiCtrlSetTip(-1, "Save Results as XLS File.")

Global $Button7 = GUICtrlCreateButton("Save Stat Results", 42, 593, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($Button7, $gfx & "Save_TXT.bmp")
GuiCtrlSetTip(-1, "Save Results as TXT File.")

$Status_Radio_1 = IniRead($config_ini,"PC_Server", "AutoStat_Save_Radio_1", "")
$Status_Radio_2 = IniRead($config_ini,"PC_Server", "AutoStat_Save_Radio_2", "")

$Sprache = ""
If $Sprachdatei = $install_dir & "system\language\DE.ini" Then $Sprache = "DE"

$Radio_POS_X_2 = 300
If $Sprache = "DE" Then $Radio_POS_X = 520
If $Sprache = "DE" Then $Radio_POS_X_2 = 335

Global $Button0 = GUICtrlCreateButton("Delete Participants ListView", 1042, 593, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($Button0, $gfx & "Delete.bmp")
GuiCtrlSetTip(-1, "Delete Participants Results List View.")

Global $listview = GUICtrlCreateListView("", 0, 180, 1079, 408, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))

_GUICtrlListView_SetExtendedListViewStyle($listview, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_DOUBLEBUFFER))
_GUICtrlStatusBar_SetSimple($Statusbar, True)
GUISetState()

; Add columns
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_1, 140) ; Name
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_2, 40) ; Grid Pos.
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_3, 140) ; Car
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_4, 35) ; Pos.
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_5, 35) ; In Lap
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_6, 60) ; In Sector
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_7, 70) ; Sector 1
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_8, 70) ; Sector 2
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_9, 70) ; Sector 3
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_10, 80) ; Last Lap
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_11, 105) ; Fastest Lap Time
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_12, 80) ; State
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_13, 30) ; Pit Stops
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_14, 35) ; Points
_GUICtrlListView_AddColumn($listview, $Infos_view_pb_Label_Column_15, 60) ; Warnings

_GUICtrlListView_AddItem($listview, "", "")
_GUICtrlListView_AddSubItem($ListView, 0, "", 1)
_GUICtrlListView_AddSubItem($ListView, 1, "", 2)
_GUICtrlListView_AddSubItem($ListView, 2, "", 3)
_GUICtrlListView_AddSubItem($ListView, 3, "", 4)
_GUICtrlListView_AddSubItem($ListView, 4, "", 5)
_GUICtrlListView_AddSubItem($ListView, 5, "", 6)
_GUICtrlListView_AddSubItem($ListView, 6, "", 7)
_GUICtrlListView_AddSubItem($ListView, 7, "", 8)
_GUICtrlListView_AddSubItem($ListView, 8, "", 9)
_GUICtrlListView_AddSubItem($ListView, 9, "", 10)
_GUICtrlListView_AddSubItem($ListView, 10, "", 11)
_GUICtrlListView_AddSubItem($ListView, 11, "", 12)
_GUICtrlListView_AddSubItem($ListView, 12, "", 13)
_GUICtrlListView_AddSubItem($ListView, 13, "", 14)


Global $listview_drivers_AT = GUICtrlCreateListView("", 7, 668, 427, 237, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))

_GUICtrlListView_SetExtendedListViewStyle($listview_drivers_AT, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_DOUBLEBUFFER))
_GUICtrlStatusBar_SetSimple($Statusbar, True)
GUISetState()

_GUICtrlListView_AddColumn($listview_drivers_AT, "Name", 130)
_GUICtrlListView_AddColumn($listview_drivers_AT, "Steam ID", 115)
_GUICtrlListView_AddColumn($listview_drivers_AT, "Added 'Date - Time'", 120)
_GUICtrlListView_AddColumn($listview_drivers_AT, "Ping", 40)

Global $UH_Button2 = GUICtrlCreateButton("ADD to Whitelist", 7, 910, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($UH_Button2, $gfx & "ADD_2_Whitelist.bmp")
GuiCtrlSetTip(-1, $Info_Drivers_AT_Button_2)

Global $UH_Button3 = GUICtrlCreateButton("ADD to Blacklist", 47, 910, 35, 35, $BS_BITMAP) ; 57, 910,
_GUICtrlButton_SetImage($UH_Button3, $gfx & "ADD_2_Blacklist.bmp")
GuiCtrlSetTip(-1, $Info_Drivers_AT_Button_3)

Global $UH_Button9 = GUICtrlCreateButton("Delete User Historie Data", 399, 910, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($UH_Button9, $gfx & "Delete.bmp")
GuiCtrlSetTip(-1, $Info_Drivers_AT_Button_9)


Global $listview_LOG = GUICtrlCreateListView("", 450, 668, 622, 237, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))

_GUICtrlListView_SetExtendedListViewStyle($listview_LOG, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_DOUBLEBUFFER))
_GUICtrlStatusBar_SetSimple($Statusbar, True)
GUISetState()

; Add columns
_GUICtrlListView_AddColumn($listview_LOG, "Index", 40)
_GUICtrlListView_AddColumn($listview_LOG, "Time", 55)
_GUICtrlListView_AddColumn($listview_LOG, "Name", 115)
_GUICtrlListView_AddColumn($listview_LOG, "Attributes", 390)

Global $LOG_Button8 = GUICtrlCreateButton("Save LOG Data TXT", 450, 910, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($LOG_Button8, $gfx & "Save_TXT.bmp")
GuiCtrlSetTip(-1, "Save Resuts from LOG data as TXT File.")

Global $LOG_Button9 = GUICtrlCreateButton("Delete LOG Data", 1037, 910, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($LOG_Button9, $gfx & "Delete.bmp")
GuiCtrlSetTip(-1, "Delete List View and Log File data.")


GUICtrlCreateGroup("Practice1:", 538, 903, 95, 44)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
GUICtrlSetColor(-1, "0x0000FF")
GUICtrlSetFont(-1, 10, 400, 6, $font_2)
GUICtrlCreateLabel("Start Index:", 545, 919, 85, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
$Value_Practice1_Log_Start = GUICtrlCreateLabel("", 600, 919, 29, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
GUICtrlCreateLabel("End Index:", 545, 930, 85, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
$Value_Practice1_Log_End = GUICtrlCreateLabel("", 600, 930, 25, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)

GUICtrlCreateGroup("Practice2:", 633, 903, 100, 44)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
GUICtrlSetColor(-1, "0x0000FF")
GUICtrlSetFont(-1, 10, 400, 6, $font_2)
GUICtrlCreateLabel("Start Index:", 640, 919, 85, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
$Value_Practice2_Log_Start = GUICtrlCreateLabel("", 695, 919, 25, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
GUICtrlCreateLabel("End Index:", 640, 930, 85, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
$Value_Practice2_Log_End = GUICtrlCreateLabel("", 695, 930, 25, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)

GUICtrlCreateGroup("Qualifying:", 733, 903, 100, 44)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
GUICtrlSetColor(-1, "0x0000FF")
GUICtrlSetFont(-1, 10, 400, 6, $font_2)
GUICtrlCreateLabel("Start Index:", 740, 919, 85, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
$Value_Qualifying_Log_Start = GUICtrlCreateLabel("", 795, 919, 25, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
GUICtrlCreateLabel("End Index:", 740, 930, 85, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
$Value_Qualifying_Log_End = GUICtrlCreateLabel("", 795, 930, 25, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)

GUICtrlCreateGroup("WarmUp:", 833, 903, 100, 44)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
GUICtrlSetColor(-1, "0x0000FF")
GUICtrlSetFont(-1, 10, 400, 6, $font_2)
GUICtrlCreateLabel("Start Index:", 840, 919, 85, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
$Value_WarmUp_Log_Start = GUICtrlCreateLabel("", 895, 919, 25, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
GUICtrlCreateLabel("End Index:", 840, 930, 85, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
$Value_WarmUp_Log_End = GUICtrlCreateLabel("", 895, 930, 25, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)

GUICtrlCreateGroup("Race1:", 933, 903, 100, 44)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", "Explorer", "wstr", 0)
GUICtrlSetColor(-1, "0x0000FF")
GUICtrlSetFont(-1, 10, 400, 6, $font_2)
GUICtrlCreateLabel("Start Index:", 940, 919, 85, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
$Value_Race1_Log_Start = GUICtrlCreateLabel("", 995, 919, 25, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
GUICtrlCreateLabel("End Index:", 940, 930, 85, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)
$Value_Race1_Log_End = GUICtrlCreateLabel("", 995, 930, 25, 15)
GUICtrlSetFont(-1, 8, 400, 2, $font_2)


Global $General_Button_1 = GUICtrlCreateButton("Save all", 5, 952, 70, 30, $BS_BITMAP)
_GUICtrlButton_SetImage($General_Button_1, $gfx & "Save_all.bmp")
GuiCtrlSetTip(-1, "Saves ALL Results to '...PCDSG\Results\' folder.")

Global $General_Button_2 = GUICtrlCreateButton("Save LSR INI", 85, 952, 112, 30, $BS_BITMAP)
_GUICtrlButton_SetImage($General_Button_2, $gfx & "Save_LSR.bmp")
GuiCtrlSetTip(-1, "Saves all driven Laps for all drivers as .ini File using DS Log to '...PCDSG\Results\' folder.")

GUICtrlCreateGroup("", 815, 945, 2, 40)

$Value_Checkbox_Progress_Bar = IniRead($PCarsDSOverview_INI, "Settings", "Checkbox_Progress_Bar", "")
$Value_Checkbox_Read_complete_Log = IniRead($PCarsDSOverview_INI, "Settings", "Checkbox_Read_complete_Log", "")

$Checkbox_Progress_Bar = GUICtrlCreateCheckbox("Enable Progress bar", 825, 950, 140, 20)
	If $Value_Checkbox_Progress_Bar = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
$Checkbox_Read_complete_Log = GUICtrlCreateCheckbox("Read|Show complete Log", 825, 966, 140, 20)
	If $Value_Checkbox_Read_complete_Log = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)

GUICtrlCreateGroup("", 970, 945, 2, 40)

GUICtrlCreateLabel("Update Interval: ", 980, 954, 50, 32) ; Label Update Interval
$Wert_UpDown_1 = IniRead($PCarsDSOverview_INI, "Settings", "Update_Interval", "3000")
$Wert_UpDown_1 = StringTrimRight($Wert_UpDown_1, 3)
$Wert_UpDown_1 = $Wert_UpDown_1
$Auswahl_Update_Intervall = GUICtrlCreateInput($Wert_UpDown_1, 1025, 955, 48, 25)
GuiCtrlSetTip(-1, "Enter Number between 1 and 9 to set the Update Interval of this Window.")
GUICtrlSetFont(-1, 12, $FW_NORMAL, "", $font_2)
GUICtrlCreateUpdown($Auswahl_Update_Intervall)
GuiCtrlSetTip(-1, "Sets the update Interval of the data in showed in this Window.")

GUISetState(@SW_SHOW)

Global $hGui, $listview, $RM_Item1, $RM_Item2, $RM_Item3, $RM_Item4, $RM_Item5, $RM_Item6, $RM_Item7, $RM_Item8, $nMsg, $asRead4

Local $contextmenu = GUICtrlCreateContextMenu($ListView)
Local $RM_Item1 = GUICtrlCreateMenuItem($ListView_RM_1, $contextmenu)
Local $RM_Item2 = GUICtrlCreateMenuItem($ListView_RM_2, $contextmenu)
Local $RM_Item3 = GUICtrlCreateMenuItem("", $contextmenu)
Local $RM_Item4 = GUICtrlCreateMenuItem($ListView_RM_4, $contextmenu)
Local $RM_Item5 = GUICtrlCreateMenuItem($ListView_RM_5, $contextmenu)
Local $RM_Item6 = GUICtrlCreateMenuItem($ListView_RM_6, $contextmenu)
Local $RM_Item7 = GUICtrlCreateMenuItem($ListView_RM_7, $contextmenu)
Local $RM_Item8 = GUICtrlCreateMenuItem($ListView_RM_8, $contextmenu)

_GUICtrlStatusBar_SetText($Statusbar, $Server_Name & @TAB & $Server_Status & @TAB & "Timestamp: " & $timestamp)
#endregion End GUI

#Region Start Funktionen Verküpfen
GUISetOnEvent($GUI_EVENT_CLOSE, "_Beenden")

GUICtrlSetOnEvent($Checkbox_Progress_Bar, "_Checkbox_Progress_Bar")
GUICtrlSetOnEvent($Checkbox_Read_complete_Log, "_Checkbox_Read_Show_complete_Log")
GUICtrlSetOnEvent($Auswahl_Update_Intervall, "_Update_Intervall")

GUICtrlSetOnEvent($RM_Item1, "_RM_Item_1")
GUICtrlSetOnEvent($RM_Item2, "_RM_Item_2")
GUICtrlSetOnEvent($RM_Item4, "_RM_Item_4")
GUICtrlSetOnEvent($RM_Item5, "_RM_Item_5")
GUICtrlSetOnEvent($RM_Item6, "_RM_Item_6")
GUICtrlSetOnEvent($RM_Item7, "_RM_Item_7")
GUICtrlSetOnEvent($RM_Item8, "_RM_Item_8")

GUICtrlSetOnEvent($Button6, "_Button6")
GUICtrlSetOnEvent($Button7, "_Button7")
GUICtrlSetOnEvent($Button0, "_Button0")

GUICtrlSetOnEvent($UH_Button2, "_UH_Button2")
GUICtrlSetOnEvent($UH_Button3, "_UH_Button3")
GUICtrlSetOnEvent($UH_Button9, "_UH_Button9")

GUICtrlSetOnEvent($LOG_Button8, "_LOG_Button8")
GUICtrlSetOnEvent($LOG_Button9, "_LOG_Button9")

GUICtrlSetOnEvent($General_Button_1, "_General_Button_1")
GUICtrlSetOnEvent($General_Button_2, "_General_Button_2")
#endregion Funktionen Verküpfen

GUISetState()
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

Global $tempSelected = 0

While 1
	$nMsg = GUIGetMsg()

	If $tempSelected <> _GUICtrlListView_GetSelectedIndices($listview_LOG) Then
	  $tempSelected = _GUICtrlListView_GetSelectedIndices($listview_LOG) - 1
	  $array = _GUICtrlListView_GetItemTextArray($listview_LOG, $tempSelected + 1)
	  $text = ""
	  If Not IsArray($array) Then Dim $array[2]
	  For $i = 1 To $array[0]
		  $text &= StringReplace($array[$i],@CRLF,@CRLF&"   ") & @CRLF
	  Next
	  $LOG_ToolTip = ToolTip(StringTrimRight($text,2))
    EndIf
	Select
      Case $msg = $listview_LOG
         MsgBox(0,"listview", "clicked="& GUICtrlGetState($listview_LOG),2)
	EndSelect

	If $tempSelected <> _GUICtrlListView_GetHotItem($listview_LOG) - 1 Then
		$tempSelected = 0
		_GUICtrlListView_SetItemSelected($listview_LOG, 0, "true", "true")
		$LOG_ToolTip = ToolTip("")
	EndIf

	Switch $nMsg

		Case $GUI_EVENT_CLOSE
			;Exit

	EndSwitch

   Sleep(100)

	For $Loop_1 = 1 to 9999
		$Value_Checkbox_Progress_Bar = IniRead($PCarsDSOverview_INI, "Settings", "Checkbox_Progress_Bar", "")
		$Update_Interval = IniRead($PCarsDSOverview_INI, "Settings", "Update_Interval", "3000")

		If $Value_Checkbox_Progress_Bar = "true" Then GUICtrlSetData($Anzeige_Fortschrittbalken, 10)
		_Download()
		If $Value_Checkbox_Progress_Bar = "true" Then GUICtrlSetData($Anzeige_Fortschrittbalken, 30)
		_PCarsDSOverview_Participants_Daten_Update()
		If $Value_Checkbox_Progress_Bar = "true" Then GUICtrlSetData($Anzeige_Fortschrittbalken, 40)
		_LOG_Daten_Update()
		If $Value_Checkbox_Progress_Bar = "true" Then GUICtrlSetData($Anzeige_Fortschrittbalken, 50)

		_ListView_Update_Kopfzeile()
		If $Value_Checkbox_Progress_Bar = "true" Then GUICtrlSetData($Anzeige_Fortschrittbalken, 70)
		_ListView_Update_STATS()
		If $Value_Checkbox_Progress_Bar = "true" Then GUICtrlSetData($Anzeige_Fortschrittbalken, 80)
		_ListView_Update_UserHistory()
		If $Value_Checkbox_Progress_Bar = "true" Then GUICtrlSetData($Anzeige_Fortschrittbalken, 90)
		_ListView_Update_LOG()
		If $Value_Checkbox_Progress_Bar = "true" Then GUICtrlSetData($Anzeige_Fortschrittbalken, 100)
		Sleep(700)
		If $Value_Checkbox_Progress_Bar = "true" Then GUICtrlSetData($Anzeige_Fortschrittbalken, 00)
		Sleep($Update_Interval)
	Next
WEnd


#Region Start Funktionen

Func _Checkbox_Progress_Bar()
	$Data_Checkbox = GUICtrlRead($Checkbox_Progress_Bar)
	If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
	If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
	IniWrite($PCarsDSOverview_INI, "Settings", "Checkbox_Progress_Bar", $Data_Checkbox)
EndFunc

Func _Checkbox_Read_Show_complete_Log()
	$Data_Checkbox = GUICtrlRead($Checkbox_Read_complete_Log)
	If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
	If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
	IniWrite($PCarsDSOverview_INI, "Settings", "Checkbox_Read_complete_Log", $Data_Checkbox)
EndFunc

Func _Update_Intervall()
	$Data_UpDown_1 = GUICtrlRead($Auswahl_Update_Intervall)
	If $Data_UpDown_1 < 0 Then GUICtrlSetData($Auswahl_Update_Intervall, "0")
	If $Data_UpDown_1 > 10 Then GUICtrlSetData($Auswahl_Update_Intervall, "10")
	$Data_UpDown_1 = GUICtrlRead($Auswahl_Update_Intervall)
	IniWrite($PCarsDSOverview_INI, "Settings", "Update_Interval", $Data_UpDown_1 & "000")
EndFunc

Func _Download()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$URL_participants = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/status?attributes&participants"
	$download = InetGet($URL_participants, $PCarsDSOverview_participants_json, 16, 0)

	$URL_LOG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/log/range?offset=-30&count=30"
	$download = InetGet($URL_LOG, $PCarsDSOverview_Server_LOG_json, 16, 0)

	_FileReadToArray($PCarsDSOverview_participants_json, $asRead)
	_FileReadToArray($PCarsDSOverview_Server_LOG_json, $asRead2)
EndFunc

Func _PCarsDSOverview_Participants_Daten_Update()
	$Ende_Zeile_NR = _FileCountLines($PCarsDSOverview_participants_json) - 1
	$participants_Name = ""
	$participants_Name_bea = ""
	$Name = ""
	$Wert = ""

	If FileExists($PCarsDSOverview_participants_INI) Then
		$EmptyFile = FileOpen($PCarsDSOverview_participants_INI, 2)
		FileWrite($EmptyFile, "")
		FileClose($EmptyFile)
	EndIf

	For $iCount_3 = 77 To $Ende_Zeile_NR
		$Wert_Zeile = FileReadLine($PCarsDSOverview_participants_json, $iCount_3)
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
	If $Name = "GridPosition" Then $participants_GridPosition = $Wert
	If $Name = "VehicleId" Then $participants_VehicleId = $Wert
	If $Name = "RacePosition" Then $participants_RacePosition = $Wert
	If $Name = "CurrentLap" Then $participants_CurrentLap = $Wert
	If $Name = "CurrentSector" Then $participants_CurrentSector = $Wert
	If $Name = "Sector1Time" Then $participants_Sector1Time = $Wert
	If $Name = "Sector2Time" Then $participants_Sector2Time = $Wert
	If $Name = "Sector3Time" Then $participants_Sector3Time = $Wert
	If $Name = "LastLapTime" Then $participants_LastLapTime = $Wert
	If $Name = "FastestLapTime" Then $participants_FastestLapTime = $Wert
	If $Name = "State" Then $participants_State = $Wert
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
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "RefId", $participants_RefId)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "Name", $participants_Name)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "GridPosition", $participants_GridPosition)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "VehicleId", $participants_VehicleId)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "RacePosition", $participants_RacePosition)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "CurrentLap", $participants_CurrentLap)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "CurrentSector", $participants_CurrentSector)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "Sector1Time", $participants_Sector1Time)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "Sector2Time", $participants_Sector2Time)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "Sector3Time", $participants_Sector3Time)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "LastLapTime", $participants_LastLapTime)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "FastestLapTime", $participants_FastestLapTime)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "State", $participants_State)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "Speed", $participants_Speed)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "Gear", $participants_Gear)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "RPM", $participants_RPM)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "PositionX", $participants_PositionX)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "PositionY", $participants_PositionY)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "PositionZ", $participants_PositionZ)
		IniWrite($PCarsDSOverview_participants_INI, $participants_RacePosition, "Orientation", $participants_Orientation)
		FileWriteLine($PCarsDSOverview_participants_INI, "")
	EndIf

	Next
EndFunc

Func _LOG_Daten_Update()
	Global $Index_LOG, $Last_Index_LOG, $Index_LOG_old

	$Last_Index_LOG = IniRead($PCarsDSOverview_Server_LOG_INI, "DATA", "NR", "")

	$Anzahl_Zeilen_LOG = UBound($asRead2)

	For $iCount_4 = 9 To $Anzahl_Zeilen_LOG
		$Wert_Zeile = FileReadLine($PCarsDSOverview_Server_LOG_json, $iCount_4)
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
				IniWrite($PCarsDSOverview_Server_LOG_INI, "DATA", "NR", "")
				IniWrite($PCarsDSOverview_Server_LOG_INI, $Index_LOG, "index", $Wert)
			EndIf

			If $Index_LOG >= $Last_Index_LOG Then

				If $Name = "index" Then
					$Index_LOG = $Wert
					IniWrite($PCarsDSOverview_Server_LOG_INI, "DATA", "NR", $Index_LOG)
				EndIf

				If $Name = "time" Then
					IniWrite($PCarsDSOverview_Server_LOG_INI, $Index_LOG, "time", $Wert)
					EndIf

				If $Name = "name" Then
					IniWrite($PCarsDSOverview_Server_LOG_INI, $Index_LOG, "name", $Wert)
				EndIf

				If $Name <> "attributes" Then
					If $Name <> "index" And $Name <> "time" And $Name <> "name" Then
						If $Index_LOG <> "" Then
							IniWrite($PCarsDSOverview_Server_LOG_INI, $Index_LOG, "attribute_" & $Name, $Wert)
						EndIf
					EndIf
				EndIf
			EndIf
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
		$Durchgang_NR = $Schleife_CAR_DropDown - 5

		$Wert_Car_ID = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown)
		$Wert_Car_ID = StringReplace($Wert_Car_ID, '        "id" : ', '')
		$Wert_Car_ID = StringReplace($Wert_Car_ID, ',', '')

		If $Wert_CAR_ID_ListView = $Wert_Car_ID Then
			$Wert_Car = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown + 1)
			$Wert_Car = StringReplace($Wert_Car, '        "name" : "', '')
			$Wert_Car = StringReplace($Wert_Car, '",', '')
			$Schleife_CAR_DropDown = $Anzahl_Zeilen_VehicleList
		EndIf
	Next
EndFunc

Func _TRACK_NAME_from_ID()
	$Wert_Track_ID_search = $Wert

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
			$Schleife_TRACK_ID_DropDown = $Anzahl_Zeilen_TrackList
		EndIf
	Next
EndFunc

Func _Daten_aktualisieren()
	If FileExists(@ScriptDir & "\" & "UpdateServerData.exe") Then
		ShellExecuteWait(@ScriptDir & "\" & "UpdateServerData.exe")
	Else
		ShellExecuteWait(@ScriptDir & "\" & "UpdateServerData.au3")
	EndIf
EndFunc

Func _ListView_Update_Kopfzeile()
	If FileExists($Server_Data_INI) Then

	$font = "Comic Sans MS"
	$font_2 = "Arial"

	; "Name:"
	$Wert = IniRead($Server_Data_INI, "DATA", "name", "")
	$Server_Name = $Wert

	; "State:"
	$Wert = IniRead($Server_Data_INI, "DATA", "state", "")
	$Server_Status = $Wert
	$Check_Lobby = IniRead($Server_Data_INI, "DATA", "SessionStage", "")


	; "Track:"
	$Wert = IniRead($Server_Data_INI, "DATA", "TrackId", "")
	Global $Wert_Track
	$Wert_Track = IniRead($Server_Data_INI, "DATA", "TrackName", "")

	If $Wert_Track = "0" Then $Wert_Track = ""

	; "Players:"
	$Wert_1 = IniRead($Server_Data_INI, "DATA", "NumParticipantsValid", "")
	$Wert_2 = IniRead($Server_Data_INI, "DATA", "max_member_count", "")
	If $Wert_1 < 10 Then $Wert_1 = "0" & $Wert_1
	If $Wert_2 < 10 Then $Wert_1 = "0" & $Wert_2
	$Wert_NR_Players = $Wert_1 ;& "/" & $Wert_2
	If $Wert_NR_Players = "0/" Then $Wert_NR_Players = ""
	If $Wert_NR_Players = "00/0" Then $Wert_NR_Players = ""

	$Wert_NR_Players = $Wert_1 & " / " & $Wert_2
	If $Wert_NR_Players = "00 / 0" Then $Wert_NR_Players = ""


	; "Session:"
	$Wert = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
	$Wert_Session = IniRead($Server_Data_INI, "DATA", "SessionStage", "")

	; "Time:"
	$Wert_1 = IniRead($Server_Data_INI, "DATA", "SessionTimeElapsed", "")
	If $Wert_Session = "Practice1" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "Practice1Length", "")
	If $Wert_Session = "Practice2" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "Practice2Length", "")
	If $Wert_Session = "Qualifying" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "QualifyLength", "")
	If $Wert_Session = "Warmup" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "WarmupLength", "")
	If $Wert_Session = "Race1" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "Race1Length", "")
	If $Wert_Session = "Race1" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "Race2Length", "")

	$Wert_Duration = IniRead($Server_Data_INI, "DATA", "SessionTimeDuration", "")
	$Wert_Time = $Wert_1 & " / " & $Wert_2 & ":00"

	If $Wert_Time = " / " Then $Wert_Time = ""
	If $Wert_Time = "00:00 / 00:00" Then $Wert_Time = ""
	If $Wert_Time = "00:00 / 0:00" Then $Wert_Time = ""
	If $Wert_Time = "00:00/0" Then $Wert_Time = ""

	; Timestamp
	$Wert_Timestamp = IniRead($Server_Data_INI, "DATA", "now", "")
	$timestamp = _NowDate() & " - " & _NowTime()

	; Server Infos Group
	$Wert_SessionPhase = IniRead($Server_Data_INI, "DATA", "SessionPhase", "")
	$Wert_Racers_Valid = IniRead($Server_Data_INI, "DATA", "NumParticipantsValid", "")
	$Wert_Racers_Disqual = IniRead($Server_Data_INI, "DATA", "NumParticipantsDisqualified", "")
	$Wert_Racers_Retired = IniRead($Server_Data_INI, "DATA", "NumParticipantsRetired", "")
	$Wert_Racers_DNF  = IniRead($Server_Data_INI, "DATA", "NumParticipantsDNF", "")
	$Wert_Racers_Finished = IniRead($Server_Data_INI, "DATA", "NumParticipantsFinished", "")

	If $Server_Status = "Idle" Then
	$Wert_SessionPhase = ""
	$Wert_Racers_Valid = ""
	$Wert_Racers_Disqual = ""
	$Wert_Racers_Retired = ""
	$Wert_Racers_DNF  = ""
	$Wert_Racers_Finished = ""
	EndIf

	GUICtrlSetData($Label_Wert_Server_Name, $Server_Name)
	GUICtrlSetData($Label_Wert_Server_State, $Server_Status)
		If $Server_Status = "Running" Then GUICtrlSetColor($Label_Wert_Server_State, $COLOR_GREEN)
		If $Server_Status = "Idle" Then GUICtrlSetColor($Label_Wert_Server_State, $COLOR_BLUE)
		If $Server_Status = "OFFLINE" Then GUICtrlSetColor($Label_Wert_Server_State, $COLOR_RED)
		If $Check_Lobby = "Lobby" Then GUICtrlSetColor($Label_Wert_Server_State, $COLOR_GREEN)
	GUICtrlSetData($Label_Wert_Track, $Wert_Track)
	GUICtrlSetData($Label_Wert_NR_Players, $Wert_NR_Players)
	GUICtrlSetData($Label_Wert_Session, $Wert_Session)
	GUICtrlSetData($Label_Wert_Time, $Wert_Time)

	GUICtrlSetData($Label_Wert_SessionPhase, $Wert_SessionPhase)
	GUICtrlSetData($Label_Wert_Racers_Valid, $Wert_Racers_Valid)
	GUICtrlSetData($Label_Wert_Racers_Disqual, $Wert_Racers_Disqual)
	GUICtrlSetData($Label_Wert_Racers_Retired, $Wert_Racers_Retired)
	GUICtrlSetData($Label_Wert_Racers_DNF, $Wert_Racers_DNF)
	GUICtrlSetData($Label_Wert_Racers_Finished, $Wert_Racers_Finished)

	_GUICtrlStatusBar_SetText($Statusbar, $Server_Name & @TAB & $Server_Status & @TAB & "Timestamp: " & $timestamp)

	EndIf
EndFunc

Func _ListView_Update_STATS()
	$Wert_Check_SessionState = IniRead($Server_Data_INI, "DATA", "SessionState","")

	_GUICtrlListView_BeginUpdate($listview)
	_GUICtrlListView_DeleteAllItems($listview)

	For $Schleife_ListView_POS_aktualisieren_2 = 1 To 32
		$Wert_RefId_participants = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "RefId","")
		$Wert_Name_participants = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "Name","")

		If $Wert_Name_participants = "" Then
			$Wert_Name_participants = IniRead($Members_Data_INI, $Wert_RefId_participants, "name","")
		EndIf

		If $Wert_Name_participants <> "" Then
			$Wert_LAP_PitStop = ""

			$Wert_LA_1 = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "Name","") ; Name
			If $Wert_LA_1 = "" Then $Wert_LA_1 = IniRead($Members_Data_INI, $Wert_RefId_participants, "name","")

			If $Wert_LA_1 <> "" Then
				$Wert_LA_1_bea = StringReplace($Wert_LA_1, "[", "<")
				$Wert_LA_1_bea = StringReplace($Wert_LA_1_bea, "]", ">")
			EndIf

			If $Wert_LA_1_bea = "" Then $Wert_LA_1_bea = $Wert_LA_1

			$Wert_LA_2 = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "GridPosition","") ; GridPosition
			$Wert_LA_3 = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "VehicleId","") ; VehicleId
				$Wert_Car =	$Wert_LA_3
				_Car_ermitteln()
				If $Wert_Car = $Wert_Wert Then $Wert_Car = $Wert_Wert
				$Wert_LA_3 = $Wert_Car
				$Wert_LA_3_Len = StringLen($Wert_LA_3)
				$Wert_LA_3 = StringTrimRight($Wert_LA_3, $Wert_LA_3_Len - 21)
					If $Wert_LA_3 <> $Wert_Car Then $Wert_LA_3 = $Wert_LA_3 & "..."
			$Wert_LA_4 = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "RacePosition","") ; RacePosition
			$Wert_LA_5 = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "CurrentLap","") ; CurrentLap
			$Wert_LA_6 = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "CurrentSector","") ; CurrentSector
			$Wert_LA_7 = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "Sector1Time","") ; Sector1Time
			$Wert_LA_8 = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "Sector2Time","")  ; Sector2Time
			$Wert_LA_9 = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "Sector3Time","")  ; Sector3Time
			$Wert_LA_10 = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "LastLapTime","")  ; LastLapTime
			$Wert_LA_11 = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "FastestLapTime","")   ; FastestLapTime
			$Wert_LA_12 = IniRead($Participants_Data_INI, $Schleife_ListView_POS_aktualisieren_2, "State","")  ; State

			$Farbe_State_ListView_Participants = $COLOR_BLACK

			If $Wert_LA_12 = "InGarage" Then $Farbe_State_ListView_Participants = $COLOR_BLACK
			If $Wert_LA_12 = "Racing" Then $Farbe_State_ListView_Participants = $COLOR_BLUE
			If $Wert_LA_12 = "ExitingPits" Then $Farbe_State_ListView_Participants = $COLOR_RED
			If $Wert_LA_12 = "InPits" Then $Farbe_State_ListView_Participants = $COLOR_GREEN

			If $Wert_LA_12 = "Finished" Then IniWrite($config_ini, "PC_Server", "Server_State", "Finished")

			$Wert_LA_13 = ""
			$Check_PitStop = IniRead($Info_PitStops_ini, $Wert_LA_1, "PitStops","")
			If $Check_PitStop <> "" Then $Wert_LA_13 = $Check_PitStop

			$Wert_LA_14 = ""
			$Check_PenaltyPoints_PP = IniRead($Points_ini, $Wert_LA_1_bea, "PenaltyPoints","")
			$Wert_LA_14 = $Check_PenaltyPoints_PP

			$Wert_LA_15 = ""
			$Check_ExperiencePoints_PP = IniRead($Stats_INI, $Wert_LA_1_bea, "ExperiencePoints", "")
			$Wert_LA_15 = $Check_ExperiencePoints_PP

			$Add_ListView_Participants = GUICtrlCreateListViewItem($Wert_LA_1 & $ListViewSeperator & $Wert_LA_2 & $ListViewSeperator & $Wert_LA_3 & _
																	$ListViewSeperator & $Wert_LA_4 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & _
																	$Wert_LA_6 & $ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & _
																	$ListViewSeperator & $Wert_LA_9 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
																	$Wert_LA_11 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
																	$ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & $Wert_LA_15 & $ListViewSeperator, $listview)

			GUICtrlSetColor($Add_ListView_Participants, $Farbe_State_ListView_Participants)

			_GUICtrlListView_SetColumnWidth($listview, 0, 140)
			_GUICtrlListView_SetColumnWidth($listview, 1, 40)
			_GUICtrlListView_SetColumnWidth($listview, 2, 140)
			_GUICtrlListView_SetColumnWidth($listview, 3, 35)
			_GUICtrlListView_SetColumnWidth($listview, 4, 35)
			_GUICtrlListView_SetColumnWidth($listview, 5, 60)
			_GUICtrlListView_SetColumnWidth($listview, 6, 70)
			_GUICtrlListView_SetColumnWidth($listview, 7, 70)
			_GUICtrlListView_SetColumnWidth($listview, 8, 70)
			_GUICtrlListView_SetColumnWidth($listview, 9, 80)
			_GUICtrlListView_SetColumnWidth($listview, 10, 105)
			_GUICtrlListView_SetColumnWidth($listview, 11, 80)
			_GUICtrlListView_SetColumnWidth($listview, 12, 30)
			_GUICtrlListView_SetColumnWidth($listview, 13, 35)
			_GUICtrlListView_SetColumnWidth($listview, 14, 60)
		EndIf
	Next
	_GUICtrlListView_EndUpdate($listview) ; End Update
EndFunc

Func _ListView_Update_UserHistory()
	Global $Wert_LA_1_ALT_EXIST, $Wert_LA_1_ALT, $Wert_LA_1, $Wert_LA_2, $Wert_LA_3, $Wert_LA_4, $Anzahl_Werte_UH

	$Anzahl_Werte_UH = IniRead($UserHistory_ini, "DATA", "NR", "")

	$Anzahl_Zeilen_ListView_UserHistory = _GUICtrlListView_GetItemCount($listview_drivers_AT)

	$Wert_LA_1_ALT_EXIST = "false"

	If FileExists($UserHistory_ini) Then
		_GUICtrlListView_BeginUpdate($listview_drivers_AT)

		For $Schleife_ListView_aktualisieren = $Anzahl_Zeilen_ListView_UserHistory To $Anzahl_Werte_UH

			$Wert_LA_1 = IniRead($UserHistory_ini, $Schleife_ListView_aktualisieren, "Name","") ; Name
			$Wert_LA_2 = IniRead($UserHistory_ini, $Schleife_ListView_aktualisieren, "Steamid","") ; Steamid
			$Wert_LA_3 = IniRead($UserHistory_ini, $Schleife_ListView_aktualisieren, "Ping","") ; Ping
			$Wert_LA_4 = IniRead($UserHistory_ini, $Schleife_ListView_aktualisieren, "Added","") ; Added

			For $Schleife_Check_Name_1 = 1 To $Anzahl_Werte_UH
			$Wert_LA_1_ALT = _GUICtrlListView_GetItemText($listview_drivers_AT, $Schleife_Check_Name_1 - 1, 0)
			If $Wert_LA_1 = $Wert_LA_1_ALT Then $Wert_LA_1_ALT_EXIST = "true"
			If $Wert_LA_1 = $Wert_LA_1_ALT Then $Schleife_Check_Name_1 = $Anzahl_Werte_UH
			Next

			If $Wert_LA_1_ALT_EXIST <> "true" Then
				;MsgBox(0, "true", $Wert_LA_1_ALT_EXIST)
				GUICtrlCreateListViewItem($Wert_LA_1 & $ListViewSeperator & $Wert_LA_2 & $ListViewSeperator & $Wert_LA_4 & $ListViewSeperator & $Wert_LA_3, $listview_drivers_AT)
			EndIf
			$Wert_LA_1_ALT_EXIST = "false"
		Next

		_GUICtrlListView_SetColumnWidth($listview_drivers_AT, 0, 130)
		_GUICtrlListView_SetColumnWidth($listview_drivers_AT, 1, 115)
		_GUICtrlListView_SetColumnWidth($listview_drivers_AT, 2, 120)
		_GUICtrlListView_SetColumnWidth($listview_drivers_AT, 3, 40)

		_GUICtrlListView_Scroll($listview_drivers_AT, 0, 10000)
		_GUICtrlListView_EndUpdate($listview_drivers_AT) ; End Update
	EndIf

EndFunc

Func _ListView_Update_LOG()
	Global $Farbe_State_LOG, $Farbe_Standard

	$LOG_Data_INI = $PCarsDSOverview_Server_LOG_INI

	$Anzahl_Werte_LOG = IniRead($PCarsDSOverview_Server_LOG_INI, "DATA", "NR","")
	If $Anzahl_Werte_LOG = "" Then $Anzahl_Werte_LOG = 1

	$Anzahl_Zeilen_ListView_LOG = _GUICtrlListView_GetItemCount($listview_LOG)

	Global $Wert_LA_1_ALT = _GUICtrlListView_GetItemText($listview_LOG, $Anzahl_Zeilen_ListView_LOG - 1, 0)

	$Value_Checkbox_Read_complete_Log = IniRead($PCarsDSOverview_INI, "Settings", "Checkbox_Read_complete_Log", "")
	If $Value_Checkbox_Read_complete_Log = "false" Then
		$Wert_LA_1_ALT = $Anzahl_Werte_LOG - 30
		Global $Value_ListView_Check = _GUICtrlListView_GetItemText($listview_LOG, $Anzahl_Zeilen_ListView_LOG - 1, 0)
		If $Value_ListView_Check <> "" Then $Wert_LA_1_ALT = $Value_ListView_Check
	EndIf

	For $Schleife_ListView_aktualisieren = $Wert_LA_1_ALT To $Anzahl_Werte_LOG

		Global $Wert_LA_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "index","") ; index
		Global $Wert_LA_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "time","") ; time
		Global $Wert_LA_3 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "name","") ; name

		Global $Wert_Label_LA_4 = ""

		Global $Wert_Label_LA_4_1 = ""
		Global $Wert_Label_LA_4_2 = ""
		Global $Wert_Label_LA_4_3 = ""
		Global $Wert_Label_LA_4_4 = ""
		Global $Wert_Label_LA_4_5 = ""
		Global $Wert_Label_LA_4_6 = ""
		Global $Wert_Label_LA_4_7 = ""
		Global $Wert_Label_LA_4_8 = ""
		Global $Wert_Label_LA_4_9 = ""
		Global $Wert_Label_LA_4_10 = ""
		Global $Wert_Label_LA_4_11 = ""

		Global $Wert_LA_4 = "" ; name

		Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_refid", "") ; attribute_refid
		Global $Wert_LA_4_2 = ""
		Global $Wert_LA_4_3 = ""
		Global $Wert_LA_4_4 = ""
		Global $Wert_LA_4_5 = ""
		Global $Wert_LA_4_6 = ""
		Global $Wert_LA_4_7 = ""
		Global $Wert_LA_4_8 = ""
		Global $Wert_LA_4_9 = ""
		Global $Wert_LA_4_10 = ""
		Global $Wert_LA_4_11 = ""


	#Region Read LOG_attribute
			If $Wert_LA_3 = "Sector" Then
				Global $Wert_Label_LA_4_1 = "refid"
				Global $Wert_Label_LA_4_2 = "participantid"
				Global $Wert_Label_LA_4_3 = "Lap"
				Global $Wert_Label_LA_4_4 = "Sector"
				Global $Wert_Label_LA_4_5 = "SectorTime"
				Global $Wert_Label_LA_4_6 = "TotalTime"
				Global $Wert_Label_LA_4_7 = "CountThisLap"
				Global $Wert_Label_LA_4_8 = "CountThisLapTimes"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_refid", "") ; attribute_refid
				Global $Wert_LA_4_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_participantid", "") ; attribute_participantid
				Global $Wert_LA_4_3 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Lap", "") ; attribute_Lap
				Global $Wert_LA_4_4 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Sector", "") ; attribute_Sector
				Global $Wert_LA_4_5 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_SectorTime", "") ; attribute_SectorTime
				Global $Wert_LA_4_6 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_TotalTime", "") ; attribute_TotalTime
				Global $Wert_LA_4_7 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_CountThisLap", "") ; attribute_CountThisLap
				Global $Wert_LA_4_8 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_CountThisLapTimes", "") ; attribute_CountThisLapTimes
			EndIf

			If $Wert_LA_3 = "Lap" Then
				Global $Wert_Label_LA_4_1 = "refid"
				Global $Wert_Label_LA_4_2 = "participantid"
				Global $Wert_Label_LA_4_3 = "Lap"
				Global $Wert_Label_LA_4_4 = "LapTime"
				Global $Wert_Label_LA_4_5 = "Sector1Time"
				Global $Wert_Label_LA_4_6 = "Sector2Time"
				Global $Wert_Label_LA_4_7 = "Sector3Time"
				Global $Wert_Label_LA_4_8 = "RacePosition"
				Global $Wert_Label_LA_4_9 = "DistanceTravelled"
				Global $Wert_Label_LA_4_10 = "CountThisLapTimes"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_refid", "") ; attribute_refid
				Global $Wert_LA_4_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_participantid", "") ; attribute_participantid
				Global $Wert_LA_4_3 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Lap", "") ; attribute_Lap
				Global $Wert_LA_4_4 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_LapTime", "") ; attribute_LapTime
				Global $Wert_LA_4_5 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Sector1Time", "") ; attribute_Sector1Time
				Global $Wert_LA_4_6 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Sector2Time", "") ; attribute_Sector2Time
				Global $Wert_LA_4_7 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Sector3Time", "") ; attribute_Sector3Time
				Global $Wert_LA_4_8 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_RacePosition", "") ; attribute_RacePosition
				Global $Wert_LA_4_9 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_DistanceTravelled", "") ; attribute_DistanceTravelled
				Global $Wert_LA_4_10 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_CountThisLapTimes", "") ; attribute_CountThisLapTimes
			EndIf

			If $Wert_LA_3 = "State" Then
				Global $Wert_Label_LA_4_1 = "refid"
				Global $Wert_Label_LA_4_2 = "participantid"
				Global $Wert_Label_LA_4_3 = "PreviousState"
				Global $Wert_Label_LA_4_4 = "NewState"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_refid", "") ; attribute_refid
				Global $Wert_LA_4_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_participantid", "") ; attribute_participantid
				Global $Wert_LA_4_3 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_PreviousState", "") ; attribute_PreviousState
				Global $Wert_LA_4_4 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_NewState", "") ; attribute_NewState
			EndIf

			If $Wert_LA_3 = "CutTrackStart" Then
				Global $Wert_Label_LA_4_1 = "refid"
				Global $Wert_Label_LA_4_2 = "participantid"
				Global $Wert_Label_LA_4_3 = "Lap"
				Global $Wert_Label_LA_4_4 = "RacePosition"
				Global $Wert_Label_LA_4_5 = "IsMainBranch"
				Global $Wert_Label_LA_4_6 = "LapTime"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_refid", "") ; attribute_refid
				Global $Wert_LA_4_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_participantid", "") ; attribute_participantid
				Global $Wert_LA_4_3 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Lap", "") ; attribute_Lap
				Global $Wert_LA_4_4 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_RacePosition", "") ; attribute_RacePosition
				Global $Wert_LA_4_5 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_IsMainBranch", "") ; attribute_IsMainBranch
				Global $Wert_LA_4_6 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_LapTime", "") ; attribute_LapTime
			EndIf

			If $Wert_LA_3 = "CutTrackEnd" Then
				Global $Wert_Label_LA_4_1 = "refid"
				Global $Wert_Label_LA_4_2 = "participantid"
				Global $Wert_Label_LA_4_3 = "ElapsedTime"
				Global $Wert_Label_LA_4_4 = "SkippedTime"
				Global $Wert_Label_LA_4_5 = "PlaceGain"
				Global $Wert_Label_LA_4_6 = "PenaltyValue"
				Global $Wert_Label_LA_4_7 = "PenaltyThreshold"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_refid", "") ; attribute_refid
				Global $Wert_LA_4_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_participantid", "") ; attribute_participantid
				Global $Wert_LA_4_3 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_ElapsedTime", "") ; attribute_ElapsedTime
				Global $Wert_LA_4_4 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_SkippedTime", "") ; attribute_SkippedTime
				Global $Wert_LA_4_5 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_PlaceGain", "") ; attribute_PlaceGain
				Global $Wert_LA_4_6 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_PenaltyValue", "") ; attribute_PenaltyValue
				Global $Wert_LA_4_7 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_PenaltyThreshold", "") ; attribute_PenaltyThreshold
			EndIf

			If $Wert_LA_3 = "Impact" Then
				Global $Wert_Label_LA_4_1 = "refid"
				Global $Wert_Label_LA_4_2 = "participantid"
				Global $Wert_Label_LA_4_3 = "OtherParticipantId"
				Global $Wert_Label_LA_4_4 = "CollisionMagnitude"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_refid", "") ; attribute_refid
				Global $Wert_LA_4_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_participantid", "") ; attribute_participantid
				Global $Wert_LA_4_3 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_OtherParticipantId", "") ; attribute_OtherParticipantId
				Global $Wert_LA_4_4 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_CollisionMagnitude", "") ; attribute_CollisionMagnitude
			EndIf

			If $Wert_LA_3 = "Authenticated" Then
				Global $Wert_Label_LA_4_1 = "refid"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_refid", "") ; attribute_refid
			EndIf

			If $Wert_LA_3 = "SessionSetup" Then
				Global $Wert_Label_LA_4_1 = "GridSize"
				Global $Wert_Label_LA_4_2 = "MaxPlayers"
				Global $Wert_Label_LA_4_3 = "Practice1Length"
				Global $Wert_Label_LA_4_4 = "Practice2Length"
				Global $Wert_Label_LA_4_5 = "QualifyLength"
				Global $Wert_Label_LA_4_6 = "WarmupLength"
				Global $Wert_Label_LA_4_7 = "Race1Length"
				Global $Wert_Label_LA_4_8 = "Race2Length"
				Global $Wert_Label_LA_4_9 = "Flags"
				Global $Wert_Label_LA_4_10 = "TrackId"
				Global $Wert_Label_LA_4_11 = "GameMode"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_GridSize", "") ; attribute_GridSize
				Global $Wert_LA_4_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_MaxPlayers", "") ; attribute_MaxPlayers
				Global $Wert_LA_4_3 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Practice1Length", "") ; attribute_Practice1Length
				Global $Wert_LA_4_4 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Practice2Length", "") ; attribute_Practice2Length
				Global $Wert_LA_4_5 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_QualifyLength", "") ; attribute_QualifyLength
				Global $Wert_LA_4_6 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_WarmupLength", "") ; attribute_WarmupLength
				Global $Wert_LA_4_7 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Race1Length", "") ; attribute_Race1Length
				Global $Wert_LA_4_8 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Race2Length", "") ; attribute_Race2Length
				Global $Wert_LA_4_9 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Flags", "") ; attribute_Flags
				Global $Wert_LA_4_10 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_TrackId", "") ; attribute_TrackId
				Global $Wert_LA_4_11 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_GameMode", "") ; attribute_GameMode
			EndIf

			If $Wert_LA_3 = "PlayerLeft" Then
				Global $Wert_Label_LA_4_1 = "refid"
				Global $Wert_Label_LA_4_2 = "Reason"
				Global $Wert_Label_LA_4_3 = "GameReasonId"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_refid", "") ; attribute_refid
				Global $Wert_LA_4_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Reason", "") ; attribute_Reason
				Global $Wert_LA_4_3 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_GameReasonId", "") ; attribute_GameReasonId
			EndIf

			If $Wert_LA_3 = "StateChanged" Then
				Global $Wert_Label_LA_4_1 = "PreviousState"
				Global $Wert_Label_LA_4_2 = "NewState"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_PreviousState", "") ; attribute_PreviousStage
				Global $Wert_LA_4_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_NewState", "") ; attribute_NewStage

			If $Wert_LA_4_1 = "Lobby" and $Wert_LA_4_2 = "Loading" Then
				GUICtrlSetData($Value_Practice1_Log_Start, "")
				GUICtrlSetData($Value_Practice2_Log_Start, "")
				GUICtrlSetData($Value_Qualifying_Log_Start, "")
				GUICtrlSetData($Value_WarmUp_Log_Start, "")
				GUICtrlSetData($Value_Race1_Log_Start, "")

				GUICtrlSetData($Value_Practice1_Log_End, "")
				GUICtrlSetData($Value_Practice2_Log_End, "")
				GUICtrlSetData($Value_Qualifying_Log_End, "")
				GUICtrlSetData($Value_WarmUp_Log_End, "")
				GUICtrlSetData($Value_Qualifying_Log_End, "")
				GUICtrlSetData($Value_Race1_Log_End, "")

				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_Start", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice2_LogIndex_Start", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_Start", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Warmup_LogIndex_Start", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex", "")

				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_End", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice2_LogIndex_End", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_End", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Warmup_LogIndex_End", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_End", "")
			EndIf

			If $Wert_LA_4_1 = "PostRace" and $Wert_LA_4_2 = "Returning" Then
				GUICtrlSetData($Value_Race1_Log_End, $Wert_LA_1)
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_End", $Wert_LA_1)
			EndIf

			If $Wert_LA_4_1 = "Returning" and $Wert_LA_4_2 = "Lobby" Then
				Sleep(5000)
			EndIf

			If $Wert_LA_4_1 = "Loading" and $Wert_LA_4_2 = "Race" Then
				$SessionStage_Check = IniRead($Server_Data_INI, "DATA", "SessionStage", "")

				GUICtrlSetData($Value_Practice1_Log_Start, "")
				GUICtrlSetData($Value_Practice2_Log_Start, "")
				GUICtrlSetData($Value_Qualifying_Log_Start, "")
				GUICtrlSetData($Value_WarmUp_Log_Start, "")
				GUICtrlSetData($Value_Race1_Log_Start, "")

				GUICtrlSetData($Value_Practice1_Log_End, "")
				GUICtrlSetData($Value_Practice2_Log_End, "")
				GUICtrlSetData($Value_Qualifying_Log_End, "")
				GUICtrlSetData($Value_WarmUp_Log_End, "")
				GUICtrlSetData($Value_Qualifying_Log_End, "")
				GUICtrlSetData($Value_Race1_Log_End, "")

				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_Start", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice2_LogIndex_Start", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_Start", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Warmup_LogIndex_Start", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex", "")

				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_End", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice2_LogIndex_End", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_End", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Warmup_LogIndex_End", "")
				IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_End", "")

				If $SessionStage_Check <> "" Then
					If $SessionStage_Check = "Practice1" Then GUICtrlSetData($Value_Practice1_Log_Start, $Wert_LA_1)
					If $SessionStage_Check = "Practice2" Then GUICtrlSetData($Value_Practice2_Log_Start, $Wert_LA_1)
					If $SessionStage_Check = "Qualifying" Then GUICtrlSetData($Value_Qualifying_Log_Start, $Wert_LA_1)
					If $SessionStage_Check = "Warmup" Then GUICtrlSetData($Value_WarmUp_Log_Start, $Wert_LA_1)
					If $SessionStage_Check = "Race1" Then GUICtrlSetData($Value_Race1_Log_Start, $Wert_LA_1)

					If $SessionStage_Check = "Practice1" Then IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_Start", $Wert_LA_1)
					If $SessionStage_Check = "Practice2" Then IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice2_LogIndex_Start", $Wert_LA_1)
					If $SessionStage_Check = "Qualifying" Then IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_Start", $Wert_LA_1)
					If $SessionStage_Check = "Warmup" Then IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Warmup_LogIndex_Start", $Wert_LA_1)
					If $SessionStage_Check = "Race1" Then IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_Start", $Wert_LA_1)
				Else
					GUICtrlSetData($Value_Practice1_Log_Start, $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_Start", $Wert_LA_1)
				EndIf


			EndIf

			EndIf

			If $Wert_LA_3 = "StageChanged" Then
				Global $Wert_Label_LA_4_1 = "PreviousStage"
				Global $Wert_Label_LA_4_2 = "NewStage"
				Global $Wert_Label_LA_4_3 = "Length"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_PreviousStage", "") ; attribute_PreviousStage
				Global $Wert_LA_4_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_NewStage", "") ; attribute_NewStage
				Global $Wert_LA_4_3 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Length", "") ; attribute_Length

				If $Wert_LA_4_1 = "Practice1" and $Wert_LA_4_2 = "Qualifying" Then
					GUICtrlSetData($Value_Qualifying_Log_Start, $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_Start", $Wert_LA_1)
				EndIf

				If $Wert_LA_4_1 = "Practice1" and $Wert_LA_4_2 = "Race1" Then
					GUICtrlSetData($Value_Race1_Log_Start, $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_Start", $Wert_LA_1)

					$Read_Value_Race1_Log_End = GUICtrlRead($Value_Race1_Log_End)

					If $Read_Value_Race1_Log_End < $Value_Race1_Log_Start Then
						GUICtrlSetData($Value_Race1_Log_End, "")
						IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_End", "")
					EndIf

				EndIf

				If $Wert_LA_4_1 = "Practice1" and $Wert_LA_4_2 = "Practice2" Then
					GUICtrlSetData($Value_Practice1_Log_End, $Wert_LA_1)
					GUICtrlSetData($Value_Practice2_Log_Start, $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_End", $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice2_LogIndex_Start", $Wert_LA_1)
				EndIf

				If $Wert_LA_4_1 = "Practice2" and $Wert_LA_4_2 = "Qualifying" Then
					GUICtrlSetData($Value_Practice2_Log_End, $Wert_LA_1)
					GUICtrlSetData($Value_Qualifying_Log_Start, $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice2_LogIndex_End", $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_Start", $Wert_LA_1)

					$Read_Value_Qualifying_Log_End = GUICtrlRead($Value_Race1_Log_End)

					If $Read_Value_Qualifying_Log_End < $Value_Qualifying_Log_Start Then
						GUICtrlSetData($Value_Qualifying_Log_End, "")
						IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_End", "")
					EndIf

				EndIf

				If $Wert_LA_4_1 = "Qualifying" and $Wert_LA_4_2 = "Warmup" Then
					GUICtrlSetData($Value_Qualifying_Log_End, $Wert_LA_1)
					GUICtrlSetData($Value_WarmUp_Log_Start, $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_End", $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Warmup_LogIndex_Start", $Wert_LA_1)
				EndIf

				If $Wert_LA_4_1 = "Qualifying" and $Wert_LA_4_2 = "Race1" Then
					GUICtrlSetData($Value_Qualifying_Log_End, $Wert_LA_1)
					GUICtrlSetData($Value_Race1_Log_Start, $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_End", $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_Start", $Wert_LA_1)

					$Read_Value_Race1_Log_End = GUICtrlRead($Value_Race1_Log_End)

					If $Read_Value_Race1_Log_End < $Value_Race1_Log_Start Then
						GUICtrlSetData($Value_Race1_Log_End, "")
						IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_End", "")
					EndIf
				EndIf

				If $Wert_LA_4_1 = "Warmup" and $Wert_LA_4_2 = "Race1" Then
					GUICtrlSetData($Value_WarmUp_Log_End, $Wert_LA_1)
					GUICtrlSetData($Value_Race1_Log_Start, $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Warmup_LogIndex_End", $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_Start", $Wert_LA_1)
				EndIf

				If $Wert_LA_4_1 = "Race1" and $Wert_LA_4_2 = "Practice1" Then
					GUICtrlSetData($Value_Race1_Log_End, $Wert_LA_1)
					GUICtrlSetData($Value_Practice1_Log_Start, $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_End", $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_Start", $Wert_LA_1)
				EndIf

				If $Wert_LA_4_1 = "Race1" and $Wert_LA_4_2 = "Qualifying" Then
					GUICtrlSetData($Value_Race1_Log_End, $Wert_LA_1)
					GUICtrlSetData($Value_Qualifying_Log_Start, $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_End", $Wert_LA_1)
					IniWrite($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_Start", $Wert_LA_1)
				EndIf
			EndIf

			If $Wert_LA_3 = "PlayerChat" Then
				Global $Wert_Label_LA_4_1 = "refid"
				Global $Wert_Label_LA_4_2 = "Message"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_refid", "") ; attribute_refid
				Global $Wert_LA_4_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Message", "") ; attribute_Message
			EndIf

			If $Wert_LA_3 = "Results" Then
				Global $Wert_Label_LA_4_1 = "refid"
				Global $Wert_Label_LA_4_2 = "participantid"
				Global $Wert_Label_LA_4_3 = "RacePosition"
				Global $Wert_Label_LA_4_4 = "Lap"
				Global $Wert_Label_LA_4_5 = "VehicleId"
				Global $Wert_Label_LA_4_6 = "State"
				Global $Wert_Label_LA_4_7 = "TotalTime"
				Global $Wert_Label_LA_4_8 = "FastestLapTime"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_refid", "") ; attribute_refid
				Global $Wert_LA_4_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_participantid", "") ; attribute_participantid
				Global $Wert_LA_4_3 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_RacePosition", "") ; attribute_RacePosition
				Global $Wert_LA_4_4 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_Lap", "") ; attribute_Lap
				Global $Wert_LA_4_5 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_VehicleId", "") ; attribute_VehicleId
				Global $Wert_LA_4_6 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_State", "") ; attribute_State
				Global $Wert_LA_4_7 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_TotalTime", "") ; attribute_TotalTime
				Global $Wert_LA_4_8 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_FastestLapTime", "") ; attribute_FastestLapTime
			EndIf

			If $Wert_LA_3 = "PlayerJoined" Then
				Global $Wert_Label_LA_4_1 = "refid"
				Global $Wert_Label_LA_4_2 = "name"
				Global $Wert_Label_LA_4_3 = "steamID"
				Global $Wert_LA_4_1 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_refid", "") ; attribute_refid
				Global $Wert_LA_4_2 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_name", "") ; attribute_name
				Global $Wert_LA_4_3 = IniRead($PCarsDSOverview_Server_LOG_INI, $Schleife_ListView_aktualisieren, "attribute_steamID", "") ; attribute_steamID
			EndIf

			If $Wert_LA_3 = "SessionDestroyed" Then
				GUICtrlSetData($Value_Practice1_Log_Start, "")
				GUICtrlSetData($Value_Practice2_Log_Start, "")
				GUICtrlSetData($Value_Qualifying_Log_Start, "")
				GUICtrlSetData($Value_WarmUp_Log_Start, "")
				GUICtrlSetData($Value_Race1_Log_Start, "")

				GUICtrlSetData($Value_Practice1_Log_End, "")
				GUICtrlSetData($Value_Practice2_Log_End, "")
				GUICtrlSetData($Value_Qualifying_Log_End, "")
				GUICtrlSetData($Value_WarmUp_Log_End, "")
				GUICtrlSetData($Value_Qualifying_Log_End, "")
				GUICtrlSetData($Value_Race1_Log_End, "")
			EndIf

	#EndRegion

		$Name_from_RefID = IniRead($Members_Data_INI, $Wert_LA_4_1, "name", "")
		If $Wert_Label_LA_4_1 = "refid" and $Name_from_RefID <> "" Then $Wert_Label_LA_4_1 = ""
		If $Name_from_RefID <> "" Then
			$Wert_LA_4_1 = "<" & $Name_from_RefID & ">"
		Else
			$Wert_Label_LA_4_1 = $Wert_Label_LA_4_1 & "="
		EndIf

		If $Wert_LA_4_1 = "0" Then
			$Wert_Label_LA_4_1 = ""
			$Wert_LA_4_1 = "PCDSG Server Message"
		EndIf


		If $Wert_LA_4 <> "" Then $Wert_LA_4 = $Wert_Label_LA_4 & "=" & $Wert_LA_4
		If $Wert_LA_4_1 <> "" Then $Wert_LA_4 = $Wert_LA_4 & "  " & $Wert_Label_LA_4_1 & "" & $Wert_LA_4_1
		If $Wert_LA_4_2 <> "" Then $Wert_LA_4 = $Wert_LA_4 & "  " & $Wert_Label_LA_4_2 & "=" & $Wert_LA_4_2
		If $Wert_LA_4_3 <> "" Then $Wert_LA_4 = $Wert_LA_4 & "  " & $Wert_Label_LA_4_3 & "=" & $Wert_LA_4_3
		If $Wert_LA_4_4 <> "" Then $Wert_LA_4 = $Wert_LA_4 & "  " & $Wert_Label_LA_4_4 & "=" & $Wert_LA_4_4
		If $Wert_LA_4_5 <> "" Then $Wert_LA_4 = $Wert_LA_4 & "  " & $Wert_Label_LA_4_5 & "=" & $Wert_LA_4_5
		If $Wert_LA_4_6 <> "" Then $Wert_LA_4 = $Wert_LA_4 & "  " & $Wert_Label_LA_4_6 & "=" & $Wert_LA_4_6
		If $Wert_LA_4_7 <> "" Then $Wert_LA_4 = $Wert_LA_4 & "  " & $Wert_Label_LA_4_7 & "=" & $Wert_LA_4_7
		If $Wert_LA_4_8 <> "" Then $Wert_LA_4 = $Wert_LA_4 & "  " & $Wert_Label_LA_4_8 & "=" & $Wert_LA_4_8
		If $Wert_LA_4_9 <> "" Then $Wert_LA_4 = $Wert_LA_4 & "  " & $Wert_Label_LA_4_9 & "=" & $Wert_LA_4_9
		If $Wert_LA_4_10 <> "" Then $Wert_LA_4 = $Wert_LA_4 & "  " & $Wert_Label_LA_4_10 & "=" & $Wert_LA_4_10
		If $Wert_LA_4_11 <> "" Then $Wert_LA_4 = $Wert_LA_4 & "  " & $Wert_Label_LA_4_11 & "=" & $Wert_LA_4_11

		$Wert_Index_Check_LOG = Int($Wert_LA_1)
		$Wert_Index_Check_ListView = Int($Wert_LA_1_ALT)

		If $Wert_Index_Check_LOG > $Wert_Index_Check_ListView Then
			$Seconds_to_Time = $Wert_LA_2
			_Epoch_decrypt($Seconds_to_Time)
			$Wert_LA_2 = $Seconds_to_Time
			$Wert_LA_2_NEU_NR = StringInStr($Wert_LA_2, "-")
			$Wert_LA_2_NEU = StringMid ($Wert_LA_2, $Wert_LA_2_NEU_NR + 2, 8)

			$Add_ListView_LOG = GUICtrlCreateListViewItem($Wert_LA_1 & $ListViewSeperator & $Wert_LA_2_NEU & $ListViewSeperator & $Wert_LA_3 & $ListViewSeperator & $Wert_LA_4, $listview_LOG)

	_GUICtrlListView_Scroll($listview_LOG, 0, 10000)

			If $Wert_LA_3 = "SessionSetup" Then GUICtrlSetColor($Add_ListView_LOG, "0x99FFFF") ; Blau sehr hell
			If $Wert_LA_3 = "Authenticated" Then GUICtrlSetColor($Add_ListView_LOG, "0x006600") ; Grün dunkel
			If $Wert_LA_3 = "ParticipantDestroyed" Then GUICtrlSetColor($Add_ListView_LOG, "0x00FF00") ; Braun
			If $Wert_LA_3 = "ParticipantCreated" Then GUICtrlSetColor($Add_ListView_LOG, "0x006600") ; Grün dunkel
			If $Wert_LA_3 = "State" Then GUICtrlSetColor($Add_ListView_LOG, "0x0099FF") ; Blau hell
			If $Wert_LA_3 = "CutTrackStart" Then GUICtrlSetColor($Add_ListView_LOG, "0xFF0000") ; Rot
			If $Wert_LA_3 = "CutTrackEnd" Then GUICtrlSetColor($Add_ListView_LOG, "0xFF0000") ; Rot
			If $Wert_LA_3 = "PlayerJoined" Then GUICtrlSetColor($Add_ListView_LOG, "0x00FF00") ; Grün
			If $Wert_LA_3 = "PlayerLeft" Then GUICtrlSetColor($Add_ListView_LOG, "0xFF6600") ; Orange
			If $Wert_LA_3 = "StateChanged" Then GUICtrlSetColor($Add_ListView_LOG, "0x0000FF") ; Blau dunkel
			If $Wert_LA_3 = "Impact" Then GUICtrlSetColor($Add_ListView_LOG, "0xFF0000") ; ROT
		EndIf
	Next

	_GUICtrlListView_SetColumnWidth($listview_LOG, 0, 40)
	_GUICtrlListView_SetColumnWidth($listview_LOG, 1, 55)
	_GUICtrlListView_SetColumnWidth($listview_LOG, 2, 115)
	_GUICtrlListView_SetColumnWidth($listview_LOG, 3, 390)

	_GUICtrlListView_Scroll($listview_LOG, 0, 10000)
EndFunc

Func _ListView_STATS_Update_Button()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 25)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 50)
	_ListView_Update_Kopfzeile()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 75)
	_ListView_Update_STATS()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 100)
	Sleep(700)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 00)
EndFunc

Func _ListView_UserHistory_Update_Button()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 25)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 50)
	_ListView_Update_Kopfzeile()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 75)
	_ListView_Update_UserHistory()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 100)
	Sleep(700)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 00)
EndFunc

Func _ListView_LOG_Update_Button()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 25)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 50)
	_ListView_Update_Kopfzeile()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 75)
	_ListView_Update_LOG()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 100)
	Sleep(700)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 00)
EndFunc

Func _Update_Page()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 20)
	If IniRead($config_ini, "PC_Server", "Checkbox_Update_1", "") = "true" Then _ListView_Update_Kopfzeile()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 40)
	If IniRead($config_ini, "PC_Server", "Checkbox_Update_3", "") = "true" Then _ListView_Update_STATS()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 60)
	If IniRead($config_ini, "PC_Server", "Checkbox_Update_2", "") = "true" Then _ListView_Update_UserHistory()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 80)
	If IniRead($config_ini, "PC_Server", "Checkbox_Update_4", "") = "true" Then _ListView_Update_LOG()
	GUICtrlSetData($Anzeige_Fortschrittbalken, 100)
	Sleep(700)
	GUICtrlSetData($Anzeige_Fortschrittbalken, 00)
EndFunc

Func _Checkbox_1()
;$Status_Checkbox_1 = GUICtrlRead($Checkbox_1)
;If $Status_Checkbox_1 = 1 Then IniWrite($config_ini, "PC_Server", "Checkbox_Update_1", "true")
;If $Status_Checkbox_1 = 4 Then IniWrite($config_ini, "PC_Server", "Checkbox_Update_1", "false")
EndFunc

Func _Checkbox_2()
;$Status_Checkbox_2 = GUICtrlRead($Checkbox_2)
;If $Status_Checkbox_2 = 1 Then IniWrite($config_ini, "PC_Server", "Checkbox_Update_2", "true")
;If $Status_Checkbox_2 = 4 Then IniWrite($config_ini, "PC_Server", "Checkbox_Update_2", "false")
EndFunc

Func _Checkbox_3()
;$Status_Checkbox_3 = GUICtrlRead($Checkbox_3)
;If $Status_Checkbox_3 = 1 Then IniWrite($config_ini, "PC_Server", "Checkbox_Update_3", "true")
;If $Status_Checkbox_3 = 4 Then IniWrite($config_ini, "PC_Server", "Checkbox_Update_3", "false")
EndFunc

Func _Checkbox_4()
;$Status_Checkbox_4 = GUICtrlRead($Checkbox_4)
;If $Status_Checkbox_4 = 1 Then IniWrite($config_ini, "PC_Server", "Checkbox_Update_4", "true")
;If $Status_Checkbox_4 = 4 Then IniWrite($config_ini, "PC_Server", "Checkbox_Update_4", "false")
EndFunc

Func _Auswahl_Update_Intervall()
	;$Data_UpDown_1 = GUICtrlRead($Auswahl_Update_Intervall)

	;If $Data_UpDown_1 < 5 Then GUICtrlSetData($Auswahl_Update_Intervall, "5")
	;If $Data_UpDown_1 > 59 Then GUICtrlSetData($Auswahl_Update_Intervall, "59")

	;$Data_UpDown_1 = GUICtrlRead($Auswahl_Update_Intervall)

	;$Data_UpDown_1 = $Data_UpDown_1 - 5

	;IniWrite($config_ini, "PC_Server", "Infos_pb_Update_Intervall", $Data_UpDown_1 & "000")
EndFunc

Func _Delete_PP_EP()
	$Abfrage = MsgBox(4, $msgbox_34, $msgbox_35 & @CRLF)

	If $Abfrage = 6 Then
		FileDelete($Points_ini)
		FileWriteLine($Points_ini, "[DATA]")
		FileWriteLine($Points_ini, "NR=0")
	EndIf
EndFunc

Func _Delete_PitStops()
	$Abfrage = MsgBox(4, $msgbox_32, $msgbox_33 & @CRLF)

	If $Abfrage = 6 Then
		FileDelete($Info_PitStops_ini)
		FileWriteLine($Info_PitStops_ini, "[PitStops]")
		FileWriteLine($Info_PitStops_ini, "NR=0")
	EndIf
EndFunc

Func _Button6() ; RESULTS .XLS

$Anzahl_Zeilen_ListView_LOG = _GUICtrlListView_GetItemCount($ListView) - 1

$NowTime_Value = _NowTime()
$NowTime_orig = $NowTime_Value
$NowTime = StringReplace($NowTime_Value, ":", "-")

$Results_Template = $Data_Dir & "Results\PCarsDSOverview RESULTS_" & $NowTime & ".xls"

Dim $objXL

$objXL = ObjCreate("Excel.Application")

    With $objXL.Application
        .Visible = False
        Local $oExcel = _Excel_Open($Results_Template, false, false)
		Local $oWorkbook = _Excel_BookNew($oExcel)
		$oWorkbook.Sheets(1).Name = "PCDSG_Results"
        ;$var_excel_open = .Workbooks.Open ($Results_Template)
		$var_excel_open = $oWorkbook
		_Excel_RangeWrite($var_excel_open, "PCDSG_Results", "--- PCDSG - Dedicated Server RESULTS ---", "A1", true)
		_Excel_RangeWrite($var_excel_open, "PCDSG_Results", "<" &  _Now() & ">", "N1", true)

		$XLS_SheetName = "PCDSG_Results"

		For $Schleife_LOG_speichern = 4 To 67
			$Check_A4 = _Excel_RangeRead($var_excel_open, $XLS_SheetName, "A" & $Schleife_LOG_speichern)
			If $Check_A4 <> "" Then
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "A" & $Schleife_LOG_speichern, true)
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "B" & $Schleife_LOG_speichern, true)
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "C" & $Schleife_LOG_speichern, true)
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "D" & $Schleife_LOG_speichern, true)
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "E" & $Schleife_LOG_speichern, true)
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "F" & $Schleife_LOG_speichern, true)
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "G" & $Schleife_LOG_speichern, true)
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "H" & $Schleife_LOG_speichern, true)
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "I" & $Schleife_LOG_speichern, true)
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "J" & $Schleife_LOG_speichern, true)
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "K" & $Schleife_LOG_speichern, true)
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "L" & $Schleife_LOG_speichern, true)
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "M" & $Schleife_LOG_speichern, true)
				_Excel_RangeWrite($var_excel_open, $XLS_SheetName, "", "N" & $Schleife_LOG_speichern, true)
			EndIf

			If $Check_A4 = "" Then $Schleife_LOG_speichern = 67
		Next


		For $Schleife_LOG_speichern = 0 To $Anzahl_Zeilen_ListView_LOG
			$Inhalt_Zeile_LOG = _GUICtrlListView_GetItemTextArray($ListView, $Schleife_LOG_speichern)

			$Spalte_A = $Inhalt_Zeile_LOG[1]
			$Spalte_B = $Inhalt_Zeile_LOG[2]
			$Spalte_C = $Inhalt_Zeile_LOG[3]
			$Spalte_D = $Inhalt_Zeile_LOG[4]
			$Spalte_E = $Inhalt_Zeile_LOG[5]
			$Spalte_F = $Inhalt_Zeile_LOG[6]
			$Spalte_G = $Inhalt_Zeile_LOG[7]
			$Spalte_H = $Inhalt_Zeile_LOG[8]
			$Spalte_I = $Inhalt_Zeile_LOG[9]
			$Spalte_J = $Inhalt_Zeile_LOG[10]
			$Spalte_K = $Inhalt_Zeile_LOG[11]
			$Spalte_L = $Inhalt_Zeile_LOG[12]
			$Spalte_M = $Inhalt_Zeile_LOG[13]
			$Spalte_N = $Inhalt_Zeile_LOG[14]
			$Spalte_O = $Inhalt_Zeile_LOG[15]

			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_A, "A" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_B, "B" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_C, "C" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_D, "D" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_E, "E" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_F, "F" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_G, "G" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_H, "H" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_I, "I" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_J, "J" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_K, "K" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_L, "L" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_M, "M" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_N, "N" & $Schleife_LOG_speichern + 4, true)
			_Excel_RangeWrite($var_excel_open, $XLS_SheetName, $Spalte_O, "O" & $Schleife_LOG_speichern + 4, true)
		Next
	EndWith

	_Excel_BookSaveAs($oWorkbook, $Results_Template, $xlAddIn8, True)

	_Excel_BookClose($var_excel_open)
	_Excel_BookClose($oWorkbook)

	If FileExists($Results_Template) Then $Abfrage = MsgBox(4, "Finish Creating", "File successfully created." & @CRLF & @CRLF & "Do you want to open the File?", 5)
	If Not FileExists($Results_Template) Then $Abfrage = MsgBox(4, "File not created", "File was not created." & @CRLF & @CRLF & "Maybe not enough Log events available?", 5)

	If $Abfrage = 6 Then ;Ja - Auswahl = JA
		If FileExists($Results_Template) Then
			Sleep(5000)
			ShellExecute($Results_Template)
		EndIf
	EndIf
EndFunc

Func _Button7() ; RESULTS .TXT
	$NowTime_Value = _NowTime()
	$NowTime_orig = $NowTime_Value
	$NowTime = StringReplace($NowTime_Value, ":", "-")

	$Results_Template = $Data_Dir & "Results\PCarsDSOverview RESULTS_" & $NowTime & ".txt"

	$Anzahl_Zeilen_ListView_LOG = _GUICtrlListView_GetItemCount($ListView) - 1

	FileWriteLine($Results_Template, "--- PCDSG - Dedicated Server RESULTS ---" & @TAB & "<" &  _Now() & ">" & @CRLF & @CRLF)

	For $Schleife_LOG_speichern = 0 To $Anzahl_Zeilen_ListView_LOG
	$Inhalt_Zeile_LOG = _GUICtrlListView_GetItemTextArray($ListView, $Schleife_LOG_speichern)

	$Anzahl_Zeilenumbrueche = @CRLF
	If $Schleife_LOG_speichern = $Anzahl_Zeilen_ListView_LOG Then $Anzahl_Zeilenumbrueche = @CRLF & @CRLF & @CRLF

	$Anzahl_Tabs_Name = @TAB
	$Laenge_Name = StringLen($Inhalt_Zeile_LOG[1])
	If $Laenge_Name < 8 Then $Anzahl_Tabs_Name = @TAB & @TAB & @TAB
	If $Laenge_Name > 8 Then $Anzahl_Tabs_Name = @TAB & @TAB
	If $Laenge_Name > 16 Then $Anzahl_Tabs_Name = @TAB

	$Anzahl_Tabs_State = @TAB
	$Laenge_Name = StringLen($Inhalt_Zeile_LOG[12])
	If $Laenge_Name < 8 Then $Anzahl_Tabs_State = @TAB & @TAB & @TAB
	If $Laenge_Name > 8 Then $Anzahl_Tabs_State = @TAB & @TAB
	If $Laenge_Name > 16 Then $Anzahl_Tabs_State = @TAB

	If $Inhalt_Zeile_LOG[7] = "" Then $Inhalt_Zeile_LOG[7] = @TAB
	If $Inhalt_Zeile_LOG[8] = "" Then $Inhalt_Zeile_LOG[8] = @TAB
	If $Inhalt_Zeile_LOG[9] = "" Then $Inhalt_Zeile_LOG[9] = @TAB
	If $Inhalt_Zeile_LOG[10] = "" Then $Inhalt_Zeile_LOG[10] = @TAB
	If $Inhalt_Zeile_LOG[11] = "" Then $Inhalt_Zeile_LOG[11] = @TAB

	If $Inhalt_Zeile_LOG[12] = "" Then $Inhalt_Zeile_LOG[11] = @TAB
	If $Inhalt_Zeile_LOG[13] = "" Then $Inhalt_Zeile_LOG[12] = @TAB
	If $Inhalt_Zeile_LOG[14] = "" Then $Inhalt_Zeile_LOG[14] = @TAB

	Local $sText = $Inhalt_Zeile_LOG[1] & $Anzahl_Tabs_Name & $Inhalt_Zeile_LOG[2] & @TAB &  $Inhalt_Zeile_LOG[3] & @TAB & $Inhalt_Zeile_LOG[4] & $Inhalt_Zeile_LOG[5] & @TAB & $Inhalt_Zeile_LOG[6] & @TAB &  $Inhalt_Zeile_LOG[7] & @TAB & $Inhalt_Zeile_LOG[8] & @TAB & $Inhalt_Zeile_LOG[9] & @TAB & $Inhalt_Zeile_LOG[10] & @TAB &  $Inhalt_Zeile_LOG[11] & @TAB & $Inhalt_Zeile_LOG[12] & $Anzahl_Tabs_State & $Inhalt_Zeile_LOG[13] & @TAB & $Inhalt_Zeile_LOG[14] & $Anzahl_Zeilenumbrueche
	FileWriteLine($Results_Template, $sText)
	Next

	If FileExists($Results_Template) Then $Abfrage = MsgBox(4, "Finish Creating", "File successfully created." & @CRLF & @CRLF & "Do you want to open the File?", 5)
	If Not FileExists($Results_Template) Then $Abfrage = MsgBox(4, "File not created", "File was not created." & @CRLF & @CRLF & "Maybe not enough Log events available?", 5)

	If $Abfrage = 6 Then ;Ja - Auswahl = JA
		If FileExists($Results_Template) Then ShellExecute($Results_Template)
	EndIf
EndFunc

Func _Button0() ; Delete ListView
	$Abfrage = MsgBox(4, "Delete Participants Data", $msgbox_25 & @CRLF)

	If $Abfrage = 6 Then
		FileDelete($Participants_Data_INI)
		_GUICtrlListView_DeleteAllItems($ListView)
		FileWriteLine($Participants_Data_INI, '[DATA]')
	FileWriteLine($Participants_Data_INI, 'NR=')
	EndIf
EndFunc

Func _RM_Item_1() ; Kick User
	$idListview = GUICtrlGetHandle($ListView)
	$sText = ""

	$ListView_Index = _GUICtrlListView_GetSelectedIndices($ListView)
	$aItem = _GUICtrlListView_GetItemTextArray($idListview, $ListView_Index)

	$index = IniRead($Members_Data_INI, $aItem[1], "index", "")
	$refid = IniRead($Members_Data_INI, $aItem[1], "refid", "")
	$steamid = IniRead($Members_Data_INI, $aItem[1], "steamid", "")

	$Abfrage = MsgBox(4, "Steam User profile", "Do you realy want to open the Steam User Profile for this User?" & @CRLF & @CRLF & "Name: " & @TAB & $aItem[1] & @CRLF &  "Index: " & @TAB & $index & @CRLF & "Refid: " & @TAB & $refid & @CRLF & "Steamid: " & @TAB & $steamid & @CRLF)
	$URL_Steam_Profil = "http://steamcommunity.com/profiles/" & $steamid & "/"

	If $Abfrage = 6 Then
		ShellExecuteWait($URL_Steam_Profil)
	EndIf
EndFunc

Func _RM_Item_2() ; User Info
	$idListview = GUICtrlGetHandle($ListView)
	$sText = ""

	$ListView_Index = _GUICtrlListView_GetSelectedIndices($ListView)

	$aItem = _GUICtrlListView_GetItemTextArray($idListview, $ListView_Index)

	$sText = "Name: " & @TAB & @TAB & $aItem[1] & @CRLF & "Start Pos.: " & @TAB & @TAB & $aItem[2] & @CRLF & "Wagen: " & @TAB & @TAB & $aItem[3] & @CRLF & "Pos.: " & @TAB & @TAB & $aItem[4] & @CRLF & "LAP: " & @TAB & @TAB & $aItem[5] & @CRLF & "Letzte Runde: " & @TAB & $aItem[10] & @CRLF & "Schnellste Runde: " & @TAB & $aItem[11] & @CRLF & "Status : " & @TAB & @TAB & $aItem[12] & @CRLF & "Boxenstopps : " & @TAB & $aItem[13]

	$index = IniRead($Members_Data_INI, $aItem[1], "index", "")
	$refid = IniRead($Members_Data_INI, $aItem[1], "refid", "")
	$steamid = IniRead($Members_Data_INI, $aItem[1], "steamid", "")

	$Speed = IniRead($Participants_Data_INI, $aItem[1], "Speed", "")
	$Gear = IniRead($Participants_Data_INI, $aItem[1], "Gear", "")
	$RPM = IniRead($Participants_Data_INI, $aItem[1], "RPM", "")
	$PositionX = IniRead($Participants_Data_INI, $aItem[1], "PositionX", "")
	$PositionY = IniRead($Participants_Data_INI, $aItem[1], "PositionY", "")
	$PositionZ = IniRead($Participants_Data_INI, $aItem[1], "PositionZ", "")
	$Orientation = IniRead($Participants_Data_INI, $aItem[1], "Orientation", "")

	$sText = $sText & @CRLF & "Speed: " & @TAB & @TAB & $Speed & @CRLF & "Gear: " & @TAB & @TAB & $Gear & @CRLF & "RPM: " & @TAB & @TAB & $RPM & @CRLF & "PositionX: " & @TAB & $PositionX & @CRLF & "PositionY: " & @TAB & $PositionY & @CRLF & "Orientation: " & @TAB & $Orientation & @CRLF & "Index: " & @TAB & @TAB & $index & @CRLF & "Refid: " & @TAB & @TAB & $refid & @CRLF & "Steamid: " & @TAB & @TAB & $steamid

	MsgBox($MB_SYSTEMMODAL, "User Information", "Information for <" & $aItem[1] & ">:" & @CRLF & @CRLF & $sText)
EndFunc

Func _RM_Item_4() ; Kick User
	$idListview = GUICtrlGetHandle($ListView)
	$sText = ""

	$ListView_Index = _GUICtrlListView_GetSelectedIndices($ListView)
	$aItem = _GUICtrlListView_GetItemTextArray($idListview, $ListView_Index)

	$index = IniRead($Members_Data_INI, $aItem[1], "index", "")
	$refid = IniRead($Members_Data_INI, $aItem[1], "refid", "")
	$steamid = IniRead($Members_Data_INI, $aItem[1], "steamid", "")

	$Abfrage = MsgBox(4, "Kick user", "Do you realy want to Kick this user?" & @CRLF & @CRLF & "Name: " & @TAB & $aItem[1] & @CRLF &  "Index: " & @TAB & $index & @CRLF & "Refid: " & @TAB & $refid & @CRLF & "Steamid: " & @TAB & $steamid & @CRLF)

	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$URL_KICK = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid ; & "&redirect=status"

	If $Abfrage = 6 Then
		$download = InetGet($URL_KICK, $KICK_BAN_TXT, 16, 0)
	EndIf

	$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)
	If $Check_KICK_BAN = '  "result" : "ok"' Then MsgBox(0, "Success", "KICK OK" & @CRLF & @CRLF & "User <" & $aItem[1] & "> was successfully kicked out of the Session.")
EndFunc

Func _RM_Item_5() ; BAN User 10 minutes
	$idListview = GUICtrlGetHandle($ListView)
	$sText = ""

	$ListView_Index = _GUICtrlListView_GetSelectedIndices($ListView)
	$aItem = _GUICtrlListView_GetItemTextArray($idListview, $ListView_Index)

	$index = IniRead($Members_Data_INI, $aItem[1], "index", "")
	$refid = IniRead($Members_Data_INI, $aItem[1], "refid", "")
	$steamid = IniRead($Members_Data_INI, $aItem[1], "steamid", "")

	$Abfrage = MsgBox(4, "Ban user", "Do you realy want to Ban this user for 10 minutes?" & @CRLF & @CRLF & "Name: " & @TAB & $aItem[1] & @CRLF &  "Index: " & @TAB & $index & @CRLF & "Refid: " & @TAB & $refid & @CRLF & "Steamid: " & @TAB & $steamid & @CRLF)

	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$URL_BAN_10m = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid & "&ban=600"

	If $Abfrage = 6 Then
		$download = InetGet($URL_BAN_10m, @ScriptDir & $KICK_BAN_TXT, 16, 0)
	EndIf

	$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)
	If $Check_KICK_BAN = '  "result" : "ok"' Then MsgBox(0, "Success", "BAN OK" & @CRLF & @CRLF & "User <" & $aItem[1] & "> was successfully kicked out of the Session." & @CRLF & "He will not be able to join within the 10 minutes.")
EndFunc

Func _RM_Item_6() ; BAN User 1 Stunde
	$idListview = GUICtrlGetHandle($ListView)
	$sText = ""

	$ListView_Index = _GUICtrlListView_GetSelectedIndices($ListView)
	$aItem = _GUICtrlListView_GetItemTextArray($idListview, $ListView_Index)

	$index = IniRead($Members_Data_INI, $aItem[1], "index", "")
	$refid = IniRead($Members_Data_INI, $aItem[1], "refid", "")
	$steamid = IniRead($Members_Data_INI, $aItem[1], "steamid", "")

	$Abfrage = MsgBox(4, "Ban user", "Do you realy want to Ban this user for 1 houer?" & @CRLF & @CRLF & "Name: " & @TAB & $aItem[1] & @CRLF &  "Index: " & @TAB & $index & @CRLF & "Refid: " & @TAB & $refid & @CRLF & "Steamid: " & @TAB & $steamid & @CRLF)

	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$URL_BAN_1h = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid & "&ban=3600"

	If $Abfrage = 6 Then
		$download = InetGet($URL_BAN_1h, @ScriptDir & $KICK_BAN_TXT, 16, 0)
	EndIf

	$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)
	If $Check_KICK_BAN = '  "result" : "ok"' Then MsgBox(0, "Success", "BAN OK" & @CRLF & @CRLF & "User <" & $aItem[1] & "> was successfully kicked out of the Session." & @CRLF & "He will not be able to join within the next hour.")
EndFunc

Func _RM_Item_7() ; BAN User 24 Stunden
	$idListview = GUICtrlGetHandle($ListView)
	$sText = ""

	$ListView_Index = _GUICtrlListView_GetSelectedIndices($ListView)
	$aItem = _GUICtrlListView_GetItemTextArray($idListview, $ListView_Index)

	$index = IniRead($Members_Data_INI, $aItem[1], "index", "")
	$refid = IniRead($Members_Data_INI, $aItem[1], "refid", "")
	$steamid = IniRead($Members_Data_INI, $aItem[1], "steamid", "")

	$Abfrage = MsgBox(4, "Ban user", "Do you realy want to Ban this user for 24 houers?" & @CRLF & @CRLF & "Name: " & @TAB & $aItem[1] & @CRLF &  "Index: " & @TAB & $index & @CRLF & "Refid: " & @TAB & $refid & @CRLF & "Steamid: " & @TAB & $steamid & @CRLF)

	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$URL_BAN_24h = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid & "&ban=864000"

	If $Abfrage = 6 Then ;Ja - Auswahl = JA
		$download = InetGet($URL_BAN_24h, @ScriptDir & "\" & $KICK_BAN_TXT, 16, 0)
	EndIf

	$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)
	If $Check_KICK_BAN = '  "result" : "ok"' Then MsgBox(0, "Success", "BAN OK" & @CRLF & @CRLF & "User < " & $aItem[1] & " > was successfully kicked out of the Session." & @CRLF & "He will not be able to join within the next 24 hours.")
EndFunc

Func _RM_Item_8() ; BAN User 48 Stunden
	$idListview = GUICtrlGetHandle($ListView)
	$sText = ""

	$ListView_Index = _GUICtrlListView_GetSelectedIndices($ListView)
	$aItem = _GUICtrlListView_GetItemTextArray($idListview, $ListView_Index)

	$index = IniRead($Members_Data_INI, $aItem[1], "index", "")
	$refid = IniRead($Members_Data_INI, $aItem[1], "refid", "")
	$steamid = IniRead($Members_Data_INI, $aItem[1], "steamid", "")

	$Abfrage = MsgBox(4, "Ban user", "Do you realy want to Ban this user for 48 houers?" & @CRLF & @CRLF & "Name: " & @TAB & $aItem[1] & @CRLF &  "Index: " & @TAB & $index & @CRLF & "Refid: " & @TAB & $refid & @CRLF & "Steamid: " & @TAB & $steamid & @CRLF)

	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$URL_BAN_48h = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid & "&ban=10368000"

	If $Abfrage = 6 Then ;Ja - Auswahl = JA
		$download = InetGet($URL_BAN_48h, @ScriptDir & "\" & $KICK_BAN_TXT, 16, 0)
	EndIf

	$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)
	If $Check_KICK_BAN = '  "result" : "ok"' Then MsgBox(0, "Success", "BAN OK" & @CRLF & @CRLF & "User < " & $aItem[1] & " > was successfully kicked out of the Session." & @CRLF & "He will not be able to join within the next 48 hours.")
EndFunc

Func _UH_Button2() ; Whitelist user
	$Auswahl_ListView = _GUICtrlListView_GetSelectedIndices($listview_drivers_AT)
	$Auswahl_ListView = $Auswahl_ListView + 1
	$Auswahl_ListView_name = IniRead($UserHistory_ini, $Auswahl_ListView, "Name", "")
	$Auswahl_ListView_steamID = IniRead($UserHistory_ini, $Auswahl_ListView, "Steamid", "")
	$Auswahl_ListView_jointime = IniRead($UserHistory_ini, $Auswahl_ListView, "Added", "")

	$Input_whitelist_1 = $Auswahl_ListView_steamID
	$Input_whitelist_2 = $Auswahl_ListView_name
	$Input_whitelist_3 = $Auswahl_ListView_jointime

	$NEW_MSG_Input_whitelist = "Driver Name: " & @TAB & $Input_whitelist_1 & @CRLF & "Driver SteamID: " & @TAB & $Input_whitelist_2 & @CRLF & "Added at: " & @TAB & @TAB & $Input_whitelist_3 & @CRLF & "Comments: " & @TAB

	$Abfrage = MsgBox(4, "Dedicated Server", $msgbox_16 & @CRLF & @CRLF & $NEW_MSG_Input_whitelist & @CRLF & @CRLF & $msgbox_17 & @CRLF)

	If $Abfrage = 6 Then
		$Input_whitelist_4 = InputBox("Whitelist", "Add Remarks and comments.", "")

		$Wert_letzte_Zeile = _FileCountLines($Whitelist_File)

		Global $asRead, $iUbound

		_FileReadToArray($Whitelist_File, $asRead)

		For $AW = 1 To _FileCountLines($Whitelist_File) - 1
			$Text_letzte_Zeile = $asRead[$AW]
			If $Text_letzte_Zeile = "}" Then $Text_letzte_Zeile = ""
			If $Text_letzte_Zeile <> "" Then FileWriteLine(@ScriptDir & "\whitelist_2.cfg", $Text_letzte_Zeile)
		Next

		$NEW_Input_whitelist = '"<' & $Input_whitelist_2 & '> <' & $Input_whitelist_4 & '> <' & $Input_whitelist_3 & '>" ' & $Input_whitelist_1

		FileWriteLine(@ScriptDir & "\whitelist_2.cfg", $NEW_Input_whitelist)
		FileWriteLine(@ScriptDir & "\whitelist_2.cfg", "}")
		FileDelete($Whitelist_File)
		FileCopy(@ScriptDir & "\whitelist_2.cfg", $Whitelist_File)
		FileDelete(@ScriptDir & "\whitelist_2.cfg")
	EndIf
EndFunc

Func _UH_Button3() ; Blacklist user
	$Auswahl_ListView = _GUICtrlListView_GetSelectedIndices($listview_drivers_AT)
	$Auswahl_ListView = $Auswahl_ListView + 1
	$Auswahl_ListView_name = IniRead($UserHistory_ini, $Auswahl_ListView, "Name", "")
	$Auswahl_ListView_steamID = IniRead($UserHistory_ini, $Auswahl_ListView, "Steamid", "")
	$Auswahl_ListView_jointime = IniRead($UserHistory_ini, $Auswahl_ListView, "Added", "")
	$Auswahl_ListView_refID = IniRead($UserHistory_ini, $Auswahl_ListView, "Steamid", "")

	$Input_blacklist_1 = $Auswahl_ListView_steamID
	$Input_blacklist_2 = $Auswahl_ListView_name
	$Input_blacklist_3 = $Auswahl_ListView_jointime

	$NEW_MSG_Input_blacklist = "Driver Name: " & @TAB & $Input_blacklist_1 & @CRLF & "Driver SteamID: " & @TAB & $Input_blacklist_2 & @CRLF & "Added at: " & @TAB & @TAB & $Input_blacklist_3 & @CRLF & "Comments: " & @TAB

	$Abfrage = MsgBox(4, "Dedicated Server", $msgbox_18 & @CRLF & @CRLF & $NEW_MSG_Input_blacklist & @CRLF & @CRLF & $msgbox_19 & @CRLF)

	If $Abfrage = 6 Then
		$Input_blacklist_4 = InputBox("Blacklist", "Add Remarks and comments.", "")

		$Wert_letzte_Zeile = _FileCountLines($Blacklist_File)

		Global $asRead, $iUbound

		_FileReadToArray($Blacklist_File, $asRead)

		For $AW = 1 To _FileCountLines($Blacklist_File) - 1
			$Text_letzte_Zeile = $asRead[$AW]
			If $Text_letzte_Zeile = "}" Then $Text_letzte_Zeile = ""
			If $Text_letzte_Zeile <> "" Then FileWriteLine(@ScriptDir & "\Blacklist_2.cfg", $Text_letzte_Zeile)
		Next

		$Input_blacklist = $Auswahl_ListView_steamID

		$NEW_Input_blacklist = '"<' & $Input_blacklist_2 & '> <' & $Input_blacklist_4 & '> <' & $Input_blacklist_3 & '>" ' & $Input_blacklist_1

		FileWriteLine(@ScriptDir & "\Blacklist_2.cfg", $NEW_Input_blacklist)
		FileWriteLine(@ScriptDir & "\Blacklist_2.cfg", "}")
		FileDelete($Blacklist_File)
		FileCopy(@ScriptDir & "\Blacklist_2.cfg", $Blacklist_File)
		FileDelete(@ScriptDir & "\Blacklist_2.cfg")

		FileWriteLine(@ScriptDir & "\KICK_LIST.txt", $Auswahl_ListView_refID)
	EndIf
EndFunc

Func _UH_Button9()
	$Abfrage = MsgBox(4, $msgbox_24, $msgbox_25 & @CRLF)

	If $Abfrage = 6 Then
		FileDelete($UserHistory_ini)
		_GUICtrlListView_DeleteAllItems($listview_drivers_AT)
		FileWriteLine($UserHistory_ini, '[DATA]')
		FileWriteLine($UserHistory_ini, 'NR=')
	EndIf
EndFunc

Func _LOG_Button8()
	$Abfrage = MsgBox(4, $msgbox_30, $msgbox_31 & @CRLF)

	$NowTime_Value = _NowTime()
	$NowTime_orig = $NowTime_Value
	$NowTime = StringReplace($NowTime_Value, ":", "-")

	$Results_Template = $Data_Dir & "Results\PCarsDSOverview Log File_" & $NowTime & ".txt"

	If $Abfrage = 6 Then
		$Anzahl_Zeilen_ListView_LOG = _GUICtrlListView_GetItemCount($listview_LOG) - 1

		FileWriteLine($Results_Template, "--- PCDSG - Dedicated Server LOG ---" & @TAB & "<" &  _Now() & ">" & @CRLF & @CRLF)

		For $Schleife_LOG_speichern = 0 To $Anzahl_Zeilen_ListView_LOG
			$Inhalt_Zeile_LOG = _GUICtrlListView_GetItemTextArray($listview_LOG, $Schleife_LOG_speichern)

			$Anzahl_Zeilenumbrueche = @CRLF
			If $Schleife_LOG_speichern = $Anzahl_Zeilen_ListView_LOG Then $Anzahl_Zeilenumbrueche = @CRLF & @CRLF & @CRLF

			$Anzahl_Tabs = @TAB
			$Laenge_Name = StringLen($Inhalt_Zeile_LOG[3])
			If $Laenge_Name < 8 Then $Anzahl_Tabs = @TAB & @TAB & @TAB
			If $Laenge_Name > 8 Then $Anzahl_Tabs = @TAB & @TAB
			If $Laenge_Name > 16 Then $Anzahl_Tabs = @TAB

			Local $sText = $Inhalt_Zeile_LOG[1] & @TAB & $Inhalt_Zeile_LOG[2] & @TAB &  $Inhalt_Zeile_LOG[3] & $Anzahl_Tabs & $Inhalt_Zeile_LOG[4] & $Anzahl_Zeilenumbrueche

			FileWriteLine($Results_Template, $sText)
		Next
	EndIf
EndFunc

Func _LOG_Button9()
	$Abfrage = MsgBox(4, $msgbox_28, $msgbox_29 & @CRLF)

	If $Abfrage = 6 Then
		FileDelete($LOG_Data_INI)
		_GUICtrlListView_DeleteAllItems($listview_LOG)
		FileWriteLine($LOG_Data_INI, '[DATA]')
		FileWriteLine($LOG_Data_INI, 'NR=0')
	EndIf
EndFunc

Func _General_Button_1() ; RESULTS - Save all Data
	_Button6()
	_Button7()
	_LOG_Button8()
	_General_Button_2()
EndFunc

Func _General_Button_2()  ; LOG prüfen und TXT speichern
	Global $Index_NR_P1_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_Start", "")
	$Index_NR_P1_Start = Int($Index_NR_P1_Start)
	Global $Index_NR_P1_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_End", "")
	$Index_NR_P1_End = Int($Index_NR_P1_End)
	Global $Index_NR_P2_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Practice2_LogIndex_Start", "")
	$Index_NR_P2_Start = Int($Index_NR_P2_Start)
	Global $Index_NR_P2_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Practice2_LogIndex_End", "")
	$Index_NR_P2_End = Int($Index_NR_P2_End)
	Global $Index_NR_Q_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_Start", "")
	$Index_NR_Q_Start = Int($Index_NR_Q_Start)
	Global $Index_NR_Q_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_End", "")
	$Index_NR_Q_End = Int($Index_NR_Q_End)
	Global $Index_NR_W_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Warmup_LogIndex_Start", "")
	$Index_NR_W_Start = Int($Index_NR_W_Start)
	Global $Index_NR_W_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Warmup_LogIndex_End", "")
	$Index_NR_W_End = Int($Index_NR_W_End)
	Global $Index_NR_R1_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_Start", "")
	$Index_NR_R1_Start = Int($Index_NR_R1_Start)
	Global $Index_NR_R1_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_End", "")
	$Index_NR_R1_End = Int($Index_NR_R1_End)

	$Value_LOG_Start = -1000
	$Value_LOG_End = 1000

	If $Index_NR_R1_Start <> "" Then $Value_LOG_Start = $Index_NR_R1_Start
	If $Index_NR_W_Start <> "" Then $Value_LOG_Start = $Index_NR_W_Start
	If $Index_NR_Q_Start <> "" Then $Value_LOG_Start = $Index_NR_Q_Start
	If $Index_NR_P2_Start <> "" Then $Value_LOG_Start = $Index_NR_P2_Start
	If $Index_NR_P1_Start <> ""  Then $Value_LOG_Start = $Index_NR_P1_Start

	If $Index_NR_P1_End <> ""  Then $Value_LOG_End = $Index_NR_P1_End
	If $Index_NR_P2_End <> "" Then $Value_LOG_End = $Index_NR_P2_End
	If $Index_NR_Q_End <> "" Then $Value_LOG_End = $Index_NR_Q_End
	If $Index_NR_W_End <> "" Then $Value_LOG_End = $Index_NR_W_End
	If $Index_NR_R1_End <> "" Then $Value_LOG_End = $Index_NR_R1_End

	$Abfrage = MsgBox(4, $msgbox_30, $msgbox_31 & @CRLF & @CRLF & $msgbox_36 & @CRLF & "Start Index NR: " & $Value_LOG_Start & @CRLF & "End Index NR: " & $Value_LOG_End)

	If $Abfrage = 6 Then
		$EventsLogSize = IniRead($config_ini, "Server_Einstellungen", "eventsLogSize", "")

		$LOG_json = $install_dir & "data\LOG.json"

		$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
		$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

		If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
		If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

		$URL_LOG = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/log/range?offset=" & $Value_LOG_Start & "&count=" & $Value_LOG_End
		If FileExists($LOG_json) Then FileDelete($LOG_json)
		$download_LOG = InetGet($URL_LOG, $LOG_json, 16, 0)

		_LOG_1000_Check()
	EndIf
EndFunc

Func _General_Button_3() ;
	MsgBox(0, "Not available", "Function not available, working on it ...")
EndFunc

Func _LOG_1000_Check()

	MsgBox(0, "Start Creating", "This may take a while... Please wait...", 2)
	_GUICtrlStatusBar_SetText($Statusbar, "Creating SessionResults.txt, This may take a while... Please wait..." & @TAB & $Server_Status & @TAB & "Timestamp: " & $timestamp)

	$NowTime_Value = _NowTime()
	$NowTime_orig = $NowTime_Value
	$NowTime = StringReplace($NowTime_Value, ":", "-")

	$SessionResults_ini = $Data_Dir & "Results\PCarsDSOverview SessionResults_" & $NowTime & ".txt"

	$LOG_json = $install_dir & "data\LOG.json"

	$Wert_search = "Lap"
	$EventsLogSize = IniRead($config_ini, "Server_Einstellungen", "eventsLogSize", "")

	$Anzahl_Zeilen_LOG_1000 = _FileCountLines($LOG_json)

	$Wert_Check = ""

	If FileExists($SessionResults_ini) Then FileDelete($SessionResults_ini)

	$Schleife_LOG_1000_loop_NR = 1

	For $Schleife_LOG_1000 = 1 To $Anzahl_Zeilen_LOG_1000
		$Wert_Check = FileReadLine($LOG_json, $Schleife_LOG_1000)
		$Wert_Check = StringReplace($Wert_Check, '        "name" : ', '')
		$Wert_Check = StringReplace($Wert_Check, '"', '')
		$Wert_Check = StringReplace($Wert_Check, ',', '')

		If $Wert_Check = $Wert_search Then
			$Wert_index = FileReadLine($LOG_json, $Schleife_LOG_1000 - 2)
			$Wert_index = StringReplace($Wert_index, '        "index" : ', '')
			$Wert_index = StringReplace($Wert_index, ',', '')

			$SessionStage_Name = ""
			If $Wert_index <> "" Then

				Global $Index_NR_P1_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_Start", "")
				$Index_NR_P1_Start = Int($Index_NR_P1_Start)
				Global $Index_NR_P1_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_End", "")
				$Index_NR_P1_End = Int($Index_NR_P1_End)
				Global $Index_NR_P2_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Practice2_LogIndex_Start", "")
				$Index_NR_P2_Start = Int($Index_NR_P2_Start)
				Global $Index_NR_P2_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Practice2_LogIndex_End", "")
				$Index_NR_P2_End = Int($Index_NR_P2_End)
				Global $Index_NR_Q_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_Start", "")
				$Index_NR_Q_Start = Int($Index_NR_Q_Start)
				Global $Index_NR_Q_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_End", "")
				$Index_NR_Q_End = Int($Index_NR_Q_End)
				Global $Index_NR_W_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Warmup_LogIndex_Start", "")
				$Index_NR_W_Start = Int($Index_NR_W_Start)
				Global $Index_NR_W_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Warmup_LogIndex_End", "")
				$Index_NR_W_End = Int($Index_NR_W_End)
				Global $Index_NR_R1_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_Start", "")
				$Index_NR_R1_Start = Int($Index_NR_R1_Start)
				Global $Index_NR_R1_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_End", "")
				$Index_NR_R1_End = Int($Index_NR_R1_End)

				If $Wert_index > $Index_NR_P1_Start and $Wert_index < $Index_NR_P1_End Then $SessionStage_Name = "Practice1_"
				If $Wert_index > $Index_NR_P2_Start and $Wert_index < $Index_NR_P2_End Then $SessionStage_Name = "Practice2_"
				If $Wert_index > $Index_NR_Q_Start and $Wert_index < $Index_NR_Q_End Then $SessionStage_Name = "Qualifying_"
				If $Wert_index > $Index_NR_W_Start and $Wert_index < $Index_NR_W_End Then $SessionStage_Name = "Warmup_"
				If $Wert_index > $Index_NR_R1_Start and $Wert_index < $Index_NR_R1_End Then $SessionStage_Name = "Race1_"
			EndIf

			If $SessionStage_Name <> "" Then
				$Wert_time = FileReadLine($LOG_json, $Schleife_LOG_1000 - 1)
				$Wert_time = StringReplace($Wert_time, '        "time" : ', '')
				$Wert_time = StringReplace($Wert_time, ',', '')

				$Wert_name = FileReadLine($LOG_json, $Schleife_LOG_1000)
				$Wert_name = StringReplace($Wert_name, '        "name" : "', '')
				$Wert_name = StringReplace($Wert_name, ',', '')

				$Wert_refid = ""
				$Wert_refid = FileReadLine($LOG_json, $Schleife_LOG_1000 + 1)
				$Wert_refid = StringReplace($Wert_refid, '        "refid" : ', '')
				$Wert_refid = StringReplace($Wert_refid, ',', '')

				$Wert_participantid = FileReadLine($LOG_json, $Schleife_LOG_1000 + 2)
				$Wert_participantid = StringReplace($Wert_participantid, '        "participantid" : ', '')
				$Wert_participantid = StringReplace($Wert_participantid, ',', '')

				$Wert_Lap = FileReadLine($LOG_json, $Schleife_LOG_1000 + 4)
				$Wert_Lap = StringReplace($Wert_Lap, '          "Lap" : ', '')
				$Wert_Lap = StringReplace($Wert_Lap, ',', '')

				$Wert_LapTime = FileReadLine($LOG_json, $Schleife_LOG_1000 + 5)
				$Wert_LapTime = StringReplace($Wert_LapTime, '          "LapTime" : ', '')
				$Wert_LapTime = StringReplace($Wert_LapTime, ',', '')
				$Wert = $Wert_LapTime
				_Time_Update()
				$Wert_LapTime = $Wert

				$Wert_Sector1Time = FileReadLine($LOG_json, $Schleife_LOG_1000 + 6)
				$Wert_Sector1Time = StringReplace($Wert_Sector1Time, '          "Sector1Time" : ', '')
				$Wert_Sector1Time = StringReplace($Wert_Sector1Time, ',', '')
				$Wert = $Wert_Sector1Time
				_Time_Update()
				$Wert_Sector1Time = $Wert

				$Wert_Sector2Time = FileReadLine($LOG_json, $Schleife_LOG_1000 + 7)
				$Wert_Sector2Time = StringReplace($Wert_Sector2Time, '          "Sector2Time" : ', '')
				$Wert_Sector2Time = StringReplace($Wert_Sector2Time, ',', '')
				$Wert = $Wert_Sector2Time
				_Time_Update()
				$Wert_Sector2Time = $Wert

				$Wert_Sector3Time = FileReadLine($LOG_json, $Schleife_LOG_1000 + 8)
				$Wert_Sector3Time = StringReplace($Wert_Sector3Time, '          "Sector3Time" : ', '')
				$Wert_Sector3Time = StringReplace($Wert_Sector3Time, ',', '')
				$Wert = $Wert_Sector3Time
				_Time_Update()
				$Wert_Sector3Time = $Wert

				$Wert_RacePosition = FileReadLine($LOG_json, $Schleife_LOG_1000 + 9)
				$Wert_RacePosition = StringReplace($Wert_RacePosition, '          "RacePosition" : ', '')
				$Wert_RacePosition = StringReplace($Wert_RacePosition, ',', '')

				$Wert_DistanceTravelled = FileReadLine($LOG_json, $Schleife_LOG_1000 + 10)
				$Wert_DistanceTravelled = StringReplace($Wert_DistanceTravelled, '          "DistanceTravelled" : ', '')
				$Wert_DistanceTravelled = StringReplace($Wert_DistanceTravelled, ',', '')

				$Wert_CountThisLapTimes = FileReadLine($LOG_json, $Schleife_LOG_1000 + 11)
				$Wert_CountThisLapTimes = StringReplace($Wert_CountThisLapTimes, '          "CountThisLapTimes" : ', '')

				Global $Wert_Check_refid, $Wert_refid

				$DS_Name = IniRead($config_ini, "Server_Einstellungen", "name", "")
				$PCDSG_Version = IniRead($config_ini, "Einstellungen", "Version", "")
				$Race1Length = IniRead($Server_Data_INI, "DATA", "Race1Length", "")
				$Flags = IniRead($Server_Data_INI, "DATA", "Flags", "")
				$DamageType = IniRead($Server_Data_INI, "DATA", "DamageType", "")
				$TireWearType = IniRead($Server_Data_INI, "DATA", "TireWearType", "")
				$FuelUsageType = IniRead($Server_Data_INI, "DATA", "FuelUsageType", "")
				$PenaltiesType = IniRead($Server_Data_INI, "DATA", "PenaltiesType", "")
				$AllowedViews = IniRead($Server_Data_INI, "DATA", "AllowedViews", "")
				$TrackId = IniRead($Server_Data_INI, "DATA", "TrackId", "")
				$VehicleClassId = IniRead($Server_Data_INI, "DATA", "VehicleClassId", "")
				$GameMode = IniRead($Server_Data_INI, "DATA", "GameMode", "")
				$SessionPhase = IniRead($Server_Data_INI, "DATA", "SessionPhase", "")
				$NumParticipantsValid = IniRead($Server_Data_INI, "DATA", "NumParticipantsValid", "")

				$Wert_Track_ID_search = $TrackId
				$Wert_Track = IniRead($Server_Data_INI, "DATA", "TrackName", "")
				$TrackName = $Wert_Track

				$PitStop = ""
				$Check_PitStop = IniRead($Info_PitStops_ini, $LOG_Name_from_refid, "PitStops","")
				If $Check_PitStop <> "" Then $PitStop = $Check_PitStop

				$PenaltyPoints = ""
				$Check_PenaltyPoints_PP = IniRead($Points_ini, $LOG_Name_from_refid, "PenaltyPoints","")
				$PenaltyPoints = $Check_PenaltyPoints_PP

				$ExperiencePoints = ""
				$Check_ExperiencePoints_PP = IniRead($Points_ini, $LOG_Name_from_refid, "ExperiencePoints", "")
				$ExperiencePoints = $Check_ExperiencePoints_PP

				If $Schleife_LOG_1000_loop_NR = "1" Then
					IniWrite($SessionResults_ini, "Header", "Game", "Project Cars")
					IniWrite($SessionResults_ini, "Header", "PCDSG Version", $PCDSG_Version)
					IniWrite($SessionResults_ini, "Header", "TimeString", _Now())
					IniWrite($SessionResults_ini, "Header", "SessionName", $DS_Name)
					IniWrite($SessionResults_ini, "Header", "SessionPhase", $SessionPhase)
					IniWrite($SessionResults_ini, "Header", "NumParticipantsValid", $NumParticipantsValid)
					If $Schleife_LOG_1000_loop_NR = "1" Then FileWriteLine($SessionResults_ini, " ")

					IniWrite($SessionResults_ini, "Session", "Track", $TrackName & " | " & $TrackId)
					IniWrite($SessionResults_ini, "Session", "VehicleClassId", $VehicleClassId)
					;IniWrite($SessionResults_ini, "Session", "VehicleModelId", $VehicleModelId)
					IniWrite($SessionResults_ini, "Session", "Race Length", $Race1Length)
					If $Schleife_LOG_1000_loop_NR = "1" Then FileWriteLine($SessionResults_ini, " ")

					IniWrite($SessionResults_ini, "SessionAttributes", "Flags", $Flags)
					IniWrite($SessionResults_ini, "SessionAttributes", "DamageType", $DamageType)
					IniWrite($SessionResults_ini, "SessionAttributes", "TireWearType", $TireWearType)
					IniWrite($SessionResults_ini, "SessionAttributes", "FuelUsageType", $FuelUsageType)
					IniWrite($SessionResults_ini, "SessionAttributes", "PenaltiesType", $PenaltiesType)
					IniWrite($SessionResults_ini, "SessionAttributes", "AllowedViews", $AllowedViews)
					IniWrite($SessionResults_ini, "SessionAttributes", "GameMode", $GameMode)
					If $Schleife_LOG_1000_loop_NR = "1" Then FileWriteLine($SessionResults_ini, " ")
				EndIf


				Global $Index_NR_P1_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_Start", "")
				$Index_NR_P1_Start = Int($Index_NR_P1_Start)
				Global $Index_NR_P1_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Practice1_LogIndex_End", "")
				$Index_NR_P1_End = Int($Index_NR_P1_End)
				Global $Index_NR_P2_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Practice2_LogIndex_Start", "")
				$Index_NR_P2_Start = Int($Index_NR_P2_Start)
				Global $Index_NR_P2_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Practice2_LogIndex_End", "")
				$Index_NR_P2_End = Int($Index_NR_P2_End)
				Global $Index_NR_Q_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_Start", "")
				$Index_NR_Q_Start = Int($Index_NR_Q_Start)
				Global $Index_NR_Q_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Qualifying_LogIndex_End", "")
				$Index_NR_Q_End = Int($Index_NR_Q_End)
				Global $Index_NR_W_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Warmup_LogIndex_Start", "")
				$Index_NR_W_Start = Int($Index_NR_W_Start)
				Global $Index_NR_W_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Warmup_LogIndex_End", "")
				$Index_NR_W_End = Int($Index_NR_W_End)
				Global $Index_NR_R1_Start = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_Start", "")
				$Index_NR_R1_Start = Int($Index_NR_R1_Start)
				Global $Index_NR_R1_End = IniRead($PCarsDSOverview_INI, "Log_Session_Status", "Race1_LogIndex_End", "")
				$Index_NR_R1_End = Int($Index_NR_R1_End)

				$Check_Index_Exist = IniRead($SessionResults_ini, $Wert_refid, "Index", "")

				$SessionStage_Name = ""
				If $Wert_index <> "" Then
					If $Wert_index > $Index_NR_P1_Start and $Wert_index < $Index_NR_P1_End Then $SessionStage_Name = "Practice1_"
					If $Wert_index > $Index_NR_P2_Start and $Wert_index < $Index_NR_P2_End Then $SessionStage_Name = "Practice2_"
					If $Wert_index > $Index_NR_Q_Start and $Wert_index < $Index_NR_Q_End Then $SessionStage_Name = "Qualifying_"
					If $Wert_index > $Index_NR_W_Start and $Wert_index < $Index_NR_W_End Then $SessionStage_Name = "Warmup_"
					If $Wert_index > $Index_NR_R1_Start and $Wert_index < $Index_NR_R1_End Then $SessionStage_Name = "Race1_"
				EndIf

				$Name_Value = IniRead($Participants_Data_INI, $Wert_refid, "Name", "")
				If $Name_Value = "" Then $Name_Value = IniRead($Members_Data_INI, $Wert_refid, "Name", "")

				$Now_Date_Time = _Now()

				If $Wert_refid <> "" and $SessionStage_Name <> "" Then
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "Index", $Wert_index)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "Time", $Now_Date_Time)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "Name", $Name_Value)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "RefID", $Wert_refid)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "ParticipantID", $Wert_participantid)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "Laps", $Wert_Lap)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "PitStops", $PitStop)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "PenaltyPoints", $PenaltyPoints)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "ExperiencePoints", $ExperiencePoints)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "LAP_" & $Wert_Lap & "_LapTime", $Wert_LapTime)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "LAP_" & $Wert_Lap & "_Sector1Time", $Wert_Sector1Time)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "LAP_" & $Wert_Lap & "_Sector2Time", $Wert_Sector2Time)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "LAP_" & $Wert_Lap & "_Sector3Time", $Wert_Sector3Time)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "LAP_" & $Wert_Lap & "_RacePosition", $Wert_RacePosition)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "LAP_" & $Wert_Lap & "_DistanceTravelled", $Wert_DistanceTravelled)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RacePosition_" & $Wert_RacePosition, "LAP_" & $Wert_Lap & "_CountThisLapTimes", $Wert_CountThisLapTimes)
					FileWriteLine($SessionResults_ini, " ")

					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "Index", $Wert_index)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "Time", $Now_Date_Time)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "Name", $Name_Value)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "RefID", $Wert_refid)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "ParticipantID", $Wert_participantid)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "Laps", $Wert_Lap)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "PitStops", $PitStop)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "PenaltyPoints", $PenaltyPoints)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "ExperiencePoints", $ExperiencePoints)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "LAP_" & $Wert_Lap & "_LapTime", $Wert_LapTime)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "LAP_" & $Wert_Lap & "_Sector1Time", $Wert_Sector1Time)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "LAP_" & $Wert_Lap & "_Sector2Time", $Wert_Sector2Time)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "LAP_" & $Wert_Lap & "_Sector3Time", $Wert_Sector3Time)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "LAP_" & $Wert_Lap & "_RacePosition", $Wert_RacePosition)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "LAP_" & $Wert_Lap & "_DistanceTravelled", $Wert_DistanceTravelled)
					IniWrite($SessionResults_ini, $SessionStage_Name & "RefID_" & $Wert_refid, "LAP_" & $Wert_Lap & "_CountThisLapTimes", $Wert_CountThisLapTimes)
					FileWriteLine($SessionResults_ini, " ")

					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "Index", $Wert_index)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "Time", $Now_Date_Time)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "Name", $Name_Value)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "RefID", $Wert_refid)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "ParticipantID", $Wert_participantid)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "Laps", $Wert_Lap)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "PitStops", $PitStop)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "PenaltyPoints", $PenaltyPoints)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "ExperiencePoints", $ExperiencePoints)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "LAP_" & $Wert_Lap & "_LapTime", $Wert_LapTime)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "LAP_" & $Wert_Lap & "_Sector1Time", $Wert_Sector1Time)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "LAP_" & $Wert_Lap & "_Sector2Time", $Wert_Sector2Time)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "LAP_" & $Wert_Lap & "_Sector3Time", $Wert_Sector3Time)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "LAP_" & $Wert_Lap & "_RacePosition", $Wert_RacePosition)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "LAP_" & $Wert_Lap & "_DistanceTravelled", $Wert_DistanceTravelled)
					IniWrite($SessionResults_ini, $SessionStage_Name & "Name" & $Name_Value, "LAP_" & $Wert_Lap & "_CountThisLapTimes", $Wert_CountThisLapTimes)
					FileWriteLine($SessionResults_ini, " ")
				EndIf
			EndIf
			$Schleife_LOG_1000_loop_NR = $Schleife_LOG_1000_loop_NR + 1
		EndIf
		$Wert_Fortschrittbalken = $Schleife_LOG_1000 / ($Anzahl_Zeilen_LOG_1000 / 100)
		GUICtrlSetData($Anzeige_Fortschrittbalken, $Wert_Fortschrittbalken)
	Next
	If FileExists($LOG_json) Then FileDelete($LOG_json)

	If FileExists($SessionResults_ini) Then $Abfrage = MsgBox(4, "Finish Creating", "File successfully created." & @CRLF & @CRLF & "Do you want to open the File?", 5)
	If Not FileExists($SessionResults_ini) Then $Abfrage = MsgBox(4, "File not created", "File was not created." & @CRLF & @CRLF & "Maybe not enough Log events available?", 5)

	If $Abfrage = 6 Then ;Ja - Auswahl = JA
		If FileExists($SessionResults_ini) Then ShellExecute($SessionResults_ini)
	EndIf
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

Func _Auto_KICK_List()
	$Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
	$Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

	If $Lesen_Auswahl_httpApiInterface = "" Then $Lesen_Auswahl_httpApiInterface = "127.0.0.1"
	If $Lesen_Auswahl_httpApiPort = "" Then $Lesen_Auswahl_httpApiPort = "9000"

	$KICK_USER_NR = 0

	For $Kick_Schleife_1 = 1 To _FileCountLines(@ScriptDir & "\KICK_LIST.txt")
	$refid = FileReadLine(@ScriptDir & "\KICK_LIST.txt", $Kick_Schleife_1)

	If $refid <> "" Then
	$URL_KICK = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid ; & "&redirect=status"
	$download = InetGet($URL_KICK, $KICK_BAN_TXT, 16, 0)
	$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)
	If $Check_KICK_BAN = '  "result" : "ok"' Then $KICK_USER_NR = $KICK_USER_NR + 1
	EndIf

	Next

	If $KICK_USER_NR > 0 Then _GUICtrlStatusBar_SetText($Statusbar, $KICK_USER_NR & " User was KICKED" & @TAB & $Server_Status & @TAB & "Timestamp: " & $timestamp)
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

	$URL_KICK = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/kick?refid=" & $refid ; & "&redirect=status"
	$download = InetGet($URL_KICK, $KICK_BAN_TXT, 16, 0)

	$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)
	If $Check_KICK_BAN = '  "result" : "ok"' Then _GUICtrlStatusBar_SetText($Statusbar, "PCDSG Action: " & "User " & $KICK_User & " was KICKED by PCDSG")
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

	$Check_KICK_BAN = FileReadLine($KICK_BAN_TXT, 2)
	If $Check_KICK_BAN = '  "result" : "ok"' Then _GUICtrlStatusBar_SetText($Statusbar, "PCDSG Action: " & "User " & $KICK_User & " was KICKED by PCDSG")
EndFunc

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $iwParam
	Local $hWndFrom, $iCode, $tNMHDR, $hWndListView, $Tmp
	$hWndListView = $ListView
	If Not IsHWnd($ListView) Then $hWndListView = GUICtrlGetHandle($ListView)
	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hWndListView
			Switch $iCode
				Case $NM_DBLCLK ; Sent by a list-view control when the user double-clicks an item with the left mouse button
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$Tmp = _GuiCtrlListView_GetFirstSelected($ListView)
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc

Func _GuiCtrlListView_GetFirstSelected($hWnd)
	Global $SelectedItemi
	$SelectedItemi = _GUICtrlListView_GetSelectedIndices($hWnd, True)
	If $SelectedItemi[0] = 0 Then Return SetError(1)
	Return $SelectedItemi[1]
	MsgBox(0, "1", $SelectedItemi[1])
EndFunc

Func _Name_from_refid()
	For $Schleife_MFR = 1 To 32
		$Check_refid_Label = IniRead($Members_Data_INI, "DATA", "Label_" & $Schleife_MFR & "_2", "")

		If $Check_refid_Label = "refid" Then
			$Check_refid = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_2", "")
		Else
			$Check_refid = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_3", "")
		EndIf

		If $Check_refid = $Wert_Check_refid Then
			$Check_refid_Label = IniRead($Members_Data_INI, "DATA", "Label_" & $Schleife_MFR & "_2", "")

			If $Check_refid_Label = "refid" Then
				Global $LOG_Name_Label_4 = IniRead($Members_Data_INI, "DATA", "Label_" & $Schleife_MFR & "_5", "")
				Global $LOG_Name_value_4 = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_5", "")
				Global $LOG_Name_from_refid = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_5", "")
				$Schleife_MFR = 32
			Else
				Global $LOG_Name_Label_4 = IniRead($Members_Data_INI, "DATA", "Label_" & $Schleife_MFR & "_6", "")
				Global $LOG_Name_value_4 = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_6", "")
				Global $LOG_Name_from_refid = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_6", "")
				$Schleife_MFR = 32
			EndIf
		EndIf
	Next
EndFunc

Func _Name_from_refid_UH()
	For $Schleife_MFR = 1 To 32
		$Check_refid_Label = IniRead($Members_Data_INI, "DATA", "Label_" & $Schleife_MFR & "_2", "")

		If $Check_refid_Label = "refid" Then
			$Check_refid = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_2", "")
		Else
			$Check_refid = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_3", "")
		EndIf

		If $Check_refid = $Wert_Check_refid Then
			$Check_refid_Label = IniRead($Members_Data_INI, "DATA", "Label_" & $Schleife_MFR & "_2", "")

			If $Check_refid_Label = "refid" Then
				Global $LOG_Name_Label_4 = IniRead($Members_Data_INI, "DATA", "Label_" & $Schleife_MFR & "_5", "")
				$LOG_Name_value_4 = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_5", "")
				Global $LOG_Name_from_refid = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_5", "")
				$Schleife_MFR = 32
			Else
				Global $LOG_Name_Label_4 = IniRead($Members_Data_INI, "DATA", "Label_" & $Schleife_MFR & "_6", "")
				$LOG_Name_value_4 = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_6", "")
				Global $LOG_Name_from_refid = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_6", "")
				$Schleife_MFR = 32
			EndIf
		EndIf
	Next
EndFunc

Func _Time_Update()
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

Func _Host_Check_from_refid()
	For $Schleife_MFR = 1 To 32
		$Check_refid_members = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_3", "")
		Global $Check_Host = IniRead($Members_Data_INI, "DATA", "Value_" & $Schleife_MFR & "_8", "")
		Global $refid_log

		If $Check_refid_members = $refid_log Then
			If $Check_Host = "true" Then Global $LOG_Check_Host_Value = "true"
			$Schleife_MFR = 32
		EndIf
	Next
EndFunc

Func _Tab3_Pfad_Button_1_Aktion()
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
EndFunc

Func _Tab3_Pfad_Button_2_Aktion()
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
EndFunc

Func _Tab3_Pfad_Button_3_Aktion()
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
EndFunc

Func _Tab3_Pfad_Button_4_Aktion()
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
EndFunc

Func _Tab3_Pfad_Button_5_Aktion()
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
EndFunc

Func _Beenden()
	Exit
EndFunc
#endregion Start Funktionen
