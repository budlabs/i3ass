PROGNM  ?= i3ass
PREFIX  ?= /usr
BINDIR  ?= $(PREFIX)/bin
SHRDIR  ?= $(PREFIX)/share
MANDIR  ?= $(SHRDIR)/man/man1

.PHONY: install
install:

	install -Dm755 src/*   -t $(DESTDIR)$(BINDIR)
	install -Dm644 man/*   -t $(DESTDIR)$(MANDIR)
	install -Dm644 LICENSE -t $(DESTDIR)$(SHRDIR)/licenses/$(PROGNM)

.PHONY: uninstall
uninstall:

	@for manpage in man/*.1 ; do \
		rm $(DESTDIR)$(MANDIR)/$${manpage##*/}; \
	done

	@for script in src/* ; do \
		rm $(DESTDIR)$(BINDIR)/$${script##*/}; \
	done

	rm -rf $(DESTDIR)$(SHRDIR)/licenses/$(PROGNM)
