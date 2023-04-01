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
++  on-init
  ^-  (quip card _this)
  =/  base  /apps/tell
  =/  cards  :~
    [%pass base %arvo %e %connect `base %tell]
    [%pass base+/cast %arvo %e %connect `base+/cast %tell]
  ==
  [cards this]
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  `this(state !<(state-0 old))
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:default [mark vase])
  ::
      %handle-http-request
    =/  req  !<((pair @ta inbound-request:eyre) vase)
    =/  url  url.request.q.req
    ?+    method.request.q.req  `this
      %'GET'
    ~&  url
    ?.  =(url '/apps/tell')  !!
    =/  frnt  
      %-  as-octs:mimes:html
      %-  crip
      %-  en-xml:html
        ;html
          ;head
            ;title: %tell
            ;style: {style}
          ==
          ;body
            ;center
              ;div(class "tell")
                ;h1: Broadcast
                ;form(action "/apps/tell/cast", method "POST")
                  ;label(for "chat"): Message
                  ;input(type "text", id "chat", name "chat", placeholder "PSA...")
                  ;button(type "submit", id "send"): Send
                ==  ::  form
              ==  ::  div tell
            ==  ::  center
          ==  ::  body
        ==  ::  html
      ==  ::  ???
    =/  httr  [/http-response/[p.req]]~
    :_  this
    :~
      [%give %fact httr %http-response-header !>([200 ~])]
      [%give %fact httr %http-response-data !>(`frnt)]
      [%give %kick httr ~]
      ==  ::  cards
    ==  ::  request switch
  ::
      %tell-command
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