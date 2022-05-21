NAME         := i3zen
VERSION      := 0.1
CREATED      := 2017-09-11
UPDATED      := 2022-05-21
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := $(NAME) [OPTIONS]
DESCRIPTION  := zentered container, full focus
ORGANISATION := budlabs
LICENSE      := MIT

MANPAGE_LAYOUT  :=               \
	$(CACHE_DIR)/help_table.txt    \
	$(CACHE_DIR)/long_help.md      \
	$(DOCS_DIR)/description.md     \
	$(DOCS_DIR)/manpage_footer.md  \
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

		printf '%s\n'                            \
		  '## CONTACT'                           \
			"Send bugs and feature requests to:  " \
			"$(CONTACT)/issues"                    \
			"## COPYRIGHT"

		cat $(CACHE_DIR)/copyright.txt

	  cat $(DOCS_DIR)/manpage_footer.md
	} > $@
