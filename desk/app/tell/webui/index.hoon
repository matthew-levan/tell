/-  *tell
/+  rudder
::
^-  (page:rudder history command)
::
|_  [=bowl:gall order:rudder history]
++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder command)
  =/  args=(map @t @t)
    ?~(body ~ (frisk:rudder q.u.body))
  ?~  what=(~(get by args) 'act')
    ~
  =/  msg  (~(gut by args) 'msg' '')
  |^
  ^-  command
  ::  Three cases:
  ::  1. No ships, %cast
  ?~  (~(got by args) 'who')
    `command`[%cast msg]
  ::  2. One ship, %call
  =/  who  (slaw %p (~(gut by args) 'who' ''))
  ?.  =(~ who)
    `command`[%call msg ~[(need who)]]
  ::  3. Many ships, %call
  `command`[%call msg (parse-list-of-ships (~(gut by args) 'who' ''))]
  ++  parse-list-of-ships
    |=  =cord
    ^-  (list @p)
    (scan (trip cord) cooker)
  ++  parser  (star ;~(pose ace ;~(plug sig fed:ag)))
  ++  lister
    |=  values=(list ?(@t (pair @t @ud)))
    =|  points=(list @p)
    |-
    ?~  values  points
    ?@  i.values
      $(values t.values)
    $(values t.values, points (weld ~[(@p +.i.values)] points))
  ++  cooker  (cook lister parser)
  --
::
++  final  (alert:rudder url.request build)
::
++  build
  |=  $:  arg=(list [k=@t v=@t])
          msg=(unit [o=? =@t])
      ==
  ^-  reply:rudder
  ::
  |^  [%page page]
  ::
  ++  icon-color  "black"
  ::
  ++  style
    '''
    * { margin: 0.2em; padding: 0.2em; font-family: monospace; }

    p { max-width: 50em; }

    form { margin: 0; padding: 0; }

    .red { font-weight: bold; color: #dd2222; }
    .green { font-weight: bold; color: #229922; }

    a {
      display: inline-block;
      color: inherit;
      padding: 0;
      margin-top: 0;
    }

    .class-filter a {
      background-color: #ccc;
      border-radius: 3px;
      padding: 0.1em;
    }

    .class-filter.all .all,
    .class-filter.mutual .mutual,
    .class-filter.target .target,
    .class-filter.leeche .leeche {
      border: 1px solid red;
    }

    .label-filter a {
        background-color: #ddd;
        border-radius: 3px;
        padding: 0.1em;
    }

    .label-filter a.yes {
      border: 1px solid blue;
    }

    .class-filter .all::before,
    .class-filter .mutual::before,
    .class-filter .target::before,
    .class-filter .leeche::before,
    .label-filter a::before {
      content: '☐ '
    }

    .class-filter.all .all::before,
    .class-filter.mutual .mutual::before,
    .class-filter.target .target::before,
    .class-filter.leeche .leeche::before,
    .label-filter a.yes::before {
      content: '☒ '
    }

    table#pals tr td:nth-child(2) {
      padding: 0 0.5em;
    }

    .sigil {
      display: inline-block;
      vertical-align: middle;
      margin: 0 0.5em 0 0;
      padding: 0.2em;
      border-radius: 0.2em;
    }

    .sigil * {
      margin: 0;
      padding: 0;
    }

    .label {
      display: inline-block;
      background-color: #ccc;
      border-radius: 3px;
      margin-right: 0.5em;
      padding: 0.1em;
    }
    .label input[type="text"] {
      max-width: 100px;
    }
    .label span {
      margin: 0 0 0 0.2em;
    }

    button {
      padding: 0.2em 0.5em;
    }
    '''
  ::
  ++  page
    ^-  manx
    ;html
      ;head
        ;title:"%tell"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
        ;style:"{(trip style)}"
      ==  :: head
      ;body
        ;h2:"%tell messager"

        Leave the list empty to broadcast to sponsees.

        ;form(method "post")
          ;button(type "submit", name "act", value "meet"):"»"
          ;input(type "text", name "msg", placeholder "the medium is the message");
          ;input(type "text", name "who", placeholder "~sampel-palnet ~zod");
        ==
      ==  :: body
    ==  :: html
  ::
  --
--
