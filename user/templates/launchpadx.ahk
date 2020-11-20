; Advanced ruleset for the MIDI controller "Launchpad X"



; Any Application except Live 10

if (midiChannel == 11)
{

  if (application != "Code.exe")
  {

    SendCode("Momentary", "App", 11, "Firefox")
    SendCode("Momentary", "App", 12, "Code")
    SendCode("Momentary", "App", 13, "Notepad")

    ; Fill a row with CTRL+1-8 buttons

    i = 1

    while i <= 8
    {
      SendCode("Momentary", "Key", 20+i, "^{" i "}")
      i++
    }

    ; Fill a row with ALT+1-8 buttons

    i = 1

    while i <= 8
    {
      SendCode("Momentary", "Key", 30+i, "!{" i "}")
      i++
    }

  } 

  if (application == "Code.exe")
  {

    SendCode("Momentary", "Key", 81, "{F5}")
    SendCode("Momentary", "Key", 82, "{F6}")
    SendCode("Momentary", "Key", 83, "{F10}")
    SendCode("Momentary", "Key", 84, "{F11}")
    SendCode("Momentary", "Key", 85, "^+{F5}")
    SendCode("Momentary", "Key", 86, "+{F5}")
    SendCode("Momentary", "Key", 87, "!{d}{F1}")
    SendCode("Momentary", "Key", 88, "!{d}{F2}")

    SendCode("Momentary", "App", 11, "Firefox")
    SendCode("Momentary", "App", 12, "Code")
    SendCode("Momentary", "App", 13, "Notepad")

    ; Fill a row with CTRL+1-8 buttons

    SendCode("Momentary", "Key", 21, "!e")
    SendCode("Momentary", "Key", 22, "!f")
    SendCode("Momentary", "Key", 23, "^+g")
    SendCode("Momentary", "Key", 24, "!d")
    SendCode("Momentary", "Key", 25, "!y")
    SendCode("Momentary", "Key", 26, "!x}")

    ; Fill a row with ALT+1-8 buttons

    i = 1

    while i <= 8
    {
      SendCode("Momentary", "Key", 30+i, "!{" i "}")
      i++
    }

  } 

}

; End application filter
