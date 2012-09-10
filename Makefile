# The git user home, from where repos are served
PREFIX=/srv/git
# The git user
USER=git
# The git-shell path
GIT_SHELL=/usr/bin/git-shell
# The hacking.git clone
HACKERS=$(PWD)

# Create the user
user: 
	useradd --home $(PREFIX) \
            --shell $(GIT_SHELL) \
            --create-home \
            --system \
            --user-group \
            $(USER)

# Create the hackers.git bare repo and clone as .ssh 
# Then create needed symlinks and add hooks to hackers.git
install: 
	cd $(PREFIX); \
	git clone --bare $(HACKERS) hackers.git && \
	git clone hackers.git .ssh && \
	chmod 700 $(PREFIX) && \
	chmod 700 .ssh && \
	chmod 600 .ssh/authorized_keys && \
	ln -s $(PREFIX)/.ssh/git-hooks/* hackers.git/hooks/ && \
	ln -s $(PREFIX)/.ssh/git-shell-commands && \
    chown -R $(USER):$(USER) $(PREFIX)
