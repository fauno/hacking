V=20120719

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 parabola{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/parabola{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

dist:
	mkdir -pv parabola-keyring-$(V)/
	cp -v Makefile parabola.gpg parabola-revoked parabola-trusted parabola-keyring-$(V)/
	bsdtar czf parabola-keyring-$(V).tar.gz parabola-keyring-$(V)/
	gpg --detach-sign --use-agent parabola-keyring-$(V).tar.gz
	rm -rv parabola-keyring-$(V)/

upload:
	scp parabola-keyring-$(V).tar.gz parabola-keyring-$(V).tar.gz.sig parabola:public/other/

.PHONY: install uninstall dist upload
