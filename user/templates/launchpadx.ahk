; Advanced ruleset for the MIDI controller "Launchpad X"



; Any Application except Live 10

if (midiChannel == 11)
{

  if (application != "Code.exe")
  {

    SendCode("Pad", "App", 11, "Firefox")
    SendCode("Pad", "App", 12, "Code")
    SendCode("Pad", "App", 13, "Notepad")

    ; Fill a row with CTRL+1-8 buttons

    i = 1

    while i <= 8
    {
      SendCode("Pad", "Key", 20+i, "^{" i "}")
      i++
    }

    ; Fill a row with ALT+1-8 buttons

    i = 1

    while i <= 8
    {
      SendCode("Pad", "Key", 30+i, "!{" i "}")
      i++
    }

  } 

  if (application == "Code.exe")
  {

    SendCode("Pad", "Key", 81, "{F5}")
    SendCode("Pad", "Key", 82, "{F6}")
    SendCode("Pad", "Key", 83, "{F10}")
    SendCode("Pad", "Key", 84, "{F11}")
    SendCode("Pad", "Key", 85, "^+{F5}")
    SendCode("Pad", "Key", 86, "+{F5}")
    SendCode("Pad", "Key", 87, "!{d}{F1}")
    SendCode("Pad", "Key", 88, "!{d}{F2}")

    SendCode("Pad", "App", 11, "Firefox")
    SendCode("Pad", "App", 12, "Code")
    SendCode("Pad", "App", 13, "Notepad")

    ; Fill a row with CTRL+1-8 buttons

    SendCode("Pad", "Key", 21, "!e")
    SendCode("Pad", "Key", 22, "!f")
    SendCode("Pad", "Key", 23, "^+g")
    SendCode("Pad", "Key", 24, "!d")
    SendCode("Pad", "Key", 25, "!y")
    SendCode("Pad", "Key", 26, "!x}")

    ; Fill a row with ALT+1-8 buttons

    i = 1

    while i <= 8
    {
      SendCode("Pad", "Key", 30+i, "!{" i "}")
      i++
    }

  } 

}

; End application filter
