NAME         := i3viswiz
VERSION      := 0.56
CREATED      := 2018-01-18
UPDATED      := 2023-07-22
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := options
DESCRIPTION  := professional window focus for i3wm
ORGANISATION := budlabs
LICENSE      := MIT

MANPAGE_LAYOUT  :=                     \
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

	  echo "## OPTIONS"
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
