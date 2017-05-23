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
$Radio_PCDSG_Stats_path_web = IniRead($config_ini,"Einstellungen", "Radio_PCDSG_Stats_path_web", "")
$EventBrowser_page_local_path = IniRead($config_ini,"Einstellungen", "PCDSG_Stats_path_local", "")
$EventBrowser_page_web_path = IniRead($config_ini,"Einstellungen", "PCDSG_Stats_path_web", "")
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

	$GUI = GUICreate("PCDSG Event Browser", 800, @DesktopHeight - 79, (@DesktopWidth - 640) / 2, $GUI_Y_POS, BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPSIBLINGS, $WS_CLIPCHILDREN))

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

	#Region Radio Buttons
	$Check_Radio_1 = IniRead($config_ini, "Einstellungen", "Radio_PCDSG_Stats_path_local", "")
	$Check_Radio_2 = IniRead($config_ini, "Einstellungen", "Radio_PCDSG_Stats_path_web", "")
	Local $Radio1 = GUICtrlCreateRadio("Local File Browser", 235, 06, 120, 15)
	Local $Radio2 = GUICtrlCreateRadio("Web File Browser", 235, 22, 120, 15)
	If $Check_Radio_1 = "true" Then GUICtrlSetState($Radio1, $GUI_CHECKED)
	If $Check_Radio_2 = "true" Then GUICtrlSetState($Radio2, $GUI_CHECKED)
	#endregion Radio Buttons

	GUISetState()

	Local $aPos = WinGetPos($GUI)
	Local $IE_aPos = WinGetPos($IE_Object)

	$oIE.navigate($EventBrowser_page)

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

			Case $msg = $Radio1
				IniWrite($config_ini, "Einstellungen", "Radio_PCDSG_Stats_path_local", "true")
				IniWrite($config_ini, "Einstellungen", "Radio_PCDSG_Stats_path_web", "false")
				_Restart()

			Case $msg = $Radio2
				$EventBrowser_page_web_path = IniRead($config_ini, "Einstellungen", "PCDSG_Stats_path_web", "")

				If $EventBrowser_page_web_path = "" Then

					$Abfrage = MsgBox(4, "Path empty", "The path to the 'AutoIndex PHP Script' Results page is empty." & @CRLF & @CRLF & _
								"You need to install 'AutoIndex PHP Script' if you want to use this function."  & @CRLF & _
								"Install 'AutoIndex PHP Script' from: "  & "http://autoindex.sourceforge.net" & @CRLF & @CRLF & _
								"Browse to the AutoIndex PHP Script' Result page using your Internet Explorer"  & @CRLF & _
								"Type or copy the address line in to Input Box that appears after choosing 'YES'." & @CRLF & @CRLF & _
								"Do you want to write and save the address to the Result Web Page?")

					If $Abfrage = 6 Then
						$InputBox = InputBox ( "Enter Address", "Type or copy the address to the Result Web Page into Input Box")
						IniWrite($config_ini, "Einstellungen", "PCDSG_Stats_path_web", $InputBox)
						IniWrite($config_ini, "Einstellungen", "Radio_PCDSG_Stats_path_local", "false")
						IniWrite($config_ini, "Einstellungen", "Radio_PCDSG_Stats_path_web", "true")
						_Restart()
					EndIf

					If $Abfrage = 7 Then
						IniWrite($config_ini, "Einstellungen", "Radio_PCDSG_Stats_path_local", "true")
						IniWrite($config_ini, "Einstellungen", "Radio_PCDSG_Stats_path_web", "false")
						_Restart()
					EndIf

				Else
					IniWrite($config_ini, "Einstellungen", "Radio_PCDSG_Stats_path_local", "false")
					IniWrite($config_ini, "Einstellungen", "Radio_PCDSG_Stats_path_web", "true")
					_Restart()
				EndIf
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