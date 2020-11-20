


; Include other core files

#Include core/gui.ahk
#Include core/routines.ahk
#Include core/config.ahk
#Include core/ports.ahk
#Include core/send.ahk




; Make these vars gobal to be used in other functions





; Midi input section in calls this function each time a midi message is received. Then the midi message is broken up into parts for manipulation. See http://www.midi.org/techspecs/midimessages.php (decimal values).

MidiMsgDetect(hInput, midiMsg, wMsg)
{

  ; Extract Variables by extracting from midi message

  midiStatus := midiMsg & 0xFF ; Extract midiStatus = what type of midi message and what midi channel
  midiChannel := (midiStatus & 0x0f) + 1 ; WHAT MIDI CHANNEL IS THE MESSAGE ON? EXTRACT FROM STATUSBYTE
  midiNum := (midiMsg >> 8) & 0xFF ; THIS IS midiNum VALUE = NOTE NUMBER OR CC NUMBER
  midiValue := (midiMsg >> 16) & 0xFF ; midiValue VALUE IS NOTE VELEOCITY OR CC VALUE
  midiPitch := (midiValue << 7) | midiNum ; (midiMsg >> 8) & 0x7F7F masking to extract the pbs

  ; Assign midiType variable for display only

  if midiStatus between 176 and 191 ; Is message a CC
  midiType := "cc" ; if so then set midiType to CC - only used with the midi monitor
  if midiStatus between 144 and 159 ; Is message a Note On
  midiType := "noteon" ; Set gui var
  if midiStatus between 128 and 143 ; Is message a Note Off?
  midiType := "noteoff" ; set gui to NoteOff
  if midiStatus between 192 and 208 ;Program Change
  midiType := "pc"
  if midiStatus between 224 and 239 ; Is message a Pitch Bend
  midiType := "pitchb" ; Set gui to pb

  MidiInDisplay(midiType, midiStatus, midiChannel, midiNum, midiValue) ; Show midi input on midi monitor display
  gosub, MidiInput ; run MidiInput label to organize

  ;MsgBox "Return"

}




; Show midi input on gui monitor

MidiInDisplay(midiType, midiStatus, midiChannel, midiNum, midiValue)
{

  Gui, 14:default
  Gui, 14:ListView, In1 ; see the first listview midi in monitor
  LV_Add("",midiType,midiStatus,midiChannel,midiNum,midiValue) ; Setting up the columns for gui
  LV_ModifyCol(1,"center")
  LV_ModifyCol(2,"center")
  LV_ModifyCol(3,"center")
  LV_ModifyCol(4,"center")
  LV_ModifyCol(5,"center")
  If (LV_GetCount() > 10)
  {
    LV_Delete(1)
  }

}




; Show midi output on gui monitor

MidiOutDisplay(midiType, midiStatus, midiChannel, midiNum, midiValue)
{

  Gui, 14:default
  Gui, 14:ListView, Out1 ; see the second listview midi out monitor
  LV_Add("",midiType,midiStatus,midiChannel,midiNum,midiValue)
  LV_ModifyCol(1,"center")
  LV_ModifyCol(2,"center")
  LV_ModifyCol(3,"center")
  LV_ModifyCol(4,"center")
  LV_ModifyCol(5,"center")

  If (LV_GetCount() > 10)
  {
    LV_Delete(1)
  }

}




; Show key output

KeyOutDisplay(midiNum, key, multi, keyMode) ; update the MidiMonitoritor gui
{

  keyout := RegExReplace(key, "[{}]", "")
  keyMode := RegExReplace(keyMode, "none", "Key")

  Gui, 14:default
  Gui, 14:ListView, Out1 ; see the second listview midi out monitor
  LV_Add("",midiNum, keyout, multi, keyMode)
  LV_ModifyCol(1,"center")
  LV_ModifyCol(2,"center")
  LV_ModifyCol(3,"center")
  LV_ModifyCol(4,"center")
  LV_ModifyCol(5,"center")

  If (LV_GetCount() > 10)
  {
    LV_Delete(1)
  }

}




; Returns a "|"-separated list of midi output devices

MidiOutsList(ByRef NumPorts)
{

  local List, MidiOutCaps, PortName, result, midisize
  (A_IsUnicode)? offsetWordStr := 64: offsetWordStr := 32
  midisize := offsetWordStr + 18
  VarSetCapacity(MidiOutCaps, midisize, 0)
  VarSetCapacity(PortName, offsetWordStr) ; PortNameSize 32

  ; Midi output devices on system, First device ID 0

  NumPorts := DllCall("winmm.dll\midiOutGetNumDevs")

  Loop %NumPorts%
  {
    result := DllCall("winmm.dll\midiOutGetDevCaps", "Uint",A_Index - 1, "Ptr",&MidiOutCaps, "Uint",midisize)

    If (result)
    {
      List .= "|-Error-"
      Continue
    }

    PortName := StrGet(&MidiOutCaps + 8, offsetWordStr)
    List .= "|" PortName
  }

  Return SubStr(List,2)
}




; At the beginning to load, at the end to unload winmm.dll

OpenCloseMidiAPI()
{
  static hModule
  If hModule
  DllCall("FreeLibrary", UInt,hModule), hModule := ""

  If (0 = hModule := DllCall("LoadLibrary",Str,"winmm.dll"))
  {
    MsgBox Cannot load libray winmm.dll
    Exit
  }

}




; Functions for sending short messages

