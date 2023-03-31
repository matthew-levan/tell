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
      %broadcast
    ?>  =(our.bowl src.bowl)
    =/  msg  cord.cmd
    =/  mod  mode.cmd
    |^
    =/  kids=(list ship)  (sponsored-ships our.bowl)
    ::  switch on the mode
    ?:  =(mod %hark)
      ::  get the list of sponsees subscribed to our %kids
      ::  create a notification card for each kid
      =/  cards=(list card)
        %+  turn  kids
        |=  kid=ship
        ^-  card
        (send-notification kid)
        ~&  get-peers
      [cards this]
    ::
    ?>  =(mod %chat)
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
    ++  send-notification
      |=  [who=ship]
      ^-  card
      =/  con=(list content:hark)
        =-  [ship+who - ~]
        emph+msg
      =/  =id:hark      (end 7 (shas %tell-notification eny.bowl))
      =/  =rope:hark    [~ ~ q.byk.bowl /(scot %p who)/[dap.bowl]]
      =/  =action:hark  [%add-yarn & & id rope now.bowl con /[dap.bowl] ~]
      =/  =cage         [%hark-action !>(action)]
      =/  card  [%pass /hark %agent [who %hark] %poke cage]
      ~&  card
      card
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
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
    [~ this]
  :: ?+    wire  (on-agent:default wire sign)
  ::     [%dm ~]
  ::   ?.  ?=(%poke-ack -.sign)  (on-agent:default wire sign)
  ::   ?~  p.sign  [~ this]
  ::   ((slog 'tell: failed to notify' u.p.sign) [~ this])
  :: ==
++  on-fail   on-fail:default
--