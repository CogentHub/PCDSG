

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiButton.au3>
#include <StaticConstants.au3>
#include <GuiListView.au3>
#include <EventLog.au3>
#include <File.au3>
#include <GuiStatusBar.au3>

Opt("GUIOnEventMode", 1)

Global $config_ini = @ScriptDir & "\config.ini"
Global $install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
Global $System_Dir = $install_dir & "system\"
Global $Data_Dir = $install_dir & "data\"
Global $Server_Data_INI = $System_Dir & "Server_Data.ini"
Global $UserHistory_ini = @ScriptDir & "\" & "UserHistory.ini"

$Sprachdatei = IniRead($config_ini,"Einstellungen", "Sprachdatei", "")

$Whitelist_File = $install_dir & "whitelist.cfg"
$Blacklist_File = $install_dir & "blacklist.cfg"

$gfx = (@ScriptDir & "\" & "gfx\")

$status_json = @ScriptDir & "\status.json"

$Server_Name = IniRead($Server_Data_INI, "DATA", "name", "")
$Server_Status = IniRead($config_ini, "PC_Server", "Status", "")
If $Server_Status = "" Then $Server_Status = "OFFLINE"
If $Server_Status = "PC_Server_beendet" Then $Server_Status = "OFFLINE"

#Region Declare Variables/Const
$timestamp = _NowDate() & " - " & _NowTime()
#endregion Declare Variables/Const

#region GUI Erstellen
Local $hGUI, $hGraphic, $hPen
Local $GUI, $aSize, $aStrings[5]
Local $btn, $chk, $rdo, $Msg
Local $GUI_List_Auswahl, $tu_Button0, $to_button1, $to_button2, $to_button3, $to_button4
Local $Wow64 = ""
If @AutoItX64 Then $Wow64 = "\Wow6432Node"
Local $sPath = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $Wow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\Examples\GUI\Advanced\Images"

$GUI = GUICreate("PCars DS User History", 580, 490, -1, 5)
$Anzeige_Fortschrittbalken = GUICtrlCreateProgress(0, 520, 644, 5)
$Statusbar = _GUICtrlStatusBar_Create($GUI)
_GUICtrlStatusBar_SetSimple($Statusbar, True)

GUISetState()

$Linie_oben = GUICtrlCreatePic($gfx & "Hintergrund.jpg", 0, 53, 1080, 2, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))

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

$font = "Comic Sans MS"
$font_2 = "Arial"

