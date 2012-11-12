SHELL=/bin/bash
# The git user home, from where repos are served
PREFIX=/srv/git
# The git user
USER=git
# The git-shell path
GIT_SHELL=/usr/bin/git-shell
# The hacking.git clone
HACKERS=$(shell pwd)

# Add all of your pubkeys
# TODO this can fail if you don't have any keys (why don't you)
bootstrap:
	cat $(HOME)/.ssh/id_{rsa,ecdsa,dsa}.pub >>authorized_keys 2>/dev/null || true 
	git commit authorized_keys -m "Bootstraping hacking.git" ; \

# Create the user
user: 
	useradd --home $(PREFIX) \
          --shell $(GIT_SHELL) \
          --create-home \
          --system \
          --user-group \
          $(USER)

# Check if we have at least a key
check:
	if [ $(shell wc -l authorized_keys | cut -d' ' -f1) -eq 0 ]; then \
		echo 'Add at least your key to authorized_keys!'; \
		exit 1 ;\
	fi 

# Add the hackers repo to the local clone
install-local:
	git remote add git git:hackers.git
	cat ssh_config >>$(HOME)/.ssh/config

# Create the hackers.git bare repo and clone as .ssh 
# Then create needed symlinks and add hooks to hackers.git
install: check
	cd $(PREFIX); \
	git clone --bare $(HACKERS) hackers.git && \
	git clone hackers.git .ssh && \
	chmod 700 $(PREFIX) && \
	chmod 700 .ssh && \
	chmod 600 .ssh/authorized_keys && \
	ln -s $(PREFIX)/.ssh/git-hooks/hackers-update hackers.git/hooks/post-receive && \
	ln -s $(PREFIX)/.ssh/git-shell-commands && \
	chown -R $(USER):$(USER) $(PREFIX)