midiOutOpen(uDeviceID = 0)
{
  ; Open midi port for sending individual midi messages --> handle

  strh_midiout = 0000
  result := DllCall("winmm.dll\midiOutOpen", UInt,&strh_midiout, UInt,uDeviceID, UInt,0, UInt,0, UInt,0, UInt)

  If (result or ErrorLevel)
  {
    MsgBox There was an Error opening the midi port.`nError code %result%`nErrorLevel = %ErrorLevel%
    Return -1
  }

  Return UInt@(&strh_midiout)
}




; All midi sent to the output midi port - calls this function

midiOutShortMsg(h_midiout, MidiStatus, Param1, Param2)
{

  result := DllCall("winmm.dll\midiOutShortMsg", UInt,h_midiout, UInt, MidiStatus|(Param1<<8)|(Param2<<16), UInt)

  If (result or ErrorLevel)
  {
    MsgBox There was an Error Sending the midi event: (%result%`, %ErrorLevel%)
    Return -1
  }

}



; Close MidiOutput

midiOutClose(h_midiout)
{

  Loop 9
  {
    result := DllCall("winmm.dll\midiOutClose", UInt,h_midiout)
    If !(result or ErrorLevel)
    Return
    Sleep 250
  }

  MsgBox Error in closing the midi output port. There may still be midi events being Processed.
  Return -1

}




; Get number of midi output devices on system, first device has an ID of 0

MidiOutGetNumDevs()
{
  Return DllCall("winmm.dll\midiOutGetNumDevs")
}




; Get name of a midiOut device for a given ID

MidiOutNameGet(uDeviceID = 0)
{

  VarSetCapacity(MidiOutCaps, 50, 0) ; allows for szPname to be 32 bytes
  OffsettoPortName := 8, PortNameSize := 32
  result := DllCall("winmm.dll\midiOutGetDevCapsA", UInt,uDeviceID, UInt,&MidiOutCaps, UInt,50, UInt)

  If (result OR ErrorLevel)
  {
    MsgBox Error %result% (ErrorLevel = %ErrorLevel%) in retrieving the name of midi output %uDeviceID%
    Return -1
  }

  VarSetCapacity(PortName, PortNameSize)
  DllCall("RtlMoveMemory", Str,PortName, Uint,&MidiOutCaps+OffsettoPortName, Uint,PortNameSize)
  Return PortName

}




; Returns number of midi output devices, creates array MidiOutPortName with their names

MidiOutsEnumerate()
{

  local NumPorts, PortID
  MidiOutPortName =
  NumPorts := MidiOutGetNumDevs()

  Loop %NumPorts%
  {
    PortID := A_Index -1
    MidiOutPortName%PortID% := MidiOutNameGet(PortID)
  }
  Return NumPorts

}




; Helper functions

UInt@(ptr)
{
  Return *ptr | *(ptr+1) << 8 | *(ptr+2) << 16 | *(ptr+3) << 24
}




; Windows 2000 and later

PokeInt(p_value, p_address)
{
  DllCall("ntdll\RtlFillMemoryUlong", UInt,p_address, UInt,4, UInt,p_value)
}




; Midi in port handling - Returns a "|"-separated list of midi output devices

MidiInsList(ByRef NumPorts)
{

  local List, MidiInCaps, PortName, result, midisize
  (A_IsUnicode)? offsetWordStr := 64: offsetWordStr := 32
  midisize := offsetWordStr + 18
  VarSetCapacity(MidiInCaps, midisize, 0)
  VarSetCapacity(PortName, offsetWordStr) ; PortNameSize 32

  NumPorts := DllCall("winmm.dll\midiInGetNumDevs") ; #midi output devices on system, First device ID 0

  Loop %NumPorts%
  {
    result := DllCall("winmm.dll\midiInGetDevCaps", "UInt",A_Index-1, "Ptr",&MidiInCaps, "UInt",midisize)

    If (result OR ErrorLevel)
    {
      List .= "|-Error-"
      Continue
    }

    PortName := StrGet(&MidiInCaps + 8, offsetWordStr)
    List .= "|" PortName
  }

  Return SubStr(List,2)

}




; Get number of midi output devices on system, first device has an ID of 0

MidiInGetNumDevs()
{
  Return DllCall("winmm.dll\midiInGetNumDevs")
}




; Get name of a midiOut device for a given ID

MidiInNameGet(uDeviceID = 0)
{

  VarSetCapacity(MidiInCaps, 50, 0) ; allows for szPname to be 32 bytes
  OffsettoPortName := 8, PortNameSize := 32
  result := DllCall("winmm.dll\midiInGetDevCapsA", UInt,uDeviceID, UInt,&MidiInCaps, UInt,50, UInt)

  If (result OR ErrorLevel)
  {
    MsgBox Error %result% (ErrorLevel = %ErrorLevel%) in retrieving the name of midi Input %uDeviceID%
    Return -1
  }

  VarSetCapacity(PortName, PortNameSize)
  DllCall("RtlMoveMemory", Str,PortName, Uint,&MidiInCaps+OffsettoPortName, Uint,PortNameSize)
  Return PortName

}




; Returns number of midi output devices, creates array MidiOutPortName with their names

MidiInsEnumerate()
{

  local NumPorts, PortID
  MidiInPortName =
  NumPorts := MidiInGetNumDevs()

  Loop %NumPorts%
  {
    PortID := A_Index -1
    MidiInPortName%PortID% := MidiInNameGet(PortID)
  }

  Return NumPorts

}
