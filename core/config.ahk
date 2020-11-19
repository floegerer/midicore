



; Read .ini file to load port settings - also set up the tray Menu

ReadIni()
{
  ;Menu, tray, NoStandard
  Menu, tray, add
  menu, tray, add, MidiMonitor ; Menu item for the midi monitor
  Menu, tray, add, MidiSet ; set midi ports tray item
  Menu, tray, add, ResetAll ; DELETE THE .INI FILE - a new config needs to be set up

  menu, tray, Rename, MidiSet, Open MIDI port selection
  menu, tray, Rename, ResetAll, Reset port selection
  menu, tray, Rename, MidiMonitor, Show IO Monitor (Ctrl+Alt+M)

  IfExist, core/settings.ini
  {
    IniRead, deviceIn, core/settings.ini, Settings, deviceIn , %deviceIn% ; read the midi In port from ini file
    IniRead, deviceOut, core/settings.ini, Settings, deviceOut , %deviceOut% ; read the midi out port from ini file
  }
  Else ; no ini exists and this is either the first run or reset settings.
  {
    MsgBox, 1, No ini file found, Select midi ports? ; Prompt user to select midi ports
    IfMsgBox, Cancel
    ExitApp
    IfMsgBox, yes
    gosub, midiset ; run the midi setup routine
  }
} ; endof readini




; Write selections to .ini file

WriteIni()
{
  IfNotExist, core/settings.ini ; if no .ini
  FileAppend,, core/settings.ini ; make .ini with the following entries.
  IniWrite, %deviceIn%, core/settings.ini, Settings, deviceIn
  IniWrite, %deviceOut%, core/settings.ini, Settings, deviceOut
}
