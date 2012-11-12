Hackers
=======

## What's this? Why?

Hackers is a simple git repository management tool. I started this for Parabola
GNU/Linux-libre when our gitosis broke and was never fixed. We didn't need
gitosis' granular permissions anyway.

Hackers.git allows for decentralized management, since any hacker added can add
new keys, own and others'.

It uses the git-shell to allow users to do git repository tasks (create a repo,
mirror one, etc.) using ssh to connect to the repository server.

## Install

Clone hackers.git somewhere and add yours and other people's SSH pubkeys (at
least yours) to the authorized\_keys file, then commit.

This step can be done in a single step with `make bootstrap` (or let the next
step do it). If you don't you won't be able to login later!

Run `make PREFIX=/srv/git` as root, where *PREFIX* is the git root. Check the
Makefile itself to see other options.

Now you can use `ssh git@host command arguments`, run the *help* command to
list commands and arguments available.

## Host requirements

You'll need `git-shell`, on Parabola it's on the *git* package. Also a working
ssh daemon with "AuthorizedKeysFile  .ssh/authorized_keys" (default in most
installations).

## Local configuration

On your hacking user, you can add this to your *~/.ssh/config*

    Host git
      HostName git_hostname_can_be_localhost
      User git

The repo URL will be *git:repo.git* or *ssh://gitPREFIX/repo.git*.

## How to add new keys

* Add your key to the authorized\_keys file on your local clone
* Change the key comment to the "Name <name@email.nu>" format (just for keeping
  it tidy)
* Commit
* Push if you have push privileges and you're adding a new hacker, or
* Run `git format-patch HEAD-1` and send the generated patches to one of the
  other hackers listed.

## How does this work?

There's a post-receive hook on the origin hackers.git repository that updates
a clone on ~/.ssh. Any change pushed to it is immediately reflected in access
privileges for the git user.

## Is this insecure?

*git* is an unprivileged user. If you know how to skip this and gain access to
our servers be kind and let us now ;)
