V=20120719

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 parabola{.gpg,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/parabola{.gpg,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

dist:
	git archive --format=tar --prefix=parabola-keyring-$(V)/ $(V) | gzip -9 > parabola-keyring-$(V).tar.gz
	gpg --detach-sign --use-agent parabola-keyring-$(V).tar.gz

upload:
	scp parabola-keyring-$(V).tar.gz parabola-keyring-$(V).tar.gz.sig repo.parabolagnulinux.org:/srv/ftp/other/parabola-keyring/

.PHONY: install uninstall dist upload
