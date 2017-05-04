#include <GDIPlus.au3>
#include <GuiConstantsEx.au3>
#include <ScreenCapture.au3>
#include <WinAPI.au3>

; ===============================================================================================================================
; Description ...: Shows how to magnify an image
; Author ........: Paul Campbell (PaulIA)
; Notes .........:
; ===============================================================================================================================

; ===============================================================================================================================
; Main
; ===============================================================================================================================

Global $config_ini = (@ScriptDir & "\" & "config.ini")
Global $install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
Global $System_Dir = $install_dir & "system\"

Global $Check_WinActivate = IniRead($config_ini, "TrackMap", "Checkbox_5", "")

Save_TrackMap()


Func Save_TrackMap()
	$Check_WinExist = WinExists ("PCars: DS TrackMap")

	If $Check_WinExist = "1" Then

		If $Check_WinActivate = "true" Then
			WinActivate("PCars: DS TrackMap")
			WinWaitActive("PCars: DS TrackMap")
		EndIf

		Local $aPos = WinGetPos("PCars: DS TrackMap")

		$X = $aPos[0] + 4
		$Y = $aPos[1] + 205
		$Width = $aPos[2]
		$Height = $aPos[3]

		Local $hBMP = _ScreenCapture_Capture("", $X, $Y, 1080, 925)
		$file = $System_Dir & "TrackMap\TrackMap.jpg"
		 _ScreenCapture_SaveImage($file, $hBmp)
	EndIf

EndFunc

Exit
