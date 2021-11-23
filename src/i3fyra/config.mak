NAME         := i3fyra
VERSION      := 1.25
CREATED      := 2017-01-14
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := options
DESCRIPTION  := An advanced, simple grid-based tiling layout
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
