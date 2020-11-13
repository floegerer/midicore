WinGet, application, ProcessName, A

inc := value
dec := 128-value
type := type
ccnum := number

;MsgBox, %application%



; Define global vars for functions

global change, number, type, mode



; Defince helper vars or functions

if value between 1 and 10
{
  change := "positive"
}

if value between 120 and 127
{
  change := "negative"
}



; Get modifier key state and set mode var

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

mode := RegExReplace(keymode, "..$", "")

if (mode == "")
mode := "Default"

;MsgBox %mode%



; New default function for sending out hotkeys triggered by MIDI messages

SendCode(controller="Enc", code="Key", num=0, keycode1="None", keycode2="None", currentmode="Default", multi=1, hold="none")
{

  if (mode == currentmode) && (number == num)
  {

    if (controller == "Enc")
    {

      if (change == "negative")
      {

        datanew := (128-value)*multi

        Loop %datanew%

        SendInput %keycode1%

        KeyOutDisplay(number, keycode1, multi, mode)

      }

      if (change == "positive")
      {

        datanew := (value)*multi

        Loop %datanew%

        SendInput %keycode2%
        KeyOutDisplay(number, keycode2, multi, mode)

      }

    }

    if (controller == "Pad") && (value == 127)
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

      KeyOutDisplay(number, keycode1, multi, mode)

    }

  }

}



; Simple sendkey function for sending out single keys

SendKey(num, key1, key2, currentmode="Default", multi=1, mod1="none", mod2="none")
{

  if (mode == currentmode)
  {

    IfEqual, number, %num%
    {

      if value between 120 and 127
      {

        datanew := (128-value)*multi

        if (mod1 == "none")
        SendInput {%key1% %datanew%}

        if (mod1 <> "none" && mod2 == "none")
        SendInput {%mod1% down}{%key1% %datanew%}{%mod1% up}

        if (mod1 <> "none" && mod2 <> "none")
        SendInput {%mod2% down}{%mod1% down}{%key1% %datanew%}


      }

      if value between 1 and 10
      {

        datanew := (value)*multi

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
