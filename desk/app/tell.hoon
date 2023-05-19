/-  *tell, hark, chat
/+  default-agent, dbug, rudder
/~  pages  (page:rudder history command)  /app/tell/webui
|%
+$  versioned-state
  $%  state-0
      state-1
  ==
+$  state-0
  $:  [%0 ~]
  ==
+$  state-1
  $:  [%1 msgs=(map @da (pair cord (list @p)))]
  ==
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-1
=*  state  -
^-  agent:gall
=<
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
    helper   ~(. +> bowl)
++  on-init
  ^-  (quip card _this)
  :_  this
  :~  [%pass /eyre/connect %arvo %e %connect [~ /[dap.bowl]] dap.bowl]
  ==
++  on-save   !>(state)
++  on-load
  |=  =old=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-vase)
  |-
  ?-  -.old
    %0  $(old [%1 *(map @da (pair cord (list @p)))])
    %1  `this(state old)
  ==
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:default [mark vase])
  ::
      %handle-http-request
    =;  out=(quip card _+.state)
      [-.out this(+.state +.out)]
    %.  [bowl !<(order:rudder vase) +.state]
    %-  (steer:rudder _+.state command)
    :^    pages
        (point:rudder /[dap.bowl] & ~(key by pages))
      (fours:rudder +.state)
    |=  cmd=command
    ^-  $@  brief:rudder
        [brief:rudder (list card) _+.state]
    =^  caz  this
      (on-poke %tell-command !>(cmd))
    ['Processed succesfully.' caz +.state]
  ::
      %tell-command
    =/  cmd  !<(command vase)
    ?-    -.cmd
        %cast
      ?>  =(our.bowl src.bowl)
      ::  create a chat card for each kid
      =/  cards=(list card)
        %+  turn  (sponsored-ships:helper our.bowl)
        |=  kid=ship
        ^-  card
        (send-chat:helper kid cord.cmd)
      [cards this]
    ::
        %call
      ?>  =(our.bowl src.bowl)
      ::  create a chat card for each target
      =/  cards=(list card)
        %+  turn  targets.cmd
        |=  target=ship
        ^-  card
        (send-chat:helper target cord.cmd)
      [cards this]
      ::
    ==
  ==  ::  mark
::
++  on-peek  on-peek:default
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path  (on-watch:default path)
      [%http-response *]
    %-  (slog leaf+"Eyre subscribed to {(spud path)}." ~)
    [~ this]
  ==  ::  path
++  on-arvo
  |=  [wir=wire sig=sign-arvo]
  ^-  (quip card _this)
  ?:  =(wir /apps/tell/cast)  ::  handle the response from posting
    ?>  ?=([%iris %http-response %finished * ~ *] sig)
    =/  res=json  (need (de-json:html q.data.u.full-file.client-response.sig))
    ?>  ?=(%o -.res)
    =/  redirect-url  (~(got by p.res) %url)
    ?>  ?=(%s -.redirect-url)
    =/  wirr  [/http-response/[&2.wir]]~
    =/  =response-header:http
      ^-  response-header:http
      :-  200  ~
    :_  this
    :~  [%give %fact wirr %http-response-header !>(response-header)]
        [%give %fact wirr %http-response-data !>(~)]
        [%give %kick wirr ~]
    ==
  `this
++  on-leave  on-leave:default
++  on-agent  on-agent:default
++  on-fail   on-fail:default
--
|_  =bowl:gall
++  send-chat
  |=  [who=ship msg=cord]
  ^-  card
  =/  =action:dm:chat
    :*  who
        [who now.bowl]
        %add
        replying=~
        author=our.bowl
        sent=now.bowl
        content=[%story `~[msg]]
    ==
  [%pass /dm %agent [our.bowl %chat] %poke %dm-action !>(action)]
++  get-peers
  ^-  (set ship)
  =+  [our=(scot %p our.bowl) now=(scot %da now.bowl)]
  %~  key  by
  .^((map ship ?(%alien %known)) %ax /[our]//[now]/peers)
::
++  sponsored-ships
  |=  spon=ship
  ^-  (list ship)
  %+  murn  ~(tap in get-peers)
  |=  =ship
  ?.  =(spon (sein:title our.bowl now.bowl ship))  ~
  `ship
--
