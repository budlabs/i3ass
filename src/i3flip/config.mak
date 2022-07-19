NAME         := i3flip
VERSION      := 0.105
CREATED      := 2018-01-03
UPDATED      := 2022-05-21
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3ass
USAGE        := i3flip [--move|-m] DIRECTION
DESCRIPTION  := Tabswitching done right
ORGANISATION := budlabs
LICENSE      := MIT

MANPAGE_LAYOUT =                \
	$(CACHE_DIR)/help_table.txt   \
	$(DOCS_DIR)/description.md    \
	$(CACHE_DIR)/copyright.txt

$(CACHE_DIR)/wiki.md: config.mak $(MANPAGE_LAYOUT)
	@$(info making $@)
	{
	  printf '%s\n' '## NAME' '$(NAME) - $(DESCRIPTION)' \
	                '## SYNOPSIS' '`$(USAGE)`'           \
	                '## OPTIONS'

	  sed 's/^/    /g' $(CACHE_DIR)/help_table.txt
	  cat $(DOCS_DIR)/description.md

	  printf '%s\n'  \
		  '## CONTACT' \
			"Send bugs and feature requests to:  " \
			"$(CONTACT)/issues" \
			'## COPYRIGHT'

		cat $(CACHE_DIR)/copyright.txt
	} > $@
