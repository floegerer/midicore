if statusbyte between 176 and 191 
{
  gosub, RelayCC
}

if statusbyte between 128 and 159 

{
  gosub, RelayNote ; send the note out.
}