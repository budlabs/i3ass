.PHONY:               \
	all clean check     \
	wiki readme manpage \
	install uninstall   \
	install-dev uninstall-dev

default: all

.ONESHELL:
SHELL     := /bin/bash

README_LAYOUT  =         \
	docs/readme_header.md  \
	docs/readme_install.md \
	docs/readme_about.md   \
	docs/_readme_table.md  \
	docs/readme_issues.md  \
	docs/readme_license.md \
	docs/readme_links.md

ass_dirs            := $(wildcard src/*)
wiki_mds            := $(ass_dirs:src/%=wiki/doc/%.md)
wiki_src            := $(ass_dirs:%=%/.cache/wiki.md)

$(wiki_src):
	@[[ $@ =~ ^(src/[^/]+) ]] && trg=$${BASH_REMATCH[1]}
	$(MAKE) -C $$trg .cache/wiki.md

wiki: $(wiki_mds)

$(wiki_mds): wiki/doc/%.md : src/%/.cache/wiki.md
	cat $< > $@	

readme: README.md

README.md: $(README_LAYOUT)
	cat $^ > $@

docs/_readme_table.md: $(addsuffix /config.mak,$(ass_dirs))
	@{
		echo
		printf '%s\n' "script | description" "|:-|:-|"
		gawk '
			$$1 == "NAME" {name=$$3}
			$$1 == "DESCRIPTION" {
				printf ("[%s] | %s  \n", name , gensub(".+:= ","",1,$$0))
			}' $^ 
	} > $@

ass_names           := $(ass_dirs:src/%=%)

each_check          := $(ass_names:%=%-check)
each_all            := $(ass_names:%=%-all)
each_clean          := $(ass_names:%=%-clean)
each_manpage        := $(ass_names:%=%-manpage)
each_install        := $(ass_names:%=%-install)
each_install-dev    := $(ass_names:%=%-install-dev)
each_uninstall      := $(ass_names:%=%-uninstall)
each_uninstall-dev  := $(ass_names:%=%-uninstall-dev)

each_each := $(each_check) $(each_all) $(each_clean) $(each_manpage) $(each_install) $(each_install-dev) $(each_uninstall) $(each_uninstall-dev)

check:         $(each_check)
all:           $(each_all)
clean:         $(each_clean)
manpage:       $(each_manpage)
install:       $(each_install)
install-dev:   $(each_install-dev)
uninstall:     $(each_uninstall)
uninstall-dev: $(each_uninstall-dev)

$(each_each):
	@v=$@ action=$${v#*-} name=$${v%%-*}
	$(MAKE) -C src/$$name $$action
