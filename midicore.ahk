
#Persistent
#SingleInstance, force
;#InstallKeybdHook



; Set AHK config

Menu, Tray, Icon, resources\tray.ico
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode 2



; Ensures a consistent starting directory

if A_OSVersion in WIN_NT4,WIN_95,WIN_98,WIN_ME ; If not Windows XP or greater, quit program
{
  MsgBox This script requires Windows 2000/XP or later.
  ExitApp
}



; Set midicore version

version = midicore



; Open ports and listen

#include core/startup.ahk



; End autoexec section

return



; Includes files

#Include core/core.ahk
#Include core/develop.ahk
#Include user/midi-in.ahk
;#Include user/midi-out.ahk
