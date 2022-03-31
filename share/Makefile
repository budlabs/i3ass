.PHONY: clean check all install uninstall \
				install-dev uninstall-dev

.ONESHELL:
SHELL           := /bin/bash

ifneq ($(wildcard config.mak),)
include config.mak
else
MANPAGE         := $(notdir $(realpath .)).1
README          := README.md
endif

PREFIX          ?= /usr
NAME            ?= $(notdir $(realpath .))
VERSION         ?= 0
UPDATED         ?= $(shell date +'%Y-%m-%d')
CREATED         ?= $(UPDATED)
AUTHOR          ?= anon
CONTACT         ?= address
ORGANISATION    ?=
CACHE_DIR       ?= ./.cache
DOCS_DIR        ?= ./docs
CONF_DIR        ?= ./conf
AWK_DIR         ?= ./awklib
FUNCS_DIR       ?= ./func
INDENT          ?= $(shell echo -e "  ")
NEWLINE         := $(shell printf '%s\n' "")
USAGE           ?= $(NAME) [OPTIONS]
DESCRIPTION     ?= short description of the script
OPTIONS_FILE    ?= options
DEFAULT_OPTIONS ?= --hello|-o WORD --help|-h --version|-v
MONOLITH        ?= _$(NAME).sh
BASE            ?= _init.sh
SHBANG          ?= \#!/bin/bash
MANPAGE         ?=
LICENSE         ?= LICENSE
README          ?=

MANPAGE_LAYOUT  ?=                \
	$(DOCS_DIR)/readme_banner.md    \
	$(CACHE_DIR)/short_help.md      \
	$(DOCS_DIR)/description.md      \
	$(CACHE_DIR)/long_help.md       \
	$(DOCS_DIR)/manpage_footer.md

README_LAYOUT  ?=              \
	$(DOCS_DIR)/readme_banner.md \
	$(MANPAGE_LAYOUT)

function_createconf := $(FUNCS_DIR)/_createconf.sh
function_awklib     := $(FUNCS_DIR)/_awklib.sh

manpage_section     := $(subst .,,$(suffix $(MANPAGE)))
installed_script    := $(DESTDIR)$(PREFIX)/bin/$(NAME)
installed_manpage   := \
	$(DESTDIR)$(PREFIX)/share/man/man$(manpage_section)/$(MANPAGE)
installed_license   := \
	$(DESTDIR)$(PREFIX)/share/licenses/$(NAME)/$(LICENSE)

installed_all       := \
	$(installed_script)  \
	$(installed_manpage) \
	$(installed_license)

