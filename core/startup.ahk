
; Declare global variables (needs to be refactored)

global deviceIn, deviceOut, appVersion
global midiStatus, midiChannel, midiNote, midiCC, midiNum, midiValue, midiType, midiPitch, midiChange, keyMode



; Load values from the ini file and refresh ports

ReadIni()
gosub, MidiPortRefresh



; Test ports

TestPorts(numports,numports2)



; Activate all midi devices (experimental)

deviceIn = 0

while (deviceIn < numports) 
{

  if (deviceIn != 5 && deviceIn != 4)
  {
    gosub, MidiListen
  }

  deviceIn++

}



; Activate Midi In & Out

; gosub, MidiListen
gosub, MidiOut
gosub, Develop



; Open Midi Montitor on Startup

;gosub, MidiMonitor