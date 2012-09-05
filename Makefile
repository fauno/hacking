PREFIX=/srv/git
USER=git
SHELL=/usr/bin/git-shell
HACKERS=$(PWD)

# Create the user
user: 
	useradd -d $(PREFIX) -m -r -s $(SHELL) -U 

install: user
	pushd $(PREFIX)
	git clone --bare $(HACKERS) hackers.git
	git clone hackers.git .ssh
	chmod 700 .ssh
	chmod 600 .ssh/authorized_keys
	ln -s $(PREFIX)/.ssh/git-hooks/* hackers.git/hooks/
	ln -s $(PREFIX)/.ssh/git-shell-commands .
