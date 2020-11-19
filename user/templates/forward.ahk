if midiStatus between 176 and 191 
{
  gosub, RelayCC
}

if midiStatus between 128 and 159 

{
  gosub, RelayNote ; send the midiNote out.
}