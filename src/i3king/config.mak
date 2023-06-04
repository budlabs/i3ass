NAME         := i3king
VERSION      := 0.4
CREATED      := 2021-06-01
UPDATED      := 2022-07-26
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := i3king [OPTIONS]
DESCRIPTION  := window ruler
ORGANISATION := budlabs
LICENSE      := MIT

MANPAGE_LAYOUT  :=                     \
	$(CACHE_DIR)/help_table.txt          \
	$(CACHE_DIR)/long_help.md            \
	$(DOCS_DIR)/description.md           \
	$(DOCS_DIR)/environment_variables.md \
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
	  cat $(DOCS_DIR)/environment_variables.md

	  printf '%s\n'  \
		  '## CONTACT' \
			"Send bugs and feature requests to:  " \
			"$(CONTACT)/issues" \
			'## COPYRIGHT'

		cat $(CACHE_DIR)/copyright.txt
	} > $@
