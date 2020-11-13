



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

  global MidiInDevice, MidiOutDevice, version ; version var is set at the beginning.
  IfExist, core/settings.ini
  {
    IniRead, MidiInDevice, core/settings.ini, Settings, MidiInDevice , %MidiInDevice% ; read the midi In port from ini file
    IniRead, MidiOutDevice, core/settings.ini, Settings, MidiOutDevice , %MidiOutDevice% ; read the midi out port from ini file
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
  global MidiInDevice, MidiOutDevice, version
  IfNotExist, core/settings.ini ; if no .ini
  FileAppend,, core/settings.ini ; make .ini with the following entries.
  IniWrite, %MidiInDevice%, core/settings.ini, Settings, MidiInDevice
  IniWrite, %MidiOutDevice%, core/settings.ini, Settings, MidiOutDevice
}
