NAME         := i3run
VERSION      := 0.2.1
CREATED      := 2017-04-20
UPDATED      := 2022-05-22
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := options
DESCRIPTION  := Run, Raise or hide windows in i3wm
ORGANISATION := budlabs
LICENSE      := MIT

MANPAGE_LAYOUT  :=                     \
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
