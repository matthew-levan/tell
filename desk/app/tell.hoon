/-  *tell, hark, chat
/+  default-agent, dbug
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  [%0 ~]
  ==
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
++  on-init   on-init:default
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  `this(state !<(state-0 old))
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?>  ?=(%tell-command mark)
  =/  cmd  !<(command vase)
  ?-    -.cmd
      %cast
    ?>  =(our.bowl src.bowl)
    =/  msg  cord.cmd
    |^
    =/  kids=(list ship)  (sponsored-ships our.bowl)
    ::  create a chat card for each kid
    =/  cards=(list card)
      %+  turn  kids
      |=  kid=ship
      ^-  card
      (send-chat kid)
    [cards this]
    ::
    ++  send-chat
      |=  [who=ship]
      ^-  card
      ::  action [pair ship diff=[echo grief]]
      =/  =action:dm:chat
        :*  who
            [who now.bowl]
            %add
            replying=~
            author=our.bowl
            sent=now.bowl
            content=[%story `~[msg]]
        ==
      ~&  action
      [%pass /dm %agent [our.bowl %chat] %poke %dm-action !>(action)]
    ::
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
  ==
::
++  on-peek  on-peek:default
++  on-watch  on-watch:default
++  on-arvo   on-arvo:default
++  on-leave  on-leave:default
++  on-agent  on-agent:default
++  on-fail   on-fail:default
--