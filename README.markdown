Parabola Hackers
================

## How to add new keys

* Add your key to the authorized_keys file.
* Change the key comment to the "Name <name@email.nu>" format (just for keeping
  it tidy)
* Commit
* Push if you have push privileges and you're adding a new hacker, or
* Run `git format-patch HEAD-1` and send the generated patches to Parabola

## How does this work?

There's a post-receive hook on the origin hackers.git repository that updates
a clone on ~/.ssh. Any change pushed to it is immediately reflected in access
privileges for the git user.

## Is this unsecure?

'git' is an unprivileged user. If you know how to skip this and gain access to
our servers be kind and let us now ;)
