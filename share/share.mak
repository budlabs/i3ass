.PHONY: manpage install uninstall check

MANPAGE := $(NAME).1

manpage: $(MANPAGE)

check: all
	shellcheck $(MONOLITH)

$(CACHE_DIR)/copyright.txt: $(config_mak)
	@$(info making $@)
	year_created=$(CREATED) year_created=$${year_created%%-*}
	year_updated=$$(date +'%Y')
	author="$(AUTHOR)" org=$(ORGANISATION)

	copy_text="Copyright (c) "

	((year_created == year_updated)) \
		&& copy_text+=$$year_created   \
		|| copy_text+="$${year_created}-$${year_updated}"

	[[ $$author ]] && copy_text+=", $$author"
	[[ $$org ]]    && copy_text+=" of $$org  "

	printf '%s\n' \
		"$$copy_text" "SPDX-License-Identifier: $(LICENSE)" > $@
			
$(MANPAGE): $(CACHE_DIR)/wiki.md
	@$(info making $@)
	uppercase_name=$(NAME)
	uppercase_name=$${uppercase_name^^}
	{
		# this first "<h1>" adds "corner" info to the manpage
		echo "# $$uppercase_name "           \
				 "$(manpage_section) $(UPDATED)" \
				 "$(ORGANISATION) \"User Manuals\""
		cat $<
	} | go-md2man > $@

installed_manpage    = $(DESTDIR)$(PREFIX)/share/man/man1/$(MANPAGE)
installed_script    := $(DESTDIR)$(PREFIX)/bin/$(NAME)

install: all
	install -Dm644 $(MANPAGE) $(installed_manpage)
	install -Dm755 $(MONOLITH) $(installed_script)

uninstall:
	@for f in $(installed_script) $(installed_manpage); do
		[[ -f $$f ]] || continue
		echo "rm $$f"
		rm "$$f"
	done
