#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

#include <GuiToolbar.au3>
#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>
#include <GuiButton.au3>
#include <StaticConstants.au3>
#include <WinAPI.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <GuiTab.au3>
#include <EventLog.au3>
#include <GuiEdit.au3>
#include <buttonconstants.au3>
#include <ProgressConstants.au3>
#include <SendMessage.au3>
#include <File.au3>
#include <GuiMenu.au3>
#include <GuiStatusBar.au3>
#include <Excel.au3>
#include <GuiHeader.au3>
#include <GuiTreeView.au3>
#include <Array.au3>
#include <EditConstants.au3>
#include<ListViewConstants.au3>
#include <Misc.au3>
#include <TabConstants.au3>
#include <ComboConstants.au3>
#include <GuiComboBox.au3>
#include <MsgBoxConstants.au3>

#Region Global Variables / Const
Global $config_ini = @ScriptDir & "\config.ini"
Global $install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
Global $System_Dir = $install_dir & "system\"
Global $Data_Dir = $install_dir & "data\"
Global $gfx = $System_Dir & "gfx\"
Global $Sprachdatei = IniRead($config_ini,"Einstellungen", "Sprachdatei", "")
#endregion Global Variables/Const

#Region Declare Variables / Const
$Radio_PCDSG_Stats_path_local = IniRead($config_ini,"Einstellungen", "Radio_PCDSG_Stats_path_local", "")
$Radio_PCDSG_Stats_path_web = "true"
$EventBrowser_page_local_path = IniRead($config_ini,"Einstellungen", "PCDSG_Stats_path_local", "")
$EventBrowser_page_web_path = IniRead($config_ini,"Einstellungen", "PCDSG_Stats_path_web", "")

Global $DS_Domain_or_IP = IniRead($config_ini, "PC_Server", "DS_Domain_or_IP", "")

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

		If IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "") = "" Then Global $Lesen_Auswahl_httpApiInterface = $Name_Password & "127.0.0.1" ; "127.0.0.1"
		If $Lesen_Auswahl_httpApiPort = "" Then Global $Lesen_Auswahl_httpApiPort = "9000"

	Else
		Global $Lesen_Auswahl_httpApiInterface = IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "")
		Global $Lesen_Auswahl_httpApiPort = IniRead($config_ini, "Server_Einstellungen", "httpApiPort", "")

		If IniRead($config_ini, "Server_Einstellungen", "httpApiInterface", "") = "" Then Global $Lesen_Auswahl_httpApiInterface = "127.0.0.1" ; "127.0.0.1"
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

#endregion Declare Variables / Const

#Region Define Browser Mode 1
$EventBrowser_page = $Data_Dir & "Results\"
If $EventBrowser_page_local_path = "" Then $EventBrowser_page_local_path = $Data_Dir & "Results"
If $Radio_PCDSG_Stats_path_local = "true" Then
	$EventBrowser_page = $EventBrowser_page_local_path
EndIf

If $Radio_PCDSG_Stats_path_web = "true" Then
	$EventBrowser_page = $EventBrowser_page_web_path
EndIf
#endregion Define Browser Mode 1

Browser_Func()

