NAME         := i3list
VERSION      := 0.51
CREATED      := 2017-10-06
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := options
DESCRIPTION  := list information about the current i3 session.
ORGANISATION := budlabs

MANPAGE      := $(NAME).1
README       :=

MANPAGE_LAYOUT  ?=                     \
	$(DOCS_DIR)/manpage_banner.md        \
	$(CACHE_DIR)/synopsis.txt            \
	$(DOCS_DIR)/description.md           \
	$(CACHE_DIR)/help_table.txt          \
	$(CACHE_DIR)/long_help.md            \
	$(DOCS_DIR)/manpage_footer.md        \
	../../LICENSE

installed_manpage    = $(DESTDIR)$(PREFIX)/share/man/man$(manpage_section)/$(MANPAGE)
installed_script    := $(DESTDIR)$(PREFIX)/bin/$(NAME)

install: all
	install -Dm644 $(MANPAGE_OUT) $(installed_manpage)
	install -Dm755 $(MONOLITH) $(installed_script)

uninstall:
	@for f in $(installed_script) $(installed_manpage); do
		[[ -f $$f ]] || continue
		echo "rm $$f"
		rm "$$f"
	done
