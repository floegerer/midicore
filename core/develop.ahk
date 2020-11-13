Develop:

return



; Reload application

~!^s::
Sleep 250
Reload
Sleep 500
return



; Define helper hotkeys, open Monitor

!^m::
GoSub, MidiMonitor
return


; Stop Win + Alt from interfering when sending out hotkeys / may break things

~LWin::
return

~LAlt::
return
