NAME         := i3get
VERSION      := 0.83
CREATED      := 2017-03-08
UPDATED      := 2022-07-19
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := i3get [OPTIONS]
DESCRIPTION  := prints info about a specific window to stdout
ORGANISATION := budlabs
LICENSE      := MIT

MANPAGE_LAYOUT =                \
	$(CACHE_DIR)/help_table.txt   \
	$(CACHE_DIR)/long_help.md     \
	$(DOCS_DIR)/description.md    \
	$(CACHE_DIR)/copyright.txt


$(CACHE_DIR)/wiki.md: config.mak $(MANPAGE_LAYOUT)
	@$(info making $@)
	{
	  printf '%s\n' '## NAME' '$(NAME) - $(DESCRIPTION)' \
	                '## SYNOPSIS' '`$(USAGE)`'           \
	                '## OPTIONS'

	  sed 's/^/    /g' $(CACHE_DIR)/help_table.txt
	  cat $(CACHE_DIR)/long_help.md
	  
	  echo "## USAGE"
	  cat $(DOCS_DIR)/description.md
	  
	  printf '%s\n' \
		  '## CONTACT' \
			"Send bugs and feature requests to:  " \
			"$(CONTACT)/issues" \
			'## COPYRIGHT'

		cat $(CACHE_DIR)/copyright.txt

	} > $@
