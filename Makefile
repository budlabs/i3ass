LINKDIR = 
PREFIX  = /usr
DESTDIR =
INSTDIR = $(DESTDIR)$(PREFIX)
INSTBIN = $(INSTDIR)/bin
INSTMAN = $(INSTDIR)/share/man/man1

install:
	test -d $(INSTDIR) || mkdir -p $(INSTDIR)
	test -d $(INSTBIN) || mkdir -p $(INSTBIN)
	test -d $(INSTMAN) || mkdir -p $(INSTMAN)

	@for fil in * ; do \
		 if test -d $$fil ; then \
		   manfile=$$fil/$${fil##*/}.1 ; \
		   scriptfile=$$fil/$${fil##*/} ; \
		   if test -f $$manfile ; then \
		   	 install -m 0644 $$manfile $(INSTMAN); \
		   	 install -m 0755 $$scriptfile $(INSTBIN); \
		   fi; \
		 fi; \
	done
.PHONY: install

install-doc:
	test -d $(INSTDIR) || mkdir -p $(INSTDIR)
	test -d $(INSTMAN) || mkdir -p $(INSTMAN)

	@for fil in * ; do \
		 if test -d $$fil ; then \
		   manfile=$$fil/$${fil##*/}.1 ; \
		   if test -f $$manfile ; then \
		   	 install -m 0644 $$manfile $(INSTMAN); \
		   fi; \
		 fi; \
	done
.PHONY: install-doc

link-scripts:
	test -d $(LINKDIR) || mkdir -p $(LINKDIR)

	@for fil in * ; do \
		 if test -d $$fil ; then \
		   manfile=$$fil/$${fil##*/}.1 ; \
		 	 scriptfile=$$fil/$${fil##*/} ; \
		   if test -f $$manfile ; then \
		   	 ln -s  $$scriptfile $(LINKDIR)/$${scriptfile##*/} ; \
		   fi; \
		 fi; \
	done
.PHONY: link-scripts

uninstall:
	@for fil in * ; do \
		 if test -d $$fil ; then \
		   manfile=$$fil/$${fil##*/}.1 ; \
		   scriptfile=$$fil/$${fil##*/} ; \
		   if test -f $$manfile ; then \
		   	 $(RM) $(INSTMAN)/$${manfile##*/} ; \
		   	 $(RM) $(INSTBIN)/$${scriptfile##*/} ; \
		   fi; \
		 fi; \
	done
.PHONY: uninstall
