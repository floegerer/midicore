# Documentation

## Introduction

Midilab is an application written in Autohotkey, that gives you the ability to remap MIDI messages to keystrokes, key combinations, mouse clicks or mousewheel turns. It's not limited to theses things though. The full power of AHK can be used to transform MIDI input. Be creative.

It also gives you the ability to send MIDI messages by pressing keys on your keyboard or using your mouse or any other HID device. Midilab is based on a very powerful library that unfortunatly has rather poor documentation & structure. My aim is to make it universally usefull by cleaning up the code, adding new features & making it more userfriendly.


## Installation

- Download the current version of AHK at https://www.autohotkey.com/ or https://www.autohotkey.com/download/
- Run the application by launching midicore.ahk
- Make sure the app runs in the correct folder if you eg. create a shortcut

## Shortcuts

- Ctrl+Alt+S = Reload the script
- Ctrl+Alt+M = Open the IO Monitor

## Files & folders

Let's start with a list of important files & folders and their purpose:

| File or folder | Description | Status |
| --- | -- | -- |
| midicore.ahk | This is the "application" file that starts midicore | Needs refactoring |
| user\midi-in.ahk | Rules for transforming MIDI input to keypresses or any other output | Clean & WIP |
| user\midi-out.ahk | Easy way to generate MIDI messages with hotkeys | Needs refactoring |
| user | This folder contains all user rules, templates (coming) and examples (coming) | WIP |
| resources | This folder contains images, icons and other assets | WIP |
| core | This folder contains the core libraries | WIP |

## Input rules


This section (midi-in.ahk) transforms incoming MIDI messages based on a set of user defined rules. Any MIDI input as noteons, noteoffs, continuous controllers (cc) and program change (pc) messages can be used to define them. You can transform MIDI input to key strokes, key combinations, mouse movements, actions or other type of MIDI output. Note: This script does not, currently, pass the original MIDI messsage out.

There are two ways of defining a MIDI input to output rule: SendCode & SendKey. Let's start with the newer syntax for the SendCode rule format below.


### SendCode

The new default rule syntax. It's more usable & powerfull then SendKey, while remaining very easy to write.

~~~
SendCode($input, $sendcode1, $sendcode2, $mode, $repeat)
~~~

- $input =  note or cc number that the rule should react to eg. 22
- $sendcode1 = code being sent on a negative change
- $sendcode2 = code being sent on a positive change
- $mode = empty or modifier key and/or combination like "Ctrl + Alt". The code is only sent if these keys are pressed.
- $repeat = number of times the code should be sent eg. 4 for four times

#### Example rules

Here are some advanced rules featuring different keycodes and modifiers:
~~~ js
SendCode(1, "{Up}", "{Down}")
// Send Up or Down arrows when CC1 is turned left or right

SendCode(1, "{Up}", "{Down}", "Ctrl", 4)
// Send Up x 4 & Down x 4 when Ctrl is pressed

SendCode(1, "^+d{Up}!{Right}", "{Enter}", "Alt")
// Send Ctrl+Shift+Up & Alt+Right or Enter when Alt is pressed

SendCode(1, "{Shift down}{Up}", "{Shift down}{Down}", "Shift")
// Send Shift|down+Up or Shift|down+Down when Shift is pressed
~~~

#### Keycode format

To send out a key or key combination you will be using the Autohotkey "Send" syntax. You can check the documentation of Autohotkey (https://www.autohotkey.com/docs/commands/Send.htm) for more details. An Autohotkey code is always formatted in the following way:

- {} = curly braces are used to enclose key names and other options, and to send special characters literally. For example, {Tab} is the Tab key and {!} is a literal exclamation mark.

- ! = sends an ALT keystroke. For example, Send This is text!a would send the keys "This is text" and then press ALT+a

- \+ = sends a SHIFT keystroke. For example, Send +abC would send the text "AbC", and Send !+a would press ALT+SHIFT+a

- ^ = sends a CONTROL keystroke. For example, Send ^!a would press CTRL+ALT+a, and Send ^{Home} would send CONTROL+HOME

- \# = sends a WIN keystroke, therefore Send #e would hold down the Windows key and then press the letter "e"

Here are some example keycodes:
~~~ js
{Up} // Letter up, being sent

^+{Down} // Ctrl + shift + down, being sent

#m // Win + M being sent

!{Tab} This is a text // Alt + Tab This is a text, being sent

^{Up}+{Right}{Enter} // Ctrl+Up Shift+Right Enter, being sent

~~~



### SendKey

The simple but less flexible rule syntax for sending out keys or mouse actions is built the following way:

~~~
SendKey($input, $key1, $key2, $mode)
~~~

- $input =  note or cc number that the rule should react to eg. 22
- $key1 = key being sent when a negative (value) value is received eg. "Backspace"
- $key2 = key being sent out when a positive (value) value is received eg. "Enter"
- $mode = Empty or modifier key and/or combination like "Ctrl + Alt". The key is only sent if these keys are pressed.

Keys being send out have to be special keys defined by Autohotkey eg. Alt, Backspace or Space. You can check the documentation for a good explanation (https://www.autohotkey.com/docs/commands/Send.htm).

To get a little more complex there are additional (optional) parameters you can use to send out key combinations:

~~~
SendKey($input, $key1, $key2, $mode, $repeat, $mod1, $mod2)
~~~

- $repeat = number of times the key should be pressed eg. 4 for four times
- $mod1 = modifier key one that should be sent out eg. "Ctrl"
- $mod2 = modifier key two that should be sent out additionaly "Shift"

Here are some examples of simple rules that trigger different keys or key combinations:

~~~
SendKey(24, "Up", "Down",, 8)
SendKey(50, "Left", "Right")
SendKey(51, "Up", "Down")
SendKey(50, "Left", "Right", "Alt", 1, "Ctrl", "Shift")
~~~

## Technical information

Technical information about MIDI messages and the most important variables used in this project.

### References
- https://stackoverflow.com/questions/29481090/explanation-of-MIDI-messages
- http://www.MIDI.org/techspecs/MIDImessages.php


### Messages

Each incoming message consists of following variables: status (statusbyte), number (data1) and value (data2). The value of each variable is transformed to an easier to read format. Here is an example of a raw MIDI message:

| status | number | value |
|---|---|---|
| 10010011 | 00011011 | 0111111 |

### Status

The following message types are defined by the status number of the incoming MIDI message:

| status | type |
| - | - |
| 128 - 143 | note-off |
| 144 - 159 | note-on |
| 176 - 191 | cc |
| 192 - 208	 | pc |

### Variables

The most important vars are type, number and value. They contain different information depending on the status type of the message:

| type | number | value |
| - | - | - |
| note-off | number | velocity |
| note-on | number | velocity |
| cc | number | value |
| pc | number | ignored |

## Todos

I want to refactor the code more and more to make things easier to read and write. The codebase is quite chaotic. Some variable names are hard to identify and there are other usability issues.

- Cleaner and leaner code

## Endnote


If you are interested in contributing (this also goes out to the original creator of this project) please go ahead and create a commit, pull request or just ping me on github or by email. I'm happy to receive any support.

## Disclaimer

This project is under heavy development and does not have a release candidate yet. It will soon have a "Development" and "Release" branch, but until then its constantly changing. It has very powerful funtions that are currently being rewritten into a good usable state. Use with caution.
