NAME         := i3fyra
VERSION      := 1.35
CREATED      := 2017-01-14
UPDATED      := 2022-06-05
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := options
DESCRIPTION  := An advanced, simple grid-based tiling layout
ORGANISATION := budlabs
LICENSE      := MIT

MANPAGE_LAYOUT  ?=                     \
	$(CACHE_DIR)/synopsis.txt            \
	$(DOCS_DIR)/description.md           \
	$(CACHE_DIR)/help_table.txt          \
	$(CACHE_DIR)/long_help.md            \
	$(DOCS_DIR)/environment_variables.md \
	$(CACHE_DIR)/copyright.txt

$(CACHE_DIR)/wiki.md: config.mak $(MANPAGE_LAYOUT)
	@$(info making $@)
	{
	  printf '%s\n' '## NAME' '$(NAME) - $(DESCRIPTION)' \
	                '## SYNOPSIS' 

	  sed 's/^/    /g' $(CACHE_DIR)/synopsis.txt

	  cat $(DOCS_DIR)/description.md

	  echo '## OPTIONS'
	  sed 's/^/    /g' $(CACHE_DIR)/help_table.txt
	  cat $(CACHE_DIR)/long_help.md
	  cat $(DOCS_DIR)/environment_variables.md

	  printf '%s\n' \
		  '## CONTACT' \
			"Send bugs and feature requests to:  " \
			"$(CONTACT)/issues" \
			'## COPYRIGHT'

		cat $(CACHE_DIR)/copyright.txt

	} > $@
