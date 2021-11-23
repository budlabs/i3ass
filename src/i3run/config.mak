NAME         := i3run
VERSION      := 0.2
CREATED      := 2017-04-20
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := options
DESCRIPTION  := Run, Raise or hide windows in i3wm
ORGANISATION := budlabs

MANPAGE      := $(NAME).1
README       :=

MANPAGE_LAYOUT  ?=                     \
	$(DOCS_DIR)/readme_banner.md         \
	$(CACHE_DIR)/short_help.md           \
	$(DOCS_DIR)/description.md           \
	$(CACHE_DIR)/long_help.md            \
	$(DOCS_DIR)/environment_variables.md \
	$(DOCS_DIR)/manpage_footer.md
