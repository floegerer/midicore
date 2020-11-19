WinGet, application, ProcessName, A

inc := midiValue
dec := 128-midiValue
ccnum := midiNum


;MsgBox, %application%



; Defince helper vars or functions

if midiValue between 1 and 10
{
  midiChange := "positive"
}

if midiValue between 120 and 127
{
  midiChange := "negative"
}



; Get modifier key state and set keyMode var

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

SendCode(controller="Enc", code="Key", num=0, keycode1="None", keycode2="None", currentmode="Default", multi=1, hold="none")
{

  if ((midiNum == num) && (keyMode == currentmode))
  {

    if (controller == "Enc")
    {

      if (midiChange == "negative")
      {

        ; datanew := (128-midiValue)*multi
        ; Loop %datanew%

        SendInput %keycode1%
        KeyOutDisplay("key", keycode1, multi, keyMode)

      }

      if (midiChange == "positive")
      {

        ; datanew := (midiValue)*multi
        ; Loop %datanew%

        SendInput %keycode2%
        KeyOutDisplay("key", keycode2, multi, keyMode)

      }

    }

    if (controller == "Pad") && (midiValue == 127)
    {

      if (code == "Key")
      {
        SendInput %keycode1%
      }

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
      }

      KeyOutDisplay(midiNum, keycode1, multi, keyMode)

    }

  }

}



; Simple sendkey function for sending out single keys

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
