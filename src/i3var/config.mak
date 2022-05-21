NAME         := i3var
VERSION      := 0.050
CREATED      := 2017-12-22
UPDATED      := 2022-05-21
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := options
DESCRIPTION  := get or get a i3 variable
ORGANISATION := budlabs
LICENSE      := MIT

MANPAGE_LAYOUT  ?=                     \
	$(CACHE_DIR)/synopsis.txt            \
	$(DOCS_DIR)/description.md           \
	$(CACHE_DIR)/help_table.txt          \
	$(CACHE_DIR)/long_help.md            \
	$(CACHE_DIR)/copyright.txt

$(CACHE_DIR)/wiki.md: config.mak $(MANPAGE_LAYOUT)
	@$(info making $@)
	{
	  printf '%s\n' '## NAME' '$(NAME) - $(DESCRIPTION)' \
	                '## SYNOPSIS'
	                
	  sed 's/^/    /g' $(CACHE_DIR)/synopsis.txt

	  echo '## OPTIONS'
	  sed 's/^/    /g' $(CACHE_DIR)/help_table.txt
	  cat $(CACHE_DIR)/long_help.md

	  echo "## USAGE"
	  cat $(DOCS_DIR)/description.md

	  printf '%s\n'                            \
		  '## CONTACT'                           \
			"Send bugs and feature requests to:  " \
			"$(CONTACT)/issues"                    \
			"## COPYRIGHT"

		cat $(CACHE_DIR)/copyright.txt
	} > $@
