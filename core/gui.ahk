


; Midi monitor gui code - creates the monitor window

MidiMonitor: ; midi monitor gui with listviews
{
  posx := A_ScreenWidth - 640
  posy := A_ScreenHeight - 380
  ; MsgBox %posx%

  Gui, 14: destroy
  Gui, 14: default
  Gui, 14: add, text, x80 y5, MIDI Input ; %TheChoice%
  Gui, 14: Add, DropDownList, x40 y20 w140 Choose%TheChoice% vMidiInPort gDoneInChange altsubmit -tabstop, %MiList% ; (
  Gui, 14: add, text, x305 y5, MIDI Ouput ; %TheChoice2%
  Gui, 14: Add, DropDownList, x270 y20 w140 Choose%TheChoice2% vMidiOutPort gDoneOutChange altsubmit -tabstop, %MoList%
  Gui, 14: Add, ListView, x5 r11 w300 Backgroundblack caqua Count10 vIn1 -tabstop, midiType|midiStatus|midiChannel|midiNum|midiValue|
  Gui, 14: Add, ListView, x+5 r11 w300 Backgroundblack cyellow Count10 vOut1 -tabstop, midiType|midiStatus|midiChannel|midiNum|midiValue|
  Gui, 14: +AlwaysOnTop
  Gui, 14: add, Button, x5 w220 gSet_Done, Save && Reload
  Gui, 14: add, Button, xp+225 w220 gCancel, Cancel
  Gui, 14: show, autosize x%posx% y%posy%, IO Monitor
}
Return



; Midi input selection

MidiSet:
{
  Gui, 6: Destroy
  Gui, 2: Destroy
  Gui, 3: Destroy
  Gui, 4: Destroy
  Gui, 4: +LastFound +AlwaysOnTop +Caption +ToolWindow ;-SysMenu
  Gui, 4: Font, s12
  Gui, 4: add, text, x10 y10 w300 cmaroon, Select Midi Ports. ; Text title
  Gui, 4: Font, s8
  Gui, 4: Add, Text, x10 y+10 w175 Center , Midi In Port ;Just text label
  Gui, 4: font, s8
  Gui, 4: Add, ListBox, x10 w200 h100 Choose%TheChoice% vMidiInPort gDoneInChange AltSubmit, %MiList% ; --- midi in listing of ports
  Gui, 4: Add, TEXT, x220 y40 w175 Center, Midi Out Port ; gDoneOutChange
  Gui, 4: Add, ListBox, x220 y62 w200 h100 Choose%TheChoice2% vMidiOutPort gDoneOutChange AltSubmit, %MoList% ; --- midi out listing
  Gui, 4: add, Button, x10 w205 gSet_Done, Done - Reload script.
  Gui, 4: add, Button, xp+205 w205 gCancel, Cancel
  Gui, 4: show , , %appVersion% Midi Port Selection ; main window title and command to show it.
}
Return



; Run this when midi input port has changed

DoneInChange:
{
  gui +lastfound
  Gui, Submit, NoHide
  Gui, Flash
  Gui, 4: Submit, NoHide
  Gui, 4: Flash
  If %MidiInPort%
  UDPort:= MidiInPort - 1, deviceIn:= UDPort ; probably a much better way do this, I took this from JimF's qwmidi without out editing much.... it does work same with doneoutchange below.
  GuiControl, 4:, UDPort, %MidiIndevice%
  WriteIni()

  ; MsgBox, 32, , midi in device = %deviceIn%`nmidiinport = %MidiInPort%`nport = %port%`ndevice= %device% `n UDPort = %UDport% ; UNCOMMENT FOR TESTING IF NEEDED
}
Return



; Run this when output port has changed

DoneOutChange:
{
  gui +lastfound
  Gui, Submit, NoHide
  Gui, Flash
  Gui, 4: Submit, NoHide
  Gui, 4: Flash
  If %MidiOutPort%
  UDPort2:= MidiOutPort - 1 , deviceOut:= UDPort2
  GuiControl, 4: , UDPort2, %MidiOutdevice%
  WriteIni()

  ;Gui, Destroy
}
Return



; Save config and reload

Set_Done:
{
  Gui, 3: Destroy
  Gui, 4: Destroy
  sleep, 100
  Reload
}
Return



; Do not save and close all dialogs

Cancel:
{
  Gui, Destroy
  Gui, 2: Destroy
  Gui, 3: Destroy
  Gui, 4: Destroy
  Gui, 5: Destroy
}
Return


; Reset configuration and delete ini

ResetAll:
{
  MsgBox, 33, %appVersion% - Reset All?, This will delete ALL settings`, and restart this program!
  IfMsgBox, OK
  {
    FileDelete, core/%appVersion%.ini ; delete the ini file to reset ports, probably a better way to do this ...
    Reload ; restart the app
  }
  IfMsgBox, Cancel
  {
    ; Do nothing
  }
}
Return


; On window close

GuiClose:
{
  Suspend, Permit ; allow Exit to work Paused.
  MsgBox, 4, Exit %appVersion%, Exit %appVersion% %ver%?
  IfMsgBox No
  Return
  Else IfMsgBox Yes
  midiOutClose(h_midiout)
  Gui, 6: Destroy
  Gui, 2: Destroy
  Gui, 3: Destroy
  Gui, 4: Destroy
  Gui, 5: Destroy
  gui, 7: destroy
  Sleep 100
  ;winclose, Midi_in_2 ;close the midi in 2 ahk file

  ExitApp
}