ifneq ($(wildcard $(CONF_DIR)/*),)
include_createconf = $(function_createconf)
conf_dirs      = $(shell find $(CONF_DIR) -type d)
conf_files     = $(shell find $(CONF_DIR) -type f)
else
$(shell rm -f $(function_createconf))
endif

ifneq ($(wildcard $(AWK_DIR)/*),)
include_awklib  = $(function_awklib)
awk_files       = $(wildcard $(AWK_DIR)/*)
else
$(shell rm -f $(function_awklib))
endif

option_docs = $(wildcard $(DOCS_DIR)/options/*)

generated_functions := $(function_err) $(include_createconf) $(include_awklib)
function_files := \
	$(generated_functions) \
	$(filter-out $(generated_functions),$(wildcard $(FUNCS_DIR)/*))

all: $(MONOLITH) $(MANPAGE) $(README) $(BASE)

clean:
	rm -rf \
		$(MONOLITH)             \
		$(BASE)                 \
		$(CACHE_DIR)            \
		$(generated_functions)  \
		$(MANPAGE)              \
		$(README)               

install-dev: $(BASE) $(NAME) | $(PREFIX)/bin/
	ln -s $(realpath $(NAME)) $(PREFIX)/bin/$(NAME)

$(PREFIX)/bin/:
	mkdir -p $@
	
uninstall-dev: $(PREFIX)/bin/$(NAME)
	rm $^

install: $(MONOLITH) $(MANPAGE)
	@[[ -f $(MANPAGE) ]] && {
		echo "install -Dm644 $(MANPAGE) $(installed_manpage)"
		install -Dm644 $(MANPAGE) $(installed_manpage)
	}
	[[ -f $(LICENSE) ]] && {
		echo "install -Dm644 $(LICENSE) $(installed_license)"
		install -Dm644 $(LICENSE) $(installed_license)
	}

	echo "install -Dm755 $(MONOLITH) $(installed_script)"
	install -Dm755 $(MONOLITH) $(installed_script)

uninstall:
	@for f in $(installed_all); do
		[[ -f $$f ]] || continue
		echo "rm '$$f'"
		rm "$$f"
	done


$(function_awklib): $(awk_files) | $(FUNCS_DIR)/
	@printf '%s\n' \
		'#!/bin/bash'                                                           \
		''                                                                      \
		'### _awklib() function is automatically generated'                     \
		'### from makefile based on the content of the $(AWK_DIR)/ directory'   \
		''                                                                      \
		'_awklib() {'                                                           \
		'[[ -d $$__dir ]] && { cat "$$__dir/$(AWK_DIR)/"* ; return ;} #bashbud' \
		"cat << 'EOAWK'"   > $@
		cat $(awk_files)  >> $@
		printf '%s\n' "EOAWK" '}' >> $@


$(function_createconf): $(conf_files) | $(FUNCS_DIR)/

	@printf '%s\n' \
		'#!/bin/bash'                                                          \
		''                                                                     \
		'### _createconf() function is automatically generated'                \
		'### from makefile based on the content of the $(CONF_DIR)/ directory' \
		''                                                                     \
		'_createconf() {'                                                      \
		'local trgdir="$$1"' > $@

	echo 'mkdir -p $(subst $(CONF_DIR),"$$trgdir",$(conf_dirs))' >> $@
	for f in $(conf_files); do
		echo "" >> $@
		echo 'if [[ -d $$__dir ]]; then #bashbud' >> $@
		echo "cat \"\$$__dir/$$f\" > \"$${f/$(subst /,\/,$(CONF_DIR))/\$$trgdir}\" #bashbud" >> $@
		echo 'else #bashbud' >> $@
		echo "cat << 'EOCONF' > \"$${f/$(subst /,\/,$(CONF_DIR))/\$$trgdir}\"" >> $@
		cat "$$f" >> $@
		echo "EOCONF" >> $@
		echo 'fi #bashbud' >> $@
	done

	echo '}' >> $@

$(README): $(README_LAYOUT)
	@cat $^ > $@

$(DOCS_DIR)/manpage_footer.md:
	@cat <<-'EOB' > $@
	# SEE ALSO
	Project site: <$(CONTACT)>

	# CONTACT
	File bugs and feature requests at the following URL:  
	<$(CONTACT)>

	# AUTHOR
	$(NAME) was written by $(AUHTOR) of $(ORGANISATION)
	EOB


$(DOCS_DIR)/readme_banner.md:
	@printf '%s\n' "# $(NAME)" "" "$(DESCRIPTION)" "" "---" "" > $@

$(MANPAGE): $(CACHE_DIR)/manpage.md
	@$(info generating $@ from $^)
	lowdown -sTman                                \
		-M title=$(NAME)                            \
		-M date=$(UPDATED)                          \
		-M source=$(ORGANISATION)                   \
		-M section=$(manpage_section)               \
		$^ > $@

$(CACHE_DIR)/manpage.md: $(MANPAGE_LAYOUT)
	@cat $^ > $@

$(CACHE_DIR)/long_help.md: $(CACHE_DIR)/options_in_use $(option_docs)
	@$(info making $@)
	printf '%s\n' '' '# OPTIONS' '' '' > $@
	for f in $(addprefix $(DOCS_DIR)/options/,$(file < $(CACHE_DIR)/options_in_use)); do
		[[ $$(wc -l < $$f) -lt 2 ]] && continue
		echo
		sed -r 's/(.+)[|][^|]+$$/## \1  /;1q' "$$f"
		echo
		tail -qn +3 "$$f"
	done >> $@

$(MONOLITH): $(NAME) $(CACHE_DIR)/print_help.sh $(function_files) $(CACHE_DIR)/timer_start $(CACHE_DIR)/getopt
	@$(info making $@)
	printf '%s\n' '$(SHBANG)' '' 'exec 3>&2' '' > $@
	$(print_version)
	grep -vhE -e '^#!/' -e '#bashbud$$' $^ >> $@
	
	$(main_timer)
	chmod +x $@

$(NAME):
	@$(info making $@)
	printf '%s\n' \
	'$(SHBANG)'                                                       \
	''                                                                \
	'main(){'                                                         \
	'$(INDENT)echo "hello $${_o[hello]:-,option "--hello" have no WORD}!"'   \
	'}'                                                               \
	''                                                                \
	'__dir=$$(dirname "$$(readlink -f "$${BASH_SOURCE[0]}")") #bashbud' \
	'source "$$__dir/$(BASE)"                               #bashbud'   \
	> $@

	chmod +x $@

$(DOCS_DIR)/description.md:
	@printf '%s\n' \
	'This is just a boilerplate.  **bold** *italic*' \
	'and other `markdown` options are supported.  ' \
	'' \
	'dependencies:  ' \
	'  - make, bash, gawk  ' \
	'  - `lowdown` , for markdown conversion  ' \
	'' \
	'- [x] easy peasy  ' \
	'- [ ] **make** it your own' \
	> $@
	                                           
$(CACHE_DIR)/short_help.md $(CACHE_DIR)/print_help.sh &: $(CACHE_DIR)/help_table.md
	@$(info making $@)
	{
		printf '%s\n' '$(SHBANG)' '' "__print_help()" "{" \
			"  cat << 'EOB' >&3  " \
		
		if [[ options = "$(USAGE)" ]]
			then
				echo '# SYNOPSIS' > $(CACHE_DIR)/short_help.md
				echo
				sed 's/^/    $(NAME) /g;s/$$/  /g' $(OPTIONS_FILE)
			else echo "usage: $(USAGE)"
		fi | tee $(CACHE_DIR)/short_help.md

		printf '%s\n' '' | tee -a $(CACHE_DIR)/short_help.md

		lowdown --term-no-ansi -Tterm $< \
			| tail -qn +3 | tee -a $(CACHE_DIR)/short_help.md
		printf '%s\n' "EOB" "}" 
	} > $(CACHE_DIR)/print_help.sh

	printf '%s\n' '' '# USAGE' '' >> $(CACHE_DIR)/short_help.md


$(CACHE_DIR)/help_table.md : $(CACHE_DIR)/long_help.md
	@$(info generating help table)
	{
		echo
		printf '%s\n' '| option | description |' \
									'|:-------|:------------|'
		head -qn1 $(addprefix $(DOCS_DIR)/options/,$(file < $(CACHE_DIR)/options_in_use))
		echo
	} > $@ 


$(BASE): config.mak $(CACHE_DIR)/timer_start $(CACHE_DIR)/getopt $(CACHE_DIR)/print_help.sh
	@$(info making $@)
	printf '%s\n' '$(SHBANG)' '' 'exec 3>&2' '' > $@
	$(print_version)
	grep -vhE -e '^#!/' $(CACHE_DIR)/print_help.sh >> $@

	echo "" >> $@

	[[ -d $(FUNCS_DIR) ]] && {
		printf '%s\n' \
		'for ___f in "$$__dir/$(FUNCS_DIR)"/*; do' \
		'$(INDENT). "$$___f" ; done ; unset -v ___f' >> $@
	}

	cat $(CACHE_DIR)/timer_start >> $@
	cat $(CACHE_DIR)/getopt >> $@

	$(main_timer)

check: all
	shellcheck $(MONOLITH)


$(OPTIONS_FILE):
	@$(info creating ./options)
	echo '$(DEFAULT_OPTIONS)' > $@

$(CACHE_DIR)/options_in_use $(CACHE_DIR)/getopt &: $(OPTIONS_FILE) | $(CACHE_DIR)/
	@$(info parsing $(OPTIONS_FILE))
	$(parse_options) > $(CACHE_DIR)/getopt

$(CACHE_DIR)/timer_start:
	@$(info making $@)
	> $@ printf '%s\n' \
		'' \
		'declare -A _o' \
		'' \
		'[[ $$* =~ --verbose ]] && _o[verbose]=1' \
		'[[ $$* =~ --dryrun ]]  && _o[dryrun]=1' \
		': "$${_o[verbose]:=$$BASHBUD_VERBOSE}"' \
		'' \
		'[[ $$BASHBUD_LOG ]] && {' \
		'$(INDENT)[[ -f $$BASHBUD_LOG ]] || mkdir -p "$${BASHBUD_LOG%/*}"' \
		'$(INDENT)exec 2>> "$$BASHBUD_LOG"' \
		'}' \
		'' \
		'((_o[verbose] && ! _o[dryrun])) && {' \
		'$(INDENT)___t=$$(( 10#$${EPOCHREALTIME//[!0-9]} ))' \
		'$(INDENT)for ((___arg=0; ___arg<$${#@}+1;___arg++)); do' \
		'$(INDENT)$(INDENT)[[ $${!___arg} == --verbose ]] && break' \
		'$(INDENT)done' \
		'$(INDENT)printf -v ___cmd "%s " "$(NAME)" "$${@:1:___arg}"' \
		'$(INDENT)unset -v ___arg' \
		'$(INDENT)>&2 echo ">>> $$___cmd"' \
		'}' \
		''

$(CACHE_DIR)/:
	@$(info creating $(CACHE_DIR)/ dir)
	mkdir -p $(CACHE_DIR) $(DOCS_DIR)/options

$(FUNCS_DIR)/:
	@$(info creating $(FUNCS_DIR)/ dir)
	mkdir -p $(FUNCS_DIR)

define print_version =
@printf '%s\n'                                \
	"__print_version()"                         \
	"{"                                         \
	"$(INDENT)>&3 printf '%s\n' \\"                    \
	"$(INDENT)$(INDENT)'$(NAME) - version: $(VERSION)' \\"    \
	"$(INDENT)$(INDENT)'updated: $(UPDATED) by $(AUTHOR)'"    \
	"}"                                                       \
	"" >> $@
endef










define main_timer =
printf '%s\n' \
	'timer_stop() {' \
  '$(INDENT)>&2 echo "<<< $$___cmd" \' \
  '$(INDENT)"$$(( (10#$${EPOCHREALTIME//[!0-9]} - ___t) / 1000 ))ms"' \
  '}' \
  '' \
  'main "$$@"' \
  '((_o[verbose] && ! _o[dryrun])) && timer_stop' >> $@
endef


define parse_options =
@gawk '
BEGIN { RS=" |\\n" }

/./ {
	if (match($$0,/^\[?--([^][|[:space:]]+)(([|]-)(\S))?\]?$$/,ma)) 
	{
		gsub(/[][]/,"",$$0)
		opt_name = ma[1]
		if (length(opt_name) > longest)
			longest = length(opt_name)
		options[opt_name]["long_name"]  = opt_name
		if (ma[4] ~ /./) 
			options[opt_name]["short_name"] = ma[4]
	}

	else if (match($$0,/^\[?-(\S)([|]--([^][:space:]]+))?\]?$$/,ma))
	{
		gsub(/[][]/,"",$$0)
		opt_name = ma[1]
		if (ma[3] ~ /./)
		{
			opt_name = ma[3]
			options[opt_name]["short_name"] = ma[1]
			options[opt_name]["long_name"]  = opt_name
		}
		else
			options[opt_name]["short_name"] = opt_name

	}

	else if (opt_name in options && !("arg" in options[opt_name]))
	{

		if ($$0 ~ /^[[]/)
			options[opt_name]["suffix"] = "::"
		else
			options[opt_name]["suffix"] = ":"

		gsub(/[][]/,"",$$0)
		options[opt_name]["arg"] = $$0
	}
}

END {

	for (o in options)
	{

		docfile = "$(DOCS_DIR)/options/" o
		options_in_use = options_in_use " " o

		if(system("[ ! -f " docfile " ]") == 0 && o ~ /./)
		{
			out = ""

			if ("short_name" in options[o])
				out = "`-" options[o]["short_name"] "`" ("long_name" in options[o] ? ", " : "")
			else
				out = ""

			if ("long_name" in options[o])
				out = out sprintf ("`--%-" longest+2 "s", options[o]["long_name"]"`")

			
			if ("arg" in options[o])
				out = out sprintf ("%s | ", gensub (/\|/,"\\\\|","g",options[o]["arg"]))
			else
				out = out " | "
			
			if ("short_name" in options[o] && options[o]["short_name"] == "v")
				out = out "print version info and exit  "
			else if ("short_name" in options[o] && options[o]["short_name"] == "h")
				out = out "print help and exit  "
			else
				out = out "short description  "

			if ("long_name" in options[o] && options[o]["long_name"] == "hello")
			{
				out = out sprintf ("\n\n%s\n%s\n%s\n", 
					"`--hello` long description  ",
					"this is the long description for `--hello`  ",
					"first line in `./docs/hello` is the short description.")
			}
			

			print out > docfile
		}
				
		if ("long_name" in options[o])
		{
			long_options = long_options "," options[o]["long_name"]
			if ("suffix" in options[o])
				long_options = long_options options[o]["suffix"]
		}

		if ("short_name" in options[o])
		{
			short_options = short_options "," options[o]["short_name"]
			if ("suffix" in options[o])
				short_options = short_options options[o]["suffix"]
		}
	}

	print options_in_use > "$(CACHE_DIR)/options_in_use"

	print "options=$$(getopt \\"
	print "  --name \"[ERROR]:" name "\" \\"
	if (short_options ~ /./)
		printf ("  --options \"%s\" \\\n", gensub(/^,/,"",1,short_options))
	printf ("  --longoptions \"%s\"  -- \"$$@\"\n", gensub(/^,/,"",1,long_options))
	print ") || exit 98"
	print ""
	print "eval set -- \"$$options\""
	print "unset options"
	print ""
	print "while true; do"
	print "  case \"$$1\" in"
	printf ("    --%-" longest+1 "s| -%s ) __print_help && exit ;;\n", "help", "h")
	printf ("    --%-" longest+1 "s| -%s ) __print_version && exit ;;\n", "version", "v")
	for (o in options)
	{
		if (o !~ /^(version|help)$$/)
		{
			if ("long_name" in options[o])
				printf ("    --%-" longest+1 "s", options[o]["long_name"])
			else
				printf ("%-" longest+7 "s", "")

			if ("short_name" in options[o])
				printf ("%s -%s ", ("long_name" in options[o] ? "|" : " "), options[o]["short_name"])
			else
				printf ("%s", "     ")

			if ("suffix" in options[o])
			{
				if (options[o]["suffix"] == "::")
					printf (") _o[%s]=$${2:-1} ; shift ;;\n", o)
				else
					printf (") _o[%s]=$$2 ; shift ;;\n", o)
			}
			else
				printf (") _o[%s]=1 ;;\n", o)
		}
	}

	print "    -- ) shift ; break ;;"
	print "    *  ) break ;;"
	print "  esac"
	print "  shift"
	print "done"
	print ""
}
' $(OPTIONS_FILE)                  \
		cache=$(CACHE_DIR)             \
		name=$(NAME)
endef

config.mak:
	@$(info creating ./config.mak)
	echo '
	NAME        := $(NAME)
	VERSION     := $(VERSION)
	CREATED     := $(CREATED)
	AUTHOR      := $(AUTHOR)
	CONTACT     := $(CONTACT)
	USAGE       := $(USAGE)
	# if USAGE is set to the string 'options' the content of OPTIONS_FILE
	# will be used.
	# USAGE       := options
	DESCRIPTION := short description of the script
	# man page and readme will only be created if they are set
	MANPAGE     := $(MANPAGE)
	README      := $(README)
	# ---
	# LICENSE is path to a file containg the license
	# not the name of the license.
	# if the file exist when target install: is invoked
	# it will also install LICENSE
	#
	# LICENSE        := LICENSE
	# ---
	# SHBANG will be used in all generated scripts
	#
	# SHBANG         := \#!/bin/bash
	# ---
	# MONOLITH is the name of the "combined" script
	# it will be installed (as NAME)
	#
	# MONOLITH        := monolith.sh
	# ---
	# BASE holds automatically generated stuff like
	# while getopts ... and __print_help() is must
	# be sourced by NAME
	#
	# BASE            := base.sh
	# ---
	# INDENT defines the indentation used in generated
	# files. it defaults to two spaces ("  ").
	# To use two tabs instead, set the variable to:
	#   INDENT := $$(shell echo -e "\t\t")
	#
	# INDENT          := $$(shell echo -e "  ")
	# ---
	# the conent of man page and readme can be configured
	# by setting the MANPAGE_LAYOUT and README_LAYOUT
	#
	# MANPAGE_LAYOUT =            \
	#  $$(CACHE_DIR)/help_table.md       \
	#  $$(DOCS_DIR)/description.md \
	#  $$(CACHE_DIR)/long_help.md
	# ---
	# README_LAYOUT  =              \
	# 	$$(DOCS_DIR)/readme_banner.md \
	# 	$$(MANPAGE_LAYOUT)
	# ---
	# leave UPDATED unset to auto set to current day
	#
	# UPDATED        := $$(shell date +'%Y-%m-%d')
	# ---
	# ORGANISATION is visible in the man page.
	# ORGANISATION   :=
	# ---
	# FUNCS_DIR      != ./lib
	# ---
	# if AWK_DIR or CONF_DIR are not empty
	# special functions will get cxreated in $(FUNCS_DIR)
	# --- 
	# AWK_DIR        := ./awklib
	# CONF_DIR       := ./conf
	# ---
	# CACHE_DIR      := ./.cache
	# DOCS_DIR       := ./docs
	# OPTIONS_FILE   := options

	' > $@
