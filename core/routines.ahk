


; Wait for key to multi key presses (does not work)

/*

MidiWait:
{
  ;Settimer, MidiWait, off

   holdsent, holdkey

  holdsent := false

  If (midiType != "")
  {
    midiwait := true
    midiType := ""
  }

  If (midiType == "")
  {
    ;Sleep 500
    midiwait := false
    Send {%holdkey% up}
    holdsent := false
  }

}
Return

*/

; Load new settings from midi out menu item

MidiOut:
{
  OpenCloseMidiAPI()
  h_midiout := midiOutOpen(deviceOut) ; OUTPUT PORT 1 SEE BELOW FOR PORT 2
}
Return



; Get list of MIDI ports

MidiPortRefresh: ; get the list of ports
{
  MIlist := MidiInsList(NumPorts) ; Get midi inputs list
  Loop Parse, MIlist, |
  {
  }
  TheChoice := deviceIn + 1

  MOlist := MidiOutsList(NumPorts2) ; Get midi outputs list
  Loop Parse, MOlist, |
  {
  }
  TheChoice2 := deviceOut + 1
}
Return



; Midi input / output under the hood

MidiListen:
{
  DeviceID := deviceIn ; midiindevice from IniRead above assigned to deviceid
  CALLBACK_WINDOW := 0x10000 ; from orbiks code for midi input

  Gui, +LastFound ; set up the window for midi data to arrive.
  hWnd := WinExist() ;MsgBox, 32, , line 176 - mcu-input is := %deviceIn% , 3 ; this is just a test to show midi device selection

  hMidiIn =
  VarSetCapacity(hMidiIn, 4, 0)
  result := DllCall("winmm.dll\midiInOpen", UInt,&hMidiIn, UInt,DeviceID, UInt,hWnd, UInt,0, UInt,CALLBACK_WINDOW, "UInt")
  If result
  {
    MsgBox, Error, midiInOpen Returned %result%`n
    ;GoSub, sub_exit
  }

  hMidiIn := NumGet(hMidiIn) ; because midiInOpen writes the value in 32 bit binary Number, AHK stores it as a string
  result := DllCall("winmm.dll\midiInStart", UInt,hMidiIn)
  If result
  {
    MsgBox, Error, midiInStart Returned %result%`nRight Click on the Tray Icon - Left click on MidiSet to select valid midi_in port.
    ;GoSub, sub_exit
  }

  OpenCloseMidiAPI()

  ; See top of this file for function called when a midi message is detected

  OnMessage(0x3C1, "MidiMsgDetect")
  OnMessage(0x3C2, "MidiMsgDetect")
  OnMessage(0x3C3, "MidiMsgDetect")
  OnMessage(0x3C4, "MidiMsgDetect")
  OnMessage(0x3C5, "MidiMsgDetect")
  OnMessage(0x3C6, "MidiMsgDetect")

}
Return
