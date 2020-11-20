; Advanced ruleset for the MIDI controller "Doepfer PocketDial"



; Only if Ableton Live 10 active

if (midiChannel == 1)
{



  if application = Ableton Live 10 Suite.exe
  {

    SendKey(9, "Left", "Right")
    SendKey(10, "Up", "Down")

  }



  ; Any Application except Live 10

  if application != Ableton Live 10 Suite.exe
  {


    ; Upper Dials 1 - 4

    SendCode("Absolute", "Key", 48, "{Up 2}", "{Down 2}")
    SendCode("Absolute", "Key", 47, "{Up 4}", "{Down 4}")


  } ; End application filter

}