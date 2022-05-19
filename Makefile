.PHONY: wiki install-dev install all clean readme uninstall-dev check manpage

default: all

.ONESHELL:
SHELL     := /bin/bash

ass_dirs  := $(wildcard src/*)
wiki_mds  := $(ass_dirs:src/%=wiki/doc/%.md)

README_LAYOUT  =         \
	docs/readme_header.md  \
	docs/readme_install.md \
	docs/readme_about.md   \
	docs/readme_table.md   \
	docs/readme_issues.md  \
	docs/readme_license.md \
	docs/readme_links.md   \


install install-dev all clean uninstall-dev check manpage:
	for dir in $(ass_dirs); do
		$(MAKE) -C "$$dir" $@
	done

wiki: $(wiki_mds)

$(wiki_mds): wiki/doc/%.md : src/%/.cache/wiki.md
	cat $< > $@	

readme: README.md

README.md: $(README_LAYOUT)
	cat $^ > $@

docs/readme_table.md: $(addsuffix /config.mak,$(ass_dirs))
	@{
		echo
		printf '%s\n' "script | description" "|:-|:-|"
		gawk '
			$$1 == "NAME" {name=$$3}
			$$1 == "DESCRIPTION" {
				printf ("[%s] | %s  \n", name , gensub(".+:= ","",1,$$0))
			}' $^ 
	} > $@
