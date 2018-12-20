#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
#Include <WinAPIEx.au3>
#include <ColorConstants.au3>

Opt('MustDeclareVars', 1)
Opt("GUIOnEventMode", 1)

Global $config_ini = @ScriptDir & "\config.ini"
Global $install_dir = IniRead($config_ini,"Einstellungen", "Installations_Verzeichnis", "")
Global $Backup_dir = $install_dir & "Backup\"
Global $System_Dir = $install_dir & "system\"
Global $Aktuelle_Version = IniRead($config_ini, "Einstellungen", "Version", "")
Global $Dedi_Installations_Verzeichnis = IniRead($config_ini, "Einstellungen", "Dedi_Installations_Verzeichnis", "")
Global $Server_Data_INI = $System_Dir & "Server_Data.ini"

IniWrite($config_ini, "TEMP", "Hidden", "true")

_Main()

Exit

Func _Main()
	;Local $DS_State = "IDLE"
	;Local $DS_State = "Lobby"
	;Local $DS_State = "Racing"

	Local $DS_State = ""

	If FileExists($Server_Data_INI) Then
		$DS_State = IniRead($Server_Data_INI, "DATA", "SessionState", "Idle")
	Else
		$DS_State = IniRead($config_ini, "PC_Server", "Server_State", "Idle")
	EndIf

	Local $Button_BG_Color = $COLOR_BLACK
	Local $Button_Label_Color = $COLOR_WHITE
	Local $Button_Border_Color = $COLOR_BLACK

	If $DS_State = "Idle" Then $Button_BG_Color = $COLOR_BLACK
	If $DS_State = "Lobby" Then $Button_BG_Color = $COLOR_YELLOW
	If $DS_State = "Racing" Then $Button_BG_Color = $COLOR_GREEN

	If $DS_State = "Idle" Then $Button_Label_Color = $COLOR_WHITE
	If $DS_State = "Lobby" Then $Button_Label_Color = $COLOR_BLACK
	If $DS_State = "Racing" Then $Button_Label_Color = $COLOR_BLUE

	If $DS_State = "Idle" Then $Button_Border_Color = $COLOR_BLACK
	If $DS_State = "Lobby" Then $Button_Border_Color = $COLOR_YELLOW
	If $DS_State = "Racing" Then $Button_Border_Color = $COLOR_GREEN


	Local $GUI_Pos_X = @DesktopWidth - 2205; 500
	Local $GUI_Pos_Y = @DesktopHeight + 300 ; 500

	Local $Button_Pos_X = 151
	Local $Button_Pos_Y = 176

	Local $Button_Width_X = 58
	Local $Button_Height_Y = 58

	Global $hBrush, $hDC
	Local $hGUI, $hBrush
	Local $hGUI, $ptrRect, $tRect,$hRgn,$hRgn2,$Button
	Local $iWidth = 1, $iHeight = 1
	Local $aPoint[7][2] = [[180, 180], [180, 180], [180, 180]]

	Global $Hidden_Mode_GUI = GUICreate("", $GUI_Pos_X, $GUI_Pos_Y,-1,-1, BitOR($WS_POPUP,$DS_MODALFRAME,$DS_SETFOREGROUND),$WS_EX_TOPMOST + $WS_EX_TOOLWINDOW)
	WinSetTrans($Hidden_Mode_GUI, "", 255)
	$Button = GUICtrlCreateButton($DS_State, $Button_Pos_X, $Button_Pos_Y, $Button_Width_X, $Button_Height_Y)
	GUICtrlSetBkColor($Button, $Button_BG_Color)
	GUICtrlSetColor($Button, $Button_Label_Color)
	GUICtrlSetOnEvent($Button, "_Show_Windows")
	$hDC = _WinAPI_GetWindowDC($Hidden_Mode_GUI)

	$hBrush = _WinAPI_CreateSolidBrush($Button_Border_Color)

	$hRgn = _WinAPI_CreatePolygonRgn($aPoint)
	$hRgn2 = _WinAPI_CreateRoundRectRgn($aPoint[2][0]-25, $aPoint[2][1], $aPoint[2][0]+25, $aPoint[2][1]+50, 50, 50)
	_WinAPI_CombineRgn($hRgn, $hRgn, $hRgn2, $RGN_OR)
	_WinAPI_DeleteObject($hRgn2)

	GUISetState()

	_WinAPI_FrameRgn ( $hDC, $hRgn, $hBrush, $iWidth, $iHeight )
	_WinAPI_SetWindowRgn($Hidden_Mode_GUI, $hRgn)

	_Hide_Windows()

	Do
		Sleep(1000)
		If FileExists($Server_Data_INI) Then
			$DS_State = IniRead($Server_Data_INI, "DATA", "SessionState", "Idle")
		Else
			$DS_State = IniRead($config_ini, "PC_Server", "Server_State", "Idle")
		EndIf
		GUICtrlSetData($Button, $DS_State)
		Local $Hidden_Check = IniRead($config_ini, "TEMP", "Hidden", "")
		If $Hidden_Check <> "true" Then _Show_Windows()
	Until GUIGetMsg() = $Button

	_Show_Windows()
	_Exit()
EndFunc

Func _Hide_Windows()
	WinSetState("Project Cars - Dedicated Server GUI", "", @SW_HIDE)
	WinSetState("Einstellungen", "", @SW_MINIMIZE)
	WinSetState("Race Control", "", @SW_MINIMIZE)
	WinSetState("PCars DS User History", "", @SW_MINIMIZE)
	WinSetState("PCars: Dedicated Server Overview", "", @SW_MINIMIZE)
	WinSetState("PCDSG " & $Aktuelle_Version, "", @SW_HIDE)
	WinSetState($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe", "", @SW_HIDE)
EndFunc

Func _Show_Windows()
	WinSetState("Project Cars - Dedicated Server GUI", "", @SW_SHOW)
	WinSetState("Einstellungen", "", @SW_SHOW)
	WinSetState("Race Control", "", @SW_SHOW)
	WinSetState("PCars DS User History", "", @SW_SHOW)
	WinSetState("PCars: Dedicated Server Overview", "", @SW_SHOW)
	WinSetState("PCDSG " & $Aktuelle_Version, "", @SW_SHOW)
	WinSetState($Dedi_Installations_Verzeichnis & "DedicatedServerCmd.exe", "", @SW_SHOW)
	_Exit()
EndFunc

Func _Exit()
	_WinAPI_DeleteObject($hBrush)
	_WinAPI_ReleaseDC($Hidden_Mode_GUI, $hDC)
	GUIDelete($Hidden_Mode_GUI)
	IniWrite($config_ini, "TEMP", "Hidden", "")
	Exit
EndFunc
