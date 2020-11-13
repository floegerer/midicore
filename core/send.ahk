


; Relay controller message

RelayCC:
{
  type := "CC" ; Only used in the midi display - has nothing to do with message output
  MidiOutDisplay(type, statusbyte, chan , number, value) ; update the MidiMonitoritor gui
  midiOutShortMsg(h_midiout, (chan+175), number, value)

  ;MsgBox, 0, ,sendcc triggered , 1 ; for testing purposes only
}
Return



; Send controller message

SendCC:
{
  type := "CC"
  statusbyte := (Channel+174)
  number = %CC_num% ; set value of the number to the above cc_num for display on the midi out window (only needed if you want to see output)
  value = %CCIntVal%
  midiOutShortMsg(h_midiout, (Channel+175), CC_num, CCIntVal)
  MidiOutDisplay(type, statusbyte, channel, number, value) ; ; update the MidiMonitoritor gui

  ;MsgBox, 0, ,sendcc triggered , 1 ; for testing purposes only
}
Return




; Send out note messages

RelayNote:
{
  type := "NoteOn"
  midiOutShortMsg(h_midiout, statusbyte, number, value)
  MidiOutDisplay(type, statusbyte, chan, number, value)
}
Return




; Send out note messages ; this should probably be a funciton but... eh

SendNote:
{
  type := "NoteOn"
  statusbyte := 144
  note = %number% ; This var is added to allow transpostion of a note
  vel = %value%
  chan = %channel%
  number = %Note% ; Set value of the number to the above cc_num for display on the midi out window (only needed if you want to see output)
  value = %Vel%

  midiOutShortMsg(h_midiout, statusbyte, note, vel) ; call the midi funcitons with these params.
  MidiOutDisplay(type, statusbyte, chan, number, value)
}
Return




; Send a progam change message - value is ignored

SendPC:
{
  type := "PC"
  statusbyte := 192
  chan = %channel%
  number = %PC% ; Set value of the number to the above cc_num for display on the midi out window (only needed if you want to see output)
  value =
  midiOutShortMsg(h_midiout, (Channel+191), pc, value)
  MidiOutDisplay(type, statusbyte, chan, number, value)
}
Return
