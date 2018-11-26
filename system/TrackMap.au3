

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

Global $ListView, $ListView_Produktinformationen, $iMemo_unten, $idTreeView, $Statusbar, $GUI, $id_Projekt, $iwParam
Global $Func_Neuen_Ordner_erstellen_ausgefuert, $Verzeichnisse_aktualisieren_ausgefuert, $Verzeichnis_Produkte, $Aufnahme_lauft_icon
Global $ZM_LabelGZ2, $ZM_LabelGZ3, $ZM_LabelGZ4, $ZM_LabelGZ5, $ZM_LabelGZ6, $ZM_LabelGZ7, $ZM_LabelGZ8, $ZM_LabelGZ9, $ZM_LabelGZ10, $ZM_LabelGZ11, $ZM_LabelGZ12, $ZM_LabelGZ13, $ZM_LabelG14, $ZM_LabelGZ15
Global $status_json, $LOG_Data_json, $Server_Data_INI, $Members_Data_INI, $Participants_Data_INI, $Info_drivers_AT_ini, $LOG_Data_INI
Global $Anzahl_Werte_LOG, $Schleife_ListView_aktualisieren, $Seconds_to_Time, $iRetH, $iRetM, $iRetS, $iSec, $Wert_Time

Global $Wert_Track_ID, $Wert_Car, $Wert_Tack, $Wert_Wert
Global $Wert_Points, $Wert_PP_Points, $Wert_Experience_Points, $Wert_Experience_Points_NEW

Global $Wert_Check_refid, $LOG_Name_from_refid

Global $ListView_Pos_1, $ListView_Pos_2, $ListView_Pos_3, $ListView_Pos_4, $ListView_Pos_5, $ListView_Pos_6, $ListView_Pos_7, $ListView_Pos_8, $ListView_Pos_9, $ListView_Pos_10
Global $ListView_Pos_11, $ListView_Pos_12, $ListView_Pos_13, $ListView_Pos_14, $ListView_Pos_15, $ListView_Pos_16, $ListView_Pos_17, $ListView_Pos_18, $ListView_Pos_19, $ListView_Pos_20
Global $ListView_Pos_21, $ListView_Pos_22, $ListView_Pos_23, $ListView_Pos_24, $ListView_Pos_25, $ListView_Pos_26, $ListView_Pos_27, $ListView_Pos_28, $ListView_Pos_29, $ListView_Pos_30
Global $ListView_Pos_31, $ListView_Pos_32

Opt("GUIOnEventMode", 1)
Opt("GUIDataSeparatorChar", "|") ;"|" is the default

$ListViewSeperator = "|"

Global $NowDate_Value = _NowDate()
Global $NowDate = StringReplace($NowDate_Value, "/", ".")
Global $NowTime_Value = _NowTime()
Global $NowTime_orig = $NowTime_Value
Global $NowTime = StringReplace($NowTime_Value, ":", "-")


#Region Global Variables / Const
Global $Wert, $ListView
#endregion Global Variables/Const

