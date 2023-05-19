# tell

## Specification

The basic idea is to have a generator-driven app that allows a single message to be broadcast to all sponsees of a point. It's easiest to do this to `%hark`, but we can also make it broadcast to DMs.

## Repo

[https://github.com/matthew-levan/tell](https://github.com/matthew-levan/tell)

## Process

We spent about four hours inclusive of lunch break constructing this then simplifying it back down.

## `/sur` Structure and `/mar` Marks

`**/sur/tell.hoon**`

```
|%
+$  command
  $%  [%cast =cord]
  ==
--
```

`**/mar/tell/command.hoon**`

```
/-  tell
|_  =command:tell
++  grab
  |%
  ++  noun  command:tell
  --
++  grow
  |%
  ++  noun  command
  --
++  grad  %noun
--
```

## `/app` Agent Logic

The app only needs to handle one poke: `%cast`, which will send a `cord` to all sponsored ships.

This is provided by a generator, invoked as:

```
:tell|cast 'This one goes out to the one I love.'
```

## Get sponsees from Azimuth

```
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
```

## Bugs found along the way

- [https://github.com/tloncorp/landscape-apps/issues/1890](https://github.com/tloncorp/landscape-apps/issues/1890)
    

## Future Work

- [ ] Read receipts
- [ ] Associated action (for `%hark` notifications)
- [ ] Message and who received
- [ ] A basic HTML front end (planned for next build party)


## Testing

A useful snippet for checking behavior:

```sh
curl -i localhost:8080/~/login -X POST -d "password=lidlut-tabwed-pillex-ridrup"
curl --header "Content-Type: application/json" \
     --cookie "urbauth-~zod=0v7.rhijc.0u68a.vshu6.dcrcl.qeqdu" \
     --request POST \
     --data '[{"cast":{"cord":"Hello Mars!"}}]' \
     http://localhost:8080/apps/tell/cast
```

(modulo the cookie string)
