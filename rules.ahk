rules:



; NoteOn Messages

if statusbyte between 144 and 159
{}



; NoteOff Messages

if statusbyte between 128 and 143
{
  MidiInDisplay(%stb%, %statusbyte%, %chan%, %data1%, %data2%)  ; display note off in gui
}



; CC Messages

if statusbyte between 176 and 191
{

  WinGet, application, ProcessName, A
  ;MsgBox, %application%

  ;Only if Ableton Live 10 active

  if application = Ableton Live 10 Suite.exe
  {

    SendKey(50, "Left", "Right", data1, data2)

    SendKey(51, "Up", "Down", data1, data2)

  }

  ; Any Application except Live 10

  if application != Ableton Live 10 Suite.exe
  {

    ; Only when all modifier key are off, process these commands

    if getKeyState("LCtrl", "P") != true and getKeyState("LAlt", "P") != true

    {

      ; Complex rules for multi key combinations

      IfEqual, data1, 22
      {

        if data2 between 1 and 10
        {
          SendInput {Shift down}{Right %data2%}{Shift up}
        }

        if data2 between 120 and 127
        {
          datanew := 128-data2
          SendInput {Shift down}{Left %datanew%}{Shift up}
        }

      }

      IfEqual, data1, 23
      {

        if data2 between 1 and 10
        {
          SendInput {Shift down}{Down %data2%}{Shift up}
        }

        if data2 between 120 and 127
        {
          datanew := 128-data2
          SendInput {Shift down}{Up %datanew%}{Shift up}
        }

      }

      ; Simple rules for single key macros

      SendKey(24, "Up", "Down", data1, data2, 8)

      SendKey(25, "WheelUp", "WheelDown", data1, data2, 2)

      SendKey(26, "Backspace", "Enter", data1, data2)

      SendKey(50, "Left", "Right", data1, data2)

      SendKey(51, "Up", "Down", data1, data2)

    }

    ; Only when modifiers key Ctrl is on

    if getKeyState("LCtrl", "P")
    {

      IfEqual, data1, 50
      {

        if data2 between 1 and 10
        {
          SendInput {Ctrl down}{Tab %data2%}
        }

        if data2 between 120 and 127
        {
          datanew := 128-data2
          SendInput {Ctrl down}{Shift down}{Tab %datanew%}{Shift up}
        }

      }

    }

    ; Only when modifier key Alt is on

    if getKeyState("LAlt", "P")
    {

      IfEqual, data1, 50
      {

        if data2 between 1 and 10
        {
          SendInput {Alt down}{Tab %data2%}
        }

        if data2 between 120 and 127
        {
          datanew := 128-data2
          SendInput {Alt down}{Shift down}{Tab %datanew%}{Shift up}
        }

      }

    }


  } ; End application filter

} ; End statusbyte cc

Return
