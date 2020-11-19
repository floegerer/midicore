


; Relay controller message

RelayCC:
{
  midiType := "cc" ; Only used in the midi display - has nothing to do with message output
  MidiOutDisplay(midiType, midiStatus, midiChannel , midiNum, midiValue) ; update the MidiMonitoritor gui
  midiOutShortMsg(h_midiout, (midiChannel+175), midiNum, midiValue)

  ;MsgBox, 0, ,sendcc triggered , 1 ; for testing purposes only
}
Return



; Send controller message

SendCC:
{
  midiType := "cc"
  midiStatus := (Channel+174)
  midiNum = %CC_num% ; set value of the midiNum to the above cc_num for display on the midi out window (only needed if you want to see output)
  midiValue = %CCIntVal%
  midiOutShortMsg(h_midiout, (Channel+175), CC_num, CCIntVal)
  MidiOutDisplay(midiType, midiStatus, channel, midiNum, midiValue) ; ; update the MidiMonitoritor gui

  ;MsgBox, 0, ,sendcc triggered , 1 ; for testing purposes only
}
Return




; Send out midiNote messages

RelayNote:
{
  midiType := "noteon"
  midiOutShortMsg(h_midiout, midiStatus, midiNum, midiValue)
  MidiOutDisplay(midiType, midiStatus, midiChannel, midiNum, midiValue)
}
Return




; Send out midiNote messages ; this should probably be a funciton but... eh

SendNote:
{
  midiType := "noteon"
  midiStatus := 144
  midiNote = %midiNum% ; This var is added to allow transpostion of a midiNote
  vel = %midiValue%
  ; midiChannel = %channel%
  midiNum = %Note% ; Set midiValue of the midiNum to the above cc_num for display on the midi out window (only needed if you want to see output)
  midiValue = %Vel%

  midiOutShortMsg(h_midiout, midiStatus, midiNote, vel) ; call the midi funcitons with these params.
  MidiOutDisplay(midiType, midiStatus, midiChannel, midiNum, midiValue)
}
Return




; Send a progam change message - midiValue is ignored

SendPC:
{
  midiType := "pc"
  midiStatus := 192
  ; midiChannel = %channel%
  midiNum = %PC% ; Set midiValue of the midiNum to the above cc_num for display on the midi out window (only needed if you want to see output)
  midiValue =
  midiOutShortMsg(h_midiout, (Channel+191), pc, midiValue)
  MidiOutDisplay(midiType, midiStatus, midiChannel, midiNum, midiValue)
}
Return
