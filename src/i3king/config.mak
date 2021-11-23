NAME         := i3king
VERSION      := 0.33
CREATED      := 2021-06-01
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := i3king [OPTIONS]
DESCRIPTION  := window ruler
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
