#   `%tell`

##  Specification

The basic idea is to have a generator-driven app that allows a single Talk message (Tlon Talk DM) to be broadcast to a list of points, including (for instance) all sponsees of a point.

##  Repo

- [https://github.com/matthew-levan/tell](https://github.com/matthew-levan/tell)

##  Usage

```hoon
> :tell|cast 'Hello my sponsees.'

> :tell|call 'Hello my friends.' ~[~zod ~nec ~wes]

> :chat +dbug
```


## Future Work

- [x] Call anyone.
- [ ] Read receipts
- [ ] Associated action (for `%hark` notifications)
- [ ] Message and who received
- [ ] A basic HTML front end
