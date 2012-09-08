PREFIX=/srv/git
USER=git
GIT_SHELL=/usr/bin/git-shell
HACKERS=$(PWD)

# Create the user
user: 
	useradd -d $(PREFIX) -m -r -s $(GIT_SHELL) -U $(USER)

# Create the hackers.git bare repo and clone as .ssh 
# Then create needed symlinks and add hooks to hackers.git
install: 
	cd $(PREFIX); \
	git clone --bare $(HACKERS) hackers.git && \
	git clone hackers.git .ssh && \
	chmod 700 .ssh && \
	chmod 600 .ssh/authorized_keys && \
	ln -s $(PREFIX)/.ssh/git-hooks/* hackers.git/hooks/ && \
	ln -s $(PREFIX)/.ssh/git-shell-commands 