#Region Declare Variables / Const
;VARIABLEN SETZEN
Global $config_ini = (@ScriptDir & "\" & "config.ini")
Global $install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
Global $System_Dir = $install_dir & "system\"
Global $gfx = $System_Dir & "gfx\"
Global $Sprachdatei = IniRead($config_ini,"Einstellungen", "Sprachdatei", "")
Global $PCDSG_LOG_ini = $System_Dir & "PCDSG_LOG.ini"

Global $TrackMap_INI = $System_Dir & "TrackMap\TrackMap.ini"
Global $TrackMapReplay_INI = $System_Dir & "TrackMap\TrackMapReplay.ini"

Global $Results_folder = $install_dir & "data\Results\"

Global $status_json = $System_Dir & "status.json"
Global $LOG_Data_json = $System_Dir & "Server_LOG.json"
Global $TrackMap_participants_json = $System_Dir & "TrackMap\TrackMap_participants.json"
Global $Server_Data_INI = $System_Dir  & "Server_Data.ini"
Global $Members_Data_INI = $System_Dir & "Members_Data.ini"
Global $Participants_Data_INI = $System_Dir & "Participants_Data.ini"
Global $TrackMap_participants_Data_INI = $System_Dir & "TrackMap\TrackMap_participants_Data.ini"
Global $UserHistory_ini = $System_Dir & "UserHistory.ini"
Global $LOG_Data_INI = $System_Dir & "Server_LOG.ini"
Global $PitStops_ini = $System_Dir & "PitStops.ini"
Global $Points_ini = $System_Dir & "Points.ini"
Global $Stats_INI = $System_Dir & "Stats.ini"
Global $CutTrack_INI = $System_Dir & "CutTrack.ini"
Global $Impact_INI = $System_Dir & "Impact.ini"

Global $Check_Checkbox_Position_Shadow = IniRead($config_ini, "TrackMap", "Checkbox_1", "")
Global $Check_Checkbox_Show_Track = IniRead($config_ini, "TrackMap", "Checkbox_2", "")

Global $TrackName_Replay, $SessionStage_Replay

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

;$Lesen_Auswahl_httpApiInterface = $Name_Password & "www.annonymous-chiller.de"

#endregion Declare Variables/Const

#Region Declare Variables / Const
$Label_ListView_1_Column_1 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_1", "Name")
$Label_ListView_1_Column_2 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_2", "Grid Pos.")
$Label_ListView_1_Column_3 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_3", "Car")
$Label_ListView_1_Column_4 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_4", "Pos.")
$Label_ListView_1_Column_5 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_5", "In LAP")
$Label_ListView_1_Column_6 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_6", "In Sector")
$Label_ListView_1_Column_7 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_7", "Sector 1")
$Label_ListView_1_Column_8 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_8", "Sector 2")
$Label_ListView_1_Column_9 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_9", "Sector 3")
$Label_ListView_1_Column_10 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_10", "Last Lap")
$Label_ListView_1_Column_11 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_11", "Fastest Lap")
$Label_ListView_1_Column_12 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_12", "State")
$Label_ListView_1_Column_13 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_13", "Pit")
$Label_ListView_1_Column_14 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_14", "Poi")
$Label_ListView_1_Column_15 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_15", "War")
$Label_ListView_1_Column_16 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_16", "Pers. Best")
$Label_ListView_1_Column_17 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_17", "EP")
$Label_ListView_1_Column_18 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_18", "TC")
$Label_ListView_1_Column_19 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_19", "IP")
$Label_ListView_1_Column_20 = IniRead($Sprachdatei,"Language", "Infos_view_pb_Label_Column_20", "Speed")
#endregion Declare Variables/Const

#Region Set Colors
$Farbe_State_ListView_Participants = $COLOR_BLACK

Global $Farbe_BLACK = 0x000000
Global $Navy = 0x000080
Global $Farbe_DarkBlue = 0x00008B
Global $Farbe_MediumBlue = 0x0000CD
Global $Farbe_Blue = 0x0000FF
Global $Farbe_DarkGreen = 0x006400
Global $Farbe_Green = 0x008000
Global $Farbe_Teal = 0x008080
Global $Farbe_DarkCyan = 0x008B8B
Global $Farbe_DeepSkyBlue = 0x00BFFF
Global $Farbe_DarkTurquoise = 0x00CED1
Global $Farbe_MediumSpringGreen = 0x00FA9A
Global $Farbe_Lime = 0x00FF00
Global $Farbe_SpringGreen = 0x00FF7F
Global $Farbe_Aqua = 0x00FFFF
Global $Farbe_Cyan = 0x00FFFF
Global $Farbe_MidnightBlue = 0x191970
Global $Farbe_DodgerBlue = 0x1E90FF
Global $Farbe_LightSeaGreen = 0x20B2AA
Global $Farbe_ForestGreen = 0x228B22
Global $Farbe_SeaGreen = 0x2E8B57
Global $Farbe_DarkSlateGray = 0x2F4F4F
Global $Farbe_LimeGreen = 0x32CD32
Global $Farbe_MediumSeaGreen = 0x3CB371
Global $Farbe_Turquoise = 0x40E0D0
Global $Farbe_RoyalBlue = 0x4169E1
Global $Farbe_SteelBlue = 0x4682B4
Global $Farbe_DarkSlateBlue = 0x483D8B
Global $Farbe_MediumTurquoise = 0x48D1CC
Global $Farbe_Indigo = 0x4B0082
Global $Farbe_DarkOliveGreen = 0x556B2F
Global $Farbe_CadetBlue = 0x5F9EA0
Global $Farbe_CornflowerBlue = 0x6495ED
Global $Farbe_MediumAquaMarine = 0x66CDAA
Global $Farbe_DimGray = 0x696969
Global $Farbe_SlateBlue = 0x6A5ACD
Global $Farbe_OliveDrab = 0x6B8E23
Global $Farbe_SlateGray = 0x708090
Global $Farbe_LightSlateGray = 0x778899
Global $Farbe_MediumSlateBlue = 0x7B68EE
Global $Farbe_LawnGreen = 0x7CFC00
Global $Farbe_Chartreuse = 0x7FFF00
Global $Farbe_Aquamarine = 0x7FFFD4
Global $Farbe_Maroon = 0x800000
Global $Farbe_Purple = 0x800080
Global $Farbe_Olive = 0x808000
Global $Farbe_Gray = 0x808080
Global $Farbe_SkyBlue = 0x87CEEB
Global $Farbe_LightSkyBlue = 0x87CEFA
Global $Farbe_BlueViolet = 0x8A2BE2
Global $Farbe_DarkRed = 0x8B0000
Global $Farbe_DarkMagenta = 0x8B008B
Global $Farbe_SaddleBrown = 0x8B4513
Global $Farbe_DarkSeaGreen = 0x8FBC8F
Global $Farbe_LightGreen = 0x90EE90
Global $Farbe_MediumPurple = 0x9370D8
Global $Farbe_DarkViolet = 0x9400D3
Global $Farbe_PaleGreen = 0x98FB98
Global $Farbe_DarkOrchid = 0x9932CC
Global $Farbe_YellowGreen = 0x9ACD32
Global $Farbe_Sienna = 0xA0522D
Global $Farbe_Brown = 0xA52A2A
Global $Farbe_DarkGray = 0xA9A9A9
Global $Farbe_LightBlue = 0xADD8E6
Global $Farbe_GreenYellow = 0xADFF2F
Global $Farbe_PaleTurquoise = 0xAFEEEE
Global $Farbe_LightSteelBlue = 0xB0C4DE
Global $Farbe_PowderBlue = 0xB0E0E6
Global $Farbe_FireBrick = 0xB22222
Global $Farbe_DarkGoldenRod = 0xB8860B
Global $Farbe_MediumOrchid = 0xBA55D3
Global $Farbe_RosyBrown = 0xBC8F8F
Global $Farbe_DarkKhaki = 0xBDB76B
Global $Farbe_Silver = 0xC0C0C0
Global $Farbe_MediumVioletRed = 0xC71585
Global $Farbe_IndianRed = 0xCD5C5C
Global $Farbe_Peru = 0xCD853F
Global $Farbe_Chocolate = 0xD2691E
Global $Farbe_Tan = 0xD2B48C
Global $Farbe_LightGrey = 0xD3D3D3
Global $Farbe_PaleVioletRed = 0xD87093
Global $Farbe_Thistle = 0xD8BFD8
Global $Farbe_Orchid = 0xDA70D6
Global $Farbe_GoldenRod = 0xDAA520
Global $Farbe_Crimson = 0xDC143C
Global $Farbe_Gainsboro = 0xDCDCDC
Global $Farbe_Plum = 0xDDA0DD
Global $Farbe_BurlyWood = 0xDEB887
Global $Farbe_LightCyan = 0xE0FFFF
Global $Farbe_Lavender = 0xE6E6FA
Global $Farbe_DarkSalmon = 0xE9967A
Global $Farbe_Violet = 0xEE82EE
Global $Farbe_PaleGoldenRod = 0xEEE8AA
Global $Farbe_LightCoral = 0xF08080
Global $Farbe_Khaki = 0xF0E68C
Global $Farbe_AliceBlue = 0xF0F8FF
Global $Farbe_HoneyDew = 0xF0FFF0
Global $Farbe_Azure = 0xF0FFFF
Global $Farbe_SandyBrown = 0xF4A460
Global $Farbe_Wheat = 0xF5DEB3
Global $Farbe_Beige = 0xF5F5DC
Global $Farbe_WhiteSmoke = 0xF5F5F5
Global $Farbe_MintCream = 0xF5FFFA
Global $Farbe_GhostWhite = 0xF8F8FF
Global $Farbe_Salmon = 0xFA8072
Global $Farbe_AntiqueWhite = 0xFAEBD7
Global $Farbe_Linen = 0xFAF0E6
Global $Farbe_LightGoldenRodYellow = 0xFAFAD2
Global $Farbe_OldLace = 0xFDF5E6
Global $Farbe_Red = 0xFF0000
Global $Farbe_Fuchsia = 0xFF00FF
Global $Farbe_Magenta = 0xFF00FF
Global $Farbe_DeepPink = 0xFF1493
Global $Farbe_OrangeRed = 0xFF4500
Global $Farbe_Tomato = 0xFF6347
Global $Farbe_HotPink = 0xFF69B4
Global $Farbe_Coral = 0xFF7F50
Global $Farbe_Darkorange = 0xFF8C00
Global $Farbe_LightSalmon = 0xFFA07A
Global $Farbe_Orange = 0xFFA500
Global $Farbe_LightPink = 0xFFB6C1
Global $Farbe_Pink = 0xFFC0CB
Global $Farbe_Gold = 0xFFD700
Global $Farbe_PeachPuff = 0xFFDAB9
Global $Farbe_NavajoWhite = 0xFFDEAD
Global $Farbe_Moccasin = 0xFFE4B5
Global $Farbe_Bisque = 0xFFE4C4
Global $Farbe_MistyRose = 0xFFE4E1
Global $Farbe_BlanchedAlmond = 0xFFEBCD
Global $Farbe_PapayaWhip = 0xFFEFD5
Global $Farbe_LavenderBlush = 0xFFF0F5
Global $Farbe_SeaShell = 0xFFF5EE
Global $Farbe_Cornsilk = 0xFFF8DC
Global $Farbe_LemonChiffon = 0xFFFACD
Global $Farbe_FloralWhite = 0xFFFAF0
Global $Farbe_Snow = 0xFFFAFA
Global $Farbe_Yellow = 0xFFFF00
Global $Farbe_LightYellow = 0xFFFFE0
Global $Farbe_Ivory = 0xFFFFF0
Global $Farbe_White = 0xFFFFFF
#EndRegion

#Region Set Scale Values
Global $Tack_Name_Scale = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
Global $Check_Track_Scale_Exists = IniRead($TrackMap_INI, $Tack_Name_Scale, "Track", "")

Global $Tack_Size_Scale_Value = IniRead($TrackMap_INI, "TrackMap", "Scale", "")
Global $X_Plus = IniRead($TrackMap_INI, "TrackMap", "X", "")
Global $Y_Plus = IniRead($TrackMap_INI, "TrackMap", "Y", "")

If $Check_Track_Scale_Exists <> "" Then
$Tack_Size_Scale_Value = IniRead($TrackMap_INI, $Tack_Name_Scale, "Scale", "")
$X_Plus = IniRead($TrackMap_INI, $Tack_Name_Scale, "X", "")
$Y_Plus = IniRead($TrackMap_INI, $Tack_Name_Scale, "Y", "")
$timestamp = _NowDate() & " - " & _NowTime()
_GUICtrlStatusBar_SetText($Statusbar, "Track Scale Values loaded for Track: " & $Tack_Name_Scale & @TAB & "" & @TAB & "Timestamp: " & $timestamp)
EndIf

$Tack_Size_Scale_Value = "0.000" & $Tack_Size_Scale_Value
#endregion Set Scale Values

#region GUI - Erstellen / Create
;Lokale Varibalen setzen
Local $hGUI, $hGraphic, $hPen
Local $GUI, $aSize, $aStrings[5]
Local $btn, $chk, $rdo, $Msg
Local $GUI_List_Auswahl, $tu_Button0, $to_button1, $to_button2, $to_button3, $to_button4
Local $Wow64 = ""
Global $GUI_X_Value = 1080
Global $GUI_Y_Value = 1010

If @AutoItX64 Then $Wow64 = "\Wow6432Node"
Local $sPath = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $Wow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\Examples\GUI\Advanced\Images"

; Erstellen der GUI
$Check_TaskBarPos = IniRead($config_ini, "TEMP", "TaskBarPos", "")
$GUI_Y_POS = 0
If $Check_TaskBarPos = "A" Then $GUI_Y_POS = 40
If $Check_TaskBarPos = "B" Then $GUI_Y_POS = 0
If $Check_TaskBarPos = "" Then $GUI_Y_POS = 0
$GUI = GUICreate("PCars: DS TrackMap", 1080, 1010, 0, $GUI_Y_POS)

; PROGRESS
$Anzeige_Fortschrittbalken = GUICtrlCreateProgress(0, 984, 1080, 5)

; Fonts
$font = "Comic Sans MS"
$font_2 = "Arial"

;Status Bar $Anzeige_Fortschrittbalken
$Statusbar = _GUICtrlStatusBar_Create($GUI)
_GUICtrlStatusBar_SetSimple($Statusbar, True)

GUISetState()

; Update und Darstellung Linien
$Linie_oben = GUICtrlCreatePic($gfx & "Hintergrund.jpg", 0, 178, 1080, 2, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
$Linie_mitte_1 = GUICtrlCreatePic($gfx & "Hintergrund.jpg", 0, 679, 1080, 2, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
$Linie_mitte_2 = GUICtrlCreatePic($gfx & "Hintergrund.jpg", 0, 897, 1080, 2, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
$Linie_unten = GUICtrlCreatePic($gfx & "Hintergrund.jpg", 0, 947, 1080, 2, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
#endregion GUI - Erstellen / Create

#region GUI - Kopfzeile / Header
; Create Groups
GUICtrlCreateGroup("Server Status", 3, 35, 1073, 50)
GUICtrlSetFont(-1, 13, 400, 1, $font_2)
GUICtrlCreateGroup("Event Settings", 3, 97, 530, 75)
GUICtrlSetFont(-1, 13, 400, 1, $font_2)
GUICtrlCreateGroup("Server Infos", 546, 97, 530, 75)
GUICtrlSetFont(-1, 13, 400, 1, $font_2)

GUICtrlCreateLabel("Name:", 205, 3, 55, 23)
GUICtrlSetFont(-1, 14, 400, 4, $font) ; will display underlined characters
$Server_Name = IniRead($Server_Data_INI, "DATA", "name", "")
$Label_Wert_Server_Name = GUICtrlCreateLabel($Server_Name, 265, 5, 315, 23)
GUICtrlSetFont(-1, 14, 400, 1, $font_2) ; will display underlined characters
GUICtrlSetColor(-1, $COLOR_BLUE)

GUICtrlCreateLabel("State:", 10, 53, 45, 23)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Server_Status = IniRead($Server_Data_INI, "DATA", "state", "")
If $Server_Status = "" Then $Server_Status = "OFFLINE"
$Check_Lobby = IniRead($Server_Data_INI, "DATA", "SessionState", "")
If $Check_Lobby = "Lobby" Then $Server_Status = "Lobby"
$Label_Wert_Server_State = GUICtrlCreateLabel($Server_Status, 65, 58, 120, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters
If $Check_Lobby = "Lobby" Then GUICtrlSetColor($Label_Wert_Server_State, $COLOR_BLUE)
If $Server_Status = "Running" Then GUICtrlSetColor(-1, $COLOR_GREEN)
If $Server_Status = "Idle" Then GUICtrlSetColor(-1, $COLOR_BLACK)
If $Server_Status = "OFFLINE" Then GUICtrlSetColor(-1, $COLOR_RED)

GUICtrlCreateLabel("Track:", 695, 3, 55, 30)
GUICtrlSetFont(-1, 14, 400, 4, $font) ; will display underlined characters
$Wert_Track = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
$Label_Wert_Track = GUICtrlCreateLabel($Wert_Track, 755, 5, 315, 23) ; $Wert_Track_ID
GUICtrlSetFont(-1, 14, 400, 1, $font_2) ; will display underlined characters
GUICtrlSetColor(-1, $COLOR_BLUE)

GUICtrlCreateLabel("Players:", 215, 53, 60, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert_NR_Players = GUICtrlCreateLabel("", 280, 58, 120, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters

GUICtrlCreateLabel("Session:", 415, 53, 60, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert_Session = GUICtrlCreateLabel("", 485, 58, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters

GUICtrlCreateLabel("Time:", 635, 53, 55, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert_Time = GUICtrlCreateLabel("", 685, 58, 120, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters

GUICtrlCreateLabel("Practice1:", 10, 115, 75, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert_Practice1 = GUICtrlCreateLabel("", 90, 120, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters
$Value_Practice1Length = IniRead($Server_Data_INI, "DATA", "Practice1Length", "")
If $Value_Practice1Length <> "0" Then
	$Value_Practice1Length = $Value_Practice1Length & " min"
Else
	$Value_Practice1Length = ""
EndIf
GUICtrlSetData(-1, $Value_Practice1Length)

GUICtrlCreateLabel("Practice2:", 10, 138, 75, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert_Practice2 = GUICtrlCreateLabel("", 90, 143, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters
$Value_Practice2Length = IniRead($Server_Data_INI, "DATA", "Practice2Length", "")
If $Value_Practice2Length <> "0" Then
	$Value_Practice2Length = $Value_Practice2Length & " min"
Else
	$Value_Practice2Length = ""
EndIf
GUICtrlSetData(-1, $Value_Practice2Length)

GUICtrlCreateLabel("Qualifying:", 195, 115, 85, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert_Qualifying = GUICtrlCreateLabel("", 285, 120, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters
$Value_QualifyLength = IniRead($Server_Data_INI, "DATA", "QualifyLength", "")
If $Value_QualifyLength <> "0" Then
	$Value_QualifyLength = $Value_QualifyLength & " min"
Else
	$Value_QualifyLength = ""
EndIf
GUICtrlSetData(-1, $Value_QualifyLength)

GUICtrlCreateLabel("Warm Up:", 195, 138, 75, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert_WarmUp = GUICtrlCreateLabel("", 285, 143, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters
$Value_WarmupLength = IniRead($Server_Data_INI, "DATA", "WarmupLength", "")
If $Value_WarmupLength <> "0" Then
	$Value_WarmupLength = $Value_WarmupLength & " min"
Else
	$Value_WarmupLength = ""
EndIf
GUICtrlSetData(-1, $Value_WarmupLength)

GUICtrlCreateLabel("Race 1:", 380, 115, 55, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert__Race1 = GUICtrlCreateLabel("", 440, 120, 80, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters
$Value_Race1Length = IniRead($Server_Data_INI, "DATA", "Race1Length", "")
If $Value_Race1Length <> "0" Then
	$Value_Race1Length = $Value_Race1Length & " laps"
Else
	$Value_Race1Length = ""
EndIf
GUICtrlSetData(-1, $Value_Race1Length)

GUICtrlCreateLabel("Race 2:", 380, 138, 55, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert__Race2 = GUICtrlCreateLabel("", 440, 143, 80, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters
$Value_Race2Length = IniRead($Server_Data_INI, "DATA", "Race2Length", "")
If $Value_Race2Length <> "0" Then
	$Value_Race2Length = $Value_Race2Length & " laps"
Else
	$Value_Race2Length = ""
EndIf
GUICtrlSetData(-1, $Value_Race2Length)


$timestamp = _NowDate() & " - " & _NowTime()


; Server Infos Group
GUICtrlCreateLabel("Session Phase:", 553, 115, 110, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert_SessionPhase = GUICtrlCreateLabel("", 670, 120, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters

GUICtrlCreateLabel("#Racers Valid:", 553, 138, 110, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert_Racers_Valid = GUICtrlCreateLabel("", 670, 143, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters

GUICtrlCreateLabel("#Racers Disqual.:", 725, 115, 150, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert_Racers_Disqual = GUICtrlCreateLabel("", 860, 120, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters

GUICtrlCreateLabel("#Racers Retired:", 725, 138, 150, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert_Racers_Retired = GUICtrlCreateLabel("", 860, 143, 110, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters

GUICtrlCreateLabel("#Racers DNF:", 910, 115, 150, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert_Racers_DNF = GUICtrlCreateLabel("", 1047, 120, 25, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters

GUICtrlCreateLabel("#Racers Finished:", 910, 138, 150, 30)
GUICtrlSetFont(-1, 12, 400, 4, $font) ; will display underlined characters
$Label_Wert_Racers_Finished = GUICtrlCreateLabel("", 1047, 143, 25, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2) ; will display underlined characters
#endregion GUI - Kopfzeile / Header

#region GUI - TrackMap
; Start TrackMap
Global $Player_1 = $gfx & "TrackMap\Player_1.jpg"
Global $Player_2 = $gfx & "TrackMap\Player_2.jpg"
Global $Player_3 = $gfx & "TrackMap\Player_3.jpg"
Global $Player_4 = $gfx & "TrackMap\Player_4.jpg"
Global $Player_5 = $gfx & "TrackMap\Player_5.jpg"
Global $Player_6 = $gfx & "TrackMap\Player_6.jpg"
Global $Player_7 = $gfx & "TrackMap\Player_7.jpg"
Global $Player_8 = $gfx & "TrackMap\Player_8.jpg"
Global $Player_9 = $gfx & "TrackMap\Player_9.jpg"
Global $Player_10 = $gfx & "TrackMap\Player_10.jpg"
Global $Player_11 = $gfx & "TrackMap\Player_11.jpg"
Global $Player_12 = $gfx & "TrackMap\Player_12.jpg"
Global $Player_13 = $gfx & "TrackMap\Player_13.jpg"
Global $Player_14 = $gfx & "TrackMap\Player_14.jpg"
Global $Player_15 = $gfx & "TrackMap\Player_15.jpg"
Global $Player_16 = $gfx & "TrackMap\Player_16.jpg"
Global $Player_17 = $gfx & "TrackMap\Player_17.jpg"
Global $Player_18 = $gfx & "TrackMap\Player_18.jpg"
Global $Player_19 = $gfx & "TrackMap\Player_19.jpg"
Global $Player_20 = $gfx & "TrackMap\Player_20.jpg"
Global $Player_21 = $gfx & "TrackMap\Player_21.jpg"
Global $Player_22 = $gfx & "TrackMap\Player_22.jpg"
Global $Player_23 = $gfx & "TrackMap\Player_23.jpg"
Global $Player_24 = $gfx & "TrackMap\Player_24.jpg"
Global $Player_25 = $gfx & "TrackMap\Player_25.jpg"
Global $Player_26 = $gfx & "TrackMap\Player_26.jpg"
Global $Player_27 = $gfx & "TrackMap\Player_27.jpg"
Global $Player_28 = $gfx & "TrackMap\Player_28.jpg"
Global $Player_29 = $gfx & "TrackMap\Player_29.jpg"
Global $Player_30 = $gfx & "TrackMap\Player_30.jpg"
Global $Player_31 = $gfx & "TrackMap\Player_31.jpg"
Global $Player_32 = $gfx & "TrackMap\Player_32.jpg"
Global $Player_x = $gfx & "TrackMap\Player_x.jpg"

Global $X_Value_Player_1 = IniRead($TrackMap_participants_Data_INI, "1", "PositionX", "")
Global $X_Value_Player_2 = IniRead($TrackMap_participants_Data_INI, "2", "PositionX", "")
Global $X_Value_Player_3 = IniRead($TrackMap_participants_Data_INI, "3", "PositionX", "")
Global $X_Value_Player_4 = IniRead($TrackMap_participants_Data_INI, "4", "PositionX", "")
Global $X_Value_Player_5 = IniRead($TrackMap_participants_Data_INI, "5", "PositionX", "")
Global $X_Value_Player_6 = IniRead($TrackMap_participants_Data_INI, "6", "PositionX", "")
Global $X_Value_Player_7 = IniRead($TrackMap_participants_Data_INI, "7", "PositionX", "")
Global $X_Value_Player_8 = IniRead($TrackMap_participants_Data_INI, "8", "PositionX", "")
Global $X_Value_Player_9 = IniRead($TrackMap_participants_Data_INI, "9", "PositionX", "")
Global $X_Value_Player_10 = IniRead($TrackMap_participants_Data_INI, "10", "PositionX", "")
Global $X_Value_Player_11 = IniRead($TrackMap_participants_Data_INI, "11", "PositionX", "")
Global $X_Value_Player_12 = IniRead($TrackMap_participants_Data_INI, "12", "PositionX", "")
Global $X_Value_Player_13 = IniRead($TrackMap_participants_Data_INI, "13", "PositionX", "")
Global $X_Value_Player_14 = IniRead($TrackMap_participants_Data_INI, "14", "PositionX", "")
Global $X_Value_Player_15 = IniRead($TrackMap_participants_Data_INI, "15", "PositionX", "")
Global $X_Value_Player_16 = IniRead($TrackMap_participants_Data_INI, "16", "PositionX", "")
Global $X_Value_Player_17 = IniRead($TrackMap_participants_Data_INI, "17", "PositionX", "")
Global $X_Value_Player_18 = IniRead($TrackMap_participants_Data_INI, "18", "PositionX", "")
Global $X_Value_Player_19 = IniRead($TrackMap_participants_Data_INI, "19", "PositionX", "")
Global $X_Value_Player_20 = IniRead($TrackMap_participants_Data_INI, "20", "PositionX", "")
Global $X_Value_Player_21 = IniRead($TrackMap_participants_Data_INI, "21", "PositionX", "")
Global $X_Value_Player_22 = IniRead($TrackMap_participants_Data_INI, "22", "PositionX", "")
Global $X_Value_Player_23 = IniRead($TrackMap_participants_Data_INI, "23", "PositionX", "")
Global $X_Value_Player_24 = IniRead($TrackMap_participants_Data_INI, "24", "PositionX", "")
Global $X_Value_Player_25 = IniRead($TrackMap_participants_Data_INI, "25", "PositionX", "")
Global $X_Value_Player_26 = IniRead($TrackMap_participants_Data_INI, "26", "PositionX", "")
Global $X_Value_Player_27 = IniRead($TrackMap_participants_Data_INI, "27", "PositionX", "")
Global $X_Value_Player_28 = IniRead($TrackMap_participants_Data_INI, "28", "PositionX", "")
Global $X_Value_Player_29 = IniRead($TrackMap_participants_Data_INI, "29", "PositionX", "")
Global $X_Value_Player_30 = IniRead($TrackMap_participants_Data_INI, "30", "PositionX", "")
Global $X_Value_Player_31 = IniRead($TrackMap_participants_Data_INI, "31", "PositionX", "")
Global $X_Value_Player_32 = IniRead($TrackMap_participants_Data_INI, "32", "PositionX", "")

Global $Y_Value_Player_1 = IniRead($TrackMap_participants_Data_INI, "1", "PositionY", "")
Global $Y_Value_Player_2 = IniRead($TrackMap_participants_Data_INI, "2", "PositionY", "")
Global $Y_Value_Player_3 = IniRead($TrackMap_participants_Data_INI, "3", "PositionY", "")
Global $Y_Value_Player_4 = IniRead($TrackMap_participants_Data_INI, "4", "PositionY", "")
Global $Y_Value_Player_5 = IniRead($TrackMap_participants_Data_INI, "5", "PositionY", "")
Global $Y_Value_Player_6 = IniRead($TrackMap_participants_Data_INI, "6", "PositionY", "")
Global $Y_Value_Player_7 = IniRead($TrackMap_participants_Data_INI, "7", "PositionY", "")
Global $Y_Value_Player_8 = IniRead($TrackMap_participants_Data_INI, "8", "PositionY", "")
Global $Y_Value_Player_9 = IniRead($TrackMap_participants_Data_INI, "9", "PositionY", "")
Global $Y_Value_Player_10 = IniRead($TrackMap_participants_Data_INI, "10", "PositionY", "")

Global $Z_Value_Player_1 = IniRead($TrackMap_participants_Data_INI, "1", "PositionZ", "")
Global $Z_Value_Player_2 = IniRead($TrackMap_participants_Data_INI, "2", "PositionZ", "")
Global $Z_Value_Player_3 = IniRead($TrackMap_participants_Data_INI, "3", "PositionZ", "")
Global $Z_Value_Player_4 = IniRead($TrackMap_participants_Data_INI, "4", "PositionZ", "")
Global $Z_Value_Player_5 = IniRead($TrackMap_participants_Data_INI, "5", "PositionZ", "")
Global $Z_Value_Player_6 = IniRead($TrackMap_participants_Data_INI, "6", "PositionZ", "")
Global $Z_Value_Player_7 = IniRead($TrackMap_participants_Data_INI, "7", "PositionZ", "")
Global $Z_Value_Player_8 = IniRead($TrackMap_participants_Data_INI, "8", "PositionZ", "")
Global $Z_Value_Player_9 = IniRead($TrackMap_participants_Data_INI, "9", "PositionZ", "")
Global $Z_Value_Player_10 = IniRead($TrackMap_participants_Data_INI, "10", "PositionZ", "")
Global $Z_Value_Player_11 = IniRead($TrackMap_participants_Data_INI, "11", "PositionZ", "")
Global $Z_Value_Player_12 = IniRead($TrackMap_participants_Data_INI, "12", "PositionZ", "")
Global $Z_Value_Player_13 = IniRead($TrackMap_participants_Data_INI, "13", "PositionZ", "")
Global $Z_Value_Player_14 = IniRead($TrackMap_participants_Data_INI, "14", "PositionZ", "")
Global $Z_Value_Player_15 = IniRead($TrackMap_participants_Data_INI, "15", "PositionZ", "")
Global $Z_Value_Player_16 = IniRead($TrackMap_participants_Data_INI, "16", "PositionZ", "")
Global $Z_Value_Player_17 = IniRead($TrackMap_participants_Data_INI, "17", "PositionZ", "")
Global $Z_Value_Player_18 = IniRead($TrackMap_participants_Data_INI, "18", "PositionZ", "")
Global $Z_Value_Player_19 = IniRead($TrackMap_participants_Data_INI, "19", "PositionZ", "")
Global $Z_Value_Player_20 = IniRead($TrackMap_participants_Data_INI, "20", "PositionZ", "")
Global $Z_Value_Player_21 = IniRead($TrackMap_participants_Data_INI, "21", "PositionZ", "")
Global $Z_Value_Player_22 = IniRead($TrackMap_participants_Data_INI, "22", "PositionZ", "")
Global $Z_Value_Player_23 = IniRead($TrackMap_participants_Data_INI, "23", "PositionZ", "")
Global $Z_Value_Player_24 = IniRead($TrackMap_participants_Data_INI, "24", "PositionZ", "")
Global $Z_Value_Player_25 = IniRead($TrackMap_participants_Data_INI, "25", "PositionZ", "")
Global $Z_Value_Player_26 = IniRead($TrackMap_participants_Data_INI, "26", "PositionZ", "")
Global $Z_Value_Player_27 = IniRead($TrackMap_participants_Data_INI, "27", "PositionZ", "")
Global $Z_Value_Player_28 = IniRead($TrackMap_participants_Data_INI, "28", "PositionZ", "")
Global $Z_Value_Player_29 = IniRead($TrackMap_participants_Data_INI, "29", "PositionZ", "")
Global $Z_Value_Player_30 = IniRead($TrackMap_participants_Data_INI, "30", "PositionZ", "")
Global $Z_Value_Player_31 = IniRead($TrackMap_participants_Data_INI, "31", "PositionZ", "")
Global $Z_Value_Player_32 = IniRead($TrackMap_participants_Data_INI, "32", "PositionZ", "")

Global $TrackMap_X_100prozent = $GUI_X_Value
Global $TrackMap_Y_100prozent = $GUI_Y_Value

Global $X_prozent_Value_Player_1 = Round(($X_Value_Player_1 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_2 = Round(($X_Value_Player_2 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_3 = Round(($X_Value_Player_3 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_4 = Round(($X_Value_Player_4 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_5 = Round(($X_Value_Player_5 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_6 = Round(($X_Value_Player_6 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_7 = Round(($X_Value_Player_7 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_8 = Round(($X_Value_Player_8 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_9 = Round(($X_Value_Player_9 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_10 = Round(($X_Value_Player_10 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_11 = Round(($X_Value_Player_11 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_12 = Round(($X_Value_Player_12 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_13 = Round(($X_Value_Player_13 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_14 = Round(($X_Value_Player_14 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_15 = Round(($X_Value_Player_15 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_16 = Round(($X_Value_Player_16 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_17 = Round(($X_Value_Player_17 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_18 = Round(($X_Value_Player_18 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_19 = Round(($X_Value_Player_19 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_20 = Round(($X_Value_Player_20 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_21 = Round(($X_Value_Player_21 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_22 = Round(($X_Value_Player_22 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_23 = Round(($X_Value_Player_23 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_24 = Round(($X_Value_Player_24 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_25 = Round(($X_Value_Player_25 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_26 = Round(($X_Value_Player_26 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_27 = Round(($X_Value_Player_27 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_28 = Round(($X_Value_Player_28 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_29 = Round(($X_Value_Player_29 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_30 = Round(($X_Value_Player_30 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_31 = Round(($X_Value_Player_31 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
Global $X_prozent_Value_Player_32 = Round(($X_Value_Player_32 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))

Global $Y_prozent_Value_Player_1 = Round(($Y_Value_Player_1 * 0.01) / ($GUI_Y_Value / 100))
Global $Y_prozent_Value_Player_2 = Round(($Y_Value_Player_2 * 0.01) / ($GUI_Y_Value / 100))
Global $Y_prozent_Value_Player_3 = Round(($Y_Value_Player_3 * 0.01) / ($GUI_Y_Value / 100))
Global $Y_prozent_Value_Player_4 = Round(($Y_Value_Player_4 * 0.01) / ($GUI_Y_Value / 100))
Global $Y_prozent_Value_Player_5 = Round(($Y_Value_Player_5 * 0.01) / ($GUI_Y_Value / 100))
Global $Y_prozent_Value_Player_6 = Round(($Y_Value_Player_6 * 0.01) / ($GUI_Y_Value / 100))
Global $Y_prozent_Value_Player_7 = Round(($Y_Value_Player_7 * 0.01) / ($GUI_Y_Value / 100))
Global $Y_prozent_Value_Player_8 = Round(($Y_Value_Player_8 * 0.01) / ($GUI_Y_Value / 100))
Global $Y_prozent_Value_Player_9 = Round(($Y_Value_Player_9 * 0.01) / ($GUI_Y_Value / 100))
Global $Y_prozent_Value_Player_10 = Round(($Y_Value_Player_10 * 0.01) / ($GUI_Y_Value / 100))

Global $Z_prozent_Value_Player_1 = Round(($Z_Value_Player_1 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_2 = Round(($Z_Value_Player_2 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_3 = Round(($Z_Value_Player_3 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_4 = Round(($Z_Value_Player_4 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_5 = Round(($Z_Value_Player_5 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_6 = Round(($Z_Value_Player_6 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_7 = Round(($Z_Value_Player_7 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_8 = Round(($Z_Value_Player_8 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_9 = Round(($Z_Value_Player_9 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_10 = Round(($Z_Value_Player_10 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_11 = Round(($Z_Value_Player_11 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_12 = Round(($Z_Value_Player_12 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_13 = Round(($Z_Value_Player_13 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_14 = Round(($Z_Value_Player_14 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_15 = Round(($Z_Value_Player_15 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_16 = Round(($Z_Value_Player_16 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_17 = Round(($Z_Value_Player_17 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_18 = Round(($Z_Value_Player_18 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_19 = Round(($Z_Value_Player_19 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_20 = Round(($Z_Value_Player_20 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_21 = Round(($Z_Value_Player_21 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_22 = Round(($Z_Value_Player_22 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_23 = Round(($Z_Value_Player_23 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_24 = Round(($Z_Value_Player_24 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_25 = Round(($Z_Value_Player_25 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_26 = Round(($Z_Value_Player_26 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_27 = Round(($Z_Value_Player_27 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_28 = Round(($Z_Value_Player_28 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_29 = Round(($Z_Value_Player_29 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_30 = Round(($Z_Value_Player_30 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_31 = Round(($Z_Value_Player_31 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
Global $Z_prozent_Value_Player_32 = Round(($Z_Value_Player_32 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))

Global $X_Position_Player_1 = $X_prozent_Value_Player_1 + 500
Global $X_Position_Player_2 = $X_prozent_Value_Player_2 + 500
Global $X_Position_Player_3 = $X_prozent_Value_Player_3 + 500
Global $X_Position_Player_4 = $X_prozent_Value_Player_4 + 500
Global $X_Position_Player_5 = $X_prozent_Value_Player_5 + 500
Global $X_Position_Player_6 = $X_prozent_Value_Player_6 + 500
Global $X_Position_Player_7 = $X_prozent_Value_Player_7 + 500
Global $X_Position_Player_8 = $X_prozent_Value_Player_8 + 500
Global $X_Position_Player_9 = $X_prozent_Value_Player_9 + 500
Global $X_Position_Player_10 = $X_prozent_Value_Player_10 + 500
Global $X_Position_Player_11 = $X_prozent_Value_Player_11 + 500
Global $X_Position_Player_12 = $X_prozent_Value_Player_12 + 500
Global $X_Position_Player_13 = $X_prozent_Value_Player_13 + 500
Global $X_Position_Player_14 = $X_prozent_Value_Player_14 + 500
Global $X_Position_Player_15 = $X_prozent_Value_Player_15 + 500
Global $X_Position_Player_16 = $X_prozent_Value_Player_16 + 500
Global $X_Position_Player_17 = $X_prozent_Value_Player_17 + 500
Global $X_Position_Player_18 = $X_prozent_Value_Player_18 + 500
Global $X_Position_Player_19 = $X_prozent_Value_Player_19 + 500
Global $X_Position_Player_20 = $X_prozent_Value_Player_20 + 500
Global $X_Position_Player_21 = $X_prozent_Value_Player_21 + 500
Global $X_Position_Player_22 = $X_prozent_Value_Player_22 + 500
Global $X_Position_Player_23 = $X_prozent_Value_Player_23 + 500
Global $X_Position_Player_24 = $X_prozent_Value_Player_24 + 500
Global $X_Position_Player_25 = $X_prozent_Value_Player_25 + 500
Global $X_Position_Player_26 = $X_prozent_Value_Player_26 + 500
Global $X_Position_Player_27 = $X_prozent_Value_Player_27 + 500
Global $X_Position_Player_28 = $X_prozent_Value_Player_28 + 500
Global $X_Position_Player_29 = $X_prozent_Value_Player_29 + 500
Global $X_Position_Player_30 = $X_prozent_Value_Player_30 + 500
Global $X_Position_Player_31 = $X_prozent_Value_Player_31 + 500
Global $X_Position_Player_32 = $X_prozent_Value_Player_32 + 500

Global $Z_Position_Player_1 = $Z_prozent_Value_Player_1 + 445
Global $Z_Position_Player_2 = $Z_prozent_Value_Player_2 + 445
Global $Z_Position_Player_3 = $Z_prozent_Value_Player_3 + 445
Global $Z_Position_Player_4 = $Z_prozent_Value_Player_4 + 445
Global $Z_Position_Player_5 = $Z_prozent_Value_Player_5 + 445
Global $Z_Position_Player_6 = $Z_prozent_Value_Player_6 + 445
Global $Z_Position_Player_7 = $Z_prozent_Value_Player_7 + 445
Global $Z_Position_Player_8 = $Z_prozent_Value_Player_8 + 445
Global $Z_Position_Player_9 = $Z_prozent_Value_Player_9 + 445
Global $Z_Position_Player_10 = $Z_prozent_Value_Player_10 + 445
Global $Z_Position_Player_11 = $Z_prozent_Value_Player_11 + 445
Global $Z_Position_Player_12 = $Z_prozent_Value_Player_12 + 445
Global $Z_Position_Player_13 = $Z_prozent_Value_Player_13 + 445
Global $Z_Position_Player_14 = $Z_prozent_Value_Player_14 + 445
Global $Z_Position_Player_15 = $Z_prozent_Value_Player_15 + 445
Global $Z_Position_Player_16 = $Z_prozent_Value_Player_16 + 445
Global $Z_Position_Player_17 = $Z_prozent_Value_Player_17 + 445
Global $Z_Position_Player_18 = $Z_prozent_Value_Player_18 + 445
Global $Z_Position_Player_19 = $Z_prozent_Value_Player_19 + 445
Global $Z_Position_Player_20 = $Z_prozent_Value_Player_20 + 445
Global $Z_Position_Player_21 = $Z_prozent_Value_Player_21 + 445
Global $Z_Position_Player_22 = $Z_prozent_Value_Player_22 + 445
Global $Z_Position_Player_23 = $Z_prozent_Value_Player_23 + 445
Global $Z_Position_Player_24 = $Z_prozent_Value_Player_24 + 445
Global $Z_Position_Player_25 = $Z_prozent_Value_Player_25 + 445
Global $Z_Position_Player_26 = $Z_prozent_Value_Player_26 + 445
Global $Z_Position_Player_27 = $Z_prozent_Value_Player_27 + 445
Global $Z_Position_Player_28 = $Z_prozent_Value_Player_28 + 445
Global $Z_Position_Player_29 = $Z_prozent_Value_Player_29 + 445
Global $Z_Position_Player_30 = $Z_prozent_Value_Player_30 + 445
Global $Z_Position_Player_30 = $Z_prozent_Value_Player_31 + 445
Global $Z_Position_Player_31 = $Z_prozent_Value_Player_32 + 445

;If $X_prozent_Value_Player_1 = "" Then $X_Position_Player_1 = 0
;If $X_prozent_Value_Player_2 = "" Then $X_Position_Player_2 = 0
;If $X_prozent_Value_Player_3 = "" Then $X_Position_Player_3 = 0
;If $X_prozent_Value_Player_4 = "" Then $X_Position_Player_4 = 0
;If $X_prozent_Value_Player_5 = "" Then $X_Position_Player_5 = 0
;If $X_prozent_Value_Player_6 = "" Then $X_Position_Player_6 = 0
;If $X_prozent_Value_Player_7 = "" Then $X_Position_Player_7 = 0
;If $X_prozent_Value_Player_8 = "" Then $X_Position_Player_8 = 0
;If $X_prozent_Value_Player_9 = "" Then $X_Position_Player_9 = 0
;If $X_prozent_Value_Player_10 = "" Then $X_Position_Player_10 = 0

;If $Z_prozent_Value_Player_1 = "" Then $Z_Position_Player_1 = 200
;If $Z_prozent_Value_Player_2 = "" Then $Z_Position_Player_2 = 200
;If $Z_prozent_Value_Player_3 = "" Then $Z_Position_Player_3 = 200
;If $Z_prozent_Value_Player_4 = "" Then $Z_Position_Player_4 = 200
;If $Z_prozent_Value_Player_5 = "" Then $Z_Position_Player_5 = 200
;If $Z_prozent_Value_Player_6 = "" Then $Z_Position_Player_6 = 200
;If $Z_prozent_Value_Player_7 = "" Then $Z_Position_Player_7 = 200
;If $Z_prozent_Value_Player_8 = "" Then $Z_Position_Player_8 = 200
;If $Z_prozent_Value_Player_9 = "" Then $Z_Position_Player_9 = 200
;If $Z_prozent_Value_Player_10 = "" Then $Z_Position_Player_10 = 200

If $X_prozent_Value_Player_1 = "" Or $X_prozent_Value_Player_1 = 0 Then $X_Position_Player_1 = 5
If $X_prozent_Value_Player_2 = "" Or $X_prozent_Value_Player_2 = 0 Then $X_Position_Player_2 = 25
If $X_prozent_Value_Player_3 = "" Or $X_prozent_Value_Player_3 = 0 Then $X_Position_Player_3 = 45
If $X_prozent_Value_Player_4 = "" Or $X_prozent_Value_Player_4 = 0 Then $X_Position_Player_4 = 65
If $X_prozent_Value_Player_5 = "" Or $X_prozent_Value_Player_5 = 0 Then $X_Position_Player_5 = 85
If $X_prozent_Value_Player_6 = "" Or $X_prozent_Value_Player_6 = 0 Then $X_Position_Player_6 = 105
If $X_prozent_Value_Player_7 = "" Or $X_prozent_Value_Player_7 = 0 Then $X_Position_Player_7 = 125
If $X_prozent_Value_Player_8 = "" Or $X_prozent_Value_Player_8 = 0 Then $X_Position_Player_8 = 145
If $X_prozent_Value_Player_9 = "" Or $X_prozent_Value_Player_9 = 0 Then $X_Position_Player_9 = 165
If $X_prozent_Value_Player_10 = "" Or $X_prozent_Value_Player_10 = 0 Then $X_Position_Player_10 = 185
If $X_prozent_Value_Player_11 = "" Or $X_prozent_Value_Player_11 = 0 Then $X_Position_Player_11 = 205
If $X_prozent_Value_Player_12 = "" Or $X_prozent_Value_Player_12 = 0 Then $X_Position_Player_12 = 225
If $X_prozent_Value_Player_13 = "" Or $X_prozent_Value_Player_13 = 0 Then $X_Position_Player_13 = 245
If $X_prozent_Value_Player_14 = "" Or $X_prozent_Value_Player_14 = 0 Then $X_Position_Player_14 = 265
If $X_prozent_Value_Player_15 = "" Or $X_prozent_Value_Player_15 = 0 Then $X_Position_Player_15 = 285
If $X_prozent_Value_Player_16 = "" Or $X_prozent_Value_Player_16 = 0 Then $X_Position_Player_16 = 305
If $X_prozent_Value_Player_17 = "" Or $X_prozent_Value_Player_17 = 0 Then $X_Position_Player_17 = 325
If $X_prozent_Value_Player_18 = "" Or $X_prozent_Value_Player_18 = 0 Then $X_Position_Player_18 = 345
If $X_prozent_Value_Player_19 = "" Or $X_prozent_Value_Player_19 = 0 Then $X_Position_Player_19 = 365
If $X_prozent_Value_Player_20 = "" Or $X_prozent_Value_Player_20 = 0 Then $X_Position_Player_20 = 385
If $X_prozent_Value_Player_21 = "" Or $X_prozent_Value_Player_21 = 0 Then $X_Position_Player_21 = 405
If $X_prozent_Value_Player_22 = "" Or $X_prozent_Value_Player_22 = 0 Then $X_Position_Player_22 = 425
If $X_prozent_Value_Player_23 = "" Or $X_prozent_Value_Player_23 = 0 Then $X_Position_Player_23 = 445
If $X_prozent_Value_Player_24 = "" Or $X_prozent_Value_Player_24 = 0 Then $X_Position_Player_24 = 465
If $X_prozent_Value_Player_25 = "" Or $X_prozent_Value_Player_25 = 0 Then $X_Position_Player_25 = 485
If $X_prozent_Value_Player_26 = "" Or $X_prozent_Value_Player_26 = 0 Then $X_Position_Player_26 = 505
If $X_prozent_Value_Player_27 = "" Or $X_prozent_Value_Player_27 = 0 Then $X_Position_Player_27 = 525
If $X_prozent_Value_Player_28 = "" Or $X_prozent_Value_Player_28 = 0 Then $X_Position_Player_28 = 545
If $X_prozent_Value_Player_29 = "" Or $X_prozent_Value_Player_29 = 0 Then $X_Position_Player_29 = 565
If $X_prozent_Value_Player_30 = "" Or $X_prozent_Value_Player_30 = 0 Then $X_Position_Player_30 = 585
If $X_prozent_Value_Player_31 = "" Or $X_prozent_Value_Player_31 = 0 Then $X_Position_Player_31 = 565
If $X_prozent_Value_Player_32 = "" Or $X_prozent_Value_Player_32 = 0 Then $X_Position_Player_32 = 585

If $Z_prozent_Value_Player_1 = "" Or $Z_prozent_Value_Player_1 = 0 Then $Z_Position_Player_1 = 190
If $Z_prozent_Value_Player_2 = "" Or $Z_prozent_Value_Player_2 = 0 Then $Z_Position_Player_2 = 190
If $Z_prozent_Value_Player_3 = "" Or $Z_prozent_Value_Player_3 = 0 Then $Z_Position_Player_3 = 190
If $Z_prozent_Value_Player_4 = "" Or $Z_prozent_Value_Player_4 = 0 Then $Z_Position_Player_4 = 190
If $Z_prozent_Value_Player_5 = "" Or $Z_prozent_Value_Player_5 = 0 Then $Z_Position_Player_5 = 190
If $Z_prozent_Value_Player_6 = "" Or $Z_prozent_Value_Player_6 = 0 Then $Z_Position_Player_6 = 190
If $Z_prozent_Value_Player_7 = "" Or $Z_prozent_Value_Player_7 = 0 Then $Z_Position_Player_7 = 190
If $Z_prozent_Value_Player_8 = "" Or $Z_prozent_Value_Player_8 = 0 Then $Z_Position_Player_8 = 190
If $Z_prozent_Value_Player_9 = "" Or $Z_prozent_Value_Player_9 = 0 Then $Z_Position_Player_9 = 190
If $Z_prozent_Value_Player_10 = "" Or $Z_prozent_Value_Player_10 = 0 Then $Z_Position_Player_10 = 190
If $Z_prozent_Value_Player_11 = "" Or $Z_prozent_Value_Player_11 = 0 Then $Z_Position_Player_11 = 190
If $Z_prozent_Value_Player_12 = "" Or $Z_prozent_Value_Player_12 = 0 Then $Z_Position_Player_12 = 190
If $Z_prozent_Value_Player_13 = "" Or $Z_prozent_Value_Player_13 = 0 Then $Z_Position_Player_13 = 190
If $Z_prozent_Value_Player_14 = "" Or $Z_prozent_Value_Player_14 = 0 Then $Z_Position_Player_14 = 190
If $Z_prozent_Value_Player_15 = "" Or $Z_prozent_Value_Player_15 = 0 Then $Z_Position_Player_15 = 190
If $Z_prozent_Value_Player_16 = "" Or $Z_prozent_Value_Player_16 = 0 Then $Z_Position_Player_16 = 190
If $Z_prozent_Value_Player_17 = "" Or $Z_prozent_Value_Player_17 = 0 Then $Z_Position_Player_17 = 190
If $Z_prozent_Value_Player_18 = "" Or $Z_prozent_Value_Player_18 = 0 Then $Z_Position_Player_18 = 190
If $Z_prozent_Value_Player_19 = "" Or $Z_prozent_Value_Player_19 = 0 Then $Z_Position_Player_19 = 190
If $Z_prozent_Value_Player_20 = "" Or $Z_prozent_Value_Player_20 = 0 Then $Z_Position_Player_20 = 190
If $Z_prozent_Value_Player_21 = "" Or $Z_prozent_Value_Player_21 = 0 Then $Z_Position_Player_21 = 190
If $Z_prozent_Value_Player_22 = "" Or $Z_prozent_Value_Player_22 = 0 Then $Z_Position_Player_22 = 190
If $Z_prozent_Value_Player_23 = "" Or $Z_prozent_Value_Player_23 = 0 Then $Z_Position_Player_23 = 190
If $Z_prozent_Value_Player_24 = "" Or $Z_prozent_Value_Player_24 = 0 Then $Z_Position_Player_24 = 190
If $Z_prozent_Value_Player_25 = "" Or $Z_prozent_Value_Player_25 = 0 Then $Z_Position_Player_25 = 190
If $Z_prozent_Value_Player_26 = "" Or $Z_prozent_Value_Player_26 = 0 Then $Z_Position_Player_26 = 190
If $Z_prozent_Value_Player_27 = "" Or $Z_prozent_Value_Player_27 = 0 Then $Z_Position_Player_27 = 190
If $Z_prozent_Value_Player_28 = "" Or $Z_prozent_Value_Player_28 = 0 Then $Z_Position_Player_28 = 190
If $Z_prozent_Value_Player_29 = "" Or $Z_prozent_Value_Player_29 = 0 Then $Z_Position_Player_29 = 190
If $Z_prozent_Value_Player_30 = "" Or $Z_prozent_Value_Player_30 = 0 Then $Z_Position_Player_30 = 190
If $Z_prozent_Value_Player_31 = "" Or $Z_prozent_Value_Player_31 = 0 Then $Z_Position_Player_31 = 190
If $Z_prozent_Value_Player_32 = "" Or $Z_prozent_Value_Player_32 = 0 Then $Z_Position_Player_32 = 190

$hPic_background = ""

Global $Pic_Player_1 = GUICtrlCreatePic($Player_1, $X_Position_Player_1, $Z_Position_Player_1, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_2 = GUICtrlCreatePic($Player_2, $X_Position_Player_2, $Z_Position_Player_2, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_3 = GUICtrlCreatePic($Player_3, $X_Position_Player_3, $Z_Position_Player_3, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_4 = GUICtrlCreatePic($Player_4, $X_Position_Player_4, $Z_Position_Player_4, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_5 = GUICtrlCreatePic($Player_5, $X_Position_Player_5, $Z_Position_Player_5, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_6 = GUICtrlCreatePic($Player_6, $X_Position_Player_6, $Z_Position_Player_6, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_7 = GUICtrlCreatePic($Player_7, $X_Position_Player_7, $Z_Position_Player_7, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_8 = GUICtrlCreatePic($Player_8, $X_Position_Player_8, $Z_Position_Player_8, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_9 = GUICtrlCreatePic($Player_9, $X_Position_Player_9, $Z_Position_Player_9, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_10 = GUICtrlCreatePic($Player_10, $X_Position_Player_10, $Z_Position_Player_10, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_11 = GUICtrlCreatePic($Player_11, $X_Position_Player_11, $Z_Position_Player_11, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_12 = GUICtrlCreatePic($Player_12, $X_Position_Player_12, $Z_Position_Player_12, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_13 = GUICtrlCreatePic($Player_13, $X_Position_Player_13, $Z_Position_Player_13, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_14 = GUICtrlCreatePic($Player_14, $X_Position_Player_14, $Z_Position_Player_14, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_15 = GUICtrlCreatePic($Player_15, $X_Position_Player_15, $Z_Position_Player_15, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_16 = GUICtrlCreatePic($Player_16, $X_Position_Player_16, $Z_Position_Player_16, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_17 = GUICtrlCreatePic($Player_17, $X_Position_Player_17, $Z_Position_Player_17, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_18 = GUICtrlCreatePic($Player_18, $X_Position_Player_18, $Z_Position_Player_18, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_19 = GUICtrlCreatePic($Player_19, $X_Position_Player_19, $Z_Position_Player_19, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_20 = GUICtrlCreatePic($Player_20, $X_Position_Player_20, $Z_Position_Player_20, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_21 = GUICtrlCreatePic($Player_21, $X_Position_Player_21, $Z_Position_Player_21, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_22 = GUICtrlCreatePic($Player_22, $X_Position_Player_22, $Z_Position_Player_22, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_23 = GUICtrlCreatePic($Player_23, $X_Position_Player_23, $Z_Position_Player_23, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_24 = GUICtrlCreatePic($Player_24, $X_Position_Player_24, $Z_Position_Player_24, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_25 = GUICtrlCreatePic($Player_25, $X_Position_Player_25, $Z_Position_Player_25, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_26 = GUICtrlCreatePic($Player_26, $X_Position_Player_26, $Z_Position_Player_26, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_27 = GUICtrlCreatePic($Player_27, $X_Position_Player_27, $Z_Position_Player_27, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_28 = GUICtrlCreatePic($Player_28, $X_Position_Player_28, $Z_Position_Player_28, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_29 = GUICtrlCreatePic($Player_29, $X_Position_Player_29, $Z_Position_Player_29, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_30 = GUICtrlCreatePic($Player_30, $X_Position_Player_30, $Z_Position_Player_30, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_31 = GUICtrlCreatePic($Player_31, $X_Position_Player_31, $Z_Position_Player_31, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
Global $Pic_Player_32 = GUICtrlCreatePic($Player_32, $X_Position_Player_32, $Z_Position_Player_32, 14, 14, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))

GUICtrlSetState($Pic_Player_1, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_2, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_3, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_4, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_5, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_6, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_7, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_8, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_9, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_10, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_11, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_12, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_13, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_14, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_15, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_16, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_17, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_18, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_19, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_20, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_21, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_22, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_23, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_24, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_25, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_26, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_27, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_28, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_29, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_30, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_31, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_32, $GUI_ENABLE)

GUISetState()
#endregion GUI - TrackMap

#region GUI - ListView_1
$ListView_1 = GUICtrlCreateListView("", 0, 680, 1079, 218, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))

_GUICtrlListView_BeginUpdate($ListView_1) ; Beginn Update
_GUICtrlListView_SetExtendedListViewStyle($ListView_1, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_DOUBLEBUFFER))
_GUICtrlStatusBar_SetSimple($Statusbar, True)
GUISetState()

; Add columns
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_4, 40) ;  Pos.
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_1, 115) ; Name
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_3, 115) ; Car
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_11, 70) ; Fastest Lap Time
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_10, 70) ; Last Lap
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_16, 70) ; Personal Best Lap
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_5, 60) ; In Lap
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_6, 60) ; In Sector
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_7, 60) ; Sector 1
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_8, 60) ; Sector 2
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_9, 60) ; Sector 3
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_12, 50) ; State
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_13, 40) ; PitStops
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_17, 50) ; EP
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_14, 30) ; Points
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_18, 30) ; Track Cuts
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_19, 30) ; Impacts
_GUICtrlListView_AddColumn($ListView_1, $Label_ListView_1_Column_20, 45) ; Speed
_GUICtrlListView_EndUpdate($ListView_1) ; End Update
#endregion GUI - ListView_1

#region GUI - Settings

#region GUI Create Groups
GUICtrlCreateGroup("TrackMap", 3, 899, 430, 46)
GUICtrlSetFont(-1, 9, 400, 1, $font_2)
GUICtrlCreateGroup("ListView", 438, 899, 133, 46)
GUICtrlSetFont(-1, 9, 400, 1, $font_2)
GUICtrlCreateGroup("TrackMapReplay", 577, 899, 195, 46)
GUICtrlSetFont(-1, 9, 400, 1, $font_2)
GUICtrlCreateGroup("", 645, 908, 3, 36)
GUICtrlCreateGroup("Mode", 777, 899, 153, 46)
GUICtrlSetFont(-1, 9, 400, 1, $font_2)
GUICtrlCreateGroup("Window", 935, 899, 141, 46)
GUICtrlSetFont(-1, 9, 400, 1, $font_2)
#endregion GUI Create Groups

#region GUI - Checkbox
$Checkbox_1 = GUICtrlCreateCheckbox(" Show Position Dot", 10, 913, 110, 15) ; 80, 952 ; TrackMap
	If IniRead($config_ini, "TrackMap", "Checkbox_1", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
$Checkbox_2 = GUICtrlCreateCheckbox(" Show Track Map", 10, 928, 110, 15) ; 80, 968 ; TrackMap
	If IniRead($config_ini, "TrackMap", "Checkbox_2", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
$Checkbox_3 = GUICtrlCreateCheckbox(" Show max. 10 entries", 444, 913, 120, 15) ; 80, 952 ; ListView
	If IniRead($config_ini, "TrackMap", "Checkbox_3", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
$Checkbox_4 = GUICtrlCreateCheckbox(" Show colored text", 444, 928, 120, 15) ; 80, 968 ; ListView
	If IniRead($config_ini, "TrackMap", "Checkbox_4", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
	;If IniRead($config_ini, "TrackMap", "Checkbox_3", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
$Checkbox_5 = GUICtrlCreateCheckbox(" Windows always on top", 940, 913, 130, 15) ; 80, 968 ; ListView
	If IniRead($config_ini, "TrackMap", "Checkbox_5", "") = "true" Then GUICtrlSetState(-1, $GUI_CHECKED)
#endregion GUI - Checkbox

#region GUI - Radio Buttons

Global $Radio_Mode_1 = IniRead($config_ini, "TrackMap", "Radio_Mode_1", "")
Global $Radio_Mode_2 = IniRead($config_ini, "TrackMap", "Radio_Mode_2", "")

If $Radio_Mode_1 = "" and $Radio_Mode_1 = "" Then
	$Radio_Mode_1 = "true"
EndIf

Global $Radio_TrackMapReplay_1 = GUICtrlCreateRadio("Live TrackMap", 782, 912, 95, 15)
If $Radio_Mode_1 = "true" Then GUICtrlSetState($Radio_TrackMapReplay_1, $GUI_CHECKED)

Global $Radio_TrackMapReplay_2 = GUICtrlCreateRadio("TrackMap Replay [Offline]", 782, 927, 143, 15)
If $Radio_Mode_2 = "true" Then GUICtrlSetState($Radio_TrackMapReplay_2, $GUI_CHECKED)


#endregion GUI - Radio Buttons

#region GUI - Scale UpDown

$Tack_Name_Scale = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
$Check_Track_Scale_Exists = IniRead($TrackMap_INI, $Tack_Name_Scale, "Track", "")

$Style = ""
;If $Check_Track_Scale_Exists <> "" Then $Style = $WS_EX_TRANSPARENT
;MsgBox(0, "", $Check_Track_Scale_Exists & @CRLF & $Style)

GUICtrlCreateLabel("Scale:", 130, 908, 40, 13) ; X = 155
$UpDown_1_Value = IniRead($TrackMap_INI, "TrackMap", "Scale", "")
$Input_UpDown_1 = GUICtrlCreateInput($UpDown_1_Value, 130, 921, 40, 20, $Style)
GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)
$UpDown_1 = GUICtrlCreateUpdown($Input_UpDown_1)

GUICtrlCreateLabel("Pos. X:", 175, 908, 40, 13)
$UpDown_2_Value = IniRead($TrackMap_INI, "TrackMap", "X", "")
$Input_UpDown_2 = GUICtrlCreateInput($UpDown_2_Value, 175, 921, 48, 20, $Style)
GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)
$UpDown_2 = GUICtrlCreateUpdown($Input_UpDown_2)

GUICtrlCreateLabel("Pos. Y:", 228, 908, 40, 13)
$UpDown_3_Value = IniRead($TrackMap_INI, "TrackMap", "Y", "")
$Input_UpDown_3 = GUICtrlCreateInput($UpDown_3_Value, 228, 921, 48, 20, $Style)
GUICtrlSetFont(-1, 10, $FW_NORMAL, "", $font_2)
$UpDown_3 = GUICtrlCreateUpdown($Input_UpDown_3)

$Tack_Name_Scale = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
$Check_Track_Scale_Exists = IniRead($TrackMap_INI, $Tack_Name_Scale, "Track", "")


#endregion GUI - Scale UpDown

#region GUI - Buttons
; Buttons

Global $Button_TrackMap_1 = GUICtrlCreateButton("Save TrackMap Scale", 285, 910, 70, 30, $BS_BITMAP)
_GUICtrlButton_SetImage($Button_TrackMap_1, $gfx & "Save_Track_Scale.bmp")
GuiCtrlSetTip(-1, "Saves the current Values 'Scale' / 'X' / 'Y' for the current running Track.")

Global $Button_TrackMap_2 = GUICtrlCreateButton("Delete TrackMap Scale", 357, 910, 70, 30, $BS_BITMAP)
_GUICtrlButton_SetImage($Button_TrackMap_2, $gfx & "Delete_Track_Scale.bmp")
GuiCtrlSetTip(-1, "Deletes the current Values 'Scale' / 'X' / 'Y' for the current running Track. This is needed to be able to adjust new ones.")

Global $Button_TrackMap_3 = GUICtrlCreateButton("Open TrackMapReplay", 582, 915, 27, 26, $BS_BITMAP)
_GUICtrlButton_SetImage($Button_TrackMap_3, $gfx & "Open_TrackMapReplay.bmp")
GuiCtrlSetTip(-1, "Open a new Track Map Replay File. (Use Play Button after choosing the File to start the Replay).")

Global $Button_TrackMap_4 = GUICtrlCreateButton("Play TrackMapReplay", 611, 915, 27, 26, $BS_BITMAP)
_GUICtrlButton_SetImage($Button_TrackMap_4, $gfx & "Play_TrackMapReplay.bmp")
GuiCtrlSetTip(-1, "Starts playing the Replay. Plays the current/last recorded Replay or the last opened/loaded Replay.")

Global $Button_TrackMap_5 = GUICtrlCreateButton("Stop TrackMapReplay", 655, 915, 55, 26, $BS_BITMAP)
_GUICtrlButton_SetImage($Button_TrackMap_5, $gfx & "Recording_Menu.bmp")
GuiCtrlSetTip(-1, "Opens Recording Menu with is needed to record the Replay.")

Global $Button_TrackMap_6 = GUICtrlCreateButton("Stop TrackMapReplay", 712, 915, 55, 26, $BS_BITMAP)
_GUICtrlButton_SetImage($Button_TrackMap_6, $gfx & "Stop_Recording.bmp")
GuiCtrlSetTip(-1, "Stops the current running Recording." & @CRLF & "(This Buttons needs to be used to stop the recording process in TrackMapReplay Window).")

Global $Button1 = GUICtrlCreateButton("Update Window", 5, 952, 70, 30, $BS_BITMAP)
_GUICtrlButton_SetImage($Button1, $gfx & "Update_all.bmp")
;GuiCtrlSetTip(-1, $Infos_view_pb_Button_2)

;Global $Button8 = GUICtrlCreateButton("Save all", 930, 952, 70, 30, $BS_BITMAP)
;_GUICtrlButton_SetImage($Button8, $gfx & "Save_all.bmp")
;GuiCtrlSetTip(-1, "Save ALL Results.")

;Global $Button9 = GUICtrlCreateButton("Stop Update", 1005, 952, 70, 30, $BS_BITMAP)
;_GUICtrlButton_SetImage($Button9, $gfx & "Stop_Update.bmp")
;GuiCtrlSetTip(-1, "Stop Updating data.")
#endregion GUI - Buttons

#endregion GUI - Settings

#region GUI - StatusBar
_GUICtrlStatusBar_SetText($Statusbar, $Server_Name & @TAB & $Server_Status & @TAB & "Timestamp: " & $timestamp)
If $Check_Track_Scale_Exists <> "" Then
	_GUICtrlStatusBar_SetText($Statusbar, "Track Scale Values loaded for Track: " & $Tack_Name_Scale & @TAB & "" & @TAB & "Timestamp: " & $timestamp)
EndIf

#endregion GUI - StatusBar

#region GUI - Set On Events
GUISetOnEvent($GUI_EVENT_CLOSE, "_Beenden")			;die Dialogbox wird geschlossen (entweder durch einen bestimmten Button oder das Systemmenü).
GUICtrlSetOnEvent($UpDown_1, "_UpDown_1")
GUICtrlSetOnEvent($UpDown_2, "_UpDown_2")
GUICtrlSetOnEvent($UpDown_3, "_UpDown_3")
GUICtrlSetOnEvent($Button_TrackMap_1, "_Button_TrackMap_1") ; Save
GUICtrlSetOnEvent($Button_TrackMap_2, "_Button_TrackMap_2") ; Delete
GUICtrlSetOnEvent($Button_TrackMap_3, "_Button_TrackMap_3")
GUICtrlSetOnEvent($Button_TrackMap_4, "_Button_TrackMap_4")
GUICtrlSetOnEvent($Button_TrackMap_5, "_Button_TrackMap_5")
GUICtrlSetOnEvent($Button_TrackMap_6, "_Button_TrackMap_6")
GUICtrlSetOnEvent($Button1, "_Update_TrackMap")
GUICtrlSetOnEvent($Checkbox_1, "_Checkbox_1")
GUICtrlSetOnEvent($Checkbox_2, "_Checkbox_2")
GUICtrlSetOnEvent($Checkbox_3, "_Checkbox_3")
GUICtrlSetOnEvent($Checkbox_4, "_Checkbox_4")
GUICtrlSetOnEvent($Checkbox_5, "_Checkbox_5")
GUICtrlSetOnEvent($Radio_TrackMapReplay_1, "_Radio_TrackMapReplay_1")
GUICtrlSetOnEvent($Radio_TrackMapReplay_2, "_Radio_TrackMapReplay_2")
#endregion GUI - StatusBar

#region LOOP

$Check_PCDSG_DS_Status = IniRead($config_ini, "PC_Server", "Status", "")

Global $Check_Status_Radio_Mode_1 = IniRead($config_ini, "TrackMap", "Radio_Mode_1", "")
Global $Check_Status_Radio_Mode_2 = IniRead($config_ini, "TrackMap", "Radio_Mode_2", "")

If $Check_PCDSG_DS_Status = "PC_Server_beendet" Then
	$Check_Status_Radio_Mode_1 = "false"
	$Check_Status_Radio_Mode_2 = "true"
	GUICtrlSetState($Radio_TrackMapReplay_2, $GUI_CHECKED)
EndIf


If $Check_Status_Radio_Mode_1 = "true" Then

	$TrackMap_participants_Data_INI = $System_Dir & "TrackMap\TrackMap_participants_Data.ini"

	Do
		$NowDate_Value = _NowDate()
		$NowDate = StringReplace($NowDate_Value, "/", ".")
		$NowTime_Value = _NowTime()
		$NowTime_orig = $NowTime_Value
		$NowTime = StringReplace($NowTime_Value, ":", "-")

		$Check_Checkbox_Position_Shadow = IniRead($config_ini, "TrackMap", "Checkbox_1", "")
		$Check_Checkbox_Show_Track = IniRead($config_ini, "TrackMap", "Checkbox_2", "")
		_Download()
		_TrackMap_Participants_Daten_Update()
		_ListView_Update_Kopfzeile_Header()
		_ListView_Update_ListView_1()
		_Scale()
		_Update_TrackMap()

		If $Check_Checkbox_Show_Track = "true" Then
			;MsgBox(0, "", "true")
			_Set_Background()
		EndIf


		$NR_Racers_Valid = IniRead($Server_Data_INI, "DATA", "NumParticipantsValid", "")
		If $NR_Racers_Valid < 5 Then
			If $NR_Racers_Valid = 5 Then Sleep(200)
			If $NR_Racers_Valid = 4 Then Sleep(500)
			If $NR_Racers_Valid = 3 Then Sleep(800)
			If $NR_Racers_Valid = 2 Then Sleep(1200)
			If $NR_Racers_Valid = 1 Then Sleep(1500)
			If $NR_Racers_Valid = 0 Then Sleep(5000)
			If $NR_Racers_Valid = "" Then Sleep(5000)
		Else
			Sleep(100)
		EndIf


		$PC_Server_Status = IniRead($config_ini, "PC_Server", "Status", "")


		$Server_Name = IniRead($Server_Data_INI, "DATA", "name", "")
		;$Track_Name = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
		$Track_Name = IniRead($Server_Data_INI, "DATA", "TrackName", "")
		$Server_Status = IniRead($Server_Data_INI, "DATA", "state", "")
		If $Server_Status = "" Then $Server_Status = "OFFLINE"

		If $Track_Name = "" Then _TRACK_NAME_from_ID()

		GUICtrlSetState($Label_Wert_Server_Name, $Server_Name)
		GUICtrlSetState($Label_Wert_Track, $Track_Name)
		GUICtrlSetState($Label_Wert_Server_State, $Server_Status)


		Global $Check_Checkbox_PCDSG_Stats_path = IniRead($config_ini, "Einstellungen", "Checkbox_PCDSG_Stats_path", "")
		If $Check_Checkbox_PCDSG_Stats_path = "true" Then
			_Sync_TrackMap()
		EndIf


		$timestamp = _NowDate() & " - " & _NowTime()

		$Tack_Name_Scale = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
		$Check_Track_Scale_Exists = IniRead($TrackMap_INI, $Tack_Name_Scale, "Track", "")

		If $Check_Track_Scale_Exists <> "" Then
			$Tack_Size_Scale_Value = IniRead($TrackMap_INI, $Tack_Name_Scale, "Scale", "")
			$X_Plus = IniRead($TrackMap_INI, $Tack_Name_Scale, "X", "")
			$Y_Plus = IniRead($TrackMap_INI, $Tack_Name_Scale, "Y", "")
			_GUICtrlStatusBar_SetText($Statusbar, "Track Scale Values loaded for Track: " & $Tack_Name_Scale & @TAB & "" & @TAB & "Timestamp: " & $timestamp)
			GUICtrlSetData($Input_UpDown_1, $Tack_Size_Scale_Value)
			GUICtrlSetData($Input_UpDown_2, $X_Plus)
			GUICtrlSetData($Input_UpDown_3, $Y_Plus)
			GUICtrlSetColor($Input_UpDown_1, "0xD3D3D3")
			GUICtrlSetColor($Input_UpDown_2, "0xD3D3D3")
			GUICtrlSetColor($Input_UpDown_3, "0xD3D3D3")
			IniWrite($TrackMap_INI, "TrackMap", "Scale", $Tack_Size_Scale_Value)
			IniWrite($TrackMap_INI, "TrackMap", "X", $X_Plus)
			IniWrite($TrackMap_INI, "TrackMap", "Y", $Y_Plus)
		Else
			_GUICtrlStatusBar_SetText($Statusbar, "Track Scale Values not loaded: " & @TAB & "Track: " & $Tack_Name_Scale & @TAB & "Timestamp: " & $timestamp)
			GUICtrlSetColor($Input_UpDown_1, $COLOR_BLACK)
			GUICtrlSetColor($Input_UpDown_2, $COLOR_BLACK)
			GUICtrlSetColor($Input_UpDown_3, $COLOR_BLACK)
		EndIf

	Until $PC_Server_Status = "PC_Server_beendet"

EndIf

If $Check_Status_Radio_Mode_2 = "true" Then
	;_TrackMapReplay_Mode()
	_GUICtrlStatusBar_SetText($Statusbar, "Track Map Replay Mode: " & @TAB & "Replay not started. Use the Buttons 'Open' and 'Play' in TrackMapReplay section to start a new Replay." & @TAB & "Timestamp: " & $timestamp)
EndIf

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

Func _TrackMapReplay_Mode()

$Replay_File = IniRead($config_ini, "TrackMap", "Replay_File", "")

If $Replay_File <> "" Then
	Global $TrackMapReplay_INI = $Replay_File
Else
	;Global $TrackMapReplay_INI = $TrackMapReplay_INI
EndIf

Global $TrackMap_participants_Data_INI = $TrackMapReplay_INI

Global $TrackName_Replay = IniRead($TrackMapReplay_INI, "TrackMapReplay", "TrackName", "")
Global $SessionStage_Replay = IniRead($TrackMapReplay_INI, "TrackMapReplay", "SessionStage", "")

$LOOP_Start = 0
$LOOP_End = IniRead($TrackMapReplay_INI, "TrackMapReplay", "NR_Records", "")

$TMR_Replay_Status = IniRead($config_ini, "TEMP", "Status_TrackMapReplay", "")

_GUICtrlStatusBar_SetText($Statusbar, "Track Map Replay Mode: " & @TAB & $LOOP_Start & " / " & $LOOP_End & @TAB & "Timestamp: " & $timestamp)

$Abfrage = MsgBox(4, "Replay Start", "Replay File: " & @CRLF & _
							$TrackMapReplay_INI & @CRLF & @CRLF & _
							"Replay for:" & @CRLF & _
							"Track: " & @TAB & @TAB & $TrackName_Replay & @CRLF & _
							"Session Stage: " & @TAB & $SessionStage_Replay & @CRLF & _
							"Replay Start: " & @TAB & $LOOP_Start & @CRLF & _
							"Replay End: " & @TAB & $LOOP_End & @CRLF & @CRLF & _
							"Do you want to Start the Track Map Replay?")

If $Abfrage = 6 Then ;Ja - Auswahl = JA

	If Not WinExists("PCDSG TrackMap Replay - Play Menu") Then
		If FileExists($System_Dir & "TrackMapReplayMenu.exe") Then
			ShellExecute($System_Dir & "TrackMapReplayMenu.exe")
		Else
			If FileExists($System_Dir & "TrackMapReplayMenu.au3") Then
				ShellExecute($System_Dir & "TrackMapReplayMenu.au3")
			EndIf
		EndIf
	EndIf

Do
	;MsgBox(0, "Replay Start", "Replay will start now...", 2)
	Sleep(500)

	Global $Value_PlaySpeed_Step = IniRead($config_ini, "TrackMap", "Replay_PlaySpeed", "")
	If $Value_PlaySpeed_Step = "" Then $Value_PlaySpeed_Step = 1

	For $Loop_1 = $LOOP_Start to $LOOP_End Step $Value_PlaySpeed_Step

		$NowDate_Value = _NowDate()
		$NowDate = StringReplace($NowDate_Value, "/", ".")
		$NowTime_Value = _NowTime()
		$NowTime_orig = $NowTime_Value
		$NowTime = StringReplace($NowTime_Value, ":", "-")

		$Check_Checkbox_Position_Shadow = IniRead($config_ini, "TrackMap", "Checkbox_1", "")
		$Check_Checkbox_Show_Track = IniRead($config_ini, "TrackMap", "Checkbox_2", "")
		;_Download()
		;_TrackMap_Participants_Daten_Update()
		;_ListView_Update_Kopfzeile_Header()
		;_ListView_Update_ListView_1()
		_Scale()
		;_Update_TrackMap()
		_Update_TrackMapReplay_Mode()
		_ListView_Update_ListView_TrackMapReplay_Mode()

		If $Check_Checkbox_Show_Track = "true" Then
			;MsgBox(0, "", "true")
			_Set_Background()
		EndIf


		$NR_Racers_Valid = IniRead($Server_Data_INI, "DATA", "NumParticipantsValid", "")
		If $NR_Racers_Valid < 5 Then
			If $NR_Racers_Valid = 5 Then Sleep(100)
			If $NR_Racers_Valid = 4 Then Sleep(100)
			If $NR_Racers_Valid = 3 Then Sleep(100)
			If $NR_Racers_Valid = 2 Then Sleep(100)
			If $NR_Racers_Valid = 1 Then Sleep(100)
			If $NR_Racers_Valid = 0 Then Sleep(100)
			If $NR_Racers_Valid = "" Then Sleep(100)
		Else
			Sleep(100)
		EndIf


		$TMR_Replay_Status = IniRead($config_ini, "TEMP", "Status_TrackMapReplay", "")


		$Server_Name = IniRead($Server_Data_INI, "DATA", "name", "")
		;$Track_Name = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
		;$Track_Name = IniRead($Server_Data_INI, "DATA", "TrackName", "")
		$Track_Name = $TrackName_Replay
		$Server_Status = IniRead($Server_Data_INI, "DATA", "state", "")
		If $Server_Status = "" Then $Server_Status = "OFFLINE"

		If $Track_Name = "" Then _TRACK_NAME_from_ID()

		GUICtrlSetState($Label_Wert_Server_Name, $Server_Name)
		GUICtrlSetState($Label_Wert_Track, $Track_Name)
		GUICtrlSetState($Label_Wert_Server_State, $Server_Status)


		Global $Check_Checkbox_PCDSG_Stats_path = IniRead($config_ini, "Einstellungen", "Checkbox_PCDSG_Stats_path", "")
		If $Check_Checkbox_PCDSG_Stats_path = "true" Then
			_Sync_TrackMap()
		EndIf


		$timestamp = _NowDate() & " - " & _NowTime()

		If $Check_Track_Scale_Exists <> "" Then
			$Tack_Size_Scale_Value = IniRead($TrackMap_INI, $Tack_Name_Scale, "Scale", "")
			$X_Plus = IniRead($TrackMap_INI, $Tack_Name_Scale, "X", "")
			$Y_Plus = IniRead($TrackMap_INI, $Tack_Name_Scale, "Y", "")
			;_GUICtrlStatusBar_SetText($Statusbar, "Track Scale Values loaded for Track: " & $Tack_Name_Scale & @TAB & "" & @TAB & "Timestamp: " & $timestamp)
			GUICtrlSetData($Input_UpDown_1, $Tack_Size_Scale_Value)
			GUICtrlSetData($Input_UpDown_2, $X_Plus)
			GUICtrlSetData($Input_UpDown_3, $Y_Plus)
			GUICtrlSetColor($Input_UpDown_1, "0xD3D3D3")
			GUICtrlSetColor($Input_UpDown_2, "0xD3D3D3")
			GUICtrlSetColor($Input_UpDown_3, "0xD3D3D3")
			IniWrite($TrackMap_INI, "TrackMap", "Scale", $Tack_Size_Scale_Value)
			IniWrite($TrackMap_INI, "TrackMap", "X", $X_Plus)
			IniWrite($TrackMap_INI, "TrackMap", "Y", $Y_Plus)
		Else
			;_GUICtrlStatusBar_SetText($Statusbar, "Track Scale Values not loaded: " & @TAB & "Track: " & $Tack_Name_Scale & @TAB & "Timestamp: " & $timestamp)
			GUICtrlSetColor($Input_UpDown_1, $COLOR_BLACK)
			GUICtrlSetColor($Input_UpDown_2, $COLOR_BLACK)
			GUICtrlSetColor($Input_UpDown_3, $COLOR_BLACK)
		EndIf

	IniWrite($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", $Loop_1)
	$Value_PlaySpeed_Step = IniRead($config_ini, "TrackMap", "Replay_PlaySpeed", "")

	;$ProcesBar_100 =
	$ProcesBar_current = $Loop_1 * 100 / $LOOP_End
	$ProcesBar_current = Round($ProcesBar_current, 0)

	_GUICtrlStatusBar_SetText($Statusbar, "Track Map Replay Mode: " & @TAB & $Loop_1 & " / " & $LOOP_End & " [" & $ProcesBar_current & "%" & "]" & @TAB & "Timestamp: " & $timestamp)
	GUICtrlSetData($Anzeige_Fortschrittbalken, $ProcesBar_current)

	If $TMR_Replay_Status = "Replay stopped" Then
		IniWrite($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", "")
		_GUICtrlStatusBar_SetText($Statusbar, "Track Map Replay Mode: " & @TAB & "Replay not started. Use the Buttons 'Open' and 'Play' in TrackMapReplay section to start a new Replay." & @TAB & "Timestamp: " & $timestamp)
		GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
		ExitLoop
	EndIf

	Next


	$Abfrage = MsgBox(4, "Replay Ended", "Replay completed." & @CRLF & @CRLF & _
												"Do you want to Stop / Exit the Replay?")

	If $Abfrage = 6 Then ;Ja - Auswahl = JA
		IniWrite($config_ini, "TEMP", "Status_TrackMapReplay", "Replay stopped")
		IniWrite($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", "")
		_GUICtrlStatusBar_SetText($Statusbar, "Track Map Replay Mode: " & @TAB & "Replay not started. Use the Buttons 'Open' and 'Play' in TrackMapReplay section to start a new Replay." & @TAB & "Timestamp: " & $timestamp)
		GUICtrlSetData($Anzeige_Fortschrittbalken, 0)
		ExitLoop
	EndIf

	If $Abfrage = 7 Then ;Nein - Auswahl = Nein

	EndIf

Until $TMR_Replay_Status = "Replay stopped"
EndIf

If $Abfrage = 7 Then ;Nein - Auswahl = Nein

EndIf

;GUICtrlSetData($Anzeige_Fortschrittbalken, 0)

EndFunc

Func _Download()

$URL_participants = "http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort & "/api/session/status?attributes&participants"
;MsgBox(0, "", $URL_participants)

$download = InetGet($URL_participants, $TrackMap_participants_json, 16, 0)
EndFunc

Func _TrackMap_Participants_Daten_Update()

$Ende_Zeile_NR = _FileCountLines($TrackMap_participants_json) - 1

	$participants_Name = ""
	$participants_Name_bea = ""
	$Name = ""
	$Wert = ""

If FileExists($TrackMap_participants_Data_INI) Then
	$EmptyFile = FileOpen($TrackMap_participants_Data_INI, 2)
	FileWrite($EmptyFile, "")
	FileClose($EmptyFile)
EndIf

For $iCount_3 = 77 To $Ende_Zeile_NR

	$Wert_Zeile = FileReadLine($TrackMap_participants_json, $iCount_3)
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
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "RefId", $participants_RefId)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "Name", $participants_Name)
	;IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "IsPlayer", $participants_IsPlayer)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "GridPosition", $participants_GridPosition)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "VehicleId", $participants_VehicleId)
	;IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "LiveryId", $participants_LiveryId)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "RacePosition", $participants_RacePosition)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "CurrentLap", $participants_CurrentLap)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "CurrentSector", $participants_CurrentSector)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "Sector1Time", $participants_Sector1Time)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "Sector2Time", $participants_Sector2Time)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "Sector3Time", $participants_Sector3Time)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "LastLapTime", $participants_LastLapTime)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "FastestLapTime", $participants_FastestLapTime)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "State", $participants_State)
	;IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "HeadlightsOn", $participants_HeadlightsOn)
	;IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "WipersOn", $participants_WipersOn)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "Speed", $participants_Speed)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "Gear", $participants_Gear)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "RPM", $participants_RPM)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "PositionX", $participants_PositionX)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "PositionY", $participants_PositionY)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "PositionZ", $participants_PositionZ)
	IniWrite($TrackMap_participants_Data_INI, $participants_RacePosition, "Orientation", $participants_Orientation)
	FileWriteLine($TrackMap_participants_Data_INI, "")
	;If $participants_RacePosition = 11 Then $iCount_3 = $Ende_Zeile_NR ; --> Loop Exit after Position 11
EndIf

Next

EndFunc

Func _ListView_Update_Kopfzeile_Header()
; Session Name:
$Wert = IniRead($Server_Data_INI, "DATA", "name", "")
$Server_Name = $Wert

; Lobby Check:
$Check_Lobby = IniRead($Server_Data_INI, "DATA", "SessionStage", "")

;Track Name
$Wert = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
$Wert_Track = $Wert
If $Wert_Track = "0" Then $Wert_Track = ""

; Players Session
$Wert_1 = IniRead($Server_Data_INI, "DATA", "NumParticipantsValid", "")
$Wert_2 = IniRead($Server_Data_INI, "DATA", "max_member_count", "")
If $Wert_1 < 10 Then $Wert_1 = "0" & $Wert_1
If $Wert_2 < 10 Then $Wert_1 = "0" & $Wert_2
$Wert_NR_Players = $Wert_1 ;& "/" & $Wert_2
If $Wert_NR_Players = "0/" Then $Wert_NR_Players = ""
If $Wert_NR_Players = "0 / " Then $Wert_NR_Players = ""
If $Wert_NR_Players = "00/0" Then $Wert_NR_Players = ""

$Wert_NR_Players = $Wert_1 & " / " & $Wert_2
If $Wert_NR_Players = "00 / 0" Then $Wert_NR_Players = ""
If $Wert_NR_Players = "0 / " Then $Wert_NR_Players = ""
;If $Wert_NR_Players = "0/ " Then $Wert_NR_Players = ""

; Session SessionStage
$Wert = IniRead($Server_Data_INI, "DATA", "SessionStage", "")
$Wert_Session = IniRead($Server_Data_INI, "DATA", "SessionStage", "")

; Time Session
$Wert_1 = IniRead($Server_Data_INI, "DATA", "SessionTimeElapsed", "")
If $Wert_Session = "Practice1" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "Practice1Length", "")
If $Wert_Session = "Practice2" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "Practice2Length", "")
If $Wert_Session = "Qualifying" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "QualifyLength", "")
If $Wert_Session = "Warmup" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "WarmupLength", "")
If $Wert_Session = "Race1" Then
	$Wert_2 = IniRead($Server_Data_INI, "DATA", "Race1Length", "")
	$Race1Length = IniRead($Server_Data_INI, "DATA", "Race1Length", "")
EndIf

If $Wert_Session = "Race1" Then $Wert_2 = IniRead($Server_Data_INI, "DATA", "Race2Length", "")

$Wert_Time = $Wert_1 & " / " & $Wert_2 & ":00" & " min"
If $Wert_Session = "Race1" Then $Wert_Time = "Race - " & $Race1Length & " laps"
If $Wert_1 = "" Then $Wert_Time = ""

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
	If $Server_Status = "Idle" Then GUICtrlSetColor($Label_Wert_Server_State, $COLOR_BLACK)
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
EndFunc

Func _ListView_Update_ListView_1()

$Show_max_10 = IniRead($config_ini, "TrackMap", "Checkbox_3", "")
$Show_colored_text = IniRead($config_ini, "TrackMap", "Checkbox_4", "")

$LOOP_To = 32

If $Show_max_10 = "true" Then $LOOP_To = 10
If $Show_max_10 <> "true" Then $LOOP_To = 32

_GUICtrlListView_BeginUpdate($ListView_1) ; Beginn Update

;$CuttentTack = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
$CuttentTack = $TrackName_Replay
_GUICtrlListView_DeleteAllItems($ListView_1)

For $LOOP_ListView_1 = 1 To $LOOP_To

	$Wert_LAP_PitStop = ""

	$Wert_LA_RefId = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "RefId","") ; RefId

	;MsgBox(0, "", $Wert_LA_RefId)

	If $Wert_LA_RefId <> "" Then
		$Wert_LA_1 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "Name","") ; Name
		If $Wert_LA_1 = "" Then $Wert_LA_1 = IniRead($Members_Data_INI, $Wert_LA_RefId, "name","")

		$Wert_LA_1_bea = $Wert_LA_1

		If $Wert_LA_1 <> "" Then
			$Wert_LA_1_bea = StringReplace($Wert_LA_1, "[", "<")
			$Wert_LA_1_bea = StringReplace($Wert_LA_1_bea, "]", ">")
		EndIf

		If $Wert_LA_1_bea = "" Then $Wert_LA_1_bea = $Wert_LA_1

		$Wert_LA_2 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "GridPosition","") ; GridPosition
		$Wert_LA_3 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "VehicleId","") ; VehicleId
		IniWrite($config_ini, "TEMP", "Check_Carid", $Wert_LA_3)
		$Wert_CAR_ID_Check = $Wert_LA_3
		;MsgBox(0, "", $Wert_LA_3)
		_Car_Name_from_ID()
		$Wert_LA_3 = IniRead($config_ini, "TEMP", "Check_CarName", $Wert_CAR_ID_Check) ; Car Name
		$Wert_LA_3_Car = $Wert_LA_3
		$Wert_LA_3_Len = StringLen($Wert_LA_3)
		$Wert_LA_3 = StringTrimRight($Wert_LA_3, $Wert_LA_3_Len - 21)
		If $Wert_LA_3 <> "" Then $Wert_LA_3 = $Wert_LA_3 & "..."
		$Wert_LA_4 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "RacePosition","") ; RacePosition
		$Wert_LA_5 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "CurrentLap","") ; CurrentLap
		$Wert_LA_6 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "CurrentSector","") ; CurrentSector
		$Wert_LA_7 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "Sector1Time","") ; Sector1Time
		$Wert_LA_8 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "Sector2Time","")  ; Sector2Time
		$Wert_LA_9 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "Sector3Time","")  ; Sector3Time
		$Wert_LA_10 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "LastLapTime","")  ; LastLapTime
		$Wert_LA_11 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "FastestLapTime","")   ; FastestLapTime
		$Wert_LA_12 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "State","")  ; State


		$Farbe_State_ListView_Participants = $COLOR_BLACK

		$Farbe_BLACK = 0x000000
		$Navy = 0x000080
		$Farbe_DarkBlue = 0x00008B
		$Farbe_MediumBlue = 0x0000CD
		$Farbe_Blue = 0x0000FF
		$Farbe_DarkGreen = 0x006400
		$Farbe_Green = 0x008000
		$Farbe_Teal = 0x008080
		$Farbe_DarkCyan = 0x008B8B
		$Farbe_DeepSkyBlue = 0x00BFFF
		$Farbe_DarkTurquoise = 0x00CED1
		$Farbe_MediumSpringGreen = 0x00FA9A
		$Farbe_Lime = 0x00FF00
		$Farbe_SpringGreen = 0x00FF7F
		$Farbe_Aqua = 0x00FFFF
		$Farbe_Cyan = 0x00FFFF
		$Farbe_MidnightBlue = 0x191970
		$Farbe_DodgerBlue = 0x1E90FF
		$Farbe_LightSeaGreen = 0x20B2AA
		$Farbe_ForestGreen = 0x228B22
		$Farbe_SeaGreen = 0x2E8B57
		$Farbe_DarkSlateGray = 0x2F4F4F
		$Farbe_LimeGreen = 0x32CD32
		$Farbe_MediumSeaGreen = 0x3CB371
		$Farbe_Turquoise = 0x40E0D0
		$Farbe_RoyalBlue = 0x4169E1
		$Farbe_SteelBlue = 0x4682B4
		$Farbe_DarkSlateBlue = 0x483D8B
		$Farbe_MediumTurquoise = 0x48D1CC
		$Farbe_Indigo = 0x4B0082
		$Farbe_DarkOliveGreen = 0x556B2F
		$Farbe_CadetBlue = 0x5F9EA0
		$Farbe_CornflowerBlue = 0x6495ED
		$Farbe_MediumAquaMarine = 0x66CDAA
		$Farbe_DimGray = 0x696969
		$Farbe_SlateBlue = 0x6A5ACD
		$Farbe_OliveDrab = 0x6B8E23
		$Farbe_SlateGray = 0x708090
		$Farbe_LightSlateGray = 0x778899
		$Farbe_MediumSlateBlue = 0x7B68EE
		$Farbe_LawnGreen = 0x7CFC00
		$Farbe_Chartreuse = 0x7FFF00
		$Farbe_Aquamarine = 0x7FFFD4
		$Farbe_Maroon = 0x800000
		$Farbe_Purple = 0x800080
		$Farbe_Olive = 0x808000
		$Farbe_Gray = 0x808080
		$Farbe_SkyBlue = 0x87CEEB
		$Farbe_LightSkyBlue = 0x87CEFA
		$Farbe_BlueViolet = 0x8A2BE2
		$Farbe_DarkRed = 0x8B0000
		$Farbe_DarkMagenta = 0x8B008B
		$Farbe_SaddleBrown = 0x8B4513
		$Farbe_DarkSeaGreen = 0x8FBC8F
		$Farbe_LightGreen = 0x90EE90
		$Farbe_MediumPurple = 0x9370D8
		$Farbe_DarkViolet = 0x9400D3
		$Farbe_PaleGreen = 0x98FB98
		$Farbe_DarkOrchid = 0x9932CC
		$Farbe_YellowGreen = 0x9ACD32
		$Farbe_Sienna = 0xA0522D
		$Farbe_Brown = 0xA52A2A
		$Farbe_DarkGray = 0xA9A9A9
		$Farbe_LightBlue = 0xADD8E6
		$Farbe_GreenYellow = 0xADFF2F
		$Farbe_PaleTurquoise = 0xAFEEEE
		$Farbe_LightSteelBlue = 0xB0C4DE
		$Farbe_PowderBlue = 0xB0E0E6
		$Farbe_FireBrick = 0xB22222
		$Farbe_DarkGoldenRod = 0xB8860B
		$Farbe_MediumOrchid = 0xBA55D3
		$Farbe_RosyBrown = 0xBC8F8F
		$Farbe_DarkKhaki = 0xBDB76B
		$Farbe_Silver = 0xC0C0C0
		$Farbe_MediumVioletRed = 0xC71585
		$Farbe_IndianRed = 0xCD5C5C
		$Farbe_Peru = 0xCD853F
		$Farbe_Chocolate = 0xD2691E
		$Farbe_Tan = 0xD2B48C
		$Farbe_LightGrey = 0xD3D3D3
		$Farbe_PaleVioletRed = 0xD87093
		$Farbe_Thistle = 0xD8BFD8
		$Farbe_Orchid = 0xDA70D6
		$Farbe_GoldenRod = 0xDAA520
		$Farbe_Crimson = 0xDC143C
		$Farbe_Gainsboro = 0xDCDCDC
		$Farbe_Plum = 0xDDA0DD
		$Farbe_BurlyWood = 0xDEB887
		$Farbe_LightCyan = 0xE0FFFF
		$Farbe_Lavender = 0xE6E6FA
		$Farbe_DarkSalmon = 0xE9967A
		$Farbe_Violet = 0xEE82EE
		$Farbe_PaleGoldenRod = 0xEEE8AA
		$Farbe_LightCoral = 0xF08080
		$Farbe_Khaki = 0xF0E68C
		$Farbe_AliceBlue = 0xF0F8FF
		$Farbe_HoneyDew = 0xF0FFF0
		$Farbe_Azure = 0xF0FFFF
		$Farbe_SandyBrown = 0xF4A460
		$Farbe_Wheat = 0xF5DEB3
		$Farbe_Beige = 0xF5F5DC
		$Farbe_WhiteSmoke = 0xF5F5F5
		$Farbe_MintCream = 0xF5FFFA
		$Farbe_GhostWhite = 0xF8F8FF
		$Farbe_Salmon = 0xFA8072
		$Farbe_AntiqueWhite = 0xFAEBD7
		$Farbe_Linen = 0xFAF0E6
		$Farbe_LightGoldenRodYellow = 0xFAFAD2
		$Farbe_OldLace = 0xFDF5E6
		$Farbe_Red = 0xFF0000
		$Farbe_Fuchsia = 0xFF00FF
		$Farbe_Magenta = 0xFF00FF
		$Farbe_DeepPink = 0xFF1493
		$Farbe_OrangeRed = 0xFF4500
		$Farbe_Tomato = 0xFF6347
		$Farbe_HotPink = 0xFF69B4
		$Farbe_Coral = 0xFF7F50
		$Farbe_Darkorange = 0xFF8C00
		$Farbe_LightSalmon = 0xFFA07A
		$Farbe_Orange = 0xFFA500
		$Farbe_LightPink = 0xFFB6C1
		$Farbe_Pink = 0xFFC0CB
		$Farbe_Gold = 0xFFD700
		$Farbe_PeachPuff = 0xFFDAB9
		$Farbe_NavajoWhite = 0xFFDEAD
		$Farbe_Moccasin = 0xFFE4B5
		$Farbe_Bisque = 0xFFE4C4
		$Farbe_MistyRose = 0xFFE4E1
		$Farbe_BlanchedAlmond = 0xFFEBCD
		$Farbe_PapayaWhip = 0xFFEFD5
		$Farbe_LavenderBlush = 0xFFF0F5
		$Farbe_SeaShell = 0xFFF5EE
		$Farbe_Cornsilk = 0xFFF8DC
		$Farbe_LemonChiffon = 0xFFFACD
		$Farbe_FloralWhite = 0xFFFAF0
		$Farbe_Snow = 0xFFFAFA
		$Farbe_Yellow = 0xFFFF00
		$Farbe_LightYellow = 0xFFFFE0
		$Farbe_Ivory = 0xFFFFF0
		$Farbe_White = 0xFFFFFF

		If $Show_colored_text = "true" Then
			If $Wert_LA_4 = "1" Then $Farbe_State_ListView_Participants = $COLOR_RED
			If $Wert_LA_4 = "2" Then $Farbe_State_ListView_Participants = $COLOR_GREEN
			If $Wert_LA_4 = "3" Then $Farbe_State_ListView_Participants = $COLOR_BLUE
			If $Wert_LA_4 = "4" Then $Farbe_State_ListView_Participants = $Farbe_SandyBrown ; $Farbe_LightYellow - $Farbe_YellowGreen  - $Farbe_GreenYellow  - $Farbe_LightGoldenRodYellow  - $Farbe_Yellow
			If $Wert_LA_4 = "5" Then $Farbe_State_ListView_Participants = $Farbe_Gray ; $Farbe_DarkSlateGray $Farbe_DimGray $Farbe_SlateGray
			If $Wert_LA_4 = "6" Then $Farbe_State_ListView_Participants = $Farbe_DeepPink
			If $Wert_LA_4 = "7" Then $Farbe_State_ListView_Participants = $Farbe_Turquoise
			If $Wert_LA_4 = "8" Then $Farbe_State_ListView_Participants = $Farbe_Purple
			If $Wert_LA_4 = "9" Then $Farbe_State_ListView_Participants = $Farbe_LightBlue ; $Farbe_LightSteelBlue
			If $Wert_LA_4 = "10" Then $Farbe_State_ListView_Participants = $Farbe_Brown
		EndIf


		$Wert_LA_13 = ""
		$Check_PitStop = IniRead($PitStops_ini, $Wert_LA_1_bea, "PitStops","")
		If $Check_PitStop <> "" Then $Wert_LA_13 = $Check_PitStop

		$Wert_LA_14 = ""
		$Check_PenaltyPoints_PP = IniRead($Points_ini, $Wert_LA_1_bea, "PenaltyPoints","")
		$Wert_LA_14 = $Check_PenaltyPoints_PP

		$Wert_LA_15 = ""
		$Check_ExperiencePoints_PP = IniRead($Stats_INI, $Wert_LA_1_bea, "ExperiencePoints", "")
		$Wert_LA_15 = $Check_ExperiencePoints_PP

		$Wert_LA_16 = ""
		$Check_PersonalBest_PB = IniRead($Stats_INI, $Wert_LA_1_bea, $CuttentTack & "_" & $Wert_LA_3_Car, "")
		$Wert_LA_16 = $Check_PersonalBest_PB

		$Wert_LA_17 = ""
		$Check_TrackCuts = IniRead($CutTrack_INI, $Wert_LA_1_bea, "NR_TrackCut", "")
		$Wert_LA_17 = $Check_TrackCuts

		$Wert_LA_18 = ""
		$Check_Impacts = IniRead($Impact_INI, $Wert_LA_1_bea, "NR_Impact", "")
		$Wert_LA_18 = $Check_Impacts

		$Wert_LA_20 = ""
		$Check_Speed = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "Speed","")
		$Wert_LA_20 = $Check_Speed

		;_GUICtrlListView_BeginUpdate($ListView_1) ; Beginn Update
		$Add_ListView_Participants = GUICtrlCreateListViewItem($Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
																$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
																$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
																$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
																$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
																$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
																$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator, $ListView_1)

		GUICtrlSetColor($Add_ListView_Participants, $Farbe_State_ListView_Participants)
		;$Farbe_State_ListView_Participants = $Farbe_Standard

		_GUICtrlListView_SetColumnWidth($ListView_1, 0, 40) ; Position
		_GUICtrlListView_SetColumnWidth($ListView_1, 1, 115) ; Name
		_GUICtrlListView_SetColumnWidth($ListView_1, 2, 115) ; Car
		_GUICtrlListView_SetColumnWidth($ListView_1, 3, 70) ; Fastest Lap
		_GUICtrlListView_SetColumnWidth($ListView_1, 4, 70) ; Last Lap
		_GUICtrlListView_SetColumnWidth($ListView_1, 5, 70) ; PB
		_GUICtrlListView_SetColumnWidth($ListView_1, 6, 60) ; In Lap
		_GUICtrlListView_SetColumnWidth($ListView_1, 7, 60) ; In Sector
		_GUICtrlListView_SetColumnWidth($ListView_1, 8, 60) ; Sector 1
		_GUICtrlListView_SetColumnWidth($ListView_1, 9, 60) ; Sector 2
		_GUICtrlListView_SetColumnWidth($ListView_1, 10, 60) ; Sector 3
		_GUICtrlListView_SetColumnWidth($ListView_1, 11, 60) ; State
		_GUICtrlListView_SetColumnWidth($ListView_1, 12, 30) ; PS
		_GUICtrlListView_SetColumnWidth($ListView_1, 13, 50) ; EP
		_GUICtrlListView_SetColumnWidth($ListView_1, 14, 30) ; PP
		_GUICtrlListView_SetColumnWidth($ListView_1, 15, 30) ; Track Cuts
		_GUICtrlListView_SetColumnWidth($ListView_1, 16, 30) ; Impacts
		_GUICtrlListView_SetColumnWidth($ListView_1, 17, 45) ; Speed

		;_GUICtrlListView_EndUpdate($ListView_1) ; End Update

	EndIf

	If $Wert_LA_RefId = "" Then
		If $Show_max_10 = "true" Then $LOOP_ListView_1 = 10
		If $Show_max_10 <> "true" Then $LOOP_ListView_1 = 32
	EndIf

Next

_GUICtrlListView_EndUpdate($ListView_1) ; End Update

EndFunc

Func _ListView_Update_ListView_TrackMapReplay_Mode()

$TrackMapReplay_LOOP_NR = IniRead($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", "")
$NR_Participants = IniRead($TrackMap_participants_Data_INI, "TrackMapReplay", "NR_Participants","")
$Check_Checkbox_Position_Shadow = IniRead($config_ini, "TrackMap", "Checkbox_1", "")

$Show_max_10 = IniRead($config_ini, "TrackMap", "Checkbox_3", "")
$Show_colored_text = IniRead($config_ini, "TrackMap", "Checkbox_4", "")

$LOOP_To = 32

;$Show_max_10 = "false"

If $Show_max_10 = "true" Then $LOOP_To = 10
If $Show_max_10 <> "true" Then $LOOP_To = 32

;_GUICtrlListView_BeginUpdate($ListView_1) ; Beginn Update
;$CuttentTack = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
$CuttentTack = $TrackName_Replay
;_GUICtrlListView_DeleteAllItems($ListView_1)

$LOOP_ListView_NR = 1

$LOOP_TO_NR = 32

For $LOOP_ListView_1 = 0 To $NR_Participants ; $LOOP_To + 1

	$Add_ListView_Participants_1 = ""
	$Add_ListView_Participants_2 = ""
	$Add_ListView_Participants_3 = ""
	$Add_ListView_Participants_4 = ""
	$Add_ListView_Participants_5 = ""
	$Add_ListView_Participants_6 = ""
	$Add_ListView_Participants_7 = ""
	$Add_ListView_Participants_8 = ""
	$Add_ListView_Participants_9 = ""
	$Add_ListView_Participants_10 = ""

	$Wert_LAP_PitStop = ""

	$Wert_LA_RefId = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "RefId","") ; RefId
	$Wert_LA_RacePosition = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "RacePosition","")

	;MsgBox(0, "", $Wert_LA_RefId)

	;If $Wert_LA_RefId <> "" Then
		$Wert_LA_1 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "Name","") ; Name
		If $Wert_LA_1 = "" Then $Wert_LA_1 = IniRead($Members_Data_INI, $Wert_LA_RefId, "name","")

		$Wert_LA_1_bea = $Wert_LA_1

		If $Wert_LA_1 <> "" Then
			$Wert_LA_1_bea = StringReplace($Wert_LA_1, "[", "<")
			$Wert_LA_1_bea = StringReplace($Wert_LA_1_bea, "]", ">")
		EndIf

		If $Wert_LA_1_bea = "" Then $Wert_LA_1_bea = $Wert_LA_1
		$Wert_LA_1 = $Wert_LA_1_bea

		$Wert_LA_2 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "GridPosition","") ; GridPosition
		$Wert_LA_3 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "VehicleId","") ; VehicleId
		IniWrite($config_ini, "TEMP", "Check_Carid", $Wert_LA_3)
		$Wert_CAR_ID_Check = $Wert_LA_3
		;MsgBox(0, "", $Wert_LA_3)
		_Car_Name_from_ID()
		$Wert_LA_3 = IniRead($config_ini, "TEMP", "Check_CarName", $Wert_CAR_ID_Check) ; Car Name
		$Wert_LA_3_Car = $Wert_LA_3
		$Wert_LA_3_Len = StringLen($Wert_LA_3)
		$Wert_LA_3 = StringTrimRight($Wert_LA_3, $Wert_LA_3_Len - 21)
		If $Wert_LA_3 <> "" Then $Wert_LA_3 = $Wert_LA_3 & "..."
		$Wert_LA_4 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "RacePosition","") ; RacePosition
		$Wert_LA_5 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "CurrentLap","") ; CurrentLap
		$Wert_LA_6 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "CurrentSector","") ; CurrentSector
		$Wert_LA_7 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "Sector1Time","") ; Sector1Time
		$Wert_LA_8 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "Sector2Time","")  ; Sector2Time
		$Wert_LA_9 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "Sector3Time","")  ; Sector3Time
		$Wert_LA_10 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "LastLapTime","")  ; LastLapTime
		$Wert_LA_11 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "FastestLapTime","")   ; FastestLapTime
		$Wert_LA_12 = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_NR, $TrackMapReplay_LOOP_NR & "_" & "State","")  ; State



		If $Show_colored_text = "true" Then
			If $Wert_LA_4 = "1" Then $Farbe_State_ListView_Participants = $COLOR_RED
			If $Wert_LA_4 = "2" Then $Farbe_State_ListView_Participants = $COLOR_GREEN
			If $Wert_LA_4 = "3" Then $Farbe_State_ListView_Participants = $COLOR_BLUE
			If $Wert_LA_4 = "4" Then $Farbe_State_ListView_Participants = $Farbe_SandyBrown ; $Farbe_LightYellow - $Farbe_YellowGreen  - $Farbe_GreenYellow  - $Farbe_LightGoldenRodYellow  - $Farbe_Yellow
			If $Wert_LA_4 = "5" Then $Farbe_State_ListView_Participants = $Farbe_Gray ; $Farbe_DarkSlateGray $Farbe_DimGray $Farbe_SlateGray
			If $Wert_LA_4 = "6" Then $Farbe_State_ListView_Participants = $Farbe_DeepPink
			If $Wert_LA_4 = "7" Then $Farbe_State_ListView_Participants = $Farbe_Turquoise
			If $Wert_LA_4 = "8" Then $Farbe_State_ListView_Participants = $Farbe_Purple
			If $Wert_LA_4 = "9" Then $Farbe_State_ListView_Participants = $Farbe_LightBlue ; $Farbe_LightSteelBlue
			If $Wert_LA_4 = "10" Then $Farbe_State_ListView_Participants = $Farbe_Brown
		EndIf


		$Wert_LA_13 = ""
		$Check_PitStop = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, $TrackMapReplay_LOOP_NR & "_" & "PitStops","")
		If $Check_PitStop <> "" Then $Wert_LA_13 = $Check_PitStop

		$Wert_LA_14 = ""
		$Check_PenaltyPoints_PP = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, $TrackMapReplay_LOOP_NR & "_" & "PenaltyPoints","")
		$Wert_LA_14 = $Check_PenaltyPoints_PP

		$Wert_LA_15 = ""
		$Check_ExperiencePoints_PP = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, $TrackMapReplay_LOOP_NR & "_" & "ExperiencePoints", "")
		$Wert_LA_15 = $Check_ExperiencePoints_PP

		$Wert_LA_16 = ""
		$Check_PersonalBest_PB = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, $CuttentTack & "_" & $Wert_LA_3_Car, "")
		$Wert_LA_16 = $Check_PersonalBest_PB

		$Wert_LA_17 = ""
		$Check_TrackCuts = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, $TrackMapReplay_LOOP_NR & "_" & "TrackCuts", "")
		$Wert_LA_17 = $Check_TrackCuts

		$Wert_LA_18 = ""
		$Check_Impacts = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, $TrackMapReplay_LOOP_NR & "_" & "Impacts", "")
		$Wert_LA_18 = $Check_Impacts

		$Wert_LA_20 = ""
		$Check_Speed = IniRead($TrackMap_participants_Data_INI, $LOOP_ListView_1, "Speed","")
		$Wert_LA_20 = $Check_Speed



#Region Set ListView_Pos
		;MsgBox(0, "Race Position: " & $Wert_LA_4, $LOOP_ListView_NR & @CRLF & @CRLF & $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								;$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								;$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								;$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								;$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								;$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								;$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator)

		If $Wert_LA_4 = "1" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_1 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "2" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_2 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "3" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_3 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "4" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_4 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "5" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_5 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf


		If $Wert_LA_4 = "6" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_6 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "7" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_7 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "8" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_8 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "9" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_9 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "10" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_10 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "11" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_11 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "12" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_12 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "13" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_13 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "14" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_14 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "15" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_15 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "16" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_16 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "17" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_17 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "18" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_18 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "19" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_19 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "20" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_20 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
								$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
								$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
								$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
								$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
								$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
								$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf


		If $Wert_LA_4 = "21" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_21 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
									$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
									$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
									$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
									$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
									$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
									$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "22" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_22 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
									$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
									$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
									$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
									$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
									$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
									$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "23" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_23 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
									$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
									$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
									$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
									$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
									$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
									$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "24" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_24 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
									$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
									$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
									$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
									$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
									$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
									$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf


		If $Wert_LA_4 = "25" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_25 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
									$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
									$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
									$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
									$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
									$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
									$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf


		If $Wert_LA_4 = "26" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_26 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
									$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
									$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
									$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
									$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
									$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
									$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "27" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_27 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
									$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
									$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
									$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
									$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
									$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
									$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "28" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_28 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
									$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
									$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
									$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
									$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
									$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
									$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "29" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_29 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
									$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
									$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
									$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
									$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
									$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
									$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "30" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_30 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
									$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
									$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
									$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
									$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
									$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
									$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "31" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_31= $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
									$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
									$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
									$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
									$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
									$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
									$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf

		If $Wert_LA_4 = "32" Then
			$LOOP_TO_NR = $Wert_LA_4
			$ListView_Pos_32 = $Wert_LA_4 & $ListViewSeperator & $Wert_LA_1 & $ListViewSeperator & $Wert_LA_3 & _
									$ListViewSeperator & $Wert_LA_11 & $ListViewSeperator & $Wert_LA_10 & $ListViewSeperator & _
									$Wert_LA_16 & $ListViewSeperator & $Wert_LA_5 & $ListViewSeperator & $Wert_LA_6 & _
									$ListViewSeperator & $Wert_LA_7 & $ListViewSeperator & $Wert_LA_8 & $ListViewSeperator & _
									$Wert_LA_9 & $ListViewSeperator & $Wert_LA_12 & $ListViewSeperator & $Wert_LA_13 & _
									$ListViewSeperator & $Wert_LA_15 & $ListViewSeperator & $Wert_LA_14 & $ListViewSeperator & _
									$Wert_LA_17 & $ListViewSeperator & $Wert_LA_18 & $ListViewSeperator & $Wert_LA_20 & $ListViewSeperator
		EndIf
#EndRegion

		$LOOP_ListView_NR = $LOOP_ListView_NR + 1

	;EndIf

	If $Wert_LA_RefId = "" and $Wert_LA_RefId = "" Then
		;$LOOP_ListView_1 = 32
		;If $Show_max_10 = "true" Then $LOOP_ListView_1 = 10
		;If $Show_max_10 <> "true" Then $LOOP_ListView_1 = 32
	EndIf

Next

_GUICtrlListView_BeginUpdate($ListView_1) ; Beginn Update
_GUICtrlListView_DeleteAllItems($ListView_1)

For $LOOP_ListView_2 = 1 To 32 ; $LOOP_TO_NR ; $LOOP_To + 1
	;MsgBox(0, 1 & "To" & $LOOP_To + 1, $LOOP_ListView_2 & @CRLF & @CRLF & $ListView_Pos_1 & @CRLF & $ListView_Pos_2 & @CRLF & $ListView_Pos_3)
	If $LOOP_ListView_2 = "1" and $ListView_Pos_1 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_1, $ListView_1)
	If $LOOP_ListView_2 = "2" and $ListView_Pos_2 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_2, $ListView_1)
	If $LOOP_ListView_2 = "3" and $ListView_Pos_3 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_3, $ListView_1)
	If $LOOP_ListView_2 = "4" and $ListView_Pos_4 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_4, $ListView_1)
	If $LOOP_ListView_2 = "5" and $ListView_Pos_5 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_5, $ListView_1)
	If $LOOP_ListView_2 = "6" and $ListView_Pos_6 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_6, $ListView_1)
	If $LOOP_ListView_2 = "7" and $ListView_Pos_7 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_7, $ListView_1)
	If $LOOP_ListView_2 = "8" and $ListView_Pos_8 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_8, $ListView_1)
	If $LOOP_ListView_2 = "9" and $ListView_Pos_9 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_9, $ListView_1)
	If $LOOP_ListView_2 = "10" and $ListView_Pos_10 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_10, $ListView_1)
	If $LOOP_ListView_2 = "11" and $ListView_Pos_11 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_11, $ListView_1)
	If $LOOP_ListView_2 = "12" and $ListView_Pos_12 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_12, $ListView_1)
	If $LOOP_ListView_2 = "13" and $ListView_Pos_13 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_13, $ListView_1)
	If $LOOP_ListView_2 = "14" and $ListView_Pos_14 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_14, $ListView_1)
	If $LOOP_ListView_2 = "15" and $ListView_Pos_15 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_15, $ListView_1)
	If $LOOP_ListView_2 = "16" and $ListView_Pos_16 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_16, $ListView_1)
	If $LOOP_ListView_2 = "17" and $ListView_Pos_17 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_17, $ListView_1)
	If $LOOP_ListView_2 = "18" and $ListView_Pos_18 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_18, $ListView_1)
	If $LOOP_ListView_2 = "19" and $ListView_Pos_19 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_19, $ListView_1)
	If $LOOP_ListView_2 = "20" and $ListView_Pos_20 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_20, $ListView_1)
	If $LOOP_ListView_2 = "21" and $ListView_Pos_21 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_21, $ListView_1)
	If $LOOP_ListView_2 = "22" and $ListView_Pos_22 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_22, $ListView_1)
	If $LOOP_ListView_2 = "23" and $ListView_Pos_23 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_23, $ListView_1)
	If $LOOP_ListView_2 = "24" and $ListView_Pos_24 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_24, $ListView_1)
	If $LOOP_ListView_2 = "25" and $ListView_Pos_25 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_25, $ListView_1)
	If $LOOP_ListView_2 = "26" and $ListView_Pos_26 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_26, $ListView_1)
	If $LOOP_ListView_2 = "27" and $ListView_Pos_27 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_27, $ListView_1)
	If $LOOP_ListView_2 = "28" and $ListView_Pos_28 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_28, $ListView_1)
	If $LOOP_ListView_2 = "29" and $ListView_Pos_29 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_29, $ListView_1)
	If $LOOP_ListView_2 = "30" and $ListView_Pos_30 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_30, $ListView_1)
	If $LOOP_ListView_2 = "31" and $ListView_Pos_31 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_31, $ListView_1)
	If $LOOP_ListView_2 = "32" and $ListView_Pos_32 <> "" Then GUICtrlCreateListViewItem($ListView_Pos_32, $ListView_1)

	GUICtrlSetColor($Add_ListView_Participants_1, $COLOR_RED)
	GUICtrlSetColor($Add_ListView_Participants_2, $COLOR_GREEN)
	GUICtrlSetColor($Add_ListView_Participants_3, $COLOR_BLUE)
	GUICtrlSetColor($Add_ListView_Participants_4, $Farbe_SandyBrown)
	GUICtrlSetColor($Add_ListView_Participants_5, $Farbe_Gray)
	GUICtrlSetColor($Add_ListView_Participants_5, $Farbe_Gray)
	GUICtrlSetColor($Add_ListView_Participants_6, $Farbe_DeepPink)
	GUICtrlSetColor($Add_ListView_Participants_7, $Farbe_Turquoise)
	GUICtrlSetColor($Add_ListView_Participants_8, $Farbe_Purple)
	GUICtrlSetColor($Add_ListView_Participants_9, $Farbe_LightBlue)
	GUICtrlSetColor($Add_ListView_Participants_10, $Farbe_Brown)
Next



;$Farbe_State_ListView_Participants = $Farbe_Standard

_GUICtrlListView_SetColumnWidth($ListView_1, 0, 40) ; Position
_GUICtrlListView_SetColumnWidth($ListView_1, 1, 115) ; Name
_GUICtrlListView_SetColumnWidth($ListView_1, 2, 115) ; Car
_GUICtrlListView_SetColumnWidth($ListView_1, 3, 70) ; Fastest Lap
_GUICtrlListView_SetColumnWidth($ListView_1, 4, 70) ; Last Lap
_GUICtrlListView_SetColumnWidth($ListView_1, 5, 70) ; PB
_GUICtrlListView_SetColumnWidth($ListView_1, 6, 60) ; In Lap
_GUICtrlListView_SetColumnWidth($ListView_1, 7, 60) ; In Sector
_GUICtrlListView_SetColumnWidth($ListView_1, 8, 60) ; Sector 1
_GUICtrlListView_SetColumnWidth($ListView_1, 9, 60) ; Sector 2
_GUICtrlListView_SetColumnWidth($ListView_1, 10, 60) ; Sector 3
_GUICtrlListView_SetColumnWidth($ListView_1, 11, 60) ; State
_GUICtrlListView_SetColumnWidth($ListView_1, 12, 30) ; PS
_GUICtrlListView_SetColumnWidth($ListView_1, 13, 50) ; EP
_GUICtrlListView_SetColumnWidth($ListView_1, 14, 30) ; PP
_GUICtrlListView_SetColumnWidth($ListView_1, 15, 30) ; Track Cuts
_GUICtrlListView_SetColumnWidth($ListView_1, 16, 30) ; Impacts
_GUICtrlListView_SetColumnWidth($ListView_1, 17, 45) ; Speed

;_GUICtrlListView_EndUpdate($ListView_1) ; End Update

_GUICtrlListView_EndUpdate($ListView_1) ; End Update

EndFunc

Func _Scale()
$Tack_Name_Scale = $TrackName_Replay
$Check_Track_Scale_Exists = IniRead($TrackMap_INI, $Tack_Name_Scale, "Track", "")

Global $Tack_Size_Scale_Value = IniRead($TrackMap_INI, "TrackMap", "Scale", "")
Global $X_Plus = IniRead($TrackMap_INI, "TrackMap", "X", "")
Global $Y_Plus = IniRead($TrackMap_INI, "TrackMap", "Y", "")

If $Check_Track_Scale_Exists <> "" Then
$Tack_Size_Scale_Value = IniRead($TrackMap_INI, $Tack_Name_Scale, "Scale", "")
$X_Plus = IniRead($TrackMap_INI, $Tack_Name_Scale, "X", "")
$Y_Plus = IniRead($TrackMap_INI, $Tack_Name_Scale, "Y", "")
EndIf

$Tack_Size_Scale_Value_1 = $Tack_Size_Scale_Value

If $Tack_Size_Scale_Value_1 >= 10 Then
	$Tack_Size_Scale_Value = "0.00" & $Tack_Size_Scale_Value
EndIf

If $Tack_Size_Scale_Value_1 < 10 Then
$Tack_Size_Scale_Value = "0.000" & $Tack_Size_Scale_Value
EndIf

If $Tack_Size_Scale_Value_1 = "" Then
$Tack_Size_Scale_Value = "0.0007"
EndIf

If $Tack_Size_Scale_Value_1 = "0" Then
$Tack_Size_Scale_Value = "0.0007"
EndIf

EndFunc

Func _Update_TrackMap()

$Check_Checkbox_Position_Shadow = IniRead($config_ini, "TrackMap", "Checkbox_1", "")

$TrackDot = $gfx & "TrackMap\TrackDot.jpg"
$Player_1 = $gfx & "TrackMap\Player_1.jpg"
$Player_2 = $gfx & "TrackMap\Player_2.jpg"
$Player_3 = $gfx & "TrackMap\Player_3.jpg"
$Player_4 = $gfx & "TrackMap\Player_4.jpg"
$Player_5 = $gfx & "TrackMap\Player_5.jpg"
$Player_6 = $gfx & "TrackMap\Player_6.jpg"
$Player_7 = $gfx & "TrackMap\Player_7.jpg"
$Player_8 = $gfx & "TrackMap\Player_8.jpg"
$Player_9 = $gfx & "TrackMap\Player_9.jpg"
$Player_10 = $gfx & "TrackMap\Player_10.jpg"

$X_Value_Player_1 = IniRead($TrackMap_participants_Data_INI, "1", "PositionX", "")
$X_Value_Player_2 = IniRead($TrackMap_participants_Data_INI, "2", "PositionX", "")
$X_Value_Player_3 = IniRead($TrackMap_participants_Data_INI, "3", "PositionX", "")
$X_Value_Player_4 = IniRead($TrackMap_participants_Data_INI, "4", "PositionX", "")
$X_Value_Player_5 = IniRead($TrackMap_participants_Data_INI, "5", "PositionX", "")
$X_Value_Player_6 = IniRead($TrackMap_participants_Data_INI, "6", "PositionX", "")
$X_Value_Player_7 = IniRead($TrackMap_participants_Data_INI, "7", "PositionX", "")
$X_Value_Player_8 = IniRead($TrackMap_participants_Data_INI, "8", "PositionX", "")
$X_Value_Player_9 = IniRead($TrackMap_participants_Data_INI, "9", "PositionX", "")
$X_Value_Player_10 = IniRead($TrackMap_participants_Data_INI, "10", "PositionX", "")

$Y_Value_Player_1 = IniRead($TrackMap_participants_Data_INI, "1", "PositionY", "")
$Y_Value_Player_2 = IniRead($TrackMap_participants_Data_INI, "2", "PositionY", "")
$Y_Value_Player_3 = IniRead($TrackMap_participants_Data_INI, "3", "PositionY", "")
$Y_Value_Player_4 = IniRead($TrackMap_participants_Data_INI, "4", "PositionY", "")
$Y_Value_Player_5 = IniRead($TrackMap_participants_Data_INI, "5", "PositionY", "")
$Y_Value_Player_6 = IniRead($TrackMap_participants_Data_INI, "6", "PositionY", "")
$Y_Value_Player_7 = IniRead($TrackMap_participants_Data_INI, "7", "PositionY", "")
$Y_Value_Player_8 = IniRead($TrackMap_participants_Data_INI, "8", "PositionY", "")
$Y_Value_Player_9 = IniRead($TrackMap_participants_Data_INI, "9", "PositionY", "")
$Y_Value_Player_10 = IniRead($TrackMap_participants_Data_INI, "10", "PositionY", "")

$Z_Value_Player_1 = IniRead($TrackMap_participants_Data_INI, "1", "PositionZ", "")
$Z_Value_Player_2 = IniRead($TrackMap_participants_Data_INI, "2", "PositionZ", "")
$Z_Value_Player_3 = IniRead($TrackMap_participants_Data_INI, "3", "PositionZ", "")
$Z_Value_Player_4 = IniRead($TrackMap_participants_Data_INI, "4", "PositionZ", "")
$Z_Value_Player_5 = IniRead($TrackMap_participants_Data_INI, "5", "PositionZ", "")
$Z_Value_Player_6 = IniRead($TrackMap_participants_Data_INI, "6", "PositionZ", "")
$Z_Value_Player_7 = IniRead($TrackMap_participants_Data_INI, "7", "PositionZ", "")
$Z_Value_Player_8 = IniRead($TrackMap_participants_Data_INI, "8", "PositionZ", "")
$Z_Value_Player_9 = IniRead($TrackMap_participants_Data_INI, "9", "PositionZ", "")
$Z_Value_Player_10 = IniRead($TrackMap_participants_Data_INI, "10", "PositionZ", "")

$TrackMap_X_100prozent = $GUI_X_Value
$TrackMap_Y_100prozent = $GUI_Y_Value

$X_prozent_Value_Player_1 = Round(($X_Value_Player_1 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_2 = Round(($X_Value_Player_2 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_3 = Round(($X_Value_Player_3 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_4 = Round(($X_Value_Player_4 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_5 = Round(($X_Value_Player_5 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_6 = Round(($X_Value_Player_6 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_7 = Round(($X_Value_Player_7 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_8 = Round(($X_Value_Player_8 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_9 = Round(($X_Value_Player_9 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_10 = Round(($X_Value_Player_10 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))

$Y_prozent_Value_Player_1 = Round(($Y_Value_Player_1 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_2 = Round(($Y_Value_Player_2 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_3 = Round(($Y_Value_Player_3 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_4 = Round(($Y_Value_Player_4 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_5 = Round(($Y_Value_Player_5 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_6 = Round(($Y_Value_Player_6 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_7 = Round(($Y_Value_Player_7 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_8 = Round(($Y_Value_Player_8 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_9 = Round(($Y_Value_Player_9 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_10 = Round(($Y_Value_Player_10 * 0.01) / ($GUI_Y_Value / 100))

$Z_prozent_Value_Player_1 = Round(($Z_Value_Player_1 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_2 = Round(($Z_Value_Player_2 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_3 = Round(($Z_Value_Player_3 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_4 = Round(($Z_Value_Player_4 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_5 = Round(($Z_Value_Player_5 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_6 = Round(($Z_Value_Player_6 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_7 = Round(($Z_Value_Player_7 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_8 = Round(($Z_Value_Player_8 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_9 = Round(($Z_Value_Player_9 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_10 = Round(($Z_Value_Player_10 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))

$X_Position_Player_1 = $X_prozent_Value_Player_1 + $X_Plus
$X_Position_Player_2 = $X_prozent_Value_Player_2 + $X_Plus
$X_Position_Player_3 = $X_prozent_Value_Player_3 + $X_Plus
$X_Position_Player_4 = $X_prozent_Value_Player_4 + $X_Plus
$X_Position_Player_5 = $X_prozent_Value_Player_5 + $X_Plus
$X_Position_Player_6 = $X_prozent_Value_Player_6 + $X_Plus
$X_Position_Player_7 = $X_prozent_Value_Player_7 + $X_Plus
$X_Position_Player_8 = $X_prozent_Value_Player_8 + $X_Plus
$X_Position_Player_9 = $X_prozent_Value_Player_9 + $X_Plus
$X_Position_Player_10 = $X_prozent_Value_Player_10 + $X_Plus

$Z_Position_Player_1 = $Z_prozent_Value_Player_1 + $Y_Plus
$Z_Position_Player_2 = $Z_prozent_Value_Player_2 + $Y_Plus
$Z_Position_Player_3 = $Z_prozent_Value_Player_3 + $Y_Plus
$Z_Position_Player_4 = $Z_prozent_Value_Player_4 + $Y_Plus
$Z_Position_Player_5 = $Z_prozent_Value_Player_5 + $Y_Plus
$Z_Position_Player_6 = $Z_prozent_Value_Player_6 + $Y_Plus
$Z_Position_Player_7 = $Z_prozent_Value_Player_7 + $Y_Plus
$Z_Position_Player_8 = $Z_prozent_Value_Player_8 + $Y_Plus
$Z_Position_Player_9 = $Z_prozent_Value_Player_9 + $Y_Plus
$Z_Position_Player_10 = $Z_prozent_Value_Player_10 + $Y_Plus

If $X_prozent_Value_Player_1 = "" Or $X_prozent_Value_Player_1 = 0 Then $X_Position_Player_1 = 5
If $X_prozent_Value_Player_2 = "" Or $X_prozent_Value_Player_2 = 0 Then $X_Position_Player_2 = 25
If $X_prozent_Value_Player_3 = "" Or $X_prozent_Value_Player_3 = 0 Then $X_Position_Player_3 = 45
If $X_prozent_Value_Player_4 = "" Or $X_prozent_Value_Player_4 = 0 Then $X_Position_Player_4 = 65
If $X_prozent_Value_Player_5 = "" Or $X_prozent_Value_Player_5 = 0 Then $X_Position_Player_5 = 85
If $X_prozent_Value_Player_6 = "" Or $X_prozent_Value_Player_6 = 0 Then $X_Position_Player_6 = 105
If $X_prozent_Value_Player_7 = "" Or $X_prozent_Value_Player_7 = 0 Then $X_Position_Player_7 = 125
If $X_prozent_Value_Player_8 = "" Or $X_prozent_Value_Player_8 = 0 Then $X_Position_Player_8 = 145
If $X_prozent_Value_Player_9 = "" Or $X_prozent_Value_Player_9 = 0 Then $X_Position_Player_9 = 165
If $X_prozent_Value_Player_10 = "" Or $X_prozent_Value_Player_10 = 0 Then $X_Position_Player_10 = 185

If $Z_prozent_Value_Player_1 = "" Or $Z_prozent_Value_Player_1 = 0 Then $Z_Position_Player_1 = 190
If $Z_prozent_Value_Player_2 = "" Or $Z_prozent_Value_Player_2 = 0 Then $Z_Position_Player_2 = 190
If $Z_prozent_Value_Player_3 = "" Or $Z_prozent_Value_Player_3 = 0 Then $Z_Position_Player_3 = 190
If $Z_prozent_Value_Player_4 = "" Or $Z_prozent_Value_Player_4 = 0 Then $Z_Position_Player_4 = 190
If $Z_prozent_Value_Player_5 = "" Or $Z_prozent_Value_Player_5 = 0 Then $Z_Position_Player_5 = 190
If $Z_prozent_Value_Player_6 = "" Or $Z_prozent_Value_Player_6 = 0 Then $Z_Position_Player_6 = 190
If $Z_prozent_Value_Player_7 = "" Or $Z_prozent_Value_Player_7 = 0 Then $Z_Position_Player_7 = 190
If $Z_prozent_Value_Player_8 = "" Or $Z_prozent_Value_Player_8 = 0 Then $Z_Position_Player_8 = 190
If $Z_prozent_Value_Player_9 = "" Or $Z_prozent_Value_Player_9 = 0 Then $Z_Position_Player_9 = 190
If $Z_prozent_Value_Player_10 = "" Or $Z_prozent_Value_Player_10 = 0 Then $Z_Position_Player_10 = 190

GUICtrlSetPos($Pic_Player_1, $X_Position_Player_1 - 5, $Z_Position_Player_1 - 7, 10, 15)
GUICtrlSetPos($Pic_Player_2, $X_Position_Player_2 - 5, $Z_Position_Player_2 - 7, 10, 15)
GUICtrlSetPos($Pic_Player_3, $X_Position_Player_3 - 5, $Z_Position_Player_3 - 7, 10, 15)
GUICtrlSetPos($Pic_Player_4, $X_Position_Player_4 - 5, $Z_Position_Player_4 - 7, 10, 15)
GUICtrlSetPos($Pic_Player_5, $X_Position_Player_5 - 5, $Z_Position_Player_5 - 7, 10, 15)
GUICtrlSetPos($Pic_Player_6, $X_Position_Player_6 - 5, $Z_Position_Player_6 - 7, 10, 15)
GUICtrlSetPos($Pic_Player_7, $X_Position_Player_7 - 5, $Z_Position_Player_7 - 7, 10, 15)
GUICtrlSetPos($Pic_Player_8, $X_Position_Player_8 - 5, $Z_Position_Player_8 - 7, 10, 15)
GUICtrlSetPos($Pic_Player_9, $X_Position_Player_9 - 5, $Z_Position_Player_9 - 7, 10, 15)
GUICtrlSetPos($Pic_Player_10, $X_Position_Player_10 - 5, $Z_Position_Player_10 - 7, 10, 15)

If $Check_Checkbox_Position_Shadow = "true" Then
	GUICtrlCreatePic($TrackDot, $X_Position_Player_1 - 1, $Z_Position_Player_1 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_2 - 1, $Z_Position_Player_2 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_3 - 1, $Z_Position_Player_3 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_4 - 1, $Z_Position_Player_4 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_5 - 1, $Z_Position_Player_5 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_6 - 1, $Z_Position_Player_6 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_7 - 1, $Z_Position_Player_7 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_8 - 1, $Z_Position_Player_8 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_9 - 1, $Z_Position_Player_9 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_10 - 1, $Z_Position_Player_10 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlSetState($TrackDot, $GUI_ENABLE)
EndIf

GUICtrlSetState($Pic_Player_1, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_2, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_3, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_4, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_5, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_6, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_7, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_8, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_9, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_10, $GUI_ENABLE)

GUISetState()

EndFunc

Func _Update_TrackMapReplay_Mode()

$TrackMapReplay_LOOP_NR = IniRead($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", "")

$Check_Checkbox_Position_Shadow = IniRead($config_ini, "TrackMap", "Checkbox_1", "")

$TrackDot = $gfx & "TrackMap\TrackDot.jpg"
$Player_1 = $gfx & "TrackMap\Player_1.jpg"
$Player_2 = $gfx & "TrackMap\Player_2.jpg"
$Player_3 = $gfx & "TrackMap\Player_3.jpg"
$Player_4 = $gfx & "TrackMap\Player_4.jpg"
$Player_5 = $gfx & "TrackMap\Player_5.jpg"
$Player_6 = $gfx & "TrackMap\Player_6.jpg"
$Player_7 = $gfx & "TrackMap\Player_7.jpg"
$Player_8 = $gfx & "TrackMap\Player_8.jpg"
$Player_9 = $gfx & "TrackMap\Player_9.jpg"
$Player_10 = $gfx & "TrackMap\Player_10.jpg"
$Player_11 = $gfx & "TrackMap\Player_11.jpg"
$Player_12 = $gfx & "TrackMap\Player_12.jpg"
$Player_13 = $gfx & "TrackMap\Player_13.jpg"
$Player_14 = $gfx & "TrackMap\Player_14.jpg"
$Player_15 = $gfx & "TrackMap\Player_15.jpg"
$Player_16 = $gfx & "TrackMap\Player_16.jpg"
$Player_17 = $gfx & "TrackMap\Player_17.jpg"
$Player_18 = $gfx & "TrackMap\Player_18.jpg"
$Player_19 = $gfx & "TrackMap\Player_19.jpg"
$Player_20 = $gfx & "TrackMap\Player_20.jpg"
$Player_21 = $gfx & "TrackMap\Player_21.jpg"
$Player_22 = $gfx & "TrackMap\Player_22.jpg"
$Player_23 = $gfx & "TrackMap\Player_23.jpg"
$Player_24 = $gfx & "TrackMap\Player_24.jpg"
$Player_25 = $gfx & "TrackMap\Player_25.jpg"
$Player_26 = $gfx & "TrackMap\Player_26.jpg"
$Player_27 = $gfx & "TrackMap\Player_27.jpg"
$Player_28 = $gfx & "TrackMap\Player_28.jpg"
$Player_29 = $gfx & "TrackMap\Player_29.jpg"
$Player_30 = $gfx & "TrackMap\Player_30.jpg"
$Player_31 = $gfx & "TrackMap\Player_31.jpg"
$Player_32 = $gfx & "TrackMap\Player_32.jpg"
$Player_x = $gfx & "TrackMap\Player_x.jpg"

$X_Value_Player_1 = IniRead($TrackMap_participants_Data_INI, "1", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_2 = IniRead($TrackMap_participants_Data_INI, "2", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_3 = IniRead($TrackMap_participants_Data_INI, "3", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_4 = IniRead($TrackMap_participants_Data_INI, "4", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_5 = IniRead($TrackMap_participants_Data_INI, "5", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_6 = IniRead($TrackMap_participants_Data_INI, "6", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_7 = IniRead($TrackMap_participants_Data_INI, "7", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_8 = IniRead($TrackMap_participants_Data_INI, "8", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_9 = IniRead($TrackMap_participants_Data_INI, "9", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_10 = IniRead($TrackMap_participants_Data_INI, "10", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_11 = IniRead($TrackMap_participants_Data_INI, "11", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_12 = IniRead($TrackMap_participants_Data_INI, "12", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_13 = IniRead($TrackMap_participants_Data_INI, "13", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_14 = IniRead($TrackMap_participants_Data_INI, "14", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_15 = IniRead($TrackMap_participants_Data_INI, "15", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_16 = IniRead($TrackMap_participants_Data_INI, "16", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_17 = IniRead($TrackMap_participants_Data_INI, "17", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_18 = IniRead($TrackMap_participants_Data_INI, "18", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_19 = IniRead($TrackMap_participants_Data_INI, "19", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_20 = IniRead($TrackMap_participants_Data_INI, "20", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_21 = IniRead($TrackMap_participants_Data_INI, "21", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_22 = IniRead($TrackMap_participants_Data_INI, "22", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_23 = IniRead($TrackMap_participants_Data_INI, "23", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_24 = IniRead($TrackMap_participants_Data_INI, "24", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_25 = IniRead($TrackMap_participants_Data_INI, "25", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_26 = IniRead($TrackMap_participants_Data_INI, "26", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_27 = IniRead($TrackMap_participants_Data_INI, "27", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_28 = IniRead($TrackMap_participants_Data_INI, "28", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_29 = IniRead($TrackMap_participants_Data_INI, "29", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_30 = IniRead($TrackMap_participants_Data_INI, "30", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_31 = IniRead($TrackMap_participants_Data_INI, "31", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")
$X_Value_Player_32 = IniRead($TrackMap_participants_Data_INI, "32", $TrackMapReplay_LOOP_NR & "_" & "PositionX", "")

$Y_Value_Player_1 = IniRead($TrackMap_participants_Data_INI, "1", $TrackMapReplay_LOOP_NR & "_" & "PositionY", "")
$Y_Value_Player_2 = IniRead($TrackMap_participants_Data_INI, "2", $TrackMapReplay_LOOP_NR & "_" & "PositionY", "")
$Y_Value_Player_3 = IniRead($TrackMap_participants_Data_INI, "3", $TrackMapReplay_LOOP_NR & "_" & "PositionY", "")
$Y_Value_Player_4 = IniRead($TrackMap_participants_Data_INI, "4", $TrackMapReplay_LOOP_NR & "_" & "PositionY", "")
$Y_Value_Player_5 = IniRead($TrackMap_participants_Data_INI, "5", $TrackMapReplay_LOOP_NR & "_" & "PositionY", "")
$Y_Value_Player_6 = IniRead($TrackMap_participants_Data_INI, "6", $TrackMapReplay_LOOP_NR & "_" & "PositionY", "")
$Y_Value_Player_7 = IniRead($TrackMap_participants_Data_INI, "7", $TrackMapReplay_LOOP_NR & "_" & "PositionY", "")
$Y_Value_Player_8 = IniRead($TrackMap_participants_Data_INI, "8", $TrackMapReplay_LOOP_NR & "_" & "PositionY", "")
$Y_Value_Player_9 = IniRead($TrackMap_participants_Data_INI, "9", $TrackMapReplay_LOOP_NR & "_" & "PositionY", "")
$Y_Value_Player_10 = IniRead($TrackMap_participants_Data_INI, "10", $TrackMapReplay_LOOP_NR & "_" & "PositionY", "")

$Z_Value_Player_1 = IniRead($TrackMap_participants_Data_INI, "1", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_2 = IniRead($TrackMap_participants_Data_INI, "2", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_3 = IniRead($TrackMap_participants_Data_INI, "3", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_4 = IniRead($TrackMap_participants_Data_INI, "4", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_5 = IniRead($TrackMap_participants_Data_INI, "5", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_6 = IniRead($TrackMap_participants_Data_INI, "6", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_7 = IniRead($TrackMap_participants_Data_INI, "7", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_8 = IniRead($TrackMap_participants_Data_INI, "8", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_9 = IniRead($TrackMap_participants_Data_INI, "9", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_10 = IniRead($TrackMap_participants_Data_INI, "10", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_11 = IniRead($TrackMap_participants_Data_INI, "11", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_12 = IniRead($TrackMap_participants_Data_INI, "12", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_13 = IniRead($TrackMap_participants_Data_INI, "13", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_14 = IniRead($TrackMap_participants_Data_INI, "14", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_15 = IniRead($TrackMap_participants_Data_INI, "15", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_16 = IniRead($TrackMap_participants_Data_INI, "16", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_17 = IniRead($TrackMap_participants_Data_INI, "17", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_18 = IniRead($TrackMap_participants_Data_INI, "18", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_19 = IniRead($TrackMap_participants_Data_INI, "19", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_20 = IniRead($TrackMap_participants_Data_INI, "20", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_21 = IniRead($TrackMap_participants_Data_INI, "21", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_22 = IniRead($TrackMap_participants_Data_INI, "22", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_23 = IniRead($TrackMap_participants_Data_INI, "23", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_24 = IniRead($TrackMap_participants_Data_INI, "24", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_25 = IniRead($TrackMap_participants_Data_INI, "25", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_26 = IniRead($TrackMap_participants_Data_INI, "26", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_27 = IniRead($TrackMap_participants_Data_INI, "27", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_28 = IniRead($TrackMap_participants_Data_INI, "28", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_29 = IniRead($TrackMap_participants_Data_INI, "29", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_30 = IniRead($TrackMap_participants_Data_INI, "30", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_31 = IniRead($TrackMap_participants_Data_INI, "31", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")
$Z_Value_Player_32 = IniRead($TrackMap_participants_Data_INI, "32", $TrackMapReplay_LOOP_NR & "_" & "PositionZ", "")

$TrackMap_X_100prozent = $GUI_X_Value
$TrackMap_Y_100prozent = $GUI_Y_Value

$X_prozent_Value_Player_1 = Round(($X_Value_Player_1 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_2 = Round(($X_Value_Player_2 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_3 = Round(($X_Value_Player_3 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_4 = Round(($X_Value_Player_4 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_5 = Round(($X_Value_Player_5 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_6 = Round(($X_Value_Player_6 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_7 = Round(($X_Value_Player_7 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_8 = Round(($X_Value_Player_8 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_9 = Round(($X_Value_Player_9 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_10 = Round(($X_Value_Player_10 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_11 = Round(($X_Value_Player_11 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_12 = Round(($X_Value_Player_12 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_13 = Round(($X_Value_Player_13 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_14 = Round(($X_Value_Player_14 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_15 = Round(($X_Value_Player_15 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_16 = Round(($X_Value_Player_16 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_17 = Round(($X_Value_Player_17 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_18 = Round(($X_Value_Player_18 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_19 = Round(($X_Value_Player_19 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_20 = Round(($X_Value_Player_20 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_21 = Round(($X_Value_Player_21 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_22 = Round(($X_Value_Player_22 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_23 = Round(($X_Value_Player_23 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_24 = Round(($X_Value_Player_24 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_25 = Round(($X_Value_Player_25 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_26 = Round(($X_Value_Player_26 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_27 = Round(($X_Value_Player_27 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_28 = Round(($X_Value_Player_28 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_29 = Round(($X_Value_Player_29 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_30 = Round(($X_Value_Player_30 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_31 = Round(($X_Value_Player_31 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))
$X_prozent_Value_Player_32 = Round(($X_Value_Player_32 * $Tack_Size_Scale_Value) / ($GUI_X_Value / 100))

$Y_prozent_Value_Player_1 = Round(($Y_Value_Player_1 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_2 = Round(($Y_Value_Player_2 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_3 = Round(($Y_Value_Player_3 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_4 = Round(($Y_Value_Player_4 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_5 = Round(($Y_Value_Player_5 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_6 = Round(($Y_Value_Player_6 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_7 = Round(($Y_Value_Player_7 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_8 = Round(($Y_Value_Player_8 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_9 = Round(($Y_Value_Player_9 * 0.01) / ($GUI_Y_Value / 100))
$Y_prozent_Value_Player_10 = Round(($Y_Value_Player_10 * 0.01) / ($GUI_Y_Value / 100))

$Z_prozent_Value_Player_1 = Round(($Z_Value_Player_1 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_2 = Round(($Z_Value_Player_2 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_3 = Round(($Z_Value_Player_3 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_4 = Round(($Z_Value_Player_4 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_5 = Round(($Z_Value_Player_5 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_6 = Round(($Z_Value_Player_6 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_7 = Round(($Z_Value_Player_7 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_8 = Round(($Z_Value_Player_8 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_9 = Round(($Z_Value_Player_9 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_10 = Round(($Z_Value_Player_10 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_11 = Round(($Z_Value_Player_11 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_12 = Round(($Z_Value_Player_12 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_13 = Round(($Z_Value_Player_13 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_14 = Round(($Z_Value_Player_14 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_15 = Round(($Z_Value_Player_15 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_16 = Round(($Z_Value_Player_16 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_17 = Round(($Z_Value_Player_17 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_18 = Round(($Z_Value_Player_18 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_19 = Round(($Z_Value_Player_19 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_20 = Round(($Z_Value_Player_20 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_21 = Round(($Z_Value_Player_21 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_22 = Round(($Z_Value_Player_22 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_23 = Round(($Z_Value_Player_23 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_24 = Round(($Z_Value_Player_24 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_25 = Round(($Z_Value_Player_25 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_26 = Round(($Z_Value_Player_26 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_27 = Round(($Z_Value_Player_27 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_28 = Round(($Z_Value_Player_28 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_29 = Round(($Z_Value_Player_29 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_30 = Round(($Z_Value_Player_30 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_31 = Round(($Z_Value_Player_31 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))
$Z_prozent_Value_Player_32 = Round(($Z_Value_Player_32 * $Tack_Size_Scale_Value) / ($GUI_Y_Value / 100))

$X_Position_Player_1 = $X_prozent_Value_Player_1 + $X_Plus
$X_Position_Player_2 = $X_prozent_Value_Player_2 + $X_Plus
$X_Position_Player_3 = $X_prozent_Value_Player_3 + $X_Plus
$X_Position_Player_4 = $X_prozent_Value_Player_4 + $X_Plus
$X_Position_Player_5 = $X_prozent_Value_Player_5 + $X_Plus
$X_Position_Player_6 = $X_prozent_Value_Player_6 + $X_Plus
$X_Position_Player_7 = $X_prozent_Value_Player_7 + $X_Plus
$X_Position_Player_8 = $X_prozent_Value_Player_8 + $X_Plus
$X_Position_Player_9 = $X_prozent_Value_Player_9 + $X_Plus
$X_Position_Player_10 = $X_prozent_Value_Player_10 + $X_Plus
$X_Position_Player_11 = $X_prozent_Value_Player_11 + $X_Plus
$X_Position_Player_12 = $X_prozent_Value_Player_12 + $X_Plus
$X_Position_Player_13 = $X_prozent_Value_Player_13 + $X_Plus
$X_Position_Player_14 = $X_prozent_Value_Player_14 + $X_Plus
$X_Position_Player_15 = $X_prozent_Value_Player_15 + $X_Plus
$X_Position_Player_16 = $X_prozent_Value_Player_16 + $X_Plus
$X_Position_Player_17 = $X_prozent_Value_Player_17 + $X_Plus
$X_Position_Player_18 = $X_prozent_Value_Player_18 + $X_Plus
$X_Position_Player_19 = $X_prozent_Value_Player_19 + $X_Plus
$X_Position_Player_20 = $X_prozent_Value_Player_20 + $X_Plus
$X_Position_Player_21 = $X_prozent_Value_Player_21 + $X_Plus
$X_Position_Player_22 = $X_prozent_Value_Player_22 + $X_Plus
$X_Position_Player_23 = $X_prozent_Value_Player_23 + $X_Plus
$X_Position_Player_24 = $X_prozent_Value_Player_24 + $X_Plus
$X_Position_Player_25 = $X_prozent_Value_Player_25 + $X_Plus
$X_Position_Player_26 = $X_prozent_Value_Player_26 + $X_Plus
$X_Position_Player_27 = $X_prozent_Value_Player_27 + $X_Plus
$X_Position_Player_28 = $X_prozent_Value_Player_28 + $X_Plus
$X_Position_Player_29 = $X_prozent_Value_Player_29 + $X_Plus
$X_Position_Player_30 = $X_prozent_Value_Player_30 + $X_Plus
$X_Position_Player_31 = $X_prozent_Value_Player_31 + $X_Plus
$X_Position_Player_32 = $X_prozent_Value_Player_32 + $X_Plus

$Z_Position_Player_1 = $Z_prozent_Value_Player_1 + $Y_Plus
$Z_Position_Player_2 = $Z_prozent_Value_Player_2 + $Y_Plus
$Z_Position_Player_3 = $Z_prozent_Value_Player_3 + $Y_Plus
$Z_Position_Player_4 = $Z_prozent_Value_Player_4 + $Y_Plus
$Z_Position_Player_5 = $Z_prozent_Value_Player_5 + $Y_Plus
$Z_Position_Player_6 = $Z_prozent_Value_Player_6 + $Y_Plus
$Z_Position_Player_7 = $Z_prozent_Value_Player_7 + $Y_Plus
$Z_Position_Player_8 = $Z_prozent_Value_Player_8 + $Y_Plus
$Z_Position_Player_9 = $Z_prozent_Value_Player_9 + $Y_Plus
$Z_Position_Player_10 = $Z_prozent_Value_Player_10 + $Y_Plus
$Z_Position_Player_11 = $Z_prozent_Value_Player_11 + $Y_Plus
$Z_Position_Player_12 = $Z_prozent_Value_Player_12 + $Y_Plus
$Z_Position_Player_13 = $Z_prozent_Value_Player_13 + $Y_Plus
$Z_Position_Player_14 = $Z_prozent_Value_Player_14 + $Y_Plus
$Z_Position_Player_15 = $Z_prozent_Value_Player_15 + $Y_Plus
$Z_Position_Player_16 = $Z_prozent_Value_Player_16 + $Y_Plus
$Z_Position_Player_17 = $Z_prozent_Value_Player_17 + $Y_Plus
$Z_Position_Player_18 = $Z_prozent_Value_Player_18 + $Y_Plus
$Z_Position_Player_19 = $Z_prozent_Value_Player_19 + $Y_Plus
$Z_Position_Player_20 = $Z_prozent_Value_Player_20 + $Y_Plus
$Z_Position_Player_21 = $Z_prozent_Value_Player_21 + $Y_Plus
$Z_Position_Player_22 = $Z_prozent_Value_Player_22 + $Y_Plus
$Z_Position_Player_23 = $Z_prozent_Value_Player_23 + $Y_Plus
$Z_Position_Player_24 = $Z_prozent_Value_Player_24 + $Y_Plus
$Z_Position_Player_25 = $Z_prozent_Value_Player_25 + $Y_Plus
$Z_Position_Player_26 = $Z_prozent_Value_Player_26 + $Y_Plus
$Z_Position_Player_27 = $Z_prozent_Value_Player_27 + $Y_Plus
$Z_Position_Player_28 = $Z_prozent_Value_Player_28 + $Y_Plus
$Z_Position_Player_29 = $Z_prozent_Value_Player_29 + $Y_Plus
$Z_Position_Player_30 = $Z_prozent_Value_Player_30 + $Y_Plus
$Z_Position_Player_31 = $Z_prozent_Value_Player_31 + $Y_Plus
$Z_Position_Player_32 = $Z_prozent_Value_Player_32 + $Y_Plus

If $X_prozent_Value_Player_1 = "" Or $X_prozent_Value_Player_1 = 0 Then $X_Position_Player_1 = 5
If $X_prozent_Value_Player_2 = "" Or $X_prozent_Value_Player_2 = 0 Then $X_Position_Player_2 = 25
If $X_prozent_Value_Player_3 = "" Or $X_prozent_Value_Player_3 = 0 Then $X_Position_Player_3 = 45
If $X_prozent_Value_Player_4 = "" Or $X_prozent_Value_Player_4 = 0 Then $X_Position_Player_4 = 65
If $X_prozent_Value_Player_5 = "" Or $X_prozent_Value_Player_5 = 0 Then $X_Position_Player_5 = 85
If $X_prozent_Value_Player_6 = "" Or $X_prozent_Value_Player_6 = 0 Then $X_Position_Player_6 = 105
If $X_prozent_Value_Player_7 = "" Or $X_prozent_Value_Player_7 = 0 Then $X_Position_Player_7 = 125
If $X_prozent_Value_Player_8 = "" Or $X_prozent_Value_Player_8 = 0 Then $X_Position_Player_8 = 145
If $X_prozent_Value_Player_9 = "" Or $X_prozent_Value_Player_9 = 0 Then $X_Position_Player_9 = 165
If $X_prozent_Value_Player_10 = "" Or $X_prozent_Value_Player_10 = 0 Then $X_Position_Player_10 = 185
If $X_prozent_Value_Player_11 = "" Or $X_prozent_Value_Player_11 = 0 Then $X_Position_Player_11 = 25
If $X_prozent_Value_Player_12 = "" Or $X_prozent_Value_Player_12 = 0 Then $X_Position_Player_12 = 225
If $X_prozent_Value_Player_13 = "" Or $X_prozent_Value_Player_13 = 0 Then $X_Position_Player_13 = 245
If $X_prozent_Value_Player_14 = "" Or $X_prozent_Value_Player_14 = 0 Then $X_Position_Player_14 = 265
If $X_prozent_Value_Player_15 = "" Or $X_prozent_Value_Player_15 = 0 Then $X_Position_Player_15 = 285
If $X_prozent_Value_Player_16 = "" Or $X_prozent_Value_Player_16 = 0 Then $X_Position_Player_16 = 205
If $X_prozent_Value_Player_17 = "" Or $X_prozent_Value_Player_17 = 0 Then $X_Position_Player_17 = 225
If $X_prozent_Value_Player_18 = "" Or $X_prozent_Value_Player_18 = 0 Then $X_Position_Player_18 = 245
If $X_prozent_Value_Player_19 = "" Or $X_prozent_Value_Player_19 = 0 Then $X_Position_Player_19 = 265
If $X_prozent_Value_Player_20 = "" Or $X_prozent_Value_Player_20 = 0 Then $X_Position_Player_20 = 285
If $X_prozent_Value_Player_21 = "" Or $X_prozent_Value_Player_21 = 0 Then $X_Position_Player_21 = 305
If $X_prozent_Value_Player_22 = "" Or $X_prozent_Value_Player_22 = 0 Then $X_Position_Player_22 = 325
If $X_prozent_Value_Player_23 = "" Or $X_prozent_Value_Player_23 = 0 Then $X_Position_Player_23 = 345
If $X_prozent_Value_Player_24 = "" Or $X_prozent_Value_Player_24 = 0 Then $X_Position_Player_24 = 365
If $X_prozent_Value_Player_25 = "" Or $X_prozent_Value_Player_25 = 0 Then $X_Position_Player_25 = 385
If $X_prozent_Value_Player_26 = "" Or $X_prozent_Value_Player_26 = 0 Then $X_Position_Player_26 = 405
If $X_prozent_Value_Player_27 = "" Or $X_prozent_Value_Player_27 = 0 Then $X_Position_Player_27 = 425
If $X_prozent_Value_Player_28 = "" Or $X_prozent_Value_Player_28 = 0 Then $X_Position_Player_28 = 445
If $X_prozent_Value_Player_29 = "" Or $X_prozent_Value_Player_29 = 0 Then $X_Position_Player_29 = 465
If $X_prozent_Value_Player_30 = "" Or $X_prozent_Value_Player_30 = 0 Then $X_Position_Player_30 = 485
If $X_prozent_Value_Player_31 = "" Or $X_prozent_Value_Player_31 = 0 Then $X_Position_Player_31 = 465
If $X_prozent_Value_Player_32 = "" Or $X_prozent_Value_Player_32 = 0 Then $X_Position_Player_32 = 485

If $Z_prozent_Value_Player_1 = "" Or $Z_prozent_Value_Player_1 = 0 Then $Z_Position_Player_1 = 190
If $Z_prozent_Value_Player_2 = "" Or $Z_prozent_Value_Player_2 = 0 Then $Z_Position_Player_2 = 190
If $Z_prozent_Value_Player_3 = "" Or $Z_prozent_Value_Player_3 = 0 Then $Z_Position_Player_3 = 190
If $Z_prozent_Value_Player_4 = "" Or $Z_prozent_Value_Player_4 = 0 Then $Z_Position_Player_4 = 190
If $Z_prozent_Value_Player_5 = "" Or $Z_prozent_Value_Player_5 = 0 Then $Z_Position_Player_5 = 190
If $Z_prozent_Value_Player_6 = "" Or $Z_prozent_Value_Player_6 = 0 Then $Z_Position_Player_6 = 190
If $Z_prozent_Value_Player_7 = "" Or $Z_prozent_Value_Player_7 = 0 Then $Z_Position_Player_7 = 190
If $Z_prozent_Value_Player_8 = "" Or $Z_prozent_Value_Player_8 = 0 Then $Z_Position_Player_8 = 190
If $Z_prozent_Value_Player_9 = "" Or $Z_prozent_Value_Player_9 = 0 Then $Z_Position_Player_9 = 190
If $Z_prozent_Value_Player_10 = "" Or $Z_prozent_Value_Player_10 = 0 Then $Z_Position_Player_10 = 190
If $Z_prozent_Value_Player_11 = "" Or $Z_prozent_Value_Player_11 = 0 Then $Z_Position_Player_11 = 190
If $Z_prozent_Value_Player_12 = "" Or $Z_prozent_Value_Player_12 = 0 Then $Z_Position_Player_12 = 190
If $Z_prozent_Value_Player_13 = "" Or $Z_prozent_Value_Player_13 = 0 Then $Z_Position_Player_13 = 190
If $Z_prozent_Value_Player_14 = "" Or $Z_prozent_Value_Player_14 = 0 Then $Z_Position_Player_14 = 190
If $Z_prozent_Value_Player_15 = "" Or $Z_prozent_Value_Player_15 = 0 Then $Z_Position_Player_15 = 190
If $Z_prozent_Value_Player_16 = "" Or $Z_prozent_Value_Player_16 = 0 Then $Z_Position_Player_16 = 190
If $Z_prozent_Value_Player_17 = "" Or $Z_prozent_Value_Player_17 = 0 Then $Z_Position_Player_17 = 190
If $Z_prozent_Value_Player_18 = "" Or $Z_prozent_Value_Player_18 = 0 Then $Z_Position_Player_18 = 190
If $Z_prozent_Value_Player_19 = "" Or $Z_prozent_Value_Player_19 = 0 Then $Z_Position_Player_19 = 190
If $Z_prozent_Value_Player_20 = "" Or $Z_prozent_Value_Player_20 = 0 Then $Z_Position_Player_20 = 190
If $Z_prozent_Value_Player_21 = "" Or $Z_prozent_Value_Player_21 = 0 Then $Z_Position_Player_21 = 190
If $Z_prozent_Value_Player_22 = "" Or $Z_prozent_Value_Player_22 = 0 Then $Z_Position_Player_22 = 190
If $Z_prozent_Value_Player_23 = "" Or $Z_prozent_Value_Player_23 = 0 Then $Z_Position_Player_23 = 190
If $Z_prozent_Value_Player_24 = "" Or $Z_prozent_Value_Player_24 = 0 Then $Z_Position_Player_24 = 190
If $Z_prozent_Value_Player_25 = "" Or $Z_prozent_Value_Player_25 = 0 Then $Z_Position_Player_25 = 190
If $Z_prozent_Value_Player_26 = "" Or $Z_prozent_Value_Player_26 = 0 Then $Z_Position_Player_26 = 190
If $Z_prozent_Value_Player_27 = "" Or $Z_prozent_Value_Player_27 = 0 Then $Z_Position_Player_27 = 190
If $Z_prozent_Value_Player_28 = "" Or $Z_prozent_Value_Player_28 = 0 Then $Z_Position_Player_28 = 190
If $Z_prozent_Value_Player_29 = "" Or $Z_prozent_Value_Player_29 = 0 Then $Z_Position_Player_29 = 190
If $Z_prozent_Value_Player_30 = "" Or $Z_prozent_Value_Player_30 = 0 Then $Z_Position_Player_30 = 190
If $Z_prozent_Value_Player_31 = "" Or $Z_prozent_Value_Player_31 = 0 Then $Z_Position_Player_31 = 190
If $Z_prozent_Value_Player_32 = "" Or $Z_prozent_Value_Player_32 = 0 Then $Z_Position_Player_32 = 190

GUICtrlSetPos($Pic_Player_1, $X_Position_Player_1 - 7, $Z_Position_Player_1 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_2, $X_Position_Player_2 - 7, $Z_Position_Player_2 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_3, $X_Position_Player_3 - 7, $Z_Position_Player_3 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_4, $X_Position_Player_4 - 7, $Z_Position_Player_4 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_5, $X_Position_Player_5 - 7, $Z_Position_Player_5 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_6, $X_Position_Player_6 - 7, $Z_Position_Player_6 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_7, $X_Position_Player_7 - 7, $Z_Position_Player_7 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_8, $X_Position_Player_8 - 7, $Z_Position_Player_8 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_9, $X_Position_Player_9 - 7, $Z_Position_Player_9 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_10, $X_Position_Player_10 - 7, $Z_Position_Player_10 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_11, $X_Position_Player_11 - 7, $Z_Position_Player_11 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_12, $X_Position_Player_12 - 7, $Z_Position_Player_12 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_13, $X_Position_Player_13 - 7, $Z_Position_Player_13 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_14, $X_Position_Player_14 - 7, $Z_Position_Player_14 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_15, $X_Position_Player_15 - 7, $Z_Position_Player_15 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_16, $X_Position_Player_16 - 7, $Z_Position_Player_16 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_17, $X_Position_Player_17 - 7, $Z_Position_Player_17 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_18, $X_Position_Player_18 - 7, $Z_Position_Player_18 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_19, $X_Position_Player_19 - 7, $Z_Position_Player_19 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_20, $X_Position_Player_20 - 7, $Z_Position_Player_20 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_21, $X_Position_Player_21 - 7, $Z_Position_Player_21 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_22, $X_Position_Player_22 - 7, $Z_Position_Player_22 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_23, $X_Position_Player_23 - 7, $Z_Position_Player_23 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_24, $X_Position_Player_24 - 7, $Z_Position_Player_24 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_25, $X_Position_Player_25 - 7, $Z_Position_Player_25 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_26, $X_Position_Player_26 - 7, $Z_Position_Player_26 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_27, $X_Position_Player_27 - 7, $Z_Position_Player_27 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_28, $X_Position_Player_28 - 7, $Z_Position_Player_28 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_29, $X_Position_Player_29 - 7, $Z_Position_Player_29 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_30, $X_Position_Player_30 - 7, $Z_Position_Player_30 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_31, $X_Position_Player_31 - 7, $Z_Position_Player_30 - 7, 14, 14)
GUICtrlSetPos($Pic_Player_32, $X_Position_Player_32 - 7, $Z_Position_Player_31 - 7, 14, 14)

If $Check_Checkbox_Position_Shadow = "true" Then
	GUICtrlCreatePic($TrackDot, $X_Position_Player_1 - 1, $Z_Position_Player_1 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_2 - 1, $Z_Position_Player_2 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_3 - 1, $Z_Position_Player_3 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_4 - 1, $Z_Position_Player_4 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_5 - 1, $Z_Position_Player_5 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_6 - 1, $Z_Position_Player_6 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_7 - 1, $Z_Position_Player_7 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_8 - 1, $Z_Position_Player_8 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_9 - 1, $Z_Position_Player_9 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlCreatePic($TrackDot, $X_Position_Player_10 - 1, $Z_Position_Player_10 - 1, 3, 3, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
	GUICtrlSetState($TrackDot, $GUI_ENABLE)
EndIf

GUICtrlSetState($Pic_Player_1, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_2, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_3, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_4, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_5, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_6, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_7, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_8, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_9, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_10, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_11, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_12, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_13, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_14, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_15, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_16, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_17, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_18, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_19, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_20, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_21, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_22, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_23, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_24, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_25, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_26, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_27, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_28, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_29, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_30, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_31, $GUI_ENABLE)
GUICtrlSetState($Pic_Player_32, $GUI_ENABLE)

GUISetState()

EndFunc

Func _Set_Background()
$Tack_Name_BG = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
$Tack_Name_BG = $gfx & "TrackMap\Tracks\" & $Tack_Name_BG & ".jpg"
If Not FileExists($Tack_Name_BG) Then $Tack_Name_BG = $gfx & "TrackMap\Tracks\" & "Template" & ".jpg"

GUICtrlDelete($hPic_background)
Global $hPic_background = GUICtrlCreatePic($Tack_Name_BG, 0, 180, 1100, 500)
;GUICtrlSetState($hPic_background, $GUI_DISABLE)
GUISetState() ; Gui anzeigen
EndFunc

Func _Sync_TrackMap()

If FileExists($System_Dir & "ADD-ON1.exe") Then
	ShellExecute($System_Dir & "ADD-ON1.exe")
Else
	If FileExists($System_Dir & "ADD-ON1.au3") Then
		ShellExecute($System_Dir & "ADD-ON1.au3")
	EndIf
EndIf

Global $Stats_copy_2_folder = IniRead($config_ini, "Einstellungen", "PCDSG_Stats_path", "")

Global $TrackMap_JPG = $System_Dir & "TrackMap\TrackMap.jpg"

Global $TrackMap_JPG_copy_2 = $Stats_copy_2_folder & "PCDSG - Images\" & "TrackMap.jpg"
Global $TrackMap_2_JPG_copy_2 = "W:\PCDSGwiki\data\media\pictures\" & "trackmap.jpg"

FileCopy($TrackMap_JPG, $TrackMap_JPG_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)
FileCopy($TrackMap_JPG, $TrackMap_2_JPG_copy_2, $FC_OVERWRITE + $FC_CREATEPATH)

EndFunc



Func _UpDown_1()
$Input_UpDown_1_Read = GUICtrlRead($Input_UpDown_1)
IniWrite($TrackMap_INI, "TrackMap", "Scale", $Input_UpDown_1_Read)
EndFunc

Func _UpDown_2()
$Input_UpDown_2_Read = GUICtrlRead($Input_UpDown_2)
IniWrite($TrackMap_INI, "TrackMap", "X", $Input_UpDown_2_Read)
EndFunc

Func _UpDown_3()
$Input_UpDown_3_Read = GUICtrlRead($Input_UpDown_3)
IniWrite($TrackMap_INI, "TrackMap", "Y", $Input_UpDown_3_Read)
EndFunc

Func _Button_TrackMap_1() ; Save
$Tack_Name_TrackMap = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")

If $Tack_Name_TrackMap <> "" Then
	$Input_UpDown_1_Read = GUICtrlRead($Input_UpDown_1)
	$Input_UpDown_2_Read = GUICtrlRead($Input_UpDown_2)
	$Input_UpDown_3_Read = GUICtrlRead($Input_UpDown_3)

	IniWrite($TrackMap_INI, $Tack_Name_TrackMap, "Track", $Tack_Name_TrackMap)
	IniWrite($TrackMap_INI, $Tack_Name_TrackMap, "Scale", $Input_UpDown_1_Read)
	IniWrite($TrackMap_INI, $Tack_Name_TrackMap, "X", $Input_UpDown_2_Read)
	IniWrite($TrackMap_INI, $Tack_Name_TrackMap, "Y", $Input_UpDown_3_Read)
	IniWrite($TrackMap_INI, $Tack_Name_TrackMap, "JPG_1", $Tack_Name_TrackMap & ".jpg")
	IniWrite($TrackMap_INI, $Tack_Name_TrackMap, "JPG_2", "")

	MsgBox(0, "Saved", "Settings saved for: " & @CRLF & _
						"Track: " & $Tack_Name_TrackMap & @CRLF & _
						"Scale: " & $Input_UpDown_1_Read & @CRLF & _
						"X: " & $Input_UpDown_2_Read & @CRLF & _
						"Y: " & $Input_UpDown_3_Read & @CRLF)

	FileWriteLine($PCDSG_LOG_ini, "Saved_TrackMap_Scale" & $NowTime & "=" & "Track: " & $Tack_Name_TrackMap & " | " & "Scale: " & $Input_UpDown_1_Read & " | " & "X: " & $Input_UpDown_2_Read & " | " & "Y: " & $Input_UpDown_3_Read)

Else
	MsgBox(0, "Track", "Track not found...")
EndIf

EndFunc

Func _Button_TrackMap_2() ; Delete
$Tack_Name_TrackMap = IniRead($config_ini, "Server_Einstellungen", "CurrentTrackName", "")
$Check_Scale = IniRead($TrackMap_INI, $Tack_Name_TrackMap, "Scale", "")
$Check_X = IniRead($TrackMap_INI, $Tack_Name_TrackMap, "X", "")
$Check_Y = IniRead($TrackMap_INI, $Tack_Name_TrackMap, "Y", "")

$Abfrage = MsgBox(4, "Delete Scale settings", "Do you realy want to delet the Scale settings for this Track?" & @CRLF & @CRLF & _
												"Settings for: " & $Tack_Name_TrackMap & @CRLF & _
												"Track: " & $Tack_Name_TrackMap & @CRLF & _
												"Scale: " & $Check_Scale & @CRLF & _
												"X: " & $Check_X & @CRLF & _
												"Y: " & $Check_Y & @CRLF)

If $Abfrage = 6 Then ;Ja - Auswahl = JA
	If $Tack_Name_TrackMap <> "" Then
		IniWrite($TrackMap_INI, $Tack_Name_TrackMap, "Track", "")
		IniWrite($TrackMap_INI, $Tack_Name_TrackMap, "Scale", "")
		IniWrite($TrackMap_INI, $Tack_Name_TrackMap, "X", "")
		IniWrite($TrackMap_INI, $Tack_Name_TrackMap, "Y", "")
		IniWrite($TrackMap_INI, $Tack_Name_TrackMap, "JPG_1", "")
		IniWrite($TrackMap_INI, $Tack_Name_TrackMap, "JPG_2", "")

		MsgBox(0, "Deleted", "Settings deleted for: " & @CRLF & _
							"Track: " & "" & @CRLF & _
							"Scale: " & "" & @CRLF & _
							"X: " & "" & @CRLF & _
							"Y: " & "" & @CRLF)

		FileWriteLine($PCDSG_LOG_ini, "Deleted_TrackMap_Scale" & $NowTime & "=" & "Track: " & $Tack_Name_TrackMap & " | " & "Scale: " & $Check_Scale & " | " & "X: " & $Check_X & " | " & "Y: " & $Check_Y)

	Else
		MsgBox(0, "Track", "Track not found...")
	EndIf
EndIf


If $Abfrage = 7 Then ;Nein - Auswahl = Nein

EndIf

EndFunc


Func _Button_TrackMap_3() ; Open TrackMapReplay File

Global $Radio_Mode_1 = IniRead($config_ini, "TrackMap", "Radio_Mode_1", "")
Global $Radio_Mode_2 = IniRead($config_ini, "TrackMap", "Radio_Mode_2", "")

If $Radio_Mode_2 = "true" Then

	Local $FileOpenDialog = FileOpenDialog("Choose TrackMapReplay File '.ini'", $Results_folder, "TrackMapReplays (*.ini)", $FD_FILEMUSTEXIST + $FD_MULTISELECT)
		If @error Then MsgBox($MB_SYSTEMMODAL, "", "No file were selected.")

	;Global $TrackMap_participants_Data_INI = $FileOpenDialog

	IniWrite($config_ini, "TrackMap", "Replay_File", $FileOpenDialog)
	;MsgBox(0, "", $FileOpenDialog)

Else

	MsgBox(0, "TrackMap Mode", "TrackMap Mode needs to be changed to 'TrackMap Replay [Offline]' Mode first.")

EndIf

EndFunc

Func _Button_TrackMap_4() ; Play TrackMapReplay

Global $Radio_Mode_1 = IniRead($config_ini, "TrackMap", "Radio_Mode_1", "")
Global $Radio_Mode_2 = IniRead($config_ini, "TrackMap", "Radio_Mode_2", "")

If $Radio_Mode_2 = "true" Then
	IniWrite($config_ini, "TEMP", "Status_TrackMapReplay", "Replay startet")
	_TrackMapReplay_Mode()
Else
	MsgBox(0, "TrackMap Mode", "TrackMap Mode needs to be changed to 'TrackMap Replay [Offline]' Mode first.")
EndIf
EndFunc

Func _Button_TrackMap_5() ; Open Recording Menu

If FileExists($System_Dir & "TrackMapReplay.exe") Then
    ShellExecute($System_Dir & "TrackMapReplay.exe")
Else
	If FileExists($System_Dir & "TrackMapReplay.au3") Then
		ShellExecute($System_Dir & "TrackMapReplay.au3")
	EndIf
EndIf

EndFunc

Func _Button_TrackMap_6() ; Stop Recording
	$End_Time = @HOUR & ":" & @MIN
	$LOG_Index_End = IniRead($LOG_Data_INI, "DATA", "NR", "")

	IniWrite($config_ini, "TEMP", "TMR_Record_End_Time", $End_Time)
	IniWrite($config_ini, "TEMP", "Status_TrackMapReplay", "Recording stopped")

	IniWrite($TrackMapReplay_INI, "TrackMapReplay", "LOG_Index_End", $LOG_Index_End)

EndFunc


Func _CheckBox_1()
$Data_Checkbox = GUICtrlRead($Checkbox_1)
If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
IniWrite($config_ini, "TrackMap", "Checkbox_1", $Data_Checkbox)
EndFunc

Func _CheckBox_2()
$Data_Checkbox = GUICtrlRead($Checkbox_2)
If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
If $Data_Checkbox = "4" Then
	$Data_Checkbox = "false"
	GUICtrlDelete($hPic_background)
EndIf
IniWrite($config_ini, "TrackMap", "Checkbox_2", $Data_Checkbox)
EndFunc

Func _CheckBox_3()
$Data_Checkbox = GUICtrlRead($Checkbox_3)
If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
IniWrite($config_ini, "TrackMap", "Checkbox_3", $Data_Checkbox)
EndFunc

Func _CheckBox_4()
$Data_Checkbox = GUICtrlRead($Checkbox_4)
If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
IniWrite($config_ini, "TrackMap", "Checkbox_4", $Data_Checkbox)
EndFunc

Func _CheckBox_5()
$Data_Checkbox = GUICtrlRead($Checkbox_5)
If $Data_Checkbox = "1" Then $Data_Checkbox = "true"
If $Data_Checkbox = "4" Then $Data_Checkbox = "false"
IniWrite($config_ini, "TrackMap", "Checkbox_5", $Data_Checkbox)
EndFunc



Func _Radio_TrackMapReplay_1()
IniWrite($config_ini, "TrackMap", "Radio_Mode_1", "true")
IniWrite($config_ini, "TrackMap", "Radio_Mode_2", "false")

If FileExists($System_Dir & "TrackMap.exe") Then
    ShellExecute($System_Dir & "TrackMap.exe")
Else
	If FileExists($System_Dir & "TrackMap.au3") Then
		ShellExecute($System_Dir & "TrackMap.au3")
	EndIf
EndIf

Sleep(500)

Exit

EndFunc

Func _Radio_TrackMapReplay_2()
IniWrite($config_ini, "TrackMap", "Radio_Mode_1", "false")
IniWrite($config_ini, "TrackMap", "Radio_Mode_2", "true")

If FileExists($System_Dir & "TrackMap.exe") Then
    ShellExecute($System_Dir & "TrackMap.exe")
Else
	If FileExists($System_Dir & "TrackMap.au3") Then
		ShellExecute($System_Dir & "TrackMap.au3")
	EndIf
EndIf

Sleep(500)

Exit

EndFunc


Func _TRACK_NAME_from_ID()

IniWrite($config_ini, "TEMP", "Check_TrackName", "")

$Wert_Track_ID_search = IniRead($Server_Data_INI, "DATA", "TrackId", "")

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
	IniWrite($config_ini, "Server_Einstellungen", "CurrentTrackName", $Wert_Track)
	GUICtrlSetState ($Label_Wert_Track, $Wert_Track)
	FileWriteLine($PCDSG_LOG_ini, "Track_detection_" & $NowTime & "=" & "Track: " & $Wert_Track & " | " & "TrackID: " & $Wert_Track_ID)
	$Schleife_TRACK_ID_DropDown = $Anzahl_Zeilen_TrackList

EndIf

Next

EndFunc

Func _Car_Name_from_ID()

$Wert_CAR_ID_Check = IniRead($config_ini, "TEMP", "Check_Carid", "")
;MsgBox(0, "", $Wert_CAR_ID_Check)

$Anzahl_Zeilen_VehicleList = _FileCountLines(@ScriptDir & "\VehicleList.txt")

$Wert_Car = ""
$Werte_Car = ""
$Wert_Car_ID = ""
$Check_Line = ""

For $Schleife_CAR_DropDown = 7 To $Anzahl_Zeilen_VehicleList Step 5

$Wert_Car_ID = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown)
$Wert_Car_ID = StringReplace($Wert_Car_ID, '      "id" : ', '')
$Wert_Car_ID = StringReplace($Wert_Car_ID, ',', '')

;MsgBox(0, "", $Wert_CAR_ID_Check & " : " & $Wert_Car_ID)

If $Wert_CAR_ID_Check = $Wert_Car_ID Then
	$Wert_Car = FileReadLine(@ScriptDir & "\VehicleList.txt", $Schleife_CAR_DropDown + 1)
	$Wert_Car = StringReplace($Wert_Car, '      "name" : "', '')
	$Wert_Car = StringReplace($Wert_Car, '",', '')
	IniWrite($config_ini, "TEMP", "Check_CarName", $Wert_Car)
	$Schleife_CAR_DropDown = $Anzahl_Zeilen_VehicleList
EndIf

Next

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

Func _Beenden() ; Beenden / Exit
IniWrite($config_ini, "TrackMap", "Replay_File", "")
IniWrite($config_ini, "TEMP", "TrackMapReplay_LOOP_NR", "")
Exit
EndFunc

#endregion Funktionen
