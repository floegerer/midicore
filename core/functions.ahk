WinGet, application, ProcessName, A
;MsgBox, %application%



; Get modifier key state and set keyMode var (would prefer a switch statement, needs refactoring)

ctrl := ""
shift := ""
alt := ""
win := ""
appkey := ""

if getKeyState("Ctrl")
ctrl := "Ctrl + "

if getKeyState("Alt")
alt := "Alt + "

if getKeyState("Shift")
shift := "Shift + "

if getKeyState("LWin")
win := "Win + "

if getKeyState("None")
appkey := "AppsKey + "

keymode = %appkey%%win%%ctrl%%alt%%shift%
keyMode := SubStr(keymode, 1, -2)

if (keyMode == "")
keyMode := "Default"



; New default function for sending out hotkeys triggered by MIDI messages

SendCode(controller="Relative", code="Key", num=0, keycode1="None", keycode2="None", currentmode="Default")
{

  if ((midiNum == num) && (keyMode == currentmode))
  {


    ; Declare helper vars

    if midiValue between 1 and 10
    {
      midiChange := "positive"
    }

    if midiValue between 120 and 127
    {
      midiChange := "negative"
    }



    ; Define mode for endless encoders named "Relative"

    if (controller == "Relative")
    {

      if (midiChange == "negative")
      {

        SendInput %keycode1%
        KeyOutDisplay("key", keycode1, "-", keyMode)

      }

      if (midiChange == "positive")
      {

        SendInput %keycode2%
        KeyOutDisplay("key", keycode2, "-", keyMode)

      }

    }



    ; Define mode for a momentary button named "Momentary"

    if (controller == "Momentary") && (midiValue == 127)
    {

      ; Define keycode mode

      if (code == "Key")
      {
        SendInput %keycode1%
        KeyOutDisplay("key", keycode1, "-", keyMode)
      }

      ; Define app launch mode

      if (code == "App")
      {
        IfWinExist %keycode1%
        {

          IfWinActive %keycode1% 
          {
            WinMinimize %keycode1%
          } 
          else 
          {
            WinActivateBottom %keycode1%
          }
  
        } else {
        Run %keycode1%
        }

        KeyOutDisplay("app", keycode1, "-", keyMode)

      }

      ; End Pad mode function

    }



    ; Define mode for absolute Knob 

    if (controller == "Absolute")
    {

      valueChange := midiValue-midiValuePrev

      if (valueChange < 0)
      {

        SendInput %keycode1%
        KeyOutDisplay("key", keycode1, "-", keyMode)
        midiValuePrev := midiValue

      }

      if (valueChange > 0)
      {

        SendInput %keycode2%
        KeyOutDisplay("key", keycode2, "-", keyMode)
        midiValuePrev := midiValue

      }

      KeyOutDisplay(midiNum, keycode1, "-", keyMode)

    }

  }
}



; Simple sendkey function for sending out single keys (Deprecated)

SendKey(num, key1, key2, currentmode="Default", multi=1, mod1="none", mod2="none")
{

  if (keyMode == currentmode)
  {

    IfEqual, midiNum, %num%
    {

      if midiValue between 120 and 127
      {

        datanew := (128-midiValue)*multi

        if (mod1 == "none")
        SendInput {%key1% %datanew%}

        if (mod1 <> "none" && mod2 == "none")
        SendInput {%mod1% down}{%key1% %datanew%}{%mod1% up}

        if (mod1 <> "none" && mod2 <> "none")
        SendInput {%mod2% down}{%mod1% down}{%key1% %datanew%}


      }

      if midiValue between 1 and 10
      {

        datanew := (midiValue)*multi

        if (mod1 == "none")
        SendInput {%key2% %datanew%}

        if (mod1 <> "none" && mod2 == "none")
        SendInput {%mod1% down}{%key2% %datanew%}{%mod1% up}

        if (mod1 <> "none" && mod2 <> "none")
        SendInput {%mod2% down}{%mod1% down}{%key2% %datanew%}

      }

    }

  }

}