Func Browser_Func()
	Local $oIE, $GUI_Button_Back, $GUI_Button_Forward
	Local $GUI_Button_Home, $GUI_Button_Stop, $msg

	#Region Define Browser Mode 2
	$EventBrowser_page = $Data_Dir & "Results\"
	If $EventBrowser_page_local_path = "" Then $EventBrowser_page_local_path = $Data_Dir & "Results"
	$EventBrowser_page = $EventBrowser_page_local_path
	If $Radio_PCDSG_Stats_path_local = "true" Then
		$EventBrowser_page = $EventBrowser_page_local_path
	EndIf

	If $Radio_PCDSG_Stats_path_web = "true" Then
		$EventBrowser_page = $EventBrowser_page_web_path
	EndIf
	#endregion Define Browser Mode 2

	$oIE = ObjCreate("Shell.Explorer.2")

	$Check_TaskBarPos = IniRead($config_ini, "TEMP", "TaskBarPos", "")
	$GUI_Y_POS = 0
	If $Check_TaskBarPos = "A" Then $GUI_Y_POS = 40
	If $Check_TaskBarPos = "B" Then $GUI_Y_POS = 0
	If $Check_TaskBarPos = "" Then $GUI_Y_POS = 0

	$GUI = GUICreate("PCars DS Web Interface", 800, @DesktopHeight - 79, (@DesktopWidth - 640) / 2, $GUI_Y_POS, BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPSIBLINGS, $WS_CLIPCHILDREN))

	GUISetState()

	$Linie_oben = GUICtrlCreatePic($gfx & "Hintergrund.jpg", 0, 41, 800, 2, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))

	$IE_Object = GUICtrlCreateObj($oIE, 00, 50, 800, @DesktopHeight - 130)
	$GUI_Button_Home = GUICtrlCreateButton("Home", 5, 3, 36, 36, $BS_BITMAP)
		_GUICtrlButton_SetImage($GUI_Button_Home, $gfx & "Home.bmp")
	$GUI_Button_Back = GUICtrlCreateButton("Zurück", 55, 3, 36, 36, $BS_BITMAP)
		_GUICtrlButton_SetImage($GUI_Button_Back, $gfx & "Back.bmp")
	$GUI_Button_Forward = GUICtrlCreateButton("Vor", 95, 3, 36, 36, $BS_BITMAP)
		_GUICtrlButton_SetImage($GUI_Button_Forward, $gfx & "Forward.bmp")

	$GUI_window_big = GUICtrlCreateButton("Fenster vergrößern", 145, 3, 36, 36, $BS_BITMAP)
		_GUICtrlButton_SetImage($GUI_window_big, $gfx & "W_big.bmp")
	$GUI_window_small = GUICtrlCreateButton("Fenster verkleinern", 185, 3, 36, 36, $BS_BITMAP) ; unterschied 145 zu 185 = 40
		_GUICtrlButton_SetImage($GUI_window_small, $gfx & "W_small.bmp")


	GUISetState()

	Local $aPos = WinGetPos($GUI)
	Local $IE_aPos = WinGetPos($IE_Object)

	;$oIE.navigate($EventBrowser_page)
	If $DS_Mode_Temp = "local" Then $oIE.navigate("http://" & $Lesen_Auswahl_httpApiInterface & ":" & $Lesen_Auswahl_httpApiPort)
	If $DS_Mode_Temp = "remote" Then $oIE.navigate("http://" & $Name_Password & $DS_Domain_or_IP & ":" & $Lesen_Auswahl_httpApiPort)



	While 1
		$msg = GUIGetMsg()

		Select
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
			Case $msg = $GUI_Button_Home
				$oIE.navigate($EventBrowser_page)
			Case $msg = $GUI_Button_Back
				$oIE.GoBack
			Case $msg = $GUI_Button_Forward
				$oIE.GoForward
			Case $msg = $GUI_window_big
				WinMove($GUI, "", 00, 00, @DesktopWidth, $aPos[3])
				GUICtrlSetPos($IE_Object, 00, 50, @DesktopWidth - 25, @DesktopHeight - 130)

				GUICtrlSetPos($Linie_oben, 0, 41, @DesktopWidth - 15, 2)

				GUICtrlSetPos($GUI_Button_Home, 10000, 3, 36, 36)
				GUICtrlSetPos($GUI_Button_Back, 10000, 3, 36, 36)
				GUICtrlSetPos($GUI_Button_Forward, 10000, 3, 36, 36)
				GUICtrlSetPos($GUI_window_big, 10000, 3, 36, 36)
				GUICtrlSetPos($GUI_window_small, 10000, 3, 36, 36)

				GUICtrlSetPos($GUI_Button_Home, 5, 3, 36, 36)
				GUICtrlSetPos($GUI_Button_Back, 55, 3, 36, 36)
				GUICtrlSetPos($GUI_Button_Forward, 95, 3, 36, 36)
				GUICtrlSetPos($GUI_window_big, 145, 3, 36, 36)
				GUICtrlSetPos($GUI_window_small, 185, 3, 36, 36)

			Case $msg = $GUI_window_small
				WinMove($GUI, "", $aPos[0], $aPos[1], $aPos[2], $aPos[3])
				GUICtrlSetPos($IE_Object, 00, 50, 800, @DesktopHeight - 130)

				GUICtrlSetPos($Linie_oben, 0, 41, 800, 2)

				GUICtrlSetPos($GUI_Button_Home, 10000, 3, 36, 36)
				GUICtrlSetPos($GUI_Button_Back, 10000, 3, 36, 36)
				GUICtrlSetPos($GUI_Button_Forward, 10000, 3, 36, 36)
				GUICtrlSetPos($GUI_window_big, 10000, 3, 36, 36)
				GUICtrlSetPos($GUI_window_small, 10000, 3, 36, 36)

				GUICtrlSetPos($GUI_Button_Home, 5, 3, 36, 36)
				GUICtrlSetPos($GUI_Button_Back, 55, 3, 36, 36)
				GUICtrlSetPos($GUI_Button_Forward, 95, 3, 36, 36)
				GUICtrlSetPos($GUI_window_big, 145, 3, 36, 36)
				GUICtrlSetPos($GUI_window_small, 185, 3, 36, 36)

		EndSelect
	WEnd
	GUIDelete()
EndFunc

Func _Restart()
	If FileExists($System_Dir & "Browser.exe") Then
		ShellExecute($System_Dir & "Browser.exe")
	Else
		ShellExecute($System_Dir & "Browser.au3")
	EndIf
	Exit
EndFunc