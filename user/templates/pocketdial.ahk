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

    SendCode("Enc", "Key", 1, "{Up}", "{Down}")
    SendCode("Enc", "Key", 1, "{Up 4}", "{Down 4}", "Ctrl")
    SendCode("Enc", "Key", 1, "^+d{Up}!{Right}", "{Enter}", "Alt")
    SendCode("Enc", "Key", 1, "{Shift down}{Up}", "{Shift down}{Down}", "Shift")
    SendCode("Enc", "Key", 1, "^+{Up}", "^+{Down}", "Ctrl + Alt")
    SendCode("Enc", "Key", 1, "+{Up 4}", "+{Down 4}", "Ctrl + Shift")
    SendCode("Enc", "Key", 1, "^+d{Up}!{Right}", "^d", "Alt + Shift")

    SendCode("Enc", "Key", 2, "{Up 4}", "{Down 4}")
    SendCode("Enc", "Key", 2, "{Up 16}", "{Down 16}", "Ctrl")

    SendCode("Enc", "Key", 3, "^+{Up}", "^+{Down}")

    SendCode("Enc", "Key", 4, "^+d{Up}!{Right}", "^d")


            
    ; Upper Dials 5 - 8

    SendCode("Enc", "Key", 5, "{Up}", "{Down}")
    SendCode("Enc", "Key", 5, "{Left}", "{Right}", "Ctrl")
    SendCode("Enc", "Key", 5, "!{Up}", "{Enter}", "Alt")
    SendCode("Enc", "Key", 5, "+{Tab}", "{Tab}", "Shift")
    SendCode("Enc", "Key", 5, "{WheelUp}", "{WheelDown}", "Ctrl + Alt")
    SendCode("Enc", "Key", 6, "!{Up}", "{Enter}")
    SendCode("Enc", "Key", 7, "+{Tab}", "{Tab}")



    ; Lower Dials 1 - 4

    SendCode("Enc", "Key", 1 + 8, "{Left}", "{Right}")
    SendCode("Enc", "Key", 1 + 8, "^{Left}", "^{Right}", "Ctrl")
    SendCode("Enc", "Key", 1 + 8, "{Backspace}", "{Delete}", "Alt")
    SendCode("Enc", "Key", 1 + 8, "{Shift down}{Left}", "{Shift down}{Right}", "Shift")
    SendCode("Enc", "Key", 1 + 8, "^{Backspace}", "^{Delete}", "Ctrl + Alt")
    SendCode("Enc", "Key", 1 + 8, "^+{Left}", "^+{Right}", "Ctrl + Shift")

    SendCode("Enc", "Key", 2 + 8, "^{Left}", "^{Right}")
    SendCode("Enc", "Key", 2 + 8, "!{Left}", "!{Right}", "Ctrl")
    SendCode("Enc", "Key", 2 + 8, "^{Backspace}", "^{Delete}", "Alt")
    SendCode("Enc", "Key", 2 + 8, "{Shift down}^{Left}", "{Shift down}^{Right}", "Shift")

    SendCode("Enc", "Key", 3 + 8, "+{Tab}", "{Tab}")
    SendCode("Enc", "Key", 3 + 8, "+{Tab 4}", "{Tab 4}", "Shift")

    SendCode("Enc", "Key", 3 + 8, "{Ctrl down}{Shift down}{Tab}{Shift up}", "{Ctrl down}{Tab}", "Ctrl")
    SendCode("Enc", "Key", 3 + 8, "{Alt down}{Shift down}{Tab}{Shift up}", "{Alt down}{Tab}", "Alt")
    SendCode("Enc", "Key", 4 + 8, "k", "j")

    SendCode("Enc", "Key", 6 + 8, "+{Tab}", "{Tab}",,,"LCtrl")


    ; Lower dials 5 - 8

    SendCode("Enc", "Key", 5 + 8, "{Left}", "{Right}")

  } ; End application filter

}