Global $Button1 = GUICtrlCreateButton("Daten aktualisieren", 5, 428, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($Button1, $gfx & "Aktualisieren_Daten.bmp")
GuiCtrlSetTip(-1, $Info_Drivers_AT_Button_1)

Global $Button2 = GUICtrlCreateButton("ADD to Whitelist", 55, 428, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($Button2, $gfx & "ADD_2_Whitelist.bmp")
GuiCtrlSetTip(-1, $Info_Drivers_AT_Button_2)

Global $Button3 = GUICtrlCreateButton("ADD to Blacklist", 95, 428, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($Button3, $gfx & "ADD_2_Blacklist.bmp")
GuiCtrlSetTip(-1, $Info_Drivers_AT_Button_3)

Global $Button9 = GUICtrlCreateButton("Delete", 540, 428, 35, 35, $BS_BITMAP)
_GUICtrlButton_SetImage($Button9, $gfx & "Delete.bmp")
GuiCtrlSetTip(-1, $Info_Drivers_AT_Button_9)


Local $listview_drivers_AT = GUICtrlCreateListView("", 0, 55, 572, 370, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))

_GUICtrlListView_SetExtendedListViewStyle($listview_drivers_AT, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_DOUBLEBUFFER))
_GUICtrlStatusBar_SetSimple($Statusbar, True)
GUISetState()

; Add columns
_GUICtrlListView_AddColumn($listview_drivers_AT, "Name", 250)
_GUICtrlListView_AddColumn($listview_drivers_AT, "Steam ID", 140)
_GUICtrlListView_AddColumn($listview_drivers_AT, "Join Time", 120)
_GUICtrlListView_AddColumn($listview_drivers_AT, "Ping", 40)

GUICtrlCreateLabel($Infos_view_drivers_AT_Label_1, 5, 0, 70, 23)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($UserHistory_ini, "DATA", "NR", "")
$Label_Wert_driver_entries = GUICtrlCreateLabel($Wert, 80, 5, 130, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel($Infos_view_drivers_AT_Label_2, 335, 0, 90, 23)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Wert = IniRead($UserHistory_ini, "1", "Added", "")
$Label_Wert_driver_first_entries = GUICtrlCreateLabel($Wert, 430, 5, 150, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

GUICtrlCreateLabel($Infos_view_drivers_AT_Label_3, 335, 25, 90, 23)
GUICtrlSetFont(-1, 12, 400, 4, $font)
$Zeile_last_entrie = IniRead($UserHistory_ini, "DATA", "NR", "")
$Wert = IniRead($UserHistory_ini, $Zeile_last_entrie, "Added", "")
$Label_Wert_driver_last_entries = GUICtrlCreateLabel($Wert, 430, 30, 150, 23)
GUICtrlSetFont(-1, 11, 400, 1, $font_2)

$Anzahl_Werte = IniRead($UserHistory_ini, "DATA", "NR", "")

For $AW = 1 To $Anzahl_Werte Step 1
	$Ebene_temp = $AW - 1

	$Wert_Wert = IniRead($UserHistory_ini, $AW, "Name","")
	_GUICtrlListView_AddItem($listview_drivers_AT, $Wert_Wert, "")

	$Wert_Wert = IniRead($UserHistory_ini, $AW, "Steamid", "")
	_GUICtrlListView_AddSubItem($listview_drivers_AT, $Ebene_temp, $Wert_Wert, 1)

	$Wert_Wert = IniRead($UserHistory_ini, $AW, "Added", "")
	_GUICtrlListView_AddSubItem($listview_drivers_AT, $Ebene_temp, $Wert_Wert, 2)

	$Wert_Wert = IniRead($UserHistory_ini, $AW, "Ping", "")
	_GUICtrlListView_AddSubItem($listview_drivers_AT, $Ebene_temp, $Wert_Wert, 3)
Next

GUISetState(@SW_SHOW)

GUISetOnEvent($GUI_EVENT_CLOSE, "_Beenden")

GUICtrlSetOnEvent($Button1, "_Alles_aktualisieren")
GUICtrlSetOnEvent($Button2, "_Button2")
GUICtrlSetOnEvent($Button3, "_Button3")
GUICtrlSetOnEvent($Button9, "_Button9")

_GUICtrlStatusBar_SetText($Statusbar, $Server_Name & @TAB & $Server_Status & @TAB & "" & $timestamp)
#endregion Funktionen Verküpfen

While 1
   Sleep(1000)
 WEnd

#Region Start Funktionen

Func _ListView_aktualisieren()
	$Anzahl_Werte = IniRead($UserHistory_ini, "DATA", "NR", "")

	If FileExists($UserHistory_ini) Then
		_GUICtrlListView_DeleteAllItems($listview_drivers_AT)

		For $Schleife_ListView_aktualisieren = 0 To $Anzahl_Werte

			$UserHistory_Name = IniRead($UserHistory_ini, $Schleife_ListView_aktualisieren, "Name","")
			$UserHistory_Steamid = IniRead($UserHistory_ini, $Schleife_ListView_aktualisieren, "Steamid", "")
			$UserHistory_Added = IniRead($UserHistory_ini, $Schleife_ListView_aktualisieren, "Added", "")
			$UserHistory_Ping = IniRead($UserHistory_ini, $Schleife_ListView_aktualisieren, "Ping", "")

			GUICtrlCreateListViewItem($UserHistory_Name & "|" & $UserHistory_Steamid & "|" & $UserHistory_Added & "|" & $UserHistory_Ping, $listview_drivers_AT)
		Next
	EndIf
EndFunc

Func _Alles_aktualisieren()
	_ListView_aktualisieren()
EndFunc

Func _Update_exit()
	$Intervall = IniRead($config_ini, "PC_Server", "Infos_pb_Update_Intervall", "")
	$Status_exit = IniRead($config_ini, "PC_Server", "Infos_pb_Update_Intervall_exit", "")

	IniWrite($config_ini, "PC_Server", "Infos_pb_Update_Intervall_exit", "exit")
EndFunc

Func _Update_Page()
	$Intervall = IniRead($config_ini, "PC_Server", "Infos_pb_Update_Intervall", "")
	$Status_exit = IniRead($config_ini, "PC_Server", "Infos_pb_Update_Intervall_exit", "")

	For $Schleife = 1 To 1000
		$Status_exit = IniRead($config_ini, "PC_Server", "Infos_pb_Update_Intervall_exit", "")
		If $Status_exit = "exit" Then Exit

		Sleep($Intervall)

		_Alles_aktualisieren()

		Sleep(1000)

		If $Status_exit = "exit" Then Exit
	Next
EndFunc

Func _Button2()
	$Auswahl_ListView = _GUICtrlListView_GetSelectedIndices($listview_drivers_AT)
	$Auswahl_ListView = $Auswahl_ListView + 1
	$Auswahl_ListView_name = IniRead($UserHistory_ini, $Auswahl_ListView, "Name", "")
	$Auswahl_ListView_steamID = IniRead($UserHistory_ini, $Auswahl_ListView, "Steamid", "")
	$Auswahl_ListView_jointime = IniRead($UserHistory_ini, $Auswahl_ListView, "Added", "")

	$Input_whitelist_1 = $Auswahl_ListView_steamID
	$Input_whitelist_2 = $Auswahl_ListView_name
	$Input_whitelist_3 = $Auswahl_ListView_jointime

	$NEW_MSG_Input_whitelist = "Driver Name: " & @TAB & $Input_whitelist_2 & @CRLF & "Driver SteamID: " & @TAB & $Input_whitelist_1 & @CRLF & "Added at: " & @TAB & @TAB & $Input_whitelist_3 & @CRLF & "Comments: " & @TAB

	$Abfrage = MsgBox(4, "Dedicated Server", $msgbox_16 & @CRLF & @CRLF & $NEW_MSG_Input_whitelist & @CRLF & @CRLF & $msgbox_17 & @CRLF)

	If $Abfrage = 6 Then ;Ja - Auswahl = JA
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

Func _Button3()
	$Auswahl_ListView = _GUICtrlListView_GetSelectedIndices($listview_drivers_AT)
	$Auswahl_ListView = $Auswahl_ListView + 1
	$Auswahl_ListView_name = IniRead($UserHistory_ini, $Auswahl_ListView, "Name", "")
	$Auswahl_ListView_steamID = IniRead($UserHistory_ini, $Auswahl_ListView, "Steamid", "")
	$Auswahl_ListView_jointime = IniRead($UserHistory_ini, $Auswahl_ListView, "Added", "")

	$Input_blacklist_1 = $Auswahl_ListView_steamID
	$Input_blacklist_2 = $Auswahl_ListView_name
	$Input_blacklist_3 = $Auswahl_ListView_jointime

	$NEW_MSG_Input_blacklist = "Driver Name: " & @TAB & $Input_blacklist_2 & @CRLF & "Driver SteamID: " & @TAB & $Input_blacklist_1 & @CRLF & "Added at: " & @TAB & @TAB & $Input_blacklist_3 & @CRLF & "Comments: " & @TAB

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
	EndIf
EndFunc

Func _Button9()
	$Abfrage = MsgBox(4, $msgbox_24, $msgbox_25 & @CRLF)

	If $Abfrage = 6 Then
		FileDelete($UserHistory_ini)
		FileWriteLine($UserHistory_ini, '[DATA]')
		FileWriteLine($UserHistory_ini, 'NR=')
	EndIf
EndFunc


Func _Beenden()
	Exit
EndFunc

#endregion Start Funktionen
