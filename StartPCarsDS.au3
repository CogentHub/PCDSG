
Global $config_ini = @ScriptDir & "\system\config.ini"
Global $DS_folder = IniRead($config_ini, "Einstellungen", "Dedi_Installations_Verzeichnis", "")

ShellExecute($DS_folder & "DedicatedServerCmd.exe", "", $DS_folder, "")