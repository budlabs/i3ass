SCRIPT  = i3ass
PREFIX  = /usr
DESTDIR =
INSTDIR = $(DESTDIR)$(PREFIX)
INSTBIN = $(INSTDIR)/bin
INSTMAN = $(INSTDIR)/share/man/man1

install:
	@test -d $(INSTDIR) || mkdir -p $(INSTDIR)
	@test -d $(INSTBIN) || mkdir -p $(INSTBIN)
	@test -d $(INSTMAN) || mkdir -p $(INSTMAN)

	@install -m 0644 $(SCRIPT).1 $(INSTMAN)
	@install -m 0755 program.sh $(INSTBIN)/$(SCRIPT)

	@for manpage in ass/*/*.1 ; do \
		install -m 0644 $$manpage $(INSTMAN); \
	done

	@for script in src/* ; do \
		install -m 0755 $$script $(INSTBIN); \
	done

	@$(SCRIPT)
.PHONY: install


uninstall:
	@$(RM) $(INSTBIN)/$(SCRIPT) 
	@$(RM) $(INSTMAN)/$(SCRIPT).1

	@for fil in src/* ; do \
		scriptfile=$${fil##*/} ; \
		manfile=$${fil}.1 ; \
		$(RM) $(INSTMAN)/$${manfile} ; \
	done
	@echo 'i3ass is now no longer installed'
.PHONY: uninstall
