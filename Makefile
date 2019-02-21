SCRIPT  = i3ass
PREFIX  = /usr
DESTDIR =
INSTDIR = $(DESTDIR)$(PREFIX)
INSTBIN = $(INSTDIR)/bin
INSTMAN = $(INSTDIR)/share/man/man1

install:
	@test -d $(INSTBIN) || mkdir -p $(INSTBIN)
	@test -d $(INSTMAN) || mkdir -p $(INSTMAN)

	@for manpage in man/*.1 ; do \
		$(RM) $(INSMAN)/$${manpage##*/}; \
		install -m 0644 $$manpage $(INSTMAN); \
	done

	@for script in src/* ; do \
		$(RM) $(INSTBIN)/$${script##*/}; \
		install -m 0755 $$script $(INSTBIN); \
	done

.PHONY: install


uninstall:
	@for manpage in man/*.1 ; do \
		$(RM) $(INSMAN)/$${manpage##*/}; \
	done

	@for script in src/* ; do \
		$(RM) $(INSTBIN)/$${script##*/}; \
	done

	@echo 'i3ass is now no longer installed'
	
.PHONY: uninstall
