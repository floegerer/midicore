
; Confirm selected ports exist

TestPorts(numports,numports2)
{

  ; Set varibles to golobal


  ; In port selection test based on numports

  If deviceIn not Between 0 and %numports%
  {
    MidiIn := 0 ; this var is just to show if there is an error - set if the ports are valid 1, invalid 0

    If (deviceIn == "") ; if there is no midi in device
    MidiInerr = Midi In Port EMPTY. ; set this var to error message

    If (deviceIn > %numports%) ; if greater than the number of ports on the system.
    MidiInnerr = Midi In Port Invalid. ; set this error message
  }
  Else
  {
    MidiIn := 1 ; setting var to non-error state or valid
  }

  ; Test out ports

  If deviceOut not Between 0 and %numports2%
  {
    MidiOut := 0 ; set var to 0 as Error state.

    If (deviceOut == "") ; if blank
    MidiOuterr = Midi Out Port EMPTY. ; set this error message

    If (deviceOut > %numports2%) ; if greater than number of availble ports
    MidiOuterr = Midi Out Port Out Invalid. ; set this error message
  }
  Else
  {
    MidiOut := 1 ; set var to 1 as valid state.
  }

  ; Test to see if ports valid, if either invalid load the gui to select

  If (%MidiIn% == 0) Or (%MidiOut% == 0)
  {
    MsgBox, 49, Midi Port Error!,%MidiInerr%`n%MidiOuterr%`n`nLaunch Midi Port Selection!
    IfMsgBox, Cancel
    ExitApp
    ;midiok = 0 ; Not sure if this is really needed now....
    Gosub, MidiSet
  }
  Else
  {
    ;midiok = 1
    Return ; do nothing - perhaps do the not test instead above.
  }

}
