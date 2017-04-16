
Global $config_ini = @ScriptDir & "\system\config.ini"
Global $install_dir = IniRead($config_ini, "Einstellungen", "Installations_Verzeichnis", "")
Global $System_Dir = $install_dir & "system\"
Global $DS_folder = IniRead($config_ini, "Einstellungen", "Dedi_Installations_Verzeichnis", "")

ShellExecute($DS_folder & "DedicatedServerCmd.exe", "", "", "")