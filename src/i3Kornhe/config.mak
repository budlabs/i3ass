NAME         := i3Kornhe
VERSION      := 0.7
CREATED      := 2017-12-12
UPDATED      := 2023-07-22
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := options
DESCRIPTION  := move and resize windows gracefully
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
	  printf '%s\n' '## NAME'                  \
								  '$(NAME) - $(DESCRIPTION)' \
	                '## SYNOPSIS'
	  
	  sed 's/^/    /g' $(CACHE_DIR)/synopsis.txt

	  echo '## OPTIONS'

	  sed 's/^/    /g' $(CACHE_DIR)/help_table.txt
	  cat $(CACHE_DIR)/long_help.md
	  echo "## USAGE"
	  cat $(DOCS_DIR)/description.md
	  cat $(DOCS_DIR)/environment_variables.md

	  printf '%s\n'                            \
		  '## CONTACT'                           \
		  "Send bugs and feature requests to:  " \
		  "$(CONTACT)/issues"                    \
		  '## COPYRIGHT'

		cat $(CACHE_DIR)/copyright.txt
	} > $@
