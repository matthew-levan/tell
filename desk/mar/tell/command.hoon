/-  tell
|_  =command:tell
++  grab
  |%
  ++  noun  command:tell
  ::
  :: {
  ::   "cast": {
  ::     "cord": "Houston, we have a problem."
  ::   }
  :: }
  ++  json
    =,  dejs:format
    |=  jon=json
    ^-  command
    %.  jon
    %-  of
    :~  [%cast (ot ~[cord+so])]
    ==
  --
++  grow
  |%
  ++  noun  command
  --
++  grad  %noun
--
