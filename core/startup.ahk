; Load values from the ini file and refresh ports

ReadIni()
gosub, MidiPortRefresh



; Test ports

TestPorts(numports,numports2)



; Activate all midi devices (experimental)

MidiinDevice = 0

while (MidiInDevice < numports) 
{

  if (MidiinDevice != 5 && MidiinDevice != 4)
  {
    gosub, MidiListen
  }

  MidiInDevice++

}



; Activate Midi In & Out

; gosub, MidiListen
gosub, MidiOut
gosub, Develop



; Open Midi Montitor on Startup

;gosub, MidiMonitor