; Advanced ruleset for the MIDI controller "Doepfer PocketDial"



; Only if Ableton Live 10 active

if (midiChannel == 1)
{



  if application = Ableton Live 10 Suite.exe
  {

    SendKey(9, "Left", "Right")
    SendKey(10, "Up", "Down")

  }


  if application = Resolve.exe
  {

    SendCode("Relative", "Key", 7 + 8, "{Left}", "{Right}") 
    SendCode("Relative", "Key", 7 + 8, "{Left 4}", "{Right 4}", "Shift") 
    SendCode("Relative", "Key", 7 + 8, "{Left 8}", "{Right 8}", "Alt") 
    SendCode("Relative", "Key", 8 + 8, "+{Left}", "+{Right}") 
    SendCode("Relative", "Key", 8 + 8, "+{Left 4}", "+{Right 4}", "Shift") 
    SendCode("Relative", "Key", 8 + 8, "+{Left 64}", "+{Right 64}", "Alt") 

  }



  ; Any Application except Live 10

  if application != Ableton Live 10 Suite.exe
  {


    ; Upper Dials 1 - 4

    SendCode("Relative", "Key", 1, "{Up}", "{Down}")
    SendCode("Relative", "Key", 1, "{Up 4}", "{Down 4}", "Ctrl")
    SendCode("Relative", "Key", 1, "^+d{Up}!{Right}", "{Enter}", "Alt")
    SendCode("Relative", "Key", 1, "{Shift down}{Up}", "{Shift down}{Down}", "Shift")
    SendCode("Relative", "Key", 1, "^+{Up}", "^+{Down}", "Ctrl + Alt")
    SendCode("Relative", "Key", 1, "+{Up 4}", "+{Down 4}", "Ctrl + Shift")
    SendCode("Relative", "Key", 1, "^+d{Up}!{Right}", "^d", "Alt + Shift")

    SendCode("Relative", "Key", 2, "{Up 4}", "{Down 4}")
    SendCode("Relative", "Key", 2, "{Up 16}", "{Down 16}", "Ctrl")

    SendCode("Relative", "Key", 3, "^+{Up}", "^+{Down}")

    SendCode("Relative", "Key", 4, "^+d{Up}!{Right}", "^d")


            
    ; Upper Dials 5 - 8

    SendCode("Relative", "Key", 5, "{Up}", "{Down}")
    SendCode("Relative", "Key", 5, "{Left}", "{Right}", "Ctrl")
    SendCode("Relative", "Key", 5, "!{Up}", "{Enter}", "Alt")
    SendCode("Relative", "Key", 5, "+{Tab}", "{Tab}", "Shift")
    SendCode("Relative", "Key", 5, "{WheelUp}", "{WheelDown}", "Ctrl + Alt")
    SendCode("Relative", "Key", 6, "!{Up}", "{Enter}")
    SendCode("Relative", "Key", 7, "+{Tab}", "{Tab}")



    ; Lower Dials 1 - 4

    SendCode("Relative", "Key", 1 + 8, "{Left}", "{Right}")
    SendCode("Relative", "Key", 1 + 8, "^{Left}", "^{Right}", "Ctrl")
    SendCode("Relative", "Key", 1 + 8, "{Backspace}", "{Delete}", "Alt")
    SendCode("Relative", "Key", 1 + 8, "{Shift down}{Left}", "{Shift down}{Right}", "Shift")
    SendCode("Relative", "Key", 1 + 8, "^{Backspace}", "^{Delete}", "Ctrl + Alt")
    SendCode("Relative", "Key", 1 + 8, "^+{Left}", "^+{Right}", "Ctrl + Shift")

    SendCode("Relative", "Key", 2 + 8, "^{Left}", "^{Right}")
    SendCode("Relative", "Key", 2 + 8, "!{Left}", "!{Right}", "Ctrl")
    SendCode("Relative", "Key", 2 + 8, "^{Backspace}", "^{Delete}", "Alt")
    SendCode("Relative", "Key", 2 + 8, "{Shift down}^{Left}", "{Shift down}^{Right}", "Shift")

    SendCode("Relative", "Key", 3 + 8, "+{Tab}", "{Tab}")
    SendCode("Relative", "Key", 3 + 8, "+{Tab 4}", "{Tab 4}", "Shift")

    SendCode("Relative", "Key", 3 + 8, "{Ctrl down}{Shift down}{Tab}{Shift up}", "{Ctrl down}{Tab}", "Ctrl")
    SendCode("Relative", "Key", 3 + 8, "{Alt down}{Shift down}{Tab}{Shift up}", "{Alt down}{Tab}", "Alt")
    SendCode("Relative", "Key", 4 + 8, "k", "j")

    SendCode("Relative", "Key", 6 + 8, "+{Tab}", "{Tab}")


    ; Lower dials 5 - 8

    SendCode("Relative", "Key", 5 + 8, "{Left}", "{Right}")

  } ; End application filter

}