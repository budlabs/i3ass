NAME         := i3menu
VERSION      := 0.11
CREATED      := 2018-07-21
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := i3menu [OPTIONS]
DESCRIPTION  := Adds more features to rofi when used in i3wm
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
